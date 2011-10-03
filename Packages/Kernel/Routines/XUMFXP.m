XUMFXP ;ISS/RAM - Master File Parameters ; 10/11/02 2:50pm
 ;;8.0;KERNEL;**299**;Jul 10, 1995
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
 ;       PARAM("CDSYS")          Coding System - if mult cod sys for
 ;                               table - use XUMFIDX x-ref for CDSYS
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
 ;                                 if MFAI contains TEMP do not store
 ;                                 values in FileMan but parse into
 ;                                 ^TEMP("XUMF ARRAY",$J, global
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
 ;       segment(s) parameters
 ;       -------------------------
 ;       PARAM("SEQ",SEQ,FLD#)=hl7_dataType
 ;    If the FIELD is a pointer add ":" + extended reference
 ;    lookup field (if other than .01) after HL7 data type.
 ;
 ;       Files involving sub-records and/or extended reference
 ;       -----------------------------------------------------
 ;       PARAM("SEQ",SEQ,"FILE")       See FM documentation
 ;       PARAM("SEQ",SEQ,"IENS")       $$GET1^DIQ() for value
 ;       PARAM("SEQ",SEQ,"FIELD")      of FILE, IENS, & FIELD.
 ;
 ;       PARAM("SEQ",SEQ,"DTYP")      HL7 data type
 ;       PRAAM("SEQ",SEQ,"LKUP")      extended reference lookup field
 ;
 ;       and another node is required for sub-file IENS for group
 ;       ^TMP("XUMF MFS",$J,"PARAM",IEN,"IENS",SEQ)=IENS
 ;
 ;       NOTE: OUTPUT in ^TMP("XUMF MFS",$J,"PARAM")
 ;
 ;       Example: MFE PKV is ^TMP("XUMF MFS",$J,"PARAM",IEN,"PKV")
 ;
 ;
 N QUERY,UPDATE,ALL,MFR,MFQ,HLFS,HLCS,GROUP,ARRAY,ROOT,NEW,I,J,CDSYS
 N PROTOCOL,MFK
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
 S MFK=$S(TYPE=10:1,1:0)
 ;
 Q:MFK
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
 .S I=0 F  S I=$O(@ROOT@("AVUID",I)) Q:'I  D
 ..S J=$O(@ROOT@("AVUID",I,0))
 ..S ^TMP("XUMF MFS",$J,"PARAM","IEN",J)=I
 ;
 ; -- get ALL file
 I ALL,'$D(^TMP("XUMF MFS",$J,"PARAM","IEN")),CDSYS="" D
 .S I=0 F  S I=$O(@ROOT@(I)) Q:'I  D
 ..S ^TMP("XUMF MFS",$J,"PARAM","IEN",I)=""
 ;
 I '$D(^DIC(4.001,+IFN)) S ERROR="1^file not supported" Q
 ;
 D MAIN^XUMFXP1
 ;
 K PARAM
 ;
 Q
 ;
 ;
DTYP(VALUE,TYP,HLCS,TOHL7,TIMEZONE) ;data type conversion
 ;INPUT
 ;   VALUE    value
 ;   TYP    HL7 data type
 ;   TOHL7   1=to HL7, 0=to FileMan
 ;OUTPUT
 ;   $$      formatted data
 ;
 N TEXT,CS
 S TYP=$G(TYP),VALUE=$G(VALUE)
 S TOHL7=$G(TOHL7),TIMEZONE=$G(TIMEZONE)
 Q:TYP="" VALUE Q:VALUE="" VALUE
 S TEXT=$P(TYP,U,2),TYP=$P(TYP,U)
 I TYP="ST"!(TYP="ID") Q VALUE
 I TYP="DT",TOHL7 D  Q $$HLDATE^HLFNC(VALUE)
 .N X,Y S X=VALUE D ^%DT S VALUE=+Y
 I TYP="DT",$E(VALUE,1,4)="0000" Q $$NOW^XLFDT
 I TYP="DT" Q $$HL7TFM^XLFDT(+VALUE,TIMEZONE)
 I TYP="ZST" D  Q VALUE
 .N IEN5 S IEN5=+$O(^DIC(5,"C",VALUE,""))
 .S:IEN5 VALUE=$P($G(^DIC(5,IEN5,0)),"^")
 I 'TOHL7 Q $P(VALUE,HLCS)
 Q VALUE_$TR(TEXT,"~",HLCS)
 ;
