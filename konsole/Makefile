# $NetBSD: Makefile,v 1.25 2016/01/10 20:01:05 markd Exp $

DISTNAME=	konsole-${KAPPSVER}
CATEGORIES=	x11

HOMEPAGE=	http://kde.org/applications/system/konsole/
COMMENT=	Terminal emulator for the K Desktop Environment
LICENSE=	gnu-gpl-v2 AND gnu-lgpl-v2 AND gnu-fdl-v1.2

.include "../../wip/kde5/applications.mk"

BUILD_DEPENDS+=	kdoctools>=5.19.0:../../devel/kdoctools

USE_TOOLS+=	msgmerge

.include "../../sysutils/desktop-file-utils/desktopdb.mk"
.include "../../wip/kdelibs4support/buildlink3.mk"
.include "../../devel/knotifyconfig/buildlink3.mk"
.include "../../devel/kpty/buildlink3.mk"
.include "../../x11/qt5-qtbase/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
