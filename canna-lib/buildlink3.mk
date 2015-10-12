# $NetBSD: buildlink3.mk,v 1.2 2012/08/12 12:47:24 makoto Exp $

BUILDLINK_TREE+=	Canna-lib

.if !defined(CANNA_LIB_BUILDLINK3_MK)
CANNA_LIB_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.Canna-lib+=	Canna-lib>=3.7pl3
BUILDLINK_PKGSRCDIR.Canna-lib?=	../../wip/canna-lib
.endif # CANNA_LIB_BUILDLINK3_MK

BUILDLINK_TREE+=	-Canna-lib
