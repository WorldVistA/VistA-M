SPNCTSHW ;WDE/SD SHOW OUTCOMES ;6/27/02  05:15
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/1997
 ;
 ; 
EN(SPNDFN) ;
 ;
 S SPNA=$P($G(^TMP($J,0)),U,2)
 I (SPNA=0)!(SPNA="") S SPNEXIT=1 Q  ;no care episodes on file
 D HDR
 D SHOW
 Q
SHOW ;       display records in ^tmp($j
 S (SPNOTOL,SPNFD0,SPNOTNE,SPNW,SPNX,SPNY,SPNZ,SPNIEN,SPNSEL,SPNEXIT,SPNSUB,SPNFD0)=0
 ;    spnw = number spnx = outcome type spny= date recorded
 S SPNOUT=0
 S SPNW=0 F  S SPNW=$O(^TMP($J,SPNW)) Q:SPNW=""   S SPNX=0 F OUT=1:1 S SPNX=$O(^TMP($J,SPNW,SPNX)) Q:SPNX=""  S SPNY=0 F  S SPNY=$O(^TMP($J,SPNW,SPNX,SPNY)) Q:(SPNY="")!('+SPNY)  D  I SPNEXIT=1 S SPNZOUT=99999 Q
 .Q:SPNOUT=1
 .S SPNFIEN=0 S SPNFIEN=$G(^TMP($J,SPNW,SPNX,SPNY))
 .W !,SPNW,") ",$$FMTE^XLFDT(SPNX,"5DZP")
 .W ?15,$$GET1^DIQ(154.1,SPNFIEN_",",.021)
 .W ?38,$$GET1^DIQ(154.1,SPNFIEN_",",.02)
 .S SPNEDSS=$P($G(^SPNL(154.1,SPNFIEN,"MS")),U,9) I SPNEDSS'=""  W ?62,"EDSS: ",$P($G(^SPNL(154.2,SPNEDSS,0)),U,1)
 .S SPNSUB=SPNSUB+1,SPNLINE=SPNLINE+1
 .I SPNLINE>14 D SEL I SPNEXIT=0 I SPNFD0=0 D HDR
 .I +SPNFD0 Q
 .Q:SPNOUT=1
 Q:SPNOUT=1
 I '+SPNFD0 I SPNEXIT=0 D SEL
 Q
HDR ;
 I $D(IOF) W @IOF
 S SPNZOUT=0
 S SPNCTYP=$P($G(^TMP($J,0)),U,4)
 I $D(SPNHDR)=0 S SPNHDR=" Episodes of care"
 W !?20,SPNHDR
 S SPNSSN=$P($G(^DPT(SPNDFN,0)),U,9) S SPNSSN=$E(SPNSSN,1,3)_"-"_$E(SPNSSN,4,5)_"-"_$E(SPNSSN,6,9)
 W !!,"Patient: ",$P(^DPT(SPNDFN,0),U,1),"    SSN: ",SPNSSN
 S SPNCDT=$P($G(^TMP($J,0)),U,2)
 S SPNCEDT=$P($G(^TMP($J,0)),U,3)
 I SPNCDT'="" D
 .W !?5,"Care Start Date: ",$$FMTE^XLFDT(SPNCDT,"5DZP")
 .I SPNCEDT'="" W "      End Date: ",$$FMTE^XLFDT(SPNCEDT,"5DZP")
 W !,"--------------------------------------------------------------------------"
 S SPNLINE=3
 Q
SEL ;prompt for a selection from the list
 Q:SPNOUT=1
 S (SPNSEL,SPNEXIT,Y)=0,SPNTOT=$P($G(^TMP($J,0)),U,1)
 W !,"--------------------------------------------------------------------------"
 W !?2,"Select 1-",SPNSUB," of ",SPNTOT," to view/edit an outcome, '^' to exit, or " I SPNSUB'=SPNTOT W "press"
 I SPNSUB'=SPNTOT W !?2,"<Return> to see the next group"
 W !?2,"<A> to Add a new outcome"
 I SPNCTYP<3 I $G(SPNRTN)'="SPNCTPAA" W !?2,"<P> to view/edit a Previous episode of care"
 I SPNCTYP<3 I $G(SPNRTN)'="SPNCTPAA" I $P($G(^TMP($J,0)),U,3)'="" W !?2,"<C> to Create a new episode of care"
PICK R !?5,"Selection: ",SPNSEL:DTIME
 I SPNSEL["?" W !?2,"Enter a number within the range allowed, or one of the designated keys." G PICK
 I SPNSEL=0 W !,$C(7),?10,"Selected number is outside the range." G PICK
 I $S($P($G(^TMP($J,0)),U,3)'="":"AaPpCc^"'[SPNSEL&(SPNSEL'?1.5N),1:"AaPp^"'[SPNSEL&(SPNSEL'?1.5N)) W !,$C(7) G PICK
 I SPNHDR["Previous"&("Aa0^"'[SPNSEL&(SPNSEL'?1.5N)) W !,$C(7) G PICK
 I SPNCTYP<3 I SPNSEL="p" S SPNSEL="P"
 I SPNCTYP<3 I SPNSEL="P" S SPNEXIT=1 S SPNOUT=1 Q
 I SPNCTYP<3 I SPNSEL="c" S SPNSEL="C"
 I SPNCTYP<3 I SPNSEL="C" S SPNEXIT=1 S SPNOUT=1 Q
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
 .S SPNOUT=1 S SPNZOUT=99999 Q
 I SPNEXIT=1 S SPNOUT=1
 Q
