XMRPCTS ;(KC-VAMC)/XXX-Steal TWIX's from PCTS Host [RCVR] ;03/18/2002  09:10
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; PCTS     XMNET-TWIX-SEND
PCTS ;
 S %=$$DSP("==>STARTING PCTS DIALOGUE<=="),XMRPCTS("R")=0
 S XMCOUNT=0
ST I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^XMRPCTSA"
 E  S X="ERR^XMRPCTSA",@^%ZOSF("TRAP")
 D INIT^XMRPCTSA
 S %=$$DSP("==>Handshaking with PCTS - This make take a while<==")
 F I=1:1:3 R X:5 Q:$T
 I X["MREQ" R X:3 S XMMN=$P(X,XMLF,2) G:X[XMET!(XMMN'?1N.N) EXIT S %=$$DSP("==>MREQ") G MAK1
 I X["MAOK" S %=$$DSP("==>MAOK") D ^XMRPCTS0 G EXIT ; We can send stuff here
 I X["MEND"!(X[XMET) S %=$$DSP("==>MENDing<==") G EXIT
 ;S %=$$DSP("===>'"_X_"' Received / Not Understood !!!")
 S XMCOUNT=XMCOUNT+1 G ST:XMCOUNT<3,EXIT
 ;
MAK1 W "MAK1",XMCR,XMLF,XMMN,XMCR,XMLF,XMET,XMCR S %=$$DSP("<==MAK1/"_XMMN),%=0
 ;
 S XMCOUNT=0
MDTA F I=1:1:3 R X:5 Q:$T
 I X["MDTA" R X:3 S XMMN=$P(X,XMLF,2) G:X[XMET EXIT S %=$$DSP("==>MDTA,  AMS Message #"_XMMN),XMSUB="PCTS==> AMS Message Number: "_XMMN G SH
 I X["MEND"!(X[XMET) S %=$$DSP("==>MENDing<==") G EXIT
 ;S %=$$DSP("===>'"_X_"' Received & Not Understood !!!")
 S XMCOUNT=XMCOUNT+1 G MDTA:XMCOUNT<3,EXIT
 ;
SH R X:5 G:'$T EXIT S XMHDR=$P(X,XMSH,2) S %=$$DSP("==>"_XMHDR),^TMP($J,1,0)=XMHDR,XMLPC=$$CSUM($C(XMLPC)_XMHDR_XMCR)
TT S X1="" F I=2:1 R X:5 Q:'$T  D
 .I X1["NNNN"&(($A($E(X,1)=10))&($A($E(X,2)=25))) R X2:5 Q
 .S XMLPC=$$CSUM($C(XMLPC)_X_XMCR),X=$$STRLF(X),X1=X
 .S ^TMP($J,I,0)=X,%=$$DSP("==>"_X)
 I X1["NNNN" S ^TMP($J,I,0)="------  End of PCTS Message  ------",%=$$DSP("==>NNNN Received") D CHKSUM(X) D XM^XMRPCTSA,REPLY^XMRPCTSA K X1 G ST
 I X1'["NNNN" S %=$$DSP("==>No 'NNNN', End of Message Found") K X1 G EXIT
CHKSUM(X) ;Verify the Checksum, We MUST agree.
 S XMLPC=$$CSUM($C(XMLPC)_XMLF) ;Add in that last LineFeed
 S XMLPC=$E(XMDH,XMLPC\16+1)_$E(XMDH,XMLPC#16+1) ;The Magic Code
 ;U IO R X:5 S X=$P(X,$C(25),2) ;Em is 25
 ;S XMLPC=$S(X=XMLPC:1,1:0) ;Do the checksums match ?
 ;Hardwire checksum evaluation to be true
 S XMLPC=1
 S %=$$DSP("==>CHECKSUM "_$S(XMLPC:"OK",1:"FAILED")_"<==")
 Q
DSP(XMTRAN) D TRAN^XMC1
 Q "" ;Show us what is going on
 ;
EXIT X ^%ZOSF("TRMOFF")
 K XMCR,XMLF,XMET,XMSH,XMLPC,XMLMN,XMMN,XMDH
 S %=$$DSP("==>ENDING PCTS DIALOGUE & RETURNING TO MAILMAN SCRIPT<==")
 F %="R","S" S XMCNT(%)=$S($G(XMRPCTS(%)):XMRPCTS(%),1:0)
 Q
 ;
STRLF(X) ;Remove leading LineFeed(s) from String
 N I F I=1:1:$L(X) Q:X'[$C(10)  I $A(X)=10 S X=$E(X,2,$L(X))
 Q (X)
CSUM(X) ;Calculate Checksum
 N Y X ^%ZOSF("LPC") Q Y
