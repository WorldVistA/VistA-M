DGYPREG4 ;ALB/REW - POST-INIT CONVERSION/REPORTING ;5-APR-93
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ;  Note: By removing the ;(comment) before D NUMLIM the user is
 ;        prompted for the maximum number of patients to print.
MAX ;
 N DIR,DGXM,DGTXT,X,Y,%DT,Z
 W !,?5,"This report will print problem records sorted by Last Activity Date."
 W !,?5,"It also prints a total of convertible and un-convertible patients"
 W !?5,"for Active and Inactive patients",!
 D PRHEAD1^DGYPREG2 ;Displays definition of Last Activity Date
 W !?5,"Because this may be a very long report, you may wish to only"
 W !?5,"print recently active patients.  The default is 2 years ago.",!
 S DIR("A")="Oldest Activity Date to Print: ",Z=(DT-20000),DIR("B")=$E(Z,4,5)_"/"_$E(Z,6,7)_"/"_$E(Z,2,3),%DT="AE",DIR(0)="D^2800101:2950101:EX"
 D ^DIR
 G:Y<0!($G(DIRUT)) QTMAX
 S:Y DGFSTDT=Y
 I DGFSTDT=2800101 D
 .N DIR
 .W !?5,"Because you have chosen the earliest date (1-1-80) records with NO"
 .W !?5,"Activity Date will be printed at the end.  An example of this"
 .W !?5,"is a patient that never completed registration.",!
 .S DGFSTDT=0
 .S DIR(0)="E" D ^DIR
 ;D NUMLIM
 S:'$G(DGMAXPT) DGMAXPT=1999
QTMAX Q
MBQUE ;
 N DIR,DIRUT,DUOUT,DGFSTDT,DGMAXPT,DGDOMB,DGVAR,DGPGM,X,Y,ZTIO
 S DGDOMB=1,DGVAR="DGMAXPT^DGFSTDT^DGDOMB^DUZ",DGPGM="EN^DGYPREG",ZTIO=""
 D MAX,QUEMESS:'$G(DIRUT)
 D:'$G(DIRUT) QUE^DGUTQ
QTMBQ Q
CFLQUE ;
 N DIR,DIRUT,DUOUT,DGFSTDT,DGMAXPT,DGDOCFL,DGVAR,DGPGM,X,Y,ZTIO
 S DGDOCFL=1,DGVAR="DGMAXPT^DGFSTDT^DGDOCFL^DUZ",DGPGM="EN^DGYPREG",ZTIO=""
 D MAX,QUEMESS:'$G(DIRUT)
 D:'$G(DIRUT) QUE^DGUTQ
QTCFLQ Q
QUEMESS ;
 I $D(ZTQUEUED) G QTQMESS
 W !!?5,"You will be receiving a Mail Message indicating records whose "
 W:$G(DGDOMB) !?5,"monetary benefit amount fields can not be converted into the"
 W:$G(DGDOMB) !?5,"TOTAL ANNUAL VA CHECK AMOUNT field.",!
 W:$G(DGDOCFL) !?5,"Claim Folder Location field in the Patient File does not "
 W:$G(DGDOCFL) !?5,"begin with an institution's station number."
 W !?5,$S($G(DGDOMB)=1:"NO",$G(DGDOCFL)=1:"NO",1:"")," Data will be changed.",!!
 W !?5,"This is a queued task.  Because this searches the entire Patient File,"
 W !?5,"you may wish to run this during off-hours.",!!
QTQMESS Q
NUMLIM ;
 W !!?5,"You may wish to limit the number of patients to print in the"
 W !?5,"listing to a maximum number of unconvertible patients.",!
 S DIR(0)="NA^20:99999:0",DIR("A")="Maximum number of Unconvertible Patients to print: "
 S DIR("B")=999
 D ^DIR
 Q:'Y
 S:Y DGMAXPT=Y
 Q
