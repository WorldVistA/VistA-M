VAQLED07 ;ALB/JFP,JRP - DISPLAY MINIMAL DATA/ADD NEW PATIENT ;01MAR93 [ 12/04/96  9:23 AM ]
 ;;1.5;PATIENT DATA EXCHANGE;**13,22,23,43**;NOV 17, 1993
EP ; -- Main entry point for the list processor
 ;    Note: sets flag 'VAQADFL' if required elements are blank
 ;
 K ^TMP("VAQD1",$J),^TMP("VAQDIS",$J)
 S (VAQADFL,VALMCNT)=0
 ;
EXTR ; -- Extract PDX minimal data
 S DFN=DFNTR
 S ROOT="^TMP(""VAQDIS"",$J)"
 S SEGPTR=$O(^VAT(394.71,"C","PDX*MIN",""))
 S VAQIGNC=1 ; -- turns of encryption
 S X=$$SEGEXT^VAQUPD1(DFN,SEGPTR,ROOT)
 I +X=-1 W !,"Extract not successful...Error: "_$P(X,U,2) D PAUSE^VALM1 QUIT
 ; -- extraction sucessful,check for missing data
 D CHKNULL
 I VAQADFL=1 D  Q
 .S VAQST="** Unable to load patient...required elements missing"
 .D EN^VALM("VAQ DIS MIN NUPD") ; -- Protocol = VAQ DIS1 (MENU)
 S VAQST="** <AP> attempt to add new patient or <RETURN> to exit"
 D EN^VALM("VAQ DIS MIN UPD") ; -- protocol = VAQ PDX7 (MENU)
 QUIT
 ;
INIT ; -- Builds array of minimal data for the patient entered (DFN)
 S XTRCT=ROOT
 S ROOT="^TMP(""VAQD1"",$J)"
 S (OFFSET,DSP)=0
 S X=$$DISPMIN^VAQDIS21(XTRCT,SEGPTR,ROOT,OFFSET,DSP)
 I +X=-1 S MSG="Display load not successful...Error: "_$P(X,U,2) D ERRMSG QUIT
 S VALMCNT=+X-1
 D DISMSG
 K VALMBCK
 QUIT
 ;
HD ; -- Make header line for list processor
 D HD1^VAQEXT02 QUIT
 ;
ADD ; -- Adds new patient to local data base
 D CLEAR^VALM1
 W !,"Please wait while information on ",$G(^TMP("VAQDIS",$J,"VALUE",2,.01,0))," is added",!
 I $G(^TMP("VAQDIS",$J,"VALUE",2,.09,0))'["P",$O(^DPT("SSN",$G(^TMP("VAQDIS",$J,"VALUE",2,.09,0)),"")) D  Q
 . W !!,$C(7),"** Patient not added, SSN in use by existing patient"
 . W !
 . D TRANEX
 S DIC="^DPT("
 S DIC(0)="EL"
 S DLAYGO=2
 S X=$G(^TMP("VAQDIS",$J,"VALUE",2,.01,0))
 S DIC("DR")=".03///"_$G(^TMP("VAQDIS",$J,"VALUE",2,.03,0))
 F I=.09,391,1901 S DIC("DR")=DIC("DR")_";"_I_"///"_$G(^TMP("VAQDIS",$J,"VALUE",2,I,0))
 K DD,D0 D FILE^DICN K DIC,DLAYGO
 I $P(Y,U,3)'=1 W !!,$C(7),"** Patient not added",! D TRANEX QUIT
 ;
 ; -- Update workload file (new patient)
 D WORKLD
 ; -- Add rest of information for stub"
 S VAQSTUB=+Y
 S LOCKFLE=$G(^DIC(2,0,"GL"))
 L +(@(LOCKFLE_VAQSTUB_")")):60
 I ('$T) W !,"Could not edit entry...record locked" K LOCKFLE QUIT
 F FLD=.02,.05,.08,.301,.302,.361,.323,.111,.112,.113,.114,.115,.1112,.117 D LOAD
 ; -- load temporary address information, if active
 D TMPADDR QUIT
 L -(@(LOCKFLE_VAQSTUB_")")) K LOCKFLE
 W !,"** PDX minimal information on ",$G(^TMP("VAQDIS",$J,"VALUE",2,.01,0))," has been added"
 D TRANEX
 D EP^VAQLED02
 K VALMBCK
 QUIT
 ;
LOAD ; -- Loads fields to patient file
 S DIE=2,(DA,DFNPT)=VAQSTUB
 S DR=FLD_"///^S X=$G(^TMP(""VAQDIS"",$J,""VALUE"",2,FLD,0))"
 D ^DIE K DIE,DA,DR
 I ($D(Y)#2) W ?10,"- ",$P(^DD(2,FLD,0),U,1),?40," could not be added",!
 QUIT
 ;
TMPADDR ; -- Checks to see if temporary address dates are active and flag set
 ; -- active flag
 I $G(^TMP("VAQDIS",$J,"VALUE",2,.12105,0))="Y" QUIT  ;strt dte 
 I $G(^TMP("VAQDIS",$J,"VALUE",2,.1217,0))'<DT QUIT  ;strt dte
 I $G(^TMP("VAQDIS",$J,"VALUE",2,.1218,0))'>DT QUIT  ;end dte
 ; -- Load temporary address fields
 F FLD=.12105,.1211,.12111,.12112,.1212,.1213,.1214,.1215,.12112,.1217,.1218,.1219 D LOAD
 QUIT
 ;
ERRMSG ; -- Displays error message
 S X=$$SETSTR^VALM1(" ","",1,79) D TMP
 S X=$$SETSTR^VALM1(MSG,"",1,80) D TMP
 S VALMBCK="Q"
 QUIT
 ;
DISMSG ; -- Display status message
 S X=$$SETSTR^VALM1(VAQST,"",1,79) D TMP
 K VAQLN,VAQST
 QUIT
 ;
TMP ; -- Set the array used by list processor
 S VALMCNT=VALMCNT+1
 S ^TMP("VAQD1",$J,VALMCNT,0)=$E(X,1,79)
 QUIT
 ;
CHKNULL ; -- Sets missing data flag if it finds a required field null
 ; Added quit condition.  NOIS ISD-0495-40199
 S FLD=""
 F FLD=.01,.02,.03,.05,.08,.09,.111,.114,.115,.1112,.117,.323,.361,391,1901 Q:(VAQADFL=1)  D
 .S VAQDATA=$G(^TMP("VAQDIS",$J,"VALUE",2,FLD,0))
 .S:VAQDATA="" VAQADFL=1
 I VAQADFL=0 D
 .S:($G(^TMP("VAQDIS",$J,"VALUE",2,.302,0))=""&($G(^TMP("VAQDIS",$J,"VALUE",2,.301,0))'="NO")) VAQADFL=0
 K FLD,VAQDATA
 QUIT
 ;
TRANEX ; -- Transaction exit
 D PAUSE^VALM1
 S VALMBCK="Q"
 QUIT
 ;
WORKLD ; -- Updates work load file
 S X=$$WORKDONE^VAQADS01("NEW",DFNTR,$G(DUZ))
 I +X<0  W !,"Error updating work loadfile (NEW)... "_$P(X,U,2)
 I $P($G(^VAT(394.61,DFNTR,0)),U,4)=0 QUIT
 S X=$$WORKDONE^VAQADS01("SNSTVE",DFNTR,$G(DUZ))
 I X<0 W !,"Error updating workload file (SNSTVE)... "_$P(X,U,2)
 QUIT
 ;
EXIT ; -- Note: The list processor cleans up its own variables.
 ;          All other variables cleaned up here.
 ;
 K ^TMP("VAQD1",$J),^TMP("VAQDIS",$J)
 K VAQADFL,VAQSTUB,VAQIGNC
 K VALMCNT,ROOT,SEGPTR,X,MSG,XTRCT,OFFSET,DSP
 Q
 ;
END ; -- End of code
 QUIT
