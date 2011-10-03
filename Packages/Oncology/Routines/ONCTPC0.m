ONCTPC0 ;HIRMFO/GWB - PCE Study of Thyroid Cancer ;8/23/96
 ;;2.11;ONCOLOGY;**6,7,15**;Mar 07, 1995
 ;Check PCE eligibility
 ;Check if ACCESSION YEAR = 1996
 I $P(^ONCO(165.5,ONCONUM,0),U,7)'=1996 S MSG="The Accession Year is not 1996." D ERRMSG G EXIT
 ;Check if microscopically confirmed
 S DC=$P($G(^ONCO(165.5,ONCONUM,2)),U,6) I (DC'=1)&(DC'=2)&(DC'=4) S MSG="The Diagnostic Confirmation code is not 1, 2 or 4." D ERRMSG G EXIT
 ;Check if Class of Case is either 1 or 2.
 S COC=$P($G(^ONCO(165.5,ONCONUM,0)),U,4) I (COC'=1)&(COC'=2) S MSG="The Class of Case code is not 1 or 2." D ERRMSG G EXIT
 ;Check if HISTOLOGY is eligible
 S HIST=$P($G(^ONCO(165.5,ONCONUM,2)),U,3)
 I HIST="" S MSG="There is no HISTOLOGY for this primary." D ERRMSG G EXIT
 S HIST("80203")=""
 S HIST("80213")=""
 S HIST("80503")=""
 S HIST("82903")=""
 S HIST("83303")=""
 S HIST("83313")=""
 S HIST("83323")=""
 S HIST("83403")=""
 S HIST("85103")=""
 S HIST("85113")=""
 I '$D(HIST(HIST)) S MSG="The Histology of "_$E(HIST,1,4)_"/"_$E(HIST,5)_" is not eligible." D ERRMSG G EXIT
MENU ;Thyroid PCE menu
 S $P(^ONCO(165.5,ONCONUM,7),U,15)="THY"
 S ^ONCO(165.5,"APCE","THY",ONCONUM)=""
 K DIR D HEAD
 S DIR(0)="SO^1:General Information;2:Initial Diagnosis;3:Extent of Disease and AJCC Stage;4:First Course of Treatment;5:First Recurrence and Subsequent Treatment;6:Status at Last Contact;7:All;8:Print Thyroid PCE"
 S DIR("A")="Select Table" D ^DIR
 G:$D(DIRUT)!($D(DIROUT)) EXIT
 I Y=7 S OUT="" D  G MENU
 .D ^ONCTPC1 Q:$G(OUT)="Y"
 .D ^ONCTPC2 Q:$G(OUT)="Y"
 .D ^ONCTPC3 Q:$G(OUT)="Y"
 .D ^ONCTPC4 Q:$G(OUT)="Y"
 .D ^ONCTPC5 Q:$G(OUT)="Y"
 .D ^ONCTPC6 Q:$G(OUT)="Y"
 I Y=8 D ^ONCTPC8 G MENU
 S SUB="^ONCTPC"_Y D @SUB G MENU
ERRMSG ;Error message
 I ONCOANS=5 W !!,?10,"This primary does not satisfy the PCE eligibility criteria:",!,?10,MSG R Z:10
 K MSG Q
HEAD ;Thyroid PCE header
 W @IOF,!,?1,PATNAM,?SITTAB,SITEGP,!,?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD,!,DASHES
 S HDL=$L("Patient Care Evaluation Study of Thyroid Cancer"),TAB=(80-HDL)\2,TAB=TAB-1
 W !,?TAB,"Patient Care Evaluation Study of Thyroid Cancer",!,DASHES
 Q
EXIT ;Kill variables and exit
 K COC,DC,HDL,HIST,MSG,ONCONUM,ONCOPA,OUT,SUB,TAB
 K DIC,DIQ,DIR,DIROUT,DIRUT,DLAYGO,DTOUT,DUOUT,X,Y
 Q
