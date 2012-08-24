PRSNREV0 ;WOIFO/DAM - Nursing Education Validation/Position and Pay Reports ;9/10/2009
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified
 QUIT
 ;
COORDNPP ;entry point of nurse position and pay information
 S PRSNOPT=2
 D MAIN
 Q
COORD ;Entry point for VANOD Coordinator
 S PRSNOPT=1
 D MAIN
 Q
 ;
MAIN ;call to generate and display report for individual activity
 ;
 ; Coordinator has no access limits so let them pick any group
 N GROUP
 D PIKGROUP^PRSNUT04(.GROUP,"",1)
 I $P($G(GROUP(0)),U,2)="E" D  Q
 .W !,$P(GROUP(0),U,3)
 N %ZIS,POP,IOP
 S %ZIS="MQ"
 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D
 . K IO("Q")
 . N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC
 . S ZTDESC=$P("Nursing Education Validation Report^Nurse Position and Pay Information Report",PRSNOPT)
 . S ZTRTN="REPORT^PRSNREV0"
 . S ZTSAVE("GROUP(")=""
 . S ZTSAVE("TYPE")=""
 . S ZTSAVE("PRSNOPT")=""
 . D ^%ZTLOAD
 . I $D(ZTSK) S ZTREQ="@" W !,"Request "_ZTSK_" Queued."
 E  D
 . D REPORT
 ;
 K PRSNOPT
 Q
 ;
REPORT ;for group of location or t&l
 ;
 N PRSIEN,PRSNGLB,PRSNG,GHD,PICK,SORT,STOP,I,PRSNGA,PRSNGB,TAB,PG
 U IO
 S SORT=$P(GROUP(0),U,2),PG=0
 D HDR^PRSNREV1(PRSNOPT)
 S (PICK,STOP)=0
 F  S PICK=$O(GROUP(PICK)) Q:PICK=""!STOP  D
 . S PRSNG=GROUP(0)_"^"_PICK_"^"_GROUP(PICK)
 . S PRSNGLB=$S($P(PRSNG,U,2)="N":$NA(^NURSF(211.8,"D",$P(PRSNG,U,7))),1:$NA(^PRSPC("ATL"_$P(PRSNG,U,3))))
 . ;
 . ; display and underline group sub header
 . ;
 . S GHD=$S($P(PRSNG,U,2)="N":"LOCATION",1:"T&L UNIT")_":  "_$P(PRSNG,U,3)
 . S TAB=IOM-$L(GHD)/2-5
 . W !!,?TAB,GHD,!
 . W ?TAB F I=1:1:$L(GHD) W "-"
 . ;
 . S PRSNGA=""
 . F  S PRSNGA=$O(@PRSNGLB@(PRSNGA)) QUIT:PRSNGA=""!STOP  D
 .. S PRSNGB=0
 .. F  S PRSNGB=$O(@PRSNGLB@(PRSNGA,PRSNGB)) QUIT:'PRSNGB!STOP  D
 ... I $P(PRSNG,U,2)="N",+$P(PRSNG,U,4)'=+$$PRIMLOC^PRSNUT03(PRSNGB) Q
 ... S PRSIEN=$S($P(PRSNG,U,2)="N":+$G(^VA(200,PRSNGB,450)),1:PRSNGB)
 ... S NURSE=$$ISNURSE^PRSNUT01(PRSIEN)
 ... Q:'+NURSE
 ... D DSPLY^PRSNREV1(PRSIEN,PRSNOPT,NURSE,.STOP)
 W !!,"End of Report"
 D ^%ZISC
 Q
 ;
