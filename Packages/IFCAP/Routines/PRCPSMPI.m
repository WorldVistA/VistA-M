PRCPSMPI ;WISC/RFJ-issue code sheets to isms                        ;29 May 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DQ(TRANNO,TRANID) ;  create/trans issue code sheet to isms
 ;  tranno=issue transaction number (full 5 pieces of '-')
 ;  tranid=transaction register id
 N COUNT,DATA,ISSUCOST,ITEMDA,NSN,QTY,TRANREG,UI,VALUSOLD,VOUCHER
 ;
 ;  start gathering items posted
 S COUNT=1 K ^TMP($J,"STRING")
 S TRANREG=0 F  S TRANREG=$O(^PRCP(445.2,"C",TRANNO,TRANREG)) Q:'TRANREG  S DATA=$G(^PRCP(445.2,TRANREG,0)) I DATA'="",$P(DATA,"^",2)=TRANID D
 .   I '$D(VOUCHER) S VOUCHER=$P(DATA,"^",15)
 .   S ITEMDA=+$P(DATA,"^",5),NSN=$TR($$NSN^PRCPUX1(ITEMDA),"-"),UI=$P($P(DATA,"^",6),"/",2)
 .   S QTY=-$P(DATA,"^",7) I 'QTY Q
 .   S VALUSOLD=-$TR($J($P(DATA,"^",22),0,2),"."),ISSUCOST=-$TR($J($P(DATA,"^",23),0,4),".")
 .   S ^TMP($J,"STRING",COUNT)="IS^"_NSN_"^"_UI_"^"_QTY_"00^"_VALUSOLD_"^0^"_ISSUCOST_"^|",COUNT=COUNT+1
 I COUNT=1 Q
 ;
 ;  prcpwait used in routine prcpsmsi when retransmitting
 ;  isms code sheets
 I '$G(PRCPWAIT) D CODESHT^PRCPSMGO(PRC("SITE"),"ISS",VOUCHER)
 Q
