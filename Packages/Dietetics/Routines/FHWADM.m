FHWADM ; HISC/REL - Set up admission ;12/4/00  10:35
 ;;5.5;DIETETICS;**5,8,21**;Jan 28, 2005;Build 6
 ; Changes necessary for new file #115 design:
 ; The .01 (1 piece of 0 node) for inpatients is now "P"_DFN (ie P7623)
 ; Therefore this file is no longer DINUMed to file #2.
 N FHWF S FHWF=$S($D(^ORD(101)):1,1:0)
 S FHZ115="P"_DFN D ADD^FHOMDPA
 I '$D(^FHPT(FHDFN,"A",0)) S ^FHPT(FHDFN,"A",0)="^115.01^^"
 D UPALFP  ;update food pref's based on allergy data
 D OPM  ;cancel any existing outpatient meals
 D NOW^%DTC S (FHNOW,FHX3,X)=$S($D(^DGPM(ADM,0)):$P(^(0),"^",1),1:%)
 I $D(^FHPT(FHDFN,"A",ADM)) S $P(^(ADM,0),"^",1)=X G:$G(^DPT(DFN,.105))'=ADM KIL G UPD
 S $P(^FHPT(FHDFN,"A",0),"^",3)=ADM,$P(^(0),"^",4)=$P(^(0),"^",4)+1
 S ^FHPT(FHDFN,"A",ADM,0)=X_"^^^^^^^^"
 S FHX1=$G(^DPT(DFN,.108)),FHX2=""
 I FHX1 S FHX1=$O(^FH(119.6,"AR",FHX1,0))
 I 'FHX1  S FHX1=$G(^DPT(DFN,.1)) I FHX1'="" S FHX1=$O(^DIC(42,"B",FHX1,0)) S:FHX1 FHX1=$O(^FH(119.6,"AW",FHX1,0))
 S FHX1=$G(^FH(119.6,+FHX1,0))
 S FHX2=$P(FHX1,"^",16),FHX1=$P(FHX1,"^",15) I 'FHX1,FHX2'="Y" G UPD
 S X=$S(FHX3>%:FHX3,1:%)
 S ^FHPT(FHDFN,"A",ADM,"AC",X,0)=X_"^1",^FHPT(FHDFN,"A",ADM,"AC",0)="^115.14^"_X_"^1",^FHPT(FHDFN,"A",ADM,"DI",0)="^115.02A^1^1"
 S $P(^FHPT(FHDFN,"A",ADM,0),"^",2)=1
 I 'FHX1 S ^FHPT(FHDFN,"A",ADM,"DI",1,0)="1^^^^^^X^^"_X_"^^"_DUZ_"^"_% S EVT="D^O^1" D ^FHORX G UPD
 S FHX2=$P($G(^FH(111,FHX1,0)),"^",5)
 S ^FHPT(FHDFN,"A",ADM,"DI",1,0)="1^"_FHX1_"^^^^^^T^"_X_"^^"_DUZ_"^"_%_"^"_FHX2
 S $P(^FHPT(FHDFN,"A",ADM,0),"^",5)="T" S EVT="D^O^1" D ^FHORX
 I 'FHWF S FHOR=FHX1_"^^^^" D ADD K FHOR G UPD
 S FHNEW="D;"_ADM_";"_1_";"_X_";;;;T;;"_FHX1_";;;;",D1=X,D2="" D NOW^%DTC S NOW=%,FHPV=DUZ,FHOR=FHX1_"^^^^" D DO^FHWOR2
 S $P(^FHPT(FHDFN,"A",ADM,0),"^",14)="" D WRD D MSG^XQOR("FH EVSEND OR",.MSG) K D1,D2,FHPV,FHNEW,MSG,NOW S $P(^FHPT(FHDFN,"A",ADM,"DI",1,0),"^",15)=6 D ADD K FHOR G KIL
UPD S $P(^FHPT(FHDFN,"A",ADM,0),"^",14)="" D WRD G KIL
WRD ; Update Room/Bed & Ward for current admission
 N FHWRD,FHRMB,WARD D DID^FHDPA Q:WARD=""  S ADM=$G(^DPT("CN",WARD,DFN)) Q:'ADM
 I '$D(^FHPT(FHDFN,"A",ADM,0)) Q
 S WARD=$P(^FHPT(FHDFN,"A",ADM,0),"^",8),EVT="L^"_$S(WARD:"T",1:"A")_"^^"_WARD_"~"_$P(^(0),"^",9) I WARD'=FHWRD G NEW
 I $P(^FHPT(FHDFN,"A",ADM,0),"^",9)'=FHRMB S $P(^(0),"^",9)=FHRMB S EVT=EVT_"~"_FHWRD_"~"_FHRMB D ^FHORX
 Q
NEW ; New Ward
 S $P(^FHPT(FHDFN,"A",ADM,0),"^",8,9)=FHWRD_"^"_FHRMB
 K:WARD ^FHPT("AW",WARD,FHDFN) I FHWRD S ^FHPT("AW",FHWRD,FHDFN)=ADM S EVT=EVT_"~"_FHWRD_"~"_FHRMB D ^FHORX
 ; Update Type of Service
 S FHX3=$P($G(^FH(119.6,+FHWRD,0)),"^",10) S:FHX3="" FHX3="TCD" I FHX3[$P(^FHPT(FHDFN,"A",ADM,0),"^",5) Q
 S FHX3=$S($L(FHX3)=1:FHX3,FHX3["D":"D",1:"C"),$P(^FHPT(FHDFN,"A",ADM,0),"^",5)=FHX3
 S FHX2=$P(^FHPT(FHDFN,"A",ADM,0),"^",2) I FHX2,$P($G(^FHPT(FHDFN,"A",ADM,"DI",+FHX2,0)),"^",8)'="" S $P(^(0),"^",8)=FHX3
 Q
ADD ; Add diet associated Diet Restriction
 D NOW^%DTC S NOW=%
 S DPAT=$O(^FH(111.1,"AB",FHOR,0))
 D UPD^FHMTK7
 K COM,DPAT,EVT,FP,L,LN,LP,LS,M,M1,M2,MEAL,N,NM,NO,NUM,NX,OPAT,P,PP,PNN,PNO,R1,SF,SP,X3,^TMP($J),Z
 Q
UPALFP ;Update Food Preferences for all Patient's based on Allergies
 I FHDFN="" Q
 K FHMISS D ALG^FHCLN I '$O(^TMP($J,"FHGMRAL","")) Q
 F FHGMRN=0:0 S FHGMRN=$O(^TMP($J,"FHGMRAL",FHGMRN)) Q:FHGMRN=""  D UPDFP^FHWGMR
 K ^TMP($J,"FHGMRAL"),^TMP($J,"FHMISS"),FHGMRN,FHMSAL,FHMSFP,FHMSPT
 Q
OPM ; Delete any future outpatient meals orders upon patient admission
 I '$D(^FHPT(FHDFN,"OP")),'$D(^FHPT(FHDFN,"SM")),'$D(^FHPT(FHDFN,"GM")) Q
 S X1=DT,X2=-1 D C^%DTC S FHDT=X_.999
 F FHRMDT=FHDT:0 S FHRMDT=$O(^FHPT(FHDFN,"OP","B",FHRMDT)) Q:FHRMDT'>0  F FHRNUM=0:0 S FHRNUM=$O(^FHPT(FHDFN,"OP","B",FHRMDT,FHRNUM)) Q:FHRNUM'>0  D CANRM
 F FHSM=FHDT:0 S FHSM=$O(^FHPT(FHDFN,"SM",FHSM)) Q:FHSM'>0  D CANSM
 F FHGM=FHDT:0 S FHGM=$O(^FHPT(FHDFN,"GM",FHGM)) Q:FHGM'>0  D CANGM
 Q
CANRM ;
 D CANRM^FHOMRC1
 S FHORN=$P($G(^FHPT(FHDFN,"OP",FHRNUM,0)),U,12)
 S FHMPNUM=$P($G(^FHPT(FHDFN,"OP",FHRNUM,0)),U,6)
 S FHDT2=$P($G(^FHPT(FHDFN,"OP",FHRNUM,0)),U,1)
 S FILL="R;"_FHMPNUM_";"_FHDT2_";"_FHDT2_";;"
 D CAN
 I $D(^FHPT(FHDFN,"OP",FHRNUM,1)) D CNAO100,CANAO^FHOMRC1
 I $D(^FHPT(FHDFN,"OP",FHRNUM,2)) D CNEL100,CANEL^FHOMRC1
 I $D(^FHPT(FHDFN,"OP",FHRNUM,3)) D CNTF100,CANTF^FHOMRC1
 Q
CNAO100 ;Backdoor message to update file #100 with AO cancel order
 S FHORN=$P($G(^FHPT(FHDFN,"OP",FHRNUM,1)),U,4),FILL="A;"_FHRNUM D CAN Q
CNEL100 ;Backdoor message to update file #100 with EL cancel order
 S FHORN=$P($G(^FHPT(FHDFN,"OP",FHRNUM,2)),U,5),FILL="E;"_FHRNUM D CAN Q
CNTF100 ;Backdoor message to update file #100 with TF cancel order
 S FHORN=$P($G(^FHPT(FHDFN,"OP",FHRNUM,3)),U,4),FILL="T;"_FHRNUM D CAN Q
 ;
CANSM ;
 S FHSTAT="C",(DA,FHDA)=FHSM,DA(1)=FHDFN
 I $G(FHORN)="" S FHORN=$P($G(^FHPT(FHDFN,"SM",FHDA,0)),U,12)
 I '$D(^FHPT(DA(1),"SM",DA,0)) Q
 S DIE="^FHPT("_DA(1)_",""SM"","
 S DR="1////^S X=FHSTAT;14////^S X=FHORN;11.5////^S X=FHSTAT" D ^DIE
 S FHZN=$G(^FHPT(FHDFN,"SM",FHDA,0))
 S FHACT="C",FHOPTY="S",FHOPDT=FHDA D SETSM^FHOMRO2
CNSM100 ;Backdoor message to update file #100 with SM cancel order
 S FHORN=$P($G(^FHPT(FHDFN,"SM",FHDA,0)),U,12),FILL="S;"_FHDA D CAN
 ;if an SM E/L Tray exists cancel that too:
CNSMEL S FHORN=$P($G(^FHPT(FHDFN,"SM",FHDA,1)),U,4) I FHORN="" Q
 S FILL="G;"_FHDA D CAN Q
 ;
CANGM ;
 S FHSTAT="C",(DA,FHDA)=FHGM,DA(1)=FHDFN
 S DIE="^FHPT("_DA(1)_",""GM"","
 S DR="8////^S X=FHSTAT;9////^S X=DUZ" D ^DIE
 S FHZN=$G(^FHPT(FHDFN,"GM",FHDA,0))
 S FHACT="C",FHOPTY="G",FHOPDT=FHDA D SETGM^FHOMRO2 ;set event
 Q
CAN ;
 Q:'$$PATCH^XPDUTL("OR*3.0*215")  ;must have CPRSv26 for O.M. backdoor
 D MSHCA^FHOMUTL,EVSEND^FHWOR
 Q
KIL ;
 K %,%H,%I,DIC,DIE,DIR,FHDT,FHDT2,FHRMDT,FHRNUM,FHNOW,FHX1,FHX2,FHX3
 K FHRMB,FHWRD,X Q
