IB20P150 ;LL/ELZ - IB*2.0*150 POST INIT:MILL BILL RX COPAY ;20-FEB-2001
 ;;2.0;INTEGRATED BILLING;**150**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
POST ;
 ;
 N X,Y
 F X="SPOST","TASK","ERROR","FPOST" S Y=$$NEWCP^XPDUTL(X,X_"^IB20P150")
 ;
 ; TASK ; task job to init patient accounts
 ; ERROR ; new error codes in file 350.8
 ;
 Q
 ;
SPOST ; start post install
 N IBA
 S IBA(1)="",IBA(2)="    Outpatient Medication Copay Cap Phase I, Post-Install Starting",IBA(3)="" D MES^XPDUTL(.IBA)
 Q
 ;
FPOST ; finish post install
 N IBA
 S IBA(1)="",IBA(2)="    Outpatient Medication Copay Cap Phase I, Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA)
 Q
 ;
 ;
TASK ; queue off the init task job
 N IBA,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK
 ;
 S IBA(1)=""
 ;
 ; already scheduled or completed?
 I $P(^IBE(350.9,1,0),"^",16) S IBA(2)="    Task already queued or completed!!" G TASKQ
 ;
 S ZTRTN="ADDPT^IB20P150",ZTDESC="IB initialization of patient accounts"
 S ZTDTH="58643,64800",ZTIO="" D ^%ZTLOAD
 ;
 I ZTSK>0 S $P(^IBE(350.9,1,0),"^",16)=1,IBA(2)="     Initialization proces scheduled task #"_ZTSK
 E  S IBA(2)="    Initialization process could NOT be scheduled!!"
 ;
TASKQ S IBA(3)="" D MES^XPDUTL(.IBA)
 Q
 ;
ERROR ; add new error coes to 350.8
 N DIC,X,Y,IBC,IBX,DO,IBT,DA,IBA,DIK
 ;
 S IBC=0,(DIC,DIK)="^IBE(350.8,",DIC(0)=""
 F IBX=1:1 S IBT=$P($T(TXT+IBX),";",3) Q:'$L(IBT)  I '$D(^IBE(350.8,"AC",$P(IBT,"^",3))) K DO S X=$P(IBT,"^") D FILE^DICN I Y>0 S ^IBE(350.8,+Y,0)=IBT,DA=+Y,IBC=IBC+1 D IX^DIK
 ;
 S IBA(2)="     "_IBC_" entries added to 350.8"
 S (IBA(1),IBA(3))=""
 ;
ERRORQ ;
 D MES^XPDUTL(.IBA)
 Q
 ;
ADDPT ; Initialize patient's accounts in file #354.7
 ;
 Q:$P(^IBE(350.9,1,0),"^",16)>1
 S $P(^IBE(350.9,1,0),"^",16)=2
 ;
 N DFN,IBCNT,IBT
 ;
 ;
 S IBCNT=0
 ;
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .;
 .; do they have treating facilities?
 .S IBT=$$TFL^IBARXMU(DFN,.IBT)
 .Q:'IBT
 .;
 .; - count patients and add account
 .S IBCNT=IBCNT+1
 .D ADD^IBARXMU(DFN)
 ;
MESSAGE ; send a message indicating completed and update flag
 ;
 N IBSITE,XMSUB,XMDUZ,XMZ,XMY
 ;
 S IBSITE=$$SITE^VASITE
 ;
 S XMSUB="COMPLETED INITIALIZATION OF PATIENT ACCOUNTS"
 S XMDUZ="INTEGRATED BILLING ("_+IBSITE_")"
 D XMZ^XMA2
 S ^XMB(3.9,XMZ,2,1,0)="The Integrated Billing package has completed the initialization of the"
 S ^XMB(3.9,XMZ,2,2,0)="IB PATIENT COPAY ACCOUNT file (354.7) for station "_$P(IBSITE,"^",2)_" ("_+IBSITE_")."
 S ^XMB(3.9,XMZ,2,3,0)="  "
 S ^XMB(3.9,XMZ,2,4,0)="There were "_IBCNT_" patients added to the file."
 S ^XMB(3.9,XMZ,2,0)="^3.92^"_4_"^"_4_"^"_DT
 S XMY("23829@DOMAIN.EXT")=""
 S XMY(DUZ)=""
 D ENT1^XMD
 ;
 S $P(^IBE(350.9,1,0),"^",16)=3
 Q
 ;
 ;
TXT ; text of error messages to add
 ;;IB CAP UNABLE TO ADD^Unable to add a new rx-copay cap tracking transaction.^IB316^1^2
 ;;IB CAP POINTER MISSING^No pointer in 350 transaction to 354.71 file.^IB317^1^2
 ;;IB CAP TRAN FILE LOCK^Unable to lock entry in file 354.71.^IB318^1^2
 ;;IB CAP PATIENT FILE LOCK^Unable to lock entry in file 354.7.^IB319^1^2
