PSUMAPR ;BHM/PDW-REPORT OF MAP OAU,NAOU,DA LOCATION TO DIVISION/OUTPATIENT SITES ; 9SEP2003
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**7,9**;MARCH, 2005;Build 6
 ;
 ;DBIA's
 ; Reference to file (#58.1) supported by DBIA 2515
 ; Reference to file (#58.8) supported by DBIA 2519
 ; Reference to file (#59.7)  supported by DBIA 2854
 ;
EN ; select Editing or Report of Mapping
 N C
 K PG,LINE,LINE2
 S PSQUIT=0,HDR="",$P(LINE,"=",79)="",$P(LINE2,"-",15)=""
 D PGH
AOU S HDR="AR/WS AOU" D PGH1
 S C=0
 S PSNM="" F  S PSNM=$O(^PSI(58.1,"B",PSNM)) Q:PSNM=""  D  Q:PSQUIT
 . S PSDA=0 F  S PSDA=$O(^PSI(58.1,"B",PSNM,PSDA)) Q:PSDA'>0  D  Q:PSQUIT
 .. D BRK Q:PSQUIT
 .. S C=C+1
 .. W !,PSNM
 .. S IEN=PSDA_",1",PSDIV=$$GET1^DIQ(59.79001,IEN,.02),PSOP=$$GET1^DIQ(59.79001,IEN,.03) W:$L(PSDIV) ?30,"Div: ",PSDIV W:$L(PSOP) ?30,"Op:  ",PSOP
 .. S PSINADT=$$GET1^DIQ(58.1,PSDA,3,"I") I PSINADT W ?60,$$FMTE^XLFDT(PSINADT,"D")
 W !
 D PG Q:PSQUIT
 ;
NAOU ;CS NAOU  Drug Accountability 'Primary
 Q:PSQUIT
 S HDR="CS NAOU" D PGH1
 S C=0
 S PSNM="" F  S PSNM=$O(^PSD(58.8,"B",PSNM)) Q:PSNM=""  D  Q:PSQUIT
 . S PSDA=0 F  S PSDA=$O(^PSD(58.8,"B",PSNM,PSDA)) Q:PSDA'>0  D
 .. S PSN0=^PSD(58.8,PSDA,0),PSTYP=$P(PSN0,U,2),PSINADT=+$G(^PSD(58.8,PSDA,"I"))
 .. I PSTYP="P" Q
 .. D BRK Q:PSQUIT
 .. S C=C+1
 .. W !,PSNM
 .. S IEN=PSDA_",1",PSDIV=$$GET1^DIQ(59.79002,IEN,.02),PSOP=$$GET1^DIQ(59.79002,IEN,.03) W:$L(PSDIV) ?30,"Div: ",PSDIV W:$L(PSOP) ?30,"Op:  ",PSOP
 .. S PSINADT=$$GET1^DIQ(58.8,PSDA,4,"I")
 .. I PSINADT W ?60,$$FMTE^XLFDT(PSINADT,"D")
 W !
 D PG Q:PSQUIT
 ;
DRACC ;
 Q:PSQUIT
 S HDR="DRUG ACCOUNTABILITY"
 D PGH1
 S C=0
 S PSNM="" F  S PSNM=$O(^PSD(58.8,"B",PSNM)) Q:PSNM=""  D  Q:PSQUIT
 . S PSDA=0 F  S PSDA=$O(^PSD(58.8,"B",PSNM,PSDA)) Q:'PSDA  D
 .. S PSN0=^PSD(58.8,PSDA,0),PSTYP=$P(PSN0,U,2)
 .. S PSINADT=+$G(^PSD(58.8,PSDA,"I"))
 .. I PSTYP'="P" Q
 .. D BRK Q:PSQUIT
 .. S C=C+1
 .. W !,PSNM
 .. S IEN=PSDA_",1",PSDIV=$$GET1^DIQ(59.79003,IEN,.02),PSOP=$$GET1^DIQ(59.79003,IEN,.03) W:$L(PSDIV) ?30,"Div: ",PSDIV W:$L(PSOP) ?30,"Op:  ",PSOP
 .. S PSINADT=$$GET1^DIQ(58.8,PSDA,4,"I")
 .. I PSINADT W ?60,$$FMTE^XLFDT(PSINADT,"D")
 ;
 I $E(IOST)="C" W !! K DIR S DIR(0)="EA",DIR("A")="Report Finished <cr>" D ^DIR
 Q
EN1 ;Scan for unmapped locations
 ;Called from PSUOP0
 ;
 N PSULOC,PSULOC1,PSULOC2
 S PSQUIT=0
 D AOU1       ;Look for AR/WS AOU's
 D NAOU1      ;Look for CS NAOU's
 D DRACC1     ;Look for Drug Accountability Pharmacy Locations
 D UNMAPD
 D MAPD
 Q
 ; 
AOU1 ;Find AR/WS AOU's and set unmapped locations into AOU array
 ;
 S PSULOC=" AR/WS AOU's "
 ;
 K AOU
 S PSNM="" F  S PSNM=$O(^PSI(58.1,"B",PSNM)) Q:PSNM=""  D  Q:PSQUIT
 .S PSDA=0 F  S PSDA=$O(^PSI(58.1,"B",PSNM,PSDA)) Q:PSDA'>0  D
 ..S IEN=PSDA_",1",PSDIV=$$GET1^DIQ(59.79001,IEN,.02)
 ..S PSOP=$$GET1^DIQ(59.79001,IEN,.03)
 ..I '$L(PSDIV),'$L(PSOP) S AOU(PSNM,PSDA)=$$GET1^DIQ(58.1,PSDA,3)
 Q
 ;
NAOU1 ;Find Controlled Substances AOU's and set unmapped locations
 ;into NAOU array
 ;
 S PSULOC1=" CS NAOUs "
 ;
 K NAOU
 S PSNM="" F  S PSNM=$O(^PSD(58.8,"B",PSNM)) Q:PSNM=""  D  Q:PSQUIT
 .S PSDA=0
 .F  S PSDA=$O(^PSD(58.8,"B",PSNM,PSDA)) Q:PSDA'>0  D
 ..S PSN0=^PSD(58.8,PSDA,0)
 ..S PSTYP=$P(PSN0,U,2)
 ..S PSINADT=+$G(^PSD(58.8,PSDA,"I"))
 ..I PSTYP="P" Q
 ..S IEN=PSDA_",1"
 ..S PSDIV=$$GET1^DIQ(59.79002,IEN,.02)
 ..S PSOP=$$GET1^DIQ(59.79002,IEN,.03)
 ..I '$L(PSDIV),'$L(PSOP) S NAOU(PSNM,PSDA)=$$GET1^DIQ(58.8,PSDA,4)
 Q
 ;
DRACC1 ;Find DA Pharmacy Locations and set unmapped locations into DRAC array
 ;
 S PSULOC2=" DA Pharmacy Locations "
 ;
 K DRAC
 S PSNM="" F  S PSNM=$O(^PSD(58.8,"B",PSNM)) Q:PSNM=""  D  Q:PSQUIT
 .S PSDA=0
 .F  S PSDA=$O(^PSD(58.8,"B",PSNM,PSDA)) Q:'PSDA  D
 ..S PSN0=^PSD(58.8,PSDA,0),PSTYP=$P(PSN0,U,2)
 ..S PSINADT=+$G(^PSD(58.8,PSDA,"I"))
 ..I PSTYP'="P" Q
 ..S IEN=PSDA_",1"
 ..S PSDIV=$$GET1^DIQ(59.79003,IEN,.02)
 ..S PSOP=$$GET1^DIQ(59.79003,IEN,.03)
 ..I '$L(PSDIV),'$L(PSOP) S DRAC(PSNM,PSDA)=$$GET1^DIQ(58.8,PSDA,4)
 Q
 ;
MAPD ;Display this if all locations are mapped
 ;
 I '$D(AOU),'$D(NAOU),'$D(DRAC) D  Q
 . W !!,?3,"All pharmacy dispensing/procurement locations are mapped.",!
 Q
 ;
UNMAPD ;Display this if unmapped locations exist
 ;
 N C
 W !
 I $D(AOU) S PSNM="" D            ;Unmapped AR/WS AOU's
 .S C=0
 .W !,?5,"The following"_PSULOC_"are not mapped:"
 .W !
 .F  S PSNM=$O(AOU(PSNM)) Q:PSNM=""  D  Q:PSQUIT
 ..S PSDA=0
 ..F  S PSDA=$O(AOU(PSNM,PSDA)) Q:PSDA'>0  D  Q:PSQUIT
 ...W !,?10,PSNM
 ...I AOU(PSNM,PSDA)'=""  W ?40,"**Inactive**"
 ...D BRK Q:PSQUIT
 ...I C=(IOSL-5) S C=0
 ...S C=C+1
 W !
 D PG Q:PSQUIT
 ;
 I $D(NAOU) S PSNM="" D           ;Unmapped CS NAOUs
 .S C=0
 .W !,?5,"The following"_PSULOC1_"are not mapped:"
 .W !
 .F  S PSNM=$O(NAOU(PSNM)) Q:PSNM=""  D  Q:PSQUIT
 ..S PSDA=0
 ..F  S PSDA=$O(NAOU(PSNM,PSDA)) Q:PSDA'>0  D  Q:PSQUIT
 ...W !,?10,PSNM
 ...I NAOU(PSNM,PSDA)'="" W ?40,"**Inactive**"
 ...D BRK Q:PSQUIT
 ...I C=(IOSL-5) S C=0
 ...S C=C+1
 W !
 D PG Q:PSQUIT
 ;
 I $D(DRAC) S PSNM="" D          ;Unmapped DA Pharmacy Locations
 .S C=0
 .W !,?5,"The following"_PSULOC2_"are not mapped:"
 .W !
 .F  S PSNM=$O(DRAC(PSNM)) Q:PSNM=""  D  Q:PSQUIT
 ..S PSDA=0
 ..F  S PSDA=$O(DRAC(PSNM,PSDA)) Q:PSDA'>0  D  Q:PSQUIT
 ...W !,?10,PSNM
 ...I DRAC(PSNM,PSDA)'="" W ?40,"**Inactive**"
 ...D BRK Q:PSQUIT
 ...I C=(IOSL-5) S C=0
 ...S C=C+1
 W !
 D PG Q:PSQUIT
 Q
 ;
BRK ;Page break. Occurs in the middle of a list
 ;
 I C=(IOSL-5) D
 .W !
 .K DIR I $E(IOST)="C" S DIR(0)="E" D ^DIR
 .I $D(Y),Y=0 S PSQUIT=1 Q
 .S PG=$G(PG)+1
 .W @IOF
 ;Q:$E(IOST,1,2)'="C-"!($D(IO("S")))
 ;K DIR W !
 ;S DIR(0)="E" D ^DIR K DIR
 ;I 'Y S PSQUIT=1 Q
 Q
 ;
PG ;Page break between headers
 ;
 K DIR I $E(IOST)="C" S DIR(0)="E" D ^DIR I Y=0 S PSQUIT=1 Q
 S PG=$G(PG)+1
 W @IOF
 Q
 ;
PGH W @IOF
 W !,"MAPPED/UNMAPPED LOCATIONS"
 W ?30,$$FMTE^XLFDT(DT)
 S PG=$G(PG)+1 W ?60,"PAGE: ",PG,!,LINE,!,"NAME",?30,"DIVISION/OUTPATIENT SITE",?60,"INACTIVE DATE"
PGH1 I $L(HDR) W !!,$G(HDR),!,LINE2
 Q
PGB I $Y<(IOSL-4) S PSQUIT=1 Q
PGHB W @IOF
 W !,"UNMAPPED LOCATIONS"
 W ?30,$$FMTE^XLFDT(DT)
 S PG=$G(PG)+1 W ?60,"PAGE: ",PG,!,LINE,!,"NAME",?40,"INACTIVE DATE"
PGH1B I $L(HDR) W !!,$G(HDR),!,LINE2
 Q
