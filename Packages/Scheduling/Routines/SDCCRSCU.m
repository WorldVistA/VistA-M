SDCCRSCU ;CCRA/LB,PB - Appointment Message Parsing Utilities;APR 4, 2019
 ;;5.3;Scheduling;**707**;APR 4, 2019;Build 57
 ;;Per VA directive 6402, this routine should not be modified.
 Q
PARSE(FIELD,REP,COMP,SUBCOMP,ESCAPE,SEG,TO) ;
 ;Parses the segment stored in SEG(1),SEG(2),... into TO()
 ;Input:
 ;  FIELD - field separator
 ;  REP - field repetition separator
 ;  COMP - component separator
 ;  SUBCOMP - subcomponent separator
 ;  ESCAPE - escape character
 ;  SEG - (pass by reference) the array holding the unparsed segment.
 ;Output:
 ;  Function returns 1 on success, 0 on failure
 ;  TO - (pass by reference) - the parsed values
 ;  SEG- This input variable is deleted during the processing.  If it is needs to be retained, pass in a copy!
 ;
 N VALUE,CHAR,COUNTS
 K TO
 Q:$L($G(FIELD))'=1 0
 Q:$L($G(REP))'=1 0
 Q:$L($G(COMP))'=1 0
 Q:'$D(SUBCOMP) 0
 Q:'$D(SEG) 0
 S COUNTS("FIELD")=0
 S COUNTS("REP")=1
 S COUNTS("COMP")=1
 S COUNTS("SUBCOMP")=1
 S VALUE=""
 S SEG("LINE")=$O(SEG(0)),SEG("CHAR")=0
 F  S CHAR=$$NEXTCHAR(.SEG) D  Q:'$L(CHAR)
 .I '$L(CHAR) D  Q
 ..I $L(VALUE) S TO(COUNTS("FIELD"),COUNTS("REP"),COUNTS("COMP"),COUNTS("SUBCOMP"))=VALUE
 .E  I CHAR=FIELD D  Q
 ..I $L(VALUE) S TO(COUNTS("FIELD"),COUNTS("REP"),COUNTS("COMP"),COUNTS("SUBCOMP"))=$$DESCAPE(VALUE,.FIELD,.COMP,.SUBCOMP,.REP,.ESCAPE),VALUE=""
 ..S COUNTS("FIELD")=COUNTS("FIELD")+1,COUNTS("REP")=1,COUNTS("COMP")=1,COUNTS("SUBCOMP")=1
 .E  I CHAR=REP D  Q
 ..I $L(VALUE) S TO(COUNTS("FIELD"),COUNTS("REP"),COUNTS("COMP"),COUNTS("SUBCOMP"))=$$DESCAPE(VALUE,.FIELD,.COMP,.SUBCOMP,.REP,.ESCAPE),VALUE=""
 ..S COUNTS("REP")=COUNTS("REP")+1,COUNTS("COMP")=1,COUNTS("SUBCOMP")=1
 .E  I CHAR=COMP D  Q
 ..I $L(VALUE) S TO(COUNTS("FIELD"),COUNTS("REP"),COUNTS("COMP"),COUNTS("SUBCOMP"))=$$DESCAPE(VALUE,.FIELD,.COMP,.SUBCOMP,.REP,.ESCAPE),VALUE=""
 ..S COUNTS("COMP")=COUNTS("COMP")+1,COUNTS("SUBCOMP")=1
 .E  I CHAR=SUBCOMP D  Q
 ..I $L(VALUE) S TO(COUNTS("FIELD"),COUNTS("REP"),COUNTS("COMP"),COUNTS("SUBCOMP"))=$$DESCAPE(VALUE,.FIELD,.COMP,.SUBCOMP,.REP,.ESCAPE),VALUE=""
 ..S COUNTS("SUBCOMP")=COUNTS("SUBCOMP")+1
 .E  S VALUE=VALUE_CHAR
 S TO("SEGMENT TYPE")=$G(TO(0,1,1,1)),TO(0)=TO("SEGMENT TYPE")
 I (TO("SEGMENT TYPE")="BHS")!(TO("SEGMENT TYPE")="MSH") S TO("FIELD SEPARATOR")=FIELD
 Q 1
 ;
NEXTCHAR(SEG) ;
 ;returns the next character in the segment array
 ;
 Q:'SEG("LINE") ""
 N RET
 S SEG("CHAR")=SEG("CHAR")+1
 S RET=$E(SEG(SEG("LINE")),SEG("CHAR"))
 Q:RET]"" RET
 S SEG("LINE")=$O(SEG(SEG("LINE")))
 I SEG("LINE") S SEG("CHAR")=1 Q $E(SEG(SEG("LINE")))
 Q ""
 ;
DESCAPE(VALUE,FIELD,COMP,SUBCOMP,REP,ESCAPE) ;
 ;Replaces the escape sequences with the corresponding encoding character and returns the result as the function value
 ;
 Q:ESCAPE="" VALUE
 N NEWSTRNG,SUBSTRNG,SET,LEN,I,SUBLEN,CHAR
 S (NEWSTRNG,SUBSTRNG,SUBLEN)=""
 S SET="FSTRE"
 S LEN=$L(VALUE)
 F I=1:1:LEN S SUBSTRNG=SUBSTRNG_$E(VALUE,I),SUBLEN=SUBLEN+1 D:SUBLEN=3
 .S CHAR=$E(SUBSTRNG,2)
 .I $E(SUBSTRNG,1)=ESCAPE,$E(SUBSTRNG,3)=ESCAPE,SET[CHAR D
 ..I CHAR="F" S NEWSTRNG=NEWSTRNG_FIELD,SUBSTRNG="",SUBLEN=0 Q
 ..I CHAR="S" S NEWSTRNG=NEWSTRNG_COMP,SUBSTRNG="",SUBLEN=0 Q
 ..I CHAR="T" S NEWSTRNG=NEWSTRNG_SUBCOMP,SUBSTRNG="",SUBLEN=0 Q
 ..I CHAR="R" S NEWSTRNG=NEWSTRNG_REP,SUBSTRNG="",SUBLEN=0 Q
 ..I CHAR="E" S NEWSTRNG=NEWSTRNG_ESCAPE,SUBSTRNG="",SUBLEN=0 Q
 .E  S NEWSTRNG=NEWSTRNG_$E(SUBSTRNG),SUBSTRNG=$E(SUBSTRNG,2,3),SUBLEN=2
 Q NEWSTRNG_SUBSTRNG
 ;
GETCODE(SEG,VALUE,FIELD,COMP,REP) ;
 ;Implements GETCNE and GETCWE
 ;
 N SUB,VAR
 Q:'$G(FIELD)
 I '$G(COMP) D
 .S VAR="COMP",SUB=1
 E  D
 .S VAR="SUB"
 S:'$G(REP) REP=1
 S @VAR=1,VALUE("ID")=$$GET(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=2,VALUE("TEXT")=$$GET(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=3,VALUE("SYSTEM")=$$GET(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=4,VALUE("ALTERNATE ID")=$$GET(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=5,VALUE("ALTERNATE TEXT")=$$GET(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=6,VALUE("ALTERNATE SYSTEM")=$$GET(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=7,VALUE("SYSTEM VERSION")=$$GET(.SEG,FIELD,COMP,SUB,REP)
 S @VAR=8,VALUE("ALTERNATE SYSTEM VERSION")=$$GET(.SEG,FIELD,COMP)
 S @VAR=9,VALUE("ORIGINAL TEXT")=$$GET(.SEG,FIELD,COMP,SUB,REP)
 Q
 ;
GET(SEG,FIELD,COMP,SUBCOMP,REP) ;
 ;This function gets a specified value from a segment that was parsed by
 ;$$NEXTSEG. The FIELD,COMP,SUBCOMP,REP parameters are optional - if not
 ;specified, they default to 1.
 ;  Example:
 ;    $$GET(.SEG,1) will return the value of the first field, first
 ;  component, first subcomponent, in the first occurrence of field #1.  
 ;Input:
 ;SEG - (required, pass by reference) - this is the array where the parsed segment was placed by $$NEXTSEG
 ;FIELD - the sequence # of the field (optional, defaults to 1)
 ;COMP - the # of the component (optional, defaults to 1)
 ;SUBCOMP - the # of the subcomponent (optional, defaults to 1)
 ;REP - the occurrence# (optional, defaults to 1)  For a non-repeating field, the occurrence # need not be provided, because it would be 1.
 ;Output:
 ;  Function returns the requested value on success, "" if not valued.
 ;
 ;allow the segment type to be obtained via field #0 (shorthand)
 I $D(FIELD),$G(FIELD)=0 Q $G(SEG("SEGMENT TYPE"))
 S:'$G(FIELD) FIELD=1
 ;
 ;for MSH or BHS, SEQ#1 is the  field separator
 I FIELD=1,$G(SEG("SEGMENT TYPE"))="MSH"!($G(SEG("SEGMENT TYPE"))="BHS"),$G(REP)<2,$G(COMP)<2,$G(SUBCOMP)<2 Q SEG("FIELD SEPARATOR")
 I FIELD=1,$G(SEG("SEGMENT TYPE"))="MSH"!($G(SEG("SEGMENT TYPE"))="BHS") Q ""
 ;
 S:'$G(COMP) COMP=1
 S:'$G(SUBCOMP) SUBCOMP=1
 S:'$G(REP) REP=1
 Q $G(SEG(FIELD,REP,COMP,SUBCOMP))
 ;
PARSEHDR(HDR) ;
 ;Parses the segment (HDR, pass by reference) into the HDR() array using meaningful subscripts.
 ;Input:
 ;  HDR (pass by reference, required) contains the segment in the format HDR(1),HDR(2), etc..
 ;Output:
 ;  HDR (pass by reference, required) This array will contain all the individual values.  Also will contain HDR(1) with components 1-6 and HDR(2) with components 1-end
 ;  Function - returns 1 if the segment is indeed an MSH or BHS segment, 0 otherwise
 ;
ZB25 ;
 N VALUE,FS,CS,REP,SUBCOMP,ESCAPE
 S VALUE=$E(HDR(1),1,3)
 I VALUE'="MSH",VALUE'="BHS" Q 0
 S HDR("SEGMENT TYPE")=VALUE
 S FS=$E(HDR(1),4)
 Q:FS="" 0
 S HDR("ENCODING CHARACTERS")=$P(HDR(1),FS,2)
 S CS=$E(HDR("ENCODING CHARACTERS"),1)
 S REP=$E(HDR("ENCODING CHARACTERS"),2)
 S ESCAPE=$E(HDR("ENCODING CHARACTERS"),3)
 S SUBCOMP=$E(HDR("ENCODING CHARACTERS"),4)
 Q:REP="" 0
 S HDR("FIELD SEPARATOR")=FS
 S HDR("COMPONENT SEPARATOR")=CS
 S HDR("REPETITION SEPARATOR")=REP
 S HDR("ESCAPE CHARACTER")=ESCAPE
 S HDR("SUBCOMPONENT SEPARATOR")=SUBCOMP
 S HDR("SENDING APPLICATION")=$$DESCAPE($P($P(HDR(1),FS,3),CS))
 S VALUE=$P(HDR(1),FS,4)
 S HDR("SENDING FACILITY",1)=$$DESCAPE($P(VALUE,CS))
 S HDR("SENDING FACILITY",2)=$$DESCAPE($P(VALUE,CS,2))
 S HDR("SENDING FACILITY",3)=$$DESCAPE($P(VALUE,CS,3))
 S HDR("RECEIVING APPLICATION")=$$DESCAPE($P($P(HDR(1),FS,5),CS))
 S VALUE=$P(HDR(1),FS,6)
 S HDR("RECEIVING FACILITY",1)=$$DESCAPE($P(VALUE,CS))
 S HDR("RECEIVING FACILITY",2)=$$DESCAPE($P(VALUE,CS,2))
 S HDR("RECEIVING FACILITY",3)=$$DESCAPE($P(VALUE,CS,3))
 S HDR("DT/TM OF MESSAGE")=$$FMDATE^HLFNC($$DESCAPE($P($P(HDR(2),FS,2),CS)))
 S HDR("SECURITY")=$$DESCAPE($P($P(HDR(2),FS,3),CS))
 ;
 I HDR("SEGMENT TYPE")="MSH" D
 .S VALUE=$P(HDR(2),FS,4)
 .S HDR("MESSAGE TYPE")=$P(VALUE,CS)
 .S HDR("EVENT")=$P(VALUE,CS,2)
 .S HDR("MESSAGE STRUCTURE")=$$DESCAPE($P(VALUE,CS,3))
 .S HDR("MESSAGE CONTROL ID")=$$DESCAPE($P($P(HDR(2),FS,5),CS))
 .S VALUE=$P(HDR(2),FS,6)
 .S HDR("PROCESSING ID")=$P(VALUE,CS)
 .S HDR("PROCESSING MODE")=$$DESCAPE($P(VALUE,CS,2))
 .S HDR("VERSION")=$$DESCAPE($P($P(HDR(2),FS,7),CS))
 .S HDR("CONTINUATION POINTER")=$$DESCAPE($P($P(HDR(2),FS,9),CS))
 .S HDR("ACCEPT ACK TYPE")=$P($P(HDR(2),FS,10),CS)
 .S HDR("APP ACK TYPE")=$P($P(HDR(2),FS,11),CS)
 .S HDR("COUNTRY")=$$DESCAPE($P($P(HDR(2),FS,12),CS))
 ;
 I HDR("SEGMENT TYPE")="BHS" D
 .S VALUE=$P(HDR(2),FS,4)
 .S HDR("BATCH NAME/ID/TYPE")=$$DESCAPE(VALUE)
 .S HDR("PROCESSING ID")=$E($P(VALUE,"PROCESSING ID=",2),1)
 .S HDR("ACCEPT ACK TYPE")=$E($P(VALUE,"ACCEPT ACK TYPE=",2),1,2)
 .S HDR("APP ACK TYPE")=$E($P(VALUE,"APP ACK TYPE=",2),1,2)
 .S HDR("BATCH COMMENT")=$$DESCAPE($P(HDR(2),FS,5))
 .S HDR("BATCH CONTROL ID")=$$DESCAPE($P($P(HDR(2),FS,6),CS))
 .S HDR("REFERENCE BATCH CONTROL ID")=$$DESCAPE($P($P(HDR(2),FS,7),CS))
 .;
ZB26 ;
 Q 1
 ;
PARSESEG(SEG,DATA,HL) ;Generic segment parser
 ;This procedure parses a single HL7 segment and builds an array
 ;subscripted by the field number containing the data for that field.
 ; Does not handle segments that span nodes
 ;
 ;  Input:
 ;     SEG - HL7 segment to parse
 ;      HL - HL7 environment array
 ;
 ;  Output:
 ;    Function value - field data array [SUB1:field, SUB2:repetition,
 ;                                SUB3:component, SUB4:sub-component]
 ;
 N CMP     ;component subscript
 N CMPVAL  ;component value
 N FLD     ;field subscript
 N FLDVAL  ;field value
 N REP     ;repetition subscript
 N REPVAL  ;repetition value
 N SUB     ;sub-component subscript
 N SUBVAL  ;sub-component value
 N FS      ;field separator
 N CS      ;component separator
 N RS      ;repetition separator
 N SS      ;sub-component separator
 N ES      ;escape character
 ;
 K DATA
 S FS=$G(HL("FS"),"|") S:FS="" FS="|"
 S CS=$E($G(HL("ECH")),1) S:CS="" CS="^"
 S RS=$E($G(HL("ECH")),2) S:RS="" RS="~"
 S ES=$E($G(HL("ECH")),3) S:ES="" ES="\"
 S SS=$E($G(HL("ECH")),4) S:SS="" SS="&"
 ;
 S DATA(0)=$P(SEG,FS)
 S SEG=$P(SEG,FS,2,9999)
 ;
 F FLD=1:1:$L(SEG,FS) D
 . S FLDVAL=$P(SEG,FS,FLD)
 . F REP=1:1:$L(FLDVAL,RS) D
 . . S REPVAL=$P(FLDVAL,RS,REP)
 . . I REPVAL[CS F CMP=1:1:$L(REPVAL,CS) D
 . . . S CMPVAL=$P(REPVAL,CS,CMP)
 . . . I CMPVAL[SS F SUB=1:1:$L(CMPVAL,SS) D
 . . . . S SUBVAL=$P(CMPVAL,SS,SUB)
 . . . . I SUBVAL'="" S DATA(FLD,REP,CMP,SUB)=SUBVAL
 . . . I '$D(DATA(FLD,REP,CMP)),CMPVAL'="" S DATA(FLD,REP,CMP)=CMPVAL
 . . I '$D(DATA(FLD,REP)),REPVAL'="",FLDVAL[RS S DATA(FLD,REP)=REPVAL
 . I '$D(DATA(FLD)),FLDVAL'="" S DATA(FLD)=FLDVAL
 Q
INP ; set up the INP array for calling ARSET^SDECAR2 to update the RTC orders
 ; Need to add code to add the rtcparent to the HL7 message and to parse it out. 
 ;D APPERROR^%ZTER("SDHL7APU 196")
 N NODE3,INTV,NUMAPTS,ORDATE,CONSID1,ORDNUM
 S CONSID1=$P(SDAPTYP,"|",2) S:$G(CONSID1)>0 SDDDT=$P(^GMR(123,CONSID1,0),"^",24),ORDNUM=$P(^GMR(123,CONSID1,0),"^",3)
 K INP
 S INP(1)="" ; This is a new request so this is always null for a new request
 S INP(2)=$G(SDDFN)
 D NOW^%DTC N NOW S NOW=$$HTFM^XLFDT($H),INP(3)=$$FMTE^XLFDT(NOW)
 ;S INP(3)=$G(ORDATE)
 ;NEEDS THE TEXT INSTITUTION NAME
 S INP(4)=$$NAME^XUAF4(+$G(DUZ(2))) ;Required, DUZ(2) is the signed on users division they are signed into, +DUZ(2) is the parent station number
 S INP(5)="APPT"
 S INP(6)=$G(SDCL)
 S INP(8)="FUTURE"
 S INP(9)="PROVIDER"
 S INP(11)=$G(SDDDT) ; Clinically Indicate Date for first appointment in the sequence, each of the remaining appointments have to be calculated
 S INP(12)=$G(SDECNOTE)
 S PCE="" S PCE=$P($G(^DPT(SDDFN,"ENR")),U,1) I PCE'="" D
 .S INP(13)=$$GET1^DIQ(27.11,PCE,.07,"E")
 ;S INP(13)="" ;Enrollment priority will be null for TMP
 S INP(14)=""
 S INP(17)="" ;null for TMP
 S SCPERC=0
 S SCPERC=$P(^DPT($G(INP(2)),.3),"^",2)
 S INP(19)=SCPERC
 S INP(22)="9"
 S INP(23)="NEW"
 S INP(28)=$G(ORDNUM)
 K SCPERC,PCE
 Q
