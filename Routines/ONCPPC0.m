ONCPPC0 ;HIRMFO/GWB - PCE Studies of Prostate Cancer ;3/18/96
 ;;2.11;ONCOLOGY;**6,15**;Mar 07, 1995
CHECK ;Check PCE eligibility
MENU ;Prostate PCE menu
 S $P(^ONCO(165.5,ONCONUM,7),U,15)="PRO"
 S ^ONCO(165.5,"APCE","PRO",ONCONUM)=""
 K DIR D HEAD
 S DIR(0)="SO^1:General Information;2:Initial Diagnosis;3:Stage of Disease;4:First Course of Treatment;5:First Recurrence;6:Subsequent Treatment;7:Status at Last Contact;8:All;9:Print Prostate PCE"
 S DIR("A")="Select Table" D ^DIR
 G:$D(DIRUT)!($D(DIROUT)) EXIT
 I Y=8 S OUT="" D  G MENU
 .D ^ONCPPC1 Q:$G(OUT)="Y"
 .D ^ONCPPC2 Q:$G(OUT)="Y"
 .D ^ONCPPC3 Q:$G(OUT)="Y"
 .D ^ONCPPC4 Q:$G(OUT)="Y"
 .D ^ONCPPC5 Q:$G(OUT)="Y"
 .D ^ONCPPC6 Q:$G(OUT)="Y"
 .D ^ONCPPC7 Q:$G(OUT)="Y"
 S SUB="^ONCPPC"_Y D @SUB G MENU
HEAD ;PCE HEADER
 W @IOF,!,?1,PATNAM,?SITTAB,SITEGP,!,?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD,!,DASHES
 S HDL=$L("Patient Care Evaluation Studies of Cancer of the Prostate"),TAB=(80-HDL)\2,TAB=TAB-1
 W !,?TAB,"Patient Care Evaluation Studies of Cancer of the Prostate",!,DASHES
 Q
EXIT ;Kill Variables and Exit.
 K HDL,ONCONUM,ONCOPA,OUT,SUB,TAB
 K DIC,DIR,DIROUT,DIRUT,DLAYGO,DTOUT,DUOUT,X,Y
 Q
