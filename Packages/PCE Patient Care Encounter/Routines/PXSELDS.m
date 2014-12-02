PXSELDS ;ALB/RBD - Select ICD DIAGNOSIS FROM LEXICON UTILITY LIST ; 19 Mar 2013  10:43 AM
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**199**;Aug 12, 1996;Build 51
 ;
 ; Copied from SROICDL and customized for PCE
 ;
SEL(PXSRL,X) ; Select from List
 ;
 ;
 ; Input
 ;
 ;     X     Length of list to display (default 5)
 ;    .PXSRL   Local array passed by reference
 ;
 ;             PXSRL()   Input Array from ICDSRCH^LEX10CS
 ;
 ;             PXSRL(0)=# found ^ Pruning Indicator
 ;             PXSRL(1,0)=Code ^ Code IEN ^ date
 ;             PXSRL(1,"IDL")=ICD-9/10 Description, Long
 ;             PXSRL(1,"IDL",1)=ICD-9/10 IEN ^ date
 ;             PXSRL(1,"IDS")=ICD-9/10 Description, Short
 ;             PXSRL(1,"IDS",1)=ICD-9/10 IEN ^ date
 ;             PXSRL(1,"LEX")=Lexicon Description
 ;             PXSRL(1,"LEX",1)=Expression IEN ^ date
 ;             PXSRL(1,"SYN",1)=Synonym #1
 ;             PXSRL(1,"SYN",m)=Synonym #m
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
 ;    PXSRL    Local array passed by reference
 ;
 ;             PXSRL(0)=Code ^ Code IEN ^ date
 ;             PXSRL("IDL")=ICD-9/10 Description, Long
 ;             PXSRL("IDL",1)=ICD-9/10 IEN ^ date
 ;             PXSRL("IDS")=ICD-9/10 Description, Short
 ;             PXSRL("IDS",1)=ICD-9/10 IEN ^ date
 ;             PXSRL("LEX")=Lexicon Description
 ;             PXSRL("LEX",1)=Expression IEN ^ date
 ;
 ;    or ^ on error
 ;    or -1 for non-selection
 ;
 S X=+($G(X)) S:X'>0 X=5 S X=$$ASK(.PXSRL,X)
 Q X
ASK(PXSRL,X) ; Ask for Selection
 N PXSRLIT,PXSRLL,PXSRLTOT S PXSRLL=+($G(X)) S:PXSRLL'>0 PXSRLL=5
 S PXSRLIT=0,PXSRLTOT=$O(PXSRL(" "),-1) Q:+PXSRLTOT'>0 "^"
 K X S:+PXSRLTOT=1 X=$$ONE(PXSRLL,.PXSRL) S:+PXSRLTOT>1 X=$$MUL(.PXSRL,PXSRLL)
 I "D@"[X Q "@"  ; user wants to delete the existing entry
 S:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(X))'>0) X=-1
 Q X
ONE(X,PXSRL) ; One Entry Found
 Q:+($G(PXSRLIT))>0 "^^"
 N DIR,PXNXTLIN,PXSRLC,PXSRLEX,PXSRLFI,PXSRLIT,PXSRLNC,PXSRLSO,PXSRLSP,PXSRLTX,Y
 S PXSRLFI=$O(PXSRL(0)) Q:+PXSRLFI'>0 "^"  S PXSRLSP=$J(" ",11)
 S PXSRLSO=$P(PXSRL(1,0),"^",1),PXSRLNC=$P(PXSRL(1,0),"^",3)
 S:+PXSRLNC>0 PXSRLNC=" ("_PXSRLNC_")" S PXSRLEX=$G(PXSRL(1,"MENU"))
 S PXSRLC=$S($D(PXSRL(1,"CAT")):"-",1:"")
 S PXSRLTX(1)=PXSRLSO_PXSRLC_$J(" ",(9-$L(PXSRLSO)))_" "_PXSRLEX_PXSRLNC
 D PR(.PXSRLTX,64) S DIR("A",1)=" One code found",DIR("A",2)=" "
 S DIR("A",3)=" "_$G(PXSRLTX(1)),PXSRLC=3 I $L($G(PXSRLTX(2))) D
 . F PXNXTLIN=2:1 Q:$G(PXSRLTX(PXNXTLIN))=""  D
 .. S PXSRLC=PXSRLC+1,DIR("A",PXSRLC)=PXSRLSP_$G(PXSRLTX(PXNXTLIN))
 S PXSRLC=PXSRLC+1,DIR("A",PXSRLC)=" ",PXSRLC=PXSRLC+1
 D SET1:$D(PXDEF),SET2:'$D(PXDEF)
 D ^DIR S Y=Y="Y"
 I X'="","Dd@"[X Q "@"  ; user wants to delete the existing entry
 Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&((+$G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) PXSRLIT=1
 I X["^^"!(+($G(PXSRLIT))>0) K PXSRL Q "^^"
 S X=$S(+Y>0:$$X(1,.PXSRL),1:-1)
 Q X
MUL(PXSRL,Y) ; Multiple Entries Found
 Q:+($G(PXSRLIT))>0 "^^"  N PXSRLE,PXSRLL,PXSRLMAX,PXSRLSS,PXSRLX,X
 S (PXSRLMAX,PXSRLSS,PXSRLIT)=0,PXSRLL=+($G(Y)),U="^" S:+($G(PXSRLL))'>0 PXSRLL=5
 S PXSRLX=$O(PXSRL(" "),-1),PXSRLSS=0
 G:+PXSRLX=0 MULQ W ! W:+PXSRLX>1 !," ",PXSRLX," matches found"
 F PXSRLE=1:1:PXSRLX Q:((PXSRLSS>0)&(PXSRLSS<(PXSRLE+1)))  Q:PXSRLIT  D  Q:PXSRLIT
 . W:PXSRLE#PXSRLL=1 ! D MULW
 . S PXSRLMAX=PXSRLE W:PXSRLE#PXSRLL=0 !
 . S:PXSRLE#PXSRLL=0 PXSRLSS=$$MULS(PXSRLMAX,PXSRLE,.PXSRL) S:PXSRLSS["^" PXSRLIT=1
 I PXSRLE#PXSRLL'=0,+PXSRLSS<=0 D
 . W ! S PXSRLSS=$$MULS(PXSRLMAX,PXSRLE,.PXSRL) S:PXSRLSS["^" PXSRLIT=1
 G MULQ
 Q X
MULW ; Write Multiple
 N PXSRLEX,PXSRLI,PXSRLSO,PXSRLNC,PXSRLT,PXSRLTX S PXSRLSO=$P(PXSRL(+PXSRLE,0),"^",1)
 S PXSRLNC=$P(PXSRL(+PXSRLE,0),"^",3) S:+PXSRLNC>0 PXSRLNC=" ("_PXSRLNC_")"
 S PXSRLEX=$G(PXSRL(+PXSRLE,"MENU")),PXSRLTX(1)=PXSRLSO
 S PXSRLTX(1)=PXSRLTX(1)_$S($D(PXSRL(+PXSRLE,"CAT")):"-",1:" ")_$J(" ",(9-$L(PXSRLSO)))_" "_PXSRLEX_PXSRLNC
 D PR(.PXSRLTX,60) W !,$J(PXSRLE,5),".  ",$G(PXSRLTX(1))
 F PXSRLI=2:1:5 S PXSRLT=$G(PXSRLTX(PXSRLI)) W:$L(PXSRLT) !,$J(" ",19),PXSRLT
 Q
MULS(X,Y,PXSRL) ; Select from Multiple Entries
 N DIR,DIRB,PXSRLFI,PXSRLHLP,PXSLLAST,PXSRLMAX,PXSRLS
 Q:+($G(PXSRLIT))>0 "^^"  S PXSRLMAX=+($G(X)),PXSLLAST=+($G(Y))
 Q:PXSRLMAX=0 -1 S PXSRLFI=$O(PXSRL(0)) Q:+PXSRLFI'>0 -1
 I +($O(PXSRL(+PXSLLAST)))>0 D
 . S DIR("A")=" Press <RETURN> for more, ""^"" to exit, or Select 1-"
 . S DIR("A")=DIR("A")_PXSRLMAX_": "
 I +($O(PXSRL(+PXSLLAST)))'>0 D
 . S DIR("A")=" Select 1-"_PXSRLMAX_": "
 S PXSRLHLP=" Answer must be from 1 to "
 S PXSRLHLP=PXSRLHLP_PXSRLMAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??"""
 S (DIR("?"),DIR("??"))="^D MULSH^PXSELDS"
 S DIR(0)="NAO^1:"_PXSRLMAX_":0" D ^DIR
 Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) PXSRLIT=1,X="^^" I X["^^"!(+($G(PXSRLIT))>0) Q "^^"
 K DIR Q:$D(DTOUT)!(X[U) "^^"
 Q $S(+Y>0:+Y,1:"-1")
MULSH ; Select from Multiple Entries Help
 I $L($G(PXSRLHLP)) W !,$G(PXSRLHLP) Q
 Q
MULQ ; Quit Multiple
 I +PXSRLSS'>0,$G(PXSRLSS)="^" Q "^"
 S X=-1 S:+($G(PXSRLIT))'>0 X=$$X(+PXSRLSS,.PXSRL)
 Q X
X(X,PXSRL) ; Set X and Output Array
 N PXSRLEX,PXSRFI,PXSRLIEN,PXSRLN,PXSRLNC,PXSRLNN,PXSRLRN,PXSRLS,PXSRLSO
 S PXSRLS=+($G(X)) S PXSRFI=$O(PXSRL(0))
 S PXSRLSO=$P($G(PXSRL(PXSRLS,0)),"^",1),PXSRLEX=$G(PXSRL(PXSRLS,"MENU"))
 S PXSRLIEN=$S($D(PXSRL(PXSRLS,"CAT")):"99:CAT;"_$P($G(PXSRL(PXSRLS,0)),"^"),1:$P($G(PXSRL(PXSRLS,"LEX",1)),"^")_";"_$P($G(PXSRL(PXSRLS,0)),"^")) Q:'$L(PXSRLSO) "^"
 Q:'$L(PXSRLEX) "^"  Q:+PXSRLIEN'>0 "^" S X=PXSRLIEN_"^"_PXSRLEX
 S PXSRLNN="PXSRL("_+PXSRLS_")",PXSRLNC="PXSRL("_+PXSRLS_","
 F  S PXSRLNN=$Q(@PXSRLNN) Q:'$L(PXSRLNN)!(PXSRLNN'[PXSRLNC)  D
 . S PXSRLRN="PXSRLN("_$P(PXSRLNN,"(",2,299) S @PXSRLRN=@PXSRLNN
 K PXSRL S PXSRLNN="PXSRLN("_+PXSRLS_")",PXSRLNC="PXSRLN("_+PXSRLS_","
 F  S PXSRLNN=$Q(@PXSRLNN) Q:'$L(PXSRLNN)!(PXSRLNN'[PXSRLNC)  D
 . S PXSRLRN="PXSRL("_$P(PXSRLNN,"(",2,299),@PXSRLRN=@PXSRLNN
 Q X
 ;
 ; Miscellaneous
CL ; Clear
 K PXSRLIT
 Q
 ;
PR(PXSRL,X) ; Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,I,Z,%,%D,PXSRLC,PXSRLI,PXSRLL
 K ^UTILITY($J,"W") Q:'$D(PXSRL)  S PXSRLL=+($G(X)) S:+PXSRLL'>0 PXSRLL=79
 S PXSRLC=+($G(PXSRL)) S:+($G(PXSRLC))'>0 PXSRLC=$O(PXSRL(" "),-1) Q:+PXSRLC'>0
 S DIWL=1,DIWF="C"_+PXSRLL S PXSRLI=0
 F  S PXSRLI=$O(PXSRL(PXSRLI)) Q:+PXSRLI=0  S X=$G(PXSRL(PXSRLI)) D ^DIWP
 K PXSRL S (PXSRLC,PXSRLI)=0
 F  S PXSRLI=$O(^UTILITY($J,"W",1,PXSRLI)) Q:+PXSRLI=0  D
 . S PXSRL(PXSRLI)=$$TM($G(^UTILITY($J,"W",1,PXSRLI,0))," "),PXSRLC=PXSRLC+1
 S:$L(PXSRLC) PXSRL=PXSRLC K ^UTILITY($J,"W")
 Q
 ;
TM(X,Y) ; Trim Character Y - Default " "
 S X=$G(X) Q:X="" X S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
 ;
SET1 ; Use this if a default ICD-10 code was supplied
 S DIR("A")="OK? ",DIR("B")="YES",DIR(0)="SAOB^Y:Yes;N:No;D:Delete;@:Delete"
 S DIR("L",1)="  Y - Yes      |    @ - Delete"
 S DIR("L",2)="  N - No       |    ? - Help"
 S DIR("L",3)="  D - Delete   |   ?? - Extra Help"
 S DIR("L")="               |    ^ - Exit"
 Q
 ;
SET2 ; Use this if no default ICD-10 code was supplied
 S DIR("A")="OK? ",DIR("B")="YES",DIR(0)="SAOB^Y:Yes;N:No"
 S DIR("L",1)="  Y - Yes      |    ? - Help"
 S DIR("L",2)="  N - No       |   ?? - Extra Help"
 S DIR("L")="               |    ^ - Exit"
 Q
