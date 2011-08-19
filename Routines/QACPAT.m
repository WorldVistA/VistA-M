QACPAT ;HISC/CEW - Patient name with Brief Data ;1/27/95  09:49
 ;;2.0;Patient Representative;**3**;07/25/1995
DATE ;
 W !!,"Select the date range you want to print."
 D ^QAQDATE G:QAQQUIT EXIT
 I QAQNBEG>DT W !?5,"*** Beginning date must be today or earlier! ***",*7 G DATE
PATIENT ;
 W ! K DIC S DIC="^DPT(",DIC(0)="AEQZM"
 S DIC("A")="Select PATIENT: "
 D ^DIC K DIC G:Y'>0 EXIT
 S QACSSN=$P($G(^DPT(+Y,0)),U,9) Q:QACSSN=""
 I '$O(^QA(745.1,"E",+Y,0)) W !!?5,"*** No data found for this patient and time frame ***",! G DATE
 S DIC="^QA(745.1,",L=0,BY="@1,3"
 S FR=QAQNBEG_","_QACSSN,TO=QAQNEND_","_QACSSN
 S FLDS="[QAC PAT BRIEF]"
 S DHD="Patient Name with Brief Data"
 D EN1^DIP
EXIT ;
 K Y,DIC,DIP,QACSSN,L,BY,FR,TO,FLDS,DHD
 D K^QAQDATE
