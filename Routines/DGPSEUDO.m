DGPSEUDO ;ALB/ERC - REPORTS FOR PSEUDO SSN ; 1/17/06 9:58am
 ;;5.3;Registration;**653**;Aug 13, 1993;Build 2
 ;
 ;creates a report of all patients with pseudo SSNs
 ;can call for veteran, non-veterans or both
 ;can call for one Pseudo SSN Reason or can call for all reasons
 ;sorted by reason
TSK1 ;
 N DGQUIT,DGREAS,DGREASON,DGTXT,DGQ,DGVET,DGXREAS,DGXVET
 N ZTRTN,ZTDESC,ZTSK,ZTIO,ZTDTH,POP,IO,IOBS,IOF,IOHG,IOM,ION,IOPAR
 N IOS,IOSL,IOST,IOT,IOUPAR,IOXY,%ZIS,ZTSAVE
 K ^TMP("DGEVC",$J)
 S DGQUIT=0
 D QUESVET Q:DGQUIT
 D QUESREAS Q:DGQUIT
 S %ZIS="Q" D ^%ZIS I $G(POP) D ^%ZISC,HOME^%ZIS W !,"Job Terminated!" Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="RPT1^DGPSEUDO"
 . S ZTDESC="PATIENTS WITH PSEUDO SOCIAL SECURITY NUMBERS"
 . S (ZTSAVE("DGXREAS"),ZTSAVE("DGXVET"))=""
 . D ^%ZTLOAD
 . S DGTXT=$S($G(ZTSK):"Task: "_ZTSK_" Queued.",1:"Error: Process not queued!")
 . W !,DGTXT
RPT1 ;
 N DGC,DGPAGE,DGXXVET
 S DGPAGE=0
 S DGC=0
 S DGXXVET=DGXVET
 D LOOP1
 D HDR1
 I $G(DGC)'>0 W !!?25,"****NO RECORDS TO REPORT****" W ! D PAUSE Q
 D REP1(DGXVET,DGXREAS)
 D ^%ZISC,HOME^%ZIS
 K ^TMP("DGEVC",$J)
 Q
QUESVET ;ask user if report should be veterans, non-veterans, or both
 N DGBOTH,DIR,DIRUT,DIROUT,X
 W !!!,?10,"REPORT OF PATIENTS WITH PSEUDO SOCIAL SECURITY NUMBERS"
 W !?5,"This report excludes deceased patients, non-user enrollees and"
 W !?5,"with no Integration Control Numbers (ICN).",!
 S DIR("A",1)="Do you want this report for Veterans, Non-Veterans or both?"
 S DIR("A",2)="1. Veterans only"
 S DIR("A",3)="2. Non-Veterans only"
 S DIR("A",4)="3. Veterans and Non-Veterans"
 S DIR("A")="Select"
 S DIR("B")=1
 S DIR("?")="Choose a report with Veterans only, Non-Veterans only or both."
 S DIR(0)="N^1:3"
 D ^DIR
 I $D(DIRUT)!($D(DIROUT)) S DGQUIT=1
 S DGXVET=$S(X=1:"VET",X=2:"NON",1:"BOTH")
 Q
 ;
QUESREAS ;ask user which Pseudo SSN Reason, or all
 N DIR,DIRUT,DIROUT,X
 W !
 S DIR("A",1)="Select which Pseudo SSN Reason(s) to be included in the report."
 S DIR("A",2)="1. Refused to Provide"
 S DIR("A",3)="2. SSN Unknown/Follow-up Required"
 S DIR("A",4)="3. No SSN Assigned"
 S DIR("A",5)="4. No reason on file"
 S DIR("A",6)="5. All of the above"
 S DIR("A")="Select"
 S DIR("?")="Select one of the Reasons for having a Pseudo SSN."
 S DIR(0)="N^1:5"
 D ^DIR
 I $D(DIRUT)!($D(DIROUT)) S DGQUIT=1
 S DGXREAS=$S(X=1:"REFUSED TO PROVIDE",X=2:"SSN UNKNOWN/FOLLOW-UP REQUIRED",X=3:"NO SSN ASSIGNED",X=4:"NULL",1:"ALL")
 Q
LOOP1 ;
 I $E(IOST,1,2)["C-" U IO(0) W !!,"Scanning file...."
 U IO
 N DGDFN,DGX
 K ^TMP("DGEVC",$J)
 S ^TMP("DGEVC",$J,"COUNT","VET","REFUSED TO PROVIDE")=0
 S ^TMP("DGEVC",$J,"COUNT","VET","SSN UNKNOWN/FOLLOW-UP REQUIRED")=0
 S ^TMP("DGEVC",$J,"COUNT","VET","NO SSN ASSIGNED")=0
 S ^TMP("DGEVC",$J,"COUNT","VET","NULL")=0
 S ^TMP("DGEVC",$J,"COUNT","NON","REFUSED TO PROVIDE")=0
 S ^TMP("DGEVC",$J,"COUNT","NON","SSN UNKNOWN/FOLLOW-UP REQUIRED")=0
 S ^TMP("DGEVC",$J,"COUNT","NON","NO SSN ASSIGNED")=0
 S ^TMP("DGEVC",$J,"COUNT","NON","NULL")=0
 S DGX=999999999
 F  S DGX=$O(^DPT("SSN",DGX)) Q:DGX=""  D
 . I DGX'["P" Q
 . S DGDFN=""
 . F  S DGDFN=$O(^DPT("SSN",DGX,DGDFN)) Q:'DGDFN  D
 . . I '$D(^DPT(DGDFN,0)) Q
 . . D PSEU1
 Q
PSEU1 ;
 N DGARR,DGDOB,DGEC,DGERR,DGNAM,DGREASON,DGSSN,DGUSER,DGVET
 I $D(^TMP("DGEVC",$J,DGDFN)) Q
 D GETS^DIQ(2,DGDFN_",",".01;.03;.09;.0906;.351;.361;.3617;991.01;1901","EI","DGARR","DGERR")
 I $D(DGERR) K DGERR Q
 I $G(DGARR(2,DGDFN_",",.351,"I"))]"" K DGARR Q
 I $G(DGARR(2,DGDFN_",",991.01,"I"))']"" K DGARR Q
 S DGVET=$S($G(DGARR(2,DGDFN_",",1901,"I"))="Y":"VET",$G(DGARR(2,DGDFN_",",1901,"I"))="N":"NON",1:"NON")
 I $G(DGVET)]"",DGXVET'="BOTH",DGVET'=DGXVET K DGARR Q
 S DGREASON=$G(DGARR(2,DGDFN_",",.0906,"E"))
 I $G(DGREASON)']"" S DGREASON="NULL"
 I DGXREAS'="ALL",DGXREAS'=DGREASON K DGARR Q
 S DGUSER=$G(DGARR(2,DGDFN_",",.3617,"I"))
 I DGVET="YES",($G(DGUSER)']"") K DGARR Q
 S DGUSER=$$FY($E(DGUSER,1,3)+1700)
 I DGVET="VET",$G(DGUSER)'=1 K DGARR Q
 S DGNAM=$G(DGARR(2,DGDFN_",",.01,"I"))
 I $G(DGNAM)']"" K DGARR Q
 S DGDOB=$G(DGARR(2,DGDFN_",",.03,"E"))
 S DGEC=$G(DGARR(2,DGDFN_",",.361,"E"))
 S DGSSN=DGARR(2,DGDFN_",",.09,"I")
 I DGX'=DGSSN K DGARR Q
 S DGC=DGC+1
 S ^TMP("DGEVC",$J,DGVET,DGREASON,DGNAM,DGDFN)=$G(DGSSN)_"^"_$G(DGDOB)_"^"_$G(DGEC)
 S ^TMP("DGEVC",$J,"COUNT")=DGC
 S ^TMP("DGEVC",$J,"COUNT",DGVET,DGREASON)=$G(^TMP("DGEVC",$J,"COUNT",DGVET,DGREASON))+1
 Q
FY(DGFY) ;determine if user enrollee date is current FY or later
 N DGYEAR
 S DGYEAR=$E(DT,1,3)+1700
 I $E(DT,4,5)>9 S DGYEAR=DGYEAR+1
 Q $S(DGFY>DGYEAR:1,DGFY=DGYEAR:1,1:0)
HDR1 ;
 N DGDATE,DGL,DGLINE,DGT,Y ;display veteran, non-vet or both
 I $E(IOST,1,2)["C-" W @IOF
 S DGPAGE=DGPAGE+1
 W !?((IOM-44)\2),"Patients with Pseudo Social Security Numbers",?70,"Page:"_DGPAGE
 S DGT=$S(DGXXVET="VET":"Veterans only",DGXXVET="NON":"Non-Veterans only",1:"Veterans and Non-Veterans")
 S DGT="Report shows "_DGT
 S DGL=$L(DGT)
 W !?((IOM-DGL)\2),DGT
 S Y=DT X ^DD("DD") S DGDATE=Y
 W !?62,"Date: "_$G(DGDATE)
 W !!,"PATIENT",?32,"PSEUDO SSN",?44,"BIRTHDATE",?56,"PRIMARY ELIGIBILITY CODE"
 N DGZ
 W !
 F DGZ=1:1:IOM W "-" ;S $P(DGLINE,"-",DGZ)=""
 Q
REP1(DGXVET,DGXREAS) ;
 N DGCT,DGV
 S DGCT=0
 I DGXVET="BOTH" D
 . F DGV="VET","NON" D
 . . Q:'$D(^TMP("DGEVC",$J,DGV))
 . . Q:$G(DGQ)
 . . I $E(IOST,1,2)["C-",($Y>(IOSL-4)) D PAUSE Q:$G(DGQ)
 . . I $Y>(IOSL-4) D
 . . . W @IOF
 . . . D HDR1
 . . W !!?5,"Report for "_$S(DGV="VET":"Veterans",1:"Non-Veterans")
 . . D VET(DGV)
 I DGXVET'="BOTH" D VET(DGXVET)
 I $G(DGC)=DGCT W !!?29,"Patients with Pseudo SSNs: "_DGCT
 I $E(IOST,1,2)["C-",('$G(DGQ)) W ! D PAUSE
 Q
VET(DGXVET) ;
 N DGR
 I DGXREAS="ALL" D
 . F DGR="REFUSED TO PROVIDE","SSN UNKNOWN/FOLLOW-UP REQUIRED","NO SSN ASSIGNED","NULL" D
 . . Q:$G(DGQ)
 . . D REAS(DGXVET,DGR)
 I DGXREAS'="ALL" D
 . D REAS(DGXVET,DGXREAS)
 Q
REAS(DGXVET,DGXRR) ;
 N DGN,DGNAM,DGDFN
 S DGDFN=0
 I $E(IOST,1,2)["C-",($Y>(IOSL-4)) D PAUSE Q:$G(DGQ)
 I $Y>(IOSL-4) D
 . W @IOF
 . D HDR1
 I $O(^TMP("DGEVC",$J,DGXVET,DGXRR,""))]"" W !!?10,"Pseudo SSN Reason: "_$S(DGXRR="NULL":"<NONE ENTERED>",1:DGXRR)
 S DGNAM=""
 F  S DGNAM=$O(^TMP("DGEVC",$J,DGXVET,DGXRR,DGNAM)) Q:DGNAM']""!($G(DGQ))  D
 . F  S DGDFN=$O(^TMP("DGEVC",$J,DGXVET,DGXRR,DGNAM,DGDFN)) Q:DGDFN']""!($G(DGQ))  D
 . . I $E(IOST,1,2)["C-",($Y>(IOSL-4)) D PAUSE Q:$G(DGQ)
 . . I $Y>(IOSL-4) D
 . . . W @IOF
 . . . D HDR1
 . . S DGN=^TMP("DGEVC",$J,DGXVET,DGXRR,DGNAM,DGDFN)
 . . W !,DGNAM,?32,$P(DGN,U),?44,$P(DGN,U,2)
 . . I $P(DGN,U,3)["SERVICE CONNECTED" S $P(DGN,U,3)="SC 50% TO 100%"
 . . W ?56,$E($P(DGN,U,3),1,23)
 . . S DGCT=$G(DGCT)+1
 I ^TMP("DGEVC",$J,"COUNT",DGXVET,DGXRR)>0,(DGXREAS="ALL") W !?46,"Subtotal: "_^TMP("DGEVC",$J,"COUNT",DGXVET,DGXRR)
 Q
 ;
PAUSE ;
 N DIR,X,Y
 S DGQ=0
 S DIR(0)="E"
 D ^DIR
 I '+Y!($D(DIRUT)) S DGQ=1
 Q
 ;
