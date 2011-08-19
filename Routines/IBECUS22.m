IBECUS22 ;RLM/DVAMC - TRICARE PHARMACY BILLING UTILITIES ; 14-AUG-96
 ;;2.0;INTEGRATED BILLING;**52,89,240,274**;21-MAR-94
 ;
ERROR ; File errors.
 ;  Input:  IBERR [opt]  --  DHCP Error Code
 ;         IBDRX("RX#")  --  Prescription Number
 ;      IBRESP(1) [opt]  --  First record transmitted by the FI
 ;                IBKEY  --  1 ; 2, where
 ;                             1 = Pointer to the rx in file #52
 ;                             2 = Pointer to the refill in file #52.1,
 ;                                 or 0 for the original fill
 ;               IBKEYD  --  1 ^ 2 ^ 3 ^ 4, where
 ;                             1 = Rx label printing device
 ;                             2 = Pointer to the Pharmacy in file #59
 ;                             3 = Pointer to the Pharmacy user in
 ;                                 file #200
 ;                             4 = Pointer to the billing transaction
 ;                                 in file #351.5 (cancellations only)
 ;
 I '$G(IBERR) S IBERC=$E(IBRESP(1),1,3)
 I $G(IBERR) K ^IBA(351.5,"APOST",IBKEY) S IBERC=IBERR
 S IBMACH=$S($D(IBERR):"DHCP",1:"MLINK")
 K IBERR,IBTXT
 ;
 ; - expand the code if necessary
 I $D(IBRESP(1)),$E(IBRESP(1),1,3)="   " S IBERC="001"
 I IBERC?1.N S IBERC=+IBERC F  Q:$L(IBERC)>1  S IBERC="0"_IBERC
 S IBERRP=$$ERRIEN(IBMACH,IBERC)
 ;
 ; - send bulletin to the Reject Notice group
 S IBTXT(1)=IBMACH_" has detected error #"_IBERC_" while processing RX# "_$S($G(IBDRX("RX#"))]"":IBDRX("RX#"),1:"Unknown")
 S IBTXT(2)="Error text: "_$$ERRTXT(IBERRP)
 S XMDUN="TRICARE PHARMACY BILLING",XMDUZ=.5,XMSUB="Tricare/IPS Billing Error"
 S XMTEXT="IBTXT(",XMY("G.IB CHAMP RX REJ")="",XMY(+$P(IBKEYD,"^",3))=""
 N DIQUIET S DIQUIET=1 D DT^DICRW,^XMD
 ;
 ; - file the rejected transaction
 S IBCHREJ=$O(^IBA(351.52,"B",IBKEY,0))
 I 'IBCHREJ D ADDREJ^IBECUS21
 I IBCHREJ S $P(^IBA(351.52,IBCHREJ,0),"^",3)=DT,^(1)=IBERRP
 K IBERC,IBERRP,IBTXT,IBMACH,XMDUN,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 Q
 ;
 ;
DUP ; Act on duplicates.
 S XQA("G.IB CHAMP RX REJ")=""
 S XQAMSG="Prescription #"_$S($G(IBDRX("RX#"))]"":IBDRX("RX#"),1:"Unknown")_" is a duplicate submission."
 D SETUP^XQALERT
 K ^IBA(351.5,"APOST",IBKEY)
 Q
 ;
 ;
DISP ; Display Universal errors on alerts.
 N ERR,TXT,X,Y
 S Y=$G(^DPT(+$P(XQADATA,"^",3),0))
 W !!,"RX# ",$P(XQADATA,"^")," for ",$P(Y,"^")," (",$E($P(Y,"^",9),6,10),") rejected because:"
 S XQADATA=$P(XQADATA,"^",2)
 F X=1:1 S ERR=$P(XQADATA,",",X) Q:ERR=""  D
 .S TXT=$$ERRTXT(ERR)
 .I TXT]"" W !?3,TXT
 W !!,"Press ENTER key to continue..." R X:DTIME
 Q
 ;
 ;
ERRTXT(IEN) ; Return Error Text.
 ;  Input:   IEN  --  Pointer to the Error Text in file #351.51
 Q $P($G(^IBE(351.51,+$G(IEN),0)),"^",3)
 ;
ERRIEN(MACH,CODE) ; Return Error File Entry Number.
 ;  Input:   MACH  --  System on which the error occurred
 ;           CODE  --  Error Code
 N X S X=""
 I $G(MACH)="" G ERRIENQ
 I $G(CODE)="" G ERRIENQ
 S X=$O(^IBE(351.51,"AD",MACH,CODE,0))
ERRIENQ Q X
