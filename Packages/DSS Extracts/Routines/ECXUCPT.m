ECXUCPT ;ALB/TJL-CPT INQUIRY FOR MYSTERY FEEDER KEYS ; 10/15/03 2:12pm
 ;;3.0;DSS EXTRACTS;**49,123**;July 1, 2003;Build 8
 ;
EN ; entry point
 N X,Y,DATE,ECRUN,QFLG
 S QFLG=0
 ; get today's date
 D NOW^%DTC S DATE=X,Y=$E(%,1,12) D DD^%DT S ECRUN=$P(Y,"@") K %DT
 D BEGIN
 F  D SELECT W @IOF Q:QFLG
 Q
 ;
BEGIN ; display report description
 W @IOF
 W !,"This inquiry allows the user to select a CPT code, then displays"
 W !,"the Short Name, Category, and Description for the selected code."
 W !!
 Q
 ;
SELECT ; user inputs for CPT Code
 N OUT,DIC,X,Y,DIR,CIEN,ECXARR,ECXIEN
 S DIC="^ICPT(",DIC(0)="AZEMQ" D ^DIC
 I Y<0 S QFLG=1 Q
 S ECXIEN=+Y
 S ECXARR=$$CPT^ICPTCOD(ECXIEN) I +ECXARR=-1 W !,"CPT Code Error." S QFLG=1 Q
 S CIEN=$P(ECXARR,U,4) I CIEN S ECXARR(81.1)=$$GET1^DIQ(81.1,CIEN_",",.01)
 S X=$$CPTD^ICPTCOD(ECXIEN,"ECXARR(81.01,")
 D PRINT
 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1
 Q
 ;
PRINT ; display results of inquiry
 N LN,DESCDA
 S $P(LN,"-",80)=""
 W !!,"CPT Inquiry",?54,"Date: ",ECRUN,!,LN,!
 W !,"CPT Code: ",$P(ECXARR,U,2)
 W ?30,"Short Name: ",$P(ECXARR,U,3)
 W !!,"Category: ",$G(ECXARR(81.1))
 W !!,"Description: "
 F DESCDA=1:1 Q:'$D(ECXARR(81.01,DESCDA))  D
 .W ECXARR(81.01,DESCDA),!
 W !!!
 Q
 ;
