GMPLMGR2 ; SLC/MKB/KER/AJB -- Problem List VALM Utilities cont ; 04/15/2002
 ;;2.0;Problem List;**26,28**;Aug 25, 1994
 ;
 ; External References
 ;   DBIA 10082  ^ICD9(
 ;   DBIA   872  ^ORD(101
 ;   DBIA 10026  ^DIR
 ;   DBIA 10116  $$SETFLD^VALM1
 ;   DBIA 10116  CLEAR^VALM1
 ;   DBIA 10140  EN^XQORM
 ;                      
BLDPROB(IFN) ; Build Line for Problem in List
 ;   Input INF   Pointer to Problem file 9000011
 ;   Expects GMPCOUNT
 N GMPL0,GMPL1,RESOLVED,TEXT,I,LINE,STR,SC,SP,ICD,ONSET,PROBLEM,STATUS
 Q:'$D(GMPCOUNT)  S GMPL0=$G(^AUPNPROB(IFN,0)),GMPL1=$G(^(1)) Q:'$L(GMPL0)
 S SC=$P(GMPL1,U,10),SP=$P(GMPL1,U,11,13)_"^"_$P(GMPL1,U,15,16),STATUS=$P(GMPL0,U,12)
 S:$P(GMPL1,U,2)="H" PROBLEM="< DELETED >" I $P(GMPL1,U,2)'="H" D
 . S PROBLEM=$$PROBTEXT^GMPLX(IFN),ONSET=$P(GMPL0,U,13)
 . I ONSET S PROBLEM=PROBLEM_", Onset "_$$EXTDT^GMPLX(ONSET)
 S RESOLVED=$J($$EXTDT^GMPLX($P(GMPL1,U,7)),8)
 S ICD=$P($G(^ICD9(+GMPL0,0)),U),GMPCOUNT=GMPCOUNT+1
 D WRAP^GMPLX(PROBLEM,40,.TEXT)
 S LINE=$$SETFLD^VALM1(GMPCOUNT,"","NUMBER")
 ; added for Code Set Versioning (CSV) - checks ICD code - # if inactive
 I '$$CODESTS^GMPLX(IFN,DT) D
 . I STATUS="A" S LINE=$$SETFLD^VALM1(" #",LINE,"STATUS")
 . I STATUS="I" S LINE=$$SETFLD^VALM1(STATUS_"#",LINE,"STATUS")
 E  S:STATUS="I" LINE=$$SETFLD^VALM1(STATUS,LINE,"STATUS")
 ; S:STATUS="I" LINE=$$SETFLD^VALM1(STATUS,LINE,"STATUS")
 S LINE=$$SETFLD^VALM1(TEXT(1),LINE,"PROBLEM")
 S LINE=$$SETFLD^VALM1(ICD,LINE,"ICD")
 I $L(SC) D
 . S STR=$S(+SC:"YES",SC=0:"NO",1:"   ")
 . S LINE=$$SETFLD^VALM1(STR,LINE,"SERV CONNECTED")
 I $L(SP) D
 . S STR=$S(+$P(SP,U):"Agent Orange",+$P(SP,U,2):"Radiation",+$P(SP,U,3):"Contaminants",+$P(SP,U,4):"Head/Neck Cancer",+$P(SP,U,5):"Mil Sexual Trauma",1:"")
 . S LINE=$$SETFLD^VALM1(STR,LINE,"EXPOSURE")
 S LINE=$$SETFLD^VALM1(RESOLVED,LINE,"RESOLVED")
 S VALMCNT=VALMCNT+1,^TMP("GMPL",$J,VALMCNT,0)=LINE
 S ^TMP("GMPLIDX",$J,GMPCOUNT)=VALMCNT_U_IFN
 I TEXT>1 F I=2:1:TEXT D
 . S LINE="",LINE=$$SETFLD^VALM1(TEXT(I),LINE,"PROBLEM")
 . S VALMCNT=VALMCNT+1,^TMP("GMPL",$J,VALMCNT,0)=LINE
 Q
 ;
HELP ; Help Code
 N X W !!?4,"You may take a variety of actions from this prompt.  To update"
 W !?4,"the problem list select from Add, Remove, Edit, Inactivate,"
 W !?4,"and Enter Comment; you will then be prompted for the problem"
 W !?4,"number.  To see all of this patient's problems, both active and"
 W !?4,"inactive, select Show All Problems; select Print to print the"
 W !?4,"same complete list in a chartable format.  To see a listing of"
 W !?4,"actions that facilitate navigating the list, enter '??'."
 W !!,"Press <return> to continue ... " R X:DTIME
 S VALMSG=$$MSG^GMPLX,VALMBCK=$S(VALMCC:"",1:"R")
 Q
 ;
EXIT ; Exit Code
 I GMPARAM("PRT"),$D(GMPRINT) D AUTO
 K ^TMP("GMPL",$J),^TMP("GMPLIDX",$J)
 K XQORM("KEY","="),XQORM("XLATE")
 K GMPDFN,GMPROV,GMPLVIEW,GMPARAM,VALMBCK,VALMHDR,VALMCNT,GMPCOUNT,GMPLUSER,GMPSC,VALMSG,GMPVAMC,GMPLIST,GMPAGTOR,GMPION,GMPGULF,GMPVA,GMPTOTAL,GMPRINT,AUPNSEX,GMPCLIN
 Q
 ;
AUTO ; Print Problem List when Exiting Patient?
 ;   Called from EXIT,NEWPAT^GMPLMGR1
 N DIR,X,Y Q:'GMPARAM("PRT")  Q:'$D(GMPRINT)
 S DIR(0)="YA",DIR("A")="Print a new problem list? ",DIR("B")="YES"
 S DIR("?",1)="Press <return> to generate a new complete problem list for this patient;",DIR("?")="enter NO to continue without printing."
 W $C(7),!!,">>>  THIS PATIENT'S PROBLEM LIST HAS CHANGED!"
 D ^DIR I $D(DTOUT)!($D(DTOUT)) S GMPQUIT=1 Q
 Q:'Y  D VAF^GMPLPRNT,DEVICE^GMPLPRNT G:$D(GMPQUIT) AUTQ
 D CLEAR^VALM1,PRT^GMPLPRNT
AUTQ ; Quit Auto-Print
 D KILL^GMPLX
 Q
 ;
SHOW ; Show Current View of List
 N VIEW,NUM,NAME S VIEW=$E(GMPLVIEW("VIEW")),NUM=$L(GMPLVIEW("VIEW"),"/")
 W !!,"CURRENT VIEW: "_$S(VIEW="S":"Inpatient, ",1:"Outpatient, ")
 I '((NUM>2)!($L(GMPLVIEW("ACT")))!(GMPLVIEW("PROV"))) W "all problems" Q
 W $S(GMPLVIEW("ACT")="A":"active",GMPLVIEW("ACT")="I":"inactive",1:"all")_" problems"
 I NUM>2 W " from "_$S(GMPLVIEW("VIEW")=$$VIEW^GMPLX1(DUZ):"preferred",1:"selected")_$S(VIEW="S":" services",1:" clinics")
 I GMPLVIEW("PROV") S NAME=$$NAME^GMPLX1(GMPLVIEW("PROV")) W:($X+$L(NAME)+4>80) ! W " by "_NAME
 Q
 ;
ENVIEW ; Entry Action to Display Appropriate View Menu
 N XQORM,X,Y,GMPLX S GMPLX=0 D SHOW S X="GMPL VIEW "_$S($E(GMPLVIEW("VIEW"))="S":"INPAT",1:"OUTPAT")
 S XQORM=+$O(^ORD(101,"B",X,0))_";ORD(101,",XQORM(0)="3AD"
 W !,"You may change your view of this patient's problem list by selecting one or",!,"more of the following attributes to alter:",!
 D EN^XQORM F  S GMPLX=$O(Y(GMPLX)) Q:GMPLX'>0  X:$D(^ORD(101,+$P(Y(GMPLX),U,2),20)) ^(20)
 Q
 ;
EXVIEW ; Exit Action to Rebuild List w/New View
 S VALMBCK=$S(VALMCC:"",1:"R") I '$D(GMPQUIT),$G(GMPREBLD) D
 . S VALMBG=1,VALMBCK="R" D GETPLIST^GMPLMGR1(.GMPLIST,.GMPTOTAL,.GMPLVIEW)
 . D BUILD^GMPLMGR(.GMPLIST),HDR^GMPLMGR
 K GMPQUIT,GMPREBLD S VALMSG=$$MSG^GMPLX
 Q
