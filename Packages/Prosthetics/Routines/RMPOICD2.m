RMPOICD2 ;ALB/MGD - Select ICD DIAGNOSIS FROM LEXICON UTILITY LIST ;12/07/2011
 ;;3.0;PROSTHETICS;**168**;Feb 09, 1996;Build 43
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 ;
 ; Input   
 ; 
 ;     X     Length of list to display (default 5)
 ;    .RMPSRL   Local array passed by reference
 ;               
 ;             RMPSRL()   Input Array from ICDSRCH^LEX10CS
 ;               
 ;             RMPSRL(0)=# found ^ Pruning Indicator
 ;             RMPSRL(1,0)=Code ^ Code IEN ^ date
 ;             RMPSRL(1,"IDL")=ICD-9/10 Description, Long
 ;             RMPSRL(1,"IDL",1)=ICD-9/10 IEN ^ date
 ;             RMPSRL(1,"IDS")=ICD-9/10 Description, Short
 ;             RMPSRL(1,"IDS",1)=ICD-9/10 IEN ^ date
 ;             RMPSRL(1,"LEX")=Lexicon Description
 ;             RMPSRL(1,"LEX",1)=Expression IEN ^ date
 ;             RMPSRL(1,"SYN",1)=Synonym #1
 ;             RMPSRL(1,"SYN",m)=Synonym #m
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
 ;    RMPSRL    Local array passed by reference
 ;               
 ;             RMPSRL(0)=Code ^ Code IEN ^ date
 ;             RMPSRL("IDL")=ICD-9/10 Description, Long
 ;             RMPSRL("IDL",1)=ICD-9/10 IEN ^ date
 ;             RMPSRL("IDS")=ICD-9/10 Description, Short
 ;             RMPSRL("IDS",1)=ICD-9/10 IEN ^ date
 ;             RMPSRL("LEX")=Lexicon Description
 ;             RMPSRL("LEX",1)=Expression IEN ^ date
 ;               
 ;    or ^ on error 
 ;    or -1 for non-selection
 ;    or -2 if "^" was entered
 ;               
SEL(RMPSRL,X) ; Select from List
 N RMPGOUP S RMPGOUP=0
 S X=+($G(X))
 S:X'>0 X=5
 S X=$$ASK(.RMPSRL,X)
 I RMPGOUP=1 Q -2
 Q X
 ;
ASK(RMPSRL,X) ; Ask for Selection
 N DTOUT,DUOUT,DIROUT
 N RMPLIT,RMPLL,RMPLTOT
 S RMPLL=+($G(X))
 S:RMPLL'>0 RMPLL=5
 S RMPLIT=0,RMPLTOT=$O(RMPSRL(" "),-1)
 Q:+RMPLTOT'>0 "^"
 K X
 S:+RMPLTOT=1 X=$$ONE(RMPLL,.RMPSRL)
 S:+RMPLTOT>1 X=$$MUL(.RMPSRL,RMPLL)
 S:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(X))'>0) X=-1
 Q X
ONE(X,RMPSRL) ; One Entry Found
 Q:+($G(RMPLIT))>0 "^^"
 N DIR,RMPLC,RMPLEX,RMPLFI,RMPLIT,RMPLSO,RMPLNC
 N RMPLSP,RMPLTX,RMPLC,Y
 S RMPLFI=$O(RMPSRL(0)) Q:+RMPLFI'>0 "^"  S RMPLSP=$J(" ",25)
 S RMPLSO=$P(RMPSRL(1,0),"^",1),RMPLNC=$P(RMPSRL(1,0),"^",3)
 S:+RMPLNC>0 RMPLNC=" ("_RMPLNC_")" S RMPLEX=$G(RMPSRL(1,"MENU"))
 S RMPLC=$S($D(RMPSRL(1,"CAT")):"-",1:"")
 S RMPLTX(1)=RMPLSO_RMPLC_$J(" ",(9-$L(RMPLSO)))_" "_RMPLEX_RMPLNC
 D PR(.RMPLTX,64) S DIR("A",1)=" One match found",DIR("A",2)=" "
 S DIR("A",3)=" "_$G(RMPLTX(1)),RMPLC=3 I $L($G(RMPLTX(2))) D
 . S RMPLC=RMPLC+1,DIR("A",RMPLC)=RMPLSP_$G(RMPLTX(2))
 S RMPLC=RMPLC+1,DIR("A",RMPLC)=" ",RMPLC=RMPLC+1
 S DIR("A")=" OK? (Yes/No) ",DIR("B")="Yes",DIR(0)="YAO" W !
 D ^DIR Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) RMPLIT=1
 I X["^^"!(+($G(RMPLIT))>0) K RMPSRL Q "^^"
 S X=$S(+Y>0:$$X(1,.RMPSRL),1:-1)
 Q X
MUL(RMPSRL,Y) ; Multiple Entries Found
 Q:+($G(RMPLIT))>0 "^^"
 N RMPSRLE,RMPLL,RMPLMAX,RMPLSS,RMPLX,X
 S (RMPLMAX,RMPLSS,RMPLIT)=0,RMPLL=+($G(Y)),U="^" S:+($G(RMPLL))'>0 RMPLL=5
 S RMPLX=$O(RMPSRL(" "),-1),RMPLSS=0
 G:+RMPLX=0 MULQ W ! W:+RMPLX>1 !," ",RMPLX," matches found"
 F RMPSRLE=1:1:RMPLX Q:((RMPLSS>0)&(RMPLSS<(RMPSRLE+1)))  Q:RMPLIT  D  Q:RMPLIT
 . W:RMPSRLE#RMPLL=1 ! D MULW
 . S RMPLMAX=RMPSRLE W:RMPSRLE#RMPLL=0 !
 . S:RMPSRLE#RMPLL=0 RMPLSS=$$MULS(RMPLMAX,RMPSRLE,.RMPSRL) S:RMPLSS["^" RMPLIT=1
 I RMPSRLE#RMPLL'=0,+RMPLSS<=0 D
 . W ! S RMPLSS=$$MULS(RMPLMAX,RMPSRLE,.RMPSRL) S:RMPLSS["^" RMPLIT=1
 G MULQ
 Q X
MULW ; Write Multiple
 N RMPLEX,RMPLI1,RMPLSO,RMPLNC,RMPLT2,RMPLTX S RMPLSO=$P(RMPSRL(+RMPSRLE,0),"^",1)
 S RMPLNC=$P(RMPSRL(+RMPSRLE,0),"^",3) S:+RMPLNC>0 RMPLNC=" ("_RMPLNC_")"
 S RMPLEX=$G(RMPSRL(+RMPSRLE,"MENU")),RMPLTX(1)=RMPLSO
 S RMPLTX(1)=RMPLTX(1)_$S($D(RMPSRL(+RMPSRLE,"CAT")):"-",1:" ")_$J(" ",(9-$L(RMPLSO)))_" "_RMPLEX_RMPLNC
 D PR(.RMPLTX,60) W !,$J(RMPSRLE,5),".  ",$G(RMPLTX(1))
 F RMPLI1=2:1:5 S RMPLT2=$G(RMPLTX(RMPLI1)) W:$L(RMPLT2) !,$J(" ",19),RMPLT2
 Q
MULS(X,Y,RMPSRL) ; Select from Multiple Entries
 N DIR,DIRB,RMPLFI,RMPLHLP,RMPLLST,RMPLMAX,RMPLS1 ;@#$ not sure RMPLS1 is  neede here
 Q:+($G(RMPLIT))>0 "^^"  S RMPLMAX=+($G(X)),RMPLLST=+($G(Y))
 Q:RMPLMAX=0 -1 S RMPLFI=$O(RMPSRL(0)) Q:+RMPLFI'>0 -1
 I +($O(RMPSRL(+RMPLLST)))>0 D
 . S DIR("A")=" Press <RETURN> for more, ""^"" to exit, or Select 1-"
 . S DIR("A")=DIR("A")_RMPLMAX_": "
 I +($O(RMPSRL(+RMPLLST)))'>0 D
 . S DIR("A")=" Select 1-"_RMPLMAX_": "
 S RMPLHLP=" Answer must be from 1 to "
 S RMPLHLP=RMPLHLP_RMPLMAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??"""
 S (DIR("?"),DIR("??"))="^D MULSH^RMPOICD2"
 S DIR(0)="NAO^1:"_RMPLMAX_":0" D ^DIR
 S:X="^" RMPGOUP=1
 Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) RMPLIT=1,X="^^" I X["^^"!(+($G(RMPLIT))>0) Q "^^"
 K DIR Q:$D(DTOUT)!(X[U) "^^"
 Q $S(+Y>0:+Y,1:"-1")
MULSH ; Select from Multiple Entries Help
 I $L($G(RMPLHLP)) W !,$G(RMPLHLP) Q
 Q
MULQ ; Quit Multiple
 I +RMPLSS'>0,$G(RMPLSS)="^" Q "^"
 S X=-1 S:+($G(RMPLIT))'>0 X=$$X(+RMPLSS,.RMPSRL)
 Q X
X(X,RMPSRL) ; Set X and Output Array
 N RMPLEX,RMPSRFI,RMPLIEN,RMPLN1,RMPLNC,RMPLNN,RMPLRN,RMPLS1,RMPLSO
 S RMPLS1=+($G(X))
 S RMPSRFI=$O(RMPSRL(0)) ;@#$ not used?
 S RMPLSO=$P($G(RMPSRL(RMPLS1,0)),"^",1),RMPLEX=$G(RMPSRL(RMPLS1,"MENU"))
 S RMPLIEN=$S($D(RMPSRL(RMPLS1,"CAT")):"99:CAT;"_$P($G(RMPSRL(RMPLS1,0)),"^"),1:$P($G(RMPSRL(RMPLS1,"IDS",1)),"^")_";"_$P($G(RMPSRL(RMPLS1,0)),"^")_";"_$P($G(RMPSRL(RMPLS1,"LEX",1)),"^")) Q:'$L(RMPLSO) "^"
 Q:'$L(RMPLEX) "^"  Q:+RMPLIEN'>0 "^" S X=RMPLIEN_"^"_RMPLEX
 S RMPLNN="RMPSRL("_+RMPLS1_")",RMPLNC="RMPSRL("_+RMPLS1_","
 F  S RMPLNN=$Q(@RMPLNN) Q:'$L(RMPLNN)!(RMPLNN'[RMPLNC)  D
 . S RMPLRN="RMPLN1("_$P(RMPLNN,"(",2,299) S @RMPLRN=@RMPLNN
 K RMPSRL S RMPLNN="RMPLN1("_+RMPLS1_")",RMPLNC="RMPLN1("_+RMPLS1_","
 F  S RMPLNN=$Q(@RMPLNN) Q:'$L(RMPLNN)!(RMPLNN'[RMPLNC)  D
 . S RMPLRN="RMPSRL("_$P(RMPLNN,"(",2,299),@RMPLRN=@RMPLNN
 Q X
 ; 
 ; Miscellaneous
CL ; Clear
 K RMPLIT
 Q
PR(RMPSRL,X) ; Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,I,Z,%,%D,RMPLC,RMPLI1,RMPLL
 K ^UTILITY($J,"W")
 Q:'$D(RMPSRL)
 S RMPLL=+($G(X))
 S:+RMPLL'>0 RMPLL=79
 S RMPLC=+($G(RMPSRL))
 S:+($G(RMPLC))'>0 RMPLC=$O(RMPSRL(" "),-1)
 Q:+RMPLC'>0
 S DIWL=1,DIWF="C"_+RMPLL
 S RMPLI1=0
 F  S RMPLI1=$O(RMPSRL(RMPLI1)) Q:+RMPLI1=0  S X=$G(RMPSRL(RMPLI1)) D ^DIWP
 K RMPSRL
 S (RMPLC,RMPLI1)=0
 F  S RMPLI1=$O(^UTILITY($J,"W",1,RMPLI1)) Q:+RMPLI1=0  D
 . S RMPSRL(RMPLI1)=$$TM($G(^UTILITY($J,"W",1,RMPLI1,0))," "),RMPLC=RMPLC+1
 S:$L(RMPLC) RMPSRL=RMPLC
 K ^UTILITY($J,"W")
 Q
TM(X,Y) ; Trim Character Y - Default " "
 S X=$G(X) Q:X="" X S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
