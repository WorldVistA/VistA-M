HLOPBLD ;ALB/CJM-HL7 - Building segments ;10/24/2006
 ;;1.6;HEALTH LEVEL SEVEN;**126,132**;Oct 13, 1995;Build 6
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
BUILDSEG(HLMSTATE,SEG,TOARY,ERROR) ;Builds the segment from the individual values
 ;Input:
 ;  HLMSTATE() - (pass by reference, required) Used to track the progress of the message. Uses these subscripts:
 ;    ("HDR","FIELD SEPARATOR")
 ;    ("HDR","ENCODING CHARACTERS")
 ;  SEG() - (pass by reference, required) Contains the data.  It must be built by calls to SET^HLOAPI prior to calling $$BUILDSEG.
 ;
 ;Note#1:  The '0' field must be a 3 character segment type
 ;Note#2: ***SEG is killed upon successfully adding the segment***
 ;
 ;Output:
 ;  Function - returns 1 on success, 0 on failure
 ;  TOARY (pass by reference) This will return the segment in an array format TOARY(1),TOARY(2),... For segments that are shorter than the MUMPS maximum string length, there will be only TOARY(1)
 ;  ERROR (optional, pass by reference) - returns an error message on failure
 ;
 ;
 K ERROR,TOARY
 N TEMP1,TEMP2,LINE,LAST,SEQ,MAX,COUNT,SEGTYPE
 S COUNT=0
 S MAX=HLMSTATE("SYSTEM","MAXSTRING")-1 ;save some room for the <CR>
 S SEGTYPE=$G(SEG(0,1,1,1))
 S LAST=0,(TEMP1,TEMP2)="",LINE=SEGTYPE_HLMSTATE("HDR","FIELD SEPARATOR")
 F  S SEQ=$O(SEG(LAST)) Q:'SEQ  D
 .S TEMP2="",$P(TEMP2,HLMSTATE("HDR","FIELD SEPARATOR"),$S(LAST=0:SEQ,1:SEQ-LAST+1))=""
 .S TEMP1=TEMP2
 .S LAST=SEQ
 .N REP,LAST
 .S LAST=0
 .F  S REP=$O(SEG(SEQ,LAST)) Q:'REP  D
 ..S TEMP2="",$P(TEMP2,$E(HLMSTATE("HDR","ENCODING CHARACTERS"),2),$S(LAST=0:REP,1:REP-LAST+1))=""
 ..S TEMP1=TEMP1_TEMP2
 ..S LAST=REP
 ..;
 ..N COMP,LAST
 ..S LAST=0
 ..F  S COMP=$O(SEG(SEQ,REP,LAST)) Q:'COMP  D
 ...S TEMP2="",$P(TEMP2,$E(HLMSTATE("HDR","ENCODING CHARACTERS"),1),$S(LAST=0:COMP,1:COMP-LAST+1))=""
 ...S TEMP1=TEMP1_TEMP2
 ...S LAST=COMP
 ...;
 ...N SUBCOMP,LAST
 ...S LAST=0
 ...F  S SUBCOMP=$O(SEG(SEQ,REP,COMP,LAST)) Q:'SUBCOMP  D
 ....N VALUE
 ....S TEMP2="",$P(TEMP2,$E(HLMSTATE("HDR","ENCODING CHARACTERS"),4),$S(LAST=0:SUBCOMP,1:SUBCOMP-LAST+1))=""
 ....S VALUE=$G(SEG(SEQ,REP,COMP,SUBCOMP))
 ....K SEG(SEQ,REP,COMP,SUBCOMP)
 ....S:((SEGTYPE'="MSH")&(SEGTYPE'="BHS"))!(SEQ'=2) VALUE=$$ESCAPE(.HLMSTATE,VALUE)
 ....S TEMP2=TEMP2_VALUE
 ....S TEMP1=TEMP1_TEMP2
 ....I $L(LINE)+$L(TEMP1)<MAX D
 .....S LINE=LINE_TEMP1
 ....E  D
 .....D ADDLINE(.TOARY,LINE_$E(TEMP1,1,MAX-$L(LINE)),.COUNT)
 .....S LINE=$E(TEMP1,MAX-$L(LINE)+1,MAX+100)
 ....S TEMP1=""
 ....S LAST=SUBCOMP
 I $L(LINE) D ADDLINE(.TOARY,LINE,.COUNT)
 K SEG
 Q 1
 ;
ADDLINE(TOARY,LINE,COUNT) ;
 S COUNT=COUNT+1
 S TOARY(COUNT)=LINE
 Q
 ;
ESCAPE(HLMSTATE,VALUE) ;
 ;Replaces the HL7 encoding characters with the corresponding escape sequences and returns the result as the function value
 ;
 N ESC,CHARS,I,NEWVALUE,LEN,CUR
 S CHARS=HLMSTATE("HDR","ENCODING CHARACTERS")
 S ESC=$E(CHARS,3)
 S NEWVALUE="",LEN=$L(VALUE)
 F I=1:1:LEN D
 .S CUR=$E(VALUE,I)
 .S NEWVALUE=NEWVALUE_$S(CUR=HLMSTATE("HDR","FIELD SEPARATOR"):ESC_"F"_ESC,CUR=ESC:ESC_"E"_ESC,CUR=$E(CHARS,1):ESC_"S"_ESC,CUR=$E(CHARS,4):ESC_"T"_ESC,CUR=$E(CHARS,2):ESC_"R"_ESC,1:CUR)
 Q NEWVALUE
 ;
REPLACE(VALUE,CHAR,STRING) ;
 ;Takes the input string=VALUE and replaces each instance of the character
 ;=CHAR with the string=STRING and returns the resultant string
 ;as the function value
 ;
 N I,NEWVALUE,CURCHAR
 S NEWVALUE=""
 F I=1:1:$L(VALUE) D
 .S CURCHAR=$E(VALUE,I)
 .S NEWVALUE=NEWVALUE_$S(CURCHAR=CHAR:STRING,1:CURCHAR)
 Q NEWVALUE
