VAFCQRY1 ;BIR/DLR-Query for patient demographics ;10/30/02  13:58
 ;;5.3;Registration;**428,474,477,575,627,648,698,711,707**;Aug 13, 1993;Build 14
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
 N VAFCA,VAFCA1 D GETS^DIQ(2,DFN_",","1*","E","VAFCA") ;**698 GETTING ALIAS INFO
 ;** 707 reformat alias information to include ALIAS SSN in PID-3 with a location reference to the name in PID-5
 I $D(VAFCA) N CT,ENT S CT=0,ENT="" F  S ENT=$O(VAFCA(2.01,ENT)) Q:ENT=""  D
 .S CT=CT+1
 .S VAFCA1(CT,"NAME")=$G(VAFCA(2.01,ENT,.01,"E"))
 .;I $G(VAFCA(2.01,ENT,1,"E"))'="" S VAFCA1("SSN")="",VAFCA1(CT,"SSN")=$G(VAFCA(2.01,ENT,1,"E"))
 .S VAFCA1(CT,"SSN")=$G(VAFCA(2.01,ENT,1,"E"))
 S SITE=$$SITE^VASITE,STN=$P($$SITE^VASITE,"^",3)
 N TMP F TMP=1:1:31 S APID(TMP)=""
 S APID(2)=CNT
 ;list of fields used for backwards compatibility with HDR
 I $D(SARY(2))!(SEQ="ALL") I VAFCMN'="" S APID(3)=$P(VAFCMN,"^")_"V"_$P(VAFCMN,"^",2)  ;Patient ID
 ;repeat patient ID list including ICN (NI),SSN (SS),CLAIM# (PN) AND DFN (PI)
 I $D(SARY(3))!(SEQ="ALL") D
 .S APID(4)=""
 .;National Identifier (ICN)
 .I VAFCMN'="",+VAFCMN>0 D
 ..I $E($P(VAFCMN,"^"),1,3)=STN S SITA=STN
 ..I $E($P(VAFCMN,"^"),1,3)'=STN S SITA="200M" ; **707 update assigning authority for national ICNs to 200M for MPI
 ..S APID(4)=$P(VAFCMN,"^")_"V"_$P(VAFCMN,"^",2)_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"0363"_COMP_"NI"_COMP_"VA FACILITY ID"_SUBCOMP_SITA_SUBCOMP_"L" D
 ..;Assumption that if this is a local ICN at this point send the message with an expiration date of today, so that it will be treated as a deprecated ID and stored on the MPI as such
 ..I $E($P(VAFCMN,"^"),1,3)=$P($$SITE^VASITE,"^",3) S APID(4)=APID(4)_COMP_COMP_$$HLDATE^HLFNC(DT,"DT") ;**707 TO ONLY SEND DATE NO TIME
 .I $G(SSN)'="" S APID(4)=APID(4)_$S(APID(4)'="":REP,1:"")_SSN_COMP_COMP_COMP_"USSSA"_SUBCOMP_SUBCOMP_"0363"_COMP_"SS"_COMP_"VA FACILITY ID"_SUBCOMP_$$STA^XUAF4(+SITE)_SUBCOMP_"L"
 .I $G(DFN)'="" S APID(4)=APID(4)_$S(APID(4)'="":REP,1:"")_DFN_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"0363"_COMP_"PI"_COMP_"VA FACILITY ID"_SUBCOMP_$$STA^XUAF4(+SITE)_SUBCOMP_"L" D
 ..;CLAIM# **707 moved dfn and claim number up here since Alias SSN could be many
 ..I $D(^DPT(DFN,.31)) S CLAIM=$P(^DPT(DFN,.31),"^",3) I +CLAIM>0 S APID(4)=APID(4)_REP_CLAIM_COMP_COMP_COMP_"USVBA"_SUBCOMP_SUBCOMP_"0363"_COMP_"PN"_COMP_"VA FACILITY ID"_SUBCOMP_$$STA^XUAF4(+SITE)_SUBCOMP_"L"
 .S NXTC=0,LVL=0
 .I $D(VAFCA1) D
 ..;Have Alias SSNs
 ..S CT=0 F  S CT=$O(VAFCA1(CT)) Q:+CT<1  D
 ...S NXT=$S($G(VAFCA1(CT,"SSN"))="":HL("Q"),1:$G(VAFCA1(CT,"SSN")))_COMP_COMP_COMP_"USSSA"_SUBCOMP_SUBCOMP_"0363"_COMP_"SS"_COMP_"VA FACILITY ID"_SUBCOMP_$$STA^XUAF4(+SITE)_SUBCOMP_"L"_COMP_COMP_$$HLDATE^HLFNC(DT,"DT")
 ...I LVL=0 D
 ....I $L(APID(4)_NXT)'>244 S APID(4)=APID(4)_REP_NXT Q
 ....I $L(APID(4)_NXT)>244 S LVL=1 S LNGTH=244-$L(APID(4)),APID(4)=APID(4)_REP_$E(NXT,1,LNGTH) S LNGTH=LNGTH+1,NXT=$E(NXT,LNGTH,$L(NXT)),NXTC=1
 ...I LVL>0 D
 ....I $L($G(APID(4,LVL))_NXT)'>245 S APID(4,LVL)=$G(APID(4,LVL))_$S(NXTC=0:REP,1:"")_NXT Q
 ....I $L($G(APID(4,LVL))_NXT)>245 S LNGTH=244-$L(APID(4,LVL)),APID(4,LVL)=APID(4,LVL)_REP_$E(NXT,1,LNGTH) S LNGTH=LNGTH+1,NXT=$E(NXT,LNGTH,$L(NXT)) S LVL=LVL+1 S APID(4,LVL)=NXT
 ...I NXTC=1 S NXTC=0
 .I $D(^DPT(DFN,"MPIFHIS")) N HIST S HIST=0  F  S HIST=$O(^DPT(DFN,"MPIFHIS",HIST)) Q:'HIST  S VAFCHMN=^DPT(DFN,"MPIFHIS",HIST,0) S HISTDT=$P(VAFCHMN,"^",4) D
 ..;**477 due to a timing issue if checksum and D/T of deprication of ICN is not present hang two seconds and try again if still not able to get ICN set D/T to DT
 ..I $G(HISTDT)="" H 2 S VAFCHMN=^DPT(DFN,"MPIFHIS",HIST,0) S HISTDT=$P(VAFCHMN,"^",4) I HISTDT="" S HISTDT=DT
 ..I APID(4)'="" D
 ...I $E($P(VAFCHMN,"^"),1,3)=STN S SITA=STN
 ...I $E($P(VAFCHMN,"^"),1,3)'=STN S SITA="200M" ; **707 update assigning authority for national ICNs to 200M for MPI
 ...S NXT=$P(VAFCHMN,"^")_"V"_$P(VAFCHMN,"^",2)_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"0363"_COMP_"NI"_COMP_"VA FACILITY ID"_SUBCOMP_SITA_SUBCOMP_"L"_COMP_COMP_$$HLDATE^HLFNC(HISTDT,"DT") ;**648 only send date not time
 ...I LVL=0 D
 ....I $L(APID(4)_NXT)'>244 S APID(4)=APID(4)_REP_NXT Q
 ....I $L(APID(4)_NXT)>244 S LVL=1 S LNGTH=244-$L(APID(4)),APID(4)=APID(4)_REP_$E(NXT,1,LNGTH) S LNGTH=LNGTH+1,NXT=$E(NXT,LNGTH,$L(NXT)),NXTC=1
 ...I LVL>0 D
 ....I $L($G(APID(4,LVL))_NXT)'>245 S APID(4,LVL)=$G(APID(4,LVL))_$S(NXTC=0:REP,1:"")_NXT Q
 ....I $L($G(APID(4,LVL))_NXT)>245 S LNGTH=244-$L(APID(4,LVL)),APID(4,LVL)=APID(4,LVL)_REP_$E(NXT,1,LNGTH) S LNGTH=LNGTH+1,NXT=$E(NXT,LNGTH,$L(NXT)) S LVL=LVL+1 S APID(4,LVL)=NXT
 ..I NXTC=1 S NXTC=0
 ..I APID(4)="" D
 ...I $E($P(VAFCHMN,"^"),1,3)=STN S SITA=STN
 ...I $E($P(VAFCHMN,"^"),1,3)'=STN S SITA="200M"
 ...S APID(4)=$P(VAFCHMN,"^")_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"0363"_COMP_"NI"_COMP_"VA FACILITY ID"_SUBCOMP_SITA_SUBCOMP_"L"_COMP_COMP_$$HLDATE^HLFNC(HISTDT,"DT") ;**707 ONLY DATE NOT TIME
NAMEPID ;patient name (last^first^middle^suffix^prefix^^"L" for legal)
 I $D(SARY(5))!(SEQ="ALL") D
 .;**711 code REMOVED PREFIX due to issues with existing PATIENT Name Standardization functionality
 .N X S X=$P(VAFCZN,"^") D NAME^VAFCPID2(DFN,.X) S APID(6)=$$HLNAME^XLFNAME(X,"",$E(HL("ECH"),1)) I $P(APID(6),$E(HL("ECH"),1),7)'="L" S $P(APID(6),$E(HL("ECH"),1),7)="L"
ALIAS .;patient alias (last^first^middle^suffice^prefix^^"A" for alias - can be multiple)
 .N ALIAS,ALIEN,LVL6,NXTC,LNGTH S NXTC=0,LVL6=0
 .I $D(VAFCA1) S ALIEN=0 F  S ALIEN=$O(VAFCA1(ALIEN)) Q:'ALIEN  D
 ..S ALIAS=$$HLNAME^XLFNAME(VAFCA1(ALIEN,"NAME"),"",$E(HL("ECH"),1))
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
 Q
