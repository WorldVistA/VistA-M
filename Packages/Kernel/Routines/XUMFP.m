XUMFP ;CIOFO-SF/RAM,ALB/BRM - Master File C/S Parameters ; 10/11/02 2:50pm
 ;;8.0;KERNEL;**206,217,246,262,369**;Jul 10, 1995;Build 27
 ;
 ;
 ;
MAIN(IFN,IEN,TYPE,PARAM,ERROR) ; -- parameters for master file server
 ;
 ;INPUT
 ;       IFN             Internal File Number (required)
 ;
 ;       IEN             Internal Entry Number (required)
 ;
 ;                       single entry (pass by value) example: IEN=1
 ;
 ;                       multiple entries (pass by reference)  IEN(1)=""
 ;                                                             IEN(2)=""
 ;
 ;                       ALL national entries (pass by value)  IEN="ALL"
 ;
 ;                       NEW entry (pass by value)             IEN="NEW"
 ;
 ;       TYPE            Message TYPE (required)
 ;
 ;                       0  = MFN - unsolicited update
 ;                       1  = MFQ - query particular record and file
 ;                       3  = MFQ - query particular record in array
 ;                       5  = MFQ - query group records file
 ;                       7  = MFQ - query group records array
 ;                       11 = MFR - query response particular rec file
 ;                       13 = MFR - query response particular rec array
 ;                       15 = MFR - query response group records file
 ;                       17 = MFR - query response group records array
 ;
 ;
 ;INPUT/OUTPUT
 ;
 ;       PARAM("PROTOCOL")       IEN Protocol (#101) file
 ;       PARAM("LLNK")           HLL("LINKS",n) 'protocol^logical link'
 ;       PARAM("PRE")            Pre-update record routine
 ;       PARAM("POST")           Post-update record routine
 ;
 ;       QRD -- Query definition segment
 ;       -------------------------------
 ;       PARAM("QDT")            Query Date/Time
 ;       PARAM("QFC")            Query Format Code
 ;       PARAM("QP")             Query Priority
 ;       PARAM("QID")            Query ID
 ;       PARAM("DRT")            Deferred Response Type
 ;       PARAM("DRDT")           Deferred Response Date/Time
 ;       PARAM("QLR")            Quantity Limited Request
 ;       PARAM("WHO")            Who Subject Filter
 ;       PARAM("WHAT")           What Subject Filter
 ;       PARAM("WDDC")           What Department Data Code
 ;       PARAM("WDCVQ")          What Data Code Value Qual
 ;       PARAM("QRL")            Query Results Level
 ;
 ;       MFI -- Master File Identification
 ;       ---------------------------------
 ;       PARAM("MFI")            Master File Identifier
 ;       PARAM("MFAI")           Master File Application Identifier
 ;       PARAM("FLEC")           File-Level Event Code
 ;       PARAM("ENDT")           Entered Data/Time
 ;       PARAM("MFIEDT")         Effective Date/Time
 ;       PARAM("RLC")            Response Level Code
 ; 
 ;       MFE -- Master File Entry
 ;       ------------------------
 ;       PARAM("RLEC")           Record-Level Event Code
 ;       PARAM("MFNCID")         MFN Control ID
 ;       PARAM("MFEEDT")         Effective Date/Time
 ;       PARAM("PKV")            Primary Key Value
 ;
 ;       [Z...] segment(s) parameters
 ;       -------------------------
 ;       PARAM("SEG",SEG)=""             HL7 segment name
 ;       PARAM("SEG",SEG,"SEQ",SEQ,FLD#) seg sequence number and field
 ;  Note: Add HL7 data type + sub components (leave value/code blank) 
 ;  Example: Institution Facility Type  = "CE^~FACILILITY TYPE~VA"
 ;    If the FIELD is a pointer and you want the lookup to be other
 ;    than the pointed to .01 set the 3rd piece = to the extended ref.
 ;    I.e., Parent Facility in the Association mult of Institution
 ;    points back to Institution, if we want to get facility using
 ;    station number (#99) instead of name (.01) set the 3rd piece
 ;    equal to ":99" giving us "CE^~FACILILITY TYPE~VA^:99".
 ;
 ;       Files involving sub-records and/or extended reference
 ;       -----------------------------------------------------
 ;       PARAM("SEG",SEG,"SEQ",SEQ,"FILE")       See FM documentation
 ;       PARAM("SEG",SEG,"SEQ",SEQ,"IENS")       $$GET1^DIQ() for value
 ;       PARAM("SEG",SEG,"SEQ",SEQ,"FIELD")      of FILE, IENS, & FIELD.
 ;
 ;       PARAM("SEG",SEG,"SEQ",SEQ,"DTYP")      HL7 data type (above)
 ;
 ;
 ; *** NOTE: OUTPUT in ^TMP("XUMF MFS",$J,"PARAM") ***
 ;
 ;       Example: MFE PKV is ^TMP("XUMF MFS",$J,"PARAM",IEN,"PKV")
 ;                    SEG    ^TMP("XUMF MFS",$J,"PARAM","SEG")
 ;
 ;       and another node is required for sub-file IENS for group
 ;       ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS",SEG,SEQ)=IENS
 ;
 ;       Use XUMFP4 as a template/example routine
 ;
 N QUERY,UPDATE,ALL,MFR,MFQ,HLFS,HLCS,GROUP,ARRAY,ROOT,NEW,I,J,CDSYS
 N PROTOCOL
 ;
 K ^TMP("XUMF MFS",$J)
 M ^TMP("XUMF MFS",$J,"PARAM")=PARAM
 ;
 S IEN=$G(IEN),IFN=$G(IFN)
 S TYPE=+$G(TYPE),ERROR=$G(ERROR)
 S UPDATE=$S(TYPE#2:0,1:1)
 S QUERY='UPDATE
 S GROUP=$S(UPDATE:0,TYPE[5:1,TYPE[7:1,1:0)
 S ARRAY=$S(UPDATE:0,TYPE[3:1,TYPE[7:1,1:0)
 S ALL=$S(IEN="ALL":1,1:0)
 S NEW=$S(IEN="NEW":1,1:0)
 S MFR=$S(UPDATE:0,TYPE>10:1,1:0)
 S MFQ=$S(UPDATE:0,'MFR:1,1:0)
 ;
 S PROTOCOL=$G(PARAM("PROTOCOL"))
 ;
 I 'IFN S ERROR="1^invalid IFN" Q
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
 ..S ^TMP("XUMF MFS",$J,"PARAM","IEN",J)=I
 ;
 ; -- get ALL file 'national' entries
 I ALL,'$D(^TMP("XUMF MFS",$J,"PARAM","IEN")),CDSYS="" D
 .S I=0 F  S I=$O(@ROOT@("XUMF","N",I)) Q:'I  D
 ..S ^TMP("XUMF MFS",$J,"PARAM","IEN",I)=""
 ;
 ; -- get ALL file
 I ALL,'$D(^TMP("XUMF MFS",$J,"PARAM","IEN")),CDSYS="" D
 .S I=0 F  S I=$O(@ROOT@(I)) Q:'I  D
 ..S ^TMP("XUMF MFS",$J,"PARAM","IEN",I)=""
 ;
 ;  *** insert code below ***
 ; insert file number in string below to add an additional file
 I "^4^4.1^5.12^5.13^730^5^45.7^4.11^49^9.8^"'[(U_IFN_U) S ERROR="1^file not supported" Q
 ;  *** end insert code ***
 ;
 ;    note: also create a subroutine for each supported file with
 ;             the file number as the line TAG (replace decimal point
 ;             of file number with the letter 'P').  This subroutine
 ;             calls an associated routine for the specific file.
 ;             This file should use the XUMFP namespace.
 ;
 I "^4^4.1^5.12^5.13^"[(U_IFN_U) D @("F"_$TR(IFN,".","P"))
 I "^730^5^4.11^49^9.8^"[(U_IFN_U) D ZL7
 ;
 K PARAM
 ;
 Q
 ;
F4 ; -- institution file
 ;
 D ^XUMFP4
 ;
 Q
 ;
F4P1 ; -- facility type file
 ;
 D ^XUMFPFT
 ;
 Q
 ;
F5P12 ; -- postal code file
 ;
 D ^XUMFP512
 ;
 Q
 ;
F5P13 ; -- county code file
 ;
 D ^XUMFP513
 ;
 Q
 ;
 ;  *** insert subroutine here for additional files ***
 ;
TAG ;D ^ROUTINE
 ;Q
 ;
 ;
ZL7 ; generic
 ;
 D ^XUMFPMFS
 ;
 Q
 ;
MFI(X) ; -- master file identifier function
 ;
 ;INPUT          X       master file indentifier (seq 1 MFI segment)
 ;OUTPUT         $$      IFN - Internal File Number or '0' for error
 ;
 Q:X="Z04" 4
 Q:X="Z4T" 4.1
 Q:$P(X,HLCS)="5P12" 5.12
 Q:$P(X,HLCS)="5P13" 5.13
 Q:X="ZNS" 730
 Q:X="ZAG" 4.11
 Q:X="Z05" 5
 Q:X="Z49" 49
 ;
 ; *** add code here for new files ***
 ;
 Q 0
 ;
DTYP(VALUE,TYP,HLCS,TOHL7) ;data type conversion
 ;INPUT
 ;   VALUE    value
 ;   TYP    HL7 data type
 ;   TOHL7   1=to HL7, 0=to FileMan
 ;OUTPUT
 ;   $$      formatted data
 ;
 N TEXT,CS
 S TYP=$G(TYP),VALUE=$G(VALUE),TOHL7=$G(TOHL7)
 Q:TYP="" VALUE Q:VALUE="" VALUE
 S TEXT=$P(TYP,U,2),TYP=$P(TYP,U)
 I TYP="ST"!(TYP="ID") Q VALUE
 I TYP="DT",TOHL7 D  Q $$HLDATE^HLFNC(VALUE)
 .N X,Y S X=VALUE D ^%DT S VALUE=+Y
 I TYP="DT" Q $$FMDATE^HLFNC(+VALUE)
 I TYP="ZST" D  Q VALUE
 .N IEN5 S IEN5=+$O(^DIC(5,"C",VALUE,""))
 .S:IEN5 VALUE=$P($G(^DIC(5,IEN5,0)),"^")
 I 'TOHL7 Q $P(VALUE,HLCS)
 Q VALUE_$TR(TEXT,"~",HLCS)
 ;
