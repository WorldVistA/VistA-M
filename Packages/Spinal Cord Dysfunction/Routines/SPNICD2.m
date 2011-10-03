SPNICD2 ;SAN/WDE/Report of PT's with particular ICD9's
 ;;2.0;Spinal Cord Dysfunction;**14,15**;01/02/1997
EN ;
 S Y=SPNSTRT X ^DD("DD") S SPNSTRT=Y,Y=SPNEND X ^DD("DD") S SPNEND=Y K Y
 S (SPNPA,SPNEXIT)=0 I $D(^UTILITY($J))=0 S SPNPA=1 D HDR W !,"No data to report",!!! I $E(IOST,1)="C" N DIR S DIR(0)="E" D ^DIR I 'Y S SPNEXIT=1 D CLOSE^SPNPRTMT Q
 S SPNDFN=0 F  S SPNDFN=$O(^UTILITY($J,SPNDFN)) Q:(SPNDFN=0)!('+SPNDFN)  D EN2
 D ZAP^SPNICD1
 D CLOSE^SPNPRTMT
 Q
 ;-----------------------------------------------------------------
EN2 S SPNPTF=0 F  S SPNPTF=$O(^UTILITY($J,SPNDFN,SPNPTF)) Q:(SPNPTF=0)!('+SPNPTF)  D EN3
 Q
 ;----------------------------------------------------------------
EN3 I SPNPA=0 S SPNPA=1  D HDR
 S SPNDATA=$G(^UTILITY($J,SPNDFN,SPNPTF)) Q:SPNDATA=""
 S SPNREG=$$GET1^DIQ(154,SPNDFN_",",.03)
 I SPNREG="" S SPNREG="**NOT IN REGISTRY**"
 S SPNAM=$P(^DPT(SPNDFN,0),U,1),SPNSSN=$P(^DPT(SPNDFN,0),U,9)
 S SPNLVL=$$GET1^DIQ(154,SPNDFN_",",2.1)
 W !,$E(SPNAM,1,28),?30,SPNSSN,?40,SPNREG,?67,SPNLVL
 W !,"Admission: ",$$GET1^DIQ(45,SPNPTF_",",2)
 W !,"DXLS: ",$$GET1^DIQ(45,SPNPTF_",",79)
 W ?14,"ICD2: ",$$GET1^DIQ(45,SPNPTF_",",79.16)
 W ?28,"ICD3: ",$$GET1^DIQ(45,SPNPTF_",",79.17)
 W ?42,"ICD4: ",$$GET1^DIQ(45,SPNPTF_",",79.18)
 W ?56,"ICD5: ",$$GET1^DIQ(45,SPNPTF_",",79.19)
 W !,"ICD6: ",$$GET1^DIQ(45,SPNPTF_",",79.201)
 W ?14,"ICD7: ",$$GET1^DIQ(45,SPNPTF_",",79.21)
 W ?28,"ICD8: ",$$GET1^DIQ(45,SPNPTF_",",79.22)
 W ?42,"ICD9: ",$$GET1^DIQ(45,SPNPTF_",",79.23)
 W ?56,"ICD10: ",$$GET1^DIQ(45,SPNPTF_",",79.24)
 W !,"----------------------------------------------------------------------------"
 I $Y>(IOSL-5) D HDR I SPNEXIT=1 K ^UTILITY($J) Q
 Q
 ;---------------------------------------------------------------
HDR ;
 I $E(IOST,1)="P" I SPNPA'=1 W #
 I $E(IOST,1)="C" D  Q:SPNEXIT
 .I SPNPA=1 W @IOF Q
 .I SPNPA'=1 D  Q:SPNEXIT
 ..N DIR S DIR(0)="E" D ^DIR I 'Y S SPNEXIT=1
 ..K Y
 ..W @IOF
 ..Q
 .Q
 Q:SPNEXIT
 S SPNTAB=$S(SPNANS=1:18,SPNANS=2:23,1:2)
 W !?SPNTAB,$S(SPNIN="JUST":"Patients in the Registry only",1:"Combined report -- Pts in Registry AND all others")
 W !?29,"ICD9 Code Search",?72,"Page: ",SPNPA
 W !?10,"Ran on admissions from ",SPNSTRT," to ",SPNEND
 W !!!,"Patient",?30,"SSN",?40,"Registration Status",?65,"SCI Level"
 W !,"Admission Date"
 W !,"-----------------------------------------------------------------------------"
 S SPNPA=SPNPA+1
