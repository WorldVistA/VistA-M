XUPSSTF ;ALB/CMC - Build STF segment;Aug, 6 2010
 ;;8.0;KERNEL;**551**;Jul 10, 1995;Build 2
 ;
 Q
EN(XUPSIEN,XUPSSTR,HL,XUPSREC,XUPSSTF) ; -- entry point
 ;Input:
 ;XUPSIEN - New Person Internal Entry Number
 ;XUPSSTR - sequence numbers which should be used (2,3,4,5,6,10,11)
 ;HL - HL array variables from INIT call
 ;Output:
 ;XUPSREC - First 245 characters
 ;XUPSSTF(1..n)=continuation nodes if results > 245 characters
 ;
 N XUPSSUB1,XUPSSUB2,XUPSSUB3,XUPSSUB4,XUPSSSN,XUPSDOB,XUPSPH
 N XUPSNO,XUPSSEX,XUPSNAMC,XUPSNAME,XUPSNAM1,XUPSREP,XUPSVID,XUPSCAT,XUPSNPI,TADDR
 N DA,DIE,DR,XUPSNAM2,XUPSVER,XUPSADD,XUPSADDR,XUPSADD1,XUPSADD2,XUPSI,XUPSSEG,HLFS,COMP,SUBCOMP
 ;
 I '$D(HL) S XUPSREC="-1^missing HL variables" Q
 S HLFS=HL("FS"),COMP=$E(HL("ECH")),HLES=$E(HL("ECH"),2),SUBCOMP=$E(HL("ECH"),4)
 N ARRAY,TMP
 S TMP=$$GET^XUPSGS(XUPSIEN,.ARRAY)
 I '$D(ARRAY) S XUPSREC="-1^No entry" Q
 ;SEQUENCE 2
 N XUPSRCTR
 I XUPSSTR["2," D
 .S (XUPSSUB1,XUPSSUB2,XUPSSUB3)=""
 .S XUPSRCTR=0
 .;DUZ
 .S XUPSSUB1=XUPSIEN_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"0363"_COMP_"PN"_COMP
 .S XUPSSUB1=XUPSSUB1_"VA FACILITY ID"_SUBCOMP_$P($$SITE^VASITE(),"^",3)_SUBCOMP_"L"_COMP_COMP
 .S XUPSRCTR=XUPSRCTR+1
 .S XUPSSEG(2,XUPSRCTR)=XUPSSUB1
 .;SSN
 .S XUPSSUB2=$S(ARRAY("SSN")]"":ARRAY("SSN"),1:HL("Q"))_COMP_COMP_COMP_"USSSA"_SUBCOMP_SUBCOMP_"0363"_COMP_"SS"
 .S XUPSSUB2=XUPSSUB2_COMP_"VA FACILITY ID"_SUBCOMP_$P($$SITE^VASITE(),"^",3)_SUBCOMP_"L"
 .S XUPSRCTR=XUPSRCTR+1
 .S XUPSSEG(2,XUPSRCTR)=XUPSSUB2
 .;NPI
 .S $P(XUPSSUB3,COMP,1)=$S(ARRAY("NPI")]"":ARRAY("NPI"),1:HL("Q"))_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"0363"
 .S XUPSSUB3=XUPSSUB3_COMP_"NPI"_COMP_"VA FACILITY ID"_SUBCOMP_$P($$SITE^VASITE(),"^",3)_SUBCOMP_"L"
 .S XUPSRCTR=XUPSRCTR+1
 .S XUPSSEG(2,XUPSRCTR)=XUPSSUB3
 .;Pointer to PAID
 .S $P(XUPSSUB4,COMP,1)=$S(ARRAY("PAID")]"":ARRAY("PAID"),1:HL("Q"))_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"0363"
 .S XUPSSUB4=XUPSSUB4_COMP_"EI"_COMP_"VA FACILITY ID"_SUBCOMP_$P($$SITE^VASITE(),"^",3)_SUBCOMP_"L"
 .S XUPSRCTR=XUPSRCTR+1
 .S XUPSSEG(2,XUPSRCTR)=XUPSSUB4
 ;NAME
 I XUPSSTR["3," D  ;get name data
 .;patient name last^first^middle^suffix^prefix^^"L" for legal
 .S XUPSSEG(3)=$S(ARRAY("Surname")'="":ARRAY("Surname"),1:HL("Q"))_COMP_$S($G(ARRAY("FirstName"))'="":$G(ARRAY("FirstName")),1:HL("Q"))_COMP
 .S XUPSSEG(3)=XUPSSEG(3)_$S($G(ARRAY("MiddleName"))'="":$G(ARRAY("MiddleName")),1:HL("Q"))_COMP_$S($G(ARRAY("Suffix"))'="":$G(ARRAY("Suffix")),1:HL("Q"))_COMP
 .S XUPSSEG(3)=XUPSSEG(3)_$S($G(ARRAY("Prefix"))'="":$G(ARRAY("Prefix")),1:HL("Q"))_COMP_COMP_"L"
 ;SEX
 I XUPSSTR["5," D  ;get sex
 .S XUPSSEG(5)=$S($G(ARRAY("Gender"))'="":$G(ARRAY("Gender")),1:HL("Q"))
 ;DOB
 I XUPSSTR["6," D  ;get dob
 .S XUPSSEG(6)=$S($G(ARRAY("DOB"))'="":$$HLDATE^HLFNC($G(ARRAY("DOB"))),1:HL("Q"))
 ;Home Phone #
 I XUPSSTR[",10" D
 .I $G(ARRAY("ResPhone"))]"" S XUPSPH=$$HLPHONE^HLFNC($G(ARRAY("ResPhone"))) D HL7TXT(.XUPSPH,.HL,HLES) ;convert HL characters
 .I $G(ARRAY("ResPhone"))="" S XUPSPH=HL("Q")
 .;PRN for Home Phone Number.
 .S $P(XUPSPH,COMP,2)="PRN",$P(XUPSPH,COMP,3)="PH"
 .S XUPSSEG(10)=XUPSPH
 ;Address
 I XUPSSTR[",11" D
 .N XUPSA,HL7STRG
 .S HL7STRG=$G(ARRAY("ResAddL1"))
 .I HL7STRG'="" D HL7TXT(.HL7STRG,.HL,HLES)
 .S $P(TADDR,COMP)=$S($G(HL7STRG)'="":HL7STRG,1:HL("Q"))
 .S HL7STRG=$G(ARRAY("ResAddL2")) D HL7TXT(.HL7STRG,.HL,HLES)
 .S $P(TADDR,COMP,2)=$S($G(HL7STRG)'="":HL7STRG,1:HL("Q"))
 .S HL7STRG=$G(ARRAY("ResAddCity")) D HL7TXT(.HL7STRG,.HL,HLES)
 .S $P(TADDR,COMP,3)=$S($G(HL7STRG)'="":HL7STRG,1:HL("Q"))
 .S $P(TADDR,COMP,4)=$S($G(ARRAY("ResAddState"))'="":$G(ARRAY("ResAddState")),1:HL("Q"))
 .S $P(TADDR,COMP,5)=$S($G(ARRAY("ResAddZip4"))'="":ARRAY("ResAddZip4"),1:HL("Q"))
 .S HL7STRG=$G(ARRAY("ResAddL3")) D HL7TXT(.HL7STRG,.HL,HLES)
 .S $P(TADDR,COMP,8)=$S($G(HL7STRG)'="":HL7STRG,1:HL("Q"))
 .;Country set to null - not used by PSIM
 .S $P(TADDR,COMP,6)=""
 .;Address type set to P for permanent
 .S $P(TADDR,COMP,7)="P"
 .S XUPSSEG(11)=TADDR
 ;
 D MAKEIT^XUPSHL7B("STF",.XUPSSEG,.XUPSREC,.XUPSSTF)
 Q
 ;
HL7TXT(HL7STRG,HL,HLES) ; Replace occurrences of embedded HL7 delimiters with
 ; HL7 escape sequence
 ;
 ; Inputs: HL7STRG - Data string to be checked
 ;        HL("ECH") - HL7 delimiter string
 ;      Delimiters MUST be in the following order,
 ;      Escape, Field, Component, Repeat, Subcomponent
 ;      Example: \^~|&
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
