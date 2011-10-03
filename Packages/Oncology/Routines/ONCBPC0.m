ONCBPC0 ;HIRMFO/GWB - PCE Study of Cancers of the Urinary Bladder;03/18/96
 ;;2.11;ONCOLOGY;**6,15**;Mar 07, 1995
 ;Check PCE eligibility
 ;Check if ACCESSION YEAR = 1995
 I $P(^ONCO(165.5,ONCONUM,0),U,7)'=1995 S MSG="The Accession Year is not 1995." D ERRMSG G EXIT
 ;Check if histologically confirmed
 S DC=$P($G(^ONCO(165.5,ONCONUM,2)),U,6) I DC'=1 S MSG="The Diagnostic Confirmation code is not 1." D ERRMSG G EXIT
 ;Check if Class of Case is either 0, 1 or 2.
 I $P($G(^ONCO(165.5,ONCONUM,0)),U,4)>2 S MSG="The Class of Case code is not 0, 1 or 2." D ERRMSG G EXIT
 ;Check Date DX and/or Date of First Course Treatment
 ;S ONCODT1=$P($G(^ONCO(165.5,ONCONUM,0)),U,16)
 ;S ONCODT2=0 F  S ONCODT2=$O(^ONCO(165.5,"ATX",ONCONUM,ONCODT2)) Q:ONCODT2'>0  Q:($E(ONCODT2,2,7)'="000000")&($E(ONCODT2,2,7)'=999999)
 ;I $E(ONCODT1,1,3)'=ONCDT,$E(ONCODT2,1,3)'=ONCDT S MSG="Date DX and/or First Treatment Date not in 1995." D ERRMSG G EXIT
MENU ;Bladder PCE menu
 S $P(^ONCO(165.5,ONCONUM,7),U,15)="BLA"
 S ^ONCO(165.5,"APCE","BLA",ONCONUM)=""
 K DIR D HEAD
 S DIR(0)="SO^1:General Information;2:Diagnostic Information;3:Extent of Disease and AJCC Stage;4:First Course of Treatment;5:First Recurrence;6:Status At Last Contact;7:All;8:Print Bladder PCE"
 S DIR("A")="Select table" D ^DIR
 I Y=7 S OUT="" D  G MENU
 .D ^ONCBPC1 Q:$G(OUT)="Y"
 .D ^ONCBPC2 Q:$G(OUT)="Y"
 .D ^ONCBPC3 Q:$G(OUT)="Y"
 .D ^ONCBPC4 Q:$G(OUT)="Y"
 .D ^ONCBPC5 Q:$G(OUT)="Y"
 .D ^ONCBPC6 Q:$G(OUT)="Y"
 G:$D(DIRUT)!($D(DIROUT)) EXIT S SUB="^ONCBPC"_Y D @SUB
 G MENU
ERRMSG ;Error message
 I ONCOANS=5 W !!,?10,"This primary does not satisfy the PCE eligibility criteria:",!,?10,MSG R Z:10
 K MSG Q
HEAD ;PCE HEADER
 W @IOF,!,?1,PATNAM,?SITTAB,SITEGP,!,?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD,!,DASHES
 S HDL=$L("Patient Care Evaluation Study of Cancers of the Urinary Bladder"),TAB=(80-HDL)\2,TAB=TAB-1
 W !,?TAB,"Patient Care Evaluation Study of Cancers of the Urinary Bladder",!,DASHES
 Q
EXIT ;Kill variables and exit
 K COC,DC,HDL,MSG,ONCONUM,ONCOPA,OUT,SUB,TAB
 K DIC,DIQ,DIR,DIROUT,DIRUT,DLAYGO,DTOUT,DUOUT,X,Y
 Q
