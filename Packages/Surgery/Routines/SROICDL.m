SROICDL ;ALB/SJA - Select ICD DIAGNOSIS FROM LIXICON UTILITY LIST ;12/07/2011
 ;;3.0;Surgery;**177**;24 Jun 93;Build 89
 ;
SEL(SRL,X) ; Select from List
 ;
 ;
 ; Input   
 ; 
 ;     X     Length of list to display (default 5)
 ;    .SRL   Local array passed by reference
 ;               
 ;             SRL()   Input Array from ICDSRCH^LEX10CS
 ;               
 ;             SRL(0)=# found ^ Pruning Indicator
 ;             SRL(1,0)=Code ^ Code IEN ^ date
 ;             SRL(1,"IDL")=ICD-9/10 Description, Long
 ;             SRL(1,"IDL",1)=ICD-9/10 IEN ^ date
 ;             SRL(1,"IDS")=ICD-9/10 Description, Short
 ;             SRL(1,"IDS",1)=ICD-9/10 IEN ^ date
 ;             SRL(1,"LEX")=Lexicon Description
 ;             SRL(1,"LEX",1)=Expression IEN ^ date
 ;             SRL(1,"SYN",1)=Synonym #1
 ;             SRL(1,"SYN",m)=Synonym #m
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
 ;    SRL    Local array passed by reference
 ;               
 ;             SRL(0)=Code ^ Code IEN ^ date
 ;             SRL("IDL")=ICD-9/10 Description, Long
 ;             SRL("IDL",1)=ICD-9/10 IEN ^ date
 ;             SRL("IDS")=ICD-9/10 Description, Short
 ;             SRL("IDS",1)=ICD-9/10 IEN ^ date
 ;             SRL("LEX")=Lexicon Description
 ;             SRL("LEX",1)=Expression IEN ^ date
 ;               
 ;    or ^ on error 
 ;    or -1 for non-selection
 ;               
 S X=+($G(X)) S:X'>0 X=5 S X=$$ASK(.SRL,X)
 Q X
ASK(SRL,X) ; Ask for Selection
 N SRLIT,SRLL,SRLTOT S SRLL=+($G(X)) S:SRLL'>0 SRLL=5
 S SRLIT=0,SRLTOT=$O(SRL(" "),-1) Q:+SRLTOT'>0 "^"
 K X S:+SRLTOT=1 X=$$ONE(SRLL,.SRL) S:+SRLTOT>1 X=$$MUL(.SRL,SRLL)
 S:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(X))'>0) X=-1
 Q X
ONE(X,SRL) ; One Entry Found
 Q:+($G(SRLIT))>0 "^^"  N Z,DIR,SRLC,SRLEX,SRLFI,SRLIT,SRLSO,SRLNC
 N SRLSP,SRLTX,SRLC,Y S SRLFI=$O(SRL(0)) Q:+SRLFI'>0 "^"
 S SRLSP=$J(" ",11)
 S SRLSO=$P(SRL(1,0),"^",1),SRLNC=$P(SRL(1,0),"^",3)
 S:+SRLNC>0 SRLNC=" ("_SRLNC_")" S SRLEX=$G(SRL(1,"MENU"))
 S SRLC=$S($D(SRL(1,"CAT")):"-",1:"")
 S SRLTX(1)=SRLSO_SRLC_$J(" ",(9-$L(SRLSO)))_" "_SRLEX_SRLNC
 ;
 D PR(.SRLTX,64)
 S DIR("A",1)=" One code found",DIR("A",2)=" "
 S DIR("A",3)=" "_$G(SRLTX(1))
 S SRLC=3
 F Z=2:1 Q:$G(SRLTX(Z))=""  S SRLC=SRLC+1,DIR("A",SRLC)=SRLSP_$G(SRLTX(Z))
 S SRLC=SRLC+1
 S DIR("A",SRLC)=" "
 S SRLC=SRLC+1
 ;
 S DIR("A")=" OK? (Yes/No) ",DIR("B")="Yes",DIR(0)="YAO" W !
 D ^DIR Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) SRLIT=1
 I X["^^"!(+($G(SRLIT))>0) K SRL Q "^^"
 S X=$S(+Y>0:$$X(1,.SRL),1:-1)
 I X>0 S SRZZONE=1
 Q X
MUL(SRL,Y) ; Multiple Entries Found
 Q:+($G(SRLIT))>0 "^^"  N SRLE,SRLL,SRLMAX,SRLSS,SRLX,X
 S (SRLMAX,SRLSS,SRLIT)=0,SRLL=+($G(Y)),U="^" S:+($G(SRLL))'>0 SRLL=5
 S SRLX=$O(SRL(" "),-1),SRLSS=0
 G:+SRLX=0 MULQ W ! W:+SRLX>1 !," ",SRLX," matches found"
 F SRLE=1:1:SRLX Q:((SRLSS>0)&(SRLSS<(SRLE+1)))  Q:SRLIT  D  Q:SRLIT
 . W:SRLE#SRLL=1 ! D MULW
 . S SRLMAX=SRLE W:SRLE#SRLL=0 !
 . S:SRLE#SRLL=0 SRLSS=$$MULS(SRLMAX,SRLE,.SRL) S:SRLSS["^" SRLIT=1
 I SRLE#SRLL'=0,+SRLSS<=0 D
 . W ! S SRLSS=$$MULS(SRLMAX,SRLE,.SRL) S:SRLSS["^" SRLIT=1
 G MULQ
 Q X
MULW ; Write Multiple
 N SRLEX,SRLI,SRLSO,SRLNC,SRLT,SRLTX S SRLSO=$P(SRL(+SRLE,0),"^",1)
 S SRLNC=$P(SRL(+SRLE,0),"^",3) S:+SRLNC>0 SRLNC=" ("_SRLNC_")"
 S SRLEX=$G(SRL(+SRLE,"MENU")),SRLTX(1)=SRLSO
 S SRLTX(1)=SRLTX(1)_$S($D(SRL(+SRLE,"CAT")):"-",1:" ")_$J(" ",(9-$L(SRLSO)))_" "_SRLEX_SRLNC
 D PR(.SRLTX,60) W !,$J(SRLE,5),".  ",$G(SRLTX(1))
 F SRLI=2:1:5 S SRLT=$G(SRLTX(SRLI)) W:$L(SRLT) !,$J(" ",19),SRLT
 Q
MULS(X,Y,SRL) ; Select from Multiple Entries
 N DIR,DIRB,SRLFI,SRLHLP,SRLLAST,SRLMAX,SRLS
 Q:+($G(SRLIT))>0 "^^"  S SRLMAX=+($G(X)),SRLLAST=+($G(Y))
 Q:SRLMAX=0 -1 S SRLFI=$O(SRL(0)) Q:+SRLFI'>0 -1
 I +($O(SRL(+SRLLAST)))>0 D
 . S DIR("A")=" Press <RETURN> for more, ""^"" to exit, or Select 1-"
 . S DIR("A")=DIR("A")_SRLMAX_": "
 I +($O(SRL(+SRLLAST)))'>0 D
 . S DIR("A")=" Select 1-"_SRLMAX_": "
 S SRLHLP=" Answer must be from 1 to "
 S SRLHLP=SRLHLP_SRLMAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??"""
 S (DIR("?"),DIR("??"))="^D MULSH^SROICDL"
 S DIR(0)="NAO^1:"_SRLMAX_":0" D ^DIR
 Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) SRLIT=1,X="^^" I X["^^"!(+($G(SRLIT))>0) Q "^^"
 K DIR Q:$D(DTOUT)!(X[U) "^^"
 Q $S(+Y>0:+Y,1:"-1")
MULSH ; Select from Multiple Entries Help
 I $L($G(SRLHLP)) W !,$G(SRLHLP) Q
 Q
MULQ ; Quit Multiple
 I +SRLSS'>0,$G(SRLSS)="^" Q "^"
 S X=-1 S:+($G(SRLIT))'>0 X=$$X(+SRLSS,.SRL)
 Q X
X(X,SRL) ; Set X and Outpot Array
 N SRLEX,SRFI,SRLIEN,SRLN,SRLNC,SRLNN,SRLRN,SRLS,SRLSO
 S SRLS=+($G(X)) S SRFI=$O(SRL(0))
 S SRLSO=$P($G(SRL(SRLS,0)),"^",1),SRLEX=$G(SRL(SRLS,"MENU"))
 ;
 S SRLIEN=$S($D(SRL(SRLS,"CAT")):"99:CAT;"_$P($G(SRL(SRLS,0)),"^"),1:$P($G(SRL(SRLS,"IDS",1)),"^")_";"_$P($G(SRL(SRLS,0)),"^")_";"_$P($G(SRL(SRLS,"LEX",1)),"^")) Q:'$L(SRLSO) "^"
 ;
 Q:'$L(SRLEX) "^"  Q:+SRLIEN'>0 "^" S X=SRLIEN_"^"_SRLEX
 S SRLNN="SRL("_+SRLS_")",SRLNC="SRL("_+SRLS_","
 F  S SRLNN=$Q(@SRLNN) Q:'$L(SRLNN)!(SRLNN'[SRLNC)  D
 . S SRLRN="SRLN("_$P(SRLNN,"(",2,299) S @SRLRN=@SRLNN
 K SRL S SRLNN="SRLN("_+SRLS_")",SRLNC="SRLN("_+SRLS_","
 F  S SRLNN=$Q(@SRLNN) Q:'$L(SRLNN)!(SRLNN'[SRLNC)  D
 . S SRLRN="SRL("_$P(SRLNN,"(",2,299),@SRLRN=@SRLNN
 Q X
 ; 
 ; Miscellaneous
CL ; Clear
 K SRLIT
 Q
PR(SRL,X) ; Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,I,Z,%,%D,SRLC,SRLI,SRLL
 K ^UTILITY($J,"W") Q:'$D(SRL)  S SRLL=+($G(X)) S:+SRLL'>0 SRLL=79
 S SRLC=+($G(SRL)) S:+($G(SRLC))'>0 SRLC=$O(SRL(" "),-1) Q:+SRLC'>0
 S DIWL=1,DIWF="C"_+SRLL S SRLI=0
 F  S SRLI=$O(SRL(SRLI)) Q:+SRLI=0  S X=$G(SRL(SRLI)) D ^DIWP
 K SRL S (SRLC,SRLI)=0
 F  S SRLI=$O(^UTILITY($J,"W",1,SRLI)) Q:+SRLI=0  D
 . S SRL(SRLI)=$$TM($G(^UTILITY($J,"W",1,SRLI,0))," "),SRLC=SRLC+1
 S:$L(SRLC) SRL=SRLC K ^UTILITY($J,"W")
 Q
TM(X,Y) ; Trim Character Y - Default " "
 S X=$G(X) Q:X="" X S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
