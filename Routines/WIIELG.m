WIIELG ;VISN20/WDE/WHN/WII - Expanded Eligibility LM screen ; 24-JUN-2008
 ;;1.0;Wounded Injured and Ill Warriors;**1**;06/26/2008;Build 28
 ; ListManager functionality designed through the List Manager Work Bench "^VALMWB" 
 ; ------------Variable list------------------
 ;  WIIENT   --  IEN of file entry
 ;  WIILN    --  LM line number
 ;  VADPT API "DEM^VADPT" and "7^VADPT" called to return demographic, eligibility and service information
 ;  FileMan API "$$GET1^DIQ()" called to return FileManager stored information 
 ;  local extrinsic function "$$LJ()" called to left justify text 
EN ; -- main entry point for WII ELIG REVIEW
 D EN^VALM("WII ELIG REVIEW")
 Q
HDR ; -- header code
 Q:'$D(DFN)
 D KVAR^VADPT,DEM^VADPT
 S VALMHDR(1)="  "
 S VALMHDR(2)=$$LJ(VADM(1),30)_"SSN: "_$$LJ($P(VADM(2),U,2),20)_"DOB: "_$P(VADM(3),U,2)
 D KVAR^VADPT
 Q
INIT ; -- init variables and list array  (expects WIIENT and DFN to be defined)
 Q:'$D(DFN)
 K ^TMP($J,"WIIELG")
 S WIILN=0
 D KVAR^VADPT,7^VADPT
 S WIILN=WIILN+1,^TMP($J,"WIIELG",WIILN,0)="              G&L DATE:  "_$$GET1^DIQ(405,WIIENT,.14)
 S WIILN=WIILN+1,^TMP($J,"WIIELG",WIILN,0)="     MAS MOVEMENT TYPE:  "_$$GET1^DIQ(405,WIIENT,.18)
 S WIILN=WIILN+1,^TMP($J,"WIIELG",WIILN,0)="    PRIMARY ELIGIBILTY:  "_$P(VAEL(1),U,2)
 S X=$O(VAEL(1,0)) I X S WIILN=WIILN+1,^TMP($J,"WIIELG",WIILN,0)="      OTHER ELIGIBILTY:  "_$P(VAEL(1,X),U,2)
 S WIILN=WIILN+1,^TMP($J,"WIIELG",WIILN,0)="     PERIOD OF SERVICE:  "_$P(VAEL(2),U,2)
 S WIILN=WIILN+1,^TMP($J,"WIIELG",WIILN,0)="         VETERAN (Y/N):  "_$S(VAEL(4)=1:"YES",1:"NO")
 S WIILN=WIILN+1,^TMP($J,"WIIELG",WIILN,0)="       TYPE OF PATIENT:  "_$P(VAEL(6),U,2)
 S WIILN=WIILN+1,^TMP($J,"WIIELG",WIILN,0)="     MEANS TEST STATUS:  "_$P(VAEL(9),U,2)
 S WIILN=WIILN+1,^TMP($J,"WIIELG",WIILN,0)="                      :  "
 I VASV(6) S WIILN=WIILN+1,^TMP($J,"WIIELG",WIILN,0)="        SERVICE BRANCH:  "_$P(VASV(6,1),U,2)
 I VASV(6) S WIILN=WIILN+1,^TMP($J,"WIIELG",WIILN,0)="    SERVICE ENTRY DATE:  "_$P(VASV(6,4),U,2)
 I VASV(6) S WIILN=WIILN+1,^TMP($J,"WIIELG",WIILN,0)="     SERVICE EXIT DATE:  "_$P(VASV(6,5),U,2)
 S VALMCNT=WIILN
 D KVAR^VADPT
 K WIIENT,WIILN
 Q
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
EXIT ; -- exit code
 Q
EXPND ; -- expand code
 Q
LJ(X,L) ; left justify function X=string L=length
 S X=X_"                      ",X=$E(X,1,L) Q X
 Q
ZAP ;CLEAN UP VAR
 K VASV,WIIENT,WIILN,VAEL,DFN,VADM,VAEL,VALMCNT,VALMHDR,VALMHDR,VASV
