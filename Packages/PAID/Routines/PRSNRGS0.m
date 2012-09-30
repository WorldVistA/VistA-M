PRSNRGS0 ;WOIFO/KJS - Nursing LOCATION Summary Report ;8/2/2011
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified
 QUIT
 ;
COORD ;Entry point for VANOD Coordinator
 ; Coordinator has no access limits so let them pick any group
 N GROUP
 D PIKGROUP^PRSNUT04(.GROUP,"N",1)
 I $P($G(GROUP(0)),U,2)="E" D  Q
 .W !,$P(GROUP(0),U,3)
 D MAIN
 Q
 ;
MAIN ;call to generate and display report for individual activity
 ;
 S STOP=0
 D DATE
 Q:STOP
 N %ZIS,POP,IOP
 S %ZIS="MQ"
 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D
 . K IO("Q")
 . N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC
 . S ZTDESC="Nursing Location Summary Report"
 . S ZTRTN="REPORT^PRSNRGS0"
 . S ZTSAVE("GROUP(")=""
 . S ZTSAVE("LOCDT")=""
 . S ZTSAVE("LOCDTE")=""
 . D ^%ZTLOAD
 . I $D(ZTSK) S ZTREQ="@" W !,"Request "_ZTSK_" Queued."
 E  D REPORT
 ;
 Q
 ;
DATE ; User is prompted for a date range 
 ;
 ; GET START DATE
 N %DT,Y,X
 S %DT="AEP"
 S %DT("A")="Date: "
 S Y=DT D DD^%DT S %DT("B")=Y
 ;
 D ^%DT
 I +$G(Y)'>0 S STOP=1 Q
 ;
 S LOCDT=Y D DD^%DT S LOCDTE=Y
 ;
 Q
 ;
REPORT ;for group of location or t&l
 ;
 N PRSIEN,PRSNGLB,PRSNG,GHD,PICK,SORT,I,PRSNGA,PRSNGB,TAB,PG,TOTUAP,TOTLPN,TOTRN
 N FIELDS,ACTIVE,STATUS,DSS,DAP,DEP,VANOD,LN
 U IO
 S SORT=$P(GROUP(0),U,2),PG=0
 K ^TMP($J)
 D HDR
 S (PICK,STOP)=0
 F  S PICK=$O(GROUP(PICK)) Q:PICK=""!STOP  D
 .S (TOTUAP,TOTLPN,TOTRN)=0
 .S PRSNG=GROUP(0)_"^"_PICK_"^"_GROUP(PICK),LOCN=$P(PRSNG,U,7)
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
 ...S SKILL=$P(NURSE,U,2)
 ...I SKILL["RN" S TOTRN=TOTRN+1
 ...I SKILL["LPN" S TOTLPN=TOTLPN+1
 ...I SKILL'["RN",SKILL'["LPN" S TOTUAP=TOTUAP+1
 .Q:STOP
 .S LOCIEN=$O(^NURSF(211.4,"B",LOCN,""))
 .S STATUS=$$ISACTIVE^PRSNUT01(LOCDT,LOCIEN)
 .S ACTIVE=$S(+STATUS:"Active",1:"Inactive")
 .K FIELDS
 .S IENS=LOCIEN_","
 .D GETS^DIQ(211.4,IENS,".01;.6;.7;2*;14*;15*","IE","FIELDS(",,)
 .S VANOD=FIELDS(211.4,IENS,.6,"E")
 .S DSS=FIELDS(211.4,IENS,.7,"E")
 .S (MASIENS,DAPIENS,DEPIENS)="",MASSTOP=0
 .F LN=1:1 D  Q:MASSTOP!STOP
 ..S MASIENS=$O(FIELDS(211.41,MASIENS))
 ..I MASIENS="" S MASSTOP=1
 ..S MAS=$S(MASSTOP:"",1:FIELDS(211.41,MASIENS,.01,"E"))
 ..I LN>1,MASSTOP Q  ;MUST PRINT AT LEAST 1 LINE
 ..D PRT1
 .Q:STOP
 .S (DEPSTOP,DAPSTOP)=0
 .F LN=1:1 D  Q:(DAPSTOP&DEPSTOP)!STOP
 ..S DEPIENS=$O(FIELDS(211.414,DEPIENS))
 ..I DEPIENS="" S DEPSTOP=1
 ..S DEP=$S(DEPSTOP:"",1:FIELDS(211.414,DEPIENS,.01,"E"))
 ..S DAPIENS=$O(FIELDS(211.415,DAPIENS))
 ..I DAPIENS="" S DAPSTOP=1
 ..S DAP=$S(DAPSTOP:"",1:FIELDS(211.415,DAPIENS,.01,"E"))
 ..I LN>1,DAPSTOP,DEPSTOP Q  ;MUST PRINT AT LEAST 1 LINE
 ..D PRT2
 W !!,"End of Report"
 D ^%ZISC
 K ^TMP($J)
 Q
 ;
HDR ;Display header
 ;
 W @IOF
 S PG=PG+1
 W "Nursing Location Summary Report For Date: ",LOCDTE
 W !,?45,"Run Date: ",$E(DT,4,5),"/",$E(DT,6,7),"/",$E(DT,2,3),"  Page: ",$J(PG,3)
 ;nurse position and pay
 W !!,"Nurse Location",?20,"MAS Ward",?40,"VANOD Unit Type",?60,"DSS Unit Type"
 W !,?5,"Status",?15,"Data Approval",?35,"Data Entry",?64,"#RNs",?69,"#LPNs",?75,"#UAPs"
 W !,"--------------------------------------------------------------------------------"
 ;
 QUIT
 ;
PRT1 ;
 ;print position and pay report
 W !
 W:LN=1 $E(PICK,1,19)
 W ?20,$E(MAS,1,19)
 W:LN=1 ?40,$E(VANOD,1,19),?60,$E(DSS,1,19)
 ;
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDR
 Q
 ;
PRT2 ;
 ;print position and pay report
 W !
 W:LN=1 ?5,ACTIVE
 W ?15,$E(DAP,1,19),?35,$E(DEP,1,19)
 W:LN=1 ?64,$J(TOTRN,4,0),?70,$J(TOTLPN,4,0),?76,$J(TOTUAP,4,0)
 ;
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDR
 Q
