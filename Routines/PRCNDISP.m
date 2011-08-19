PRCNDISP ;SSI/SEB-Display any transaction ;[ 03/28/96  12:32 PM ]
 ;;1.0;Equipment/Turn-In Request;**14**;Sep 13, 1996
USR ;  Review a requestor's transactions
 S PRCNUSR=0,DIC("S")="I $P(^(0),U,2)=DUZ"
 G PRT
CMR ;  Review a CMR Official's transactions
 S PRCNC=DUZ D CMR^PRCNCMR K PRCNC
 S PRCNUSR=0,DIC("S")="S CMRZ=$P(^(0),U,16) I $D(PRCNCMR(CMRZ))"
 G PRT
PPM ;  Review transactions by PPM
 S PRCNUSR=6
PRT ; Select a transaction, then display it.
 I $G(PRCNUSR)="" S PRCNUSR=10
 S DIC="^PRCN(413,",DIC(0)="AEQZ" D ^DIC G EXIT:Y<0
 S IN=+Y K DIC("S")
 D SETUP^PRCNPRNT
EXIT K DIC,IN,PRCNUSR,Y,JJ,PRCN,PRCNC,PRCNCMR,CMR,CMRZ
 Q
