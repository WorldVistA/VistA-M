ONCCPC0 ;HIRMFO/GWB - PCE Study of Colorectal Cancer;2/7/97
 ;;2.11;ONCOLOGY;**11,15**;Mar 07, 1995
 ;Check PCE eligibility
 ;Check if ACCESSION YEAR = 1997
 I $P(^ONCO(165.5,ONCONUM,0),U,7)'=1997 S MSG="The Accession Year is not 1997." D ERRMSG G EXIT
 ;Check if microscopically confirmed
 S DC=$P($G(^ONCO(165.5,ONCONUM,2)),U,6) I (DC'=1)&(DC'=2)&(DC'=4) S MSG="The Diagnostic Confirmation code is not 1, 2 or 4." D ERRMSG G EXIT
 ;Check if Class of Case is either 1, 2 or 6.
 S COC=$P($G(^ONCO(165.5,ONCONUM,0)),U,4) I (COC'=1)&(COC'=2)&(COC'=6) S MSG="The Class of Case code is not 1, 2 or 6." D ERRMSG G EXIT
 ;Check if HISTOLOGY and BEHAVIOR is eligible
 S HIST=$P($G(^ONCO(165.5,ONCONUM,2)),U,3)
 S HIST1234=$E(HIST,1,4),BEH=$E(HIST,5)
 I HIST="" S MSG="There is no HISTOLOGY for this primary." D ERRMSG G EXIT
 I (BEH'=2)&(BEH'=3) S MSG="The BEHAVIOR code is not 2 (in situ) or 3 (malignant)." D ERRMSG G EXIT
 S HIST(8140)=""
 S HIST(8141)=""
 S HIST(8143)=""
 S HIST(8144)=""
 S HIST(8145)=""
 S HIST(8147)=""
 S HIST(8150)=""
 S HIST(8154)=""
 S HIST(8160)=""
 S HIST(8190)=""
 S HIST(8200)=""
 S HIST(8210)=""
 S HIST(8211)=""
 S HIST(8220)=""
 S HIST(8221)=""
 S HIST(8244)=""
 S HIST(8250)=""
 S HIST(8251)=""
 S HIST(8260)=""
 S HIST(8261)=""
 S HIST(8262)=""
 S HIST(8263)=""
 S HIST(8270)=""
 S HIST(8280)=""
 S HIST(8290)=""
 S HIST(8300)=""
 S HIST(8310)=""
 S HIST(8312)=""
 S HIST(8320)=""
 S HIST(8322)=""
 S HIST(8323)=""
 S HIST(8330)=""
 S HIST(8331)=""
 S HIST(8332)=""
 S HIST(8340)=""
 S HIST(8350)=""
 S HIST(8370)=""
 S HIST(8380)=""
 S HIST(8400)=""
 S HIST(8401)=""
 S HIST(8410)=""
 S HIST(8420)=""
 S HIST(8441)=""
 S HIST(8450)=""
 S HIST(8460)=""
 S HIST(8470)=""
 S HIST(8480)=""
 S HIST(8481)=""
 S HIST(8490)=""
 S HIST(8500)=""
 S HIST(8503)=""
 S HIST(8504)=""
 S HIST(8510)=""
 S HIST(8520)=""
 S HIST(8530)=""
 S HIST(8550)=""
 S HIST(8560)=""
 S HIST(8570)=""
 S HIST(8571)=""
 S HIST(8572)=""
 S HIST(8573)=""
 S HIST(9070)=""
 S HIST(9110)=""
 I '$D(HIST(HIST1234)) S MSG="The Histology of "_$E(HIST,1,4)_"/"_$E(HIST,5)_" is not eligible." D ERRMSG G EXIT
MENU ;Colorectal Cancer PCE menu
 S $P(^ONCO(165.5,ONCONUM,7),U,15)="COL"
 S ^ONCO(165.5,"APCE","COL",ONCONUM)=""
 K DIR D HEAD
 S DIR(0)="SO^1:General Information;2:Initial Diagnosis/Cancer Identification;3:Extent of Disease and AJCC Stage;4:First Course of Treatment;5:Quality of Life;6:First Recurrence;7:Status at Last Contact;8:All;"
 S DIR(0)=DIR(0)_"9:Print Colorectal Cancer PCE"
 S DIR("A")="Select Table" D ^DIR
 G:$D(DIRUT)!($D(DIROUT)) EXIT
 I Y=8 S OUT="" D  G MENU
 .D ^ONCCPC1 Q:$G(OUT)="Y"
 .D ^ONCCPC2 Q:$G(OUT)="Y"
 .D ^ONCCPC3 Q:$G(OUT)="Y"
 .D ^ONCCPC4 Q:$G(OUT)="Y"
 .D ^ONCCPC5 Q:$G(OUT)="Y"
 .D ^ONCCPC6 Q:$G(OUT)="Y"
 .D ^ONCCPC7 Q:$G(OUT)="Y"
 I Y=9 D ^ONCCPC9 G MENU
 S SUB="^ONCCPC"_Y D @SUB G MENU
ERRMSG ;Error message
 I ONCOANS=5 W !!,?10,"This primary does not satisfy the PCE eligibility criteria:",!,?10,MSG R Z:10
 K MSG Q
HEAD ;Colorectal Cancer PCE header
 W @IOF,!,?1,PATNAM,?SITTAB,SITEGP,!,?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD,!,DASHES
 S HDL=$L("Patient Care Evaluation Study of Colorectal Cancer"),TAB=(80-HDL)\2,TAB=TAB-1
 W !,?TAB,"Patient Care Evaluation Study of Colorectal Cancer",!,DASHES
 Q
EXIT ;Kill variables and exit
 K COC,DC,HDL,HIST,HIS1234,BEH,MSG,ONCONUM,ONCOPA,OUT,SUB,TAB
 K DIC,DIQ,DIR,DIROUT,DIRUT,DLAYGO,DTOUT,DUOUT,X,Y
 Q
