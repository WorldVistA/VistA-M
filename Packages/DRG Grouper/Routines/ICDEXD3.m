ICDEXD3 ;SLC/KER - ICD Extractor - DRG APIs (cont) ;04/21/2014
 ;;18.0;DRG Grouper;**57**;Oct 20, 2000;Build 1
 ;               
 ;               
 ; Global Variables
 ;    ^ICDCCEX(           N/A
 ;    ^TMP(SUB,$J         SACC 2.3.2.5.1
 ;               
 ; External References
 ;    None
 ;               
 Q
NOT(IEN,SUB,FMT) ; Codes not Used With
 ;
 ; Input:
 ;
 ;   IEN     Internal Entry Number in file 80
 ;   SUB     TMP global array subscript name.
 ;           If not provided, the subscript 
 ;           "ICDNOT" will be used.
 ;   FMT     Format of Output
 ;             0 - Total number only (default)
 ;             1 - Total number with global array
 ; 
 ; Output:
 ; 
 ;   $$NOT   The number of ICD codes that can not
 ;           be used with the ICD code identified
 ;           by IEN (FMT=0 or 1)
 ;           
 ;   TMP global array as follows (FMT=1):
 ;   
 ;           ^TMP("SUB",$J,IEN)=CODE
 ;           ^TMP("SUB",$J,"B",(CODE_" "),IEN)=""
 ;   
 S IEN=+($G(IEN)) Q:$O(^ICD9(IEN,"N",0))'>0 0
 S SUB=$$TM($G(SUB)) S:'$L(SUB) SUB="ICDNOT" S FMT=+($G(FMT)) K ^TMP(SUB,$J)
 N NIEN,NCNT S (NIEN,NCNT)=0 F  S NIEN=$O(^ICD9(IEN,"N",NIEN)) Q:+NIEN'>0  D
 . N CODE,NOT,TIEN S TIEN=$G(^ICD9(IEN,"N",NIEN,0)) Q:TIEN'>0
 . S CODE=$P($G(^ICD9(TIEN,0)),"^",1) Q:'$L(CODE)  Q:$D(^TMP(SUB,$J,"B",(CODE_" ")))
 . S ^TMP(SUB,$J,TIEN)=CODE,^TMP(SUB,$J,"B",(CODE_" "),TIEN)="",NCNT=NCNT+1
 K:FMT'>0 ^TMP(SUB,$J)
 Q NCNT
REQ(IEN,SUB,FMT) ; Codes Required With
 ;
 ; Input:
 ;
 ;   IEN     Internal Entry Number in file 80
 ;   SUB     TMP global array subscript name.
 ;           If not provided, the subscript 
 ;           "ICDREQ" will be used.
 ;   FMT     Format of Output
 ;             0 - Total number only (default)
 ;             1 - Total number with global array
 ; 
 ; Output:
 ; 
 ;   $$REQ   The number of ICD codes requires when
 ;           the ICD code identified by IEN is used.
 ;           (FMT=0 or 1)
 ;           
 ;   TMP global array as follows (FMT=1): 
 ;   
 ;           ^TMP("SUB",$J,IEN)=CODE
 ;           ^TMP("SUB",$J,"B",(CODE_" "),IEN)=""
 ;   
 S IEN=+($G(IEN)) Q:$O(^ICD9(IEN,"R",0))'>0 0
 S SUB=$$TM($G(SUB)) S:'$L(SUB) SUB="ICDREQ" S FMT=+($G(FMT)) K ^TMP(SUB,$J)
 N NIEN,NCNT S (NIEN,NCNT)=0 F  S NIEN=$O(^ICD9(IEN,"R",NIEN)) Q:+NIEN'>0  D
 . N CODE,REQ,TIEN S TIEN=$G(^ICD9(IEN,"R",NIEN,0)) Q:TIEN'>0
 . S CODE=$P($G(^ICD9(TIEN,0)),"^",1) Q:'$L(CODE)  Q:$D(^TMP(SUB,$J,"B",(CODE_" ")))
 . S ^TMP(SUB,$J,TIEN)=CODE,^TMP(SUB,$J,"B",(CODE_" "),TIEN)="",NCNT=NCNT+1
 K:FMT'>0 ^TMP(SUB,$J)
 Q NCNT
 Q
NCC(IEN,SUB,FMT) ; Codes not considered CC With
 ;
 ; Input:
 ;
 ;   IEN     Internal Entry Number in file 80
 ;   SUB     TMP global array subscript name.
 ;           If not provided, the subscript 
 ;           "ICDNCC" will be used.
 ;   FMT     Format of Output
 ;             0 - Total number only (default)
 ;             1 - Total number with global array
 ; 
 ; Output:
 ; 
 ;   $$NCC   The number of ICD codes not considered
 ;           as Complication/Comorbidity with the 
 ;           ICD code identified by IEN.
 ;           (FMT=0 or 1)
 ;           
 ;   TMP global array as follows (FMT=1):
 ;   
 ;           ^TMP("SUB",$J,IEN)=CODE
 ;           ^TMP("SUB",$J,"B",(CODE_" "),IEN)=""
 ;   
 S IEN=+($G(IEN)) Q:$O(^ICD9(IEN))'>0 0
 S SUB=$$TM($G(SUB)) S:'$L(SUB) SUB="ICDNCC" S FMT=+($G(FMT)) K ^TMP(SUB,$J)
 N NIEN,NCNT,PDXE,ICDCS S NCNT=0,ICDCS=$P($G(^ICD9(IEN,1)),"^",1)
 S PDXE=$$PDXE^ICDEX(IEN) I PDXE>0 D  K:FMT'>0 ^TMP(SUB,$J) Q NCNT
 . S (NIEN,NCNT)=0 F  S NIEN=$O(^ICDCCEX(+PDXE,1,NIEN)) Q:+NIEN'>0  D
 . . N CODE,NCC S NCC=$P($G(^ICDCCEX(+PDXE,1,+NIEN,0)),"^",1) Q:+NCC'>0
 . . S CODE=$P($G(^ICD9(NCC,0)),"^",1) Q:'$L(CODE)  Q:$D(^TMP(SUB,$J,"B",(CODE_" ")))
 . . S NCNT=NCNT+1,^TMP(SUB,$J,NCNT)=CODE,^TMP(SUB,$J,"B",(CODE_" "),NCNT)=""
 . . S ^TMP(SUB,$J,0)=NCNT
 I ICDCS=1!(ICDCS=2) S (NIEN,NCNT)=0 F  S NIEN=$O(^ICD9(IEN,2,NIEN)) Q:+NIEN'>0  D
 . N CODE,NCC S NCC=$P($G(^ICD9(IEN,2,NIEN,0)),"^",1) Q:+NCC'>0
 . S CODE=$P($G(^ICD9(NCC,0)),"^",1) Q:'$L(CODE)
 . Q:$D(^TMP(SUB,$J,"B",(CODE_" ")))
 . S NCNT=NCNT+1,^TMP(SUB,$J,NCNT)=CODE,^TMP(SUB,$J,"B",(CODE_" "),NCNT)=""
 . S ^TMP(SUB,$J,0)=NCNT
 K:FMT'>0 ^TMP(SUB,$J)
 Q NCNT
 Q
PDXE(IEN) ; Primary DX Exclusion Code
 ;
 ; Input 
 ; 
 ;   IEN     Internal Entry Number (IEN) for file #80
 ;   
 ; Output
 ; 
 ;   $$PDXE  Pointer to DRG CC Exclusions file #82.13 
 ;           or <null> if not found
 Q $P($G(^ICD9(+($G(IEN)),1)),"^",11)
TM(X,Y) ; Trim Character
 ;
 ; Input:
 ;
 ;   X     Input String
 ;   Y     Character to Trim (default " ")
 ;
 ; Output:
 ; 
 ;   X     String without Leading/Trailing character Y
 ;
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
