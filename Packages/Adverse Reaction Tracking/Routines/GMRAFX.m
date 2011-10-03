GMRAFX ;SLC/DAN Fix existing allergy entries ;3/2/06  13:46
 ;;4.0;Adverse Reaction Tracking;**17,19,23,20**;Mar 29, 1996;Build 1
 ;DBIA SECTION
 ;10118 - VALM
 ;2056  - DIQ
 ;3744  - $$TESTPAT^VADPT
 ;10006 - DIC
 ;10103 - XLFDT
 ;10102 - XQORM1
 ;10104 - XLFSTR
 ;10117 - VALM10
 ;10116 - VALM1
 ;10026 - DIR
 ;10018 - DIE
 ;10013 - DIK
 ;10061 - VADPT
 ;10101 - XQOR
 ;
EN ; -- main entry point for GMRA FIX
 N NMBR,REBLD,Y,DIR,I,LTYPE
 S LTYPE=$$GETTYPE^GMRAFX3(.LTYPE) Q:LTYPE=0
 I $D(^XTMP("GMRAFX",LTYPE,"B")) W !,"The list is currently being built by another user so this option is",!,"temporarily unavailable.  Please try again in a few minutes." Q
 I $D(^XTMP("GMRAFX",LTYPE,"INUSE")) D
 .W !,"The utility is currently in use by the following people:",!
 .S I=0 F  S I=$O(^XTMP("GMRAFX",LTYPE,"INUSE",I)) Q:'+I  W !,$$GET1^DIQ(200,I,.01)
 .W !!,"As a result, the existing "_$S(LTYPE="FREE":"free text",LTYPE="ING":"ingredient",1:"drug class")_" list will be used." D WAIT^GMRAFX3
 I $D(^XTMP("GMRAFX",LTYPE)),'$D(^XTMP("GMRAFX",LTYPE,"INUSE")) D
 .W !,"The "_$S(LTYPE="FREE":"free text",LTYPE="ING":"ingredient",1:"drug class")_" list was last built on ",$$FMTE^XLFDT($P(^XTMP("GMRAFX",LTYPE,0),U,2)),!
 .S DIR(0)="Y",DIR("A")="Do you want to rebuild the list",DIR("B")="NO",DIR("?")="Enter yes to rebuild the list of entries.  Enter NO to use the currently existing list"
 .D ^DIR I Y=1 K ^XTMP("GMRAFX",LTYPE) S REBLD=1
 I $G(REBLD)!('$D(^XTMP("GMRAFX",LTYPE))) W !,"Building list of "_$S(LTYPE="FREE":"free text",LTYPE="ING":"ingredient",1:"drug class")_" allergies...this may take a few minutes",!
 S ^XTMP("GMRAFX",LTYPE,"INUSE",+$G(DUZ))=""
 D EN^VALM("GMRA FIX")
 K ^XTMP("GMRAFX",LTYPE,"INUSE",+$G(DUZ))
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Allergy Tracking "_$S(LTYPE="FREE":"Free Text",LTYPE="ING":"Ingredient",1:"Drug CLass")_" Entries"
 Q
PHDR ;
 S VALMSG="Select one or more entries"
 S XQORM("#")=$$FIND1^DIC(101,,"BX","GMRA FIX FREE TEXT LIST") ;19
 D SHOW^VALM
 Q
 ;
INIT ;Initialize variables, etc
 S VALMBCK="",VALMBG=$S($G(VALMBG)'="":VALMBG,1:1),VALMCNT=$S($D(^XTMP("GMRAFX",LTYPE,0)):$P(^(0),U,3),1:0),VALMWD=80
 Q
LIST ; -- obtain and display list of free text allergies
 N GMRAIEN,GMRAOTH,GMRATXT,GMRAUTXT,SP1,SP2,SP3,UP,TXT
 S VALMBCK="R",VALMCNT=0
 K ^XTMP("GMRAFX",LTYPE) S ^XTMP("GMRAFX",LTYPE,"B")="",^XTMP("GMRAFX",LTYPE,"INUSE",+$G(DUZ))=""
 S GMRAOTH=$O(^GMRD(120.82,"B","OTHER ALLERGY/ADVERSE REACTION",0))_";GMRD(120.82," ;Gets IEN;FILE ENTRY for free text entries
 S GMRAIEN=0 F  S GMRAIEN=$O(^GMR(120.8,GMRAIEN)) Q:'+GMRAIEN  D
 .I LTYPE="FREE" I $P($G(^GMR(120.8,GMRAIEN,0)),U,3)'=GMRAOTH Q
 .I LTYPE="ING" I $P($G(^GMR(120.8,GMRAIEN,0)),U,3)'["50.416" Q
 .I LTYPE="DRUG" I $P($G(^GMR(120.8,GMRAIEN,0)),U,3)'["50.605" Q
 .Q:+$G(^GMR(120.8,GMRAIEN,"ER"))  ;Quit if reactant entered in error
 .Q:$$DECEASED(+$P($G(^GMR(120.8,GMRAIEN,0)),U))  ;Don't report expired patients
 .Q:$$TESTPAT^VADPT($P($G(^GMR(120.8,GMRAIEN,0)),U))  ;Don't report test patients
 .S GMRATXT=$E($P($G(^GMR(120.8,GMRAIEN,0)),U,2),1,75) ;Get "reactant" text entry, no more than 75 characters
 .S GMRATXT=$TR(GMRATXT,"""","") ;19 remove quote marks from text
 .S GMRAUTXT=$$UP^XLFSTR(GMRATXT) ;Convert to upper case
 .S ^XTMP("GMRAFX",LTYPE,"GMRAR",GMRAUTXT,GMRATXT)=$G(^XTMP("GMRAFX",LTYPE,"GMRAR",GMRAUTXT,GMRATXT))+1 ;# of active entries
 .S ^XTMP("GMRAFX",LTYPE,"GMRAR",GMRAUTXT,GMRATXT,GMRAIEN)="" ;Store entry number
 .Q
 S UP="" F  S UP=$O(^XTMP("GMRAFX",LTYPE,"GMRAR",UP)) Q:UP=""  S TXT="" F  S TXT=$O(^XTMP("GMRAFX",LTYPE,"GMRAR",UP,TXT)) Q:TXT=""  D
 .S VALMCNT=VALMCNT+1
 .S SP1=4-$L(VALMCNT),SP2=40-$L(TXT),SP3=16-$L(^XTMP("GMRAFX",LTYPE,"GMRAR",UP,TXT))\2 ;Set up spacing before storing
 .D SET^VALM10(VALMCNT,VALMCNT_$$REPEAT^XLFSTR(" ",SP1)_TXT_$$REPEAT^XLFSTR(" ",SP2)_$$REPEAT^XLFSTR(" ",SP3)_^XTMP("GMRAFX",LTYPE,"GMRAR",UP,TXT))
 .S ^XTMP("GMRAFX",LTYPE,"IDX",VALMCNT)=UP_"^"_TXT
 K ^XTMP("GMRAFX",LTYPE,"B") ;Done building
 S ^XTMP("GMRAFX",LTYPE,0)=$$FMADD^XLFDT(DT,30)_U_DT_U_$G(VALMCNT)
 Q
 ;
HELP ; -- help code
 D FULL^VALM1
 W !!,"Use AE to add local allergies to the GMR ALLERGY file.  This",!,"should only be done if you're sure no existing reactant matches your needs."
 W !!,"Use EE to mark all entries within the selected group as entered",!,"in error.  You may select multiple groups if you like."
 W !!,"Use DD to get a detailed display.  It's highly recommended that you",!,"use the detailed display menu to make all changes."
 W !!,"Use UR to update the reactant.  Extreme caution should be used when doing",!,"mass updates.  It would be better to do the updates from within",!,"the detailed display menu.",!
 D WAIT^GMRAFX3 S VALMBCK="R"
 Q
 ;
EXIT ; -- exit code
 D FULL^VALM1
 D DESELECT  ;Clear any remaining items
 Q
 ;
EXPND ; -- expand code
 Q
 ;
CHKSEL ;Evaluate selection if done by number
 N J,TMP,DIR,NUM,X,Y,TNMBR
 S VALMBCK="R"
 S NUM=$P($G(XQORNOD(0)),"=",2) ;get currently selected entries
 I NUM'="" D
 .I NUM=$G(NMBR) D DESELECT Q  ;If user selects same entry without taking an entry, unhighlight and stop processing
 .D DESELECT:$G(NMBR) ;If user previously selected entries but took no action, unhighlight before highlighting new choices
 .S NMBR=$P(XQORNOD(0),"=",2),DIR(0)="L^"_"1:"_VALMCNT,X=NMBR,DIR("V")="" D ^DIR K DIR
 .I Y="" D FULL^VALM1 W !,"Invalid selection." D WAIT^GMRAFX3 K NMBR Q  ;Selection out of range, stop processing
 .S TNMBR=""
 .F J=1:1:$L(NMBR,",")-1 S TMP=$P(NMBR,",",J) I $$LOCK^GMRAFX3(TMP) S TNMBR=TNMBR_TMP_"," D CNTRL^VALM10(TMP,1,+$G(VALMWD),IORVON,IORVOFF)
 .I TNMBR="" K NMBR Q
 .S NMBR=TNMBR
 Q
 ;
DESELECT ;Un-highlight selected choices
 N J,TMP
 F J=1:1:$L($G(NMBR),",")-1 S TMP=$P(NMBR,",",J) D CNTRL^VALM10(TMP,1,+$G(VALMWD),IORVOFF,IORVOFF) L -^XTMP("GMRAFX","IDX",TMP)
 K NMBR
 Q
 ;
AEA ; Entry for GMRA LOCAL ALLERGIES EDIT option
 S VALMBCK="R" D FULL^VALM1,PROCESS^GMRAFUT0,WAIT^GMRAFX3 Q  ;23
 N DLAYGO,DIC,Y,GMRAIEN,DA,GMRALN,DIE,GMRACT,DR,GMRAX,GMRAY,X
 S VALMBCK="R" D FULL^VALM1
 W ! S DLAYGO=120.82,DIC="^GMRD(120.82,",DIC("A")="Select a LOCAL ALLERGY/ADVERSE REACTION: ",DIC(0)="AEQML",DIC("DR")="1" D ^DIC K DIC,DLAYGO Q:+Y'>0  S (DA,GMRAIEN)=+Y
 L +^GMRD(120.82,GMRAIEN):1 I '$T W !,"THIS ENTRY IS BEING EDITED BY SOMEONE ELSE" Q
 S GMRALN=$G(^GMRD(120.82,GMRAIEN,0))
 S DIE="^GMRD(120.82,",DR="",GMRACT=1
 I +$P(GMRALN,U,3) S DR(1,120.82,1)="@1;W !!,$C(7),""CANNOT EDIT NAME FIELD OF A NATIONAL ALLERGY."",!;3;"
 E  D
 .S DR(1,120.82,1)=".01;3;"
 .S DR(1,120.82,2)="S (GMRAY,GMRAX)=$P(GMRALN,U,2) D EDTTYPE^GMRAUTL(.GMRAX);"
 .S DR(1,120.82,3)="S:GMRAX=GMRAY!(""^^""[GMRAX) X=GMRAX,Y=$S(""^^""[GMRAX:""@3"",1:""@4"");1///^S X=GMRAX;@4;4;5;@3;"
 .Q
 D ^DIE
 L -^GMRD(120.82,GMRAIEN)
 Q
 ;
PROCESS(TYPE) ;API to mark all entries as entered in error or update entries to new reactant
 N GMRAPA,GMRAI,GMRAJ,DIR,Y,ROOT,NUM,ENTRY,GMRADONE,STOP,J,TNMBR,GMRAAR,GMRASURE
 S VALMBCK="R" D FULL^VALM1
 I '$G(NMBR) S NMBR=$$GETNUM^GMRAFX3("") Q:'+NMBR  D  Q:'+$G(NMBR)
 .S TNMBR=""
 .F J=1:1:$L(NMBR,",")-1 S TMP=$P(NMBR,",",J) I $$LOCK^GMRAFX3(TMP) S TNMBR=TNMBR_TMP_","
 .I TNMBR="" K NMBR Q
 .S NMBR=TNMBR
 I TYPE="U" W !!,"You should use the detailed display option to review entries in",!,"this group before doing a mass update.  CHANGES CANNOT BE UN-DONE!" D WAIT^GMRAFX3
 W !!,"You are about to ",$S(TYPE="E":"mark",1:"update")," ALL allergies with the selected reactant ",!,$S(TYPE="E":"as entered in error.",1:"to a new reactant."),!
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="ARE YOU SURE"
 S DIR("?")="If you're unsure, use the 'detailed display' option to get a list of individual patients."
 S DIR("?",1)="Answering YES to this prompt will cause all allergies associated with"
 S DIR("?",2)="the selected reactant to be "_$S(TYPE="E":"marked as entered in error.",1:"updated to the new reactant.")
 S DIR("?",3)=""
 S DIR("?",4)="Be SURE this is what you want to do."
 D ^DIR Q:Y'=1  ;Stop if user doesn't answer yes
 F GMRAI=1:1:($L(NMBR,",")-1) D
 .S NUM=$P(NMBR,",",GMRAI),ENTRY=^XTMP("GMRAFX",LTYPE,"IDX",NUM),STOP=0
 .S ROOT="^XTMP(""GMRAFX"",LTYPE,""GMRAR"","_""""_$P(ENTRY,"^")_""""_","_""""_$P(ENTRY,"^",2)_""""_")",GMRAJ=0 Q:'@ROOT
 .I TYPE="U" W !!,"Updating ",$P(ENTRY,U)," reactions"
 .F  S GMRAJ=$O(@ROOT@(GMRAJ)) Q:GMRAJ=""!($G(STOP))  I GMRAJ D
 ..S GMRAPA=GMRAJ,GMRADONE=1 D @$S(TYPE="E":"EIE",1:"UIE^GMRAFX3")
 ..D:GMRADONE UPDATE^GMRAFX3
 Q
 ;
EIE ;Mark individual entry as entered in error
 D EIE^GMRAFX3 ;Moved due to size limits
 Q
 ;
DECEASED(GMRAIFN) ;Function returns 1 if patient is deceased, 0 if living
 N DFN,VADM
 Q:GMRAIFN=0 1  ;If no patient entry return true
 S DFN=GMRAIFN
 D DEM^VADPT
 Q $S(+VADM(6):1,1:0)  ;VADM(6) holds date of death
 ;
ADCOM(ENTRY,TYPE,COM) ;Add comment to allergy
 N DIC,DIE,DR,DA,Y,X
 S DA(1)=ENTRY
 S DIC="^GMR(120.8,"_DA(1)_",26,",DIC(0)="L" F  S X=$$NOW^XLFDT Q:'$D(^GMR(120.8,DA(1),26,"B",X))  ;23 Don't allow duplicate entries
 D ^DIC Q:Y=-1  ;add new comment multiple
 S DA=+Y
 S DIE=DIC K DIC
 S DR="1////"_$G(DUZ,.5)_";1.5///"_TYPE_";2///"_$TR(COM,";"," ") ;remove semi-colon from free text
 D ^DIE ;Comment added by user
 Q
