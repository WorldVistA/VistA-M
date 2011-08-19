RGHLLOG1 ;ALB/CJM-SEND EXCEPTION TO MPI EXCEPTION HANDLER ;11/25/2000
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**13,18**;30 Apr 99
 ;
 ;Reference to file 870 supported by IA #3335
 ;Reference to file 391.72 supported by IA #3037
 ;References to file 773 supported by IA #3244 and 3273
 ;
SENDMPI(RGEXC,RGERR,RGDFN,MSGID,STATNUM) ;
 ;Description: Sends the exception to the MPI Exception Handler.
 ;Input: Required
 ;  RGEXC - Exception type in File #991.11
 ;  RGERR - Supplemental text
 ;       Optional
 ;  RGDFN - IEN in the PATIENT file (#2)
 ;  MSGID - message id of message being processed when the exception occurred (optional), uses RGLOG(3) or HL("MID") if not defined
 ;  STATNUM - station # of site that encountered the error (optional)
 ;         If not defined then local site is assumed, using $$SITE^VASITE
 ;Output: none
 ;
 ;Variables:
 ;  @RGMSG is the location for the message text
 ;
 N RGMSG
 S RGMSG="^TMP($J,""RG MPI SERVER EXCEPTION"")"
 K @RGMSG
 ;
 D ADDLINE("**MPI/PD EXCEPTION**")
 D ADDDATA("EXCEPTION TYPE",$G(RGEXC))
 D ADDDATA("OPTIONAL TEXT",$G(RGERR))
 D ADDDATA("SITE OF OCCURRENCE",$S($D(STATNUM):STATNUM,1:$P($$SITE^VASITE(),"^",3)))
 D ADDDATA("SITE REPORTING",$P($$SITE^VASITE(),"^",3))
 D ADDDATA("DATE/TIME REPORTED",$$NOW^XLFDT)
 I $G(RGDFN) D
 .N OUT,SITE
 .D GETALL^RGFIU(RGDFN,.OUT)
 .D ADDLINE("**PATIENT DATA**")
 .D ADDDATA("ICN",OUT("ICN"))
 .D ADDDATA("NAME",$$NAME^RGFIU(RGDFN))
 .D ADDDATA("SSN",$$SSN^RGFIU(RGDFN))
 .D ADDDATA("CMOR",OUT("CMOR"))
 .S SITE=""
 .F  S SITE=$O(OUT("TF",SITE)) Q:(SITE="")  D ADDLINE("**"),ADDDATA("TREATING FACILITY",SITE),ADDDATA("DATE LAST TREATED",OUT("TF",SITE,"LASTDATE")),ADDDATA("EVENT REASON",$$GETFIELD^RGFIU(391.72,.01,OUT("TF",SITE,"EVENT")))
 K OUT
 I $$GETMSG($G(MSGID),.OUT) D
 .N SUB
 .D ADDLINE("**HL7 MESSAGE**")
 .S SUB=""
 .F  S SUB=$O(OUT(SUB)) Q:(SUB="")  D ADDDATA(SUB,OUT(SUB))
 D ADDLINE("**END**")
 I $$MAIL
 K @RGMSG
 ;
 Q
 ;
SERVER() ;
 ;Description: Returns the <server name>@<server domain>. This entry
 ;returns the Servers location either at the test MPI or Production MPI.
 ;If a null is returned the MAIL subroutine will default to the MPIF
 ;EXCEPTIONS mail group
 ;
 ;Input: none
 ;Output: Where to send the exception.Returns the <server name>@<server domain> or Null
 ;
 N TO,IEN
 S TO=""
 ; get MPI logical link
 D LINK^HLUTIL3("200M",.HLL,"I")
 ; get MPI domain DBIA 3335
 S IEN=$O(HLL(0)) I +IEN>0 S TO=$$GET1^DIQ(870,+IEN_",",.03) I TO'="" S TO="S.MPI EXCEPTION SERVER@"_TO
 Q TO
 ;
ADDDATA(LABEL,DATA) ;
 ;Description: Adds one formated line to the message text containing the label and data value
 ;Input:
 ;  LABEL - text label that identifies the type of data
 ;  DATA - data value
 ;Output:none
 ; 
 D ADDLINE(LABEL_":"_DATA)
 Q
ADDLINE(LINE) ;
 ;Description: adds one one to the message text
 ;Inputs:
 ;  LINE - the line of text to be added
 ;  RGMSG - @RGMSG is the location for the message text
 ;Output: none
 S @RGMSG@(($O(@RGMSG@(9999),-1)+1))=LINE
 Q
MAIL() ;
 ;Description: Sends the message located at @RGMSG to the MPI Exception Handler
 ;Input: message at @RGMSG
 ;Output: If succssful, the function returns the mailman message number, otherwise, "" is returned
 ;
 N XMY,XMSUB,XMDUZ,XMTEXT,XMZ,XMDUN,DIFROM,SERVER
 Q:'$D(@RGMSG) ""
 S SERVER=$$SERVER
 ;if the MPI server isn't returned default to the old MPIF EXCEPTIONS mail group
 I SERVER="" S SERVER="MPIF EXCEPTIONS"
 S XMDUZ="MPI/PD at "_$P($$SITE^VASITE(),"^",2)
 S XMY(.5)=""
 S XMY(SERVER)=""
 S XMTEXT=$P(RGMSG,")")_","
 S XMSUB="MPI/PD EXCEPTION"
 D ^XMD
 Q $G(XMZ)
 ;
GETMSG(MSGID,MSGARRAY) ;
 ;Description: Retrieves data from the HL7 Message Administration file (#773) related to the message
 ;Input:
 ;  MSGID - the message id (optional)
 ;  RGLOG(3) - if MSGID is not passed then RGLOG(3) is used to determine the message
 ;  HL("MID") - if MSGID and RGLOG(3) are not defined then HL("MID") is used to determine the message
 ;
 ;Output:
 ;  Function Value - 1 on success, 0 on failure
 ;  MSGARRAY() - (pass by reference) - returns the data
 ;          ("MESSAGE ID") - the HL7 message id
 ;          ("MESSAGE TYPE") - the HL7 message type
 ;          ("EVENT TYPE") - the HL7 event type
 ;          ("SENDING APPLICATION") - the name of the sending application
 ;          ("LOGICAL LINK") - the name of the HL Logical Link overwhich the message was received
 ;
 N MSGIEN
 K MSGARRAY
 I '$G(MSGID) D
 .I $G(RGLOG(3)) S MSGID=$$GETFIELD^RGFIU(773,2,RGLOG(3)) Q:MSGID
 .S MSGID=$G(HL("MID"))
 Q:'MSGID 0
 ;
 S MSGIEN=$$IEN773^RGHLLOG(MSGID)
 ;
 S MSGARRAY("MESSAGE ID")=MSGID
 S MSGARRAY("LOGICAL LINK")=$$GETFIELD^RGFIU(773,7,MSGIEN,,1)
 S MSGARRAY("SENDING APPLICATION")=$$GETFIELD^RGFIU(773,13,MSGIEN,,1)
 S MSGARRAY("MESSAGE TYPE")=$$GETFIELD^RGFIU(773,15,MSGIEN,,1)
 S MSGARRAY("EVENT TYPE")=$$GETFIELD^RGFIU(773,16,MSGIEN,,1)
 ;
 ;this compensates for a bug in the HL7 package - the external form rather than the pointer values are being stored in file 773
 I MSGID,'$L(MSGARRAY("MESSAGE TYPE")) S MSGARRAY("MESSAGE TYPE")=$$GETFIELD^RGFIU(773,15,MSGIEN)
 I MSGID,'$L(MSGARRAY("EVENT TYPE")) S MSGARRAY("EVENT TYPE")=$$GETFIELD^RGFIU(773,16,MSGIEN)
 ;
 Q 1
