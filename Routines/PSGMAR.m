PSGMAR ;BIR/CML3-24 HOUR MAR - MAIN DRIVER ;14 Oct 98 / 4:27 PM
 ;;5.0; INPATIENT MEDICATIONS ;**8,15,20,111,131,145**;16 DEC 97;Build 17
 ;
EN ;
 ;
 NEW PSGOP
 D ENCV^PSGSETU G:$D(XQUIT) DONE
 D MARFORM^PSGMUTL G:PSGMARB=0 DONE S:PSGMARB'=1 PSGMARS=3
 G:PSGMARB'=1 ENDATE F  R !!,"Print (C)ontinuous sheets, (P)RN sheets, or (B)oth? B// ",X:DTIME W:'$T $C(7) S:'$T X="^" Q:"^CPB"[X&($L(X)<2)  W:X'?1."?" $C(7),"  ??" D:X?1."?" SHTH
 G:X="^" DONE I X="" W "  (Both)" S PSGMARS=3
 E  W $S(X="C":"ontinuous",X="P":"RN",1:"oth") S PSGMARS=$F("CPB",X)-1
 ;
ENDATE ; get start date
 S %DT="ETX",Y=-1 F  W !!,"Enter START DATE/TIME for 24 hour MAR: " R X:DTIME W:'$T $C(7) S:'$T X="^" Q:"^"[X  D:X?1."?" DH D ^%DT Q:Y>0
 I Y'>0 W $C(7),!!?5,"(No date selected for MAR run.)" G DONE
 S PSGMARDT=+$E(Y,1,10) D:$P(PSGMARDT,".",2)
 .S PSGPLS=PSGMARDT,PSGPLF=$$EN^PSGCT(PSGPLS,-1),ST=$P(PSGPLS_0,".",2),FT=$P(PSGPLF_0,".",2)
 .S PSGMARSD=$E(ST,1,2),PSGMARFD=$E(FT,1,2) S:'PSGMARSD PSGMARSD="01" S PSGMARFD=$S(+PSGMARSD=1:24,PSGMARSD=PSGMARFD:PSGMARSD-1,1:PSGMARFD) S:$L(PSGMARFD)<2 PSGMARFD=0_PSGMARFD
 .I ST>1 S X1=$P(PSGPLF,"."),X2=1 D C^%DTC S PSGPLF=X
 .S PSGPLS=+(PSGPLS_"."_ST),PSGPLF=+(PSGPLF_"."_FT)
 .S PSGMARSP=$$ENDTC2^PSGMI(PSGPLS),PSGMARFP=$$ENDTC2^PSGMI(PSGPLF)
 D NOW^%DTC S PSGDT=%,(PSGMARWG,PSJPWDO)=0,PSGMARWD=+$G(PSJPWD),PSGRBPPN=""
 I '$D(PSGOENOF) S (PSGP,PSGPAT)=0,PSGSSH="MAR" D ^PSGSEL G:"^"[PSGSS OUT D @PSGSS G:$G(PSJSTOP) OUT
 G:$$MEDTYPE^PSJMDIR(PSGMARWD) OUT S PSGMTYPE=Y
 D DEV I POP!$D(IO("Q")) G DONE
 ;
ENQ ; when queued
 N F,P,DRGI,DRGN,DRGT,PSIVUP,PSJORIFN,PSGMSORT
 S PSJACNWP=1 U IO D ^PSGMAR0 I $D(^TMP($J))>9 D ^PSGMAR1
 ;DAM 5-01-07
 I $D(PSGREP) K ^XTMP(PSGREP)
 ;END DAM
 D ^%ZISC G DONE
 ;
OUT W $C(7),!!?5,"(No patient(s) selected for MAR run.)" K PSGPLF,PSGPLS
DONE ;
 I '$D(PSGOENOF) D ENKV^PSGSETU
 K AD,ASTERS,BD,BLN,C,CNTR,DA1,DA2,DAO,DFN,DRG,DX,EXPIRE,FD,FT,HX,L,LN1,LN14,LN2,LN3,LN4,LN5,LN6,LN7,MOS,MSG1,MSG2,ND2,NG,OPST,PSJJORD,PAGE,PN,PND,PNN,PPN,PRB,PSEX,PSSN,PSGPLF,PSGPLS,PSGPLC,PSGPLO,QX,TMSTR,XX
 K PSGADR,PSGALG,PSGD,PSGDW,PSGFORM,PSGMAR,PSGMARB,PSGMARDF,PSGMARDT,PSGMARED,PSGMARGD,PSGMARFD,PSGMARFP,PSGMAROC,PSGMARS,PSGMARSD,PSGL
 K PSGMARSM,PSGMARSP,PSGMARTS,PSGMARWD,PSGMARWG,PSGMARWN,PSGMARWS,PSGMPG,PSGMPGN,PSGORD,PSGPAT,PSJDIET
 K PSJSTOP,PSJPWDO,PSGMARO,ST,PSGSS,PSGSSH,PSTXDT,PST,PTM,PWDN,PSJACNWP,QST,R,RB,RCT,S,SD,SM,SPACES,TM,T,TD,TS,WD,WDN,WG,WGN,WS,WT,X1,X2,Y1,^TMP($J)
 K PSGST,PSGTM,PSGTMALL,XTYPE,PSGLRPH,PSGMTYPE,PSGPG,PSGMFOR,PSGMTYPE,PSGPG,PSGRBPPN,PSGS0XT,PSGS0Y
 K HT,ON,PSGOENOF,PSGOES,PSGRBPPN,PSGS0XT,PSGST,PSGTIR,PSGWD,XQUIT,ZTDES,ONHOLD
 D ENKV^PSGLOI
 Q
 ;
G ; get ward group
 S DIC="^PS(57.5,",DIC(0)="QEAMI",DIC("A")="Select WARD GROUP: " W ! D ^DIC K DIC D  I $G(PSJSTOP)=1 Q
 . I X="^OTHER" S PSGMARWG="^OTHER" Q
 . S PSGMARWG=+Y
 . I +Y'>0 S PSJSTOP=1
 D RBPPN^PSJMDIR
 Q
 ;
W ; get ward
 S DIC="^DIC(42,",DIC(0)="QEAMI",DIC("A")="Select WARD: " W ! D ^DIC K DIC S PSGMARWD=+Y I +Y'>0 S PSJSTOP=1 Q
 S PSGWD=PSGMARWD D ADMTM^PSJMDIR
 D:'PSJSTOP RBPPN^PSJMDIR
 Q
 ;
P ; get patient
 K PSGPAT S PSGPAT=0 F CNTR=0:1 S:CNTR PSGDICA="another" D ENP^PSGGAO:'PSGMARB,ENDPT^PSGP:PSGMARB Q:PSGP'>0  D
 . S PSGPAT(PSGP)="",PSGPAT=PSGP
 . ;*** PSGMARWD=1 when all patients are select from the same ward.
 . S:'$G(PSJPWDO) (PSGMARWD,PSJPWDO)=PSJPWD S PSGMARWD=$S('$G(PSGMARWD):0,PSJPWDO=PSJPWD:PSJPWD,1:0)
 S Y=PSGPAT S:Y'>0 PSJSTOP=1 K PSGDICA
 Q
 ;
C ;
 ;DAM Add new variable to hold numerical value of CLINIC 5-01-07
 S PSGCLNC=""
 K DIR S DIR(0)="FAO",DIR("A")="Select CLINIC: "
 S DIR("?")="^D CDIC^PSGVBW" W ! D ^DIR
CDIC ;
 K DIC S DIC="^SC(",DIC(0)="QEMIZ" D ^DIC K DIC S:+Y>0 CL=+Y S PSGCLNC=+Y I +Y<0 S PSJSTOP=1 Q
 W:X["?" !!,"Enter the clinic you want to use to select patients for processing.",!
 Q
L ;
 K DIR S DIR(0)="FAO",DIR("A")="Select CLINIC GROUP: "
 S DIR("?")="^D LDIC^PSGVBW" W ! D ^DIR
LDIC ;
 K DIC S DIC="^PS(57.8,",DIC(0)="QEMI" D ^DIC K DIC S:+Y>0 CG=+Y I +Y<0 S PSJSTOP=1 Q
 W:X["?" !!,"Enter the name of the clinic group you want to use to select patients for processing."
 Q
DEV ; ask print device and queue if asked to
 K ZTSAVE S PSGTIR="ENQ^PSGMAR",ZTDESC="24 HOUR MAR" S:PSGMARB ZTSAVE("PSGMARS")="" D
 . F X="PSGMARWG","PSGMARWD","PSGP","PSGPAT(","PSGDT","PSGMARDT","PSGSS","PSGMARB","PSGMARDF","PSGMTYPE","PSGRBPPN","^TMP($J,","PSGINCL","PSGINCLG","PSGINWD","PSGINWDG" S ZTSAVE(X)=""
 I $P(PSGMARDT,".",2) F X="PSGPLS","PSGPLF","PSGMARSD","PSGMARFD","PSGMARSP","PSGMARFP" S ZTSAVE(X)=""
 I PSGSS="W" F X="PSGTMALL","PSGTM","PSGTM(" S ZTSAVE(X)=""
 D ENDEV^PSGTI W:POP !!?3,"No device selected for 24 hour MAR run." W:$D(ZTSK) !?3,"24 hour MAR Queued!" K ZTSK Q
 I 'IO("Q") U IO
 ;
BH ;
 W !!,"  Enter a 'Y' to print BLANK (no data) MARs for the patient(s) you select.",!,"Enter an 'N' (or press the RETURN key) to print MARs complete with orders.",!,"Enter an  '^' to exit this option now." Q
 ;
DH ;
 W !!?2,"Enter the START DATE of the 24 hour period for which this MAR is to print.",!,"Unless the BLANK MARs are selected, all orders for the patient(s) selected that",!,"are (or were) active during the date range selected will print."
 W !?2,"Time is not required.  If time is not entered, the default time is used (if",!,"found in the site parameters).  If the default time is not found, the start of",!,"the day is used." Q
 ;
SHTH ;
 W !!?2,"Enter 'C' to print ONLY CONTINUOUS blank sheets for the patients selected.",!,"Enter 'P' to print ONLY PRN sheets.  Enter 'B' (or press RETURN) to print BOTH",!,"sheets for each patient." Q
 ;
ENLM ;
 S PSGOENOF=1,PSGPAT(PSGP)="",PSGSS="P" G EN
