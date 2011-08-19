ONCGPC0 ;Hines OIFO/GWB - 2001 Gastric Cancers PCE Study ;02/27/01
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
 S ADENOCA=0,LYMPHOMA=0
 I (HIST1234>8139)&(HIST1234<8577) S ADENOCA=1 G MENU  ;Adenocarcinomas
 I HIST1234=8941 S ADENOCA=1 G MENU                    ;Adenocarcinoma
 I HIST1234=8890 G MENU                                ;Leiomyosarcoma
 ;I HIST1234=8936 G MENU                               ;GIST
 I HIST1234=9140 G MENU                                ;Kaposi sarcoma
 I (HIST1234>9589)&(HIST1234<9730) S LYMPHOMA=1 G MENU ;Lymphomas
 S MSG="Invalid Histology code." D ERRMSG G EXIT
 ;
MENU ;Gastric Cancers PCE menu
 S SEX=$P(^ONCO(160,ONCOPA,0),U,8) ;SEX (160,10)
 S $P(^ONCO(165.5,ONCONUM,7),U,15)="GAS"
 S ^ONCO(165.5,"APCE","GAS",ONCONUM)=""
 K DIR D HEAD
 S DIR(0)="SO^1:Patient Information;2:Tumor Identification and Diagnosis;3:First Course of Treatment;4:Treatment Complications;5:Case Registration;6:All;7:Print Gastric PCE"
 S DIR("A")="Select section" D ^DIR
 G:$D(DIRUT)!($D(DIROUT)) EXIT
 I Y=6 S OUT="" D  G MENU
 .D ^ONCGPC1 Q:$G(OUT)="Y"
 .D ^ONCGPC2 Q:$G(OUT)="Y"
 .D ^ONCGPC3 Q:$G(OUT)="Y"
 .D ^ONCGPC4 Q:$G(OUT)="Y"
 .D ^ONCGPC5 Q:$G(OUT)="Y"
 S SUB="^ONCGPC"_Y D @SUB G MENU
 ;
ERRMSG ;Error message
 I ONCOANS=5 W !!,?8,"This primary does not satisfy the PCE eligibility criteria:",!!,?8,MSG R Z:10
 K MSG Q
 ;
HEAD ;PCE header
 W @IOF,!,?1,PATNAM,?SITTAB,SITEGP
 W !,?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD
 W !,DASHES
 S HDL=$L("2001 Patient Care Evaluation Study of Gastric Cancers")
 S TAB=(80-HDL)\2,TAB=TAB-1
 W !,?TAB,"2001 Patient Care Evaluation Study of Gastric Cancers"
 W !,DASHES
 Q
 ;
EXIT ;Kill variables and exit
 K ADENOCA,HDL,LYMPHOMA,ONCONUM,ONCOPA,OUT,SUB,TAB
 K DIC,DIR,DIROUT,DIRUT,DLAYGO,DTOUT,DUOUT,X,Y
 Q
