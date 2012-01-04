RAHLACK ;HISC/PAV - Process Appl Ack for (ORM) and (ORU) Msgs; 06/23/2006  10:42
 ;;5.0;Radiology/Nuclear Medicine;**47**;June 16, 2006;Build 21
 ; Based on information from incoming Ack, e-mail message is
 ; sent to Mail group: G.RAD HL7 MESSAGES
 ;
 ;Integration Agreements
 ;----------------------
 ;MSG^DIALOG(2050); $$GETAPP^HLCS2(2887); $$MSG^HLCSUTL(3099);^XMD(10070)
 ;
MAIN ; Process incoming ACK, called from 2.4 protocols
 ;
 N CNT,ERR,ERROR,EXIT,GROUP,HLFS,HLCS,HLSCS,I,NUMBER,RAERR,SEG,X,Y
 D INIT,PROCESS,EXIT
 Q
 ;
INIT ; initialize
 ;
 ;S DUZ(0)="@"
 ;
 S ERROR=0
 S HLFS=HL("FS"),HLCS=$E(HL("ECH"))
 S HLSCS=$E(HL("ECH"),4),HLREP=$E(HL("ECH"),2)
 Q
 ;
PROCESS ; pull message text
 ;
 N SEG
 F  X HLNEXT  Q:HLQUIT'>0  S SEG=$P(HLNODE,HLFS) D:SEG'=""
 .D:"^MSH^MSA^ERR^"[(U_SEG_U) @SEG
 Q
 ;
MSH ; -- MSH segment
 ;
 Q
 ;
MSA ; -- MSA segment
 ;
 N CODE,DA,DIC,RAHLMA,RAMSA,RAMSG,X
 S CODE=$P(HLNODE,HLFS,2)
 I CODE="AE"!(CODE="AR") D
 .S ERROR=ERROR_U_$P(HLNODE,HLFS,4,99)
 .S RAERR("DIMSG",1)=CODE_" ACK Code received to the Message ID: "_$P(HLNODE,HLFS,3)
 .S RAMSA=$P(HLNODE,HLFS,3),RAMSG=$$MSG^HLCSUTL(RAMSA,"RAHLMA(1)")
 .I RAMSG>0 S RAERR("DIMSG",2)=RAHLMA(1,1)
 Q
 ;
ERR ; -- ERR segment
 ;
 ; Set ERR segment handler here...
 Q
 ;
EM(MID,ERROR,RAERR,XMSUB,XMY) ; error message
 ;
 N GROUP,RAMPG,RAX,XMDUZ,XMMG,XMTEXT,XMZ
 ;
 D MSG^DIALOG("AM",.RAX,80,"","RAERR")
 ;
 S RAX(.1)="HL7 message ID: "_$G(MID)
 S RAX(.2)="",RAX(.3)=$G(ERROR)
 S:$G(XMSUB)="" XMSUB="RAD ACK ERROR/WARNING/INFO"
 S RAMPG=$P($$GETAPP^HLCS2(HL("SAN")),U,1) ;RAMPG="G.RAD HL7 MESSAGES"
 S:'$L(RAMPG) RAMPG="G.RAD HL7 MESSAGES"
 S XMY(RAMPG)="",XMDUZ=.5
 S XMTEXT="RAX("
 ;
 D ^XMD
 Q
 ;
GSTATUS(HLRESLT,ED) ;
 Q:'$D(HLRESLT)
 N I,RAERR,ERROR,XMSUB
 S XMSUB="RAD HL7: Error in GENERATE^HLMA"
 S ERROR="For Event Driver: "_$P($G(^ORD(101,+$G(ED),0)),U)
 I +$P(HLRESLT,U,2)!$L($P(HLRESLT,U,3)) D
 .S RAERR(1)=$P(HLRESLT,U,2),RAERR(2)=$P(HLRESLT,U,3)
 .D EM(+HLRESLT,ERROR_">>"_HLRESLT_"<<",.RAERR,XMSUB_" single subscriber")
 .K RAERR
 S I=0 F  S I=$O(HLRESLT(I)) Q:'I  D:$L($P(HLRESLT(I),U,2))!$L($P(HLRESLT(I),U,3))
 .S RAERR(1)=$P(HLRESLT(I),U,2),RAERR(2)=$P(HLRESLT(I),U,3)
 .D EM(+HLRESLT(I),ERROR,.RAERR,XMSUB_" multi subscribers")
 .K RAERR
 Q
 ;
ASTATUS(HLRESLT,MID,VNDR) ;ACK error
 ;
 Q:'$D(HLRESLT)
 N I,RAERR,ERROR,XMSUB
 S XMSUB="RAD HL7: Error in GENACK^HLMA1"
 S ERROR="ACK to:"_VNDR_"    Message ID: "_MID
 I +$P(HLRESLT,U,2)!$L($P(HLRESLT,U,3)) D
 .S RAERR(1)=$P(HLRESLT,U,2),RAERR(2)=$P(HLRESLT,U,3)
 .D EM(+HLRESLT,ERROR_">>"_HLRESLT_"<<",.RAERR,XMSUB)
 .K RAERR
 Q
EXIT ; cleanup, and quit.
 Q
