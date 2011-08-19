PXRRFDSC ;ISL/PKR - PCE reports FD selection criteria routines. ;2/5/98
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**12,18,31**;Aug 12, 1996
 ;
 ;=======================================================================
DIAGSC ;Get the diagnosis screening criteria.
 N TEMP,X,Y
 K DIRUT,DTOUT,DUOUT
 S DIR(0)="SAO"_U_"P:Primary Diagnosis Only;A:All Diagnoses (Primary and Secondary)"
 S DIR("A")="Select PRIMARY DIAGNOSIS ONLY (P) or ALL DIAGNOSES (A): "
 S DIR("B")="P"
 S TEMP="If you want to count only the primary diagnosis for each encounter enter a 'P'."
 S TEMP=TEMP_"  To count ALL diagnoses enter an 'A'."
 S DIR("?")=TEMP
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S PXRRFDDC=Y_U_Y(0)
 Q
 ;
 ;=======================================================================
DMAX ;Get the maximum number of diagnoses to display in the report.
 N X,Y
 K DIRUT,DTOUT,DUOUT
 S DIR(0)="NA"_U_1
 S DIR("A")="Enter the maximum NUMBER OF DIAGNOSES to display in the report: "
 S DIR("B")=10
 S DIR("?")="Enter an integer greater than or equal to 1"
 S DIR("??")=U_"D DMAXHELP^PXRRFDSC"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S PXRRDMAX=Y
 Q
 ;
DMAXHELP ;?? help for DMAX.
 W !!,"This is the maximum number of entries that will be displayed in the report."
 W !,"If less than this number of entries are found then they all will be displayed."
 W !,"The number of entries that are found are determined by a combination of the"
 W !,"screening criteria and the data stored in PCE."
 Q
 ;
 ;=======================================================================
RACE ;Get the race screening criteria.
 N X,Y
 S NRACE=0
 S DIC("A")="Select patient race(s): "
GRACE K DIRUT,DTOUT,DUOUT
 S DIC=10
 S DIC(0)="AEMQZ"
 I NRACE>0 S DIC("A")="Enter another race: "
 W !
 D ^DIC K DIC
 I X=(U_U) S DTOUT=1
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 I Y=-1 Q
 S NRACE=NRACE+1
 S PXRRRACE(NRACE)=Y
 G GRACE
 Q
 ;
 ;=======================================================================
SEX ;Get the sex screening criteria.
 N X,Y
 K DIRUT,DTOUT,DUOUT
 S DIR(0)="SAO"_U_"M:MALE;F:FEMALE"
 S DIR("A")="Report should be based on patient sex: "
 S DIR("B")="M"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S PXRRSEX=Y_U_Y(0)
 Q
 ;
