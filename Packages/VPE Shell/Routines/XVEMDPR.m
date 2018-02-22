XVEMDPR ;DJB/VEDD**Printing, Count Fields [6/28/95 6:42pm];2017-08-15  12:20 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
 ;;This is run each time VEDD is run, right after you select a File.
 ;;It sets up multiples in ^TMP("XVV","VEDD",$J,"TMP")
PRINTM ;Print Option in Main Menu
 I PRINTING'="YES" D  Q
 . W $C(7),!!?2,"NOTE: To use this option you must have ^%ZIS routines and the DEVICE and"
 . W !?8,"TERMINAL TYPE files on your system."
 S FLAGP1=1 ;Redraws Main Menu. See MENU+2^XVEMD.
PRINT ;
 S FLAGP=FLAGP=0 I FLAGP=0 D  Q  ;FLAGM-User hit <RET> at Main Menu
 . W:$E(XVVIOST,1,2)="P-"&('FLAGM) @XVV("IOF") D ^%ZISC
 . S XVVSIZE=(IOSL-6),XVV("IOF")=IOF,XVV("IOM")=IOM-1
 . S XVV("IOSL")=IOSL,XVVIOST=IOST
 S %ZIS("A")="  DEVICE: " D ^%ZIS KILL %ZIS("A") I POP S FLAGP=0
 Q
TXT ;
 I 'FLAGP W @XVV("IOF") Q
 I $E(XVVIOST,1,2)="P-" W !!!
 E  W @XVV("IOF")
 I '$D(VEDDATE) NEW %DT,X,Y D
 . S X="NOW",%DT="T" D ^%DT
 . S VEDDATE=$$DATEDASH^XVEMKU1(Y)
 W !,$E(XVVLINE1,1,XVV("IOM"))
 W !?2,"File:---- ",ZNAM,!?2,"Global:-- ",ZGL
 W ?(XVV("IOM")-17),"Date: ",VEDDATE,!,$E(XVVLINE1,1,XVV("IOM")),!
 Q
INIT ;
 I FLAGP D  W:$E(XVVIOST,1,2)="P-" !?1,"Printing.." U IO
 . S XVVSIZE=(IOSL-6),XVV("IOF")=IOF,XVV("IOM")=IOM-1
 . S XVV("IOSL")=IOSL,XVVIOST=IOST
 D TXT
 Q
MULT ;
 NEW CNT,TMP
 D MULTBLD
 Q
MULTBLD ;
 KILL ^TMP("XVV","VEDD",$J,"TMP") S CNT=1
 S ^TMP("XVV","VEDD",$J,"TMP",ZNUM)=$P(^DD(ZNUM,0),U,4)_"^"_CNT
 S ^TMP("XVV","VEDD",$J,"TOT")=$P(^DD(ZNUM,0),U,4)
 Q:'$D(^DD(ZNUM,"SB"))  S TMP(1)=ZNUM,CNT=2,TMP(CNT)=""
 F  S TMP(CNT)=$O(^DD(TMP(CNT-1),"SB",TMP(CNT))) D MULTBLD1 Q:CNT=1
 Q
MULTBLD1 ;
 I TMP(CNT)="" S CNT=CNT-1 Q
 I '$D(^DD(TMP(CNT),0)) Q
 S ^TMP("XVV","VEDD",$J,"TMP",TMP(CNT))=$P(^DD(TMP(CNT),0),U,4)_"^"_CNT_"^"_$O(^DD(TMP(CNT-1),"SB",TMP(CNT),""))
 S ^TMP("XVV","VEDD",$J,"TOT")=^TMP("XVV","VEDD",$J,"TOT")+$P(^DD(TMP(CNT),0),U,4)
 I $D(^DD(TMP(CNT),"SB")) S CNT=CNT+1,TMP(CNT)=""
 Q
