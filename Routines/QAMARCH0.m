QAMARCH0 ;HISC/DAD-SELECTIVELY PURGE FILES 743.1, 743.2, 743.6 ;7/17/92  09:39
 ;;1.0;Clinical Monitoring System;;09/13/1993
 ;
EN1 ; *** MONITOR HISTORY FILE (#743.2)
 W !!?5,"*********************************************************************",*7
 W !?5,"*  This option DELETES selected data from the Monitor History file  *"
 W !?5,"*       Once the data has been deleted it CANNOT BE RECOVERED       *"
 W !?5,"*********************************************************************",*7
 D ASKCONT G:%'=1 EXIT
 D GETMON G:QAQQUIT EXIT
 D GETDATE G:QAQQUIT EXIT
 D ASKREADY I %'=1 W !!,"Nothing deleted." G EXIT
 D QUEUE(1) G EXIT
ENTSK1 ; *** TASKED ENTRY POINT
 D EN1^QAMARCH1 G EXIT
 ;
EN2 ; *** FALL OUT FILE (#743.1)
 W !!?5,"********************************************************************",*7
 W !?5,"*     This option DELETES selected data from the Fall Out file     *"
 W !?5,"*      Once the data has been deleted it CANNOT BE RECOVERED       *"
 W !?5,"********************************************************************",*7
 D ASKCONT G:%'=1 EXIT
 D GETMON G:QAQQUIT EXIT
 D GETDATE G:QAQQUIT EXIT
 D ASKREADY I %'=1 W !!,"Nothing deleted." G EXIT
 D QUEUE(2) G EXIT
ENTSK2 ; *** TASKED ENTRY POINT
 D EN2^QAMARCH1 G EXIT
 ;
EN3 ; *** AUTO ENROLL RUN DATES FILE (#743.6)
 W !!?2,"***************************************************************************",*7
 W !?2,"*  This option DELETES selected data from the Auto Enroll Run Dates file  *"
 W !?2,"*          Once the data has been deleted it CANNOT BE RECOVERED          *"
 W !?2,"***************************************************************************",*7
 D ASKCONT G:%'=1 EXIT
 D GETMON G:QAQQUIT EXIT
 D GETDATE G:QAQQUIT EXIT
 D ASKREADY I %'=1 W !!,"Nothing deleted." G EXIT
 D QUEUE(3) G EXIT
ENTSK3 ; *** TASKED ENTRY POINT
 D EN3^QAMARCH1
 ;
EXIT ; *** COMMON EXIT POINT
 S:$D(ZTQUEUED) ZTREQ="@"
 K %,%Y,DA,DIC,DIE,DIK,DR,QADL,QAMD0,QAMD1,QAMDATE,QAMDELET,QAMEND,QAMFALL,QAMMON,QAMMONNM,QAMQUIT,QAMSAMP,QAMSTART,QAMZERO,QAQQUIT,ZTDESC,ZTIO,ZTRTN,ZTSAVE D K^QAQDATE
 Q
 ;
ASKCONT ; *** CONTINUE?
 W !!,"Are you sure you want to continue" S %=2 D YN^DICN I '% W !!?5,"Please answer Y(es) or N(o)" G ASKCONT
 Q
 ;
ASKREADY ; *** READY TO DELETE?
 W *7
AR W !!,"Ready to DELETE, are you sure" S %=2 D YN^DICN I '% W !!?5,"Enter Y(es) to delete the selected data, or",!?5,"Enter N(o) to exit without deleting the data" G AR
 Q
 ;
GETMON ; *** MONITORS TO DELETE
 W !!,"Select the monitors to delete." S QAQDIC="^QA(743,",QAQDIC(0)="AEMNQZ",QAQDIC("A")="Select MONITOR: ",QAQUTIL="QAM MONITOR" D EN1^QAQSELCT
 Q
 ;
GETDATE ; *** DATE RANGE TO DELETE
 W !!,"Select the date range to delete." D ^QAQDATE
 Q
 ;
QUEUE(X) ; *** QUEUE THE DELETION
 S ZTRTN="ENTSK"_X_"^QAMARCH0",(ZTSAVE("QAM*"),ZTSAVE("QAQ*"),ZTSAVE("^UTILITY($J,"),ZTIO)=""
 S ZTDESC="Purge the "_$S(X=1:"MONITOR HISTORY",X=2:"FALL OUT",X=3:"AUTO ENROLL RUN DATES",1:"???")_" file (#"_$S(X=1:743.2,X=2:743.1,X=3:743.6,1:"???")_")",ZTDTH=$H
 D ^%ZTLOAD W !!,"Deletion request queued."
 Q
