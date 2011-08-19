XMRPCTS0 ;(KC-VAMC)/XXX-Send TWIX's to PCTS Host [XMTR] ;03/21/2002  07:49
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; RQ       XMNET-TWIX-TRANSMIT
 ;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ; Walk through this Domains Transmit Basket and send them.
 ; If there is an error, record the error message, copy of
 ; the message, and drop to PCTS Mailgroup.
 ;-------------------------------------------------------------
 D DSP^XMRPCTS("==>Checking for PCTS Messages to Transmit<==")
 ;Get domain # for the PCTS domain
 S XMINST=$O(^DIC(4.2,"B","VHA.DMIA",0))
 S XMK=XMINST+1000,XMDUZ=.5,XMZ=0,U="^" D INIT^XMRPCTSA S XMRPCTS("S")=0
WALK D DSP("==>Checking for messages in basket # "_XMK_"<==")
 S XMZ=$O(^XMB(3.7,.5,2,XMK,1,XMZ)) G EXIT:XMZ<1
 I '$D(^XMB(3.9,XMZ,0)) D ZAPIT^XMXMSGS2(.5,XMK,XMZ) G WALK ;Message is Gone?
 D DSP("<==MREQ for local "_XMZ) W "MREQ",!,XMZ,!,"PCTS",!,"AMS",!,"TAB",!,XMET,XMCR S %=0
 ;
MREQ F I=1:1:3 R X:5 Q:$T
 I X["MAK1" R X:3 S XMMN=$P(X,XMLF,2) G:X[XMET!(XMMN'=XMZ) EXIT G REM
 I X["MEND"!(X[XMET) D DSP("==>MENDing<==") G EXIT
 S %=%+1 G MREQ:%<3,EXIT
REM R X:3 S XMMN=$P(X,XMLF,2) G:X[XMET!(XMMN'?1N.N) EXIT
 D DSP("==>MAK1 for REMOTE "_XMMN)
MDTA ;
 D DSP("<==MDTA, Now Sending Message #"_XMZ)
 S ^XMBS(4.2999,XMINST,3)=$H_"^"_XMZ_"^^^^DMI/MM-SSP" ; mailman status
 W "MDTA",!,XMZ,!,XMMN,!,XMSH S XMLPC=0 ;Here we go!
 F X=0:0 S X=$O(^XMB(3.9,XMZ,2,X)) Q:X<1  I $D(^(X,0)) S Z=^(0) D  Q:$E(Z,1,6)["NNNN"
 . N X,Y S X=$C(XMLPC)_Z_XMCR_XMLF X ^%ZOSF("LPC") S XMLPC=Y W Z,!
 ;S X=$C(XMLPC)_XMLF) X ^%ZOSF("LPC") S XMLPC=Y ;We like that extra lf calculated
 S XMLPC=$E(XMDH,XMLPC\16+1)_$E(XMDH,XMLPC#16+1) ;The Magic Code
 W $C(25),XMLPC,XMET,XMCR S %=1 ;Write the checksum
MAK2 F I=1:1:3 R X:5 Q:$T  ;Look for the status of the one we just sent
 I X["MAK2" S XMSTAT="Sent-> AMS Msg# "_XMMN R X:3 R X:3 D STAT S XMRPCTS("S")=XMRPCTS("S")+1 G WALK
 I $E(X["MN") R X:3 R X:3 S XMSTAT="Error: "_$P(X,XMLF,2) D STAT,ERR G WALK
 S %=%+1 G MAK2:%<3
 ;
 D DSP("==>INVALID RESPONSE from RCVR, Expecting MAK2, Closing up")
 G EXIT
 ;
 Q
JD() ; Returns today's Julian date
 N XMDDD,XMHHMM,XMNOW,XMDT
 S XMNOW=$$NOW^XLFDT
 S XMDT=$E(XMNOW,1,7)
 S XMDDD=$$RJ^XLFSTR($$FMDIFF^XLFDT(XMDT,$E(XMDT,1,3)_"0101",1)+1,3,"0")
 S XMHHMM=$$LJ^XLFSTR($E(XMNOW,9,12),4,"0")
 Q XMDDD_XMHHMM
 ;
DSP(XMTRAN) ;
 D TRAN^XMC1
 S %="" ;Show us what is going on
 Q
 ;
STAT ;Update the Mailman Status
 S X=$O(^XMB(3.9,XMZ,1,"C","XXX@"_$P(^DIC(4.2,+XMINST,0),U),0))
 I X>0 S $P(^XMB(3.9,XMZ,1,X,0),U,5,6)=$$DT_U_XMSTAT
 S ^XMBS(4.2999,XMINST,3)="" ;Mailman Status
 D ZAPIT^XMXMSGS2(.5,XMK,XMZ) ;Remove it from the Domains Basket
 Q
ERR N %,X,XMSUB,XMTEXT,XMY,Y
 D DSP("==>Recording Rejected Message #"_XMZ_"  "_XMSTAT)
 S XMTEXT="^XMB(3.9,"_XMZ_",2,"
 N XMZ,DIC,XMDF
 S XMSUB="PCTS Message Returned "_XMSTAT,XMDF=1
 S XMY("G.PCTS")="" ; Mail group PCTS must be created on the system
 S XMY(.5)=""
 D ^XMD
 Q  ;Send it to the PostMaster anyway
 ;
DT() N X,Y,%DT S %DT="T",X="N" D ^%DT Q (Y)
EXIT D DSP("==>Quitting<==")
 W "MEND",!
 Q
RQ ;Force this domain to play its script, it plays regardless...
 ;Queue this puppy to run at regular intervals.
 N XMDUZ,XMSITE,XMINST,XMB,%
 S XMDUZ=.5
 S XMSITE="VHA.DMIA"
 S XMINST=$O(^DIC(4.2,"B",XMSITE,0))
 I $D(ZTQUEUED) D  I $$OBE^XMTDR(XMINST) G QQ
 . S ZTREQ="@"
 E  I $$TSKEXIST^XMKPR(XMINST) G QQ
 D SCRIPT^XMKPR1(XMINST,XMSITE,.XMB)
 I 'XMB("SCR IEN") G QQ
 D PLAY^XMTDR(XMINST,XMSITE,.XMB)
QQ ;
 D DSP("Quitting from sending TWIX's")
 ;D KL1^XMC
 L
 K DIC,X,Y,XMDT,ZTPAR
 Q:'$G(XMRPCTS0)
 S XMCI=XMRPCTS0
 Q
