DGICPL ;ALB/KUM - Select ICD PROCEDURE FROM A LEXICON UTILITY LIST ;12/07/2011
 ;;5.3;Registration;**850**;Aug 13, 1993;Build 171
 ;
 ;
SEL(ICDSRL,X) ; Select from List
 ;
 ; Input   
 ; 
 ;     X     Length of list to display (default 5)
 ;    .ICDSRL   Local array passed by reference
 ;               
 ;             ICDSRL()   Input Array from ICDSRCH^LEX10CS
 ;               
 ;             ICDSRL(0)=# found ^ Pruning Indicator
 ;             ICDSRL(1,0)=Code ^ Code IEN ^ date
 ;             ICDSRL(1,"IDL")=ICD-9/10 Description, Long
 ;             ICDSRL(1,"IDL",1)=ICD-9/10 IEN ^ date
 ;             ICDSRL(1,"IDS")=ICD-9/10 Description, Short
 ;             ICDSRL(1,"IDS",1)=ICD-9/10 IEN ^ date
 ;             ICDSRL(1,"LEX")=Lexicon Description
 ;             ICDSRL(1,"LEX",1)=Expression IEN ^ date
 ;             ICDSRL(1,"SYN",1)=Synonym #1
 ;             ICDSRL(1,"SYN",m)=Synonym #m
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
 ;    ICDSRL    Local array passed by reference
 ;               
 ;             ICDSRL(0)=Code ^ Code IEN ^ date
 ;             ICDSRL("IDL")=ICD-9/10 Description, Long
 ;             ICDSRL("IDL",1)=ICD-9/10 IEN ^ date
 ;             ICDSRL("IDS")=ICD-9/10 Description, Short
 ;             ICDSRL("IDS",1)=ICD-9/10 IEN ^ date
 ;             ICDSRL("LEX")=Lexicon Description
 ;             ICDSRL("LEX",1)=Expression IEN ^ date
 ;               
 ;    or ^ on error 
 ;    or -1 for non-selection
 ;               
 S X=+($G(X)) S:X'>0 X=5 S X=$$ASK(.ICDSRL,X)
 Q X
ASK(ICDSRL,X) ;   Ask for Selection
 K X N ICDSRLIT,ICDSRLL,ICDSRTOT S ICDSRLL=+($G(X)) S:ICDSRLL'>0 ICDSRLL=5
 S ICDSRLIT=0,ICDSRTOT=$O(ICDSRL(" "),-1) Q:+ICDSRTOT'>0 "^"
 K X S:+ICDSRTOT=1 X=$$ONE(ICDSRLL,.ICDSRL) S:+ICDSRTOT>1 X=$$MUL(.ICDSRL,ICDSRLL)
 Q X
ONE(X,ICDSRL) ;     One Entry Found
 Q:+($G(ICDSRLIT))>0 "^^"  N DIR,DTOUT,ICDSRLC,ICDSRLEX,ICDSRLFI,ICDSRLIT,ICDSRLSO
 N ICDSRLSP,ICDSRLTX,Y
 S ICDSRLFI=$O(ICDSRL(0)) Q:+ICDSRLFI'>0 "^"  S ICDSRLSP=$J(" ",25)
 S ICDSRLSO=$P(ICDSRL(1,0),"^",1),ICDSRLEX=$G(ICDSRL(1,"LEX"))
 S ICDSRLTX(1)=ICDSRLSO_$J(" ",(9-$L(ICDSRLSO)))_" "_ICDSRLEX
 D PR(.ICDSRLTX,64) S DIR("A",1)=" One code found for character "_($L($G(ICDPRC))+1)_".",DIR("A",2)=" "
 S DIR("A",3)="     "_$G(ICDSRLTX(1)),ICDSRLC=3 I $L($G(ICDSRLTX(2))) D
 . S ICDSRLC=ICDSRLC+1,DIR("A",ICDSRLC)=ICDSRLSP_$G(ICDSRLTX(2))
 S ICDSRLC=ICDSRLC+1,DIR("A",ICDSRLC)=" ",ICDSRLC=ICDSRLC+1
 S DIR("A")="   OK?  (Yes/No)  ",DIR("B")="Yes",DIR(0)="YAO" W !
 D ^DIR S:X["^^"!($D(DTOUT)) ICDSRLIT=1
 I X["^^"!(+($G(ICDSRLIT))>0) K ICDSRL Q "^^"
 S X=$S(+Y>0:$$X(1,.ICDSRL),1:-1)
 Q X
MUL(ICDSRL,Y) ;     Multiple Entries Found
 Q:+($G(ICDSRLIT))>0 "^^"  N ICDSRLE,ICDSRLL,ICDSRMAX,ICDSRLSS,ICDSRLX,X
 S (ICDSRMAX,ICDSRLSS,ICDSRLIT)=0,ICDSRLL=+($G(Y)),U="^" S:+($G(ICDSRLL))'>0 ICDSRLL=5
 S ICDSRLX=$O(ICDSRL(" "),-1),ICDSRLSS=0
 G:+ICDSRLX=0 MULQ W ! W:+ICDSRLX>1 !," ",ICDSRLX," matches found for character ",$L($G(ICDPRC))+1,"."
 F ICDSRLE=1:1:ICDSRLX Q:((ICDSRLSS>0)&(ICDSRLSS<(ICDSRLE+1)))  Q:ICDSRLIT  D  Q:ICDSRLIT
 . W:ICDSRLE#ICDSRLL=1 ! D MULW
 . S ICDSRMAX=ICDSRLE W:ICDSRLE#ICDSRLL=0 !
 . S:ICDSRLE#ICDSRLL=0 ICDSRLSS=$$MULS(ICDSRMAX,ICDSRLE,.ICDSRL) S:ICDSRLSS["^" ICDSRLIT=1
 I ICDSRLE#ICDSRLL'=0,+ICDSRLSS<=0 D
 . W ! S ICDSRLSS=$$MULS(ICDSRMAX,ICDSRLE,.ICDSRL) S:ICDSRLSS["^" ICDSRLIT=1
 G MULQ
 Q X
MULW ;       Write Multiple
 N ICDSRLEX,ICDSRLI,ICDSRLSO,ICDSRLT,ICDSRLTX S ICDSRLSO=$P(ICDSRL(+ICDSRLE,0),"^",1)
 S ICDSRLEX=$G(ICDSRL(+ICDSRLE,"LEX")),ICDSRLTX(1)=ICDSRLSO
 S ICDSRLTX(1)=ICDSRLTX(1)_$J(" ",(9-$L(ICDSRLSO)))_" "_ICDSRLEX
 D PR(.ICDSRLTX,63) W !,$J(ICDSRLE,5),".  ",$G(ICDSRLTX(1))
 F ICDSRLI=2:1:5 S ICDSRLT=$G(ICDSRLTX(ICDSRLI)) W:$L(ICDSRLT) !,$J(" ",18),ICDSRLT
 Q
MULS(X,Y,ICDSRL) ;       Select from Multiple Entries
 N DIR,DIRB,DIROUT,DIRUT,DTOUT,DUOUT,ICDSRLFI,ICDSRHLP,ICDSRLAST,ICDSRMAX,ICDSRLS
 Q:+($G(ICDSRLIT))>0 "^^"  S ICDSRMAX=+($G(X)),ICDSRLAST=+($G(Y))
 Q:ICDSRMAX=0 -1  S ICDSRLFI=$O(ICDSRL(0)) Q:+ICDSRLFI'>0 -1
 I +($O(ICDSRL(+ICDSRLAST)))>0 D
 . S DIR("A")=" Press <RETURN> for more, '^' to quit selection, or Select 1-"
 . S DIR("A")=DIR("A")_ICDSRMAX_":  "
 I +($O(ICDSRL(+ICDSRLAST)))'>0 D
 . S DIR("A")=" Select 1-"_ICDSRMAX_":  "
 S ICDSRHLP="    Answer must be from 1 to "
 S ICDSRHLP=ICDSRHLP_ICDSRMAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??"""
 S (DIR("?"),DIR("??"))="^D MULSH^ICDSELPS"
 S DIR(0)="NAO^1:"_ICDSRMAX_":0" D ^DIR
 I X["^^"!($D(DTOUT)) S ICDSRLIT=1,X="^^" Q "^^"
 K DIR Q:$D(DTOUT)!(X[U) "^"
 Q $S(+Y>0:+Y,1:"-1")
MULSH ;       Select from Multiple Entries Help
 I $L($G(ICDSRHLP)) W !,$G(ICDSRHLP) Q
 Q
MULQ ;       Quit Multiple Entries Selection
 Q:+($G(ICDSRLSS))'>0 -1  S X=-1 S:+($G(ICDSRLIT))'>0 X=$$X(+ICDSRLSS,.ICDSRL)
 Q X
X(X,ICDSRL) ;   Set X and Outpot Array
 N ICDSRLEX,LEXFI,ICDSRLIEN,ICDSRLN,ICDSRLNC,ICDSRLNN,ICDSRLRN,ICDSRLS,ICDSRLSO
 S ICDSRLS=+($G(X)) S LEXFI=$O(LEX(0))
 S ICDSRLSO=$P($G(ICDSRL(ICDSRLS,0)),"^",1)
 S ICDSRLEX=$G(ICDSRL(ICDSRLS,"LEX"))
 Q:'$L(ICDSRLEX) "^" S X=ICDSRLSO_"^"_ICDSRLEX
 Q X
 ;        
 ; Miscellaneous
CL ;   Clear
 K ICDSRLIT
 Q
PR(ICDSRL,X) ;   Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,ICDSRLC,ICDSRLI,ICDSRLL
 K ^UTILITY($J,"W") Q:'$D(ICDSRL)  S ICDSRLL=+($G(X)) S:+ICDSRLL'>0 ICDSRLL=79
 S ICDSRLC=+($G(ICDSRL)) S:+($G(ICDSRLC))'>0 ICDSRLC=$O(ICDSRL(" "),-1) Q:+ICDSRLC'>0
 S DIWL=1,DIWF="C"_+ICDSRLL S ICDSRLI=0
 F  S ICDSRLI=$O(ICDSRL(ICDSRLI)) Q:+ICDSRLI=0  S X=$G(ICDSRL(ICDSRLI)) D ^DIWP
 K ICDSRL S (ICDSRLC,ICDSRLI)=0
 F  S ICDSRLI=$O(^UTILITY($J,"W",1,ICDSRLI)) Q:+ICDSRLI=0  D
 . S ICDSRL(ICDSRLI)=$$TM($G(^UTILITY($J,"W",1,ICDSRLI,0))," "),ICDSRLC=ICDSRLC+1
 S:$L(ICDSRLC) ICDSRL=ICDSRLC K ^UTILITY($J,"W")
 Q
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
