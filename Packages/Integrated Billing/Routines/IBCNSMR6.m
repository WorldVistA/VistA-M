IBCNSMR6 ;ALB/TJK - MRA EXTRACT ; 02-SEPT-97
 ;;2.0;INTEGRATED BILLING;**146**;21-MAR-94
 ; -Queue task to create MRA Extract file
 N IBABEG,IBAEND,DIR,SITE,EXDATE,FILENM,PATH,DTOUT,DUOUT
 I '$D(DT) D DT^DICRW
 W !!,"Build MRA Extract"
 I '$G(DUZ) D  G END
    .W !!,"Your user number (DUZ) must be defined before proceeding!"
 W !!
 W !,"This program extracts data from the AR and IB packages and"
 W !,"sends it to the VA CFO office for analysis. A background job"
 W !,"called 'IB-Compile MRA statistics' will be queued to run at a time"
 W !,"you choose. A file will be created with the extracted info"
 W !,"will have to be FTPed to a designated IP address.  The file will"
 W !,"have a format: MRA_SITE #_MMDDYYYY.DAT."
 W !!,"This extract must be run on the Legacy sites as well as "
 W !,"the Primary site if you are an integrated database facility."
 W !!
 ; - specify the default file directory
DIR S DIR(0)="FO"
 S DIR("A")="Volume/Directory (or return to accept the default directory)"
 S DIR("?")="Enter using format VA3$:[ANONYMOUS.PUB]"
 W !
 D ^DIR
 K DIR
 G END:$D(DUOUT)!($D(DTOUT))
 K PATH
 I Y]"" S PATH=Y
 I '$D(PATH) S PATH=$$PWD^%ZISH I PATH="" W !,*7,"Unable to determine default directory.  Please enter one." G DIR
 ;
 ; - be sure file can be opened
 S SITE=$P($$SITE^VASITE,"^",3)
 S EXDATE=$E(DT,4,5)_$E(DT,6,7)_($E(DT,1,3)+1700)
 S FILENM="MRA"_SITE_EXDATE_".DAT"
 D OPEN^%ZISH("MRAEXTRACT",PATH,FILENM,"W")
 I POP W !,*7,"Unable to create file in specified volume/directory" G DIR
 D CLOSE^%ZISH("MRAEXTRACT")
 I '$O(^IBE(350.9,1,99,0)) W !!,"You must enter the list of Insurance Companies to be included in this extract first",!! D BLD1^IBCNSMRE
 I '$O(^IBE(350.9,1,99,0)) G END
 W ! S DIR(0)="DA",DIR("A")="Enter Start Date for MRA Extract: ",DIR("B")="Jan. 1,1995",DIR("?")="Enter the earliest date for which Means test charges will be extracted"
 D ^DIR G END:'Y S IBABEG=Y
 W ! S DIR(0)="DA",DIR("A")="Enter End Date for MRA Extract: ",DIR("B")="Dec. 31, 1996",DIR("?")="Enter the latest date for which Means test charges will be extracted"
 D ^DIR G END:'Y S IBAEND=Y
 ;
QUE ; -- que compilation to run
 W !!,"This will automatically be tasked to run.  Upon completion of the extract A mail message will be sent to you.",!
 S ZTIO="",IO("Q")=1
 S ZTDESC="IB-Compile MRA statistics",ZTRTN="DQ^IBCNSMR7",(ZTSAVE("DUZ"),ZTSAVE("IBABEG"),ZTSAVE("IBAEND"),ZTSAVE("FILENM"),ZTSAVE("SITE"),ZTSAVE("PATH"))=""
 D ^%ZTLOAD
 W $S($G(ZTSK):"Job queued ("_ZTSK_")",1:"Task not queued!")
 K ZTSK,ZTIO,ZTDESC,ZTRTN,ZTSAVE,IO("Q")
 ;
END ; -- end of program
 K C,I,J,POP,X,Y,ZTSK,ZTSAVE,ZTDESC,ZTRTN,IBPRNT,IBSNDRPT,IBQUIT
 D ^%ZISC
 Q
 ;
POSTINIT ;Purges old data in 350.9, node 99
 ;Resets '0' node of subfile
 K ^IBE(350.9,1,99)
 S ^IBE(350.9,1,99,0)="^350.999PA"
 Q
