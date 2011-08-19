PRCHAAC2 ;WIFO/CR-CONT. OF IFCAP HL7 MESSAGE TO AUSTIN ;3/4/05 11:43 AM
 ;;5.1;IFCAP;**79**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;This routine is a continuation of the routine PRCHAAC1.
 ;
CLEAN K %,PRCACMSG,PRCACK,PRCBATCH,PRCDATE,PRCMESG,PRCMID,PRCSUB,HL,HLFS,HLRS,HLRS,HLNODE,HLNEXT,HLQUIT,PRCTAAC,PRCFAAC,PRCDIF,X,X1,Y
 Q
 ;
END ;Log the date/time ($H format) of the AAC response and the creation date
 ;(FileMan format) in ^XTMP
 S X=DT D NOW^%DTC S X1=$$FMTH^XLFDT(%)
 S $P(^XTMP(PRCSUB,"TIME"),U,2)=X1
 S $P(^XTMP(PRCSUB,0),U,2)=X
 S X=DT D NOW^%DTC,YX^%DTC S PRCDATE=Y
 S $P(^XTMP(PRCSUB,0),U,3)="Processing done "_PRCDATE_" for IFCAP HL7 MSG to the AAC"
 ;
 ;Get an approximated calculation of how long it takes to get a response
 ;from the AAC, to help in troubleshooting problems.
 I $P(^XTMP(PRCSUB,"TIME"),U,1)]""&$P(^XTMP(PRCSUB,"TIME"),U,2)]"" D
 . S PRCTAAC=$P(^XTMP(PRCSUB,"TIME"),U,1)    ;date/time msg to the AAC
 . S PRCFAAC=$P(^XTMP(PRCSUB,"TIME"),U,2)    ;date/time msg from the AAC
 . S PRCDIF=$$HDIFF^XLFDT(PRCFAAC,PRCTAAC,3) ;time difference
 . S $P(^XTMP(PRCSUB,"TIME"),U,3)=PRCDIF     ;time elapsed
 D CLEAN
 Q
 ;
ERR ;Errors from incoming messages are logged here
 I $D(PRCERR) D
 . S PRCMSG=PRCMSG_";"_"HL7 Message ID: "_$S(PRCMID>0:PRCMID,1:"No MID")
 . S ^XTMP(PRCSUB,"ERR",$H)=PRCMSG
 Q
 ;
LOG ;Set purge date to keep ^XTMP clean; first piece is purge date, FM form
 S X=$$FMADD^XLFDT(DT,7)   ;keep for seven days
 S $P(^XTMP(PRCSUB,0),U,1)=X
 ;Record date of message to the AAC
 S X=DT D NOW^%DTC S X1=$$FMTH^XLFDT(%)
 S $P(^XTMP(PRCSUB,"TIME"),U,1)=X1
 ;Keep track of who created the message
 S $P(^XTMP(PRCSUB,"TIME"),U,4)=PRCDUZ
 Q
 ;
SUB ;Subscriber to handle the ACKs coming from the AAC
 ;Error message 'No MID' = no message id
 S HLFS=$G(HL("FS"))
 S HLCS=$E(HL("ECH"),1),HLRS=$E(HL("ECH"),2)
 I HL("MTN")'="MFK" S PRCERR=1,PRCMSG="1A"_"^Wrong message name." D REC Q
 X HLNEXT I HLQUIT'>0 S PRCERR=1,PRCMSG="2A"_"^Missing MSH segment." D REC Q
 S PRCACMSG=$P(HLNODE,HLFS,10)
 X HLNEXT I HLQUIT'>0 S PRCERR=1,PRCMSG="3A"_"^Missing segments." D REC Q
 S PRCMID=$$FLD^HLCSUTL(.HLNODE,3) I '$D(PRCMID) S PRCMID="No MID",PRCERR=1,PRCMSG="4A"_"^No MID" D REC Q
 S PRCSUB="PRCHAAC1;"_PRCMID
 I $P(HLNODE,HLFS)'="MSA" S PRCERR=1,PRCMSG="5A"_"^No MSA segment." D REC Q
 S PRCACK=$P(HLNODE,HLFS,2)
 S PRCBATCH=$G(HLNODE)
 I $P(HLNODE,HLFS)="MSA"&(PRCACK="AA") D  Q
 . S ^XTMP(PRCSUB,"AAC_MSG_ID")=PRCACMSG
 . S ^XTMP(PRCSUB,"IFCAP_MSG_ID")=$P(PRCBATCH,HLFS,3)
 . D END
 ;
 ;If there is an error, store the entire string.
 I PRCACK'="AA" S PRCERR=1,PRCMSG=PRCACK_";"_PRCBATCH D REC
 Q
 ;
REC ;For errors, log as much as possible in ^XTMP
 I '$D(PRCMID) S PRCMID=$$FLD^HLCSUTL(.HLNODE,3)
 I '$D(PRCSUB) S PRCSUB=$S(PRCMID>0:"PRCHAAC1;"_PRCMID,1:"PRCHAAC1;"_"No MID")
 D ERR,END
 Q
