RAIPS181 ;HISC/GJC post-install RA*5.0*181 ; May 07, 2021@11:05:38
 ;;5.0;Radiology/Nuclear Medicine;**181**;Mar 16, 1998;Build 1
 ;
 ;ICR#            referenced IA           reference type
 ;------------------------------------------------------  
 ;2051            $$FIND1^DIC()           Supported
 ;10002           EN^DIEZ                 Supported
 ;2649            $$ROUSIZE^DILF          Supported
 ;2022            ^DIE("AF",              Controlled
 ;
 ;file #.402 input template file w/root ^DIE(
 ;
EN1 ;re-compile RA REGISTER (file 70)
 N DMAX,X,Y S (RAY,Y)=$$FIND1^DIC(.402,,"C","RA REGISTER")
 I RAY'>0 D  D KQ Q
 .N RATXT S RATXT(1)="The [RA REGISTER] input template was not found. Contact the national"
 .S RATXT(2)="RIS development team." D BMES^XPDUTL(.RATXT)
 .Q
 ;
 S RAX=$P($G(^DIE(RAY,"ROU")),U,2) ;RAX = compiled template routine name
 ;no compiled routines? check "AF" nodes & "ROUOLD"
 I RAX="" S:($D(^DIE("AF",70))\10) RAX=$G(^DIE(RAY,"ROUOLD"))
 I RAX="" D  D KQ Q  ;missing compiled template routine namespace
 .N RATXT S RATXT(1)="The compiled template routine namespace for RA REGISTER was not found."
 .S RATXT(2)="Contact the national RIS development team." D BMES^XPDUTL(.RATXT)
 .Q
 S (DMAX,RAMAX)=$$ROUSIZE^DILF()
 S X=RAX,Y=RAY D EN^DIEZ
 Q
 ;
KQ ;kill and quit
 K RAMAX,RAX,RAY
 Q
 ;
