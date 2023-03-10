DVBAB1 ;ALB/SPH - CAPRI UTILITIES ; MAY 27, 2022@11:31am
 ;;2.7;AMIE;**35,37,50,42,53,57,73,104,109,137,146,143,179,238**;Apr 10, 1995;Build 16
 ;
VERSION(ZMSG,DVBGUIV) ;
 ; 
 ; --rpc: DVBAB VERSION
 ; 
 ; Must have a letter at the end of the Version for Delphi compatibility.
 ;  1st piece is version description
 ;  2nd piece can be YESOLD or NOOLD
 ;    YESOLD --> Allow old GUI to run with new KID
 ;     NOOLD --> Do not allow old GUI to run with newer version
 ;
 ;  Ex: "CAPRI GUI V2.7*123*0*A^NOOLD"
 ; 
 ; Sets variables DVBABVR* so that the error trap will display what
 ; version of the client software the user was utilizing if CAPRI bombs.
 ; Patch 238 adds two N variables and the checking GUI version against minimum and previous versions
 ;
 N DVBVERS
 N DVBOLD
 N DVBPREV
 N DVBGUIC
 N DVBABVR1,DVBABVR2,DVBABVR3
 ;
 ;obtain version parameters and build version string result
 S DVBVERS=$$GET^XPAR("PKG","DVBAB CAPRI MINIMUM VERSION",1,"Q")
 S DVBOLD=$$GET^XPAR("PKG","DVBAB CAPRI ALLOW OLD VERSION",1,"Q")
 S ZMSG=DVBVERS_"^"_$S(DVBOLD=1:"YESOLD",1:"NOOLD")
 ;
 ;238-Checking GUI version against minimum and previous versions
 ;Strip preceding zero from minor build number and setting date to prevent other gui's
 I $G(DVBGUIV)'="" S DVBGUIC=DVBGUIV,$P(DVBGUIC,".",3)=+$P(DVBGUIC,".",3) D 
 .I $P(ZMSG,"*",2)'=$P(DVBGUIC,"*",3) D
 ..S DVBPREV=$$GET^XPAR("PKG","DVBAB CAPRI PREVIOUS VERSION",1,"Q")
 ..I DVBPREV'="",($P(DVBGUIC,"*",3)'=$P(DVBPREV,"*",3)) D
 ...S $P(ZMSG,"*",5)=2800101
 ;
 ;set DVBABVR* vars for error trap
 S DVBABVR1="CAPRI Server Version: "_ZMSG
 S DVBABVR2="CAPRI GUI Version: "_$S($G(DVBGUIV)]"":DVBGUIV,1:"UNKNOWN")
 S DVBABVR3=$P(^VA(200,DUZ,0),"^",1)
 Q 
 ;
REQUESTS(Y,TYPE) ;
 ; TYPE is the internal value of field 17 in file 396.3
 ; This relates to which status of request should be returned
 N DVBABCNT,DVBABIEN
 S DVBABCNT=0,DVBABIEN=0
 F  S DVBABIEN=$O(^DVB(396.3,DVBABIEN)) Q:'DVBABIEN  D
 .S DVBABST=$P($G(^DVB(396.3,DVBABIEN,0)),"^",18)
 .I DVBABST=TYPE D
 ..S DVBABNM=$P($G(^DVB(396.3,DVBABIEN,0)),"^",1)
 ..S DVBABPT=DVBABNM
 ..I DVBABNM'="" S DVBABNM=$P($G(^DPT(DVBABNM,0)),"^",1)
 ..S DVBABDT=$$FMTE^XLFDT($P($G(^DVB(396.3,DVBABIEN,0)),"^",2),"2D")
 ..S DVBABWHO=$P($G(^DVB(396.3,DVBABIEN,0)),"^",4)
 ..I DVBABWHO'="" S DVBABWHO=$P($G(^VA(200,DVBABWHO,0)),"^",1)
 ..E  S DVBABWHO="UNKNOWN"
 ..S DVBABRO=$P($G(^DVB(396.3,DVBABIEN,0)),"^",3)
 ..I DVBABRO'="" S DVBABRO=$P($G(^DIC(4,DVBABRO,0)),"^",1)
 ..E  S DVBABRO="UNKNOWN"
 ..S ^TMP("DVBAREQ",DUZ,DVBABCNT)=DVBABST_"^"_DVBABPT_"^"_DVBABNM_"^"_DVBABDT_"^"_DVBABWHO_"^"_DVBABRO_"^"_DVBABIEN_$C(13),DVBABCNT=DVBABCNT+1
 S Y=$NA(^TMP("DVBAREQ",DUZ))
 K DVBABCNT,DVBABIEN,TYPE,DVBABNM,DVBABDT,DVBABST,DVBABWHO,DVBABPT
 Q
TEAMPTS(DVBORY,TEAM,TMPFLAG) ; RETURN LIST OF PATIENTS IN A TEAM
 ; If TMPFLAG passed and = TRUE, code expects a "^TMP(xxx"
 ;    global root string passed in ORY, and builds the returned 
 ;    list in that global instead of to a memory array.
 N DOTMP,NEWTMP,DVBSSN,DVBORI,DVBORPT,I
 K ^TMP("DVBATMPT",DUZ)
 S (I,DOTMP,DVBORI)=0
 I $G(TMPFLAG) D             ; Was value passed?
 .I TMPFLAG S DOTMP=1        ; Is value TRUE?
 I +$G(TEAM)<1 D
 .I DOTMP S NEWTMP=DVBORY_1_")",@NEWTMP="^No team identified"
 .E  S DVBORY(1)="^No team identified"
 F  S DVBORI=$O(^OR(100.21,+TEAM,10,DVBORI)) Q:DVBORI<1  D
 .S DVBORPT=^OR(100.21,+TEAM,10,DVBORI,0)
 .I DOTMP D
 ..S I=I+1,NEWTMP=DVBORY_+I_")"
 ..S @NEWTMP=+DVBORPT_U_$P(^DPT(+DVBORPT,0),U)
 .S DVBSSN=$P($G(^DPT($P(DVBORPT,";",1),0)),U,9)
 .E  S I=I+1,^TMP("DVBATMPT",DUZ,I)=+DVBORPT_U_$P(^DPT(+DVBORPT,0),U)_U_DVBSSN_$C(13)
 I DOTMP S:I<1 NEWTMP=DVBORY_1_")",@NEWTMP="^No patients found."
 E  S:I<1 ^TMP("DVBATMPT",DUZ,1)="^No patients found."
 S DVBORY=$NA(^TMP("DVBATMPT",DUZ))
 Q
DIVISION(Y) ; Returns Name for an Institution
 N DVBARR,DVBERR,DVBATP
 S Y=""
 Q:$G(DUZ(2))=""
 D GETS^DIQ(4,DUZ(2)_",0",".01","I","DVBARR","DVBERR")
 Q:$D(DVBERR)
 S Y=$G(DVBARR(4,DUZ(2)_",0,",.01,"I"))
 D GETS^DIQ(4,DUZ(2)_",0",13,"I","DVBARR","DVBERR")
 S DVBATP=$G(DVBARR(4,DUZ(2)_",0,",13,"I"))
 I DVBATP'="" S DVBATP=$P($G(^DIC(4.1,DVBATP,0)),"^",1)
 S Y=Y_"-"_DVBATP
 Q
 ;
DT(Y,X1,X2) ; Returns date X1 minus X2 days
 ; change the '00:00' that could be passed so Fileman doesn't reject
 ;C^%DTC(X1,X2)
 ;S %DT=$G(%DT,"TS") D ^%DT
 ;K %DT,X1,X2
 ;Q
DTTM(Y) ;
 S Y=$$HTE^XLFDT($H,"P")
 Q
CHKCRED(Y) ;KLB
 S Y="[OK]"
 I '$D(DUZ(2)) S Y="Your division number is missing." Q
 I $D(DUZ)#2=0 S Y="Your user number is invalid." Q
 I +DUZ(2)<1 S Y="Invalid division."
 Q
PTINQ(REF,DFN) ; Return formatted pt inquiry report
 K ^TMP("ORDATA",$J,1)
 ; DVBA*2.7*109 - Added $D to next line
 I ($D(^DPT(DFN,0))) D START^ORWRP(80,"DGINQB^ORCXPND1(DFN)")
 S REF=$NA(^TMP("ORDATA",$J,1))
 Q
TEMPLATE(Y) ; Returns list of CAPRI exam templates
 N DVBABCNT,DVBABIEN,DVBABNM,DVBABAD,DVBABDD,DVBABSL,DVBABOC
 K Y,^TMP("DVBALAB1",DUZ)
 S DVBABCNT=0,DVBABIEN=0
 F  S DVBABIEN=$O(^DVB(396.18,DVBABIEN)) Q:'DVBABIEN  D
 .S DVBABNM=$P($G(^DVB(396.18,DVBABIEN,0)),"^",1)
 .S DVBABAD=$P($G(^DVB(396.18,DVBABIEN,2)),"^",1)
 .S DVBABDD=$P($G(^DVB(396.18,DVBABIEN,2)),"^",2)
 .S DVBABSL=$P($G(^DVB(396.18,DVBABIEN,6)),"^",1)
 .S DVBABOC=$P($G(^DVB(396.18,DVBABIEN,6)),"^",2)
 .S ^TMP("DVBATMPL",DUZ,DVBABCNT)=DVBABNM_"^"_DVBABAD_"^"_DVBABDD_"^"_DVBABSL_"^"_DVBABOC_"^"_DVBABIEN_$C(13),DVBABCNT=DVBABCNT+1
 S Y=$NA(^TMP("DVBATMPL",DUZ))
 Q
 ;
LABLIST(Y) ; Returns list of LAB TEST NAMES
 N DVBABCNT,DVBABIEN,DVBABLNM
 K Y,^TMP("DVBALAB1",DUZ)
 S DVBABCNT=0,DVBABIEN=0
 F  S DVBABIEN=$O(^LAB(60,DVBABIEN)) Q:'DVBABIEN  D
 .S DVBABLNM=$P($G(^LAB(60,DVBABIEN,0)),"^",1)
 .S ^TMP("DVBALAB1",DUZ,DVBABCNT)=DVBABLNM_"^"_DVBABIEN_$C(13),DVBABCNT=DVBABCNT+1
 S Y=$NA(^TMP("DVBALAB1",DUZ))
 Q
 ;
INSTLIST(Y) ; Returns full list of Institutions
 N DVBABCNT,DVBABIEN,DVBABNM,DVBABSTN,DVBABST,DVBABDS,DVBARR,DVBERR,DVBATP
 K Y,^TMP("DVBAINST",$J,DUZ)
 S (DVBABCNT,DVBABIEN)=0
 F  S DVBABIEN=$O(^DIC(4,DVBABIEN)) Q:'DVBABIEN  D 
 . K DVBARR,DVBERR
 . D GETS^DIQ(4,DVBABIEN_",0",".01:.02:.03:","I","DVBARR","DVBERR")
 . Q:$D(DVBERR)
 . S DVBABNM=$G(DVBARR(4,DVBABIEN_",0,",.01,"I"))
 . Q:DVBABNM=""
 . S DVBABSTN=$G(DVBARR(4,DVBABIEN_",0,",.02,"I"))
 . Q:DVBABSTN=""
 . S DVBABDS=$G(DVBARR(4,DVBABIEN_",0,",.03,"I"))
 . K DVBARR,DVBERR
 . D GETS^DIQ(5,DVBABSTN_",0",.01,"I","DVBARR","DVBERR")
 . Q:$D(DVBERR)
 . S DVBABST=$G(DVBARR(5,DVBABSTN_",0,",.01,"I"))
 . K DVBARR,DVBERR
 . D GETS^DIQ(4,DVBABIEN_",0",13,"I","DVBARR","DVBERR")
 . S DVBATP=$G(DVBARR(4,DVBABIEN_",0,",13,"I"))
 . I DVBATP'="" D
 .. S DVBATP=$P($G(^DIC(4.1,DVBATP,0)),"^",1)
 . S ^TMP("DVBAINST",$J,DUZ,DVBABCNT)=DVBABNM_"-"_DVBATP_"^"_DVBABST_"^"_DVBABDS_"^"_DVBABIEN_$C(13)
 . S DVBABCNT=DVBABCNT+1
 S Y=$NA(^TMP("DVBAINST",$J,DUZ))
 Q
 ;
INCEXAM(ZMSG) ;Increased exam # in file  and passes back the # to user
 S ZMSG=+$G(^DVB(396.1,1,5))+1
 S ^DVB(396.1,1,5)=ZMSG
 Q
 ;
MSG(ERR,DUZ,XMSUB,XMTEXT,MGN,ID) ;Generate mail message;KLB
 ; --rpc: DVBAB SEND MSG
 ;
 ; This remote procedure is used to generate bulletins for specific CAPRI actions, such as cancellation of 2507 exams.
 ;
 ;  Supported References:                                               
 ;     DBIA #10111: Allows FM read access of ^XMB(3.8,D0,0) using DIC.
 K ^TMP($J,"AMIE")
 S XMB="",XMDUZ=DUZ
 I '$D(DUZ) S ERR="MISSING DUZ" Q
 I '$D(XMSUB) S ERR="MISSING SUBJECT" Q
 I '$D(XMTEXT) S ERR="MISSING TEXT" Q
 I '$D(MGN) S ERR="MISSING MAIL GROUP NAME" Q
 ;IF MGN=DVBA C 2507 EXAM READY NO BULLETIN NECESSARY, BUILD THE EMAIL AND QUIT
 I MGN="DVBA C 2507 EXAM READY" D SENDMSG Q
 S J=0
 F  S J=$O(XMTEXT(J)) Q:'J  S ^TMP($J,"AMIE",J)=$G(XMTEXT(J))
 S XMTEXT="^TMP($J,""AMIE"","
 S DIC="^XMB(3.8,",DIC(0)="QM",X=MGN D ^DIC
 I +Y<0 S ERR="INVALID MAIL GROUP NAME" Q
 I '$$GOTLOCAL^XMXAPIG(MGN) S ERR="NO ACTIVE LOCAL MEMBERS IN MAIL GROUP" K ^TMP("XMERR",$J) Q
 I MGN="DVBA C NEW C&P VETERAN" S XMB="DVBA CAPRI NEW C&P VETERAN"
 I MGN="DVBA C 2507 CANCELLATION" S XMB="DVBA CAPRI 2507 CANCELLATION"
 I XMB="" S ERR="UNABLE TO SET BULLETIN" Q
 D ^XMB
 ;XMB = -1 if bulletin not found in file (#3.6)
 S ERR=$S(XMB=-1:"BULLETIN NOT FOUND",1:"MESSAGE SENT")
 ;before we quit, send a message to the requestor if the message is a cancellation
 I MGN="DVBA C 2507 CANCELLATION" D SENDMSG
 K XMSUB,XMTEXT,MGN,DIC,DIC(0),J,Y,XMDUZ,XMB
 Q
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
SENDMSG ;SET UP TO SEND EMAIL/NOTIFICATION TO REQUESTOR OF 2507
 N DVBA0,DVBAREQ,DVBAEA,DVBAC,DVBAQUIT,DVBADFN,DVBASITE,DVBADT,DUZ
 N MSG,MERR,CTR,RIEN
 ;SINCE MAILMAN DOES NOT ALLOW MESSAGES TO BE SENT FROM USERS WITHOUT ACCESS CODES OR MAILBOXES
 ;WHICH CAPRI REMOTE USER DO NOT HAVE, WE HAVE TO NEW DUZ AND CHANGE XMDUZ TO THE NAME OF THE USER
 ;AS A STRING SO THE PROCESS IS STILL LINKED TO THE USER SENDING/TRIGGERING THE MESSAGE
 I $G(ID)="" Q
 S XMDUZ=$P(^VA(200,XMDUZ,0),"^",1)_" CAPRI"
 S DVBA0=$G(^DVB(396.3,ID,0))
 S DVBADFN=$P(DVBA0,"^",1),DVBAREQ=$P(DVBA0,"^",4),DVBADT=$$FMTE^XLFDT($P(DVBA0,"^",2))
 ;following call supported by IA 3858
 S DVBAEA=$P($G(^VA(200,DVBAREQ,.15)),"^",1)
 I DVBAEA'="" D
 . S XMY(DVBAEA)="",DVBASITE=$$SITE^VASITE
 . I MGN="DVBA C 2507 CANCELLATION" D CNCLMSG Q
 . I MGN="DVBA C 2507 EXAM READY" D RDYMSG Q
 Q
CNCLMSG ;SEND CANCEL MESSAGE TO REQUESTOR OF THE 2507 EXAM
 ;need to loop through previously built text to make sure all PII is removed
 S J=0,DVBAQUIT=0
 F  S J=$O(^TMP($J,"AMIE",J)) Q:'J!(DVBAQUIT)  D
 .I $G(^TMP($J,"AMIE",J))["Name" S ^TMP($J,"AMIE",J)="DFN: `"_DVBADFN_"       SITE: "_$P($G(DVBASITE),"^",2)_"       Request Date: "_DVBADT
 .I $G(^TMP($J,"AMIE",J))["Additional Comments" D  Q
 ..S ^TMP($J,"AMIE1",J)="**NOTE: To view the patient using the DFN, paste the DFN number into the CAPRI"
 ..S ^TMP($J,"AMIE1",J+1)="Patient Selector 'Patient ID' field to find the patient. Be sure to include"
 ..S ^TMP($J,"AMIE1",J+2)="the ` (backward-apostrophe) character."
 ..S ^TMP($J,"AMIE1",J+3)=""
 ..S ^TMP($J,"AMIE1",J+4)=""
 ..S ^TMP($J,"AMIE1",J+4)=""
 ..S ^TMP($J,"AMIE1",J+5)="*****This is an auto-generated email.  Do not respond to this email address.*****"
 ..S DVBAQUIT=1 Q
 .S ^TMP($J,"AMIE1",J)=$G(^TMP($J,"AMIE",J))
 S XMTEXT="^TMP($J,""AMIE1"","
 D ^XMD
 K ^TMP($J,"AMIE1")
 Q
RDYMSG ;SEND EXAM COMPLETE MESSAGE TO REQUESTOR OF 2507 
 ;no text/body is passed in so we have to build the message from scratch
 S ^TMP($J,"AMIE1",1)="A 2507 request as described below has been completed and released to the regional office , and is now available in CAPRI."
 S ^TMP($J,"AMIE1",2)=""
 S ^TMP($J,"AMIE1",3)=""
 S ^TMP($J,"AMIE1",4)="                 DFN:  `"_DVBADFN
 S ^TMP($J,"AMIE1",5)="          Vista Site: "_$P($G(DVBASITE),"^",2)
 S ^TMP($J,"AMIE1",6)="        Request Date: "_DVBADT
 S ^TMP($J,"AMIE1",7)=""
 S ^TMP($J,"AMIE1",8)=""
 S ^TMP($J,"AMIE1",9)="**NOTE: To view the patient using the DFN, paste the DFN number into the CAPRI"
 S ^TMP($J,"AMIE1",10)="Patient Selector 'Patient ID' field to find the patient. Be sure to include"
 S ^TMP($J,"AMIE1",11)="the ` (backward-apostrophe) character."
 S ^TMP($J,"AMIE1",12)=""
 S ^TMP($J,"AMIE1",13)=""
 S ^TMP($J,"AMIE1",14)=""
 S ^TMP($J,"AMIE1",15)="*****This is an auto-generated email.  Do not respond to this email address.*****"
 S XMTEXT="^TMP($J,""AMIE1"","
 D ^XMD
 K ^TMP($J,"AMIE1")
 K XMSUB,XMTEXT,MGN,XMDUZ
 Q
