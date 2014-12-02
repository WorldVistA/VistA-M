ICDTOKN ;DLS/DEK - Parse Text ;04/21/2014
 ;;18.0;DRG Grouper;**57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 Q
TOK(X) ;   Parse Text into Tokens in array PARS()
 K PARS D PAR($G(X),.PARS,1)
 Q
TOKEN(X,ROOT,SYS,ARY) ;   Parse Text into Tokens
 ;
 ; Input 
 ; 
 ;   X      Text (Required)
 ;   
 ;   ROOT   Global Root/File # (Required)
 ;   
 ;             ^ICD9(   or 80
 ;             ^ICD0(   or 80.1
 ;             
 ;   SYS    Coding System  (Required)
 ;   
 ;              1  or  ICD  or  ICD-9-CM
 ;              2  or  ICP  or  ICD-9 Proc
 ;             30  or  10D  or  ICD-10-CM
 ;             31  or  10P  or  ICD-10-PCS
 ;
 ;  .ARY    Output array passed by reference (Required)
 ;  
 ;          This is an array of words parsed from the input
 ;          string X arranged by frequency of use
 ;  
 ;          ARY(0)=# of words
 ;          ARY(#)=word
 ;          
 ;          The least frequently used word will be ARY(1)
 ;          and the most frequently used word will be 
 ;          ARY($O(ARY(" "),-1)).  words not found in
 ;          the file and coding system will not appear in
 ;          the parsed array.
 ;          
 ; D TOKEN^ICDTOKN($G(X),$G(ROOT),$G(SYS),.ARY) is called
 ; TOKEN^ICDEX to parse words in use order
 ;
 N TMP,ORD,NUM,IEN,USAGE,ABBR,TOKEN K ARY,TMP,ORD S ROOT=$$ROOT^ICDEX($G(ROOT)),SYS=$$SYS^ICDEX($G(SYS)) D PAR($G(X),.TMP)
 K ORD S IEN=0 F  S IEN=$O(TMP(IEN)) Q:+IEN'>0  D
 . N NUM,SEG S SEG=$G(TMP(IEN)) Q:$L(SEG)'>1
 . S USAGE=$$CT(SEG,ROOT,SYS),ABBR=+($P(USAGE,"^",2)),USAGE=+USAGE
 . S NUM=$O(ORD(+USAGE," "),-1)+1
 . S ORD(+USAGE,NUM)=SEG
 . S:ABBR>0 ORD(+USAGE,NUM,"A")=1
 K ARY S USAGE="" F  S USAGE=$O(ORD(USAGE)) Q:'$L(USAGE)  D
 . N NUM S NUM=0 F  S NUM=$O(ORD(USAGE,NUM)) Q:+NUM'>0  D
 . . N SEG,INC S SEG=$G(ORD(USAGE,NUM)) Q:'$L(SEG)
 . . S INC=$O(ARY(" "),-1)+1,ARY(INC)=SEG
 . . S:+($G(ORD(+USAGE,NUM,"A")))>0 ARY(INC,"A")=1
 K TMP,ORD S IEN=0 F  S IEN=$O(ARY(IEN)) Q:+IEN'>0  S ARY(0)=$G(ARY(0))+1
 Q
CT(SEG,ROOT,SYS) ; Count Usage
 S SEG=$G(SEG) Q:'$L(SEG) 0  S ROOT=$G(ROOT) Q:'$L(ROOT) 0  S SYS=+($G(SYS))
 N EROOT,IEN,CNT,ABR S (ABR,CNT)=0
 S EROOT=ROOT_"""D""," S:+SYS>0&($D(@(ROOT_"""AD"","_+SYS_")"))) EROOT=ROOT_"""AD"","_+SYS_","
 I $D(@(EROOT_""""_SEG_""")")) D
 . N IEN S IEN=0 F  S IEN=$O(@(EROOT_""""_SEG_""","_+IEN_")")) Q:+IEN'>0  D
 . . S CNT=CNT+1 N EFF S EFF="" F  S EFF=$O(@(EROOT_""""_SEG_""","_+IEN_","""_EFF_""")")) Q:'$L(EFF)!(EFF'?7N)  D
 . . . N TIEN S TIEN=0 F  S TIEN=$O(@(EROOT_""""_SEG_""","_+IEN_","""_EFF_""","_+TIEN_")")) Q:+TIEN'>0  D
 . . . . S:$O(@(EROOT_""""_SEG_""","_+IEN_","""_EFF_""","_+TIEN_",0)"))>0 ABR=ABR+1
 I '$D(@(EROOT_""""_SEG_""")")) D
 . N ORD,IEN S ORD=$E(SEG,1,($L(SEG)-1))_$C(($A($E(SEG,$L(SEG)))-1))_"~"
 . F  S ORD=$O(@(EROOT_""""_ORD_""")")) Q:$E(ORD,1,$L(SEG))'=SEG  D
 . . S IEN=0 F  S IEN=$O(@(EROOT_""""_ORD_""","_+IEN_")")) Q:+IEN'>0  D
 . . . S CNT=CNT+1 N EFF S EFF="" F  S EFF=$O(@(EROOT_""""_SEG_""","""_EFF_""")")) Q:'$L(EFF)!(EFF'?7N)  D
 . . . . N TIEN S TIEN=0 F  S TIEN=$O(@(EROOT_""""_SEG_""","""_EFF_""","_+TIEN_")")) Q:+TIEN'>0  D
 . . . . . S:$O(@(EROOT_""""_SEG_""","_+IEN_","""_EFF_""","_+TIEN_",0)"))>0 ABR=ABR+1
 S ABR=$S(CNT>0&(CNT=ABR):1,1:0) S CNT=CNT_"^"_ABR
 Q CNT
PAR(X,ARY,FLG) ;   Parse
 ;
 ; Called by ICDIDX for indexing words
 ;   D PAR^ICDTOKN($G(X),.ARY,0)
 ;   
 ; Called by ICDEXLK3 for lookup of words
 ;   D PAR^ICDTOKN($G(X),.PARS,1)
 ;   
 N BEG,END,CHR,I,NUM,TXT,PIE S TXT=$$UP^XLFSTR(X),TXT=$$SWAP(TXT)
 K ARY S BEG=1 F END=1:1:$L(TXT)+1 D
 . S CHR=$E(TXT,END) I "~!@#$%&*()_+`-=[]{};'\:|,./?<> """[CHR D
 . . S PIE=$E(TXT,BEG,END-1),BEG=END+1
 . . I $L(PIE)>1,$L(PIE)<31,$$EXC(PIE) D
 . . . Q:$D(ARY("B",PIE))  N I,NUM S NUM=(246-$L(PIE))
 . . . I +($G(FLG))'>0 S I=$O(ARY(" "),-1)+1,ARY(I)=PIE,ARY("B",PIE)="" Q
 . . . S I=$O(ARY(+($G(NUM))," "),-1)+1,ARY(+($G(NUM)),I)=PIE,ARY("B",PIE)=""
 K ARY("B") S NUM=0 F  S NUM=$O(ARY(NUM)) Q:+NUM'>0  D
 . I +($G(FLG))'>0 S ARY(0)=$G(ARY(0))+1 Q
 . N I S I=0 F  S I=$O(ARY(NUM,I)) Q:+I'>0  S ARY(0)=$G(ARY(0))+1
 Q
EXC(X) ;   Exclusions
 Q:$L($G(X))'>1 0
 Q:"^ABOUT^AFTER^ALMOST^ALSO^ALTHOUGH^AND^ANOTHER^"[("^"_$G(X)_"^") 0
 Q:"^ANY^ARE^AREA^AREAS^AT^BE^BEEN^BEFORE^BEST^BUT^"[("^"_$G(X)_"^") 0
 Q:"^BY^CAN^COULD^DONE^EACH^EVEN^FAR^FOR^FORM^FORMS^"[("^"_$G(X)_"^") 0
 Q:"^FROM^GIVEN^HAD^HAVE^HER^HERE^HERSELF^HIM^"[("^"_$G(X)_"^") 0
 Q:"^HIMSELF^HIS^HOW^IN^INTO^IS^IT^IT'S^ITS^ITS'^"[("^"_$G(X)_"^") 0
 Q:"^ITSELF^KIND^LIKE^LOST^MANY^MAY^MERE^MORE^MOST^"[("^"_$G(X)_"^") 0
 Q:"^MUST^NEW^NOTE^NOW^OF^OFTEN^ON^ONESELF^ONLY^"[("^"_$G(X)_"^") 0
 Q:"^OR^OUR^OURS^OUT^OWN^PUT^SAME^SET^SHOULD^SOME^"[("^"_$G(X)_"^") 0
 Q:"^SUCH^STATED^SURE^THAN^THAT^THE^THEN^THERE^THEREBY^"[("^"_$G(X)_"^") 0
 Q:"^THESE^THEY^THIS^THUS^TO^TOO^UPON^WAS^"[("^"_$G(X)_"^") 0
 Q:"^WHAT^WHEN^WHERE^WHICH^WHO^WHOSE^WITHIN^"[("^"_$G(X)_"^") 0
 Q:"^WOULD^"[("^"_$G(X)_"^") 0
 Q 1
 ;
SWAP(X) ; Special Case Word Swap
 ;
 ;   This sub-routine swaps one word for another
 ;   This swap must apply to both Lookup and Indexing
 ;   This swap only applies to uppercase text
 ;   These words cannot be Replacement Words in file 757.05
 ;   
 N TXT S (X,TXT)=$G(X) Q:'$L(TXT) X
 S (X,TXT)=$$UP^XLFSTR(X) N SEG
 F SEG="X-RAY","X RAY" D
 . I TXT[SEG S TXT=$$SW(TXT,SEG,"XRAY")
 F SEG="E.COLI","E COLI","E. COLI" D
 . I TXT[SEG S TXT=$$SW(TXT,SEG,"ECOLI")
 S X=$G(TXT)
 Q X
SW(X,SEG1,SEG2) ; Swap text SEG1 for SEG2 in X
 ; 
 ; Input
 ; 
 ;    X      Text string
 ;    SEG1   Word to remove in string (replace)
 ;    SEG2   Word to insert in string (with)
 ;    
 ; Output
 ; 
 ;    X      Text string without SEG1
 ;    
 N TXT,NOT,CHR,LEAD,TRAIL S (X,TXT)=$G(X) Q:'$L(TXT) X  S SEG1=$G(SEG1)
 Q:'$L(SEG1) X  S SEG2=$G(SEG2) Q:'$L(SEG2) X  Q:TXT'[SEG1 X
 S NOT="~!@#$%^&*()_+`{}|[]\:;'<>?,./" I TXT=SEG1 S X=SEG2 Q X
 I $E(TXT,1,$L(SEG1))=SEG1 D
 . N CHR S CHR=$E(TXT,($L(SEG1)+1)) Q:CHR'=" "
 . S TXT=SEG2_$E(TXT,($L(SEG1)+1),$L(TXT))
 F LEAD=" ","-","(","<","{","[","," D
 . N REP,WIT F TRAIL=" ","-",")",">","}","]","," D
 . . N REP,WIT
 . . S REP=LEAD_SEG1_TRAIL,WIT=LEAD_SEG2_TRAIL
 . . Q:TXT'[REP
 . . F  Q:TXT'[REP  S TXT=$P(TXT,REP,1)_WIT_$P(TXT,REP,2)
 . S REP=LEAD_SEG1,WIT=LEAD_SEG2
 . I TXT[REP,$L($P(TXT,REP,1)),'$L($P(TXT,REP,2)) D
 . . S TXT=$P(TXT,REP,1)_WIT
 S X=$G(TXT)
 Q X
