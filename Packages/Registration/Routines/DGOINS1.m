DGOINS1 ;ALB/MAC - OUTPUT FOR PATIENTS ADMITTED WITH UNKNOWN INSURANCE ; SEP 12 1988@1:00
 ;;5.3;Registration;**162**;Aug 13, 1993
START D NOW^%DTC S Y=$E(%,1,12),DGDT=$$FMTE^XLFDT(Y,1),(DGN,DGC,DGU,DGV)="",$P(DGCL,"*",81)="",L=1 F X=1:1:4 S DGS(X)=0
 I DGL="C" S DGW=0 F X1=0:0 S DGW=$O(^DPT("CN",DGW)) Q:DGW=""  F DFN=0:0 S DFN=$O(^DPT("CN",DGW,DFN)) Q:DFN=""  S DGCA=^(DFN) I $D(^DGPM(+DGCA,0)),$P(^DGPM(+DGCA,0),"^",2)=1 D UTIL
 I DGL="C" G PP
SR F DGD=DGBEG1:0 S DGD=$O(^DGPM("AMV1",DGD)) Q:(DGD="")!(DGD\1>DGEND1)  F DFN=0:0 S DFN=$O(^DGPM("AMV1",DGD,DFN)) Q:DFN=""  F DGCA=0:0 S DGCA=$O(^DGPM("AMV1",DGD,DFN,DGCA)) Q:DGCA=""  D UTIL
PP I '$D(^UTILITY($J,"DGM")) S DGD=1 W !,"=====>NO PATIENTS FOUND" G QUIT
 S DGDV=0 F K=0:0 S DGDV=$O(^UTILITY($J,"DGM",DGDV)) Q:DGDV=""!(DGU)  D TT Q:DGU  D HEAD S DGP=0 F DGJ=0:0 S DGP=$O(^UTILITY($J,"DGM",DGDV,DGP)) Q:DGP=""!(DGU)  S DGV=DGDV F DGD=0:0 S DGD=$O(^UTILITY($J,"DGM",DGDV,DGP,DGD)) Q:DGD=""!(DGU)  D LP
 G QUIT:DGU D TT G QUIT:DGU
 I DGS(3)>0!(DGS(4)>0) D MC
 F K=0:0 S K=$O(DGL(K)) Q:K=""!(DGU)  S DGL=DGL(K) W !!,"DIVISION: ",$P(DGL,"^",1),!!?10,"Number of unknown",?34,": ",$J($P(DGL,"^",3),5),!?9,"#Number of unanswered",?34,": ",$J($P(DGL,"^",2),5) I IOST?1"C-".E&($Y+7>IOSL) D RT,MC
 G QUIT:DGU I DGS(3)>0!(DGS(4)>0) W !!?5,"MEDICAL CENTER:",!?10,"Total number of unknown",?34,": ",$J(DGS(4),5),!?9,"#Total number unanswered",?34,": ",$J(DGS(3),5),!?36,"-----",!?29,"TOTAL",?34,": ",$J(DGS(4)+DGS(3),5) W !! D NT
QUIT D CLOSE^DGUTQ Q
LP F DFN=0:0 S DFN=$O(^UTILITY($J,"DGM",DGDV,DGP,DGD,DFN)) Q:DFN=""!(DGU)  D PRINT,CT
 Q
UTIL I $D(^DPT(DFN,.3)) Q:(DGSC=2)&($P(^(.3),"^",1)="Y")
 Q:'$D(^DGPM(DGCA,0))  S DGNO=^(0) S:DGL="C" DGD=$P(DGNO,"^",1) D INP^VADPT S X=+VAIN(4) K VAIN
 Q:'$D(^DIC(42,+X,0))  S Y=$P(^DIC(42,X,0),"^",11) G:Y="" UT Q:'VAUTD&('$D(VAUTD(Y)))
UT I $D(^DPT(DFN,.31)) S X=$P(^(.31),"^",11) Q:X="Y"!(X="N")
 S DGP=$P(^DPT(DFN,0),"^",1) S DGDV=$S(Y="":"ZNOT SPECIFIED",1:$P(^DG(40.8,Y,0),"^",1))
 S ^UTILITY($J,"DGM",DGDV,DGP,DGD,DFN)=""
 Q
CT I '$D(^DPT(DFN,.31)) S DGS(3)=DGS(3)+1,DGS(1)=DGS(1)+1 Q
 S X=$P(^DPT(DFN,.31),"^",11) I X="" S DGS(3)=DGS(3)+1,DGS(1)=DGS(1)+1 Q
 S DGS(4)=DGS(4)+1,DGS(2)=DGS(2)+1 Q
TT S DGV=$S(DGV="ZNOT SPECIFIED":"NOT SPECIFIED",1:DGV) I $Y+6>IOSL&(DGS(1)>0)!($Y+6>IOSL&(DGS(2)>0)) D:IOST?1"C-".E RT Q:DGU  S DGC=DGC+1 W @IOF,!?3,"DIVISION: ",DGV,?50,DGDT," PAGE ",DGC,!!?22,"DIVISION SUMMARY FOR" D HEAD2 W !!,DGCL
 I DGS(1)>0!DGS(2)>0 W !!!?3,"DIVISION: ",DGV,!?5,"Number of Unknown: ",$J(DGS(2),5),!?4,"#Number Unanswered: ",$J(DGS(1),5),?40 D NT S DGL(L)="",DGL(L)=DGV_"^"_DGS(1)_"^"_DGS(2),L=L+1,(DGS(1),DGS(2))=0 D:IOST?1"C-".E RT S DGC=0 Q
 S DGC=0 Q
PRINT I $Y+4>IOSL D:IOST?1"C-".E RT Q:DGU  D HEAD
 S X=+$P(^DPT(DFN,0),"^",3) I X S X=$$FMTE^XLFDT(X,"5DF"),X=$TR(X," ","0"),X=$TR(X,"/","-")
 D PID^VADPT6 W !,$S('$D(^DPT(DFN,.31)):"#",$P(^DPT(DFN,.31),"^",11)="":"#",1:" ")_DGP,?27 W:VA("PID")]"" VA("PID") W ?40,X,?52 W:$D(^DPT(DFN,"VET")) $J(^("VET")_$S(^("VET")="Y":"ES",^("VET")="N":"O",1:""),3)
 W ?57 S X=$P($S($D(^DPT(DFN,.3)):^(.3),1:""),"^",1),X=$P(X,"^",1) W:X]"" $J(X_$S(X="Y":"ES",1:"O"),3) W ?62 S Y=DGD X ^DD("DD") W $P(Y,"@",1)_"@"_$E($P(Y,"@",2),1,5)
 Q
HEAD S DGC=DGC+1 W @IOF,!?3,"DIVISION: ",$S(DGDV="ZNOT SPECIFIED":"NOT SPECIFIED",1:DGDV),?50,DGDT," PAGE ",DGC,!?31 D HEAD2
 W !!?3,"PATIENT",?30,"PT ID",?43,"DOB",?52,"VET",?58,"SC",?63,"ADMISSION DATE",!,DGCL
 Q
HEAD2 W " ACTIVE PATIENTS",!?23,"WITH UNKNOWN/UNANSWERED INSURANCE",!
 I DGL="C" S DGT="FOR "_$P(DGDT,"@",1)
 I DGL="D" S DGT=$S(DGBEG=DGEND:"FOR ",1:"FROM "),DGT=DGT_$$FMTE^XLFDT(DGBEG,"1D") I DGEND'=DGBEG S DGT=DGT_" TO "_$$FMTE^XLFDT(DGEND,"1D")
 S DGY=40-($L(DGT)/2) W ?DGY,DGT Q
RT F X=$Y:1:(IOSL-2) W !
 R !?22,"Enter <RET> to continue or ^ to QUIT",X:DTIME S:X["^"!('$T) DGU=1 Q:DGU=1
 Q
MC Q:DGU  W @IOF,!?60,DGDT,!?19,"MEDICAL CENTER TOTALS FOR" D HEAD2 W !,DGCL Q
NT W "# - Denotes prompt left blank by user" Q
