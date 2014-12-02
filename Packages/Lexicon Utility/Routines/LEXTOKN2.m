LEXTOKN2 ;ISL/KER - Parse term into words - Special Case ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEXLOW   Set of lower case is needed (LEXNDX2)
 ;               
 Q
SW(X) ; Special Case Word Swap
 ;
 ;   This sub-routine swaps one word for another
 ;   This swap must apply to both Lookup and Indexing
 ;   This swap only applies to uppercase text
 ;   These words cannot be Replacement Words in file 757.05
 ;   
 N LEXTXT S (X,LEXTXT)=$G(X) Q:'$L(LEXTXT) X
 I '$D(LEXLOW) D  Q X
 . S (X,LEXTXT)=$$UP^XLFSTR(X) N LEXI
 . F LEXI="X-RAY","X RAY" D
 . . I LEXTXT[LEXI S LEXTXT=$$SWAP(LEXTXT,LEXI,"XRAY")
 . F LEXI="E.COLI","E COLI","E. COLI" D
 . . I LEXTXT[LEXI S LEXTXT=$$SWAP(LEXTXT,LEXI,"ECOLI")
 . S X=$G(LEXTXT)
 I $D(LEXLOW) D
 . S (X,LEXTXT)=X N LEXI
 . F LEXI="X-RAY","X RAY","X-Ray","X Ray","X-ray","X ray","x-ray","x ray" D
 . . I LEXTXT[LEXI S LEXTXT=$$SWAP(LEXTXT,LEXI,"XRay")
 . F LEXI="E COLI","E. COLI","E.COLI","ECOLI","E Coli","E. Coli","E.Coli","EColi" D
 . . I LEXTXT[LEXI S LEXTXT=$$SWAP(LEXTXT,LEXI,"EColi")
 . F LEXI="E coli","E. coli","E.coli","Ecoli","e coli","e. coli","e.coli","ecoli" D
 . . I LEXTXT[LEXI S LEXTXT=$$SWAP(LEXTXT,LEXI,"EColi")
 S X=LEXTXT
 Q X
SWAP(X,LEX1,LEX2) ; Swap text LEX1 for LEX2 in X
 ; 
 ; Input
 ; 
 ;    X      Text string
 ;    LEX1   Word to remove in string (replace)
 ;    LEX2   Word to insert in string (with)
 ;    
 ; Output
 ; 
 ;    X      Text string without LEX1
 ;    
 N LEXTXT,LEXNOT,LEXC,LEXLC,LEXTC S (X,LEXTXT)=$G(X) Q:'$L(LEXTXT) X  S LEX1=$G(LEX1)
 Q:'$L(LEX1) X  S LEX2=$G(LEX2) Q:'$L(LEX2) X  Q:LEXTXT'[LEX1 X
 S LEXNOT="~!@#$%^&*()_+`{}|[]\:;'<>?,./" I LEXTXT=LEX1 S X=LEX2 Q X
 I $E(LEXTXT,1,$L(LEX1))=LEX1 D
 . N LEXC S LEXC=$E(LEXTXT,($L(LEX1)+1)) Q:LEXC'=" "
 . S LEXTXT=LEX2_$E(LEXTXT,($L(LEX1)+1),$L(LEXTXT))
 F LEXLC=" ","-","(","<","{","[","," D
 . N LEXO,LEXN F LEXTC=" ","-",")",">","}","]","," D
 . . N LEXO,LEXN
 . . S LEXO=LEXLC_LEX1_LEXTC,LEXN=LEXLC_LEX2_LEXTC
 . . Q:LEXTXT'[LEXO
 . . F  Q:LEXTXT'[LEXO  S LEXTXT=$P(LEXTXT,LEXO,1)_LEXN_$P(LEXTXT,LEXO,2)
 . S LEXO=LEXLC_LEX1,LEXN=LEXLC_LEX2
 . I LEXTXT[LEXO,$L($P(LEXTXT,LEXO,1)),'$L($P(LEXTXT,LEXO,2)) D
 . . S LEXTXT=$P(LEXTXT,LEXO,1)_LEXN
 S X=$G(LEXTXT)
 Q X
ORD ; Arrange in Frequency Order
 ; 
 ; Input
 ;  
 ;    ^TMP("LEXTKN",$J,#,WORD)=""
 ;    
 ;    Global array containing words parsed from text from
 ;    API PTX^LEXTOKN
 ;    
 ;    "DIABETES MELLITUS KETOACIDOSIS" Parsed as:
 ;    
 ;       ^TMP("LEXTKN",$J,0)=3
 ;       ^TMP("LEXTKN",$J,1,"DIABETES")=
 ;       ^TMP("LEXTKN",$J,2,"MELLITUS")=
 ;       ^TMP("LEXTKN",$J,3,"KETOACIDOSIS")=
 ;    
 ; Output
 ; 
 ;    ^TMP("LEXTKN",$J,#,WORD)=FREQ
 ;    
 ;    Global array containing words parsed from text arranged
 ;    in order of the frequency of use, the least used word is
 ;    first and the most frequently used word is last.
 ;
 ;    "DIABETES MELLITUS KETOACIDOSIS" Reordered to:
 ;    
 ;       ^TMP("LEXTKN",$J,0)=3
 ;       ^TMP("LEXTKN",$J,1,"KETOACIDOSIS")=60
 ;       ^TMP("LEXTKN",$J,2,"MELLITUS")=811
 ;       ^TMP("LEXTKN",$J,3,"DIABETES")=1101
 ;    
 ; The Lexicon searches terms containing the least used word 
 ; and checks to see if the remaining words are found in the
 ; term.  Instead of checking 1101 terms for MELLITUS and 
 ; KETOACIDOSIS, it will check 60 terms for DIABETES and MELLITUS.
 ; 
 N LEXI,LEXA,LEXC,LEXF S LEXI=0 F  S LEXI=$O(^TMP("LEXTKN",$J,LEXI)) Q:+LEXI'>0  D
 . N LEXT S LEXT="" F  S LEXT=$O(^TMP("LEXTKN",$J,LEXI,LEXT)) Q:'$L(LEXT)  D
 . . N LEXF S LEXF=+($O(^LEX(757.01,"ASL",LEXT,0))) Q:LEXF'>0  S LEXA(+LEXF,LEXT)=LEXF
 K ^TMP("LEXTKN",$J) S LEXI=0 F  S LEXI=$O(LEXA(LEXI)) Q:+LEXI'>0  D
 . N LEXT S LEXT="" F  S LEXT=$O(LEXA(LEXI,LEXT)) Q:'$L(LEXT)  D
 . . N LEXC S LEXC=$O(^TMP("LEXTKN",$J," "),-1)+1,^TMP("LEXTKN",$J,LEXC,LEXT)=LEXI,^TMP("LEXTKN",$J,0)=LEXC
 Q
ST ; Show ^TMP("LEXTKN")
 N LEXNN,LEXNC,LEXLOW S LEXNN="^TMP(""LEXTKN"","_$J_")",LEXNC="^TMP(""LEXTKN"","_$J_","
 F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  W !,LEXNN,"=",@LEXNN
 Q 
