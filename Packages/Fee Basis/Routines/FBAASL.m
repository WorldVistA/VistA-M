FBAASL ;AISC/CMR-SUSPENSE LETTERS CONT. ;4/28/93  10:59
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Allows selection of one/many/all Fee Programs and one/many/all
 ;letters to print.
 S DIR(0)="Y",DIR("A")="Print Denials only",DIR("B")="No" D ^DIR K DIR G END:$D(DIRUT) I Y S FBDEN=1
 S DIR(0)="Y",DIR("A")="Do you want to print letters for ALL Fee Basis programs",DIR("B")="No" D ^DIR K DIR G END:$D(DIRUT)  I Y S FBPRG=1 D
 .F J="I","O","P","C" S FBPRG(J)=""
SELP I 'FBPRG S DIR(0)="S^I:INPATIENT PAYMENT;O:OUTPATIENT PAYMENT;P:PHARMACY PAYMENT;C:CH NOTIFICATION/DENIAL",DIR("A")="Select PROGRAM to print letter for" D ^DIR K DIR G END:$D(DIRUT) S FBPRG(Y)=""
 I 'FBPRG S DIR(0)="Y",DIR("A")="Do you want to choose another Program",DIR("B")="No" D ^DIR K DIR G END:$D(DIRUT),SELP:Y
 S J="" F  S J=$O(FBPRG(J)) Q:J=""  S FBCTR=FBCTR+1
SELLT K FBERR I FBCTR>1 S DIR(0)="Y",DIR("A")="Do you want to choose a different letter for each of the PROGRAMS you have      selected",DIR("B")="No" D ^DIR K DIR G END:$D(DIRUT) S FBY=Y
 S DIC="^FBAA(161.3,",DIC(0)="AEQ",K=0
 D LTR:FBCTR=1!'FBY G END:$G(FBLOUT),SELLT:$G(FBERR) F J=1:1:FBCTR S K=$O(FBPRG(K)) D MULT:FBCTR>1&(FBY) G END:$G(FBLOUT),SELLT:$G(FBERR) S FBPRG(K)=+Y
 Q
END K FBPRG,FBCTR,J,K,FBLOUT,FBERR S FBAAOUT=1
 Q
MULT S DIC("A")="Select letter to print for "_$S(K="I":"Inpatient Payments",K="O":"Outpatient Payments",K="P":"Pharmacy Payments",K="C":"CH Notification/Denials")_":  " D LTR Q:$G(FBLOUT)!$G(FBERR)
 Q
LTR D ^DIC K DIC("A") S:$D(DUOUT)!($D(DTOUT))!(X="") FBLOUT=1 S:Y<0 FBERR=1
 Q
INDIV ;select pt and/or vendor to print suspension letters for
 D DT^DICRW S DFN="",U="^" W !! S DIC="^FBAAA(",DIC(0)="AEQMZ",DIC("A")="Select Patient (or RETURN to select all):" D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT)) END1 I Y>0 S DFN=+Y
 S DIC("A")="Select Vendor (or RETURN to select all):" D GETVEN^FBAAUTL1 K DIC,D0 G:$D(DTOUT)!($D(DUOUT)) END1
 G ^FBAASLP
END1 ;
 K DFN,FBV,DUOUT,DTOUT
 Q
