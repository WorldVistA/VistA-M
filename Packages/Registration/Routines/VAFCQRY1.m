VAFCQRY1 ;BIR/DLR-Query for patient demographics ;7/19/21  10:44
 ;;5.3;Registration;**428,474,477,575,627,648,698,711,707,837,874,937,974,981,1059**;Aug 13, 1993;Build 6
 ;
 ;Reference to $$GETDFNS^MPIF002 supported by IA #3634.
 ;
BLDPID(DFN,CNT,SEQ,PID,HL,ERR) ;build PID from File #2
 ; Variable list
 ;  DFN - internal PATIENT (#2) number
 ;  CNT - value to be place in PID seq#1 (SET ID)
 ;  SEQ - variable consisting of sequence numbers delimited by commas
 ;        that will be used to build the message (default is ALL)
 ;  PID (passed by reference) - array location to place PID segment
 ;        result, the array can have existing values when passed.
 ;   HL - array that contains the necessary HL variables (init^hlsub)
 ;  ERR - array that is used to return an error
 ;
 ; DG*5.3*981 introduced changes to support the local modifications for HAC/MVI integration in CH*1.3*22529.
 ;
 N VAFCMN,VAFCMMN,SITE,VAFCZN,SSN,SITE,APID,HIST,HISTDT,VAFCHMN,NXT,NXTC,COMP,REP,SUBCOMP,STATE,CITY,CLAIM,HLECH,HLFS,HLQ,STATEIEN,SARY,LVL,LNGTH,X,STN,SITA,HLES
 I '$D(SEQ) S SEQ="ALL"
 I SEQ="" S SEQ="ALL"
 I SEQ'="ALL" D
 .; setting up temp array to hold fields to be included in message
 .N POS,EN S POS=1 F  S EN=$P(SEQ,",",POS) Q:EN=""  S SARY(EN)="",POS=POS+1
 S HLECH=HL("ECH"),HLFS=HL("FS"),HLQ=HL("Q"),(COMP,HL("COMP"))=$E(HL("ECH"),1)
 S (SUBCOMP,HL("SUBCOMP"))=$E(HL("ECH"),4),(REP,HL("REP"))=$E(HL("ECH"),2),HLES=$E(HL("ECH"),3)
 ;get Patient File MPI node
 S VAFCMN=""
 N X S X="MPIFAPI" X ^%ZOSF("TEST") I $T S VAFCMN=$$MPINODE^MPIFAPI(DFN)
 I +VAFCMN<0 S VAFCMN=""
 S VAFCZN=^DPT(DFN,0),SSN=$P(^DPT(DFN,0),"^",9)
 ;**974,Story 841921 (mko): Get the internal Alias values instead of external
 ;  so that the internal pointer (IEN) of the Name Components entry can be retrieved.
 ;  In the following code, values are obtained from the "I" nodes instead of the "E" nodes.
 N VAFCA,VAFCA1 D GETS^DIQ(2,DFN_",","1*","I","VAFCA") ;**698 GETTING ALIAS INFO
 ;** 707 reformat alias information to include ALIAS SSN in PID-3 with a location reference to the name in PID-5
 I $D(VAFCA) N CT,ENT S CT=0,ENT="" F  S ENT=$O(VAFCA(2.01,ENT)) Q:ENT=""  D
 .S CT=CT+1
 .S VAFCA1(CT,"NAME")=$G(VAFCA(2.01,ENT,.01,"I"))
 .;I $G(VAFCA(2.01,ENT,1,"E"))'="" S VAFCA1("SSN")="",VAFCA1(CT,"SSN")=$G(VAFCA(2.01,ENT,1,"E"))
 .S VAFCA1(CT,"SSN")=$G(VAFCA(2.01,ENT,1,"I"))
 .S VAFCA1(CT,"NCIEN")=$G(VAFCA(2.01,ENT,100.03,"I"))_"^"_ENT ;**974,Story 841921 (mko): Get Name Components pointer and save IENS of Alias subentry
 ;custom change - if current site is HAC then use station number 741MM - CH*1.3*22529
 S SITE=$$SITE^VASITE,STN=$P($$SITE^VASITE,"^",3) I STN=741 S STN="741MM"
 N TMP F TMP=1:1:31 S APID(TMP)=""
 S APID(2)=CNT
 ;list of fields used for backwards compatibility with HDR
 I $D(SARY(2))!(SEQ="ALL") I VAFCMN'="" S APID(3)=$P(VAFCMN,"^")_"V"_$P(VAFCMN,"^",2)  ;Patient ID
 ;repeat patient ID list including ICN (NI),SSN (SS),CLAIM# (PN) and DFN (PI)
 I $D(SARY(3))!(SEQ="ALL") D
 .S APID(4)=""
 .;National Identifier (ICN)
 .I VAFCMN'="",+VAFCMN>0 D
 ..I $E($P(VAFCMN,"^"),1,3)=STN S SITA=STN
 ..; custom change - if current site is HAC then use station number 741MM - CH*1.3*22529
 ..I $E($P(VAFCMN,"^"),1,3)=+STN I +STN="741" S SITA=+STN I SITA=741 S SITA="741MM"
 ..I $E($P(VAFCMN,"^"),1,3)'=+STN S SITA="200M" ; **707 update assigning authority for national ICNs to 200M for MPI
 ..S APID(4)=$P(VAFCMN,"^")_"V"_$P(VAFCMN,"^",2)_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"0363"_COMP_"NI"_COMP_"VA FACILITY ID"_SUBCOMP_SITA_SUBCOMP_"L" D
 ..;Assumption that if this is a local ICN at this point send the message with an expiration date of today, so that it will be treated as a deprecated ID and stored on the MPI as such
 ..I $E($P(VAFCMN,"^"),1,3)=STN S APID(4)=APID(4)_COMP_COMP_$$HLDATE^HLFNC(DT,"DT") ;**707 TO ONLY SEND DATE NO TIME
 .I $G(SSN)'="" S APID(4)=APID(4)_$S(APID(4)'="":REP,1:"")_SSN_COMP_COMP_COMP_"USSSA"_SUBCOMP_SUBCOMP_"0363"_COMP_"SS"_COMP_"VA FACILITY ID"_SUBCOMP_STN_SUBCOMP_"L"
 .S NXTC=0,LVL=0 ;**837,MVI_879: Move here, so that LVL gets set before pulling in TIN and FIN
 .;**837,MVI_879: Get TIN and FIN from Patient file and put in PID-3
 .;**1059, VAMPI-11120 (dri) Get ITIN from Patient file and put in PID-3
 .N TIN,FIN,ITIN,REF
 .S TIN=$P(VAFCMN,"^",8),FIN=$P(VAFCMN,"^",9),ITIN=$P(VAFCMN,"^",11),REF=$NA(APID(4))
 .D ADDLINE($S(TIN="":HLQ,1:TIN)_COMP_COMP_COMP_"USDOD"_SUBCOMP_SUBCOMP_"0363"_COMP_"TIN"_COMP_"VA FACILITY ID"_SUBCOMP_STN_SUBCOMP_"L",.LVL,REF,REP)
 .D ADDLINE($S(FIN="":HLQ,1:FIN)_COMP_COMP_COMP_"USDOD"_SUBCOMP_SUBCOMP_"0363"_COMP_"FIN"_COMP_"VA FACILITY ID"_SUBCOMP_STN_SUBCOMP_"L",.LVL,REF,REP)
 .D ADDLINE($S(ITIN="":HLQ,1:ITIN)_COMP_COMP_COMP_"USIRS"_SUBCOMP_SUBCOMP_"0363"_COMP_"NI"_COMP_"VA FACILITY ID"_SUBCOMP_STN_SUBCOMP_"L",.LVL,REF,REP)
 .I $G(DFN)'="" D
 ..D ADDLINE(DFN_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"0363"_COMP_"PI"_COMP_"VA FACILITY ID"_SUBCOMP_STN_SUBCOMP_"L",.LVL,REF,REP)
 ..;CLAIM# **707 moved dfn and claim number up here since Alias SSN could be many
 ..I $D(^DPT(DFN,.31)) S CLAIM=$P(^DPT(DFN,.31),"^",3) I +CLAIM>0 D ADDLINE(CLAIM_COMP_COMP_COMP_"USVBA"_SUBCOMP_SUBCOMP_"0363"_COMP_"PN"_COMP_"VA FACILITY ID"_SUBCOMP_STN_SUBCOMP_"L",.LVL,REF,REP)
 .I $D(VAFCA1) D
 ..;Have Alias SSNs
 ..S CT=0 F  S CT=$O(VAFCA1(CT)) Q:+CT<1  D
 ...S NXT=$S($G(VAFCA1(CT,"SSN"))="":HL("Q"),1:$G(VAFCA1(CT,"SSN")))_COMP_COMP_COMP_"USSSA"_SUBCOMP_SUBCOMP_"0363"_COMP_"SS"_COMP_"VA FACILITY ID"_SUBCOMP_STN_SUBCOMP_"L"_COMP_COMP_$$HLDATE^HLFNC(DT,"DT")
 ...I LVL=0 D
 ....I $L(APID(4)_NXT)'>244 S APID(4)=APID(4)_REP_NXT Q
 ....I $L(APID(4)_NXT)>244 S LVL=1 S LNGTH=244-$L(APID(4)),APID(4)=APID(4)_REP_$E(NXT,1,LNGTH) S LNGTH=LNGTH+1,NXT=$E(NXT,LNGTH,$L(NXT)),NXTC=1
 ...I LVL>0 D
 ....I $L($G(APID(4,LVL))_NXT)'>245 S APID(4,LVL)=$G(APID(4,LVL))_$S(NXTC=0:REP,1:"")_NXT Q
 ....I $L($G(APID(4,LVL))_NXT)>245 S LNGTH=244-$L(APID(4,LVL)),APID(4,LVL)=APID(4,LVL)_REP_$E(NXT,1,LNGTH) S LNGTH=LNGTH+1,NXT=$E(NXT,LNGTH,$L(NXT)) S LVL=LVL+1 S APID(4,LVL)=NXT
 ...I NXTC=1 S NXTC=0
 .I $D(^DPT(DFN,"MPIFHIS")) N HIST S HIST=0  F  S HIST=$O(^DPT(DFN,"MPIFHIS",HIST)) Q:'HIST  S VAFCHMN=^DPT(DFN,"MPIFHIS",HIST,0) S HISTDT=$P(VAFCHMN,"^",4) D
 ..;**477 due to a timing issue if checksum and D/T of deprecation of ICN is not present hang two seconds and try again if still not able to get ICN set D/T to DT
 ..I $G(HISTDT)="" H 2 S VAFCHMN=^DPT(DFN,"MPIFHIS",HIST,0) S HISTDT=$P(VAFCHMN,"^",4) I HISTDT="" S HISTDT=DT
 ..I APID(4)'="" D
 ...; custom change - if current site is HAC then use station number 741MM - CH*1.3*22529
 ...I $E($P(VAFCHMN,"^"),1,3)=+STN S SITA=+STN I SITA=741 S SITA="741MM"
 ...I $E($P(VAFCHMN,"^"),1,3)'=+STN S SITA="200M" ; **707 update assigning authority for national ICNs to 200M for MPI
 ...S NXT=$P(VAFCHMN,"^")_"V"_$P(VAFCHMN,"^",2)_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"0363"_COMP_"NI"_COMP_"VA FACILITY ID"_SUBCOMP_SITA_SUBCOMP_"L"_COMP_COMP_$$HLDATE^HLFNC(HISTDT,"DT") ;**648 only send date not time
 ...I LVL=0 D
 ....I $L(APID(4)_NXT)'>244 S APID(4)=APID(4)_REP_NXT Q
 ....I $L(APID(4)_NXT)>244 S LVL=1 S LNGTH=244-$L(APID(4)),APID(4)=APID(4)_REP_$E(NXT,1,LNGTH) S LNGTH=LNGTH+1,NXT=$E(NXT,LNGTH,$L(NXT)),NXTC=1
 ...I LVL>0 D
 ....I $L($G(APID(4,LVL))_NXT)'>245 S APID(4,LVL)=$G(APID(4,LVL))_$S(NXTC=0:REP,1:"")_NXT Q
 ....I $L($G(APID(4,LVL))_NXT)>245 S LNGTH=244-$L(APID(4,LVL)),APID(4,LVL)=APID(4,LVL)_REP_$E(NXT,1,LNGTH) S LNGTH=LNGTH+1,NXT=$E(NXT,LNGTH,$L(NXT)) S LVL=LVL+1 S APID(4,LVL)=NXT
 ..I NXTC=1 S NXTC=0
 ..I APID(4)="" D
 ...; custom change - if current site is HAC then use station number 741MM - CH*1.3*22529
 ...I $E($P(VAFCHMN,"^"),1,3)=+STN S SITA=+STN I SITA=741 S SITA="741MM"
 ...I $E($P(VAFCHMN,"^"),1,3)'=+STN S SITA="200M"
 ...S APID(4)=$P(VAFCHMN,"^")_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"0363"_COMP_"NI"_COMP_"VA FACILITY ID"_SUBCOMP_SITA_SUBCOMP_"L"_COMP_COMP_$$HLDATE^HLFNC(HISTDT,"DT") ;**707 ONLY DATE NOT TIME
 ;
ALTID ;**874 MVI_3035 (elz) alternate ID
 I $D(SARY(4))!(SEQ="ALL") D
 . S REF=$NA(APID(5)),@REF="",LVL=0
 . I $G(DFN) D
 .. ;VIC card number, station 742V1
 .. N VAVICF,VAVICX,VAVIC,X
 .. S VAVICF=+$$LKUP^XUAF4("742V1")
 .. S VAVICX=0 F  S VAVICX=$O(^DGCN(391.91,"APAT",DFN,VAVICF,VAVICX)) Q:'VAVICX  D
 ... F X=0,2 S VAVIC(X)=$G(^DGCN(391.91,VAVICX,X))
 ... I $P(VAVIC(2),"^",2),$P(VAVIC(2),"^",3)'="H",$L($P(VAVIC(2),"^")),$L($P(VAVIC(0),"^",9)) D
 .... D ADDLINE($P(VAVIC(2),"^",2)_COMP_COMP_COMP_$P(VAVIC(2),"^")_SUBCOMP_SUBCOMP_"0363"_COMP_$P(VAVIC(0),"^",9)_COMP_"VA FACILITY ID"_SUBCOMP_"742V1"_SUBCOMP_"L",.LVL,REF,REP)
 ;
NAMEPID ;patient name (last^first^middle^suffix^prefix^^"L" for legal)
 I $D(SARY(5))!(SEQ="ALL") D
 .;**711 code REMOVED PREFIX due to issues with existing PATIENT Name Standardization functionality
 .N X S X=$P(VAFCZN,"^") D NAME^VAFCPID2(DFN,.X) S APID(6)=$$HLNAME^XLFNAME(X,"",$E(HL("ECH"),1)) I $P(APID(6),$E(HL("ECH"),1),7)'="L" S $P(APID(6),$E(HL("ECH"),1),7)="L"
PREFNAME .; Story 455447 (elz)DG*5.3*937 Preferred Name (^preferred name^^^^^"N" for nickname)
 .N PREFNAM S PREFNAM=$P($G(^DPT(DFN,.24)),"^",5)
 .D HL7TXT(.PREFNAM,.HL,HLES) S APID(6)=APID(6)_$S(APID(6)]"":REP,1:"")_$S(PREFNAM]"":PREFNAM,1:"""""")_COMP_COMP_COMP_COMP_COMP_COMP_"N"
ALIAS .;patient alias (last^first^middle^suffice^prefix^^"A" for alias - can be multiple)
 .N ALIAS,ALIEN,LVL6,NXTC,LNGTH S NXTC=0,LVL6=0
 .I $D(VAFCA1) S ALIEN=0 F  S ALIEN=$O(VAFCA1(ALIEN)) Q:'ALIEN  D
 ..;**974,Story 841921 (mko): Get the Name Components themselves
 ..;  rather than parsing them out of the Name field
 ..I $G(VAFCA1(ALIEN,"NCIEN"))>0 D
 ...N NAMEC
 ...S NAMEC("FILE")=2.01,NAMEC("IENS")=$P(VAFCA1(ALIEN,"NCIEN"),"^",2),NAMEC("FIELD")=.01
 ...S ALIAS=$$HLNAME^XLFNAME(.NAMEC,"",$E(HL("ECH")))
 ..E  S ALIAS=$$HLNAME^XLFNAME(VAFCA1(ALIEN,"NAME"),"",$E(HL("ECH"),1))
 ..Q:ALIAS=""
 ..S $P(ALIAS,$E(HL("ECH"),1),7)="A"
 ..I LVL6=0 D
 ...I $L(APID(6)_ALIAS)'>244 S APID(6)=APID(6)_REP_ALIAS Q
 ...I $L(APID(6)_ALIAS)>244 S LVL6=1 S LNGTH=244-$L(APID(6)),APID(6)=APID(6)_REP_$E(ALIAS,1,LNGTH) S LNGTH=LNGTH+1,ALIAS=$E(ALIAS,LNGTH,$L(ALIAS)),NXTC=1
 ..I LVL6>0 D
 ...I $L($G(APID(6,LVL6))_ALIAS)'>245 S APID(6,LVL6)=$G(APID(6,LVL6))_$S(NXTC=0:REP,1:"")_ALIAS Q
 ...I $L($G(APID(6,LVL6))_ALIAS)>245 S LNGTH=244-$L(APID(6,LVL6)),APID(6,LVL6)=APID(6,LVL6)_REP_$E(ALIAS,1,LNGTH) S LNGTH=LNGTH+1,ALIAS=$E(ALIAS,LNGTH,$L(ALIAS)) S LVL6=LVL6+1 S APID(6,LVL6)=ALIAS
 ..I NXTC=1 S NXTC=0
 . I APID(6)="" S APID(6)=HL("Q")
MOTHER ;mother's maiden name  (last^first^middle^suffix^prefix^^"M" for maiden name)
 I $D(SARY(6))!(SEQ="ALL") D
 .S APID(7)=HL("Q")
 .I $D(^DPT(DFN,.24)) S VAFCMMN=$P(^DPT(DFN,.24),"^",3) D
 ..S APID(7)=$$HLNAME^XLFNAME(VAFCMMN,"",$E(HL("ECH"),1)) I APID(7)="" S APID(7)=HL("Q")
 ..I $P(APID(7),$E(HL("ECH"),1),7)'="M" S $P(APID(7),$E(HL("ECH"),1),7)="M"
 .I APID(7)="" S APID(7)=HL("Q")
 I $D(SARY(7))!(SEQ="ALL") S APID(8)=$$HLDATE^HLFNC($P(VAFCZN,"^",3)) I APID(8)="" S APID(8)=HL("Q") ;date/time of birth
 I $D(SARY(8))!(SEQ="ALL") S APID(9)=$P(VAFCZN,"^",2) I APID(9)="" S APID(9)=HL("Q") ;sex
 ;place of birth city and state
 ;split into 2 routines **707
 D CONT^VAFCQRY3(DFN,.APID,.PID,.HL,HLES,.SARY,SEQ,.ERR,REP,COMP,SSN,VAFCMN)
 D KVA^VADPT
 Q
 ;
HL7TXT(HL7STRG,HL,HLES) ; Replace occurrences of embedded HL7 delimiters with
 ; HL7 escape sequence
 ;
 ; Inputs: HL7STRG - Data string to be checked
 ;        HL("ECH") - HL7 delimiter string
 ;              Delimiters MUST be in the following order,
 ;              Escape, Field, Component, Repeat, Subcomponent
 ;              Example: \^~|&
 ;
 ; Output: HL7XTRG - Data string with escape sequence added (if needed)
 ;
 N OCHR,RCHR,RCHRI,TYPE,I,HLES2
 ;
 I $G(HL("COMP"))="" S HL("COMP")=$E(HL("ECH"),1),HL("REP")=$E(HL("ECH"),2),HL("SUBCOMP")=$E(HL("ECH"),4)
 ; Set HL7 escape char
 S HLES2=HLES_HL("FS")_HL("COMP")_HL("REP")_HL("SUBCOMP")
 ;
 ; Search for occurrence of each delimiter and replace it with "\<type>\"
 F TYPE="E","F","C","R","S" D
 . S RCHRI=$S(TYPE="E":1,TYPE="F":2,TYPE="C":3,TYPE="R":4,TYPE="S":5)
 . ;
 . ; OCHR=original char, RCHR=replacement char
 . S OCHR=$E(HLES2,RCHRI),RCHR=$E("EFSRT",RCHRI) Q:'$F(HL7STRG,OCHR)
 . F I=1:1 Q:$E(HL7STRG,I)=""  I $E(HL7STRG,I)=OCHR S HL7STRG=$E(HL7STRG,1,I-1)_HLES_RCHR_HLES_$E(HL7STRG,I+1,999),I=I+2
 Q
 ;
ADDLINE(NXT,LVL,REF,REP) ; Prepend REP to NXT and add it to the @REF
 ; array, starting at subscript LVL. If appending NXT causes the node
 ; to exceed 245 chars in length, add as much of NXT as possible to the
 ; current level, and the remaining at the next level.
 ; In:
 ;   NXT = string to add to the @REF array
 ;  .LVL = current subscript level (passed by referenced)
 ;   REF = array reference string
 ;   REP = repetition character (e.g., |)
 ; **837,MVI_879: Created this subroutine to aid in adding TIN and FIN to PID-3.
 N LNGTH,CURREF
 S:$G(LVL)<1 LVL=0
 S CURREF=$S(LVL=0:REF,1:$NA(@REF@(LVL)))
 I LVL>0!($G(@CURREF)]"") S NXT=REP_NXT
 I $L($G(@CURREF))+$L(NXT)'>245 S @CURREF=$G(@CURREF)_NXT
 E  S LNGTH=245-$L(@CURREF),@CURREF=@CURREF_$E(NXT,1,LNGTH),LVL=LVL+1,@REF@(LVL)=$E(NXT,LNGTH+1,$L(NXT))
 Q
 ;
