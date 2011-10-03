ONCSPC0 ;HIRMFO/GWB - PCE Study of Soft Tissue Sarcoma ;8/23/96
 ;;2.11;ONCOLOGY;**6,7,15**;Mar 07, 1995
 ;Check PCE eligibility
 ;Check if ACCESSION YEAR = 1996
 I $P(^ONCO(165.5,ONCONUM,0),U,7)'=1996 S MSG="The Accession Year is not 1996." D ERRMSG G EXIT
 ;Check if microscopically confirmed
 S DC=$P($G(^ONCO(165.5,ONCONUM,2)),U,6) I (DC'=1)&(DC'=2)&(DC'=4) S MSG="The Diagnostic Confirmation code is not 1, 2 or 4." D ERRMSG G EXIT
 ;Check if Class of Case is either 1 or 2.
 S COC=$P($G(^ONCO(165.5,ONCONUM,0)),U,4) I (COC'=1)&(COC'=2) S MSG="The Class of Case code is not 1 or 2." D ERRMSG G EXIT
 ;Check if HISTOLOGY is eligible
 S HIST=$P($G(^ONCO(165.5,ONCONUM,2)),U,3),HIST123=$E(HIST,1,3)
 I HIST="" S MSG="There is no HISTOLOGY for this primary." D ERRMSG G EXIT
 S HIST(868)=""
 S HIST(869)=""
 S HIST(870)=""
 S HIST(871)=""
 S HIST(880)=""
 S HIST(881)=""
 S HIST(882)=""
 S HIST(883)=""
 S HIST(884)=""
 S HIST(885)=""
 S HIST(886)=""
 S HIST(887)=""
 S HIST(888)=""
 S HIST(889)=""
 S HIST(890)=""
 S HIST(891)=""
 S HIST(892)=""
 S HIST(899)=""
 S HIST(904)=""
 S HIST(905)=""
 S HIST(912)=""
 S HIST(913)=""
 S HIST(915)=""
 S HIST(916)=""
 S HIST(917)=""
 S HIST(918)=""
 S HIST(919)=""
 S HIST(920)=""
 S HIST(921)=""
 S HIST(922)=""
 S HIST(923)=""
 S HIST(924)=""
 S HIST(925)=""
 S HIST(926)=""
 S HIST(927)=""
 S HIST(928)=""
 S HIST(929)=""
 S HIST(930)=""
 S HIST(931)=""
 S HIST(932)=""
 S HIST(933)=""
 S HIST(934)=""
 S HIST(937)=""
 S HIST(949)=""
 S HIST(950)=""
 S HIST(954)=""
 S HIST(955)=""
 S HIST(956)=""
 S HIST(957)=""
 S HIST(958)=""
 I $E(ICDO,2,3)=44,$E(HIST,1,4)'=8832 S MSG="Skin sites are only allowed for patients with dermatofibrosarcoma." D ERRMSG G EXIT
 I ('$D(HIST(HIST123)))!($E(HIST,5)'=3) S MSG="The Histology of "_$E(HIST,1,4)_"/"_$E(HIST,5)_" is not eligible." D ERRMSG G EXIT
MENU ;Soft Tissue Sarcoma PCE menu
 S $P(^ONCO(165.5,ONCONUM,7),U,15)="STS"
 S ^ONCO(165.5,"APCE","STS",ONCONUM)=""
 K DIR D HEAD
 S DIR(0)="SO^1:General Information;2:Initial Diagnosis/Cancer Identification;3:Extent of Disease and AJCC Stage;4:First Course of Therapy;5:First Recurrence and Subsequent Treatment;6:Status at Last Contact;7:All;"
 S DIR(0)=DIR(0)_"8:Print Soft Tissue Sarcoma PCE"
 S DIR("A")="Select Table" D ^DIR
 G:$D(DIRUT)!($D(DIROUT)) EXIT
 I Y=7 S OUT="" D  G MENU
 .D ^ONCSPC1 Q:$G(OUT)="Y"
 .D ^ONCSPC2 Q:$G(OUT)="Y"
 .D ^ONCSPC3 Q:$G(OUT)="Y"
 .D ^ONCSPC4 Q:$G(OUT)="Y"
 .D ^ONCSPC5 Q:$G(OUT)="Y"
 .D ^ONCSPC6 Q:$G(OUT)="Y"
 I Y=8 D ^ONCSPC8 G MENU
 S SUB="^ONCSPC"_Y D @SUB G MENU
ERRMSG ;Error message
 I ONCOANS=5 W !!,?10,"This primary does not satisfy the PCE eligibility criteria:",!,?10,MSG R Z:10
 K MSG Q
HEAD ;Soft Tissue Sarcoma PCE header
 W @IOF,!,?1,PATNAM,?SITTAB,SITEGP,!,?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD,!,DASHES
 S HDL=$L("Patient Care Evaluation Study of Soft Tissue Sarcoma"),TAB=(80-HDL)\2,TAB=TAB-1
 W !,?TAB,"Patient Care Evaluation Study of Soft Tissue Sarcoma",!,DASHES
 Q
EXIT ;Kill variables and exit
 K COC,DC,HDL,HIST,MSG,ONCONUM,ONCOPA,OUT,SUB,TAB
 K DIC,DIQ,DIR,DIROUT,DIRUT,DLAYGO,DTOUT,DUOUT,X,Y
 Q
