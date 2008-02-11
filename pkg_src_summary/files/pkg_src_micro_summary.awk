#!/usr/bin/env runawk

# Copyright (c) 2007-2008 Aleksey Cheusov <vle@gmx.net>
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

BEGIN {
	good_pkgname_re = "^[^${}()]+$" #"^[[:alnum:]_-]+-[[:digit:]]+([.][[:digit:]]+)*$"
}

# output format:
#    for success:
#       + <SPACE> pkgname+pkgrevision <SPACE> Makefile
#    for failure:
#       - <SPACE> pkgname <SPACE> distname <SPACE> Makefile
function print_name_and_path (){
	pkgname = ""

	if (! ("PKGNAME" in badvar)){
		if ("PKGNAME" in var)
			pkgname = check("PKGNAME")
		else if ("DISTNAME" in var)
			pkgname = check("DISTNAME")
	}

	if (pkgname == ""){
		print "-", var ["PKGNAME"], var ["DISTNAME"], last_fn
		return
	}

	pkgrevision = ""
	if ("PKGREVISION" in var){
		pkgrevision = "nb" var ["PKGREVISION"]
	}
	print "+", pkgname pkgrevision , last_fn
}

# try to get a real PKGNAME...
function check (variable,

				value,left,right,subvarname,subvalue,repl,old_string,new_string)
{
	# fast checks

	# PKGNAME was assigned more than once, i.e. badname?
	if (variable in badvar)
		return ""

	value = var [variable]
	# not set?
	if (value == "")
		return ""

	# try replacements...
	while (match(value, /[$][{][[:alnum:]_.]+(:S\/.*\/.*\/)?[}]/)){
		left  = substr(value, 1, RSTART-1)
		right = substr(value, RSTART+RLENGTH)

		# ${VARNAME} found?
		if (value !~ /:S\//){
			# yes!
			subvarname = substr(value, RSTART + 2, RLENGTH - 3)
			subvalue = check(subvarname)

			if (subvalue == ""){
				return ""
			}

			value = left subvalue right
			continue
		}

		# ${VARNAME:S/old_substr/new_substr/} found!
		repl  = substr(value, RSTART + 2, RLENGTH - 4)
		subvarname = repl
		sub(/:.*$/, "", subvarname)
		sub(/^[^:]+:S\//, "", repl)

		subvalue = check(subvarname)
		if (subvalue == ""){
			return ""
		}

#		print "left=" left
#		print "right=" right
#		print "varname=" varname
#		print "repl=" repl
#		print "----"

		match(repl, "/")
		old_string = substr(repl, 1, RSTART-1)
		new_string = substr(repl, RSTART+1)

		# complex old_string?
		if (old_string ~ /[$^\[\]\\]/){
			# yes :-(
			return ""
		}

		# string to regexp
		gsub(/[?{}|()*+.]/, "[&]", old_string)

		# old_string to new_string
		sub(old_string, new_string, subvalue)
#		print "result of substritution: var [" varname "]=" var [varname]
		#
		value = left subvalue right
	}

	# final check
	if (value ~ good_pkgname_re){
		return value
	}

	# :-(
	return ""
}

function trim (s){
	sub(/^[ \t]+/, "", s)
	sub(/[ \t]+$/, "", s)

	return s
}

function process_include (fn, inc, cond_cnt,              ret,varname){
	sub(/\/[^\/]+$/, "", fn)
	if (inc !~ /^\//)
		fn = fn "/" inc

#	print "incl:" fn

	while ((ret = getline < fn) > 0){
		if ($1 == ".if") {
			++cond_cnt
			continue
		}

		if ($1 == ".endif") {
			--cond_cnt
			continue
		}

		if (match ($1, /^[[:alnum:]_.]+[?:]?=/)) {
			varname = $1
			sub(/[?:]?=.*$/, "", varname)

			sub(/^[^=]+=/, "", $0)
			$0 = trim($0)

			if (cond_cnt != 0 || (varname in var) && var [varname] != $0){
				# double assignment? -> badvar
				badvar [varname] = 1
			}else{
				# conditional assignments are not remembered
				var [varname] = $0
#				print varname " ---> " var [varname]
			}
			continue
		}

		if ($1 == ".include" &&
			$2 !~ /buildlink3.mk"$/ && $2 !~ /^"[.][.]\/[.][.]\/mk/)
		{
			# recursive .include processing
			if (cond_cnt > 0)
				new_cnt = 10000 # unbalanced .if/.endif? who knows
			else
				new_cnt = 0

			process_include(fn, substr($2, 2, length($2)-2), new_cnt)
		}
	}

	close(fn)
}

{
	last_fn = $1
	process_include(".", last_fn, 0)
	print_name_and_path()

	delete var
	delete badvar
}
