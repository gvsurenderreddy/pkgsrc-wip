$NetBSD: patch-chrome_renderer_webplugin__delegate__pepper.cc,v 1.2 2011/05/27 13:23:09 rxg Exp $

--- chrome/renderer/webplugin_delegate_pepper.cc.orig	2011-05-24 08:01:44.000000000 +0000
+++ chrome/renderer/webplugin_delegate_pepper.cc
@@ -9,7 +9,7 @@
 #include <string>
 #include <vector>
 
-#if defined(OS_LINUX)
+#if defined(OS_LINUX) || defined(OS_BSD)
 #include <unistd.h>
 #endif
 
@@ -53,7 +53,7 @@
 #if defined(OS_MACOSX)
 #include "base/mac/mac_util.h"
 #include "base/mac/scoped_cftyperef.h"
-#elif defined(OS_LINUX)
+#elif defined(OS_LINUX) || defined(OS_BSD)
 #include "chrome/renderer/renderer_sandbox_support_linux.h"
 #include "printing/pdf_ps_metafile_cairo.h"
 #elif defined(OS_WIN)
@@ -414,7 +414,7 @@ bool WebPluginDelegatePepper::SetCursor(
 NPError NPMatchFontWithFallback(NPP instance,
                                 const NPFontDescription* description,
                                 NPFontID* id) {
-#if defined(OS_LINUX)
+#if defined(OS_LINUX) || defined(OS_BSD)
   int fd = renderer_sandbox_support::MatchFontWithFallback(
       description->face, description->weight >= 700, description->italic,
       description->charset);
@@ -433,7 +433,7 @@ NPError GetFontTable(NPP instance,
                      uint32_t table,
                      void* output,
                      size_t* output_length) {
-#if defined(OS_LINUX)
+#if defined(OS_LINUX) || defined(OS_BSD)
   bool rv = renderer_sandbox_support::GetFontTable(
       id, table, static_cast<uint8_t*>(output), output_length);
   return rv ? NPERR_NO_ERROR : NPERR_GENERIC_ERROR;
@@ -444,7 +444,7 @@ NPError GetFontTable(NPP instance,
 }
 
 NPError NPDestroyFont(NPP instance, NPFontID id) {
-#if defined(OS_LINUX)
+#if defined(OS_LINUX) || defined(OS_BSD)
   close(id);
   return NPERR_NO_ERROR;
 #else
@@ -823,7 +823,7 @@ int WebPluginDelegatePepper::PrintBegin(
       current_printer_dpi_ = printer_dpi;
     }
   }
-#if defined (OS_LINUX)
+#if defined(OS_LINUX) || defined(OS_BSD)
   num_pages_ = num_pages;
   pdf_output_done_ = false;
 #endif  // (OS_LINUX)
@@ -852,7 +852,7 @@ bool WebPluginDelegatePepper::VectorPrin
   unsigned char* pdf_output = NULL;
   int32 output_size = 0;
   NPPrintPageNumberRange page_range;
-#if defined(OS_LINUX)
+#if defined(OS_LINUX) || defined(OS_BSD)
   // On Linux we will try and output all pages as PDF in the first call to
   // PrintPage. This is a temporary hack.
   // TODO(sanjeevr): Remove this hack and fix this by changing the print
@@ -871,7 +871,7 @@ bool WebPluginDelegatePepper::VectorPrin
     return false;
 
   bool ret = false;
-#if defined(OS_LINUX)
+#if defined(OS_LINUX) || defined(OS_BSD)
   // On Linux we need to get the backing PdfPsMetafile and write the bits
   // directly.
   cairo_t* context = canvas->beginPlatformPaint();
@@ -1026,7 +1026,7 @@ void WebPluginDelegatePepper::PrintEnd()
   current_printer_dpi_ = -1;
 #if defined(OS_MACOSX)
   last_printed_page_ = SkBitmap();
-#elif defined(OS_LINUX)
+#elif defined(OS_LINUX) || defined(OS_BSD)
   num_pages_ = 0;
   pdf_output_done_ = false;
 #endif  // defined(OS_LINUX)
@@ -1039,7 +1039,7 @@ WebPluginDelegatePepper::WebPluginDelega
       plugin_(NULL),
       instance_(instance),
       current_printer_dpi_(-1),
-#if defined (OS_LINUX)
+#if defined(OS_LINUX) || defined(OS_BSD)
       num_pages_(0),
       pdf_output_done_(false),
 #endif  // (OS_LINUX)
