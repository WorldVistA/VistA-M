PRCGARCF ;WIRMFO@ALTOONA/CTB FIND ARCHIVABLE RECORDS ;12/10/97  9:49 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;ifcap archive
 ;SELECT STATION
 S PRCF("X")="AS" D ^PRCFSITE Q:'%
 D NOW^%DTC
 S CFY=$E(X,1,3)+1700,CFY=$S(+$E(X,4,5)>9:CFY+1,1:CFY)
 ;SELECT FISCAL YEAR
 F  D  Q:AFY>0!($D(OUT))
 . S DIR(0)="D^::E",DIR("A")="Select the Fiscal Year thru which this option is to run"
 . S DIR("?",1)="Enter a valid FileMan date.  If you select an exact date, I will",DIR("?")="convert it to the last day of the FISCAL YEAR."
 . D ^DIR
 . S AFY=0
 . I X["^"!(X="") S X="<  No action taken>*" D MSG^PRCFQ S OUT=1 QUIT
 . Q:Y<0
 . S FY=Y
 . I $E(FY,4,5)>9 S FY=($E(FY,1,3)+1)_"0930"
 . E  S FY=$E(FY,1,3)_"0930"
 . S AFY=$E(FY,1,3)+1700
 . I CFY-AFY<3 S X="You may only select for archive those documents which are greater that 2 Fiscal Years old.*" D MSG^PRCFQ S AFY=0 QUIT
 I $D(OUT) K OUT QUIT
 S %=2
 I $O(^PRC(443.9,0)) D
 . F  D  Q:%<3
 . . W !! S %A="There are already records in the IFCAP Pending Archive File",%A(1)="If these are old records, they could cause duplication of the archive.",%A(2)="Do you want me to REMOVE these records before I begin"
 . . S %=1 D ^PRCFYN Q:%'=1
 . . S %A="ARE YOU SURE" D ^PRCFYN
 . . Q:%'=2  W !! S X="OK,  Now I'm really confused.  Let's do that again.*" D MSG^PRCFQ S %=3
 . . QUIT
 . QUIT
 QUIT:%<0
 S CLEANFIL=%
 S ZTDESC="IFCAP ARCHIVE RECORD FIND",ZTSAVE("AFY")="",ZTSAVE("EFY")="",ZTSAVE("FY")="",ZTSAVE("CFY")="",ZTSAVE("PRC*")="",ZTSAVE("CLEANFIL")="",ZTRTN="^PRCGARCG"
 D ^PRCFQ
END K FY,BFY,EFY,CFY,AFY,NX,MX,ZERONODE,FLAG,X,Y,TREC,CREC,LREC,XPOS,DX,CY,MOP,ARCBIT,DIC,DLAYGO,A,N,M,PERCENT
 K %DT,ARCHECK,CURSOR,CLEANFIL,D0,DG,DICR,DIG,DIH,DIU,DIV,DIW,ITEMS,MESSAGE,OUT,RTIME,TTIME,YPOS
 QUIT
