$NetBSD$

--- src/Common/src/System/Net/DebugCriticalHandleMinusOneIsInvalid.cs.orig	2016-01-30 00:20:59.000000000 +0000
+++ src/Common/src/System/Net/DebugCriticalHandleMinusOneIsInvalid.cs
@@ -4,13 +4,6 @@
 
 using Microsoft.Win32.SafeHandles;
 
-using System.Diagnostics.CodeAnalysis;
-using System.Net.NetworkInformation;
-using System.Net.Sockets;
-using System.Runtime.CompilerServices;
-using System.Runtime.InteropServices;
-using System.Threading;
-
 namespace System.Net
 {
 #if DEBUG
