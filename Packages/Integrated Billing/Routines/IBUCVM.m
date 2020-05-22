IBUCVM ;LL/ELZ-LONG TERM CARE CLOCK MAINTANCE ; 06-DEC-19
 ;;2.0;INTEGRATED BILLING;**663,671**;21-MAR-94;Build 13
 ;; Per VHA Directive 6402, this routine should not be modified
 ;
 ; This routine is used to perform the Urgent Care Visit Tracking
 ; database Maintenance.
 ;
 Q
 ;
ENTER ; menu option main entry point
 ;
 N DIC,X,Y,DFN,DTOUT,DUOUT,DIRUT,DIROUT,%,DIR,IBYR,IBLCT,IBAE,IBQUIT
 ;
 S IBQUIT=0  ;Don't quit.
 ;
 ; select a patient (screen out patients with no LTC clock and are
 ; not LTC patients.
LOOP K DIC,X,Y,DFN,IBLTCX,VADP,IBLCT
 ;
 ; Clear temp global in case of stoppage during work
 K ^TMP($J,"IBUCVM")
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
 ;
 ;Ask user to Add or Edit Visit
 W !!    ; Space prompt.
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
 K ^TMP($J,"IBUCVM")
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
 S DIR("B")=2019
 S DIR(0)="F^4:4:K:X'?4N X"
 D ^DIR I $D(DIRUT) Q -1
 W " ",Y
 Q Y
 ;
PRTVSTS(IBDFN,IBYR) ; Get the list of visits for the calendar year
 ;
 N IBZ,IBV,IBC,IBI,IBN,IBD,IBSTAT,IBDT,IBLDT,IBLDT1,IBPT,IBQUIT,IBVYR
 ;
 S IBC=0 ; Counter of Visits
 ; Collect the list of visits
 S IBI=0 F  S IBI=$O(^IBUC(351.82,"B",IBDFN,IBI)) Q:'IBI  D
 . S IBD=$G(^IBUC(351.82,IBI,0))
 . Q:'IBD
 . S IBSTAT=$P(IBD,U,4)
 . S IBDT=$P(IBD,U,3)
 . S IBVYR=$E(IBDT,1,3)+1700    ; Convert visit date to calendar year
 . I IBYR'=IBVYR Q
 . S IBC=IBC+1
 . S ^TMP($J,"IBUCVM","IBA",IBC)=IBDT,^TMP($J,"IBUCVM","IBA","D",IBDT,IBC)=IBI_U_IBD
 ;
 ;Reorganize in date order for display
 S (IBLDT,IBLCT)=0
 F  S IBLDT=$O(^TMP($J,"IBUCVM","IBA","D",IBLDT)) Q:'IBLDT  D
 . S IBLDT1=0
 . F  S IBLDT1=$O(^TMP($J,"IBUCVM","IBA","D",IBLDT,IBLDT1)) Q:'IBLDT1  D
 . . S IBLCT=IBLCT+1
 . . S ^TMP($J,"IBUCVM","IBP",IBLCT)=$G(^TMP($J,"IBUCVM","IBA","D",IBLDT,IBLDT1))
 ;
 W @IOF
 S IBPT=$$PT^IBEFUNC(IBDFN)
 W !,"Urgent Care Visits in "_IBYR_" for "_$P(IBPT,U),"  ",$P(IBPT,U,2),!
 D LINE("=",80)
 I 'IBC W "No Urgent Care Visits during this calendar year." Q 0
 S IBV=IBLCT\3 I IBC#3 S IBV=IBV+1
 F IBI=1:1:IBV D  Q:$G(IBQUIT)
 . D:$D(IBQUIT) CHKPAUSE
 . S IBN=IBI
 . S IBD=$G(^TMP($J,"IBUCVM","IBP",IBN))
 . W !?5,$J(IBN,2),?10,$$FMTE^XLFDT($P(IBD,U,4))_" "_$S($P(IBD,U,5)=1:"F",$P(IBD,U,5)=3:"R",$P(IBD,U,5)=4:"V",1:"")
 . S IBN=IBI+IBV S IBD=$G(^TMP($J,"IBUCVM","IBP",IBN)) I IBD'="" W ?30,$J(IBN,2),?35,$$FMTE^XLFDT($P(IBD,U,4))_" "_$S($P(IBD,U,5)=1:"F",$P(IBD,U,5)=3:"R",$P(IBD,U,5)=4:"V",1:"")
 . S IBN=IBI+(2*IBV) S IBD=$G(^TMP($J,"IBUCVM","IBP",IBN)) I IBD'="" W ?55,$J(IBN,2),?60,$$FMTE^XLFDT($P(IBD,U,4))_" "_$S($P(IBD,U,5)=1:"F",$P(IBD,U,5)=3:"R",$P(IBD,U,5)=4:"V",1:"")
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
 ;
 ;RCMNFLG - Ask to print the Main report (Detailed) report.  0=No, 1=Yes
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 ;
 ; Prompt Summary or Detail version
 S DIR("A")="(A)dd an Urgent Care Visit, (E)dit an existing Visit, or (Q)uit: "
 S DIR(0)="SA^A:ADD;E:Edit;Q:Quit"
 S DIR("?")="Select whether to Add a new Urgent Care visit, Edit an Existing visit, or Quit."
 ;
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!($G(Y)="")  Q -1
 I Y="Q" Q -1
 Q Y
 ;
ADDVST(IBDFN) ; Add a new UC visit for the patient
 ;
 N IBVST,IBINST,IBSTAT,IBBILL,IBCOMM,IBSITE,IBERROR,IBDUPFLG,IBELPG
 ;
 ;Initialize the error return array/Variable
 S IBERROR=""
 ;
 S (IBVST,IBINST,IBSTAT,IBBILL,IBCOMM)="",IBDUPFLG=0
 D SITE^IBAUTL   ; retrieve the Billing Site value from the IB Site Parameter File.  Store in IBSITE
 S IBVST=$$GETVST
 I $D(^TMP($J,"IBUCVM","IBA","D",IBVST)) S IBDUPFLG=1
 Q:IBVST=-1
 ; Retrieve Priority Group (future development)
 S IBELPG=$$GETELGP^IBECEA36(DFN,IBVST)
 ;
 S IBSTAT=$$GETSTAT(DFN,IBVST,IBELPG)
 Q:IBSTAT=-1
 S:IBSTAT=2 IBBILL=$$GETBILL
 Q:IBBILL=-1
 S:IBSTAT'=2 IBCOMM=$$GETCOMM(IBSTAT,IBELPG)
 Q:IBCOMM=-1
 S IBOK=$$GETOK^IBECEA36(IBDUPFLG)
 Q:IBOK'=1
 D ADD^IBECEA38(IBDFN,IBSITE,IBVST,IBSTAT,IBBILL,IBCOMM,1,"",.IBERROR)
 Q
 ;
EDITVST(IBLCT) ; Add a new UC visit for the patient
 ;
 N IBSTAT,IBBILL,IBCOMM,IBERROR,IBVISIT,IBIEN,IBD,IBSITECD,IBSITENM,IBVSITE,IBVST,IBELPG,IBOK
 ;
 ;Ask user for visit to edit
 S (IBSTAT,IBBILL,IBCOMM,IBERROR,IBVSITE)=""
 S IBVISIT=$$GETVISIT(IBLCT)
 Q:IBVISIT=-1
 ;
 ;Get the visit info
 S IBD=$G(^TMP($J,"IBUCVM","IBP",IBVISIT))
 Q:IBD=""
 S IBIEN=$P(IBD,U)
 S IBVST=$P(IBD,U,4)
 ;
 ;get the Site name and code
 I $P(IBD,U,3)'="" D
 .  S IBSITECD=$$GET1^DIQ(4,$P(IBD,U,3)_",",99,"I")
 .  S IBSITENM=$$GET1^DIQ(4,$P(IBD,U,3)_",",.01,"E")
 .  S IBVSITE=$E(IBSITECD_"-"_IBSITENM,1,20)
 ;
 ;display the visit info
 ;
 W !!,"Date of Visit",?16,"Station",?39,"Status",?51,"Bill No.",?64,"Reason"
 W !,"-------------",?16,"-------",?39,"------",?51,"--------",?64,"------"
 W !,$$FMTE^XLFDT($P(IBD,U,4)),?16,IBVSITE,?39,$$GET1^DIQ(351.82,IBIEN_",",.04)
 I $P(IBD,U,6)'="" W ?51,$P(IBD,U,6)
 I $P(IBD,U,7)'=""  W ?64,$E($$GET1^DIQ(351.82,IBIEN_",",.06),1,19)
 W !!
 ;
 ; Retrieve Priority Group (future development)
 S IBELPG=$$GETELGP^IBECEA36(DFN,IBVST)
 ;
 ;Prompt for Status change
 S IBSTAT=$$GETSTAT(DFN,IBVST,IBELPG)
 Q:IBSTAT=-1
 ;
 ;Prompt for Bill No. if status is billed
 S:IBSTAT=2 IBBILL=$$GETBILL
 Q:IBBILL=-1
 ;
 ;Prompt for Comment if changed to Free or Not Counted
 S:IBSTAT'=2 IBCOMM=$$GETCOMM(IBSTAT,IBELPG)
 Q:IBCOMM=-1
 ;
 ;Confirm with user with no Duplicate Visit flag.
 S IBOK=$$GETOK^IBECEA36(0)
 Q:IBOK'=1
 ;
 ;Save the changes.
 D UPDATE^IBECEA38(IBIEN,IBSTAT,IBBILL,IBCOMM,1,.IBERROR)
 Q
 ;
 ;Ask the user for the type of work to do
GETVST() ;
 ;
 ;RCMNFLG - Ask to print the Main report (Detailed) report.  0=No, 1=Yes
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 ;
 ; Prompt Summary or Detail version
 S DIR("A")="Visit Date: "
 S DIR(0)="DA^3190606:"_DT
 S DIR("?")="The visit has to occur between 6/6/2019 and Today."
 ;
 ;
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!($G(Y)="")  Q -1
 Q Y
 ;
GETSTAT(IBDFN,IBVST,IBELPG) ;Ask the user for the Status of the Visit
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT,IBFRCT,IBRUR,IBSCSA
 ;
 S IBFRCT=0
 ;
 ;Add Prompts
 I IBAE="A" D
 . S DIR("A")="(F)REE,(B)ILLED, or (V)isit Only: "
 . S DIR(0)="SA^1:FREE;2:BILLED;4:VISIT ONLY"
 . S DIR("?")="Select whether the visit was a FREE, BILLED, or VISIT ONLY."
 ;
 ;Edit Prompts
 I IBAE="E" D 
 . S DIR("A")="(F)REE,(B)ILLED,(R)emoved, or (V)isit Only: "
 . S DIR(0)="SA^1:FREE;2:BILLED;3:REMOVED;4:VISIT ONLY"
 . S DIR("?")="Select whether the visit was a FREE, BILLED, REMOVED or VISIT ONLY."
 ;
 D ^DIR K DIR
 ;
 I $D(DTOUT)!$D(DUOUT)!($G(Y)="")  Q -1
 ;
 ;Validate that the veteran can receive a free visit
 I (IBELPG>6),(Y=1) D  Q -1
 . W !!,"Per the MISSION Act of 2018, this patient is ineligible for a Free"
 . W !,"Urgent Care Visit.",!
 ;
 I IBELPG=6 D
 . ;Check to see if an RUR was completed.  If not, ask for the RUR and quit
 . S IBRUR=$$PRTSARUR^IBECEA36
 . I IBRUR=-1 D  Q
 . . W !!,"Please send this for review by RUR."
 . . S Y=-1
 . ;
 . ;Check to see if visit related to the SC/SA.
 . S IBSCSA=$$PRTVSTSA^IBECEA36
 . ;
 . I (IBSCSA=-1),(Y=1) D
 . . W !!,"Per the MISSION Act of 2018, this patient is ineligible for a Free"
 . . W !,"Urgent Care Visit.",!
 . . S Y=-1
 ;
 ; Exit if the PG 6 data checks failed
 I Y=-1 Q -1
 ;
 ; If a free visit, check to see if there are already 3 or more visits.  If so warn the user and exit.
 S:Y=1 IBFRCT=$P($$GETVST^IBECEA36(IBDFN,IBVST),U,2)
 ;
 K ^TMP($J,"IBUCVST")   ;Clean up TMP global created during GETVST^IBECEA36, not needed
 ;
 I (Y=1),(IBELPG<7),(IBFRCT>2) D  Q -1
 . W !!,"Per the Mission Act of 2018, this patient has already used their 3 free"
 . W !,"visits for the calendar year.",!
 Q Y
 ;
GETBILL() ;Ask the user for a Bill Number
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 ;
 S DIR("A")="Bill Number: "
 S DIR(0)="FAO^^K:'$$CHKBILL^IBUCVM(X) X"
 S DIR("?")="Enter the Bill Number (including site) or ON HOLD if this visit was billed.  <ENTER> to continue."
 ;
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)  Q -1
 Q Y
 ;
CHKBILL(IBBLNO) ; Validate that the Bill Number is a valid input
 ;
 ;Input:  IBBLNO - A bill number (with site) or ON HOLD.
 ;
 N IBBLIEN
 ;
 Q:IBBLNO="ON HOLD" 1     ; ON HOLD is a valid non Bill # entry
 I IBBLNO'?3N1"-"1"K"6NU Q 0   ; Is not a valid Site and Bill Number format
 S IBBLIEN=$O(^IB("ABIL",IBBLNO,""))
 Q:IBBLIEN'="" 1
 Q 0
 ;
GETCOMM(IBSTAT,IBELPG) ; Ask the user for the status reason (or default it if Status is FREE)
 ;
 ;Input: IBSTAT - The visit status (from code set in .06 field in file 351.82
 ;                1 - FREE
 ;                3 - REMOVED
 ;                4 - VISIT ONLY
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 ;
 ;
 ;If the status is to be FREE, auto populate the Reason based on Priority Group
 I (IBSTAT=1),(IBELPG=6) Q 1    ;Defaults to reason SC/SA
 I (IBSTAT=1),(IBELPG<6) Q 2    ;Defaults to reason MISSION Act
 ;
 ;If the status is VISIT ONLy, auto populate the Reason with No Copay Required
 I IBSTAT=4 Q 5
 ;
 ;If the Status is Not Counted, ask user for the REMOVED reason.
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
