HLEMSND ;ALB/CJM - Sends events to remote event servers;12 JUN 1997 10:00 am
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13,1995
 ;
SENDALL ;send all events pending distribution to remote locations
 L +^HLEV(776.4,"AK"):0
 Q:'$T
 D START^HLEVAPI()
 N EVENT
 S IDX="^HLEV(776.4,""AK"")"
 S EVENT=0
 F  S EVENT=$O(@IDX@(EVENT)) Q:'EVENT  D
 .I $$SEND(EVENT)
 .K @IDX@(EVENT)
 L -^HLEV(776.4,"AK")
 D CHECKOUT^HLEVAPI
 Q
 ;
 ;
SEND(IEN) ;
 ;Sends the event=IEN to its remote servers
 ;
 N MSG,EVENT,TYPE,MAILMSG,DOMAIN
 ;
 ;get the event
 Q:'$$GET^HLEME(IEN,.EVENT) 0
 ;
 ;get the event type
 Q:'$$GET^HLEMT(EVENT("TYPE"),.TYPE) 0
 ;
 ;are there any remote locations to send this event type?
 S DOMAIN=0
 F  S DOMAIN=$O(TYPE("DOMAIN",DOMAIN)) Q:'DOMAIN  D
 .I '$L(TYPE("DOMAIN",DOMAIN)) S DOMAIN(DOMAIN)="" Q
 .;
 .;there is a screen, execute it
 .N HLEVENT
 .M HLEVENT=EVENT
 .N EVENT
 .X TYPE("DOMAIN",DOMAIN)
 .I $T S DOMAIN(DOMAIN)=""
 Q:'$O(DOMAIN(0)) 0  ;there are no remote locations!
 ;
 ;location of where the message will be built, referenced by indirection
 S MSG="^TMP($J,""HL7 MONITOR EVENT"")"
 K @MSG
 ;
 D BUILD(MSG,.EVENT,.TYPE)
 S MAILMSG=$$MAIL(MSG,.DOMAIN)
 I MAILMSG'="" D
 .N DA,DATA,ERROR
 .S DA(1)=IEN
 .S DATA(.01)=MAILMSG
 .I '$$ADD^HLEMU(776.42,.DA,.DATA,.ERROR) D
 ..D ERROR(.EVENT)
 ..I '$D(ZTQUEUED) W !,"FAILED TO ADD THE MAILMAN MESSAGE NUMBER TO THE EVENT ",ERROR ;then fileman failed!
 E  D
 .D ERROR(.EVENT)
 .I '$D(ZTQUEUED) W !,"MAILMAN FAILED TO SEND HL7 LOG EVENT TO REMOTE SERVER"
 K @MSG
 Q 1
 ;
BUILD(MSG,EVENT,TYPE) ;
 ;EVENT - event array, pass by reference
 ;TYPE - event type array, pass by reference
 ;
 N SUB,LINE,TXT
 ;
 ;can't send local pointers!
 S EVENT("SITE")=$$STATNUM^HLEMU(EVENT("SITE"))
 S EVENT("TYPE")=$$GETFIELD^HLEMU(9.4,.01,TYPE("PACKAGE"))_"^"_TYPE("CODE")
 S EVENT("REVIEWER")=""
 ;
 S SUB=""
 F  S SUB=$O(EVENT(SUB)) Q:(SUB="")  D:$D(EVENT(SUB))'[0
 .D ADDDATA(MSG,SUB,EVENT(SUB))
 ;
 ;add the application data
 D ADDLINE(MSG,"**APPLICATION DATA**")
 S LINE=0
 F  S LINE=$O(^HLEV(776.4,EVENT("IEN"),3,LINE)) Q:'LINE  D
 .S TXT=$G(^HLEV(776.4,EVENT("IEN"),3,LINE,0))
 .Q:'$L(TXT)
 .D ADDDATA(MSG,"VARIABLE",TXT)
 .S TXT=$G(^HLEV(776.4,EVENT("IEN"),3,LINE,2))
 .D ADDDATA(MSG,"VALUE",TXT)
 ;
 ;add the notes
 D ADDLINE(MSG,"**NOTES**")
 S LINE=0
 F  S LINE=$O(^HLEV(776.4,EVENT("IEN"),1,LINE)) Q:'LINE  D
 .S TXT=$G(^HLEV(776.4,EVENT("IEN"),1,LINE,0))
 .D:$L(TXT) ADDLINE(MSG,TXT)
 Q
 ;
MAIL(MSG,DOMAIN) ;
 ;Sends the message located at @MSG to the HLEM EVENT SERVER, locations in TYPE("DOMAIN") array
 ;Input:
 ;    message at @MSG
 ;    DOMAIN - array of remote domains, pass by reference
 ;Output: If succssful, the function returns the mailman message number, otherwise, "" is returned
 ;
 N XMY,XMSUB,XMDUZ,XMTEXT,XMZ,XMDUN,DIFROM,SERVER
 S SERVER="S.HLEM EVENT LOG SERVER"
 S XMDUZ="HL7 EVENT LOG at "_$P($$SITE^VASITE(),"^",2)
 S XMY(.5)=""
 S DOMAIN=0 F  S DOMAIN=$O(DOMAIN(DOMAIN)) Q:'DOMAIN  D
 .S XMY(SERVER_"@"_$P($G(^DIC(4.2,DOMAIN,0)),"^"))=""
 ;
 ;******REMOVE THIS *****
 ;S XMY("MOORE,JIM")=""
 ;******
 ;
 S XMTEXT=$P(MSG,")")_","
 S XMSUB="HL7 EVENT LOG"
 D ^XMD
 Q $G(XMZ)
 ;
ADDDATA(MSG,LABEL,DATA) ;
 ;Description: Adds one formated line to the message text containing the label and data value
 ;Input:
 ;  MSG - the workspace location
 ;  LABEL - text label that identifies the type of data
 ;  DATA - data value
 ;Output:none
 ; 
 D ADDLINE(MSG,LABEL_":"_DATA)
 Q
 ;
ADDLINE(MSG,LINE) ;
 ;Description: adds one line to the message text
 ;Inputs:
 ;  LINE - the line of text to be added
 ;  MSG - @MSG is the location for the message text
 ;Output: none
 S @MSG@(($O(@MSG@(9999),-1)+1))=LINE
 Q
 ;
ERROR(EVENT) ;
 ;establishes a new event if this routine encounters an error.
 ;pass EVENT by reference
 ;
 N NEWEVENT,VAR
 S NEWEVENT=$$EVENT^HLEME("SRVR ERROR","HEALTH LEVEL SEVEN")
 S VAR("IEN")=EVENT("IEN")
 S VAR("ID")=EVENT("ID")
 I $$STOREVAR^HLEME(NEWEVENT,.VAR)
 Q
