IB20P330 ;BPFO/OEC-POST INIT ROUTINE FOR IB*2*330 ; 11/15/05 11:21am
 ;;2.0;INTEGRATED BILLING;**330**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
POST ; Post Init part of routine to add new rates to 350.2
 ;
 N DIC,DIK,DA,X,Y,IBX,IBA,IBT,IBY,DO,IBC,IBM,IBL,IBUP,IBY1
 ;
 S IBL=0 D M(""),M("  IB*2*330 Post-Install Starting ....."),M(""),MES^XPDUTL(.IBM) K IBM S (IBL,IBT)=0
 ;
 ; loop through entries to add (if needed)
RATE F IBX=1:1 S IBY=$P($T(RATES+IBX),";",3) Q:IBY=""  D
 . ;
 . ; see if it is there already
 . S IBA=$O(^IBE(350.1,"B",$P(IBY,"^",3),0))
 . I 'IBA D M(" ** Error: IB Action type "_$P(IBX,"^",3)_" not found !!!") Q
 . S $P(IBY,"^",3)=IBA
 . S IBC=$O(^IBE(350.2,"AIVDT",IBA,-$P(IBY,"^",2),0))
 . ;
 . ; add new entry
 . I 'IBC S DIC="^IBE(350.2,",DIC(0)="",X=$P(IBY,"^") K DO D FILE^DICN I $P(Y,"^",3) S $P(IBT,"^")=IBT+1,IBC=+Y
 . I 'IBC D M(" ** Error: Unable to add rate for "_$P(IBY,"^")) Q
 . ;
 . ; file data and xref
 . S ^IBE(350.2,+IBC,0)=IBY,DA=IBC,DIK="^IBE(350.2," D IX^DIK
 ;
 ;
 D M("  "_IBT_" rates added to IB ACTION CHARGE file."),M(" ")
 D MES^XPDUTL(.IBM) K IBM S IBL=0
 ;
 ;
 S IBT=0
 ;
 ; loop through entries to add (if needed)
CAP F IBX=1:1 S IBY=$P($T(CAPS+IBX),";",3) Q:IBY=""  D
 . ;
 . ; see if it is there already
 . S IBA=$O(^IBAM(354.75,"AC",$P(IBY,"^",3),$P(IBY,"^",2),0))
 . I IBA S IBC=$G(^IBAM(354.75,IBA,0)) I IBC=$P(IBY,"^",2,7) Q
 . ;
 . I IBA D M(" ** Error: Entry Number "_IBA_" in file 354.75 is incorrect !!!") Q
 . ;
 . ; add new entry
 . S DIC="^IBAM(354.75,",DIC(0)="",X=$P(IBY,"^",2) K DO D FILE^DICN S IBY1=+Y K D0
 . I Y<0 D M(" ** Error: Unable to add entry "_$P(IBY,"^")_" in file 354.75 !!!") Q
 . ;
 . ; file data and xref
 . S ^IBAM(354.75,IBY1,0)=$P(IBY,"^",2,7),DA=IBY1,DIK="^IBAM(354.75," D IX^DIK S IBT=IBT+1
 ;
 D M("  "_IBT_" caps added to IB COPAY CAPS file."),M(" ")
 D MES^XPDUTL(.IBM) K IBM,IBY1 S IBL=0
 ;
 D M("  IB*2*330 Post-Install Done .....")
 D MES^XPDUTL(.IBM)
 ;
 Q
 ;
M(Y) ; sets up messages
 ; Y = text to set up
 S IBL=IBL+1,IBM(IBL)=Y
 Q
 ;
RATES ; copay rates to add
 ;;RX1^3060101^PSO NSC RX COPAY NEW^8
 ;;RX3^3060101^PSO NSC RX COPAY CANCEL^8
 ;;RX4^3060101^PSO NSC RX COPAY UPDATE^8
 ;;RX2^3060101^PSO SC RX COPAY NEW^8
 ;;RX5^3060101^PSO SC RX COPAY CANCEL^8
 ;;RX6^3060101^PSO SC RX COPAY UPDATE^8
 ;;
CAPS ; copay caps to be installed (added) (same format as in 354.75 dd)
 ;;1^3060101^2^^960^^C
 ;;2^3060101^3^^960^^C
 ;;3^3060101^4^^960^^C
 ;;4^3060101^5^^960^^C
 ;;5^3060101^6^^960^^C
