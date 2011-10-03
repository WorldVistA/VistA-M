PSXNOTE ;BIR/WPB-Routine to Send Mail Messages ;16 Oct 2001  6:28 AM
 ;;2.0;CMOP;**1,27,30,38,41,45**;11 Apr 97
 ;Reference to ^DIC(4.2  supported by DBIA #1966
 ;Sends messages to users on transmission/receipt of CMOP data
GRP I '$D(^XUSEC("PSXMAIL")) G GRP1
 F MDUZ=0:0 S MDUZ=$O(^XUSEC("PSXMAIL",MDUZ)) Q:MDUZ'>0  S XMY(MDUZ)=""
ZZCONT1 ;
 K MDUZ
 G:'$D(XMY) GRP1
 Q
GRP1 F XDUZ=0:0 S XDUZ=$O(^XUSEC("PSXCMOPMGR",XDUZ)) Q:XDUZ'>0  S XMY(XDUZ)="",XQA(XDUZ)=""
 K XDUZ
 Q
FROM S FROM=$P(PSXSITE,",",1) Q
EXIT K XMSUB,SEG,SREC,XR,XMDUZ,XMZ,LCNT,XMDUN,XMFROM,XMY,DTE,FROM,OLDBAT,TDT,MM,XX,ADT,NN,XDUZ,XQA,PSXDUZ
 Q
EN ;sets up the notification messages
 D FROM S XX=PSXFLAG S Y=$S(PSXFLAG=3:ADT,PSXFLAG'=3:PSXTDT,1:0) X ^DD("DD") S TDT=Y K Y
 S XMSUB=$S(XX=1:"CMOP "_PSXREF_" Transmitted",XX=2:"CMOP "_PSXREF_" from "_FROM_" Received.",XX=3:"CMOP "_PSXREF_" Acknowledged.",XX=4:"CMOP Re-transmission "_PSXREF_" from "_FROM_" Received.",1:0)
 I $G(PSXDIV)]"" S XMSUB=PSXDIV_" "_XMSUB
 S LCNT=$S(XX<4:8,XX=4:9,1:"")
 S XMDUZ=.5 D XMZ^XMA2
 G:XMZ<1 EN
TXT ;sets the message in the mailman global
 S PSXDUZ=DUZ
 S MM=$S(XX=1:"CONFIRMATION:",(XX=4)!(XX=2):"RECEIVED:",XX=3:"ACKNOWLEDGEMENT:",1:"")
 S NN=$S(PSXRTRN=1:"RE-TRANSMISSION ",PSXRTRN=0:"TRANSMISSION ",1:"")
 S ^XMB(3.9,XMZ,2,1,0)=$S(XX=1:"  CMOP "_NN_MM,XX=2:"  CMOP "_NN_MM,XX=3:"  CMOP "_NN_MM,XX=4:"  CMOP RE-TRANSMISSION "_MM,1:"")
 S ^XMB(3.9,XMZ,2,2,0)="     Pharmacy Division    :  "_PSXDIV
 S ^XMB(3.9,XMZ,2,3,0)="     Batch Number         :  "_PSXREF
 S ^XMB(3.9,XMZ,2,4,0)="     Transmitted by       :  "_PSXSENDR
 S ^XMB(3.9,XMZ,2,5,0)="     Date/Time            :  "_TDT
 S ^XMB(3.9,XMZ,2,6,0)="     Total orders/Rx's    :  "_PSXMSGCT_"/"_PSXRXCT
 S ^XMB(3.9,XMZ,2,7,0)="     Beginning order #    :  "_PSXSTART
 S ^XMB(3.9,XMZ,2,8,0)="     Ending order #       :  "_PSXEND
 I (PSXRTRN=1)&($G(OLDBAT)>0) S ^XMB(3.9,XMZ,2,9,0)="     Original Batch #     :  "_OLDBAT
 I PSXRTRN=2!(PSXRTRN=1)&($G(PSXFLG1)'="") S ^XMB(3.9,XMZ,2,10,0)="",^XMB(3.9,XMZ,2,11,0)="      ******TRANSMISSION "_PSXREF_" IS ON HOLD."
 I PSXRTRN=2&($G(PSXFLG1)'="") S ^XMB(3.9,XMZ,2,12,0)="      Original "_PSXREF_" received "_$$FMTE^XLFDT(OLDTM,"2P")_$S($G(PSXFLG1)=1:" and has been sent to the automated system",$G(PSXFLG1)=0:" and is on hold",1:""),LCNT=12
 I (PSXRTRN=1&($G(PSXFLG1)'="")&($G(OLDSDT)'="")) D
 .S ^XMB(3.9,XMZ,2,12,0)="      Original "_+SITEN_"-"_$G(OLDBAT)_" transmitted "_$$FMTE^XLFDT($G(OLDSDT),"2P")_$S($G(PSXFLG1)=2:" and has been sent to the automated system",$G(PSXFLG1)=0:" and is on hold",1:""),LCNT=12
 I (PSXRTRN>0&($G(PSXFLG1)'="")&($G(OLDSDT)'="")) S ^XMB(3.9,XMZ,2,13,0)="Please review these transmissions and take appropriate action.",LCNT=13
XMIT ;transmits the message
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_U_LCNT_U_DT,XMDUN="CMOP Manager"
 I PSXFLAG=1 D TIMER^PSXMISC
 K XMY S XMDUZ=".5" D GRP,ENT1^XMD
 K FROM
 G EXIT
ACK ;sets up the acknowledgement message that is sent back to the remote
 N XMZ,XMFROM,XMSER,XQSOP,XQMSG
 S REC=$G(PSXDA),PSXRTRN=0 S:$G(PSXRECV) REC=$G(OLDDA)
 S PSXBAT=$P($P(^PSX(552.1,REC,0),"^"),"-",2),PSXSTART=$P(^PSX(552.1,REC,1),"^"),PSXEND=$P(^PSX(552.1,REC,1),"^",2),PSXFTDT=$P(^PSX(552.1,REC,0),"^",4),PSXSENDR=$P(^PSX(552.1,REC,"P"),"^",3),PSXMSGCT=$P(^PSX(552.1,REC,1),"^",3)
 S PSXRXCT=$P(^PSX(552.1,REC,1),"^",4),PSXDIV=$P(^PSX(552.1,REC,"P"),"^"),PSXREF=$P(^PSX(552.1,REC,0),"^"),SITE=$P(PSXREF,"-") S:$G(PSXRECV)=3 PSXFTDT=$P(^PSX(552.1,REC,0),"^",5)
 S X=SITE,AGNCY="VASTANUM" S:$D(^PSX(552,"D",X)) X=$E(X,2,99),AGNCY="DMIS" S SREC=$$IEN^XUMF(4,AGNCY,X) K DIC,X,Y,AGNCY ;****DOD L1
 S XR=$O(^PSX(552,"B",SREC,"")),DOM=$P(^PSX(552,XR,0),"^",4)
 I $G(PSXFTDT)="" D NOW^%DTC S PSXFTDT=% K %
 S:$D(^PSX(552.1,REC,2)) PSXRTRN=1
 Q:$D(^PSX(552,"D",SITE))  ;do not send a MM ack to DoD sites
 S XMSUB=$S($G(PSXRECV)=1:"CMOP Acknowledgement",$G(PSXRECV)=2:"CMOP Close Transmission",$G(PSXRECV)=3:"CMOP Unhold Transmission",1:"CMOP Transmission Processed"),XMDUZ=.5,LCNT=2
 S SEG=PSXBAT_U_$G(ORSTAT)_U_PSXSTART_U_PSXEND_U_PSXFTDT_"^"_$G(PSXOLD)_"^"_PSXSENDR_"^"_PSXMSGCT_"^"_PSXRXCT_"^"_PSXRTRN_"^"_PSXDIV_"^"_PSXREF
 D XMZ^XMA2
 G:XMZ<1 ACK
 S ^XMB(3.9,XMZ,2,1,0)=$S($G(PSXRECV)=1:"$$ACKN^",$G(PSXRECV)=2:"$$CACK^",$G(PSXRECV)=3:"$$HACK^",1:"$$VACK^")_$G(SEG)
 S ^XMB(3.9,XMZ,2,2,0)="$$ENDACKN^"
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_U_LCNT_U_DT,XMDUN="CMOP Manager"
 S DOMAIN=$$GET1^DIQ(4.2,DOM,.01)
 K XMY S XMDUZ=.5,XMY($S(DOMAIN="":"S.PSXX CMOP SERVER",DOMAIN'="":"S.PSXX CMOP SERVER@"_DOMAIN,1:""))=""
 ;S XMY(DUZ)="" H 1 ;****TESTING S.PSXX
 Q:$D(^PSX(552,"D",SITE))
 D ENT1^XMD
 K PSXSYST
 G EXIT
ERR ;will send an error message to the CMOP manager at the host if
 ;there is a problem with the transmission
 S XMDUZ=.5,XMSUB="CMOP Data Transmission Error, "_XSITE_" "_PSXDIV D XMZ^XMA2
 G:XMZ<1 ERR
 S ^XMB(3.9,XMZ,2,1,0)="There was an error in the transmission of batch #"_PSXREF
 S ^XMB(3.9,XMZ,2,2,0)="Please contact the BIRMINGHAM ISC for assistance as soon as possible."
 S ^XMB(3.9,XMZ,2,3,0)="  "
 S ^XMB(3.9,XMZ,2,4,0)="Transmisssion Information"
 S ^XMB(3.9,XMZ,2,5,0)="  "
 S ^XMB(3.9,XMZ,2,6,0)="Data collected at sending facility:"
 S ^XMB(3.9,XMZ,2,7,0)="Beginning msg #  "_PSXSTART
 S ^XMB(3.9,XMZ,2,8,0)="Ending msg #     "_PSXEND
 S ^XMB(3.9,XMZ,2,9,0)="Total Rxs        "_PSXRXCT
 S ^XMB(3.9,XMZ,2,10,0)="Total orders     "_PSXMSGCT
 S ^XMB(3.9,XMZ,2,11,0)="  "
 S ^XMB(3.9,XMZ,2,12,0)="Data received at host facility:"
 S ^XMB(3.9,XMZ,2,13,0)="Beginning msg #  "_PSXSMSG
 S ^XMB(3.9,XMZ,2,14,0)="Ending msg #     "_PSXLAST
 S ^XMB(3.9,XMZ,2,15,0)="Total Rxs        "_PSXRXS
 S ^XMB(3.9,XMZ,2,16,0)="Total orders     "_PSXORDCT
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_"16"_U_"16"_U_DT,XMDUN="CMOP Manager"
 K XMY S XMDUZ=.5
 D GRP,ENT1^XMD
 G EXIT
