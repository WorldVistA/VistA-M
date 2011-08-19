XUMFP513 ;ALB/BRM - Master File Param COUNTY CODE ; 10/29/02 9:52am
 ;;8.0;KERNEL;**246**;Jul 10, 1995
 ;
 ;
 ; This routine sets up the parameters required by the COUNTY CODE
 ; (#5.13) file for the Master File server mechanism.
 ;
 ;  ** This routine is not a supported interface -- use XUMFP **
 ;
 ;  See XUMFP for parameter list documentation
 ;
 N PKV,PROTOCOL,HLFS,HLCS,RT,RF
 ;
 S PARAM("PRE")="PRE^XUMFP513"
 S PARAM("POST")="POST^XUMFP513"
 S TYPE=0
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
 I QUERY D QRD
 ;
 ; MFI -- Master File Identification Segment
 S ^TMP("XUMF MFS",$J,"PARAM","MFI")="5P13"  ;Master File Identifier
 S ^TMP("XUMF MFS",$J,"PARAM","MFAI")=""  ;Application Identifier
 S ^TMP("XUMF MFS",$J,"PARAM","FLEC")="UPD"  ;File-Level Event Code
 S ^TMP("XUMF MFS",$J,"PARAM","ENDT")=""  ;Entered Date/Time
 S ^TMP("XUMF MFS",$J,"PARAM","MFIEDT")=""  ;Effective Date/Time
 S ^TMP("XUMF MFS",$J,"PARAM","RLC")="NE"  ;Response Level Code
 ;
 ; MFE -- Master File Entry
 I $G(^TMP("XUMF MFS",$J,"PARAM","RLEC"))="" D  ;Record-Level Event Code
 .S ^TMP("XUMF MFS",$J,"PARAM","RLEC")="UPD"
 S ^TMP("XUMF MFS",$J,"PARAM","MFNCID")=""  ;MFN Control ID
 I $G(^TMP("XUMF MFS",$J,"PARAM","MFEEDT"))="" D  ;Effective Date/Time
 .S ^TMP("XUMF MFS",$J,"PARAM","MFEEDT")=$$HLDATE^HLFNC($$NOW^XLFDT)
 ;
SEG ; -- LOC segment used for County Code File updates
 ;
 I IEN D
 .S PKV=$P($G(^XIP(5.13,+IEN,0)),U)
 .S ^TMP("XUMF MFS",$J,"PARAM","PKV")=PKV  ; Primary Key Value
 I NEW D
 .S PKV="NEW"
 .S ^TMP("XUMF MFS",$J,"PARAM","PKV")=PKV  ; Primary Key Value
 ;
 ; LOC -- Location Identification Segment sequence
 S ^TMP("XUMF MFS",$J,"PARAM","SEGMENT")="LOC"
 ;   primary key value
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","LOC","SEQ",1,.01)="PL"
 ;   location address (contains components utilizing XAD)
 ;   components and subcomponents are recognized by decimal SEQ values
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","LOC","SEQ",5.4,2)="ZST"  ;state
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","LOC","SEQ",5.8,1)="ST"  ;county
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","LOC","SEQ",5.9,.01)="ST"  ;FIPS
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","LOC","SEQ",5.12,"HLSCS",2,3)="DT"  ;inactive date
 ;
 Q:'GROUP
 Q:$G(HL("MTN"))="MFR"
 ;
GROUP ; -- query group
 ;
 S IEN=0
 F  S IEN=$O(^TMP("XUMF MFS",$J,"PARAM","IENS",IEN)) Q:'IEN  D
 .S PKV=$P(^XIP(5.13,IEN,0),U)
 .S ^TMP("XUMF MFS",$J,"PARAM",IEN,"PKV")=PKV
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
 .S ^TMP("XUMF MFS",$J,"PARAM","QID")="5P13 "_$S(ARRAY:"ARRAY",1:"FILE")
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
 .S ^TMP("XUMF MFS",$J,"PARAM","QLR")="RD"_HLCS_999
 ;
 ;Who Subject Filter - sta#, D x-ref, assigning facility
 I '$D(^TMP("XUMF MFS",$J,"PARAM","WHO")) D
 .N X S X=$S(ALL:"ALL",IEN:$P($G(^XIP(5.13,+IEN,0)),U),1:"IEN ARRAY")
 .S $P(X,HLCS,9,10)="B"_HLCS_"VA"
 .S ^TMP("XUMF MFS",$J,"PARAM","WHO")=X
 ;
 ;What Subject Filter
 I '$D(^TMP("XUMF MFS",$J,"PARAM","WHAT")) D
 .S ^TMP("XUMF MFS",$J,"PARAM","WHAT")="5.13"_HLCS_"IFN"_HLCS_"VA FM"
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
