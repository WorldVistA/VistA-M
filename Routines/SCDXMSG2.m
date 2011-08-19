SCDXMSG2 ;ALB/JRP - AMB CARE TRANSMISSION BULLETINS;01-JUL-1996 ; 1/17/02 5:07pm
 ;;5.3;Scheduling;**44,121,128,66,132,247,393,466**;AUG 13, 1993;Build 2
 ;
CMPLBULL(SENT,ERRCNT,IPCNT,IPERR) ;Send completion bulletin
 ;
 ;Input  : SENT - Number of encounters sent to NPCDB (Defaults to 0)
 ;         ERRCNT - Contains the number of errored encounters
 ;         IPCNT  - Number of inpatient encounters
 ;         IPERR  - Contains the number of inpatient errored encounters
 ;Output : None
 ;
 ;Declare variables
 N MSGTXT,XMB,XMTEXT,XMY,XMDUZ,XMDT,XMZ,XMITPTR,LINE
 N ENCPTR,DELPTR,ENCDATE,ENCLOC,NAME,TMP,ENCZERO,SSN,PATZERO
 ;Deliver bulletin
 S XMB="SCDX AMBCARE TO NPCDB SUMMARY"
 S XMB(1)=+$G(SENT)
 S XMB(2)=+$G(ERRCNT)
 S XMB(3)=+$G(SENT)-(+$G(IPCNT))
 S XMB(4)=+$G(IPCNT)
 S XMB(5)=+$G(ERRCNT)-(+$G(IPERR))
 S XMB(6)=+$G(IPERR)
 D ^XMB
 Q
 ;
ERRBULL(REASON) ;Send error bulletin
 ;
 ;Input  : REASON - Why transmission of data could not be completed
 ;Output : None
 ;
 ;Check input
 S REASON=$G(REASON)
 ;Declare variables
 N MSGTXT,XMB,XMTEXT,XMY,XMDUZ,XMDT,XMZ
 ;Set message text
 S MSGTXT(1)="Transmission of data to the National Patient Care Database"
 S MSGTXT(2)=" "
 S MSGTXT(3)="could not be completed for the following reason:"
 S MSGTXT(4)=" "
 S MSGTXT(5)="  "_REASON
 ;Set bulletin subject
 S XMB(1)="** TRANSMISSION OF DATA TO NPCDB NOT COMPLETED **"
 ;Deliver bulletin
 S XMB="SCDX AMBCARE TO NPCDB SUMMARY"
 S XMTEXT="MSGTXT("
 D ^XMB
 ;Done
 Q
 ;
LATEACT(XMITPTR,ACT,USER,DATE) ;Send late activity bulletin
 ;
 ;Input :  XMITPTR - Pointer to TRANSMITTED OUTPATIENT ENCOUNTER file
 ;                   (#409.73) that was acted upon
 ;         ACT - Late activity that occurred
 ;               Free text (defaults to transmission event of XMITPTR)
 ;         USER - Who did the activity
 ;                Pointer to NEW PERSON file (#200)
 ;                (defaults to causer of event of XMITPTR)
 ;         DATE - Date/time activity took place
 ;                FileMan format (defaults to event date of XMITPTR)
 ;Output : None
 ;Notes  : Late activity bulletin will be sent to members of the mail
 ;         group contained in the LATE ACTIVITY MAIL GROUP field (#217)
 ;         of the MAS PARAMETER file (#43).  The bulletin will not be
 ;         sent if this mail group has not been defined.
 ;       : POSTMASTER (DUZ=.5) will be converted to 'ACRP NIGHTLY
 ;         TRANSMISSION BUILDER' as the causer of the event
 ;       : Bulletin will default to a transmission event if no ACT
 ;         is specified
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR,0)))
 S ACT=$G(ACT)
 S USER=+$G(USER)
 S DATE=+$G(DATE)
 ;Declare variables
 N NODE,ENCPTR,DELPTR,ENCDATE,XMDUZ,XMTEXT,XMSUB,XMY,MSGL,SMTB,SMTN
 N CLOSED,DFN,CLINIC,DIV,VA,LASTXMIT,LASTACK,LASTCODE,HISTARR
 ;Send bulletin to site specified mail group
 ; Don't send if mail group not defined or is invalid
 S NODE=$G(^DG(43,1,"SCLR"))
 Q:('$P(NODE,"^",17))
 D XMY^SDUTL2($P(NODE,"^",17),0,0)
 Q:('$D(XMY))
 ;Get zero node of transmission file
 S NODE=$G(^SD(409.73,XMITPTR,0))
 ;Set default values (if applicable)
 I (ACT="") D  Q:(ACT="")
 .S ACT=+$P(NODE,"^",5)
 .I (ACT=1)!(ACT=2) S ACT="Creation/Editing of encounter" Q
 .I (ACT=3) S ACT="Deletion of encounter" Q
 .S ACT="Retransmission of encounter"
 I ('USER) D
 .S USER=+$P(NODE,"^",7)
 .S:('USER) USER=+$G(DUZ)
 S:(USER=.5) USER="ACRP NIGHTLY TRANSMISSION BUILDER"
 I ('DATE) S DATE=+$P(NODE,"^",6) S:('DATE) DATE=$$DT^XLFDT()
 ;Get pointer to encounter and deleted encounter
 S ENCPTR=+$P(NODE,"^",2)
 S DELPTR=+$P(NODE,"^",3)
 ;Get zero node of [deleted] encounter
 S NODE=""
 S:(ENCPTR) NODE=$G(^SCE(ENCPTR,0))
 S:('ENCPTR) NODE=$G(^SD(409.74,DELPTR,1))
 ;Get date/time of encounter
 S ENCDATE=+NODE
 ;Get DFN
 S DFN=+$P(NODE,"^",2)
 ;Get clinic pointer
 S CLINIC=+$P(NODE,"^",4)
 ;Get division
 S DIV=+$P(NODE,"^",11)
 ;Get transmission history
 S (LASTXMIT,LASTACK,LASTCODE)=""
 S HISTARR=$NA(^TMP("SCDXMSG2",$J,"HIST"))
 K @HISTARR
 I ($$HST4XMIT^SCDXFU13(XMITPTR,HISTARR,1)) D
 .;Get last xmit date
 .S LASTXMIT=+$O(@HISTARR@(""),-1)
 .Q:('LASTXMIT)
 .;Get ack info for last xmit
 .S LASTACK=$G(@HISTARR@(LASTXMIT))
 .S LASTCODE=$P(LASTACK,"^",3)
 .S LASTACK=$P(LASTACK,"^",2)
 K @HISTARR
 ;Determine the level of acceptance for data base credit and/or
 ;workload credit
 S MSGL=$$XMIT4DBC^SCDXFU04(XMITPTR)
 Q:MSGL<1!(MSGL>4)  ; Only four levels of messages are defined
 ; 0 - no message, transmit
 ; 5 - no transmit; error 
 ;Build message
 S SMTB="The following activity occurred "
 S XMTEXT(1)=SMTB_"after the National Patient Care"
 S XMTEXT(2)="Database was closed"
 I MSGL=4 S XMTEXT(2)=XMTEXT(2)_"."
 I MSGL=3 D
 .S XMTEXT(2)=XMTEXT(2)_" for yearly workload credit but will be sent"
 .S XMTEXT(3)="to the NPCD for historical accuracy of the database."
 I MSGL=2 D
 .S XMTEXT(2)=XMTEXT(2)_" for monthly workload credit but will be sent"
 .S XMTEXT(3)="to the NPCD to be included in the fiscal year totals."
 I MSGL=1 D
 .; the rolling 20-day message is based on setup of ROLLD=19 in
 .; CLOSEOUT^SCDXFU04
 .S XMTEXT(1)=SMTB_"20 or more days after the encounter"
 .S XMTEXT(2)="date but is valid for workload credit and will be sent"
 .S XMTEXT(3)="to the National Patient Care Database."
 S SMTN=$S(MSGL=4:3,1:4) S XMTEXT(SMTN)=" "
 S XMTEXT(SMTN+1)="  Activity: "_ACT
 S XMTEXT(SMTN+2)="Entered By: "_$S(USER:$P($G(^VA(200,USER,0)),"^",1),1:USER)
 S XMTEXT(SMTN+3)="Entered On: "_$$FMTE^XLFDT(DATE)
 S XMTEXT(SMTN+4)=" "
 S XMTEXT(SMTN+5)="        Encounter Date: "_$$FMTE^XLFDT(ENCDATE)_"  (#"_$S(ENCPTR:ENCPTR,1:DELPTR)_")"
 S:('ENCPTR) XMTEXT(SMTN+5)=XMTEXT(SMTN+5)_"  ** Deleted Encounter **"
 S XMTEXT(SMTN+6)="Last NPCD Transmission: "_$S(LASTXMIT:$$FMTE^XLFDT(LASTXMIT),1:"Encounter data never transmitted ")_"  (#"_XMITPTR_")"
 S XMTEXT(SMTN+7)="Last NPCD Ack Received: "_$S(LASTACK:$$FMTE^XLFDT(+LASTACK),1:"Acknowledgement not received")
 S:(LASTACK) XMTEXT(SMTN+7)=XMTEXT(SMTN+7)_"  ("_$S((LASTCODE'=""):$$EXTERNAL^DILFD(409.73,15,"",LASTCODE),1:"Status unknown")_")"
 S XMTEXT(SMTN+8)=" "
 S XMTEXT(SMTN+9)=" Clinic: "_$P($G(^SC(CLINIC,0)),"^",1)
 D PID^VADPT6
 S XMTEXT(SMTN+10)="Patient: "_$P($G(^DPT(DFN,0)),"^",1)_"  ("_VA("BID")_")"
 ;Send message
 S XMSUB="Late ACRP Related Activity"_$$DIV^SDAMEVT1(DIV)
 S XMTEXT="XMTEXT("
 S XMDUZ=.5
 S:(USER) XMY(USER)=""
 D ^XMD    ; REMOVE COMMENT
 ;Done
 Q
