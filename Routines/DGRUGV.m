DGRUGV ;ALB/BOK - RUG/PAI TRANSMISSION ; 12 MAY 87 07:25
 ;;5.3;Registration;**89,159**;Aug 13, 1993
 S VATNAME="RUG-II" D ^VATRAN G QUIT:VATERR
 W !,*7,"This option will send the RUG/PAI data to the Austin DPC."
A S %=2 W !,"Are you sure you want to continue" D YN^DICN I '% W !,"REPLY (Y)ES OR (N)O" G A
 D START:%=1
QUIT K ^UTILITY($J),%,%DT,D,DA,DGBC,DGCON,DGCNT,DGD,DGED,DGFLG,DGLCO,DGI,DGP,DGPG,DGPGM,DGPT,DGROW,DGS,DGSD,DGVAR,DGXX,DGSDI,VAT,VATERR,VATNAME,DIE,DR,I,J,K,L,POP,S,X,XMDUZ,XMSUB,XMTEXT,XMY,Y Q
START K ^UTILITY($J) D LO^DGUTL R !,"Survey purpose: (A)dmission/transfer & CNH or (S)emi-annual? ",X:DTIME G QUIT:X[U,HELP:"AS"'[X S DGP=$S(X="A":1,X="S":2,1:0) G QUIT:'DGP
DATE D CLOSEOUT^DGRUG S DGCNT=0,%DT("A")="ASSESSMENT START DATE: ",%DT="AEP" D ^%DT K %DT("A") G QUIT:Y<0,CLOUT:Y<DGLCO,FUT:Y>DT S DGSD=Y-.1 S %DT(0)=DGSD,%DT("A")="END DATE: " D ^%DT K %DT("A") G QUIT:Y<0,FUT:Y>DT S DGED=Y
DEV S %ZIS("A")="Device to print errors on: ",DGVAR="DGP^DGSD^DGED^VAT#^DUZ",DGPGM="EN^DGRUGV" D ZIS^DGUTQ G:POP QUIT
EN D LO^DGUTL S (DGFLG,DGXX)="",(DGCNT,DGROW)=0,DGPG=1,$P(DGXX," ",106)=""
 ;If transmission date after cutover date (4/1/98) send 4 digit year.
 N DGRUGYTK
 S DGRUGYTK=$S(DT>2980401:1,1:0)
 F I=DGSD:0 S I=$O(^DG(45.9,"AP",DGP,I)) Q:I'>0!(I>DGED)  F J=0:0 S J=$O(^DG(45.9,"AP",DGP,I,J)) Q:J'>0  I $D(^DG(45.9,J,0)) S DGI=^(0),DGS=$S($D(^DG(45.9,J,"C")):+^("C"),1:"") D ERR:DGS'=2 I DGS=2 D SET:$D(DGFLG)
 I DGP=1 S DGP=3 D
 .F I=DGSD:0 S I=$O(^DG(45.9,"AP",DGP,I)) Q:I'>0!(I>DGED)  F J=0:0 S J=$O(^DG(45.9,"AP",DGP,I,J)) Q:J'>0  I $D(^DG(45.9,J,0)) S DGI=^(0),DGS=$S($D(^DG(45.9,J,"C")):+^("C"),1:"") D ERR:DGS'=2 I DGS=2 D SET:$D(DGFLG)
 I $D(^UTILITY($J,"DGRUG")) F DGBC=1:1:DGPG D ROUTER S XMSUB="RUG-II TRANSMISSION, MESSAGE # "_DGBC,XMTEXT="^UTILITY("_$J_",""DGRUG"","_DGBC_",1," D ^XMD
 G PERR
ROUTER F DGSDI=0:0 S DGSDI=$O(VAT(DGSDI)) Q:DGSDI'>0  S XMY(VAT(DGSDI))=""
 S XMDUZ=.5,XMY(DUZ)="" Q
SET S X="" F K=3:1:5 S L=$P(DGI,U,K) G ERR:L']"" S X=X_L
 S D=$P(DGI,U,2) D DAT S X=X_$P(DGI,U,6),D=$P(DGI,U,7) D DAT F K=8:1:21 S L=$P(DGI,U,K) G ERR:L']""&(DGP'=3)&(K'=9) S:(DGP=3)&(K=9)&(DGRUGYTK=1) L=" " S X=X_L
 S X=X_" " F K=23:1:28 S L=$P(DGI,U,K) G ERR:L']"" S X=X_L
 S X=X_"   " F K=32:1:35 S L=$P(DGI,U,K) G ERR:L']"" S X=X_L
 S X=X_"    " F K=40:1:57 S L=$P(DGI,U,K) G ERR:L']"" S X=X_L
 F K=63:1:67 S L=$P(DGI,U,K) G ERR:L']"" S X=X_$S($L(L)=4:L,$L(L)=3:"0"_L,$L(L)=2:"00"_L,1:"000"_L)
 F K=58:1:62 S L=$P(DGI,U,K) G ERR:L']"" S X=X_L
 F K=1:1:$S(DGRUGYTK=1:21,1:25) S X=X_" "
 S:DGROW+1>VAT("F") DGPG=DGPG+1,DGROW=0 S DGROW=DGROW+1,^UTILITY($J,"DGRUG",DGPG,1,DGROW,0)=$E(X_DGXX,1,130),DGCNT=DGCNT+1
 S DA=J,DR="80///4;83///"_DT,DIE="^DG(45.9," D ^DIE Q
ERR S:DGS=4 ^UTILITY($J,"TRANS",J)=DGI S:DGS'=4 ^UTILITY($J,"ERR",J)=DGI Q
PERR S X=132 X ^%ZOSF("RM")
 W @IOF,!?95,"Transmission Date: " S Y=DT D DT^DIQ W:($D(^UTILITY($J,"ERR"))!$D(^("TRANS"))) !!?5,"NAME",?40,"SSN",?55,"ASSESSMENT DATE",?80,"STATUS",! S I="",$P(I,"*",132)="" W I
 I $D(^UTILITY($J,"ERR")) W !!,"ERRORS",! F J=0:0 S J=$O(^UTILITY($J,"ERR",J)) Q:J'>0  S K=^(J) W !,$P(^DPT(+K,0),U,1),?38,$P(K,U,3),?55,$$FMTE^XLFDT($P(K,U,2),"5DZ"),?82 D STAT W S
 I $D(^UTILITY($J,"TRANS")) W !!,"RECORDS ALREADY TRANSMITTED",! F J=0:0 S J=$O(^UTILITY($J,"TRANS",J)) Q:J'>0  S K=^(J) W !,$P(^DPT(+K,0),U,1),?38,$P(K,U,3),?55,$$FMTE^XLFDT($P(K,U,2),"5DZ"),?82 D STAT W S
 W !!!,I,!!!,"NUMBER OF RECORDS SENT TO AUSTIN: ",DGCNT,!,"DATE RANGE SENT: " S Y=DGSD+.1 D DT^DIQ W " - " S Y=DGED D DT^DIQ W !,"ASSESSMENT PURPOSE: ",$S(DGP=2:"SEMI-ANNUAL",+DGP'=2:"ADMISSION/TRANSFER & CNH",1:""),@IOF
CLOSE D QUIT,CLOSE^DGUTQ
 Q
STAT S S=$S($D(^DG(45.9,J,"C")):+^("C"),1:""),S=$S(S=1:"COMPLETED",S=2:"CLOSED BUT MISSING DATA",S=3:"RELEASED",S=4:"TRANSMITTED",S=0:"OPEN",5:"INCOMPLETE",1:"NO STATUS") Q
DAT I DGRUGYTK=1 S D=$E(D,4,5)_$E(D,6,7)_($E(D,1,3)+1700),X=X_D Q
 S D=$E(D,4,5)_$E(D,6,7)_$E(D,2,3),X=X_D
 Q
HELP W !!,"Depending on type of survey being transmitted enter",!?5,"A - Admission/Transfer PAI Survey",!?5,"S - Semi-annual PAI survey",! G START
CLOUT W !!,*7,"Start date must be within current closeout cycle.",!,"Date must not be before " S Y=DGLCO D DT^DIQ W ".",!! G DATE
FUT W !!,*7,"Can not transmit for future dates",!! G DATE
