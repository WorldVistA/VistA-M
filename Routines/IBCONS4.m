IBCONS4 ;ALB/ARH - NSC W/INSURANCE OUTPUT (SETUP) ; 12-23-96
 ;;Version 2.0 ; INTEGRATED BILLING ;**66**; 21-MAR-94
 ;
RPT N DIR,X,Y,DIRUT,DTOUT,DUOUT,IBX,IBY,IBI S (IBPRTRDS,IBPRTIEX,IBPRTICR,IBPRTIPC,IBPRTIGC)=0
 S (IBSELUBL,IBSELBNA,IBSELBIL,IBSELRNB,IBSELCDV,IBSELTRM,IBSELRNG)=0
 ;
 W !!,?5,"Enter Report to print:"
 W !,?10,"1  - Unbilled Episodes"
 W !,?10,"2  - Billed Episodes but Not Authorized"
 W !,?10,"3  - Billed Episodes (Authorized)",!
 ;
 S DIR(0)="LO^1:3:0"
 S DIR("A")="Report",DIR("B")="1",DIR("??")="^D RHELP1^IBCONS4" D ^DIR K DIR I +Y'>0 S IBQUIT=1 G EXIT
 ;
 S IBY=Y F IBI=1:1 S Y=$P(IBY,",",IBI) Q:'Y  D
 . ;
 . I Y=1 S IBSELUBL=1 ;       unbilled episodes
 . I Y=2 S IBSELBNA=1 ;       billed but not authorized
 . I Y=3 S IBSELBIL=1 ;       billed episodes (authorized)
 ;
 W !!,?5,"Optional format requirements:"
 W !,?10,"1  - Include Episodes with a Reason Not Billable"
 W !,?10,"2  - Include Only Episodes with a Reason Not Billable"
 W !,?10,"3  - Combine Divisions into one Report"
 W !,?10,"4  - Sort by Terminal Digit"
 W !,?10,"5  - Select Sort Range"
 W !!,?5,"Optional print fields:"
 W !,?10,"6  - Patient's Rated Disabilities"
 W !,?10,"7  - Patient Insurance Dates"
 W !,?10,"8  - Coverage and Riders"
 W !,?10,"9  - Policy Comments"
 W !,?10,"10 - Group Comments",!
 ;
 S DIR(0)="LO^1:10:0"
 S DIR("A")="Optional requirements",DIR("??")="^D RHELP2^IBCONS4" D ^DIR I $D(DTOUT)!$D(DUOUT) S IBQUIT=1 G EXIT
 ;
 S IBY=Y F IBI=1:1 S Y=$P(IBY,",",IBI) Q:'Y  D
 . ;
 . I Y=1 S IBSELRNB=1 ;               include episodes with a RNB
 . I Y=2 S IBSELRNB=2 ;               include episodes with a RNB only
 . I Y=3 S IBSELCDV=1 ;               combine divisions
 . I Y=4 S IBSELTRM=1 ;               sort by terminal digit
 . I Y=5 S IBSELRNG=1 ;               select range of patients (PT name or TD)
 . I Y=6 S IBPRTRDS=1 ;               patient's rated disabilities
 . I Y=7 S IBPRTIEX=1 ;               patient insurance dates and group #
 . I Y=8 S IBPRTICR=1 ;               coverage limits and riders
 . I Y=9 S IBPRTIPC=1 ;               patient policy comments
 . I Y=10 S IBPRTIGC=1 ;              group plan comments
 ;
 I $G(IBSELRNG)=1 W ! D SRTRNG I '$D(IBSELSR1)!'$D(IBSELSR2) S IBQUIT=1 G EXIT
 W ! D DATE I ($G(IBBEG)'?7N)!($G(IBEND)'?7N) S IBQUIT=1 G EXIT
 D ASKDIV
EXIT Q
 ;
SRTRNG ; get which data item to range on: Patient Name or Terminal Digit
 N DIR,X,Y,DIRUT,DUOUT,DTOUT S IBSELRNG=0 K IBSELSR1,IBSELSR2
 S DIR("A")="Select Range of Patients By",DIR(0)="SO^1:Patient Name;2:Terminal Digit;3:Insurance Company" D ^DIR
 I +Y=1 S IBSELRNG=+Y D SRTRNGP
 I +Y=2 S IBSELRNG=+Y D SRTRNGT
 I +Y=3 S IBSELRNG=+Y D SRTRNGI
 Q
 ;
SRTRNGP ; select patient name range for sort
 N DIR,X,Y,DIRUT,DUOUT,DTOUT K IBSELSR1,IBSELSR2
 S DIR(0)="FO"
 S DIR("B")="FIRST",DIR("A")="START WITH PATIENT NAME" D ^DIR Q:$D(DIRUT)  S:Y="FIRST" Y="" S IBSELSR1=$$ASCII^IBCONS2(Y)
 ;
 S DIR("B")="LAST",DIR("A")="GO TO PATIENT NAME" D ^DIR Q:$D(DIRUT)  S:Y="LAST" Y="" S IBSELSR2=$$ASCII^IBCONS2(Y)
 Q
 ;
SRTRNGT ; select terminal digit range for sort
 N DIR,X,Y,DIRUT,DUOUT,DTOUT K IBSELSR1,IBSELSR2
 S DIR(0)="FO^1:9^K:X'?1.9N X",DIR("?")="Enter up to 9 digits of the Terminal Digit to include in report"
 ;
 S DIR("B")="0000",DIR("A")="START WITH TERMINAL DIGIT" D ^DIR Q:$D(DIRUT)  S IBSELSR1=$E((Y_"000000000"),1,9)
 ;
 S DIR("B")=9999,DIR("A")="GO TO TERMINAL DIGIT" D ^DIR Q:$D(DIRUT)  S IBSELSR2=$E((Y_"999999999"),1,9)
 Q
 ;
SRTRNGI ; select insurance company name range for sort
 N DIR,X,Y,DIRUT,DUOUT,DTOUT K IBSELSR1,IBSELSR2
 S DIR(0)="FO"
 S DIR("B")="FIRST",DIR("A")="START WITH INSURANCE COMPANY NAME" D ^DIR Q:$D(DIRUT)  S:Y="FIRST" Y="" S IBSELSR1=$$ASCII^IBCONS2(Y)
 ;
 S DIR("B")="LAST",DIR("A")="GO TO INSURANCE COMPANY NAME" D ^DIR Q:$D(DIRUT)  S:Y="LAST" Y="" S IBSELSR2=$$ASCII^IBCONS2(Y)
 Q
 ;
DATE ; Issue prompts for Begin and End dates
 N %DT,Y,X K IBBEG,IBEND
 S %DT="AEPX",%DT("A")="Start with DATE: " D ^%DT Q:Y<0  S IBBEG=+Y\1
 S %DT="AEPX",%DT("A")="Go to DATE: ",%DT(0)=+Y D ^%DT Q:Y<0  S IBEND=+Y\1
 Q
 ;
ASKDIV ; Issue prompt for Division (ALL: VAUTD=1,  SELECT: VAUTD=0, VAUTD(DV)=DV NAME, ELSE: Y=-1)
 D PSDR^IBODIV I Y<0 S IBQUIT=1
 Q
 ;
RHELP1 ; help for report question
 W !,"------------------------------------------------------------------------------"
 W !,"Determines what types of episodes are included on the report.",!
 W !,"Required: specify if report should include billed and/or unbilled episodes"
 W !!,?3,"1 - Unbilled:              no Third Party bill can be identified for episode"
 W !,?3,"2 - Billed/Not Authorized: one or more Third Party bills exists for the",!,?30,"episode, but at least one of them has not yet been",!,?30,"authorized or passed to AR"
 W !,?3,"3 - Billed/Authorized:     one or more Third Party bills exists for the",!,?30,"episode and all of them have been Authorized"
 W !!,"Choose one or more of the above to include on the report."
 W !,"------------------------------------------------------------------------------"
 Q
 ;
RHELP2 ; help for optional requirements question
 W !,"------------------------------------------------------------------------------"
 W !,"Determines which episodes are included on the report and how they are sorted."
 W !!,"Optional:  special requirements for printing the report,",!,?11,"these apply to both billed and unbilled episode reports."
 W !!,?3,"1 - Include Episodes with a RNB:       (default excludes episodes with a RNB)"
 W !,?3,"2 - Include Only Episodes with a RNB:                         (default is No)"
 W !,?3,"3 - Combine Divisions:         (default is separate report for each Division)"
 W !,?3,"4 - Sort by Terminal Digit:     (default sort alphabetically by Patient Name)"
 W !,?3,"5 - Select Range of Pat Names or Term Digits or Ins Company: (default is all)"
 ;
 W !!,"Terminal Digit Sort:  the output will be sorted by the 8th and 9th digits and",!,"then the 6th and 7th digits of the patient's SSN"
 W !,"{Reason Not Billable}:  if episodes with RNB are included then inpatient",!,"episodes with all movements SC are included on the report"
 ;
 W !!,"All of the optional print fields apply to the patient and if chosen will",!,"print once for each patient on the report."
 W !,"Indications of the Insurance Coverage and Riders, Policy Comments, and Group",!,"Comments are only printed if they exist for the policy/plan."
 W !,"------------------------------------------------------------------------------"
 Q
