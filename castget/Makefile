# $NetBSD: Makefile,v 1.15 2012/09/24 18:26:52 asau Exp $
#

DISTNAME=	castget-1.1.0
CATEGORIES=	audio www
MASTER_SITES=	http://savannah.nongnu.org/download/castget/
EXTRACT_SUFX=	.tar.bz2

MAINTAINER=	netbsd@guigui2.net
HOMEPAGE=	http://castget.nongnu.org/
COMMENT=	Command-line RSS enclosures dowloader
LICENSE=	gnu-lgpl-v2.1

GNU_CONFIGURE=	yes
USE_LIBTOOL=	yes
USE_LANGUAGES=	c
USE_TOOLS+=	pkg-config

INSTALLATION_DIRS=	share/examples

post-install:
	${INSTALL_DATA} ${WRKSRC}/castgetrc.example \
		${DESTDIR}${PREFIX}/share/examples/castgetrc.example

.include "../../www/curl/buildlink3.mk"
.include "../../audio/id3lib/buildlink3.mk"
.include "../../textproc/libxml2/buildlink3.mk"
.include "../../devel/glib2/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
