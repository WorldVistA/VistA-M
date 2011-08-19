XUMFI0 ;CIOFO-SF/RAM - Master File Interface ;06/28/00
 ;;8.0;KERNEL;**369,416**;Jul 10, 1995;Build 5
 ;
 Q
 ;
INIT ; -- initialize
 ;
 K ^TMP("DILIST",$J),^TMP("DIERR",$J)
 K ^TMP("HLS",$J),^TMP("HLA",$J)
 ;
 S IEN=$G(IEN),IFN=$G(IFN)
 S TYPE=$G(TYPE),ERROR=$G(ERROR),CNT=1
 S UPDATE=$S(TYPE#2:0,1:1)
 S QUERY='UPDATE
 S GROUP=$S(UPDATE:0,TYPE[5:1,TYPE[7:1,1:0)
 S ARRAY=$S(UPDATE:0,TYPE[3:1,TYPE[7:1,1:0)
 S ALL=$S(IEN["ALL":1,1:0)
 S PROTOCOL=$G(^TMP("XUMF MFS",$J,"PARAM","PROTOCOL"))
 S MFR=$S(UPDATE:0,TYPE>10:1,1:0)
 S MFQ=$S(UPDATE:0,'MFR:1,1:0)
 S MFK=$S(TYPE=10:1,1:0)
 S MTYP=$S(MFR:"HLA",MFK:"HLA",1:"HLS")
 ;
 ; -- get variables from HL7 package
 I $O(HL(""))="" D INIT^HLFNC2(PROTOCOL,.HL)
 I $O(HL(""))="" S ERROR="1^"_$P(HL,"^",2) Q
 S HLFS=HL("FS"),HLCS=$E(HL("ECH")),HLSCS=$E(HL("ECH"),4)
 ;
 Q:ERROR
 I UPDATE,'IEN,TYPE=10 Q
 ;
 ; -- check parameters
 I 'QUERY,'UPDATE S ERROR="1^invalid message type" Q
 I 'IFN S ERROR="1^invalid file number" Q
 I 'IEN,'ALL,'MFK S ERROR="1^invalid IEN" Q
 I '$$VFILE^DILFD(IFN) S ERROR="1^invalid file number" Q
 I UPDATE,'IEN S ERROR="1^update message requires an IEN" Q
 ;
 ; -- get root of file
 S ROOT=$$ROOT^DILFD(IFN,,1)
 ;
 ; -- if IEN array input, merge with param
 I 'ALL,'IEN,$O(IEN(0)) M ^TMP("XUMF MFS",$J,"PARAM","IEN")=IEN
 ;
 ; -- if CDSYS and ALL get entries
 S CDSYS=$G(^TMP("XUMF MFS",$J,"PARAM","CDSYS"))
 I ALL,CDSYS'="" D
 .S I=0 F  S I=$O(@ROOT@("XUMFIDX",CDSYS,I)) Q:'I  D
 ..S J=$O(@ROOT@("XUMFIDX",CDSYS,I,0))
 ..S ^TMP("XUMF MFS",$J,"PARAM","IEN",J)=""
 ;
 ; -- get ALL file 'national' entries
 I ALL,'$D(^TMP("XUMF MFS",$J,"PARAM","IEN")) D
 .S I=0 F  S I=$O(@ROOT@("XUMF","N",I)) Q:'I  D
 ..S ^TMP("XUMF MFS",$J,"PARAM","IEN",I)=""
 ;
 Q
 ;
