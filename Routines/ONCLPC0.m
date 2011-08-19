ONCLPC0 ;Hines OIFO/GWB - 2001 2001 Lung (NSCLC) PCE Study ;05/04/01
 ;;2.11;ONCOLOGY;**29**;Mar 07, 1995
 ;Check PCE eligibility
 ;
 ;ACCESSION YEAR (165.5,.07) = 2001
 I $P(^ONCO(165.5,ONCONUM,0),U,7)'=2001 S MSG="The Accession Year is not 2001." D ERRMSG G EXIT
 ;
 ;DIAGNOSTIC CONFIRMATION (165.5,26) = 1, 2, or 4
 S DC=$P($G(^ONCO(165.5,ONCONUM,2)),U,6)
 I (DC'=1)&(DC'=2)&(DC'=4) S MSG="The Diagnostic Confirmation code is not 1, 2 or 4." D ERRMSG G EXIT
 ;
 ;CLASS OF CASE (165.5,.04) = 0, 1 or 2
 S COC=$P($G(^ONCO(165.5,ONCONUM,0)),U,4)
 I (COC'=0)&(COC'=1)&(COC'=2) S MSG="The Class of Case code is not 0, 1 or 2." D ERRMSG G EXIT
 ;
 ;BEHAVIOR = 3.
 I HIST1234=8936 S MSG="GI stromal sarcomas (8936) are being collected via paper data form." D ERRMSG G EXIT ;GI stromal sarcomas
 I BEH'=3 S MSG="The Behavior Code is not 3 (Malignant)." D ERRMSG G EXIT
 ;
HIST ;HISTOLOGY (165.5,22) 
 I (HIST1234=8041)!(HIST1234=8042)!(HIST1234=8043)!(HIST1234=8044)!(HIST1234=8045) G MSG             ;exclude Small cell Carcinoma
 I HIST1234=8240 G MSG ;exclude Carcinoid tumor
 I (HIST1234>8011)&(HIST1234<8577) G MENU
MSG S MSG="Invalid Histology code." D ERRMSG G EXIT
 ;
MENU ;Lung (NSCLC) Cancers PCE menu
 S $P(^ONCO(165.5,ONCONUM,7),U,15)="LNG"
 S ^ONCO(165.5,"APCE","LNG",ONCONUM)=""
 K DIR D HEAD
 S DIR(0)="SO^1:Patient Information;2:Tumor Identification and Diagnosis;3:Tumor Evaluation;4:Pathology;5:First Course of Treatment;6:Treatment Complications;7:Case Registration;8:All;9:Print Lung (NSCLC) PCE"
 S DIR("A")="Select section" D ^DIR
 G:$D(DIRUT)!($D(DIROUT)) EXIT
 I Y=8 S OUT="" D  G MENU
 .D ^ONCLPC1 Q:$G(OUT)="Y"
 .D ^ONCLPC2 Q:$G(OUT)="Y"
 .D ^ONCLPC3 Q:$G(OUT)="Y"
 .D ^ONCLPC4 Q:$G(OUT)="Y"
 .D ^ONCLPC5 Q:$G(OUT)="Y"
 .D ^ONCLPC6 Q:$G(OUT)="Y"
 .D ^ONCLPC7 Q:$G(OUT)="Y"
 S SUB="^ONCLPC"_Y D @SUB G MENU
 ;
ERRMSG ;Error message
 I ONCOANS=5 W !!,?8,"This primary does not satisfy the PCE eligibility criteria:",!!,?8,MSG R Z:10
 K MSG Q
 ;
HEAD ;PCE header
 W @IOF,!,?1,PATNAM,?SITTAB,SITEGP
 W !,?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD
 W !,DASHES
 S HDL=$L("2001 Patient Care Evaluation Study of Non-Small Cell Lung Carcinoma")
 S TAB=(80-HDL)\2,TAB=TAB-1
 W !,?TAB,"2001 Patient Care Evaluation Study of Non-Small Cell Lung Carcinoma"
 W !,DASHES
 Q
 ;
EXIT ;Kill variables and exit
 K HDL,ONCONUM,ONCOPA,OUT,SUB,TAB
 K DIC,DIR,DIROUT,DIRUT,DLAYGO,DTOUT,DUOUT,X,Y
 Q
