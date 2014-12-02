YSLXDG2 ;ALB/RBD - Select ICD DIAGNOSIS FROM LEXICON UTILITY LIST;10 May 2013  9:46 AM
 ;;5.01;MENTAL HEALTH;**107**;Dec 30, 1994;Build 23
 ;
 ; Based on ZZLXDG2
 ;
 ; Input
 ;
 ;     X     Length of list to display (default 5)
 ;    .YSSRL   Local array passed by reference
 ;
 ;             YSSRL()   Input Array from ICDSRCH^LEX10CS
 ;
 ;             YSSRL(0)=# found ^ Pruning Indicator
 ;             YSSRL(1,0)=Code ^ Code IEN ^ date
 ;             YSSRL(1,"IDL")=ICD-9/10 Description, Long
 ;             YSSRL(1,"IDL",1)=ICD-9/10 IEN ^ date
 ;             YSSRL(1,"IDS")=ICD-9/10 Description, Short
 ;             YSSRL(1,"IDS",1)=ICD-9/10 IEN ^ date
 ;             YSSRL(1,"LEX")=Lexicon Description
 ;             YSSRL(1,"LEX",1)=Expression IEN ^ date
 ;             YSSRL(1,"SYN",1)=Synonym #1
 ;             YSSRL(1,"SYN",m)=Synonym #m
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
 ;    YSSRL    Local array passed by reference
 ;
 ;             YSSRL(0)=Code ^ Code IEN ^ date
 ;             YSSRL("IDL")=ICD-9/10 Description, Long
 ;             YSSRL("IDL",1)=ICD-9/10 IEN ^ date
 ;             YSSRL("IDS")=ICD-9/10 Description, Short
 ;             YSSRL("IDS",1)=ICD-9/10 IEN ^ date
 ;             YSSRL("LEX")=Lexicon Description
 ;             YSSRL("LEX",1)=Expression IEN ^ date
 ;
 ;    or ^ on error
 ;    or -1 for non-selection
 ;    or -2 if "^" was entered
 ;               
SEL(YSSRL,X) ; Select from List
 N YSGOUP S YSGOUP=0
 S X=+($G(X))
 S:X'>0 X=5
 S X=$$ASK(.YSSRL,X)
 I YSGOUP=1 Q -2
 Q X
 ;
ASK(YSSRL,X) ; Ask for Selection
 N DTOUT,DUOUT,DIROUT
 N YSLIT,YSLL,YSLTOT
 S YSLL=+($G(X))
 S:YSLL'>0 YSLL=5
 S YSLIT=0,YSLTOT=$O(YSSRL(" "),-1)
 Q:+YSLTOT'>0 "^"
 K X
 S:+YSLTOT=1 X=$$ONE(YSLL,.YSSRL)
 S:+YSLTOT>1 X=$$MUL(.YSSRL,YSLL)
 S:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(X))'>0) X=-1
 Q X
ONE(X,YSSRL) ; One Entry Found
 Q:+($G(YSLIT))>0 "^^"
 N DIR,YSLC,YSLEX,YSLFI,YSLIT,YSLSO,YSLNC
 N YSLSP,YSLTX,YSLC,YSNXTLIN,Y
 S YSLFI=$O(YSSRL(0)) Q:+YSLFI'>0 "^"  S YSLSP=$J(" ",11)
 S YSLSO=$P(YSSRL(1,0),"^",1),YSLNC=$P(YSSRL(1,0),"^",3)
 S:+YSLNC>0 YSLNC=" ("_YSLNC_")" S YSLEX=$G(YSSRL(1,"MENU"))
 S YSLC=$S($D(YSSRL(1,"CAT")):"-",1:"")
 S YSLTX(1)=YSLSO_YSLC_$J(" ",(9-$L(YSLSO)))_" "_YSLEX_YSLNC
 D PR(.YSLTX,64) S DIR("A",1)=" One match found",DIR("A",2)=" "
 S DIR("A",3)=" "_$G(YSLTX(1)),YSLC=3 I $L($G(YSLTX(2))) D
 . F YSNXTLIN=2:1 Q:$G(YSLTX(YSNXTLIN))=""  D
 .. S YSLC=YSLC+1,DIR("A",YSLC)=YSLSP_$G(YSLTX(YSNXTLIN))
 S YSLC=YSLC+1,DIR("A",YSLC)=" ",YSLC=YSLC+1
 S DIR("A")=" OK? (Yes/No) ",DIR("B")="Yes",DIR(0)="YAO" W !
 D ^DIR Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) YSLIT=1
 I X["^^"!(+($G(YSLIT))>0) K YSSRL Q "^^"
 S X=$S(+Y>0:$$X(1,.YSSRL),1:-1)
 Q X
MUL(YSSRL,Y) ; Multiple Entries Found
 Q:+($G(YSLIT))>0 "^^"
 N YSSRLE,YSLL,YSLMAX,YSLSS,YSLX,X
 S (YSLMAX,YSLSS,YSLIT)=0,YSLL=+($G(Y)),U="^" S:+($G(YSLL))'>0 YSLL=5
 S YSLX=$O(YSSRL(" "),-1),YSLSS=0
 G:+YSLX=0 MULQ W ! W:+YSLX>1 !," ",YSLX," matches found"
 F YSSRLE=1:1:YSLX Q:((YSLSS>0)&(YSLSS<(YSSRLE+1)))  Q:YSLIT  D  Q:YSLIT
 . W:YSSRLE#YSLL=1 ! D MULW
 . S YSLMAX=YSSRLE W:YSSRLE#YSLL=0 !
 . S:YSSRLE#YSLL=0 YSLSS=$$MULS(YSLMAX,YSSRLE,.YSSRL) S:YSLSS["^" YSLIT=1
 I YSSRLE#YSLL'=0,+YSLSS<=0 D
 . W ! S YSLSS=$$MULS(YSLMAX,YSSRLE,.YSSRL) S:YSLSS["^" YSLIT=1
 G MULQ
 Q X
MULW ; Write Multiple
 N YSLEX,YSLI1,YSLSO,YSLNC,YSLT2,YSLTX S YSLSO=$P(YSSRL(+YSSRLE,0),"^",1)
 S YSLNC=$P(YSSRL(+YSSRLE,0),"^",3) S:+YSLNC>0 YSLNC=" ("_YSLNC_")"
 S YSLEX=$G(YSSRL(+YSSRLE,"MENU")),YSLTX(1)=YSLSO
 S YSLTX(1)=YSLTX(1)_$S($D(YSSRL(+YSSRLE,"CAT")):"-",1:" ")_$J(" ",(9-$L(YSLSO)))_" "_YSLEX_YSLNC
 D PR(.YSLTX,60) W !,$J(YSSRLE,5),".  ",$G(YSLTX(1))
 F YSLI1=2:1:5 S YSLT2=$G(YSLTX(YSLI1)) W:$L(YSLT2) !,$J(" ",19),YSLT2
 Q
MULS(X,Y,YSSRL) ; Select from Multiple Entries
 N DIR,DIRB,YSLFI,YSLHLP,YSLLST,YSLMAX,YSLS1 ;@#$ not sure YSLS1 is needed here
 Q:+($G(YSLIT))>0 "^^"  S YSLMAX=+($G(X)),YSLLST=+($G(Y))
 Q:YSLMAX=0 -1 S YSLFI=$O(YSSRL(0)) Q:+YSLFI'>0 -1
 I +($O(YSSRL(+YSLLST)))>0 D
 . S DIR("A")=" Press <RETURN> for more, ""^"" to exit, or Select 1-"
 . S DIR("A")=DIR("A")_YSLMAX_": "
 I +($O(YSSRL(+YSLLST)))'>0 D
 . S DIR("A")=" Select 1-"_YSLMAX_": "
 S YSLHLP=" Answer must be from 1 to "
 S YSLHLP=YSLHLP_YSLMAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??"""
 S (DIR("?"),DIR("??"))="^D MULSH^YSLXDG2"
 S DIR(0)="NAO^1:"_YSLMAX_":0" D ^DIR
 S:X="^" YSGOUP=1
 Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) YSLIT=1,X="^^" I X["^^"!(+($G(YSLIT))>0) Q "^^"
 K DIR Q:$D(DTOUT)!(X[U) "^^"
 Q $S(+Y>0:+Y,1:"-1")
MULSH ; Select from Multiple Entries Help
 I $L($G(YSLHLP)) W !,$G(YSLHLP) Q
 Q
MULQ ; Quit Multiple
 I +YSLSS'>0,$G(YSLSS)="^" Q "^"
 S X=-1 S:+($G(YSLIT))'>0 X=$$X(+YSLSS,.YSSRL)
 Q X
X(X,YSSRL) ; Set X and Output Array
 N YSLEX,YSSRFI,YSLIEN,YSLN1,YSLNC,YSLNN,YSLRN,YSLS1,YSLSO
 S YSLS1=+($G(X))
 S YSSRFI=$O(YSSRL(0)) ;@#$ not used?
 S YSLSO=$P($G(YSSRL(YSLS1,0)),"^",1),YSLEX=$G(YSSRL(YSLS1,"MENU"))
 S YSLIEN=$S($D(YSSRL(YSLS1,"CAT")):"99:CAT;"_$P($G(YSSRL(YSLS1,0)),"^"),1:$P($G(YSSRL(YSLS1,"LEX",1)),"^")_";"_$P($G(YSSRL(YSLS1,0)),"^")) Q:'$L(YSLSO) "^"
 Q:'$L(YSLEX) "^"  Q:+YSLIEN'>0 "^" S X=YSLIEN_"^"_YSLEX
 S YSLNN="YSSRL("_+YSLS1_")",YSLNC="YSSRL("_+YSLS1_","
 F  S YSLNN=$Q(@YSLNN) Q:'$L(YSLNN)!(YSLNN'[YSLNC)  D
 . S YSLRN="YSLN1("_$P(YSLNN,"(",2,299) S @YSLRN=@YSLNN
 K YSSRL S YSLNN="YSLN1("_+YSLS1_")",YSLNC="YSLN1("_+YSLS1_","
 F  S YSLNN=$Q(@YSLNN) Q:'$L(YSLNN)!(YSLNN'[YSLNC)  D
 . S YSLRN="YSSRL("_$P(YSLNN,"(",2,299),@YSLRN=@YSLNN
 Q X
 ;
 ; Miscellaneous
CL ; Clear
 K YSLIT
 Q
PR(YSSRL,X) ; Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,I,Z,%,%D,YSLC,YSLI1,YSLL
 K ^UTILITY($J,"W")
 Q:'$D(YSSRL)
 S YSLL=+($G(X))
 S:+YSLL'>0 YSLL=79
 S YSLC=+($G(YSSRL))
 S:+($G(YSLC))'>0 YSLC=$O(YSSRL(" "),-1)
 Q:+YSLC'>0
 S DIWL=1,DIWF="C"_+YSLL
 S YSLI1=0
 F  S YSLI1=$O(YSSRL(YSLI1)) Q:+YSLI1=0  S X=$G(YSSRL(YSLI1)) D ^DIWP
 K YSSRL
 S (YSLC,YSLI1)=0
 F  S YSLI1=$O(^UTILITY($J,"W",1,YSLI1)) Q:+YSLI1=0  D
 . S YSSRL(YSLI1)=$$TM($G(^UTILITY($J,"W",1,YSLI1,0))," "),YSLC=YSLC+1
 S:$L(YSLC) YSSRL=YSLC
 K ^UTILITY($J,"W")
 Q
TM(X,Y) ; Trim Character Y - Default " "
 S X=$G(X) Q:X="" X S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
