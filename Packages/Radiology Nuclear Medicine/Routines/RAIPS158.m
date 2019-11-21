RAIPS158 ;HISC/GJC post-install routine ;05 Jun 2019 8:37 AM
 ;;5.0;Radiology/Nuclear Medicine;**158**;Mar 16, 1998;Build 2
 ;
 ;Routine              IA          Type
 ;-------------------------------------
 ; ^%ZTLOAD            10063        (S)
 ;  FILE^DIE           2053         (S)
 ;  DT^XLFDT           10103        (S)
 ;  FMADD^XLFDT        10103        (S)
 ;  UNWIND^%ZTER       1621         (S)
 ;  ^%ZTER             1621         (S)
 ; FILESEC^DDMOD       2916         (S)
 ;  DQ^XUFILE1         7078         (P)
 ;
 N RACHX1 S RACHX1=$$NEWCP^XPDUTL("POST1","EN^RAIPS158")
 Q
 ;
EN ;delete the ORIGINAL PROCEDURE? (field: [#8]) flag
 ; for all procedures in the RAD/NUC MED PROCEDURES [#71]
 ; file.
 ;
 ; ^XTMP(namespaced- subscript,0)=purge date^create date^last file 71 IEN
 ; (both dates will be in VA FileMan internal date format). TTL = fifteen days
 ;
 I '$D(^XTMP("RA158",0))#2 D
 .S ^XTMP("RA158",0)=$$FMADD^XLFDT($$DT^XLFDT(),15,0,0,0)_U_$$DT^XLFDT()_U
 .Q
 ;
 K RATXT,RAY N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S RAY=+$P($G(^XTMP("RA158",0)),U,3)
 S:RAY>0 RAY=(RAY-0.1)
 S ZTIO="",ZTRTN="EN1^RAIPS158",ZTSAVE("RAY")=""
 S (ZTDESC,RATXT(1))="RA158 post: Delete the ORIGINAL PROCEDURE? flag from file [#71]."
 S ZTDTH=$H D ^%ZTLOAD
 S RATXT(2)="Task: "_$S($G(ZTSK)>0:ZTSK,1:"in error")
 D BMES^XPDUTL(.RATXT) K RATXT,RAY
 ;
 D EN2 ;add new cancel reasons to file 75.2
 ;
 D EN3 ;remove TYPE OF REASON value for all non-national records in file 75.2
 ;
 D EN4 ;remove user access to the RAD/NUC MED REASON [#75.2]
 ;
 D EN5 ;set file security for 75.2 all "@" except for "RD" & "AUDIT"
 ;
 QUIT
 ;
EN1 ; entry point to loop [#71] called from EN tag.
 ;
 N $ESTACK,$ETRAP S $ETRAP="D ABEND^RAIPS158"
 ;
 S RAROOT=$NA(^RAMIS(71))
 ;variable RAY set above
 F  S RAY=$O(^RAMIS(71,RAY)) Q:RAY'>0  D
 .Q:$P(@RAROOT@(RAY,0),U,8)'="Y"
 .S RAFDA(71,RAY_",",8)="@" D FILE^DIE("","RAFDA")
 .K RAFDA S $P(^XTMP("RA158",0),U,3)=RAY
 .Q
 K RAROOT,RAY
 S:$D(ZTQUEUED)#2 ZTREQ="@"
 Q
 ;
ABEND ;come here on error
 S $P(^XTMP("RA158",0),U,3)=$G(RAY)
 D ^%ZTER ; record the error
 D UNWIND^%ZTER ; unwind the stack, return to caller.
 Q
 ;
EN2 ;add new cancel reasons...
 S RAR="RAFDA(75.2,""?+1,"")" ;FDA root - check for existing entry w/?
 F RAI=1:1 S RAREA=$T(REA+RAI) Q:RAREA=""  D
 .S RA01=$P(RAREA,";",3),RA3=$P(RAREA,";",4)
 .S @RAR@(.01)=RA01 ;Reason
 .S @RAR@(2)=1      ;Type of reason=cancel request
 .S @RAR@(3)=RA3    ;Synonym
 .S @RAR@(4)="i"    ;Nature of order activity=Policy
 .S @RAR@(5)="Y"    ;NATIONAL flag = YES prevents local modifications
 .D UPDATE^DIE(,"RAFDA","","RAMSG(1)") K RAFDA
 .I $D(RAMSG(1,"DIERR"))#2 S RATXT="An error occured filing data for "_RA01
 .E  S RATXT=RA01_" filed"
 .D MES^XPDUTL(RATXT)
 .K RATXT,RAMSG
 K RAI,RAR,RAREA
 Q
 ;
EN3 ;remove type of reason (#2) off non-national reason
 S RAY=0 F  S RAY=$O(^RA(75.2,RAY)) Q:RAY'>0  D
 .Q:$P(^RA(75.2,RAY,0),U,5)="Y"  ;national - hands off
 .S RAFDA(75.2,RAY_",",2)="@"
 .D FILE^DIE("","RAFDA","")
 .K RAFDA
 .Q
 K RAY
 Q
 ;
EN4 ;remove user access to the RAD/NUC MED REASON [#75.2]
 N RATXT,ZTDESC,ZTDTH,ZTIO,ZTRTN
 S ZTIO="",RATXT(1)="",ZTRTN="TSK^RAIPS158"
 S (ZTDESC,RATXT(2))="RA158: remove user access to the RAD/NUC MED REASON [#75.2]"
 S ZTDTH=$H D ^%ZTLOAD S RATXT(3)="Task: "_$S($G(ZTSK)>0:ZTSK,1:"in error")
 D BMES^XPDUTL(.RATXT)
 Q
 ;
EN5 ;set file security for 75.2 all "@" except for "RD" & "AUDIT"
 K ^TMP("DIERR",$J)
 S RASEC752("DD")="@"
 S RASEC752("RD")=""
 S RASEC752("WR")="@"
 S RASEC752("DEL")="@"
 S RASEC752("LAYGO")="@"
 S RASEC752("AUDIT")=""
 D FILESEC^DDMOD(75.2,.RASEC752)
 I $D(^TMP("DIERR",$J))>0 K RATXT D
 .S RATXT(1)="Error when setting security access codes for the"
 .S RATXT(2)="RAD/NUC MED REASON [#75.2] file." D BMES^XPDUTL(.RATXT)
 .K RATXT
 .Q
 K ^TMP("DIERR",$J),RASEC752
 Q
 ;
TSK ;remove user access to the RAD/NUC MED REASON [#75.2]
 ;file.
 N XUW S XUW=75.2 D DQ^XUFILE1
 Q
 ;
 ;Note: type of reason = cancel request; Nature of order = policy; national = yes
REA ;reason table
 ;;CC-IMAGING CONSULT DC/ADMIN CLOSURE POLICY;CC ADMIN CLOSE
 ;;CC-IMAGING CONSULT DC PT CX'D;CC CANCEL
 ;;CC-IMAGING CONSULT DC PT NO SHOW;CC NO SHOW
 ;;CC-IMAGING CONSULT DC UNABLE TO CONTACT;CC NO RESPONSE
 ;;OBSOLETE ORDER;OBSOLETE
 ;;UNABLE TO CONTACT THE PATIENT;NO RESPONSE
 ;;FUTURE DD/CID GREATER THAN 390 DAYS;FUTURE > 390
 ;;PATIENT NO SHOWED;NO SHOW
 ;;DUPLICATE ORDER;DUPLICATE
 ;;PATIENT REFUSED;REFUSED EXAM
 ;;EXAM CANCELLED;EXAM CANCELLED
 ;;OTHER;OTHER
 ;;IMAGES UNAVAILABLE;NO IMAGES
