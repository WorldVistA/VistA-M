RCCPCSV1 ;WASH-ISC@ALTOONA,PA/LDB-Receive and Process CCPC messages ;1/6/97  2:54 PM
 ;;4.5;Accounts Receivable;**34,70,76,130,153**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
IS ;INVALID STATEMENT
 D CHKTRAN(LABEL)
 S ERR="The following statements did not print due to errors:" D ERRMSG
 S ERR=" " D ERRMSG
 S ERR="     KEY            ERROR" D ERRMSG S ERR=" " D ERRMSG
 D ID
 S ERR="If these errors are corrected, these statements will not print until" D ERRMSG S ERR="the next billing cycle." D ERRMSG
 Q
 ;
ID ;INVALID STATEMENT DETAIL ERROR
 F  S RCMSG=$O(^TMP($J,"MSG",RCMSG)) Q:'RCMSG  D
 .I $P(^TMP($J,"MSG",RCMSG),"^")'="ID" S ERR="ERROR IN READING CCPC ERROR RECORD" D ERRMSG Q
 .S KEY=$P(^TMP($J,"MSG",RCMSG),"^",2),KEY=$TR(KEY," ",""),KEY=$E(KEY,$F(KEY,$$SITE^RCMSITE),999)
 .I KEY']"" D KEYERR Q
 .S DEB=$O(^RCPS(349.2,"AKEY",KEY,0)) I 'DEB D KEYERR Q
 .S ERROR=$P(^TMP($J,"MSG",RCMSG),"^",3),^RCPS(349.2,+DEB,5)=ERROR
 .F RCX=1:5:21 S RCX1=RCX+4 S ERR(0)=$E(ERROR,RCX,RCX1) Q:ERR(0)=""  D
 ..S ERR(1)=$O(^RCPSE(349.7,"B",ERR(0),""))
 ..I 'ERR(1) S ERR="NO ERROR DESCRIPTION FOR ERROR CODE: "_ERR(0)
 ..I ERR(1) S ERR=$P(^RCPSE(349.7,+ERR(1),0),"^",4)
 ..S ERR=KEY_" "_ERR(0)_" "_ERR
 ..D ERRMSG
 ..S ERR=" " D ERRMSG
 .S ^RCPS(349.2,+DEB,5)=$P(^TMP($J,"MSG",RCMSG),"^",3)
 .S ^RCPS(349.2,"AD","E",+DEB)=""
 Q
 ;
 ;
KEYERR ;SEND MESSAGE TO MAIL GROUP INDICATING NO KEY
 S ERR="CCPC ERROR MESSAGE - NO AR KEY ID FOR CCPC KEY: "_KEY D ERRMSG
 S ERR="This patient record is corrupted. Please contact IRM." D ERRMSG
 S ERR=" " D ERRMSG
 Q
 ;
PA ;STATEMENT ACKNOWLEDGEMENT
 N STDT,SSTDT
 Q:$P(RCTR,"^")'="PA"
 D CHKTRAN(LABEL)
 S SDAT=$P(RCTR,"^",7) S SDAT=$E(SDAT,1,2)_"/"_$E(SDAT,3,4)_"/"_$E(SDAT,5,8) S X=SDAT D ^%DT S SDAT=Y
 S STOT=+$P(RCTR,"^",6)
 S SEQ=+$P(RCTR,"^",3)
 F  S RCMSG=$O(^TMP($J,"MSG",RCMSG)) Q:'RCMSG  D
 .S RCTR=^TMP($J,"MSG",RCMSG)
 .Q:$P(RCTR,"^")'="AD"
 .S KEY=$P(RCTR,"^",2),KEY=$TR(KEY," ",""),KEY=$E(KEY,$F(KEY,$$SITE^RCMSITE),999)
 .I KEY']"" D KEYERR Q
 .S DEB=$O(^RCPS(349.2,"AKEY",KEY,0))
 .I 'DEB D KEYERR Q
 .S END=$P(^RCPS(349.2,+DEB,0),"^",10)
 .S:'END END=$O(^RCPS(349.2,0)),END=$P($G(^(+END,0)),"^",10)
 .F P=13:1:17 S SBAL(P)=$P(^RCPS(349.2,+DEB,0),"^",P)
 .;update patient statement date in 341 to end process time
 .D OPEN^RCEVDRV1(2,$P(^RCD(340,DEB,0),U),END,DUZ,$$SITE^RCMSITE,.ERR,.EVN,SBAL(13)_U_SBAL(14)_U_SBAL(15)_U_SBAL(16)_U_SBAL(17))
 .I EVN S DR=".07////"_END_";.11////"_1,DA=+EVN,DIE="^RC(341," D ^DIE K DIE,DR,DA
 .I EVN S $P(^RC(341,+EVN,6),"^")=$G(SDAT)
 .;update bill file 430 letter fields
 .NEW BN,DA,DIC,DIE,DR,II,LET,NOT,X,Y
 .S DIE="^PRCA(430,",NOT=0,BN=0
 .F  S BN=$O(^PRCA(430,"AS",DEB,16,BN)) Q:'BN  S DA=BN D
 ..S LET=$G(^PRCA(430,BN,6))
 ..I $P(LET,"^",21)>END Q
 ..S END=$G(SDAT)
 ..F II=1:1:4 Q:$P(LET,U,II)=END  I $P(LET,U,II)="" S DR=$S(II=1:61,II=2:62,II=3:63,1:68)_"////^S X="_END_";68.1////^S X="_END D ^DIE Q
 .S ^RCPS(349.2,+DEB,6)=1
PAMAIL S XMSUB="Patient Acknowledgments received from CCPC."
 S XMY("G.RCCPC STATEMENTS")="",XMDUZ="AR PACKAGE",XMTEXT="MSG("
 S MSG(1)="Patient acknowledgment message "_$G(XMZ)_" received."
 S MSG(2)="This means that CCPC has printed patient statements for this statement period."
 D ^XMD
 Q
 ;CODE BELOW NO LONGER NEEDED SINCE INTEREST/ADMIN UPDATE NOW DONE 
 ;WHEN STATEMENTS ARE GENERATED.
 N ZTDESC,ZTDTH,ZTRTN,ZTSAVE
 S DATE=$G(SDAT) Q:'DATE
 S ZTDTH=$S(DT'>SDAT:$$FMADD^XLFDT(SDAT,1),1:$$FMADD^XLFDT(DT,1))_".02"
 S ZTIO="",ZTRTN="FIRSTPTY^RCBECHGS",ZTDESC="Accrue interest/admin charges"
 S ZTSAVE("RCUPDATE")=DATE
 D ^%ZTLOAD
 Q
 ;
CHKTRAN(LABEL) ;Check for incomplete message from CCPC
 Q:$G(LABEL)']""
 S LABEL(1)=+$O(^RCT(349.1,"B",LABEL,0))
 I LABEL(1) S:$P(^TMP($J,"MSG",RCMSG),"^",2)=$P(^TMP($J,"MSG",RCMSG),"^",3) $P(^RCT(349.1,+LABEL(1),4),"^",1,2)=$P(^TMP($J,"MSG",RCMSG),"^",2,3),$P(^RCT(349.1,+LABEL(1),4),"^",3)=$G(XMZ)
 Q
 ;
TRANCHK ;Check for complete ACK transmission
 N MSG,RCT,SEG,SEQ,X
 F RCT=3,4 I $P($G(^RCT(349.1,+RCT,4)),"^")'=$P($G(^RCT(349.1,+RCT,4)),"^",2) D
 .S XMDUZ="AR PACKAGE"
 .S XMSUB="CCPC ACKNOWLEDGMENT TRANSMISSION(S) INCOMPLETE"
 .I $O(^XMB(3.8,"B","RCCPC STATEMENTS",0)) S XMY("G.RCCPC STATEMENTS")="" E  S XMY(.5)=""
 .S XMTEXT="MSG("
 .S SEG=$S(RCT=3:"IS",1:"PA")
 .S SEG(1)=$P(^RCT(349.1,+RCT,4),"^",2)
 .S MSG(2)="The last "_SEG_" segment message received from CCPC was numbered "_SEG(1)_"."
 .S MSG(3)="This was not labeled the final message in that segment type transmission."
 .S MSG(4)="This may cause patient statement information to be missing."
 .S MSG(5)="The last message number received was "_$P($G(^RCT(349.1,RCT,4)),"^",3)
 .S MSG(6)="Please contact the CCPC in Austin."
 .D ^XMD
 Q
 ;
 ;
IT ;INVALID TRANSMISSION
 S ERR="The CCPC patient statement messages were not accepted by CCPC" D ERRMSG
 S ERR="due to the following error(s):" D ERRMSG
 S ERR=" " D ERRMSG
 S RCMSG=1 F  S RCMSG=$O(^TMP($J,"MSG",RCMSG)) Q:'RCMSG  D
 .S MSG=^TMP($J,"MSG",RCMSG)
 .S MSG=$P(MSG,"^",8)
 .F RCX=1:5:21 S RCX1=RCX+4 S ERROR=$E(MSG,RCX,RCX1) Q:ERROR=""  D
 ..S ERR(1)=$O(^RCPSE(349.7,"B",ERROR,""))
 ..I 'ERR(1) S ERR="NO ERROR DESCRIPTION FOR ERROR CODE: "_ERROR
 ..I ERR(1) S ERR=$P(^RCPSE(349.7,+ERR(1),0),"^",4),ERR=ERROR_" "_ERR
 ..I ERR(1) S:$P(^RCPSE(349.7,+ERR(1),0),"^",3)="R" RE=1
 ..D ERRMSG
 S ERR=" " D ERRMSG
 S ERR="Please contact IRM."
 D ERRMSG
 Q
 ;
ERRMSG ;ERROR MESSAGE
 S LN=LN+1,^TMP($J,"ERR",LN)=ERR
 Q
