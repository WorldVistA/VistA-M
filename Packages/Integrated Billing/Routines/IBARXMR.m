IBARXMR ;LL/ELZ - PHARMCAY COPAY CAP RPC STUFF ;17-NOV-2000
 ;;2.0;INTEGRATED BILLING;**150,158,156,308**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
RQUERY(IBR,IBICN,IBM) ; remote query call
 ; called from rpc IBARXM QUERY ONLY
 N DFN
 S DFN=$$DFN^IBARXMU(IBICN) I 'DFN S IBY(0)=0 Q
 D QUERY(.IBR,DFN,IBM)
 S IBR=$NA(IBY)
 Q
 ;
QUERY(IBR,DFN,IBM) ; call for querying data
 ; IBR = where results are returned
 ; IBM = month/year for query
 N IBX,IBZ,IBS,IBC
 K IBR
 ;
 S IBS=+$P($$SITE^IBARXMU,"^",3)
 S (IBX,IBC)=0 F  S IBX=$O(^IBAM(354.71,"AD",DFN,IBM,IBX)) Q:IBX<1  D
 . S IBZ=^IBAM(354.71,IBX,0) Q:(+IBZ)'=IBS
 . S IBC=IBC+1
 . D SENDF^IBARXMU(.IBZ)
 . S IBR(IBC)=IBZ
 S IBR(0)=IBC
 Q
 ;
TRANS(IBR,IBICN,IBD) ; remote procedure call for receiving transaction data (new or updated)
 ; called from rpc IBARXM TRANS DATA
 ; IBICN = the patient's ICN
 ; IBR = return acceptance response
 ; IBD = data being received on a transaction
 N DFN,IBA
 S DFN=$$DFN^IBARXMU(IBICN)
 S IBR=$S(DFN>0:$$ADD^IBARXMN(DFN,IBD),1:0)
 Q
 ;
BILL(IBR,IBICN,IBT,IBB) ; remote procedure call to indicate a bill should be
 ; billed after all, this occurs when a copay bill was cancelled and
 ; the patient had previously reached his cap and the bill indicated was
 ; not billed.
 ; called from rpc IBARXM TRANS BILL
 ; IBR = return acceptance response
 ; IBICN = patient's icn
 ; IBT = 354.71 transaction number to bill
 ; IBB = amount to bill
 N DFN
 S DFN=$$DFN^IBARXMU(IBICN) I 'DFN S IBR="-1^Patient not found" Q
 ;
 ; if PFSS/IDX transaction call VDEF and quit
 I $$SWSTAT^IBBAPI,$P($G(^IBAM(354.71,+^IBAM(354.71,"B",IBT,0),0)),"^",20) S IBR=$$QUEUE^VDEFQM("DFT^P03","SUBTYPE=CPBL^IEN="_IBT_":"_IBB,,"PFSS OUTBOUND") Q
 ;
 D BILL^IBARXMB(IBT,IBB)
 S IBR=1
 Q
