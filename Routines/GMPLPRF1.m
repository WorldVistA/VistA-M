GMPLPRF1 ; SLC/MKB -- Problem List User Prefs cont ;;9-5-95 11:54am
 ;;2.0;Problem List;**3**;Aug 25, 1994
ADD ; -- add item(s) to view
 N GMPLSEL,GMPLNO,IFN,NUM,CNUM,I,J S VALMBCK=$S(VALMCC:"",1:"R")
ADD1 S GMPLSEL=$$SELECT Q:GMPLSEL="^"
 S GMPLNO=$L(GMPLSEL,","),I=$S(GMPLMODE="S":"service",1:"clinic")
 I (^TMP("GMPLIST",$J,"VIEW",0)+GMPLNO-1)>60 D  G ADD1
 . W !!,"You may not have more than 60 "_I_"s included in your view!"
 . W !,"Your view currently includes "_^TMP("GMPLIST",$J,"VIEW",0)_" "_I_$S(^TMP("GMPLIST",$J,"VIEW",0)'=1:"s",1:"")_"."
 . W !,"Please select again, choosing no more than "_(60-^TMP("GMPLIST",$J,"VIEW",0))_" "_I_$S(^TMP("GMPLIST",$J,"VIEW",0)'=1:"s",1:"")_"."
ADD2 W !!,"Adding "_(GMPLNO-1)_" "_I_"(s) ..." K I
 F I=1:1:GMPLNO S NUM=$P(GMPLSEL,",",I) I NUM D
 . S IFN=^TMP("GMPLIST",$J,"IDX",NUM) W "."
 . S TMP=$E($P(^TMP("GMPLIST",$J,NUM,0),U,1),1,44)_" Y",^TMP("GMPLIST",$J,NUM,0)=TMP
 . S:'$D(^TMP("GMPLIST",$J,"VIEW",IFN)) ^TMP("GMPLIST",$J,"VIEW",IFN)="",^TMP("GMPLIST",$J,"VIEW",0)=^TMP("GMPLIST",$J,"VIEW",0)+1
 . Q:GMPLMODE'="S"  Q:'$D(^DIC(49,"ACHLD",IFN))
 . I $$INCLCHLD(IFN) F J=0:0 S J=$O(^DIC(49,"ACHLD",IFN,J)) Q:J'>0  D
 . . S CNUM=+$G(^TMP("GMPLIST",$J,"B",J)) W "."
 . . I CNUM S TMP=$E(^TMP("GMPLIST",$J,CNUM,0),1,44)_" Y",^TMP("GMPLIST",$J,CNUM,0)=TMP S:'$D(^TMP("GMPLIST",$J,"VIEW",J)) ^TMP("GMPLIST",$J,"VIEW",J)="",^TMP("GMPLIST",$J,"VIEW",0)=^TMP("GMPLIST",$J,"VIEW",0)+1
 S VALMBCK="R",VALMSG=$$MSG^GMPLPREF K VALMHDR
 Q
 ;
REMOVE ; -- delete item(s) from view
 N GMPLSEL,GMPLNO,IFN,NUM,CNUM,I,J S VALMBCK=$S(VALMCC:"",1:"R")
 S GMPLSEL=$$SELECT Q:GMPLSEL="^"
 S GMPLNO=$L(GMPLSEL,",")
 W !!,"Removing "_(GMPLNO-1)_" "_$S(GMPLMODE="S":"service",1:"clinic")_"(s) ..."
 F I=1:1:GMPLNO S NUM=$P(GMPLSEL,",",I) I NUM D
 . S IFN=+^TMP("GMPLIST",$J,"IDX",NUM),^TMP("GMPLIST",$J,NUM,0)=$E(^TMP("GMPLIST",$J,NUM,0),1,44)
 . S:$D(^TMP("GMPLIST",$J,"VIEW",IFN)) ^TMP("GMPLIST",$J,"VIEW",0)=^TMP("GMPLIST",$J,"VIEW",0)-1
 . K ^TMP("GMPLIST",$J,"VIEW",IFN) W "."
 . Q:GMPLMODE'="S"  Q:'$D(^DIC(49,"ACHLD",IFN))
 . I $$INCLCHLD(IFN) F J=0:0 S J=$O(^DIC(49,"ACHLD",IFN,J)) Q:J'>0  D
 . . S CNUM=+$G(^TMP("GMPLIST",$J,"B",J)) W "."
 . . I CNUM S ^TMP("GMPLIST",$J,CNUM,0)=$E(^TMP("GMPLIST",$J,CNUM,0),1,44) S:$D(^TMP("GMPLIST",$J,"VIEW",J)) ^TMP("GMPLIST",$J,"VIEW",0)=^TMP("GMPLIST",$J,"VIEW",0)-1 K ^TMP("GMPLIST",$J,"VIEW",J)
 S VALMBCK="R",VALMSG=$$MSG^GMPLPREF K VALMHDR
 Q
 ;
INCLCHLD(IFN) ; Returns 1 or 0, to include 'child' services in selection
 N DIR,X,Y,NAME S NAME=$P($G(^DIC(49,IFN,0)),U),DIR("B")="YES"
 S DIR(0)="Y",DIR("A")="Include all sub-services/sections of "_NAME
 S DIR("?",1)="This service is a 'parent' to other services/sections,"
 S DIR("?",2)="listed indented above; enter YES to include all of these"
 S DIR("?")="as well in this action, or enter NO to exclude them."
 D ^DIR S:$D(DTOUT) Y="^"
 Q Y
 ;
SELECT() ; Select item(s) from list
 N DIR,X,Y,MAX
 S MAX=+$G(^TMP("GMPLIST",$J,0)) I MAX'>0 Q "^"
 S DIR(0)="LAO^1:"_MAX
 S DIR("A")="Select "_$S(GMPLMODE="S":"Service",1:"Clinic")
 S:MAX>1 DIR("A")=DIR("A")_" (1-"_MAX_"): "
 S:MAX'>1 DIR("A")=DIR("A")_": ",DIR("B")=1
 S DIR("?")="Enter the display number of the "_$S(GMPLMODE="S":"service",1:"clinic")_"(s) you wish to select"
 D ^DIR I $D(DTOUT)!(X="") S Y="^"
 Q Y
 ;
DIFFRENT() ; -- Returns 1 if view has changed, else 0
 N I,TEMP S TEMP=""
 F I=0:0 S I=$O(^TMP("GMPLIST",$J,"VIEW",I)) Q:I'>0  S TEMP=TEMP_I_"/"
 S:$L(TEMP) TEMP=GMPLMODE_"/"_TEMP
 Q TEMP'=$P($G(^VA(200,DUZ,125)),U)
 ;
SAVE ; -- save new view in File #200/Field #125
 N I,TEMP,TMP S TEMP=GMPLMODE,TMP=$P($G(^VA(200,DUZ,125)),U,2,999)
 F I=0:0 S I=$O(^TMP("GMPLIST",$J,"VIEW",I)) Q:I'>0  S TEMP=TEMP_"/"_I
 S:$L(TEMP)>1 TEMP=TEMP_"/"
 S ^VA(200,DUZ,125)=TEMP_U_TMP,GMPSAVED=1
 Q
 ;
SWITCH ; -- change preferred views (service <--> clinic)
 N DIR,X,Y S Y=1,VALMBCK=$S(VALMCC:"",1:"R")
 G SW1:'$L($G(GMPLVIEW)) ; no current view
 S DIR(0)="Y",DIR("A")="Are you sure this is ok",DIR("B")="NO"
 S DIR("?",1)="You may have only one preferred view at a time."
 S DIR("?",2)="Enter YES to change how your preferred view is defined,"
 S DIR("?")="or press <return> to keep the view you currently have."
 W !!,">>>  This action will clear your current view of problems by "
 W $S(GMPLMODE="S":"service",1:"clinic")
 W !?5,"and present a list of "_$S(GMPLMODE="S":"clinics",1:"services")
 W " to replace it with.",! D ^DIR
SW1 I Y D
 . S VALMBCK="R",GMPLVIEW="",GMPLMODE=$S(GMPLMODE="S":"C",1:"S")
 . D @("GET"_GMPLMODE_"LIST^GMPLPREF") K VALMHDR
 Q
 ;
DELETE ; -- delete preferred view (no view)
 N DIR,X,Y S DIR(0)="Y",DIR("B")="NO",VALMBCK=$S(VALMCC:"",1:"R")
 S DIR("A")="Are you sure you want to delete your preferred view"
 S DIR("?",1)="Enter YES to remove your preferred view; the default view of Outpatient,",DIR("?",2)="including all active problems, will be used to display problem information.",DIR("?")="Enter NO to continue editing your current view."
 D ^DIR I Y D
 . W !!,"Deleting preferred view of "_$S(GMPLMODE="S":"services",1:"clinics")_" ..."
 . K ^TMP("GMPLIST",$J,"VIEW") S ^TMP("GMPLIST",$J,"VIEW",0)=0,VALMBCK="Q",GMPLMODE=""
 . D SAVE W " done."
 Q
