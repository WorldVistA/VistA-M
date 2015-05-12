ICDEXLK5 ;SLC/KER - ICD Extractor - Lookup, EXM/IEN/List ;12/19/2014
 ;;18.0;DRG Grouper;**57,67**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^ICDS(              N/A
 ;    ^TMP(SUB,$J         SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$MIX^LEXXM         ICR   5781
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;    
 ; Marked Items
 ;    $T(MIX^LEXXM)
 ;    
 ; Local Variables Newed or Killed by calling application
 ;     DIC(0)    Fileman Lookup Parameters
 ;     DIC("S")  Fileman Screen
 ;     
 ; Local Variables Newed or Killed Elsewhere
 ;     ICDBYCD   Sort by Code
 ;     ICDCDT    Code Set Date
 ;     ICDOUT    Format of display
 ;     ICDVDT    Date to use during lookup 
 ;     ICDSYS    Coding System
 ;     ICDVER    Versioned Lookup
 ;     ICDDICS   Screen
 ;     INP2      User Input (processed)
 ;     LOUD      Output to Screen
 ;     
 Q
EXM(TXT,ROOT,Y,CDT,SYS,VER) ; Lookup Exact Match
 ;
 ;   Input   TXT    Text/Code for search (Required)
 ;           ROOT   Global Root (Required)
 ;          .Y      Output array passed by reference (Required)
 ;           CDT    Date
 ;           SYS    Coding System
 ;           VER    Versioned Search
 ;   
 ;   Output  $$EM   Number of Exact Matches Found
 ;           Y(n)   Array of Exact Matches
 ;   
 N EXM,KEY,ORD,ICDI,IEN,NUM,ORG,EROOT S ORG=$G(TXT) Q:'$L($G(ORG)) 0
 Q:'$L($TR(ORG,"""","")) 0  S ROOT=$G(ROOT)  Q:'$L($G(ROOT)) 0
 S SYS=+($G(SYS)),VER=+($G(VER))
 S CDT=$$CDT^ICDEXLK3($G(CDT),SYS)
 ; Exact Match Case Sensitive Code
 S KEY=ORG,KEY=ORG S ORD=$E(KEY,1,($L(KEY)-1))_$C(($A($E(KEY,$L(KEY)))-1))_"~ "
 S EROOT=ROOT_"""BA""," S:+SYS>0&($D(@(ROOT_"""ABA"","_+SYS_")"))) EROOT=ROOT_"""ABA"","_+SYS_","
 F  S ORD=$O(@(EROOT_""""_ORD_""")")) Q:'$$ISORD  D
 . S IEN=0 F  S IEN=$O(@(EROOT_""""_ORD_""","_+IEN_")")) Q:+IEN'>0  D
 . . N VAL,STA S STA=1
 . . S:VER>0 STA=$$LS^ICDEXLK3(ROOT,IEN,CDT)
 . . Q:+($G(VER))>0&(+STA'>0)
 . . S VAL=$P($G(@(ROOT_+IEN_",0)")),"^",1)
 . . Q:VAL'=ORG  S EXM(IEN)="",LOR=1
 ; Exact Match Code
 I $O(EXM(0))'>0 D
 . S KEY=$$UP^XLFSTR(ORG),KEY=ORG S ORD=$E(KEY,1,($L(KEY)-1))_$C(($A($E(KEY,$L(KEY)))-1))_"~ "
 . S EROOT=ROOT_"""BA""," S:+SYS>0&($D(@(ROOT_"""ABA"","_+SYS_")"))) EROOT=ROOT_"""ABA"","_+SYS_","
 . F  S ORD=$O(@(EROOT_""""_ORD_""")")) Q:'$$ISORD  D
 . . S IEN=0 F  S IEN=$O(@(EROOT_""""_ORD_""","_+IEN_")")) Q:+IEN'>0  D
 . . . N VAL,STA S STA=1 S:VER>0 STA=$$LS^ICDEXLK3(ROOT,IEN,CDT)
 . . . Q:+($G(VER))>0&(+STA'>0)
 . . . S VAL=$P($G(@(ROOT_+IEN_",0)")),"^",1)
 . . . Q:VAL'=ORG  S EXM(IEN)="",LOR=1
 ; Exact Match Text
 I $O(EXM(0))'>0 D
 . Q:$D(ICDBYCD)  S KEY=$$UP^XLFSTR($G(ORG)) K PARS D TOKEN^ICDEXLK3(KEY,ROOT,SYS,.PARS)
 . S NUM=$O(PARS(0)),SEQ=$O(PARS(+NUM,0)),KEY=$G(PARS(+NUM,+SEQ))
 . K PARS(+NUM,+SEQ)  Q:$L(KEY)'>1
 . S ORD=$E(KEY,1,($L(KEY)-1))_$C(($A($E(KEY,$L(KEY)))-1))_"~"
 . S EROOT=ROOT_"""D""," S:+SYS>0&($D(@(ROOT_"""AD"","_+SYS_")"))) EROOT=ROOT_"""AD"","_+SYS_","
 . F  S ORD=$O(@(EROOT_""""_ORD_""")")) Q:'$$ISORD  D
 . . S IEN=0 I $G(DIC(0))["X",ORD'=KEY Q
 . . F  S IEN=$O(@(EROOT_""""_ORD_""","_+IEN_")")) Q:+IEN'>0  D
 . . . N VAL,STA S STA=1 S:VER>0 STA=$$LS^ICDEXLK3(ROOT,IEN,CDT)
 . . . Q:+($G(VER))>0&(+STA'>0)
 . . . S VAL=$$LD^ICDEXLK3(ROOT,IEN,CDT,VER)
 . . . Q:$$UP^XLFSTR(VAL)'=$$UP^XLFSTR(ORG)
 . . . S EXM(IEN)="",LOR=0
 S (X,IEN)=0 F  S IEN=$O(EXM(IEN)) Q:+IEN'>0  D
 . N ICDI S ICDI=$O(Y(" "),-1)+1,Y(ICDI)=IEN,(X,Y(0))=ICDI
 Q X
IEN ; Lookup by IEN
 K Y S ICDOFND=0,Y=-1 Q:'$L(INP2)  Q:INP2'?1N.N  Q:+INP2'>0  Q:'$L(ROOT)  Q:+FILE'>0
 N XX,VDES,UDES,IEN,SNAME,ICS,INAME,STA,ORG S IEN=INP2 Q:'$D(@(ROOT_+IEN_",0)"))
 S ORG="`"_IEN,VDES=$$LD^ICDEX(FILE,IEN,ICDCDT),UDES=$$LD^ICDEX(FILE,IEN,9999999)
 S ICS=$$CSI^ICDEX(FILE,IEN),XX=VDES,(SNAME,INAME)=$$SYS^ICDEX(ICS,,"E")
 S:$L($G(ICDSYS)) SNAME=$$SYS^ICDEX($G(ICDSYS),,"E")
 S STA=$$LS^ICDEX(FILE,IEN,$G(ICDCDT))
 I $L($G(ICDSYS))>0,ICS>0,$G(ICDSYS)'=ICS D  Q
 . K X,Y S X="" S:$L($G(ORG)) X=$G(ORG) S Y=-1,ICDOFND=0 Q
 . S X=UDES,Y="-1^IEN "_IEN_" is not of the "_SNAME_" coding system"
 I +($G(ICDVER))>0,STA'>0 D  Q
 . K X,Y S X="" S:$L($G(ORG)) X=$G(ORG) S Y=-1,ICDOFND=0 Q
 . S X=UDES,Y="-1^IEN "_IEN_" is not active on "_$$FMTE^XLFDT($G(ICDCDT),"5Z")
 I +($G(ICDVER))'>0,$E(XX,1,2)="-1",$L(UDES),$E(UDES,1,2)'="-1" S XX=UDES
 W:$D(LOUD)&($G(DIC(0))["E")&($E(XX,1,2)'="-1") "   ",XX
 D FND(ROOT,IEN,ICDCDT,$G(ICS),$G(ICDVER),+($G(LOR)),$G(ICDOUT))
 D SEL(ROOT,1) I +($G(^TMP(SUB,$J,"SEL",1)))>0 D
 . S ICDOFND=1 N ANS S ANS=$$ONE^ICDEXLK2
 . I ANS'>0 D  Q
 . . S ICDOFND=0,X=""
 . . ;+($G(^TMP(SUB,$J,"SEL",1)))
 . . S Y=-1 K ^TMP(SUB,$J,"SEL") Q
 . D X^ICDEXLK2(1,SUB) S (ICDOFND,ICDOSEL,ICDOREV)=1
 . D Y^ICDEXLK2($G(ROOT),+($G(^TMP(SUB,$J,"SEL",1))),$G(ICDCDT))
 . I +($G(Y))'>0,$L($G(INP)) S X=$G(INP) Q
 . I +($G(Y))>0 D:$G(DIC(0))'["F" SAV^ICDEXLK6(+($G(Y)),ROOT)
 K ^TMP(SUB,$J,"SEL")
 Q
 ;
FND(ROOT,IEN,CDT,SYS,VER,LOR,OUT) ; Add Item to Found List
 ;
 ; Input
 ; 
 ;    ROOT   Global Root
 ;    IEN    Internal Entry Number
 ;    CDT    Date
 ;    SYS    Coding System
 ;    VER    Versioned Search
 ;    LOR    List Order
 ;             0  List by Text Length
 ;             1  List by Code Number
 ;    OUT    Output Format
 ;             1  Fileman, code and short text
 ;             2  Fileman, code and description
 ;             3  Lexicon, short text and code
 ;             4  Lexicon, description and code
 ;
 ; Output
 ; 
 ;    ^TMP(ID,$J,"FND")
 ;    ^TMP(ID,$J,"FND",LEN,SEQ)=IEN ^ Display Text
 ;    ^TMP(ID,$J,"FND","IEN",<ien>)=""
 ;  
 ;      where
 ;      
 ;         ID is a package namespaced subscript:
 ;        
 ;            ICD9 - for file #80 searches
 ;            ICD0 - for file #80.1 searches
 ;      
 ;         LEN is a number assigned based string length
 ;         SEQ is a unique sequence number for length
 ;                
 ;   Uses   DIC("S") to screen output
 ; 
 N CC,CODE,CTR,FILE,SEQ,SCREEN,SHORT,LONG,STATUS,STA,SUB,TEXT,TERM,TYP,NUM,Y
 S SYS=+($G(SYS)),VER=+($G(VER)) S (Y,IEN)=+($G(IEN)) Q:+IEN'>0
 S ROOT=$$ROOT^ICDEX($G(ROOT)),FILE=$$FILE^ICDEX(ROOT)
 S SUB=$TR(ROOT,"^("),SCREEN=$$SCREEN Q:'SCREEN  Q:+FILE'>0
 S CODE=$P($G(@(ROOT_+IEN_",0)")),"^",1) Q:'$L(CODE)
 S:'$L($G(CDT)) CDT=$$DT^XLFDT S LOR=+($G(LOR))
 S STA=1 I +VER>0 S STA=$$STATCHK^ICDEX(CODE,CDT,SYS) Q:+($G(STA))'>0
 Q:'$L(SUB)  Q:$D(^TMP(SUB,$J,"FND","IEN",+IEN))
 S TYP=$P($G(^ICDS(+SYS,0)),"^",1),TERM=""
 S OUT=$G(OUT) S:+OUT'>0 OUT=1 S:+OUT>4 OUT=1
 I +($G(OUT))=1!(+($G(OUT))=3) S TERM=$$SD^ICDEX(FILE,IEN,CDT)
 I +($G(OUT))=2!(+($G(OUT))=4) D
 . S TERM=$$LD^ICDEX(FILE,IEN,CDT) Q:$P(TERM,"^",1)=-1
 . I +($G(OUT))=4,$L($T(MIX^LEXXM)) S TERM=$$MIX^LEXXM(TERM)
 I VER'>0,($P(TERM,"^",1)=-1!('$L(TERM))) D
 . N TDT S TDT=$O(@(ROOT_IEN_",67,""B"","_+($G(CDT))_")")) Q:$E(TDT,1,7)'?7N
 . I +($G(OUT))=1!(+($G(OUT))=3) S TERM=$$SD^ICDEX(FILE,IEN,TDT)
 . I +($G(OUT))=2!(+($G(OUT))=4) S TERM=$$LD^ICDEX(FILE,IEN,TDT)
 . I +($G(OUT))=4,$P(TERM,"^",1)'=-1,$L($T(MIX^LEXXM)) S TERM=$$MIX^LEXXM(TERM)
 . S:$P(TERM,"^",1)=-1 TERM="" Q:'$L(TERM)
 . S:TDT?7N TERM=TERM_" ("_$$FMTE^XLFDT(TDT,"5ZM")_")"
 S:$P(TERM,"^",1)=-1 TERM="" Q:'$L(TERM)  S NUM=$$NUM^ICDEX(CODE)
 S CODE=CODE_$J(" ",(10-$L(CODE))) S CC=""
 S:FILE=80 CC=$$VCC^ICDEX(IEN,CDT),CC=$$CC(+CC)
 S STATUS=$O(@(ROOT_+IEN_",66,""B"","_(+CDT+.000001)_")"),-1)
 S STATUS=$O(@(ROOT_+IEN_",66,""B"","_+STATUS_","" "")"),-1)
 S STATUS=$P($G(@(ROOT_+IEN_",66,"_+STATUS_",0)")),"^",2)
 S STATUS=$$ST(STATUS)
 S:$G(OUT)'?1N OUT=$G(OUT) S:+OUT'>0 OUT=1 S:+OUT>4 OUT=4
 I +($G(OUT))=1!(+($G(OUT))=2) D
 . S:$G(DIC(0))'["S" TEXT=CODE_TERM_CC_STATUS
 . S:$G(DIC(0))["S" TEXT=TERM_CC_STATUS
 I +($G(OUT))=3!(+($G(OUT))=4) D
 . S CODE=$$TM(CODE),TEXT=TERM_CC_STATUS
 . Q:$G(DIC(0))["S"
 . S:$L(TYP) TEXT=TEXT_" ("_TYP_" "_CODE_")"
 . S:'$L(TYP) TEXT=TEXT_" ("_CODE_")"
 S SEQ=246-$L(TERM) S:LOR>0 SEQ=NUM
 S CTR=$O(^TMP(SUB,$J,"FND",+SEQ," "),-1)+1
 S ^TMP(SUB,$J,"FND",+SEQ,CTR)=IEN_"^"_TEXT
 S ^TMP(SUB,$J,"FND","IEN",+IEN)=""
 Q
SEL(ROOT,LOR) ; Add Items to Selection List
 ;
 ; Input   
 ;   
 ;   ROOT   Global Root/File # (Required)
 ;   LOR    List Order
 ;            0  List by Text Length
 ;            1  List by Code Number
 ;   
 ; Output
 ;   
 ;    ^TMP(ID,$J,"SEL")
 ;    ^TMP(ID,$J,"SEL",0)=# of entries
 ;    ^TMP(ID,$J,"SEL",#)=IEN^Display Text
 ;  
 ;      where ID is a package namespaced subscript:
 ;        
 ;       ICD9 - for the Diagnosis file #80
 ;       ICD0 - for the Operations/Procedure file #80.1
 ;       
 ; Uses    ^TMP(NAME,$J,"FND") (Optional)
 ; Kills   ^TMP(NAME,$J,"FND")
 ;   
 N CTR,FILE,SEQ,SUB,TEXT S ROOT=$$ROOT^ICDEX($G(ROOT)),LOR=+($G(LOR))
 S FILE=$$FILE^ICDEX(ROOT),SUB=$TR(ROOT,"^(") K ^TMP(SUB,$J,"SEL")
 Q:+FILE'>0  Q:'$L(SUB)  K ^TMP(SUB,$J,"SEL")
 I +($G(LOR))'>0 D
 . S SEQ=" " F  S SEQ=$O(^TMP(SUB,$J,"FND",SEQ),-1) Q:+SEQ'>0  D SEL2
 I +($G(LOR))>0 D
 . S SEQ=0 F  S SEQ=$O(^TMP(SUB,$J,"FND",SEQ)) Q:+SEQ'>0  D SEL2
 K ^TMP(SUB,$J,"FND")
 Q
SEL2 ;  Add Items to Selection List (part 2)
 N ICDI S ICDI=0 F  S ICDI=$O(^TMP(SUB,$J,"FND",+SEQ,ICDI)) Q:+ICDI'>0  D
 . N CTR,TEXT S TEXT=$G(^TMP(SUB,$J,"FND",+SEQ,ICDI))
 . Q:'$L(TEXT)  Q:+TEXT'>0  Q:'$L($P(TEXT,"^",2))
 . S CTR=$O(^TMP(SUB,$J,"SEL"," "),-1)+1
 . S ^TMP(SUB,$J,"SEL",CTR)=TEXT,^TMP(SUB,$J,"SEL",0)=CTR
 Q
 ;
 ; Miscellaneous
SH ;   Display TMP
 N SUB,NN,NC
 S SUB="ICD9" S:'$D(^TMP(SUB)) SUB="ICD0" Q:'$D(^TMP(SUB))
 S NN="^TMP("""_SUB_""","_$J_")",NC="^TMP("""_SUB_""","_$J_","
 W:'$D(@NN) ! Q:'$D(@NN)  F  S NN=$Q(@NN) Q:'$L(NN)!(NN'[NC)  W !,NN,"=",@NN
 W !
 Q
SCREEN(X) ;   Screen Entries - Boolean Truth Value
 Q:+($G(Y))'>0 1   Q:'$L($G(ROOT)) 1  N ICDNR,ICDO,ICDS,ICDY
 S ICDY=+($G(Y)),ROOT=$$ROOT^ICDEX($G(ROOT)) Q:'$L(ROOT) 1
 S ICDS=$G(ICDDICS) Q:'$L(ICDS) 1  S Y=+($G(ICDY))
 S ICDNR=$D(@(ROOT_+Y_",0)")) X ICDS S ICDO=$T
 Q:'ICDO 0
 Q 1
ISORD(X) ;   Check if in $ORDER
 Q:'$L($G(ORD)) 0  Q:'$L($G(KEY)) 0
 Q:$E($G(ORD),1,$L($G(KEY)))=$G(KEY) 1
 Q 0
CC(X) ;   CC
 Q:+($G(X))=1 " (CC)"
 Q:+($G(X))=2 " (Major CC)"
 Q ""
ST(X) ;   Status indicators
 Q:$G(X)?1N&(+$G(X)'>0) " (Inactive)"
 Q:$G(X)'?1N&(+$G(X)'>0) " (Pending)"
 Q ""
TM(X,Y) ;   Trim Y
 S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
