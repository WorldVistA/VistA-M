DGUTL4 ;BPFO/JRP - RACE & ETHNIC UTILITIES;9/5/2002
 ;;5.3;Registration;**415**;Aug 13, 1993
 ;
PTR2TEXT(VALUE,TYPE)    ;Convert pointer to text (.01 field)
 ;Input:  VALUE - Pointer to RACE file (#10), ETHNICITY file (#10.2),
 ;                or RACE AND ETHNICITY COLLECTION METHOD file (#10.3)
 ;        TYPE - Flag indicating which file VALUE is for
 ;               1 = Race (default)
 ;               2 = Ethnicity
 ;               3 = Collection Method
 ;Output: Text (.01 field)
 ;Notes : NULL ("") returned on bad input or if there is no code
 ;
 ;Check input
 S VALUE=+$G(VALUE)
 I 'VALUE Q ""
 S TYPE=$G(TYPE)
 S:(TYPE'?1N) TYPE=1
 S:((TYPE<1)!(TYPE>3)) TYPE=1
 ;Declare variables
 N FILE,NODE
 ;Grab zero node
 S FILE=$S(TYPE=3:$NA(^DIC(10.3)),TYPE=2:$NA(^DIC(10.2)),1:$NA(^DIC(10)))
 S NODE=$G(@FILE@(VALUE,0))
 ;Return text
 Q $P(NODE,"^",1)
 ;
INACTIVE(VALUE,TYPE)    ;Entry marked as inactive ?
 ;Input:  VALUE - Pointer to RACE file (#10) or ETHNICITY file (#10.2)
 ;        TYPE - Flag indicating which file VALUE is for
 ;               1 = Race (default)
 ;               2 = Ethnicity
 ;Output: 0 - Entry not inactive
 ;        1^Date - Entry inactive (Date in FileMan format)
 ;Notes : 0 (zero) returned on bad input
 ;      : Collection methods can not currently be inactivated
 ;
 ;Check input
 S VALUE=+$G(VALUE)
 I 'VALUE Q ""
 S TYPE=$G(TYPE)
 S:(TYPE'?1N) TYPE=1
 S:((TYPE<1)!(TYPE>2)) TYPE=1
 ;Declare variables
 N FILE,NODE,DATE
 ;Grab inactivation node
 S FILE=$S(TYPE=2:$NA(^DIC(10.2)),1:$NA(^DIC(10)))
 S NODE=$G(@FILE@(VALUE,.02))
 ;Grab inactivation date
 S DATE=$P(NODE,"^",2)
 ;Not inactive
 I (('NODE)&('DATE)) Q 0
 ;Inactive - include inactivation date
 Q "1^"_DATE
 ;
PTR2CODE(VALUE,TYPE,CODE)       ;Convert pointer to specified code
 ;Input:  VALUE - Pointer to RACE file (#10), ETHNICITY file (#10.2),
 ;                or RACE AND ETHNICITY COLLECTION METHOD file (#10.3)
 ;        TYPE - Flag indicating which file VALUE is for
 ;               1 = Race (default)
 ;               2 = Ethnicity
 ;               3 = Collection Method
 ;        CODE - Flag indicating which code to return
 ;               1 = Abbreviation (default)
 ;               2 = HL7
 ;               3 = CDC (not applicable for Collection Method)
 ;               4 = PTF
 ;Output: Requested code
 ;Notes : NULL ("") returned on bad input or if there is no code
 ;
 ;Check input
 S VALUE=+$G(VALUE)
 I 'VALUE Q ""
 S TYPE=$G(TYPE)
 S:(TYPE'?1N) TYPE=1
 S:((TYPE<1)!(TYPE>3)) TYPE=1
 S CODE=$G(CODE)
 S:(CODE'?1N) CODE=1
 S:((CODE<1)!(CODE>4)) CODE=1
 ;No CDC code for Collection Method
 I ((TYPE=3)&(CODE=3)) Q ""
 ;Declare variables
 N FILE,NODEREF,NODE,PIECE
 ;Grab node storing code
 S FILE=$S(TYPE=3:$NA(^DIC(10.3)),TYPE=2:$NA(^DIC(10.2)),1:$NA(^DIC(10)))
 S NODEREF=0
 S NODE=$G(@FILE@(VALUE,NODEREF))
 ;Determine which piece requested code is in
 S PIECE=CODE+1
 ;Return requested code
 Q $P(NODE,"^",PIECE)
 ;
CODE2PTR(VALUE,TYPE,CODE)       ;Convert specified code to pointer
 ;Input:  VALUE - Code to convert
 ;        TYPE - Flag indicating which file VALUE is from
 ;               1 = Race (file #10) (default)
 ;               2 = Ethnicity (file #10.2)
 ;               3 = Collection Method (file #10.3)
 ;        CODE - Flag indicating which code VALUE is for
 ;               1 = Abbreviation (default)
 ;               2 = HL7
 ;               3 = CDC (not applicable for Collection Method)
 ;               4 = PTF
 ;Output: Pointer to file
 ;Notes : 0 (zero) returned on bad input or if an entry can't be found
 ;
 ;Check input
 S VALUE=$G(VALUE)
 I VALUE="" Q 0
 S TYPE=$G(TYPE)
 S:(TYPE'?1N) TYPE=1
 S:((TYPE<1)!(TYPE>3)) TYPE=1
 S CODE=$G(CODE)
 S:(CODE'?1N) CODE=1
 S:((CODE<1)!(CODE>4)) CODE=1
 ;No CDC code for Collection Method
 I ((TYPE=3)&(CODE=3)) Q 0
 ;Declare variables
 N PTR,FILE,NODEREF,PIECE,FOUND
 S FILE=$S(TYPE=3:$NA(^DIC(10.3)),TYPE=2:$NA(^DIC(10.2)),1:$NA(^DIC(10)))
 ;Abbreviation and HL7 have x-refs
 I ((CODE=1)!(CODE=2)) D  Q PTR
 .;Get pointer using x-ref
 .S NODEREF=$S(CODE=2:"AHL7",1:"C")
 .S PTR=+$O(@FILE@(NODEREF,VALUE,0))
 ;CDC and PTF don't have x-refs - loop through file looking for match
 ;Node & piece code is stored on
 S NODEREF=0
 S PIECE=CODE+1
 S FOUND=0
 S PTR=0
 F  S PTR=+$O(@FILE@(PTR)) Q:'PTR  D  Q:FOUND
 .S NODE=$G(@FILE@(PTR,NODEREF))
 .I $P(NODE,"^",PIECE)=VALUE S FOUND=1
 Q PTR
