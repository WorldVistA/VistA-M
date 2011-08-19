SPNCTSHO ;WDE/SD SHOW ANN AND CONT ;6/27/02  05:15
 ;;2.0;Spinal Cord Dysfunction;**19,20,21**;01/02/1997
 ;
 ; 
EN(SPNDFN) ;
 ;
 ;S SPNA=$P($G(^TMP($J,0)),U,2)
 ;I (SPNA=0)!(SPNA="") S SPNEXIT=1 Q  ;no care episodes on file
 D HDR
 D SHOW
 Q
SHOW ;       display records in ^tmp($j
 S (SPNOTOL,SPNFD0,SPNOTNE,SPNW,SPNX,SPNY,SPNZ,SPNIEN,SPNSEL,SPNEXIT,SPNSUB,SPNFD0)=0
 ;    spnw = number spnx = outcome type spny= date recorded
 S SPNOUT=0
 S SPNW=0 F  S SPNW=$O(^TMP($J,SPNW)) Q:SPNW=""   S SPNX=0 F OUT=1:1 S SPNX=$O(^TMP($J,SPNW,SPNX)) Q:SPNX=""  S SPNY=0 F  S SPNY=$O(^TMP($J,SPNW,SPNX,SPNY)) Q:(SPNY="")!('+SPNY)  D  I SPNEXIT=1 S OUT=99999 Q
 .Q:SPNOUT=1
 .S SPNFIEN=0 S SPNFIEN=$G(^TMP($J,SPNW,SPNX,SPNY))
 .W !,SPNW,") ",$$FMTE^XLFDT(SPNX,"5DZP")
 .I SPNCTYP=3 W ?15,$$GET1^DIQ(154.1,SPNFIEN_",",.02)
 .I SPNCTYP=4 W ?15,$$GET1^DIQ(154.1,SPNFIEN_",",.021),?38,$$GET1^DIQ(154.1,SPNFIEN_",",.02)
 .S SPNEDSS=$P($G(^SPNL(154.1,SPNFIEN,"MS")),U,9) I SPNEDSS'=""  W ?62,"EDSS: ",$P($G(^SPNL(154.2,SPNEDSS,0)),U,1)
 .S SPNSUB=SPNSUB+1,SPNLINE=SPNLINE+1
 .I SPNLINE>15 D SEL I SPNEXIT=0 I SPNFD0=0 D HDR
 .I +SPNFD0 Q
 .Q:SPNOUT=1
 Q:SPNOUT=1
 I '+SPNFD0 I SPNEXIT=0 D SEL
 Q
HDR ;
 I $D(IOF) W @IOF
 S OUT=0
 S SPNCTYP=$P($G(^TMP($J,0)),U,4)
 I $D(SPNHDR)=0 S SPNHDR=" Episodes of care"
 W !?20,SPNHDR
 S SPNSSN=$P($G(^DPT(SPNDFN,0)),U,9) S SPNSSN=$E(SPNSSN,1,3)_"-"_$E(SPNSSN,4,5)_"-"_$E(SPNSSN,6,9)
 W !!,"Patient: ",$P(^DPT(SPNDFN,0),U,1),"    SSN: ",SPNSSN
 W !,"--------------------------------------------------------------------------"
 S SPNLINE=3
 Q
SEL ;prompt for a selection from the list
 Q:SPNOUT=1
 S (SPNSEL,SPNEXIT,Y)=0,SPNTOT=$P($G(^TMP($J,0)),U,1)
 W !,"--------------------------------------------------------------------------"
 I SPNSUB=0 W !?2,"There are no ",SPNHDR," Outcomes on file.",!?2,"(An ASIA should be entered first if you add outcomes.)"
 I SPNSUB>0 W !?2,"Select 1-",SPNSUB," of ",SPNTOT," to view/edit an outcome, '^' to exit, or " I SPNSUB'=SPNTOT W "press"
 I SPNSUB>0 I SPNSUB'=SPNTOT W !?2,"<Return> to see the next group"
 W !?2,"<A> to Add a new outcome"
PICK R !?5,"Selection: ",SPNSEL:DTIME
 I SPNSEL["?" W !?2,"Enter a number within the range allowed, or one of the designated keys." G PICK
 I SPNSEL=0 W !,$C(7),?10,"Selected number is outside the range." G PICK
 I "Aa^"'[SPNSEL,(SPNSEL'?1.5N) W !,$C(7) G PICK
 I SPNSEL="a" S SPNSEL="A"
 I SPNSEL="A" S SPNEXIT=1 S SPNOUT=1 Q
 I SPNSEL="^" S SPNEXIT=1 S SPNOUT=1 Q
 I (SPNSEL>$P($G(^TMP($J,0)),U,1))!(SPNSEL>SPNSUB) W !,$C(7),?10,"Selected number is outside the range." G PICK
 I SPNSEL="" I SPNSUB=SPNTOT S SPNEXIT=1 Q
 I SPNEXIT=0  I +SPNSEL I $D(^TMP($J,SPNSEL))  D
 .S (SPNB,SPNX)=""
 .S SPNB=$O(^TMP($J,SPNSEL,SPNB))
 .S SPNX=$O(^TMP($J,SPNSEL,SPNB,SPNX))
 .S SPNFD0=$P($G(^TMP($J,SPNSEL,SPNB,SPNX)),U,1)
 .I SPNFD0="" S SPNFD0="" S SPNEXIT=1 Q
 .S SPNFTYPE=$P($G(^SPNL(154.1,SPNFD0,0)),U,2)
 .I SPNFTYPE="" S SPNEXIT=1 Q
 .S SPNOUT=1 S OUT=99999 Q
 I SPNEXIT=1 S SPNOUT=1
 Q
