GMPLCODE ; SLC/MKB/AJB -- Problem List ICD Code Utilities ;5/27/94  08:23
 ;;2.0;Problem List;**28**;Aug 25, 1994
EN ; -- main entry point for GMPL CODE LIST
 K GMPLUSER
 D EN^VALM("GMPL CODE LIST")
 Q
 ;
INIT ; -- init variables and list array
 S GMPDFN=$$PAT^GMPLX1 I +GMPDFN'>0 K GMPDFN S VALMQUIT=1 Q
 S GMPVA=$S($G(DUZ("AG"))="V":1,1:0),GMPVAMC=+$G(DUZ(2))
 S (GMPSC,GMPAGTOR,GMPION,GMPGULF)=0 D:GMPVA VADPT^GMPLX1(+GMPDFN)
 S (GMPLVIEW("ACT"),GMPLVIEW("VIEW"))="",GMPLVIEW("PROV")=0
 S X=$G(^GMPL(125.99,1,0)),GMPARAM("VER")=+$P(X,U,2),GMPARAM("PRT")=+$P(X,U,3),GMPARAM("CLU")=+$P(X,U,4),GMPARAM("REV")=$S($P(X,U,5)="R":1,1:0) K X
 D GETPLIST^GMPLMGR1(.GMPLIST,.GMPTOTAL,.GMPLVIEW)
 D BUILD^GMPLMGR(.GMPLIST)
 S VALMSG=$$MSG^GMPLX
 Q
 ;
HELP ; -- help code
 N X
 W !!?4,"You may take a variety of actions from this prompt.  To update"
 W !?4,"the ICD Code assigned to a problem, you may choose to search"
 W !?4,"either the ICD Diagnosis file or the Clinical Lexicon for a"
 W !?4,"match; the code of the entry you select will be assigned to the"
 W !?4,"current problem in the list.  If you need more information on a"
 W !?4,"problem, select Detailed Display.  To see a listing of"
 W !?4,"actions that facilitate navigating the list, enter '??'."
 W !!,"Press <return> to continue ... " R X:DTIME
 S VALMSG=$$MSG^GMPLX,VALMBCK=$S(VALMCC:"",1:"R")
 Q
 ;
EDIT ; -- edit field .01
 N GMPLSEL,GMPLNO,GMPI,GMPIFN,GMPLNUM,GMPSAVED
 S VALMBCK=$S(VALMCC:"",1:"R")
 S GMPLSEL=$$SEL^GMPLX("code") G:GMPLSEL="^" EDQ
 S GMPLNO=$L(GMPLSEL,",")
 F GMPI=1:1:GMPLNO S GMPLNUM=$P(GMPLSEL,",",GMPI) I GMPLNUM D  Q:$D(GMPQUIT)
 . S GMPIFN=$P($G(^TMP("GMPLIDX",$J,+GMPLNUM)),U,2) Q:GMPIFN'>0
 . L +^AUPNPROB(GMPIFN,0):1 I '$T W $C(7),!!,$$LOCKED^GMPLX,! H 2 Q
 . D ICD(GMPLNUM,GMPIFN) L -^AUPNPROB(GMPIFN,0)
 S:$D(GMPSAVED) VALMBCK="R"
EDQ D KILL^GMPLX S VALMSG=$$MSG^GMPLX
 Q
 ;
ICD(NUM,IFN) ; -- search ICD Diagnosis file #80
 N X,Y,DIC,DIR,OLD,NEW,DA,DR,DIE,LCNT,CHNGE
 W !,IFN,!
 D FULL^VALM1 S VALMBCK="R" W !!
 S OLD=+$G(^AUPNPROB(IFN,0)),OLD=OLD_U_$P($G(^ICD9(OLD,0)),U)
 S DIR(0)="PAO^ICD9(:QEM",DIR("A")="Enter ICD CODE or DESCRIPTION: "
 S DIR("A",1)="Problem #"_NUM_": "_$$PROBTEXT^GMPLX(IFN)
 S DIR("?")="Enter a new code number or a brief free text description on which to search",DIR("B")=$P(OLD,U,2)
 ; Added for Code Set Versioning (CSV) - screen allows ONLY active codes
 S DIR("S")="I +($$STATCHK^ICDAPIU($$CODEC^ICDCODE(+($G(Y))),DT))>0"
 D ^DIR I $D(DTOUT)!($D(DUOUT)) S GMPQUIT=1 Q
 I X="@" Q:'$D(DIR("B"))  S:$$SURE^GMPLX Y=$$NOS^GMPLX
 I +Y>0,Y'=OLD D  S GMPSAVED=1
 . S NEW=Y,DIE="^AUPNPROB(",DA=IFN,DR=".01////"_+NEW D ^DIE
 . S CHNGE=IFN_"^.01^"_$$HTFM^XLFDT($H)_U_DUZ_U_+OLD_U_+NEW
 . D AUDIT^GMPLX(CHNGE,"")
 . S LCNT=+$G(^TMP("GMPLIDX",$J,NUM))
 . D FLDTEXT^VALM10(LCNT,"ICD",$P(NEW,U,2))
 D BUILD^GMPLMGR(.GMPLIST) S VALMBCK="R"
 Q
