GMPLRPTR ; SLC/MKB/AJB -- Problem List Report of Removed Problems ;4/10/03
 ;;2.0;Problem List;**28**;Aug 25, 1994
EN ; -- main entry point
 S GMPDFN=$$PAT^GMPLX1 Q:+GMPDFN'>0
 D WAIT^DICD,GETLIST
 I GMPLIST(0)'>0 W $C(7),!!?10,"No 'removed' problems found for this patient.",! Q
 D DISPLAY,REPLACE
 K GMPDFN,GMPLIST
 Q
 ;
GETLIST ; -- build GMPLIST() of removed problems
 N IFN,CNT,NODE S CNT=0
 F IFN=0:0 S IFN=$O(^AUPNPROB("AC",+GMPDFN,IFN)) Q:IFN'>0  D
 . S NODE=$G(^AUPNPROB(IFN,1)) Q:$P(NODE,U,2)'="H"
 . S CNT=CNT+1,GMPLIST(CNT)=IFN W "."
 S GMPLIST(0)=CNT
 Q
 ;
DISPLAY ; -- show list on screen
 N PROBLEM,DATE,USER,NUM,PROV,IDT,AIFN,NODE,DONE,GMPQUIT D HDR
 F NUM=0:0 S NUM=$O(GMPLIST(NUM)) Q:NUM'>0  D  Q:$D(GMPQUIT)
 . S IFN=GMPLIST(NUM) Q:'IFN
 . S PROBLEM=$$PROBTEXT^GMPLX(IFN),(DATE,PROV)="" K DONE
 . ; added for Code Set Versioning (CSV)
 . I '$$CODESTS^GMPLX(IFN,DT) S PROBLEM="#"_PROBLEM
 . F IDT=0:0 S IDT=$O(^GMPL(125.8,"AD",IFN,IDT)) Q:IDT'>0  D  Q:$D(DONE)
 . . F AIFN=0:0 S AIFN=$O(^GMPL(125.8,"AD",IFN,IDT,AIFN)) Q:AIFN'>0  D  Q:$D(DONE)
 . . . S NODE=$G(^GMPL(125.8,AIFN,0)) Q:$P(NODE,U,2)'=1.02
 . . . I $P(NODE,U,6)="H" S DATE=9999999-IDT,PROV=$P(NODE,U,8),DONE=1
 . I $Y>(IOSL-4) S:'$$CONTINUE GMPQUIT=1 Q:$D(GMPQUIT)  D HDR
 . ; added for Code Set Versioning
 . N GMPLBUF S GMPLBUF=$S(PROBLEM["#":3,1:4)
 . W !,NUM,?GMPLBUF,PROBLEM,?51,$$EXTDT^GMPLX(DATE),?60,$$NAME^GMPLX1(PROV)
 Q
 ;
HDR ; -- header code
 W @IOF,"REMOVED PROBLEMS FOR "_$P(GMPDFN,U,2)_" ("_$P(GMPDFN,U,3)_"):"
 W !!,"    Problem",?51,"Removed  By Whom",!,$$REPEAT^XLFSTR("-",79)
 Q
 ;
CONTINUE() ; -- end of page prompt
 N DIR,X,Y
 S DIR(0)="E",DIR("A")="Press <return> to continue or ^ to exit ..."
 D ^DIR
 Q +Y
 ;
REPLACE ; -- replace problem on patient's list
 N GMPLSEL,GMPLNO,NUM,CHNGE,NOW,DA,DR,DIE W !!
 S GMPLSEL=$$SEL Q:GMPLSEL="^"  Q:'$$SURE
 W !!,"Replacing problem(s) on patient's list ..."
 S GMPLNO=$L(GMPLSEL,","),NOW=$$HTFM^XLFDT($H)
 F I=1:1:GMPLNO S NUM=$P(GMPLSEL,",",I) I NUM D
 . ; added for Code Set Versioning (CSV)
 . I '$$CODESTS^GMPLX(GMPLIST(NUM),DT) W !!,$$PROBTEXT^GMPLX(GMPLIST(NUM)),!,"has an inactive ICD9 code and will not be replaced." Q
 . S DA=GMPLIST(NUM),DR="1.02////P",DIE="^AUPNPROB(" D ^DIE
 . S CHNGE=DA_"^1.02^"_NOW_U_DUZ_"^H^P^Replaced^"_DUZ
 . D AUDIT^GMPLX(CHNGE,""),DTMOD^GMPLX(DA)
 . W !,"  "_$$PROBTEXT^GMPLX(DA)
 D
 . N DIR S DIR(0)="E" W ! D ^DIR
 Q
 ;
SEL() ; -- select problem(s)
 N DIR,X,Y,MAX
 S MAX=+GMPLIST(0) I MAX'>0 Q "^"
 S DIR(0)="LAO^1:"_MAX,DIR("A")="Select the problem(s) you wish to replace on this patient's list: "
 S DIR("?",1)="Enter the problems you wish to add back on this patient's problem list,",DIR("?")="as a range or list of numbers."
 D ^DIR I $D(DTOUT)!(X="") S Y="^"
 Q Y
 ;
SURE() ; -- are you sure you want to do this?
 N DIR,X,Y
 S DIR(0)="Y",DIR("A")="Are you sure you want to do this",DIR("B")="NO"
 S DIR("?",1)="Enter YES if you are ready to have the selected problems put back on this",DIR("?")="patient's problem list; press <return> to exit without further action."
 W $C(7) D ^DIR
 Q +Y
