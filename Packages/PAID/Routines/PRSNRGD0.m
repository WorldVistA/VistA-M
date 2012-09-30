PRSNRGD0 ;WOIFO/KJS - Nursing LOCATION DETAIL Report ;8/2/2011
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified
 QUIT
 ;
COORD ;Entry point for VANOD Coordinator
 ; Coordinator has no access limits so let them pick any group
 N GROUP
 D PIKGROUP^PRSNUT04(.GROUP,"",1)
 I $P($G(GROUP(0)),U,2)="E" D  Q
 .W !,$P(GROUP(0),U,3)
 D MAIN
 Q
 ;
MAIN ;call to generate and display report for individual activity
 ;
 N %ZIS,POP,IOP
 S %ZIS="MQ"
 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D
 . K IO("Q")
 . N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC
 . S ZTDESC="Nursing Location Detail Report"
 . S ZTRTN="REPORT^PRSNRGD0"
 . S ZTSAVE("GROUP(")=""
 . S ZTSAVE("TYPE")=""
 . D ^%ZTLOAD
 . I $D(ZTSK) S ZTREQ="@" W !,"Request "_ZTSK_" Queued."
 E  D REPORT
 ;
 Q
 ;
REPORT ;for group of location or t&l
 ;
 N PRSIEN,PRSNGLB,PRSNG,GHD,PICK,SORT,STOP,I,PRSNGA,PRSNGB,TAB,PG,FTEE,TOTNUR,TOTFTEE
 U IO
 S SORT=$P(GROUP(0),U,2),PG=0,(FTEE,TOTFTEE,TOTNUR)=0
 K ^TMP($J)
 D HDR^PRSNRGD1
 S (PICK,STOP)=0
 F  S PICK=$O(GROUP(PICK)) Q:PICK=""!STOP  D
 .S PRSNG=GROUP(0)_"^"_PICK_"^"_GROUP(PICK)
 .S PRSNGLB=$S($P(PRSNG,U,2)="N":$NA(^NURSF(211.8,"D",$P(PRSNG,U,7))),1:$NA(^PRSPC("ATL"_$P(PRSNG,U,3))))
 .;
 .;
 .K ^TMP($J)
 .S PRSNGA=""
 .F  S PRSNGA=$O(@PRSNGLB@(PRSNGA)) QUIT:PRSNGA=""!STOP  D
 ..S PRSNGB=0
 ..F  S PRSNGB=$O(@PRSNGLB@(PRSNGA,PRSNGB)) QUIT:'PRSNGB!STOP  D
 ...I $P(PRSNG,U,2)="N",+$P(PRSNG,U,4)'=+$$PRIMLOC^PRSNUT03(PRSNGB) Q
 ...S PRSIEN=$S($P(PRSNG,U,2)="N":+$G(^VA(200,PRSNGB,450)),1:PRSNGB)
 ...S NURSE=$$ISNURSE^PRSNUT01(PRSIEN)
 ...Q:'+NURSE
 ...S JOB=$$GETCODES^PRSNUT01(PRSIEN)    ;Job codes
 ...S BOC=$P(JOB,U)
 ...S OCC=$P(JOB,U,2)
 ...D INFO^PRSNRAS1
 ...S ^TMP($J,OCC,PRSNAME,PRSIEN)=NURSE
 .; display and underline group sub header
 .;
 .Q:STOP
 .S GHD=$S($P(PRSNG,U,2)="N":"LOCATION",1:"T&L UNIT")_":  "_$P(PRSNG,U,3)
 .S TAB=IOM-$L(GHD)/2-5
 .W !!,?TAB,GHD,!
 .W ?TAB F I=1:1:$L(GHD) W "-"
 .S S1=""
 .F  S S1=$O(^TMP($J,S1)) Q:S1=""!STOP  D
 ..S S2=""
 ..F  S S2=$O(^TMP($J,S1,S2)) Q:S2=""!STOP  D
 ...S PRSIEN=""
 ...F  S PRSIEN=$O(^TMP($J,S1,S2,PRSIEN)) Q:PRSIEN=""!STOP  D
 ....S NURSE=^TMP($J,S1,S2,PRSIEN)
 ....D DSPLY^PRSNRGD1(PRSIEN,NURSE,.STOP)
 W !!,?40,"Total Nurses: ",$J(TOTNUR,4),?60,"Total FTEE: ",?72,$J(TOTFTEE,8,2)
 W !!,"End of Report"
 D ^%ZISC
 K ^TMP($J)
 Q
 ;
