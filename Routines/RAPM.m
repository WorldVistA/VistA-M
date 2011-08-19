RAPM ;HOIFO/TH-Radiology Performance Monitors/Indicator; ;5/12/04  10:03
 ;;5.0;Radiology/Nuclear Medicine;**37,44,48,67,99**;Mar 16, 1998;Build 5
 ;RVD - 3/19/09 p99.
 ;Supported IA #2056 reference to ^DIQ
 ;Supported IA #10000 reference to C^%DTC
 ;Supported IA #10090 reference to ^DIC(4
 ; *** Application variables: ***
 ;
 ; Exam Date - RADTE (Regular Fileman format)
 ;             RADTI (Inverse Fileman format)
 ; Case Number - RACN               Exam Status - RAEXST
 ; Category of Exam - RACAT         Primary Interpreting Staff - RAPRIM
 ; Date Report Entered - RARPTDT    Verified Date - RAVERDT
 ; Report Status - RARPTST          Page Number - RAPG
 ; Type of Report - RARPT
 ; Internal number of an entry in the Patient file (#2) - RADFN
 ;
INIT ; Check for the existence of RACESS. Pass in user's DUZ!
 I $D(DUZ),($O(RACCESS(DUZ,""))']"") D CHECK^RADLQ3(DUZ)
 ;
 N DIR,DIRUT,RABDATE,RAEDATE,RARPT,DTDIFF,RABEGDT,RAENDDT,RA1
 N RAM,RARAD,RAR,RAMSG,X,Y K RAP99
 S (RABDATE,RAEDATE,RAANS,RAANS2,RANODIV,RASINCE,RARAD)="",RAN=0
 ; RANODIV=1 if one or more exams are missing DIVISION
PROMPT ; 
 W @IOF
 W !!,"Radiology Verification Timeliness Report",!!
 ; Prompt for Report Type. Quit if no report type selected
 D GETRPT K DIR Q:$D(DIRUT)
 ; Prompt for Date Range - Quit if no dates selected
 W !! D GETDATE K DIR Q:$D(DIRUT)
 ; Prompt for Radiologist if Short or Both
 D RADIOL^RAPM3
 ; Prompt for Division and Imaging Types
 S X=$$DIVLOC^RAUTL7() I X G EXIT
 I $D(^TMP($J,"RA I-TYPE","VASCULAR LAB")) D
 . K ^TMP($J,"RA I-TYPE","VASCULAR LAB")
 . W !!?5,"*** Imaging type 'Vascular Lab' will not be included in this report ***"
 ; Prompt for sort option if Detail
 D:RARPT'="S" SORT K DIR Q:$D(DIRUT)
 ; Prompt for mail delivery if Short or Both
 I RARPT'="D" D EMAIL^RAPM2 K DIR Q:$D(DIRUT)
 ; Warning for Detail or Both
 I RARPT="D"!(RARPT="B") D
 . S RATXT="*** The detail report requires a 132 column output device ***"
 . S RALINE="",$P(RALINE,"*",$L(RATXT))=""
 . W !!?(80-$L(RATXT)\2),RALINE,!?(80-$L(RATXT)\2),RATXT,!?(80-$L(RATXT)\2),RALINE,!
 .Q
 D DEV
 I RAPOP D  G EXIT
 . I RAANS!(RAANS2) W !?5,"** No mail will be sent **",$C(7)
 . Q
START ; Get data and print the report
 S:$D(ZTQUEUED) ZTREQ="@" S RAIO=$S(IO="":0,1:1),RAN=0
 ;added by patch #99
 D GETDATA
 I $G(RAP99) S RAS99=1 D PWT^RAPMW(RABDATE,RAEDATE)  ;process partial Wait and Time report
 ;
 ;D GETDATA
 I RARPT="S"!(RARPT="B") S RAPG=0 D ^RAPM1
 I RARPT="D"!(RARPT="B") S RAPG=0 D ^RAPM2
 I $G(RAP99) K RAS99 S RAL99=1 D PWT^RAPMW(RABDATE,RAEDATE)    ;process all wait and time reports
 ; see if need send email
 D SEND^RAPM2
 D EXIT
 Q
 ;
GETRPT ; Prompt for Summary or Detail or Both reports; Default = Summary Report
 W !,"Enter Report Type"
 S DIR(0)="S^S:Summary;D:Detail;B:Both"
 S DIR("A")="Select Report Type",DIR("B")="S"
 S DIR("?")="Enter Summary report OR Detail report OR Both reports"
 D ^DIR
 Q:$D(DIRUT) 
 S RARPT=Y
 Q
GETDATE ; Prompt for start and end dates
 S DIR(0)="D^:"_DT_":AEX"
 I RARPT'="D" D
 . W !!?4,"The begin date for Summary and Both must be at least 10 days before today.",!
 . S X1=DT,X2=-10 D C^%DTC S RA1=X
 . S DIR(0)="D^:"_RA1_":AEX"
 . Q
 S DIR("A")="Enter starting date"
 S DIR("?")="Enter date to begin searching from"
 D ^DIR
 Q:$D(DIRUT)
 S RABDATE=Y
 ;
 S RADD=91,X1=RABDATE,X2=RADD D C^%DTC S RAMAXDT=X
 ; put 10 day block for summary report or Both
 I RARPT'="D" D
 . W !!?4,"The ending date for Summary and Both must be at least 10 days before today.",!
 . S X1=DT,X2=-10 D C^%DTC S:X<RAMAXDT RAMAXDT=X
 S:RAMAXDT>DT RAMAXDT=DT
 S DIR(0)="D^"_RABDATE_":"_RAMAXDT_":AE"
 S DIR("A")="Enter ending date"
 S DIR("?",1)="     +91 days max. for Summary and Detail."
 S DIR("?",2)="     And the ending date for the Summary and Both"
 S DIR("?")="     must be at least 10 days before today."
 D ^DIR
 Q:$D(DIRUT)
 ;
 ; Set end date to end of day
 ; RABDATE and RAEDATE are original values
 ; RABEGDT and RAENDDT are used in GETDATA 
 S RAEDATE=Y,RAENDDT=RAEDATE_.9999
 ; Set start date back to include current day
 S RABEGDT=(RABDATE-1)_.9999
 Q
SORT ; Prompt for Sorted by
 W !!,"Sort report by"
 S DIR(0)="S^C:Case Number;E:Category of Exam;I:Imaging Type;P:Patient Name;R:Radiologist;T:Hrs to Transcrip.;V:Hrs to Verif."
 S DIR("A")="Select Sorted by",DIR("B")="C"
 D ^DIR
 Q:$D(DIRUT)
 S RASORT=Y
 S DIR(0)="N^0:240"
 S DIR("A")="Print PENDING and "_$S(RASORT="V":"Verif.",1:"Transrip.")_" hours greater than or equal to"
 S DIR("B")="72"
 S DIR("?")="Enter minimum number of hours elapsed since registration."
 D ^DIR Q:$D(DIRUT)  S RASINCE=Y
 Q
DEV ; Device
 I $D(DIRUT) D EXIT Q
 W:RARPT="B" !!,"Specify device for both summary and detail reports."
 D TASK
 D ZIS^RAUTL
 Q
TASK ; set vars for taskman
 S ZTRTN="START^RAPM"
 S ZTSAVE("RA*")=""
 S ZTSAVE("^TMP($J,")=""
 ;S ZTSAVE("^TMP($J,""RA D-TYPE"",")=""
 ;S ZTSAVE("^TMP($J,""RA I-TYPE"",")=""
 S:$G(RAP99) ZTDESC="Radiology Timeliness Performance Reports"
 S:'$G(RAP99) ZTDESC="Radiology Verification Timeliness Report"
 Q
 ;
GETDATA ; Get all the data
 ; Order thru Exam Date (RADTE)
 S RADTE=RABEGDT F  S RADTE=$O(^RADPT("AR",RADTE)) Q:'RADTE  Q:(RADTE>RAENDDT)  D
 . S RADFN="" F  S RADFN=$O(^RADPT("AR",RADTE,RADFN)) Q:'RADFN  D
 . . ; Get patient name
 . . S RAPATNM=$$GET1^DIQ(2,RADFN,.01) S:RAPATNM="" RAPATNM=" "
 . . ; Order thru inverse Exam Date (RADTI)
 . . S RADTI="" F  S RADTI=$O(^RADPT("AR",RADTE,RADFN,RADTI)) Q:'RADTI  D CHECK
 . . Q
 . Q
 Q
CHECK ; Check type of image
 Q:'$D(^RADPT(RADFN,"DT",RADTI))  ;no exam data at all
 S RAITYP=$P($G(^RADPT(RADFN,"DT",RADTI,0)),U,2)
 S RAIMGTYP=$P($G(^RA(79.2,+RAITYP,0)),U,1)
 ; quit if img typ is known AND does not match selection
 I RAIMGTYP'="",'$D(^TMP($J,"RA I-TYPE",RAIMGTYP)) Q
 I RAIMGTYP="" S RAIMGTYP="(unknown)"
 ;
 ; Check division - Quit if no division selected
 S RASELDIV=$P($G(^RADPT(RADFN,"DT",RADTI,0)),U,3)
 S RACHKDIV=$P($G(^DIC(4,+RASELDIV,0)),U,1)
 ; quit if div is known AND does not match selection 
 I RACHKDIV'="",'$D(^TMP($J,"RA D-TYPE",RACHKDIV)) Q
 S:RACHKDIV="" RANODIV=1
 ;
 ; Get exam related data
 S RACNI=0 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:'RACNI  D
 . S (RACN0,RAEXST,RANUM,RACN,RAPRIM,RAPRIMNM,RACAT,RARPTTXT)=""
 . S (RARPTDT,RAVERDT,RARPTST,RADHT,RADHV,RATDFHR,RAVDFHR)=""
 . ; Get 0 node (RACN0) of ^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)
 . S RACN0=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 . Q:RACN0=""  ; no exam data
 . ; Get Case number: Exam Date - Case Number
 . S RACN=$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_$P(RACN0,U,1)
 . ; Get exam status
 . S RAEXST=$P(RACN0,U,3)
 . Q:RAEXST=""  ; no exam status
 . ; Quit if exam's CREDIT METHOD is 2 = no credit
 . Q:$P(RACN0,U,26)=2
 . ; Quit if exam status is "Cancelled"
 . I $P(^RA(72,RAEXST,0),U,3)=0 Q
 . ; Get number of set - '1' separate; '2' for combined report.
 . S RANUM=$P(RACN0,U,25)
 . ; if member of set > 1 then set RACNI to 99999 to skip remaining cases
 . I RANUM>1 S RACNI=99999
 . ; Get Radiologist (Primary Interpreting Staff) internal # and name. 
 . S RAPRIM=$P(RACN0,U,15)
 . ; if specific radiologist requested, quit if not his/her case
 . I RARAD,RAPRIM'=RARAD Q
 . S RAPRIMNM=$$GET1^DIQ(200,RAPRIM,.01) S:RAPRIMNM="" RAPRIMNM=" "
 . ; Get Category of Exam
 . S RACAT=$P(RACN0,U,4)
 . ; Get Procedure Name
 . S RAPRCN=$P($G(^RAMIS(71,+$P(RACN0,U,2),0)),U)
 . ; Get IEN of imaging report
 . S RARPTTXT=$P(RACN0,U,17)
 . ; Pending if no imaging report OR report doesn't exist in the Report
 . ; file (#74) OR Stub report
 . S RAHASR=0 ;=1 has real report
 . I $D(^RARPT(+RARPTTXT,0)),'$$STUB^RAEDCN1(+RARPTTXT) S RAHASR=1
 . I 'RAHASR D
 . . S ^TMP($J,"RAPM","TR",0)=$G(^TMP($J,"RAPM","TR",0))+1
 . . S ^TMP($J,"RAPM","VR",0)=$G(^TMP($J,"RAPM","VR",0))+1
 . ; Get report info. if real report exists.
 . I RAHASR D RPTINFO^RAPM1
 . D STORE^RAPM2
 . ; Calculate the total number of reports
 . S ^TMP($J,"RAPM","TOTAL")=$G(^TMP($J,"RAPM","TOTAL"))+1
 Q
EXIT ; Exit
 ; Close device
 D CLOSE^RAUTL
 K RACN0,RAEXST,RANUM,RACN,RAPRIM,RAPRIMNM,RACAT,RARPTTXT,RAANS,RATXT
 K DIR,DIRUT,RABDATE,RAEDATE,RARPT,DTDIFF,RABEGDT,RAENDDT,RAITYP,RAIMGTYP,RATYP
 K ZTRTN,ZTSAVE,ZTDESC,RAPG,RASELDIV,RACHKDIV,RACNO,RAVHRS
 K RADIV,RAN,RAIMG,RAREC1,RATOTCNT,RACNI,RADFN,RADTE,RADTI,RAHD,RAPATNM
 K RAPOP,RAPSTX,RAQUIT,RAREC,RARPTDT,RARPTST,RASORT,RASRT,RATDFHR,RAHASR
 K RATDFSEC,RATHRS,RAVDFHR,RAVDFSEC,RAVERDT,RAMES,RALINE,RAMAXDT,RADD
 K RAANS2,RAIOM,RAHDR,RANODIV,RASINCE,RADHT,RADHV,RAVAL,RAPRCN
 K RAXIT,RAIO,RALDENT,RALMAX,RALUSED,RATAIL,RAS99,RAL99,RAP99,RAN
 K ^TMP($J)
 Q
