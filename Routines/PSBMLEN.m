PSBMLEN ;BIRMINGHAM/EFC-BCMA MEDICATION LOG FUNCTIONS ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**4,9,19**;Mar 2004
 ;
 ; Reference/IA
 ; EN^PSJBCMA/2828
 ; ENE^PSJBCMA4/3416
 ; ENR^PSJBCMA4/3416
 ; ^XUSEC/10076
 ; ^DPT/10035
 ; $$GET^XPAR/2263
 ; HLP^DDSUTL/10150
 ;
EN ;
 N PSBCNT,PSBDT,PSBERR,PSBFORM,PSBMED,PSBNOW,PSBSCHT,PSBVARD,PSBX,PSBFREQ,PSBFLAG
 K ^TMP("PSB",$J),^TMP("PSJ",$J),PSBREC
 W @IOF,!,"Manual Medication Entry",!
 I $D(^XUSEC("PSB READ ONLY",DUZ)) W !,"This option is NOT AVAILABLE in PSB READ ONLY mode.",! Q
 W !,"Notice: No validation of medications is done with this option."
 W !,"Entries in the Med Log created with this option will reflect this"
 W !,"in the comments.",!!
 S DIC="^DPT(",DIC(0)="AEQM",DIC("A")="Select PATIENT: "
 D ^DIC K DIC Q:+Y<1
 S DFN=+Y
 D EN1
 K ^TMP("PSBO",$J)
 Q
 ;
EN1 ;
 S %DT="AEQ",%DT("B")="Today",%DT("A")="Select Orders From Date: "
 D ^%DT Q:+Y<1  S PSBDT=+Y
 W !,"Searching for Orders..."
 K ^TMP("PSJ",$J)
 D EN^PSJBCMA(DFN,PSBDT,"")
 Q:$G(^TMP("PSJ",$J,1,0))=-1
 S PSBERR=0
 D NOW^%DTC S PSBNOW=%
 F PSBX=0:0 S PSBX=$O(^TMP("PSJ",$J,PSBX)) Q:'PSBX  D
 .D CLEAN^PSBVT,PSJ^PSBVT(PSBX)
 .Q:PSBONX?.N1"P"  ; No Pending Yet
 .I "PCS"'[PSBIVT,PSBONX'["U" Q
 .I PSBIVT["S",PSBISYR'=1 Q  ;    allow intermittent syringe only
 .I PSBIVT["C",PSBCHEMT'="P",PSBISYR'=1 Q
 .I PSBIVT["C",PSBCHEMT="A" Q  ;     allow Chemo with intermittent syringe or Piggyback type only
 .K ^TMP("PSBO",$J)
 .S PSBOUT=0
 .D:PSBSCHT="C"
 ..;Calculate admin times based on Frequency from IPM
 ..S (PSBYES,PSBODD)=0
 ..S:$$PSBDCHK1^PSBVT1(PSBSCH) PSBYES=1
 ..I PSBYES,PSBADST="" S PSBOUT=1 Q
 ..I PSBSCH?2.4N.E S PSBYES=1
 ..S PSBFREQ=$$GETFREQ^PSBVDLU1(DFN,PSBONX)
 ..I PSBFREQ="O" S PSBYES=1
 ..I 'PSBYES,PSBADST="",PSBFREQ<1 S PSBOUT=1 Q
 ..I (PSBFREQ#1440'=0),(1440#PSBFREQ'=0) S PSBODD=1
 ..I PSBODD,PSBADST'="" S PSBOUT=1 Q
 ..I PSBADST="" S PSBADST=$$GETADMIN^PSBVDLU1(DFN,PSBONX,PSBOST,PSBFREQ,PSBDT)
 ..E  K ^TMP("PSB",$J,"GETADMIN") S ^TMP("PSB",$J,"GETADMIN",0)=PSBADST
 ..F PSBY=1:1 Q:$P(PSBADST,"-",PSBY)=""  I ($P(PSBADST,"-",PSBY)'?2N)&($P(PSBADST,"-",PSBY)'?4N) S PSBOUT=1 Q  ; Validate time(s)
 .Q:PSBOUT
 .Q:PSBOST>PSBNOW  ; Future Start Date
 .I PSBSCHT="O" S (PSBGVN,X,Y)="" D  I (PSBGVN)!(PSBNGF) K PSBGVN,X,Y Q
 ..F  S X=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X),-1) Q:'X  D
 ...F  S Y=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X,Y),-1) Q:'Y  S:($P(^PSB(53.79,Y,.1),U)=PSBONX)&($P(^PSB(53.79,Y,0),U,9)'="N") PSBGVN=1,(X,Y)=0
 .I PSBSCHT="OC" S (PSBGVN,X,Y)="" D  I PSBGVN K PSBGVN,X,Y Q
 ..F  S X=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X),-1) Q:'X  D
 ...F  S Y=$O(^PSB(53.79,"AOIP",DFN,PSBOIT,X,Y),-1) Q:'Y  S:($P(^PSB(53.79,Y,.1),U)=PSBONX)&($P(^PSB(53.79,Y,0),U,9)'="N") PSBGVN=1,(X,Y)=0
 ..S PSBGVN=PSBGVN&('$$GET^XPAR("DIV","PSB ADMIN MULTIPLE ONCALL")) Q:PSBGVN
 ..I PSBOSTS'="A"&(PSBOSTS'="R") S PSBGVN=1 Q
 ..I PSBNGF S PSBGVN=1 Q
 .S ^TMP("PSB",$J,PSBSCHT,PSBOITX,PSBX)=PSBONX_U_PSBADST_U_PSBOST_U_PSBOSP_U_PSBOSTS
 I PSBERR W ! K DIR S DIR(0)="E" D ^DIR Q:Y="^"
 ;
EN2 ;
 W $$HDR() I '$D(^TMP("PSB",$J)) W !!?5,"No Med Orders Found!",!  Q
 S PSBSCHT="",PSBCNT=0
 F  S PSBSCHT=$O(^TMP("PSB",$J,PSBSCHT)) Q:PSBSCHT=""  D
 .W !  ; Line between order types
 .S PSBMED=""
 .F  S PSBMED=$O(^TMP("PSB",$J,PSBSCHT,PSBMED)) Q:PSBMED=""  D
 ..F PSBX=0:0 S PSBX=$O(^TMP("PSB",$J,PSBSCHT,PSBMED,PSBX)) Q:'PSBX  D
 ...I $Y>(IOSL-6) W ! K DIR S DIR(0)="E" D ^DIR W:Y $$HDR() I 'Y S PSBSCHT="Z" Q
 ...S PSBCNT=PSBCNT+1
 ...W !,$J(PSBCNT,2),". ",PSBSCHT,?7,PSBMED
 ...W ?40," (",$P(^TMP("PSB",$J,PSBSCHT,PSBMED,PSBX),U,5),")"
 ...S Y=$P(^TMP("PSB",$J,PSBSCHT,PSBMED,PSBX),U,3)
 ...W:$X>44 !
 ...W ?45,"Start: ",$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_(1700+$E(Y,1,3))_" "
 ...W $E($P(Y,".",2)_"0000",1,4)
 ...S Y=$P(^TMP("PSB",$J,PSBSCHT,PSBMED,PSBX),U,4)
 ...W !?45," Stop: ",$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_(1700+$E(Y,1,3))_" "
 ...W $E($P(Y,".",2)_"0000",1,4)
 ...I $P(^TMP("PSB",$J,PSBSCHT,PSBMED,PSBX),U,2)]"" W !?7,"Admin Times: ",$P(^TMP("PSB",$J,PSBSCHT,PSBMED,PSBX),U,2)
 ...W !
 ...S ^TMP("PSBO",$J,PSBCNT)=$P(^TMP("PSB",$J,PSBSCHT,PSBMED,PSBX),U,1)
 F  Q:$Y>(IOSL-5)  W !
 K DIR S DIR(0)="NO^1:"_PSBCNT_":0" D ^DIR
 I Y S Y=^TMP("PSBO",$J,Y) D NEW^PSBMLEN1(Y) G EN2
 Q
 ;
 ;
HDR() ;
 W @IOF,"Manual Medication Entry",!," #",?4,"Sc",?7,"Medication",?41,"St"
 W !,$TR($J("",IOM)," ","-")
 Q ""
 ;
EDIT    ; Edit Medication Log
 N PSBAUDIT
 S PSBAUDIT=1
 W:'$D(^XUSEC("PSB MANAGER",DUZ)) !!?5,"Notice: You are restricted from editing any entries other than",!,"        those that you have created.",!
 S DA=""
 S DIC="^DPT(",DIC(0)="AEQM",DIC("A")="Select Patient Name: "
 D ^DIC K DIC Q:+Y<1
 S DFN=+Y
 D EDIT1
 K PSBCNT,PSBDT,PSBIEN,PSBSRCH,PSBTMP,DA,DFN,DR,DDSFILE
 G EDIT
 ;
EDIT1   ; 
 S %DT="AEQ",%DT("A")="Select Date to Begin Searching Back From: "
 W !! S %DT("B")="TODAY" D ^%DT Q:+Y<1  S PSBDT=Y
 F  D  Q:'PSBDT
 .W @IOF,!,"Searching Date " S Y=PSBDT D D^DIQ W Y
 .W !," #  Medication",?45,"St",?50,"D/T Given",?75,"Int"
 .W !,$TR($J("",IOM)," ","-")
 .S PSBSRCH=PSBDT+.9,PSBCNT=0
 .K PSBTMP
 .F  S PSBSRCH=$O(^PSB(53.79,"AEDT",DFN,PSBSRCH),-1) Q:'PSBSRCH!(PSBSRCH<PSBDT)  D
 ..S PSBIEN=""
 ..F  S PSBIEN=$O(^PSB(53.79,"AEDT",DFN,PSBSRCH,PSBIEN),-1) Q:'PSBIEN  D:$P(^PSB(53.79,PSBIEN,0),U,7)=DUZ!($D(^XUSEC("PSB MANAGER",DUZ)))
 ...Q:$P(^PSB(53.79,PSBIEN,0),U,9)="N"
 ...S PSBCNT=PSBCNT+1,PSBTMP(PSBCNT)=PSBIEN
 ...D:$Y>19
 ....W ! S DIR(0)="E" D ^DIR
 ....W @IOF,!,"Searching Date " S Y=PSBDT D D^DIQ W Y
 ....W !," #  Medication",?45,"St",?50,"D/T Given",?75,"Int"
 ....W !,$TR($J("",IOM)," ","-")
 ...W !,$J(PSBCNT,2),". "
 ...W ?5,$$GET1^DIQ(53.79,PSBIEN_",",.08)
 ...I $$GET1^DIQ(53.79,PSBIEN_",",.26) W ?5," ("_$$GET1^DIQ(53.79,PSBIEN_",",.26)_")"
 ...W ?45,$P(^PSB(53.79,PSBIEN,0),U,9)
 ...W ?50,$$GET1^DIQ(53.79,PSBIEN_",",.06)
 ...W ?75,$$GET1^DIQ(53.79,PSBIEN_",","ACTION BY:INITIAL")
 .I PSBCNT D  Q:Y
 ..W ! S DIR(0)="NO^1:"_PSBCNT_":0" D ^DIR
 ..I Y S DA=PSBTMP(Y),PSBDT=""
 .I 'PSBCNT W !!?5,"No Meds Found!"
 .S X1=PSBDT,X2=-1 D C^%DTC S (PSBDT,Y)=X D D^DIQ
 .W !!,"Continue With ",Y
 .S %=1 D YN^DICN I %'=1 S PSBDT=0
 I DA D
 .S PSBCOMP="",PSBDFN=$$GET1^DIQ(53.79,DA_",",.01,"I"),PSBONX=$$GET1^DIQ(53.79,DA_",",.11),PSBSTUS=$$GET1^DIQ(53.79,DA_",",.09,"I")
 .I PSBONX["V",PSBSTUS'="G" D  Q:PSBCOMP=1
 ..S PSBBAGN=$$GET1^DIQ(53.79,DA_",",.26) D INFUSING^PSBVDLU2 Q:PSBCOMP=0
 ..I $D(PSBPORA(PSBONX)) S X="" F  S X=$O(PSBPORA(PSBONX,X)),PSBBAG2=$P(PSBPORA(PSBONX,X),U,1),PSBBAGST=$P(PSBPORA(PSBONX,X),U,2) Q:PSBBAG2]""
 ..I PSBBAGN=PSBBAG2 S PSBCOMP=0 Q
 ..I (PSBBAGN'=PSBBAG2),PSBBAGST'="C" D 
 ...W !!,"Bag "_PSBBAG2_" is marked as ",$S(PSBBAGST="I":"Infusing",PSBBAGST="S":"Stopped",1:"unk")
 ...W !,"This bag must be completed before bag "_PSBBAGN_" can be edited.",!!
 ...K PSBORA,PSBBAGN,PSBBAG2,PSBBAGST
 .I PSBONX["V" D PSJ1^PSBVT(PSBDFN,PSBONX)
 .S DDSFILE=53.79 D
 ..I PSBONX["U" S DR="[PSB MED LOG EDIT]" Q
 ..I PSBIVT["P" S DR="[PSB MED LOG EDIT]" Q
 ..I PSBIVT["S",PSBISYR=1  S DR="[PSB MED LOG EDIT]" Q
 ..I PSBIVT["C",PSBISYR=1  S DR="[PSB MED LOG EDIT]" Q
 ..I PSBIVT["C",PSBCHEMT="P"  S DR="[PSB MED LOG EDIT]" Q
 ..S DR="[PSB MED LOG EDIT IV]" Q
 .D ^DDS
 .;One time order reinstated if not given
 .D:($P(^PSB(53.79,DA,.1),U,2)="O")&($P(^PSB(53.79,DA,0),U,9)="N") ENR^PSJBCMA4(DFN,$P(^PSB(53.79,DA,.1),U,1))
 .D:($P(^PSB(53.79,DA,.1),U,2)="O")&($P(^PSB(53.79,DA,0),U,9)="G") ENE^PSJBCMA4(DFN,$P(^PSB(53.79,DA,.1),U,1))
 Q
 ;
VALID ;
 I $G(PSBSTUS)="RM","^RM^"'[("^"_X_"^") W $C(7) S DDSERROR=1 D HLP^DDSUTL("Status of Removed cannot be changed.") Q
 I $G(PSBREC(7))'="Entry created with 'Manual Medication Entry' option." D  Q
 .I ($D(^PSB(53.79,DA,.5,1,0))),($P($G(^PSB(53.79,DA,.5,1,0)),U,4)="PATCH") D  Q
 ..I "^G^N^H^R^RM^"'[("^"_X_"^") W $C(7) S DDSERROR=1 D HLP^DDSUTL("Allowed status codes are Given, Not Given, Held, Refused and Removed.")
 .I "^G^N^H^R^"'[("^"_X_"^") W $C(7) S DDSERROR=1 D HLP^DDSUTL("Allowed status codes are Given, Not Given, Held, and Refused.")
 I "^G^H^R^"'[("^"_X_"^") W $C(7) S DDSERROR=1 D HLP^DDSUTL("Allowed status codes are Given, Held, and Refused.") Q
 ;
UNITS ;Check UNITS field for entry of PATCH
 I Y'="PATCH" Q
 S (DDSERROR,DDSBR)=1
 S @DDSREFT@("F"_DDP,DDSDA,DDSFLD,"D")=DDSOLD
 W $C(7)
 D HLP^DDSUTL("Field cannot be changed to PATCH")
 D REFRESH^DDSUTL
 Q
 ;
