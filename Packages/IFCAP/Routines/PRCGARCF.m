PRCGARCF ;WIRMFO@ALTOONA/CTB FIND ARCHIVABLE RECORDS ;12/10/97  9:49 AM
V ;;5.1;IFCAP;**193**;Oct 20, 2000;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 ;ifcap archive
 ;
 ;PRC*5.1*193 Added universal date control query to process
 ;
 ;SELECT STATION
 S PRCF("X")="AS" D ^PRCFSITE Q:'%
 D NOW^%DTC
 S CFY=$E(X,1,3)+1700,CFY=$S(+$E(X,4,5)>9:CFY+1,1:CFY)
DT ;SELECT FISCAL YEAR        ;PRC*5.1*193
 S PRCGOUT=$$PURGEDT^PRCGPUTL("",7)
 I PRCGPGDT'>0!PRCGOUT G END
 W !! S %A="The archiving processing will go through date "_PRCGDOUT_" is this OK?" S %=1 D ^PRCFYN G END:%'=1
 W !! S %A="ARE YOU SURE" D ^PRCFYN I %'=1 W ?35,"I am confused, let's start over..." G DT
 S FY=PRCGPGDT,AFY=$E(FY,1,3)+1700
CKOLD S %=2
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
END K FY,BFY,EFY,CFY,AFY,NX,MX,ZERONODE,FLAG,X,Y,TREC,CREC,LREC,XPOS,DX,CY
 K MOP,ARCBIT,DIC,DLAYGO,A,N,M,PERCENT,%DT,ARCHECK,CURSOR,CLEANFIL,D0
 K DG,DICR,DIG,DIH,DIU,DIV,DIW,ITEMS,MESSAGE,OUT,RTIME,TTIME,YPOS
 K PRCGOUT,PRCGDOUT,PRCGPGDT
 QUIT
