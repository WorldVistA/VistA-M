ECBEN1B ;BIR/MAM,JPW-Batch Enter Procedures (cont'd) ;1 May 96
 ;;2.0; EVENT CAPTURE ;**4,5,10,13,17,23,41,42,50,54,72,76**;8 May 96;Build 6
EN ;entry pt
 D HDR
 S CNT=0
PATS ; get patients
 W ! Q:ECOUT=1  K ECADD
 K DIC,DUOUT S DIC=2,DIC(0)="QEAMZ",DIC("A")=$S($D(ECPT):"Select Next Patient: ",1:"Select Patient: ")
 D ^DIC K DIC S OK=0
 I $D(DUOUT)!($D(DTOUT)) S ECOUT=1 Q
 I Y<0,CNT=0 S ECOUT=2 Q
 I Y<0 D  G PATS
 .D LIST Q:ECOUT=1  Q:'$O(ECPT(0))  Q:$G(ECADD)="A"
 .S ECTWO=0 K ECHOICE D ^ECBEN2A
 .I ECOUT=2 D KILL,HDR
 I $O(ECPT(0)) S JJ="" F  S JJ=$O(ECPT(JJ)) Q:'JJ!(OK=1)  I +$G(ECPT(JJ))=+Y S OK=1 W !!,"Patient already selected.  Please select another patient.",!
 I OK=1 G PATS
 N YY,ECUP D  I $G(ECUP)="^" G PATS
 . S YY=Y,DFN=+Y D 2^VADPT S Y=YY I +VADM(6) D
 . . ; NOIS MWV-0603-21781:line below changed by VMP.
 . . W !!,"WARNING "_"[PATIENT DIED ON "_$P(VADM(6),U,2)_"] ",!!
 . . R "Press Return to Continue or ^ to Deselect: ",ECUP:DTIME
 S CNT=CNT+1,CNT1=CNT,ECPT(CNT)=+Y_"^"_$P(Y,"^",2) D DIAG
 G PATS
 ;
LIST ; list patients
 K ECADD
 W @IOF,!,"Patients Selected for Batch Entry: ",! F I=0:0 S I=$O(ECPT(I)) Q:'I  W:I#2 ! W:I#2=0 ?40 W I_".  "_$P(ECPT(I),"^",2)
 W !!,"Is this list correct ?  YES//  " R ECYN:DTIME I '$T!(ECYN="^") S ECOUT=1 Q
 S ECYN=$E(ECYN) S:ECYN="" ECYN="Y" I "YyNn"'[ECYN W !!,"Enter <RET> if this list is complete, or NO to add or delete",!,"patients on the list.",!!,"Press <RET> to continue  " R X:DTIME G LIST
 I "Yy"[ECYN Q:$O(ECPT(0))  D NOBODY Q:ECOUT
ADD W !!,"Add or Delete Patients ?  ADD//  " R ECADD:DTIME I '$T!(ECADD="^") S ECOUT=1 Q
 S ECADD=$E(ECADD) S:ECADD="" ECADD="A" I "AaDd"'[ECADD W !!,"Enter <RET> to make additions to the list, or ""D"" to delete a ",!,"patient from the list." G ADD
 I "Aa"[ECADD Q
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
 W @IOF,!,"Location: "_ECLN
 W !,"DSS Unit: "_ECDN
 W !,"Ordering Section: ",ECON
 W !,"Procedure Date: ",ECDATE,!
 D DSP1416^ECPRVMUT(.ECPRVARY)
 W !
 Q
 ;
NOBODY ;No patients selected
 I $D(ECADD),ECADD="D" W !!,"You cannot delete patients when your patient list is empty."
 I $G(ECADD)'="D" W !!,"You have selected no patients."
 R !!,"Do you wish to quit?  Y//",X:DTIME S X=$E(X) I '$T!(X="^") S ECOUT=1 Q
 S:X="" X="Y" I "yY"[X S ECOUT=1 Q
 I "nN"'[X W !,"Answer N to continue selection, or enter return to quit",! G NOBODY
 Q
 ;
ADCAT ;add category/procedures for patients
 D ^ECBEN2A I ECOUT=1 Q
 Q
KILL ;kill arrays
 K ECA,ECHOICE,ECJLP,ECPT,ECC,ECCN,ECP,ECPN,ECV,NATN,NODE,SYN,SYS,VOL
 K ^TMP("ECPRO",$J),ECDX,ECDXN,ECINP,ECVST,ECSC,ECAO,ECIR,ECZEC,EC4,EC4N
 K ECID,ECMST,ECDXS,ECDXIEN,ECHNC,ECCV,ECSHAD
 S ECOUT=0
 Q
DIAG ;ask dx, etc. questions
 S (ECDX,ECDXN,ECINP,ECVST,ECSC,ECAO,ECIR,ECZEC,ECMST,ECHNC,ECCV)=""
 S ECDFN=$P(ECPT(CNT),U),ECSHAD=""
 ;- Determine inpatient/outpatient status
 S ECPTSTAT=$$INOUTPT^ECUTL0(+$G(ECPT(CNT)),+$G(ECDT))
 I ECPTSTAT="" D INOUTERR^ECUTL0 Q
 ;- Determine patient eligibility
 I $$CHKDSS^ECUTL0(+$G(ECD),ECPTSTAT) D
 . I $$MULTELG^ECUTL0(+$G(ECPT(CNT))) S ECELIG=+$$ELGLST^ECUTL0
 . E  S ECELIG=+$G(VAEL(1))
 K VAEL
 D DSPSTAT^ECUTL0(ECPTSTAT)
 I '$D(EC4) S EC4="",EC4N="NO ASSOCIATED CLINIC"
 I '$D(ECID) S ECID=""
 I $P(ECPCE,"~",2)="N" G SETDX
 D PCEQST^ECBEN2U
 I ECOUT D DELPT(.CNT) Q
SETDX ;set dx, etc. in pat array
 S EC4N=$S($P($G(^SC(+EC4,0)),"^")]"":$P(^(0),"^"),1:"NO ASSOCIATED CLINIC"),ECID=$P($G(^SC(+EC4,0)),"^",7)
 S ECPT(CNT)=ECPT(CNT)_"^"_ECDX_"^"_$S(ECINP="":$G(ECPTSTAT),1:ECINP)_"^"_ECVST_"^"_ECSC_"^"_ECAO_"^"_ECIR_"^"_ECZEC_"^"_EC4_"^"_ECID_"^"_ECMST_"^"_ECHNC_"^"_ECCV_"^"_ECSHAD
 I $D(ECDXS) M ECPT(CNT,"DXS")=ECDXS K ECDXS
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
