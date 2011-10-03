IB20P389 ;ALB/ARH - IB*2.0*389 POST INIT: PROSTHETICS ITEM REPLACEMENT ; 20-FEB-2008
 ;;2.0;INTEGRATED BILLING;**389**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
PRE ; Clean up DD, remove fields exported so installs clean
 ; TRANSFER PRICING INPT PROSTHETIC ITEMS (#351.67), ITEM (.01) Output Transform not deleted by install
 S DIK="^DD(351.61,",DA(1)=351.61,DA=4.04 D ^DIK K DIK,DA
 S DIK="^DD(351.67,",DA(1)=351.67,DA=.01 D ^DIK K DIK,DA
 S DIK="^DD(362.5,",DA(1)=362.5,DA=.03 D ^DIK K DIK,DA
 Q
 ;
 ;
 ; Add Prosthetics Item Name to IB BILL/CLAIMS PROSTHETICS (#362.5, .05)
 ; This free text Item Name (#362.5, .05) replaces the ITEM pointer (#362.5, .03) to PROS ITEM MASTER (#661)
 ; The free Text Item Name will be based on the RECORD (#352.5, .04) if defined, otherwise ITEM (#362.5, .03):
 ; - Prosthetics HISTORICAL ITEM (660,89) if patient item (#362.5, .04) defined/set
 ; - Item Master PRE_NIF SHORT DESCRIPTION (#441,52) if defined and Delivery Date before last edit date
 ; - Item Master SHORT DESCRIPTION (#441,.05) if Delivery Date is after last edit date
 ;
 ; Delete all entries in TRANSFER PRICING INPT PROSTHETIC ITEMS (#351.67) file
 ; List of Prosthetics Item to not bill, changed Item pointer from #661 to #661.1
 ;
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    IB*2*389 Prosthetics Item Replacement Post-Install .....",IBA(3)="" D MESG K IBA
 ;
 D PIDEL ; delete all TP Inpt Prosthetics Item (#352.67)
 D RBILL ; add prosthetic item name to bill record (#362.5)
 ;
 S IBA(1)="",IBA(2)="    IB*2*389 Prosthetics Item Replacement Post-Install Complete",IBA(3)="" D MESG K IBA
 ;
 Q
 ;
PIDEL ; Delete all entries from TRANSFER PRICING INPT PROSTHETIC ITEMS (#361.67)
 N IBPIFN,IBCNT,DIK,DIC,DIE,DA,X,Y S IBCNT=0
 ;
 S IBPIFN=0 F  S IBPIFN=$O(^IBAT(351.67,IBPIFN)) Q:'IBPIFN  D
 . ;
 . S DA=IBPIFN,DIK="^IBAT(351.67," D ^DIK K DIK,DA S IBCNT=IBCNT+1
 ;
 S IBA(1)="      >> "_IBCNT_" TRANSFER PRICING INPT PROSTHETIC ITEMS deleted (#351.67)" D MESG K IBA
 Q
 ;
RBILL ; Replace Bill Prosthetics Item pointer with name (#362.5)
 N IBPIN,IBPI0,IBDDT,IB661,IB660,IBNAME,IBCNT,DIE,DR,DA,DIC,DA,DO,X,Y S IBCNT=0
 ;
 S IBPIN=0 F  S IBPIN=$O(^IBA(362.5,IBPIN)) Q:'IBPIN  D
 . S IBPI0=$G(^IBA(362.5,IBPIN,0)) S IBDDT=+IBPI0 Q:$P(IBPI0,U,5)'=""
 . S IB661=+$P(IBPI0,U,3),IB660=+$P(IBPI0,U,4)
 . ;
 . S IBNAME=$$NAME(IB661,IB660,IBDDT) Q:IBNAME=""
 . ;
 . S DIE="^IBA(362.5,",DA=IBPIN,DR=".05////^S X=IBNAME" D ^DIE K DIE,DR,DA,DIC,DA,DO S IBCNT=IBCNT+1
 ;
 S IBA(1)="      >> "_IBCNT_" IB BILL/CLAIMS PROSTHETICS Records converted (#362.5)" D MESG K IBA
 Q
 ;
NAME(IP661,IP660,IDDT) ; Return free text name description for item
 N IBNAME,IB441,IBOLD,IBNEW,IBDATE S IDDT=+$G(IDDT),IBNAME=""
 ;
 I +$G(IP660) S IBNAME=$P($G(^RMPR(660,IP660,"HST")),U,1)
 ;
 I IBNAME="",+$G(IP661) D
 . S IB441=+$G(^RMPR(661,+IP661,0)) Q:'IB441
 . S IBOLD=$P($G(^PRC(441,+IB441,9)),U,1) ; pre_nif short description
 . S IBNEW=$P($G(^PRC(441,+IB441,0)),U,2) ; short description
 . S IBDATE=$P($G(^PRC(441,+IB441,0)),U,9) ; date item created (last updated)
 . ;
 . S IBNAME=IBNEW I IBOLD'="",IDDT<IBDATE S IBNAME=IBOLD
 ;
 I $E(IBNAME,1,2)="**" S IBNAME=$P(IBNAME,"**",2)
 I IBNAME="" S IBNAME="PROSTHETIC ITEM"
 ;
 Q IBNAME
 ;
MESG ;
 D MES^XPDUTL(.IBA)
 Q
