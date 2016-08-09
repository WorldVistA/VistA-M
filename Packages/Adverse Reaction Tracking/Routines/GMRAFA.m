GMRAFA ;ISP/RFR - CORRECT ASSESSMENTS ;04/22/2016  11:37
 ;;4.0;Adverse Reaction Tracking;**48**;Mar 29, 1996;Build 13
EN ; -- main entry point for GMRA ASSESS FIX
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 I '$D(^XTMP("GMRAFAL")) D  Q
 .W !!,"I will create a task to build the list of assessments that need review"
 .W !,"and send you an email when the list is built.",!
 .N XMDUZ,XMDF,XMY,X,XMOUT
 .S XMDUZ=.5,^XTMP("GMRAFAL","B","RECIPS",DUZ)=""
 .S DIR(0)="Y"_U_"A",DIR("A")="Shall I notify anyone else when the list is built"
 .S DIR("B")="NO",DIR("?")="Enter YES to add other recipients or NO to not add other recipients."
 .D ^DIR
 .Q:$D(DIRUT)
 .I +Y S XMDF=1 D DES^XMA21 I X="",'$D(XMOUT),$D(XMY) M ^XTMP("GMRAFAL","B","RECIPS")=XMY
 .K X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 .S DIR(0)="Y"_U_"A",DIR("A")="Do you want to include deceased patients in the list"
 .S DIR("B")="NO",DIR("?",1)="Enter YES to include deceased patients in the list or NO to exclude deceased"
 .S DIR("?")="patients from the list."
 .D ^DIR
 .Q:$D(DIRUT)
 .S ^XTMP("GMRAFAL","Q","INC_DEAD")=+Y
 .N ZTRTN,ZTDESC,ZTIO,ZTSK
 .S ZTRTN="LISTBLD^GMRAFA",ZTDESC="GMRA ASSESSMENT LIST BUILDER",ZTIO=""
 .W !!,"Enter the date and time below when the assessment list builder should start.",!
 .D ^%ZTLOAD
 .I $D(ZTSK) S ^XTMP("GMRAFAL","B")=ZTSK W !!,"Successfully queued the assessment list builder; task #"_ZTSK_".",!!
 .E  W !!,"The assessment list builder was not scheduled.",!!
 .S:$D(^XTMP("GMRAFAL")) ^XTMP("GMRAFAL",0)=$$FMADD^XLFDT(DT,30,0,0,0)_U_DT_U_"GMRA ASSESSMENT LIST"
 I $G(^XTMP("GMRAFAL","B"))>0 D  Q
 .N ZTSK S ZTSK=+$G(^XTMP("GMRAFAL","B"))
 .W !!,"Task #"_ZTSK
 .D ISQED^%ZTLOAD
 .I ZTSK(0)=1 W " is scheduled to build the list" I $G(ZTSK("D"))>0 W " on "_$$HTE^XLFDT(ZTSK("D"))  K ZTSK
 .I $D(ZTSK(0)),ZTSK(0)="" D
 ..W " could not be found.",!
 ..I DUZ(0)'["@" W "Please contact IRM for assistance" I $G(ZTSK("E"))'="" W " with error code "_$G(ZTSK("E"))
 ..E  D RESET
 .I $D(ZTSK(0)),ZTSK(0)=0 D
 ..K ZTSK S ZTSK=+$G(^XTMP("GMRAFAL","B"))
 ..D STAT^%ZTLOAD
 ..I ZTSK(1)=2 K ZTSK W " is currently building the list" I $G(^XTMP("GMRAFAL","B","STATUS"))'="" W " and is "_^("STATUS")
 ..I $D(ZTSK(1)),ZTSK(1)=5 D
 ...W " stopped abnormally.",!
 ...I DUZ(0)'["@" W "Please contact IRM for assistance"
 ...E  D RESET
 ..I $D(ZTSK(1)),ZTSK(1)'=2,ZTSK(1)'=5 D
 ...W " has a problem.",!
 ...I DUZ(0)'["@" W "Please contact IRM for assistance"
 ...E  D RESET
 .W "."
 .Q:$D(ZTSK)
 .I $D(^XTMP("GMRAFAL","B","RECIPS",DUZ)) W !,"I will notify you when the list is complete.",!! Q
 .S DIR(0)="Y"_U_"A",DIR("A")="Shall I send you an email when the list is built"
 .S DIR("?")="Enter YES to add yourself to the recipient list or NO to not add yourself."
 .D ^DIR
 .I +Y D
 ..S ^XTMP("GMRAFAL","B","RECIPS",DUZ)="" W !,"I will notify you when the list is complete.",!
 ..S ^XTMP("GMRAFAL",0)=$$FMADD^XLFDT(DT,30,0,0,0)_U_DT_U_"GMRA ASSESSMENT LIST"
 D EN^VALM("GMRA ASSESS FIX")
 I $O(^XTMP("GMRAFAL",0))="B" K ^XTMP("GMRAFAL") Q
 K ^TMP($J,"GMRAFAL")
 Q
 ;
RESET ; -- reset the option
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="Y"_U_"A",DIR("A")="Shall I reset this option"
 S DIR("?")="Enter YES to delete the task number or NO to do nothing."
 D ^DIR
 I +Y K ^XTMP("GMRAFAL")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Adverse Reaction Tracking Assessment Corrector"
 Q
 ;
LISTBLD ; -- search for problem patients
 N DFN,TEXT,TOTAL,CUR,X,VALMCNT,INCDEAD,EXIT
 S ^XTMP("GMRAFAL",0)=$$FMADD^XLFDT(DT,30,0,0,0)_U_DT_U_"GMRA ASSESSMENT LIST"
 S VALMCNT=0,TOTAL=$O(^DPT("?"),-1),INCDEAD=+$G(^XTMP("GMRAFAL","Q","INC_DEAD"))
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .I 'INCDEAD D  I $G(EXIT) S EXIT=0 Q
 ..N VADM
 ..D DEM^VADPT
 ..I $G(VADM(6))'="" S EXIT=1
 .N COUNT,ASSESS
 .I '(DFN#1000) D
 ..S CUR=(DFN/TOTAL)*100,CUR=+$P(CUR,".")_"."_$E(+$P(CUR,".",2),1,2)
 ..S ^XTMP("GMRAFAL","B","STATUS")=CUR_"% complete"
 .I $D(^DPT(DFN,-9)) Q
 .Q:$$VERIFY(DFN,.COUNT,.ASSESS)
 .S VALMCNT=VALMCNT+1
 .S ^XTMP("GMRAFAL",VALMCNT,DFN,"PATIENT")=$$GET1^DIQ(2,DFN_",",.01)
 .S ^XTMP("GMRAFAL",VALMCNT,DFN,"ASSESSMENT")=$$EASSESS($G(ASSESS("EXTERNAL")))
 .S ^XTMP("GMRAFAL",VALMCNT,DFN,"ALLERGIES")=+$G(COUNT("GOOD"))
 N XMDUZ,XMSUB,XMZ,XMY
 S XMDUZ=.5,XMSUB="GMRA ASSESSMENT FIX LIST BUILD STATUS"
 M XMY=^XTMP("GMRAFAL","B","RECIPS")
 D XMZ^XMA2
 I XMZ>0 D
 .;ICR #10113 MAILMAN: Message Text - Direct Entry
 .I VALMCNT=0 D
 ..K ^XTMP("GMRAFAL")
 ..S ^XMB(3.9,XMZ,2,0)=U_3.92_U_2_U_2_U_DT
 ..S ^XMB(3.9,XMZ,2,1,0)="The assessment list builder has determined there are no patients with"
 ..S ^XMB(3.9,XMZ,2,2,0)="assessment problems. No further action is needed."
 .I VALMCNT>0 D
 ..K ^XTMP("GMRAFAL","B")
 ..S ^XTMP("GMRAFAL","B")=0
 ..S ^XMB(3.9,XMZ,2,0)=U_3.92_U_6_U_6_U_DT
 ..S ^XMB(3.9,XMZ,2,1,0)="The assessment list builder has successfully created the list of patients to"
 ..S ^XMB(3.9,XMZ,2,2,0)="review."
 ..S ^XMB(3.9,XMZ,2,3,0)=" "
 ..S ^XMB(3.9,XMZ,2,4,0)="Please use option Assessment clean up utility [GMRA ASSESSMENT UTILITY],"
 ..S ^XMB(3.9,XMZ,2,5,0)="located on the Enter/Edit Site Configurable Files [GMRA SITE FILE MENU] menu,"
 ..S ^XMB(3.9,XMZ,2,6,0)="to process this list."
 .D ENT2^XMD
 S ZTREQ="@"
 Q
 ;
INIT ; -- init variables and list array 
 W @IOF,"Please wait while I prepare the list."
 N DFN,TEXT,TOTAL,CUR,TEXT,LAST
 K ^TMP($J,"GMRAFAL")
 S CUR=0 F  S CUR=$O(^XTMP("GMRAFAL",CUR)) Q:'+CUR  D
 .S LAST=1+$G(LAST),^TMP($J,"GMRAFAL","C",LAST,CUR)=""
 S CUR=0 F  S CUR=$O(^TMP($J,"GMRAFAL","C",CUR)) Q:'+CUR  S LAST=$O(^TMP($J,"GMRAFAL","C",CUR,0)),DFN=$O(^XTMP("GMRAFAL",LAST,0)) D
 .S TEXT="",TEXT=$$SETFLD^VALM1(CUR_".",TEXT,"LINENO")
 .S TEXT=$$SETFLD^VALM1($G(^XTMP("GMRAFAL",LAST,DFN,"PATIENT")),TEXT,"PATIENT")
 .S TEXT=$$SETFLD^VALM1($$CJ^XLFSTR($G(^XTMP("GMRAFAL",LAST,DFN,"ASSESSMENT")),$P(VALMDDF("ASSESSMENT"),U,3)),TEXT,"ASSESSMENT")
 .S TEXT=$$SETFLD^VALM1($$CJ^XLFSTR($G(^XTMP("GMRAFAL",LAST,DFN,"ALLERGIES")),$P(VALMDDF("ALLERGIES"),U,3)),TEXT,"ALLERGIES")
 .D SET^VALM10(CUR,TEXT,DFN)
 .S VALMCNT=CUR
 S:$G(VALMCNT)="" VALMCNT=0,VALMSG="No problems found"
 Q
 ;
VERIFY(DFN,COUNT,ASSESS) ; -- verify the assessment matches the allergies
 N IEN,RETURN
 K COUNT,ASSESS
 S (IEN,COUNT,RETURN)=0
 F  S IEN=$O(^GMR(120.8,"B",DFN,IEN)) Q:'IEN  D
 .I +$P($G(^GMR(120.8,IEN,"ER")),U) S COUNT("ERROR")=1+$G(COUNT("ERROR"))
 .I '+$P($G(^GMR(120.8,IEN,"ER")),U) S COUNT("GOOD")=1+$G(COUNT("GOOD"))
 S ASSESS=+$O(^GMR(120.86,"B",DFN,0))
 S:ASSESS>0 ASSESS("EXTERNAL")=$$GET1^DIQ(120.86,ASSESS_",",1),ASSESS=$P($G(^GMR(120.86,ASSESS,0)),U,2)
 I +ASSESS,(+$G(COUNT("GOOD"))>0) S RETURN=1
 I '+ASSESS,('+$G(COUNT("GOOD"))) S RETURN=1
 Q RETURN
 ;
EASSESS(ASSESS) ; -- return the external value of the assessment
 Q $S($G(ASSESS)="":"No Assess.",1:$G(ASSESS))
 ;
HELP ; -- help code
 D FULL^VALM1
 W !!,"Use SP to select the patient you want to work with.  You can only work with one",!
 W "patient at a time.",!
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
PATIENT ; -- select patient
 N GMRAITM,DFN,ASSESS,COUNT,EXIT,ISFIXED,GMRAACT
 D SELECT^GMRAFA1(.GMRAITM,"patients")
 I 'GMRAITM S VALMSG="No problems found" Q
 Q:GMRAITM<0
 S DFN=+$O(@VALMAR@("IDX",GMRAITM,"")),EXIT=0
 I $D(^XTMP("GMRAFA",DFN)),('$D(^XTMP("GMRAFA",DFN,DUZ))) D  Q
 .N IEN
 .S IEN=+$O(^XTMP("GMRAFA",DFN,0))
 .W !,$S(IEN>0:$$GET1^DIQ(200,IEN_",",.01),1:"Someone")_" has locked that patient's records"
 .I $G(^XTMP("GMRAFA",DFN,IEN))'="" W !,"in process ID number "_$G(^XTMP("GMRAFA",DFN,IEN))
 .W "."
 .D WAIT^GMRAFX3
 I $D(^XTMP("GMRAFA",DFN,DUZ)),($G(^XTMP("GMRAFA",DFN,DUZ))'=$J) D  Q:$G(EXIT)
 .N IEN
 .S IEN=+$O(^XTMP("GMRAFA",DFN,0))
 .W !,"You are already editing this patient in a different session",!
 .W "(that session has process ID number "_$G(^XTMP("GMRAFA",DFN,IEN))_").",!
 .N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 .S DIR(0)="YA"_U,DIR("A",1)="Are you sure you want to continue editing"
 .S DIR("A")="this patient in this session? ",DIR("B")="NO"
 .D ^DIR
 .I $D(DIRUT)!('Y) S EXIT=1
 S ^XTMP("GMRAFA",0)=$$FMADD^XLFDT(DT,7,0,0,0)_U_DT_U_"GMRA ASSESSMENT FIX LOCKS",^XTMP("GMRAFA",DFN,DUZ)=$J
 I $$VERIFY(DFN,.COUNT,.ASSESS) D  Q
 .W !,"Number "_GMRAITM_" has already been corrected."
 .D FLDTEXT^VALM10(GMRAITM,"ASSESSMENT",$$CJ^XLFSTR($$EASSESS($G(ASSESS("EXTERNAL"))),$P(VALMDDF("ASSESSMENT"),U,3)))
 .D FLDTEXT^VALM10(GMRAITM,"ALLERGIES",$$CJ^XLFSTR(+$G(COUNT("GOOD")),$P(VALMDDF("ALLERGIES"),U,3)))
 .D FLDTEXT^VALM10(GMRAITM,"STATUS","**FIXED**")
 .D WAIT^GMRAFX3
 D EN^VALM("GMRA ASSESS FIX DETAIL")
 S ISFIXED=$$VERIFY(DFN,.COUNT,.ASSESS)
 D FLDTEXT^VALM10(GMRAITM,"ASSESSMENT",$$CJ^XLFSTR($$EASSESS($G(ASSESS("EXTERNAL"))),$P(VALMDDF("ASSESSMENT"),U,3)))
 D FLDTEXT^VALM10(GMRAITM,"ALLERGIES",$$CJ^XLFSTR(+$G(COUNT("GOOD")),$P(VALMDDF("ALLERGIES"),U,3)))
 S GMRAACT=+$O(^TMP($J,"GMRAFAL","C",GMRAITM,0))
 I GMRAACT>0,'ISFIXED D
 .S ^XTMP("GMRAFAL",GMRAACT,DFN,"ASSESSMENT")=$$EASSESS($G(ASSESS("EXTERNAL")))
 .S ^XTMP("GMRAFAL",GMRAACT,DFN,"ALLERGIES")=+$G(COUNT("GOOD"))
 I ISFIXED D
 .D FLDTEXT^VALM10(GMRAITM,"STATUS","**FIXED**")
 .K:GMRAACT>0 ^XTMP("GMRAFAL",GMRAACT)
 D WRITE^VALM10(GMRAITM)
 D RE^VALM4
 I $D(^XTMP("GMRAFA",DFN,DUZ)),($G(^XTMP("GMRAFA",DFN,DUZ))=$J) K ^XTMP("GMRAFA",DFN)
 Q
 ;
