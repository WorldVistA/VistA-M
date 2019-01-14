RAIPS124 ;HISC/GJC post-install routine ;08 Jun 2018 1:06 PM
 ;;5.0;Radiology/Nuclear Medicine;**124**;Mar 16, 1998;Build 4
 ;
 ;Routine              File     IA          Type
 ;----------------------------------------------
 ; ^%ZTLOAD                     10063       (S)
 ; D EN^DIEZ                    10002       (S)
 ; ENALL^DIK                    10013       (S)
 ; $$ROUSIZE^DILF               2649        (S) 
 ;                     ^DD(     6892        (P)
 ;
 N RACHKP1,RACHKP2
 S RACHKP1=$$NEWCP^XPDUTL("POST1","EN1^RAIPS124")
 S RACHKP2=$$NEWCP^XPDUTL("POST2","EN2^RAIPS124")
 S RACHKP2=$$NEWCP^XPDUTL("POST3","EN3^RAIPS124")
 S RACHKP2=$$NEWCP^XPDUTL("POST4","EN4^RAIPS124")
 Q
 ;
EN1 ;cleanup this mess left from patch 130: DATE DESIRED (Not guaranteed) FLD #21
 ; "AP" is a new style for Use a DIK call. Look at every ^DD(75.1,21,1,x
 N RAR,RAY,RAX
 S RAR=$NA(^DD(75.1,21,1)),RAY=0
 F  S RAY=$O(@RAR@(RAY)) Q:'RAY  S RAX=$G(^(RAY,0)) I RAX="75.1^AC^MUMPS" D
 .D DELIX^DDMOD(75.1,21,RAY,"W")
 .Q
 Q
 ;
EN2 ;re-index the "AD" cross reference SCHEDULED DATE (TIME optional) 75.1;23
 ;
 N RATXT,ZTDESC,ZTDTH,ZTIO,ZTRTN S ZTIO="",RATXT(1)=""
 S ZTRTN="EN21^RAIPS124",(ZTDESC,RATXT(2))="RA124: re-index of the 'SCHEDULED DATE (TIME optional)' ""AD"" xref."
 S ZTDTH=$H D ^%ZTLOAD S RATXT(3)="Task: "_$S($G(ZTSK)>0:ZTSK,1:"in error")
 D BMES^XPDUTL(.RATXT)
 Q
 ;
EN21 ; re-index the existing 'SCHEDULED DATE (TIME optional)' fld #23 "AD" xref
 ;
 K DA,DIC,DIK K ^RAO(75.1,"AD") ;kill the corrupted "AD" xref
 S DIK="^RAO(75.1,",DIK(1)="23^AD" D ENALL^DIK
 K DA,DIC,DIK
 Q
 ;
EN3 ;recompile input templates associated with the EXAM STATUS 
 ;(70.03;3) field run in the foreground as part of the post-install
 ; ^DD(70.03,3,0)="EXAM STATUS"
 ; ^DIE("AF",sub-file,field,template_IEN)=""
 N DMAX,RADMAX,RAY,X,Y S RAY=0,RADMAX=$$ROUSIZE^DILF()
 F  S RAY=$O(^DIE("AF",70.03,3,RAY)) Q:RAY=""  D  ;Y = IEN of compiled template
 .S DMAX=RADMAX
 .;^DIE(1220,"ROU")="^RACTQE"
 .;^DIE(1220,"ROUOLD")="RACTQE"
 .S X=$P($G(^DIE(RAY,"ROU")),U,2) ;X = compiled template routine name
 .S:X="" X=$G(^DIE(RAY,"ROUOLD")) ;"ROU" not defined, check "ROUOLD"
 .Q:X=""  ;missing compiled template routine namespace 
 .S Y=RAY D EN^DIEZ
 .Q
 Q
 ;
EN4 ;task re-index "AE" & "AS" new style xrefs (70.03;3)
 N RATXT,ZTDESC,ZTDTH,ZTIO,ZTRTN S ZTIO="",RATXT(1)=""
 S ZTRTN="EN41^RAIPS124",(ZTDESC,RATXT(2))="RA124: re-index of the 'EXAM STATUS'' ""AE"" & ""AS"" xrefs."
 S ZTDTH=$H D ^%ZTLOAD S RATXT(3)="Task: "_$S($G(ZTSK)>0:ZTSK,1:"in error")
 D BMES^XPDUTL(.RATXT)
 ;
 Q
 ;
EN41 ;re-index the "AE" & "AS" new style xrefs
 ; EXAM STATUS field (70.03;3)
 N DA,DIC,DIK,RADFN,RADTI,X S RADFN=0
 K ^RADPT("AE") ;kill the "AE" xref
 K ^RADPT("AS") ;kill the "AS" xref
 F  S RADFN=$O(^RADPT(RADFN)) Q:RADFN'>0  D
 .S RADTI=0
 .F  S RADTI=$O(^RADPT(RADFN,"DT",RADTI)) Q:RADTI'>0  D
 ..S DIK="^RADPT("_RADFN_",""DT"","_RADTI_",""P"","
 ..S DIK(1)="3^AE^AS",DA(2)=RADFN,DA(1)=RADTI
 ..D ENALL^DIK K DA,DIC,DIK,X
 ..Q
 .Q
 Q
 ;
