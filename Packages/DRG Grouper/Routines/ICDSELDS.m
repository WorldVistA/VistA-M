ICDSELDS ;ALB/SJA/SS/KUM - Select ICD DIAGNOSIS FROM LIXICON UTILITY LIST ;12/07/2011
 ;;18.0;DRG Grouper;**64**;Oct 20, 2000;Build 103
 ;
 ;
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
 ;    or -2 if "^" was entered
 ;               
SEL(ICDSRL,X) ; Select from List
 N ICDGOUP S ICDGOUP=0
 S X=+($G(X))
 S:X'>0 X=5
 S X=$$ASK(.ICDSRL,X)
 I ICDGOUP=1 Q -2
 Q X
 ;
ASK(ICDSRL,X) ; Ask for Selection
 N DTOUT,DUOUT,DIROUT
 N ICDLIT,ICDLL,ICDLTOT
 S ICDLL=+($G(X))
 S:ICDLL'>0 ICDLL=5
 S ICDLIT=0,ICDLTOT=$O(ICDSRL(" "),-1)
 Q:+ICDLTOT'>0 "^"
 K X
 S:+ICDLTOT=1 X=$$ONE(ICDLL,.ICDSRL)
 S:+ICDLTOT>1 X=$$MUL(.ICDSRL,ICDLL)
 S:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(X))'>0) X=-1
 Q X
ONE(X,ICDSRL) ; One Entry Found
 Q:+($G(ICDLIT))>0 "^^"
 N DIR,ICDLC,ICDLEX,ICDLFI,ICDLIT,ICDLSO,ICDLNC
 N ICDLSP,ICDLTX,ICDLC,Y,ICDCNT1
 S ICDLFI=$O(ICDSRL(0)) Q:+ICDLFI'>0 "^"  S ICDLSP=$J(" ",11)
 S ICDLSO=$P(ICDSRL(1,0),"^",1),ICDLNC=$P(ICDSRL(1,0),"^",3)
 S:+ICDLNC>0 ICDLNC=" ("_ICDLNC_")" S ICDLEX=$G(ICDSRL(1,"MENU"))
 S ICDLC=$S($D(ICDSRL(1,"CAT")):"-",1:"")
 S ICDLTX(1)=ICDLSO_ICDLC_$J(" ",(9-$L(ICDLSO)))_" "_ICDLEX_ICDLNC
 D PR(.ICDLTX,64) S DIR("A",1)=" One match found",DIR("A",2)=" "
 S DIR("A",3)=" "_$G(ICDLTX(1))
 S ICDLC=3
 F ICDCNT1=2:1 Q:$G(ICDLTX(ICDCNT1))=""  S ICDLC=ICDLC+1,DIR("A",ICDLC)=ICDLSP_$G(ICDLTX(ICDCNT1))
 S ICDLC=ICDLC+1,DIR("A",ICDLC)=" ",ICDLC=ICDLC+1
 S DIR("A")=" OK? (Yes/No) ",DIR("B")="Yes",DIR(0)="YAO" W !
 D ^DIR Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) ICDLIT=1
 I X["^^"!(+($G(ICDLIT))>0) K ICDSRL Q "^^"
 S X=$S(+Y>0:$$X(1,.ICDSRL),1:-1)
 Q X
MUL(ICDSRL,Y) ; Multiple Entries Found
 Q:+($G(ICDLIT))>0 "^^"
 N ICDSRLE,ICDLL,ICDLMAX,ICDLSS,ICDLX,X
 S (ICDLMAX,ICDLSS,ICDLIT)=0,ICDLL=+($G(Y)),U="^" S:+($G(ICDLL))'>0 ICDLL=5
 S ICDLX=$O(ICDSRL(" "),-1),ICDLSS=0
 G:+ICDLX=0 MULQ W ! W:+ICDLX>1 !," ",ICDLX," matches found"
 F ICDSRLE=1:1:ICDLX Q:((ICDLSS>0)&(ICDLSS<(ICDSRLE+1)))  Q:ICDLIT  D  Q:ICDLIT
 . W:ICDSRLE#ICDLL=1 ! D MULW
 . S ICDLMAX=ICDSRLE W:ICDSRLE#ICDLL=0 !
 . S:ICDSRLE#ICDLL=0 ICDLSS=$$MULS(ICDLMAX,ICDSRLE,.ICDSRL) S:ICDLSS["^" ICDLIT=1
 I ICDSRLE#ICDLL'=0,+ICDLSS<=0 D
 . W ! S ICDLSS=$$MULS(ICDLMAX,ICDSRLE,.ICDSRL) S:ICDLSS["^" ICDLIT=1
 G MULQ
 Q X
MULW ; Write Multiple
 N ICDLEX,ICDLI1,ICDLSO,ICDLNC,ICDLT2,ICDLTX S ICDLSO=$P(ICDSRL(+ICDSRLE,0),"^",1)
 S ICDLNC=$P(ICDSRL(+ICDSRLE,0),"^",3) S:+ICDLNC>0 ICDLNC=" ("_ICDLNC_")"
 S ICDLEX=$G(ICDSRL(+ICDSRLE,"MENU")),ICDLTX(1)=ICDLSO
 S ICDLTX(1)=ICDLTX(1)_$S($D(ICDSRL(+ICDSRLE,"CAT")):"-",1:" ")_$J(" ",(9-$L(ICDLSO)))_" "_ICDLEX_ICDLNC
 D PR(.ICDLTX,60) W !,$J(ICDSRLE,5),".  ",$G(ICDLTX(1))
 F ICDLI1=2:1:5 S ICDLT2=$G(ICDLTX(ICDLI1)) W:$L(ICDLT2) !,$J(" ",19),ICDLT2
 Q
MULS(X,Y,ICDSRL) ; Select from Multiple Entries
 N DIR,DIRB,ICDLFI,ICDLHLP,ICDLLST,ICDLMAX,ICDLS1 ;@#$ not sure ICDLS1 is  neede here
 Q:+($G(ICDLIT))>0 "^^"  S ICDLMAX=+($G(X)),ICDLLST=+($G(Y))
 Q:ICDLMAX=0 -1 S ICDLFI=$O(ICDSRL(0)) Q:+ICDLFI'>0 -1
 I +($O(ICDSRL(+ICDLLST)))>0 D
 . S DIR("A")=" Press <RETURN> for more, ""^"" to exit, or Select 1-"
 . S DIR("A")=DIR("A")_ICDLMAX_": "
 I +($O(ICDSRL(+ICDLLST)))'>0 D
 . S DIR("A")=" Select 1-"_ICDLMAX_": "
 S ICDLHLP=" Answer must be from 1 to "
 S ICDLHLP=ICDLHLP_ICDLMAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??"""
 S (DIR("?"),DIR("??"))="^D MULSH^ZZLXDG2"
 S DIR(0)="NAO^1:"_ICDLMAX_":0" D ^DIR
 S:X="^" ICDGOUP=1
 Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) ICDLIT=1,X="^^" I X["^^"!(+($G(ICDLIT))>0) Q "^^"
 K DIR Q:$D(DTOUT)!(X[U) "^^"
 Q $S(+Y>0:+Y,1:"-1")
MULSH ; Select from Multiple Entries Help
 I $L($G(ICDLHLP)) W !,$G(ICDLHLP) Q
 Q
MULQ ; Quit Multiple
 I +ICDLSS'>0,$G(ICDLSS)="^" Q "^"
 S X=-1 S:+($G(ICDLIT))'>0 X=$$X(+ICDLSS,.ICDSRL)
 Q X
X(X,ICDSRL) ; Set X and Output Array
 N ICDLEX,ICDSRFI,ICDLIEN,ICDLN1,ICDLNC,ICDLNN,ICDLRN,ICDLS1,ICDLSO
 S ICDLS1=+($G(X))
 S ICDSRFI=$O(ICDSRL(0)) ;@#$ not used?
 S ICDLSO=$P($G(ICDSRL(ICDLS1,0)),"^",1),ICDLEX=$G(ICDSRL(ICDLS1,"MENU"))
 S ICDLIEN=$S($D(ICDSRL(ICDLS1,"CAT")):"99:CAT;"_$P($G(ICDSRL(ICDLS1,0)),"^"),1:$P($G(ICDSRL(ICDLS1,"LEX",1)),"^")_";"_$P($G(ICDSRL(ICDLS1,0)),"^")) Q:'$L(ICDLSO) "^"
 Q:'$L(ICDLEX) "^"  Q:+ICDLIEN'>0 "^" S X=ICDLIEN_"^"_ICDLEX
 S ICDLNN="ICDSRL("_+ICDLS1_")",ICDLNC="ICDSRL("_+ICDLS1_","
 F  S ICDLNN=$Q(@ICDLNN) Q:'$L(ICDLNN)!(ICDLNN'[ICDLNC)  D
 . S ICDLRN="ICDLN1("_$P(ICDLNN,"(",2,299) S @ICDLRN=@ICDLNN
 K ICDSRL S ICDLNN="ICDLN1("_+ICDLS1_")",ICDLNC="ICDLN1("_+ICDLS1_","
 F  S ICDLNN=$Q(@ICDLNN) Q:'$L(ICDLNN)!(ICDLNN'[ICDLNC)  D
 . S ICDLRN="ICDSRL("_$P(ICDLNN,"(",2,299),@ICDLRN=@ICDLNN
 Q X
 ; 
 ; Miscellaneous
CL ; Clear
 K ICDLIT
 Q
PR(ICDSRL,X) ; Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,ICDDN,I,Z,%,%D,ICDLC,ICDLI1,ICDLL
 K ^UTILITY($J,"W")
 Q:'$D(ICDSRL)
 S ICDLL=+($G(X))
 S:+ICDLL'>0 ICDLL=79
 S ICDLC=+($G(ICDSRL))
 S:+($G(ICDLC))'>0 ICDLC=$O(ICDSRL(" "),-1)
 Q:+ICDLC'>0
 S DIWL=1,DIWF="C"_+ICDLL
 S ICDLI1=0
 F  S ICDLI1=$O(ICDSRL(ICDLI1)) Q:+ICDLI1=0  S X=$G(ICDSRL(ICDLI1)) D ^DIWP
 K ICDSRL
 S (ICDLC,ICDLI1)=0
 F  S ICDLI1=$O(^UTILITY($J,"W",1,ICDLI1)) Q:+ICDLI1=0  D
 . S ICDSRL(ICDLI1)=$$TM($G(^UTILITY($J,"W",1,ICDLI1,0))," "),ICDLC=ICDLC+1
 S:$L(ICDLC) ICDSRL=ICDLC
 K ^UTILITY($J,"W")
 Q
TM(ICDX,ICDY) ; Trim Character Y - Default " "
 S ICDX=$G(ICDX) Q:ICDX="" ICDX S ICDY=$G(ICDY) S:'$L(ICDY) ICDY=" "
 F  Q:$E(ICDX,1)'=ICDY  S ICDX=$E(ICDX,2,$L(ICDX))
 F  Q:$E(ICDX,$L(ICDX))'=ICDY  S ICDX=$E(ICDX,1,($L(ICDX)-1))
 Q ICDX
