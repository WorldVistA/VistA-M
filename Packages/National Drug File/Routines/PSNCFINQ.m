PSNCFINQ ;BIR/PC - Control File Inquiry Screen ;01/30/2017
 ;;4.0;NATIONAL DRUG FILE;**513**; 30 Oct 98;Build 53
 ;
 N PSNCFBEG,PSNCFEND,PSNCFB,PSNCFE,PSNCFIEN,CNT,PSNCFAX
 K DIC,DIR
ASK ;ask if Download or Install Inquiry
 S (PSNCFOUT,PSNCFQ)=0,PSNCFPG=1,$P(PSNCFLIN,"-",78)=""
 W ! K DIR,Y S DIR(0)="SA^D:DOWNLOAD;I:INSTALL;Q:QUIT"
 S DIR("A")="Select (D)ownload Detail, (I)nstall Detail or (Q)uit: "
 D ^DIR I Y="Q"!$D(DIRUT) G END
 S PSNCFAX=Y
 D DATE I PSNCFQ=1 G END
ASK1 ;
 D @$S(PSNCFAX="I":"ISUM",1:"DSUM") I PSNCFQ=1 G ASK
 D CHOOSE I PSNCFQ=1!($D(DIRUT)) G ASK
 K PSNCFAR D GETS^DIQ(57.23,1,".01;1;2;3;5;6;8;9;10","E","PSNCFAR") ;ZERO level
 S PSNINNM=$S(PSNCFAX="I":$$GET1^DIQ(57.231,PSNCFIEN_",1,",.01,"E"),1:$$GET1^DIQ(57.234,PSNCFIEN_",1,",.01,"E"))
 I PSNCFAX="I" D INSTALL S PSNCFQ=0 G ASK1
 I PSNCFAX="D" D DOWNLD,CONT G ASK1
 Q
DATE ;enter date range for list of .DAT files
 N %DT,X K PSNDT
 S %DT(0)=-DT,%DT="AEP",%DT("A")="Enter Start Date: " W ! D ^%DT I Y<0!($D(DTOUT)) S PSNCFQ=1 Q
 S PSNCFBEG=Y\1-.00001,PSNCFB=Y
 S %DT(0)=PSNCFBEG+1\1,%DT("A")="Enter End Date: " W ! D ^%DT I Y<0!($D(DTOUT)) S PSNCFQ=1 Q
 S PSNCFEND=Y\1+.99999,PSNCFE=Y
 S PSNCFL2=$$FMTE^XLFDT(PSNCFB)_" to "_$$FMTE^XLFDT(PSNCFE)
 S PSNCFOUT=0,PSNCFDEV=$S($E(IOST,1,2)'="C-":"P",1:"C"),PSNCFPG=1
 Q
 ;
ISUM ; SUMMARY SCREEN FOR INSTALL FILES
 K PSNX1,PSNCARR S PSNCFPG=1,PSNJ=""
 D HEAD S CNT=0,PSNCFOUT=0
 I '$D(PSNDT) S PSNX1=PSNCFBEG F  S PSNX1=$O(^PS(57.23,1,5,"C",PSNX1)) Q:PSNX1=""!(PSNX1>PSNCFEND)  F  S PSNJ=$O(^PS(57.23,1,5,"C",PSNX1,PSNJ)) Q:PSNJ=""  S PSNDT(PSNJ)=PSNX1
 S PSNCFIEN=0 F  S PSNCFIEN=$O(PSNDT(PSNCFIEN)) Q:PSNCFIEN=""  D GETS^DIQ(57.231,PSNCFIEN_",1",".01;1;2","E","PSNCARR") D  Q:PSNCFOUT=1
 . S CNT=CNT+1,PSNCFSM(CNT)=PSNCFIEN_"^"_PSNCARR(57.231,PSNCFIEN_",1,",.01,"E")
 . W !,"("_CNT_") ",PSNCARR(57.231,PSNCFIEN_",1,",.01,"E"),?32,PSNCARR(57.231,PSNCFIEN_",1,",1,"E"),?55,PSNCARR(57.231,PSNCFIEN_",1,",2,"E")
 . I ($Y+5)>IOSL D HEAD Q:PSNCFOUT=1
 W !! I CNT=0 W !!,"No Install files for date range chosen.  Please enter new dates.",$C(7) W ! D CONT S PSNCFQ=1
 Q
 ;
DSUM ; SUMMARY SCREEN FOR DOWNLOAD FILES
 K PSNX1,PSNCARD S PSNCFPG=1,PSNJ=""
 D HEAD S CNT=0,PSNCFOUT=0
 I '$D(PSNDT) S PSNX1=PSNCFBEG F  S PSNX1=$O(^PS(57.23,1,4,"D",PSNX1)) Q:PSNX1=""!(PSNX1>PSNCFEND)  F  S PSNJ=$O(^PS(57.23,1,4,"D",PSNX1,PSNJ)) Q:PSNJ=""  S PSNDT(PSNJ)=PSNX1
 S PSNCFIEN=0 F  S PSNCFIEN=$O(PSNDT(PSNCFIEN)) Q:PSNCFIEN=""  D GETS^DIQ(57.234,PSNCFIEN_",1",".01;1;2","E","PSNCARD") D  Q:PSNCFOUT=1
 . S CNT=CNT+1,PSNCFSM(CNT)=PSNCFIEN_"^"_PSNCARD(57.234,PSNCFIEN_",1,",.01,"E")
 . W !,"("_CNT_") ",PSNCARD(57.234,PSNCFIEN_",1,",.01,"E"),?32,PSNCARD(57.234,PSNCFIEN_",1,",1,"E"),?55,PSNCARD(57.234,PSNCFIEN_",1,",2,"E")
 . I ($Y+5)>IOSL D HEAD Q:PSNCFOUT=1
 W !! I CNT=0 W !!,"No Download files for date range chosen.  Please enter new dates.",$C(7) W ! D CONT S PSNCFQ=1
 Q
 ;
HEAD ; SUMMARY HEADER PAGE
 I $G(PSNCFPG)'=1 W ! K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSNCFOUT=1 Q
 W @IOF
 W !,$S(PSNCFAX="D":"DOWNLOAD",1:"INSTALL")_" FILE NAME",?32,$S(PSNCFAX="D":"DOWNLOAD",1:"INSTALL")_" BEGIN DT/TM",?55,"COMPLETION DT/TM"
 W !,PSNCFL2,?68,"PAGE: "_PSNCFPG,!,PSNCFLIN S PSNCFPG=PSNCFPG+1
 Q
 ;
HEAD1(PSNH) ; DETAIL HEADER PAGE
 ;PSNP = DETAIL OR ERROR
 I $G(PSNCFPG)'=1 W ! K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSNCFQ=1 Q
 W @IOF
 W !,PSNH_" INFORMATION FOR FILE "_PSNINNM
 W !,?68,"PAGE: "_PSNCFPG,!,PSNCFLIN S PSNCFPG=PSNCFPG+1
 Q
 ;
CHOOSE ;File Selection
 K DIR,X,Y,DIRUT,DUOUT S PSNCFQ=0 S DIR(0)="LA^1:"_CNT
 S DIR("A")="Select "_$S(PSNCFAX="D":"a Download",1:"an Install")_" File for greater detail. Choose 1-"_CNT_" or '^' to Quit: "
 S DIR("?")="Select from the above list of files or a enter '^' to Quit."
 D ^DIR I $D(DIRUT)!($D(DUOUT)) S PSNCFQ=1 Q
 S PSNCFANS=$P(Y,",",1),PSNCFIEN=$P(PSNCFSM(PSNCFANS),"^",1)
 Q
 ;
INSTALL ; INSTALL SCREEN
 K PSNCFARR
 D GETS^DIQ(57.231,PSNCFIEN_",1,","**","ERN","PSNCFARR")  ;INSTALL INFORMATION
 W !!,"Current Install Status:",!,"-----------------------"
 W !,"Name: ",?30,$G(PSNCFAR(57.23,"1,",.01,"E"))
 W !,"Open VMS Local Directory:",?30,$G(PSNCFAR(57.23,"1,",1,"E"))
 W !,"UNIX/LINUX Local Directory:",?30,$G(PSNCFAR(57.23,"1,",3,"E"))
 W !,"PPS-N Install Version:",?30,$G(PSNCFAR(57.23,"1,",2,"E"))
 W !,"PPS-N Mail Group:",?30,$G(PSNCFAR(57.23,"1,",5,"E"))
 W !,"Secondary Mail Group:",?30,$G(PSNCFAR(57.23,"1,",6,"E"))
 W !,"PPS-N Download Version:",?30,$G(PSNCFAR(57.23,"1,",8,"E"))
 W !,"Download Status:",?30,$G(PSNCFAR(57.23,"1,",9,"E"))
 W !,"Install Status:",?30,$G(PSNCFAR(57.23,"1,",10,"E"))
 W !!,"Install Information for file "_PSNINNM_":",!,"--------------------------------------------------"
 W !,"Install Begin Date/Time:",?30,$G(PSNCFARR(57.231,PSNCFIEN_",1,","INSTALL BEGIN DATE/TIME","E"))
 W !,"Install Completion Date/Time:",?30,$G(PSNCFARR(57.231,PSNCFIEN_",1,","INSTALL COMPLETION DATE/TIME","E"))
 W !,"Last VistA file processed:",?30,$G(PSNCFARR(57.231,PSNCFIEN_",1,","LAST VISTA FILE PROCESSED","E"))
 W !,"Last File IEN processed:",?30,$G(PSNCFARR(57.231,PSNCFIEN_",1,","LAST FILE IEN PROCESSED","E"))
 W !,"Last TMP file subscript:",?30,$G(PSNCFARR(57.231,PSNCFIEN_",1,","LAST TMP FILE SUBSCRIPT","E"))
 W !,"Last Update file section:",?30,$G(PSNCFARR(57.231,PSNCFIEN_",1,","LAST UPDATE FILE SECTION","E"))
 W !,"Displayed Last:",?30,$G(PSNCFARR(57.231,PSNCFIEN_",1,","DISPLAYED LAST","E"))
 ; ask if Error or Quit
 W ! K DIR,Y S DIR(0)="SA^E:ERROR;Q:QUIT"
 S DIR("A")="Select (E)rror Detail or (Q)uit: "
 D ^DIR I Y="Q"!$D(DIRUT) S PSNCFQ=1 Q
 S PSNCFXX=Y
 I PSNCFXX="E" D ERROR G INSTALL
 Q
DOWNLD ; DOWNLOAD HISTORY
 S PSNCFPG=1,PSFLG=0 D HEAD1("DOWNLOAD")
 S PSNJ="" F  S PSNJ=$O(^PS(57.23,1,4,"B",$P(PSNINNM,";",1),PSNJ)) Q:PSNJ=""   D  I PSFLG=1 D CONT Q
 . S PSNDND=$G(^PS(57.23,1,4,PSNJ,0)) I PSNDND="" W !!,"No Download Information for this file" S PSFLG=1 Q
 . W !,"Download File Name:",?33,$P(PSNDND,"^",1)
 . W !,"Download Begin Date/Time:",?33,$$FMTE^XLFDT($P(PSNDND,"^",2))
 . W !,"Download Complete Date/Time:",?33,$$FMTE^XLFDT($P(PSNDND,"^",3))
 . W !,"Download File Size:",?33,$E($P(PSNDND,"^",4),2,99)
 . W !,"Download Error Message:" I $L($P(PSNDND,"^",5))<46 W ?33,$P(PSNDND,"^",5),! Q
 . N X,DIWL,DIWR,DIWF S X=$P(PSNDND,"^",5),DIWL=34,DIWR=79,DIWF="W" K ^UTILITY($J,"W") D ^DIWP D ^DIWW K ^UTILITY($J,"W")
 Q
 ;
ERROR ; INSTALL ERROR SCREEN
 S PSNCFPG=1 D HEAD1("ERROR")
 I '$D(^PS(57.23,1,5,PSNCFIEN,2,1,0)) W !!,"No Error Information for this file" D CONT Q
 S PSNJ="" F PSNJ=1:1 S PSNJ=$O(^PS(57.23,1,5,PSNCFIEN,2,PSNJ)) Q:PSNJ=""  D
 . S PSNJD=$G(^PS(57.23,1,5,PSNCFIEN,2,PSNJ,0))
 . W !,"Error Date/Time:",?33,$$FMTE^XLFDT($P(PSNJD,"^",1))
 . W !,"Error File:",?33,$P(PSNJD,"^",2)
 . W !,"Error IEN:",?33,$P(PSNJD,"^",3)
 . W !,"Error TMP file subscript:",?33,$P(PSNJD,"^",4)
 . W !,"Error Message: " I $L($P(PSNJD,"^",5))<46 W ?33,$P(PSNJD,"^",5),! Q
 . N X,DIWL,DIWR,DIWF S X=$P(PSNJD,"^",5),DIWL=33,DIWR=79,DIWF="W" K ^UTILITY($J,"W") D ^DIWP D ^DIWW K ^UTILITY($J,"W")
 D CONT
 Q
 ;
CONT ;
 K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR
 Q
 ;
END ; KILL VARIABLES
 K X,%DT,DA,DA,DIC,DIE,DIR,DR,DIRUT,DTOUT,PSNCFAR,PSNCFER,PSNCFARR,PSNCFDEV,PSNINNM,PSNCARR,PSNDND
 K PSNCFBEG,PSNCFEND,PSNCFOUT,PSNCFPG,PSNCFL2,PSNCFLIN,PSNCFBG,PSNCFIEN,PSNCFXX,PSNCFDN,PSNCFANS
 K PSNCFSM,PSNDT,PSNH,PSNJ,PSNX,PSFLG,PSNJD,PSNCFAX,PSNCFQ,PSNJ,PSNCFE,PSNCFB
 Q
