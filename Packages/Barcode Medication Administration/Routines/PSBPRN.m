PSBPRN ;BIRMINGHAM/EFC-BCMA PRN FUNCTIONS ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**5,3,13**;Mar 2004
 ;
 ;Reference/IA
 ;DEM^VADPT/10061
 ;INP^VADPT/10061
 ;$$GET1^DIQ/2056
EN ;
 Q
 ;
EDIT ; Edit Medication Log PRN Effectiveness
 NEW DFN ;* Undef DFN at EDIT+7^PSBPRN (NOIS: HUN-0699-21494)
 W !! S DA=""
 S DIC="^DPT(",DIC(0)="AEQM",DIC("A")="Select Patient Name: "
 D ^DIC K DIC Q:+Y<1
 S DFN=+Y
 D EDIT1
 K DFN,DA
 G EDIT
 ;
EDIT1 ;
 S %DT="AEQ",%DT("A")="Select Date to Begin Searching Back From: "
 S %DT("B")="Today"
 W !! D ^%DT Q:+Y<1  S PSBDT=Y
 F  D  Q:'PSBDT
 .W @IOF,!,"Searching Date " S Y=PSBDT D D^DIQ W Y
 .W !," #  Medication",?45,"St",?50,"D/T Given",?75,"Int"
 .W !,$TR($J("",IOM)," ","-")
 .S PSBSRCH=PSBDT+.9,PSBCNT=0
 .K PSBTMP
 .F  S PSBSRCH=$O(^PSB(53.79,"APRN",DFN,PSBSRCH),-1) Q:'PSBSRCH!(PSBSRCH<PSBDT)  D
 ..S PSBIEN=""
 ..F  S PSBIEN=$O(^PSB(53.79,"APRN",DFN,PSBSRCH,PSBIEN),-1) Q:'PSBIEN  D
 ...Q:$P($G(^PSB(53.79,PSBIEN,.2)),U,2)]""
 ...Q:$P($G(^PSB(53.79,PSBIEN,0)),U,9)'="G"
 ...S PSBCNT=PSBCNT+1,PSBTMP(PSBCNT)=PSBIEN
 ...I $Y>19 W ! S DIR(0)="E" D ^DIR W @IOF,!,"Searching Date " S Y=PSBDT D D^DIQ W Y,!," #  Medication",?45,"St",?50,"D/T Given",?75,"Int",!,$TR($J("",IOM)," ","-")
 ...W !,$J(PSBCNT,2),". "
 ...W ?5,$$GET1^DIQ(53.79,PSBIEN_",",.08)
 ...W ?45,$P(^PSB(53.79,PSBIEN,0),U,9)
 ...W ?50,$$GET1^DIQ(53.79,PSBIEN_",",.06)
 ...W ?75,$$GET1^DIQ(53.79,PSBIEN_",","ACTION BY:INITIAL")
 .I PSBCNT W ! S DIR(0)="NO^1:"_PSBCNT_":0" D ^DIR S:Y DA=PSBTMP(Y),PSBDT="" Q:Y
 .I 'PSBCNT W !!?5,"No Meds Found!"
 .S X1=PSBDT,X2=-1 D C^%DTC S (PSBDT,Y)=X D D^DIQ
 .W !!,"Continue With ",Y
 .S %=1 D YN^DICN I %'=1 S PSBDT=0
 I DA S DDSFILE=53.79,DR="[PSB PRN EFFECTIVENESS]" D ^DDS S %=2 W !,"Edit another entry" D YN^DICN G:%=1 EDIT1
 K PSBCNT,PSBDT,PSBIEN,PSBSRCH,PSBTMP,DA,DR,DDSFILE
 Q
 ;
GETPRNS(RESULTS,DFN,PSBORD) ; Get the PRN's for a pt needing effectness
 ;
 ; RPC PSB GETPRNS
 ;
 ; Description:
 ; Returns all administrations of a PRN order that have NOT had
 ; the PRN Effectiveness documented BASED ON THE TRANSFER DATE AND SITE PARAM
 ;
 N PSBIEN,PSBSTOP
 K ^TMP("PSB",$J),RESULTS
 ;
 Q:$$DISCHRGD(DFN)
 ;
 D INP^VADPT S PSBTRDT=+VAIN(7)
 S PSBHOUR=$$GET^XPAR("DIV","PSB PRN DOCUMENTATION") I PSBHOUR="" S PSBHOUR=72
 D NOW^%DTC S PSBSTRT=%,PSBPRNDT=$$FMADD^XLFDT(PSBSTRT,"",-PSBHOUR)
 ;
 ;Use the (OLDER) value of PSBPRNDT(site param) or PSBTRDT(admission)
 I PSBPRNDT>PSBTRDT S PSBPRNDT=PSBTRDT
 S PSBSTRT="" F  S PSBSTRT=$O(^PSB(53.79,"APRN",DFN,PSBSTRT),-1) Q:(PSBSTRT<PSBPRNDT)  D
 .S PSBIEN=""
 .F  S PSBIEN=$O(^PSB(53.79,"APRN",DFN,PSBSTRT,PSBIEN),-1) Q:'PSBIEN  D
 ..Q:(PSBORD'="")&($P(^PSB(53.79,PSBIEN,.1),U)'=PSBORD)  ;  Not the right order
 ..I ($P(^PSB(53.79,PSBIEN,0),U,9)'="G")&($P(^PSB(53.79,PSBIEN,0),U,9)'="RM") Q    ; Med was never given
 ..Q:$P($G(^PSB(53.79,PSBIEN,.2)),U,2)]""  ; Already entered
 ..S PSBX=PSBIEN_U_DFN,PSBIENS=PSBIEN_","
 ..S PSBX=PSBX_U_$$GET1^DIQ(53.79,PSBIENS,.02)
 ..S PSBX=PSBX_U_$$GET1^DIQ(53.79,PSBIENS,.06,"I")
 ..S PSBX=PSBX_U_$$GET1^DIQ(53.79,PSBIENS,.07)
 ..S PSBX=PSBX_U_$$GET1^DIQ(53.79,PSBIENS,.08)
 ..S PSBX=PSBX_U_$$GET1^DIQ(53.79,PSBIENS,.21)
 ..D PSJ1^PSBVT(DFN,$$GET1^DIQ(53.79,PSBIENS,.11))
 ..S PSBX=PSBX_U_PSBOIT_U_PSBONX
 ..S PSBX=PSBX_U_$$GET1^DIQ(53.79,PSBIENS,.27)
 ..S Y=$O(^TMP("PSB",$J,""),-1)+1
 ..S ^TMP("PSB",$J,Y)=PSBX
 ..;Special instructions
 ..S Y=Y+1,^TMP("PSB",$J,Y)=PSBOTXT
 ..F PSBZ=.5,.6,.7 F PSBY=0:0 S PSBY=$O(^PSB(53.79,PSBIEN,PSBZ,PSBY)) Q:'PSBY  D
 ...S PSBDD=$S(PSBZ=.5:53.795,PSBZ=.6:53.796,1:53.797)
 ...S PSBSOL=$S(PSBZ=.5:"DD",PSBZ=.6:"ADD",1:"SOL")
 ...Q:'$D(^PSB(53.79,PSBIEN,PSBZ,PSBY))
 ...S PSBUNIT=$$GET1^DIQ(PSBDD,PSBY_","_PSBIEN_",",.03)
 ...S PSBUNFR=$$GET1^DIQ(PSBDD,PSBY_","_PSBIEN_",",.04)
 ...S Y=Y+1
 ...S ^TMP("PSB",$J,Y)=PSBSOL_U_$$GET1^DIQ(PSBDD,PSBY_","_PSBIEN_",",.01)_U_PSBUNIT_U_PSBUNFR
 ..S Y=Y+1,^TMP("PSB",$J,Y)="END"
 S ^TMP("PSB",$J,0)=+$O(^TMP("PSB",$J,""),-1)
 S RESULTS=$NAME(^TMP("PSB",$J))
 K PSBTRDT,PSBHOUR,PSBPRNDT
 D CLEAN^PSBVT
 Q
 ;
DISCHRGD(DFN) ; Patient Discharged OR Deceased?
 ;
 S DISCHRGD=0
 ;
 D DEM^VADPT ;check for date of death entry
 I VADM(6)]"" S DISCHRGD=1,^TMP("PSB",$J,0)=0 K VADM
 ;
 I DISCHRGD=0 D  ;check for discharge if they're not dead
 .D INP^VADPT
 .I VAIN(1)']"" S DISCHRGD=1,^TMP("PSB",$J,0)=0 K VAIN
 ;
 I DISCHRGD D  ;setup results and clean up
 .S RESULTS=$NAME(^TMP("PSB",$J))
 .K PSBTRDT,PSBHOUR,PSBPRNDT
 .D CLEAN^PSBVT
 ;
 Q DISCHRGD
 ;
