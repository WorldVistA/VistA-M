GMRCIAC3 ;ALB/WTC - FILE IFC ACTIVITIES CONT'D ; Jan 27, 2025@06:03:05
 ;;3.0;CONSULT/REQUEST TRACKING;**201,205**;DEC 27, 1997;Build 3
 ;
 Q  ;
 ;
ERR206(MSGID,EDIPI,CRNRORDR,ORDRDESC,ORDRDATE,GMRCMSG) ;
 ;
 ;  Special processing for error code 206 ICN Missing from Incoming Order
 ;
 ;  MSGID    = HL7 Message ID
 ;  EDIPI    = Patient's EDIPI
 ;  CRNRORDR = Cerner order number
 ;  ORDRDESC = Order description
 ;  ORDRDATE = Date of order
 ;  GMRCMSG  = Name of array where HL7 message is stored
 ;
 ;  Set do not purge flag for incoming order.
 ;
 I $G(HLMTIENS) N RTNCODE S RTNCODE=$$SETPURG^HLUTIL(1) ;
 ;
 ;  Send Application rejection ACK.
 ;
 D APPACK^GMRCIAC2(0,"AR",206,1,MSGID,GMRCMSG) ;
 ;
 ;  Log message for later re-processing.
 ;
 D LOGMSG^GMRCIUTL("","",MSGID,206) ;
 ;
 ;  Send mail message.
 ;
 N XMSUB,XMDUZ,XMTEXT,XMY,GRPIEN,MEM,GRP ;
 S GRP="DGEN ELIGIBILITY ALERT" ;
 S XMSUB="Failed IFC transaction: ICN Missing from Order (Error 206)",XMTEXT="XMTEXT(" ;
 S XMTEXT(1)="Message ID: "_MSGID ;
 S XMTEXT(2)="EDIPI: "_EDIPI ;
 S XMTEXT(3)="Cerner Order Number: "_CRNRORDR ;
 S XMTEXT(4)="Order Description: "_ORDRDESC ;
 S XMTEXT(5)="Order Date: "_$$FMTE^XLFDT(ORDRDATE) ;
 S GRPIEN=$O(^XMB(3.8,"B",GRP,"")) Q:'GRPIEN
 ;Set up XMY for MEMBERS
 S MEM=0 F  S MEM=$O(^XMB(3.8,GRPIEN,1,MEM)) Q:'MEM  S XMY($P(^XMB(3.8,GRPIEN,1,MEM,0),U))=""
 ;Set up XMY for MEMBERS REMOTE
 S MEM=0 F  S MEM=$O(^XMB(3.8,GRPIEN,6,MEM)) Q:'MEM  S XMY($P(^XMB(3.8,GRPIEN,6,MEM,0),U))=""
 Q:'$D(XMY)
 S XMDUZ=GRP
 D XMZ^XMA2 ; call Create Message Module
 D EN1^XMD
 Q  ;
 ;
