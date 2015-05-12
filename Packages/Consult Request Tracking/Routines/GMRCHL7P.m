GMRCHL7P ;DSS/MS - HL7 Message Utilities for HCP ;4/29/14
 ;;3.0;CONSULT/REQUEST TRACKING;**75**;DEC 27, 1997;Build 22
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;10106 HLPHONE^HLFNC
 ;
ADDR(PROVIEN,HL) ;get address data for Referring Provider
 N HL7STRG,COMP,ADD,STATEIEN S COMP=$E(HL("ECH")),ADD=""
 S HL7STRG=$$GET1^DIQ(200,PROVIEN_",",.111) D HL7TXT(.HL7STRG,.HL,"\")
 S $P(ADD,COMP)=HL7STRG
 S HL7STRG=$$GET1^DIQ(200,PROVIEN_",",.112) D HL7TXT(.HL7STRG,.HL,"\")
 S $P(ADD,COMP,2)=HL7STRG
 S HL7STRG=$$GET1^DIQ(200,PROVIEN_",",.114) D HL7TXT(.HL7STRG,.HL,"\")
 S $P(ADD,COMP,3)=HL7STRG
 S STATEIEN=$$GET1^DIQ(200,PROVIEN_",",.115,"I") S $P(ADD,COMP,4)=$$GET1^DIQ(5,+STATEIEN_",",1)
 S HL7STRG=$$GET1^DIQ(200,PROVIEN_",",.116) D HL7TXT(.HL7STRG,.HL,"\")
 S $P(ADD,COMP,5)=HL7STRG
 Q ADD
PH(PROVIEN,HL) ;get contact information
 N HL7STRG,COMP,PH S COMP=$E(HL("ECH")),PH=""
 S HL7STRG=$$GET1^DIQ(200,PROVIEN_",",.151) D HL7TXT(.HL7STRG,.HL,"\")
 S $P(PH,COMP,4)=HL7STRG
 S HL7STRG=$$GET1^DIQ(200,PROVIEN_",",.132),HL7STRG=$$HLPHONE^HLFNC(HL7STRG)
 I HL7STRG["(" S $P(PH,COMP,6)=$E(HL7STRG,2,4),$P(PH,COMP,7)=$P(HL7STRG,")",2)
 E  S $P(PH,COMP,7)=HL7STRG
 Q PH
HL7TXT(HL7STRG,HL,HLES) ; Replace occurrences of embedded HL7 delimiters with
 ; HL7 escape sequence
 ; copied from VAFCQRY1
 ;
 ; Inputs: HL7STRG - Data string to be checked
 ;        HL("ECH") - HL7 delimiter string
 ;              Delimiters MUST be in the following order,
 ;              Escape, Field, Component, Repeat, Subcomponent
 ;              Example: \|^~&
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
