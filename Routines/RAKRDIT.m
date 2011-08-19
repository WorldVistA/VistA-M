RAKRDIT ;Hines OI/GJC-pass exam info within a date range, to PCE
 ;;5.0;Radiology/Nuclear Medicine;**31**;Mar 16, 1998
 Q
EN1 ;DBIA 3445 read from file 42
 ;Supported entry point used to credit examinations that have failed
 ;to be credited in the past.  The user will be asked to supply the
 ;following required information:
 ;* Imaging Location (active, receives regular credit, & has a DSS ID)
 ;* Date Range
 ;
 ;From this, we look at the exam records and determine if the exam
 ;has been credited and whether or not the patients are outpatients.
 ;
 ;The software needs to check if these exams are single exams or
 ;exam-sets (linked to a single report, known as a print-set, or
 ;linked to unique reports) and send to PCE only those exams that
 ;have an Exam Status of 'Complete'.
 ;
 ;Intergration Agreements (IAs) used within this software
 ;#3445-$$GET1^DIQ(42,ien_file_42,.03,"I") ;the SERVICE of the ward
 ;
IMGLOC W !!,?2,"Select an Imaging Location from the IMAGING LOCATIONS (#79.1)"
 W !?2,"file that is active, receives regular credit, and has a valid"
 W !?2,"DSS ID.",!
 K DIC S RATDY=$$DT^XLFDT(),DIC="^RA(79.1,"
 S DIC("S")="N RAI S RAI=$G(^(0)) I '$P(RAI,""^"",19),($P(RAI,""^"",21)=0),($P(RAI,""^"",22)]"""")"
 S DIC("A")="Enter the Imaging Location that you wish to credit: "
 S DIC(0)="QEANZ" D ^DIC K DIC
 I Y=-1 D  D KILL Q
 .W !!?2,$C(7),"Imaging Location selection invalid, exiting."
 .Q
 S RAILOC=Y_"^"_Y(0,0) ;ien file 79.1^ien file 44^.01 value file 44
 ;
DATE1 K DIR S DIR(0)="D^2110101:"_RATDY_":EA"
 S DIR("?",1)="Enter the date to begin searching for exams that have not been credited."
 S DIR("A")="Enter the starting date: ",DIR("?")="Time is not allowed."
 D ^DIR K DIR
 I $D(DIRUT) D  D KILL Q
 .W !!?2,$C(7),"Starting date not selected, exiting."
 .Q
 S (RASTRT,RADTE)=Y
 ;
DATE2 K DIR S DIR(0)="D^"_RASTRT_":"_RATDY_":EA"
 S DIR("A")="Enter the ending date: "
 S DIR("?",1)="Enter the date to end the search for exams that have not been credited."
 S DIR("?")="Dates cannot preceed: "_$$FMTE^XLFDT(RASTRT,"1P")_"; time is not allowed."
 D ^DIR K DIR
 I $D(DIRUT) D  D KILL Q
 .W !!?2,$C(7),"Ending date not selected, exiting."
 .Q
 S RAEND=$$FMADD^XLFDT(Y,0,24,0,0) ;to include all data, set to midnight
 ;
 S ZTIO="",ZTRTN="QUEUED^RAKRDIT",ZTDESC="Rad/Nuc Med attempt to credit exams for a specific imaging location and date range"
 F I="RAEND","RADTE","RASTRT","RAILOC" S ZTSAVE(I)=""
 W ! D ^%ZTLOAD
 I $D(ZTSK) D
 .W !!?2,"Request queued: "_ZTSK_" @ "_$$HTE^XLFDT($G(ZTSK("D"),"error"))
 .Q
 K ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK D KILL
 Q
 ;
QUEUED ;begin checking for uncredited exams...
 S:$G(U)'="^" U="^" S:$D(ZTQUEUED) ZTREQ="@" S RAXIT=0
EXAMS F  S RADTE=$O(^RADPT("AR",RADTE)) Q:RADTE'>0!(RADTE>RAEND)  D
 .;^RADPT("AR",date/time of exam,patient dfn,inverse exam date/time)=""
 .S RADFN=0
 .F  S RADFN=$O(^RADPT("AR",RADTE,RADFN)) Q:RADFN'>0  D  Q:RAXIT
 ..S RADTI=0
 ..F  S RADTI=$O(^RADPT("AR",RADTE,RADFN,RADTI)) Q:RADTI'>0  D  Q:RAXIT
 ...S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0)),RAXSET=0
 ...Q:$P(RAY2,"^",4)'=+RAILOC  ;not the specified I-Loc
 ...S RACNI=0
 ...;check the exam to see if it is part of an exam set.  If it is,
 ...;the call to RAPCE performs checking logic on all the descendents.
 ...I $P(RAY2,"^",5) S RAXSET=1 D  Q  ;we have an exam set...
 ....S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0
 ....S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 ....Q:+$$EN1^RASETU($P(RAY3,U,11),RADFN)'=9  ; check all descendents
 ....;for a minimum order number of nine (9).  This indicates that all
 ....;descendents are in the COMPLETE examination status.  Status info
 ....;about exam set passed back from EN1^RASETU in the following
 ....;format: min status_"^"_max status_"^"_$S(All_Statuses=0:1,1:0)
 ....Q:$$ELIG(RAY3)  ;must be an outpatient
 ....D COMPLETE^RAPCE(RADFN,RADTI,RACNI)
 ....D XAMSET(RADFN,RADTI) ;CREDIT METHOD of Reg. Credit on descendents
 ....I $$S^%ZTLOAD() S (RAXIT,ZTSTOP)=1
 ....Q
 ...;we do not have an exam set, proceed as usual...
 ...F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0  D  Q:RAXIT
 ....S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 ....Q:$$ELIG(RAY3)  ;must be an outpatient
 ....D COMPLETE^RAPCE(RADFN,RADTI,RACNI)
 ....D:$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),U,24)="Y" CREDITM(RADFN,RADTI,RACNI) ;update CREDIT METHOD fld from No Credit to Regular Credit
 ....I $$S^%ZTLOAD() S (RAXIT,ZTSTOP)=1
 ....Q
 ...I $$S^%ZTLOAD() S (RAXIT,ZTSTOP)=1
 ...Q
 ..I $$S^%ZTLOAD() S (RAXIT,ZTSTOP)=1
 ..Q
 .I $$S^%ZTLOAD() S (RAXIT,ZTSTOP)=1
 .Q
 Q
KILL ; kill local variables, clean up partition
 K DIC,DIRUT,DTOUT,DUOUT,I,RADFN,RADTE,RADTI,RAEND,RAILOC,RASTRT,RATDY
 K RAXIT,RAXSET,RAY2,RAY3,X,Y
 Q
ELIG(RAY3) ;Is this record eligible to be credited?  If so, the CLINIC
 ;STOP RECORDED? (#23) cannot be set to yes, the patient must not be
 ;located on a ward (outpatient), & the exam must be in a complete
 ;status (order_number = 9)
 ;Input: RAY3 set to - ^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)
 I 'RAXSET,($P($G(^RA(72,+$P(RAY3,"^",3),0)),U,3)='9) Q 1 ;check single
 ;exam records for an order number of nine (9).  This means the exam is
 ;in a status of COMPLETE.  Note: the order numbers of the descendent
 ;exams within an exam-set is checked with $$EN1^RASETU...
 Q:$P(RAY3,"^",24)="Y" 1 ;clinic stop credited, skip this exam
 I $P(RAY3,"^",6)]"",($$GET1^DIQ(42,$P(RAY3,"^",6),.03,"I")'="D") Q 1
 ;Note: if a ward, then it must have a SERVICE of DOMICILIARY to be
 ;consider an outpatient
 Q 0
 ;
CREDITM(RADFN,RADTI,RACNI) ;Change the CREDIT METHOD (DD: 70.03, fld: 26)
 ;from "No Credit" (2) to "Regular Credit" (0)
 ;Note: Crediting was skipped because the Imaging Location (I-Loc) was
 ;marked as 'NO CREDIT'.  To credit at this time, the I-Loc must have
 ;CREDIT METHOD set to 'REGULAR CREDIT'.  All exam records must be
 ;updated accordingly.
 ;Input=RADFN: patient dfn, RADTI: inv. exam date/time, RACNI: case ien
 N RAFDA S RAFDA(70.03,RACNI_","_RADTI_","_RADFN_",",26)=0 ; zero
 D FILE^DIE("K","RAFDA")
 Q
 ;
XAMSET(RADFN,RADTI) ; change CREDIT METHOD from No Credit to Regular Credit
 ;Input=RADFN: patient dfn, RADTI: inv. exam date/time
 N RACNI S RACNI=0
 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0  D
 .D:$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),U,24)="Y" CREDITM(RADFN,RADTI,RACNI) ;update CREDIT METHOD fld from No Credit to Regular Credit
 Q
