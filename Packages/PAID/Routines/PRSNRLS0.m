PRSNRLS0 ;WOIFO/KJS - All Activity at a Nursing Location - Summary and Detailed;12-8-2011
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
COORD ;Entry point for VANOD Coordinator
 ; Coordinator has no access limits so let them pick any group
 N GROUP
 D PIKGROUP^PRSNUT04(.GROUP,"N",1)
 ; quit if any error during group selection
 I $P($G(GROUP(0)),U,2)="E" D  Q
 .W !,$P(GROUP(0),U,3)
 D MAIN
 ;
 Q
 ;
MAIN ;
 N RANGE,BEG,END,EXTBEG,EXTEND,STOP
 N DAYBEG,DAYEND
 N TYPE,BEG,END
 S STOP=0
 D TYPE
 Q:STOP
 D DATE
 Q:STOP
 D QUE
 Q
 ;
REPORT ;for group of location
 ;
 N PRSIEN,PRSNG,PICK,PG,LOCIEN,PRSNVER,PRSNTS,PRSNDAY,PPIEN,ENDPP,ENDDAY,BEGPP,BEGDAY,TODAY,PG,TIMEREC
 N PRSNAME,PRSNSSN,PRSNTL,SKILMIX,PRSL,PRSNDAYS,PRSNDATE
 N PRSNST,PRSNSP,PRSNTT,PRSNWIEN,HOURS,PRSNTIEN
 N PRSNTW,PRSNTWD,PRSNM,PRSNRE,PRSNREC,PRSNRIEN,MEAL
 N PRSNLNG,IEN200,PRIMLOC,PRSNARY,LOCNAM,GHD,PRSD
 K ^TMP($J,"PRSNR")
 U IO
 S PG=0,TODAY=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 S BEGPP=$G(^PRST(458,"AD",BEG)),BEGDAY=$P(BEGPP,U,2),BEGPP=+BEGPP
 S ENDPP=$G(^PRST(458,"AD",END)),ENDDAY=$P(ENDPP,U,2),ENDPP=+ENDPP
 I TYPE="S" D HDRSUM
 I TYPE="D" D HDRDET
 S (PICK,STOP)=0
 F  S PICK=$O(GROUP(PICK)) Q:PICK=""!STOP  D
 . S PRSNG=GROUP(0)_"^"_PICK_"^"_GROUP(PICK)
 . S LOCIEN=+GROUP(PICK)
 . S LOCNAM=$P($$ISACTIVE^PRSNUT01(DT,LOCIEN),U,2)
 . S GHD="Location: "_LOCNAM
 . S TAB=IOM-$L(GHD)/2-5
 . W !!,?TAB,GHD,!
 . W ?TAB F I=1:1:$L(GHD) W "-"
 . ;SORT BY NAME FOR THIS LOCATION
 . K ^TMP($J,"PRSNR")
 . S PRSIEN=0
 . F  S PRSIEN=$O(^PRSN(451,"ALN",LOCIEN,PRSIEN)) Q:'PRSIEN   S PRSNA=$P($G(^PRSPC(PRSIEN,0)),U),^TMP($J,"PRSNR",PRSNA,PRSIEN)=""
 . S PRSNA=""
 . F  S PRSNA=$O(^TMP($J,"PRSNR",PRSNA)) Q:PRSNA=""!STOP  D
 .. S PRSIEN=0
 .. F  S PRSIEN=$O(^TMP($J,"PRSNR",PRSNA,PRSIEN)) Q:PRSIEN=""!STOP  D
 ... N WKTOT
 ... D INFO
 ... S PPIEN=BEGPP-1
 ... F  S PPIEN=$O(^PRSN(451,"ALN",LOCIEN,PRSIEN,PPIEN)) Q:'PPIEN!STOP!(PPIEN>ENDPP)  D
 .... S PRSNDAYS=$G(^PRST(458,PPIEN,1))
 .... S PRSNDAY=$S(PPIEN=BEGPP:BEGDAY-1,1:0)
 .... F  S PRSNDAY=$O(^PRSN(451,"ALN",LOCIEN,PRSIEN,PPIEN,PRSNDAY)) Q:'PRSNDAY!STOP!(PPIEN=ENDPP&(PRSNDAY>ENDDAY))  D
 ..... S PRSNDATE=$P(PRSNDAYS,U,PRSNDAY),PRSNDATE=$E(PRSNDATE,4,5)_"/"_$E(PRSNDATE,6,7)_"/"_$E(PRSNDATE,2,3)
 ..... S PRSNVER=$O(^PRSN(451,"ALN",LOCIEN,PRSIEN,PPIEN,PRSNDAY,""),-1)
 ..... S PRSNTS=0,PRSD=1
 ..... F  S PRSNTS=$O(^PRSN(451,"ALN",LOCIEN,PRSIEN,PPIEN,PRSNDAY,PRSNVER,PRSNTS)) Q:'PRSNTS!STOP  D
 ...... S TIMEREC=$G(^PRSN(451,PPIEN,"E",PRSIEN,"D",PRSNDAY,"V",PRSNVER,"T",PRSNTS,0))
 ...... D DATA
 ...... I TYPE="S" D TOTTIME
 ...... I TYPE="D" D PRTDET
 ...Q:STOP
 ... I TYPE="S" D PRTSUM
 W !!,"End of Report"
 D ^%ZISC
 K ^TMP($J,"PRSNR")
 Q
 ;
INFO ;Find nurse information to display in report
 ;
 S PRSL=1
 S PRSNARY=$G(^PRSPC(PRSIEN,0))
 S PRSNAME=$P(PRSNARY,U)              ;Nurse Name
 S PRSNSSN=$P(PRSNARY,U,9)           ;Nurse SSN
 S PRSNTL=$P(PRSNARY,U,8)             ;Nurse T&L
 S SKILMIX=$P($$ISNURSE^PRSNUT01(PRSIEN),U,2) ;  Nurse skillmix
 I SKILMIX["ADMINISTRATIVE" S SKILMIX="ADMIN RN"
 S IEN200=$G(^PRSPC(PRSIEN,200))
 S PRIMLOC=$S(IEN200="":"",1:$$PRIMLOC^PRSNUT03(IEN200))
 Q
 ;
DATA ;Extract display data from POCD array
 ;
 ;Start Time
 S PRSNST=$P(TIMEREC,U)
 ;
 ;Stop Time 
 S PRSNSP=$P(TIMEREC,U,2)
 ;
 ;Meal Time
 S MEAL=$P(TIMEREC,U,3)
 ;
 ;Get hours worked in a given location
 S HOURS=$$AMT^PRSPSAPU(PRSNST,PRSNSP,MEAL)
 ;
 ;Type of Time code IEN
 S PRSNTT=$P(TIMEREC,U,4),PRSNLNG=" "
 I PRSNTT'="" D
 . ;
 . ;Type of Time code
 . S PRSNTIEN=$O(^PRST(457.3,"B",PRSNTT,0))
 . Q:PRSNTIEN=""
 . ;
 . ;Description for Type of Time code
 . S PRSNLNG=$P(^PRST(457.3,PRSNTIEN,0),U,2)
 . ;
 . ;Type of Work Code IEN
 S PRSNWIEN=$P(TIMEREC,U,6),PRSNTW=" ",PRSNTWD=" "
 I PRSNWIEN'="" D
 . ;
 . ;Type of Work Code
 . S PRSNTW=$P(^PRSN(451.5,PRSNWIEN,0),U)
 . ;
 . ;Description for Type of Work code
 . S PRSNTWD=$P(^PRSN(451.5,PRSNWIEN,0),U,2)
 ;
 ;OT Mandatory/Voluntary
 S PRSNM=$P(TIMEREC,U,7)
 Q
 ;
TOTTIME ;
 ; save hours into work array
 S WKTOT(PRSNLNG,PRSNTWD)=$G(WKTOT(PRSNLNG,PRSNTWD))+HOURS
 ;
 Q
 ;
HDRSUM ;Display header for report of Individual Nurse Activity
 ;
 W @IOF
 S PG=PG+1,PRSL=1
 W ?20,"All Activity at a Nurse Location Summary Report"
 W !,?15,EXTBEG_" - "_EXTEND,?45,"Run Date: ",TODAY,?70,"Page: ",$J(PG,3)
 W !         ;blank line
 W !,"Nurse Name",?21,"Type of",?32,"Type of",?48,"Primary Location",?68,"# of",?75,"T&L"
 W !,"Skill Mix",?22,"Time",?33,"Work",?68,"Hours",?75,"Unit"
 W !,"--------------------------------------------------------------------------------"
 ;
 Q
 ;
PRTSUM ;  Loop through Totals array and print each one
 ;
 N TT,TWD,HOURS,CNT
 S TT="",CNT=0
 F  S TT=$O(WKTOT(TT)) Q:TT=""!STOP  D
 . S TWD=""
 . F  S TWD=$O(WKTOT(TT,TWD)) Q:TWD=""!STOP  D
 .. S HOURS=$G(WKTOT(TT,TWD)),CNT=CNT+1
 .. D PPP
 ; need a blank line between nurses when there was only one record printed
 I CNT=1 W !
 Q
 ;
PPP ;
 I PRSL W !,$E(PRSNAME,1,19)
 W ?21,TT,?32,$E(TWD,1,14),?48,$E($P(PRIMLOC,U,3),1,18),?66,$J(HOURS,7,2),?75,PRSNTL
 W !
 I PRSL W "  ",$E(SKILMIX,1,17)
 ;
 S PRSL=0
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDRSUM
 Q
 ;
HDRDET ;Display header for report of Individual Nurse Activity
 ;
 W @IOF
 S PG=PG+1,(PRSL,PRSD)=1
 W ?20,"All Activity at a Nurse Location Detail Report"
 W !,?15,EXTBEG_" - "_EXTEND,?45,"Run Date: ",TODAY,?70,"Page: ",$J(PG,3)
 W !              ;blank line
 W !,"Nurse Name",?21,"Last 4",?29,"Start/",?38,"Type of",?49,"Mand",?57,"Meal",?63,"Primary Location/"
 W !,"Skill Mix",?23,"SSN/",?29,"Stop",?39,"Time",?50,"OT",?57,"Time",?64,"Type of Work"
 W !,"Date",?23,"T&L",?29,"Time"
 W !,"--------------------------------------------------------------------------------"
 ;
 Q
 ;
PRTDET ;Print report
 I PRSL W !,$E(PRSNAME,1,19)
 ;PUT DATE ON FIRST LINE IF NAME & SKILL ARE NOT PRINTED
 I 'PRSL,PRSD W !,"  ",PRSNDATE
 W ?22,$E(PRSNSSN,6,9)
 W ?29,PRSNST
 W ?38,PRSNLNG
 W ?51,PRSNM
 W ?58,MEAL
 W ?65,$E($P(PRIMLOC,U,3),1,14)
 W !
 I PRSL W "  ",$E(SKILMIX,1,17)
 W ?22,PRSNTL
 W ?29,PRSNSP
 W ?65,$E(PRSNTWD,1,14)
 W !
 ;PUT DATE ON THIRD LINE IF NAME & SKILL ARE PRINTED
 I PRSL,PRSD W "  ",PRSNDATE,!
 S (PRSL,PRSD)=0
 ;
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDRDET
 Q
 ;
TYPE ;Choose summary or detailed group activity report
 ;
 N DIR,DIRUT,X,Y
 S DIR(0)="S^S:Summary Report;D:Detailed Report"
 S DIR("A")="Enter Selection"
 S DIR("?")="Enter whether you want to select a Summary or Detailed Group Activity Report"
 D ^DIR
 I $D(DIRUT) S STOP=1 Q
 S TYPE=Y
 Q
 ;
DATE ; User is prompted for a date range 
 ;
 S RANGE=$$POCRANGE^PRSNUT01()
 ; QUIT HERE IF RANGE=0 
 I +$G(RANGE)'>0 S STOP=1
 ;
 S BEG=$P(RANGE,U)
 S END=$P(RANGE,U,2)
 S EXTBEG=$P(RANGE,U,3)
 S EXTEND=$P(RANGE,U,4)
 ;
 Q
 ;
QUE ;call to generate and display report for individual activity
 N %ZIS,POP,IOP
 S %ZIS="MQ"
 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D
 . K IO("Q")
 . N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC
 . S ZTDESC="All Activity at a Nurse Location "_$S(TYPE="S":"Summary",1:"Detail")
 . S ZTRTN="REPORT^PRSNRLS0"
 . S ZTSAVE("GROUP")=""
 . S ZTSAVE("GROUP(")=""
 . S ZTSAVE("TYPE")=""
 . S ZTSAVE("BEG")=""
 . S ZTSAVE("END")=""
 . S ZTSAVE("EXTBEG")=""
 . S ZTSAVE("EXTEND")=""
 . D ^%ZTLOAD
 . I $D(ZTSK) S ZTREQ="@" W !,"Request "_ZTSK_" queued."
 E  D
 . D REPORT
 Q
