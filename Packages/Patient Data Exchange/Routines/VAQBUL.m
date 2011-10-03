VAQBUL ;ALB/JRP - BULLETINS;25-MAY-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
SENDBULL(SUBJECT,SENTBY,FWRDBY,ROOT) ;BUILD AND SEND BULLETIN
 ;INPUT  : SUBJECT - Subject of message
 ;         SENTBY - 'User' sending message
 ;         FWRDBY - 'User' fowarding the message (defaults to SENTBY)
 ;         ROOT - Where the message text is stored (full global ref)
 ;                  ROOT(Line#,0)=Line of text
 ;         XMY() - Recipient list
 ;OUTPUT : XMZ - Message number of message sent
 ;         -1^Error_Text - Message not sent
 ;
 ;CHECK INPUT
 Q:($G(SUBJECT)="") "-1^Did not pass subject of message"
 Q:($G(SENTBY)="") "-1^Did not pass sender of message"
 S:($G(FWRDBY)="") FWRDBY=SENTBY
 Q:($G(ROOT)="") "-1^Did not pass array containing message"
 Q:('$D(@ROOT)) "-1^Did not valid array reference"
 Q:($O(@ROOT@(""))="") "-1^Array did not contain message"
 Q:('$D(XMY)) "-1^Did not pass distribution list"
 Q:($O(XMY(""))="") "-1^Distributionl list was empty"
 ;DECLARE VARIABLES
 N XMZ,XMDUN,LINE,OFFSET,TMP,X,XMCHAN
 S XMCHAN=1
 ;GET STUB MESSAGE
 S XMZ=$$MAKESTUB^VAQCON1(SUBJECT,SENTBY)
 I (XMZ<1) Q "-1^Could not get stub message"
 ;COPY TEXT INTO MESSAGE
 S LINE=1
 S OFFSET=0
 F  S OFFSET=+$O(@ROOT@(OFFSET)) Q:('OFFSET)  D
 .S TMP=$G(@ROOT@(OFFSET,0))
 .S X=$$ADDLINE^VAQCON1(TMP,XMZ,LINE)
 .S LINE=LINE+1
 ;SET ZERO NODE
 S X=$$SETZERO^VAQCON1(XMZ,(LINE-1))
 ;FOWARD (SEND) MESSAGE
 S XMDUN=FWRDBY
 D ENT1^XMD
 Q XMZ
