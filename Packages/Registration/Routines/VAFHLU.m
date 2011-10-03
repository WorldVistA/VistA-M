VAFHLU ;BPFO/JRP - SEGMENT BUILDING UTILTIES ;7/12/2002
 ;;5.3;Registration;**415,508**;Aug 13, 1993
 ;
 Q
MAKEIT(SEGNAME,SEGARR,FIRST245,ADTLNODE)        ;Make segment
 ;Input  : SEGNAME - Name of segment being built
 ;         SEGARR - Array continue segment data (pass by value)
 ;           SEGARR(X) = Value for sequence N
 ;           SEGARR(X,Y) = Repetition Y of sequence X
 ;           SEGARR(X,Y,Z) = Component Z of repetition Y of sequence X
 ;           SEGARR(X,Y,Z,A) = Subcomponent A of component Z of
 ;                             repetition Y of sequence X
 ;         FIRST245 - Variable to return first 245 characters of
 ;                    segment in (pass by value)
 ;         ADTLNODE - Array for continuation nodes (pass by value)
 ;Assumed: HL7 encoding chars (output of INIT^HLFNC2 or INIT^HLTRANS)
 ;Output : None
 ;         FIRST245 = First 245 characters of segment
 ;         ADTLNODE(1..n) = Continuation of segment
 ;Notes  : Validity & existance of input is assumed
 ;       : Assumes no single element contained in SEGARR is greater
 ;         than 245 characters
 ;       : Continuation nodes are added at element boundaries
 ;
 ;Declare variables
 N SUB1,SUB2,SUB3,CS,RS,FS,SS,OUTREF,X
 K FIRST245,ADTLNODE
 ;Get HL7 separators (attempts to use HL() array)
 S FS=$S($D(HL("FS")):HL("FS"),1:HLFS)
 S X=$S($D(HL("ECH")):HL("ECH"),1:HLECH)
 S CS=$E(X,1),RS=$E(X,2),SS=$E(X,4)
 ;Build output
 S OUTREF=$NA(FIRST245)
 S @OUTREF=SEGNAME
 I '$O(SEGARR(0)) S X="",Y=FS D ADD Q
 F SUB1=1:1:$O(SEGARR(""),-1) D
 .S X=$G(SEGARR(SUB1)),Y=FS D ADD
 .F SUB2=1:1:$O(SEGARR(SUB1,""),-1) D
 ..S X=$G(SEGARR(SUB1,SUB2)),Y=$S(SUB2=1:"",1:RS) D ADD
 ..F SUB3=1:1:$O(SEGARR(SUB1,SUB2,""),-1) D
 ...S X=$G(SEGARR(SUB1,SUB2,SUB3)),Y=$S(SUB3=1:"",1:CS) D ADD
 ...F SUB4=1:1:$O(SEGARR(SUB1,SUB2,SUB3,""),-1) D
 ....S X=$G(SEGARR(SUB1,SUB2,SUB3,SUB4)),Y=$S(SUB4=1:"",1:SS) D ADD
 Q
ADD ;Add to output - account for continuation node
 I ($L(@OUTREF)+$L(X)+1)>245 D
 .S X1=1+$O(ADTLNODE(""),-1)
 .S OUTREF=$NA(ADTLNODE(X1))
 .S @OUTREF=""
 S @OUTREF=@OUTREF_Y_X
 Q
