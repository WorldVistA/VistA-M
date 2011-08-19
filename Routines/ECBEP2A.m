ECBEP2A ;BIR/MAM,JPW-Batch Enter by Procedure (cont'd) ;1 May 96
 ;;2.0; EVENT CAPTURE ;**4,5,10,13,17,18,23,33,41,42,54,72,76**;8 May 96;Build 6
EN ;entry pt
 D HDR
 S CNT=0
PATS ; get patients
 W ! Q:ECOUT=1  K ECADD
 K DIC,DUOUT S DIC=2,DIC(0)="QEAMZ",DIC("A")=$S($D(ECPT):"Select Next Patient: ",1:"Select Patient: ")
 D ^DIC K DIC S OK=0
 I $D(DUOUT)!($D(DTOUT)) S ECOUT=1 Q
 I Y<0,CNT=0 S ECOUT=2 Q
 I Y<0 D  G:ECOUT'=2 PATS I ECOUT=2 D KILL Q
 .D LIST Q:ECOUT  Q:'$O(ECPT(0))  Q:$G(ECADD)="A"
 .S ECTWO=0 K ECHOICE D ^ECBEP2B S ECOUT=2
 I $O(ECPT(0)) S JJ="" F  S JJ=$O(ECPT(JJ)) Q:'JJ!(OK=1)  I +$G(ECPT(JJ))=+Y S OK=1 W !!,"Patient already selected.  Please select another patient.",!
 I OK=1 G PATS
 N YY,ECUP D  I $G(ECUP)="^" G PATS
 . S YY=Y,DFN=+Y D 2^VADPT S Y=YY I +VADM(6) D
 . . W !!,"WARNING ",VADM(7),!!
 . . R "Press Return to Continue or ^ to Deselect: ",ECUP:DTIME
 S CNT=CNT+1,CNT1=CNT,ECPT(CNT)=+Y_"^"_$P(Y,"^",2) D ASK
 G PATS
 ;
LIST ; list patients
 K ECADD
 W @IOF,!,"Patients Selected for Batch Entry: ",! F I=0:0 S I=$O(ECPT(I)) Q:'I  W:I#2 ! W:I#2=0 ?40 W I_".  "_$P(ECPT(I),"^",2)
 W !!,"Is this list correct ?  YES//  " R ECYN:DTIME I '$T!(ECYN="^") S ECOUT=1 Q
 S ECYN=$E(ECYN) S:ECYN="" ECYN="Y" I "YyNn"'[ECYN W !!,"Enter <RET> if this list is complete, or NO to add or delete",!,"patients on the list.",!!,"Press <RET> to continue  " R X:DTIME G LIST
 I "Yy"[ECYN Q:$O(ECPT(0))  D NOBODY Q:ECOUT
ADD W !!,"Add or Delete Patients ?  ADD//  " R ECADD:DTIME I '$T!(ECADD="^") S ECOUT=1 Q
 S ECADD=$E(ECADD) S:ECADD="" ECADD="A" I "AaDd"'[ECADD W !!,"Enter <RET> to make additions to the list, or D to delete a ",!,"patient from the list." K ECADD G ADD
 Q:ECADD="A"
DEL ; delete patients from list
 I '$D(ECPT(1)) D NOBODY Q:ECOUT  G LIST
 W !!,"Select Number:  " R X:DTIME I '$T!(X="^") S ECOUT=1 Q
 I X="" Q
 I '$D(ECPT(X)) W !!,"Select the number corresponding to the patient that you would like",!,"to remove from the list.",!!,"Press <RET> to continue  " R X:DTIME S ECMORE=1 D LIST Q:ECOUT  G DEL
 F I=X+1:1:CNT S ECPT(I-1)=ECPT(I)
 K ECPT(CNT),I S CNT=CNT-1
 W !!,"Patient deleted.",!!,"Press <RET> to continue " R X:DTIME
 G LIST
 Q
HDR ;
 W @IOF,!,"Location: ",ECLN
 W !,"DSS Unit: ",ECDN
 I $G(ECCN)]"" W !,"Category: ",ECCN
 W !,"Procedure: "_$S(ECCPT'="":ECPTCD_" ",1:"")_$E(ECPN,1,50)
 W $S(SYN'["NOT DEFINED":" ["_SYN_"]",1:"")_"  (#"_NATN_")"
 ;- Display CPT procedure Modifiers
 I ECCPT'="" N MOD S MOD="" F  S MOD=$O(ECMOD(ECCPT,MOD)) Q:MOD=""  D
 . W !?1,"Modifier: ","    - ",MOD," ",$E($P(ECMOD(ECCPT,MOD),U),1,55)
 W !,"Procedure Date: ",ECDATE
 W ! D DSP1416^ECPRVMUT(.ECPRVARY)
 W !
 Q
 ;
NOBODY ;No patients selected
 I $D(ECADD),ECADD="D" W !!,"You cannot delete patients when your patient list is empty."
 I $G(ECADD)'="D" W !!,"You have selected no patients."
 R !!,"Do you wish to quit?  Y//",X:DTIME S X=$E(X) I '$T!(X="^") S ECOUT=1 Q
 S:X="" X="Y" I "yY"[X S ECOUT=1 Q
 I "nN"'[X W !,"Answer ""N"" to continue selection, or enter return to quit",! G NOBODY
 Q
ADCAT ;add category/procedures for patients
 ;D ^ECBEN2A I ECOUT=1 Q
 ;W !!! K DIR,DIRUT,DA S DIR(0)="Y",DIR("A")="Do you want to enter another category and procedure for these patients" D ^DIR Q:$D(DIRUT)!'Y
 Q
KILL ;kill arrays and variables
 K ECSC,ECZEC,ECIR,ECDX,ECDXN,ECVST,ECINP,ECAO,ECPTSTAT,ECMST,ECHNC,ECCV
 K ECA,ECHOICE,ECJLP,ECPT,ECO,ECON,ECV,ECDXS,ECDXIEN,ECSHAD
 S ECOUT=0
 Q
ASK ; ask ord sect & vol
 W !!,"DSS Unit: "_ECDN,?50,"Category: "_ECCN,!
 W "Procedure: "_$S(ECCPT="":"",1:ECPTCD_" ")_$E(ECPN,1,50)
 W $S(SYN'["NOT DEFINED":" ["_SYN_"]",1:"")_"  (#"_NATN_")",!
 ;- Display CPT procedure Modifiers
 I ECCPT'="" N MOD S MOD="" F  S MOD=$O(ECMOD(ECCPT,MOD)) Q:MOD=""  D
 . W ?1,"Modifier: ","    - ",MOD," ",$E($P(ECMOD(ECCPT,MOD),U),1,55),!
 W "Patient: ",$P(ECPT(CNT),"^",2),!
 ;
 ;- Determine inpatient/outpatient status
 S ECPTSTAT=$$INOUTPT^ECUTL0(+$G(ECPT(CNT)),+$G(ECDT))
 I ECPTSTAT="" D INOUTERR^ECUTL0 Q
 ;
 ;- Determine patient eligibility
 I $$CHKDSS^ECUTL0(+$G(ECD),ECPTSTAT) D
 . I $$MULTELG^ECUTL0(+$G(ECPT(CNT))) S ECELIG=+$$ELGLST^ECUTL0
 . E  S ECELIG=+$G(VAEL(1))
 K VAEL
 ;
 ;- Display inpatient/outpatient status message
 D DSPSTAT^ECUTL0(ECPTSTAT)
 ;
O ; ord sect
 K DIC,DUOUT S DIC=723,DIC(0)="QEAMZ",DIC("A")="Ordering Section: "
 D ^DIC K DIC I Y<0 D DELPT(.CNT) Q
 S ECO=+Y,ECON=$P(Y,"^",2)
V ; vol
 S:'VOL VOL=1
 W !,"Volume: "_VOL_"//" R X:DTIME I '$T S ECOUT=1 Q
 I X="^" D DELPT(.CNT) Q
 S:X="" X=VOL I X'?1.2N!'X W !!,"Enter a whole number between 1 and 99." G V
 S ECV=X
DIAG ;diagnosis, in/outpatient, visit
 S (ECDX,ECDXN,ECINP,ECVST,ECSC,ECAO,ECIR,ECZEC,ECMST,ECHNC,ECCV)=""
 S ECDFN=$P(ECPT(CNT),U),ECSHAD=""
 I $P(ECPCE,"~",2)="N" G NODE
 D PCEQST^ECBEN2U
 I ECOUT D DELPT(.CNT) Q
NODE ;set node
 ;- Get associated clinic from event code screen and DSS ID if null
 S:$G(EC4)="" EC4=$P($G(^ECJ(+$O(^ECJ("AP",+ECL,+ECD,+ECC,$G(ECP),0)),"PRO")),"^",4)
 S EC4N=$S($P($G(^SC(+EC4,0)),"^")]"":$P(^(0),"^"),1:"NO ASSOCIATED CLINIC"),ECID=$P($G(^SC(+EC4,0)),"^",7)
 S ECPT(CNT)=ECPT(CNT)_"^"_ECO_"^"_ECON_"^"_ECV_"^"_ECDX_"^"_$S(ECINP="":$G(ECPTSTAT),1:ECINP)_"^"_ECVST_"^"_ECSC_"^"_ECAO_"^"_ECIR_"^"_ECZEC_"^"_EC4_"^"_ECID_"^"_ECMST_"^"_ECHNC_"^"_ECCV_"^"_ECSHAD
 I $D(ECDXS) M ECPT(CNT,"DXS")=ECDXS K ECDXS
 S ECELPT(CNT)=$S($G(ECELIG):ECELIG,1:"") K ECPTSTAT
 Q
 ;
DELPT(CNT) ;deselect patient due to missing required data
 N DIR,Y
 K ECPT(CNT) S CNT=CNT-1
 W !,"Required data missing.",!,"Patient deselected...",!
 S ECOUT=0
 S DIR(0)="E",DIR("A")="Press RETURN to continue"
 D ^DIR
 W !
 Q
