RAEDCN1 ;HISC/GJC-Utility routine for RAEDCN ; Feb 18, 2020@15:18:21
 ;;5.0;Radiology/Nuclear Medicine;**18,45,93,106,113,124,166**;Mar 16, 1998;Build 2
 ; last modif by SS for P18
 ; 07/15/2008 BAY/KAM rem call 249750 RA*5*93 Correct DIK Calls
 ;
 ;Routine              IA          Type
 ;-------------------------------------
 ;APPERROR^%ZTER       1621        (S)
 ;
UNDEF ; Message for undefined imaging types
 I '+$G(RAMLC) D  Q
 . W !?5,"Imaging Location data is not defined, "
 . W "contact IRM.",$C(7)
 . Q
 W !?5,"An Imaging Type was not defined for the following Imaging"
 W !?5,"Location: "_$P(^SC($P($G(^RA(79.1,+RAMLC,0)),U),0),U)_"."
 Q
 ;
STUB(RARPT) ; Determine if this is an imaging stub report.
 ; Input : RARPT: IEN of the report record
 ; Output: 1 if an imaging stub report, else 0
 ;
 ;new business rules with the advent of RA*5.0*106. An
 ;'images collected' (Activity Log, TYPE OF ACTION field)
 ;event no longer defines a stub report. A stub report is
 ;defined as a report with the following traits:
 ;-------------------------------------------------------
 ;* Has attached images
 ;* Does not have a REPORT STATUS value
 ;* Does not have impression text
 ;* Does not have a problem statement
 ;* Does not have report text
 ;
 ;sanity check
 Q:RARPT'>0 0 Q:'($D(^RARPT(RARPT,0))#2) 0
 ;
 I $P(^RARPT(RARPT,0),U,5)="",$O(^RARPT(RARPT,2005,0)),'$D(^RARPT(RARPT,"I")),'$D(^("P")),'$D(^("R")) Q 1
 Q 0
 ;
PSET(RADFN,RADTI,RACNI) ; Determine if this exam is part of a printset.
 ; Input: RADFN-patient dfn <-> RADTI-exam timestamp <-> RACNI-exam ien
 ; Output: 1 if part of a printset, else 0
 Q $S($P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),"^",25)=2:1,1:0)
 ;
CKREASON(X) ;check file 75.2 ; P18 moved it from RAEDCN because the routine's length exceeded limit
 ; 0=OKAY, 1=BAD
 ; don't check for var RAOREA, because it's not set this early
 I X="C",$O(^RA(75.2,"B","EXAM CANCELLED",0)) Q 0
 I X="D",$O(^RA(75.2,"B","EXAM DELETED",0)) Q 0
 W !!?5,$S(X="C":"Cancellation",1:"Deletion")," cannot be done, because your file #75.2,"
 W !?5,"RAD/NUC MED REASON, does not have ""EXAM ",$S(X="C":"CANCELLED",1:"DELETED"),"""","."
 W !!?5,"Please notify your ADPAC.",!
 K DIR S DIR(0)="E",DIR("A")="Press RETURN for menu options" D ^DIR K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 Q 1
 ;
DEL ; 'Exam Deletion' option (RA DELETEXAM)
 D SETVARS^RAEDCN Q:'($D(RACCESS(DUZ))\10)!('$D(RAIMGTY))
 S RAXIT=$$CKREASON^RAEDCN1("D") I RAXIT K RAXIT Q  ;P18
DEL1 D ^RACNLU G EXIT^RAEDCN:X="^"
 I RARPT W !?3,$C(7),"A report has been filed for this case. Therefore deletion is not allowed!" G DEL1
ASKDEL R !!,"Do you wish to delete this exam? NO// ",X:DTIME S:'$T!(X="")!(X["^") X="N" G DEL1:"Nn"[$E(X) I "Yy"'[$E(X) W:X'["?" $C(7) W !!,"Enter 'YES' to delete this exam, or 'NO' not to." G ASKDEL
 L +^RADPT(RADFN,"DT",RADTI):1 I '$T W !,$C(7),"Someone else is editing an exam for this patient on the date/time",!,"you selected. Please try Later" G DEL1
 S RADELFLG="" D ^RAORDC
 ;
 ;RA5P166
 ;RAUSUNXF is set in YNCAN^RAORDC
 ;QUIT if timeout/^ out (-1)
 I $G(RAUSUNXF)=-1 K RAUSUNXF Q
 ;RA5P166
 ;
 ; trigger RA CANCEL protocol on xam delete if xam not already cancelled
 S RA7003=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),X=+$P(RA7003,"^",3)
 ; no rpt filed, xam status exists & not cancelled -OR- xam status
 ; non-existent.
 I $P($G(^RA(72,X,0)),U,3)'=0 D
 . K RAIENS,RAERR S RAIENS=""_RACNI_","_RADTI_","_RADFN_","_"",RAFDA(70.03,RAIENS,3)="CANCELLED" D FILE^DIE("KSE","RAFDA","RAERR") K RAIENS,RAERR,RAFDA D CANCEL^RAHLRPC
 . Q
 K RA7003 S RABULL="",DA(2)=RADFN,DA(1)=RADTI,DA=RACNI
 S RAYY=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,1)),U,1)
 ;S DIK="^RADPT(DA(2),""DT"",DA(1),""P""," D ^DIK
 S DIK="^RADPT("_DA(2)_",""DT"","_DA(1)_",""P""," D ^DIK
 W !?10,"...deletion of exam complete."
 ; --- delete the associated Rad dosage record RA5p113 ---
 D:RAYY>0 DEL^RADUTL(RAYY)
 ; --- end RA5P113
 K %,D,D0,D1,D2,DA,DIC,DIK,RADELFLG,RABULL,RAPRTZ,RAAFTER,RABEFORE,RAYY
 ; Check if one exam or multiple exams exists below "DT" node.
 ; If no exams are present, delete "DT" node.
 I '+$O(^RADPT(RADFN,"DT",RADTI,"P",0)) D
 . K DA,DIK S DA(1)=RADFN,DA=RADTI
 . ; S DIK="^RADPT(DA(1),""DT""," D ^DIK
 . S DIK="^RADPT("_DA(1)_",""DT""," D ^DIK
 . K DA,DIK Q
 L -^RADPT(RADFN,"DT",RADTI)
 G DEL1
 ;
VIEW ; 'View Exam by Case No.' option (RA VIEWCN)
 D SETVARS^RAEDCN Q:'($D(RACCESS(DUZ))\10)!('$D(RAIMGTY))
 S RAVW="" D ^RACNLU G EXIT^RAEDCN:X="^" K RAFL D ^RAPROD D EXIT^RAEDCN G VIEW
 ;
 ;
CANCEL ;cancel exam status
 N DA,DIERR,RA124EXST,RAERR,RAERROR,RAFDA,RAIENS,RAR
 ;get correct imaging type/cancelled
 ;is RAIMGTY defined? if so use it, else set it
 ;Note: RAY2 & RAY3 are defined in RAEDCN.
 ;
 I '$D(RAIMGTY)#2 D
 .S RAIMGTY=$P($G(^RA(79.2,+$P(RAY2,U,2),0)),U) ;xternal
 .Q
 I RAIMGTY="" D  Q
 .D ERROR("RA: IMAGING TYPE DEFINITION ERROR")
 .W !!,"WARNING: CANCEL AN EXAM option aborted: Imaging Type definition error.",!!
 .Q
 S RA124EXST=$O(^RA(72,"AA",RAIMGTY,0,0)) ;IEN file 72
 ; for cancelled (order # = 0 4th subscript)
 I RA124EXST="" D  Q
 .D ERROR("RA: INVALID EXAM STATUS")
 .W !!,"WARNING: CANCEL AN EXAM option aborted: Exam Status definition error.",!!
 .Q
 ;
 ;update 70.03, field 3 EXAM STATUS
 S DA(2)=RADFN,DA(1)=RADTI,DA=RACNI
 S RAIENS=$$IENS^DILF(.DA) K DA
 ;
 S RAFDA(70.03,RAIENS,3)=RA124EXST
 ;update 70.03, field 3.5 REASON FOR CANCELLATION
 S:$G(RAREASON)'="" RAFDA(70.03,RAIENS,3.5)=RAREASON
 D FILE^DIE(,"RAFDA","RAERROR")
 I $D(DIERR)#2 S RADESC="RA: ERROR UPDATING SUB-DD;FIELD: 70.03;3 or 70.03;3.5" D ERROR(RADESC)
 ;
 ;do I care about editing 70.03 ; 3.5? REASON FOR CANCELLATION
 ;
ALOG ;update activity (70.03 ; 100) log
 K DIERR,RAERROR,RAFDA
 S RAR=$NA(RAFDA(70.07,"+1,"_RAIENS))
 ;.01 - log date
 S @RAR@(.01)=$E($$NOW^XLFDT(),1,12) ;internal
 ;field #: 2 - type of action
 S @RAR@(2)="X" ; 'X' = cancelled internal
 ;field #: 3 - computer user
 S @RAR@(3)=DUZ ;internal
 ;field #4: technologist comment "TCOM" node
 ;internal
 S:$G(RATCOM)'="" @RAR@(4)=RATCOM ;internal
 D UPDATE^DIE("","RAFDA","RAIENS","RAERROR") ;file as internal what if error?
 I $D(DIERR)#2 S RADESC="RA: ERROR UPDATING 'ACTIVITY LOG' (70.03 ; 100) MULTIPLE" D ERROR(RADESC)
 ;
XSTIME ;update exam status times (70.03 ; 75) log
 K RAIENS(1),DIERR,RAERROR,RAFDA
 S RAR=$NA(RAFDA(70.05,"+1,"_RAIENS))
  ;.01 - status change date/time
 S @RAR@(.01)=$E($$NOW^XLFDT(),1,12) ;internal
 ;field #: 2 - new status
 S @RAR@(2)=RA124EXST ;internal
 ;field #: 3 - computer user
 S @RAR@(3)=DUZ ;internal
 D UPDATE^DIE("","RAFDA","RAIENS","RAERROR")
 I $D(DIERR)#2 S RADESC="RA: ERROR UPDATING 'EXAM STATUS TIMES' (70.03 ; 75) MULTIPLE" D ERROR(RADESC)
 ;
 W !!?3,"... exam cancellation complete."
 Q
 ;
ERROR(RADESC) ;trip error trap hit primarily for CANCEL AN EXAM
 D APPERROR^%ZTER(RADESC)
 Q
 ;
