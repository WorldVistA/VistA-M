GMPLEDT4 ; SLC/MKB/TC -- Problem List Edit actions cont ;10/30/14  07:04
 ;;2.0;Problem List;**5,43,42,47**;Aug 25, 1994;Build 58
TERM ; edit field 1.01
 N DTOUT,PROB,TERM,ICD,DUP,Y,GMPLCSYS,GMPL0,GMPL802,GMPIMPDT
 S GMPIMPDT=$$IMPDATE^LEXU("10D")
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
 I +Y'>0 S GMPQUIT=1 Q
 S DUP=$$DUPL^GMPLX(+GMPDFN,+Y,PROB)
 I DUP,'$$DUPLOK^GMPLX(DUP) S (Y,GMPROB)="" W ! G T1
 S TERM=$S(+$G(Y)>1:Y,1:""),ICD=$G(Y(1))
 S:'$L(ICD) ICD=$S(DT<GMPIMPDT:"799.9",1:"R69.")
 N I,GMPSTAT,GMPCSREC,GMPCSPTR,GMPCSNME,GMPSCTC,GMPSCTD,GMPTXT
 I ICD["/" F I=1:1:$L(ICD,"/") D  Q:GMPSTAT
 . N GMPCODE S GMPCODE=$P(ICD,"/",I),GMPSTAT=0
 . S GMPCSREC=$$CODECS^ICDEX(GMPCODE,80,DT),GMPCSPTR=$P(GMPCSREC,U),GMPCSNME=$P(GMPCSREC,U,2)
 . S:'+$$STATCHK^ICDXCODE(GMPCSPTR,GMPCODE,DT) GMPSTAT=1
 E  D
 . S GMPSTAT=0,GMPCSREC=$$CODECS^ICDEX(ICD,80,DT),GMPCSPTR=$P(GMPCSREC,U),GMPCSNME=$P(GMPCSREC,U,2)
 . S:'+$$STATCHK^ICDXCODE(GMPCSPTR,ICD,DT) GMPSTAT=1
 I GMPSTAT W !,PROB,!,"has an inactive ICD code.  Please enter another search term." H 3 Q
 I (PROB["(SCT"),(PROB[")") D
 . S GMPSCTC=$$ONE^LEXU(+TERM,DT,"SCT")
 . S GMPTXT=$$TRIM^XLFSTR($RE($P($RE(PROB),"(",2,99)))
 . S GMPSCTD=$$GETDES^LEXTRAN1("SCT",GMPTXT),GMPSCTD=$S(+GMPSCTD=1:$P(GMPSCTD,U,2),1:"")
 S GMPLCSYS=$$SAB^ICDEX(GMPCSPTR,DT)
 S GMPFLD(1.01)=TERM,GMPFLD(.05)=U_PROB
 S GMPFLD(.01)=$S($L(ICD):$P($$ICDDATA^ICDXCODE(GMPCSPTR,$P(ICD,"/"),DT,"E"),U)_U_$G(ICD),1:"")
 S:'GMPFLD(.01)!($P(GMPFLD(.01),U)<0) GMPFLD(.01)=$$NOS^GMPLX(GMPLCSYS,DT)
 S (GMPFLD(.03),GMPFLD(80201),GMPFLD(1.09))=DT_U_$$EXTDT^GMPLX(DT)
 S GMPFLD(80202)=GMPLCSYS_U_$G(GMPCSNME)
 S GMPFLD(80001)=GMPSCTC_U_GMPSCTC,GMPFLD(80002)=GMPSCTD_U_GMPSCTD
 Q
 ;
TEXT(DFLT) ; Enter/edit provider narrative text (no lookup)
 N DIR,X,Y,DTOUT
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
 N DIR,DTOUT S DIR(0)="FAO^1:100",DIR("A")=PROMPT
 S:$L(DEFAULT) DIR("B")=DEFAULT
 S DIR("?",1)="Enter any text you wish appended to this problem, up to 60 characters"
 S DIR("?")="in length.  You may append as many comments to a problem as you wish."
ED1 D ^DIR I $D(DTOUT)!(Y="^") S GMPQUIT=1,Y="" Q
 I Y?1"^".E D JUMP^GMPLEDT3(Y) Q:$D(GMPQUIT)!($G(GMPLJUMP))  K:$G(GMPIFN) GMPLJUMP G ED1
 Q:Y=DEFAULT  I X="@" D  Q:$D(GMPQUIT)!(Y="")  G ED1
 . N DIR,X,DTOUT,DUOUT S DIR(0)="YAO",DIR("B")="NO"
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
 N DIR,X,Y,DTOUT
 S DIR(0)="SAO^A:ACUTE;C:CHRONIC;",DIR("A")="  (A)cute or (C)hronic? "
 S:$L($G(GMPFLD(1.14))) DIR("B")=$P(GMPFLD(1.14),U,2)
 S DIR("?",1)="  You may further refine the status of this problem by designating it",DIR("?",2)="  as ACUTE or CHRONIC; problems marked as ACUTE will be flagged on the",DIR("?")="  list display with a '*'."
PR1 D ^DIR I $D(DTOUT)!(Y="^") S GMPQUIT=1 Q
 I Y?1"^".E D JUMP^GMPLEDT3(Y) Q:$D(GMPQUIT)!($G(GMPLJUMP))  K:$G(GMPIFN) GMPLJUMP G PR1
 S:Y'="" Y=Y_U_$S(Y="A":"ACUTE",1:"CHRONIC")
 S GMPFLD(1.14)=Y
 Q
