IBDLXDG2 ;ALB/CFS - Select ICD DIAGNOSIS FROM LEXICON UTILITY LIST ;03/27/2012
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**63**;Mar 27, 2012;Build 80
 ;
 ; Input   
 ; 
 ;     X     Length of list to display (default 5)
 ;    .IBDSRL   Local array passed by reference
 ;               
 ;             IBDSRL()   Input Array from ICDSRCH^LEX10CS
 ;               
 ;             IBDSRL(0)=# found ^ Pruning Indicator
 ;             IBDSRL(1,0)=Code ^ Code IEN ^ date
 ;             IBDSRL(1,"IDL")=ICD-9/10 Description, Long
 ;             IBDSRL(1,"IDL",1)=ICD-9/10 IEN ^ date
 ;             IBDSRL(1,"IDS")=ICD-9/10 Description, Short
 ;             IBDSRL(1,"IDS",1)=ICD-9/10 IEN ^ date
 ;             IBDSRL(1,"LEX")=Lexicon Description
 ;             IBDSRL(1,"LEX",1)=Expression IEN ^ date
 ;             IBDSRL(1,"SYN",1)=Synonym #1
 ;             IBDSRL(1,"SYN",m)=Synonym #m
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
 ;    IBDSRL    Local array passed by reference
 ;               
 ;             IBDSRL(0)=Code ^ Code IEN ^ date
 ;             IBDSRL("IDL")=ICD-9/10 Description, Long
 ;             IBDSRL("IDL",1)=ICD-9/10 IEN ^ date
 ;             IBDSRL("IDS")=ICD-9/10 Description, Short
 ;             IBDSRL("IDS",1)=ICD-9/10 IEN ^ date
 ;             IBDSRL("LEX")=Lexicon Description
 ;             IBDSRL("LEX",1)=Expression IEN ^ date
 ;               
 ;    or ^ on error 
 ;    or -1 for non-selection
 ;    or -2 if "^" was entered
 ;               
SEL(IBDSRL,X) ; Select from List
 N IBDGOUP S IBDGOUP=0
 S X=+($G(X))
 S:X'>0 X=5
 S X=$$ASK(.IBDSRL,X)
 I IBDGOUP=1 Q -2
 Q X
 ;
ASK(IBDSRL,X) ; Ask for Selection
 N DTOUT,DUOUT,DIROUT
 N IBDLIT,IBDLL,IBDLTOT
 S IBDLL=+($G(X))
 S:IBDLL'>0 IBDLL=5
 S IBDLIT=0,IBDLTOT=$O(IBDSRL(" "),-1)
 Q:+IBDLTOT'>0 "^"
 K X
 S:+IBDLTOT=1 X=$$ONE(IBDLL,.IBDSRL)
 S:+IBDLTOT>1 X=$$MUL(.IBDSRL,IBDLL)
 S:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(X))'>0) X=-1
 Q X
ONE(X,IBDSRL) ; One Entry Found
 Q:+($G(IBDLIT))>0 "^^"
 N DIR,IBDLC,IBDLEX,IBDLFI,IBDLIT,IBDLSO,IBDLNC,IBDCNT1
 N IBDLSP,IBDLTX,IBDLC,Y
 S IBDLFI=$O(IBDSRL(0)) Q:+IBDLFI'>0 "^"  S IBDLSP=$J(" ",11)
 S IBDLSO=$P(IBDSRL(1,0),"^",1),IBDLNC=$P(IBDSRL(1,0),"^",3)
 S:+IBDLNC>0 IBDLNC=" ("_IBDLNC_")" S IBDLEX=$G(IBDSRL(1,"MENU"))
 S IBDLC=$S($D(IBDSRL(1,"CAT")):"-",1:"")
 S IBDLTX(1)=IBDLSO_IBDLC_$J(" ",(9-$L(IBDLSO)))_" "_IBDLEX_IBDLNC
 D PR(.IBDLTX,64) S DIR("A",1)=" One match found",DIR("A",2)=" "
 S DIR("A",3)=" "_$G(IBDLTX(1))
 S IBDLC=3
 F IBDCNT1=2:1 Q:$G(IBDLTX(IBDCNT1))=""  S IBDLC=IBDLC+1,DIR("A",IBDLC)=IBDLSP_$G(IBDLTX(IBDCNT1))
 S IBDLC=IBDLC+1,DIR("A",IBDLC)=" ",IBDLC=IBDLC+1
 S DIR("A")=" OK? (Yes/No) ",DIR("B")="Yes",DIR(0)="YAO" W !
 D ^DIR Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) IBDLIT=1
 I X["^^"!(+($G(IBDLIT))>0) K IBDSRL Q "^^"
 S X=$S(+Y>0:$$X(1,.IBDSRL),1:-1)
 Q X
MUL(IBDSRL,Y) ; Multiple Entries Found
 Q:+($G(IBDLIT))>0 "^^"
 N IBDSRLE,IBDLL,IBDLMAX,IBDLSS,IBDLX,X
 S (IBDLMAX,IBDLSS,IBDLIT)=0,IBDLL=+($G(Y)),U="^" S:+($G(IBDLL))'>0 IBDLL=5
 S IBDLX=$O(IBDSRL(" "),-1),IBDLSS=0
 G:+IBDLX=0 MULQ W ! W:+IBDLX>1 !," ",IBDLX," matches found"
 F IBDSRLE=1:1:IBDLX Q:((IBDLSS>0)&(IBDLSS<(IBDSRLE+1)))  Q:IBDLIT  D  Q:IBDLIT
 . W:IBDSRLE#IBDLL=1 ! D MULW
 . S IBDLMAX=IBDSRLE W:IBDSRLE#IBDLL=0 !
 . S:IBDSRLE#IBDLL=0 IBDLSS=$$MULS(IBDLMAX,IBDSRLE,.IBDSRL) S:IBDLSS["^" IBDLIT=1
 I IBDSRLE#IBDLL'=0,+IBDLSS<=0 D
 . W ! S IBDLSS=$$MULS(IBDLMAX,IBDSRLE,.IBDSRL) S:IBDLSS["^" IBDLIT=1
 G MULQ
 Q X
MULW ; Write Multiple
 N IBDLEX,IBDLI1,IBDLSO,IBDLNC,IBDLT2,IBDLTX S IBDLSO=$P(IBDSRL(+IBDSRLE,0),"^",1)
 S IBDLNC=$P(IBDSRL(+IBDSRLE,0),"^",3) S:+IBDLNC>0 IBDLNC=" ("_IBDLNC_")"
 S IBDLEX=$G(IBDSRL(+IBDSRLE,"MENU")),IBDLTX(1)=IBDLSO
 S IBDLTX(1)=IBDLTX(1)_$S($D(IBDSRL(+IBDSRLE,"CAT")):"-",1:" ")_$J(" ",(9-$L(IBDLSO)))_" "_IBDLEX_IBDLNC
 D PR(.IBDLTX,60) W !,$J(IBDSRLE,5),".  ",$G(IBDLTX(1))
 F IBDLI1=2:1:5 S IBDLT2=$G(IBDLTX(IBDLI1)) W:$L(IBDLT2) !,$J(" ",19),IBDLT2
 Q
MULS(X,Y,IBDSRL) ; Select from Multiple Entries
 N DIR,DIRB,IBDLFI,IBDLHLP,IBDLLST,IBDLMAX,IBDLS1
 Q:+($G(IBDLIT))>0 "^^"  S IBDLMAX=+($G(X)),IBDLLST=+($G(Y))
 Q:IBDLMAX=0 -1 S IBDLFI=$O(IBDSRL(0)) Q:+IBDLFI'>0 -1
 I +($O(IBDSRL(+IBDLLST)))>0 D
 . S DIR("A")=" Press <RETURN> for more, ""^"" to exit, or Select 1-"
 . S DIR("A")=DIR("A")_IBDLMAX_": "
 I +($O(IBDSRL(+IBDLLST)))'>0 D
 . S DIR("A")=" Select 1-"_IBDLMAX_": "
 S IBDLHLP=" Answer must be from 1 to "
 S IBDLHLP=IBDLHLP_IBDLMAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??"""
 S (DIR("?"),DIR("??"))="^D MULSH^IBDLXDG2"
 S DIR(0)="NAO^1:"_IBDLMAX_":0" D ^DIR
 S:X="^" IBDGOUP=1
 W:X="" @IOF ;clear the screen if the next page
 Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) IBDLIT=1,X="^^" I X["^^"!(+($G(IBDLIT))>0) Q "^^"
 K DIR Q:$D(DTOUT)!(X[U) "^^"
 Q $S(+Y>0:+Y,1:"-1")
MULSH ; Select from Multiple Entries Help
 I $L($G(IBDLHLP)) W !,$G(IBDLHLP) Q
 Q
MULQ ; Quit Multiple
 I +IBDLSS'>0,$G(IBDLSS)="^" Q "^"
 S X=-1 S:+($G(IBDLIT))'>0 X=$$X(+IBDLSS,.IBDSRL)
 Q X
X(X,IBDSRL) ; Set X and Output Array
 N IBDLEX,IBDSRFI,IBDLIEN,IBDLN1,IBDLNC,IBDLNN,IBDLRN,IBDLS1,IBDLSO
 S IBDLS1=+($G(X))
 S IBDSRFI=$O(IBDSRL(0)) ;
 S IBDLSO=$P($G(IBDSRL(IBDLS1,0)),"^",1),IBDLEX=$G(IBDSRL(IBDLS1,"MENU"))
 ;S IBDLIEN=$S($D(IBDSRL(IBDLS1,"CAT")):"99:CAT;"_$P($G(IBDSRL(IBDLS1,0)),"^"),1:$P($G(IBDSRL(IBDLS1,"LEX",1)),"^")_";"_$P($G(IBDSRL(IBDLS1,0)),"^")) Q:'$L(IBDLSO) "^"
 S IBDLIEN=$S($D(IBDSRL(IBDLS1,"CAT")):"99:CAT;"_$P($G(IBDSRL(IBDLS1,0)),"^"),1:$P($G(IBDSRL(IBDLS1,"IDS",1)),"^")_";"_$P($G(IBDSRL(IBDLS1,0)),"^")_";"_$P($G(IBDSRL(IBDLS1,"LEX",1)),"^")) Q:'$L(IBDLSO) "^"
 Q:'$L(IBDLEX) "^"  Q:+IBDLIEN'>0 "^" S X=IBDLIEN_"^"_IBDLEX
 S IBDLNN="IBDSRL("_+IBDLS1_")",IBDLNC="IBDSRL("_+IBDLS1_","
 F  S IBDLNN=$Q(@IBDLNN) Q:'$L(IBDLNN)!(IBDLNN'[IBDLNC)  D
 . S IBDLRN="IBDLN1("_$P(IBDLNN,"(",2,299) S @IBDLRN=@IBDLNN
 K IBDSRL S IBDLNN="IBDLN1("_+IBDLS1_")",IBDLNC="IBDLN1("_+IBDLS1_","
 F  S IBDLNN=$Q(@IBDLNN) Q:'$L(IBDLNN)!(IBDLNN'[IBDLNC)  D
 . S IBDLRN="IBDSRL("_$P(IBDLNN,"(",2,299),@IBDLRN=@IBDLNN
 Q X
 ; 
 ; Miscellaneous
CL ; Clear
 K IBDLIT
 Q
PR(IBDSRL,X) ; Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,I,Z,%,IBDLC,IBDLI1,IBDLL
 K ^UTILITY($J,"W")
 Q:'$D(IBDSRL)
 S IBDLL=+($G(X))
 S:+IBDLL'>0 IBDLL=79
 S IBDLC=+($G(IBDSRL))
 S:+($G(IBDLC))'>0 IBDLC=$O(IBDSRL(" "),-1)
 Q:+IBDLC'>0
 S DIWL=1,DIWF="C"_+IBDLL
 S IBDLI1=0
 F  S IBDLI1=$O(IBDSRL(IBDLI1)) Q:+IBDLI1=0  S X=$G(IBDSRL(IBDLI1)) D ^DIWP
 K IBDSRL
 S (IBDLC,IBDLI1)=0
 F  S IBDLI1=$O(^UTILITY($J,"W",1,IBDLI1)) Q:+IBDLI1=0  D
 . S IBDSRL(IBDLI1)=$$TM($G(^UTILITY($J,"W",1,IBDLI1,0))," "),IBDLC=IBDLC+1
 S:$L(IBDLC) IBDSRL=IBDLC
 K ^UTILITY($J,"W")
 Q
TM(X,Y) ; Trim Character Y - Default " "
 S X=$G(X) Q:X="" X S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
