DVBAB1C ;ALB/AJF;CAPRI UTILITIES ; 10/13/21 8:02am
 ;;2.7;AMIE;**193,227**;Apr 10, 1995;Build 21
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
MSG(RIEN) ;Generate mail message;AJF
 ;
 D GETREQ
 D MGUSR
 ;
 S XMSUB="CAPRI: 2507 Exam Request Rejected"
 S ^TMP($J,"AMIE1",1)="The 2507 Exam Request as described below has been rejected."
 S ^TMP($J,"AMIE1",2)=""
 S ^TMP($J,"AMIE1",3)=""
 S ^TMP($J,"AMIE1",4)="                 DFN:  `"_DVBADFN
 S ^TMP($J,"AMIE1",5)="          Requested Date: "_DVBADT
 S ^TMP($J,"AMIE1",6)="          Requested Site: "_RTF
 S ^TMP($J,"AMIE1",7)=""
 S ^TMP($J,"AMIE1",8)="          Rerouted Date: "_RDT
 S ^TMP($J,"AMIE1",9)="          Rerouted Site: "_RTO
 S ^TMP($J,"AMIE1",10)=""
 ;changes for patch 227 displaying reject date/reason
 S ^TMP($J,"AMIE1",11)="         Rejected Date: "_RRRD
 S ^TMP($J,"AMIE1",12)="         Rejected Reason: "_RRRJ
 S ^TMP($J,"AMIE1",13)=""
 S ^TMP($J,"AMIE1",14)=""
 S ^TMP($J,"AMIE1",15)="**NOTE: To view the patient using the DFN, paste the DFN number into the CAPRI"
 S ^TMP($J,"AMIE1",16)="Patient Selector 'Patient ID' field to find the patient. Be sure to include"
 S ^TMP($J,"AMIE1",17)="the ` (backward-apostrophe) character."
 S ^TMP($J,"AMIE1",18)=""
 S ^TMP($J,"AMIE1",19)=""
 S ^TMP($J,"AMIE1",20)=""
 S ^TMP($J,"AMIE1",21)="*****This is an auto-generated email.  Do not respond to this email address.*****"
 S XMTEXT="^TMP($J,""AMIE1"","
 D ^XMD,END
 Q
 ;
 ;
AMSG(RIEN) ;Generate Acceptance Email
 ;
 D GETREQ
 D MGUSR
 ;
 S XMSUB="CAPRI: 2507 Exam Request Accepted"
 S ^TMP($J,"AMIE1",1)="The 2507 Exam Request as described below has been ACCEPTED."
 S ^TMP($J,"AMIE1",2)=""
 S ^TMP($J,"AMIE1",3)=""
 S ^TMP($J,"AMIE1",4)="                 DFN:  `"_DVBADFN
 S ^TMP($J,"AMIE1",5)="          Requested Date: "_DVBADT
 S ^TMP($J,"AMIE1",6)="          Requested Site: "_RTF
 S ^TMP($J,"AMIE1",7)=""
 S ^TMP($J,"AMIE1",8)="          Rerouted Date: "_RDT
 S ^TMP($J,"AMIE1",9)="          Rerouted Site: "_RTO
 S ^TMP($J,"AMIE1",10)=""
 S ^TMP($J,"AMIE1",11)=""
 S ^TMP($J,"AMIE1",12)="**NOTE: To view the patient using the DFN, paste the DFN number into the CAPRI"
 S ^TMP($J,"AMIE1",13)="Patient Selector 'Patient ID' field to find the patient. Be sure to include"
 S ^TMP($J,"AMIE1",14)="the ` (backward-apostrophe) character."
 S ^TMP($J,"AMIE1",15)=""
 S ^TMP($J,"AMIE1",16)=""
 S ^TMP($J,"AMIE1",17)=""
 S ^TMP($J,"AMIE1",18)="*****This is an auto-generated email.  Do not respond to this email address.*****"
 S XMTEXT="^TMP($J,""AMIE1"","
 D ^XMD,END
 Q
 ;
FINDEXAM(ZMSG,ZIEN) ;Returns list of exams in 396.4 that are linked to ZIEN in 396.3
 N DVBABCNT,DVBABIEN
 S DVBABCNT=0,DVBABIEN=0
 F  S DVBABIEN=$O(^DVB(396.4,"C",ZIEN,DVBABIEN)) Q:'DVBABIEN  D
 .S DVBABD1=$P($G(^DVB(396.4,DVBABIEN,0)),"^",2)
 .S DVBABD2=$P($G(^DVB(396.6,+$P($G(^DVB(396.4,DVBABIEN,0)),"^",3),0)),"^",1)  ;Name of Exam
 .S DVBABD3=$P($G(^DVB(396.4,DVBABIEN,0)),"^",4)
 .I DVBABD3="O" S DVBABD3="[OPEN]"
 .I DVBABD3="C" S DVBABD3="[COMPLETE]"
 .I DVBABD3="X" S DVBABD3="[CANCELED BY MAS]"
 .I DVBABD3="RX" S DVBABD3="[CANCELED BY RO]"
 .I DVBABD3="T" S DVBABD3="[TRANSFERRED OUT]"
 .I ZIEN=DVBABD1 D
 ..S ZMSG(DVBABCNT)=DVBABIEN_"^"_DVBABD2_" "_DVBABD3
 ..S DVBABCNT=DVBABCNT+1
 K DVBABCNT,DVBABIEN,ZIEN,DVBABD1,DVBABD2,DVBABD3
 Q
 ;
 ;
SENDMSG(RIEN) ;SET UP TO SEND EMAIL/NOTIFICATION TO REQUESTOR OF 2507
 D GETREQ
 Q:DVBAEA=""
 ;
RDYMSG ;SEND REROUTED MESSAGE TO REQUESTOR OF 2507 
 ;no text/body is passed in so we have to build the message from scratch
 S XMSUB="CAPRI: 2507 Exam Request Rerouted"
 S ^TMP($J,"AMIE1",1)="The 2507 Exam Request as described below has been rerouted."
 S ^TMP($J,"AMIE1",2)=""
 S ^TMP($J,"AMIE1",3)=""
 S ^TMP($J,"AMIE1",4)="                 DFN:  `"_DVBADFN
 S ^TMP($J,"AMIE1",5)="          Requested Date: "_DVBADT
 S ^TMP($J,"AMIE1",6)="          Requested Site: "_RTF
 S ^TMP($J,"AMIE1",7)="          Requested By: "_DVBNM
 S ^TMP($J,"AMIE1",8)=""
 S ^TMP($J,"AMIE1",9)="          Rerouted Date: "_RDT
 S ^TMP($J,"AMIE1",10)="          Rerouted Site: "_RTO
 S ^TMP($J,"AMIE1",11)=""
 S ^TMP($J,"AMIE1",12)="         Reroute Reason: "_RRR
 S ^TMP($J,"AMIE1",13)="         Reroute Description: "_RRD
 S ^TMP($J,"AMIE1",14)=""
 S ^TMP($J,"AMIE1",15)=""
 S ^TMP($J,"AMIE1",16)="**NOTE: To view the patient using the DFN, paste the DFN number into the CAPRI"
 S ^TMP($J,"AMIE1",17)="Patient Selector 'Patient ID' field to find the patient. Be sure to include"
 S ^TMP($J,"AMIE1",18)="the ` (backward-apostrophe) character."
 S ^TMP($J,"AMIE1",19)=""
 S ^TMP($J,"AMIE1",20)=""
 S ^TMP($J,"AMIE1",21)=""
 S ^TMP($J,"AMIE1",22)="*****This is an auto-generated email.  Do not respond to this email address.*****"
 S XMTEXT="^TMP($J,""AMIE1"","
 D ^XMD,END
 Q
 ;
GETREQ ; Get infor the RIEN
 N DVBA0,DVBAREQ,DVBAC,DVBAQUIT,DUZ
 N MSG,MERR,CTR
 ;SINCE MAILMAN DOES NOT ALLOW MESSAGES TO BE SENT FROM USERS WITHOUT ACCESS CODES OR MAILBOXES
 ;WHICH CAPRI REMOTE USER DO NOT HAVE, WE HAVE TO NEW DUZ AND CHANGE XMDUZ TO THE NAME OF THE USER
 ;AS A STRING SO THE PROCESS IS STILL LINKED TO THE USER SENDING/TRIGGERING THE MESSAGE
 S DVBA0=$G(^DVB(396.3,RIEN,0))
 S DVBADFN=$P(DVBA0,"^",1),DVBAREQ=$P(DVBA0,"^",4)
 ;S XMDUZ=$P(^VA(200,DVBAREQ,0),"^",1)_" CAPRI"
 S XMDUZ="CAPRI "_$P(^VA(200,.5,0),"^",1)
 S DVBADT=$$FMTE^XLFDT($P(DVBA0,"^",2))
 ;following call supported by IA 3858
 S DVBAEA=$P($G(^VA(200,DVBAREQ,.15)),"^",1)
 S DVBNM=$P($G(^VA(200,DVBAREQ,0)),"^",1)
 S J1=$O(^DVB(396.3,RIEN,6,99999),-1)
 S J2=$O(^DVB(396.3,RIEN,6,J1,1,99999),-1)
 S J10=^DVB(396.3,RIEN,6,J1,0),J20=^DVB(396.3,RIEN,6,J1,1,J2,0)
 ;changes for patch 227 adding reject reason in reject message
 S RRRJ=$G(^DVB(396.3,RIEN,6,J1,1,J2,1))
 S:RRRJ="" RRRJ="None"
 S RRR=$$EXTERNAL^DILFD(396.34,4,,$P(J10,"^",5))
 S RRD=$P(J10,"^",6)
 S:RRD="" RRD="None"
 S RDT=$$EXTERNAL^DILFD(396.34,.01,,$P(J10,"^",1))
 S RTO=$$EXTERNAL^DILFD(396.34,.02,,$P(J10,"^",7))
 S RTF=$$EXTERNAL^DILFD(396.34,3,,$P(J10,"^",4))
 S RRRD=$$EXTERNAL^DILFD(396.341,.01,,$P(J20,"^",1))
 I DVBAEA="" Q
 S XMY(DVBAEA)="",DVBASITE=$$SITE^VASITE
 K J1,J10,J2,J20
 ;
 Q
 ;
MGUSR ; set email addresses from mail group
 ;  Supported References:                                               
 ;     DBIA #10111: Allows FM read access of ^XMB(3.8,D0,0) using DIC.
 ;
 N MGN,XMB,DIC,MMG,MDIEN,DVEM,MMUS,ERR
 S MGN="DVBA C 2507 REROUTE",XMB="DVBA CAPRI REROUTE"
 S XMDUZ="CAPRI "_$P(^VA(200,.5,0),"^",1)
 S DIC="^XMB(3.8,",DIC(0)="QM",X=MGN D ^DIC
 I +Y<0 S ERR="INVALID MAIL GROUP NAME" Q
 S MDIEN=+Y,MMG=0
 I '$$GOTLOCAL^XMXAPIG(MGN) S ERR="NO ACTIVE LOCAL MEMBERS IN MAIL GROUP" K ^TMP("XMERR",$J) Q
 F  S MMG=$O(^XMB(3.8,MDIEN,1,MMG)) Q:MMG="B"  D
 .S MMUS=$P($G(^XMB(3.8,MDIEN,1,MMG,0)),"^",1)
 .S DVEM=$P($G(^VA(200,MMUS,.15)),"^",1)
 .Q:DVEM=""
 .S XMY(DVEM)=""
 Q
 ;
END ;
 K RDT,RRD,RRR,RRRJ,RTF,RTO,X,XMY,XMSUB,XMTEXT,MGN,DIC,DIC(0),J,Y,XMDUZ,XMB,ERR,RRRD
 K ^TMP($J,"AMIE1"),DVBADFN,DVBASITE,DVBADT,DVBAEA,DVBNM
 Q
