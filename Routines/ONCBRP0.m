ONCBRP0 ;HINES CIOFO/GWB - BREAST PCE 1998 ;6/1/98
 ;;2.11;ONCOLOGY;**18**;Mar 07, 1995
CHECK ;Check PCE eligibility
 ;Check if ACCESSION YEAR = 1998
 I $P(^ONCO(165.5,ONCONUM,0),U,7)'=1998 S MSG="The Accession Year is not 1998." D ERRMSG G EXIT
 ;Check if histologically confirmed
 S DC=$P($G(^ONCO(165.5,ONCONUM,2)),U,6) I DC'=1 S MSG="The Diagnostic Confirmation code is not 1 (Positive histology)." D ERRMSG G EXIT
 ;Check if Class of Case is either 1, 2 or 6.
 S COC=$P($G(^ONCO(165.5,ONCONUM,0)),U,4) I (COC'=1)&(COC'=2)&(COC'=6) S MSG="The Class of Case code is not 1, 2 or 6." D ERRMSG G EXIT
 ;Check if Behavior is either 2 or 3.
 I (BEH'=2)&(BEH'=3) S MSG="The Behavior Code is not 2 (In situ) or 3 (Malignant)." D ERRMSG G EXIT
 ;Check Sex, T-code, P-code and Histology 
 S HST(82012)=""
 S HST(82112)=""
 S HST(85002)=""
 S HST(85012)=""
 S HST(85032)=""
 S HST(85102)=""
 S HST(85122)=""
 S HST(85222)=""
 S SEX=$P(^ONCO(160,ONCOPA,0),U,8)         ;#10   Sex
 I (SEX'=1)&(SEX'=2) S MSG="Sex is neither 1 (Male) nor 2 (Female)." D ERRMSG G EXIT
 S CT=$P($G(^ONCO(165.5,ONCONUM,2)),U,25)  ;#37.1 Clinical T
 S PT=$P($G(^ONCO(165.5,ONCONUM,2.1)),U,1) ;#85   Pathologic T
 I SEX=1 G MENU
 I SEX=2,(CT="1MIC")!(CT="1A")!(PT="1MIC")!(PT="1A") G MENU
 I SEX=2,$D(HST(HIST)) G MENU
 E  S MSG="Female patient has neither DCIS nor AJCC tumor size of T1mic or T1a." D ERRMSG G EXIT
MENU ;Breast PCE menu
 S SEX=$P($G(^ONCO(160,ONCOPA,0)),U,8)
 K HST
 S HST(82013)=""
 S HST(82113)=""
 S HST(85003)=""
 S HST(85013)=""
 S HST(85033)=""
 S HST(85103)=""
 S HST(85123)=""
 S HST(85223)=""
 S IDC=0 I $D(HST(HIST)) S IDC=1
 S $P(^ONCO(165.5,ONCONUM,7),U,15)="BRE"
 S ^ONCO(165.5,"APCE","BRE",ONCONUM)=""
 K DIR D HEAD
 S DIR(0)="SO^1:General Information;2:Initial Diagnosis;3:Tumor Markers and Prognostic Tests;4:Extent of Disease and AJCC Stage;5:First Course of Treatment;6:First Recurrence;7:Status at Last Contact;8:All;9:Print Breast PCE"
 S DIR("A")="Select Table" D ^DIR
 G:$D(DIRUT)!($D(DIROUT)) EXIT
 I Y=8 S OUT="" D  G MENU
 .D ^ONCBRP1 Q:$G(OUT)="Y"
 .D ^ONCBRP2 Q:$G(OUT)="Y"
 .D ^ONCBRP3 Q:$G(OUT)="Y"
 .D ^ONCBRP4 Q:$G(OUT)="Y"
 .D ^ONCBRP5 Q:$G(OUT)="Y"
 .D ^ONCBRP6 Q:$G(OUT)="Y"
 .D ^ONCBRP7 Q:$G(OUT)="Y"
 S SUB="^ONCBRP"_Y D @SUB G MENU
ERRMSG ;Error message
 I ONCOANS=5 W !!,?8,"This primary does not satisfy the PCE eligibility criteria:",!,?8,MSG R Z:10
 K MSG Q
HEAD ;PCE HEADER
 W @IOF,!,?1,PATNAM,?SITTAB,SITEGP,!,?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD,!,DASHES
 S HDL=$L(" 1998 Patient Care Evaluation Study of Breast Cancer"),TAB=(80-HDL)\2,TAB=TAB-1
 W !,?TAB,"1998 Patient Care Evaluation Study of Breast Cancer",!,DASHES
 Q
EXIT ;Kill Variables and Exit.
 K HDL,ONCONUM,ONCOPA,OUT,SUB,TAB,SEX,CT,PT,HST,IDC
 K DIC,DIR,DIROUT,DIRUT,DLAYGO,DTOUT,DUOUT,X,Y
 Q
