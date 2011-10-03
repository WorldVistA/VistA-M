XUMFPMFS ;CIOFO-SF/RAM - Master File Param GENERIC ;8/14/06
 ;;8.0;KERNEL;**262,369**;Jul 10, 1995;Build 27
 ;
 ; This routine sets up the parameters required by the ZL7
 ; for the Master File server mechanism.
 ;
 ;  ** This routine is not a supported interface -- use XUMFP **
 ;
 ;  See XUMFP for parameter list documentation
 ;
 N PKV,PROTOCOL,HLFS,HLCS,RT,RF,TABLE,TABNAM
 ;
 D FILE^DID(IFN,"","NAME","X")
 S TABNAM=$S($G(X("NAME"))'="":X("NAME"),1:"NOTAB") K X
 ;
 S PARAM("PRE")="PRE^XUMFPMFS"
 S PARAM("POST")="POST^XUMFPMFS"
 ;
 I $O(HL(""))="" D
 .S:UPDATE PROTOCOL=$O(^ORD(101,"B","XUMF MFN",0))
 .S:QUERY PROTOCOL=$O(^ORD(101,"B","XUMF MFQ",0))
 .S:'PROTOCOL ERROR="1^invalid protocol" Q:ERROR
 .S ^TMP("XUMF MFS",$J,"PARAM","PROTOCOL")=PROTOCOL
 .D INIT^HLFNC2(PROTOCOL,.HL)
 ;
 I $O(HL(""))="" S ERROR="1^"_$P(HL,U,2) Q
 S HLFS=HL("FS"),HLCS=$E(HL("ECH"))
 ;
 D
 .I IFN=4.11 S TABLE="ZAG" Q
 .I IFN=5 S TABLE="Z05" Q
 .I IFN=49 S TABLE="Z49" Q
 .I IFN=9.8 S TABLE="ZRN" Q
 .S TABLE="NOTAB" Q
 ;
 I QUERY D QRD
 ;
 ; MFI -- Master File Identification Segment
 ;
 S ^TMP("XUMF MFS",$J,"PARAM","MFI")=TABLE  ;Master File Identifier
 S ^TMP("XUMF MFS",$J,"PARAM","MFAI")=""  ;Application Identifier
 S ^TMP("XUMF MFS",$J,"PARAM","FLEC")="UPD"  ;File-Level Event Code
 S ^TMP("XUMF MFS",$J,"PARAM","ENDT")=""  ;Entered Data/Time
 S ^TMP("XUMF MFS",$J,"PARAM","MFIEDT")=""  ;Effective Date/Time
 S ^TMP("XUMF MFS",$J,"PARAM","RLC")="NE"  ;Response Level Code
 ;
 ; MFE -- Master File Entry
 I $G(^TMP("XUMF MFS",$J,"PARAM","RLEC"))="" D  ;Record-Level Event Code
 .S ^TMP("XUMF MFS",$J,"PARAM","RLEC")="MUP"
 S ^TMP("XUMF MFS",$J,"PARAM","MFNCID")=""  ;MFN Control ID
 I $G(^TMP("XUMF MFS",$J,"PARAM","MFEEDT"))="" D  ;Effective Date/Time
 .S ^TMP("XUMF MFS",$J,"PARAM","MFEEDT")=$$HLDATE^HLFNC($$NOW^XLFDT)
 ;
SEG ; -- ZL7 segment
 ;
 I IEN D
 .S PKV=$P($G(@ROOT@(+IEN,0)),U)_HLCS_TABNAM_HLCS_"B"
 .S ^TMP("XUMF MFS",$J,"PARAM","PKV")=PKV  ; Primary Key Value
 I NEW D
 .S PKV="NEW"_HLCS_TABNAM_HLCS_"B"
 .S ^TMP("XUMF MFS",$J,"PARAM","PKV")=PKV  ; Primary Key Value
 ;
 D @(TABLE_"^XUMFPZL7")
 ;
 Q:'GROUP
 Q:$G(HL("MTN"))="MFR"
 ;
GROUP ; -- query group
 ;
 S IEN=0
 F  S IEN=$O(^TMP("XUMF MFS",$J,"PARAM","IEN",IEN)) Q:'IEN  D
 .S PKV=$P(@ROOT@(IEN,0),U)_HLCS_TABNAM_HLCS_"B"
 .S ^TMP("XUMF MFS",$J,"PARAM",IEN,"PKV")=PKV
 .I IFN=9.8 D
 ..N X S X=$O(^DIC(9.8,IEN,8,0)) Q:'X
 ..S ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS","ZL7",5)=X_","_IEN_","
 ..S ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS","ZL7",6)=X_","_IEN_","
 ..F  S X=$O(^DIC(9.8,IEN,8,X)) Q:'X  D
 ...S ^TMP("XUMF MFS",$J,"PARAM",IEN,"ROUTINE",5,X)=X_","_IEN_","
 ...S ^TMP("XUMF MFS",$J,"PARAM",IEN,"ROUTINE",6,X)=X_","_IEN_","
 ;
 Q
 ;
QRD ; -- query definition segment
 ;
 ;Query Date/Time
 I '$D(^TMP("XUMF MFS",$J,"PARAM","QDT")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","QDT")=$$HLDATE^HLFNC($$NOW^XLFDT)
 ;
 ;Query Format Code
 I '$D(^TMP("XUMF MFS",$J,"PARAM","QFC")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","QFC")="R"
 ;
 ;Query Priority
 I '$D(^TMP("XUMF MFS",$J,"PARAM","QP")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","QP")="I"
 ;
 ;Query ID
 I '$D(^TMP("XUMF MFS",$J,"PARAM","QID")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","QID")=TABLE_" "_$S(ARRAY:"ARRAY",1:"FILE")
 ;
 ;Deferred Response Type (optional)
 I '$D(^TMP("XUMF MFS",$J,"PARAM","DRT")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","DRT")=""
 ;
 ;Deferred Response Date/Time (optional)
 I '$D(^TMP("XUMF MFS",$J,"PARAM","DRDT")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","DRDT")=""
 ;
 ;Quantity Limited Request
 I '$D(^TMP("XUMF MFS",$J,"PARAM","QLR")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","QLR")="RD"_HLCS_99999
 ;
 ;Who Subject Filter
 I '$D(^TMP("XUMF MFS",$J,"PARAM","WHO")) D
 .N X S X=$S(ALL:"ALL",IEN:$P($G(@ROOT@(+IEN,0)),U),1:"IEN ARRAY")
 .S $P(X,HLCS,9,10)="B"_HLCS_"VA"
 .S ^TMP("XUMF MFS",$J,"PARAM","WHO")=X
 ;
 ;What Subject Filter
 I '$D(^TMP("XUMF MFS",$J,"PARAM","WHAT")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","WHAT")=IFN_HLCS_"IFN"_HLCS_"VA FM"
 ;
 ;What Department Data Code
 I '$D(^TMP("XUMF MFS",$J,"PARAM","WDDC")) D
 .N X S X="INFRASTRUCTURE"_HLCS_"INFORMATION INFRASTRUCTURE"
 .S X=X_HLCS_"VA TS"
 .S ^TMP("XUMF MFS",$J,"PARAM","WDDC")=X
 ;
 ;What Data Code Value Qual (optional)
 I '$D(^TMP("XUMF MFS",$J,"PARAM","WDCVQ")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","WDCVQ")=""
 ;
 ;Query Results Level (optional)
 I '$D(^TMP("XUMF MFS",$J,"PARAM","QRL")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","QRL")=""
 ;
 Q
 ;
PRE ; -- pre-update record
 ;
 Q
 ;
POST ; -- post-update record
 ;
 Q
 ;
