RABAR ;HISC/GJC-Procedure & CPT Code barcode output (part 1 of 2) ;7/31/96  08:57
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
EN1 ; Entry point for RA BARPROCPRINT (Barcoded Procedure List)
 ; variable list:
 ; 'RADIC' : namespaced DIC input variables passed to EN1^RASELCT
 ; 'RAPRNT': data elements to print i.e, CPT Code, Procedure or both
 ; 'RASORT': data elements to sort by i.e, CPT Code or Procedure
 ; '^TMP($J,"RA I-TYPE")': Imaging Type(s) selected by the user
 ; '^TMP($J,"RA PROC")'  : Procedure(s) selected by the user
 ;
 K ^TMP($J,"RA BARDEV"),^TMP($J,"RA I-TYPE"),^TMP($J,"RA PROC")
 N RADIC,RADT,RADX,RADY,RAPRNT,RASORT,RAVHI,RAXIT
 S RADT=$$FMTE^XLFDT(DT,"1D"),RAXIT=0
 S RATEST=$$TEST^RABAR1() I RATEST<0 D KILL Q
 I RATEST D DEV ; obtain proc test print
 K RATEST
 S RAVHI=$$HI()  ; vertical height (in lines) of the barcode
 I RAVHI<0 D KILL Q
 D KILLDIR S DIR(0)="SO^C:CPT barcode;P:Procedure barcode;B:Both barcodes"
 S DIR("A")="Which of the above would you like to print?"
 S DIR("?",1)="Enter 'B' to print both the Procedure and CPT Code in a"
 S DIR("?",2)="barcode format.  'C' to print only the CPT Code barcode,"
 S DIR("?")="or 'P' to print only the procedure in a barcode format."
 D ^DIR S:$D(DIRUT) RAXIT=1
 D KILLDIR G:RAXIT KILL S RAPRNT=Y(0)
 I $E(RAPRNT,1)="B" D BOTH G:RAXIT KILL ; sort by CPT or Procedure?
 S RAXIT=$$ITYPE() G:RAXIT KILL
 S RAXIT=$$PROC^RABAR1() G:RAXIT KILL
 I '$D(^TMP($J,"RA PROC")) D KILL Q
DEV ; Device selection
 W ! S %ZIS="QM",%ZIS("A")="Select a printer with barcode setup: "
 S %ZIS("B")=$S($D(^TMP($J,"RA BARDEV"))\10:$O(^("RA BARDEV","")),1:"")
 S %ZIS("S")="I $$DSCR^RABAR(+Y)" D ^%ZIS
 I POP D KILL Q
 I $D(RATEST) S ^TMP($J,"RA BARDEV",ION)=""
 I $D(IO("Q")) D  G KILL
 . S ZTRTN="START^RABAR"
 . S ZTDESC="Rad Nuc/Med Print procedure/CPT code in a barcode format."
 . D ZTSAVE^RABAR1,^%ZTLOAD
 . I +$G(ZTSK("D"))>0 W !?5,"Request Queued, Task #: ",$G(ZTSK)
 . D HOME^%ZIS
 . K %X,%XX,%Y,%YY,IO("Q"),X,Y
 . Q
START ; Start processing data & printing to the device here
 S:$D(ZTQUEUED) ZTREQ="@" U IO
 I '$D(RATEST) D
 . S RAHD1="Barcode print of Imaging "
 . S:$E(RAPRNT,1)="B" RAHD1=RAHD1_"Procedures & CPT Codes"
 . S:$E(RAPRNT,1)="C" RAHD1=RAHD1_"CPT Codes"
 . S:$E(RAPRNT,1)="P" RAHD1=RAHD1_"Procedures"
 . Q
 S:$D(RATEST) RAHD1="Barcode test print"
 S RAHD2="Printed on: "_RADT,RAPG=0
 S $P(RALINE,"-",(IOM+1))="",RA1=""
 I $D(RATEST) D
 . D HDR Q:RAXIT  D PRINT1^RABAR1
 . Q
 E  D
 . N RAEOS S RAEOS=$S($D(RAVHI):RAVHI,1:6) D HDR Q:RAXIT
 . F  S RA1=$O(^TMP($J,"RA PROC",RA1)) Q:RA1=""  D  Q:RAXIT
 .. S RA2=0 F  S RA2=$O(^TMP($J,"RA PROC",RA1,RA2)) Q:RA2'>0  D  Q:RAXIT
 ... D PRINT^RABAR1
 ... Q
 .. Q
 . Q
 W ! D ^%ZISC
 D KILL
 Q
BOTH ; Ask the user which to sort by i.e, CPT Code -or- Procedure
 W ! D KILLDIR S DIR(0)="SOA^C:CPT Code;P:Procedure"
 S DIR("A")="Select the data element you wish to sort by: "
 S DIR("?",1)="Enter 'C' to sort by the CPT Code, or 'P' to sort by the"
 S DIR("?")="procedure."
 D ^DIR S:$D(DIRUT) RAXIT=1
 D KILLDIR Q:RAXIT  S RASORT=Y(0)
 Q
DOLLARY ; Caculate the new value of $Y for formatting purposes.
 S RADX=$X,RADY=($Y+RAVHI) D ZOSF^RABAR1(RADX,RADY)
 Q
DSCR(Y) ; Device screen logic, select only barcode capable devices.
 N RABAR0,RABAR1,RATERMTY S RATERMTY=+$G(^%ZIS(1,+Y,"SUBTYPE"))
 Q:'RATERMTY 0 ; missing pointer to Terminal Type file!
 S RABAR0=$G(^%ZIS(2,RATERMTY,"BAR0")) ; barcode off node
 S RABAR1=$G(^%ZIS(2,RATERMTY,"BAR1")) ; barcode on node
 Q:(RABAR0]"")&(RABAR1]"") 1 ; barcoding capability
 Q 0
HDR ; Header
 W:$Y @IOF S RAPG=RAPG+1
 W !?(IOM-$L(RAHD1)\2),RAHD1
 W !?(IOM-$L(RAHD2)\2),RAHD2
 W ?$S(IOM=132:116,1:64),"Page: ",RAPG
 W !,RALINE
 ; Check if user stops the task.
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1
 Q
HELP ; Help message for barcode height prompt
 W !,"If you don't know how to answer this prompt, first determine which printer",!,"you are going to use.  Then exit this option and re-select it from your menu."
 W !,"When you are asked if you want to print a sample barcode, enter 'Yes'."
 W !,"Enter your printer selection at the 'DEVICE' prompt, then retrieve your",!,"sample printout.  If no barcode has printed, contact your IRM and ask them"
 W !,"to set up the printer for barcode printing.  If a barcode has printed, use",!,"the line counts printed above and below the barcode to determine how many"
 W !,"vertical lines the barcode occupies (include the procedure name line printed",!,"below the barcode)."
 Q
HI() ; user input of height (in lines) of the barcode
 ; returns the height (in lines) of the barcode, OR -1 if user chooses
 ; to exit without inputting a number.
 N RALOW,RAHI S RALOW=1,RAHI=10
 W ! D KILLDIR S DIR(0)="NA^"_RALOW_":"_RAHI
 S DIR("A")="Enter the height of the barcode: "
 S DIR("?",1)="Enter the height of the barcode in terms of vertical text lines ("_RALOW_" to "_RAHI_")"
 S DIR("?")="for your printer, or '^' to exit."
 S DIR("??")="^D HELP^RABAR"
 D ^DIR S Y=$S($D(DIRUT):-1,1:+Y) D KILLDIR
 Q Y
INA(Y) ; Determines if the procedure is inactive
 ; Input : IEN of file 71
 ; Output: 1 if active, 0 if inactive
 Q:+$G(^RAMIS(71,+Y,"I"))=0 1
 Q $S(+$G(^RAMIS(71,+Y,"I"))>DT:1,1:0)
 ;
ITYPE() ; Select the Imaging Type(s)
 N RADIC,RAINPUT,RAQUIT,RAUTIL
 S RADIC="^RA(79.2,",RADIC(0)="QEAMZ",RADIC("A")="Select Imaging Type: "
 S RAUTIL="RA I-TYPE",RAINPUT=1 D EN1^RASELCT(.RADIC,RAUTIL,"",RAINPUT)
 Q RAQUIT
KILL ; Kill all other variables [ includes ^TMP($J) ]
 K:'$D(RATEST) ^TMP($J,"RA BARDEV")
 K ^TMP($J,"RA I-TYPE"),^TMP($J,"RA PROC")
 K %X,%XX,%Y,%YY,RA1,RA2,RAHD1,RAHD2,RALINE,RAPG,RAPG1,RATEST,X,Y
 K ZTDESC,ZTRTN,ZTSAVE
 K DDH,I,POP
 Q
KILLDIR ; Kill off variables from DIR call
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 Q
LINE ; Print ten lines of text
 N I F I=1:1:10 W !,"LINE ",I
 Q
