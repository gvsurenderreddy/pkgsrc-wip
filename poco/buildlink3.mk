# $NetBSD: buildlink3.mk,v 1.1.1.1 2009/01/10 16:05:32 tnn2 Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
POCO_BUILDLINK3_MK:=	${POCO_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	poco
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Npoco}
BUILDLINK_PACKAGES+=	poco
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}poco

.if ${POCO_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.poco+=	poco>=1.3.3p1
BUILDLINK_PKGSRCDIR.poco?=	../../wip/poco
.endif	# POCO_BUILDLINK3_MK

.include "../../security/openssl/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
