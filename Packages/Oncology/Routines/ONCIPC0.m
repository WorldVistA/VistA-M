ONCIPC0 ;Hines OIFO/GWB - Primary Intracranial/CNS Tumors PCE Study ;01/14/00
 ;;2.11;ONCOLOGY;**26,27**;Mar 07, 1995
 ;
CHECK ;Check PCE eligibility
 ;ACCESSION YEAR (165.5,.07) = 2000
 I $P(^ONCO(165.5,ONCONUM,0),U,7)'=2000 S MSG="The Accession Year is not 2000." D ERRMSG G EXIT
 ;
 ;DIAGNOSTIC CONFIRMATION (165.5,26) = 1, 2, 4 or 5
 S DC=$P($G(^ONCO(165.5,ONCONUM,2)),U,6)
 I (DC'=1)&(DC'=2)&(DC'=4)&(DC'=5)&(DC'=7)&(DC'=8) S MSG="The Diagnostic Confirmation code is not 1, 2, 4, 5, 7 or 8." D ERRMSG G EXIT
 ;
 ;CLASS OF CASE (165.5,.04) = 0, 1, 2 or 5
 S COC=$P($G(^ONCO(165.5,ONCONUM,0)),U,4)
 I (COC'=0)&(COC'=1)&(COC'=2)&(COC'=5) S MSG="The Class of Case code is not 0, 1, 2 or 5." D ERRMSG G EXIT
 ;
 ;BEHAVIOR = 0, 1 or 3.
 I (BEH'=0)&(BEH'=1)&(BEH'=3) S MSG="The Behavior Code is not 0, 1 or 3." D ERRMSG G EXIT
 ;
MENU ;Primary Intracranial/CNS Tumors PCE menu
 K HST
 S $P(^ONCO(165.5,ONCONUM,7),U,15)="CNS"
 S ^ONCO(165.5,"APCE","CNS",ONCONUM)=""
 K DIR D HEAD
 S DIR(0)="SO^1:Patient Information;2:Tumor Identification;3:First Course of Treatment;4:Recurrence/Progression;5:Subsequent Treatment;6:Status at Last Contact;7:All;8:Print Primary Intracranial/CNS Tumors PCE"
 S DIR("A")="Select section" D ^DIR
 G:$D(DIRUT)!($D(DIROUT)) EXIT
 I Y=7 S OUT="" D  G MENU
 .D ^ONCIPC1 Q:$G(OUT)="Y"
 .D ^ONCIPC2 Q:$G(OUT)="Y"
 .D ^ONCIPC3 Q:$G(OUT)="Y"
 .D ^ONCIPC4 Q:$G(OUT)="Y"
 .D ^ONCIPC5 Q:$G(OUT)="Y"
 .D ^ONCIPC6 Q:$G(OUT)="Y"
 S SUB="^ONCIPC"_Y D @SUB G MENU
ERRMSG ;Error message
 I ONCOANS=5 W !!,?8,"This primary does not satisfy the PCE eligibility criteria:",!!,?8,MSG R Z:10
 K MSG Q
HEAD ;PCE HEADER
 W @IOF,!,?1,PATNAM,?SITTAB,SITEGP
 W !,?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD,!,DASHES
 S HDL=$L(" 2000 Patient Care Evaluation Study of Primary Intracranial & CNS Tumors"),TAB=(80-HDL)\2,TAB=TAB-1
 W !,?TAB,"2000 Patient Care Evaluation Study of Primary Intracranial & CNS Tumors",!,DASHES
 Q
EXIT ;Kill Variables and Exit.
 K HDL,ONCONUM,ONCOPA,OUT,SUB,TAB,HST
 K DIC,DIR,DIROUT,DIRUT,DLAYGO,DTOUT,DUOUT,X,Y
 Q
