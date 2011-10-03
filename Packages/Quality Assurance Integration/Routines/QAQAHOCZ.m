QAQAHOCZ ;HISC/DAD-AD HOC REPORTS: INTERFACE COMPILER ;9/3/91  15:52 [ 10/07/92  7:10 PM ]
 ;;1.7;QM Integration Module;;07/25/1995
 ;
 D EXIT,HOME^%ZIS S QAQYESNO="Please answer Y(es) or N(o)."
 D NOW^%DTC S X=$J(%,0,6),QAQTODAY=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_"  "_$E(X,9,10)_":"_$E(X,11,12)
ROUTINE ; *** Prompt user for Ad Hoc interface routine name
 K DIR S DIR(0)="FAO^2:8^K:X'?1U1.7UN X",DIR("A")="Ad Hoc Report Generator Interface Routine: ",DIR("?")="^D EN^QAQAHOCH(""H6"")"
 W ! D ^DIR G:$D(DIRUT) EXIT S (QAQPROG,X)=Y
 X ^%ZOSF("TEST") I  D  G EXIT:QAQREPLC=-1,ROUTINE:QAQREPLC=2
 . W !!?5,"*** ",QAQPROG," already exists !! ***",*7
R1 . W !!?5,"Do you want to replace it"
 . S %=2 D YN^DICN S QAQREPLC=%
 . Q:(%=-1)!(%=2)  I '% W !!?10,QAQYESNO G R1
R2 . W !!?5,"Replace ",QAQPROG,", are you sure"
 . S %=2 D YN^DICN S QAQREPLC=%
 . Q:%=-1  I '% W !!?10,QAQYESNO G R2
 . Q
FILE ; *** Prompt user for the file that Ad Hoc will use
 W !!,"Select the FILE to be used by the Ad Hoc Report Generator."
 K DIC S DIC="^DIC(",DIC(0)="AEMNQZ",DIC("A")="Select FILE: " D ^DIC G:Y'>0 EXIT S QAQFILE=+Y,QAQFILE(0)=Y(0,0)
FIELDS ; *** Prompt user for the fields that Ad Hoc will use
 W !!,"Select the FIELDS to be used by the Ad Hoc Report Generator."
 D ^QAQAHOCY G:QAQMMAX'>0!QAQQUIT EXIT I QAQSORT'>0 W !!?5,"*** No sort fields chosen !! ***",*7 G EXIT
NODATA ; *** Include optional output checking code in OTHER entry point (Y/N)
 W !!,"Automatically include the ""No data found..."" message" S %=1 D YN^DICN G:%=-1 EXIT S QAQNODAT=$S(%=1:1,1:0)
 I '% D EN^QAQAHOCH("H8") G NODATA
MENUHDR ; *** Prompt user for the sort/print menu screen header
 K DIR S DIR(0)="FAO^0:45^K:(X[""^"")!(X[$C(34)) X",DIR("A")="Menu screen header: ",DIR("?")="^D EN^QAQAHOCH(""H9"")"
 W ! D ^DIR G:$D(DTOUT)!$D(DUOUT)!$D(DIROUT) EXIT S QAQMHDR=Y
BUILD ; *** Build Ad Hoc Report interface routine(s)
 W !!,"Building the Ad Hoc Report Generator interface routine(s)...",!
 D BUILD^QAQAHOCX
 W !!,"Enter 'DO ^",QAQPROG,"' to run the Ad Hoc Report Generator."
EXIT ; *** Exit the Ad Hoc interface compiler
 K %,%DT,%H,DIC,DIE,DIR,DIRUT,DTOUT,DUOUT
 K ^TMP($J,"QAQTXT"),^TMP($J,"QAQROU")
 K QA,QAI,QAQ,QAQCHOSN,QAQDD,QAQDONE,QAQFILE,QAQLEN,QAQLEVEL,QAQLN,QAQMHDR,QAQMMAX,QAQNODAT,QAQPROG,QAQQUIT,QAQREPLC,QAQRTN,QAQRTNNO,QAQRTNXT,QAQSORT,QAQTAB,QAQTEXT,QAQTODAY,QAQWP,QAQYESNO,X,XCM,XCN,Y
 Q
