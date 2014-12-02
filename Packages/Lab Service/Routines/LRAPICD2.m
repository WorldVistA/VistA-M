LRAPICD2 ;ALB/JAM - Anatomic Pathology ICD-10 DIAGNOSIS CODE API ;6/15/12
 ;;5.2;LAB SERVICE;**422**;Sep 27, 1994;Build 29
 ;
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Routine based on ^ZZLXDG2
 ;
 ; Input   
 ; 
 ;     X     Length of list to display (default 5)
 ;    .LRASRL   Local array passed by reference
 ;               
 ;             LRASRL()   Input Array from ICDSRCH^LEX10CS
 ;               
 ;             LRASRL(0)=# found ^ Pruning Indicator
 ;             LRASRL(1,0)=Code ^ Code IEN ^ date
 ;             LRASRL(1,"IDL")=ICD-9/10 Description, Long
 ;             LRASRL(1,"IDL",1)=ICD-9/10 IEN ^ date
 ;             LRASRL(1,"IDS")=ICD-9/10 Description, Short
 ;             LRASRL(1,"IDS",1)=ICD-9/10 IEN ^ date
 ;             LRASRL(1,"LEX")=Lexicon Description
 ;             LRASRL(1,"LEX",1)=Expression IEN ^ date
 ;             LRASRL(1,"SYN",1)=Synonym #1
 ;             LRASRL(1,"SYN",m)=Synonym #m
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
 ;    LRASRL    Local array passed by reference
 ;               
 ;             LRASRL(0)=Code ^ Code IEN ^ date
 ;             LRASRL("IDL")=ICD-9/10 Description, Long
 ;             LRASRL("IDL",1)=ICD-9/10 IEN ^ date
 ;             LRASRL("IDS")=ICD-9/10 Description, Short
 ;             LRASRL("IDS",1)=ICD-9/10 IEN ^ date
 ;             LRASRL("LEX")=Lexicon Description
 ;             LRASRL("LEX",1)=Expression IEN ^ date
 ;               
 ;    or ^ on error 
 ;    or -1 for non-selection
 ;    or -2 if "^" was entered
 ;               
SEL(LRASRL,X) ; Select from List
 N LRAGOUP S LRAGOUP=0
 S X=+($G(X))
 S:X'>0 X=5
 S X=$$ASK(.LRASRL,X)
 I LRAGOUP=1 Q -2
 Q X
 ;
ASK(LRASRL,X) ; Ask for Selection
 N DTOUT,DUOUT,DIROUT
 N LRALIT,LRALL,LRALTOT
 S LRALL=+($G(X))
 S:LRALL'>0 LRALL=5
 S LRALIT=0,LRALTOT=$O(LRASRL(" "),-1)
 Q:+LRALTOT'>0 "^"
 K X
 S:+LRALTOT=1 X=$$ONE(LRALL,.LRASRL)
 S:+LRALTOT>1 X=$$MUL(.LRASRL,LRALL)
 S:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(X))'>0) X=-1
 Q X
ONE(X,LRASRL) ; One Entry Found
 Q:+($G(LRALIT))>0 "^^"
 N DIR,LRALC,LRALEX,LRALFI,LRALIT,LRALSO,LRALNC,LRACNT1
 N LRALSP,LRALTX,LRALC,Y
 S LRALFI=$O(LRASRL(0)) Q:+LRALFI'>0 "^"  S LRALSP=$J(" ",11)
 S LRALSO=$P(LRASRL(1,0),"^",1),LRALNC=$P(LRASRL(1,0),"^",3)
 S:+LRALNC>0 LRALNC=" ("_LRALNC_")" S LRALEX=$G(LRASRL(1,"MENU"))
 S LRALC=$S($D(LRASRL(1,"CAT")):"-",1:"")
 S LRALTX(1)=LRALSO_LRALC_$J(" ",(9-$L(LRALSO)))_" "_LRALEX_LRALNC
 D PR(.LRALTX,64) S DIR("A",1)=" One match found",DIR("A",2)=" "
 S DIR("A",3)=" "_$G(LRALTX(1))
 S LRALC=3
 F LRACNT1=2:1 Q:$G(LRALTX(LRACNT1))=""  S LRALC=LRALC+1,DIR("A",LRALC)=LRALSP_$G(LRALTX(LRACNT1))
 S LRALC=LRALC+1,DIR("A",LRALC)=" ",LRALC=LRALC+1
 S DIR("A")=" OK? (Yes/No) ",DIR("B")="Yes",DIR(0)="YAO" W !
 D ^DIR Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) LRALIT=1
 I X["^^"!(+($G(LRALIT))>0) K LRASRL Q "^^"
 S X=$S(+Y>0:$$X(1,.LRASRL),1:-1)
 Q X
MUL(LRASRL,Y) ; Multiple Entries Found
 Q:+($G(LRALIT))>0 "^^"
 N LRASRLE,LRALL,LRALMAX,LRALSS,LRALX,X
 S (LRALMAX,LRALSS,LRALIT)=0,LRALL=+($G(Y)),U="^" S:+($G(LRALL))'>0 LRALL=5
 S LRALX=$O(LRASRL(" "),-1),LRALSS=0
 G:+LRALX=0 MULQ W ! W:+LRALX>1 !," ",LRALX," matches found"
 F LRASRLE=1:1:LRALX Q:((LRALSS>0)&(LRALSS<(LRASRLE+1)))  Q:LRALIT  D  Q:LRALIT
 . W:LRASRLE#LRALL=1 ! D MULW
 . S LRALMAX=LRASRLE W:LRASRLE#LRALL=0 !
 . S:LRASRLE#LRALL=0 LRALSS=$$MULS(LRALMAX,LRASRLE,.LRASRL) S:LRALSS["^" LRALIT=1
 I LRASRLE#LRALL'=0,+LRALSS<=0 D
 . W ! S LRALSS=$$MULS(LRALMAX,LRASRLE,.LRASRL) S:LRALSS["^" LRALIT=1
 G MULQ
 Q X
MULW ; Write Multiple
 N LRALEX,LRALI1,LRALSO,LRALNC,LRALT2,LRALTX S LRALSO=$P(LRASRL(+LRASRLE,0),"^",1)
 S LRALNC=$P(LRASRL(+LRASRLE,0),"^",3) S:+LRALNC>0 LRALNC=" ("_LRALNC_")"
 S LRALEX=$G(LRASRL(+LRASRLE,"MENU")),LRALTX(1)=LRALSO
 S LRALTX(1)=LRALTX(1)_$S($D(LRASRL(+LRASRLE,"CAT")):"-",1:" ")_$J(" ",(9-$L(LRALSO)))_" "_LRALEX_LRALNC
 D PR(.LRALTX,60) W !,$J(LRASRLE,5),".  ",$G(LRALTX(1))
 F LRALI1=2:1:5 S LRALT2=$G(LRALTX(LRALI1)) W:$L(LRALT2) !,$J(" ",19),LRALT2
 Q
MULS(X,Y,LRASRL) ; Select from Multiple Entries
 N DIR,DIRB,LRALFI,LRALHLP,LRALLST,LRALMAX,LRALS1 ;@#$ not sure LRALS1 is  needed here
 Q:+($G(LRALIT))>0 "^^"  S LRALMAX=+($G(X)),LRALLST=+($G(Y))
 Q:LRALMAX=0 -1 S LRALFI=$O(LRASRL(0)) Q:+LRALFI'>0 -1
 I +($O(LRASRL(+LRALLST)))>0 D
 . S DIR("A")=" Press <RETURN> for more, ""^"" to exit, or Select 1-"
 . S DIR("A")=DIR("A")_LRALMAX_": "
 I +($O(LRASRL(+LRALLST)))'>0 D
 . S DIR("A")=" Select 1-"_LRALMAX_": "
 S LRALHLP=" Answer must be from 1 to "
 S LRALHLP=LRALHLP_LRALMAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??"""
 S (DIR("?"),DIR("??"))="^D MULSH^LRAPICD2"
 S DIR(0)="NAO^1:"_LRALMAX_":0" D ^DIR
 S:X="^" LRAGOUP=1
 Q:'$D(DTOUT)&('$D(DUOUT))&('$D(DIROUT))&(+($G(Y))'>0) -1
 S:X["^^"!($D(DTOUT)) LRALIT=1,X="^^" I X["^^"!(+($G(LRALIT))>0) Q "^^"
 K DIR Q:$D(DTOUT)!(X[U) "^^"
 Q $S(+Y>0:+Y,1:"-1")
MULSH ; Select from Multiple Entries Help
 I $L($G(LRALHLP)) W !,$G(LRALHLP) Q
 Q
MULQ ; Quit Multiple
 I +LRALSS'>0,$G(LRALSS)="^" Q "^"
 S X=-1 S:+($G(LRALIT))'>0 X=$$X(+LRALSS,.LRASRL)
 Q X
X(X,LRASRL) ; Set X and Output Array
 N LRALEX,LRASRFI,ZZLIEN,LRALN1,LRALNC,LRALNN,LRALRN,LRALS1,LRALSO
 S LRALS1=+($G(X))
 S LRASRFI=$O(LRASRL(0)) ;@#$ not used?
 S LRALSO=$P($G(LRASRL(LRALS1,0)),"^",1),LRALEX=$G(LRASRL(LRALS1,"MENU"))
 S ZZLIEN=$S($D(LRASRL(LRALS1,"CAT")):"99:CAT;"_$P($G(LRASRL(LRALS1,0)),"^"),1:$P($G(LRASRL(LRALS1,"IDS",1)),"^")_";"_$P($G(LRASRL(LRALS1,0)),"^")_";"_$P($G(LRASRL(LRALS1,"LEX",1)),"^")) Q:'$L(LRALSO) "^"
 Q:'$L(LRALEX) "^"  Q:+ZZLIEN'>0 "^" S X=ZZLIEN_"^"_LRALEX
 S LRALNN="LRASRL("_+LRALS1_")",LRALNC="LRASRL("_+LRALS1_","
 F  S LRALNN=$Q(@LRALNN) Q:'$L(LRALNN)!(LRALNN'[LRALNC)  D
 . S LRALRN="LRALN1("_$P(LRALNN,"(",2,299) S @LRALRN=@LRALNN
 K LRASRL S LRALNN="LRALN1("_+LRALS1_")",LRALNC="LRALN1("_+LRALS1_","
 F  S LRALNN=$Q(@LRALNN) Q:'$L(LRALNN)!(LRALNN'[LRALNC)  D
 . S LRALRN="LRASRL("_$P(LRALNN,"(",2,299),@LRALRN=@LRALNN
 Q X
 ; 
 ; Miscellaneous
CL ; Clear
 K LRALIT
 Q
PR(LRASRL,X) ; Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,%,%D,LRALC,LRALI1,LRALL
 K ^UTILITY($J,"W")
 Q:'$D(LRASRL)
 S LRALL=+($G(X))
 S:+LRALL'>0 LRALL=79
 S LRALC=+($G(LRASRL))
 S:+($G(LRALC))'>0 LRALC=$O(LRASRL(" "),-1)
 Q:+LRALC'>0
 S DIWL=1,DIWF="C"_+LRALL
 S LRALI1=0
 F  S LRALI1=$O(LRASRL(LRALI1)) Q:+LRALI1=0  S X=$G(LRASRL(LRALI1)) D ^DIWP
 K LRASRL
 S (LRALC,LRALI1)=0
 F  S LRALI1=$O(^UTILITY($J,"W",1,LRALI1)) Q:+LRALI1=0  D
 . S LRASRL(LRALI1)=$$TM($G(^UTILITY($J,"W",1,LRALI1,0))," "),LRALC=LRALC+1
 S:$L(LRALC) LRASRL=LRALC
 K ^UTILITY($J,"W")
 Q
TM(X,Y) ; Trim Character Y - Default " "
 S X=$G(X) Q:X="" X S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
