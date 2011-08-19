PRCHFPD2 ;SF/FKV,TKW/RHD-PROMPT WHETHER FPDS DATA IS TO BE ENTERED ;2/9/93  14:54
V ;;5.1;IFCAP;**79,100**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
AMT ;
 S PRCHY=0 I PRCHEST>0,PRCHEC>0 S PRCHY=PRCHEST/PRCHEC,Y=$P(PRCHY,".",2) I $L(Y)>2 S PRCHY=$P(PRCHY,".",1)+$J("."_Y,2,2)
 S PRCH=0 F PRCHI=1:1 S PRCH=$O(PRCH("AM",PRCH)) Q:PRCH=""  D CHEC S PRCHAMT=""""_PRCH("AM",PRCH)_"""" K DR S DR="35///"_PRCHAMT,DR(2,442.1)=".01////"_PRCHAMT S:PRCH'=".OM" DR(2,442.1)=DR(2,442.1)_";2////"_PRCH D ^DIE
 K PRCHI,PRCHY,DR
 Q
CHEC ;
 I PRCHI=PRCHEC,PRCHEST'=(PRCHY*PRCHEC) S PRCHY=PRCHY+(PRCHEST-(PRCHY*PRCHEC))
 I PRCHY>0 S PRCH("AM",PRCH)=$P(PRCH("AM",PRCH),U,1)_U_($P(PRCH("AM",PRCH),U,2)+PRCHY)_U_$P(PRCH("AM",PRCH),U,3)
 S PRCH("AM",PRCH)=+$P(PRCH("AM",PRCH),U,2)
 Q
FPDS ;
 ;If source code is not 2, 5, or [4,6,7,B], delivery order from a PA,
 ;do not ask for any FPDS information and quit.
 ;If source code is 9, do not ask for any FPDS information
 I $D(^PRC(442,PRCHPO,14)),$P(^PRC(442,PRCHPO,23),U,11)'="P",$P(^PRC(442,PRCHPO,23),U,11)'="D",PRCHSC=9 S PRCHFPDS=0 D AMT Q
 ;
 S PRCHFPDS=0,%B="Specifically excluded from reporting are grants,intragovernmental",%B(1)="procurements,procurements from imprest fund,nonappropriated",%B(2)="(general post,loan guarantee,etc.),SF44s,credit card"
 S %B(3)="transactions,training authorizations,Government Bills of",%B(4)="Lading (GBL),and Government Transportation Requests (GTR)."
 S X="",PRCH="" F I=0:0 S PRCH=$O(PRCH("AM",PRCH)) Q:PRCH=""  S X=X+$P(PRCH("AM",PRCH),U,2)
 ; DON'T ASK FOR FPDS DATA IF TOTAL $>25,000, IF FEDERAL SOURCE, IF IMPREST FUNDS, IF A REQUISITION (FEDERAL SOURCE), OR IF GENERAL POST FUNDS.
 S X=X+PRCHEST,PRCHTTT=X
 ; For a delivery PO, forget the 25K limit on the total amount. This is
 ; intended for Purchasing Agents and Delivery Orders menu users. Now a
 ; definition for delivery orders is in effect: if the PO uses source
 ; codes 4, 6, 7, or B, then it is a delivery order (DO).
 ; Check Detailed PO from a PC user if it has source codes 6 or B.
 ; PRC*5.1*100: for non-general post funds (GPF), when creating a PO
 ; PRCHN("SFC")=0. If using a GPF, PRCHN("SFC")=1.
 I PRCHTTT>25000&($P(^PRC(442,PRCHPO,23),U,11)="P")&($G(PRCHPC)=2)&("6B"[PRCHSC)&($G(PRCHN("SFC"))>1!($G(PRCHN("SFC"))=0)) D PC Q
 ;
 ; Check PO from users of the separate Delivery Orders menu
 I PRCHTTT>25000&(($G(PRCHPHAM)=1)!($G(PRCHDELV)=1))&($G(PRCHN("SFC"))>1!($G(PRCHN("SFC"))=0)) D PC Q
 ;
 ; Check PO from the purchasing agent who can use any source code.
 I PRCHTTT>25000&("467B"[PRCHSC)&($D(^PRC(442,PRCHPO,14)))&($G(PRCHN("SFC"))>1!($G(PRCHN("SFC"))=0)) D DEL Q
 ;
 S Y=$S(X>25000:0,"130"[PRCHSC:0,PRCHN("MP")=12:0,PRCHN("MP")=5:0,PRCHN("SFC")=1:0,1:1)
 I 'Y S X=$S(X>25000:"Total Amount "_$J(X,11,2)_" is greater than $25000.00",1:"") W !!!,"No FPDS Data to be Entered: "_X,!!,%B,!,%B(1),!,%B(2),!,%B(3),!,%B(4),! D AMT K %B Q
 ; Check below for Delivery or Detailed purchase card orders, PRC*5.1*79
 I $G(PRCHTTT)'>0 S PRCHFPDS=0 Q  ;don't need $0 orders
 I $G(PRCHPC)=2!$G(PRCHPHAM)=1!$G(PRCHDELV)=1 D PC Q
 S %A="Is this P.O. to be reported to the FPDS system (Under $25,000 report)",%=1 D YN^PRCFYN S:%=1 PRCHFPDS=1 K:%=-1 PRCHPO D AMT:$D(PRCHPO)&(%=2)
 K %B
 Q
 ;
DEL S %A="Is this P.O. to be reported to the FPDS system",%=1 W ! D YN^PRCFYN S:%=1 PRCHFPDS=1 K:%=-1 PRCHPO D AMT:$D(PRCHPO)&(%=2)
 K %A,%B
 Q
 ;
PC ; Checks below for PRC*5.1*79.
 S A(1)="This P.O. must be reported to the FPDS system."
 S A(1,"F")="!!?10"
 S A(2,"F")="!!"
 D EN^DDIOL(.A)
 S PRCHFPDS=1
 K A,%B
 Q
