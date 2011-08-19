RAO7PC2 ;HISC/GJC-Part two for Return Narrative (EN3^RAO7PC1) ;8/18/08  09:47
 ;;5.0;Radiology/Nuclear Medicine;**1,11,14,16,22,27,45,75,56,95,97**;Mar 16, 1998;Build 6
 ;Supported IA #1571 ^LEX(757.01
 ;Supported IA #10104 UP^XLFSTR
 ;Supported IA #2055 EXTERNAL^DILFD
 ;Supported IA #10060 ^VA(200
CASE(Y) ; Retrieve exam data for specified inverse exam date range.
 ; 'Y'-> Exam node IEN
 N RABNOR,RACNT,RAEXAM,RAI,RAIMPRES,RAINCLUD,RAOPRC,RAORD,RAPDIAG
 N RAPIST,RAPIRE,RAPROC,RARDE,RADTI,RACNI,RADUPHX,RAREASDY
 N RARPT,RARPTST,RARPTXT,RASBN,RASDIAG,RAVER,RAERRFLG,Z,Z1,Z2,RATMP
 S RACNT=1
 S RAEXAM(0)=$G(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,0)) Q:RAEXAM(0)']""
 S:$P(RAEXAM(0),"^",25)=2 RAPSET=1
 S:RAPSET=1 ^TMP($J,"RAE2",RADFN,"PRINT_SET")="" ; xam set with same rpt
 S RAPROC(0)=$G(^RAMIS(71,+$P(RAEXAM(0),"^",2),0))
 S RAPROC=$S($P(RAPROC(0),"^")]"":$P(RAPROC(0),"^"),1:"Unknown")
 S RAORD(0)=$G(^RAO(75.1,+$P(RAEXAM(0),"^",11),0))
 S RAORD(7)=$P(RAORD(0),"^",7) ; CPRS order ien
 S RAREASDY=$P($G(^RAO(75.1,+$P(RAEXAM(0),"^",11),.1)),"^") ;REASON FOR STUDY
 S RAOPRC(0)=$G(^RAMIS(71,+$P(RAORD(0),"^",2),0))
 S RAOPRC=$S($P(RAOPRC(0),"^")]"":$P(RAOPRC(0),"^"),1:"Unknown")
 S RAPDIAG(0)=$G(^RA(78.3,+$P(RAEXAM(0),"^",13),0))
 S RATMP=$$GET1^DIQ(757.01,$P($G(^RA(78.3,+$P(RAEXAM(0),U,13),0)),U,6),.01)
 S RAPDIAG=$P(RAPDIAG(0),"^")_$S(RATMP="":"",1:" ("_RATMP_")")
 S RARPT=+$P(RAEXAM(0),"^",17)
 ; RARPTST="NO REPORT" if no ^RARPT(ien) OR no data for Report Status
 S RARPT(0)=$G(^RARPT(RARPT,0)),RARPTST=$$UL^RAO7PC1A($$RSTAT^RAO7PC1A())
 ; set the following flag variable: RAINCLUD
 ; RAINCLUD=1 includes V, R, EF <-- patch 95
 S RAINCLUD=$S("RVE"[$E(RARPTST):1,1:0)
 I $E(RARPTST)="V",(RAPSET'<0) D
 . S RAVER=$P(RARPT(0),"^",9),RASBN=$P($G(^VA(200,+RAVER,20)),"^",2)
 . S ^TMP($J,"RAE2",RADFN,Y,RAPROC,"V")=RAVER_"^"_RASBN
 . Q
 S RABNOR=$$UP^XLFSTR($P(RAPDIAG(0),"^",4)) S:RABNOR'="Y" RABNOR=""
 I RAPDIAG]"",(RAINCLUD),(RAPSET'<0) D  ; if diag & verif'd or released/unverif'd & first pass if part of xam set (many xams - one rpt)
 . S ^TMP($J,"RAE2",RADFN,Y,RAPROC,"D",RACNT)=RAPDIAG
 . Q
 S ^TMP($J,"RAE2",RADFN,Y,RAPROC,"RFS")=RAREASDY ;REASON FOR STUDY
 ; 1st, get clnhist from file70. 2nd, get addl clnhist form file74
 ; 1st:
 I +$O(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"H",0)) D
 . N RAI S (RAI,Z)=0
 . F  S Z=$O(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"H",Z)) Q:Z'>0  D
 .. S RAI=RAI+1
 .. S ^TMP($J,"RAE2",RADFN,Y,RAPROC,"H",RAI)=$G(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"H",Z,0))
 .. Q
 . Q
 ;2nd:
 S RADTI=RAINVXDT,RACNI=Y D CHKDUPHX^RART1 ;chk if file74 clnhist is dupl
 I 'RADUPHX,$O(^RARPT(RARPT,"H",0)) S Z="H" D RPTXT(RARPT,Z)
 ;
 I +$O(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"M",0)) D  ; save modifiers
 . N RAI S (RAI,Z)=0
 . F  S Z=$O(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"M",Z)) Q:Z'>0  D
 .. S RAI=RAI+1
 .. S ^TMP($J,"RAE2",RADFN,Y,RAPROC,"M",RAI)=$P($G(^RAMIS(71.2,+$G(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"M",Z,0)),0)),"^")
 .. Q
 . Q
 I +$O(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"DX",0)),(RAPSET'<0) D
 . S Z=0 F  S Z=$O(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"DX",Z)) Q:Z'>0  D
 .. S RASDIAG=+$G(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"DX",Z,0))
 .. S RASDIAG(0)=$G(^RA(78.3,RASDIAG,0))
 .. S RATMP=$$GET1^DIQ(757.01,$P($G(^RA(78.3,+RASDIAG,0)),U,6),.01)
 .. S RASDIAG(1)=$P(RASDIAG(0),"^")_$S(RATMP="":"",1:" ("_RATMP_")")
 .. I RASDIAG(1)]"",(RAINCLUD) D
 ... S RACNT=RACNT+1,^TMP($J,"RAE2",RADFN,Y,RAPROC,"D",RACNT)=RASDIAG(1)
 ... I RABNOR'="Y" D
 .... S RABNOR=$$UP^XLFSTR($P(RASDIAG(0),"^",4)) S:RABNOR'="Y" RABNOR=""
 .... Q
 ... Q
 .. Q
 . Q
 I RAINCLUD,(RAPSET'<0) D
 . I +$O(^RARPT(RARPT,"I",0)) S Z="I" D RPTXT(RARPT,Z)
 . I +$O(^RARPT(RARPT,"R",0)) S Z="R" D RPTXT(RARPT,Z)
 . Q
 I $P(RAEXAM(0),"^",25) S ^TMP($J,"RAE2",RADFN,"ORD")=RAOPRC
 I '$P(RAEXAM(0),"^",25) S ^TMP($J,"RAE2",RADFN,"ORD",Y)=RAOPRC
 ;
 ; Check to see if amended report
 I RAPSET'<0,+$O(^RARPT(RARPT,"ERR",0)) S RAERRFLG="A"
 ;
 S:RAPSET'<0 ^TMP($J,"RAE2",RADFN,Y,RAPROC)=RARPTST_"^"_$G(RABNOR)_"^"_$G(RAORD(7))_"^"_$G(RAERRFLG)
 S:RAPSET<0 ^TMP($J,"RAE2",RADFN,Y,RAPROC)=""
 S:RAPSET=1 RAPSET=-1
 ;
 I RARPTST'="No Report" D
 .; Add Prim Int Staff, Prim Int Resident & Reported Date
 .S RAPIST=$P(RAEXAM(0),"^",15)
 .S RAPIRE=$P(RAEXAM(0),"^",12)
 .S RARDE=$P(RARPT(0),"^",8)
 .S ^TMP($J,"RAE2",RADFN,Y,RAPROC,"P")=RAPIST_"^"_RAPIRE_"^"_RARDE
 ;If contrast media was involved in the exam pass that information.
 I +$O(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"CM",0)) S (RACNT,RAI)=0 D
 .F  S RAI=$O(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"CM",RAI)) Q:'RAI  D
 ..S RACNT=RACNT+1
 ..S RAI(0)=$G(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"CM",RAI,0))
 ..S ^TMP($J,"RAE2",RADFN,Y,RAPROC,"CM",RACNT)=$P(RAI(0),U)_"^"_$$EXTERNAL^DILFD(70.3225,.01,"",$P(RAI(0),U))
 ..Q
 Q
 ;
RPTXT(RARPT,Z) ; Retrieve report text & store in ^TMP
 ; 'RARPT' -> Report IEN
 ; 'Z'     -> "I":Impression Text <> "R":Report Text
 S (Z1,Z2)=0
 ;file 74's "H" nodes are now additional clinical history
 I Z="H" S Z2=$O(^TMP($J,"RAE2",RADFN,Y,RAPROC,Z,""),-1) I $O(^RARPT(RARPT,Z,Z1)) S Z2=Z2+1,^TMP($J,"RAE2",RADFN,Y,RAPROC,Z,Z2)="Additional Clinical History:"
 F  S Z1=$O(^RARPT(RARPT,Z,Z1)) Q:Z1'>0  D
 . S Z1(0)=$G(^RARPT(RARPT,Z,Z1,0)),Z2=Z2+1
 . S ^TMP($J,"RAE2",RADFN,Y,RAPROC,Z,Z2)=Z1(0)
 . Q
 Q
 ;
CLIN(DFN,PROCLIST) ;Radiology and Clinical Reminders API
 ;
 ; Created by Cameron Taylor March 1999
 ; 
 ; This API recieves a patient and a list of procedures. For each 
 ; Procedure, the details of the last 'complete' procedure and/or the
 ; last 'cancelled' & 'in progress' procedure details and returns them 
 ; in ^TMP($J,"RADPROC"
 N XX,PROC,DATE,STATUS,PROVIDER,EXAM,X,Y,EXAMIEN,RADPTIEN,ORDER,SUCCESS
 ; 
 S DFN=$G(DFN)  ; Patient Name
 S PROCLIST=$G(PROCLIST)  ; List of Procedures (separated by '^')
 K ^TMP($J,"RADPROC")
 ;
 S RADPTIEN=$O(^RADPT("B",DFN,""))
 I (RADPTIEN="")!(RADPTIEN=0) D  Q
 .S ^TMP($J,"RADPROC")="Invalid/Unknown Radiology Patient"
 ;
 F XX=1:1 S PROC=$P(PROCLIST,U,XX) Q:PROC=""  D
 .S SUCCESS=0  ; Quit searching if SUCCESS=3 (comp, canc & in prog)
 .S DATE=0 F  S DATE=$O(^RADPT(RADPTIEN,"DT",DATE)) Q:DATE'?7N1".".N!(SUCCESS=3)  D
 ..S EXAMIEN=0 F  S EXAMIEN=$O(^RADPT(RADPTIEN,"DT",DATE,"P",EXAMIEN)) Q:'EXAMIEN!(SUCCESS=3)  D
 ...S EXAM=$G(^RADPT(RADPTIEN,"DT",DATE,"P",EXAMIEN,0))
 ...Q:$P(EXAM,U,2)'=PROC
 ...;
 ...; Continue, get STATUS and ORDER 
 ...; (0 is cancelled, 1-8 in progress & 9 is COMPLETE)
 ...; (ignore if null)
 ...;
 ...S STATUS=$P(EXAM,U,3)
 ...I STATUS'="" D
 ....S ORDER=$P(^RA(72,STATUS,0),U,3)
 ....S STATUS=$P(^RA(72,STATUS,0),U) ; description
 ...; 
 ...; Only one of each type (ORDER)
 ...;
 ...Q:ORDER=""
 ...I ORDER=0 Q:$D(^TMP($J,"RADPROC",RADPTIEN,PROC,"CANCELLED"))  S ORDER="CANCELLED"
 ...I ORDER=9 Q:$D(^TMP($J,"RADPROC",RADPTIEN,PROC,"COMPLETE"))  S ORDER="COMPLETE"
 ...I ORDER<9,ORDER>0 Q:$D(^TMP($J,"RADPROC",RADPTIEN,PROC,"IN PROGRESS"))  S ORDER="IN PROGRESS"
 ...;
 ...; Now for the PROVIDER. Check PRIMARY INTERPRETING STAFF 
 ...; if none, then default to PRIMARY INTERPRETING RESIDENT.
 ...;
 ...S PROVIDER=$P(EXAM,U,15)
 ...S:PROVIDER="" PROVIDER=$P(EXAM,U,12)
 ...S:PROVIDER'="" PROVIDER=$P($G(^VA(200,PROVIDER,0)),U,1) ; description
 ...;
 ...; Create return info. on ^TMP (1st manipulate DATE)
 ...;
 ...S Y=9999999.9999-DATE
 ...S ^TMP($J,"RADPROC",RADPTIEN,PROC,ORDER)=Y_U_STATUS_U_PROVIDER
 ...S SUCCESS=SUCCESS+1
 .;
 .; Finished searching Patient file. Any Procedures with no activity?
 .;
 .I '$D(^TMP($J,"RADPROC",RADPTIEN,PROC)) S ^TMP($J,"RADPROC",RADPTIEN,PROC,"NONE")=""
 Q
 ;
