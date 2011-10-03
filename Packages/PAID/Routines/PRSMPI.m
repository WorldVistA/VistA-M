PRSMPI ;ALB/CMC-TRIGGER X-REF ON PAID FIELDS FOR MPI & STF SEG BUILDER ;8/5/2010
 ;;4.0;PAID;**128**;Sep 21, 1995;Build 3
 ;
XREF(DA) ;TRIGGER TO SET THE REQUIRES TRANSMISSION FIELD if the PAID Enumeration process has started
 ;8989.3,901    PAID Enumeration Started MPI;2 DATE
 N IEN,FDA,PRSERR
 S IEN=$O(^XTV(8989.3,0))
 Q:$P($G(^XTV(8989.3,IEN,"MPI")),"^",2)=""
 ;enumeration has started so set the Requires Transmission field in PAID for this Record
 S FDA(450,DA_",",902)="Y"
 D FILE^DIE("E","FDA","PRSERR")
 ;what to do if can't set the field???
 Q
 ;
GET(EN,ARRAY) ;
 ;EN is the internal entry for the person in file 200
 ;returned is 0 or -1^error message
 ;if returned value is 0 then ARRAY will also be defined with the data values
 N CNT,COR,NAME2,NAME,ERROR
 I 'EN S ERROR="-1^Invalid parameter - no correlation ien passed." Q ERROR
 M COR(EN)=^PRSPC(EN)
 I '$D(COR(EN)) S ERROR="-1^Correlation doesn't exist." Q ERROR
 S ARRAY("SourceSystemIEN")=$P($$SITE^VASITE(),"^") ;facility ien
 S ARRAY("SourceSystemID")=$P($$SITE^VASITE(),"^",3) ;facility station number
 S ARRAY("SourceID")=EN ;duz
 S NAME2=$P(COR(EN,0),"^")
 S NAME=$$HLNAME^XLFNAME(.NAME2,"","^")
 S ARRAY("Surname")=$P(NAME,"^") ;surname
 S ARRAY("FirstName")=$P(NAME,"^",2) ;first name
 S ARRAY("MiddleName")=$P(NAME,"^",3) ;middle name
 S ARRAY("Prefix")="" ;PREFIX IS NOT STORED IN PAID EMPLOYEE
 S ARRAY("Suffix")=$P(NAME,"^",4) ;suffix
 S ARRAY("DOB")=$P($G(COR(EN,0)),"^",33) ;dob
 S ARRAY("Gender")=$P($G(COR(EN,0)),"^",32) ;gender
 S ARRAY("SSN")=$P($G(COR(EN,0)),"^",9) ;ssn
 S ARRAY("ResAddL1")=$P($G(COR(EN,"ADD")),"^",7) ;street line 1
 S ARRAY("ResAddL2")=$P($G(COR(EN,"ADD")),"^",8) ;street line 2
 S ARRAY("ResAddL3")=$P($G(COR(EN,"ADD")),"^",9) ;street line 3
 S ARRAY("ResAddCity")="" ;city is not defined per say in PAID file
 S ARRAY("ResAddState")=$P($G(COR(EN,"ADD")),"^",6) ;state
 S ARRAY("ResAddZip4")=$P($G(COR(EN,"ADD")),"^",10) ;zip
 S ARRAY("NPIEN")=$P($G(^PRSPC(EN,200)),"^") ;NEW PERSON FILE IEN
 S ARRAY("EnumerateStart")=$P($G(^PRSPC(EN,"MPI")),"^") ;Enumeration Initiated
 S ARRAY("EnumerateComp")=$P($G(^PRSPC(EN,"MPI")),"^",2) ;Enumeration Completed
 Q 0
STF(PRSSIEN,HL,PRSSTR) ; STF segment builder for PAID Employee (#450)
 ;at this moment fields 2, 3, 5, 6, 10 and 11 will be populated
 ;seq 2 may contain SSN, PAID IEN, and New Person IEN as a repeating field
 ;PRSSIEN is the IEN in PAID Employee that data is being pulled from
 ;HL is the array name containing the HL7 array variables
 ;PRSSTR is the list of fields that can be populated in the STF segment
 ;Output:
 ;PRSSTF - First 245 characters
 ;PRSSTF(1..n)=continuation nodes if results > 245 characters
 ;
 I $G(PRSSTR)="" S PRSSTR="2,3,4,5,10,11"
 N HLFS,COMP,HLES,SUBCOMP,PRSSRCTR,PRSSSUB1,PRSSSUB2,PRSSSUB3,ARRAY,TMP,TADDR,PRSSSEG,PRSSREC,PRSSSTF
 S HLFS=HL("FS"),COMP=$E(HL("ECH")),HLES=$E(HL("ECH"),2),SUBCOMP=$E(HL("ECH"),4)
 S TMP=$$GET(PRSSIEN,.ARRAY)
 Q:'$D(ARRAY) "-1^No entry"
 ;SEQUENCE 2
 I PRSSTR["2," D
 .S (PRSSSUB1,PRSSSUB2,PRSSSUB3)="",PRSSRCTR=0
 .;IEN file 450
 .S PRSSSUB1=PRSSIEN_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"0363"_COMP_"EI"_COMP
 .S PRSSSUB1=PRSSSUB1_"VA FACILITY ID"_SUBCOMP_$P($$SITE^VASITE(),"^",3)_SUBCOMP_"L"_COMP_COMP
 .S PRSSRCTR=PRSSRCTR+1
 .S PRSSSEG(2,PRSSRCTR)=PRSSSUB1
 .;SSN
 .S PRSSSUB2=$S(ARRAY("SSN")]"":ARRAY("SSN"),1:HL("Q"))_COMP_COMP_COMP_"USSSA"_SUBCOMP_SUBCOMP_"0363"_COMP_"SS"
 .S PRSSSUB2=PRSSSUB2_COMP_"VA FACILITY ID"_SUBCOMP_$P($$SITE^VASITE(),"^",3)_SUBCOMP_"L"
 .S PRSSRCTR=PRSSRCTR+1
 .S PRSSSEG(2,PRSSRCTR)=PRSSSUB2
 .;NEW PERSON POINTER
 .S PRSSSUB3=$S(ARRAY("NPIEN")]"":ARRAY("NPIEN"),1:HL("Q"))_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"0363"_COMP
 .S PRSSSUB3=PRSSSUB3_"PN"_COMP_"VA FACILITY ID"_SUBCOMP_$P($$SITE^VASITE(),"^",3)_SUBCOMP_"L"_COMP_COMP
 .S PRSSRCTR=PRSSRCTR+1
 .S PRSSSEG(2,PRSSRCTR)=PRSSSUB3
 ;NAME
 I PRSSTR["3," D  ;get name data
 .;name last^first^middle^suffix^prefix^^"L" for legal
 .S PRSSSEG(3)=$S(ARRAY("Surname")'="":ARRAY("Surname"),1:HL("Q"))_COMP_$S($G(ARRAY("FirstName"))'="":$G(ARRAY("FirstName")),1:HL("Q"))_COMP
 .S PRSSSEG(3)=PRSSSEG(3)_$S($G(ARRAY("MiddleName"))'="":$G(ARRAY("MiddleName")),1:HL("Q"))_COMP_$S($G(ARRAY("Suffix"))'="":$G(ARRAY("Suffix")),1:HL("Q"))_COMP
 .S PRSSSEG(3)=PRSSSEG(3)_$S($G(ARRAY("Prefix"))'="":$G(ARRAY("Prefix")),1:HL("Q"))_COMP_COMP_"L"
 ;SEX
 I PRSSTR["5," D  ;get sex
 .S PRSSSEG(5)=$S($G(ARRAY("Gender"))'="":$G(ARRAY("Gender")),1:HL("Q"))
 ;DOB
 I PRSSTR["6," D  ;get dob
 .S PRSSSEG(6)=$S($G(ARRAY("DOB"))'="":$$HLDATE^HLFNC($G(ARRAY("DOB"))),1:HL("Q"))
 ;Address
 I PRSSTR[",11" D
 .N PRSSA,HL7STRG
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
 .S PRSSSEG(11)=TADDR
 ;
 D MAKEIT^PRSHL7B("STF",.PRSSSEG,.PRSSREC,.PRSSSTF)
 Q PRSSREC
 ;
HL7TXT(HL7STRG,HL,HLES) ; Replace occurrences of embedded HL7 delimiters with HL7 escape sequence
 ; Inputs: HL7STRG - Data string to be checked
 ;        HL("ECH") - HL7 delimiter string
 ;      Delimiters MUST be in the following order: Escape, Field, Component, Repeat, Subcomponent
 ;      Example: \^~|&
 ; Output: HL7XTRG - Data string with escape sequence added (if needed)
 N OCHR,RCHR,RCHRI,TYPE,I,HLES2
 I $G(HL("COMP"))="" S HL("COMP")=$E(HL("ECH"),1),HL("REP")=$E(HL("ECH"),2),HL("SUBCOMP")=$E(HL("ECH"),4)
 ; Set HL7 escape char
 S HLES2=HLES_HL("FS")_HL("COMP")_HL("REP")_HL("SUBCOMP")
 ; Search for occurrence of each delimiter and replace it with "\<type>\"
 F TYPE="E","F","C","R","S" D
 .S RCHRI=$S(TYPE="E":1,TYPE="F":2,TYPE="C":3,TYPE="R":4,TYPE="S":5)
 .; OCHR=original char, RCHR=replacement char
 .S OCHR=$E(HLES2,RCHRI),RCHR=$E("EFSRT",RCHRI) Q:'$F(HL7STRG,OCHR)
 .F I=1:1 Q:$E(HL7STRG,I)=""  I $E(HL7STRG,I)=OCHR S HL7STRG=$E(HL7STRG,1,I-1)_HLES_RCHR_HLES_$E(HL7STRG,I+1,999),I=I+2
 Q
