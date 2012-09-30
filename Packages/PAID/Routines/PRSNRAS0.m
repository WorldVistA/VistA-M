PRSNRAS0 ;WOIFO/DAM - Group Activity - Summary and Detailed;9/10/2009
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
DEP ; Entry point for Data Entry Personnel
 N GROUP
 D ACCESS^PRSNUT02(.GROUP,"E",DT,1)
 ; quit if any error during group selection
 I $P($G(GROUP(0)),U,2)="E" D  Q
 .W !,$P(GROUP(0),U,3)
 D MAIN
 Q
 ;
DAP ; Entry point for Data Approval Personnel
 N GROUP
 D ACCESS^PRSNUT02(.GROUP,"A",DT,1)
 ; quit if any error during group selection
 I $P($G(GROUP(0)),U,2)="E" D  Q
 .W !,$P(GROUP(0),U,3)
 D MAIN
 Q
 ;
COORD ;Entry point for VANOD Coordinator
 ; Coordinator has no access limits so let them pick any group
 N GROUP
 D PIKGROUP^PRSNUT04(.GROUP,"",1)
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
REPORT ;for group of location or t&l
 ;
 N PRSIEN,PRSNGLB,PRSNG,PICK,PRSNGA,PRSNGB,PG,STOP
 N PRSNARY,PRSNAME,PRSNTL
 K ^TMP($J,"PRSNR")
 U IO
 S (PICK,STOP)=0
 F  S PICK=$O(GROUP(PICK)) Q:PICK=""!STOP  D
 . S PRSNG=GROUP(0)_"^"_PICK_"^"_GROUP(PICK)
 . S PRSNGLB=$S($P(PRSNG,U,2)="N":$NA(^NURSF(211.8,"D",$P(PRSNG,U,7))),1:$NA(^PRSPC("ATL"_$P(PRSNG,U,3))))
 . S PRSNGA=""
 . F  S PRSNGA=$O(@PRSNGLB@(PRSNGA)) QUIT:PRSNGA=""!STOP  D
 .. S PRSNGB=0
 .. F  S PRSNGB=$O(@PRSNGLB@(PRSNGA,PRSNGB)) QUIT:'PRSNGB!STOP  D
 ... I $P(PRSNG,U,2)="N",+$P(PRSNG,U,4)'=+$$PRIMLOC^PRSNUT03(PRSNGB) Q
 ... S PRSIEN=$S($P(PRSNG,U,2)="N":+$G(^VA(200,PRSNGB,450)),1:PRSNGB)
 ... Q:'+$$ISNURSE^PRSNUT01(PRSIEN)
 ... S PRSNARY=$G(^PRSPC(PRSIEN,0))
 ... S PRSNAME=$P(PRSNARY,U)              ;Nurse Name
 ... S PRSNTL=$P(PRSNARY,U,8)             ;Nurse T&L
 ... S ^TMP($J,"PRSNR",PICK,PRSNAME,PRSIEN)=""
 ;
 S PG=0,TODAY=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 I TYPE="S" D HDR^PRSNRAS1(EXTBEG,EXTEND)
 I TYPE="D" D HDR^PRSNRAD0
 S PICK=""
 F  S PICK=$O(^TMP($J,"PRSNR",PICK)) Q:PICK=""!STOP  D
 . S GHD="Location: "_PICK
 . S TAB=IOM-$L(GHD)/2-5
 . W !!,?TAB,GHD,!
 . W ?TAB F I=1:1:$L(GHD) W "-"
 . S PRSNAME=""
 . Q:STOP
 . F  S PRSNAME=$O(^TMP($J,"PRSNR",PICK,PRSNAME)) Q:PRSNAME=""!STOP  D
 .. S PRSIEN=""
 .. F  S PRSIEN=$O(^TMP($J,"PRSNR",PICK,PRSNAME,PRSIEN)) Q:PRSIEN=""!STOP  D
 ... I TYPE="S" D
 .... ;summary report
 .... D DSPLY^PRSNRAS1(PRSIEN,BEG,END,EXTBEG,EXTEND,.STOP)
 ... I TYPE="D" D
 .... ;detailed report
 .... D DSPLY^PRSNRAD0(PRSIEN,BEG,END,.STOP)
 W !!,"End of Report"
 D ^%ZISC
 K ^TMP($J,"PRSNR")
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
 . S ZTDESC="GROUP ACTIVITY "_TYPE_" REPORT"
 . S ZTRTN="REPORT^PRSNRAS0"
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
