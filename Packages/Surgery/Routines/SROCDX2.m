SROCDX2 ;BIR/ADM - ASSOCIATED DIAGNOSIS CODING UTILITIES ;07/27/05
 ;;3.0; Surgery ;**142**;24 Jun 93
PRLOOP(SRCHK) N SRDX,SRMATCH,SRXX S (SRDX,SRMATCH)=0,SRXX=X
 F SRI=1:1 S SRDX=$O(^SRO(136,SRTN,2,SRDX)) Q:'SRDX  D
 .I X=^SRO(136,SRTN,2,SRDX,0) D
 ..I 'SRCHK D KPADX(SRTN,SRDX) S X=SRXX
 ..S:$G(SRNEW) ^SRO(136,SRTN,2,SRDX,0)=SRNEW
 ..S SRMATCH=1
 Q SRMATCH
OTLOOP(SRCHK) N SRDA,OTH,SRMATCH,SRXX S (OTH,SRMATCH)=0,SRXX=X
 F  S OTH=$O(^SRO(136,SRTN,3,OTH)) Q:'OTH  D
 .S SRDA=0 F  S SRDA=$O(^SRO(136,SRTN,3,OTH,2,SRDA)) Q:'+SRDA  D
 ..I X=^SRO(136,SRTN,3,OTH,2,SRDA,0) D  Q
 ...I 'SRCHK D KOADX(SRTN,OTH,SRDA) S X=SRXX
 ...S:$G(SRNEW) ^SRO(136,SRTN,3,OTH,2,SRDA,0)=SRNEW
 ...S SRMATCH=1
 Q SRMATCH
DELASOC N DIR,Y,SRPR,SROT,SRXBAK
 Q:$G(X)=""  S SRXBAK=X
 S:'$D(SRTN)&$D(DA(1)) SRTN=DA(1) S:'$D(SRTN)&'$D(DA(1)) SRTN=DA
 S SRPR=$$PRLOOP(1),SROT=$$OTLOOP(1)
 I 'SRPR,'SROT Q
 S X=SRXBAK,SRPR=$$PRLOOP(0),SROT=$$OTLOOP(0)
 Q
PRINASOD Q:$G(SRTN)=""!($G(X)="")
 N D0 S D0=0  D DELASOC
 Q
SCOND(X1,X2) ; set condition for ADXP x-ref
 N SRDO S SRDO=0
 I X1(1)'="",X1(1)'=X2(1) S SRDO=1
 Q SRDO
KCOND(X1,X2) ; kill condition for ADXP x-ref
 N SRDO S SRDO=0
 I X2(1)="" S SRDO=1
 Q SRDO
SADXP ; ADXP x-ref set logic
 N DIR,Y
 I '$O(^SRO(136,DA,2,0)) Q
 S DIR("A",1)="",DIR("A",2)="The Diagnosis to Procedure Associations may no longer be correct.",DIR("A")="Delete all Principal Associated Diagnoses"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR I $D(DTOUT)!$D(DUOUT)!'Y Q
 I Y D KADXP
 Q
KADXP ; ADXP x-ref kill logic
 N SRASSD,SRFDA,SRIENU,SRIENF,SRTN
 S SRTN=DA D AT2 I $P(^SRO(136,SRTN,0),U,3) D
 .S SRASSD=$P(^SRO(136,SRTN,0),U,3),SRFDA="136.02",SRIENU="+1"_","_SRTN_",",SRIENF=0_","_SRTN_"," D UPDATE^SROCDX1,FILE^SROCDX1
 Q
AT2 ; delete principal associated diagnoses
 N SRDA,SRJ,SRY
 S SRDA=DA,SRJ=0 F  S SRJ=$O(^SRO(136,SRDA,2,SRJ)) Q:'SRJ  D
 .S SRY(136.02,SRJ_","_SRDA_",",.01)="@" D FILE^DIE("","SRY")
 Q
SADXO ; ADXO x-ref set logic
 N DIR,Y
 I '$O(^SRO(136,DA(1),3,DA,2,0)) Q
 S DIR("A",1)="",DIR("A",2)="The Diagnosis to Procedure Associations may no longer be correct.",DIR("A")="Delete all Other Associated Diagnoses"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR I $D(DTOUT)!$D(DUOUT)!'Y Q
 I Y D KADXO
 Q
KADXO ; ADXO x-ref kill logic
 N SRDA,SRJ,SRY
 S SRDA=DA,SRDA(1)=DA(1),SRJ=0 F  S SRJ=$O(^SRO(136,SRDA(1),3,SRDA,2,SRJ)) Q:'SRJ  D
 .S SRY(136.32,SRJ_","_SRDA_","_SRDA(1)_",",.01)="@" D FILE^DIE("","SRY")
 Q
KPADX(SRCN,SRPDA) ; kill all the principal cpt associated diagnosis codes
 N DA,DIK,SRX1,Y
 S SRX1=0,DA(1)=SRCN
 I '$G(SRPDA) F  S SRX1=$O(^SRO(136,DA(1),2,SRX1)) Q:'SRX1  D
 .S DA=SRX1,DA(1)=SRCN,DIK="^SRO(136,"_DA(1)_",2," D ^DIK
 Q:'$G(SRPDA)
 S DA=SRPDA,DA(1)=SRCN,DIK="^SRO(136,"_DA(1)_",2," D ^DIK
 Q
KOADX(SRCN,SRREC,SRPDA) ; kill other cpt associated diagnosis codes
 N DA,DIK,SRX1,Y
 S SRX1=0,DA(2)=SRCN
 I '$G(SRPDA) F  S SRX1=$O(^SRO(136,DA(2),3,SRREC,2,SRX1)) Q:'SRX1  D
 .S DA=SRX1,DA(1)=SRREC,DA(2)=SRCN,DIK="^SRO(136,"_DA(2)_",3,"_DA(1)_",2," D ^DIK
 Q:'$G(SRPDA)
 S DA=SRPDA,DA(1)=SRREC,DA(2)=SRCN,DIK="^SRO(136,"_DA(2)_",3,"_DA(1)_",2," D ^DIK
 Q
DELWRN N SRC
 S SRC(1)="This case cannot be sent to PCE until all procedures have at",SRC(1,"F")="!!?3"
 S SRC(2)="least one associated diagnosis code entered.",SRC(2,"F")="!?3"
 D EN^DDIOL(.SRC)
 Q
