QAOSPSM4 ;HISC/DAD-SUMMARY OF OCCURRENCE SCREENING - PART II ;5/6/93  09:43
 ;;3.0;Occurrence Screen;;09/14/1993
 W !!,"Reference: RCS 10-0004 (BPA1) Outpatient Health Service Workload"
 W !,"   Section 8.  ""Purpose of Visit""; Line B ""10-10 Visits"" and"
 W !,"   Line D ""Unscheduled Visits"""
 D PAUSE G:QAOSQUIT EXIT
 W !!,"   c.  Number of Surgical Procedures Performed",?71,"________"
 W !!,"Reference: VA Form 10-7396d Annual Report of Surgical Procedures"
 W !,"   Sum the Total Reported at the Bottom of each Part that is compiled"
 W !,"   for each Surgical Section."
 W !!,"NOTE: The reports cited for the first two items are cumulative.  March's"
 W !,"cumulative totals are the data to be reported for the first semi-annual"
 W !,"report of the fiscal year.  Data for the second semi-annual report are"
 W !,"derived by subtracting March's figures from September's totals."
 D PAUSE
EXIT K DASH,UNDL
 Q
PAUSE Q:$E(IOST)'="C"
 K DIR S DIR(0)="E" D ^DIR K DIR S QAOSQUIT=$S(Y'>0:1,1:0)
 Q
FF W @IOF
 Q
