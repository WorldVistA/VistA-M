IB20P563 ;OAK/ELZ - IB*2*563 INSTALL ROUTINE ;17-MAR-2016
 ;;2.0;INTEGRATED BILLING;**563**;21-MAR-94;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
PREINT ; - pre-install
 ;
 ; - delete old unused fields to be replaced by install
 D BMES^XPDUTL("Removing old unused fields to be replaced")
 N DIK,DA
 S DIK="^DD(350,",DA=.22,DA(1)=350
 D ^DIK
 D BMES^XPDUTL("Field .22 in file 350 removed.")
 S DIK="^DD(354.71,",DA=.2,DA(1)=354.71
 D ^DIK
 D BMES^XPDUTL("Field .2 in file 354.71 removed.")
 Q
 ;
POSTINT ; - post-install
 D BMES^XPDUTL("Starting Post-install")
 D OLDCH
 D NEWCH
 D NEWCAP
 D BMES^XPDUTL("Post-install finished")
 Q
 ;
OLDCH ; - populate old action type charges
 ;
 D BMES^XPDUTL("Populating default tier into old prescription IB Action Charges")
 ;
 ; this will loop through all old pharmacy action types and populate the default tier of 2
 N IBX,IBC,IBZ,DIE,DA,DR
 S (IBC,IBX)=0 F  S IBX=$O(^IBE(350.2,IBX)) Q:'IBX  D
 . S IBZ=$G(^IBE(350.2,IBX,0)) Q:$E(IBZ,1,2)'="RX"
 . Q:$P(IBZ,"^",2)>3170101
 . Q:$P(IBZ,"^",7)
 . S DIE="^IBE(350.2,",DA=IBX,DR=".07///2" D ^DIE
 . S IBC=IBC+1
 D BMES^XPDUTL(IBC_" IB Action Charges updated")
 Q
 ;
NEWCH ; - populate new action type charges
 ;
 D BMES^XPDUTL("Adding new prescription IB Action Charges")
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
 D BMES^XPDUTL("Added "_IBC_" new prescription IB Action Charges")
 Q
 ;
NEWCAP ; - populate new copayment cap data
 ; eff date^pg^amount^basis
 D BMES^XPDUTL("Adding new Copay Cap Amounts")
 N IBC,IBI,IBX,IBDT,IBPG,IBCAP,IBBAS,X,Y,DIC
 S IBC=0
 F IBI=2:1 S IBX=$P($T(DATA3547+IBI),";;",2) Q:IBX=""  D
 . S IBDT=+IBX,IBPG=$P(IBX,"^",2),IBCAP=$P(IBX,"^",3),IBBAS=$P(IBX,"^",4)
 . Q:$D(^IBAM(354.75,"AC",IBPG,IBDT))
 . ;
 . S X=IBDT,DIC="^IBAM(354.75,",DIC(0)=""
 . S DIC("DR")=".02///^S X=IBPG;.04///^S X=IBCAP;.06///^S X=IBBAS"
 . D FILE^DICN
 . I Y<1 D  Q
 .. D BMES^XPDUTL("****ERROR: Cannot add cap for PG"_IBPG_" effective "_$$FMTE^XLFDT(IBDT))
 . S IBC=IBC+1
 D BMES^XPDUTL("Added "_IBC_" new Copay Caps")
 Q
DATA3502 ; - data for the new 350.2 entries
 ; format key^eff date^action type (350.1)^unit charge^tier
 ;;RX1^3170227^PSO NSC RX COPAY NEW^5^1
 ;;RX2^3170227^PSO SC RX COPAY NEW^5^1
 ;;RX3^3170227^PSO NSC RX COPAY CANCEL^5^1
 ;;RX4^3170227^PSO NSC RX COPAY UPDATE^5^1
 ;;RX5^3170227^PSO SC RX COPAY CANCEL^5^1
 ;;RX6^3170227^PSO SC RX COPAY UPDATE^5^1
 ;;RX1^3170227^PSO NSC RX COPAY NEW^8^2
 ;;RX2^3170227^PSO SC RX COPAY NEW^8^2
 ;;RX3^3170227^PSO NSC RX COPAY CANCEL^8^2
 ;;RX4^3170227^PSO NSC RX COPAY UPDATE^8^2
 ;;RX5^3170227^PSO SC RX COPAY CANCEL^8^2
 ;;RX6^3170227^PSO SC RX COPAY UPDATE^8^2
 ;;RX1^3170227^PSO NSC RX COPAY NEW^11^3
 ;;RX2^3170227^PSO SC RX COPAY NEW^11^3
 ;;RX3^3170227^PSO NSC RX COPAY CANCEL^11^3
 ;;RX4^3170227^PSO NSC RX COPAY UPDATE^11^3
 ;;RX5^3170227^PSO SC RX COPAY CANCEL^11^3
 ;;RX6^3170227^PSO SC RX COPAY UPDATE^11^3
 ;;
DATA3547 ; - data for the new 354.75 entries
 ; format eff date^pg^amount^basis
 ;;3170101^2^700^C
 ;;3170101^3^700^C
 ;;3170101^4^700^C
 ;;3170101^5^700^C
 ;;3170101^6^700^C
 ;;3170101^7^700^C
 ;;3170101^8^700^C
