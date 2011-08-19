DVBACPPB ;ALB/DW - Print Blank C&P Worksheets ; 8/27/1999
 ;;2.7;AMIE;**30**;Apr 10, 1995
 ;
 ;
EN ;Entry point of the routine.
 N X,Y,CPNO,HD7,HD8,HD9,HD91,LX,LY,PG,DTOUT
 D HOME^%ZIS
 D SELECT
 I X="^"!(X="") W @IOF Q
 I $D(DTOUT) W *7 W @IOF Q
 S CPNO=+Y
 D PRINT
 D EXIT
 W @IOF
 Q
 ;
SELECT ;Select C&P worksheet to print.
 N DIC
 S DIC="^DVB(396.6,",DIC(0)="AEQM",DIC("A")="Select C&P worksheet to print: "
 S DIC("S")="I $P($G(^DVB(396.6,Y,0)),U,5)=""A"""
 D ^DIC
 Q
 ;
PRINT ;Select device to print the chosen C&P worksheet.
 W !!,"** Worksheets should be sent to a printer. **",!!
 N CODE,NAME,SSN,CNUM
 N POP,ZTSAVE,TSK,%ZIS,ZTRTN,ZTDESC,ZTSK
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="WRITER^DVBACPPB",ZTDESC="DVBA Print blank C&P worksheets."
 . S ZTSAVE("CPNO")=""
 . D ^%ZTLOAD
 . S TSK=$S($D(ZTSK)=0:"C",1:"Y")
 . I TSK="Y" W !!,"Task queued! Task number: ",ZTSK
 . D HOME^%ZIS
 I '$D(IO("Q")) D WRITER
 Q
 ;
WRITER ;Print out the chosen worksheet.
 U IO
 I $E(IOST,1,2)="C-" W @IOF
 S CODE=$P($G(^DVB(396.6,CPNO,0)),U,4) I $G(CODE)="" Q
 S (NAME,SSN,CNUM)=""
 S CODE="^"_CODE
 D @CODE
 D ^%ZISC
 Q
 ;
EXIT ;Clean up variables upon exit.
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
