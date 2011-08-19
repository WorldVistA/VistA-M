PSAHIS1 ;BIR/LTL,JMB-Drug Transaction History - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3,69,72**; 10/24/97;Build 2
 ;Prints the Show Drug Transaction History report in pharmacy location
 ;then date order. It is called by PSAHIS.
 ;
PRINT D HEADER S PSADRG="",PSACNT=0
 F  S PSADRG=$O(^TMP("PSAHIS",$J,PSADRG)) Q:PSADRG=""!(PSAOUT)  D:$Y+6>IOSL HEADER Q:PSAOUT  K PSABAL,PSATRCNT S PSADT=0 D  Q:PSAOUT
 .F  S PSADT=+$O(^TMP("PSAHIS",$J,PSADRG,PSADT)) Q:'PSADT!(PSAOUT)  D  Q:PSAOUT
 ..S PSATR=0 F  S PSATR=+$O(^TMP("PSAHIS",$J,PSADRG,PSADT,PSATR)) Q:'PSATR!(PSAOUT)  D:$Y+6>IOSL HEADER Q:PSAOUT  D TRANS
 .Q:PSAOUT  D:$Y+6>IOSL HEADER Q:PSAOUT  D TOTALS
 I 'PSACNT W !!,"No transactions were found for the pharmacy location."
 Q:PSAOUT
 ;
DONE ;Holds screen or ejects paper if sent to printer
 I $E(IOST,1,2)="C-" D
 .S PSAS=21-$Y F PSASS=1:1:PSAS W !
 .S DIR(0)="EA",DIR("A")="End of pharmacy location's display! Enter RETURN to continue or '^' to exit:" D ^DIR K DIR S:$G(DIRUT) PSAOUT=1
 I $E(IOST)'="C" W !!!,"REPORT RUN: ",PSARUN W @IOF
 Q
 ;
TRANS S PSATR0=$G(^PSD(58.81,PSATR,0)),PSACNT=1,PSATRCNT=$G(PSATRCNT)+1
 ;If it is first transaction for drug, print drug name & beg balance.
 ;Beg balance = 1st transaction + (receipts(+), adjs(+/-), &
 ;dispensing(-) made prior to beg date & fell within rpt date range)
 I PSATRCNT=1 D
 .W !,?37,"|",?48,"|",?54,"|",?60,"|",?71,"|" D WRAPDRUG
 .S Z=$G(^PSD(58.81,+^TMP("PSA",$J,PSADRG),0))
 .S PSABAL=$P(Z,"^",10)+$G(PSABAD(PSADRG)) W ?72,$J(PSABAL,7)
 ;
 ;Print transaction date & +/- qty from balance
 W !,$E(PSADT,4,5)_"-"_$E(PSADT,6,7)_"-"_$E(PSADT,2,3),?10,$E($P($G(^VA(200,+$P(PSATR0,"^",7),0)),"^"),1,28)
 I $P(PSATR0,"^",2)'=24,$P(PSATR0,"^",2)'=9 S PSABAL=$S(",1,10,11,19,"[(","_$P(PSATR0,"^",2)_","):PSABAL+$P(PSATR0,"^",6),1:PSABAL-$P(PSATR0,"^",6))  ;;<<3*72-RJS>>
 I $P(PSATR0,"^",2)=24!($P(PSATR0,"^",2)=9) S PSABAL=PSABAL+$P(PSATR0,"^",6)
 ;Receipts
 I $P(PSATR0,"^",2)=1 S PSAWRT=0 W ?37,"|",?41,$J($P(PSATR0,"^",6),6),?48,"|",?54,"|",?60,"|",?71,"|",?72,$J(PSABAL,7),! S PSARECT=$G(PSARECT)+$P(PSATR0,"^",6) D  Q
 .I $P($G(^PRC(442,+$P(PSATR0,"^",9),0)),"^") W ?11,"PO# ",$P($G(^(0)),"^"),?37,"|",?48,"|",?54,"|",?60,"|",?71,"|" S PSALN=$G(PSALN)+1 S PSAWRT=1
 .I $P($G(^PRCS(410,+$P(PSATR0,"^",8),0)),"^") W:PSAWRT ! W ?11,"TR# ",$P($G(^(0)),"^"),?37,"|",?48,"|",?54,"|",?60,"|",?71,"|" S PSALN=$G(PSALN)+1,PSAWRT=1
 .I $P($G(^PSD(58.81,PSATR,8)),"^",2)'="" W:PSAWRT ! W ?11,"ORD# ",$P($G(^(8)),"^",2),?37,"|",?48,"|",?54,"|",?60,"|",?71,"|" S PSALN=$G(PSALN)+1,PSAWRT=1
 .I $P($G(^PSD(58.81,PSATR,8)),"^")'="" W:PSAWRT ! W ?11,"INV# ",$P($G(^(8)),"^"),?37,"|",?48,"|",?54,"|",?60,"|",?71,"|" S PSALN=$G(PSALN)+1,PSAWRT=1
 .W:$G(PSAW) !?37,"|",?48,"|",?54,"|",?60,"|",?71,"|" K PSAW
 ;Adjusted or transferred
 I $P(PSATR0,"^",2)=9!($P(PSATR0,"^",2)=11)!($P(PSATR0,"^",2)=24) D  Q
 .W ?37,"|",?48,"|",?54,"|",?60,"|",?64,$J($P(PSATR0,"^",6),6),?71,"|",?72,$J(PSABAL,7)
 .I +$P(PSATR0,"^",19) S PSADJDT=$P(PSATR0,"^",19) W !?11,"DATE ENTERED: "_$E(PSADJDT,4,5)_"-"_$E(PSADJDT,6,7)_"-"_$E(PSADJDT,2,3),?37,"|",?48,"|",?54,"|",?60,"|",?71,"|"
 .I $P(PSATR0,"^",2)=9!($P(PSATR0,"^",2)=11),$P(PSATR0,"^",16)'="" D REASON
 .D:$P(PSATR0,"^",2)=24 TRANSFER S PSADJT=$G(PSADJT)+$P(PSATR0,"^",6)
 ;Dispensed by IP (2 means Unit Dose or Ward Stock 15 means IV)
 I $P(PSATR0,"^",2)=2!($P(PSATR0,"^",2)=15) W ?10,"NIGHTLY BACKGROUND JOB",?37,"|",?48,"|",?49,$J($P(PSATR0,"^",6),5),?54,"|",?60,"|",?71,"|",?72,$J(PSABAL,7) S PSAIPT=$G(PSAIPT)+$P(PSATR0,"^",6) Q
 ;Dispensed by OP
 I $P(PSATR0,"^",2)=6 W ?10,"NIGHTLY BACKGROUND JOB",?37,"|",?48,"|",?54,"|",?55,$J($P(PSATR0,"^",6),5),?60,"|",?71,"|",?72,$J(PSABAL,7) S PSAOPT=$G(PSAOPT)+$P(PSATR0,"^",6)
 ;Return Drug Credit
 I $P(PSATR0,"^",2)=10 W ?37,"|",?48,"|",?54,"|",?60,"|",?62,$J($P(PSATR0,"^",6),8),?71,"|",?72,$J($P(PSATR0,"^",10),7) S PSADJT=$G(PSADJT)+$P(PSATR0,"^",6) D REASON
 Q
 ;
HEADER ;Prints header info
 S PSAPG=PSAPG+1 I PSAPG=1,$E(IOST,1,2)="C-" W @IOF
 I $E(IOST,1,2)="C-",PSAPG>1 D  Q:PSAOUT
 .S PSAS=21-$Y F PSASS=1:1:PSAS W !
 .S DIR(0)="E" D ^DIR K DIR W:'$G(DIRUT) @IOF S:$G(DIRUT) PSAOUT=1
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),"^"),"." S PSAOUT=1 Q
 I PSAPG>1,$E(IOST)'="C" W @IOF
 W !?22,"D R U G   A C C O U N T A B I L I T Y",?71,"Page ",$J(PSAPG,2)
 W !?((42-$L(PSABDTR)-$L(PSARPDT))/2),"HISTORY OF DRUG TRANSACTIONS FROM ",PSABDTR," TO ",PSARPDT
 W !?((80-$L(PSALOCN))/2),PSALOCN
 W !!?37,"|",?48,"| DISPENSED |",?71,"|"
 W !,"DATE",?10,"INITIATOR",?37,"| RECEIVED |  IP |  OP | ADJUSTED | BALANCE"
 W !,PSADLN
 I $G(PSADRG)'=""&($G(PSATRCNT)) D WRAPDRUG W ?72,$J(PSABAL,7)
 Q
 ;
ALL ;Creates drug array with all drugs in location
 S PSA50=0 F  S PSA50=+$O(^PSD(58.8,PSALOC,1,PSA50)) Q:'PSA50  S:$P($G(^PSDRUG(PSA50,0)),"^")'="" ^TMP("PSADRG",$J,PSALOC,$P($G(^PSDRUG(PSA50,0)),"^"),PSA50)="",PSACNT=PSACNT+1
 Q
 ;
WRAPDRUG ;Prints drug name w/o spliting words
 I $L(PSADRG)<36 W !,"* ",PSADRG,?37,"|",?48,"|",?54,"|",?60,"|",?71,"|" Q
 S PSAPC1="" F PSAPCS=1:1 S PSAPC=$P(PSADRG," ",PSAPCS) Q:PSAPC=""  D
 .I $L(PSAPC1)+$L(PSAPC)+1<36 S PSAPC1=PSAPC1_PSAPC_" " Q
 .I $L(PSAPC1)+$L(PSAPC)+1>35 W !,"* "_PSAPC1,?37,"|",?48,"|",?54,"|",?60,"|",?71,"|" S PSAPC1=PSAPC_" "
 W:$L(PSAPC1) !?4,PSAPC1,?37,"|",?48,"|",?54,"|",?60,"|",?71,"|"
 Q
 ;
REASON ;Prints transaction reason w/o spliting words
 S PSAREA=$P(PSATR0,"^",16)
 I $L(PSAREA)<27 W !?11,PSAREA,?37,"|",?48,"|",?54,"|",?60,"|",?71,"|" Q
 S PSAPC1="" F PSAPCS=1:1 S PSAPC=$P(PSAREA," ",PSAPCS) Q:PSAPC=""  D
 .I $L(PSAPC1)+$L(PSAPC)+1<27 S PSAPC1=PSAPC1_PSAPC_" " Q
 .I $L(PSAPC1)+$L(PSAPC)+1>26 W !?11,PSAPC1,?37,"|",?48,"|",?54,"|",?60,"|",?71,"|" S PSAPC1=PSAPC_" "
 W:$L(PSAPC1) !?11,PSAPC1,?37,"|",?48,"|",?54,"|",?60,"|",?71,"|"
 Q
 ;
TRANSFER ;Prints transfer pharm loc that rec'd or sent drugs
 S PSATRANL=$P($G(^PSD(58.81,+$P(PSATR0,"^",17),0)),"^",3),PSAHOLD=PSALOC,PSAHOLDN=PSALOCN,PSALOC=PSATRANL
 I PSALOC="" S PSAREA="TRANSFER DATA MISSING" S PSALOC=PSAHOLD,PSALOCN=PSAHOLDN Q
 D SITES^PSAUTL1 S PSALOCN=$P(^PSD(58.8,PSALOC,0),"^")_PSACOMB
 S PSAREA="TRANSFER "_$S($P(PSATR0,"^",6)<0:"TO ",1:"FROM ") D TRAN
 S PSALOC=PSAHOLD,PSALOCN=PSAHOLDN
 S PSAPC1="" F PSAPCS=1:1 S PSAPC=$P(PSAREA," ",PSAPCS) Q:PSAPC=""  D
 .I $L(PSAPC1)+$L(PSAPC)+1<27 S PSAPC1=PSAPC1_PSAPC_" " Q
 .I $L(PSAPC1)+$L(PSAPC)+1>26 W !?11,PSAPC1,?37,"|",?48,"|",?54,"|",?60,"|",?71,"|" S PSAPC1=PSAPC_" "
 W:$L(PSAPC1) !?11,PSAPC1,?37,"|",?48,"|",?54,"|",?60,"|",?71,"|"
 Q
 ;
TRAN ;Prints transferred location w/o spliting words
 I $E(PSALOCN)="I" S PSAREA=PSAREA_"INPATIENT:"_$P($P(PSALOCN,":",2),"(IP)")
 I $E(PSALOCN)="O" S PSAREA=PSAREA_"OUTPATIENT:"_$P($P(PSALOCN,":",2),"(OP)")
 I $E(PSALOCN)="C" S PSAREA=PSAREA_"COMBINED:"_$P($P(PSALOCN,":",2),"(IP)")_"(IP)"_$P($P(PSALOCN,":",2),"(IP)",2)
 W !?11,$P(PSAREA,":")_":",?37,"|",?48,"|",?54,"|",?60,"|",?71,"|"
 S PSAREA=$P(PSAREA,": ",2)
 Q
 ;
TOTALS ;Prints totals
 W !?37,"|----------|-----|-----|----------|--------"
 W !?25,"DRUG TOTALS",?37,"|",?41,$J($G(PSARECT),6),?48,"|",$J($G(PSAIPT),5),?54,"|",$J($G(PSAOPT),5),?60,"|",?64,$J($G(PSADJT),6),?71,"|",!,PSADLN
 K PSADJT,PSAIPT,PSAOPT,PSARECT
 Q
