SPNAGGA ;SD/WDE- AGGREGATE OUTCOME REPORTS STARTING POINT; 12/13/2002
 ;;2.0;Spinal Cord Dysfunction;**20**;01/02/1997
 ;
 ;Can be used to prompt for Care Type, Record Type, or Date Range
CARE ;Care type
 W !!,"This option prints an aggregate Outcomes report, based on"
 W !,"your selection of Care Type and range of Care End Dates."
 W !
 S SPNLEXIT=0
 K DIR S DIR(0)="SOAM^1:INPATIENT;2:OUTPATIENT;3:ANNUAL EVALUATION;4:CONTINUUM OF CARE"
 S DIR("A")="Care Type: "
 S DIR("?")="Enter the desired Care Type 1-4"
 D ^DIR S CARETYP=$P(Y,U,1)
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,Y="":1,1:0)
 G:SPNLEXIT=1 EXIT
 K DIR
 S SPNAGROU=$S(CARETYP=1:"^SPNAGGI",CARETYP=2:"^SPNAGGO",CARETYP=3:"^SPNAGGE",CARETYP=4:"^SPNAGGC",1:"^SPNAGGI")
 D @SPNAGROU
 Q
 ;
RCDTYPE ;record type  FIM/FAM/ASIA etc.
 S DIR(0)="SOAM^0:ALL;1:Self Report of Function;2:FIM;3:ASIA;4:CHART;5:FAM;6:DIENER;7:DUSOI;8:Multiple Sclerosis"
 S DIR("A")="Record Type: "
 S DIR("?")="Enter the desired Record Type 0-8"
 D ^DIR S RCORDTYP=Y_U_$G(Y(0))
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,1:0)
 K DIR
 Q
 ;
SCORE ;Score type
 ;obsolete subroutine (score type is now a file)
 S DIR(0)="SOAM^0:ALL;1:INPT START;2:INPT GOAL;3:INPT INTERIM;4:INPT REHAB FINISH;5:INPT FOLLOW-UP (END);6:OUTPT START;7:OUTPT GOAL;8:OUTPT INTERIM;9:OUTPT REHAB FINISH;10:OUTPT FOLLOW-UP (END);11:UNKNOWN"
 S DIR("A")="Score Type: "
 S DIR("?")="Enter the desired Score Type 0-11"
 D ^DIR S SCORETYP=Y_U_$G(Y(0))
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,1:0)
 K DIR
 Q
 ;
DATE ;date range
 W !
 K DIR S DIR(0)="DOA^::EX"
 I $G(DIR("A"))="" S DIR("A")="Beginning date: "
 D ^DIR S DATE("BEGINNING DATE")=Y_U_$G(Y(0))
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,Y="":1,1:0)
 G:SPNLEXIT=1 EXIT
 I 'SPNLEXIT,Y'="" D
 . K DIR S DIR(0)="DOA^"_$P(DATE("BEGINNING DATE"),U)_"::EX"
 . S DIR("A")="Ending date:   "
 . D ^DIR S DATE("ENDING DATE")=Y_U_$G(Y(0))
 . Q
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,Y="":1,1:0)
 G:SPNLEXIT=1 EXIT
 I 'SPNLEXIT,Y'="" D
 . S BDATE=$P(DATE("BEGINNING DATE"),U)
 . S EDATE=$P(DATE("ENDING DATE"),U)
 . Q
 K DIR
 Q
EXIT ;
 K CARETYP,DIR
 Q
