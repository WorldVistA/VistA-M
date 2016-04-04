DMSQ ;SFISC/EZ-CALLS INTO SQLI CODE ;10/30/97  16:25
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
SETUP ;entry point to begin SQLI projection process
 ;gives interactive user a chance to cancel out before continuing
 ;requires programmer mode (DUZ(0)="@")
 I $D(ZTQUEUED) D RUN Q
 I $$WAIT^DMSQT1 D  Q
 . W !?5,"Another SQLI projection is already running right now."
 . W !?5,"Try later if you want to re-run the SQLI projection."
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="This process takes several hours.  Want to Continue"
 S DIR("?",1)="This will project FileMan data dictionary information into SQLI files."
 S DIR("?",2)="It may consume up to 30Mb of space in a full hospital account."
 S DIR("?",3)=" "
 S DIR("?",4)="It is safe to run on all systems, even if you don't have SQLI-to-SQL mapping."
 S DIR("?",5)="(Note: SQLI print options won't report anything if SQLI files are empty.)"
 S DIR("?",6)=" "
 S DIR("?",7)="To experiment, you can run this and then use the purge option afterwards."
 S DIR("?",8)="(It isn't necessary to run the purge option beforehand, by the way.)"
 S DIR("?",9)=" "
 S DIR("?",10)="If you do have SQLI-to-SQL mapping, be aware that this is step 2 of 3:"
 S DIR("?",11)=" "
 S DIR("?",12)="  (1) Populate the SQLI Key Word file - KW^DMSQD(SCR,ERR)"
 S DIR("?",13)="  (2) Run this utility - SETUP^DMSQ"
 S DIR("?",14)="  (3) Run your SQLI-to-SQL mapper (vendor product)"
 S DIR("?",15)=" "
 S DIR("?")="These 3 steps should be done in sequence, one right after the other."
 D ^DIR K DIR Q:'Y
 I $G(DUZ(0))'["@" W !,"PROGRAMMER MODE REQUIRED (NOTHING DONE)",! Q
 W !!?5,"Running this job on your terminal (HOME device) will tie up"
 W !?5,"your terminal for the several hours it takes to run, but you"
 W !?5,"will see the job's status as it's running."
 W !!?5,"Queuing will send it to the background for processing.  The"
 W !?5,"status will be apparent from the printed output (if there's an"
 W !?5,"error, it's text will be printed).  TaskMan/Kernel tools can also"
 W !?5,"be used to determine whether the job ran to completion or not."
 W !!?5,"Don't send this directly to a printer (without queuing) unless"
 W !?5,"you are prepared to tie up your terminal AND the printer for"
 W !?5,"the duration of the process.",!
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="RUN^DMSQ",ZTDESC="SQLI PROJECTION"
 . D ^%ZTLOAD D HOME^%ZIS K IO("Q")
 S:IO'=IO(0) DMDOT="" D RUN
EXIT K DMDOT
 Q
RUN ;runs the projection of all files (called from SETUP)
 U IO
 I $G(DUZ(0))'["@" W !,"PROGRAMMER MODE REQUIRED (NOTHING DONE)",! Q
 I $$WAIT^DMSQT1 D  Q
 . W !?5,"Another SQLI projection is being run right now.  So"
 . W !?5,"this attempt to re-run the projection is aborted."
 D ALLF^DMSQF(1) ;using param=1 schema/domains/datatypes (re)done
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
RUNONE ;re-runs the projection of one file - for testing purposes only.
 ;if the selected file has subfiles, they will not be processed.
 ;to process one subfile, use the subfile number in this call.
 ;to select a (sub)file, it must already be an SQLI Table (re-runs only).
 I $G(DUZ(0))'["@" W !,"PROGRAMMER MODE REQUIRED (NOTHING DONE)",! Q
 N DM1,DM2,DMQ,DMFN S DMQ="" D ASK
 I DMQ W !?5,"No file selected; nothing done." Q
 D ONEF^DMSQF(DMFN) W !?5,"Done.  See SQLI files for changes."
 Q
ASK ; select (sub)file number
 S DM1=$O(^DMSQ("T","C",0)),DM2=$O(^DMSQ("T","C",99999999999),-1)
 S DIR(0)="NO^"_DM1_":"_DM2_":999999999",DIR("A")="File or Subfile Number"
 S DIR("?")="Enter the number of a file or subfile to re-project"
 D ^DIR S:$D(DIRUT) DMQ=1 K DIR Q:DMQ  S DMFN=Y
 I '$D(^DMSQ("T","C",DMFN)) D  G ASK
 . W !?5,"Invalid selection:  no SQLI table for this (sub)file."
 Q
PURGE ;entry point to clear data from SQLI files, all except keywords
 ;requires programmer mode (DUZ(0)="@")
 ;header nodes of the files are reset, indicating empty status
 N I
 I $G(DUZ(0))'["@" W !,"PROGMODE REQUIRED (NOTHING DONE)",! Q
 I $$WAIT^DMSQT1 D  Q
 . W !?5,"Purging can't be done right now.  The SQLI structures"
 . W !?5,"are in the process of being built, a job that might take"
 . W !?5,"a few hours.  So try again later (when the job finishes)."
 S DIR("A")="Removes all records from SQLI files. Continue"
 S DIR("?",1)="Clears all SQLI files (between 1.52 and 1.53) except SQLI_KEY_WORD."
 S DIR("?",2)="(You can re-generate SQLI data at a future time as needed.)",DIR("?",3)=" "
 S DIR("?")="Data can be cleared if you don't have an SQL system or you don't use SQLI."
 S DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR Q:$D(DIRUT)!(Y'=1)
 W !,"Working..."
 F I="S","KF","T","E","C","P","F","EX","ET","DT","DM","OF" D CLF^DMSQU(I)
 W "Done!"
 Q
