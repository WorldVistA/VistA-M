LEXERF ; ISL Functions for Exc/Rep Words          ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
EXIST(X) ; Boolean function returns:
 ;    0    If X will result in a unsuccessful search (not found)
 ;    1    If X will result in a successful search (found)
 ;   IFN   If X has an exact match (found)
 Q:'$D(X) 0 Q:X="" 0
 I $D(^LEX(757.01,"AB",$$UP^XLFSTR(X))) Q $O(^LEX(757.01,"AB",$$UP^XLFSTR(X),0))
 N LEXOK D PTX^LEXTOLKN S LEXOK=1
 I '$D(^TMP("LEXTKN",$J,0)) K ^TMP("LEXTKN"),LEXOK Q 0
 I ^TMP("LEXTKN",$J,0)<1 K ^TMP("LEXTKN"),LEXOK Q 0
 I ^TMP("LEXTKN",$J,0)=1 D  K ^TMP("LEXTKN"),LEXKEY,LEXKEY2 Q LEXOK
 . S LEXKEY=$O(^TMP("LEXTKN",$J,1,""))
 . S:$L(LEXKEY)>1 LEXKEY2=$E(LEXKEY,1,$L(LEXKEY)-1)_$C($A($E(LEXKEY,$L(LEXKEY)))-1)_"~"
 . S:$L(LEXKEY)=1 LEXKEY2=$C($A(LEXKEY)-1)_"~"
 . S:$G(LEXKEY2)="" LEXKEY2=""
 . S:LEXKEY="" LEXOK=0 Q:LEXKEY=""
 . I $O(^LEX(757.01,"AWRD",LEXKEY2))[LEXKEY S LEXOK=1 Q
 . S LEXOK=0
 N LEXKEY,LEXKEY2,LEXREC,LEXWRD,LEXOTH,LEXCNT
 S (LEXOK,LEXREC)=0,LEXKEY=$O(^TMP("LEXTKN",$J,1,""))
 S LEXKEY2=$S($L(LEXKEY)>1:$E(LEXKEY,1,$L(LEXKEY)-1)_$C($A($E(LEXKEY,$L(LEXKEY)))-1)_"~",$L(LEXKEY)=1:$C($A(LEXKEY)-1)_"~",1:"")
 I LEXKEY2="" K LEXKEY,LEXKEY2,LEXREC,LEXWRD,LEXOTH,LEXCNT Q 0
 F  S LEXKEY2=$O(^LEX(757.01,"AWRD",LEXKEY2)) Q:LEXKEY2'[LEXKEY!(LEXOK)  D
 . S LEXREC=0 F  S LEXREC=$O(^LEX(757.01,"AWRD",LEXKEY2,LEXREC)) Q:+LEXREC=0!(LEXOK)  D
 . . S (LEXCNT,LEXWRD)=1,LEXOTH="" F  S LEXWRD=$O(^TMP("LEXTKN",$J,LEXWRD)) Q:+LEXWRD=0  D
 . . . S LEXOTH=$O(^TMP("LEXTKN",$J,LEXWRD,""))
 . . . S:$$UP^XLFSTR($G(^LEX(757.01,LEXREC,0)))[$$UP^XLFSTR(LEXOTH) LEXCNT=LEXCNT+1
 . . . S:LEXCNT=^TMP("LEXTKN",$J,0) LEXOK=1 S:LEXCNT'=^TMP("LEXTKN",$J,0) LEXOK=0
 K ^TMP("LEXTKN"),LEXKEY,LEXWRD,LEXREC,LEXCNT,LEXOTH Q LEXOK
ADDEXC(X) ; Boolean function returns:
 ;    0    Not OK to add X to the Excluded Words file #757.04
 ;    1    OK to add X to the Excluded Words file #757.04
 Q:X="" 0
 I +(+($$ISEXC(X))+($$ISREP(X))+($$ISBY(X)))>0 Q 0
 Q 1
ISREP(X) ; Boolean function returns:
 ;    0    If X is not a "Replacement" word
 ;    1    If X is a "Replacement" word
 Q:X="" 0 Q:$D(^LEX(757.05,"AB",$$UP^XLFSTR(X))) 1 Q 0
ISBY(X) ; Boolean function returns:
 ;    0    If X is not a "Replacement" term
 ;    1    If X is a "Replacement" term
 Q:X="" 0 Q:$D(^LEX(757.04,"C",$$UP^XLFSTR(X))) 1 Q 0
ISEXC(X) ; Boolean function returns:
 ;    0    If X is not an "Excluded" word
 ;   IFN   If X is an "Excluded" word
 Q:X="" 0
 I $D(^LEX(757.04,"AB",$$UP^XLFSTR(X))) Q $O(^LEX(757.04,"AB",$$UP^XLFSTR(X),0))
 Q 0
