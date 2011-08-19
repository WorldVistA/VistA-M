RCRCSRV ;ALB/CMS - RC SERVER DRIVER ; 16-JUN-00
V ;;4.5;Accounts Receivable;**61,87,63,147,159**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
SERVER ;RC RC SERV SERVER OPTION MAIN ENTRY POINT
 ;INPUT  : Mailman variables
 ;OUTPUT : Sets the XTMP global for certain types of message
 ;       : Sets the task job in the background if appropriate
 ;       : Adds Confirmation or Error to AR Transmission File
 ;
 Q:$G(XMZ)=""  Q:'$D(^XMB(3.9,XMZ))
 S XMXX="S.RC RC SERV",XMCHAN=1
 D SETSB^XMA1C ;Save message in postmaster server basket
 N RCBDT,RCCMSG,RCDOM,RCEDT,RCJOB,RCSCE,RCSTA,RCTYP,RCVAR,RCSITE,RCXMY,RCXMZ,RCXTYP
 S RCXMZ=XMZ,RCJOB=$J
 D READ
 D SEND
 D TASK
 S XMZ=RCXMZ,XMSER="S.RC RC SERV" D REMSBMSG^XMA1C
 K XMCHAN,XMDUZ,XMDUN,XMFROM,XMREC,XMSER,XMXX,XMY,XMZ
Q Q
 ;
READ ;READ TRANSMISSION CHK FIRST LINE PUT MESSAGE IN XTMP
 N II,RCEND,RCNT,XMRG,XMER,X2
 S RCNT=0,RCCMSG="",RCSITE=$$SITE^RCMSITE,RCDOM=$G(XMFROM)
 F II=0:0 D  Q:$G(RCCMSG)]""
 .X XMREC S RCNT=RCNT+1
 .I $G(XMER)<0 D  Q
 ..I $G(RCEND)="" S RCCMSG="E;Incomplete message from Regional Counsel"
 ..E  S RCCMSG="C;AR accepted "_RCNT_" lines successfully."
 ..S RCBDT=$P($G(RCEND),"$",4),RCEDT=$P($G(RCEND),"$",5)
 ..; I +$P(RCVAR,U,5),$D(^XTMP(RCXTYP,RCJOB,0)) S $P(^XTMP(RCXTYP,RCJOB,0),"^",5)=RCNT
 .I RCNT=1 D CHK1 I $G(RCCMSG)]"" Q
 .I ($P(XMRG,"$",2)="END")!($P(XMRG,"$",3)="END") S RCEND=XMRG S RCNT=RCNT-1 Q
 .I '$L(XMRG) S RCNT=RCNT-1 Q
 .I +$P(RCVAR,U,5) S ^XTMP(RCXTYP,RCXMZ,RCNT)=XMRG
 Q
 ;
SEND ;CONFIRMATION, ERROR, ORIGINAL MESSAGE TRANSPORT
 ;I message is the original send confirmation or error to RC
 ;INPUT: RCCMSG from Read module always set
 ;       RCVAR if exists
 ;I message is a Confirmation or Error from RC to site quit
 I $P(RCCMSG,";",1)="Q" G SENDQ
 S RETRY=0
 ;
XMB N LN,RCCOM,RCSUB,RCWHO,RETRY,XMDUZ,XMSUB,XMTEXT,XMY,X,Y
 ;Line below may not be needed
 ;I confirmation don't send to anyone.
 I $G(RCDOM)="" S RCDOM=$$RCDOM^RCRCUTL
 S:$G(XMFROM)]"" XMY(XMFROM)=""
 ;S RCWHO="S.RC RC SERV@"_RCDOM,XMY(RCWHO)=""
 S RCWHO=RCDOM,XMY(RCWHO)=""
 S Y=DT D D^DIQ
 S LN(1)="$$RC$"_$G(RCTYP,"UNK")_"$"_$E(RCCMSG,1)_"$"_$G(RCSITE,"UNK")_"$"
 S LN(2)="Status: Mail Message #("_XMZ_") received at the VAMC "_$G(RCSITE,"UNK")_" system on "_Y
 S LN(3)=$S($E(RCCMSG,1)="E":"Error ",1:"")_"Message: "_$P(RCCMSG,";",2)
 S LN(4)="Desc.: "_$P($G(RCVAR),U,4)
 S (RCSUB,XMSUB)="AR/RC - "_$G(RCSITE,"UNK")_" "_$S($E(RCCMSG,1)="C":"CONFIRMATION ("_$G(RCTYP,"UNK")_")",1:"TRANSMISSION ("_$G(RCTYP,"UNK")_") ERROR")_" MESSAGE"
 S XMTEXT="LN(",XMDUZ="ACCOUNTS RECEIVABLE RC SERVER"
 D ^XMD I XMZ<1 S RETRY=RETRY+1 I RETRY<100 G XMB
 S RCCOM=LN(3)
 D ENT^RCRCXMS(XMZ,RCSUB,RCWHO,RCCOM)
SENDQ Q
 ;
CHK1 ;CHECK FIRST LINE OF TRANSMISSION
 ;First Line Syntax: 
 ;$$RC$S1$$sta#prefix$RC Address
 ;  o first four characters must be $$RC$
 ;  o $ piece 4 required must be a server code in routine RCRCVAR
 ;  o $ piece 5 will be "C" for a confirmation message or
 ;                      "E" for error receiving the message
 ;                       "" for the original transmission of a message 
 ;  o $ piece 6 station number 
 ;  o $ piece 7 is the RC address to send back to at RCDOM
 ;Last Line Syntax: $END$#oflines$
 ;                  $END$#oflines$Beg.Ref.DT$End.Ref.DT (Rec Rept. 4 of 4)
 ; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 ;INPUT:  XMRG - First line of mail message
 ;OUTPUT: RCVAR - Server Code^(C,E,O)^Recipient^desc.^0or1^taskroutine
 ;        or Killed
 ;        RCCMSG - Error message
 ;        RCSTA - Station Number
 ;        RCXMY - send message to
 ;        RCJOB - $J
 ;        
 I $E(XMRG,1,5)'="$$RC$" S RCCMSG="E;RC Server at site is unable to interpret the first line of this message." G CHK1Q
 S RCSCE=$P(XMRG,"$",5) S RCSCE=$S(RCSCE="C":RCSCE,RCSCE="E":RCSCE,RCSCE="":"O",1:"UNK")
 S RCTYP=$P(XMRG,"$",4),RCVAR=$$CHK^RCRCVAR(RCTYP,RCSCE)
 I $P(RCVAR,";",1)="E" S RCCMSG=RCVAR K RCVAR G CHK1Q
 S RCSTA=$P(XMRG,"$",6)
 S RCXMY=$P(XMRG,"$",7)
 S RCDOM=$G(XMFROM)
 ; If original message needs an XTMP global initialize it 
 I +$P(RCVAR,U,5) D XTMP(RCTYP,$P(RCVAR,U,4))
 D FILE
 I "CE"[RCSCE S RCCMSG="Q;"
CHK1Q Q
 ;
TASK ;If message is original fire off the background job
 ;fire off the background task now. (The time the server is run.)
 I $G(RCSCE)="O",$E($G(RCCMSG),1)'="E" D TASK^RCRCRR
TASKQ Q
 ;
FILE ;Update AR Transmission File
 N DA,DIE,DR,RCCOM,RCX,X,Y
 I RCSCE="O" D  G FILEQ
   . S RCSUB=$$SUBGET^XMGAPI0(RCXMZ)
   . S RCCOM="RC sent Request Action ("_RCTYP_")."
   . D ENT^RCRCXMS(RCXMZ,$G(RCSUB),"RC SERVER AT "_RCSTA,RCCOM)
 ;If Message is a Confirm or Error from RC
 X XMREC S RCNT=RCNT+1 I XMRG'["STATUS:" G FILEQ
 S RCX=+$P(XMRG,"Message ",2)
 S DA=$O(^RCT(349.3,"B",RCX,0))
 I DA S DIE="^RCT(349.3,",DR=$S(RCSCE="E":6,1:5)_"////^S X="_RCXMZ D ^DIE
 I 'DA,RCSCE="E" D
   . S RCSUB=$$SUBGET^XMGAPI0(RCXMZ)
   . S RCCOM="RC sent Error message ("_RCTYP_")."
   . D ENT^RCRCXMS(RCXMZ,$G(RCSUB),"RC SERVER AT "_RCSTA,RCCOM)
FILEQ Q
 ;
XTMP(RCTYP,RCDSC) ;INITIALIZE TOP XTMP Global for Server Type
 ;INPUT : Type of server message  must be passed
 ;OUTPUT: XTMP global gets created for this server type
 ;      : RCXTYP gets set to PRCA_rctype(MR1,RR1,TR,CL...)
 ;      : RCJOB Job Number
 ;XTMP purge data will be 30 days past the create date
 N RCDT,X,X1,X2,Y,%,%H,%I
 D NOW^%DTC S (X1,RCDT)=X,X2=30 D C^%DTC
 S RCXTYP="PRCA"_RCTYP K ^XTMP(RCXTYP,RCXMZ)
 S ^XTMP(RCXTYP,RCXMZ,0)=X_"^"_RCDT_"^"_RCDSC_U_RCXMZ
 Q
 ;RCRCSRV
