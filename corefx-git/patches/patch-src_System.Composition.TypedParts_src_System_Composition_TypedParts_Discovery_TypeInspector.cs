$NetBSD$

--- src/System.Composition.TypedParts/src/System/Composition/TypedParts/Discovery/TypeInspector.cs.orig	2016-01-30 00:20:59.000000000 +0000
+++ src/System.Composition.TypedParts/src/System/Composition/TypedParts/Discovery/TypeInspector.cs
@@ -2,12 +2,10 @@
 // The .NET Foundation licenses this file to you under the MIT license.
 // See the LICENSE file in the project root for more information.
 
-using System;
 using System.Collections.Generic;
 using System.Composition.Convention;
 using System.Composition.Hosting;
 using System.Composition.Hosting.Core;
-using System.Composition.Runtime;
 using System.Composition.TypedParts.ActivationFeatures;
 using System.Linq;
 using System.Reflection;
