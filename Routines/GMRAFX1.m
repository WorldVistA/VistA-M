GMRAFX1 ;SLC/DAN Fix existing allergy entries-continued ;10/6/05  11:42
 ;;4.0;Adverse Reaction Tracking;**17,19,20**;Mar 29, 1996;Build 1
 ;DBIA SECTION
 ;10116 - VALM1
 ;10102 - XQORM1
 ;10104 - XLFSTR
 ;10061 - VADPT
 ;10017 - VALM10
 ;10118 - VALM
 ;10026 - DIR
 ;
DET ;Detailed listing of selected group
 N DIR,Y,DTOUT,DUOUT,DIRUT,J,GMRAT,GMRAUT,DFN,GMRA,GMRAL,VADM,CNT,VAERR,K,LEN,NAME,ENTRY,NMBR2,ENMBR,GMRAR
 S VALMBCK="R",CNT=0
 K ^TMP($J,LTYPE,"GMRADET"),^TMP($J,LTYPE,"IDX2")
 S ENMBR=+NMBR ;get number portion of entry
 S ENTRY=0
 S GMRAUT=$P(^XTMP("GMRAFX",LTYPE,"IDX",ENMBR),"^"),GMRAT=$P(^XTMP("GMRAFX",LTYPE,"IDX",ENMBR),"^",2)
 S J=0 F  S J=$O(^XTMP("GMRAFX",LTYPE,"GMRAR",GMRAUT,GMRAT,J)) Q:'+J  D
 .S DFN=$P($G(^GMR(120.8,J,0)),"^"),GMRA="0^0^111" D ^GMRADPT ;Get patient allergies
 .D DEM^VADPT ;Get patient information
 .Q:$G(VAERR)  ;Quit if patient lookup produces an error
 .S CNT=CNT+1,ENTRY=ENTRY+1
 .S GMRAR(CNT)=VADM(1)_$$REPEAT^XLFSTR(" ",(32-$L(VADM(1))))_$E(VADM(2),6,9)_" "
 .D SET^VALM10(CNT,ENTRY_$$REPEAT^XLFSTR(" ",(4-$L(ENTRY)))_GMRAR(CNT)) K GMRAR(CNT) ;19
 .S ^TMP($J,LTYPE,"IDX2",ENTRY)=CNT_"^"_J
 .S CNT=CNT+1,LEN=0,GMRAR(CNT)="Allergies: "
 .S K=0 F  S K=$O(GMRAL(K)) Q:'+K  D
 ..S NAME=$P(GMRAL(K),"^",2) ;Allergy name
 ..S LEN=LEN+$L(NAME)+1
 ..I LEN>70 D SET^VALM10(CNT,GMRAR(CNT)) K GMRAR(CNT) S CNT=CNT+1,LEN=$L(NAME)+1,GMRAR(CNT)="   " ;19
 ..S GMRAR(CNT)=$G(GMRAR(CNT))_NAME_$S($O(GMRAL(K)):"~",1:"") D:'$O(GMRAL(K)) SET^VALM10(CNT,GMRAR(CNT)) ;19
 S VALMCNT=CNT,^TMP($J,LTYPE,"IDX2",0)=ENTRY
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Patient listing for reactant "_$S(+$G(NMBR):$P(^XTMP("GMRAFX",LTYPE,"IDX",+NMBR),"^"),1:"")
 Q
 ;
PHDR ;
 S VALMSG="Select a patient"
 S XQORM("#")=$$FIND1^DIC(101,,"BX","GMRA FIX DETAIL MENU") ;19
 D SHOW^VALM
 Q
 ;
INIT ; -- init variables and list array
 N DIR
 I '$G(NMBR) S NMBR=$$GETNUM^GMRAFX3("DET") S:'+NMBR VALMQUIT="" Q:'+NMBR  I '$$LOCK^GMRAFX3(+NMBR) S VALMQUIT="" Q
 I $L($G(NMBR),",")>2 D FULL^VALM1 W !,"Please select",$S('$G(NMBR):"",1:" only")," one entry from the list." S DIR(0)="E",DIR("A")="Press enter to continue" D ^DIR S VALMQUIT=1 Q
 K ^TMP($J,LTYPE,"GMRADET"),^TMP($J,LTYPE,"IDX2")
 S VALMBCK="",VALMBG=$G(VALMBG,1),VALMCNT=0,VALMWD=80
 Q
 ;
CHKSEL ;Evaluate selection if done by number
 N J,TMP,DIR,NUM,X,Y
 S NUM=$P($G(XQORNOD(0)),"=",2) ;get currently selected entries
 I NUM'="" D
 .I NUM=$G(NMBR2) D DESELECT Q  ;If user selects same entry without taking an entry, unhighlight and stop processing
 .D DESELECT:$G(NMBR2) ;If user previously selected entries but took no action, unhighlight before highlighting new choices
 .S NMBR2=$P(XQORNOD(0),"=",2),DIR(0)="L^"_"1:"_$G(^TMP($J,LTYPE,"IDX2",0)),X=NMBR2,DIR("V")="" D ^DIR K DIR
 .I Y="" D FULL^VALM1 W !,"Invalid selection." D WAIT^GMRAFX3 K NMBR2 Q  ;Selection out of range, stop processing
 .F J=1:1:$L(NMBR2,",")-1 S TMP=$P(NMBR2,",",J) D CNTRL^VALM10(+^TMP($J,LTYPE,"IDX2",TMP),1,+$G(VALMWD),IORVON,IORVOFF)
 Q
 ;
DESELECT ;Un-highlight selected choices
 N J,TMP
 F J=1:1:$L($G(NMBR2),",")-1 S TMP=$P(NMBR2,",",J) D CNTRL^VALM10(+^TMP($J,LTYPE,"IDX2",TMP),1,+$G(VALMWD),IORVOFF,IORVOFF)
 K NMBR2
 Q
HELP ; -- help code
 D FULL^VALM1
 W !!,"Use AE to add local allergies to the GMR ALLERGY file.  This",!,"should only be done if you're sure no existing reactant matches your needs."
 W !!,"Use EE to mark all selected entries as entered",!,"in error.  You may select multiple patients if you like."
 W !!,"Use UR to update the reactant.  Extreme caution should be used when updating",!,"reactants.  You may select multiple patients if you like,"
 W !!,"Use PR to add new allergies for the selected patient in",!,"addition to the ones listed here."
 W !!,"Use DD to get details about the allergy entry that you're",!,"currently working on for this patient.",!
 D WAIT^GMRAFX3 S VALMBCK="R"
 Q
 ;
EXIT ; -- exit code
 K ^TMP($J,LTYPE,"IDX2"),^TMP($J,LTYPE,"GMRADET")
 Q
 ;
EXPND ; -- expand code
 Q
 ;
PROCESS(TYPE) ;API to mark selected entries from the detailed listing as entered in error or update to new reactant
 N GMRAPA,GMRAJ,DIR,Y,NUM,GMRADONE,ENTRY,GMRAI,STOP,NUM2,GMRAAR
 S VALMBCK="R" D FULL^VALM1
 I '$G(NMBR2) S NMBR2=$$GETNUM^GMRAFX3("") Q:'+NMBR2
 W !!,"You are about to ",$S(TYPE="E":"mark",1:"update")," the selected patient",$S($L(NMBR2,",")>2:"s'",1:"'s"),!
 S ENTRY=$G(^XTMP("GMRAFX",LTYPE,"IDX",+NMBR))
 W $P(ENTRY,"^",2)," allergy ",$S(TYPE="E":"as entered in error.",1:"to a new reactant."),!
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="ARE YOU SURE"
 S DIR("?")="Once allergies are updated or marked as entered in error it cannot be undone!"
 S DIR("?",1)="Be sure this is what you want to do."
 D ^DIR Q:Y'=1  ;Stop if user doesn't answer yes
 S NUM=+NMBR
 F GMRAI=1:1:($L(NMBR2,",")-1) D  Q:$G(STOP)
 .S GMRADONE=1
 .S NUM2=$P(NMBR2,",",GMRAI)
 .S (GMRAPA,GMRAJ)=$P(^TMP($J,LTYPE,"IDX2",NUM2),U,2) Q:'GMRAPA
 .D @$S(TYPE="E":"EIE^GMRAFX",1:"UIE^GMRAFX3")
 .D:$G(GMRADONE) UPDATE^GMRAFX3
 Q
