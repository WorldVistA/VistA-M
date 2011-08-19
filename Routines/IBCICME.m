IBCICME ;DSI/ESG - IBCI CLAIMSMANAGER ERROR REPORT ;6-APR-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 NEW STOP,IBCIRTN,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,POP,RPTSPECS
 ;
 S STOP=0
 S IBCIRTN="IBCICME"
 W @IOF
 W !?10,"ClaimsManager Error Report",!
 ;
 ; If there are no errors currently stored in the file,
 ; then there is no point in going any further.
 I '$D(^IBA(351.9,"AEC")) D  G EXIT
 . W !!?5,"There are no errors currently recorded in the ClaimsManager"
 . W !?5,"file.  There is no data to report."
 . W !! S DIR("A")="Press RETURN to continue",DIR(0)="E" D ^DIR K DIR
 . Q
 ;
 ;
A10 D ERRCODE I STOP G EXIT
A20 D DATE^IBCICMS I STOP G:$$STOP^IBCICMS EXIT G A10
A30 D DTRANGE^IBCICMS I STOP G:$$STOP^IBCICMS EXIT G A20
A40 D STATUS^IBCICMS I STOP G:$$STOP^IBCICMS EXIT G A30
A50 D TYPE^IBCICMS I STOP G:$$STOP^IBCICMS EXIT G A40
A60 D ERRDISP I STOP G:$$STOP^IBCICMS EXIT G A50
A70 D SELASN^IBCICMS I STOP G:$$STOP^IBCICMS EXIT G:RPTSPECS("TYPE")="S" A50 G A60
A80 D ASSIGN^IBCICMS I STOP G:$$STOP^IBCICMS EXIT G A70
A90 D SORTBY^IBCICMS I STOP G:$$STOP^IBCICMS EXIT G A80
A100 D ERRTXT I STOP G:$$STOP^IBCICMS EXIT G A90
A110 D COMMENTS^IBCICMS I STOP G:$$STOP^IBCICMS EXIT G A100
A120 D DEVICE^IBCICMS(IBCIRTN) I STOP G:$$STOP^IBCICMS EXIT G:RPTSPECS("TYPE")="S" A50 G A110
 ;
EXIT ;
 QUIT                                 ; quit from routine
 ;
COMPILE ; This entry point is called from EN^XUTMDEVQ in either
 ; direct mode or queued mode.
 NEW IBCISCNT
 D BUILD^IBCICME1                     ; compile report
 I '$G(ZTSTOP) D EN^IBCICMEP          ; print report
 D ^%ZISC                             ; close the device
 KILL ^TMP($J,IBCIRTN)                ; kill main scratch global
 KILL ^TMP($J,IBCIRTN_"-TOTALS")      ; kill totals scratch global
 I $D(ZTQUEUED) S ZTREQ="@"           ; purge the task record
COMPX ;
 QUIT                                 ; quit from routine
 ;
 ;
 ;
ERRCODE ; This procedure displays the error codes currently in the file and
 ; lets the user select all of them or some of them.
 ;
 NEW J,ERR,PCE,NUM
 KILL ^TMP($J,"IBCICME ERROR CODES")
 ;
 ; The first entry should be ALL
 S J=1,ERR="ALL Error Codes in the ClaimsManager File"
 S ^TMP($J,"IBCICME ERROR CODES",J)=ERR
 S DIR("A",J)=$J(J,12)_"    "_ERR
 ;
 ; Loop through all error codes to build the arrays
 S ERR=""
 F J=2:1 S ERR=$O(^IBA(351.9,"AEC",ERR)) Q:ERR=""  D
 . S ^TMP($J,"IBCICME ERROR CODES",J)=ERR
 . S DIR("A",J)=$J(J,12)_"    "_ERR
 . Q
 S DIR("A",J)="  "        ; blank line before the prompt
 ;
 S DIR(0)="L^1:"_(J-1)
 S DIR("A")="Please Select the Error Codes to include"
 S DIR("B")=1
 S DIR("?",1)="  This response must be a list or range."
 S DIR("?",2)="  For example,   1,3,5   or   2-4,8"
 S DIR("?",3)="  "
 S DIR("?",4)="  If you include #1, then all codes will be included"
 S DIR("?")="    regardless of what you enter here."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G ERRCODEX
 ;
 ; Add a comma to the front of Y so the $F will work
 ; Check to see if the user response included ALL CODES
 S Y=","_Y
 KILL RPTSPECS("SELECTED ERRCODES")
 S RPTSPECS("ALL ERRCODES")=0
 I $F(Y,",1,") S RPTSPECS("ALL ERRCODES")=1 G ERRCODEX
 ;
 ; remove the leading the trailing commas and then build the list
 S Y=$E(Y,2,$L(Y)-1)
 F PCE=1:1:$L(Y,",") D
 . S NUM=$P(Y,",",PCE),ERR=""
 . I NUM'="" S ERR=^TMP($J,"IBCICME ERROR CODES",NUM)
 . I ERR'="" S RPTSPECS("SELECTED ERRCODES",ERR)=""
 . Q
 ;
ERRCODEX ;
 KILL ^TMP($J,"IBCICME ERROR CODES")
 Q
 ;
 ;
ERRTXT ;
 I RPTSPECS("TYPE")="S" S RPTSPECS("DISPLAY ERROR TEXT")=0 G ERRTXTX
 ; Only ask question if it is a detailed report
 W !
 S DIR(0)="Y"
 S DIR("A")="Do you want to see the ClaimsManager Error Messages for these bills"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter YES if you would like to see the full description of the error"
 S DIR("?",2)="    including all lines of error message text."
 S DIR("?")="  Enter NO if you do not want to see this information."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G ERRTXTX
 S RPTSPECS("DISPLAY ERROR TEXT")=+Y
ERRTXTX ;
 Q
 ;
 ;
ERRDISP ; get the error display type (esg - 6/12/01)
 I RPTSPECS("TYPE")="S" S RPTSPECS("ERROR DISPLAY TYPE")=1 G ERRDISPX
 ; Only ask question if it is a detailed report
 NEW CH
 W !
 S CH="1:Display all ClaimsManager Errors for a Bill;"
 S CH=CH_"2:Display all Bills for a ClaimsManager Error Code"
 S DIR(0)="SO^"_CH
 S DIR("A")="Select the Error Display Type"
 S DIR("B")=1
 S DIR("?",1)="  The answer to this question will determine how the Bills and Errors"
 S DIR("?",2)="  are displayed on the report."
 S DIR("?",3)="  "
 S DIR("?",4)="  Select option 1 if you want to display all of the ClaimsManager"
 S DIR("?",5)="  errors for each bill that appears on the report.  These errors will"
 S DIR("?",6)="  appear together with the bill."
 S DIR("?",7)="  "
 S DIR("?",8)="  Select option 2 if you want to break this report out by ClaimsManager"
 S DIR("?",9)="  error code.  In this case, you will see separate sections for each"
 S DIR("?",10)="  error code and all bills in which a particular error code is present."
 S DIR("?",11)="  "
 S DIR("?",12)="  Remember that the bills and errors are still subject to the other"
 S DIR("?")="  selection and sort criteria that you enter."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G ERRDISPX
 S RPTSPECS("ERROR DISPLAY TYPE")=Y
 ;
ERRDISPX ;
 Q
 ;
