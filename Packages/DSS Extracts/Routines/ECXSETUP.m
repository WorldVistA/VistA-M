ECXSETUP ;ALB/JAP,BIR/DMA,CML,PTD-Generate Patient Population for a Given Day ; [ 11/25/96  11:26 AM ]
 ;;3.0;DSS EXTRACTS;**11,8,24**;Dec 22, 1997
EN ;entry point from option
 ;Pick a day, find everyone who was in the hospital on that day,
 ;find the corresponding admission and the last transfer and treating
 ;speciality change
 ;This routine should only be run once
 I '$D(DT) S DT=$$HTFM^XLFDT(+$H)
 I $P($G(^ECX(728,1,"S")),U,2)]"" W !,"The setup extract is already running.",! Q
 I $P($G(^ECX(728,1,"S")),U) W !,"The setup extract has already been run.",! Q
 W !!,"This option will extract the admission data and data for the last",!,"transfer and treating specialty change for all patients who",!,"were in the hospital on the day you select.",!!
 W !!,"NOTE - This will generate a snapshot of your inpatient population on the",!,"BEGINNING of the day you select, not the end of the day as MAS reports do.",!
 W "For example, for the inpatient setup extract if you choose October 1, 1994,",!,"the report will start at midnight at the beginning of the day."
 W "  For the MAS",!,"report, you would choose September 30, 1994.  The MAS report begins at midnight",!,"at the end of the day.",!!!
 S Y=$E(DT,1,3) S:'$E(DT,4) Y=Y-1 S ECDEX=$$FMTE^XLFDT(Y_"1001")
DATE S DIR(0)="D^::EXP",DIR("A")="Select the starting date ",DIR("B")=ECDEX D ^DIR K DIR G END:$D(DIRUT) S ECED=Y I Y>DT W !,"Date must be in the past",! G DATE
 S ECDEX=$$FMTE^XLFDT(Y)
 S ZTSAVE("ECED")="",ZTDESC="Find all inpatients on "_ECDEX,ZTIO="",ZTRTN="START^ECXSETUP" D ^%ZTLOAD
 I $D(ZTSK) W !,"Request queued as Task #",ZTSK,".",!
 G END
 ;
START ;queued entry point
 I $G(^ECX(728,1,"S"))]"",$G(^("S"))'="^" Q  ;already running or finished
 S $P(^ECX(728,1,"S"),U,2)="R" ; set run flag
 K ECXDD D FIELD^DID(405,.19,,"SPECIFIER","ECXDD") S ECPRO=$E(+$P(ECXDD("SPECIFIER"),"P",2)) K ECXDD
 S ECPACK="Admission setup",ECPIECE=13,ECRTN="START^ECXSETUP",ECGRP="ADMS",ECHEAD="ADM",ECFILE=727.82,ECSD=ECED,ECD=ECED,ECVER=7
 S ECINST=+$P(^ECX(728,1,0),U) K ECXDIC S DA=ECINST,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 D EN^DIQ1 S ECINST=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 S ECRN=0,QFLG=0
 S ECD0=9999999.9999999-ECD
 K ^TMP($J)
 F DFN=0:0 S DFN=$O(^DGPM("ATID1",DFN)) Q:'DFN  S EC1=$O(^(DFN,ECD0)) I EC1 S ECDA=+$O(^(EC1,0)) I $D(^DGPM(ECDA,0)) D  Q:QFLG
 .S EC=^(0),ECX=+$P(EC,U,17),ECAS=$P(EC,U,18)=40 D:$S('ECX:1,'$D(^DGPM(ECX,0)):1,^DGPM(ECX,0)>ECD:1,1:0) GET I ECAS D GET1
 I QFLG S ZTSTOP=1 G END
 S ECLAST=$O(^ECX(ECFILE,999999999),-1),ECTOTAL=$P(^ECX(ECFILE,0),U,4)+ECRN,$P(^(0),U,3,4)=ECLAST_U_ECTOTAL K ECLAST,ECTOTAL
 G ^ECXSETU1
END K DIR,ECD,ECDEX,X,Y,ECD0,DFN,DA,EC0
 Q
 ;
GET ;
 Q:'$D(^DPT(DFN,0))
 S D0=^DPT(DFN,0)
 Q:$E($P(D0,U,9),1,5)="00000"
 S ECAD=$P(EC,U),^TMP($J,DFN,ECDA)=""
 S ECTM=$$ECXTIME^ECXUTL(ECAD),ECXYM=$$ECXYM^ECXUTL(ECED)
 S X=$$PRIMARY^ECXUTL2(DFN,ECD),ECPTTM=$P(X,U,1),ECPTPR=$P(X,U,2)
 S ECODE=DFN_U_$P(D0,U,9)_U_$E($P($P(D0,U),",")_"    ",1,4)_"^3^"_$$ECXDATE^ECXUTL(ECAD,ECXYM)_U_ECPTTM
 S ECODE=ECODE_U_$P(D0,U,2)_U_$$ECXDOB^ECXUTL($P(D0,U,3))_U_$P(D0,U,8)_U_$P($G(^DPT(DFN,.311)),U,15)_U_+$$INSURED^IBCNS1(DFN,ECD)
 S D1=$G(^DPT(DFN,.11)),ECSTA=$P(D1,U,5),STATE=$S(ECSTA:$P(^DIC(5,ECSTA,0),U,3),1:"")
 S ECCTY=$P(D1,U,7),COUNTY=$S(ECCTY:$P(^DIC(5,ECSTA,1,ECCTY,0),U,3),1:"")
 S ECODE=ECODE_U_STATE_U_COUNTY_U_$P(D1,U,6),D1=$P($G(^DIC(8,+$G(^DPT(DFN,.36)),0)),U,9) I D1 S D1=$C(D1+64)
 S ECM=$P($G(^DG(408.32,+$P(D0,U,14),0)),U,2)
 S ECODE=ECODE_U_D1_U_$P($G(^DPT(DFN,"VET")),U)_U_$P($G(^DPT(DFN,.321))_"^^^^",U,1,3)_U_$P($G(^DPT(DFN,.52)),U,5)_U_$P($G(^DIC(21,+$P($G(^DPT(DFN,.32)),U,3),0)),U,3)_U_ECM_U_$P(D0,U,5)
 S W=$P(EC,U,6),FAC=$P($G(^DIC(42,+W,0)),U,11),W=$P($G(^DIC(42,+W,44)),U)
 S ECTS="" F J=1:1:100 S ECT1=$G(^DGPM(ECDA+J,0)) I $P(ECT1,U,14)=ECDA,$P(ECT1,U,2)=6 S ECTS=ECT1 Q
 ;get corresponding Treating specialty - should be the next one, but must be close
 S ECODE=FAC_U_ECODE_U_W_U_$P($G(^DIC(45.7,+$P(ECTS,U,9),0)),U,2)_U_ECPRO_$P(ECTS,U,19)_U_ECDA
 S (ECDRG,ECDIA)="",ECPTF=+$P(EC,U,16) I ECPTF,$D(^DGPT(ECPTF,"M")) D PTF S ECODE=ECODE_U_ECDRG_U_ECDIA
 S $P(ECODE,U,31)=ECTM,$P(ECODE,U,32)=ECPTPR,$P(ECODE,U,33)=$P($G(^DIC(10,+$P(D0,U,6),0)),U,2)_"^"
 ;facility^dfn^ssn^name^in/out^day^primary care team^sex^dob^religion^employment status^health ins^state^county^zip^eligibility^
 ;vet^vietnam^agent orange^radiation^pow^period of service^means test^marital status^ward^treating specialty^
 ;attending physician^mov #^DRG^diagnosis^time^primary care provider^race
FILE ;file record
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ^ECX(ECFILE,EC7,0)=EC7_U_ECXYM_U_U_ECODE,ECRN=ECRN+1
 S $P(^ECX(ECFILE,EC7,1),U,12)=""
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX^DIK K DIK,DA
 I $D(ZTQUEUED),ECRN>499,'(ECRN#500),$$S^%ZTLOAD S QFLG=1
 Q
 ;
GET1 ;look again for admission if the one we found was ASIH (ECAS=1)
 F EC1=EC1:0 S EC1=$O(^DGPM("ATID1",DFN,EC1)) Q:'EC1  S ECDA=$O(^(EC1,0)) I ECDA,$D(^DGPM(ECDA,0)) S EC=^DGPM(ECDA,0) I $P(EC,U,18)'=40 S ECX=$P(EC,U,17) Q
 I EC1,ECDA,$S('ECX:1,'$D(^DGPM(ECX,0)):1,^DGPM(ECX,0)>ECD:1,1:0) D GET ; find the admission movement (not ASIH) for this ASIH movement
 Q
 ;
 ;
PTF ; get admitting DRG and diagnosis from PTF
 ;use number for DRG and .01 for diagnosis
 S EC=1 I $D(^DGPT(ECPTF,"M",2,0)) S EC=2
 S EC2=+$P(^DGPT(ECPTF,"M",EC,0),U,5),ECDRG=$P($G(^DGPT(ECPTF,"M",EC,"P")),U)
 S ECDIA=$P($G(^ICD9(EC2,0)),U) Q
 ;
 ;
