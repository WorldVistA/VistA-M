HLEMRCV ;ALB/CJM - Mailman server for HL7 Monitoring Events;12 JUN 1997 10:00 am
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13,1995
 ;
RECEIVE ;Description: Read the exception message and file it.
 ;!!!! for testing interactively !!!!!!!!!!!!
 ;S XMER=0
 ;S XMFROM="HL7 EVENT LOG AT SAN FRANCISCO"
 ;S XMPOS=0
 ;S XMREC="D REC^XMS3"
 ;S XMRG="**APPLICATION DATA**"
 ;S XMXX="S.HLEM EVENT LOG SERVER"
 ;S XMZ=8557
 ;!!!!!!
 ;
 N EVENT,EXIT,TEMP
 S EXIT=0
 F  X XMREC Q:(XMER<0)  D  Q:EXIT
 .I $E(XMRG,1,2)="**" S EXIT=1 Q
 .N LABEL,DATA
 .S LABEL=$P(XMRG,":"),DATA=$P(XMRG,":",2,99)
 .Q:'$L(LABEL)
 .S EVENT(LABEL)=DATA
 ;
 ;don't save IEN from sending site
 K EVENT("IEN")
 ;
 ;need to get local pointers
 ;event type
 S:$D(EVENT("TYPE")) TEMP=$$FIND^HLEMT($P($G(EVENT("TYPE")),"^",2),$P($G(EVENT("TYPE")),"^"))
 I '$G(TEMP) D ERROR("UNKNOWN EVENT TYPE AT REMOTE SITE: "_EVENT("TYPE"),XMZ) Q
 S EVENT("TYPE")=TEMP
 ;get the institution ien
 S:$D(EVENT("SITE")) EVENT("SITE")=$$INSTIEN^HLEMU(EVENT("SITE"))
 ;
 ;don't enter duplicates (no updating at present)
 I $L($G(EVENT("ID"))),$D(^HLEV(776.4,"C",EVENT("ID"))) Q
 ;
 ;establish this event on this system
 S EVENT=$$STORE^HLEME1(.EVENT,.ERROR)
 ;
 ;if successful
 I EVENT D
 .;add a note with the ien of the message for traceability
 .I $$ADDNOTE^HLEME(EVENT,"REMOTE EVENT ADDED BY SERVER AT "_$$NOW^XLFDT_", MAILMAN MESSAGE IEN: "_$G(XMZ))
 ;
 ;if not successful
 I 'EVENT D ERROR("Fileman Failed to store remote event:  "_$G(ERROR),$G(XMZ)) Q
 ;
 ;handle application data
 I $E(XMRG,1,4)="**AP" D
 .S EXIT=0
 .F  X XMREC Q:(XMER<0)  D  Q:EXIT
 ..I $E(XMRG,1,4)="**NO" S EXIT=1 Q
 ..N VAR
 ..I $P(XMRG,":")="VARIABLE" D
 ...S VAR=$P(XMRG,":",2)
 ...X XMREC
 ...I $P(XMRG,":")="VALUE" S @VAR=$P(XMRG,":",2,99) I $$STOREVAR^HLEME(EVENT,.@VAR,VAR)
 ;
 ;handle notes
 I $E(XMRG,1,4)="**NO" D
 .S EXIT=0
 .F  X XMREC Q:(XMER<0)  D  Q:EXIT
 ..N VAR
 ..I $P(XMRG,":")="VAR" D
 ...S VAR=$P(XMRG,":",2)
 ...X XMREC
 ...I $L(XMRG) D
 ..I $$ADDNOTE^HLEME(EVENT,XMRG)
 ;
 S XMSER="S.HLEM EVENT LOG SERVER"
 D REMSBMSG^XMA1C
 Q
 ;
ERROR(COMMENT,MAIL) ;
 ;establishes a new event if this routine encounters an error.
 ;MAIL is the message id of the MailMan mesage
 ;
 N NEWEVENT,VAR
 S NEWEVENT=$$EVENT^HLEME("SRVR ERROR","HEALTH LEVEL SEVEN")
 S VAR("MAIL IEN")=$G(MAIL)
 I $$STOREVAR^HLEME(NEWEVENT,.VAR)
 I $$ADDNOTE^HLEME(NEWEVENT,$G(COMMENT))
 Q
