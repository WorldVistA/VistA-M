SCMCHLM ;BP/DJB - PCMM HL7 Mail Msgs ; 6/28/99 10:16am
 ;;5.3;Scheduling;**177,210,505**;AUG 13, 1993;Build 20
 ;
 ;Reference routine: SCDXMSG2
CMPLBULL(SENT,ERRCNT,VALER) ;Send completion bulletin
 ;
 ;Input  : SENT   - Number of messages sent to NPCD. Default=0.
 ;         ERRCNT - Number of errored messages.
 ;         VALER  - Array containing error messages.
 ;Output : None
 ;
 ;Check input
 S SENT=+$G(SENT)
 S ERRCNT=$G(ERRCNT)
 S VALER=$G(VALER)
 ;
 ;Declare variables
 NEW MSGTXT,XMB,XMTEXT,XMY,XMDUZ,XMDT,XMZ,XMITPTR,LINE
 NEW ENCPTR,DELPTR,ENCDATE,ENCLOC,NAME,TMP,ENCZERO,SSN,PATZERO
 ;
 S MSGTXT="^TMP(""SCMC-XMIT-BLD"","_$J_",""BULLETIN"")"
 KILL @MSGTXT
 ;
 ;Put number of messages transmitted into message text
 S @MSGTXT@(1)="Transmission of PCMM Primary Care data to the NPCD has completed."
 S @MSGTXT@(2)=""
 S @MSGTXT@(3)="A total of "_SENT_" messages were sent."
 ;Put number of nontransmitted messages into message text
 S @MSGTXT@(4)="A total of "_ERRCNT_" messages were not sent."
 S @MSGTXT@(5)=""
 S @MSGTXT@(6)="Please review the IEMM Error listing for further detail."
 ;
 ;Set bulletin subject
 S XMB(1)="Transmission of data to NPCDB completed"
 ;Deliver bulletin
 S XMB="PCMM PRIMARY CARE DATA TO NPCDB SUMMARY"
 S XMTEXT=$P(MSGTXT,")",1)_","
 D ^XMB
 ;Done - clean up and quit
 KILL @MSGTXT
 Q
 ;
ERRBULL(REASON) ;Send error bulletin
 ;
 ;Input  : REASON - Why transmission of data could not be completed
 ;Output : None
 ;
 ;Check input
 S REASON=$G(REASON)
 ;
 ;Declare variables
 NEW MSGTXT,XMB,XMTEXT,XMY,XMDUZ,XMDT,XMZ
 ;
 ;Set message text
 S MSGTXT(1)="Transmission of PCMM Primary Care data to the CDCO"
 S MSGTXT(2)=" "
 S MSGTXT(3)="could not be completed for the following reason:"
 S MSGTXT(4)=" "
 S MSGTXT(5)="  "_REASON
 ;
 ;Set bulletin subject
 S XMB(1)="** TRANSMISSION OF DATA TO NPCDB NOT COMPLETED **"
 ;Deliver bulletin
 S XMB="PCMM PRIMARY CARE DATA TO NPCDB SUMMARY"
 S XMTEXT="MSGTXT("
 D ^XMB
 ;
 ;Done
 Q
 ;
NOTIFY ; Description: This is used to send a message to local mail group.
 ; The notification message is used to alert users at the local site
 ; that new PCMM HL7 Transmission errors were received from the CDCO.
 ;
 ;Reference routine: SCMCHLRR
 ;
 ;  Input: None
 ; Output: None
 ;
 ;Init variables
 N ACK,SCBEG,SCCNT,SCEND,SCTLIEN,SCSTAT
 N SCAIEN,SCADFN,SCBIEN,SCCX,SCCY,SCGLB,SCCIENB,SCCIENA,SCTPSS
 N SCTPOS,SCY,SCX,SCINNAM
 N SCHLIEN,SCHLIEN1,SCHLIEN2,SCHLIEN3,SCHLIEN4,SCHLIEN5,SCINT
 N SCMCIDX,SCMCIE,SCMCTMX,SCMCTPX,SCMCX,SCMGIEN,SCTP
 S (SCTLIEN,SCBEG,SCEND,SCCNT)=0 K ^XTMP("SCMCHLM")
 S ^XTMP("SCMCHLM",0)=DT_U_DT
 ;
 ;Get data from PCMM HL7 Trans Log file for records that have
 ;have a status of 'rejected' and 'marked for re-transmit'
 F SCSTAT="M","RJ" D
 .F  S SCTLIEN=$O(^SCPT(404.471,"ASTAT",SCSTAT,SCTLIEN)) Q:SCTLIEN=""  D
 ..;
 ..;if Included In Reject Bulletin? field is not 'YES'
 ..I $$INCLUDE^SCMCHLA(SCTLIEN)'="Y" D
 ...;
 ...;count rejects received
 ...S SCCNT=SCCNT+1
 ...;
 ...;get institution,team,position and message ID
 ...S (SCTPOS,SCTPSS,SCINNAM,SCTP)="UNK"
 ...S SCAIEN=$G(^SCPT(404.471,SCTLIEN,0)) D
 ....S SCADFN=$P(SCAIEN,U,2),SCMGIEN=$P(SCAIEN,U),SCHLIEN=0
 ....F  S SCHLIEN=$O(^SCPT(404.471,SCTLIEN,"ZPC",SCHLIEN)) Q:SCHLIEN=""  D
 .....S SCHLIEN1=$G(^SCPT(404.471,SCTLIEN,"ZPC",SCHLIEN,0)) Q:SCHLIEN1=""
 .....S SCHLIEN2=$P(SCHLIEN1,U,2),SCHLIEN3=+$G(^SCPT(404.49,SCHLIEN2,0))
 .....S SCHLIEN4=$G(^SCPT(404.43,SCHLIEN3,0)) Q:SCHLIEN4=""
 .....S SCHLIEN5=$G(^SCPT(404.42,+SCHLIEN4,0)) Q:SCHLIEN5=""
 .....S SCTPOS=$P(SCHLIEN4,U,2),SCTPSS=$G(^SCTM(404.57,+SCTPOS,0))
 .....S SCTP=$P(SCTPSS,U,2),SCY=$G(^SCTM(404.51,+SCTP,0)),SCINT=$P(SCY,U,7)
 .....S SCINNAM=$$GET1^DIQ(4,+SCINT_",",.01)
 .....I '$D(^XTMP("SCMCHLM",$J,+SCINT,+SCAIEN)) D
 ......S ^XTMP("SCMCHLM",$J,+SCINT,+SCAIEN,+SCHLIEN)=SCINNAM_"^"_$P(SCTPSS,U)_"^"_$P(SCY,U)
 ...;get date/time of 'earliest' and 'latest' reject msg
 ...S ACK=$$ACK^SCMCHLA(SCTLIEN)
 ...I 'SCBEG S SCBEG=ACK
 ...I ACK<SCBEG S SCBEG=ACK
 ...I 'SCEND S SCEND=ACK
 ...I ACK>SCEND S SCEND=ACK
 ...;
 ...;set Included In Reject Bulletin? field of record to 'YES'
 ...I $$UPDINCL^SCMCHLA(SCTLIEN,"Y")
 ;
 ;If reject msgs, then send notification message
 I SCCNT D SEND(SCBEG,SCEND,SCCNT)
 Q
 ;
SEND(SCBEG,SCEND,SCCNT) ;
 ; Description: Used to send PCMM Transmission Errors Received
 ; notification message.
 ;
 ;  Input:
 ;   SCBEG - internal FM date/time earliest error received
 ;   SCEND - internal FM date/time latest error received
 ;   SCCNT - count of errors received
 ;
 ; Output: None
 ;
 N SCRANGE,TEXT,XMDUN,XMDUZ,XMTEXT,XMROU,XMSTRIP,XMSUB,XMY,XMZ
 ;
 ;Init subj/sender
 S XMSUB="PCMM Transmission Errors Received"
 S (XMDUN,XMDUZ)="PCMM Module"
 ;
 ;Recipient (mail group)
 S XMY("G.PCMM TRANSMISSION ERRORS")=""
 ;
 ;Message body
 S XMTEXT="TEXT("
 S TEXT(1)="PCMM reject transmissions have been received from the Corporate"
 S TEXT(2)="Data Center Operations (CDCO)."
 S TEXT(3)=""
 S SCRANGE=" Reject Transmissions Received: "_$$FMTE^XLFDT($G(SCBEG),"2P")_" thru "_$$FMTE^XLFDT($G(SCEND),"2P")
 S TEXT(4)=SCRANGE
 S TEXT(5)="  Total Transmissions Rejected: "_$G(SCCNT)
 S TEXT(6)=""
 S TEXT(7)="Please use the PCMM Transmission Error Processing option for a"
 S TEXT(8)="list of the errors associated with these rejected transmissions."
 S TEXT(9)=""
 S TEXT(10)="Institution              Message ID        Team             Position"
 S TEXT(11)="===========              ==========        ====             ========"
 S TEXT(12)=""
 N SCMCID,SCMCIN,SCMCIDN,SCMCTM,SCMCTP,SCMCINNM,SCMCL
 S SCMCL=12
 S SCMCIN=0 F  S SCMCIN=$O(^XTMP("SCMCHLM",$J,SCMCIN)) Q:SCMCIN=""  D
 .S SCMCID=0 F  S SCMCID=$O(^XTMP("SCMCHLM",$J,SCMCIN,SCMCID)) Q:SCMCID=""  D
 ..S SCMCIE=0 F  S SCMCIE=$O(^XTMP("SCMCHLM",$J,SCMCIN,SCMCID,SCMCIE)) Q:SCMCIE<1  D
 ...S SCMCIDN=$G(^XTMP("SCMCHLM",$J,SCMCIN,SCMCID,SCMCIE))
 ...S SCMCINNM=$E($P(SCMCIDN,U,1),1,17),SCMCTM=$E($P(SCMCIDN,U,2),1,20)
 ...S SCMCTP=$E($P(SCMCIDN,U,3),1,20),SCMCL=SCMCL+1
 ...S SCMCX=SCMCINNM_$E("                    ",1,20-$L(SCMCINNM))
 ...S SCMCIDX=$E("                    ",1,15-$L(SCMCID))_SCMCID
 ...S SCMCX=SCMCX_SCMCIDX
 ...S SCMCTMX=$E("                     ",1,17-$L(SCMCTM))_SCMCTM
 ...S SCMCX=SCMCX_SCMCTMX
 ...S SCMCTPX=$E("                     ",1,17-$L(SCMCTP))_SCMCTP
 ...S SCMCX=SCMCX_SCMCTPX
 ...S TEXT(SCMCL)=SCMCX
 ;
 ;Mailman delivery
 D ^XMD
 K ^XTMP("SCMCHLM")
 Q
