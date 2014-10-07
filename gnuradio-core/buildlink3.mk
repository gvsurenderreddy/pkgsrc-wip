# $NetBSD: buildlink3.mk,v 1.5 2014/10/07 11:45:09 makoto Exp $

BUILDLINK_TREE+=	gnuradio-core

.if !defined(GNURADIO_CORE_BUILDLINK3_MK)
GNURADIO_CORE_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.gnuradio-core+=	gnuradio-core>=3.7.5
BUILDLINK_ABI_DEPENDS.gnuradio-core+=	gnuradio-core>=3.7.5
BUILDLINK_PKGSRCDIR.gnuradio-core?=	../../wip/gnuradio-core
.endif # GNURADIO_CORE_BUILDLINK3_MK

BUILDLINK_TREE+=	-gnuradio-core
