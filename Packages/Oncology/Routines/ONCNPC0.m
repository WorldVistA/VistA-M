ONCNPC0 ;HIRMFO/GWB - PCE Study of Non-Hodgkin's Lymphoma;4/11/97
 ;;2.11;ONCOLOGY;**11,15**;Mar 07, 1995
 ;Check PCE eligibility
 ;Check if histologically or cytologically confirmed
 S DC=$P($G(^ONCO(165.5,ONCONUM,2)),U,6) I (DC'=1)&(DC'=2)&(DC'=4) S MSG="The Diagnostic Confirmation code is not 1, 2 or 4." D ERRMSG G EXIT
 ;Check if Class of Case is either 1, 2 or 6.
 S COC=$P($G(^ONCO(165.5,ONCONUM,0)),U,4) I (COC'=1)&(COC'=2)&(COC'=6) S MSG="The Class of Case code is not 1, 2 or 6." D ERRMSG G EXIT
 ;Check if BEHAVIOR is 3 (malignant)
 I BEH'=3 S MSG="The BEHAVIOR code is not 3 (malignant)." D ERRMSG G EXIT
MENU ;Non-Hodgkin's Lymphoma PCE menu
 S $P(^ONCO(165.5,ONCONUM,7),U,15)="NHL"
 S ^ONCO(165.5,"APCE","NHL",ONCONUM)=""
 K DIR D HEAD
 S DIR(0)="SO^1:General Information;2:Initial Diagnosis;3:Extent of Disease and AJCC Stage;4:First Course of Treatment;5:First Recurrence;6:Status at Last Contact;7:All;"
 S DIR(0)=DIR(0)_"8:Print Non-Hodgkin's Lymphoma PCE"
 S DIR("A")="Select Table" D ^DIR
 G:$D(DIRUT)!($D(DIROUT)) EXIT
 I Y=7 S OUT="" D  G MENU
 .D ^ONCNPC1 Q:$G(OUT)="Y"
 .D ^ONCNPC2 Q:$G(OUT)="Y"
 .D ^ONCNPC3 Q:$G(OUT)="Y"
 .D ^ONCNPC4 Q:$G(OUT)="Y"
 .D ^ONCNPC5 Q:$G(OUT)="Y"
 .D ^ONCNPC6 Q:$G(OUT)="Y"
 I Y=8 D ^ONCNPC8 G MENU
 S SUB="^ONCNPC"_Y D @SUB G MENU
ERRMSG ;Error message
 I ONCOANS=5 W !!,?10,"This primary does not satisfy the PCE eligibility criteria:",!,?10,MSG R Z:10
 K MSG Q
HEAD ;Non-Hodgkin's Lymphoma PCE header
 W @IOF,!,?1,PATNAM,?SITTAB,SITEGP,!,?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD,!,DASHES
 S HDL=$L("Patient Care Evaluation Study of Non-Hodgkin's Lymphoma"),TAB=(80-HDL)\2,TAB=TAB-1
 W !,?TAB,"Patient Care Evaluation Study of Non-Hodgkin's Lymphoma",!,DASHES
 Q
EXIT ;Kill variables and exit
 K COC,DC,HDL,HIST,HIS1234,BEH,MSG,ONCONUM,ONCOPA,OUT,SUB,TAB
 K DIC,DIQ,DIR,DIROUT,DIRUT,DLAYGO,DTOUT,DUOUT,X,Y
 Q
