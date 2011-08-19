ONCHPC0 ;Hines OIFO/GWB - 2000 HEPATOCELLULAR CANCERS PCE STUDY ;01/06/00
 ;;2.11;ONCOLOGY;**26**;Mar 07, 1995
 ;Check PCE eligibility
 ;
 ;ACCESSION YEAR (165.5,.07) = 2000
 I $P(^ONCO(165.5,ONCONUM,0),U,7)'=2000 S MSG="The Accession Year is not 2000." D ERRMSG G EXIT
 ;
 ;DIAGNOSTIC CONFIRMATION (165.5,26) = 1, 2, 4 or 5
 S DC=$P($G(^ONCO(165.5,ONCONUM,2)),U,6)
 I (DC'=1)&(DC'=2)&(DC'=4)&(DC'=5) S MSG="The Diagnostic Confirmation code is not 1, 2, 4 or 5." D ERRMSG G EXIT
 ;
 ;CLASS OF CASE (165.5,.04) = 0, 1 or 2
 S COC=$P($G(^ONCO(165.5,ONCONUM,0)),U,4)
 I (COC'=0)&(COC'=1)&(COC'=2) S MSG="The Class of Case code is not 0, 1 or 2." D ERRMSG G EXIT
 ;
 ;BEHAVIOR = 3.
 I BEH'=3 S MSG="The Behavior Code is not 3 (Malignant)." D ERRMSG G EXIT
 ;
 ;HISTOLOGY (165.5,22) 
 S HST(80103)=""
 S HST(81403)=""
 S HST(81603)=""
 S HST(81613)=""
 S HST(81703)=""
 S HST(81713)=""
 S HST(81803)=""
 S HST(84403)=""
 S HST(88003)=""
 S HST(88103)=""
 S HST(88143)=""
 S HST(88503)=""
 S HST(88513)=""
 S HST(88523)=""
 S HST(88533)=""
 S HST(88543)=""
 S HST(88553)=""
 S HST(88583)=""
 S HST(89703)=""
 S HST(89913)=""
 S HST(91203)=""
 S HST(91333)=""
 I $D(HST(HIST)) G MENU
 I (HIST>95902)&(HIST<97174) G MENU
 E  S MSG="Invalid Histology code." D ERRMSG G EXIT
 ;
MENU ;Hepatocellular Cancers PCE menu
 K HST
 S $P(^ONCO(165.5,ONCONUM,7),U,15)="HEP"
 S ^ONCO(165.5,"APCE","HEP",ONCONUM)=""
 K DIR D HEAD
 S DIR(0)="SO^1:Patient Information;2:Tumor Identification;3:Stage of Disease at Diagnosis;4:First Course of Treatment;5:Recurrence;6:Follow-Up;7:All;8:Print Hepatocellular PCE"
 S DIR("A")="Select section" D ^DIR
 G:$D(DIRUT)!($D(DIROUT)) EXIT
 I Y=7 S OUT="" D  G MENU
 .D ^ONCHPC1 Q:$G(OUT)="Y"
 .D ^ONCHPC2 Q:$G(OUT)="Y"
 .D ^ONCHPC3 Q:$G(OUT)="Y"
 .D ^ONCHPC4 Q:$G(OUT)="Y"
 .D ^ONCHPC5 Q:$G(OUT)="Y"
 .D ^ONCHPC6 Q:$G(OUT)="Y"
 S SUB="^ONCHPC"_Y D @SUB G MENU
 ;
ERRMSG ;Error message
 I ONCOANS=5 W !!,?8,"This primary does not satisfy the PCE eligibility criteria:",!!,?8,MSG R Z:10
 K MSG Q
 ;
HEAD ;PCE header
 W @IOF,!,?1,PATNAM,?SITTAB,SITEGP
 W !,?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD
 W !,DASHES
 S HDL=$L("2000 Patient Care Evaluation Study of Hepatocellular Cancers")
 S TAB=(80-HDL)\2,TAB=TAB-1
 W !,?TAB,"2000 Patient Care Evaluation Study of Hepatocellular Cancers"
 W !,DASHES
 Q
 ;
EXIT ;Kill variables and exit
 K HDL,ONCONUM,ONCOPA,OUT,SUB,TAB,HST
 K DIC,DIR,DIROUT,DIRUT,DLAYGO,DTOUT,DUOUT,X,Y
 Q
