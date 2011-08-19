SPNPRTMT ;HIRMFO/WAA- Master Search Program ; 8/20/96
 ;;2.0;Spinal Cord Dysfunction;**3**;01/02/1997
 ;;
 ; This routine is the master search program
 ; It Will call all the needed search routines as needed
 ;EN1
 ; This entry point is the main sort and selection entry point
 ; The user will be asked to select a series of question then
 ; be allowed to select other fields to search by.
 ;
 ;EN2(D0) 
 ; This entry point is the main filter routine.  This program
 ; will pass all the patient with in the data base through the
 ; pre-select filter and only store those who mee all the critera
 ; that was asked for.
 ; Input:
 ;     D0 = Patient DFN
 ; Output:
 ;     FLAG = 1/0
 ;            1 patient meets the critera
 ;            0 patient fails the critera
 ;
 ;DEVICE
 ; This routine is a generic device selection dialog.
 ; Input:
 ;     PROGRAM = The calling program
 ;     TITLE = The Title of the print
 ; Output:
 ;     SPNIO = Q
 ;        If SPNIO is a Q then the user queued the print.
 ;
 ;CLOSE
 ; This routine will set the current device to top of form and close.
 ; 
 ;STPCK
 ; This function is to see if the user terminated the print via
 ; taskman.
 ;
EN1 ; Main Search Entry Point
 S SPNFILTR=$G(SPNFILTR,1)
 Q:'SPNFILTR
 S (SPNMAST,SPNLEXIT)=0
 I '$D(^TMP($J,"SPNPRT","AUP")) S SPNMAST=1 D  G:SPNLEXIT EXIT
 .D EN1^SPNPRTUP
 .Q
 D EXIT2
 D EN1^SPNPRTAU G:SPNLEXIT EXIT
 D EN1^SPNPRTSR G:SPNLEXIT EXIT
 Q
EN2(D0) ; Main filter routine
 N ACTION,FLAG
 S ACTION="",FLAG=1
 F  S ACTION=$O(^TMP($J,"SPNPRT",ACTION)) Q:ACTION=""  D  Q:'FLAG
 . N SEQUENCE S SEQUENCE=0
 . F  S SEQUENCE=$O(^TMP($J,"SPNPRT",ACTION,SEQUENCE)) Q:SEQUENCE<1  D  Q:'FLAG
 .. N PASSFAIL
 .. S PASSFAIL=$G(^TMP($J,"SPNPRT",ACTION,SEQUENCE,0))
 .. Q:PASSFAIL=""
 .. Q:$E(PASSFAIL,1,2)'="$$"
 .. S PASSFAIL="S FLAG="_PASSFAIL
 .. X PASSFAIL
 .. Q
 . Q
 Q FLAG
DEVICE(PROGRAM,TITLE,ZTSAVE) ; Select device
 N %ZIS,IOP
 S SPNIO=""
 S %ZIS="QM",%ZIS("A")="Select DEVICE: "
 D ^%ZIS
 I POP D  Q
 .S SPNLEXIT=1
 .W !,"Print ",TITLE," has been aborted."
 .Q
 I $D(IO("Q")) D
 .N ZTRTN
 .S ZTRTN=PROGRAM,ZTDESC=TITLE
 .S ZTSAVE("^TMP($J,"""_"SPNPRT"_""",")=""
 .D ^%ZTLOAD
 .I $D(ZTSK)[0 D  Q
 ..W !,"Print ",TITLE," has been aborted."
 ..S SPNLEXIT=1
 ..Q
 .W !,"Print ",TITLE," has been queued."
 .W !,"The task number for the print job is ",ZTSK,"."
 .S SPNIO="Q"
 .Q
 Q
CLOSE ;Close current print device
 I 'SPNLEXIT W @IOF
 W ! D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 D EXIT K SPNMAST
 Q
STPCK() ; Taskman check
 N ZTSTOP
 S ZTSTOP=0
 I $$S^%ZTLOAD D
 .S ZTSTOP=1 K ZTREG W !?10,"*** OUTPUT STOPPED AT USER'S REQUEST ***"
 .Q
 Q ZTSTOP
 ;
EXIT ;KILL QUIT
 I $G(SPNMAST) K ^TMP($J,"SPNPRT","AUP")
EXIT2 K ^TMP($J,"SPNPRT","AUTO")
 K ^TMP($J,"SPNPRT","POST")
 Q
