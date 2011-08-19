SPNCTPAA ;WDE/SD PROMPTS FOR PAST EPISODE ;6/28/02  05:15
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/1997
 ;
 ; 
EN(SPNCT,SPNDFN) ;
 ;   spnw is the care start date
 ;build utility with all care dates
 K ^UTILITY($J),TMP($J)
 S SPNRTN="SPNCTPAA"
 D EN^SPNCTBLD(SPNCT,SPNDFN)
 S (SPNW,SPNCDT,SPNCNT)=0
 S SPNA=0 F  S SPNA=$O(^UTILITY($J,SPNCT,SPNA)) Q:SPNA=""  D
 .S SPNB=0 S SPNB=$O(^UTILITY($J,SPNCT,SPNA,SPNB)) Q:SPNB=""
 .S SPNC=0 S SPNC=$O(^UTILITY($J,SPNCT,SPNA,SPNB,SPNC)) Q:SPNC=""
 .I $P($G(^SPNL(154.1,SPNC,8)),U,2)="" Q  ;close date BLOCKS THE LAST FROM SHOWING
 .S SPNCNT=SPNCNT+1
 .I $P($G(^SPNL(154.1,SPNC,8)),U,2)'="" S ^TMP($J,SPNCNT)=SPNA_U_SPNC_U_$P(^SPNL(154.1,SPNC,8),U,2)
 .S ^TMP($J,0)=SPNCNT_"^^^"_SPNCT  ;number of episodes
 .Q
 I $D(^TMP($J))=0 D NONE D ZAP^SPNCTINA S SPNEXIT=1 G:SPNCT=1 RESTART^SPNCTINA G:SPNCT=2 RESTART^SPNCTOUA Q
 S SPNEXIT=0
 D DISP
RESTART ;
 D PAST^SPNCTCUR(SPNCT,SPNCDT)  ;spnct = care type  spncdt = episode date
 ;above call builds tmp with the outcomes
 I SPNCT=1 S SPNHDR="Previous INPATIENT Episode of Care"
 I SPNCT=2 S SPNHDR="Previous OUTPATIENT Episode of Care"
 D EN^SPNCTSHW(SPNDFN)
 I $D(SPNSEL) I SPNSEL="A" D:SPNCT=1 ADD^SPNCTINA D:SPNCT=2 ADD^SPNCTOUA I SPNEXIT'=1 I $D(SPNFD0) I $D(SPNFTYPE) D EDIT^SPNFEDT0
 I SPNEXIT=1 D ZAP^SPNCTINA G:SPNCT=1 RESTART^SPNCTINA G:SPNCT=2 RESTART^SPNCTOUA Q
 ;
 I $D(SPNSEL) I +SPNSEL D
 .S (SPNA,SPNFD0)=0
 .S SPNA=$O(^TMP($J,SPNSEL,SPNA))
 .S SPNFD0=$O(^TMP($J,SPNSEL,SPNA,SPNFD0))
 .S SPNFTYPE=$P(^SPNL(154.1,SPNFD0,0),U,2) D EDIT^SPNFEDT0
 .K SPNA,SPNB
 .Q
 D ZAP^SPNCTINA
 D EN^SPNCTBLD(SPNCT,SPNDFN)
 S SPNRTN="SPNCTPAA"
 G RESTART
 Q
 ;
DISP ;display the episode dates and prompt for one
 S SPNLINE=0,SPNEXIT=0
 D HDR
 S SPNA=0 F  S SPNA=$O(^TMP($J,SPNA)) Q:SPNA=""  D
 .I SPNEXIT=1 D ZAP Q
 .
 .W !,SPNA,") ",$$FMTE^XLFDT($P($G(^TMP($J,SPNA)),U,1),"5DZP")
 .W ?16,$$FMTE^XLFDT($P($G(^TMP($J,SPNA)),U,3),"5DZP")
 .S SPNLINE=SPNLINE+1
 .S SPNCNT=SPNA
 .I SPNLINE>9 D SEL I SPNEXIT=0 D HDR
 .I SPNEXIT=1 D ZAP Q
 .Q
 I SPNEXIT'=1 D SEL
 Q
HDR ;
 I SPNA=$P($G(^TMP($J,0)),U,1) S SPNEXIT=1 Q
 I $D(IOF) W @IOF
 W !?20,SPNHDR
 S SPNSSN=$P($G(^DPT(SPNDFN,0)),U,9) S SPNSSN=$E(SPNSSN,1,3)_"-"_$E(SPNSSN,4,5)_"-"_$E(SPNSSN,6,9)
 W !!,"Patient: ",$P(^DPT(SPNDFN,0),U,1),"    SSN: ",SPNSSN
 W !!," Date Opened",?16,"Date Closed"
 W !,"---------------------------------------------------------------------------"
 S SPNLINE=4
 Q
SEL ;
 W !,"---------------------------------------------------------------------------"
 W !?2,"Select 1-",SPNCNT," of ",$P(^TMP($J,0),U,1)," to view/edit an episode of care, '^' to exit"
 I SPNCNT'=$P(^TMP($J,0),U,1) W ", or" W !?2,"press Return to see the next group"
PICK R !?5,"Selection: ",SPNSEL:DTIME
 I SPNSEL["?" W !?2,"Enter a number within the range allowed." G PICK
 I SPNSEL=0 W !,$C(7),?10,"Selected number is outside the range." G PICK
 I U'[SPNSEL,(SPNSEL'?1.5N) W !,$C(7) G PICK
 I SPNSEL="" Q
 I SPNSEL="^" S SPNEXIT=1 Q
 I $D(^TMP($J,SPNSEL)) D
 .S SPNEXIT=1
 .S SPNCDT=$P($G(^TMP($J,SPNSEL)),U,1)
 .Q
 I $G(^TMP($J,SPNSEL))="" W !,$C(7),?10,"Selected number is outside the range." G PICK
 Q
ZAP ;
 Q
NONE ;No episodes on file for this patient
 I $D(IOF) W @IOF
 W !?20,$S(SPNCT=1:"Previous INPATIENT Episode(s) of Care",SPNCT=2:"Previous OUTPATIENT Episode(s) of Care",SPNCT=3:"ANNUAL EVALUATIONS",SPNCT=4:"CONTINUUM OF CARE",1:"UNKNOWN")
 S SPNSSN=$P($G(^DPT(SPNDFN,0)),U,9) S SPNSSN=$E(SPNSSN,1,3)_"-"_$E(SPNSSN,4,5)_"-"_$E(SPNSSN,6,9)
 W !!,"Patient: ",$P(^DPT(SPNDFN,0),U,1),"    SSN: ",SPNSSN
 W !,"------------------------------------------------------------------------"
 W !!?5,"There are no Previous episodes for this patient"
 R !!?10,"Press Return to continue...",SPNX:DTIME
 Q
