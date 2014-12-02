PSJCLOR1 ;BIR/JCH - SHOW NON-VERFIED CLINIC ORDERS GATHERED IN PSJCLOR1 ; 2/28/12 9:11am
 ;;5.0;INPATIENT MEDICATIONS;**275**;DEC 16, 1997;Build 157
 ;
 ; Reference to ^PSSLOCK is supported by DBIA #2789
 ; Reference to ^DIR is supported by DBIA 10026
 ; Reference to ^VALM is supported by DBIA 10118
 ;
START ;
 N PSJHLIN S PSGOEA=$G(PSGOEA),$P(PSJHLIN,"-",81)="" S PSGPXN=$G(PSGPXN)
 K ^TMP("PSJLIST",$J) D:PSGSS'="P" DISPLAYW Q:'$O(^TMP("PSJSELECT",$J,0))
PROCESS ; Loop through selected patients and display profile/orders.
 N PSJCNT K DIR,PSJPNV S PSJPNV=1
 F PSJCNT=0:0 S PSJCNT=$O(^TMP("PSJSELECT",$J,PSJCNT)) Q:'PSJCNT  D PROCESS1 S PSGOP=PSGP D ENQL^PSGLW:$P(PSJSYSL,"^",2)]"" Q:$G(PSJGOTO)="E"  I $D(^TMP("PSJSELECT",$J,+$G(PSJGOTO))) S PSJCNT=PSJGOTO-1
 D DONE
 Q
PROCESS1 ; Process patient
 N PSJTMPN,PSJCURCL,PSJCLN,PSJPAD,PSJPAGE,PSJPDD,PSJPDOB,PSJPDX,PSJPHT,PSJPHTD,PSJPRB,PSJPSEX,PSJPSSN,PSJPTD,PSJPWDN,PSJPWT,PSJPWTD,RMORDAT
 S PSJCURCL=$G(^TMP("PSJSELECT",$J,"C",$G(PSJCNT)))
 S PSJPN=$G(^TMP("PSJSELECT",$J,PSJCNT)),PSJTMPN=PSJPN K PSJGOTO
 S PSJLK=$$L^PSSLOCK($P(PSJPN,U,2),1) I 'PSJLK W !,$C(7),$P(PSJLK,U,2) D CONT^PSJOE0 Q
 I $G(PSJTMPED),$P(PSJTMPED,"^",2) S PSJEND=$S($P(PSJTMPED,"^",2)'=$P(PSJPN,"^",2):+PSJTMPED,1:+PSJEND)
 I $G(PSJTMPBG),$P(PSJTMPBG,"^",2) S PSJBEG=$S($P(PSJTMPBG,"^",2)'=$P(PSJPN,"^",2):+PSJTMPBG,1:+PSJBEG)
 K PSJGOTO D:PSJPN]"" GTORDERS
 I PSJLK D UL^PSSLOCK($P(PSJTMPN,U,2))
 S PSGPXN=$G(PSGPXN)
 Q
DISPLAYW ; Allow selection of patients on each ward selected.
 K ^TMP("PSJSELECT",$J) S PSJCNT=1,PSGWORP1="" F  S PSGWORP1=$O(^TMP("PSGVBW",$J,PSGWORP1)) Q:PSGWORP1=""  D DISPLAYP
 K PSJASK
 Q
DISPLAYP ; Display WORP1 (Ward or Priority)
 N PSGPICK
 S PSGVBWN=PSGWORP1
 D HEADER
 S PSGWORP2="" F  S PSGWORP2=$O(^TMP("PSGVBW",$J,PSGWORP1,PSGWORP2)) Q:PSGWORP2=""  S PSGPRIN=PSGWORP2 D DISPLAYT
 I $G(PSJASK),(PSGVBY>0) D ASK
 Q
DISPLAYT ;
 ;NEW PSGPICK  ;PSGPICK=1-->user selected order, stop display the profile
 S PSGPRIN=PSGWORP2
 S:$G(PSGPRIF) PSGVBWN=PSGWORP2,PSGPRIN=PSGWORP1
 S PSGVBTM="" F  S PSGVBTM=$O(^TMP("PSGVBW",$J,PSGWORP1,PSGWORP2,PSGVBTM))  Q:(PSGVBTM=""!$G(PSGPICK))  D V2
 I $G(PSJPRIF),$G(PSJASK),(PSGVBY>0) D ASK
 Q
GTORDERS ;
 S (PSGP,DFN)=$P(PSJPN,U,2),PSGOL="S" K PSJACNWP D ^PSJAC
 S:$G(PSJTMPBG) PSJBEG=PSJTMPBG S:$G(PSJTMPED) PSJEND=PSJTMPED K PSJTMPBG,PSJTMPED
 D PROFILE Q
 Q
PROFILE ; Display the patient's profile and allow order selection.
 S PSGP=DFN,PSJOL=PSGOL F  Q:$G(PSJVALQ)  D EN^VALM("PSJ LM CLINIC ORDERS") Q:'$G(PSJORD)&'$G(PSJNEWOE)!$G(PSJVALQ)  S PSJNEWOE=0
 S PSJVALQ=0
 Q
DONE ; Clean up
 K PSGOP,PSJLK,PSJNEWOE,PSJPN,VALMBCK,PSGP
 Q
V2 ;
 S PSGVBPN="" F  S PSGVBPN=$O(^TMP("PSGVBW",$J,PSGWORP1,PSGWORP2,PSGVBTM,PSGVBPN)) Q:(PSGVBPN=""!$G(PSGPICK))  S PSGP=$P(PSGVBPN,"^",2),PPN=$P(PSGVBPN,"^") S:PPN="" PPN=PSGP_";DPT(" D WRT
 Q
WRT ;
 S PSGVBY=PSGVBY+1,PSJASK=1
 S PSGVBWN=PSGWORP1,PSGPRD=PSGWORP2
 W !,$J(PSGVBY,4),?8,PPN," (",$P(PSGVBPN,U,3),")" S ^TMP("PSJLIST",$J,PSGVBY)=PSGVBWN_U_PSGVBTM_U_PPN_U_PSGP
 I $Y+1>IOSL,(PSGVBY>0) NEW DIR S DIR(0)="EA",DIR("A")=" '^' TO QUIT " D ^DIR D
 . I X="^" S PSGPICK=1  Q
 . S PSJASK=0 W @IOF
 Q
ASK ;
 N DIR,PSGDFN,PSGASKX S DIR(0)="LOA^1:"_PSGVBY,DIR("A")="Select 1 - "_PSGVBY_": " D ^DIR I $D(DUOUT)!$D(DTOUT) K ^TMP("PSGVBW",$J) Q
 S:Y]"" PSGPICK=1
 F PSJINDEX=1:1:$L(Y,",")-1 D
 . S PSGASKX=$G(^TMP("PSJLIST",$J,$P(Y,",",PSJINDEX))),PSGDFN=$P(PSGASKX,"^",4)_"^"_$P(PSGASKX,"^",3)
 . D CHK^PSJDPT(.PSGDFN,1) I PSGDFN=-1 Q
 . S:PSGASKX]"" ^TMP("PSJSELECT",$J,PSJCNT)=$P(PSGASKX,U,3,4),^TMP("PSJSELECT",$J,"B",$P(PSGASKX,U,3),PSJCNT)="",^TMP("PSJSELECT",$J,"C",PSJCNT)=$G(^TMP("PSGVBW3",$J,$P(PSGASKX,U),PSGP)),PSJCNT=PSJCNT+1
 K PSJINDEX,Y
 Q
H2 ;
 W !!?2,"Select patients either singularly separated by commas (1,2,3), by a range of",!,"patients separated by a dash (1-3), or a combination (1,2,4-6).  To select all",!,"patients, enter 'ALL' or a dash ('-').  You can also enter '-n' to"
 W " select the",!,"first patient through the 'nth' patient or enter 'n-' to select the 'nth'",!,"patient through the last patient.  If a patient is selected more than once,"
 W !,"only the first selection is used.  (Entering '1,2,1' would return '1,2'.)" Q
 ;
HEADER ;
 W:$Y @IOF W !,"CLINIC ORDERS - "
 I $G(PSGPRIF) W $S($G(PRD)=1:"STAT",$G(PRD)=2:"ASAP",1:"ROUTINE")
 I '$G(PSGPRIF) W $S(PSGVBWN="ZZ":"^OTHER",1:PSGVBWN)
 W !!," No.",?8,"PATIENT",!,PSJHLIN K PSGVBY S PSGVBY=0 Q
 Q
NP ;
 W $C(7) R !!,"ENTER AN '^' TO SELECT ORDERS NOW, OR PRESS THE RETURN KEY TO CONTINUE. ",NP:DTIME E  S NP="^"
 Q
DISPORD(DFN,ON)     ;Display the order that being lock by another user
 NEW PSJLINE,PSJOC,X
 S PSJLINE=1
 D DSPLORDU^PSJLMUT1(DFN,ON)
 W ! F X=0:0 S X=$O(PSJOC(ON,X)) Q:'X  W !,PSJOC(ON,X)
 Q
HELP ;
 D FULL^VALM1
 W !!,"ES  Edit Start Date"
 W !,"     Select the medication orders you wish to edit. "
 W !,"     After selecting orders, a new Start Date/Time may be entered."
 W !
 W !,"VD  View Order Detail"
 W !,"    Select the medication orders you wish to view. "
 W !,"    Details for selected orders will be displayed."
 W !
 W !,"VP  View Profile"
 W !,"    View order profile that shows all medication orders."
 W !,"    No edits allowed at this view. "
 W !
 W !,"CD  Change Date Range"
 W !,"    Change the search date range for the current patient's"
 W !,"    Clinic Orders. The search date range will revert to the"
 W !,"    initial search date range for subsequent patients. ",!
 D CONT^PSJOE0 S VALMBCK="R"
 Q
IMPATPR ; View Profile Entry
 D ^PSJHVARS N VAIN,VADM,PSJLM D FULL^VALM1,ENOR^PSJCLOR4(PSGP) D RESTORE^PSJHVARS S VALMBCK="R"
 Q
PSJREVFY() ; Ask if Active orders should be re-verified
 D FULL^VALM1 W !
 K Y,DIR S Y=0 S DIR("A",1)=""
 S DIR("A",2)="     ATTENTION: One or more selected orders have an ACTIVE status.  "
 S DIR("A",3)=" You may choose to have ACTIVE orders remain ACTIVE after editing, or "
 S DIR("A",4)=" you may choose to have the status of ACTIVE orders changed to NON-VERIFIED."
 S DIR("A",5)=" "
 S DIR("?")="^D VFYHELP^PSJCLOR1",DIR(0)="Y",DIR("A")="Should ACTIVE orders remain ACTIVE after editing" D ^DIR W !!
 I 'Y,'$G(DUOUT) W !,"  All selected orders will have a status of NON-VERIFIED after editing",!
 Q +Y
VFYHELP ; Help text for auto-reverify
 W !?5,"Yes  - ACTIVE orders will remain ACTIVE after they are modified.",!
 W !?5,"No - The status of ACTIVE orders will be changed to NON-VERIFIED"
 W !?5,"after they are modified. The orders must be re-verified, via"
 W !?5,"Inpatient Order Entry or other order entry options, in order"
 W !?5,"to change the status back to ACTIVE."
 Q
SURE() ; Non-Pharmacist can't auto-reverify
 D FULL^VALM1 W !
 K Y,DIR S Y=0
 S DIR("A",1)="     ATTENTION: One or more selected orders have an ACTIVE status.  "
 S DIR("A",2)=" If you continue, the status of ACTIVE orders will be changed to NON-VERIFIED."
 S DIR("A",3)=" "
 S DIR("?")="^D SUREHELP^PSJCLOR1",DIR(0)="Y",DIR("A")="Continue editing selected orders" D ^DIR W !
 I Y>0,'$G(DUOUT) W !,"  All selected orders will have a status of NON-VERIFIED after editing",!
 Q $S(Y>0:0,1:-1)
SUREHELP ; Help text for non-pharmacists
 W !?5,"The status of ACTIVE orders will be changed to NON-VERIFIED"
 W !?5,"after they are modified. The orders must be re-verified, via"
 W !?5,"Inpatient Order Entry or other order entry options, in order"
 W !?5,"to change the status back to ACTIVE."
 Q
HDR ; HEADER code for PSJ LM ECO protocol
 D A^PSJ200(21,19),SHOW^VALM
 S XQORM("#")=+$O(^ORD(101,"B","PSJ LM VIEW ORDER DETAIL",0))_"^1:"_+$G(^TMP("PSJPRO",$J,0))
 Q
