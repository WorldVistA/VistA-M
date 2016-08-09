PRCGPUTL ;MNT/RB-IFCAP ARCHIVE/PURGE DATE UTILITY ; 01/12/16
V ;;5.1;IFCAP;**193**;JAN 12, 2016;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRC*5.1*193 Universal date query for archive/purge options
 ;
PURGEDT(PRCGTHRU,PRCGYRS) ;ARCHIVE/PURGE date query
 N PRCGDT,OUT D DT S OUT=0
P1 S PRCGDOUT=0,PRCGPGDT=0
 S DIR(0)="D^::E",DIR("A")="Select Fiscal Year thru which this option is to run",DIR("?",1)="Enter a valid FileMan date (YYYY is valid), or an up-arrow to quit."
 S DIR("?")="Date is converted to last day of FISCAL YEAR associated with entry"
 S:PRCGTHRU>0 DIR("B")=PRCGTHRU
 D ^DIR K DIR I X["^"!(X="") S OUT=1 G Q
 I $E(Y,4,5)>9 S Y=($E(Y,1,3)+1)_"0930"
 E  S Y=$E(Y,1,3)_"0930"
 S PRCGPGDT=Y
 I PRCGPGDT>PRCGDT W !,"CANNOT RUN THIS OPTION FOR LESS THAN LAST "_PRCGYRS_" FISCAL YEARS + CURRENT FISCAL YEAR" K PRCGDOUT,PRCGPGDT G P1
 D DD^%DT S PRCGDOUT=Y K Y
Q Q OUT
 ;
DT N U,X,MM,DD,YY
 S U="^"
 I '$D(DT) S DT=$$DT^XLFDT
 S MM=$E(DT,4,5),DD=$E(DT,6,7),YY=$E(DT,1,3)
 S YY=YY-PRCGYRS    ;MIN = LAST 7 YEARS + CURRENT
 S YY=YY-1,PRCGDT=YY_"0930"
 Q
