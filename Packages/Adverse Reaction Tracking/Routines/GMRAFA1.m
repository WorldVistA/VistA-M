GMRAFA1 ;ISP/RFR - CORRECT ASSESSMENTS DETAIL;04/11/2013  07:13
 ;;4.0;Adverse Reaction Tracking;**48**;Mar 29, 1996;Build 13
EN ; -- main entry point for GMRA ASSESS FIX DETAIL
 Q
 ;
HDR ; -- header code
 Q:'+$G(DFN)
 N VADM,VAIN,ASSESS,IEN
 D DEM^VADPT,INP^VADPT
 S VALMHDR(1)=$$LJ^XLFSTR("Patient: "_VADM(1)_" ("_$P(VADM(2),"-",3)_")",$S(+$G(IOM)>0:IOM,1:80)-10," ")_$S($D(VAIN):" Inpatient",1:"Outpatient")
 S IEN=+$O(^GMR(120.86,"B",DFN,0))
 S:IEN>0 ASSESS=$P($G(^GMR(120.86,IEN,0)),U,2)
 S VALMHDR(2)="Assessment: "_$S(IEN=0:"None on file",ASSESS=0:"No known reactions",ASSESS=1:"Has known reactions",1:"<ENTRY NOT FOUND>")
 S VALMHDR(3)="Allergy Listing"
 Q
 ;
INIT ; -- init variables and list array
 Q:'+$G(DFN)
 D CLEAN^VALM10
 N IEN,TEXT
 S VALMCNT=0
 S IEN=0 F  S IEN=$O(^GMR(120.8,"B",DFN,IEN)) Q:'IEN  D
 .S VALMCNT=VALMCNT+1
 .S TEXT="",TEXT=$$SETFLD^VALM1(VALMCNT_".",TEXT,"LINENO")
 .S TEXT=$$SETFLD^VALM1($P($G(^GMR(120.8,IEN,0)),U,2),TEXT,"REACTANT")
 .S TEXT=$$SETFLD^VALM1($$EIE(IEN),TEXT,"ERROR")
 .D SET^VALM10(VALMCNT,TEXT,IEN)
 S:VALMCNT=0 VALMSG="No reactions found"
 Q
 ;
EIE(IEN) ; -- return 'Entered in Error' text
 N RETURN
 S RETURN=$$GET1^DIQ(120.8,IEN_",",22)
 S RETURN=$S(RETURN'="":RETURN,1:"NO")
 Q RETURN
 ;
HELP ; -- help code
 D FULL^VALM1
 W !!,"Use MA to reassess the patient for adverse reactions.  The patient's current",!
 W "assessment appears in the upper-left corner of the screen.",!
 W !!,"Use RR to view a single reaction.  After the reaction is displayed, the system",!
 W "will ask if you want to mark the reaction as 'Entered in Error'.",!
 W !!,"Use EE to mark all displayed reactions as 'Entered in Error'.  Use extreme",!
 W "caution when performing a mass update.  It is better to first view the reaction",!
 W "and then mark it as 'Entered in Error'.",!
 D WAIT^GMRAFX3
 S VALMBCK="R"
 Q
 ;
EXIT ; -- exit code
 D FULL^VALM1
 Q
 ;
EXPND ; -- expand code
 Q
 ;
RR ; -- review reaction
 Q:$$NOLOCK
 N DIC,DA,DIQ,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,GMRAPA,STATUS,GMRAITM
 D SELECT(.GMRAITM,"reactions")
 I 'GMRAITM S VALMSG="No reactions found" Q
 Q:GMRAITM<0
 S DA=+$O(@VALMAR@("IDX",GMRAITM,"")),DIC="^GMR(120.8,",DIQ(0)="CR"
 W ! D EN^DIQ
 S STATUS=$$EIE(DA)
 I STATUS="NO" D
 .S DIR(0)="YA"_U,DIR("A")="Would you like to mark this allergy as 'Entered in Error'? "
 .S DIR("B")="NO"
 .D ^DIR
 .I +$G(Y)>0 D 
 ..S GMRAPA=DA
 ..D MEIE
 I STATUS'="NO" D WAIT^GMRAFX3
 K VALMSG
 Q
 ;
UASSESS ; -- update assessment
 Q:$$NOLOCK
 D FULL^VALM1
 D NKAASK^GMRANKA(DFN)
 K VALMHDR,VALMSG
 D RE^VALM4
 Q
 ;
ALLEE ; -- mark all allergies as entered in error
 Q:$$NOLOCK
 I VALMCNT=0 D  Q
 .W !,"There are no reactions to mark."
 .S VALMSG="No reactions found"
 .D WAIT^GMRAFX3
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="YA"_U,DIR("A",1)="You are about to mark all of this patient's allergies as 'Entered in Error'."
 S DIR("A")="Do you want to continue? ",DIR("B")="NO"
 D ^DIR
 Q:$D(DIRUT)!($G(Y)<1)
 N GMRAPA,GMRAITM
 S GMRAITM=0 F  S GMRAITM=$O(@VALMAR@("IDX",GMRAITM)) Q:'$G(GMRAITM)  D
 .S GMRAPA=+$O(@VALMAR@("IDX",GMRAITM,""))
 .I '$P($G(^GMR(120.8,GMRAPA,"ER")),U) D
 ..S GMRAPA=+$O(@VALMAR@("IDX",GMRAITM,""))
 ..W !,"Marking "_$P($G(^GMR(120.8,GMRAPA,0)),U,2)_" as 'Entered in Error'...",!
 ..D MEIE
 Q
MEIE ; -- mark allergy as entered in error
 D EIE^GMRAFX3
 D FLDTEXT^VALM10(GMRAITM,"ERROR",$$EIE(GMRAPA))
 K VALMHDR,VALMSG
 D WRITE^VALM10(GMRAITM)
 Q
 ;
NOLOCK() ; -- determines if the user has a lock on the current patient
 N RETURN
 S RETURN=0
 I '$D(^XTMP("GMRAFA",DFN,DUZ)) S RETURN=1
 I $G(^XTMP("GMRAFA",DFN,DUZ))'=$J S RETURN=1
 I RETURN D
 .W !,"You no longer have a lock on this patient's records in this session.",!
 .W !,"Please reselect the patient."
 .S VALMBCK="Q"
 .D WAIT^GMRAFX3
 Q RETURN
SELECT(RETURN,ENTITIES) ; -- select an item from the list
 S RETURN=-1
 I VALMCNT=0 D  Q
 .W !,"There are no "_ENTITIES_" to select."
 .D WAIT^GMRAFX3
 .S RETURN=0
 N DIR,X,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="N^1:"_VALMCNT_":0"
 D ^DIR
 Q:$D(DIRUT)!($D(DIROUT))
 D FULL^VALM1
 S RETURN=Y
 Q
 ;
