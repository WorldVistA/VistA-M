RARTUVR ;HISC/FPT,SWM AISC/RMO-Unverified Reports ;8/19/97  11:01
 ;;5.0;Radiology/Nuclear Medicine;**29,56**;Mar 16, 1998;Build 3
 ;
 ; This routine displays the total number of reports that have a status
 ; other than V(erify) and the report is linked to a Resident, Staff or
 ; unknown physician. It builds the report by using the 'ASTAT' cross
 ; reference on File 74. It displays the report by division and imaging
 ; type. Within division/imaging type, it displays the number of reports
 ; by category (Resident and Staff). It displays the number of unverified
 ; reports by Interpreting Physician within a category.
 ; The routine checks the PRIMARY INTERPRETING RESIDENT and PRIMARY
 ; INTERPRETING STAFF fields (File 70) associated with a report.
 ; If a primary Resident is associated with the report, then the report
 ; is counted towards that Resident.
 ; If a primary Staff physician is associated with the report, then the
 ; report is counted towards that Interpreting Staff.
 ; If neither of the above are true the report is counted toward unknown.
 ;
EN ; unverified reports report
 K ^TMP($J)
 I '$D(^RARPT("ASTAT")) W !!,*7,?5,"There are no Unverified Reports." Q
 ;
 ; Select Imaging Type, if exists
 I $O(RACCESS(DUZ,""))="" D SETVARS^RAPSET1(0) S RAPSTX=""
 S RAXIT=$$SETUPDI^RAUTL7() I RAXIT K RAXIT Q
 S X=$$DIVLOC^RAUTL7() I X D KILL Q
 S RACNT=0,X="" F  S X=$O(RACCESS(DUZ,"DIV-IMG",X)) Q:X']""  D
 . Q:'$D(^TMP($J,"RA D-TYPE",X))  S Y=""
 . F  S Y=$O(RACCESS(DUZ,"DIV-IMG",X,Y)) Q:Y']""  D
 .. S:$D(^TMP($J,"RA I-TYPE",Y)) ^TMP($J,"RAUVR",X,Y)=0,RACNT=RACNT+1
 .. Q
 . Q
 W !
ASKBD K DIR S DIR("B")="b"
 S DIR("?",1)="Enter 'b' for a brief format, 'd' for a detailed format, "
 S DIR("?",2)="'e' for a format sorted by exam date, 's' for a format"
 S DIR("?",3)="sorted by Primary Interpreting Staff."
 S DIR("?")="This is mandatory."
 S DIR(0)="S^b:Brief;d:Detailed;e:Exam Date, Itemized List;s:Staff, Itemized List"
 D ^DIR G:$D(DIRUT) KILL
 S RABD=$$UP^XLFSTR(Y) K DIR,DIROUT,DIRUT,DUOUT,DTOUT
 I RABD="S"!(RABD="E") D
 . W ! D 132^RAMAINP S RAFILE="EXAM REGISTERED"
 . Q
 E  S RAFILE="REPORT ENTERED"
 ;
ASKTHRU S RASKTIME=1 W !!,"(The date range refers to DATE "_RAFILE_")"
 D DATE^RAUTL K RAFILE,RASKTIME ;allow time of day input
 G:X="^" KILL G:'$D(ENDDATE)!('$D(BEGDATE)) KILL
 S:$L(ENDDATE)=7 ENDDATE=ENDDATE_".2359"
 G:"^E^S^"[("^"_RABD_"^") DEVICE ; skip date/time cut-off
 ;
ASKCUT S RACUT(1)=24,RACUT(2)=48,RACUT(3)=96
 W !!,"Default cut-off limits (in hours) for aging of reports are :"
 W !!?35 F RA1=1:1:3 W RACUT(RA1),"   "
 K DIR S DIR("A")="Do you want to enter different cut-off limits",DIR("B")="N",DIR("?")="Enter  Y  only if you want to change the above limits",DIR("??")="This is optional",DIR(0)="Y"
 W ! D ^DIR K DIR G:X="^" KILL G:+Y<1 DEVICE
 S DIR("?")="Enter number of hours as the cut-off limit"
 F RA1=1:1:3 S DIR(0)="N^"_$S(RA1=1:0,1:RACUT(RA1-1))_":87660",DIR("A")="Enter the "_$S(RA1=1:"first",RA1=2:"second",1:"third")_" cutoff hours" D ^DIR Q:+Y<1  S RACUT(RA1)=Y
 K DIR I +Y<1 W !!,"Try again " G ASKCUT
 ;
DEVICE ; select device
 S ZTRTN="START^RARTUVR",ZTSAVE("^TMP($J,""RA D-TYPE"",")="",ZTSAVE("^TMP($J,""RA I-TYPE"",")="",ZTSAVE("^TMP($J,""RAUVR"",")="",ZTSAVE("RACNT")="",ZTSAVE("BEGDATE")="",ZTSAVE("ENDDATE")="",ZTSAVE("RACUT*")="",ZTSAVE("RABD")=""
 W ! D ZIS^RAUTL I RAPOP D KILL Q
START ; start processing
 U IO S:$D(ZTQUEUED) ZTREQ="@"
 I "^E^S^"[("^"_RABD_"^") D EN1^RARTUVR3 D KILL Q
 S RADIVNME=""
 F  S RADIVNME=$O(^TMP($J,"RAUVR",RADIVNME)) Q:RADIVNME']""  S RAITNAME="" F  S RAITNAME=$O(^TMP($J,"RAUVR",RADIVNME,RAITNAME)) Q:RAITNAME']""  D
 . S ^TMP($J,RADIVNME,RAITNAME,"RESCNT")=0
 . S ^TMP($J,RADIVNME,RAITNAME,"STFCNT")=0
 . S ^TMP($J,RADIVNME,RAITNAME,"UNKCNT")=0
 . Q
 ;
 ;
 S RASTATUS="",RAOUT=0
 F  S RASTATUS=$O(^RARPT("ASTAT",RASTATUS)) Q:RASTATUS=""!(RAOUT)  D
 . S RARPT=0,RAOUT=0
 . F  S RARPT=$O(^RARPT("ASTAT",RASTATUS,RARPT)) Q:RARPT'>0!(RAOUT)  D
 ..;use Report Status to exclude, as Verf'd rpt may have leftover "ASTAT"
 ..;exclude Verified, Deleted, and Electronically Filed reports
 .. Q:"^V^X^EF^"[("^"_$P($G(^RARPT(RARPT,0)),U,5)_"^")
 .. S RARPTENT=$P($G(^RARPT(RARPT,0)),U,6)
 .. Q:RARPTENT<BEGDATE!(RARPTENT>ENDDATE)
 .. I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAOUT=1 Q:RAOUT=1
 .. S Y=RARPT D RASET^RAUTL2 Q:'Y  S RAX=Y
 .. S RAPRES=$P(RAX,"^",12),RAPSTF=$P(RAX,"^",15)
 .. ; Check if Staff & Resident the same, if so, use Staff only
 .. I (RAPSTF>0),(RAPRES=RAPSTF) S RAPRES=""
 .. S RAIP=""
 .. S:RAPRES>0 RAIP=RAIP_"R"
 .. S:RAPSTF>0 RAIP=RAIP_"S"
 .. S:RAIP="" RAIP="U"
 .. D BTG^RARTUVR1
 .. Q
 . Q
DIV ; walk through tmp global, start with 'division'
 S (RACNT(0),RAOUT,RAPAGE)=0,RADIVNME=""
 S X="NOW",%DT="T" D ^%DT K %DT D D^RAUTL S RARUNDAT=Y
 S $P(RADASH,"-",IOM)="",$P(RAEQUAL,"=",IOM+1)=""
 F  S RADIVNME=$O(^TMP($J,"RAUVR",RADIVNME)) Q:RADIVNME=""!(RAOUT)  D IT Q:RAOUT  D DIVSUM^RARTUVR1 Q:RAOUT
KILL ; kill variables & close device
 K ^TMP($J),POP,RAPOP,RACN,RACNI,RACNT,RAD,RADATE,RADFN,RADIVNME,RADIVNUM,RADTI,RADTE,RAFL,RAFLG,RAIP,RAIPNAME,RAITNAME,RAITNUM,RAOUT,RAPAGE,RAQUIT,RAPRES,RAPSTF,RARAD,RARE,RARPT,RARS,RASTATUS,RASTRING,RAX,RAXIT,X,Y,ZTQUEUED,ZTSTOP
 K RA1,RA2,RA3,RA4,RABD,RACUT,RADASH,RAEQUAL,RAHOURS,RARPTENT,RARUNDAT,RASSN
 K:$D(RAPSTX) RACCESS,RAPSTX
 K BEGDATE,DIR,DIRUT,DUOUT,ENDDATE,I,RAMES,ZTDESC,ZTRTN,ZTSAVE
 D CLOSE^RAUTL
 Q
IT ; imaging type
 S RAITNAME=""
 F  S RAITNAME=$O(^TMP($J,"RAUVR",RADIVNME,RAITNAME)) Q:RAITNAME=""!(RAOUT)  D PRINT^RARTUVR2 Q:RAOUT
 Q
 ;
