# $NetBSD: Makefile,v 1.1 2015/04/06 17:22:22 nros Exp $

DISTNAME=	AnyEvent-I3-0.16
PKGNAME=	p5-${DISTNAME}
CATEGORIES=	devel
MASTER_SITES=	https://cpan.metacpan.org/authors/id/M/MS/MSTPLBG/

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://metacpan.org/pod/AnyEvent::I3
COMMENT=	Perl module to communicate with the i3 window manager
LICENSE=	${PERL5_LICENSE}

PERL5_PACKLIST=	auto/AnyEvent/I3/.packlist

DEPENDS+=	p5-AnyEvent-[0-9]*:../../devel/p5-AnyEvent
DEPENDS+=	p5-JSON-XS-[0-9]*:../../converters/p5-JSON-XS

.include "../../lang/perl5/module.mk"
.include "../../mk/bsd.pkg.mk"
