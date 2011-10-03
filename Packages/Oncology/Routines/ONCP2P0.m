ONCP2P0 ;HINES CIOFO/GWB - PROSTATE PCE 1998 ;6/1/98
 ;;2.11;ONCOLOGY;**18**;Mar 07, 1995
CHECK ;Check PCE eligibility
 ;Check if ACCESSION YEAR = 1998
 I $P(^ONCO(165.5,ONCONUM,0),U,7)'=1998 S MSG="The Accession Year is not 1998." D ERRMSG G EXIT
 ;Check if histologically confirmed
 S DC=$P($G(^ONCO(165.5,ONCONUM,2)),U,6) I DC'=1 S MSG="The Diagnostic Confirmation code is not 1 (Positive histology)." D ERRMSG G EXIT
 ;Check if Class of Case is either 1, 2 or 6.
 S COC=$P($G(^ONCO(165.5,ONCONUM,0)),U,4) I (COC'=1)&(COC'=2)&(COC'=6) S MSG="The Class of Case code is not 1, 2 or 6." D ERRMSG G EXIT
MENU ;Prostate PCE menu
 S $P(^ONCO(165.5,ONCONUM,7),U,15)="PRO2"
 S ^ONCO(165.5,"APCE","PRO2",ONCONUM)=""
 K DIR D HEAD
 S DIR(0)="SO^1:General Information;2:Initial Diagnosis;3:Extent and Stage of Disease;4:First Course of Treatment;5:First Recurrence;6:Status at Last Contact;7:All;8:Print Prostate PCE"
 S DIR("A")="Select Table" D ^DIR
 G:$D(DIRUT)!($D(DIROUT)) EXIT
 I Y=7 S OUT="" D  G MENU
 .D ^ONCP2P1 Q:$G(OUT)="Y"
 .D ^ONCP2P2 Q:$G(OUT)="Y"
 .D ^ONCP2P3 Q:$G(OUT)="Y"
 .D ^ONCP2P4 Q:$G(OUT)="Y"
 .D ^ONCP2P5 Q:$G(OUT)="Y"
 .D ^ONCP2P6 Q:$G(OUT)="Y"
 S SUB="^ONCP2P"_Y D @SUB G MENU
ERRMSG ;Error message
 I ONCOANS=5 W !!,?10,"This primary does not satisfy the PCE eligibility criteria:",!,?10,MSG R Z:10
 K MSG Q
HEAD ;PCE HEADER
 W @IOF,!,?1,PATNAM,?SITTAB,SITEGP,!,?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD,!,DASHES
 S HDL=$L(" 1998 Patient Care Evaluation Study of Prostate Cancer"),TAB=(80-HDL)\2,TAB=TAB-1
 W !,?TAB,"1998 Patient Care Evaluation Study of Prostate Cancer",!,DASHES
 Q
EXIT ;Kill Variables and Exit.
 K HDL,ONCONUM,ONCOPA,OUT,SUB,TAB
 K DIC,DIR,DIROUT,DIRUT,DLAYGO,DTOUT,DUOUT,X,Y
 Q
