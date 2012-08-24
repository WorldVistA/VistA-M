PRSNRLOS ;WOIFO/KJS - All Overtime at a Nursing Location - Summary and Detailed;2-2-2012
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
 N PRSNLNG,IEN200,PRIMLOC,PRSNARY,GHD,SKILTYP,TOTHRS,I
 K ^TMP($J,"PRSNR")
 U IO
 S PG=0,TODAY=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 S BEGPP=$G(^PRST(458,"AD",BEG)),BEGDAY=$P(BEGPP,U,2),BEGPP=+BEGPP
 S ENDPP=$G(^PRST(458,"AD",END)),ENDDAY=$P(ENDPP,U,2),ENDPP=+ENDPP
 S (PICK,STOP)=0
 F  S PICK=$O(GROUP(PICK)) Q:PICK=""!STOP  D
 . S PRSNG=GROUP(0)_"^"_PICK_"^"_GROUP(PICK)
 . S LOCIEN=+GROUP(PICK)
 . S PRSIEN=0
 . F  S PRSIEN=$O(^PRSN(451,"ALN",LOCIEN,PRSIEN)) Q:'PRSIEN!STOP  D
 .. D INFO
 .. S PPIEN=BEGPP-1
 .. F  S PPIEN=$O(^PRSN(451,"ALN",LOCIEN,PRSIEN,PPIEN)) Q:'PPIEN!STOP!(PPIEN>ENDPP)  D
 ... S PRSNDAYS=$G(^PRST(458,PPIEN,1))
 ... S PRSNDAY=$S(PPIEN=BEGPP:BEGDAY-1,1:0)
 ... F  S PRSNDAY=$O(^PRSN(451,"ALN",LOCIEN,PRSIEN,PPIEN,PRSNDAY)) Q:'PRSNDAY!STOP!(PPIEN=ENDPP&(PRSNDAY>ENDDAY))  D
 .... S PRSNDATE=$P(PRSNDAYS,U,PRSNDAY),PRSNDATE=$E(PRSNDATE,4,5)_"/"_$E(PRSNDATE,6,7)_"/"_$E(PRSNDATE,2,3)
 .... S PRSNVER=$O(^PRSN(451,"ALN",LOCIEN,PRSIEN,PPIEN,PRSNDAY,""),-1)
 .... S PRSNTS=0,PRSD=1
 .... F  S PRSNTS=$O(^PRSN(451,"ALN",LOCIEN,PRSIEN,PPIEN,PRSNDAY,PRSNVER,PRSNTS)) Q:'PRSNTS!STOP  D
 ..... S TIMEREC=$G(^PRSN(451,PPIEN,"E",PRSIEN,"D",PRSNDAY,"V",PRSNVER,"T",PRSNTS,0))
 ..... D DATA
 ..... ;NOT overtime so don't proceed
 ..... Q:PRSNM=""
 ..... I TYPE="S" D TOTTIM1
 ..... I TYPE="D" D TOTTIM2
 ;
 I TYPE="S" D HDRSUM1
 I TYPE="D" D HDRSUM2
 S PICK=""
 F  S PICK=$O(^TMP($J,"PRSNR",PICK)) Q:PICK=""!STOP  D
 . S GHD="Location: "_PICK
 . S TAB=IOM-$L(GHD)/2-5
 . W !!,?TAB,GHD,!
 . W ?TAB F I=1:1:$L(GHD) W "-"
 . I TYPE="S" D PRTSUM1
 . I TYPE="D" D PRTSUM2
 ;
 I STOP G EXIT
 I TYPE="S" D
 . S HOURS=$G(^TMP($J,"PRSNR")),TOTHRS=0
 . F I=1:1:3 S TOTHRS=TOTHRS+$P(HOURS,U,I)
 . W !,?2,"GRAND TOTAL:",?43,$J($P(HOURS,U,1),7,2),?53,$J($P(HOURS,U,2),7,2),?63,$J($P(HOURS,U,3),7,2),?73,$J(TOTHRS,7,2)
 ;
 I TYPE="D" D
 . S HOURS=$G(^TMP($J,"PRSNR"))
 . W !,?2,"GRAND TOTAL:",?66,$J(HOURS,7,2)
 ;
EXIT ;
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
 S SKILTYP=$S(SKILMIX["RN":1,SKILMIX["LPN":2,1:3)
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
 S PRSNRIEN=$P(TIMEREC,U,8),PRSNREC=" ",PRSNRE=" "
 I PRSNRIEN'="" D
 . ;Reason for OT code
 . S PRSNREC=$P(^PRSN(451.6,PRSNRIEN,0),U)
 . ;
 . ;Description for OT code
 . S PRSNRE=$P(^PRSN(451.6,PRSNRIEN,0),U,2)
 Q
 ;
TOTTIM1 ;
 ; save hours into work array
 S $P(^TMP($J,"PRSNR"),U,SKILTYP)=$P($G(^TMP($J,"PRSNR")),U,SKILTYP)+HOURS
 S $P(^TMP($J,"PRSNR",PICK),U,SKILTYP)=$P($G(^TMP($J,"PRSNR",PICK)),U,SKILTYP)+HOURS
 S $P(^TMP($J,"PRSNR",PICK,3,PRSNTT),U,SKILTYP)=$P($G(^TMP($J,"PRSNR",PICK,3,PRSNTT)),U,SKILTYP)+HOURS
 S $P(^TMP($J,"PRSNR",PICK,2,PRSNTT_"-"_PRSNM),U,SKILTYP)=$P($G(^TMP($J,"PRSNR",PICK,2,PRSNTT_"-"_PRSNM)),U,SKILTYP)+HOURS
 S $P(^TMP($J,"PRSNR",PICK,1,PRSNRE),U,SKILTYP)=$P($G(^TMP($J,"PRSNR",PICK,1,PRSNRE)),U,SKILTYP)+HOURS
 ;
 Q
 ;
TOTTIM2 ;
 ; save hours into work array
 S ^TMP($J,"PRSNR")=$G(^TMP($J,"PRSNR"))+HOURS
 S ^TMP($J,"PRSNR",PICK)=$G(^TMP($J,"PRSNR",PICK))+HOURS
 S ^TMP($J,"PRSNR",PICK,4,PRSNTT)=$G(^TMP($J,"PRSNR",PICK,4,PRSNTT))+HOURS
 S ^TMP($J,"PRSNR",PICK,3,PRSNTT_"-"_PRSNM)=$G(^TMP($J,"PRSNR",PICK,3,PRSNTT_"-"_PRSNM))+HOURS
 S ^TMP($J,"PRSNR",PICK,2,PRSNTT_"-"_PRSNM_"-"_PRSNREC)=$G(^TMP($J,"PRSNR",PICK,2,PRSNTT_"-"_PRSNM_"-"_PRSNREC))+HOURS
 S ^TMP($J,"PRSNR",PICK,1,PRSNAME,PRSIEN,PRSNTT_"-"_PRSNM_"-"_PRSNREC_"-"_PRSNTWD)=$G(^TMP($J,"PRSNR",PICK,1,PRSNAME,PRSIEN,PRSNTT_"-"_PRSNM_"-"_PRSNREC_"-"_PRSNTWD))+HOURS
 ;
 Q
 ;
HDRSUM1 ;Display header for report of Individual Nurse Activity
 ;
 W @IOF
 S PG=PG+1,PRSL=1
 W ?20,"All Overtime at a Nurse Location Summary Report"
 W !,?15,EXTBEG_" - "_EXTEND,?45,"Run Date: ",TODAY,?70,"Page: ",$J(PG,3)
 W !         ;blank line
 W !,?10,"Reason for",?45,"# Of",?55,"# Of",?65,"# Of",?75,"Total"
 W !,?10,"Overtime",?45,"Hours",?55,"Hours",?65,"Hours",?75,"Hours"
 W !,?46,"RN",?56,"LPN",?66,"UAP"
 W !,"--------------------------------------------------------------------------------"
 ;
 Q
 ;
PRTSUM1 ;  Loop through Totals array and print each one
 ;
 N TOTYP
 F TOTYP=1:1:3 D  Q:STOP
 .S PRSNTT=""
 .F  S PRSNTT=$O(^TMP($J,"PRSNR",PICK,TOTYP,PRSNTT)) Q:PRSNTT=""!STOP  D
 .. S HOURS=$G(^TMP($J,"PRSNR",PICK,TOTYP,PRSNTT))
 .. D PPP1
 . W !
 Q:STOP
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDRSUM1
 Q:STOP
 S HOURS=$G(^TMP($J,"PRSNR",PICK)),TOTHRS=0
 F I=1:1:3 S TOTHRS=TOTHRS+$P(HOURS,U,I)
 W !,?4," TOTAL: ",PICK,?43,$J($P(HOURS,U,1),7,2),?53,$J($P(HOURS,U,2),7,2),?63,$J($P(HOURS,U,3),7,2),?73,$J(TOTHRS,7,2),!
 Q
 ;
PPP1 ;
 S TOTHRS=0
 F I=1:1:3 S TOTHRS=TOTHRS+$P(HOURS,U,I)
 W !
 I TOTYP=1 W ?10,PRSNTT
 I TOTYP'=1 W ?10,"TOTAL: ",PRSNTT
 W ?43,$J($P(HOURS,U,1),7,2),?53,$J($P(HOURS,U,2),7,2),?63,$J($P(HOURS,U,3),7,2),?73,$J(TOTHRS,7,2)
 ;
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDRSUM1
 Q
 ;
HDRSUM2 ;Display header for report of Individual Nurse Activity
 ;
 W @IOF
 S PG=PG+1,PRSL=1
 W ?20,"All Overtime at a Nurse Location Detail Report"
 W !,?15,EXTBEG_" - "_EXTEND,?45,"Run Date: ",TODAY,?70,"Page: ",$J(PG,3)
 W !         ;blank line
 W !,"Nurse Name",?21,"Type Time-",?32,"Type",?48,"Primary Location",?68,"# of",?75,"T&L"
 W !,"Skill Mix",?21,"OT-Reason",?32,"Work",?68,"Hours",?75,"Unit"
 W !,"--------------------------------------------------------------------------------"
 ;
 Q
 ;
PRTSUM2 ;  Loop through Totals array and print each one
 ;
 N CNT
 S PRSNAME=""
 F  S PRSNAME=$O(^TMP($J,"PRSNR",PICK,1,PRSNAME)) Q:PRSNAME=""!STOP  D
 . S PRSIEN=""
 . F  S PRSIEN=$O(^TMP($J,"PRSNR",PICK,1,PRSNAME,PRSIEN)) Q:PRSIEN=""!STOP  D
 .. D INFO
 .. S PRSNTT="",CNT=0
 .. F  S PRSNTT=$O(^TMP($J,"PRSNR",PICK,1,PRSNAME,PRSIEN,PRSNTT)) Q:PRSNTT=""!STOP  D
 ... S CNT=CNT+1
 ... S HOURS=$G(^TMP($J,"PRSNR",PICK,1,PRSNAME,PRSIEN,PRSNTT))
 ... D PPP2
 ..; need a blank line between nurses when there was only one record printed
 .. I CNT=1 W !
 Q:STOP
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDRSUM2
 Q:STOP
 D PRTSUM3
 Q
 ;
PPP2 ;
 I PRSL W !,$E(PRSNAME,1,19)
 W ?21,$P(PRSNTT,"-",1,3),?32,$E($P(PRSNTT,"-",4),1,14),?48,$E($P(PRIMLOC,U,3),1,18),?67,$J(HOURS,6,2),?75,PRSNTL,!
 I PRSL W "  ",$E(SKILMIX,1,17)
 ;
 S PRSL=0
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDRSUM2
 Q
 ;
PRTSUM3 ;  Loop through Totals array and print each one
 ;
 N TOTYP
 F TOTYP=2:1:4 D  Q:STOP
 .S PRSNTT=""
 .F  S PRSNTT=$O(^TMP($J,"PRSNR",PICK,TOTYP,PRSNTT)) Q:PRSNTT=""!STOP  D
 .. S HOURS=$G(^TMP($J,"PRSNR",PICK,TOTYP,PRSNTT))
 .. D PPP3
 . W !
 Q:STOP
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDRSUM2
 Q:STOP
 S HOURS=$G(^TMP($J,"PRSNR",PICK))
 W !,?4," TOTAL: ",PICK,?67,$J(HOURS,6,2),!
 Q
 ;
PPP3 ;
 W !,?6," TOTAL: ",PRSNTT,?67,$J(HOURS,6,2)
 ;
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDRSUM2
 Q
 ;
TYPE ;Choose summary or detailed group activity report
 ;
 N DIR,DIRUT,X,Y
 S DIR(0)="S^S:Summary Report;D:Detailed Report"
 S DIR("A")="Enter Selection"
 S DIR("?")="Enter whether you want to select a Summary or Detailed Overtime Report"
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
 . S ZTDESC="All Overtime at a Nurse Location "_$S(TYPE="S":"Summary",1:"Detail")
 . S ZTRTN="REPORT^PRSNRLOS"
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
