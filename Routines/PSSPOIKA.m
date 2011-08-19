PSSPOIKA ;BIR/RTR-Orderable Item reports ;09/01/98
 ;;1.0;PHARMACY DATA MANAGEMENT;**15,38**;9/30/97
 S PSSITE=+$O(^PS(59.7,0)) I +$P($G(^PS(59.7,PSSITE,80)),"^",2)<2 W !!?3,"Orderable Item Auto-Create has not been completed yet!",! K PSSITE,DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR Q
 ;
 K DIR,PSSITE S DIR(0)="S^M:Drugs that are matched;N:Drugs that are not matched",DIR("A",1)="Enter M to see all the IV Solutions, IV Additives, and Dispense Drugs that"
 S DIR("A",2)="are matched to an Orderable Item. Enter N to see all IV Additives, IV",DIR("A",3)="Solutions, and Dispense Drugs that are not matched to an Orderable Item.",DIR("A",4)="",DIR("A")="Enter M or N"
 D ^DIR K DIR G:Y["^"!($D(DTOUT))!($D(DUOUT)) END
 S PSREP=$S(Y="M":1,1:0)
 W $C(7),!!!,"** WARNING **  THIS REPORT MAY BE VERY LONG  ** WARNING **"
 D KMES^PSSPOIM1
 W !!,"This report must be QUEUED to a printer!"
QUE W ! K %ZIS,IOP,ZTSK S %ZIS("B")="",%ZIS="QM" D ^%ZIS I POP G END
 I $E(IOST)["C" W $C(7),!?5,"This report must be QUEUED to a printer, enter Q at Device prompt!",! G QUE
 ;!('$D(IO("Q")))
 S ZTRTN=$S(PSREP:"MATCH^PSSPOIKA",1:"NOT^PSSPOIKA"),ZTDESC=$S(PSREP:"Matched Orderable Item Report",1:"Not matched Drug report") D ^%ZTLOAD K IO("Q")
END K AA,BB,CC,DOSE,DTOUT,DUOUT,EE,GFLAG,LIN,MM,NDNODE,NME,NN,PSPOI,PSREP,REA,Y,ZFG,ZFLAG,RR,SS,ZZ,PAGE,KK,LL,TT,WW,VV,PSDIS D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" Q
MATCH ; drugs that are matche
DIS S PAGE=1,$P(LIN,"-",79)="",(ZFG,GFLAG)=0 D DHEAD
 S MM="" F  S MM=$O(^PS(50.7,"ADF",MM)) Q:MM=""  F NN=0:0 S NN=$O(^PS(50.7,"ADF",MM,NN)) Q:'NN  F TT=0:0 S TT=$O(^PS(50.7,"ADF",MM,NN,TT)) Q:'TT  I $P($G(^PS(50.7,TT,0)),"^",3)'=1,$D(^PSDRUG("ASP",TT)) D  D ADD,SOL
 .S NME=$P($G(^PS(50.7,TT,0)),"^"),DOSE=$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^")
 .S:($Y+6)>IOSL ZFG=1 D:ZFG DHEAD
 .W:'ZFG !,LIN,!,"("_TT_") "_NME,"   ",DOSE S ZFG=0
 .F LL=0:0 S LL=$O(^PSDRUG("ASP",TT,LL)) Q:'LL  D
 ..S:($Y+4)>IOSL GFLAG=1 D:GFLAG DHEAD W !?2,"("_LL_")",?9,"Dispense Drug -> ",$P($G(^PSDRUG(LL,0)),"^")
 W @IOF G END
ADD S RR="" F  S RR=$O(^PS(52.6,"AOI",TT,RR)) Q:'RR  S PSPOI=$P($G(^PS(52.6,RR,0)),"^",11) I PSPOI,$D(^PS(50.7,PSPOI,0)) D
 .S:($Y+6)>IOSL GFLAG=1 D:GFLAG DHEAD W !,?2,"("_RR_")",?9,"Additive -> ",$P(^PS(52.6,RR,0),"^")
 Q
SOL S EE="" F  S EE=$O(^PS(52.7,"AOI",TT,EE)) Q:'EE  S PSPOI=$P($G(^PS(52.7,EE,0)),"^",11) I PSPOI,$D(^PS(50.7,PSPOI,0)) D
 .S:($Y+6)>IOSL GFLAG=1 D:GFLAG DHEAD W !,?2,"("_EE_")",?9,"Solution -> ",$P(^PS(52.7,EE,0),"^"),"   ",$P($G(^(0)),"^",3)
 Q
DHEAD W @IOF W !?5,"ORDERABLE ITEM - DISPENSE DRUG  (MATCHED REPORT)",?68,"PAGE: ",PAGE,!,LIN S PAGE=PAGE+1
 I ZFG W !!,"("_TT_") "_NME,"   ",DOSE Q
 I GFLAG W !!,"("_TT_") "_NME,"   ",DOSE," cont."
 S GFLAG=0 Q
NOT ;not matched
NDIS K ^TMP("PSS",$J)
 S PAGE=1,$P(LIN,"-",79)="" D NDHEAD
 S CC="" F  S CC=$O(^PSDRUG("B",CC)) Q:CC=""  F EE=0:0 S EE=$O(^PSDRUG("B",CC,EE)) Q:'EE  I '$P($G(^PSDRUG(EE,2)),"^") D  D NADD,NSOL W !,LIN
 .S REA="" S NDNODE=$G(^PSDRUG(EE,"ND")) I $P(NDNODE,"^"),$P(NDNODE,"^",3) S DA=$P($G(NDNODE),"^"),X=$$VAGN^PSNAPIS(DA) I $G(X)'=0,$L(X)>40 S REA="(VA Generic name > 40 characters)"
 .I REA="" S REA=$S('$P($G(NDNODE),"^"):"(Not matched to NDF)",'$P($G(NDNODE),"^",3):"(No VA Product name entry)",$G(X)=0:"(Invalid NDF match for this drug)",1:"")
 .D:($Y+5)>IOSL NDHEAD W !,"("_EE_") "_$P($G(^PSDRUG(EE,0)),"^"),"   ",$G(REA)
 W @IOF G FINAL
NADD ;
 S AA="" F  S AA=$O(^PS(52.6,"B",AA)) Q:AA=""  F SS=0:0 S SS=$O(^PS(52.6,"B",AA,SS)) Q:'SS  S PSPOI=$G(^PS(52.6,SS,0)) I '$P(PSPOI,"^",11) S:$P(PSPOI,"^",2)="" ^TMP("PSS",$J,AA,SS)="A" I $P(PSPOI,"^",2)=EE D
 .S PSDIS=0,PSDIS=$P($G(^PS(52.6,SS,0)),"^",2)
 .D:($Y+6)>IOSL NDHEAD W !,?2,"("_SS_") "_$P($G(^PS(52.6,SS,0)),"^")," -> ",$S(PSDIS:$P($G(^PSDRUG(PSDIS,0)),"^"),1:"(not matched to a Dispense Drug)")," (A)"
 Q
NSOL ;
 S BB="" F  S BB=$O(^PS(52.7,"B",BB)) Q:BB=""  F ZZ=0:0 S ZZ=$O(^PS(52.7,"B",BB,ZZ)) Q:'ZZ   S PSPOI=$G(^PS(52.7,ZZ,0)) I '$P(PSPOI,"^",11) S:$P(PSPOI,"^",2)="" ^TMP("PSS",$J,BB,ZZ)="S" I $P(PSPOI,"^",2)=EE D
 .D:($Y+6)>IOSL NDHEAD W !,?2,"("_ZZ_") "_$P($G(^PS(52.7,ZZ,0)),"^"),"   ",$P($G(^(0)),"^",3)_" (S)"
 Q
FINAL S PAGE=1 D NASH
 S AA="" F  S AA=$O(^TMP("PSS",$J,AA)) Q:AA=""  F RR=0:0 S RR=$O(^TMP("PSS",$J,AA,RR)) Q:'RR  D:($Y+6)>IOSL NASH W !,"("_RR_")",?9,AA,"   ("_$G(^TMP("PSS",$J,AA,RR))_")","  (Not matched to a dispense drug)"
 W @IOF G END
NASH W @IOF W !?5,"ADDITIVES/SOLUTIONS NOT MATCHED TO AN ORDERABLE ITEM",?68,"PAGE: ",PAGE,!,LIN S PAGE=PAGE+1
 Q
NDHEAD W @IOF W !?5,"DISPENSE DRUGS  (NOT MATCHED TO ORDERABLE ITEM)",?68,"PAGE: ",PAGE,!,LIN S PAGE=PAGE+1
 Q
