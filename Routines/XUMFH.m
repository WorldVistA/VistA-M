XUMFH ;CIOFO-SF/RAM - Master File HL7 Msg Handler ;11/16/05
 ;;8.0;KERNEL;**206,209,217,218,262,335,261,390,369,416**;Jul 10, 1995;Build 5
 ;
 ; This routine handles Master File HL7 messages.
 ;
MAIN ; -- entry point
 ;
 N CNT,ERR,I,X,HLFS,HLCS,ERROR,HLRESLTA,IFN,IEN,MTPE,TYPE,ARRAY
 N HDT,KEY,MID,REASON,VALUE,XREF,ALL,GROUP,PARAM,ROOT,SEG,QRD
 N QID,WHAT,WHO,HLSCS,CDSYS,ERRCNT,IDX98
 ;
 D INIT,PROCESS,REPLY,EXIT
 ;
 Q
 ;
INIT ; -- initialize
 ;
 K ^TMP("DILIST",$J),^TMP("DIERR",$J)
 K ^TMP("HLS",$J),^TMP("HLA",$J),^TMP("XUMF ERROR",$J)
 ;
 S (ERROR,CNT,TYPE,ARRAY,ERRCNT)=0
 S HLFS=HL("FS"),HLCS=$E(HL("ECH")),HLSCS=$E(HL("ECH"),4)
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
 Q:ERROR
 ;
 S QRD="QRD,QDT,QFC,QP,QID,DRT,DRDT,QLR,WHO,WHAT,WDDC,WDCVQ,QRL"
 ;
 F I=2:1:13 S PARAM($P(QRD,",",I))=$P(HLNODE,HLFS,I)
 S QID=$P(HLNODE,HLFS,5)
 S WHO=$P(HLNODE,HLFS,9)
 I WHO="" D  Q
 .S ERROR="1^QRD segment has null missing WHO parameter"
 .D EM(ERROR,.ERR)
 S WHAT=$P(HLNODE,HLFS,10)
 I WHAT="" D  Q
 .S ERROR="1^QRD segment has null missing WHAT parameter"
 .D EM(ERROR,.ERR)
 ;
 S ARRAY=$S(QID["ARRAY":1,1:0)
 S ALL=$S(WHO["ALL":1,1:0)
 S GROUP=$S(ALL:1,(WHO["IEN"):1,1:0)
 ;
 S:ARRAY TYPE=$S(GROUP:7,1:3)
 S:'ARRAY TYPE=$S(GROUP:5,1:1)
 S:HL("MTN")="MFR" TYPE=TYPE+10
 ;
 S IFN=+WHAT
 S XREF=$P(WHO,HLCS,9),ROOT=$$ROOT^DILFD(IFN,,1)
 S IEN=$O(@ROOT@(XREF,$P(WHO,HLCS),0))
 S IEN=$S(IEN:IEN,1:$P(WHO,HLCS))
 S:$L(XREF)>1 PARAM("CDSYS")=XREF
 ;
 K:ARRAY ^TMP("XUMF ARRAY",$J)
 ;
 Q
 ;
MFI ; -- MFI segment
 ;
 Q:ERROR
 Q:$G(IFN)
 ;
 I $P(HLNODE,HLFS,2)="" D  Q
 .S ERROR="1^MFI segment missing Master File Identifier"
 .D EM(ERROR,.ERR)
 S IFN=$$MFI^XUMFP($P(HLNODE,HLFS,2))
 I 'IFN D  Q
 .S ERROR="1^IFN in MFI could not be resolved"
 .D EM(ERROR,.ERR)
 ;
 Q
 ;
MFE ; -- MFE segment
 ;
 Q:ERROR
 ;Q:$G(IEN)
 ;
 S KEY=$P(HLNODE,HLFS,5) Q:ARRAY
 ;
 I $P(KEY,HLCS)="" D  Q
 .D EM("MFE segment NULL key "_$E(HLNODE,1,80),.ERR)
 .
 S XREF=$P(KEY,HLCS,3)
 S CDSYS=$S($L(XREF)>1:XREF,1:"")
 ;
 S IEN=$S(CDSYS'="":$$IEN^XUMF(IFN,CDSYS,$P(KEY,HLCS)),1:$$FIND1^DIC(IFN,,"BX",$P(KEY,HLCS),XREF,,"ERR"))
 S IEN=$S(IEN:IEN,KEY["ALL":"ALL",$G(ERR)'="":"ERROR",1:"NEW")
 I IEN="ERROR" D  Q
 .D EM("MFE segment couldn't resolve IEN",.ERR)
 .K ERR
 D MAIN^XUMFP(IFN,IEN,TYPE,.PARAM,.ERROR)
 ;
 Q
 ;
ZL7 ; -- Generic Master File
ZIN ; -- VHA Institution segment
ZFT ; -- VHA Facility Type segment
LOC ; -- Location Identification segment
ZZZ ; -- get [Z...] segment(s)
 ;
 Q:ERROR
 Q:IEN="ERROR"
 ;
 I $G(ARRAY) D ARRAY Q
 ;
 N FDA,IENS,FIELD,ERR,PRE,POST,XUMF,MULT,FDA1,SEQ,SEQ1,SEQ2,SEQ3,XUMFSEQ
 ;
 D SEGPRSE^XUMFXHL7("HLNODE","XUMFSEQ")
 ;
 I IFN=4,CDSYS'="",XUMFSEQ(2)'="",'$D(^DIC(4,"D",XUMFSEQ(2),IEN)) D  Q
 .D EM("Coding system/station number mismatch - record "_KEY_" not updated",.ERR)
 ;
 S PRE=$G(^TMP("XUMF MFS",$J,"PARAM","PRE"))
 D:PRE'="" @(PRE)
 ;
 S XUMF=7
 ;
 S SEG=$P(HLNODE,HLFS)
 S IENS=$S(IEN:IEN,1:"+1")_","
 S SEQ=0
 F  S SEQ=$O(^TMP("XUMF MFS",$J,"PARAM","SEG",SEG,"SEQ",SEQ)) Q:'SEQ  D
 .I IFN=4,SEQ=17 D NPI^XUMF Q
 .S SEQ1=$P(SEQ,"."),SEQ2=$P(SEQ,".",2)
 .S SEQ3=$O(^TMP("XUMF MFS",$J,"PARAM","SEG",SEG,"SEQ",SEQ,"HLSCS",0))
 .I SEQ3 D SUBCOMP Q
 .S FIELD=$O(^TMP("XUMF MFS",$J,"PARAM","SEG",SEG,"SEQ",SEQ,0))
 .I FIELD=".01" D
 ..N FDA,IEN1
 ..S TYP=$G(^TMP("XUMF MFS",$J,"PARAM","SEG",SEG,"SEQ",SEQ,FIELD))
 ..;S VALUE=$$VALUE()
 ..S VALUE=$S(SEQ2:XUMFSEQ($P(SEQ,".")),1:XUMFSEQ(SEQ))
 ..S:SEQ2 VALUE=$$VAL2()
 ..S VALUE=$$DTYP^XUMFP(VALUE,TYP,HLCS,0)
 ..S FDA(IFN,IENS,FIELD)=VALUE
 ..D UPDATE^DIE("E","FDA","IEN1","ERR")
 ..I $D(ERR) D
 ...D EM("Update DIE - error message",.ERR)
 ...K ERR
 ..;NEW RECORD
 ..I $D(IEN1) D
 ...S IENS=IEN1(1)_","
 ...D CDSYS^XUMF(CDSYS,$P(KEY,HLCS),IEN1(1))
 .I 'FIELD D SUBFILE Q
 .S TYP=$G(^TMP("XUMF MFS",$J,"PARAM","SEG",SEG,"SEQ",SEQ,FIELD))
 .;S VALUE=$$VALUE()
 .S VALUE=$S(SEQ2:XUMFSEQ($P(SEQ,".")),1:XUMFSEQ(SEQ))
 .S:SEQ2 VALUE=$$VAL2()
 .S VALUE=$$DTYP^XUMFP(VALUE,TYP,HLCS,0)
 .S FDA(IFN,IENS,FIELD)=VALUE
 ;
 M FDA=FDA1
 ;
 D FILE^DIE("E","FDA","ERR")
 I $D(ERR) D
 .D EM("File DIE -- error message",.ERR)
 .K ERR
 ;
 S POST=$G(^TMP("XUMF MFS",$J,"PARAM","POST"))
 D:POST'="" @(POST)
 ;
 K IEN
 ;
 Q
 ;
SUBFILE ; -- process subfile record
 ;
 N IFN,IENS1,KEY1,FIELD,TYP,MKEY,ERR
 ;
 S IFN=^TMP("XUMF MFS",$J,"PARAM","SEG",SEG,"SEQ",SEQ,"FILE")
 S FIELD=^TMP("XUMF MFS",$J,"PARAM","SEG",SEG,"SEQ",SEQ,"FIELD")
 S TYP=^TMP("XUMF MFS",$J,"PARAM","SEG",SEG,"SEQ",SEQ,"DTYP")
 ;S VALUE=$$VALUE()
 S VALUE=$S(SEQ2:XUMFSEQ($P(SEQ,".")),1:XUMFSEQ(SEQ))
 S:SEQ2 VALUE=$$VAL2()
 S VALUE=$$DTYP^XUMFP(VALUE,TYP,HLCS,0)
 ;
 S MULT=$G(^TMP("XUMF MFS",$J,"PARAM","MULT",SEG,SEQ))
 S MKEY=$G(^TMP("XUMF MFS",$J,"PARAM","MKEY",SEG,SEQ))
 I MULT=SEQ Q:VALUE=""  D
 .N FDA,IEN
 .S FDA(IFN,"?+1,"_IENS,.01)=VALUE
 .D UPDATE^DIE("E","FDA","IEN","ERR")
 .I $D(ERR) D
 ..D EM("update DIE call error message in SUBFILE",.ERR)
 ..K ERR
 .S IENS1=IEN(1)_","_IENS,MULT(SEQ)=IENS1
 I 'MULT D
 .N FDA,IEN
 .S FDA(IFN,"?+1,"_IENS,.01)=MKEY
 .D UPDATE^DIE("E","FDA","IEN","ERR")
 .I $D(ERR) D
 ..D EM("update DIE call error message in SUBFILE",.ERR)
 ..K ERR
 .S IENS1=IEN(1)_","_IENS,MULT(SEQ)=IENS1
 .S FDA1(IFN,IENS1,.01)=MKEY
 I MULT,MULT'=SEQ S IENS1=$G(MULT(+MULT)) Q:IENS1=""
 S FDA1(IFN,IENS1,FIELD)=VALUE
 ;
 Q
 ;
VALUE() ; -- parse segment
 ;
 ;Q
 ;
 ;N COL
 ;
 ;D SEGPRSE^XUMFXHL7("HLNODE","COL")
 ;
 ;Q:SEQ2 COL($P(SEQ,"."))
 ;
 ;Q COL(SEQ)
 ;
 ;
VAL2() ; -- parse component
 ;
 N XXX
 ;
 D SEQPRSE^XUMFXHL7("VALUE","XXX")
 ;
 Q XXX(1,SEQ2)
 ;
 ;
SUBCOMP ; -- subcomponents
 ;
 S SEQ3=0
 F  S SEQ3=$O(^TMP("XUMF MFS",$J,"PARAM","SEG",SEG,"SEQ",SEQ,"HLSCS",SEQ3)) Q:'SEQ3  D
 .S FIELD=$O(^TMP("XUMF MFS",$J,"PARAM","SEG",SEG,"SEQ",SEQ,"HLSCS",SEQ3,0))
 .S TYP=$G(^TMP("XUMF MFS",$J,"PARAM","SEG",SEG,"SEQ",SEQ,"HLSCS",SEQ3,FIELD))
 .;S VALUE=$$VALUE()
 .S VALUE=$S(SEQ2:XUMFSEQ($P(SEQ,".")),1:XUMFSEQ(SEQ))
 .S VALUE=$$VAL2()
 .S VALUE=$P(VALUE,HLSCS,SEQ3)
 .S VALUE=$$DTYP^XUMFP(VALUE,TYP,HLSCS,0)
 .S FDA(IFN,IENS,FIELD)=VALUE
 ;
 Q
 ;
ARRAY ; -- query data stored in array (not filed)
 ;
 I $P($G(KEY),HLCS)="" D  Q
 .D EM("Null KEY found in the following segment: "_$E(HLNODE,1,80),.ERR)
 .S ERROR=ERROR_U_$G(ERR)
 ;
 I $G(IFN)=9.8 D  Q
 .S IDX98=$G(IDX98)+1
 .S ^TMP("XUMF ARRAY",$J,IDX98)=HLNODE
 ;
 M ^TMP("XUMF ARRAY",$J,$P(KEY,HLCS))=HLNODE
 ;
 Q
 ;
REPLY ; -- master file response
 ;
 Q:HL("MTN")="MFR"
 Q:HL("MTN")="MFK"
 Q:HL("MTN")="ACK"
 ;
 S:(TYPE<10) TYPE=(TYPE+10)
 ;
 I HL("MTN")="MFQ" D
 .S IFN=+$G(WHAT) I 'IFN D  Q
 ..S ERROR="1^REPLY MFQ couldn't resolve IFN"
 ..D EM(ERROR,.ERR)
 .S XREF=$P(WHO,HLCS,9),ROOT=$$ROOT^DILFD(IFN,,1)
 .S IEN=$O(@ROOT@(XREF,$P(WHO,HLCS),0))
 .S IEN=$S(IEN:IEN,1:$P(WHO,HLCS))
 ;
 S IFN=$G(IFN),IEN=$G(IEN)
 ;
 D MAIN^XUMFP(IFN,IEN,TYPE,.PARAM,.ERROR)
 D MAIN^XUMFI(IFN,IEN,TYPE,.PARAM,.ERROR)
 ;
 Q
 ;
EXIT ; -- cleanup, and quit
 ;
 I $D(^TMP("XUMF ERROR",$J)) D EM1 K ^TMP("XUMF ERROR",$J)
 ;
 K ^TMP("DILIST",$J),^TMP("DIERR",$J),^TMP("HLS",$J),^TMP("HLA",$J)
 ;
 Q
 ;
EM(ERROR,ERR) ; -- error message
 ;
 D EM^XUMFHM(ERROR,.ERR)
 ;
 Q
 ;
 ;
 ;N X,I,Y,XMTEXT,FLG
 ;
 ;S FLG=0
 ;
 ;D MSG^DIALOG("AM",.X,80,,"ERR")
 ;
 ;S X(.02)="",X(.03)=$G(ERROR),X(.04)=""
 ;
 ;S X=.9 F  S X=$O(X(X)) Q:'X  D
 ;.I X(X)="" K X(X) Q
 ;.I X(X)["DINUMed field cannot" S FLG=1 K X(X) Q
 ;.I X(X)["ASSOCIATION" S FLG=1 K X(X) Q
 ;.I X(X)["INSTITUTION" S FLG=1 K X(X) Q
 ;.I X(X)["The entry does not exist." S FLG=1 K X(X) Q
 ;.I X(X)["already exists." S FLG=1 K X(X) Q
 ;
 ;I FLG Q:'$O(X(.9))
 ;
 ;S ERRCNT=ERRCNT+1
 ;
 ;S ^TMP("XUMF ERROR",$J,ERRCNT_".01")=""
 ;S ^TMP("XUMF ERROR",$J,ERRCNT_".02")=""
 ;S ^TMP("XUMF ERROR",$J,ERRCNT_".03")=$G(ERROR)
 ;S ^TMP("XUMF ERROR",$J,ERRCNT_".04")=""
 ;S ^TMP("XUMF ERROR",$J,ERRCNT_".05")="KEY: "_$G(KEY)_"   IFN: "_$G(IFN)_"   IEN: "_$G(IEN)
 ;S ^TMP("XUMF ERROR",$J,ERRCNT_".06")=""
 ;S X=.9 F  S X=$O(X(X)) Q:'X  D
 ;.S ^TMP("XUMF ERROR",$J,ERRCNT_"."_X)=X(X)
 ;
 ;Q
 ;
EM1 ;
 ;
 D EM1^XUMFHM
 ;
 Q
 ;
 ;N XMY,XMSUB
 ;
 ;S ^TMP("XUMF ERROR",$J,.1)="HL7 message ID: "_$G(HL("MID"))
 ;S XMY("G.XUMF ERROR")="",XMSUB="MFS ERROR"
 ;S XMTEXT="^TMP(""XUMF ERROR"",$J,"
 ;
 ;D ^XMD
 ;
 ;Q
 ;
