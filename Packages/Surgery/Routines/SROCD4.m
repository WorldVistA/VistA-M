SROCD4 ;BIR/ADM - MARK CASE CODING COMPLETE ;10/17/05
 ;;3.0; Surgery ;**142**;24 Jun 93
 ;
 ; Reference to CL^SDCO21 supported by DBIA #406
 ;
 N SR,SRCHF,SRCL,SRDATA,SRDX,SRICD,SRK,SRMISS,SROTH,SRSDATE,SRTYPE
 D CHF I SRCHF=1 D ASKCHF I SRCHFNO Q
 S SR(0)=^SRO(136,SRTN,0) S SRSOUT=0,SREDIT=1
 I $P(SR(0),"^",2)="" S SRMISS("PRINCIPAL PROCEDURE CODE")=""
 I $P(SR(0),"^",3)="" S SRMISS("PRINCIPAL POSTOP DIAGNOSIS CODE")=""
 S DFN=$P(^SRF(SRTN,0),"^"),SRSDATE=$P(^SRF(SRTN,0),"^",9) D CL^SDCO21(DFN,SRSDATE,,.SRCL) I $D(SRCL) D PSCEI
 I '$O(^SRO(136,SRTN,2,0)) S SRMISS("PRINCIPAL ASSOCIATED DIAGNOSIS")=""
 S SROTH=0 F  S SROTH=$O(^SRO(136,SRTN,3,SROTH)) Q:'SROTH  I '$O(^SRO(136,SRTN,3,SROTH,2,0)) S SRMISS("OTHER ASSOCIATED DIAGNOSIS")="" Q
 S SROTH=0 F  S SROTH=$O(^SRO(136,SRTN,4,SROTH)) Q:'SROTH  I $D(SRCL) S SRDX=^SRO(136,SRTN,4,SROTH,0) D OSCEI
 I $D(SRMISS) D MISS Q
 I $P($G(^SRO(136,SRTN,10)),"^"),'$$CHNG^SROCD1 D  Q
 .I '$P(^SRF(SRTN,0),"^",15) D FILE Q
 I '$P($G(^SRO(136,SRTN,10)),"^") D  D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y Q
 .W ! K DIR S DIR("A")="Is the coding of this case complete and ready to send to PCE",DIR("B")="NO",DIR(0)="Y"
FILE D NOW^%DTC S SRNOW=$E(%,1,12) D
 .K DA,DIE,DR S DA=SRTN,DIE=136,DR="10////1" D ^DIE K DA,DIE,DR
 .K DD,DO S DIC="^SRO(136,SRTN,11,",DIC(0)="L",X=DUZ,DIC("DR")="1////"_SRNOW D FILE^DICN K DA,DD,DIC,DO,DR
 .W !!,"Processing data to be sent to PCE..." D CHKIN I SRK D  K SRK Q
 ..W !!,"Information needed to send the case to PCE is missing. Use the PCE"
 ..W !,"Filing Status Report to review missing information. The case will be"
 ..W !,"sent to PCE upon completion of the missing information.",! D PAGE
 .D START^SROPCEP ; send to PCE
 .W !!,"Coding completed and sent to PCE.",! D PAGE
 Q
CHKIN ; check for items in file 130 required by PCE
 N SR,SRAO,SRATT,SRCHK,SRCPT,SRCV,SRDATE,SRDEPC,SRDIAG,SRDXF,SREC,SRHNC,SRINOUT,SRIR,SRLOC,SRMST,SRNON,SRO,SRODIAG,SRPROV,SRRPROV,SRSC,SRUP,SRX
 D UTIL^SROPCEP
 Q
CHF ; check diagnoses for CRIMEAN HEMORRHAGIC FEVER
 N SRY,X,Y S SRY="",SRCHF=0
 K DIC S DIC="^ICD9(",DIC(0)="XM",X="CHF" D ^DIC S:Y'=-1 SRY=+Y Q:'SRY
 S Y=$$ICDDX^ICDCODE("065.0",$P(^SRF(SRTN,0),"^",9)) I $P(Y,"^")'=SRY Q
 S SRICD=$P(Y,"^",2)_" "_$P(Y,"^",4),X=$P(^SRO(136,SRTN,0),"^",3) I X=SRY S SRCHF=1 Q
 S Y=0 F  S Y=$O(^SRO(136,SRTN,4,Y)) Q:'Y  I $P(^SRO(136,SRTN,4,Y,0),"^")=SRY S SRCHF=1 Q
 Q
ASKCHF ; ask for confirmation of CRIMEAN HEMORRHAGIC FEVER diagnosis
 K DIR S DIR("A",1)="",DIR(0)="Y",SRCHFNO=0
 S DIR("A",2)="The ICD Diagnosis Code "_SRICD_" was entered as the"
 S DIR("A",3)="Principal or Other Diagnosis. It is possible that you entered ""CHF"" and"
 S DIR("A",4)="have the wrong code entered.",DIR("A",5)=""
 S DIR("A",6)="Are you sure that you want to submit this case to PCE with the case"
 S DIR("A")="coded using "_SRICD,DIR("B")="NO"
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y S SRCHFNO=1
 Q
MISS W !!,"Coding of this surgical case is not complete.",!,"The following items are missing:",!
 S SRDATA="" F  S SRDATA=$O(SRMISS(SRDATA)) Q:SRDATA=""  W ?5,SRDATA,!
 W !,"This case cannot be sent to PCE until all missing information is supplied.",!
PAGE K DIR S DIR(0)="FOA",DIR("A")="Press Enter/Return key to continue " D ^DIR K DIR
 Q
PSCEI S SRTYPE="PRINCIPAL"
 I $D(SRCL(1)),$P(SR(0),"^",5)="" D SRSET Q
 I $D(SRCL(2)),$P(SR(0),"^",6)="" D SRSET Q
 I $D(SRCL(3)),$P(SR(0),"^",4)="" D SRSET Q
 I $D(SRCL(4)),$P(SR(0),"^",7)="" D SRSET Q
 I $D(SRCL(5)),$P(SR(0),"^",8)="" D SRSET Q
 I $D(SRCL(6)),$P(SR(0),"^",9)="" D SRSET Q
 I $D(SRCL(7)),$P(SR(0),"^",10)="" D SRSET
 Q
OSCEI S SRTYPE="OTHER DIAGNOSIS"
 I $D(SRCL(1)),$P(SRDX,"^",3)="" D SRSET Q
 I $D(SRCL(2)),$P(SRDX,"^",4)="" D SRSET Q
 I $D(SRCL(3)),$P(SRDX,"^",2)="" D SRSET Q
 I $D(SRCL(4)),$P(SRDX,"^",7)="" D SRSET Q
 I $D(SRCL(5)),$P(SRDX,"^",5)="" D SRSET Q
 I $D(SRCL(6)),$P(SRDX,"^",6)="" D SRSET Q
 I $D(SRCL(7)),$P(SRDX,"^",8)="" D SRSET
 Q
SRSET S SRMISS(SRTYPE_" SC/EI")=""
 Q
CONV ; convert coding data from file 130 to file 136
 I $O(^SRO(136,0)) D MES^XPDUTL("Conversion has already run.") Q
 D NITE^SROPCE
C2 N SRCT,SRD,SRODX,SRPDX,SRPP,SROP,SRP,SRTN
 D MES^XPDUTL(" Converting coding data from file 130 to file 136...")
 S (SRCT,SRTN)=0 F  S SRTN=$O(^SRF(SRTN)) Q:'SRTN  D
 .I '$P($G(^SRF(SRTN,.2)),"^",12)&'$P($G(^SRF(SRTN,"NON")),"^",5) Q
 .S SRPP=$P($G(^SRF(SRTN,"OP")),"^",2),(SROP,SRP)=0 F  S SRP=$O(^SRF(SRTN,13,SRP)) Q:'SRP  I $P($G(^SRF(SRTN,13,SRP,2)),"^") S SROP=1 Q
 .S SRPDX=$P($G(^SRF(SRTN,34)),"^",2),(SRODX,SRD)=0 F  S SRD=$O(^SRF(SRTN,15,SRD)) Q:'SRD  I $P($G(^SRF(SRTN,15,SRD,0)),"^",3) S SRODX=1 Q
 .I SRPP!SROP!SRPDX!SRODX D
 ..Q:$D(^SRO(136,SRTN,0))
 ..D ^SROCD1 S SRCT=SRCT+1 I '(SRCT#10000) D MES^XPDUTL(SRCT_" cases converted... ")
 D MES^XPDUTL("Total cases converted: "_SRCT)
 Q
PRE ; pre-install entry
 ; delete APCE x-refs
 K DIE,DR,DIK,DA S DIK="^DD(130.16,3,1,",DA=1,DA(1)=3,DA(2)=130.16 D ^DIK
 K DIK,DA S DIK="^DD(130.165,.01,1,",DA=2,DA(1)=.01,DA(2)=130.165 D ^DIK
 K DIK,DA S DIK="^DD(130.18,.01,1,",DA=9,DA(1)=.01,DA(2)=130.18 D ^DIK
 K DIK,DA S DIK="^DD(130.18,3,1,",DA=1,DA(1)=3,DA(2)=130.18 D ^DIK
 K DIK,DA S DIK="^DD(130,27,1,",DA=1,DA(1)=27,DA(2)=130 D ^DIK
 K DIK,DA S DIK="^DD(130.275,.01,1,",DA=1,DA(1)=.01,DA(2)=130.275 D ^DIK
 K DIK,DA S DIK="^DD(130,32.5,1,",DA=1,DA(1)=32.5,DA(2)=130 D ^DIK
 K DIK,DA S DIK="^DD(130,66,1,",DA=1,DA(1)=66,DA(2)=130 D ^DIK K DIK,DA
 Q
