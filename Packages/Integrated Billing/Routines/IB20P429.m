IB20P429 ;ELZ/OAK - POST INIT FOR PATCH;11/10/09
 ;;2.0;INTEGRATED BILLING;**429**;21-MAR-94;Build 62
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
POST ; loop through and populate entries in 350.2 if not there
 ;
 N IBX,IBZ,IBC,DO,IBE,X,Y,DIC,IBY,DIK,DA
 S IBC=0
 F IBX=1:1 S IBZ=$P($T(3502+IBX),";",3) Q:IBZ=""  D
 . S IBE=$O(^IBE(350.1,"B",$P(IBZ,"^",3),0))
 . I 'IBE D MES^XPDUTL("ERROR: Unable to find IB ACTION TYPE: "_$P(IBZ,"^",3)) Q
 . S $P(IBZ,"^",3)=IBE
 . I $D(^IBE(350.2,"AIVDT",$P(IBZ,"^",3),-$P(IBZ,"^",2))) Q
 . S X=$P(IBZ,"^"),DIC="^IBE(350.2,",DIC(0)="" D FILE^DICN
 . S IBY=+Y I Y<1 D MES^XPDUTL("ERROR: Unable to add IB ACTION CHARGE: "_$P(IBZ,"^")) Q
 . S ^IBE(350.2,IBY,0)=IBZ
 . S DIK="^IBE(350.2,",DA=IBY D IX^DIK
 . ; set additional amount IF logic
 . S ^IBE(350.2,IBY,20)="I $G(DFN)>0,$$PRIORITY^DGENA(DFN)>6"
 . S IBC=IBC+1
 ;
 D MES^XPDUTL(IBC_" entries added to IB ACTION CHARGE (#350.2) file.")
 ;
 Q
 ;
3502 ; data for 350.2 entries to be added
 ;;RX1^3100701^PSO NSC RX COPAY NEW^8^^1
 ;;RX2^3100701^PSO SC RX COPAY NEW^8^^1
 ;;RX3^3100701^PSO NSC RX COPAY CANCEL^8^^1
 ;;RX4^3100701^PSO NSC RX COPAY UPDATE^8^^1
 ;;RX5^3100701^PSO SC RX COPAY CANCEL^8^^1
 ;;RX6^3100701^PSO SC RX COPAY UPDATE^8^^1
 ;;
 ;
