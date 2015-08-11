ECOSSUM ;BIR/DMA,RHK,JPW - Ordering Section Summary ;11/18/14  16:03
 ;;2.0;EVENT CAPTURE;**5,8,18,47,72,95,119,126**;8 May 96;Build 8
EN ;entry point from menu option
 W !
 K DIC S DIC=723,DIC(0)="AQEMZ",DIC("A")="Select Ordering Section: " D ^DIC K DIC
 I Y<0 G EXIT
 S ECOS=+Y,ECOSN=$P(Y,"^",2)
 D RANGE
 I '$G(ECLOOP)!'$G(ECSD)!'$G(ECED) G EXIT
 W !
 S JJ=$$ASKLOC^ECRUTL
 I 'JJ G EXIT
 W !
 S JJ=$$ASKDSS^ECRUTL
 I 'JJ G EXIT
 W !
 D DEVICE
 I POP G EXIT
 I $G(ZTSK) G EXIT
 I $G(IO("Q")),'$G(ZTSK) G EXIT
 D START
 D HOME^%ZIS
 G EXIT
 Q
 ;
START ;queued entry point or continuation
 D PROCESS
 I $G(ECPTYP)="E" D EXPORT,EXIT Q  ;119
 U IO D PRINT
 I $D(ECGUI) D EXIT Q
 I IO'=IO(0) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@" D EXIT
 Q
 ;
RANGE ;get any date range
 N ECSTDT,ECENDDT
 W !!,?5,"Enter a Begin Date and End Date for the Event Capture "
 W !,?5,"Ordering Section report.",!
 S (ECSD,ECED)=0
 F  D  Q:ECSD>0  Q:'$G(ECLOOP)
 .S ECLOOP=$$STDT^ECRUTL() I 'ECLOOP Q
 .S ECSD=ECSTDT
 Q:'$G(ECLOOP)!'$G(ECSD)
 F  D  Q:ECED>0  Q:'$G(ECLOOP)
 .S ECLOOP=$$ENDDT^ECRUTL(ECSTDT) I 'ECLOOP Q
 .S ECED=ECENDDT
 .I ECED>(DT+1) D
 ..W !!,?15,"The End Date for this report may not be"
 ..W !,?15,"a future date.  Try again...",!
 ..S ECED=0
 Q 
 ;
DEVICE ;select output device
 W !,"This report is formatted for 132 column output.",!
 K IOP S %ZIS="QM" D ^%ZIS
 I POP W !!,"No device selected.  Exiting...",!! S DIR(0)="E" W ! D ^DIR K DIR Q
 I $D(IO("Q")) D
 .S ZTRTN="START^ECOSSUM",ZTDESC="EC Ordering Section Summary"
 .S ZTSAVE("ECSD")="",ZTSAVE("ECED")="",ZTSAVE("ECOS")="",ZTSAVE("ECOSN")=""
 .S ZTSAVE("ECLOC(")="",ZTSAVE("ECDSSU(")=""
 .D ^%ZTLOAD
 .I '$G(ZTSK) W !,"Report canceled..." S DIR(0)="E" W ! D ^DIR K DIR Q
 .W !,"Report queued as Task #: ",ZTSK S DIR(0)="E" W ! D ^DIR K DIR
 Q
 ;
PROCESS ;get data to print
 N EC,ECD,ECDA,ECPA,ECPATN,ECSS,ECSSN,ECP,ECPN,ECLOCA,ECUNIT,ECCAT,ECFILE,ECPSY,ECPSYN,ECPRV,ECPRVN,EC725,ECLOCN,ECUNITN,ECEPN,ECEPC ;119
 N NLOC,NUNIT,JJ,ECPXD
 K ^TMP("ECOS",$J)
 ;put locations and units into ien subscripted arrays
 S JJ="" F  S JJ=$O(ECLOC(JJ)) Q:JJ=""  D
 .S NLOC($P(ECLOC(JJ),"^",1))=$P(ECLOC(JJ),"^",2)
 S JJ="" F  S JJ=$O(ECDSSU(JJ)) Q:JJ=""  D
 .S NUNIT($P(ECDSSU(JJ),"^",1))=$P(ECDSSU(JJ),"^",2)
 S ECD=ECSD
 F  S ECD=$O(^ECH("AC",ECD)) Q:'ECD  Q:ECD>ECED  D
 .S ECDA="" F  S ECDA=$O(^ECH("AC",ECD,ECDA)) Q:'ECDA  S EC=$G(^ECH(ECDA,0)) I $P(EC,"^",12)=ECOS D
 ..I $P(EC,"^",3)<ECSD!($P(EC,"^",3)>ECED) Q  ;file or x-ref problem
 ..S ECLOCA=+$P(EC,U,4),ECUNIT=+$P(EC,U,7)
 ..I '$D(NLOC(ECLOCA))!('$D(NUNIT(ECUNIT))) Q
 ..S ECLOCN=$G(NLOC(ECLOCA)),ECUNITN=$G(NUNIT(ECUNIT)) ;119 Get location and unit names
 ..S ECP=$P(EC,U,9) Q:ECP']""
 ..S ECCAT=+$P(EC,U,8)
 ..S ECPSY=+$O(^ECJ("AP",ECLOCA,ECUNIT,ECCAT,ECP,""))
 ..S ECPSYN=$P($G(^ECJ(ECPSY,"PRO")),"^",2)
 ..S ECFILE=$P(ECP,";",2),ECFILE=$S($E(ECFILE)="I":81,$E(ECFILE)="E":725,1:"UNKNOWN")
 ..I ECFILE="UNKNOWN" S (ECPN,ECEPN)="UNKNOWN" ;119
 ..S ECCPT=$S(ECFILE=81:+ECP,1:$P($G(^EC(725,+ECP,0)),"^",5)),ECPXD="",ECEPC="" ;119
 ..I ECCPT'="" D
 ...S ECPXD=$$CPT^ICPTCOD(ECCPT,$P(EC,"^",3)),ECCPT=$P(ECPXD,"^",2)
 ..I ECFILE=81 S (ECPN,ECEPN)=$S($P(ECPXD,"^",3)]"":$P(ECPXD,"^",3),1:"UNKNOWN") ;119
 ..I ECFILE=725 D
 ...S EC725=$G(^EC(725,+ECP,0)),ECPN=$P(EC725,"^",2)_" "_$P(EC725,"^"),ECEPN=$P(EC725,U),ECEPC=$P(EC725,U,2) ;119
 ..S ECPN=ECPN_"~"_ECCPT ;119,126
 ..;ALB/JAM - Get Procedure CPT modifiers
 ..S ECMODF=0 I $O(^ECH(ECDA,"MOD",0))'="" D
 ...K ECMOD S ECMODF=$$MOD^ECUTL(ECDA,"E",.ECMOD)
 ..S (ECPA,ECPATN,ECSS)="",ECPA=$G(^DPT(+$P(EC,"^",2),0)) Q:ECPA=""
 ..S ECPATN=$P(ECPA,"^",1),ECSS=$P(ECPA,"^",9)
 ..S:+ECSS ECSSN=$E(ECSS,6,10) S:ECSS="" ECSSN="UNKN"
 ..S:ECPATN="" ECPATN="UNKNOWN" S ECPATN=ECPATN_"^"_ECSSN
 ..S ECV=+$P(EC,"^",10)
 ..K ECPRV S ECPRV=$$GETPRV^ECPRVMUT(ECDA,.ECPRV) I 'ECPRV D  K ECPRV
 ...M ^TMP("ECOS",$J,$S($G(ECPTYP)="E":ECLOCN,1:ECLOCA),$S($G(ECPTYP)="E":ECUNITN,1:ECUNIT),ECPATN,ECDA,"PRV")=ECPRV ;119 Use names rather than numbers if exporting
 ..I $G(ECPTYP)'="E" S ^TMP("ECOS",$J,ECLOCA,ECUNIT,ECPATN,ECDA)=ECSSN_"^"_ECPN_"^"_ECPSYN_"^"_ECV ;119,126
 ..S:$G(ECPTYP)="E" ^TMP("ECOS",$J,ECLOCN,ECUNITN,ECPATN,ECDA)=ECSSN_U_ECCPT_U_ECEPC_U_ECEPN_U_ECPSYN_U_ECV ;119,126
 ..I ECMODF D
 ...M ^TMP("ECOS",$J,$S($G(ECPTYP)="E":ECLOCN,1:ECLOCA),$S($G(ECPTYP)="E":ECUNITN,1:ECUNIT),ECPATN,ECDA,"MOD")=ECMOD ;119 use names rather than numbers when exporting
 Q
 ;
PRINT ;output report
 N ECDA,ECLOCA,ECUNIT,ECPATN,ECSSN,ECPN,ECV,ECPSYN ;126
 N PAGE,QFLAG,DASH,DASH2,PRNTDT,JJ,SS,ALOC,AUNIT,LOC,UNNAME,UNIT,DATA,PTNAME,PROV,PROVN,V,X,Y
 S (PAGE,QFLAG)=0 S $P(DASH,"-",130)="",$P(DASH2,"-",64)=""
 S Y=$P(ECSD,".",1)+1 D DD^%DT S ECSD=Y S Y=$P(ECED,".",1) D DD^%DT S ECED=Y
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S PRNTDT=Y
 S ECV("L")=0,ECV("O")=0,ECV("P")=0,ECV("U")=0
 ;if no data exists then print the header and quit
 I '$D(^TMP("ECOS",$J)) D  Q
 .S LOC="" D HEAD
 .W !!,?26,"No data for this Ordering Section for the date range specified.",!!
 .I $E(IOST)="C"&('QFLAG) S DIR(0)="E" D  D ^DIR K DIR
 ..S SS=22-$Y F JJ=1:1:SS W !
 .W:$E(IOST)'="C" @IOF
 ;if there's data in ^TMP then need to present the data alphabetically;
 ;put locations and units in alpha ordered array
 S JJ="" F  S JJ=$O(ECLOC(JJ)) Q:JJ=""  D
 .S ALOC($P(ECLOC(JJ),"^",2))=$P(ECLOC(JJ),"^",1)
 S JJ="" F  S JJ=$O(ECDSSU(JJ)) Q:JJ=""  D
 .S AUNIT($P(ECDSSU(JJ),"^",2))=$P(ECDSSU(JJ),"^",1)
 ;process the ^TMP global data in alpha order for location and unit
 S LOC="" F  S LOC=$O(ALOC(LOC)) Q:LOC=""  S ECLOCA=ALOC(LOC),ECV("L")=0 D  Q:QFLAG
 .D HEAD Q:QFLAG  ;always start a new location at top of page
 .S UNIT="" F  S UNIT=$O(AUNIT(UNIT)) Q:UNIT=""  S ECUNIT=AUNIT(UNIT),ECV("U")=0 D  Q:QFLAG
 ..I '$D(^TMP("ECOS",$J,ECLOCA,ECUNIT)) Q
 ..S UNNAME=$E(UNIT,1,20)
 ..D:($Y+6>IOSL) HEAD Q:QFLAG  W !,UNNAME ;126 Removed excess linefeed
 ..S ECPATN="" F  S ECPATN=$O(^TMP("ECOS",$J,ECLOCA,ECUNIT,ECPATN)) Q:ECPATN=""  S ECV("P")=0 D  Q:QFLAG
 ...S PTNAME=$P(ECPATN,"^",1),PTNAME=$E(PTNAME,1,22),ECSSN=$P(ECPATN,"^",2)
 ...W ?24,PTNAME,?48,ECSSN
 ...S ECDA="" F  S ECDA=$O(^TMP("ECOS",$J,ECLOCA,ECUNIT,ECPATN,ECDA)) Q:ECDA=""  S DATA=^(ECDA) D  Q:QFLAG
 ....S ECPN=$P(DATA,"^",2),ECPN=$S($P(ECPN,"~",2)'="":$J($P(ECPN,"~",2)_" ",6),1:"")_$P(ECPN,"~") ;126
 ....S ECV=$P(DATA,"^",4),ECV=ECV\1,ECPSYN=$P(DATA,U,3) D  ;126
 .....F V="L","O","P","U" S ECV(V)=ECV(V)+ECV
 .....S:+ECV>9999 ECV="9999+" S ECV=$$RJ^XLFSTR(ECV,5," ") ;unusually high individual volume figure
 ....K PROV M PROV=^TMP("ECOS",$J,ECLOCA,ECUNIT,ECPATN,ECDA,"PRV")
 ....K ECMOD M ECMOD=^TMP("ECOS",$J,ECLOCA,ECUNIT,ECPATN,ECDA,"MOD")
 ....W ?54,ECPN,?112,ECV,!,?25,$P($G(PROV(1)),"^",2),?60,ECPSYN K PROV(1) ;126
 ....D:($Y+6>IOSL) HEAD Q:QFLAG
 ....;ALB/JAM - write cpt procedure modifiers on same line with providers
 ....S MOD=0,PROVN=1 F  S MOD=$O(ECMOD(MOD)),PROVN=$O(PROV(PROVN)) Q:(MOD="")&(PROVN="")  D  I QFLAG Q
 .....I ($Y+6>IOSL) D HEAD Q:QFLAG  W !?54,ECPN
 .....W !
 .....I PROVN'="" W ?25,$P($G(PROV(PROVN)),"^",2) K PROV(PROVN) ;126
 .....I MOD'="" W ?60,"- ",MOD," ",$P(ECMOD(MOD),U,3) K ECMOD(MOD) ;126
 ....W ! ;start a new line
 ...;write subtotal for patient
 ...Q:QFLAG  D:($Y+6>IOSL) HEAD Q:QFLAG
 ...W ?54,DASH2,!
 ...W ?24,"Subtotal for "_$P(ECPATN,"^",1)_":",?112,$$RJ^XLFSTR(ECV("P"),5," "),!! ;126
 ..;write total for unit
 ..Q:QFLAG  D:($Y+6>IOSL) HEAD Q:QFLAG
 ..W !,"Subtotal for DSS Unit "_UNIT_":",?111,$$RJ^XLFSTR(ECV("U"),6," "),! ;126
 .;write the total for the location
 .Q:QFLAG  D:($Y+6>IOSL) HEAD Q:QFLAG
 .W !!,"Total for Location "_LOC_":",?111,$$RJ^XLFSTR(ECV("L"),6," "),! ;126
 ;write the ordering section grandtotal
 Q:QFLAG  D:($Y+8>IOSL) HEAD Q:QFLAG
 W !!!,"Grand Total for Ordering Section "_ECOSN_":",?111,$$RJ^XLFSTR(ECV("O"),6," "),! ;126
 ;all done
 D FOOTER  ;print footer on last page
 I $E(IOST)="C"&('QFLAG) S DIR(0)="E" D  D ^DIR W @IOF
 .S SS=22-$Y F JJ=1:1:SS W !
 W:$E(IOST)'="C" @IOF
 Q
HEAD ;header
 I $E(IOST)="C" S SS=22-$Y F JJ=1:1:SS W !
 I PAGE>0 D FOOTER
 I $E(IOST)="C",PAGE>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLAG=1 Q
 W:$Y!($E(IOST)="C") @IOF
 S PAGE=PAGE+1
 W !,?26,"Event Capture Ordering Section Summary for ",ECOSN,?105,"Page: ",PAGE
 W !,?26,"for the Date Range ",$$FMTE^XLFDT(ECSD)," to ",$$FMTE^XLFDT(ECED),?102,"Printed: "_PRNTDT
 W !,?26,"Location: ",LOC,!
 W !,"DSS Unit",?24,"Patient",?48,"SSN",?54,"Procedure",?114,"Vol." ;126
 W !,?25,"Provider(s)",?60,"Synonym",!,?60,"- Modifier(s)" ;126
 W !,DASH ;126 Removed extra line feed
 Q
 ;
FOOTER ;print page footer
 W !!?4,"Volume totals may represent days, minutes, numbers of procedures"
 W !?4,"and/or a combination of these."
 Q
 ;
EXIT ;common exit point
 D ^ECKILL
 D:'$D(ECGUI) ^%ZISC
 K ^TMP("ECOS",$J)
 K JJ,X,Y,ZTSK,IO("Q"),DIR,DIRUT,DTOUT,DUOUT,ECOS,ECOSN,ECSD,ECED,ECLOOP,ECLOC,ECDSSU
 Q
 ;
EXPORT ;119 Section added for exporting data to excel
 N CNT,LOC,UNIT,PAT,IEN,DATA,SUB,MODCNT,PRCNT
 S CNT=1,^TMP($J,"ECRPT",CNT)="ORDERING SECTION^LOCATION^DSS UNIT^PATIENT^SSN^CPT CODE^PROCEDURE CODE^PROCEDURE NAME (DESCRIPTION)^SYNONYM^VOLUME" ;126
 S ^TMP($J,"ECRPT",CNT)=^TMP($J,"ECRPT",CNT)_"^CPT MOD #1^CPT MOD #2^CPT MOD #3^PROVIDER #1^PROVIDER #2^PROVIDER #3^PROVIDER #4^PROVIDER #5^PROVIDER #6^PROVIDER #7" ;126
 I '$D(^TMP("ECOS",$J)) Q  ;Nothing to report
 S LOC="" F  S LOC=$O(^TMP("ECOS",$J,LOC)) Q:LOC=""  D
 .S UNIT="" F  S UNIT=$O(^TMP("ECOS",$J,LOC,UNIT)) Q:UNIT=""  D
 ..S PAT="" F  S PAT=$O(^TMP("ECOS",$J,LOC,UNIT,PAT)) Q:PAT=""  D
 ...S IEN=0 F  S IEN=$O(^TMP("ECOS",$J,LOC,UNIT,PAT,IEN)) Q:'+IEN  D
 ....S DATA=^TMP("ECOS",$J,LOC,UNIT,PAT,IEN)
 ....S CNT=CNT+1,^TMP($J,"ECRPT",CNT)=ECOSN_U_LOC_U_UNIT_U_$P(PAT,U)_U_$P(DATA,U)_U_$P(DATA,U,2)_U_$P(DATA,U,3)_U_$P(DATA,U,4)_U_$P(DATA,U,5)_U_$P(DATA,U,6) ;126
 ....S SUB=0,MODCNT=0 F  S:SUB'="" SUB=$O(^TMP("ECOS",$J,LOC,UNIT,PAT,IEN,"MOD",SUB)) Q:MODCNT=3  S ^TMP($J,"ECRPT",CNT)=^TMP($J,"ECRPT",CNT)_U_$S(SUB'="":SUB_" "_$P($G(^TMP("ECOS",$J,LOC,UNIT,PAT,IEN,"MOD",SUB)),U,3),1:""),MODCNT=MODCNT+1
 ....S SUB=0,PRCNT=0 F  S:SUB'="" SUB=$O(^TMP("ECOS",$J,LOC,UNIT,PAT,IEN,"PRV",SUB)) Q:PRCNT=7  S ^TMP($J,"ECRPT",CNT)=^TMP($J,"ECRPT",CNT)_U_$S(SUB="":"",1:$P($G(^TMP("ECOS",$J,LOC,UNIT,PAT,IEN,"PRV",SUB)),U,2)) S PRCNT=PRCNT+1
 Q
