RMPR124P ;VMP/RB - FIX FIELD LENGTH PROBLEMS FOR FILES #660/664 ;01/13/06
 ;;3.0;Prosthetics;**124**;06/20/05;Build 17
 ;;
 ;1. Post install to correct fields with length error created during
 ;   cut & paste for function key input during GUI process and passed
 ;   to VISTA files 660 and 664 for fields:  Brief Description, Remarks,
 ;   Serial #, Manufacturer, Model and Lot #  
 ;
FIX664 ;search and correct length in errors for specified fields in files 664
 W @IOF
 W !,"** THIS TEMPORARY PROCESS HAS BEEN PUT IN PLACE TO SCRUB (VIA USER  **"
 W !,"** INTERACTION) ANY FIELDS IN FILE #664 AND FILE#660 THAT MAY HAVE  **"
 W !,"** A FIELD LENGTH ERROR CAUSED BY THE GUI PROSTHETICS PURCHASING    **"
 W !,"** MODULE WHICH WAS ALLOWING DATA OUTSIDE THE FIELD DEFINED LENGTH  **"
 W !,"** LIMITATIONS.                                                     **"
F1 S %=1,DTOUT=0 W !!,"WANT TO PROCEED WITH CLEANSING PROCESS" D YN^DICN I '% W !,"REPLY YES (Y) OR NO (N)" G F1
 S ANS=$S('(%-1):"Y",1:"N") I ANS="N"!$D(DIRUT)!$D(DUOUT) G EXIT
 W !!
EN ;Entry Point.
 N DIR,DA,ZTRTN,ZTDESC,RMOPT,ZTSK,ZTQUEUED,ZTIO,POP
 S DIR("?")="Please enter 1, 2, or 3."
 S DIR("?",1)="Please note: Options 2 & 3 work directly from the temporary"
 S DIR("?",2)="file created by length error compile under Option 1 - COMPILE."
 S DIR("?",3)=""
 S DIR(0)="SO^1:COMPILE LENGTH ERRORS;2:PRINT LENGTH ERROR REPORT;3:FIX LENGTH ERRORS"
 S DIR("L",1)="Select one of the following:"
 S DIR("L",2)=""
 S DIR("L",3)="1 Compile  2 Report  3 Fix Length Errors"
 D ^DIR
 S RMOPT=Y
 Q:RMOPT=""
 K DIR,DA Q:$D(DIRUT)
 I RMOPT=1 D ASKCMP Q
 I RMOPT=2 D PRINT^RMPRFPRT Q
 I RMOPT=3 D FIX Q
 G EXIT
ASKCMP ;COMPILE ASK
 N RMSTART,RMCREATE,RMPURGE,RMEND,RMREM
 S Y=$G(^XTMP("RMPRFIX","START COMPILE")) D DD^%DT S RMSTART=Y
 S Y=$G(^XTMP("RMPRFIX","END COMPILE")) D DD^%DT S RMEND=Y
 I RMEND="RUNNING" D  Q
 .W !!,"Build started on ",RMSTART," still running!"
 .D WAIT
 S RMREM=$G(^XTMP("RMPRFIX","RMPR","COUNT"))
 I RMEND'="" D
 .W !!,"Last Build completed on ",RMEND
 .I +RMREM>0 W !!,"This build contains ",+RMREM," nodes to be fixed, ",+$P(RMREM,"^",2)," field length errors",!
 .I +RMREM=0 W !!,"There are 0 items to be fixed.",!
 S DIR("A")="Do you wish to continue with NEW Build? "
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR
 K DA,DIR Q:$D(DIRUT)
 I Y=0 Q
CMP ;COMPILE
 K %DT,Y
 K ^XTMP("RMPRFIX")
 D CLEAR^VALM1
 ;D BUILD^RMPR124P Q
 S ZTRTN="BUILD^RMPR124P"
 S ZTDESC="UTILITY FOR RMPR FIELD LENGTH ERRORS"
 S ZTSAVE("RM*")="",ZTSAVE("XM*")="",ZTIO=""
 D ^%ZTLOAD
 I $D(ZTSK) W !,"Request Queued!"
 D WAIT
 Q
BUILD D NOW^%DTC S RMSTART=%
 S ^XTMP("RMPRFIX","START COMPILE")=RMSTART
 S ^XTMP("RMPRFIX","END COMPILE")="RUNNING"
 S ^XTMP("RMPRFIX",0)=$$FMADD^XLFDT(RMSTART,90)_"^"_RMSTART
FIX ;FIX BY INTERNAL PTR FOR 660/664
 N IEN0,IEN4,R664,IEN42,R40,R42,R43,R660,R6601,R6609,FLD1,FLD2,FLD7,FLD15,FLD152,FLD154,FLD156,FLD19,FLD211,FLD9
 N FLD16,FLD21,FLD24,FLD25,FLD91,FLD92,FLD1D,FLD2,DIE,DA,DR,DA1,DA2,DA1A,FILE1,FILE2,END,DATA,LMIN,LMAX,WDS
 N DTOUT,DUOUT,DIRUT,DIR,I,J,ANS,TT,IWD,PCN,HSW,WDA,WDB,WDC,HDT,NUM,Y,TFND,TFIX,RMUSER,RMOBN,HIEN,RMPRCT1,RMPRCT2
 D:RMOPT=1 BEG^RMPRFFIX D:RMOPT=3 ENT^RMPRFFIX
 G EXIT:END=1
EXIT0 W:RMOPT=3 !!,"** REPAIR PROCESS COMPLETE: ",$S(TFND=0:"NO FIELD LENGTH ERRORS FOUND",1:TFIX_" FIELD LENGTH ERRORS CORRECTED")
EXIT I $G(END)=1,RMOPT=3 W !!,"** REPAIR PROCESS TERMINATED BY USER **" I TFIX>0 W "  < ",TFIX_" FIELD LENGTH ERRORS CORRECTED"," >"
 I $G(RMOPT)=1 D
 . D NOW^%DTC S RMEND=%
 . S ^XTMP("RMPRFIX","RMPR","COUNT")=RMPRCT1_"^"_RMPRCT2
 . S ^XTMP("RMPRFIX","END COMPILE")=RMEND
 . D MAIL
 Q
MAIL ;Send mail message when build complete.
 N XMAIL,XMSUB,XMDUZ,XMTEXT,RMTEXT,Y,XMY,XMMG,XMZ
 S Y=$G(RMSTART) D DD^%DT S PXSTART=Y
 S Y=$G(RMEND) D DD^%DT S PXEND=Y
 S ZTQUEUED=1
 S RMTEXT(1)="UTILITY FOR RMPR FIELD LENGTH ERRORS is ready to report & fix."
 S RMTEXT(1)="Compile for RMPR field length errors is complete and ready to report & fix."
 S RMTEXT(2)="Start time: "_$G(PXSTART)_" End time: "_$G(PXEND)
 S XMSUB="RMPR field length error cleanup...Build Completed.."
 S XMTEXT="RMTEXT(",XMDUZ=.5,XMY(DUZ)=""
 D ^XMD
 S ^XTMP("RMPRFIX","RMPR","RMMAIL")=$G(XMZ)_"^"_DUZ_"^"_$G(XMMG)
 Q
WAIT ;
 ;Q:IO'=$G(IO("HOME"))
 N DIR,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 W ! S DIR(0)="E" S DIR("A")="Enter RETURN to continue" D ^DIR W !
 Q
