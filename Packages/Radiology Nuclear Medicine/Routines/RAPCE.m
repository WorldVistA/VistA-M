RAPCE ;HIRMFO/GJC - Interface with PCE APIs for wrkload, visits ; Apr 28, 2022@08:42:59
 ;;5.0;Radiology/Nuclear Medicine;**10,17,21,26,41,57,56,153,172,174,189**;Mar 16, 1998;Build 1
 ;Supported IA #2053 FILE^DIE
 ;Supported IA #4663 SWSTAT^IBBAPI
 ;Controlled IA #1889 DATA2PCE^PXAPI
 Q
COMPLETE(RADFN,RADTI,RACNI) ; When an exam status changes to 'complete'
 ; Input: RADFN-> Patient DFN, RADTI-> Exam Timestamp, RACNI-> Case IEN
 ; NOTE:  RACNI input param is ignored for exam sets (all cases under
 ;
 ;//P174 begin//
 ;  if this is a study with an outside report with a
 ;  REPORT STATUS of 'Electronically Filed' quit.
 Q:$$OUTSIDE()=1
 ;//P174 end//
 ;
 ; an exam set are processed at once when order is complete)
 ; $$DATA2PCE^PXAPI returns: 1 if no errors, else error condition
 ;
 K ^TMP("DIERR",$J),^TMP("RAPXAPI",$J)
 N RA7002,RA7003,RA71,RA791,RACNT,RADTE,RAEARRY,RAPKG,RAVSIT,RABAD,RASTAT,RACPTM,RA,RA1,RARECMPL,RACNISAV
 N RADUPRC,RACOMIEN,RASENT,RALCKFAL
 S RALCKFAL=0 ; >0 if lock fails when :
 ; 1= complt'g exam that's unique to other cases same dt/tm, if any
 ; 2= complt'g exam that's a dupl of another cmplt'd exam (RESEND^RAPCE1)
 ; 3= UNcompleting exam before deleting credit+visit pointers same dt/tm
 S RAPKG=$O(^DIC(9.4,"B","RADIOLOGY/NUCLEAR MEDICINE",0))
 S RADTE=9999999.9999-RADTI,RACNT=0
 S RA7002=$G(^RADPT(RADFN,"DT",RADTI,0))
 S RAXAMSET=+$P(RA7002,"^",5) ; is this part of an exam set? 1=YES
 ;TEST: Singles registered together - treat as examset.
 ;I '$G(RAXAMSET),$P(^RADPT(RADFN,"DT",RADTI,"P",0),U,4)>1 S RAXAMSET=1
 ;
 ;//P174 begin//
EN2 ;check i-loc's credit method quit if 'no credit'
 S RA791=$G(^RA(79.1,+$P(RA7002,"^",4),0))
 Q:+$P(RA791,"^",21)=2  ; no credit, quit
 ;//P174 end//
 ;
 ; Initialize variables required for PFSS 1B project and check the switch status.
 N RAPFSW,RACCOUNT S RAPFSW=$$SWSTAT^IBBAPI ; Requirement 12
 S RAEARRY="RAERROR" N @RAEARRY
LON ; lock at P level
 L +^RADPT(RADFN,"DT",RADTI,"P",RACNI):30 I '$T S RALCKFAL=1 D FAILBUL^RAPCE2(RADFN,RADTI,RACNI,$S($G(RADUZ):RADUZ,1:DUZ)) Q
 I 'RAXAMSET G NONSET
 ; exam set, grab all the completed records!
 S RACNISAV=RACNI
 S RACNI=0
 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0!($G(RABAD))  D
 . S RA7003=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) I $P($G(^RA(72,+$P(RA7003,U,3),0)),U,3)'=9 Q  ;check code instead of name
 . S RACNT=RACNT+1 D SETUP I $G(RABAD) Q
 . D:'$D(^TMP("RAPXAPI",$J,"ENCOUNTER")) ENC(RACNT)
 . D DX^RABWPCE($P(RA7003,U,11)) ; Ordering ICD Dx and related data.
 . D PROC(RACNT)
 . Q
 S RACNI=RACNISAV ;restore value so unlock would work 012601
 I '$G(RABAD),$D(^TMP("RAPXAPI",$J)) D PCE(RADFN,RADTI,RACNI)
 ;Missing data, send failure bulletin for ea case in set, don't attempt to send data to PCE
 I $G(RABAD) W:'$D(ZTQUEUED)&('$D(RARECMPL)) !,"Unable to credit Exam set" D
 . S RACNI=0 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0  D FAILBUL^RAPCE2(RADFN,RADTI,RACNI,$S($G(RADUZ):RADUZ,1:DUZ))
 G KOUT
NONSET ; non-exam sets
 S RA7003=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 D CKDUP^RAPCE1 ; chk for duplicate procedure(s) non-examset
 I $G(RADUPRC) D RESEND^RAPCE1 G KOUT ; branch off to re-send rec(s) this dt/tm
 S RACNT=RACNT+1
 D SETUP
 D:'$G(RABAD) ENC(RACNT) D:'$G(RABAD) DX^RABWPCE($P(RA7003,U,11)) D:'$G(RABAD) PROC(RACNT) D:'$G(RABAD) PCE(RADFN,RADTI,RACNI)
 I $G(RABAD) W:'$D(ZTQUEUED)&('$D(RARECMPL)) !,"Unable to credit exam" D FAILBUL^RAPCE2(RADFN,RADTI,RACNI,$S($G(RADUZ):RADUZ,1:DUZ)) ;Missing data, send failure bulletin for single case, don't attempt to pass data to PCE
 ;
KOUT K ^TMP("RAPXAPI",$J)
 L -^RADPT(RADFN,"DT",RADTI,"P",RACNI)
 Q
ENC(X) ; Set up the '"RAPXAPI",$J,"ENCOUNTER"' nodes
 N RAIMGLOC,RA17,RARPTLOC
 S RA17=+$P(RA7003,U,17)
 S RARPTLOC=$P($G(^RARPT(RA17,"BA")),U,1)
 S RAIMGLOC=$P($G(^RA(79.1,+RARPTLOC,0)),"^")
 S:'RAIMGLOC RAIMGLOC=$P($G(^RA(79.1,+$P(RA7002,"^",4),0)),"^")
 I RAIMGLOC="" S RABAD=1 Q  ; needs imaging location
 S ^TMP("RAPXAPI",$J,"ENCOUNTER",X,"PATIENT")=RADFN
 S ^TMP("RAPXAPI",$J,"ENCOUNTER",X,"ENC D/T")=RADTE
 S ^TMP("RAPXAPI",$J,"ENCOUNTER",X,"HOS LOC")=RAIMGLOC
 S ^TMP("RAPXAPI",$J,"ENCOUNTER",X,"SERVICE CATEGORY")="X"
 S ^TMP("RAPXAPI",$J,"ENCOUNTER",X,"ENCOUNTER TYPE")="A"
 Q
PCE(RADFN,RADTI,RACNI) ; Pass on the information to the PCE software
 N RASULT
 ; If the PFSS switch is not active then do not pass RACCOUNT parameter to DATA2PCE call.
 I 'RAPFSW S RASULT=$$DATA2PCE^PXAPI("^TMP(""RAPXAPI"",$J)",RAPKG,"RAD/NUC MED",.RAVSIT,"","","","",.@RAEARRY)
 ; If the PFSS switch is active then use RACCOUNT parameter in DATA2PCE call.
 I RAPFSW D
 . ; PFSS Requirement 6, 11
 . S RASULT=$$DATA2PCE^PXAPI("^TMP(""RAPXAPI"",$J)",RAPKG,"RAD/NUC MED",.RAVSIT,"","","","",.@RAEARRY,.RACCOUNT)
 . Q
 ;KLM/p172 - PX211 adds new result values that create visits.  We'll check for visit IEN instead.
 I $G(RAVSIT)>0 D  ;Visit file pointer, set 'Credit recorded' to yes. 
 . W:'$D(ZTQUEUED)&('$D(RARECMPL)) !?5,"Visit credited.",!
 . D:'RAXAMSET VISIT(RADFN,RADTI,RACNI,RAVSIT)
 . D:'RAXAMSET RECDCS(RADFN,RADTI,RACNI) ; only one exam, not a set
 . D:RAXAMSET MULCS(RADFN,RADTI) ; set, update all exams!
 . S RASENT=1 ; sent to PCE was okay
 . Q
 E  D
 . I $G(RASULT)=-2 D RSCRFLR^RAPCE1 Q  ;p189/KLM - Resend to PCE (PX211 work around)
 . N RAWHOERR S RAWHOERR=""
 . W:'$D(ZTQUEUED)&('$D(RARECMPL)) !?5,$C(7),"Unable to credit.",!
 . I '$G(RAXAMSET) D FAILBUL^RAPCE2(RADFN,RADTI,RACNI,$S($G(RADUZ):RADUZ,1:DUZ))
 . I $G(RAXAMSET) D
 .. S RACNI=0 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0  D FAILBUL^RAPCE2(RADFN,RADTI,RACNI,$S($G(RADUZ):RADUZ,1:DUZ))
 .. Q
 . Q
 Q
MULCS(RADFN,RADTI) ; Update the 'Credit recorded' field and the Visit 
 ;pointer for each case that is complete
 N RACNI S RACNI=0
 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0  D
 . Q:$P($G(^RA(72,+$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),U,3),0)),U,3)'=9
 . D RECDCS(RADFN,RADTI,RACNI)
 . D VISIT(RADFN,RADTI,RACNI,RAVSIT)
 . Q
 Q
PROC(X) ; Set up the other '"RAPXAPI",$J,"PROCEDURE"' nodes for this case
 ; If same procedure repeated in exam set, add to qty of existing 
 ; 'procedure' node.   Else, if different provider, create new 
 ; separate 'procedure' nodes
 N X1,X2,X3,RADUP F X1=1:1:X S X2=$G(^TMP("RAPXAPI",$J,"PROCEDURE",X1,"PROCEDURE")) I X2=$P(RA71,"^",9),^("ENC PROVIDER")=$S(RA7003(15)]"":RA7003(15),1:RA7003(12)) D  Q
 . S ^TMP("RAPXAPI",$J,"PROCEDURE",X1,"QTY")=^("QTY")+1
 . D CPTMOD(X1)
 . S RADUP=1
 . Q
 I $D(RADUP) Q
 S ^TMP("RAPXAPI",$J,"PROCEDURE",X,"QTY")=1
 S ^TMP("RAPXAPI",$J,"PROCEDURE",X,"PROCEDURE")=$P(RA71,"^",9)
 S ^TMP("RAPXAPI",$J,"PROCEDURE",X,"NARRATIVE")=$P(RA71,"^")
 S ^TMP("RAPXAPI",$J,"PROCEDURE",X,"ENC PROVIDER")=$S(RA7003(15)]"":RA7003(15),1:RA7003(12)) ; Pri. Int Staff if exists, else Pri Int Resident
 S ^TMP("RAPXAPI",$J,"PROCEDURE",X,"ORD PROVIDER")=RA7003(14) ; Requesting Physician.
 S ^TMP("RAPXAPI",$J,"PROCEDURE",X,"EVENT D/T")=$$FMADD^XLFDT(RADTE,0,0,0,RACNI) ;For unique entry in V CPT post PX*1.0*211
 ;KLM/p172 - Pass the radiologist as 'Primary' for the encounter.
 S ^TMP("RAPXAPI",$J,"PROVIDER",X,"NAME")=$S(RA7003(15)]"":RA7003(15),1:RA7003(12)) ; Pri. Int Staff if exists, else Pri Int Resident
 S ^TMP("RAPXAPI",$J,"PROVIDER",X,"PRIMARY")=X
 ; if the PFSS switch is active Get both Dept. Code and Account Reference Number (RACCOUNT)
 I RAPFSW D GETDEPT^RABWIBB ; Requirement 9
 D CPTMOD(X)
 D PROCDX^RABWPCE(X) ; Add Ordering ICD Dx to each Procedure.
 Q
RECDCS(RADFN,RADTI,RACNI) ; Set 'Clinic Stop Recorded' to yes
 ; (70.03, fld 23)
 N RAFDA S RAFDA(70.03,RACNI_","_RADTI_","_RADFN_",",23)="Y"
 D FILE^DIE("K","RAFDA")
 Q
SETUP ; Setup examination data node information
 ; If no provider, or inactive CPT, fail
 S RA7003=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 S RA7003(12)=$P(RA7003,"^",12) ; Pri. Inter. Resident
 S RA7003(14)=$P(RA7003,"^",14) ; Requesting Physician.
 S RA7003(15)=$P(RA7003,"^",15) ; Pri. Inter. Staff
 ; OK to send if missing resident/staff ONLY if report Elec. Filed
 I (RA7003(12)="")&(RA7003(15)=""),$P($G(^RARPT(+$P(RA7003,U,17),0)),U,5)'="EF" S RABAD=1 Q
 S RA71=$G(^RAMIS(71,+$P(RA7003,"^",2),0))
 ; store CPT Modifiers' .01 value
 K RACPTM S RA=0 F  S RA=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",RA)) Q:'RA  S RA1=$$BASICMOD^RACPTMSC($P($G(^(RA,0)),"^"),+$P(RA7002,"^")) S:+RA1>0 RACPTM(RA)=$P(RA1,"^",2) ;only valid cpt mods
 ; find out if CPT code is active
 I '$$ACTCODE^RACPTMSC(+$P(RA71,"^",9),$P(RA7002,"^")) S RABAD=1
 Q
VISIT(RADFN,RADTI,RACNI,RAVSIT) ; Stuff the Visit file pointer passed back
 ; from $$DATA2PCE^PXAPI() into the Visit field (70.02, fld 6)
 N RAFDA S RAFDA(70.03,RACNI_","_RADTI_","_RADFN_",",27)=RAVSIT
 D FILE^DIE("K","RAFDA")
 Q
CPTMOD(X3) ;CPT Modifiers
 ; CPT Mods for dupl. procedure+provider will be accounted for
 ; however, same CPT Mod will overwrite previous CPT Mod
 S ^TMP("RAPXAPI",$J,"PROCEDURE",X3,"MODIFIERS")="" ;prevent abend
 S RA=0
 F  S RA=$O(RACPTM(RA)) Q:'RA  S ^TMP("RAPXAPI",$J,"PROCEDURE",X3,"MODIFIERS",RACPTM(RA))=""
 Q
 ;
OUTSIDE() ;is this study tied to an outside report?
 ; input: none (vars RADFN,RADTI,RACNI must exist)
 ;return: one if an outside report, else zero
 ; note: Dx code and intepreter cannot be entered
 ;       w/o a report on file
 Q:'$D(RADFN)#2!('$D(RADTI)#2)!('$D(RACNI)#2) 1
 N RARPT,RAY3
 S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 ;if no report maybe their exam status setup
 ;needs review? Continue through RAPCE.
 S RARPT=$P(RAY3,U,17) Q:RARPT="" 0
 S RARPT(0)=$G(^RARPT(RARPT,0))
 ;REPORT STATUS fld #5, 0;5
 ;DATE INITIAL OUTSIDE RPT ENTRY fld #18, 0;18
 Q $S($P(RARPT(0),U,5)="EF"&($P(RARPT(0),U,18)>0):1,1:0)
 ;
