ECRPRSN ;ALB/JAP - Procedure Reasons Report;24 JAN 07
 ;;2.0; EVENT CAPTURE ;**5,18,47,63,72,91**;8 May 96;Build 2
EN ;entry point from menu option
 N JJ
 W ! S JJ=$$ASKLOC^ECRUTL I 'JJ G EXIT
 W ! S JJ=$$ASKDSS^ECRUTL I 'JJ G EXIT
 W ! S JJ=$$ASKREAS() I 'JJ G EXIT
 W !
 D RANGE
 I '$G(ECLOOP)!'$G(ECSD)!'$G(ECED) G EXIT
 W ! D DEVICE I POP G EXIT
 I $G(ZTSK) G EXIT
 I $G(IO("Q")),'$G(ZTSK) G EXIT
 D START,HOME^%ZIS
 G EXIT
 Q
START ;queued entry point or continuation
 D PROCESS
 U IO D PRINT Q:$D(ECGUI)
 I IO'=IO(0) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@" D EXIT
 Q
ASKREAS()        ; Ask reasons
 ;   output: ECREAS array; contains set of reason iens
 N DIRUT,DUOUT,DTOUT,Y,DIR,A,P,R,S,JJ,KK,NLOC,NUNIT,LINK,ECREAS,E
 ;setup array of associated reason iens for the locations/units included
 W !!,"Just a moment please..."
 W !,?5,"...finding Procedure Reasons related to the"
 W !,?5,"   Location(s) and DSS Unit(s) you selected...",!
 S JJ="" F  S JJ=$O(ECLOC(JJ)) Q:JJ=""  D
 .S NLOC=$P(ECLOC(JJ),"^",1)
 .S KK="" F  S KK=$O(ECDSSU(KK)) Q:KK=""  S NUNIT=$P(ECDSSU(KK),"^",1),A(NLOC_"-"_NUNIT)=""
 S P=""
 F  S P=$O(^ECJ("B",P)) Q:P=""  I $D(A($P(P,"-",1,2))) S I=$O(^ECJ("B",P,"")),S(I)=""
 K A S P="" F  S P=$O(^ECL("AD",P)) Q:P=""  I $D(S(P)) S R="" D
 .F  S R=$O(^ECL("AD",P,R)) Q:R=""  D
 ..S LINK=$O(^ECL("AD",P,R,"")),ECLINK(LINK)=R
 ..S ECREAS(R)=$P($G(^ECR(R,0)),"^",1)
 ..I ECREAS(R)="" K ECREAS(R),ECLINK(LINK)
 K S
 ;ask the user to include all reasons or selected reasons
 S ASK=1
 S DIR(0)="YA",DIR("A")="Do you want to print this report for all Procedure Reasons? "
 S DIR("B")="YES" W ! D ^DIR K DIR I Y=0,'$G(DIRUT) D SPECR
 I $G(DIRUT)!(Y=0) S ASK=0 K ECREAS
 ;display user selections
 I $D(ECREAS)>1 D
 .W @IOF S E=0 W !,"Selected Procedure Reasons --",!
 .S R="" F  S R=$O(ECREAS(R)) Q:R=""  D  I E Q
 ..I $Y+3>IOSL S DIR(0)="E" D ^DIR K DIR S:'Y E=1 Q:'Y  D
 ...W @IOF,!,"Selected Procedure Reasons (cont.) --",!
 ..W !,?5,ECREAS(R)
 .Q:E  S DIR(0)="E" D  D ^DIR K DIR
 ..S SS=22-$Y F JJ=1:1:SS W !
 Q ASK
SPECR ;specific reasons
 N R,DUOUT,DTOUT
 K DIRUT,Y
 S DIR(0)="YA",DIR("A")="Do you want to include only specific Procedure Reasons in this report? ",DIR("B")="YES"
 S DIR("?")="Enter YES to select specific Procedure Reasons or NO to quit."
 W ! D ^DIR K DIR Q:$G(DIRUT)!(Y=0)
 ;select subset of possible reasons
 K DIRUT,DTOUT,DUOUT,Y
 F  D  Q:$G(DIRUT)!(Y=-1)
 .S DIC=720.4,DIC("A")="Select a Procedure Reason to include: ",DIC(0)="QAEM"
 .S DIC("S")="I $D(ECREAS(+Y))"
 .W ! D ^DIC Q:$G(DUOUT)!$G(DTOUT)!(Y=-1)
 .S R(+Y)=""
 S:$G(DTOUT)!($G(DUOUT)) DIRUT=1
 Q:$G(DIRUT)
 ;delete reasons from ecreas array which were not selected
 I $D(R)<10 S Y=0 Q
 S R="" F  S R=$O(ECREAS(R)) Q:R=""  I '$D(R(R)) K ECREAS(R)
 ;delete links from eclink array for reasons not selected
 S LINK="" F  S LINK=$O(ECLINK(LINK)) Q:LINK=""  S R=ECLINK(LINK) I '$D(ECREAS(R)) K ECLINK(LINK)
 S Y=1
 Q
RANGE ;get any date range
 N ECSTDT,ECENDDT
 W !!!,?5,"Enter a Begin Date and End Date for the Event Capture "
 W !,?5,"Procedure Reason Report.",!
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
 W ! K IOP,ZTSK S %ZIS="QM" D ^%ZIS
 I POP W !!,"No device selected.  Exiting...",!! S DIR(0)="E" W ! D ^DIR K DIR Q
 I $D(IO("Q")) D
 .S ZTRTN="START^ECRPRSN",ZTDESC="EC Procedure Reason Report"
 .S ZTSAVE("ECSD")="",ZTSAVE("ECED")="",ZTSAVE("ECLOC(")="",ZTSAVE("ECDSSU(")="",ZTSAVE("ECLINK(")=""
 .D ^%ZTLOAD D HOME^%ZIS
 .I '$G(ZTSK) W !,"Report canceled..." S DIR(0)="E" W ! D ^DIR K DIR Q
 .W !,"Report queued as Task #: ",ZTSK S DIR(0)="E" W ! D ^DIR K DIR
 Q
 ;
PROCESS ;get data to print
 N EC,ECD,ECDA,ECPA,ECR,ECRL,ECRN,ECPATN,ECSS,ECSSN,ECP,ECPN,ECLOCA
 N ECUNIT,ECCAT,ECFILE,ECPSY,ECPSYN,ECPRV,ECPRVN,ECDFN,ECCPT,ECDESC
 N NLOC,NUNIT,JJ,ECMOD,ECMD,ECMODF,EC725
 K ^TMP("ECREAS",$J)
 ;if ecreas array doesn't exist, quit
 I $D(ECLINK)<10 Q
 ;put locations and units into ien subscripted arrays
 S JJ="" F  S JJ=$O(ECLOC(JJ)) Q:JJ=""  D
 .S NLOC($P(ECLOC(JJ),"^",1))=$P(ECLOC(JJ),"^",2)
 S JJ="" F  S JJ=$O(ECDSSU(JJ)) Q:JJ=""  D
 .S NUNIT($P(ECDSSU(JJ),"^",1))=$P(ECDSSU(JJ),"^",2)
 S ECD=ECSD F  S ECD=$O(^ECH("AC",ECD)) Q:'ECD  Q:ECD>ECED  D
 .S ECDA="" F  S ECDA=$O(^ECH("AC",ECD,ECDA)) Q:'ECDA  S EC=$G(^ECH(ECDA,0))  I $P(EC,"^",23)'="" D
 ..S ECDFN=$P(EC,"^")
 ..I $P(EC,"^",3)<ECSD!($P(EC,"^",3)>ECED) Q  ;file or x-ref problem
 ..S ECLOCA=+$P(EC,U,4),ECUNIT=+$P(EC,U,7)
 ..I '$D(NLOC(ECLOCA))!('$D(NUNIT(ECUNIT))) Q
 ..S ECRL=$P(EC,"^",23) Q:'$D(ECLINK(ECRL))  S ECR=ECLINK(ECRL),ECRN=$P($G(^ECR(ECR,0)),"^") Q:ECRN']""
 ..S ECP=$P(EC,U,9) Q:ECP']""
 ..S ECCAT=+$P(EC,U,8),ECPSY=+$O(^ECJ("AP",ECLOCA,ECUNIT,ECCAT,ECP,""))
 ..S ECPSYN=$P($G(^ECJ(ECPSY,"PRO")),"^",2),ECPI=""
 ..S ECFILE=$P(ECP,";",2),ECFILE=$S($E(ECFILE)="I":81,$E(ECFILE)="E":725,1:"UNKNOWN")
 ..S ECCPT=$S(ECFILE=81:+ECP,1:$P($G(^EC(725,+ECP,0)),"^",5))
 ..I ECCPT'="" D
 ...S ECPI=$$CPT^ICPTCOD(ECCPT,$P(ECED,".")) I +ECPI>1 S ECCPT=$P(ECPI,"^",2)_" "
 ..I ECFILE="UNKNOWN" S ECPN="UNKNOWN"
 ..I ECFILE=81 S ECPN=$S($P(ECPI,"^",3)]"":$P(ECPI,"^",3),1:"UNKNOWN")
 ..I ECFILE=725 S EC725=$G(^EC(725,+ECP,0)),ECPN=$P(EC725,"^",2)_" "_$P(EC725,"^")
 ..Q:ECPN=""
 ..S ECDESC=$J(ECCPT_" ",6)_$E(ECPN,1,40)_$S(ECPSYN]"":" ["_ECPSYN_"] ",1:"")
 ..S (ECPA,ECPATN,ECSS)="",ECPA=$G(^DPT(+$P(EC,"^",2),0)) Q:ECPA=""
 ..S ECPATN=$E($P(ECPA,"^",1),1,24),ECSS=$P(ECPA,"^",9)
 ..S:+ECSS ECSSN=$E(ECSS,6,9) S:ECSS="" ECSSN="UNKNOWN"
 ..S:ECPATN="" ECPATN="UNKNOWN" S ECPATN=ECPATN_"^"_ECSSN
 ..S (ECPRV,ECPRVN)="",ECPRV=$$GETPPRV^ECPRVMUT(ECDA,.ECPRVN),ECPRVN=$S(ECPRV:"UNKNOWN",1:ECPRVN)
 ..S ECMD="" I $O(^ECH(ECDA,"MOD",0))'="" D  ;ALB/JAM - Get CPT modifiers
 ...K ECMOD S ECMODF=$$MOD^ECUTL(ECDA,"I",.ECMOD),SEQ="" I 'ECMODF Q
 ...F  S SEQ=$O(ECMOD(SEQ)) Q:SEQ=""  S ECMD=ECMD_$S(ECMD="":"",1:";")_$P(ECMOD(SEQ),"^",2)
 ..I ECMD="" S ECMD="NOMOD"
 ..S ^TMP("ECREAS",$J,ECLOCA,ECUNIT,ECRN,$E(ECPN,1,15))=ECDESC
 ..S ^TMP("ECREAS",$J,ECLOCA,ECUNIT,ECRN,$E(ECPN,1,15),ECMD,ECDFN,ECD)=ECPRVN_"^"_ECPATN
 ..;where ecloca, ecunit,ecdfn are iens, ecdt is internal format
 Q
PRINT ;output report
 N ECLOCA,ECUNIT,ECREASN,ECDT,ECED2,ECSD2,ECPATN,ECPN,ECPRVN,SEQ,X,Y,SSN
 N PAGE,QFLAG,DASH,PRNTDT,JJ,SS,ALOC,AUNIT,DATE,LOC,UNIT,PTNAME,PROVN,ECDESC
 S (PAGE,QFLAG)=0 S $P(DASH,"-",80)=""
 S Y=$P(ECSD,".",1)+1 D DD^%DT S ECSD2=Y S Y=$P(ECED,".",1) D DD^%DT S ECED2=Y
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S PRNTDT=Y
 ;if no data exists then print the header and quit
 I '$D(^TMP("ECREAS",$J)) D  Q
 .S (LOC,UNIT)="" D HEAD
 .W !!,?6,"No data for the date range specified.",!!
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
 S LOC="" F  S LOC=$O(ALOC(LOC)) Q:LOC=""  S ECLOCA=ALOC(LOC) D  Q:QFLAG
 .S UNIT="" F  S UNIT=$O(AUNIT(UNIT)) Q:UNIT=""  S ECUNIT=AUNIT(UNIT) D  Q:QFLAG
 ..;always start a location at top of page
 ..I $D(^TMP("ECREAS",$J,ECLOCA,ECUNIT)) D HEAD D LOOP
 ;all done
 I $E(IOST)="C"&('QFLAG) S DIR(0)="E" D  D ^DIR W @IOF
 .S SS=22-$Y F JJ=1:1:SS W !
 W:$E(IOST)'="C" @IOF
 Q
LOOP ;print the section of the ^tmp global for a specific location/unit
 S ECREASN=""
 F  S ECREASN=$O(^TMP("ECREAS",$J,ECLOCA,ECUNIT,ECREASN)) Q:ECREASN=""  Q:QFLAG  D
 .D:($Y+3>IOSL) HEAD Q:QFLAG  W !!,"Reason: ",ECREASN,! S ECPN=""
 .F  S ECPN=$O(^TMP("ECREAS",$J,ECLOCA,ECUNIT,ECREASN,ECPN)) Q:ECPN=""  Q:QFLAG  D
 ..S ECDESC=$G(^TMP("ECREAS",$J,ECLOCA,ECUNIT,ECREASN,ECPN)),ECMOD=""
 ..F  S ECMOD=$O(^TMP("ECREAS",$J,ECLOCA,ECUNIT,ECREASN,ECPN,ECMOD)) Q:ECMOD=""  D  Q:QFLAG
 ...W !,?3,"Procedure: ",ECDESC D:ECMOD'="NOMOD" MODPRT Q:QFLAG  D LOOP1
 Q
LOOP1 S ECPATN="" F  S ECPATN=$O(^TMP("ECREAS",$J,ECLOCA,ECUNIT,ECREASN,ECPN,ECMOD,ECPATN)) Q:ECPATN=""  Q:QFLAG  D
 .S ECDT="" F  S ECDT=$O(^TMP("ECREAS",$J,ECLOCA,ECUNIT,ECREASN,ECPN,ECMOD,ECPATN,ECDT)) Q:ECDT=""  Q:QFLAG  D
 ..S ECPRVN=^(ECDT),PTNAME=$P(ECPRVN,"^",3),PTNAME=$E(PTNAME,1,22)
 ..S SSN=$P(ECPRVN,"^",4),ECPRVN=$P(ECPRVN,"^",2)
 ..S Y=ECDT D DD^%DT S DATE=$E(Y,1,18),PROVN=$E(ECPRVN,1,22)
 ..D:($Y+3>IOSL) HEAD Q:QFLAG  W !,?6,PTNAME,?30,SSN,?37,DATE,?57,PROVN
 W !
 Q
MODPRT ;ALB/JAM - print CPT procedure modifiers
 N MOD,I,MODESC,IEN,MODI
 W !?4,"Modifier: "
 F I=1:1 S IEN=$P(ECMOD,";",I) Q:IEN=""  D  I QFLAG Q
 . S MODI=$$MOD^ICPTMOD(IEN,"E",$P(ECED,".")),MOD=$P(MODI,"^",2) I MOD="" Q
 . S MODESC=$P(MODI,"^",3) I MODESC="UNKNOWN" Q
 . W:I>1 ! W ?18,"- ",MOD," ",MODESC I ($Y+3)>IOSL D HEAD
 Q
HEAD ;header
 I $E(IOST)="C" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PAGE>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLAG=1 Q
 W:$Y!($E(IOST)="C") @IOF
 S PAGE=PAGE+1
 W !,?12,"Event Capture Procedure Reason Report"
 W !,?12,"for the Date Range ",$$FMTE^XLFDT(ECSD2)," to ",$$FMTE^XLFDT(ECED2),!
 W !,?3,"DSS Unit: ",UNIT,?55,"Page: ",PAGE
 W !,?3,"Location: ",LOC,?52,"Printed: "_PRNTDT,!
 W !?6,"Patient",?30,"SSN",?37,"Date/Time",?57,"Provider"
 W !,DASH
 Q
EXIT ;common exit point
 D ^ECKILL D:'$D(ECGUI) ^%ZISC
 K ^TMP("ECREAS",$J) K JJ,X,Y,ZTSK,IO("Q"),DIR,DIRUT,DTOUT,DUOUT,ECSD
 K ECED,ECLOOP,ECLOC,ECDSSU,ECLINK,ASK,DIC
 Q
