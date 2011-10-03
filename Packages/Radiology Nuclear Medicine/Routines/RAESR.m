RAESR ;HISC/GJC AISC/RMO-Exam Statistics Rpt ;1/20/95  09:03
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ; Zero out data globals!
 S A="" F  S A=$O(RACCESS(DUZ,"DIV-IMG",A)) Q:A']""  D
 . Q:'$D(^TMP($J,"RA D-TYPE",A))
 . S ^TMP($J,"RASTAT","RADIV",A)=0,B=""
 . F  S B=$O(RACCESS(DUZ,"DIV-IMG",A,B)) Q:B']""  D
 .. Q:'$D(^TMP($J,"RA I-TYPE",B))
 .. S ^TMP($J,"RASTAT","RAIMG",A,B)=0
 .. Q
 . Q
 K RACCESS(DUZ,"DIV-IMG") S ZTRTN="START^RAESR"
 F I="BEGDTX","ENDDTX","BEGDATE","ENDDATE","RARPT","RATMEFRM","^TMP($J,""RA D-TYPE"",","^TMP($J,""RA I-TYPE"",","^TMP($J,""RASTAT""," S ZTSAVE(I)=""
 D DATE^RAUTL G:RAPOP PURGE^RAESR2
 S BEGDTX=$$FMTE^XLFDT(BEGDATE,1),ENDDTX=$$FMTE^XLFDT(ENDDATE,1)
 S RATMEFRM="For Period: "_BEGDTX_" to "_ENDDTX_"."
DEV W ! D ZIS^RAUTL G:RAPOP PURGE^RAESR2
START ; Set-up date variables for selected date range.
 ; NOTE: RADTE is the exam reg date/time, and RADTI is the
 ; internal date number
 U IO S RABEG=BEGDATE-.0001,RAEND=ENDDATE+.9999
 S RACNB=6,RADU="C:CONTRACT;E:EMPLOYEE;I:INPATIENT;O:OUTPATIENT;R:RESEARCH;S:SHARING;"
 F RADTE=RABEG:0 S RADTE=$O(^RADPT("AR",RADTE)) Q:'RADTE!(RADTE>RAEND)  S RADTI=9999999.9999-RADTE S RADAT=$P(RADTE,".") D RADFN
 G ^RAESR1 ; generate report
RADFN ; Set RADFN the internal file number in the patient file, and check if
 ; an Exam was registered on the specified date, RADTE
 ; if so set RADO to the value of the Exam Registration node(Visit) via
 ; the naked reference
 F RADFN=0:0 S RADFN=$O(^RADPT("AR",RADTE,RADFN)) Q:'RADFN  I $D(^RADPT(RADFN,"DT",RADTI,0)) S RAD0=$G(^(0)) D RACNI
 Q
RACNI ; Set RACNI the internal file number for an exam, and check for all
 ; examinations performed during this patient visit
 ; ^(RACNI,0), if so, set RAP0 to the value of the Examination node via
 ; the naked reference
 S RALNM=$S('$D(^RA(79.1,+$P(RAD0,"^",4),0)):"Unknown",$D(^SC(+^(0),0)):$P(^(0),"^"),1:"Unknown")
 S RAINM=$S($D(^RA(79.2,+$P(RAD0,"^",2),0)):$P(^(0),"^"),1:"Unknown")
 S RACMP=$O(^RA(72,"AA",RAINM,9,0)) Q:'RACMP
 ; Quit if no completed status for I-Type name.
 S RADNM=$S($D(^DIC(4,+$P(RAD0,"^",3),0)):$P(^(0),"^"),1:"Unknown")
 Q:'$D(^TMP($J,"RA D-TYPE",RADNM))!('$D(^TMP($J,"RA I-TYPE",RAINM)))
 K RAFLG F RACNI=0:0 K RATMP S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:'RACNI  I $D(^(RACNI,0)),$P(^(0),"^",4)'="" S RAP0=^(0),RACTE=$P(RAP0,"^",4) D SETGLO
 Q
SETGLO ; Location Statistics
 S:'$D(^TMP($J,"RASTAT","RALOC",RADNM,RAINM,RALNM,RADAT)) ^(RADAT)="" S Y=^(RADAT) D STATS S ^TMP($J,"RASTAT","RALOC",RADNM,RAINM,RALNM,RADAT)=Y
 S:'($D(^TMP($J,"RASTAT","RALOC",RADNM,RAINM,RALNM))#2) ^(RALNM)="" S Y=^(RALNM) D STATS S ^TMP($J,"RASTAT","RALOC",RADNM,RAINM,RALNM)=Y
 ; Imaging Type statistics
 S:'$D(^TMP($J,"RASTAT","RAIMG",RADNM,RAINM,RADAT)) ^(RADAT)="" S Y=^(RADAT) D STATS S ^TMP($J,"RASTAT","RAIMG",RADNM,RAINM,RADAT)=Y
 S:'($D(^TMP($J,"RASTAT","RAIMG",RADNM,RAINM))#2) ^(RAINM)="" S Y=^(RAINM) D STATS S ^TMP($J,"RASTAT","RAIMG",RADNM,RAINM)=Y
 ; Division Statistics
 S:'$D(^TMP($J,"RASTAT","RADIV",RADNM,RADAT)) ^(RADAT)="" S Y=^(RADAT) D SET:$D(RATMP),STATS:'$D(RATMP) S ^TMP($J,"RASTAT","RADIV",RADNM,RADAT)=Y
 S:'($D(^TMP($J,"RASTAT","RADIV",RADNM))#2) ^(RADNM)="" S Y=^(RADNM) D SET:$D(RATMP),STATS:'$D(RATMP) S ^TMP($J,"RASTAT","RADIV",RADNM)=Y
 ; Total Statistics
 S:'$D(^TMP($J,"RASTAT","RATOT",RADAT)) ^(RADAT)="" S Y=^(RADAT) D SET:$D(RATMP),STATS:'$D(RATMP) S ^TMP($J,"RASTAT","RATOT",RADAT)=Y
 S:'($D(^TMP($J,"RASTAT","RATOT"))#2) ^("RATOT")="" S Y=^("RATOT") D SET:$D(RATMP),STATS:'$D(RATMP) S ^TMP($J,"RASTAT","RATOT")=Y
 Q
STATS ; Calculate statistics for # of Visits, # of Exams, # of complete
 ; Exams and Category
 S:'$D(RAFLG) RAFLG="",$P(RATMP,"^")=1 S $P(RATMP,"^",2)=1 S:$P(RAP0,"^",3)=RACMP $P(RATMP,"^",3)=1
 ; set global ^TMP for statistics including category
 F T=1:1 I RACTE=$E($P(RADU,";",T)) S $P(RATMP,"^",T+3)=1 Q
 ;
SET ; Set variable
 F I=1:1:9 S $P(Y,"^",I)=$P(Y,"^",I)+$P(RATMP,"^",I)
 Q
ASK ; Entry point from RA DAISTATS (Examination Statistics) menu
 K ^TMP($J,"RASTAT")
 I $O(RACCESS(DUZ,""))="" D SETVARS^RAPSET1(0) S RAPSTX=""
 S DIR(0)="S^L:Location;I:Imaging Type;D:Division;T:Totals Only"
 S DIR("A")="Enter Report Detail Needed",DIR("B")="Location"
 S DIR("?",1)="Enter 'L' to obtain location, imaging type, division and total statistics"
 S DIR("?",2)="Enter 'I' to obtain imaging type, division and total statistics"
 S DIR("?",3)="Enter 'D' to obtain division and total statistics"
 S DIR("?",4)="Enter 'T' to obtain total statistics only"
 S DIR("?")="Enter '^' to stop." D ^DIR K DIR
 I $D(DIRUT) K DIROUT,DIRUT,DTOUT,DUOUT,I,RAPSTX Q
 S RARPT=$S(Y="L":1,Y="I":2,Y="D":3,1:4)
 S X=$$DIVLOC^RAUTL7()
 S:'X ZTDESC="Rad/Nuc Med Examination Statistics" G:'X RAESR
 D PURGE^RAESR2
 Q
