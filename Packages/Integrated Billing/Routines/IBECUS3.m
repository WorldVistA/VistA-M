IBECUS3 ;RLM/DVAMC - CANCEL TRICARE PHARMACY TRANSACTION ; 14-AUG-96
 ;;2.0;INTEGRATED BILLING;**52,89,240**;21-MAR-94
 ;
EN ; Transmit a cancellation transaction.
 ;  Input:    IBKEY  --  1 ; 2, where
 ;                           1 = Pointer to the prescription in file #52
 ;                           2 = Pointer to the refill in file #52.1, or
 ;                               0 for the original fill
 ;           IBKEYD  --  1 ^ 2 ^ 3 ^ 4, where
 ;                         1 = Rx label printing device
 ;                         2 = Pointer to the Pharmacy in file #59
 ;                         3 = Pointer to the Pharmacy user in file #200
 ;                         4 = Pointer to the billing transaction
 ;                             in file #351.5 (cancellations only)
 ;
 ; - bleed off queue
 F  R *IBI:0 Q:IBI=-1
 ;
 ; - get rx data; make sure there is an NDC
 K IBDRX,IBERR
 I $$TRANS^PSOCPTRI(+IBKEY,+$P(IBKEY,";",2),.IBDRX)<0 S IBERR=1 G ENQ
 ;
 ; - must be a billing transaction for the cancellation
 S IBCHTRN=+$P(IBKEYD,"^",4)
 S IBCHTRND=$G(^IBA(351.5,IBCHTRN,0))
 I 'IBCHTRND S IBERR=8 G ENQ
 S DFN=+$P(IBCHTRND,"^",2)
 I 'DFN S IBERR=4 G ENQ
 ;
 ; - is patient covered by TRICARE?
 S IBCDFN=$$CUS^IBACUS(DFN,DT)
 I 'IBCDFN S IBERR=2 G ENQ
 ;
 ; - get the BIN Number for the insurance company
 S IBCDFND=$G(^DPT(DFN,.312,IBCDFN,0))
 S IBBIN=$P($G(^DIC(36,+IBCDFND,3)),"^",3)
 I $L(IBBIN)'=6 S IBERR=5 G ENQ
 ;
 ; - build transmission:
 ;        o pharmacy division
 ;        o FI identifier (bin number)
 ;        o commercial software package version (32)
 ;        o cancellation transaction code  (11)
 ;        o control # (currently 10 spaces)
 ;        o pharmacy # (currently 12 spaces)
 ;        o rx fill date
 ;        o prescription number
 ;
 ;        (pharmacy number [abp] ??)
 ;        S JADNUM=$S($P(JADPSRX(2),"^",9)=1:7745017,1:7745029),JADLEN=12 D LJUST^JADNC S JADNABP=JADNUM
 ;
 S IBLINE(1)=$$FILL^IBECUS2(IBDRX("DIV"),2)_IBBIN_"3211"_$J("",10)_$J("",12)
 S IBLINE(1)=IBLINE(1)_$$DATE^IBECUS2(IBDRX("FDT"))
 S IBLINE(1)=IBLINE(1)_$$FILL^IBECUS2(IBDRX("RX#"),7)
 ;
 ; - transmit
 W IBLINE(1),!
 ;
 ; - receive
 R IBRESP(1)#100:120 I '$L(IBRESP(1)) S IBERR=6 G ENQ
 ;
 ; - handle errors
 I $E(IBRESP(1),1,3) D ERROR^IBECUS22 G ENQ
 ;
 ; - handle rejects
 S IBRESP(1)=$E(IBRESP(1),3,999)
 I $E(IBRESP(1),5)="R" D REJECT G ENQ
 ;
 ; - update cancellation auth number and user
 S ^IBA(351.5,IBCHTRN,6)=$E(IBRESP(1),6,19)_"^"_+$P(IBKEYD,"^",3)
 K ^IBA(351.5,"APOST",IBKEY)
 ;
 ; - Queue task to cancel charges
 D TASK^IBECUS2("RXCAN;Rx Cancellation")
 ;
ENQ I $G(IBERR) D ERROR^IBECUS22
 Q
 ;
 ;
REJECT ; Send alert for a reject.
 S IBREJ=""
 F IBRJ=8:2 S IBRJA=$E(IBRESP(1),IBRJ,IBRJ+1) Q:IBRJA="  "!(IBRJA="")  D
 .S IBERRP=$$ERRIEN^IBECUS22("UNIVERSAL",IBRJA)
 .I IBERRP S IBREJ=IBREJ_","_IBERRP
 S IBREJ=$E(IBREJ,2,999)
 ;
 S XQA("G.IB CHAMP RX REJ")="",XQA(+$P(IBKEYD,"^",3))=""
 S XQAMSG="Reversal for prescription #"_IBDRX("RX#")_" rejected for reason #"_IBREJ
 S XQADATA=IBDRX("RX#")_"^"_IBREJ_"^"_DFN,XQAROU="DISP^IBECUS22"
 D SETUP^XQALERT
 ;
 ; - update transaction file with reject codes
 S $P(^IBA(351.5,IBCHTRN,6),"^",3)=IBREJ
 ;
 K IBERRP,IBREJ,IBRJ,IBRJA
 Q
