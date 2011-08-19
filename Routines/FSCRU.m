FSCRU ;SLC/STAFF-NOIS Report Utility ;8/29/94  10:20
 ;;1.1;NOIS;;Sep 06, 1998
 ;
DISPLAY(DISPLAY,OK) ; from FSCOPT, FSCRPTS
 N DIR,X,Y K DIR S DISPLAY="",OK=1
 S DIR(0)="SAMO^DEVICE:DEVICE;VIEW:VIEW",DIR("A")="Select (D)evice or (V)iew: ",DIR("B")="View"
 S DIR("?",1)="Enter DEVICE to display the report to the screen or queue to a device."
 S DIR("?",2)="Enter VIEW to display the report on the NOIS View Screen using List Manager."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) S OK=0 Q
 S DISPLAY=Y
 Q
 ;
PT ; from FSCLMP
 D DEV("VALM*",VALMAR,"DQPT^FSCRUDQ","NOIS - Print Text",.OK)
 Q
 ;
PS ; from FSCLMP
 D DEV("VALM*",VALMAR,"DQPS^FSCRUDQ","NOIS - Print Screen",.OK)
 Q
 ;
DEV(SAVE,SAVEG,RTN,DESC,OK) ; from FSCOPT, FSCRPTS
 I '$L($G(RTN)) Q
 N %ZIS,FIRST,FSCDEV,PAGEBRK,POP,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK K %ZIS,ZTSAVE S (FSCDEV,OK)=1,PAGEBRK=0
 I $P($G(FSCSTYLE(0)),U,8),$L($G(DESC)),DESC'["Print Screen" S OK=1 D  I 'OK Q
 .I DESC="NOIS Report" D PAGEBRK(.PAGEBRK,.OK) Q
 .I $L($G(VALMAR)),@VALMAR>1 D PAGEBRK(.PAGEBRK,.OK) Q
 .I $G(SAVEG)="^TMP(""FSC LIST"",$J," S FIRST=$O(^TMP("FSC LIST",$J,0)) I FIRST,$O(^(FIRST)) D PAGEBRK(.PAGEBRK,.OK)
 D
 .S %ZIS="Q",%ZIS("B")=""
 .D ^%ZIS I POP S OK=0 Q
 .I $G(IO("Q"))'=1 D @RTN Q
 .S ZTIO=ION_";"_IOST I $L($G(IO("DOC"))) S ZTIO=ZTIO_";"_IO("DOC")
 .S ZTSAVE("FSC*")="",ZTSAVE("PAGEBRK")=""
 .I $L($G(SAVE)) S ZTSAVE(SAVE)=""
 .I $L($G(SAVEG)) S ZTSAVE(SAVEG)="",SAVEG=$E(SAVEG,1,$L(SAVEG)-1)_",",ZTSAVE(SAVEG)=""
 .S ZTRTN=RTN
 .S ZTDESC=$G(DESC)
 .D ^%ZTLOAD
 .W !,$S($D(ZTSK):"Request queued",1:"Request cancelled")
 .D HOME^%ZIS
 W ! D ^%ZISC
 Q
 ;
PAGEBRK(PAGEBRK,OK) ;
 N DIR,X,Y K DIR S PAGEBRK=0
 S DIR(0)="YAO",DIR("A")="Start each call on a new page: ",DIR("B")="NO"
 S DIR("?",1)="Enter YES to have each call begin on a new page."
 S DIR("?",2)="Enter NO to simply print the display text."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) S OK=0 Q
 I Y=1 S PAGEBRK=1
 Q
 ;
REPLACE(STR,CHAR,WITH) ; $$(string,replace characters,with characters) -> new string
 N ARRAY K ARRAY
 S ARRAY(CHAR)=WITH
 Q $$REPLACE^XLFSTR(STR,.ARRAY)
