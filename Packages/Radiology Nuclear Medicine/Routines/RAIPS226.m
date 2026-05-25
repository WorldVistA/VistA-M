RAIPS226 ;WOIFO/KLM - Post-init Driver, patch 226 ; Oct 08, 2025@10:00
 ;;5.0;Radiology/Nuclear Medicine;**226**;Mar 16, 1998;Build 2
 ;
 ;This patch will add the new Oracle/Cerner standard procedures to the radiology package
 ;and sync them with CPRS. They will be deployed inactive.
 ;
 ;The new procedures are being passed in with the NEW RAD PROCEDURE WORKUP file (#71.11)
 ;
 Q
 ;
EN1 ;Main entry point (Called from KIDS)
 N RA01,RAERR,RASAV,RAY,RATMPDA,RAIENS,RADA,RAFDA,RA71Z,IENS,RAPROCT,RAR
 S RAPROCT=0 ;counter
 K ^XTMP("RA226_ERRORS")
 S ^XTMP("RA226_ERRORS",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"RA*5*226 Errors filing procedure data"
 S RATMPDA=0 F  S RATMPDA=$O(^RAMRPF(71.11,RATMPDA)) Q:RATMPDA=""  D
 .S RA01=$P($G(^RAMRPF(71.11,RATMPDA,0)),U) Q:RA01=""
 .;Create .01 first
 .N RAFDA,RAR S RAR="RAFDA(71,""?+1,"")" ;FDA root -check for existing entry
 .S @RAR@(.01)=RA01 ;Name
 .K RAERR,RAIENS,RADA
 .D UPDATE^DIE(,"RAFDA","RADA","RAERR") K RAFDA
 .I $D(RAERR(1,"DIERR"))#2 S ^XTMP("RA226_ERRORS","DIERR",RA01)="An error occured filing data for "_RA01 Q
 .;
 .;Update rest of fields (ZERO node)
 .Q:'$D(RADA)
 .I $G(RADA(1,0))'="+"  S ^XTMP("RA226_ERRORS","DIERR",RA01)="Error Filing Data - procedure already exists. "_RA01 Q
 .S RASAV=RADA(1),RAIENS=RADA(1)_","
 .S IENS=RATMPDA_"," ;71.11 IENS
 .D GETS^DIQ(71.11,IENS,"6;7;9;11;12;17;20","E","RA71Z","RAERR")
 .K RAFDA,RAERR,RAR
 .S RAR="RAFDA(71,RAIENS)"
 .S @RAR@(6)=$G(RA71Z(71.11,IENS,6,"E")) ;Type of Procedure
 .S @RAR@(7)=$G(RA71Z(71.11,IENS,7,"E")) ;Staff Review Required
 .S @RAR@(8)="Y"   ;Standard Procedure (no editing)
 .S @RAR@(9)=$G(RA71Z(71.11,IENS,9,"E")) ;CPT Code
 .S @RAR@(11)=$G(RA71Z(71.11,IENS,11,"E")) ;Rad/NM Phys Approval required
 .S @RAR@(12)=$G(RA71Z(71.11,IENS,12,"E")) ;Type of Imaging
 .S @RAR@(17)=$G(RA71Z(71.11,IENS,17,"E")) ;Display ED DESC when ordered
 .S @RAR@(20)=$G(RA71Z(71.11,IENS,20,"E")) ;Contrast Media Used?
 .S @RAR@(100)=$$FMADD^XLFDT(DT,-1) ;Inactive Date (t-1)
 .K RAERR D FILE^DIE("E","RAFDA","RAERR")
 .I $D(RAERR(1,"DIERR"))#2 S ^XTMP("RA226_ERRORS","DIERR",RA01)="An error occured filing data for "_RA01
 .;
 .;Contrast Media - Mult field #125
 .I $$GET1^DIQ(71,RASAV,20)="Yes" D
 ..N RA125
 ..S RA125=$G(^RAMRPF(71.11,RATMPDA,"CM",1,0)) Q:RA125=""
 ..K RAFDA,RAERR,RAIENS
 ..S RAIENS="+1,"_RASAV_","
 ..S RAFDA(71.0125,RAIENS,.01)=$G(RA125)
 ..D UPDATE^DIE("","RAFDA","RAIENS","RAERR")
 ..I $D(RAERR(1,"DIERR"))#2 S ^XTMP("RA226_ERRORS","DIERR",RA01)="Error filing contrast media data"
 ..D FILEAU^RAMAINU1(RASAV,RA125)  ;update the activity log
 ..Q
 .;
 .;Modality - Mult field #731
 .N RA731
 .S RA731=$$GET1^DIQ(71.11731,1_","_RATMPDA_",",.01)
 .K RAFDA,RAERR,RAIENS
 .S RAIENS="+1,"_RASAV_","
 .S RAFDA(71.0731,RAIENS,.01)=$G(RA731)
 .D UPDATE^DIE("E","RAFDA","RAIENS","RAERR")
 .I $D(RAERR(1,"DIERR"))#2 S ^XTMP("RA226_ERRORS","DIERR",RA01)="Error filing modality data."
 .;
 .;Educational Description - WP field #500
 .N RAEDU,RA500,I
 .S RAEDU=$$GET1^DIQ(71.11,RATMPDA_",",500,"","RA500")
 .K RAFDA,RAERR,RAIENS,^TMP($J,"RA226")
 .S RAIENS=RASAV_","
 .S I=0 F  S I=$O(RA500(I)) Q:I=""  S ^TMP($J,"RA226",I,0)=$G(RA500(I))
 .D WP^DIE(71,RAIENS,500,"","^TMP($J,""RA226"")","RAERR")
 .I $D(RAERR(1,"DIERR"))#2 S ^XTMP("RA226_ERRORS","DIERR",RA01)="Error filing the educational description"
 .;
 .;Orderable Item update (#101.43)
 .S RAY=RASAV_"^"_RA01_"^"_1 ;for OI update
 .N RAENALL,RAFILE,RASTAT
 .S RAENALL=0,RAFILE=71,RASTAT=1,RAY=RASAV_"^"_RA01_"^"_1
 .D PROC^RAO7MFN(RAENALL,RAFILE,RASTAT,RAY)
 .;
 .S RAPROCT=RAPROCT+1
 .Q
 D EN2^RAIPS226(RAPROCT)
 D EN3^RAIPS226
 Q
EN2(RACNT) ;Mailman message
 N XMDUZ,XMSUB,XMTEXT,XMY,RAC3,RAXT,RATEXT,RATXCNT,RA01,RAEMSG,RAMDUZ
 N DIFROM ;Required for mailman API (per Kernel DG)
 I '$D(^XTMP("RA226_ERRORS","DIERR")) S RATEXT(6)="*** No procedure filing errors ***"
 S RAXT=$NA(^XTMP("RA226_ERRORS"))
 ;Mail message introductory blurb...
 S RATEXT(1)="The post-init routine RAIPS226 has completed the installation of patch "
 S RATEXT(2)="RA*5.0*226, adding the national standard radiology procedure order set."
 S RATEXT(3)=""
 S RATEXT(4)="The number of procedures added: "_RACNT
 S RATEXT(5)=""
 I $D(^XTMP("RA226_ERRORS","DIERR")) D
 .S RATEXT(6)="There were errors filing the procedure data, contact the radiology developers."
 .S RATEXT(7)=""
 .S RATEXT(8)="Error messages are stored in "_RAXT
 .S RATEXT(9)=""
 .S RA01="" F RATXCNT=10:1 S RA01=$O(^XTMP("RA226_ERRORS","DIERR",RA01)) Q:RA01=""  D
 ..S RAEMSG=^XTMP("RA226_ERRORS","DIERR",RA01)
 ..S RATEXT(RATXCNT)=RAEMSG_$S(RAEMSG[RA01:"",1:" for "_RA01)
 .Q
 ;XMTEXT for message text
 S XMTEXT="RATEXT("
 S XMSUB="RA*5.0*226 - Post-Init Results"
 S XMDUZ=.5 ;postmaster
 ;Mail Recipients
 S XMY(DUZ)=""
 S RAMDUZ=.5 F  S RAMDUZ=$O(^XUSEC("RA MGR",RAMDUZ)) Q:RAMDUZ=""  S XMY(RAMDUZ)=""
 D ^XMD
 Q
EN3 ;Clean-up the NEW RAD PROCEDURE WORKUP file (#71.11)
 N RADA,DA
 S RADA=0 F  S RADA=$O(^RAMRPF(71.11,RADA)) Q:RADA=""  D
 .S DIK="^RAMRPF(71.11,",DA=RADA D ^DIK
 .K DIK,DA
 .Q
 Q
