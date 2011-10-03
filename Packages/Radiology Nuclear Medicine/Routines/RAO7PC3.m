RAO7PC3 ;HISC/SWM&CRT-Procedure Call utilities. ;8/15/08  16:45
 ;;5.0;Radiology/Nuclear Medicine;**16,26,27,56,95**;Mar 16, 1998;Build 7
 ;Supported IA #2056 GET1^DIQ
 ;Supported IA 10104 UP^XLFSTR
 ;; api to return entire report (same as auto e-mail's)
EN3(X) ; Return narrative text for exam(s)
 ; Input:
 ; X-> Exam id in one of two forms:
 ;   1) Pat. DFN^inv. exam date^Case IEN
 ;      Retrieves a single report for a single exam
 ;   2) Pat. DFN^inv. exam date^
 ;      Retrieves all reports for a set of exams ordered on one order
 ;
 ; Note:  Input delimiter can be any of the following: ^~\&;-
 ;        a delimiter may be a single space i.e, " "
 ;
 ; Output:
 ; ^TMP($J,"RAE3",Patient IEN,case IEN,procedure name)=report status^
 ; abnormal alert^CPRS Order ien
 ; ^TMP($J,"RAE3",Patient IEN,case IEN,procedure name,n)=line n of rpt
 ; ^TMP($J,"RAE3",Patient IEN,"PRINT_SET")=null (IF this is a printset)
 ; ^TMP($J,"RAE3",Patient IEN,"ORD")=name of ordered procedure for
 ; examsets and printsets
 ; ^TMP($J,"RAE3",Patient IEN,"ORD",case IEN)=name of ordered procedure
 ; for that case; not part of an examset or printset
 ;
 ;
 K ^TMP($J,"RAE3"),^TMP($J,"RA AUTOE")
 K RAU S RAU=$$DEL^RAO7PC1(X) I RAU="" K RAU Q
 Q:'$P(X,RAU)!('$P(X,RAU,2))  ; Quit if no Pat. DFN -or- no inv. exam DT
 N RACIEN,RADFN,RAINVXDT,RAPSET,RAUTOE,Y S RAPSET=0
 S RADFN=$P(X,RAU),RAINVXDT=$P(X,RAU,2),RACIEN=+$P(X,RAU,3)
 K RAU Q:'($D(^RADPT(RADFN,"DT",RAINVXDT,0))#2)
 I RACIEN D CASE(RACIEN) Q
 S Y=0
 F  S Y=$O(^RADPT(RADFN,"DT",RAINVXDT,"P",Y)) Q:Y'>0  D
 . D CASE(Y) S RAPSET=0
 . Q
 Q
EN30(RAOIFN) ; Return narrative text for exam(s).  
 ; To be used with the EN3 entry point above.
 ;
 ; Input: RAOIFN -> the ien of Rad/Nuc Med Order
 ;
 Q:'RAOIFN  ; order passed in as 0 or null
 Q:'$D(^RAO(75.1,RAOIFN,0))  ; no such order
 Q:'$D(^RADPT("AO",RAOIFN))  ; no exam associated with this order
 N RADFN,RADTI,RACNI,RAXSET
 S RADFN=+$O(^RADPT("AO",RAOIFN,0)) Q:'RADFN
 S RADTI=+$O(^RADPT("AO",RAOIFN,RADFN,0)) Q:'RADTI
 S RAXSET=+$P($G(^RADPT(RADFN,"DT",RADTI,0)),"^",5) ; set if RAXSET=1
 I RAXSET D EN3(RADFN_"^"_RADTI_"^") Q  ; exam set, hit EN3 code
 ; the following code is executed for non-exam set examinations
 S RACNI=+$O(^RADPT("AO",RAOIFN,RADFN,RADTI,0)) Q:'RACNI
 D EN3(RADFN_"^"_RADTI_"^"_RACNI)
 Q
CASE(Y) ;
 N N,RABNOR,RACASE,RACIEN,RADIAG,RAEXAM,RAINCLUD,RAOPRC,RAORD,BLANK
 N RAMSG,RAPDIAG,RAPROC,RARDE,RARPT,RARPTST,RASPACE,SKIP,X,ZZRADFN,X0,X1,X2,RASIGVES,RARPTST2
 ;
 S RACIEN=Y,$P(BLANK," ",80)=""
 S RAEXAM(0)=$G(^RADPT(RADFN,"DT",RAINVXDT,"P",RACIEN,0)) Q:RAEXAM(0)']""
 S RACASE=$P(RAEXAM(0),"^")
 S:$P(RAEXAM(0),"^",25)=2 RAPSET=1
 S:RAPSET=1 ^TMP($J,"RAE3",RADFN,"PRINT_SET")=""
 S RAPROC(0)=$G(^RAMIS(71,+$P(RAEXAM(0),"^",2),0))
 S RAPROC=$S($P(RAPROC(0),"^")]"":$P(RAPROC(0),"^"),1:"Unknown")
 S RAORD(0)=$G(^RAO(75.1,+$P(RAEXAM(0),"^",11),0))
 S RAORD(7)=$P(RAORD(0),"^",7)
 S RAOPRC(0)=$G(^RAMIS(71,+$P(RAORD(0),"^",2),0))
 S RAOPRC=$S($P(RAOPRC(0),"^")]"":$P(RAOPRC(0),"^"),1:"Unknown")
 S RAPDIAG(0)=$G(^RA(78.3,+$P(RAEXAM(0),"^",13),0))
 S RARPT=+$P(RAEXAM(0),"^",17),RARPTST2=$$UL^RAO7PC1A($$RSTAT^RAO7PC1A())
 S RARPT(0)=$G(^RARPT(RARPT,0)),RARPTST=$P(RARPT(0),"^",5)
 S RASIGVES="" I RARPTST="V",$P(RARPT(0),U,10)]"",$P(RARPT(0),U,9)]"" S X2=RARPT,X1=$P(RARPT(0),U,9),X=$P(RARPT(0),U,10) D DE^XUSHSHP S:X]"" RASIGVES="/ES/"_X
 S RARDE=$$GET1^DIQ(74,RARPT_",",8,"E")
 ; View whole report if Rad User or status is R or V.
 D CHKUSR^RAUTL2 S RAINCLUD=RAMSG
 ;allow V, R, EF rpts to be seen by non-Radiology CPRS users - patch 95
 S RAINCLUD=$S(RAMSG:1,"^V^R^EF^"[("^"_RARPTST_"^"):1,1:0)
 S RABNOR=$$UP^XLFSTR($P(RAPDIAG(0),"^",4)) S:RABNOR'="Y" RABNOR=""
 ;
 I $P(RAEXAM(0),"^",25) S ^TMP($J,"RAE3",RADFN,"ORD")=RAOPRC
 I '$P(RAEXAM(0),"^",25) S ^TMP($J,"RAE3",RADFN,"ORD",RACIEN)=RAOPRC
 ;
 I RAPSET'<0 D
 .S ^TMP($J,"RAE3",RADFN,RACIEN,RAPROC)="^"_RABNOR_"^"_RAORD(7)
 .S $P(^TMP($J,"RAE3",RADFN,RACIEN,RAPROC),"^")=RARPTST2
 S:RAPSET<0 ^TMP($J,"RAE3",RADFN,RACIEN,RAPROC)=""
 S:RAPSET=1 RAPSET=-1
 ;
 ; Setup variables then call ^RARTR to create Rad Report on ^TMP nodes
 ; 2 stages: INIT^RARTR creates header info, PRT1^RARTR for the report
 ; (save RADFN as RARTR kills it at the end)
 ;
 S RAUTOE=1,ZZRADFN=RADFN,RAACNT=0
 S X="^"_RADFN_"^"_(9999999.9999-RAINVXDT)_"^"_RACASE_"^"_RARPTST
 ;
 D INIT^RARTR
 S (RAFFLF,RAORIOF)=$G(IOF)
 I RAY0<0!(RAY1<0)!(RAY2<0)!(RAY3<0) K RAFFLF Q
 ;
 S RAVERF=0
 I RARPTST2="No Report" D
 .S:'$D(RAMDIV) RAMDIV=+$P(^RADPT(RADFN,"DT",RAINVXDT,0),"^",3)
 .S:'$D(RAMDV) RAMDV=$S($D(^RA(79,RAMDIV,.1)):^(.1),1:""),RAMDV=$TR(RAMDV,"YNyn","1010")
 D PRT1^RARTR
 S RADFN=ZZRADFN
 Q:'$D(^TMP($J,"RA AUTOE"))
 ;
 ; Now manipulate ^TMP($J,"RA AUTOE" and save as ^TMP($J,"RAE3"
 ; Step 1: Change Case Number to Exam Date
 ; Step 2: Remove Impression, Report & Diagnostic Codes if not
 ;         Released or Verified or Electronically Filed
 ;         Also remove "Att Phys" and "Pri Phys"
 ; Step 3: Change Status to Report Status & add Reported Date
 ; Step 4: If No Report then get Clin History from file #70.
 ; ** WITH PATCH 27 - NO LONGER NEED TO DO STEP 4 **
 ;
STEP1 S ^TMP($J,"RAE3",RADFN,RACIEN,RAPROC,1)=$P(^TMP($J,"RA AUTOE",1),"Case: ")
 S ^TMP($J,"RAE3",RADFN,RACIEN,RAPROC,1.5)="Exm Date: "_$$GET1^DIQ(70.02,RAINVXDT_","_RADFN_",",.01,"E")
 ;
STEP2 K SKIP S N=1 F  S N=$O(^TMP($J,"RA AUTOE",N)) Q:N=""  D
 . S X0=^TMP($J,"RA AUTOE",N),X1=$E(X0,1,10)
 . I (X1="Att Phys: ")!(X1="Pri Phys: ") D
 .. S ^TMP($J,"RA AUTOE",N)=$E(BLANK,1,41)_$E(X0,42,$L(X0))
 .. Q
 .;I RARPTST2="No Report",($E(^TMP($J,"RA AUTOE",N),1,21)="    Clinical History:") D STEP4
 .I $E(^TMP($J,"RA AUTOE",N),1,12)="    Report: " D STEP3 Q:RARPTST2="No Report"
 .I 'RAINCLUD,$E(^TMP($J,"RA AUTOE",N),1,15)="    Impression:" D
 ..S SKIP=1,^TMP($J,"RAE3",RADFN,RACIEN,RAPROC,N+0.1)=""
 .I 'RAINCLUD,$E(^TMP($J,"RA AUTOE",N),1,28)="    Primary Diagnostic Code:" D
 ..S SKIP=1 S ^TMP($J,"RA AUTOE",N)=$E(^TMP($J,"RA AUTOE",N),1,28)
 .I 'RAINCLUD,$E(^TMP($J,"RA AUTOE",N),1,31)="    Secondary Diagnostic Codes:" D
 ..S SKIP=1,^TMP($J,"RAE3",RADFN,RACIEN,RAPROC,N+0.1)=""
 .I $E(^TMP($J,"RA AUTOE",N),1,27)="Primary Interpreting Staff:" K SKIP
 .I $D(SKIP) S SKIP=SKIP+1
 .I $G(SKIP)<3 S ^TMP($J,"RAE3",RADFN,RACIEN,RAPROC,N)=^TMP($J,"RA AUTOE",N)
 .Q
 ;
XIT K ^TMP($J,"RA AUTOE")
 Q
 ;
STEP3 S ^TMP($J,"RAE3",RADFN,RACIEN,RAPROC,N-0.4)="    Report Status: "_RARPTST2
 I RARPTST2="No Report" S N="^" Q
 S $P(RASPACE," ",46)=""
 S ^TMP($J,"RAE3",RADFN,RACIEN,RAPROC,N-0.4)=^(N-0.4)_$E(RASPACE,1,46-$L(^(N-0.4)))_"Date Reported: "_RARDE
 I RARPTST="V" D
 . S ^TMP($J,"RAE3",RADFN,RACIEN,RAPROC,N-0.3)=RASPACE_" Date Verified: "_$P($$GET1^DIQ(74,+$P(RAEXAM(0),"^",17),7),"@")
 . S ^TMP($J,"RAE3",RADFN,RACIEN,RAPROC,N-0.2)="    Verifier E-Sig:"_RASIGVES
 . Q
 S ^TMP($J,"RAE3",RADFN,RACIEN,RAPROC,N-0.1)=""
 S ^TMP($J,"RA AUTOE",N)="    Report:"
 I 'RAINCLUD S SKIP=1,^TMP($J,"RAE3",RADFN,RACIEN,RAPROC,N+0.1)=""
 Q
 ;
STEP4 I +$O(^RADPT(RADFN,"DT",RAINVXDT,"P",RACIEN,"H",0)) D
 .N RAI,RAIN,Z S (RAI,Z)=0,RAIN=N_".000"
 .F  S Z=$O(^RADPT(RADFN,"DT",RAINVXDT,"P",RACIEN,"H",Z)) Q:Z'>0  D
 ..S RAI=RAI+1
 ..S RAIN=$E(RAIN,1,$L(RAIN)-$L(RAI))_RAI
 ..S ^TMP($J,"RAE3",RADFN,RACIEN,RAPROC,RAIN)="      "_$G(^RADPT(RADFN,"DT",RAINVXDT,"P",RACIEN,"H",Z,0))
 Q
