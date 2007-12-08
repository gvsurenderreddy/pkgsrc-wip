# $NetBSD: buildlink3.mk,v 1.9 2007/12/08 22:20:04 netcap Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
AUDACIOUS_BUILDLINK3_MK:=	${AUDACIOUS_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	audacious
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Naudacious}
BUILDLINK_PACKAGES+=	audacious
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}audacious

.if ${AUDACIOUS_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.audacious+=	audacious>=1.4.4
BUILDLINK_PKGSRCDIR.audacious?=	../../wip/audacious
BUILDLINK_DEPMETHOD.audacious?=	build
.endif	# AUDACIOUS_BUILDLINK3_MK

.include "../../wip/mowgli/buildlink3.mk"
.include "../../devel/libmcs/buildlink3.mk"
.include "../../devel/pango/buildlink3.mk"
.include "../../devel/glib2/buildlink3.mk"
.include "../../devel/libglade/buildlink3.mk"
.include "../../devel/atk/buildlink3.mk"
.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../sysutils/dbus/buildlink3.mk"
.include "../../sysutils/dbus-glib/buildlink3.mk"
.include "../../textproc/libxml2/buildlink3.mk"
.include "../../x11/gtk2/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
