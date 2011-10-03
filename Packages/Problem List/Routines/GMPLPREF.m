GMPLPREF ; SLC/MKB -- Problem List User Preferences ;2/1/96  12:31
 ;;2.0;Problem List;**3,5**;Aug 25, 1994
EN ; -- main entry point for GMPL USER PREFS
 D CURRENT^GMPLPRF0(DUZ) Q:'$$CHANGE^GMPLPRF0
 D EN^VALM("GMPL USER PREFS")
 Q
 ;
INIT ; -- init variables and list array
 S GMPLVIEW=$P($G(^VA(200,DUZ,125)),U),GMPLMODE=$E(GMPLVIEW) ; 'S' or 'C'
 S GMPLMODE=$$VIEW^GMPLPRF0(GMPLMODE)
 I GMPLMODE="^" K GMPLVIEW,GMPLMODE S VALMQUIT=1 Q
 I $$ALL^GMPLPRF0(GMPLMODE,$L(GMPLVIEW,"/")) D SAVE^GMPLPRF1 W !!,"Preferred View saved.",! H 1 S VALMQUIT=1 Q
 D GETSLIST:GMPLMODE="S",GETCLIST:GMPLMODE'="S"
 Q
 ;
GETSLIST ; -- init SERVICE list array
 N LCNT,IFN,NAME,PARENT K ^TMP("GMPLIST",$J) S LCNT=0,^TMP("GMPLIST",$J,"VIEW",0)=0
 W !!,"Retrieving the list of clinical services ..."
 F IFN=0:0 S IFN=$O(^DIC(49,"F","C",IFN)) Q:IFN'>0  D
 . Q:$D(^TMP("GMPLIST",$J,"B",IFN))  ; service already on list
 . S PARENT=+$P($G(^DIC(49,IFN,0)),U,4) I PARENT,PARENT'=IFN,$D(^DIC(49,"F","C",PARENT)) Q  ; child of clin service
 . S NAME=$P($G(^DIC(49,IFN,0)),U)
 . D ITEM(IFN,NAME,GMPLVIEW,.LCNT)
 . Q:'$D(^DIC(49,"ACHLD",IFN))  ; service has no 'children'
 . F CHILD=0:0 S CHILD=$O(^DIC(49,"ACHLD",IFN,CHILD)) Q:CHILD'>0  I CHILD'=IFN D
 . . S NAME="  "_$P($G(^DIC(49,CHILD,0)),U)
 . . D ITEM(CHILD,NAME,GMPLVIEW,.LCNT)
 I LCNT'>0 S ^TMP("GMPLIST",$J,1,0)="   ",^TMP("GMPLIST",$J,2,0)="    No clinical services available to select from."
 D:$P(VALMDDF("SERVICE"),U,4)'="Service" CHGCAP^VALM("SERVICE","Service")
 S VALMCNT=LCNT,^TMP("GMPLIST",$J,0)=VALMCNT,VALMSG=$$MSG
 Q
 ;
GETCLIST ; -- init CLINIC list array
 N LCNT,IFN,NAME K ^TMP("GMPLIST",$J) S LCNT=0,^TMP("GMPLIST",$J,"VIEW",0)=0
 W !!,"Retrieving the list of clinics ..."
 F IFN=0:0 S IFN=$O(^SC(IFN)) Q:IFN'>0  D
 . S NODE=$G(^SC(IFN,0)) Q:$P(NODE,U,3)'="C"  ; loc not a clinic
 . S NAME=$P(NODE,U) D ITEM(IFN,NAME,GMPLVIEW,.LCNT)
 I LCNT'>0 S ^TMP("GMPLIST",$J,1,0)="   ",^TMP("GMPLIST",$J,2,0)="    No clinics available to select from."
 D:$P(VALMDDF("SERVICE"),U,4)'="Clinic" CHGCAP^VALM("SERVICE","Clinic")
 S VALMCNT=LCNT,^TMP("GMPLIST",$J,0)=VALMCNT,VALMSG=$$MSG
 Q
 ;
ITEM(IFN,NAME,VIEW,CNT) ;Add item to list display
 N LNG,TMP,LINE,INCL S INCL=VIEW[("/"_IFN_"/")
 S LINE="    . . . . . . . . . . . . . . . . . . . . "
 S CNT=CNT+1,LINE=$$SETFLD^VALM1(CNT,LINE,"NUMBER")
 S LNG=4+$L(NAME),TMP=$E(LINE,1,4)_NAME_$E(LINE,LNG+1,$L(LINE)),LINE=TMP
 I INCL S LINE=$$SETFLD^VALM1(" Y",LINE,"ACCEPT"),^TMP("GMPLIST",$J,"VIEW",IFN)="",^TMP("GMPLIST",$J,"VIEW",0)=^TMP("GMPLIST",$J,"VIEW",0)+1
 S ^TMP("GMPLIST",$J,CNT,0)=LINE,^TMP("GMPLIST",$J,"IDX",CNT)=IFN,^TMP("GMPLIST",$J,"B",IFN)=CNT
 D CNTRL^VALM10(CNT,1,2,IOINHI,IOINORM) ; highlight numbers
 Q
 ;
HDR ; -- header code
 N NUM,USER,X S USER=$P($G(^VA(200,DUZ,0)),U)
 S X="CLINIC"_$S(GMPLMODE="S":"AL SERVICE",1:"")_"S"
 S NUM=+$G(^TMP("GMPLIST",$J,"VIEW",0))_" "_$S(GMPLMODE="S":"services",1:"clinics")
 S VALMHDR(1)=USER_$J(NUM,79-$L(USER)),VALMHDR(2)=$J(X,$L(X)\2+41)
 Q
 ;
HELP ; -- help code
 N X,Y S:GMPLMODE="S" X="services",Y="clinics"
 S:GMPLMODE'="S" X="clinics",Y="services"
 W !!?4,"To create or change your preferred view, choose either Add or"
 W !?4,"Remove; those "_X_" you add will be flagged above with a 'Y'."
 W !?4,"Within the Problem List application, ONLY those problems associated"
 W !?4,"with your selected "_X_" will initially be displayed, however"
 W !?4,"the entire list is always available using its Select View option."
 W !?4,"If you wish to create a view according to "_Y_" instead, or not"
 W !?4,"to have a view at all, choose Select New View or Delete respectively."
 W !!,"Press <return> to continue ... " R X:DTIME
 S VALMSG=$$MSG,VALMBCK=$S(VALMCC:"",1:"R")
 Q
 ;
CLEAN ; -- exit code
 I $$DIFFRENT^GMPLPRF1,'$D(GMPSAVED) D
 . N DIR,X,Y S DIR(0)="Y"
 . W !!,$C(7),">>>  YOUR PREFERRED VIEW HAS CHANGED!!"
 . S DIR("A")="Do you want to save these changes",DIR("B")="YES"
 . S DIR("?",1)="Enter YES to have only problems from the "_$S(GMPLMODE="S":"service",1:"clinic")_"s indicated above"
 . S DIR("?",2)="listed, when initially displaying a patient's problem list;"
 . S DIR("?")="enter NO to retain your previous view."
 . D ^DIR D:Y SAVE^GMPLPRF1
 K GMPLVIEW,GMPLIST,GMPLMODE,GMPSAVED
 K ^TMP("GMPLIST",$J)
 K VALMHDR,VALMCNT,VALMSG,VALMBCK
 Q
 ;
MSG() ; -- msg line for more help
 N X S X="+ More "_$S(GMPLMODE="S":"Services",1:"Clinics")_"   ?? More actions"
 Q X
