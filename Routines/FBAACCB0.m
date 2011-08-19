FBAACCB0 ;AISC/GRR-CLERK CLOSE BATCH CONTINUED ;5/12/1999
 ;;3.5;FEE BASIS;**5,4,116**;JAN 30, 1995;Build 30
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
LISTT S Q="",$P(Q,"=",80)="="
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
ENT S FBAAOUT=0
 D HEDP F J=0:0 S J=$O(^FBAAC("AD",B,J)) Q:J'>0!($G(FBAAOUT))  F K=0:0 S K=$O(^FBAAC("AD",B,J,K)) Q:K'>0!($G(FBAAOUT))  I $D(^FBAAC(J,3,K,0)) S Y(0)=^(0) D SETT
 K FBCAN,FBCANDT,FBCANR,FBCK,FBCKDT,FBCKINT,FBDIS
 Q
HEDP W ?23,"'+' Represents Cancellation Activity",!?4,"Patient Name",?36,"SSN",?49,"Date",?56,"Travel Amount",!,Q,! Q
WRTT I $Y+7>IOSL D ASKH:$E(IOST,1,2)["C-" Q:FBAAOUT  W @IOF D HEDP
 I A2'=".00" W !,$S($D(QQ):QQ_") ",1:""),$S($G(FBCAN)]"":"+",1:""),?4,N,?32,$E(S,1,3),"-",$E(S,4,5),"-",$E(S,6,10),?47,$E(D,4,5),"/",$E(D,6,7),"/",$E(D,2,3),?59,"$ ",$J(A2,4,2)  D PMNT^FBAACCB2 Q
SETT S N=$S($D(^DPT(J,0)):$P(^(0),"^",1),1:""),S=$S(N]"":$P(^(0),"^",9),1:""),A2=$P(Y(0),"^",3),D=$P(Y(0),"^",1) D FBCKT(J,K),WRTT Q
 Q
SETV S K=$S($D(^FBAA(162.1,A,0)):$P(^(0),"^",4),1:"")
ENV S (V,VID)="" I K]"" S V=$S($D(^FBAAV(K,0)):$P(^(0),"^",1),1:""),VID=$S(V]"":$P(^(0),"^",2),1:"")
 Q
ASKH S DIR(0)="E" D ^DIR K DIR S:'Y FBAAOUT=1 Q
GMORE F K=0:0 S K=$O(^FBAAC("AJ",B,FBIN,J,K)) Q:K'>0!(FBAAOUT)  F L=0:0 S L=$O(^FBAAC("AJ",B,FBIN,J,K,L)) Q:L'>0!(FBAAOUT)  F M=0:0 S M=$O(^FBAAC("AJ",B,FBIN,J,K,L,M)) Q:M'>0!(FBAAOUT)  D SET^FBAACCB
 Q
INTOT ;; HIPAA 5010 - count line items that have 0.00 amount paid
 ;I FBINOLD'=FBIN&(FBINTOT>0) W !!,?15,"Invoice #: "_FBINOLD_"   Totals: $ "_$J(FBINTOT,1,2) S FBINTOT=0 Q
 I +FBINOLD'=0,FBINOLD'=FBIN&(FBINTOT]"") W !!,?15,"Invoice #: "_FBINOLD_"   Totals: $ "_$J(FBINTOT,1,2) S FBINTOT=0 Q
 Q
Q K C,B,J,K,L,M,T,X,Y,FZ,A,A1,A2,B2,CPTDESC,DO,DA,DIC,DIRUT,DL,DR,DRX,DX,FBAACPT,FBAAOUT,FBIN,FBINOLD,FBINTOT,FBVP,FBTYPE,FBPV,N,Q,S,V,VID,ZIS,XY,ZS,FBMODLE,FBVCHDT
 K FBAC,FBAP,FBDX,FBFD,FBI,FBK,FBLISTC,FBPDT,FBSC,FBTD Q
FBCKT(J,K) ;set travel check variables
 ;j,k required variables j=DA(1),k=DA
 I 'J!('K) S (FBCAN,FBCK,FBCANDT,FBCANR,FBDIS,FBCKDT,FBCKINT)="" Q
 S FBCKIN=$G(^FBAAC(J,3,K,0))
 S FBCAN=$P(FBCKIN,"^",10),FBCK=$P(FBCKIN,"^",7),FBCANDT=$P(FBCKIN,"^",8),FBCANR=$P(FBCKIN,"^",9),FBDIS=$P(FBCKIN,"^",11),FBCKDT=$P(FBCKIN,"^",6),FBCKINT=$P(FBCKIN,"^",12)
 K FBCKIN Q
