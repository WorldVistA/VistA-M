XDRCNT ;SF-IRMFO/OHPRD/LAB - Count/Tally records by status/merged status;   [ 08/13/92  09:50 AM ] ;8/28/08  17:55
 ;;7.3;TOOLKIT;**23,113**;Apr 25, 1995;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
START ;
 D EN^XDRVCHEK
 D INFORM
 D INIT
 D GETFILE
 G:XDRQFLG EOJ
 D ZIS
 G:XDRQFLG EOJ
 D PROCESS
 D EOJ
 Q
EOJ ;Eoj cleanup
 K XDRQFLG,XDRD,XDRFL,XDRCNT
 S:$D(ZTQUEUED) ZTREQ="@"
 K ZTSK,POP,I,S
 W:$D(IOF) @IOF
 D ^%ZISC
 Q
INIT ;initialize variables
 S XDRQFLG=0,XDRCNT("PG")=0
 S X=$G(^DD(15,.03,0)) I X="" W !!,$C(7),"Dictionary error!!  Notify a programmer!" S XDRQFLG=1 Q
 S X=$P(X,U,3)
 F I=1:1 S S=$P(X,";",I) Q:S=""  S XDRCNT("STATUS",$P(S,":",1),"CNT")=0,XDRCNT("STATUS",$P(S,":",1),"NAME")=$P(S,":",2)
 I '$D(XDRCNT("STATUS")) S XDRQFLG=1 W !!,"Dictionary error!!  Notify a programmer!" Q
 S X=$G(^DD(15,.05,0)) I X="" W !!,$C(7),"Dictionary error!!  Notify a programmer!" S XDRQFLG=1 Q
 S X=$P(X,U,3)
 F I=1:1 S S=$P(X,";",I) Q:S=""  S XDRCNT("MERGE STATUS",$P(S,":",1),"CNT")=0,XDRCNT("MERGE STATUS",$P(S,":",1),"NAME")=$P(S,":",2)
 I '$D(XDRCNT("MERGE STATUS")) S XDRQFLG=1 W !!,"Dictionary error!!  Notify a programmer!" Q
 S XDRCNT("TOTAL RECS")=0
 Q
 ;
GETFILE ;get file to tally records fo
 K XDRFL
 ; XT*7.3*113 input variable XDRNOPT to FILE^XDRDQUE-if UNDEF, allows PATIENT file to be selected
 N XDRNOPT
 S DIC("A")="Tally duplicate entries for which file? " D FILE^XDRDQUE
 Q:XDRQFLG
 S XDRCNT("GBL")=^DIC(XDRFL,0,"GL"),XDRCNT("GBL")=$P(XDRCNT("GBL"),U,2)
 Q
ZIS W !! K ZTSK,ZTQUEUED,IOP S %ZIS="PQM" D ^%ZIS
 I POP S XDRQFLG=1 Q
 I $D(IO("Q")) D TSKMN
 Q
TSKMN ;
 S ZTIO=$S($D(ION):ION,1:IO) I $D(IOST)#2,IOST]"" S ZTIO=ZTIO_";"_IOST
 I $D(IO("DOC")),IO("DOC")]"" S ZTIO=ZTIO_";"_IO("DOC")
 I $D(IOM)#2,IOM S ZTIO=ZTIO_";"_IOM I $D(IOSL)#2,IOSL S ZTIO=ZTIO_";"_IOSL
 K ZTSAVE S ZTSAVE("*")=""
 S ZTRTN="PROCESS^XDRCNT",ZTDTH="",ZTDESC="TALLY DUPLICATE RECORD STATUS" D ^%ZTLOAD S XDRQFLG=1
 Q
PROCESS ;
 NEW X,D,S
 ;S X=0_";"_XDRCNT("GBL") F  S X=$O(^VA(15,"B",X)) Q:X=""!($P(X,";",2)'=XDRCNT("GBL"))  D
 S X=0_";"_XDRCNT("GBL") F  S X=$O(^VA(15,"B",X)) Q:X=""  I $P(X,";",2)=XDRCNT("GBL") D
 . S D=0 F  S D=$O(^VA(15,"B",X,D)) Q:D'=+D   D
 . . Q:^VA(15,"B",X,D)=1
 . . S XDRCNT("TOTAL RECS")=XDRCNT("TOTAL RECS")+1
 . . S S=$P(^VA(15,D,0),U,3)
 . . I S=""
 . . E  S XDRCNT("STATUS",S,"CNT")=$G(XDRCNT("STATUS",S,"CNT"))+1
 . . I S="V" D
 . . . S S=+$P(^VA(15,D,0),U,5)
 . . . S XDRCNT("MERGE STATUS",S,"CNT")=XDRCNT("MERGE STATUS",S,"CNT")+1
 . . Q
 .Q
PRINT ;print report
 U IO
 D HEADER
 W !!,"Total Number of Duplicate Records for File ",$E(XDRD(0,0),1,18),":  ",?65,$J(XDRCNT("TOTAL RECS"),6),!
 W !?5,"STATUS field:" S X=0 F  S X=$O(XDRCNT("STATUS",X)) Q:X=""  D
 .I $Y>(IOSL-5) D HEADER Q:$D(XDRCNT("QUIT"))  W !
 .W ?26,$E(XDRCNT("STATUS",X,"NAME"),1,34),?65,$J(XDRCNT("STATUS",X,"CNT"),6),!
 W !?5,"MERGE STATUS field:" S X="" F  S X=$O(XDRCNT("MERGE STATUS",X)) Q:X=""  D
 .I $Y>(IOSL-5) D HEADER Q:$D(XDRCNT("QUIT"))  W !
 .W ?26,$E(XDRCNT("MERGE STATUS",X,"NAME"),1,34),?65,$J(XDRCNT("MERGE STATUS",X,"CNT"),6),!
 .Q
 I $E(IOST)="C" W !!,"End of Report.  Press return to exit" R X:DTIME
 Q
HEADER ;print header information
 N DIR,X,Y
 I 'XDRCNT("PG") G HEADER1
 I $E(IOST)="C",IO=IO(0) W ! S DIR(0)="EO" D ^DIR K DIR I Y=0!(Y="^")!($D(DTOUT)) S XDRCNT("QUIT")="" Q
HEADER1 ;
 W:$D(IOF) @IOF S XDRCNT("PG")=XDRCNT("PG")+1
 W !?3,$P(^DIC(4,DUZ(2),0),U) S Y=DT D DD^%DT W ?50,Y,?70,"Page ",XDRCNT("PG"),?78,!
 W !?12,"TALLY OF DUPLICATE RECORDS' STATUS/MERGE STATUS FIELDS"
 S XDRCNT("LENG")=7+$L(XDRD(0,0))
 W !?((80-XDRCNT("LENG"))/2),"FILE:  ",XDRD(0,0),?78,!
 W !,$TR($J("",80)," ","-")
 Q
INFORM ;inform user
 W !!,"This report will tally the Status and Merge Status fields for all",!,"entries in the Duplicate record file for the file that you select.",!
 Q
