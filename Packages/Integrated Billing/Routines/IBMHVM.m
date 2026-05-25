IBMHVM ;EDE/YMG - Mental Health Visit Maintenance; 07/06/2023
 ;;2.0;INTEGRATED BILLING;**784,779**;21-MAR-94;Build 7
 ;; Per VHA Directive 6402, this routine should not be modified
 ;
 ; This routine is used to perform the Mental Health Visit Tracking
 ; database Maintenance.
 ;
 Q
 ;
EN ; entry point
 N DIC,X,Y,DFN,DTOUT,DUOUT,DIRUT,DIROUT,%,DIR,IBYR,IBLCT,IBAE,IBQUIT
 ;
 S IBQUIT=0
LOOP K DIC,X,Y,DFN,IBLTCX,VADP,IBLCT
 K ^TMP($J,"IBMHVM")
 ;
 ;Ask for the patient
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC="^DPT(",DIC(0)="AEMNQ" W ! D ^DIC G:Y<1 EX
 S DFN=+Y D DEM^VADPT
 ;
 S IBYR=$$ASKDT("Enter Year")
 G:IBYR=-1 LOOP
 ;
MLOOP ; Entry/Loop tag to allow user to stay with the defined maintenance utility.
 ;
 S IBLCT=$$PRTVSTS(DFN,IBYR)
 ;Ask user to Add or Edit Visit
 W !!
 S IBAE=$$GETMAINT
 I IBAE=-1 G LOOP
 ;
 I IBAE="A" D ADDVST(DFN)
 I IBAE="E" D EDITVST(IBLCT)
 ;
 D PAUSE(1)
 ;
 I IBQUIT=1 G LOOP
 ; Clear temp global after work on the veteran is done.
 K ^TMP($J,"IBMHVM")
 G MLOOP
 ;
EX ;
 D KVAR^VADPT
 ;
 Q
 ;
ASKDT(IBPRMT) ;Date input
 N DIR,Y,X,DIROUT,DIRUT
 I $G(IBPRMT)'="" S DIR("A")=IBPRMT
 S DIR("B")=2023
 S DIR(0)="F^4:4^K:X'?4N X"
 D ^DIR I $D(DIRUT)!$D(DIROUT) Q -1
 W " ",Y
 Q Y
 ;
PRTVSTS(IBDFN,IBYR) ; Get the list of visits for the calendar year
 ;
 N IBZ,IBV,IBC,IBI,IBN,IBD,IBSTAT,IBDT,IBLDT,IBLDT1,IBPT,IBQUIT,IBVYR
 ;
 S IBC=0 ; Counter of Visits
 ; Collect the list of visits
 S IBI=0 F  S IBI=$O(^IBMH(351.83,"B",IBDFN,IBI)) Q:'IBI  D
 .S IBD=$G(^IBMH(351.83,IBI,0)) Q:'IBD
 .S IBSTAT=$P(IBD,U,4)
 .S IBDT=$P(IBD,U,3)
 .S IBVYR=$E(IBDT,1,3)+1700    ; Convert visit date to calendar year
 .I IBYR'=IBVYR Q
 .S IBC=IBC+1
 .S ^TMP($J,"IBMHVM","IBA",IBC)=IBDT,^TMP($J,"IBMHVM","IBA","D",IBDT,IBC)=IBI_U_IBD
 .Q
 ;
 ;Reorganize in date order for display
 S (IBLDT,IBLCT)=0 F  S IBLDT=$O(^TMP($J,"IBMHVM","IBA","D",IBLDT)) Q:'IBLDT  D
 .S IBLDT1=0 F  S IBLDT1=$O(^TMP($J,"IBMHVM","IBA","D",IBLDT,IBLDT1)) Q:'IBLDT1  D
 ..S IBLCT=IBLCT+1
 ..S ^TMP($J,"IBMHVM","IBP",IBLCT)=$G(^TMP($J,"IBMHVM","IBA","D",IBLDT,IBLDT1))
 ..Q
 ;
 W @IOF
 S IBPT=$$PT^IBEFUNC(IBDFN)
 W !,"Mental Health Visits in "_IBYR_" for "_$P(IBPT,U),!
 D LINE("=",80)
 I 'IBC W "No Mental Health Visits during this calendar year." Q 0
 S IBV=IBLCT\3 I IBC#3 S IBV=IBV+1
 F IBI=1:1:IBV D  Q:$G(IBQUIT)
 .D:$D(IBQUIT) CHKPAUSE
 .S IBN=IBI
 .S IBD=$G(^TMP($J,"IBMHVM","IBP",IBN))
 .W !?5,$J(IBN,2),?10,$$FMTE^XLFDT($P(IBD,U,4))_" "_$S($P(IBD,U,5)=1:"F",$P(IBD,U,5)=3:"R",$P(IBD,U,5)=4:"V",1:"")
 .S IBN=IBI+IBV S IBD=$G(^TMP($J,"IBMHVM","IBP",IBN)) I IBD'="" W ?30,$J(IBN,2),?35,$$FMTE^XLFDT($P(IBD,U,4))_" "_$S($P(IBD,U,5)=1:"F",$P(IBD,U,5)=3:"R",$P(IBD,U,5)=4:"V",1:"")
 .S IBN=IBI+(2*IBV) S IBD=$G(^TMP($J,"IBMHVM","IBP",IBN)) I IBD'="" W ?55,$J(IBN,2),?60,$$FMTE^XLFDT($P(IBD,U,4))_" "_$S($P(IBD,U,5)=1:"F",$P(IBD,U,5)=3:"R",$P(IBD,U,5)=4:"V",1:"")
 .Q
 Q IBLCT
 ;
PAUSE(IBEND) Q:'$$SCR()  ;Screen only
 N IBJ,DIR,DIRUT,DTOUT,DUOUT,DIROUT,Y,IOSL2
 S IBQUIT=0
 Q:$E(IOST,1,2)'["C-"
 S IOSL2=$S(IOSL>24:24,1:IOSL)
 F IBJ=$Y:1:(IOSL2-4) W !
 I $G(IBEND) S DIR("A")="Enter RETURN to continue or '^' to exit."
 S DIR(0)="E"
 D ^DIR
 K DIR
 I $G(DUOUT) S IBQUIT=1
 I $G(IBEND) W @IOF
 Q
 ;
CHKPAUSE ;Check pause
 I $Y>(IOSL-5) D PAUSE Q:IBQUIT  W @IOF D LINE("-",80) W !
 Q
 ;
SCR() Q $E(IOST,1,2)="C-" ; Screen
 ;
 ; Draw a line, of characters IBC, length IBN
LINE(IBC,IBN) N IBL
 I $L($G(IBC))'=1 S IBC="="
 I +$G(IBN)=0 S IBN=80
 S $P(IBL,IBC,IBN+1)=""
 W IBL
 Q
 ;
 ; Fotmatting row labels
FRM(IBLBL,IBCUT) ;
 I $G(IBCUT,1) S IBLBL=$E(IBLBL,1,26)
 Q "  "_IBLBL_": "  ;;;$J("",26-$L(IBLBL))_":  "
 ;
 ;Ask the user for the type of work to do
GETMAINT() ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 ; Prompt Summary or Detail version
 S DIR("A")="(A)dd a Mental Health Visit, (E)dit an existing Visit, or (Q)uit: "
 S DIR(0)="SA^A:ADD;E:Edit;Q:Quit"
 S DIR("?")="Select whether to Add a new Mental Health visit, Edit an Existing visit, or Quit."
 ;
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!($G(Y)="")  Q -1
 I Y="Q" Q -1
 Q Y
 ;
ADDVST(IBDFN) ; Add a new MH visit for the patient
 N IBVST,IBIEN,IBSTAT,IBCOMM,IBSITE,IBDUPFLG,IBOVRFLG,IBIND
 ;
 S (IBIEN,IBVST,IBSTAT,IBCOMM)="",IBDUPFLG=0
 D SITE^IBAUTL   ; retrieve the Billing Site value from the IB Site Parameter File.  Store in IBSITE
 S IBVST=$$GETVST() Q:IBVST=-1
 I $D(^TMP($J,"IBMHVM","IBA","D",IBVST)) S IBDUPFLG=1
 S IBIND=$$INDCHK^IBINUT1(IBVST,DFN)
 S IBSTAT=$$GETSTAT(DFN,IBVST,IBIND,.IBOVRFLG) Q:IBSTAT=-1
 I IBSTAT=2 S IBIEN=$$GETBILL(DFN,IBVST) I 'IBIEN W !,"No Cleland-Dole eligible charge was found for this date." Q
 S:IBSTAT'=2 IBCOMM=$$GETCOMM(IBSTAT,IBOVRFLG)
 Q:IBCOMM=-1
 S IBOK=$$GETOK^IBECEA36(IBDUPFLG) Q:IBOK'=1
 D ADDVST^IBECEAMH(IBDFN,IBVST,IBIEN,IBSTAT,IBCOMM,IBSITE)
 Q
 ;
EDITVST(IBLCT) ; Edit an existing MH visit for the patient
 N IBSTAT,IBVISIT,IBIEN,IBD,IBSITECD,IBSITENM,IBVSITE,IBVST,IBVSTIEN,IBOK,IBOVRFLG,IBIND,IBCOMM,IBUID
 ; Ask user for visit to edit
 S (IBSTAT,IBVSITE,IBOVRFLG)=""
 S IBVISIT=$$GETVISIT(IBLCT)
 Q:IBVISIT=-1
 ; Get the visit info
 S IBD=$G(^TMP($J,"IBMHVM","IBP",IBVISIT)) Q:IBD=""
 S IBVSTIEN=$P(IBD,U),IBVST=$P(IBD,U,4),IBIEN=$P(IBD,U,9)
 ;IB*2.0*801 - Prevent edits on visits from other sites
 ;
 ;Check to see if visit info is from another site, if so, warn the user and quit.
 S IBUID=$P($G(^IBMH(351.83,IBVSTIEN,0)),U,7)
 I IBUID["_" D  Q -1
 . W !!,"Unable to edit this visit.  The visit data is from another VAMC."
 . W !,"Please select another visit to edit."
 ;END IB 801
 ; Get the Site name and code
 I $P(IBD,U,3)'="" D
 .S IBSITECD=$$GET1^DIQ(4,$P(IBD,U,3)_",",99,"I")
 .S IBSITENM=$$GET1^DIQ(4,$P(IBD,U,3)_",",.01,"E")
 .S IBVSITE=$E(IBSITECD_"-"_IBSITENM,1,20)
 .Q
 ; display the visit info
 W !!,"Date of Visit",?16,"Station",?39,"Status",?51,"Bill No.",?64,"Reason"
 W !,"-------------",?16,"-------",?39,"------",?51,"--------",?64,"------"
 W !,$$FMTE^XLFDT($P(IBD,U,4)),?16,IBVSITE,?39,$$GET1^DIQ(351.83,IBVSTIEN,.04)
 I $P(IBD,U,6)'="" W ?51,$P(IBD,U,6)
 I $P(IBD,U,7)'=""  W ?64,$E($$GET1^DIQ(351.83,IBVSTIEN,.06),1,19)
 W !!
 S IBIND=$$INDCHK^IBINUT1(IBVST,DFN)
 ; Prompt for Status change
 S IBSTAT=$$GETSTAT(DFN,IBVST,IBIND,.IBOVRFLG)
 Q:IBSTAT=-1
 I $$CHKDUP(IBSTAT,IBVSTIEN) W !!,"Visit can only be edited to a different status." Q
 S IBCOMM=0 I IBSTAT=4 S IBCOMM=$$GETCOMM(IBSTAT,IBOVRFLG) S:IBCOMM=3 IBSTAT=1
 ; Confirm with user with no Duplicate Visit flag.
 S IBOK=$$GETOK^IBECEA36(0)
 Q:IBOK'=1
 ; Save the changes.
 D UPDVST^IBECEAMH(IBIEN,IBSTAT,IBVSTIEN)
 Q
 ;
 ;Ask the user for the type of work to do
GETVST() ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 N SDT
 S SDT=$$GET1^DIQ(350.9,"1,",71.03,"I")
 S DIR("A")="Visit Date: "
 S DIR(0)="DA^"_SDT_":"_DT
 S DIR("?")="The visit has to occur between "_$$FMTE^XLFDT(SDT,"2DZ")_" and Today."
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!($G(Y)="")  Q -1
 Q Y
 ;
GETSTAT(IBDFN,IBVST,IBIND,IBOVRFLG) ;Ask the user for the Status of the Visit
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT,IBRUR,IBSCSA,IBY
 ;
 S IBOVRFLG=0
 I IBAE="A",IBIND D  Q -1
 .W !!,"Unable to add visit for patient covered by Indian Attestation exemption.",!
 .Q
 ;Add Prompt
 I IBAE="A" D
 .S DIR("A")="(F)REE, (B)ILLED, or (V)isit Only: "
 .S DIR(0)="SA^1:FREE;2:BILLED;4:VISIT ONLY"
 .S DIR("?")="Select whether the visit was a FREE, BILLED, or VISIT ONLY."
 .Q
 ;Edit Prompt
 I IBAE="E" D
 .S DIR("A")="(F)REE, (R)emoved, or (V)isit Only: "
 .S DIR(0)="SA^3:FREE;4:REMOVED;2:VISIT ONLY"
 .S DIR("?")="Select whether the visit was a FREE, REMOVED or VISIT ONLY."
 .Q
 ;
 D ^DIR K DIR
 ;
 I $D(DTOUT)!$D(DUOUT)!($G(Y)="")  Q -1
 S IBY=Y
 ;
 ; If a free visit, check to see if there are already 3 or more visits.  If so warn the user and exit.
 I IBY=1,'$$NUMVSTCK^IBECEAMH(IBDFN,IBVST) D  Q -1
 .W !!,"Per the Cleland-Dole Act, this patient has already used their 3 free"
 .W !,"visits for the calendar year.",!
 .Q
 Q IBY
 ;
GETCOMM(IBSTAT,IBOVRFLG) ; Ask the user for the status reason (or default it if Status is FREE)
 ;
 ;Input: IBSTAT - The visit status (from code set in .06 field in file 351.83
 ;                1 - FREE
 ;                2 - VISIT ONLY
 ;                4 - REMOVED
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 ;
 ;
 ; If the status is to be FREE, auto populate the Reason based on Priority Group
 I IBSTAT=1,IBOVRFLG=1 Q 6  ; Defaults to reason FRM Override
 I IBSTAT=1 Q 2             ; Defaults to reason Cleland-Dole
 ; If the status is VISIT ONLY, auto populate the Reason with No Copay Required
 I IBSTAT=2 Q 5
 ; Ask user for the REMOVED reason.
 S DIR("A")="Reason for (E)ntered in Error or (D)uplicate Visit: "
 S DIR(0)="SA^3:Entered in Error;4:Duplicate Visit"
 S DIR("?")="Select a reason to associate with the REMOVED visit status."
 ;
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)  Q -1
 Q Y
 ;
GETVISIT(IBLCT) ; Get the IEN for visit to be edited.
 ;
 S DIR("A")="Enter Visit Number: "
 S DIR(0)="NA^1:"_IBLCT_"^"
 S DIR("?")="Enter the Visit to edit from the list above"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y<1)  Q -1
 ;
 Q +Y
 ;
DISPCHG(IBSTAT,IBBILL,IBREAS) ;Redisplay the changes requested
 ;
 W "The following updates will be made to this visit:"
 W !!
 Q
 ;
GETBILL(IBDFN,IBVSTDT) ; get bill # from file 350
 ;
 ; IBDFN - patient's DFN
 ; IBVSTDT - visit date
 ;
 ; returns file 350 ien, or 0 if no file 350 entry was found.
 ;
 N IBENC,IBIEN,IBOK,IBSTAT,N0,STOP,RES,Z
 S (RES,STOP)=0
 S IBIEN="" F  S IBIEN=$O(^IB("ACHDT",IBDFN,IBVSTDT,IBIEN)) Q:'IBIEN!STOP  D
 .S IBSTAT=$$GET1^DIQ(350,IBIEN,.05) I IBSTAT="CANCELLED" Q
 .S N0=$G(^IB(IBIEN,0))
 .S IBOK=$$ISCDCANC^IBECEAMH(IBIEN)
 .I 'IBOK S Z=$P($P(N0,U,4),";") Q:$P(Z,":")'="409.68"  S IBENC=$P(Z,":",2),IBOK=$$OECHK^IBECEAMH(IBENC,IBVSTDT)
 .I 'IBOK Q  ; not Cleland-Dole eligible
 .S RES=IBIEN,STOP=1
 .Q
 Q RES
 ;
CHKDUP(IBSTAT,IBVSTIEN) ; check for duplicate visit status
 ;
 ; IBSTAT - new visit status (from $$GETSTAT() function)
 ; IBVSTIEN - file 351.83 ien
 ;
 ; returns 1 if new status is the same as existing one, 0 otherwise
 ;
 N TMP
 S TMP=$S(IBSTAT=3:1,IBSTAT=4:3,1:4) ; convert $$GETSTAT() result to appropriate code for field 351.83/.04
 I $$GET1^DIQ(351.83,IBVSTIEN,.04,"I")=TMP Q 1
 Q 0
