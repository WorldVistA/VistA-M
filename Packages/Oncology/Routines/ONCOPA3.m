ONCOPA3 ;Hines OIFO/GWB-[PA Print Complete Abstract (132c)] continued ;10/07/11
 ;;2.11;ONCOLOGY;**13,15,18,25,26,33,34,36,37,44,45,46,47,48,50,51,54**;Mar 07, 1995;Build 10
 ;
 N ALHS,ALTP,ALZN,CFH,CHST,NOK,OC,OCCP,RCDT,TBHS,TBTP,TBZN,TX,Y
 S NAME="PERSONAL DATA" D FORMAT^ONCOPA1
 W !!,TITLE
 W !!?10,"             Address at Dx: ",ONCAB(165.5,IEN,8)
 W !?10,"      Address at Dx - Supp: ",ONCAB(165.5,IEN,8.2)
 W !?10,"           City/Town at Dx: ",ONCAB(165.5,IEN,8.1),?70,"     Place of Birth: ",ONCAB(160,PTIEN,7) D P Q:EX=U
 W !?10,"               State at Dx: ",ONCAB(165.5,IEN,16),?70,"           Religion: ",$E(ONCAB(160,PTIEN,13),1,14) D P Q:EX=U
 W !?10,"         Postal Code at Dx: ",ONCAB(165.5,IEN,9),?69,"Marital Status at Dx: ",ONCAB(165.5,IEN,11) D P Q:EX=U
 W !?10,"              County at Dx: ",ONCAB(165.5,IEN,10),?70,"Primary Payer at Dx: ",ONCAB(165.5,IEN,18) D P Q:EX=U
 W !?10,"                 Telephone: ",ONCAB(160,PTIEN,.131)
 S NOK=""
 I $D(^ONCO(160,PTIEN,0)) S RCDT=$G(^ONCO(160,PTIEN,0)) I $P(RCDT,";",2)["DPT",$D(^DPT($P(RCDT,";",1),.21)) S NOK=$P(^(.21),U)_" ("_$P(^(.21),U,2)_")"
 I ESPD=1 S NOK="XXXXX,XXXXX"
 W ?70,"        Next of Kin: ",NOK D P Q:EX=U
 W !?10,"           Abstract Status: ",ONCAB(165.5,IEN,91) D P Q:EX=U
 W !?10,"     Date of First Contact: ",ONCAB(165.5,IEN,155) D P Q:EX=U
 W !?10,"       Date Case Completed: ",ONCAB(165.5,IEN,90) D P Q:EX=U
 W !?8,"Elapsed Months to Completion: ",ONCAB(165.5,IEN,157.1,"E") D P Q:EX=U
 W !?10,"             Abstracted by: ",ONCAB(165.5,IEN,92) D P Q:EX=U
 W !
 W !?1,"               Other Cancer:  ",ONCAB(165.5,IEN,148,"E") D P Q:EX=U
 W !?1,"                  Cancer #1:  ",ONCAB(165.5,IEN,148.1,"E") D P Q:EX=U
 W !?1,"                  Cancer #2:  ",ONCAB(165.5,IEN,148.2,"E") D P Q:EX=U
 W !?1,"                  Cancer #3:  ",ONCAB(165.5,IEN,148.3,"E") D P Q:EX=U
 W !?1,"                  Cancer #4:  ",ONCAB(165.5,IEN,148.4,"E") D P Q:EX=U
 W !!?7,"Agent Orange Exposure:  ",ONCAB(160,PTIEN,48) D P Q:EX=U
 W !?1,"Ionizing Radiation Exposure:  ",ONCAB(160,PTIEN,50) D P Q:EX=U
 W !?1,"          Chemical Exposure:  ",ONCAB(160,PTIEN,52) D P Q:EX=U
 W !?1,"          Asbestos Exposure:  ",ONCAB(160,PTIEN,61) D P Q:EX=U
 W !?1,"            Vietnam Service:  ",ONCAB(160,PTIEN,62) D P Q:EX=U
 W !?1,"            Lebanon Service:  ",ONCAB(160,PTIEN,55) D P Q:EX=U
 W !?1,"            Grenada Service:  ",ONCAB(160,PTIEN,63) D P Q:EX=U
 W !?1,"             Panama Service:  ",ONCAB(160,PTIEN,64) D P Q:EX=U
 W !?1,"       Persian Gulf Service:  ",ONCAB(160,PTIEN,51) D P Q:EX=U
 W !?1,"            Somalia Service:  ",ONCAB(160,PTIEN,56) D P Q:EX=U
 W !?1,"         Yugoslavia Service:  ",ONCAB(160,PTIEN,65) D P Q:EX=U
 W !?1,"  Afghanistan (OEF) Service:  ",ONCAB(160,PTIEN,67) D P Q:EX=U
 W !?1,"         Iraq (OIF) Service:  ",ONCAB(160,PTIEN,66) D P Q:EX=U
 W !?1,"          Branch of Service:  ",ONCAB(160,PTIEN,68) D P Q:EX=U
 W !!?1,"         Source Comorbidity:  ",ONCAB(160,PTIEN,1006) D P Q:EX=U
 W !?1,"Comorbidity/Complication  1:  ",ONCAB(160,PTIEN,25) D P Q:EX=U
 W !?1,"Comorbidity/Complication  2:  ",ONCAB(160,PTIEN,25.1) D P Q:EX=U
 W !?1,"Comorbidity/Complication  3:  ",ONCAB(160,PTIEN,25.2) D P Q:EX=U
 W !?1,"Comorbidity/Complication  4:  ",ONCAB(160,PTIEN,25.3) D P Q:EX=U
 W !?1,"Comorbidity/Complication  5:  ",ONCAB(160,PTIEN,25.4) D P Q:EX=U
 W !?1,"Comorbidity/Complication  6:  ",ONCAB(160,PTIEN,25.5) D P Q:EX=U
 W !?1,"Comorbidity/Complication  7:  ",ONCAB(160,PTIEN,25.6) D P Q:EX=U
 W !?1,"Comorbidity/Complication  8:  ",ONCAB(160,PTIEN,25.7) D P Q:EX=U
 W !?1,"Comorbidity/Complication  9:  ",ONCAB(160,PTIEN,25.8) D P Q:EX=U
 W !?1,"Comorbidity/Complication 10:  ",ONCAB(160,PTIEN,25.9) D P Q:EX=U
 S NAME="EMPLOYMENT HISTORY" D FORMAT^ONCOPA1
 W !!,TITLE,!
 I $D(^ONCO(160,PTIEN,7,0)) F OC=0:0 S OC=$O(^ONCO(160,PTIEN,7,OC)) Q:OC'>0  D
 .S OCCP=$P($G(^ONCO(160,PTIEN,7,OC,0)),U,1) I OCCP="" Q
 .W !,"    Occupation:  ",$E(OCCP,1,24) D P Q:EX=U
 .W !,"Usual Industry:  ",$E($P($G(^ONCO(160,PTIEN,7,OC,0)),U,4),1,22) D P Q:EX=U
 .W !  D P Q:EX=U 
 S NAME="TOBACCO AND ALCOHOL USAGE" D FORMAT^ONCOPA1
 W !,TITLE
 W !!?15,"  TOBACCO HISTORY:  ",ONCAB(160,PTIEN,38) D P Q:EX=U
 F TBHS=0:0 S TBHS=$O(^ONCO(160,PTIEN,5,TBHS)) Q:TBHS'>0  D
 .S TBZN=$G(^ONCO(160,PTIEN,5,TBHS,0)) S TBTP=$P(TBZN,U,1) I TBTP="" Q
 .W !?3,"Type of Tobacco User:  ",$S(TBTP=1:"CIGARETTE",TBTP=2:"CIGARS",TBTP=3:"PIPE",TBTP=4:"CHEWING TOBACCO",TBTP=5:"SNUFF",TBTP=6:"MARIJUANA",TBTP=7:"MORE THAN 1 TYPE",TBTP=8:"UNKNOWN",1:"")
 .W ?55,"Pack-Years:  ",$S($P(TBZN,U,2)="U":"UNK",1:$P(TBZN,U,2))
 .W ?77,"Year Quit Tobacco Use:  " S Y=$P(TBZN,U,3) W:Y="U" "UNK" I +Y D DD^%DT W Y
 .Q
 W !!?15,"  ALCOHOL HISTORY:  ",ONCAB(160,PTIEN,39) D P Q:EX=U
 F ALHS=0:0 S ALHS=$O(^ONCO(160,PTIEN,6,ALHS)) Q:ALHS'>0  D
 .S ALZN=$G(^ONCO(160,PTIEN,6,ALHS,0)) S ALTP=$P(ALZN,U,1) I ALTP="" Q
 .W !?3,"Type of Alcohol User:  ",$S(ALTP="B":"BEER",ALTP="W":"WINE",ALTP="H":"HARD LIQUOR",ALTP="M":"MODERATE/SOCIAL",ALTP="S":"SERIOUS/HEAVY",ALTP="U":"UNKNOWN",1:"")
 .W ?45,"Years of Alcohol Use:  ",$S($P(ALZN,U,2)="U":"UNK",1:$P(ALZN,U,2))
 .W ?77,"Drinks Per Day:  ",$S($P(ALZN,U,3)="U":"UNK",1:$P(ALZN,U,3))
 .W ?100,"Year Quit Drinking:  " S Y=$P(ALZN,U,4) W:Y="U" "UNK" I +Y D DD^%DT W Y
 .Q
 S CFH=ONCAB(160,PTIEN,43),NAME="CANCER FAMILY HISTORY: "_CFH
 D FORMAT^ONCOPA1 W !!,TITLE,!
 F CHST=0:0 S CHST=$O(ONCAB(160.044,CHST)) Q:CHST'>0  D
 .W !,"   Family member with cancer:  ",ONCAB(160.044,CHST,.01)
 .W ?50,"        Cancer:  ",ONCAB(160.044,CHST,1) D P Q:EX=U
 .Q
 S NAME="PHYSICIAN CONTACTS " D FORMAT^ONCOPA1
 W !!,TITLE
 I DATEDX>3061231 D
 .W !,"    Managing Physician:  ",ONCAB(165.5,IEN,2.2,"E") D P Q:EX=U
 W !,"   Following Physician:  ",ONCAB(165.5,IEN,2.1) D P Q:EX=U
 W !,"       Primary Surgeon:  ",ONCAB(165.5,IEN,2) D P Q:EX=U
 W !,"          Physician #3:  ",ONCAB(165.5,IEN,2.3) D P Q:EX=U
 W !,"          Physician #4:  ",ONCAB(165.5,IEN,2.4) D P Q:EX=U
 W !!,"   QA Selected:  ",ONCAB(165.5,IEN,62) D P Q:EX=U
 W ?25,"   QA Reviewer:  ",ONCAB(165.5,IEN,64.1) D P Q:EX=U
 W ?75,"   QA Date:  ",ONCAB(165.5,IEN,64) D P Q:EX=U
 W ?100,"   QA Review:  ",ONCAB(165.5,IEN,63) D P Q:EX=U
 W !,"   QA Findings: " F TX=0:0 S TX=$O(^ONCO(165.5,IEN,28,TX)) Q:TX'>0  W !?6,^ONCO(165.5,IEN,28,TX,0) D P Q:EX=U
 ;
 I $E(IOST,1,2)="C-" W ! K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue with this abstract" D ^DIR Q:'Y  D HDR G PA3A
 D P Q:EX=U
PA3A D ^ONCOPA3A
 Q
P ;
 I ($Y'<(LINE-1)) D  Q:EX=U  W !
 .I $E(IOST,1,2)="C-" W ! K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue with this abstract" D ^DIR I 'Y S EX=U Q
 .D HDR Q
 Q
HDR ; Header
 W @IOF S PG=PG+1
 W CRA,!
 W ?5," Patient Name:  ",PATNAME,?84,"SSN:  ",SSAN,!
 Q
 ;
CLEANUP ;Cleanup
 K CRA,DATEDX,ESPD,EX,IEN,LINE,NAME,ONCAB,PATNAME,PG,PTIEN,SSAN,TITLE
