XUMFHPR ;OIFO-OAK/RAM - Master File Parameters client Handler ;06/28/00
 ;;8.0;KERNEL;**299**;Jul 10, 1995
 ;
 ; This routine handles Master File Parameters file updates.
 ;
MAIN ; -- entry point
 ;
 N ERR,HLFS,HLCS,ERROR,IEN,KEY,MID,REASON,VALUE
 ;
 D INIT,PROCESS,EXIT
 ;
 Q
 ;
INIT ; -- initialize
 ;
 K ^TMP("DILIST",$J),^TMP("DIERR",$J)
 K ^TMP("HLS",$J),^TMP("HLA",$J)
 ;
 S ERROR=0,HLFS=HL("FS"),HLCS=$E(HL("ECH"))
 ;
 Q
 ;
PROCESS ; -- pull message text
 ;
 F  X HLNEXT Q:HLQUIT'>0  D
 .Q:$P(HLNODE,HLFS)=""
 .D @($P(HLNODE,HLFS))
 ;
 Q
 ;
MSH ; -- MSH segment
 ;
 Q
 ;
MSA ; -- MSA segment
 ;
 N CODE
 ;
 S CODE=$P(HLNODE,HLFS,2)
 ;
 I CODE="AE"!(CODE="AR") D
 .S ERROR=ERROR_U_$P(HLNODE,HLFS,4)_U_$G(ERR)
 .D EM(ERROR,.ERR)
 ;
 Q
 ;
QRD ; -- QRD segment
 ;
 Q
 ;
MFI ; -- MFI segment
 ;
 Q
 ;
MFE ; -- MFE segment
 ;
 Q:ERROR
 ;
 S KEY=$P($P(HLNODE,HLFS,5),HLCS)
 ;
 S IEN=$$FIND1^DIC(1,,"X",KEY,"B")
 ;
 I 'IEN D  Q
 .D EM("Error - no IEN in MFE XUMFH",.ERR)
 .K ERR
 ;
 Q
 ;
ZMF ; -- ZMF segment
 ;
 Q:ERROR
 ;
 N FDA,IENS,FIELD,ERR,XUMF,SEQ,X
 ;
 S XUMF=1
 ;
 K FDA
 S IENS=IEN_","
 ;
 ;zero node
 F SEQ=2:1:6 D
 .S FIELD=".0"_SEQ
 .S VALUE=$P(HLNODE,HLFS,SEQ+1)
 .S VALUE=$$DTYP^XUMFP(VALUE,"ST",HLCS,0)
 .S FDA(4.001,IENS,FIELD)=VALUE
 ;
 ;mfe node
 F SEQ=1:1:9 D
 .S FIELD="4."_SEQ
 .S VALUE=$P(HLNODE,HLFS,SEQ+7)
 .S VALUE=$$DTYP^XUMFP(VALUE,"ST",HLCS,0)
 .S FDA(4.001,IENS,FIELD)=VALUE
 F SEQ=1,2,4:1:7 D
 .S FIELD="4.1"_SEQ
 .S VALUE=$P(HLNODE,HLFS,SEQ+16)
 .S VALUE=$$DTYP^XUMFP(VALUE,"ST",HLCS,0)
 .S FDA(4.001,IENS,FIELD)=VALUE
 ;
 D FILE^DIE("E","FDA","ERR")
 I $D(ERR) D
 .D EM("FILE DIE call error message in ZZZ XUMFHPR",.ERR)
 .K ERR
 ;
 K FDA
 S SEQ=0
 F  S SEQ=$O(^DIC(4.001,IEN,1,SEQ)) Q:'SEQ  D
 .S IENS=SEQ_","_IEN_","
 .S FDA(4.011,IENS,.01)="@"
 ;
 D FILE^DIE("E","FDA")
 ;
 Q
 ;
ZZS ; -- SEQUENCE segments
 ;
 Q:ERROR
 ;
 N FDA,IENS,FIELD,ERR,XUMF,SEQ
 ;
 S XUMF=1
 ;
 S IENS="?+"_+$P(HLNODE,HLFS,2)_","_IEN_","
 ;
 F I=1:1:9 D
 .S FIELD=".0"_I
 .S VALUE=$P(HLNODE,HLFS,I+1)
 .S VALUE=$$DTYP^XUMFP(VALUE,"ST",HLCS,0)
 .S FDA(4.011,IENS,FIELD)=VALUE
 ;
 D UPDATE^DIE("E","FDA",,"ERR")
 I $D(ERR) D
 .D EM("UPDATE DIE call error message in ZZS XUMFHPR",.ERR)
 .K ERR
 ;
 Q
 ;
EXIT ; -- cleanup, and quit
 ;
 K ^TMP("DILIST",$J),^TMP("DIERR",$J),^TMP("HLS",$J),^TMP("HLA",$J)
 K ^TMP("XUMF MFS",$J)
 ;
 Q
 ;
EM(ERROR,ERR,XMSUB,XMY) ; -- error message
 ;
 N X,XMTEXT
 ;
 D MSG^DIALOG("AM",.X,80,,"ERR")
 ;
 S X(.1)="HL7 message ID: "_$G(HL("MID"))
 S X(.2)="",X(.3)=$G(ERROR),X(.4)=""
 S:$G(XMSUB)="" XMSUB="MFS ERROR"
 S XMY("G.XUMF ERROR")="",XMDUZ=.5
 S XMTEXT="X("
 ;
 D ^XMD
 ;
 Q
 ;
