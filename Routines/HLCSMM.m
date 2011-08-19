HLCSMM ;ISC/MTC-Create Mail Message and Entry in the HL7 Transmission File ;11/03/2000  08:53
 ;;1.6;HEALTH LEVEL SEVEN;**17,35,57,66,68**;Oct 13, 1995
 Q
 ;
EN(HLD0,HLD1) ; This routine will send a Message from the Out Queue to the
 ; MailGroup Specified in the Logical Link file (#870). It is called
 ; from HLCSMM1 routine that monitors the queue for a link. The MM LLP
 ; uses <CR> stuffing to indicate the end of segments. The message
 ; will use the following format within the XMB global.
 ;  ^XMB(3.9,..1)=Segment 1
 ;  ^XMB(3.9,..2)=""  - End of segment 1
 ;  ^XMB(3.9,..3)=Segment 2
 ;  ^XMB(3.9,..4)=Continuation of segment 2
 ;  ^XMB(3.9,..5)=""  - End of segment 2
 ; "             "
 ; This processing will enable segment greater than 245.
 ;
 ; INPUT :  HLD0 - IEN of Logical Link file (#870)
 ;       :  HLD1 - IEN of OutQueue Mutiple (Message)
 ;
 ; OUTPUT:  NONE
 ;
 N HLI,HLI0,HLSERV,HLFAC,HLERR,HLOGLINK,HLMSTXT,HLPARENT,HLPTXT,HLPARM
 ;
 S HLOGLINK=$G(^HLCS(870,HLD0,0))
 ;-- get MailMan LLP parameters
 S HLPARM=$G(^HLCS(870,HLD0,100))
 ;-- facility
 S HLFAC=$P($$SITE^VASITE,"^",2)
 I HLFAC="" S HLFAC="Unknown"
 ;-- date
 D NOW^%DTC S Y=% X ^DD("DD") S HLDT=Y
 ;-- logical link name
 S HLDAN=$P(HLOGLINK,U)
 ;
 ;-- Build MailMan variables
 ;
NEWMM ;Patch 66-introduce new Mailman API's
 N XMSUB,XMTO,XMINSTR
 I '$G(DUZ) N DUZ D DUZ^XUP(.5)
 S XMSUB="HL7 Msg "_HLDT_" from "_HLFAC,XMSUB=$E(XMSUB,1,65)
 S XMTO="G."_$P(^XMB(3.8,$P(HLPARM,U),0),U)
 S XMINSTR("FROM")=.5
 S XMINSTR("ADDR FLAGS")="R" ; Ignore any restrictions (domain closed or protected by security key)
 D SENDMSG^XMXAPI(DUZ,XMSUB,"^HLCS(870,HLD0,2,HLD1,1)",XMTO,.XMINSTR)
 ;-- Set message status to 'done'
 S $P(^HLCS(870,HLD0,2,HLD1,0),"^",2)="D"
 I $G(XMERR) D ERROR
 Q 
ERROR ;-- send Mail Message indicating error
 Q:'$G(XMERR)
 Q:'$D(^TMP("XMERR",$J))
 N HLX,HLY,HLZ,HLPARAM,XMSUB,XMTO,XMINSTR
 N DUZ D DUZ^XUP(.5) ; Want to make sure this message is sent.  It won't be if DUZ is not a valid user.
 K ^TMP($J,"HLERR")
 S HLNXST="ERROR" D STATUS^HLCSMM1(HLNXST) H 1
 S HLPARAM=$$PARAM^HLCS2,XMTO("G."_$P(HLPARAM,U,8))="",XMTO(.5)=""
 S (HLX,HLZ)=0
 F  S HLX=$O(^TMP("XMERR",$J,HLX)) Q:'HLX  D
 . S HLZ=HLZ+1,^TMP($J,"HLERR",HLZ)=""
 . S HLY=0
 . F  S HLY=$O(^TMP("XMERR",$J,HLX,"TEXT",HLY)) Q:'HLY  D
 . . S HLZ=HLZ+1,^TMP($J,"HLERR",HLZ)=$G(^TMP("XMERR",$J,HLX,"TEXT",HLY))
 . I $D(^TMP("XMERR",$J,HLX,"PARAM","VALUE")) S HLZ=HLZ+1,^TMP($J,"HLERR",HLZ)=^TMP("XMERR",$J,HLX,"PARAM","VALUE")
 S HLZ=HLZ+1,^TMP($J,"HLERR",HLZ)=""
 S HLZ=HLZ+1,^TMP($J,"HLERR",HLZ)="HL7 Logical Link: "_$G(HLDAN)
 S XMSUB="Error handing HL7 message off to Mailman"
 S XMINSTR("FROM")="POSTMASTER" ; msg will appear new, nomatter who receives it.
 D SENDMSG^XMXAPI(DUZ,XMSUB,"^TMP($J,""HLERR"")",.XMTO,.XMINSTR)
 K ^TMP($J,"HLERR"),XMERR,^TMP("XMERR",$J)
 Q
