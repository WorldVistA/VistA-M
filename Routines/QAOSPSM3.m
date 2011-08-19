QAOSPSM3 ;HISC/DAD-SUMMARY OF OCCURRENCE SCREENING - PART II ;5/6/93  09:08
 ;;3.0;Occurrence Screen;;09/14/1993
 W !!!,"3.  Results of the Reliability Assessments (Complete only for second report"
 W !,"    of fiscal year.)"
 W !!,"   a.  Clinical Review"
 W !!,"      (1)  Date reliability assessment completed  ____________________"
 W !!,"      (2)  Percentage agreement found             ____________________"
 W !!,"   b.  Peer Review"
 W !!,"      (1)  Date reliability assessment completed  ____________________"
 W !!,"      (2)  Percentage agreement found             ____________________"
 D PAUSE G:QAOSQUIT EXIT D FF
 W !!!,"4.  Service-Specific Occurrences"
 W !!,DASH
 W !,"|             | Medicine  |   Surgery   |  Psychiatry  |   Other*   |  Total** |"
 W !,"|   (Including Neurology) |             |              |            |          |"
 W !,DASH
 W !,"| Criterion 1 |   ",$$SRV("N",1,1),"    |    ",$$SRV("N",1,2),"     |    ",$$SRV("N",1,3),"      |    ",$$SRV("N",1,4),"    |   ",$$SRV("N",1,5),"   |"
 W !,DASH
 W !,"| Criterion 2 |    N/A    |     N/A     |     N/A      |     N/A    |   ",$$SRV("N",2,5),"   |"
 W !,DASH
 W !,"| Criterion 3 |    N/A    |    ",$$SRV("N",3,2),"     |     N/A      |     N/A    |   ",$$SRV("N",3,2),"   |"
 W !,DASH
 W !,"| Criterion 4 |   ",$$SRV("N",4,1),"    |    ",$$SRV("N",4,2),"     |    ",$$SRV("N",4,3),"      |    ",$$SRV("N",4,4),"    |   ",$$SRV("N",4,5),"   |"
 W !,DASH
 D PAUSE G:QAOSQUIT EXIT
 W !!,"Include only occurrences in this table, i.e., cases requiring clinical review"
 W !,"to determine if further review is necessary.  Cases meeting exceptions, are"
 W !,"not included."
 W !!,"Use the following rules in determining the service to which an"
 W !,"occurrence belongs:"
 W !,"   Criterion 1 - Service at time of discharge from first hospitalization"
 W !,"   Criterion 2 - No rule necessary since only total figure needed"
 W !,"   Criterion 3 - No rule necessary since all occurrences are in surgery"
 W !,"   Criterion 4 - Service providing care at time of death"
 W !!,"* The ""Other"" column should be used for occurrences belonging to Intermediate"
 W !,"Medicine, Nursing Home Care Unit, Rehabilitation Medicine, SCI, and Domiciliary."
 W !!,"** The numbers in the ""Total"" columns should be the same as those in column 1"
 W !,"of Part I if all occurrences were clinically reviewed."
 D PAUSE G:QAOSQUIT EXIT D FF
 W !!,"5.  Facility Workload Data (Should be readily available from Medical"
 W !,"    Administration Service)"
 W !!,"   a.  Number of Admissions to Acute Care during Reporting Period:"
 W !!,"Reference : RCS 10-0021 (8ZD1) VA Inpatient Care"
 W !,"   Under the ""Gains"" Section; Line ""Total - Adm & Trans"""
 W !,"   List for each Bed Section:"
 W !!,"      Medicine (Include Neurology, exclude Intermediate Med.)",?71,"________"
 W !!,"      Surgery",?71,"________"
 W !!,"      Psychiatry",?71,"________"
 W !!,"   b.  Number of ""Unscheduled"" and ""10-10"" Ambulatory Care"
 W !,"       Visits During Reporting Period",?71,"________"
 G ^QAOSPSM4
SRV(STATUS,SEQUENCE,PIECE) ;
 Q $S(QAOBLANK:"    ",1:$J($P($G(QAOSRV(STATUS,SEQUENCE)),"^",PIECE),4,0))
EXIT K DASH,UNDL
 Q
PAUSE Q:$E(IOST)'="C"
 K DIR S DIR(0)="E" D ^DIR K DIR S QAOSQUIT=$S(Y'>0:1,1:0)
 Q
FF W @IOF
 Q
