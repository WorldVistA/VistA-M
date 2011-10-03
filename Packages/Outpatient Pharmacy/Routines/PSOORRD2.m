PSOORRD2 ;BHAM-ISC/EJW - Remote Data Interoperability Order Checks - backdoor ;06/26/05
 ;;7.0;OUTPATIENT PHARMACY;**207,251,387**;DEC 1997;Build 13
 ;
DUP ;Remote order - duplicate drug
 N PSOD0,PSOD1,PSOREMX,RDIINST,FSIG,PSOULN,PSOLF,PSORDI
 S $P(PSOULN,"-",79)="",PSOT="DD"
 S PSORDI=0 F  S PSORDI=$O(^TMP($J,"DD",PSORDI)) Q:'PSORDI  S PSOD0=^TMP($J,"DD",PSORDI,0),PSOD1=^(1),PSOREMX=$P($P(PSOD0,"^",4),";"),RDIINST=$P(PSOD0,"^",5),PSOLF=$P(PSOD1,"^",3) D
 .W !,PSOULN,!
 .W "Duplicate Drug in Remote Rx:",!
 .W $J("Location Name: ",20)_RDIINST,!
 .W $J("Rx #: ",20)_$E(PSOREMX,1,$L(PSOREMX)-1),!
 .W $J("Drug: ",20)_$P(PSOD1,"^"),!
 .D FSIG(.FSIG)
 .W $J("SIG: ",20) F I=1:1 Q:'$D(FSIG(I))  W ?20,FSIG(I),!
 .W $J("QTY: ",20)_$P(PSOD1,"^",5),?44,$J("Refills remaining: ",20)_$P(PSOD1,"^",6)
 .W !,$J("Provider: ",20)_$P(PSOD1,"^",8),?44,$J("Issued: ",20)_$P(PSOD1,"^",9)
 .W !,$J("Status: ",20)_$P(PSOD1,"^",2),?44,$J("Last filled on: ",20)_PSOLF
 .W !?44,$J("Days Supply: ",20)_$P(PSOD1,"^",4)
 .W !,PSOULN,!
 .D PAUSE
 .S ^TMP($J,"PSORMDD",PSORDI,0)=1
 K PSOT
 Q
 ;
CLS ;Remote order - duplicate drug class
 N PSOD0,PSOD1,PSOREMX,RDIINST,FSIG,PSOULN,PSOLF,PSORDI
 S $P(PSOULN,"-",79)="",PSOT="DC"
 S PSORDI=0 F  S PSORDI=$O(^TMP($J,"DC",PSORDI)) Q:'PSORDI  S PSOD0=^TMP($J,"DC",PSORDI,0),PSOD1=^(1),PSOREMX=$P($P(PSOD0,"^",6),";"),RDIINST=$P(PSOD0,"^",7),PSOLF=$P(PSOD1,"^",3) D
 .W !,PSOULN,!
 .W "     *** SAME CLASS *** OF DRUG IN REMOTE RX FOR ",$P(PSOD1,"^"),!
 .W ">> ",RDIINST,!
 .W "CLASS: ",$P(PSOD0,"^"),!
 .W $J("Rx #: ",20)_$E(PSOREMX,1,$L(PSOREMX)-1),!
 .W $J("Status: ",20),$P(PSOD1,"^",2)
 .W ?44,$J("Issued: ",20),$P(PSOD1,"^",9)
 .D FSIG(.FSIG)
 .W !,$J("SIG: ",20) F I=1:1 Q:'$D(FSIG(I))  W ?20,FSIG(I),!
 .W $J("QTY: ",20),$P(PSOD1,"^",5),!
 .W $J("Provider: ",20),$P(PSOD1,"^",8)
 .W ?44,$J("Refills remaining: ",20),$P(PSOD1,"^",6)
 .W !?44,$J("Last filled on: ",20),PSOLF
 .W !?44,$J("Days Supply: ",20),$P(PSOD1,"^",4)
 .D PAUSE
 K PSOT
 Q
FSIG(FSIG) ;Format sig from remote site
 ;returned in the FSIG array
 N FFF,NNN,CNT,FVAR,FVAR1,FLIM,HSIG,II,I
 F I=0:1 Q:'$D(^TMP($J,PSOT,PSORDI,1,I))  S HSIG(I+1)=^(I)
FSTART S (FVAR,FVAR1)="",II=1
 F FFF=0:0 S FFF=$O(HSIG(FFF)) Q:'FFF  S CNT=0 F NNN=1:1:$L(HSIG(FFF)) I $E(HSIG(FFF),NNN)=" "!($L(HSIG(FFF))=NNN) S CNT=CNT+1 D  I $L(FVAR)>52 S FSIG(II)=FLIM_" ",II=II+1,FVAR=FVAR1
 .S FVAR1=$P(HSIG(FFF)," ",(CNT))
 .S FLIM=FVAR
 .S FVAR=$S(FVAR="":FVAR1,1:FVAR_" "_FVAR1)
 I $G(FVAR)'="" S FSIG(II)=FVAR
 I $G(FSIG(1))=""!($G(FSIG(1))=" ") S FSIG(1)=$G(FSIG(2)) K FSIG(2)
FQUIT Q
SIGNIF ;
 S DIR(0)="SA^1:YES;0:NO",DIR("A")="Do you want to Intervene? ",DIR("B")="Y" W ! D ^DIR
 I Y I '$D(PSORX("INTERVENE")) S PSORX("INTERVENE")=2
 I '$G(Y) K DIR,DTOUT,DIRUT,DIROUT,DUOUT,Y Q
 Q
 ;
PAUSE ;
 K DIR W ! S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue..." D ^DIR W ! K DIR
 Q
DRGINT ;DRUG-DRUG INTERACTION WITH ORDER FROM REMOTE SITE
 N PSOD0,PSOD1,PSOREMX,RDIINST,FSIG,PSOULN,PSOLF,PSOINT,PSORDI
 S $P(PSOULN,"-",79)="",PSOT="DI"
 S PSORDI=0 F  S PSORDI=$O(^TMP($J,"DI",PSORDI)) Q:'PSORDI  Q:$G(PSORX("DFLG"))  S PSOD0=^TMP($J,"DI",PSORDI,0),PSOD1=^(1),PSOREMX=$P($P(PSOD0,"^",8),";"),RDIINST=$P(PSOD0,"^",9),PSOLF=$P(PSOD1,"^",3) D
 .S PSOINT=$P(PSOD0,"^",4)
 .W !,PSOULN,!
 .W ">> ",RDIINST,!
 .W ?5,"** ",PSOINT," ** DRUG-DRUG interaction ",$P(PSOD0,"^",5)," & ",$P(PSOD0,"^",6),!
 .W ?5,"Remote RX # ",$E(PSOREMX,1,$L(PSOREMX)-1)," Drug: ",$P(PSOD1,"^"),!
 .W $J("Status: ",20),$P(PSOD1,"^",2)
 .W ?44,$J("Issued: ",20),$P(PSOD1,"^",9)
 .D FSIG(.FSIG)
 .W !,$J("SIG: ",20) F I=1:1 Q:'$D(FSIG(I))  W ?20,FSIG(I),!
 .W $J("QTY: ",20),$P(PSOD1,"^",5),!
 .W $J("Provider: ",20),$P(PSOD1,"^",8)
 .W !?44,$J("Refills remaining: ",20),$P(PSOD1,"^",6)
 .W !?44,$J("Last filled on: ",20),PSOLF
 .W !?44,$J("Days Supply: ",20),$P(PSOD1,"^",4)
 .I '$D(^XUSEC("PSORPH",DUZ)) Q  ; CLERK/TECH ENTRY
 .I PSOINT'="CRITICAL" D SIGNIF
 .I PSOINT="CRITICAL" D CRI
 K PSOT,PSORDI
 Q
 ;
CRI ;process new drug interactions entered by pharmacist
 K DIR S DIR("A",1)="",DIR("A",2)="Do you want to Process medication",DIR("A")=PSODRUG("NAME")_": ",DIR(0)="SA^1:PROCESS;0:ABORT ORDER ENTRY",DIR("B")="P"
 S DIR("?",1)="Enter '1' or 'P' to Activate medication",DIR("?")="      '0' or 'A' to Abort Order Entry process" D ^DIR K X1,DIR I 'Y S PSORX("DFLG")=1,DGI="" K DTOUT,DIRUT,DIROUT,DUOUT,PSORX("INTERVENE") Q
 D SIG^XUSESIG I X1="" K PSORX("INTERVENE") S PSORX("DFLG")=1 Q
 S PSORX("INTERVENE")=1
 K DUOUT,DTOUT,DIRUT,DIROUT
 Q
