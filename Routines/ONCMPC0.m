ONCMPC0 ;Hines CIOFO/GWB - PCE Study of Melanoma ;1/05/99
 ;;2.11;ONCOLOGY;**22**;Mar 07, 1995
 ;Check PCE eligibility
 ;Check if Class of Case = 0, 1, 2 or 6.
 S COC=$P($G(^ONCO(165.5,ONCONUM,0)),U,4) I (COC'=0)&(COC'=1)&(COC'=2)&(COC'=6) S MSG="The Class of Case is not 0, 1, 2 or 6." D ERRMSG G EXIT
 ;Check if BEHAVIOR is 2 (melanoma in situ) or 3 (malignant)
 I (BEH'=2)&(BEH'=3) S MSG="The BEHAVIOR is not 2 (melanoma in situ) or 3 (malignant)." D ERRMSG G EXIT
MENU ;Melanoma PCE menu
 S $P(^ONCO(165.5,ONCONUM,7),U,15)="MEL"
 S ^ONCO(165.5,"APCE","MEL",ONCONUM)=""
 K DIR D HEAD
 S DIR(0)="SO^1:General Information;2:Initial Diagnosis;3:Extent of Disease and AJCC Stage;4:First Course of Treatment;5:First Recurrence;6:Status at Last Contact;7:Other Information;8:All;"
 S DIR(0)=DIR(0)_"9:Print Melanoma PCE"
 S DIR("A")="Select Table" D ^DIR
 G:$D(DIRUT)!($D(DIROUT)) EXIT
 I Y=8 S OUT="" D  G MENU
 .D ^ONCMPC1 Q:$G(OUT)="Y"
 .D ^ONCMPC2 Q:$G(OUT)="Y"
 .D ^ONCMPC3 Q:$G(OUT)="Y"
 .D ^ONCMPC4 Q:$G(OUT)="Y"
 .D ^ONCMPC5 Q:$G(OUT)="Y"
 .D ^ONCMPC6 Q:$G(OUT)="Y"
 .D ^ONCMPC7 Q:$G(OUT)="Y"
 I Y=9 D ^ONCMPC9 G MENU
 S SUB="^ONCMPC"_Y D @SUB G MENU
ERRMSG ;Error message
 I ONCOANS=5 W !!,?10,"This primary does not satisfy the Melanoma PCE eligibility criteria:",!,?10,MSG R Z:10
 K MSG Q
HEAD ;Melanoma PCE header
 W @IOF,!,?1,PATNAM,?SITTAB,SITEGP,!,?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD,!,DASHES
 S HDL=$L("1999 Patient Care Evaluation Study of Melanoma"),TAB=(80-HDL)\2,TAB=TAB-1
 W !,?TAB,"1999 Patient Care Evaluation Study of Melanoma",!,DASHES
 Q
EXIT ;Kill variables and exit
 K COC,DC,HDL,HIST,HIS1234,BEH,MSG,ONCONUM,ONCOPA,OUT,SUB,TAB
 K DIC,DIQ,DIR,DIROUT,DIRUT,DLAYGO,DTOUT,DUOUT,X,Y
 Q
