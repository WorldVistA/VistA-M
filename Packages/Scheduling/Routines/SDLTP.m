SDLTP ;ALB/LDB - PRINT SCHEDULING LETTERS ; 11/27/00 1:53pm
 ;;5.3;Scheduling;**79,106,170,80,356,398**;Aug 13, 1993
R D EXIT S SD9=0,SDLT=1,DIC=407.6,DIC(0)="AEQMZ",DIC("A")="SELECT THE TYPE OF LETTER TO PRINT: ",DIC("S")="I ""^A^C^N^P^""[(""^""_$P($G(^(0)),U)_""^"")" D ^DIC G:Y'>0 EXIT S L0=Y(0,0) K DIC,DA
R1 R !,"PRINT LETTER ASSIGNED TO THE CLINIC(S)" S %=1 D YN^DICN G:'% HELP1 G:%<0 EXIT I %=1 S SDLET=0 G DIV
R2 K DIC,X,Y S DIC=407.5,DIC("S")="I $P(^(0),""^"",2)="_""""_L0_"""",DIC(0)="AEQMZ" D ^DIC G:Y'>0 EXIT S SDLET=+Y
DIV S SDLT1=SDLET,SDV1=$O(^DG(40.8,0)) K DIC,X,Y I $D(^DG(43,1,"GL")),$P(^("GL"),"^",2) S DIC=40.8,DIC(0)="AEQM" D @($S(L0="P":"PALST",L0="C":"CNLET",L0="N":"NSLET1",1:"PCNLET")_"^SDDIV") G:+Y<0 R S SDV1=+Y
 S VAUTD=0,VAUTD(SDV1)=$P(^DG(40.8,SDV1,0),"^"),SDFORM=0,SDTIME="*" I $D(^DG(40.8,SDV1,"LTR")),^("LTR") S SDFORM=1
L0 I L0="C" D IND G:$D(DTOUT)!(%=-1) R
 S VAUTNI=2 I "AP"[L0!(L0="C"&(SD9)) D PC G:S1=-1 R I "Pp"[S1 D PAT G R:Y<0,DATE
 S SDCONC="B" I L0="P" D NCOUNT^SDAL0 I SDCONC=U G R
 D NCLINIC^SDAL0 G:Y<0 R I VAUTC D EX G:%Y="^"!($D(DTOUT)) R I $D(X),X="^" G R
DATE N %DT I L0="P" S SDT00="AEF"
 D DATE^SDUTL G:POP&('$D(SDBD)) EXIT G:POP&(X="^") EXIT S:'$D(SDED) SDED=SDBD S L2=$S(L0="C"&('SD9):"BEG1^SDC0",L0="N":"BC^SDN1",L0="P":"^SDL1",1:"^SDCNL")
QUE S DGPGM=L2,DGVAR="SDCONC^SDLT^SDFORM^SDV1^SDLT1^SDLET^VAUTD#^SDBD^SDED"_$S($D(VAUTNALL):"^VAUTNALL",1:"")_$S($D(VAUTC):"^VAUTC#",1:"")_$S($D(VAUTN):"^VAUTN#",1:"")
 S DGVAR=DGVAR_$S(L2="^SDCNL":"^SD9",1:"^SDTIME")_$S($D(S1):"^S1",1:"")_$S($D(SDVAUTC):"^SDVAUTC#",1:"")
 D ZIS^DGUTQ G:POP EXIT
 U IO D @L2
EXIT K %,%Y,A2,BEGDATE,C,DIC,DGPGM,DGVAR,DIV,DIW,DIWF,DIWL,DIWR,DIWT,ENDDATE,ENDATE,L,LL,L0,L2,POP,S1,SD9,SDC,SDDAT,SDCL,SC,SDADD,SDARRAY,SDTADB,SDTADE,SDBD,SDCONC,SDCNT,SDD,SDED,SDHX,SDIV,SDFORM,SDLET,SDLT1,SDLT,SDMDT,SDT0,SDTIME,SDV,SDV1,SDX
 K SDX1,VAUTC,VAUTN,VAUTNI,VAUTD,SDVAUTC,X,XX,Y,W,Z0,Z5,^UTILITY("SDLT"),^UTILITY($J,"W"),^TMP($J,"BADADD") D CLOSE^DGUTQ Q
HELP W !,"LETTER TYPE MUST EXIST IN LETTERS TYPE FILE!" S DIC=407.6 K DIC("S") D ^DIC G R
HELP1 W !,"If you want to print another letter for the selected clinic(s), you must answer",!,"""N"""_" and select another letter of the appropriate type. If you do this, that ",!,"letter will print for (ALL) the selected clinic(s)." G R1
PC R !,"Enter 'P' for individual PATIENT letters or 'C' for letters by CLINIC: P// ",S1:DTIME S:S1["^"!('$T) S1=-1 Q:S1=-1  S:S1="" S1="P" I "PCpc"'[S1 W "??" D HELP2 G PC
 Q
HELP2 W !,"Entering 'P' will allow you to select PATIENT(S) and entering a 'C' will allow",!,"you to select CLINIC(S)." Q
PAT S VAUTNI=2,VAUTNALL=1 D PATIENT^VAUTOMA Q
EX S SDCNT=0 W !,"Do you want to exclude any Clinic(s)" S %=2 D YN^DICN I '% W !,"RESPOND YES OR NO" G EX
 K SDVAUTC Q:%-1
EXASK S DIC=44,DIC(0)="AEQM",DIC("S")="I $P(^(0),""^"",3)=""C"",'$G(^(""OOS""))",DIC("A")="Select Clinic to be excluded: " D ^DIC K DIC("A"),DIC("S") Q:"^"[X  G:Y<0 EXASK I $D(SDVAUTC(+Y)) W !,*7,"THIS CLINIC HAS ALREADY BEEN SELECTED!" G EXASK
 S SDCNT=SDCNT+1,SDVAUTC(+Y)="" W " ...OK" W:SDCNT'<10 !,*7,"ONLY TEN CLINICS ARE ALLOWED TO BE SELECTED!" G:SDCNT<10 EXASK
 Q
MAX W !,*7,"NO MORE THAN TEN CLINICS ALLOWED TO BE EXCLUDED" Q
IND S %=1,SD9=0 W !,"DID CLINIC CANCEL AVAILABILITY" D YN^DICN I '% D HLP3 G IND
 S:%-1 SD9=1 Q
HLP3 W !!,"If the clinic was cancelled for any length of time respond 'Y'.",!,"If individual appointments were cancelled without cancelling the clinic respond 'N'",! Q
 W !,"CLINIC CANCELLATION LETTERS will be selectable with 'C' response.",! Q
