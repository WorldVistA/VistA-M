PRCVIBF ;WOIFO/AS-FUND PROCESSING USING DATA FROM DYNAMED ;4/11/05  15:15
 ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
INIT(NOD) ;
 ;  1. Find out it is IV or SV
 ;
 NEW RTVAL
 I '$D(^TMP(NOD,$J)) D ERR(1) G EXIT
PROCESS ;
 NEW DUZ
 NEW %,ACCOD,ACT,BATCHID,BOC,CC,DA,PRC,PRCPDA,PRCHQ,PRCPORD,DIC,PRCSCP,RECORD1,RECORD10,RECORD2,RECORD3,RECORD4,T
 NEW DATIME,DESC,IEN,ITM,ITOT,IVAL,ND,TRNODE,Z,SVAL,STOT
 NEW PRCVI,PRCVDT,PRCSN,CC2
 D NOW^%DTC
 S PRCVDT=DT,DATIME=%,U="^",ND=$G(^TMP(NOD,$J,1)),PRC("SITE")=$P(ND,U)
 S BATCHID=$P(ND,U,2),Z=$P(ND,U,3),ACT=$P(ND,U,4)
 D DUZ^XUP($P(ND,U,6)) ;DBIA #4129 DUZ^XUP
 ;  Return PRC("FY"), PRC("QTR") using fileman date X
 S X=$P(ND,U,5) D FYQ^PRCFSITE
 S ND=$G(^TMP(NOD,$J,2))
 S PRC("SCP")=$P(ND,U),PRC("CP")=$P(ND,U,2),CC=$P(ND,U,3),CC2=$P(ND,U,4)
 S PRC("BBFY")=$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),PRC("CP"),1)
 I Z="IV",PRC("SCP")="" S PRC("SCP")=4537
 ;  If adjustment...
 I ACT'="E" D ADJ G EXIT
 ;
 ;        Issue Book Fund Commitment
 ;  1. get data from DynaMed by HL7 message
TRANS ;  2. get new transaction number
 S X=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("CP")
 S Z=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_PRC("CP")
 D EN1^PRCSUT3
NOD0 ;  3. create file 410, node 0 and 3
 S PRC("CP")=$P($G(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),"^")
 D EN2^PRCSUT3
 ; Failed if --> I '$D(PRCSX1)
 ;S X=PRCSX1,T1=DA
 S RTVAL=DA_"^0"
 ;    Transaction type = O:Obligation, A:Adjustment, CA:Cancelled
 S $P(^PRCS(410,DA,0),"^",2)="O"
 ;    Form Type = 5, Issue Book
 S $P(^PRCS(410,DA,0),"^",4)=5
 ;
NODE2 ;  4. create file 410, node 2
 S IEN=$O(^PRC(440,"AC","S",0)),ND=$G(^PRC(440,+IEN,0))
 I IEN D
 . S ^PRCS(410,DA,2)=$P(ND,"^",1,10)
 . S $P(^PRCS(410,DA,3),"^",4)=+IEN
 ;
 ;  5. Date of request (P1), Priority of Request (ST), Date required (P4)
 S ^PRCS(410,DA,1)=PRCVDT_"^^ST^"_PRCVDT
CC ;  6. Cost Center
 S CC=CC_CC2,CC=$P($G(^PRCD(420.1,CC,0)),"^")
 S $P(^PRCS(410,DA,3),"^",3)=CC
 ;  7. Create Items
ITEM ;     FIND UPDATE^DIE USAGE
 ;
 S CC=$G(^TMP(NOD,$J,3,0)),(STOT,ITOT)=0
 F PRCVI=1:1:CC D
 . S ND=$G(^TMP(NOD,$J,3,PRCVI,0)) Q:ND=""
 . S ACCOD=$P(ND,U,2),IVAL=$P(ND,U,4),SVAL=$P(ND,U,5)
 . S BOC=$P(ND,U,3) I BOC S BOC=$E($P($G(^PRCD(420.2,+BOC,0)),U),1,30)
 . S ITM=999999,DESC=$P($G(^PRC(441,ITM,0)),"^",2)
 . I DESC="" S DESC="DYNAMED ITEM"
 . S ACT=$G(^PRCS(410,DA,"IT",0)) I ACT="" S ^(0)="^410.02AI^0^0"
 . S $P(^PRCS(410,DA,"IT",0),"^",3,4)=PRCVI_"^"_PRCVI
 . S ^PRCS(410,DA,"IT",PRCVI,0)=PRCVI_"^^^"_BOC_U_ITM_"^^^"_CC
 . S ^PRCS(410,DA,"IT",PRCVI,1,0)="^^1^1^"_PRCVDT
 . S ^PRCS(410,DA,"IT",PRCVI,1,1,0)=DESC
 . ;Node 445 in "IT"
 . ;   how to handle ACCT-BOC    (CAME FROM DYNAMED)
 . S ^PRCS(410,DA,"IT",PRCVI,445)="A"_ACCOD_"-"_$P(ND,U,3)_U_$P(ND,U)_"^^"_IVAL_U_SVAL
 . S ^PRCS(410,DA,"IT","AB",PRCVI,PRCVI)=""
 . S ^PRCS(410,DA,"IT","B",PRCVI,PRCVI)=""
 . S ^PRCS(410,DA,"IT","AG",ITM,PRCVI)=""
 . S STOT=STOT+SVAL
 ;   End of item loop
 S $P(^PRCS(410,DA,10),U)=PRCVI
 ;
TOT ;   TOTAL COST and Date Commited
 S ^PRCS(410,DA,4)=ITOT_U_PRCVDT_U_STOT_"^^^^^"_STOT
 ;  5. Get DUZ of requestor and Approving Official, Total Amount
 S $P(^PRCS(410,DA,7),U)=DUZ
445 ;
 S $P(^PRCS(410,DA,445),"^",5)=BATCHID
COMMIT ;
 S PRCSN=^PRCS(410,DA,0),PRCHQ=$P(PRCSN,"^",4)
 ;S (CURQTR,CURQTR1)=PRC("QTR")
 S $P(^PRCS(410,DA,11),U,3)=1,^PRCS(410,"AQ",1,DA)=""
 S ^PRCS(410,"F",PRC("SITE")_"-"_+PRC("CP")_"-"_$P($P(^PRCS(410,DA,0),U),"-",5),DA)=""
 S ^PRCS(410,"F1",$P($P(^PRCS(410,DA,0),U),"-",5)_"-"_PRC("SITE")_"-"_+PRC("CP"),DA)=""
 ;  Copied from FINAL1^PRCSAPP2
 ;  set record in 443, clean up 410, change cp uncommitted balance 
 ;  using TRANS^PRCSES, in 420
 S PRCSCP=$P($G(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),U,12)
 L +^PRCS(410,DA):15 Q:$T=0
 S $P(^PRCS(410,DA,10),U,4)=$O(^PRCD(442.3,"C",60,0))
 I PRCSCP=1!(PRCHQ=1) S $P(^PRCS(410,DA,10),U,4)=$O(^PRCD(442.3,"C",10,0))
 K ^PRCS(410,"F",+PRCSN_"-"_+PRC("CP")_"-"_$P($P(PRCSN,U),"-",5),DA)
 K ^PRCS(410,"F1",$P($P(PRCSN,U),"-",5)_"-"_+PRCSN_"-"_+PRC("CP"),DA)
 K ^PRCS(410,"AQ",1,DA)
 S $P(^PRCS(410,DA,11),U,3)=""
 D ERS410^PRC0G(DA_"^A")
 L -^PRCS(410,DA)
ESIG ;
 S MESSAGE=""
 D ENCODE^PRCSC1(DA,DUZ,.MESSAGE)
 K MESSAGE
 S X=STOT D TRANS^PRCSES
 ;    no sub-cp processing  (removed the code)
 I $P(PRCSN,U,4)>1 D
 . S X=$P(PRCSN,U,1),DIC="^PRC(443,",DIC(0)="L",DLAYGO=443
 . D ^DIC K DIC,DLAYGO,X
 . S X=$O(^PRCD(442.3,"C",60,0))
 . S:PRCSCP=1 X=$O(^PRCD(442.3,"C",10,0))
 . S $P(^PRC(443,DA,0),U,7)=X,^PRC(443,"AC",X,DA)=""
 . S $P(^PRC(443,DA,0),U,11)=$P(PRCSN,U,6)
 ;   No sub-cp  so no --->        increment due-ins and due-outs
 ;   D EN2^PRCPWI
 ;
 S TRNODE(0)=0 D:PRCHQ=1 NODE^PRCS58OB(DA,.TRNODE)
POSTING ;
 ;   Buyer and Seller's FCP provided by DynaMed
 ;
 ;S (PRCPINPT,WHSE)=$O(^PRCP(445,"B",PRC("SITE")_"-WHSE",0))
 S PRCPDA=DA
 ;   get reference voucher (Obligation) number
 S PRCPORD=$$IBCNS^PRCPWPU1(PRC("SITE")_"-I"_$E(PRC("FY"),2))
 I PRCPORD="" D ERR(2) G EXIT
 S $P(^PRCS(410,PRCPDA,445),U)=PRCPORD
 S $P(^PRCS(410,PRCPDA,445),U,3,4)=STOT_U_DT
 S ^PRCS(410,"AS",BATCHID,PRCPDA)=""
 ;
FILE ;
 D IB^PRCS0B(PRC("SITE")_U_PRC("SITE"),PRC("CP")_U_PRC("SCP"),PRCPDA,STOT_U_STOT)
FINAL ;
 ;   All issue book from DynaMed are FINAL
 S $P(^PRCS(410,PRCPDA,4),U,4)=DT
 ;   change status
 S $P(^PRCS(410,PRCPDA,10),U,4)=$O(^PRCD(442.3,"C",40,0))
 ;   Accountable officer and date signed
 S $P(^PRCS(410,PRCPDA,7),U,11,12)=DUZ_U_DATIME
 ;   remove any worksheet file for 2237
 N DA,DIC,DIK
 S DIK="^PRC(443,",DA=PRCPDA D ^DIK
EXIT ;
 Q RTVAL
 ;
ADJ ;
 ; Adjustment 
 ;   Get IEN from "AS"
 S DA=$O(^PRCS(410,"AS",BATCHID,0))
 I 'DA D ERR(3) Q
 S RTVAL=DA_"^0"
 ;
 S CC=$G(^TMP(NOD,$J,3,0)),STOT=0
 F PRCVI=1:1:CC D
 . S ND=$G(^TMP(NOD,$J,3,PRCVI,0)) Q:ND=""
 . S STOT=STOT+$P(ND,U,5)
 ;  Update following code to generate new 410 for Buyer and Seller
 I 'STOT D ERR(4) G EXIT
 S CC=$P($G(^PRCS(410,DA,4)),"^",5)_"-ADJ"
 I STOT D
 . N A,B,BUY,SAL
 . S BUY=PRC("SITE")_U_PRC("CP")_U_"A"_"^^"_DT_U_STOT_U_CC
 . S A=^PRCS(410,DA,0),B=$P($G(^(3)),"^",11)
 . S A=$P($$QTRDATE^PRC0D($P(A,"-",2),$P(A,"-",3)),"^",7)
 . S $P(BUY,"^",10,11)=A_"^"_+$$DATE^PRC0C(B,"I"),SAL=BUY
 . D A410^PRC0F(.PRCPXX,BUY)
 . S $P(SAL,U,2)=PRC("SCP"),$P(SAL,U,6)=-STOT
 . D A410^PRC0F(.PRCPXX,SAL)
 . K PRCPXX
 Q
DMITEM ;
 ;  Initiate new item number for DynaMed interface
 NEW FDA,RESULT
 S FDA(441,"?+1,",.01)=999999
 S FDA(441,"?+1,",.05)="ITEM FOR DYNAMED ISSUE BOOK PROCESSING"
 S FDA(441,"?+1,",2)=9999
 S FDA(441,"?+1,",12)=2696
 D UPDATE^DIE("E","FDA","RESULT")
 S FDA(1)="Item created for use when processing IVSV transaction in support"
 S FDA(2)="of the DynaMed-IFCAP interface"
 D WP^DIE(441,"999999,",.1,"KA","FDA")
 Q
ERR(N) ;
 ;  if error, send HL7 app ACK of AE
 S N=$P($T(ERCODE+N),";;",2)
 S RTVAL="^"_+N_"^"_$P(N,"^",2)
 Q
ERCODE ;
 ;;201^MISSING TMP GLOBAL
 ;;207^Reference Voucher Number generation failed
 ;;209^Original Transaction ID not found
 ;;211^Adjustment amount missing.
 ;;
