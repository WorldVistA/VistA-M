XUMF512F ;ALB/BRM-Postal and County Code Master File edit ; [10/11/02 9:15am]
 ;;8.0;KERNEL;**246**;Jul 10, 1995
 ;
 ; this routine will be used to transmit updates made to the
 ; #300.9 file to populate the #5.12 and #5.13 files on the VistA
 ; system.
 ;
 Q
MAIN(IEN3009,UPDTFIL,ERROR) ;entry point
 ;
 N IFN,PARAM,PKV,PROTOCOL,TYPE,HL,QUERY,UPDATE,ALL,MFR,MFQ,HLFS,HLCS
 N GROUP,ARRAY,ROOT,NEW,I
 ;
 ;
 I '$G(UPDTFIL)!("^5.12^5.13^"'[("^"_UPDTFIL_"^")) S ERROR="1^invalid update file" Q
 I '$G(IEN3009) S ERROR="1^invalid 300.9 ien" Q
 S IFN=300.9,TYPE=0,ERROR=0,QUERY=0,GROUP=0,ARRAY=0
 S ALL=0,NEW=0,MFR=0,MFQ=0
 S PARAM("BROADCAST")=1
 K ^TMP("XUMF MFS",$J)
 S ^TMP("XUMF MFS",$J,"PARAM","PRE")="PRE^XUMF512F"
 S ^TMP("XUMF MFS",$J,"PARAM","POST")="POST^XUMF512F"
 S ^TMP("XUMF MFS",$J,"PARAM","BROADCAST")=1
 S ^TMP("XUMF MFS",$J,"PARAM","UPDATE FILE")=$G(UPDTFIL)
 ;
 S PROTOCOL=$O(^ORD(101,"B","XUMF MFN",0))
 I 'PROTOCOL S ERROR="1^invalid protocol" Q
 S ^TMP("XUMF MFS",$J,"PARAM","PROTOCOL")=PROTOCOL
 D INIT^HLFNC2(PROTOCOL,.HL)
 ;
 I $O(HL(""))="" S ERROR="1^"_$P(HL,U,2) Q
 S HLFS=HL("FS"),HLCS=$E(HL("ECH"))
 ;
 ; MFI -- Master File Identification Segment
 S ^TMP("XUMF MFS",$J,"PARAM","MFI")=$TR(UPDTFIL,".","P")  ;MFI
 S ^TMP("XUMF MFS",$J,"PARAM","MFAI")=""  ;Application Identifier
 S ^TMP("XUMF MFS",$J,"PARAM","FLEC")="UPD"  ;File-Level Event Code
 S ^TMP("XUMF MFS",$J,"PARAM","ENDT")=""  ;Entered Date/Time
 S ^TMP("XUMF MFS",$J,"PARAM","MFIEDT")=""  ;Effective Date/Time
 S ^TMP("XUMF MFS",$J,"PARAM","RLC")="NE"  ;Response Level Code
 ;
 ; MFE -- Master File Entry
 S ^TMP("XUMF MFS",$J,"PARAM","RLEC")="MUP"
 S ^TMP("XUMF MFS",$J,"PARAM","MFNCID")=""  ;MFN Control ID
 S ^TMP("XUMF MFS",$J,"PARAM","MFEEDT")=$$HLDATE^HLFNC($$NOW^XLFDT)  ;Effective Date/Time
 ;
 ; LOC segment used for Postal Code File updates
 ; data will be obtained from the 300.9 file
 ;
 ; create ^TMP for Postal Code update message
 I ^TMP("XUMF MFS",$J,"PARAM","UPDATE FILE")=5.12 D
 .S PKV=$P($G(^IVM(300.9,IEN3009,0)),U)
 .S ^TMP("XUMF MFS",$J,"PARAM","PKV")=PKV  ; Primary Key Value
 .S ^TMP("XUMF MFS",$J,"PARAM","SEGMENT")="LOC"
 .S ^TMP("XUMF MFS",$J,"PARAM","SEG","LOC","SEQ",1,.01)="PL"
 .S ^TMP("XUMF MFS",$J,"PARAM","SEG","LOC","SEQ",5.3,2)="ST"  ;city
 .S ^TMP("XUMF MFS",$J,"PARAM","SEG","LOC","SEQ",5.4,1)="ST"  ;state
 .S ^TMP("XUMF MFS",$J,"PARAM","SEG","LOC","SEQ",5.5,.01)="ST"  ;p cod
 .S ^TMP("XUMF MFS",$J,"PARAM","SEG","LOC","SEQ",5.8,5)="ST"  ;county
 .S ^TMP("XUMF MFS",$J,"PARAM","SEG","LOC","SEQ",5.9,4.7)="ST" ;FIPS
 ; create ^TMP for County Code update message
 I ^TMP("XUMF MFS",$J,"PARAM","UPDATE FILE")=5.13 D
 .S PKV=$P($G(^IVM(300.9,IEN3009,0)),"^",12)_$P($G(^IVM(300.9,IEN3009,0)),"^",5)
 .S ^TMP("XUMF MFS",$J,"PARAM","PKV")=PKV  ; Primary Key Value
 .S ^TMP("XUMF MFS",$J,"PARAM","SEGMENT")="LOC"
 .S ^TMP("XUMF MFS",$J,"PARAM","SEG","LOC","SEQ",1,4.7)="ST"  ;PKV
 .S ^TMP("XUMF MFS",$J,"PARAM","SEG","LOC","SEQ",5.4,1)="ST"  ;state
 .S ^TMP("XUMF MFS",$J,"PARAM","SEG","LOC","SEQ",5.8,5)="ST"  ;county
 .S ^TMP("XUMF MFS",$J,"PARAM","SEG","LOC","SEQ",5.9,4.7)="ST"  ;5-digit FIPS
 ;
 ; transmit updates in MFN~M05 message
 D MAIN^XUMFI(IFN,IEN3009,TYPE,.PARAM,.ERROR)
 Q
 ;
PRE ; -- pre-update record
 Q
 ;
POST ; -- post-update record
 Q
 ;
