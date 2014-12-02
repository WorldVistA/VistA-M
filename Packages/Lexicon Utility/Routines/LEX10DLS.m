LEX10DLS ;ISL/KER - ICD-10 Diagnosis Lookup Selection ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^UTILITY($J         ICR  10011
 ;               
 ; External References
 ;    ^DIR                ICR  10026
 ;    ^DIWP               ICR  10011
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed in LEX10DL
 ;     DIROUT,DTOUT,DUOUT
 ;             
SEL(LEX,X) ; Select from List
 ;
 ; Input   
 ; 
 ;     X     Length of list to display (default 5)
 ;    .LEX   Local array passed by reference
 ;               
 ;             LEX()   Input Array from ICDSRCH^LEX10CS
 ;               
 ;             LEX(0)=# found ^ Pruning Indicator
 ;             LEX(1,0)=Code ^ Code IEN ^ date
 ;             LEX(1,"IDL")=ICD-9/10 Description, Long
 ;             LEX(1,"IDL",1)=ICD-9/10 IEN ^ date
 ;             LEX(1,"IDS")=ICD-9/10 Description, Short
 ;             LEX(1,"IDS",1)=ICD-9/10 IEN ^ date
 ;             LEX(1,"LEX")=Lexicon Description
 ;             LEX(1,"LEX",1)=Expression IEN ^ date
 ;             LEX(1,"SYN",1)=Synonym #1
 ;             LEX(1,"SYN",m)=Synonym #m
 ;             ...
 ;               
 ; Output
 ;               
 ;    $$SEL  Two Piece "^" delimited string same as
 ;           Fileman's Y output variable
 ;               
 ;             1  Lexicon IEN
 ;             2  Lexicon Term
 ;               
 ;    LEX    Local array passed by reference
 ;               
 ;             LEX(0)=Code ^ Code IEN ^ date
 ;             LEX("IDL")=ICD-9/10 Description, Long
 ;             LEX("IDL",1)=ICD-9/10 IEN ^ date
 ;             LEX("IDS")=ICD-9/10 Description, Short
 ;             LEX("IDS",1)=ICD-9/10 IEN ^ date
 ;             LEX("LEX")=Lexicon Description
 ;             LEX("LEX",1)=Expression IEN ^ date
 ;               
 ;    or ^ on error 
 ;    or -1 for non-selection
 ;               
 S X=+($G(X)) S:X'>0 X=5 S X=$$ASK(.LEX,X)
 Q X
ASK(LEX,X) ; Ask for Selection
 N LEXIT,LEXL,LEXTOT S LEXL=+($G(X)) S:LEXL'>0 LEXL=5
 S LEXIT=0,LEXTOT=$O(LEX(" "),-1) Q:+LEXTOT'>0 "^"
 K X S:+LEXTOT=1 X=$$ONE(LEXL,.LEX) S:+LEXTOT>1 X=$$MUL(.LEX,LEXL)
 S:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(X))'>0) X=-1
 Q X
ONE(X,LEX) ; One Entry Found
 Q:+($G(LEXIT))>0 "^^"  N DIR,LEXC,LEXEX,LEXFI,LEXIT,LEXSO,LEXNC
 N LEXSP,LEXTX,LEXC,Y S LEXFI=$O(LEX(0)) Q:+LEXFI'>0 "^"  S LEXSP=$J(" ",25)
 S LEXSO=$P(LEX(1,0),"^",1),LEXNC=$P(LEX(1,0),"^",3)
 S:+LEXNC>0 LEXNC=" ("_LEXNC_")" S LEXEX=$G(LEX(1,"MENU"))
 S LEXC=$S($D(LEX(1,"CAT")):"-",1:"")
 S LEXTX(1)=LEXSO_LEXC_$J(" ",(9-$L(LEXSO)))_" "_LEXEX_LEXNC
 D PR(.LEXTX,64) S DIR("A",1)=" One match found",DIR("A",2)=" "
 S DIR("A",3)=" "_$G(LEXTX(1)),LEXC=3 I $L($G(LEXTX(2))) D
 . S LEXC=LEXC+1,DIR("A",LEXC)=LEXSP_$G(LEXTX(2))
 S LEXC=LEXC+1,DIR("A",LEXC)=" ",LEXC=LEXC+1
 S DIR("A")=" OK? (Yes/No) ",DIR("B")="Yes",DIR(0)="YAO" W !
 D ^DIR Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) LEXIT=1
 I X["^^"!(+($G(LEXIT))>0) K LEX Q "^^"
 S X=$S(+Y>0:$$X(1,.LEX),1:-1)
 Q X
MUL(LEX,Y) ; Multiple Entries Found
 Q:+($G(LEXIT))>0 "^^"  N LEXE,LEXL,LEXMAX,LEXSS,LEXX,X
 S (LEXMAX,LEXSS,LEXIT)=0,LEXL=+($G(Y)),U="^" S:+($G(LEXL))'>0 LEXL=5
 S LEXX=$O(LEX(" "),-1),LEXSS=0
 G:+LEXX=0 MULQ W ! W:+LEXX>1 !," ",LEXX," matches found"
 F LEXE=1:1:LEXX Q:((LEXSS>0)&(LEXSS<(LEXE+1)))  Q:LEXIT  D  Q:LEXIT
 . W:LEXE#LEXL=1 ! D MULW
 . S LEXMAX=LEXE W:LEXE#LEXL=0 !
 . S:LEXE#LEXL=0 LEXSS=$$MULS(LEXMAX,LEXE,.LEX) S:LEXSS["^" LEXIT=1
 I LEXE#LEXL'=0,+LEXSS<=0 D
 . W ! S LEXSS=$$MULS(LEXMAX,LEXE,.LEX) S:LEXSS["^" LEXIT=1
 G MULQ
 Q X
MULW ; Write Multiple
 N LEXEX,LEXI,LEXSO,LEXNC,LEXT,LEXTX S LEXSO=$P(LEX(+LEXE,0),"^",1)
 S LEXNC=$P(LEX(+LEXE,0),"^",3) S:+LEXNC>0 LEXNC=" ("_LEXNC_")"
 S LEXEX=$G(LEX(+LEXE,"MENU")),LEXTX(1)=LEXSO
 S LEXTX(1)=LEXTX(1)_$S($D(LEX(+LEXE,"CAT")):"-",1:" ")_$J(" ",(9-$L(LEXSO)))_" "_LEXEX_LEXNC
 D PR(.LEXTX,60) W !,$J(LEXE,5),".  ",$G(LEXTX(1))
 F LEXI=2:1:5 S LEXT=$G(LEXTX(LEXI)) W:$L(LEXT) !,$J(" ",19),LEXT
 Q
MULS(X,Y,LEX) ; Select from Multiple Entries
 N DIR,DIRB,LEXFI,LEXHLP,LEXLAST,LEXMAX,LEXS
 Q:+($G(LEXIT))>0 "^^"  S LEXMAX=+($G(X)),LEXLAST=+($G(Y))
 Q:LEXMAX=0 -1 S LEXFI=$O(LEX(0)) Q:+LEXFI'>0 -1
 I +($O(LEX(+LEXLAST)))>0 D
 . S DIR("A")=" Press <RETURN> for more, ""^"" to exit, or Select 1-"
 . S DIR("A")=DIR("A")_LEXMAX_": "
 I +($O(LEX(+LEXLAST)))'>0 D
 . S DIR("A")=" Select 1-"_LEXMAX_": "
 S LEXHLP=" Answer must be from 1 to "
 S LEXHLP=LEXHLP_LEXMAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??"""
 S (DIR("?"),DIR("??"))="^D MULSH^LEX10DLS"
 S DIR(0)="NAO^1:"_LEXMAX_":0" D ^DIR
 Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) LEXIT=1,X="^^" I X["^^"!(+($G(LEXIT))>0) Q "^^"
 K DIR Q:$D(DTOUT)!(X[U) "^^"
 Q $S(+Y>0:+Y,1:"-1")
MULSH ; Select from Multiple Entries Help
 I $L($G(LEXHLP)) W !,$G(LEXHLP) Q
 Q
MULQ ; Quit Multiple
 I +LEXSS'>0,$G(LEXSS)="^" Q "^"
 S X=-1 S:+($G(LEXIT))'>0 X=$$X(+LEXSS,.LEX)
 Q X
X(X,LEX) ; Set X and Outpot Array
 N LEXEX,LEXFI,LEXIEN,LEXN,LEXNC,LEXNN,LEXRN,LEXS,LEXSO
 S LEXS=+($G(X)) S LEXFI=$O(LEX(0))
 S LEXSO=$P($G(LEX(LEXS,0)),"^",1),LEXEX=$G(LEX(LEXS,"MENU"))
 S LEXIEN=$S($D(LEX(LEXS,"CAT")):"99:CAT;"_$P($G(LEX(LEXS,0)),"^"),1:$P($G(LEX(LEXS,"LEX",1)),"^")_";"_$P($G(LEX(LEXS,0)),"^")) Q:'$L(LEXSO) "^"
 Q:'$L(LEXEX) "^"  Q:+LEXIEN'>0 "^" S X=LEXIEN_"^"_LEXEX
 S LEXNN="LEX("_+LEXS_")",LEXNC="LEX("_+LEXS_","
 F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  D
 . S LEXRN="LEXN("_$P(LEXNN,"(",2,299) S @LEXRN=@LEXNN
 K LEX S LEXNN="LEXN("_+LEXS_")",LEXNC="LEXN("_+LEXS_","
 F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  D
 . S LEXRN="LEX("_$P(LEXNN,"(",2,299),@LEXRN=@LEXNN
 Q X
CONT(X,Y) ; Ask to Continue
 K DTOUT,DUOUT,DIRUT,DIROUT N LEXX,LEXFQ,LEXW,LEXI,LEXC,DIR
 S LEXX=$$UP^XLFSTR($G(X)),LEXFQ=$G(Y) Q:'$L(LEXX) 1  Q:LEXFQ'>0 1
 S LEXW(1)="Searching for """_LEXX_""" requires inspecting "
 S LEXW(2)=LEXFQ_" records to determine if they match the "
 S LEXW(3)="search criteria.  This could take quite some time."
 S LEXW(4)="Suggest refining the search by further specifying "
 S LEXW(5)=""""_LEXX_"."""
 D PR(.LEXW,60) S (LEXC,LEXI)=0 F  S LEXI=$O(LEXW(LEXI)) Q:+LEXI'>0  D
 . Q:'$L($G(LEXW(LEXI)))  S LEXC=LEXC+1 S DIR("A",LEXC)="   "_$G(LEXW(LEXI))
 I LEXC>0 S LEXC=LEXC+1,DIR("A",LEXC)=" "
 S DIR("A")=" Do you wish to continue?  (Y/N)  ",DIR("B")="No"
 S DIR(0)="YAO",(DIR("?"),DIR("??"))="^D COH^LEX10DLS"
 S DIR("PRE")="S:X[""?"" X=""??""" W ! D ^DIR
 S X=+Y S:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) X="^"
 Q X
COH ;   Continue Help
 I $L($G(LEXX))>0 D
 . W !,"   Enter   To"
 . W !,"   'Yes'   continue searching for """,LEXX,"""."
 . W !,"   'No'    refine the search (further specify)"
 . W !,"   '^'     discontinue the search and exit"
 I '$L($G(LEXX))>0 D
 . W !,"   Enter   To"
 . W !,"   'Yes'   continue the search"
 . W !,"   'No'    refine the search (further specify)"
 . W !,"   '^'     discontinue the search and exit"
 Q
 ;
 ; Miscellaneous
CL ; Clear
 K LEXIT
 Q
PR(LEX,X) ; Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,Z,LEXC,LEXI,LEXL
 K ^UTILITY($J,"W") Q:'$D(LEX)  S LEXL=+($G(X)) S:+LEXL'>0 LEXL=79
 S LEXC=+($G(LEX)) S:+($G(LEXC))'>0 LEXC=$O(LEX(" "),-1) Q:+LEXC'>0
 S DIWL=1,DIWF="C"_+LEXL S LEXI=0
 F  S LEXI=$O(LEX(LEXI)) Q:+LEXI=0  S X=$G(LEX(LEXI)) D ^DIWP
 K LEX S (LEXC,LEXI)=0
 F  S LEXI=$O(^UTILITY($J,"W",1,LEXI)) Q:+LEXI=0  D
 . S LEX(LEXI)=$$TM($G(^UTILITY($J,"W",1,LEXI,0))," "),LEXC=LEXC+1
 S:$L(LEXC) LEX=LEXC K ^UTILITY($J,"W")
 Q
TM(X,Y) ; Trim Character Y - Default " "
 S X=$G(X) Q:X="" X S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
