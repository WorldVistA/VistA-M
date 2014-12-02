DGICDL ;ALB/SJA - Select ICD DIAGNOSIS FROM LEXICON UTILITY LIST ;12/07/2011
 ;;5.3;Registration;**850**;Aug 13, 1993;Build 171
 ; Clone of SROICDL
SEL(DGL,X) ; Select from List
 ;
 ;
 ; Input   
 ; 
 ;     X     Length of list to display (default 5)
 ;    .DGL   Local array passed by reference
 ;               
 ;             DGL()   Input Array from ICDSRCH^LEX10CS
 ;               
 ;             DGL(0)=# found ^ Pruning Indicator
 ;             DGL(1,0)=Code ^ Code IEN ^ date
 ;             DGL(1,"IDL")=ICD-9/10 Description, Long
 ;             DGL(1,"IDL",1)=ICD-9/10 IEN ^ date
 ;             DGL(1,"IDS")=ICD-9/10 Description, Short
 ;             DGL(1,"IDS",1)=ICD-9/10 IEN ^ date
 ;             DGL(1,"LEX")=Lexicon Description
 ;             DGL(1,"LEX",1)=Expression IEN ^ date
 ;             DGL(1,"SYN",1)=Synonym #1
 ;             DGL(1,"SYN",m)=Synonym #m
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
 ;    DGL    Local array passed by reference
 ;               
 ;             DGL(0)=Code ^ Code IEN ^ date
 ;             DGL("IDL")=ICD-9/10 Description, Long
 ;             DGL("IDL",1)=ICD-9/10 IEN ^ date
 ;             DGL("IDS")=ICD-9/10 Description, Short
 ;             DGL("IDS",1)=ICD-9/10 IEN ^ date
 ;             DGL("LEX")=Lexicon Description
 ;             DGL("LEX",1)=Expression IEN ^ date
 ;               
 ;    or ^ on error 
 ;    or -1 for non-selection
 ;               
 S X=+($G(X)) S:X'>0 X=5 S X=$$ASK(.DGL,X)
 Q X
ASK(DGL,X) ; Ask for Selection
 N DGLIT,DGLL,DGLTOT S DGLL=+($G(X)) S:DGLL'>0 DGLL=5
 S DGLIT=0,DGLTOT=$O(DGL(" "),-1) Q:+DGLTOT'>0 "^"
 K X S:+DGLTOT=1 X=$$ONE(DGLL,.DGL) S:+DGLTOT>1 X=$$MUL(.DGL,DGLL)
 S:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(X))'>0) X=-1
 Q X
ONE(X,DGL) ; One Entry Found
 Q:+($G(DGLIT))>0 "^^"  N Z,DIR,DGLC,DGLEX,DGLFI,DGLIT,DGLSO,DGLNC
 N DGLSP,DGLTX,DGLC,Y S DGLFI=$O(DGL(0)) Q:+DGLFI'>0 "^"  S DGLSP=$J(" ",11)
 S DGLSO=$P(DGL(1,0),"^",1),DGLNC=$P(DGL(1,0),"^",3)
 S:+DGLNC>0 DGLNC=" ("_DGLNC_")" S DGLEX=$G(DGL(1,"MENU"))
 S DGLC=$S($D(DGL(1,"CAT")):"-",1:"")
 S DGLTX(1)=DGLSO_DGLC_$J(" ",(9-$L(DGLSO)))_" "_DGLEX_DGLNC
 D PR(.DGLTX,64) S DIR("A",1)=" One code found",DIR("A",2)=" "
 S DIR("A",3)=" "_$G(DGLTX(1)),DGLC=3
 F Z=2:1 Q:$G(DGLTX(Z))=""  S DGLC=DGLC+1,DIR("A",DGLC)=DGLSP_$G(DGLTX(Z))
 S DGLC=DGLC+1,DIR("A",DGLC)=" ",DGLC=DGLC+1
 S DIR("A")=" OK? (Yes/No) ",DIR("B")="Yes",DIR(0)="YAO" W !
 D ^DIR Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) DGLIT=1
 I X["^^"!(+($G(DGLIT))>0) K DGL Q "^^"
 S X=$S(+Y>0:$$X(1,.DGL),1:-1)
 I X>0 S DGZZONE=1
 Q X
MUL(DGL,Y) ; Multiple Entries Found
 Q:+($G(DGLIT))>0 "^^"  N DGLE,DGLL,DGLMAX,DGLSS,DGLX,X
 S (DGLMAX,DGLSS,DGLIT)=0,DGLL=+($G(Y)),U="^" S:+($G(DGLL))'>0 DGLL=5
 S DGLX=$O(DGL(" "),-1),DGLSS=0
 G:+DGLX=0 MULQ W ! W:+DGLX>1 !," ",DGLX," matches found"
 F DGLE=1:1:DGLX Q:((DGLSS>0)&(DGLSS<(DGLE+1)))  Q:DGLIT  D  Q:DGLIT
 . W:DGLE#DGLL=1 ! D MULW
 . S DGLMAX=DGLE W:DGLE#DGLL=0 !
 . S:DGLE#DGLL=0 DGLSS=$$MULS(DGLMAX,DGLE,.DGL) S:DGLSS["^" DGLIT=1
 I DGLE#DGLL'=0,+DGLSS<=0 D
 . W ! S DGLSS=$$MULS(DGLMAX,DGLE,.DGL) S:DGLSS["^" DGLIT=1
 G MULQ
 Q X
MULW ; Write Multiple
 N DGLEX,DGLI,DGLSO,DGLNC,DGLT,DGLTX S DGLSO=$P(DGL(+DGLE,0),"^",1)
 S DGLNC=$P(DGL(+DGLE,0),"^",3) S:+DGLNC>0 DGLNC=" ("_DGLNC_")"
 S DGLEX=$G(DGL(+DGLE,"MENU")),DGLTX(1)=DGLSO
 S DGLTX(1)=DGLTX(1)_$S($D(DGL(+DGLE,"CAT")):"-",1:" ")_$J(" ",(9-$L(DGLSO)))_" "_DGLEX_DGLNC
 D PR(.DGLTX,60) W !,$J(DGLE,5),".  ",$G(DGLTX(1))
 F DGLI=2:1:5 S DGLT=$G(DGLTX(DGLI)) W:$L(DGLT) !,$J(" ",19),DGLT
 Q
MULS(X,Y,DGL) ; Select from Multiple Entries
 N DIR,DIRB,DGLFI,DGLHLP,DGLLAST,DGLMAX,DGLS
 Q:+($G(DGLIT))>0 "^^"  S DGLMAX=+($G(X)),DGLLAST=+($G(Y))
 Q:DGLMAX=0 -1 S DGLFI=$O(DGL(0)) Q:+DGLFI'>0 -1
 I +($O(DGL(+DGLLAST)))>0 D
 . S DIR("A")=" Press <RETURN> for more, ""^"" to exit, or Select 1-"
 . S DIR("A")=DIR("A")_DGLMAX_": "
 I +($O(DGL(+DGLLAST)))'>0 D
 . S DIR("A")=" Select 1-"_DGLMAX_": "
 S DGLHLP=" Answer must be from 1 to "
 S DGLHLP=DGLHLP_DGLMAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??"""
 S (DIR("?"),DIR("??"))="^D MULSH^DGICDL"
 S DIR(0)="NAO^1:"_DGLMAX_":0" D ^DIR
 Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) DGLIT=1,X="^^" I X["^^"!(+($G(DGLIT))>0) Q "^^"
 K DIR Q:$D(DTOUT)!(X[U) "^^"
 Q $S(+Y>0:+Y,1:"-1")
MULSH ; Select from Multiple Entries Help
 I $L($G(DGLHLP)) W !,$G(DGLHLP) Q
 Q
MULQ ; Quit Multiple
 I +DGLSS'>0,$G(DGLSS)="^" Q "^"
 S X=-1 S:+($G(DGLIT))'>0 X=$$X(+DGLSS,.DGL)
 Q X
X(X,DGL) ; Set X and Output Array
 N DGLEX,DGLIEN,DGLN,DGLNC,DGLNN,DGLRN,DGLS,DGLSO
 S DGLS=+($G(X))
 S DGLSO=$P($G(DGL(DGLS,0)),"^",1),DGLEX=$G(DGL(DGLS,"MENU"))
 S DGLIEN=$S($D(DGL(DGLS,"CAT")):"99:CAT;"_$P($G(DGL(DGLS,0)),"^"),1:$P($G(DGL(DGLS,"IDS",1)),"^")_";"_$P($G(DGL(DGLS,0)),"^")_";"_$P($G(DGL(DGLS,"LEX",1)),"^")) Q:'$L(DGLSO) "^"
 Q:'$L(DGLEX) "^"  Q:+DGLIEN'>0 "^" S X=DGLIEN_"^"_DGLEX
 S DGLNN="DGL("_+DGLS_")",DGLNC="DGL("_+DGLS_","
 F  S DGLNN=$Q(@DGLNN) Q:'$L(DGLNN)!(DGLNN'[DGLNC)  D
 . S DGLRN="DGLN("_$P(DGLNN,"(",2,299) S @DGLRN=@DGLNN
 K DGL S DGLNN="DGLN("_+DGLS_")",DGLNC="DGLN("_+DGLS_","
 F  S DGLNN=$Q(@DGLNN) Q:'$L(DGLNN)!(DGLNN'[DGLNC)  D
 . S DGLRN="DGL("_$P(DGLNN,"(",2,299),@DGLRN=@DGLNN
 Q X
 ; 
 ; Miscellaneous
CL ; Clear
 K DGLIT
 Q
PR(DGL,X) ; Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,I,Z,%,%D,DGLC,DGLI,DGLL
 K ^UTILITY($J,"W") Q:'$D(DGL)  S DGLL=+($G(X)) S:+DGLL'>0 DGLL=79
 S DGLC=+($G(DGL)) S:+($G(DGLC))'>0 DGLC=$O(DGL(" "),-1) Q:+DGLC'>0
 S DIWL=1,DIWF="C"_+DGLL S DGLI=0
 F  S DGLI=$O(DGL(DGLI)) Q:+DGLI=0  S X=$G(DGL(DGLI)) D ^DIWP
 K DGL S (DGLC,DGLI)=0
 F  S DGLI=$O(^UTILITY($J,"W",1,DGLI)) Q:+DGLI=0  D
 . S DGL(DGLI)=$$TM($G(^UTILITY($J,"W",1,DGLI,0))," "),DGLC=DGLC+1
 S:$L(DGLC) DGL=DGLC K ^UTILITY($J,"W")
 Q
TM(X,Y) ; Trim Character Y - Default " "
 S X=$G(X) Q:X="" X S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
