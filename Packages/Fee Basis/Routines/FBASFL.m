FBASFL ;AISC/JLG - Select ICD DIAGNOSIS FROM LEXICON UTILITY LIST ;03/26/2012
 ;;3.5;FEE BASIS;**139**;JAN 30, 1995;Build 127
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Input   
 ; 
 ;     X     Length of list to display (default 5)
 ;    .FBSRL   Local array passed by reference
 ;               
 ;             FBSRL()   Input Array from ICDSRCH^LEX10CS
 ;               
 ;             FBSRL(0)=# found ^ Pruning Indicator
 ;             FBSRL(1,0)=Code ^ Code IEN ^ date
 ;             FBSRL(1,"IDL")=ICD-9/10 Description, Long
 ;             FBSRL(1,"IDL",1)=ICD-9/10 IEN ^ date
 ;             FBSRL(1,"IDS")=ICD-9/10 Description, Short
 ;             FBSRL(1,"IDS",1)=ICD-9/10 IEN ^ date
 ;             FBSRL(1,"LEX")=Lexicon Description
 ;             FBSRL(1,"LEX",1)=Expression IEN ^ date
 ;             FBSRL(1,"SYN",1)=Synonym #1
 ;             FBSRL(1,"SYN",m)=Synonym #m
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
 ;    FBSRL    Local array passed by reference
 ;               
 ;             FBSRL(0)=Code ^ Code IEN ^ date
 ;             FBSRL("IDL")=ICD-9/10 Description, Long
 ;             FBSRL("IDL",1)=ICD-9/10 IEN ^ date
 ;             FBSRL("IDS")=ICD-9/10 Description, Short
 ;             FBSRL("IDS",1)=ICD-9/10 IEN ^ date
 ;             FBSRL("LEX")=Lexicon Description
 ;             FBSRL("LEX",1)=Expression IEN ^ date
 ;               
 ;    or ^ on error 
 ;    or -1 for non-selection
 ;    or -2 if "^" was entered
 ;               
SEL(FBSRL,X) ; Select from List
 N FBGOUP S FBGOUP=0
 S X=+($G(X))
 S:X'>0 X=5
 S X=$$ASK(.FBSRL,X)
 I FBGOUP=1 Q -2
 Q X
 ;
ASK(FBSRL,X) ; Ask for Selection
 N DTOUT,DUOUT,DIROUT
 N FBLIT,FBLL,FBLTOT
 S FBLL=+($G(X))
 S:FBLL'>0 FBLL=5
 S FBLIT=0,FBLTOT=$O(FBSRL(" "),-1)
 Q:+FBLTOT'>0 "^"
 K X
 S:+FBLTOT=1 X=$$ONE(FBLL,.FBSRL)
 S:+FBLTOT>1 X=$$MUL(.FBSRL,FBLL)
 S:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(X))'>0) X=-1
 Q X
ONE(X,FBSRL) ; One Entry Found
 Q:+($G(FBLIT))>0 "^^"
 N DIR,FBLC,FBLEX,FBLFI,FBLIT,FBLSO,FBLNC,FBCNT1
 N FBLSP,FBLTX,FBLC,Y
 S FBLFI=$O(FBSRL(0)) Q:+FBLFI'>0 "^"  S FBLSP=$J(" ",11)
 S FBLSO=$P(FBSRL(1,0),"^",1),FBLNC=$P(FBSRL(1,0),"^",3)
 S:+FBLNC>0 FBLNC=" ("_FBLNC_")" S FBLEX=$G(FBSRL(1,"MENU"))
 S FBLC=$S($D(FBSRL(1,"CAT")):"-",1:"")
 S FBLTX(1)=FBLSO_FBLC_$J(" ",(9-$L(FBLSO)))_" "_FBLEX_FBLNC
 D PR(.FBLTX,64) S DIR("A",1)=" One match found",DIR("A",2)=" "
 S DIR("A",3)=" "_$G(FBLTX(1))
 S FBLC=3
 F FBCNT1=2:1 Q:$G(FBLTX(FBCNT1))=""  S FBLC=FBLC+1,DIR("A",FBLC)=FBLSP_$G(FBLTX(FBCNT1))
 S FBLC=FBLC+1,DIR("A",FBLC)=" ",FBLC=FBLC+1
 S DIR("A")=" OK? (Yes/No) ",DIR("B")="Yes",DIR(0)="YAO" W !
 S Y=1 ; DEFAULTS TO YES FOR PRECEDING PROMPT.
 S:X["^^"!($D(DTOUT)) FBLIT=1
 I X["^^"!(+($G(FBLIT))>0) K FBSRL Q "^^"
 S X=$S(+Y>0:$$X(1,.FBSRL),1:-1)
 Q X
MUL(FBSRL,Y) ; Multiple Entries Found
 Q:+($G(FBLIT))>0 "^^"
 N FBSRLE,FBLL,FBLMAX,FBLSS,FBLX,X
 S (FBLMAX,FBLSS,FBLIT)=0,FBLL=+($G(Y)),U="^" S:+($G(FBLL))'>0 FBLL=5
 S FBLX=$O(FBSRL(" "),-1),FBLSS=0
 G:+FBLX=0 MULQ W ! W:+FBLX>1 !," ",FBLX," matches found"
 F FBSRLE=1:1:FBLX Q:((FBLSS>0)&(FBLSS<(FBSRLE+1)))  Q:FBLIT  D  Q:FBLIT
 . W:FBSRLE#FBLL=1 ! D MULW
 . S FBLMAX=FBSRLE W:FBSRLE#FBLL=0 !
 . S:FBSRLE#FBLL=0 FBLSS=$$MULS(FBLMAX,FBSRLE,.FBSRL) S:FBLSS["^" FBLIT=1
 I FBSRLE#FBLL'=0,+FBLSS<=0 D
 . W ! S FBLSS=$$MULS(FBLMAX,FBSRLE,.FBSRL) S:FBLSS["^" FBLIT=1
 G MULQ
 Q X
MULW ; Write Multiple
 N FBLEX,FBLI1,FBLSO,FBLNC,FBLT2,FBLTX S FBLSO=$P(FBSRL(+FBSRLE,0),"^",1)
 S FBLNC=$P(FBSRL(+FBSRLE,0),"^",3) S:+FBLNC>0 FBLNC=" ("_FBLNC_")"
 S FBLEX=$G(FBSRL(+FBSRLE,"MENU")),FBLTX(1)=FBLSO
 S FBLTX(1)=FBLTX(1)_$S($D(FBSRL(+FBSRLE,"CAT")):"-",1:" ")_$J(" ",(9-$L(FBLSO)))_" "_FBLEX_FBLNC
 D PR(.FBLTX,60) W !,$J(FBSRLE,5),".  ",$G(FBLTX(1))
 F FBLI1=2:1:5 S FBLT2=$G(FBLTX(FBLI1)) W:$L(FBLT2) !,$J(" ",19),FBLT2
 Q
MULS(X,Y,FBSRL) ; Select from Multiple Entries
 N DIR,DIRB,FBLFI,FBLHLP,FBLLST,FBLMAX,FBLS1 ;@#$ not sure FBLS1 is  neede here
 Q:+($G(FBLIT))>0 "^^"  S FBLMAX=+($G(X)),FBLLST=+($G(Y))
 Q:FBLMAX=0 -1 S FBLFI=$O(FBSRL(0)) Q:+FBLFI'>0 -1
 I +($O(FBSRL(+FBLLST)))>0 D
 . S DIR("A")=" Press <RETURN> for more, ""^"" to exit, or Select 1-"
 . S DIR("A")=DIR("A")_FBLMAX_": "
 I +($O(FBSRL(+FBLLST)))'>0 D
 . S DIR("A")=" Select 1-"_FBLMAX_": "
 S FBLHLP=" Answer must be from 1 to "
 S FBLHLP=FBLHLP_FBLMAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??"""
 S (DIR("?"),DIR("??"))="^D MULSH^FBASFL"
 S DIR(0)="NAO^1:"_FBLMAX_":0" D ^DIR
 S:X="^" FBGOUP=1
 Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) FBLIT=1,X="^^" I X["^^"!(+($G(FBLIT))>0) Q "^^"
 K DIR Q:$D(DTOUT)!(X[U) "^^"
 Q $S(+Y>0:+Y,1:"-1")
MULSH ; Select from Multiple Entries Help
 I $L($G(FBLHLP)) W !,$G(FBLHLP) Q
 Q
MULQ ; Quit Multiple
 I +FBLSS'>0,$G(FBLSS)="^" Q "^"
 S X=-1 S:+($G(FBLIT))'>0 X=$$X(+FBLSS,.FBSRL)
 Q X
X(X,FBSRL) ; Set X and Output Array
 N FBLEX,FBSRFI,FBLIEN,FBLN1,FBLNC,FBLNN,FBLRN,FBLS1,FBLSO
 S FBLS1=+($G(X))
 S FBSRFI=$O(FBSRL(0)) ;@#$ not used?
 S FBLSO=$P($G(FBSRL(FBLS1,0)),"^",1),FBLEX=$G(FBSRL(FBLS1,"MENU"))
 S FBLIEN=$S($D(FBSRL(FBLS1,"CAT")):"99:CAT;"_$P($G(FBSRL(FBLS1,0)),"^"),1:$P($G(FBSRL(FBLS1,"IDS",1)),"^")_";"_$P($G(FBSRL(FBLS1,0)),"^")_";"_$P($G(FBSRL(FBLS1,"LEX",1)),"^")) Q:'$L(FBLSO) "^"
 Q:'$L(FBLEX) "^"  Q:+FBLIEN'>0 "^" S X=FBLIEN_"^"_FBLEX
 S FBLNN="FBSRL("_+FBLS1_")",FBLNC="FBSRL("_+FBLS1_","
 F  S FBLNN=$Q(@FBLNN) Q:'$L(FBLNN)!(FBLNN'[FBLNC)  D
 . S FBLRN="FBLN1("_$P(FBLNN,"(",2,299) S @FBLRN=@FBLNN
 K FBSRL S FBLNN="FBLN1("_+FBLS1_")",FBLNC="FBLN1("_+FBLS1_","
 F  S FBLNN=$Q(@FBLNN) Q:'$L(FBLNN)!(FBLNN'[FBLNC)  D
 . S FBLRN="FBSRL("_$P(FBLNN,"(",2,299),@FBLRN=@FBLNN
 Q X
 ; 
 ; Miscellaneous
CL ; Clear
 K FBLIT
 Q
PR(FBSRL,X) ; Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,I,Z,%,FBLC,FBLI1,FBLL
 K ^UTILITY($J,"W")
 Q:'$D(FBSRL)
 S FBLL=+($G(X))
 S:+FBLL'>0 FBLL=79
 S FBLC=+($G(FBSRL))
 S:+($G(FBLC))'>0 FBLC=$O(FBSRL(" "),-1)
 Q:+FBLC'>0
 S DIWL=1,DIWF="C"_+FBLL
 S FBLI1=0
 F  S FBLI1=$O(FBSRL(FBLI1)) Q:+FBLI1=0  S X=$G(FBSRL(FBLI1)) D ^DIWP
 K FBSRL
 S (FBLC,FBLI1)=0
 F  S FBLI1=$O(^UTILITY($J,"W",1,FBLI1)) Q:+FBLI1=0  D
 . S FBSRL(FBLI1)=$$TM($G(^UTILITY($J,"W",1,FBLI1,0))," "),FBLC=FBLC+1
 S:$L(FBLC) FBSRL=FBLC
 K ^UTILITY($J,"W")
 Q
TM(X,Y) ; Trim Character Y - Default " "
 S X=$G(X) Q:X="" X S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
