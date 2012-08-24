PRSNRUR ;WOIFO/KJS - Unapproved POC records report;1-20-2012
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038,this routine should not be modified.
 ;
 Q
 ;
EN ; Entry point for approval of POC records for a pay period.
 N A,B,DAY,DAYREC,DIC,DIR,DIRUT,DSPFLG,GROUP,I,IEN200
 N IEN450,NURSNM,PAYPD,PREVPD,PRSD,PRSFLG,PRSIEN,PRSPD,PRSPDE
 N PRSPDI,PRSPRM,PRSSTAT,STOP,REC,SEG
 D PIKGROUP^PRSNUT04(.GROUP,"",1)
 I $P($G(GROUP(0)),U,2)="E" D  Q
 . W !!,"There are no groups assigned or selected."
 ;
 S PRSPRM=$P(GROUP(0),U,2)
 S STOP=0
 ;
 D SETPPD
 Q:STOP
 D TYPE
 Q:STOP
 D QUE
 Q
 ;
SETPPD ; back up default of current pay period if it doesn't have any data
 ;
 N DIC,X,Y,DUOUT,DTOUT
 S PRSPDI=$O(^PRSN(451,"AEP",""),-1)
 S DIC("B")=PRSPDI
 S DIC="^PRSN(451,",DIC(0)="AEQMZ"
 S DIC("A")="Select a Pay Period: "
 S DIC("S")="I $$PPFND^PRSNRUR(+Y)"
 D ^DIC
 I $D(DUOUT)!$D(DTOUT)!(+$G(Y)'>0) S STOP=1 Q
 S PRSPDI=+Y
 ;
 Q
 ;
PPFND(PPIEN) ;
 N FOUND,PICK,DIVI
 S FOUND=0
 I $D(^PRSN(451,"AEP",PPIEN)) S FOUND=1 Q FOUND
 S PICK=0
 F  S PICK=$O(GROUP(PICK)) Q:'PICK  D  Q:FOUND
 . S DIVI=$P(GROUP(PICK),U,2)
 . I $D(^PRSN(451,"ACE",DIVI,PPIEN)) S FOUND=1
 Q FOUND
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
QUE ;call to generate and display report for individual activity
 N %ZIS,POP,IOP
 S %ZIS="MQ"
 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D
 . K IO("Q")
 . N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC
 . S ZTDESC="UNAPPROVED POC TIME "_TYPE_" REPORT"
 . S ZTRTN="REPORT^PRSNRUR"
 . S ZTSAVE("GROUP")=""
 . S ZTSAVE("GROUP(")=""
 . S ZTSAVE("TYPE")=""
 . S ZTSAVE("PRSPDI")=""
 . D ^%ZTLOAD
 . I $D(ZTSK) S ZTREQ="@" W !,"Request "_ZTSK_" queued."
 E  D
 . D REPORT
 Q
 ;
REPORT ;for group of location or t&l
 ;
 N PRSIEN,PRSNG,PICK,PG,STOP,PRSPDE,TODAY,PRSNARY,PRSNAME,PRSNTL,IEN200
 N TOT,GTOT
 K ^TMP($J,"PRSNR")
 S PRSPDE=$P(^PRSN(451,PRSPDI,0),U)
 U IO
 S PG=0,TODAY=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 S (PICK,STOP)=0
 F  S PICK=$O(GROUP(PICK)) Q:PICK=""!STOP  D
 . S PRSNG=GROUP(0)_"^"_PICK_"^"_GROUP(PICK)
 . S PRSIEN=0
 . F  S PRSIEN=$O(^PRSN(451,"AEP",PRSPDI,PRSIEN)) Q:'PRSIEN  D
 .. S PRSNARY=$G(^PRSPC(PRSIEN,0))
 .. S PRSNAME=$P(PRSNARY,U)              ;Nurse Name
 .. S PRSNTL=$P(PRSNARY,U,8)             ;Nurse T&L
 .. S IEN200=$P($G(^PRSPC(PRSIEN,200)),U)
 .. I $P(PRSNG,U,2)="N",+$P(PRSNG,U,4)'=+$$PRIMLOC^PRSNUT03(IEN200) Q
 .. I $P(PRSNG,U,2)="T",PICK'=PRSNTL Q
 .. S ^TMP($J,"PRSNR",PICK,PRSNAME,PRSIEN,"A")=""
 .;
 . S DIVI=$P(GROUP(PICK),U,2)
 . S PRSIEN=0
 . F  S PRSIEN=$O(^PRSN(451,"ACE",DIVI,PRSPDI,PRSIEN)) Q:'PRSIEN  D
 .. S PRSNARY=$G(^PRSPC(PRSIEN,0))
 .. S PRSNAME=$P(PRSNARY,U)              ;Nurse Name
 .. S PRSNTL=$P(PRSNARY,U,8)             ;Nurse T&L
 .. S IEN200=$P($G(^PRSPC(PRSIEN,200)),U)
 .. I $P(PRSNG,U,2)="N",+$P(PRSNG,U,4)'=+$$PRIMLOC^PRSNUT03(IEN200) Q
 .. I $P(PRSNG,U,2)="T",PICK'=PRSNTL Q
 .. S ^TMP($J,"PRSNR",PICK,PRSNAME,PRSIEN,"C")=""
 ;
 S PICK="",(GTOT("A"),GTOT("C"))=0
 D HDR
 F  S PICK=$O(^TMP($J,"PRSNR",PICK)) Q:PICK=""!STOP  D
 . I TYPE="D" D
 .. S GHD="Location: "_PICK
 .. S TAB=IOM-$L(GHD)/2-5
 .. W !!,?TAB,GHD,!
 .. W ?TAB F I=1:1:$L(GHD) W "-"
 . S PRSNAME="",(TOT("A"),TOT("C"))=0
 . F  S PRSNAME=$O(^TMP($J,"PRSNR",PICK,PRSNAME)) Q:PRSNAME=""!STOP  D
 .. S PRSIEN=""
 .. F  S PRSIEN=$O(^TMP($J,"PRSNR",PICK,PRSNAME,PRSIEN)) Q:PRSIEN=""!STOP  D
 ... S TT=""
 ... F  S TT=$O(^TMP($J,"PRSNR",PICK,PRSNAME,PRSIEN,TT)) Q:TT=""!STOP  D
 .... S TOT(TT)=TOT(TT)+1,GTOT(TT)=GTOT(TT)+1
 .... Q:TYPE'="D"
 .... ;detailed report
 .... I (IOSL-4)<$Y D HDR
 .... Q:STOP
 .... W !,PRSNAME W:TT="C" "  Corrected"
 . W:TYPE="D" !
 . W !,"Total for ",PICK,": ",TOT("A"),"  Corrected: ",TOT("C")
 W !!,"Grand Total: ",GTOT("A"),"  Corrected: ",GTOT("C")
 W !!,"End of Report"
 D ^%ZISC
 D CLEANUP
 Q
 ;
HDR ;
 ;
 I PG>0 S STOP=$$ASK^PRSLIB00()
 Q:STOP
 W @IOF
 S PG=PG+1
 W "Unapproved Pay Period POC Records for "
 W $S($P(PRSNG,U,2)="N":"Nurse Location",1:"T&L Unit")
 W ?66,"Pay Pd: ",PRSPDE,!
 W:TYPE="D" "Nurse Name"
 W ?35,$S(TYPE="D":"Detail",1:"Summary"),?66,"Page: ",PG,!
 F I=1:1:80 W "-"
 ;
 Q
 ;
CLEANUP ;
 K ^TMP($J,"PRSNR")
 Q
