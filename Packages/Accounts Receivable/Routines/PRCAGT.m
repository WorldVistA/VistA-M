PRCAGT ;WASH-ISC@ALTOONA,PA/CMS-Patient Statement Build Tran List ;8/19/93
V ;;4.5;Accounts Receivable;**100,162,165,169,219,301**;Mar 20, 1995;Build 144
 ;;Per VA Directive 6402, this routine should not be modified.
 ;SEND (DEB=340-IFN,BEG,END,TRANTYPE=430.3-IFN)
 ;BUILD ^TMP("PRCAGT",$J,DEB,DATE,BILL,TN)=TAMT^TTY
 ;IF (TN,TTY)=0 TAMT=BILL'S ORIG AMT
 ;CALLER MUST KILL ^TMP
EN(DEB,BEG,END,TTY) ;*CALLER MUST KILL ^TMP("PRCAGT",$J)
 NEW Y K ^TMP("PRCAGT",$J)
 S:$G(BEG)="" BEG=0 I $G(END)="" D NOW^%DTC S END=%
 S TTY=$G(TTY) I TTY="" D F430
 D F433
Q Q
F430 ;
 NEW DAT,BN
 S DAT=BEG F  S DAT=$O(^PRCA(430,"ATD",DEB,DAT)) Q:('DAT)!(DAT>END)  S BN=0 F  S BN=$O(^PRCA(430,"ATD",DEB,DAT,BN)) Q:'BN  D
 .;Q:$D(^PRCA(430,"TCSP",BN))  ;prca*4.5*301
 .I $P(^PRCA(430,BN,0),U,3) S ^TMP("PRCAGT",$J,DEB,DAT,BN,0)=$P(^PRCA(430,BN,0),"^",3)_"^0"
 Q
F433 ;
 NEW DAT,TN,TN0,TN1 S COMM=0
 F DAT=BEG:0 S DAT=$O(^PRCA(433,"ATD",DEB,DAT)) Q:('DAT)!(DAT>END)  F TN=0:0 S TN=$O(^PRCA(433,"ATD",DEB,DAT,TN)) Q:'TN  D
 .S TN0=$G(^PRCA(433,TN,0)) Q:TN0=""  S TN1=$G(^PRCA(433,TN,1))
 .I $P(TN1,U,2)=45 S COMM=1
 .I $G(TTY)'="" Q:TTY'=$P(TN1,U,2)
 .I TTY="",",3,4,5,6,7,24,25,30,"[(","_$P(TN1,U,2)_",") Q
 .I ($P(TN0,U,2)="")!($P(TN0,U,4)'=2) Q
 .I $G(PRCAHIST)="THIST",$P(TN1,U,2)=45 G F433A
 .I $P(TN0,U,10)=1 Q
 .;
 .;  if transaction type not 46 (unsuspended) and not 47 (suspended)
 .;  then check to see if the bill was suspended or unsuspended at the
 .;  time the transaction was entered.  if the bill is suspended, then
 .;  the transaction should not be counted.  if the bill is unsuspended
 .;  then the transaction should be counted.
 .I $P(TN1,"^",2)'=46,$P(TN1,"^",2)'=47 D  I TN1="" Q
 .   .   N RCTRANDA,RCSTOP,TRANTYPE
 .   .   ;  check to see if bill was unsuspended when transaction was created
 .   .   ;  if so, count the transaction
 .   .   S RCSTOP=0
 .   .   S RCTRANDA=TN F  S RCTRANDA=$O(^PRCA(433,"C",+$P(TN0,"^",2),RCTRANDA),-1) Q:'RCTRANDA  D  I RCSTOP Q
 .   .   .   ;  transaction not complete
 .   .   .   I $P($G(^PRCA(433,RCTRANDA,0)),"^",4)'=2 Q
 .   .   .   S TRANTYPE=$P($G(^PRCA(433,RCTRANDA,1)),"^",2)
 .   .   .   ;  transaction type is unsuspended (46) meaning the bill
 .   .   .   ;  was unsuspended when the transaction was created.  the
 .   .   .   ;  transaction should be counted.
 .   .   .   I TRANTYPE=46 S RCSTOP=1 Q
 .   .   .   ;  transaction type is suspended (47) meaning the bill
 .   .   .   ;  was suspended when the transaction was created.  the
 .   .   .   ;  transaction should not be counted.
 .   .   .   I TRANTYPE=47 S RCSTOP=1,TN1="" Q
 .;
 .I TTY="",+$P(TN1,U,5)=0,$P(TN1,U,2)'=45 Q
F433A .S ^TMP("PRCAGT",$J,DEB,DAT,$P(TN0,U,2),TN)=+$P(TN1,U,5)_U_$P(TN1,U,2)
 S DAT=0 F  S DAT=$O(^TMP("PRCAGT",$J,DEB,DAT)) Q:'DAT  S END=DAT
 Q
TBAL(DEB,TBAL) ;get balance of transactions
 NEW BN,CH,DAT,PC,RF,RR,TAMT,TN,TTY,CS,CSFLAG
 S RR=+$O(^PRCA(430.2,"AC",33,0)),(CH,RF,PC)=0,CSFLAG=$D(CSTCH)
 I '$D(^TMP("PRCAGT",$J,DEB)) G TBALQ
 F DAT=0:0 S DAT=$O(^TMP("PRCAGT",$J,DEB,DAT)) Q:'DAT  F BN=0:0 S BN=$O(^TMP("PRCAGT",$J,DEB,DAT,BN)) Q:'BN  D
 .S CS=$D(^PRCA(430,"TCSP",BN)) ; set flag for CS bills
 .I $D(^TMP("PRCAGT",$J,DEB,DAT,BN,0)) S CH=CH+^(0) S:CS CSTCH=$G(CSTCH)+^(0)
 .F TN=0:0 S TN=$O(^TMP("PRCAGT",$J,DEB,DAT,BN,TN)) Q:'TN  S TAMT=^(TN),TTY=$P(TAMT,U,2) I TTY'=45 D
 ..I TTY=12 S:TAMT<0 PC=PC+TAMT S:TAMT'<0 CH=CH+TAMT S:TAMT<0&CS CSTPC=$G(CSTPC)+TAMT S:TAMT'<0 CSTCH=$G(CSTCH)+TAMT
 ..;  interest and admin charges may be negative
 ..;  this was added in patch 165
 ..I TTY'=13 S TAMT=$TR(+TAMT,"-")
 ..I $P(^PRCA(430,BN,0),U,2)=RR S:TTY=1 PC=PC-TAMT S:TTY=35 CH=CH+TAMT S:TTY=41 RF=RF+TAMT Q
 ..I ",2,8,9,10,11,14,19,47,34,35,29,"[(","_TTY_",") S PC=PC-TAMT S:CS CSTPC=$G(CSTPC)-TAMT Q
 ..I ",1,13,46,43,"[(","_TTY_",") S CH=CH+TAMT S:CS CSTCH=$G(CSTCH)+TAMT
 ;
TBALQ S TBAL("RF")=RF,TBAL("CH")=CH,TBAL("PC")=PC,TBAL=RF+CH+PC
 I 'CSFLAG K CSTCH,CSTPC
 Q
ACT(DEB,DAT) ;Quit 1 if debtor has activity other than interest
 NEW BN,DATT,TN,TN0,TN1
 S TN=0 F DATT=$P($G(DAT),"."):0 S DATT=$O(^PRCA(430,"ATD",DEB,DATT)) Q:'DATT!(TN)  F BN=0:0 S BN=$O(^PRCA(430,"ATD",DEB,DATT,BN)) Q:'BN!(TN)  S TN=1 Q
 I TN=1 G Q1
 S BN=0 F DATT=$P($G(DAT),"."):0 S DATT=$O(^PRCA(433,"ATD",DEB,DATT)) Q:'DATT!(BN)  F TN=0:0 S TN=$O(^PRCA(433,"ATD",DEB,DATT,TN)) Q:'TN!(BN)  D
 .S TN0=$G(^PRCA(433,TN,0)) Q:TN0=""  S TN1=$G(^PRCA(433,TN,1))
 .I ($P(TN0,U,4)=1)!($P(TN0,U,10)=1) Q
 .I +$P(TN1,U,5)=0,$P(TN1,U,2)'=45 Q
 .I +$P(TN1,U,2)'=13 S BN=1 Q
 I BN=1 G Q1
Q0 Q 0
Q1 Q 1
