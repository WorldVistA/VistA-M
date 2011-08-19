GMPLEDT4 ; SLC/MKB -- Problem List Edit actions cont ;3-7-96 2:00pm
 ;;2.0;Problem List;**5**;Aug 25, 1994
TERM ; edit field 1.01
 N PROB,TERM,ICD,DUP,Y
T1 W !,"PROBLEM: "_$P(GMPFLD(.05),U,2)_"//"
 R PROB:DTIME S:'$T DTOUT=1 I $D(DTOUT)!(PROB="^") S GMPQUIT=1 Q
 I PROB?1"^".E D JUMP^GMPLEDT3(PROB) Q:$D(GMPQUIT)!($G(GMPLJUMP))  K:$G(GMPIFN) GMPLJUMP G T1
 Q:PROB=""  Q:PROB=$P(GMPFLD(.05),U,2)  ; no change
 I PROB["?" D  G T1
 . W !!?4,"Enter a description of this problem, up to 80 characters.",!
 I PROB="@",'+$G(GMPIFN) D  S GMPQUIT=1 Q
 .W !!?5,$C(7),$C(7),"This problem has not yet been saved."
 .W !?5,"Enter <Q>uit and it will not be added to the list.",!!
 .K DIR S DIR("A")="Press RETURN to redisplay the problem text"
 .S DIR(0)="E" D ^DIR K DIR
 I PROB="@" D DELETE^GMPLEDT2 S:VALMBCK="Q" GMPQUIT=1 Q:$D(GMPQUIT)  G T1
T2 ; new text -- pass to look-up
 I '$D(GMPLUSER)!($D(GMPLUSER)&('GMPARAM("CLU"))) S GMPFLD(1.01)="",GMPFLD(.05)=U_PROB Q
 D SEARCH^GMPLX(.PROB,.Y,"PROBLEM: ","1") ; pass to CLU
 S TERM=$G(Y),ICD=$G(Y(1)) I +TERM'>0 S GMPQUIT=1 Q
 S DUP=$$DUPL^GMPLX(+GMPDFN,+TERM,PROB)
 I DUP,'$$DUPLOK^GMPLX(DUP) W ! G T1
 S GMPFLD(1.01)=$S(+TERM>1:TERM,1:""),GMPFLD(.05)=U_PROB
 S GMPFLD(.01)=$S($L(ICD):$O(^ICD9("AB",ICD_" ",0))_U_ICD,1:"")
 S:'GMPFLD(.01) GMPFLD(.01)=$$NOS^GMPLX
 Q
 ;
TEXT(DFLT) ; Enter/edit provider narrative text (no lookup)
 N DIR,X,Y
 S DIR(0)="FAO^2:80",DIR("A")="PROBLEM: " S:$L(DFLT) DIR("B")=DFLT
 S DIR("?")="Enter a description of this problem, up to 80 characters."
 D ^DIR S:$D(DTOUT)!(X="^") Y="^" S:'$L(DFLT)&(X="") Y="^"
 Q Y
 ;
NTES ; Edit existing note, display # in XQORNOD(0)
 N NUM,NOTE,X,Y,PROMPT,DEFAULT,NT
 S NT=$S(GMPVA:7,1:5) S:$D(^XUSEC("GMPL ICD CODE",DUZ)) NT=NT+1
 S NUM=+$P(XQORNOD(0),U,3)-NT Q:NUM'>0
 S NOTE=GMPFLD(10,NUM),DEFAULT=$P(NOTE,U,3)
 S PROMPT="NOTE "_$$EXTDT^GMPLX($P(NOTE,U,5))_": "
 D EDNOTE Q:$D(GMPQUIT)
 S $P(GMPFLD(10,NUM),U,3)=Y
 Q
 ;
EDNOTE ; Edit note text given PROMPT,DEFAULT (returns X,Y)
 N DIR S DIR(0)="FAO^1:100",DIR("A")=PROMPT
 S:$L(DEFAULT) DIR("B")=DEFAULT
 S DIR("?",1)="Enter any text you wish appended to this problem, up to 60 characters"
 S DIR("?")="in length.  You may append as many comments to a problem as you wish."
ED1 D ^DIR I $D(DTOUT)!(Y="^") S GMPQUIT=1,Y="" Q
 I Y?1"^".E D JUMP^GMPLEDT3(Y) Q:$D(GMPQUIT)!($G(GMPLJUMP))  K:$G(GMPIFN) GMPLJUMP G ED1
 Q:Y=DEFAULT  I X="@" D  Q:$D(GMPQUIT)!(Y="")  G ED1
 . N DIR,X S DIR(0)="YAO",DIR("B")="NO"
 . S DIR("A")="   Are you sure you want to delete this comment? "
 . S DIR("?")="   Enter YES to completely remove this comment from this patient's problem."
 . W $C(7) D ^DIR I $D(DUOUT)!($D(DTOUT)) S GMPQUIT=1,Y="" Q
 . S:Y Y=""
 I $L(X)>60 W !!,"Text may not exceed 60 characters!",!,$C(7) S DIR("B")=$E(X,1,60) G ED1
 S Y=X
 Q
 ;
RESOLVED ; edit field 1.07
 N X,Y,PROMPT,HELPMSG,DEFAULT,ONSET S ONSET=+$G(GMPFLD(.13))
 S DEFAULT=$G(GMPFLD(1.07)),PROMPT="DATE RESOLVED: "
 S HELPMSG="Enter the date this problem became resolved or inactive, as precisely as known."
R1 D DATE^GMPLEDT2 Q:$D(GMPQUIT)!($G(GMPLJUMP))
 I Y,ONSET,Y<ONSET W !!,"Date Resolved cannot be prior to the Date of Onset!",$C(7) G R1
 S GMPFLD(1.07)=Y S:Y'="" GMPFLD(1.07)=GMPFLD(1.07)_U_$$EXTDT^GMPLX(Y)
 Q
 ;
PRIORITY ; edit field 1.14
 N DIR,X,Y
 S DIR(0)="SAO^A:ACUTE;C:CHRONIC;",DIR("A")="  (A)cute or (C)hronic? "
 S:$L($G(GMPFLD(1.14))) DIR("B")=$P(GMPFLD(1.14),U,2)
 S DIR("?",1)="  You may further refine the status of this problem by designating it",DIR("?",2)="  as ACUTE or CHRONIC; problems marked as ACUTE will be flagged on the",DIR("?")="  list display with a '*'."
PR1 D ^DIR I $D(DTOUT)!(Y="^") S GMPQUIT=1 Q
 I Y?1"^".E D JUMP^GMPLEDT3(Y) Q:$D(GMPQUIT)!($G(GMPLJUMP))  K:$G(GMPIFN) GMPLJUMP G PR1
 S:Y'="" Y=Y_U_$S(Y="A":"ACUTE",1:"CHRONIC")
 S GMPFLD(1.14)=Y
 Q
