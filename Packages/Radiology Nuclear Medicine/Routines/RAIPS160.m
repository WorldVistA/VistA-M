RAIPS160 ;HISC/GJC-postinit 160 ; Aug 18, 2020@09:28:10
 ;;5.0;Radiology/Nuclear Medicine;**160**;Mar 16, 1998;Build 4
 ;
 ;Routine              File     IA          Type
 ;----------------------------------------------
 ;%ZTLOAD                       10063        (S)
 ;FIND^DIC                      2051         (S)
 ;FILE^DIE                      2053         (S)
 ;UPDATE^DIE                    2053         (S)
 ;ENALL^DIK                     10013        (S)  
 ;$$NOW^XLFDT                   10103        (S)
 ;$$FMADD^XLFDT                 10103        (S)
 ;$$FMTH^XLFDT                  10103        (S)
 ;$$NEWCP^XPDUTL                10141        (S)
 ;BMES^XPDUTL                   10141        (S)
 ;DUZ^XUP                       1429         (C)
 ;
 N RACHX1 S RACHX1=$$NEWCP^XPDUTL("POST1","EN1^RAIPS160")
 N RACHX2 S RACHX2=$$NEWCP^XPDUTL("POST2","EN2^RAIPS160")
 N RACHX3 S RACHX3=$$NEWCP^XPDUTL("POST3","EN3^RAIPS160")
 Q
 ;
 ; Note: EN1 has a hour ead start on EN2; EN2
 ; has an hour head start on EN3
 ;
EN1 ;Fix the ^RADPT(,"DT",0) if necessary for every
 ;patient in the RAD/NUC MED PATIENT (#70) file.
 N RATXT,ZTDESC,ZTDTH,ZTIO,ZTRTN
 S ZTIO="",RATXT(1)="",ZTRTN="TSK1^RAIPS160"
 S (ZTDESC,RATXT(2))="RA160: Fix the ^RADPT(,""DT"",0) node if necessary 1 of 3"
 S ZTDTH=$$NOW^XLFDT() ;get this task started immediately.
 D ^%ZTLOAD S RATXT(3)="Task: "_$S($G(ZTSK)>0:ZTSK,1:"in error")
 D BMES^XPDUTL(.RATXT)
 Q
 ;
TSK1 ;Rebuild the REGISTERED EXAM sub-file zero node.
 ;Example: ^RADPT(7168771.8995,"DT",0)="^70.02DA^7138969.9057^"
 ;Note: rebuilding the "AR" & "B" xrefs (70.02;.01) will fully
 ;build out ^RADPT(RADFN,"DT",0) w/4th piece
 N RADD,RADFN,RADTI S RADD="70.02DA",RADFN=0
 F  S RADFN=$O(^RADPT(RADFN)) Q:'RADFN  D
 .Q:($D(^RADPT(RADFN,"DT",0))#2)>0  ; (1) node exists
 .; ^RADPT(RADFN,"DT",0) is missing
 .; Get the earliest/only exam date
 .; (RADTI) for this patient.
 .S RADTI=$O(^RADPT(RADFN,"DT",$C(32)),-1)
 .S:RADTI>0 ^RADPT(RADFN,"DT",0)=U_RADD_U_RADTI_U
 .Q
 Q
 ;
 ;-------------------------------------------------------------------------------------
 ;
EN2 ;reindex the "AR" & "B" xrefs on the EXAM DATE (#70.02) .01 field.
 N RATXT,ZTDESC,ZTDTH,ZTIO,ZTRTN
 S ZTIO="",RATXT(1)="",ZTRTN="TSK2^RAIPS160"
 S (ZTDESC,RATXT(2))="RA160: reindex ""AR"" & ""B"" xrefs on EXAM DATE 2 of 3"
 S ZTDTH=$$QDT(0,1) ;queue task one hour into the future
 D ^%ZTLOAD S RATXT(3)="Task: "_$S($G(ZTSK)>0:ZTSK,1:"in error")
 D BMES^XPDUTL(.RATXT)
 Q
 ;
TSK2 ;reindex the "AR" & "B" cross reference on the EXAM DATE (#70.02)
 ;.01 field.
 N DA,DIC,DIK,RADFN,X
 K ^RADPT("AR") ;kill the file wide "AR" index
 S RADFN=0
 F  S RADFN=$O(^RADPT(RADFN)) Q:RADFN'>0  D
 .S DIK="^RADPT("_RADFN_",""DT"","
 .S DIK(1)=".01^AR^B",DA(1)=RADFN
 .K ^RADPT(DA(1),"DT","B") ;kill all patient level "B" indexes.
 .D ENALL^DIK K DA,DIC,DIK,X
 .Q
 Q
 ;
 ;-------------------------------------------------------------------------------------
 ;
EN3 ;mass override to complete from the beginning
 ;of time to 12/31/2008@23.59 (for live systems post release)
 N RATXT,ZTDESC,ZTDTH,ZTIO,ZTRTN
 S ZTIO="",RATXT(1)="",ZTRTN="TSK3^RAIPS160"
 S (ZTDESC,RATXT(2))="RA160: complete all studies/orders up to 12/31/2008@23.59 3 of 3"
 S ZTDTH=$$QDT(0,2) ;queue two hours into the future
 D ^%ZTLOAD S RATXT(3)="Task: "_$S($G(ZTSK)>0:ZTSK,1:"in error")
 D BMES^XPDUTL(.RATXT)
 Q
 ;
TSK3 ;mass override to complete from the beginning
 ;of time to 12/31/2008@23.59
 ;
 S RAARX=$NA(^RADPT("AR")),(RADTE,RASTOP)=0,RAEND=3081231.2359
 S RASAVDR="[RA OVERRIDE]" ;RASAVDR iS checked in RAORDU (bypass PCE)
 ;-------------------------------------------
 ;set DUZ to the value of POSTMASTER
 N RADUZ160 S RADUZ160=DUZ D DUZ^XUP(.5)
 ;-------------------------------------------
 F  S RADTE=$O(@RAARX@(RADTE)) Q:RADTE'>0  Q:RADTE>RAEND  D  Q:RASTOP
 .S RADFN=0
 .F  S RADFN=$O(@RAARX@(RADTE,RADFN)) Q:RADFN'>0  D  Q:RASTOP
 ..S RADTI=0
 ..F  S RADTI=$O(@RAARX@(RADTE,RADFN,RADTI)) Q:RADTI'>0  D  Q:RASTOP
 ...S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0))
 ...S RAITYP=+$P(RAY2,U,2) ;type of imaging
 ...S RAITYPE=$P($G(^RA(79.2,RAITYP,0)),U)
 ...Q:RAITYPE=""  ;cannot proceed w/bad data
 ...S RACMP=$O(^RA(72,"AA",RAITYPE,9,0))
 ...; quit if RACMP does not exist w/order # 9
 ...Q:RACMP'>0  S RACNI=0
 ...F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0  D  Q:RASTOP
 ....S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 ....Q:$$ACTIVE(+$P(RAY3,U,3))=0
 ....; // ** check if user asked to stop the task ** //
 ....I $$S^%ZTLOAD("RA*5.0*160: stopped by user.") S (RASTOP,ZTSTOP)=1
 ....; // ** check if user asked to stop the task ** //
 ....S RAIENS=RACNI_","_RADTI_","_RADFN_","
 ....S RAFDA(70.03,RAIENS,3)=RACMP
 ....L +^RADPT(RADFN,"DT",RADTI,"P",RACNI):3
 ....Q:$TEST=0  ;failed don't update xam status, xam logs or order request status
 ....D FILE^DIE("","RAFDA") ;internal - do not execute input transform
 ....D RA7005(RAIENS) ; (#75) EXAM STATUS TIMES
 ....D RA7007(RAIENS) ; (#100) ACTIVITY LOG
 ....L -^RADPT(RADFN,"DT",RADTI,"P",RACNI) ;release lock
 ....; update the radiology/CPRS orders if applicable to 'complete'
 ....D RA751
 ....Q
 ...Q
 ..Q
 .Q
 ;----------------------------------
 ;set DUZ back to its original value
 D DUZ^XUP(RADUZ160)
 ;----------------------------------
 D XIT
 Q
 ;
 ;-------------------------------------------------------------------------------------
 ;
ACTIVE(Y) ; is the study canceled or complete?
 ; input Y: ptr to file 72
 ; return: 0 if canceled or complete; else 1
 N RAX,X S RAX=$G(^RA(72,Y,0))
 S X=$P(RAX,U,3)
 ;X="" returns 0; X=0 or x=9 returns 0
 ;else returns a number between 1 and 8
 Q (X#9)
 ;
RA7005(RAY) ; (#75) EXAM STATUS TIMES
 ;input: RAY = RACNI_","_RADTI_","_RADFN_","
 N RAFDA,RAR
 S RAR=$NA(RAFDA(70.05,"+1,"_RAY)) ;RAFDA root
 ;.01 - option to be scheduled
 S @RAR@(.01)=$E($$NOW^XLFDT(),1,12)
 S @RAR@(2)=RACMP ;complete by i-type
 S @RAR@(3)=.5 ;postmaster (should be)
 D UPDATE^DIE("","RAFDA")
 Q
 ;
RA7007(RAY) ; (#100) ACTIVITY LOG
 ;input: RAY = RACNI_","_RADTI_","_RADFN_","
 N RAFDA,RAR
 S RAR=$NA(RAFDA(70.07,"+1,"_RAY)) ;RAFDA root
 ;.01 - option to be scheduled
 S @RAR@(.01)=$E($$NOW^XLFDT(),1,12)
 S @RAR@(2)="O" ; COMPLETE STATUS OVERRIDE
 S @RAR@(3)=.5 ;postmaster (should be)
 S @RAR@(4)="RA*5.0*160: mass override" ;Tech Comment...
 S @RAR@(5)=1 ;indicates record overriden by P160
 D UPDATE^DIE("","RAFDA")
 Q
 ;
RA751 ;update the radiology and CPRS orders to 'complete'
 ;required vars: RAY3, RADFN, RADTI & RACNI (all exist
 ;               when tag: RA751 is called.)
 ;               
 ;               RAOSTS, RAOIFN, RAOIFN(0) & DUZ
 ;               (are set within RA751)
 ;
 N RAOIFN S RAOIFN=+$P(RAY3,U,11)
 ;
 Q:($D(^RAO(75.1,RAOIFN,0))#2)=0  ;either null
 ;or a ptr to a null request record
 ; 
 S RAOIFN(0)=$G(^RAO(75.1,RAOIFN,0))
 ;if the patient pointers match and the request is not
 ;'COMPLETE' ('2' is the code for 'COMPLETE' for the
 ;Class I VistA RIS
 I $P(RAOIFN(0),U)=RADFN,($P(RAOIFN(0),U,5)'=2) D
 .NEW RAOSTS ;DUZ set to .5 (POSTMASTER)
 .S RAOSTS=2 ;'2' = COMPLETE
 .D ^RAORDU
 .Q
 Q
 ;
QDT(DAY,HOUR) ;date/time to queue a task for 160
 ; DAY - the # of day(s) to queue the task in the future
 ;HOUR - the # of hour(s) to queue the task in the future
 ;
 N RAQDT ; RAQDT - FM date/time in the future
 S RAQDT=$$FMADD^XLFDT($E($$NOW^XLFDT(),1,12),$G(DAY),$G(HOUR),0,0) ;NOW to the minute
 S:$P(RAQDT,".",2)=24 RAQDT=$$FMADD^XLFDT(RAQDT,0,0,1,0) ;stay off midnight/add a minute
 Q $$FMTH^XLFDT(RAQDT) ;return $H for ZTDTH
 ;
XIT ;kill vars, task... then quit
 S:$D(ZTQUEUED) ZTREQ="@"
 K RAARX,RAC,RACMP,RACNI,RADFN,RADIV,RADTE,RADTI,RAEND,RAFDA,RAIENS
 K RAITYP,RAITYPE,RAR,RASAVDR,RASTOP,RAX,RAY,RAY2,RAY3,X,Y
 Q
 ;
