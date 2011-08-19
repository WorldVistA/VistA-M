SPNAHOCZ ;HISC/DAD-AD HOC REPORTS: INTERFACE COMPILER ; [ 05/17/95  5:42 PM ]
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
 W !,"=== Ad Hoc Report Interface Compiler ==="
 D EXIT,DT^DICRW,HOME^%ZIS S SPNYESNO="Please answer Y(es) or N(o)."
 D NOW^%DTC S X=$J(%,0,6),SPNTODAY=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_"  "_$E(X,9,10)_":"_$E(X,11,12)
ROUTINE ; *** Prompt user for Ad Hoc interface routine name
 K DIR S DIR(0)="FAO^2:8^K:X'?1U1.7UN X",DIR("?")="^D EN^SPNAHOCH(""H6"")"
 S DIR("A")="Ad Hoc Report Interface Routine: "
 D ^DIR G:$D(DIRUT) EXIT S (SPNPROG,X)=Y
 X ^%ZOSF("TEST") I  D  G EXIT:SPNREPLC=-1 I SPNREPLC=2 W ! G ROUTINE
 . W !!?5,"*** ",SPNPROG," already exists !! ***",$C(7)
 . F  D  Q:%
 .. W !!?5,"Do you want to replace it"
 .. S %=2 D YN^DICN S SPNREPLC=% I '% W !!?10,SPNYESNO
 .. Q
 . I SPNREPLC=1 F  D  Q:%
 .. W !!?5,"Replace ",SPNPROG,", are you sure"
 .. S %=2 D YN^DICN S SPNREPLC=% I '% W !!?10,SPNYESNO
 .. Q
 . Q
FILE ; *** Prompt user for the file that Ad Hoc will use
 W !!,"Select the FILE to be used by the Ad Hoc Report Generator."
 K DIC S DIC="^DIC(",DIC(0)="AEMNQZ",DIC("A")="Select FILE: "
 S DIC("S")="I Y>1" D ^DIC G:Y'>0 EXIT S SPNFILE=+Y,SPNFILE(0)=Y(0,0)
FIELDS ; *** Prompt user for the fields that Ad Hoc will use
 W !!,"Select the FIELDS to be used by the Ad Hoc Report Generator."
 D ^SPNAHOCY G:SPNMMAX'>0!SPNQUIT EXIT
 I SPNSORT'>0 W !!?5,"*** No sort fields chosen !! ***",$C(7) G EXIT
NODATA ; *** Display a 'No data found...' message on reports (Y/N)
 F  D  Q:%
 . W !!,"Automatically include the ""NO RECORDS TO PRINT"" message"
 . S %=1 D YN^DICN S SPNNODAT=$S(%=1:1,1:0) I '% D EN^SPNAHOCH("H8")
 . Q
 G:%=-1 EXIT
MENUHDR ; *** Prompt user for the sort/print menu screen header
 K DIR S DIR(0)="FAO^0:45^K:(X[U)!(X[$C(34)) X"
 S DIR("A")="Menu screen header: ",DIR("?")="^D EN^SPNAHOCH(""H9"")"
 W ! D ^DIR G:$D(DTOUT)!$D(DUOUT)!$D(DIROUT) EXIT S SPNMHDR=X
BUILD ; *** Build Ad Hoc Report interface routine(s)
 W !!,"Building the Ad Hoc Report Generator interface routine(s)...",!
 D BUILD^SPNAHOCX
 W !!,"Enter 'DO ^",SPNPROG,"' to run the Ad Hoc Report Generator."
EXIT ; *** Exit the Ad Hoc interface compiler
 K %,%DT,%H,DIC,DIE,DIR,DIRUT,DTOUT,DUOUT
 K ^TMP($J,"SPNTXT"),^TMP($J,"SPNROU")
 K SP,SPI,SPN,SPNATTR,SPNCHOSN,SPNDD,SPNDONE,SPNERR,SPNFILE,SPNLEN
 K SPNLEVEL,SPNLN,SPNMHDR,SPNMMAX,SPNNODAT,SPNPROG,SPNQUIT,SPNREPLC
 K SPNRTN,SPNRTNNO,SPNRTNXT,SPNSORT,SPNTAB,SPNTEXT,SPNTODAY,SPNWP
 K SPNY,SPNYESNO,X,XCM,XCN,Y
 Q
