PSGCAP ;BIR/CML3-ACTION PROFILE (#2) ;04 APR 96 / 1:10 PM
 ;;5.0; INPATIENT MEDICATIONS ;**111**;16 DEC 97
 N PSJNEW,PSGPTMP,PPAGE S PSJNEW=1
 ;
 D ENCV^PSGSETU I $D(XQUIT) Q
 ;
START ;
 S (PSGAP,PSGP,PSGAPWD,PSGAPWG)=0,(PSGAPWDN,PSGAPWGN)="",PSGSSH="AP" S PSGPTMP=0,PPAGE=1
 D ^PSGSEL G:PSGSS="^"!(PSGSS="") DONE D @PSGSS I (Y'="^OTHER"),(Y'>0) W !!?3,"No patient(s) selected.  Option terminated." G START
 ;
ORS I '$G(PSGAPWG) S PSGAPS="P" G ORS1
 S PSGAPS="T" I $S(PSGSS'="P":1,1:PSGPAT>1) F  W !!,"Sort Action Profiles by (T)eam or Treating (P)rovider? T// " R PSGAPS:DTIME D Q1 Q:PSGAPS]""
ORS1 G:PSGAPS="^" START D NOW^%DTC S PSGDT=% F N="START","STOP" D GDT G:$D(DIRUT) START
 F  W !!,"Print (A)ll active orders, or (E)xpiring orders only? A// " R PSGAPO:DTIME D Q2 Q:PSGAPO]""
 G:PSGAPO="^" START
 G:$$MEDTYPE^PSJMDIR($G(PSGWD)) START S PSGMTYPE=Y
 K ZTSAVE F X="PSGAPS","PSGAPO","PSGAPSD","PSGAPFD","PSGMTYPE","PSGP","PSGSS","PSGAPWD","PSGAPWG","PSGAPWDN","PSGAPWGN","PSGPAT(","PSGPTMP","PPAGE" S ZTSAVE(X)=""
 S PSGTIR="ENQ^PSGCAP0",ZTDESC="ACTION PROFILE" D ENDEV^PSGTI G:POP START G:$D(IO("Q")) DONE
 W !,"...this may take a few minutes...(you really should QUEUE this report)..." D ENQ^PSGCAP0
 ;
 ;
DONE ;
 D ENKV^PSGSETU K CA,CNTR,DIAG,DO,DRG,FD,LQ,N,NF,ND,ND2,PSJJORD,PAGE,PDOB,PN,PND,PSEX,PSGAP,PSGAPWD,PSGAPWDN,PSGAPWG,PSGAPWGN,PSGDICA,PSGPAT,PSGSS
 K PSGSSH,RB,RTE,SD,SI,SM,ST,STRT,STP,STT,WS,WT,S1,ZTOUT,PSGAPFD,PSGAPSD,PSGAPS,PSGAPO,PSJACNWP,PSJDLW,PSJOPC,PSJPWDO,PSGWD
 K PSGADR,PSGALG,PSGEXPDT,PSGMTYPE,PSJSI,PSJSTOP,PSJTEAM,PST,QST
 K ^TMP($J)
 Q
 ;
GDT ;
 K DIR NEW MINDT S:N="START" MINDT=PSGDT-.0001,DIR("B")="NOW" S:N="STOP" MINDT=PSGAPSD,DIR("B")=$$ENDD^PSGMI(PSGAPSD)
 S DIR(0)="DA^"_MINDT_":9999999.9999:EFTX",DIR("?")="^D DTM^PSGCAP",DIR("A")="Enter "_$S(N["R":"START",1:"STOP")_" date/time: " D ^DIR K DIR Q:$D(DIRUT)
 I X'="^" S:N["R" PSGAPSD=$S(Y'>0:PSGDT,Y#1:+$E(Y,1,12),1:Y+.0001) S:N["O" PSGAPFD=$S(Y'>0:9999999,Y#1:+$E(Y,1,12),1:Y+.24)
  Q
 ;
G ; get ward group
 S DIC="^PS(57.5,",DIC(0)="QEAMZ",DIC("A")="Select WARD GROUP: " W ! D ^DIC K DIC S:Y>0 PSGAPWG=+Y,PSGAPWGN=Y(0,0) I Y<0,X="^OTHER" D
 . S (Y,PSGAPWG,PSGAPWGN)="^OTHER",(PSGAPWD,PSGAPWDN)="zz"
 Q
 ;
C ;
 K DIR S DIR(0)="FAO",DIR("A")="Select CLINIC: "
 S DIR("?")="^D CDIC^PSGVBW" W ! D ^DIR
CDIC ;
 K DIC S DIC="^SC(",DIC(0)="QEMIZ" D ^DIC K DIC S:+Y>0 CL=+Y
 W:X["?" !!,"Enter the clinic you want to use to select patients for processing.",!
 Q
L ;
 K DIR S DIR(0)="FAO",DIR("A")="Select CLINIC GROUP: "
 S DIR("?")="^D LDIC^PSGVBW" W ! D ^DIR
LDIC ;
 K DIC S DIC="^PS(57.8,",DIC(0)="QEMI" D ^DIC K DIC S:+Y>0 CG=+Y
 W:X["?" !!,"Enter the name of the clinic group you want to use to select patients for processing."
 Q
W ; get ward
 S DIC="^DIC(42,",DIC(0)="QEAMZ",DIC("A")="Select WARD: " W ! D ^DIC K DIC S:Y>0 (PSGWD,PSGAPWD)=+Y,PSGAPWDN=Y(0,0) Q
 ;
P ; get patient
 K PSGPAT,PSJPWDO,PSGWD
 S PSGPAT=0 F CNTR=1:1 S:CNTR>1 PSGDICA="another" D ENP^PSGGAO Q:PSGP'>0  S PSGPAT(PSGP)="",PSGPAT=PSGPAT+1 S:'$G(PSJPWDO) (PSGWD,PSJPWDO)=PSJPWD S PSGWD=$S('$G(PSGWD):0,PSJPWDO=PSJPWD:PSJPWD,1:0)
 S Y=$S(PSGPAT:1,1:-1) K PSGDICA Q
 ;
DTM ;
 S Y=PSGDT D D^DIQ S T=$P(Y,"@",2),Y=$P(Y,",")
 W !!?2,"Enter a ",N," date.  If a time is not entered for the ",N," date, the",!,$S(N["R":"beginning",1:"end")," of the day is assumed and used."
 W !?2,"If you wish to enter a ",$S(N["R":"start",1:"stop")," date of ",Y,", you must enter a TIME of day",!,"of ",T," or greater.  Any date after ",Y," does not need time entered.",! S Y=-1 Q
 ;
Q1 ;
 W:'$T $C(7) S:'$T PSGAPS="^" Q:PSGAPS="^"
 I PSGAPS="" S PSGAPS="T" W "  (TEAM)" Q
 I PSGAPS?.E1C.E S PSGAPS="" W $C(7),"  ??" Q
 I PSGAPS?1."?" W !!?2,"Enter 'T' (or press RETURN) to sort and print patients by TEAM.  Enter 'P'",!,"to sort and print patients by treating PROVIDER." S PSGAPS="" Q
 F Q=1:1:$L(PSGAPS) I $E(PSGAPS,Q)?1L S PSGAPS=$E(PSGAPS,1,Q-1)_$C($A($E(PSGAPS,Q))-32)_$E(PSGAPS,Q+1,$L(PSGAPS))
 F X="TEAM","PROVIDER" I $P(X,PSGAPS)="" W $P(X,PSGAPS,2) S PSGAPS=$E(X) Q
 E  W $C(7),"  ??" S PSGAPS=""
 Q
 ;
Q2 ;
 W:'$T $C(7) S:'$T PSGAPO="^" Q:PSGAPO="^"
 I PSGAPO="" S PSGAPO="A" W "  (ALL)" Q
 I PSGAPO?.E1C.E S PSGAPO="" W $C(7),"  ??" Q
 I PSGAPO?1."?" W !!?2,"Enter 'A' (or press RETURN) to print ALL ACTIVE orders for the patient(s)",!,"selected.  Enter 'E' to print only orders that will EXPIRE within the date",!,"range selected for the patient(s) selected." S PSGAPO="" Q
 F Q=1:1:$L(PSGAPO) I $E(PSGAPO,Q)?1L S PSGAPO=$E(PSGAPO,1,Q-1)_$C($A($E(PSGAPO,Q))-32)_$E(PSGAPO,Q+1,$L(PSGAPO))
 F X="ALL","EXPIRING" I $P(X,PSGAPO)="" W $P(X,PSGAPO,2) S PSGAPO=$E(X) Q
 E  W $C(7),"  ??" S PSGPAS=""
 Q
ENLM ;Entry point for PSJ LM AP2 protocol
 N PSJNEW,PSGPTMP,PPAGE S PSJNEW=1
 S PSGPTMP=0,PPAGE=1
 D ENCV^PSGSETU I $D(XQUIT) Q
 S PSGPAT=PSGP,PSGPAT(DFN)="",(PSGAPWD,PSGAPWG)=0,(PSGAPWDN,PSGAPWGN)="",PSGSS="P",PSGAPS="T" D ORS1
 S PSJNKF=1 G DONE
