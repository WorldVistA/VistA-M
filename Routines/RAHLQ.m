RAHLQ ;HISC/CAH,GJC AISC/SAW-Process Query Message (QRY) Type ;10/2/97  13:32
 ;;5.0;Radiology/Nuclear Medicine;**7**;Mar 16, 1998
 ; Check the validity of the following data globals:
 ; Example: '^TMP("RARPT-QRY",$J,RASUB,' (RASUB is an ien in file 772)
 ; **************** validates if data present **************************
 ; ^TMP("RARPT-QRY",$J,RASUB,"RAEXAM")=case number, if case no. entered
 ; ^TMP("RARPT-QRY",$J,RASUB,"RANUMREC")=max # of records to retrieve
 ; ^TMP("RARPT-QRY",$J,RASUB,"RASSN")=SSN of the patient, if ssn entered
 ; ^TMP("RARPT-QRY",$J,RASUB,"RAVERF")=ien of user doing the query
 ; note: ^TMP("RARPT-QRY" should only have 3 of 4
 ; of these nodes; RAEXAM and RASSN are mutually exclusive
 ; *********************************************************************
EN1 S I="" F  S I=$O(^TMP("RARPT-QRY",$J,RASUB,I)) Q:I=""  S @I=$G(^(I))
 ; this should set the variables: RAEXAM/RASSN, RANUMREC, RAVERF
 I '$G(RAVERF) S RAERR="Invalid Access Code" Q
QRD ;Analyze data from the 'QRY' Message from Non-DHCP System
 I '$D(RASSN),'$D(RAEXAM) S RAERR="Missing both the Patient & Exam ID" Q
 I $D(RASSN) I '$S(RASSN?9N:1,RASSN?9N1A:1,RASSN?1A4N:1,1:0) S RAERR="Invalid Patient ID" Q
 I $D(RAEXAM) I '$S(RAEXAM?6N1"-".N:1,RAEXAM?.N:1,1:0) S RAERR="Invalid Exam ID" Q
 D:$D(RASSN) SSN D:$D(RAEXAM) EXAM
 K RARPT
 Q
 ;Look Up Query Subject by SSN or BS5 X-refs
SSN S:$E(RASSN)?1L RASSN=$C($A($E(RASSN))-32)_$E(RASSN,2,5) S RAI=$S(RASSN?1U4N:"BS5",1:"SSN") S:$L(RASSN)=10&($E(RASSN,10)?1L) RASSN=$E(RASSN,1,9)_$C($A($E(RASSN,10))-32)
 S RADFN=$O(^DPT(RAI,RASSN,0)) I 'RADFN S RAERR="Invalid Patient Identifier" Q
 I $O(^DPT(RAI,RASSN,RADFN)) S RAERR="Ambiguous Patient Identifier" Q
 I '$D(^RADPT(RADFN)) S RAERR="No Exams on File for This Patient" Q
 K VADM,VAERR S DFN=RADFN D DEM^VADPT
 I VADM(1)']"" S RAERR="Invalid Patient Identifier" Q
 S (RARECNT,RADTI)=0
 F  S RADTI=$O(^RADPT(RADFN,"DT",RADTI)) Q:RADTI'>0!(RARECNT>RANUMREC)  D
 . S RACNI=0
 . F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0!(RARECNT>RANUMREC)  D
 .. I $D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) S RACN0=^(0) D
 ... D EDTCHK Q:RARPT
 ... S RARPT=+$P(RACN0,"^",17) Q:'RARPT  S RARPT=$G(^RARPT(RARPT,0)),RARPT=$S("PD"[$P(RARPT,"^",5):0,1:1)
 .. I 'RARPT S RARECNT=RARECNT+1 Q:RARECNT>RANUMREC  D EN1^RAHLQ1
 .. Q
 . Q
 I 'RARECNT S RAERR="No Exams on File for This Patient"
 Q
EXAM ;Look Up Query Subject by Exam/Case Number
 S RAI=$S(RAEXAM["-":"ADC",1:"AE")
 S RADFN=$O(^RADPT(RAI,RAEXAM,0)) I 'RADFN S RAERR="Invalid Exam Number or Exam Already Complete" Q
 I $O(^RADPT(RAI,RAEXAM,RADFN)) S RAERR="Ambiguous Exam Number" Q
 S RADTI=$O(^RADPT(RAI,RAEXAM,RADFN,0)) I 'RADTI S RAERR="Invalid Exam Number" Q
 S RACNI=$O(^RADPT(RAI,RAEXAM,RADFN,RADTI,0)) I 'RACNI S RAERR="Invalid Exam Number" Q
 S RACN0=$S($D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)):^(0),1:"") I 'RACN0 S RAERR="Invalid Case Number" Q
 D EDTCHK I RARPT=1 S RAERR="STATUS is CANCELLED. User is not permitted to edit report." Q
 I RARPT=2 S RAERR="Case is cancelled AND belongs to a printset -- please use DHCP to edit this case." Q
 I $P(RACN0,"^",17) S RARPT=$G(^RARPT($P(RACN0,"^",17),0)),RARPT=$S("PD"[$P(RARPT,"^",5):0,1:1) I RARPT S RAERR="Report Already On File" Q
 K VA,VADM,VAERR S DFN=RADFN D DEM^VADPT I VADM(1)']"" S RAERR="Invalid Patient Identifier" Q
 S RARECNT=1 ; exactly one case is being queried
 D EN1^RAHLQ1
 Q
CHKPRV ;Check for active interpreting staff/resident
 ; Examine the following two (2) conditions
 ; 1) Does this person have a resident or staff classification?
 ; 2) Is this person an active Rad/Nuc Med user?
 ; If 'No' to any of the above questions, set the variable RAERR to
 ; the appropriate error message.
 I '$D(^VA(200,"ARC","R",RAVERF)),('$D(^VA(200,"ARC","S",RAVERF))) D  Q
 . ; neither a resident or staff
 . S RAERR="Provider not classified as resident or staff."
 . Q
 I $P($G(^VA(200,RAVERF,"RA")),"^",3),($P(^("RA"),"^",3)'>$$DT^XLFDT()) D
 . ; Rad/Nuc Med user has been inactivated.
 . K RAESIG S RAERR="Inactive Rad/Nuc Med Classification for Interpreting Physician."
 . Q
 I '$D(^XUSEC("RA VERIFY",RAVERF)) S RAERR="Provider does not hold the appropriate Rad/Nuc Med security key."
 Q
EDTCHK ; is user permitted to edit report of a cancelled case ?
 ; Sets RARPT to indicate if report is allowed
 ; RARPT=1 if case cancelled, no report allowed
 ; RARPT=2 if cancelled printset, no report allowed
 ; RARPT=0 if case not cancelled, or user has key, or div params
 ;         allow rpt on cancelled cases, report entry allowed
 S RARPT=0
 S RASTATUS=+$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),"^",3)
 I $P($G(^RA(72,RASTATUS,0)),"^",3)>0 K RASTATUS Q
 K RASTATUS
 I +$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),"^",25)>1 S RARPT=2 Q  ;don't allow edit if printset
 I $D(^XUSEC("RA MGR",+$G(RAVERF))) Q  ;user has proper key
 I $D(^RADPT(RADFN,"DT",RADTI,0)) S RAMDIV=^(0),RAMLC=+$P(RAMDIV,"^",4),RAMDIV=+$P(RAMDIV,"^",3),RAMDV=$S($D(^RA(79,RAMDIV,.1)):^(.1),1:""),RAMDV=$S(RAMDV="":RAMDV,1:$TR(RAMDV,"YyNn",1100))
 I $P(RAMDV,"^",22)=1 Q  ;allow rpts on cancelled cases
 S RARPT=1  ;
 Q
