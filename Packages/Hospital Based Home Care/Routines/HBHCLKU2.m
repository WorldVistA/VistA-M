HBHCLKU2 ;ALB/KG - DIAGNOSIS LOOK UP ;5/15/12
 ;;1.0;HOSPITAL BASED HOME CARE;**25**;NOV 01, 1993;Build 45
 ;******************************************************************************
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;HBH*1.0*25   FEB  2012   K GUPTA      Support for ICD-10 Coding System
 ;******************************************************************************
 ;******************************************************************************
 ;
 ; Input   
 ; 
 ;     X     Length of list to display (default 5)
 ;    .HBHCSRL   Local array passed by reference
 ;               
 ;             HBHCSRL()   Input Array from ICDSRCH^LEX10CS
 ;               
 ;             HBHCSRL(0)=# found ^ Pruning Indicator
 ;             HBHCSRL(1,0)=Code ^ Code IEN ^ date
 ;             HBHCSRL(1,"IDL")=ICD-9/10 Description, Long
 ;             HBHCSRL(1,"IDL",1)=ICD-9/10 IEN ^ date
 ;             HBHCSRL(1,"IDS")=ICD-9/10 Description, Short
 ;             HBHCSRL(1,"IDS",1)=ICD-9/10 IEN ^ date
 ;             HBHCSRL(1,"LEX")=Lexicon Description
 ;             HBHCSRL(1,"LEX",1)=Expression IEN ^ date
 ;             HBHCSRL(1,"SYN",1)=Synonym #1
 ;             HBHCSRL(1,"SYN",m)=Synonym #m
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
 ;    HBHCSRL    Local array passed by reference
 ;               
 ;             HBHCSRL(0)=Code ^ Code IEN ^ date
 ;             HBHCSRL("IDL")=ICD-9/10 Description, Long
 ;             HBHCSRL("IDL",1)=ICD-9/10 IEN ^ date
 ;             HBHCSRL("IDS")=ICD-9/10 Description, Short
 ;             HBHCSRL("IDS",1)=ICD-9/10 IEN ^ date
 ;             HBHCSRL("LEX")=Lexicon Description
 ;             HBHCSRL("LEX",1)=Expression IEN ^ date
 ;               
 ;    or ^ on error 
 ;    or -1 for non-selection
 ;    or -2 if "^" was entered
 ;    or -3 if time out
 ;               
SEL(HBHCSRL,X) ; Select from List
 N HBHCGOUP S HBHCGOUP=0
 S X=+($G(X))
 S:X'>0 X=5
 S X=$$ASK(.HBHCSRL,X)
 I HBHCGOUP=1 Q -2
 Q X
 ;
ASK(HBHCSRL,X) ; Ask for Selection
 N DTOUT,DUOUT,DIROUT
 N HBHCLIT,HBHCLL,HBHCLTOT
 S HBHCLL=+($G(X))
 S:HBHCLL'>0 HBHCLL=5
 S HBHCLIT=0,HBHCLTOT=$O(HBHCSRL(" "),-1)
 Q:+HBHCLTOT'>0 "^"
 K X
 S:+HBHCLTOT=1 X=$$ONE(HBHCLL,.HBHCSRL)
 S:+HBHCLTOT>1 X=$$MUL(.HBHCSRL,HBHCLL)
 Q:$D(DTOUT) -3    ;time out
 Q:$D(DIROUT) -5   ;^^
 Q:$D(DUOUT) -2    ;^
 Q:+($G(X))'>0 -1  ;non-selection
 Q X
ONE(X,HBHCSRL) ; One Entry Found
 Q:+($G(HBHCLIT))>0 "^^"
 N DIR,HBHCLC,HBHCLEX,HBHCLFI,HBHCLIT,HBHCLSO,HBHCLNC
 N HBHCLSP,HBHCLTX,HBHCLC,Y
 S HBHCLFI=$O(HBHCSRL(0)) Q:+HBHCLFI'>0 "^"  S HBHCLSP=$J(" ",25)
 S HBHCLSO=$P(HBHCSRL(1,0),"^",1),HBHCLNC=$P(HBHCSRL(1,0),"^",3)
 S:+HBHCLNC>0 HBHCLNC=" ("_HBHCLNC_")" S HBHCLEX=$G(HBHCSRL(1,"MENU"))
 S HBHCLC=$S($D(HBHCSRL(1,"CAT")):"-",1:"")
 S HBHCLTX(1)=HBHCLSO_HBHCLC_$J(" ",(9-$L(HBHCLSO)))_" "_HBHCLEX_HBHCLNC
 D PR(.HBHCLTX,64) S DIR("A",1)=" One match found",DIR("A",2)=" "
 S DIR("A",3)=" "_$G(HBHCLTX(1)),HBHCLC=3 I $L($G(HBHCLTX(2))) D
 . S HBHCLC=HBHCLC+1,DIR("A",HBHCLC)=HBHCLSP_$G(HBHCLTX(2))
 S HBHCLC=HBHCLC+1,DIR("A",HBHCLC)=" ",HBHCLC=HBHCLC+1
 S DIR("A")=" OK? (Yes/No) ",DIR("B")="Yes",DIR(0)="YAO" W !
 D ^DIR Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) HBHCLIT=1
 I X["^^"!(+($G(HBHCLIT))>0) K HBHCSRL Q "^^"
 S X=$S(+Y>0:$$X(1,.HBHCSRL),1:-1)
 Q X
MUL(HBHCSRL,Y) ; Multiple Entries Found
 Q:+($G(HBHCLIT))>0 "^^"
 N HBHCSRLE,HBHCLL,HBHCLMAX,HBHCLSS,HBHCLX,X
 S (HBHCLMAX,HBHCLSS,HBHCLIT)=0,HBHCLL=+($G(Y)),U="^" S:+($G(HBHCLL))'>0 HBHCLL=5
 S HBHCLX=$O(HBHCSRL(" "),-1),HBHCLSS=0
 G:+HBHCLX=0 MULQ W ! W:+HBHCLX>1 !," ",HBHCLX," matches found"
 F HBHCSRLE=1:1:HBHCLX Q:((HBHCLSS>0)&(HBHCLSS<(HBHCSRLE+1)))  Q:HBHCLIT  D  Q:HBHCLIT
 . W:HBHCSRLE#HBHCLL=1 ! D MULW
 . S HBHCLMAX=HBHCSRLE W:HBHCSRLE#HBHCLL=0 !
 . S:HBHCSRLE#HBHCLL=0 HBHCLSS=$$MULS(HBHCLMAX,HBHCSRLE,.HBHCSRL) S:HBHCLSS["^" HBHCLIT=1
 I HBHCSRLE#HBHCLL'=0,+HBHCLSS<=0 D
 . W ! S HBHCLSS=$$MULS(HBHCLMAX,HBHCSRLE,.HBHCSRL) S:HBHCLSS["^" HBHCLIT=1
 G MULQ
 Q X
MULW ; Write Multiple
 N HBHCLEX,HBHCLI1,HBHCLSO,HBHCLNC,HBHCLT2,HBHCLTX S HBHCLSO=$P(HBHCSRL(+HBHCSRLE,0),"^",1)
 S HBHCLNC=$P(HBHCSRL(+HBHCSRLE,0),"^",3) S:+HBHCLNC>0 HBHCLNC=" ("_HBHCLNC_")"
 S HBHCLEX=$G(HBHCSRL(+HBHCSRLE,"MENU")),HBHCLTX(1)=HBHCLSO
 S HBHCLTX(1)=HBHCLTX(1)_$S($D(HBHCSRL(+HBHCSRLE,"CAT")):"-",1:" ")_$J(" ",(9-$L(HBHCLSO)))_" "_HBHCLEX_HBHCLNC
 D PR(.HBHCLTX,60) W !,$J(HBHCSRLE,5),".  ",$G(HBHCLTX(1))
 F HBHCLI1=2:1:5 S HBHCLT2=$G(HBHCLTX(HBHCLI1)) W:$L(HBHCLT2) !,$J(" ",19),HBHCLT2
 Q
MULS(X,Y,HBHCSRL) ; Select from Multiple Entries
 N DIR,DIRB,HBHCLFI,HBHCLHLP,HBHCLLST,HBHCLMAX,HBHCLS1 ;@#$ not sure HBHCLS1 is  neede here
 Q:+($G(HBHCLIT))>0 "^^"  S HBHCLMAX=+($G(X)),HBHCLLST=+($G(Y))
 Q:HBHCLMAX=0 -1 S HBHCLFI=$O(HBHCSRL(0)) Q:+HBHCLFI'>0 -1
 I +($O(HBHCSRL(+HBHCLLST)))>0 D
 . S DIR("A")=" Press <RETURN> for more, ""^"" to exit, or Select 1-"
 . S DIR("A")=DIR("A")_HBHCLMAX_": "
 I +($O(HBHCSRL(+HBHCLLST)))'>0 D
 . S DIR("A")=" Select 1-"_HBHCLMAX_": "
 S HBHCLHLP=" Answer must be from 1 to "
 S HBHCLHLP=HBHCLHLP_HBHCLMAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??"""
 S (DIR("?"),DIR("??"))="^D MULSH^HBHCLKU2"
 S DIR(0)="NAO^1:"_HBHCLMAX_":0" D ^DIR
 S:X="^" HBHCGOUP=1
 Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) HBHCLIT=1,X="^^" I X["^^"!(+($G(HBHCLIT))>0) Q "^^"
 K DIR Q:$D(DTOUT)!(X[U) "^^"
 Q $S(+Y>0:+Y,1:"-1")
MULSH ; Select from Multiple Entries Help
 I $L($G(HBHCLHLP)) W !,$G(HBHCLHLP) Q
 Q
MULQ ; Quit Multiple
 I +HBHCLSS'>0,$G(HBHCLSS)="^" Q "^"
 S X=-1 S:+($G(HBHCLIT))'>0 X=$$X(+HBHCLSS,.HBHCSRL)
 Q X
X(X,HBHCSRL) ; Set X and Output Array
 N HBHCLEX,HBHCSRFI,HBHCLIEN,HBHCLN1,HBHCLNC,HBHCLNN,HBHCLRN,HBHCLS1,HBHCLSO
 S HBHCLS1=+($G(X))
 S HBHCSRFI=$O(HBHCSRL(0)) ;@#$ not used?
 S HBHCLSO=$P($G(HBHCSRL(HBHCLS1,0)),"^",1),HBHCLEX=$G(HBHCSRL(HBHCLS1,"MENU"))
 S HBHCLIEN=$S($D(HBHCSRL(HBHCLS1,"CAT")):"99:CAT;"_$P($G(HBHCSRL(HBHCLS1,0)),"^"),1:$P($G(HBHCSRL(HBHCLS1,"IDS",1)),"^")_";"_$P($G(HBHCSRL(HBHCLS1,0)),"^")_";"_$P($G(HBHCSRL(HBHCLS1,"LEX",1)),"^")) Q:'$L(HBHCLSO) "^"
 Q:'$L(HBHCLEX) "^"  Q:+HBHCLIEN'>0 "^" S X=HBHCLIEN_"^"_HBHCLEX
 S HBHCLNN="HBHCSRL("_+HBHCLS1_")",HBHCLNC="HBHCSRL("_+HBHCLS1_","
 F  S HBHCLNN=$Q(@HBHCLNN) Q:'$L(HBHCLNN)!(HBHCLNN'[HBHCLNC)  D
 . S HBHCLRN="HBHCLN1("_$P(HBHCLNN,"(",2,299) S @HBHCLRN=@HBHCLNN
 K HBHCSRL S HBHCLNN="HBHCLN1("_+HBHCLS1_")",HBHCLNC="HBHCLN1("_+HBHCLS1_","
 F  S HBHCLNN=$Q(@HBHCLNN) Q:'$L(HBHCLNN)!(HBHCLNN'[HBHCLNC)  D
 . S HBHCLRN="HBHCSRL("_$P(HBHCLNN,"(",2,299),@HBHCLRN=@HBHCLNN
 Q X
 ; 
 ; Miscellaneous
CL ; Clear
 K HBHCLIT
 Q
PR(HBHCSRL,X) ; Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,I,Z,%,%D,HBHCLC,HBHCLI1,HBHCLL
 K ^UTILITY($J,"W")
 Q:'$D(HBHCSRL)
 S HBHCLL=+($G(X))
 S:+HBHCLL'>0 HBHCLL=79
 S HBHCLC=+($G(HBHCSRL))
 S:+($G(HBHCLC))'>0 HBHCLC=$O(HBHCSRL(" "),-1)
 Q:+HBHCLC'>0
 S DIWL=1,DIWF="C"_+HBHCLL
 S HBHCLI1=0
 F  S HBHCLI1=$O(HBHCSRL(HBHCLI1)) Q:+HBHCLI1=0  S X=$G(HBHCSRL(HBHCLI1)) D ^DIWP
 K HBHCSRL
 S (HBHCLC,HBHCLI1)=0
 F  S HBHCLI1=$O(^UTILITY($J,"W",1,HBHCLI1)) Q:+HBHCLI1=0  D
 . S HBHCSRL(HBHCLI1)=$$TM($G(^UTILITY($J,"W",1,HBHCLI1,0))," "),HBHCLC=HBHCLC+1
 S:$L(HBHCLC) HBHCSRL=HBHCLC
 K ^UTILITY($J,"W")
 Q
TM(X,Y) ; Trim Character Y - Default " "
 S X=$G(X) Q:X="" X S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
