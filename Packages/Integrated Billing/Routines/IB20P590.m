IB20P590 ;OAK/ELZ - IB*2*590 INSTALL ROUTINE ;1-MAR-2017
 ;;2.0;INTEGRATED BILLING;**590**;21-MAR-94;Build 3
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
POSTINT ; - post-install
 D BMES^XPDUTL("Starting Post-install")
 D OLDCH
 D NEWCH
 D BMES^XPDUTL("Post-install finished")
 Q
 ;
OLDCH ; - populate old action type charges
 ;
 D BMES^XPDUTL("Populating default tier into old Fee Prescription IB Action Charges")
 ;
 ; this will loop through all old fee pharmacy action types and populate the default tier of 2
 N IBX,IBC,IBZ,DIE,DA,DR
 S (IBC,IBX)=0 F  S IBX=$O(^IBE(350.2,IBX)) Q:'IBX  D
 . S IBZ=$G(^IBE(350.2,IBX,0)) Q:$E(IBZ,1,11)'="FEE SERV RX"
 . Q:$P(IBZ,"^",2)>3170101
 . Q:$P(IBZ,"^",7)
 . S DIE="^IBE(350.2,",DA=IBX,DR=".07///2" D ^DIE
 . S IBC=IBC+1
 D BMES^XPDUTL(IBC_" IB Fee Action Charges updated")
 Q
 ;
NEWCH ; - populate new action type charges
 ;
 D BMES^XPDUTL("Adding new Fee Prescription IB Action Charges")
 N IBC,IBI,IBX,DO,IBTIER,IBATYPE,DIC,X,IBCHRG,IBDT,Y
 S IBC=0
 F IBI=2:1 S IBX=$P($T(DATA3502+IBI),";;",2) Q:IBX=""  D
 . S IBDT=$P(IBX,"^",2),IBTIER=$P(IBX,"^",5),IBCHRG=$P(IBX,"^",4)
 . S IBATYPE=$O(^IBE(350.1,"B",$P(IBX,"^",3),0))
 . I 'IBATYPE D  Q
 .. D BMES^XPDUTL("****ERROR: ACTION TYPE (#350.1) "_$P(IBX,"^",3)_" not found!!!")
 . Q:$D(^IBE(350.2,"AC",IBATYPE,IBTIER,-IBDT))
 . ;
 . S X=$P(IBX,"^"),DIC="^IBE(350.2,",DIC(0)=""
 . S DIC("DR")=".02///^S X=IBDT;.03///^S X=""`""_IBATYPE;.04///^S X=IBCHRG;.07///^S X=IBTIER"
 . D FILE^DICN
 . I Y<1 D  Q
 .. D BMES^XPDUTL("****ERROR: Cannot add charge for Key"_$P(IBX,"^")_" for Tier "_IBTIER_".")
 . S IBC=IBC+1
 D BMES^XPDUTL("Added "_IBC_" new Fee Prescription IB Action Charges")
 Q
 ;
DATA3502 ; - data for the new 350.2 entries
 ; format key^eff date^action type (350.1)^unit charge^tier
 ;;FEE SERV RX1^3170227^FEE SERV NSC RX COPAY NEW^5^1
 ;;FEE SERV RX3^3170227^FEE SERV NSC RX COPAY CANCEL^5^1
 ;;FEE SERV RX4^3170227^FEE SERV NSC RX COPAY UPDATE^5^1
 ;;FEE SERV RX1^3170227^FEE SERV NSC RX COPAY NEW^8^2
 ;;FEE SERV RX3^3170227^FEE SERV NSC RX COPAY CANCEL^8^2
 ;;FEE SERV RX4^3170227^FEE SERV NSC RX COPAY UPDATE^8^2
 ;;FEE SERV RX1^3170227^FEE SERV NSC RX COPAY NEW^11^3
 ;;FEE SERV RX3^3170227^FEE SERV NSC RX COPAY CANCEL^11^3
 ;;FEE SERV RX4^3170227^FEE SERV NSC RX COPAY UPDATE^11^3
 ;;
