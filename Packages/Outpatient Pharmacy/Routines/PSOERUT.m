PSOERUT ;ALB/MFR - eRx Utilities; 06/25/2022 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**692**;DEC 1997;Build 4
 ;
XML2GBL(XML,OUTARR)  ;,NMSPC) ; Transfers XML incoming data into a TMP Gobal
 ; Input: XML   - XML Message to be transferred to a Temp Global or Local Array
 ;        OUTARR - Output Array (Temp Global or Local Array, e.g. $NA(^TMP($J,"PSOERUT")), "XMLMSG", "MSG(""ERX"")", etc.
 ;Output: Parsed XML data in the Temp Global or Local Array
 ;
 ; Protecting from saving non-TEMP globals
 I $G(OUTARR)["^",$E(OUTARR,1,5)'="^TMP(",$E(OUTARR,1,6)'="^XTMP(" Q
 ;
 K @OUTARR
 N STATUS,READER,ARRDPTH,PRVDPTH,SEQ
 S PRVDPTH=0,ARRDPTH=$S(OUTARR[",":$L(OUTARR,","),OUTARR[")":1,1:0)
 S STATUS=##class(%XML.TextReader).ParseStream(XML,.READER)
 I $$STATCHK^XOBWLIB(STATUS,.XOBERR,1) D
 . F  Q:'READER.Read()!READER.EOF  D
 . . I (READER.Depth'<PRVDPTH),READER.LocalName'="" D
 . . . S SEQ=+$O(@$NA(@OUTARR@(READER.LocalName,999999)),-1)+1
 . . . S OUTARR=$NA(@OUTARR@(READER.LocalName,SEQ))
 . . E  S:READER.Depth<PRVDPTH OUTARR=$NA(@OUTARR,ARRDPTH+(READER.Depth*2))
 . . I (READER.Value'="") D
 . . . S @(OUTARR)=READER.Value
 . . S PRVDPTH=READER.Depth
 Q
