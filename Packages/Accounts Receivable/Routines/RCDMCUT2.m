RCDMCUT2 ;HEC/SBW - Utility Functions for Hold Debt to DMC Project ;30/AUG/2007
 ;;4.5;Accounts Receivable;**253,347**;Mar 20, 1995;Build 47
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
DEVICE(ROUTINE,DESC,STOPIT,RCSCR,BEGDT,EXCEL,RCTYPE,RCDMC) ;
 ;INPUT:
 ;  ROUTINE - Routine Entry to Queue (e.g. MAIN^RDDMCR1)
 ;  DESC    - Description to use for tasked jobs
 ;  BEGDT   - Beginning date the report should begin with (required)
 ;  EXCEL   - If 1 report format will be Excel Delimited (Optional)
 ;  RCTYPE  - Report Type - D-DETAILED,S-SUMMARY,E-Excel (Optional)
 ;  RCDMC   - DMC Debt Valid Field Value - A-ALL VALUES,B-BLANK/NULL,
 ;            Y-YES,N-NO (Optional)
 ;OUTPUT:
 ;  STOPIT  - Variable to indicate if process should't continue
 ;  RCSCR   - Variable to indicate if process is being sent to 
 ;            the screen or a device. 1 indicate screen
 ;
 N %ZIS,ZTSK,ZTRTN,ZTIO,ZTDESC,POP,ZTSAVE
 I $G(ROUTINE)']"" S STOPIT=1 Q
 I $G(BEGDT)']"" S STOPIT=1 Q
 S %ZIS="QM"
 W ! D ^%ZIS
 I POP S STOPIT=1 Q
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 ;
 I $D(IO("Q")) D  S STOPIT=1
 . S ZTRTN=ROUTINE
 . S ZTIO=ION
 . S ZTSAVE("RC*")=""
 . S ZTSAVE("STOPIT")=""
 . S ZTSAVE("BEGDT")=""
 . S ZTSAVE("EXCEL")=""
 . S ZTDESC=$G(DESC)
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Request Queued.  TASK = "_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 Q
 ;
STOPIT() ; Checks if user requested task to stop
 ;Input:
 ;  No input
 ;Output
 ;  Function returns one if the user requested the task to stop
 ;
 N RCX,STOPIT
 S STOPIT=0
 S RCX=$$S^%ZTLOAD
 I RCX D  ;
 . S STOPIT=1
 . I $G(ZTSK) S ZTSTOP=1
 Q STOPIT
 ;
EXCEL() ; - Returns whether to capture data for Excel report.
 ;INPUT:
 ;  None
 ; Output:
 ;   Returns 1 - YES (capture data) / 0 - NO (DO NOT capture data) /
 ;           "^" - Exit report
 ;
 N EXCEL,X,Y,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 ;
 S EXCEL=0
 S DIR(0)="Y",DIR("B")="NO",DIR("T")=DTIME W !
 S DIR("A")="Do you want to capture report data for an Excel document"
 S DIR("?")="^D HEXC^RCDMCUT2"
 D ^DIR
 S:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) EXCEL="^"
 S:$G(Y)>0 EXCEL=1
 ;
 Q EXCEL
 ;
HEXC ; - 'Do you want to capture data...' prompt
 W !!,"      Enter:  'Y'    -  To capture detail report data to transfer"
 W !,"                        to an Excel document"
 W !,"              '<CR>' -  To skip this option"
 W !,"              '^'    -  To quit this option"
 Q
 ;
EXMSG ; - Displays the message about capturing to an Excel file format
 ;
 W !!?5,"This report may take a while to run. It is recommended that you Queue it."
 W !!?5,"To capture as an Excel format, it is recommended that you queue this"
 W !?5,"report to a spool device with margins of 256 and page length of 99999"
 W !?5,"(e.g. spoolname;256;99999). This should help avoid wrapping problems."
 W !!?5,"Another method would be to set up your terminal to capture the detail"
 W !?5,"report data. On some terminals, this can be done by clicking on the"
 W !?5,"'Tools' menu above, then click on 'Capture Incoming Data' to save to"
 W !?5,"Desktop.  To avoid undesired wrapping of the data saved to the file,"
 W !?5,"please enter '0;256;99999' at the 'DEVICE:' prompt.",!
 Q
 ;
GETTYPE(STOPIT) ; Choose a (S)ummary or (D)etail or (E)xcel Delimited Report
 ;INPUT
 ;   STOPIT  - Variable to be set if user '^' out or time out
 ;OUTPUT
 ;   STOPIT  - Variable to be set if user '^' out or time out
 ;   Function returns the Report Type (D,S,E)
 ;
 N Y,X,DIR,DIRUT,DUOUT,DTOUT,DIROUT
 S DIR(0)="S^D:DETAILED;S:SUMMARY;E:EXCEL DELIMITED"
 S DIR("A")="Select Type of Report"
 W !
 D ^DIR
 S:$D(DIRUT)!$D(DUOUT)!$D(DTOUT)!$D(DIROUT) STOPIT=1,Y=""
 Q Y
GETTYPE2(STOPIT) ; Choose a (S)ummary or (D)etail
 ;INPUT
 ;   STOPIT  - Variable to be set if user '^' out or time out
 ;OUTPUT
 ;   STOPIT  - Variable to be set if user '^' out or time out
 ;   Function returns the Report Type (D,S,E)
 ;
 N Y,X,DIR,DIRUT,DUOUT,DTOUT,DIROUT
 S DIR(0)="S^D:DETAILED;S:SUMMARY"
 S DIR("A")="Select Type of Report"
 S DIR("B")="DETAILED"
 W !
 D ^DIR
 S:$D(DIRUT)!$D(DUOUT)!$D(DTOUT)!$D(DIROUT) STOPIT=1,Y=""
 Q $E(Y)
 ;
BILLPAYS() ; Do you want to see only bills with payments? 
 ;INPUT:
 ;  None
 ; Output:
 ;   Returns 1 - YES (Bills with payments) / 0 - NO (All bills) /
 ;           "^" - Exit report
 ;
 N BP,X,Y,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 ;
 S BP=0
 S DIR(0)="Y",DIR("B")="YES",DIR("T")=DTIME W !
 S DIR("A")="Do you want to see only bills with payments"
 ;S DIR("?")="^D HEXC^RCDMCUT2"
 D ^DIR
 S:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) BP="^"
 S:$G(Y)>0 BP=1
 Q BP
 ;
GETDMC(STOPIT) ;Chose DMC Debt Valid field value to include Null, Pending,
 ; Yes, No and All vallues
 ;INPUT
 ;   STOPIT  - Variable to be set if user '^' out or time out
 ;OUTPUT
 ;   STOPIT  - Variable to be set if user '^' out or time out
 ;   Function returns the DMC Debt Valid Field Value (A,B,P,Y,N)
 ;
 N Y,X,DIR,DIRUT,DUOUT,DTOUT,DIROUT
 S DIR(0)="S^A:ALL FIELD VALUES;B:BLANK/NULL;P:PENDING;Y:YES;N:NO"
 S DIR("A")="Select DMC Debt Valid field value"
 S DIR("?")=" "
 S DIR("?",1)="Enter 'A' to list bills of all DMC Debt Valid values"
 S DIR("?",2)="Enter 'B' to list bills not yet reviewed by the user"
 S DIR("?",3)="Enter 'P' to list bills excluded by AR nightly background process"
 S DIR("?",4)="Enter 'Y' to list bills a User determined should be referred to DMC"
 S DIR("?",5)="Enter 'N' to list bills a User determined should not be referred to DMC"
 W !
 D ^DIR
 S:$D(DIRUT)!$D(DUOUT)!$D(DTOUT)!$D(DIROUT) STOPIT=1,Y=""
 Q Y
 ;
EXTTYPE(TYPE) ;Get Set of Code external format for Report type
 ;INPUT
 ;  TYPE  - Internal Report type: D, S, E
 ;OUTPUT
 ;  Returns external Report type: D - DETAILED, S - SUMMARY,
 ;                                E - EXCEL DELIMITED
 ;
 S TYPE=$G(TYPE)
 Q $S(TYPE="D":"DETAILED",TYPE="S":"SUMMARY",TYPE="E":"EXCEL DELIMITED",1:"")
 ;
EXTDMC(VAL) ;Get Set of Code external format for DMC Debt Valid field value
 ;INPUT
 ;  VAL  - Internal DMC Debt Valid value: A, B, P, Y, N
 ;OUTPUT
 ;  Returns external DMC Debt Valid value: A - ALL, B - BLANK/NULL
 ;                                         P - PENDING, Y - YES, N - NO
 ;
 S VAL=$G(VAL)
 Q $S(VAL="A":"ALL",VAL="B":"BLANK/NULL",VAL="P":"PENDING",VAL="Y":"YES",VAL="N":"NO",1:"")
 ;
DATE(PROMPT,PROMPT2,BEG,END,DTYPE) ;Get beginning and Ending dates
 ;INPUT:
 ;   PROMPT - Message to display prior to prompting for dates
 ;   PROMPT2 - (Optional) Message to display on second line
 ;   BEG - (Optional) default begin date
 ;   END - (Optional) default end date
 ;   DTYPE - (Optional) date type
 ;OUTPUT:
 ;    1^BEGDT^ENDDT - Data found
 ;    0             - User up arrowed or timed out
 ;NOTE:
 ;    Optional Parameters added by Glaz to support date range from other reports
 ;
 N %DT,Y,X,BEGDT,ENDDT,DTOUT,OUT,DIRUT,DUOUT,DIROUT
 S OUT=0
 W !,$G(PROMPT)
 I $G(PROMPT2)'="" W !,$G(PROMPT2)
 S %DT="AEX"
 S %DT("A")="Enter "_$S($G(DTYPE)="":"",1:DTYPE_" ")_"Beginning Date: "
 I $G(BEG)="" S %DT("B")="TODAY"
 E  S Y=BEG X ^DD("DD") S %DT("B")=Y
 W !
 D ^%DT
 K %DT
 ;Quit if user time out or didn't enter valid date
 Q:Y<0 OUT
 S BEGDT=+Y
 S %DT="AEX"
 S %DT("A")="Enter "_$S($G(DTYPE)="":"",1:DTYPE_" ")_"Ending Date: "
 I $G(END)="" S %DT("B")="TODAY"
 E  S Y=END X ^DD("DD") S %DT("B")=Y
 D ^%DT
 K %DT
 ;Quit if user time out or didn't enter valid date
 Q:Y<0 OUT
 S ENDDT=+Y
 S OUT=1_U_BEGDT_U_ENDDT
 ;Switch dates when user enters more recent date for Begin Date
 ;than End Date
 S:BEGDT>ENDDT OUT=1_U_ENDDT_U_BEGDT
 Q OUT
 ;
DATE2(PROMPT,PROMPT2,BEG,END,DTYPE) ;Get beginning and Ending dates
 ;INPUT:
 ;   PROMPT - Message to display prior to prompting for dates
 ;   PROMPT2 - (Optional) Message to display on second line
 ;   BEG - (Optional) default begin date
 ;   END - (Optional) default end date
 ;   DTYPE - (Optional) date type
 ;OUTPUT:
 ;    1^BEGDT^ENDDT - Data found
 ;    0             - User up arrowed or timed out
 ;NOTE:
 ;    Optional Parameters added to support date range from other reports
 ;
 N %DT,Y,X,BEGDT,ENDDT,DTOUT,OUT,DIRUT,DUOUT,DIROUT
 S OUT=0
 W !,$G(PROMPT)
 I $G(PROMPT2)'="" W !,$G(PROMPT2)
 S %DT="AEX"
 S %DT("A")="Enter "_$S($G(DTYPE)="":"",1:DTYPE_" ")_"Begin Date: "
 I $G(BEG)="" S %DT("B")="TODAY"
 I $G(BEG)'="" S Y=BEG X ^DD("DD") S %DT("B")=Y
 W !
 D ^%DT
 K %DT
 ;Quit if user time out or didn't enter valid date
 Q:Y<0 OUT
 S BEGDT=+Y
 S %DT="AEX"
 S %DT("A")="Enter "_$S($G(DTYPE)="":"",1:DTYPE_" ")_"End Date: "
 I $G(END)="" S %DT("B")="TODAY"
 I $G(END)'="" S Y=END X ^DD("DD") S %DT("B")=Y
 D ^%DT
 K %DT
 ;Quit if user time out or didn't enter valid date
 Q:Y<0 OUT
 S ENDDT=+Y
 S OUT=1_U_BEGDT_U_ENDDT
 ;Switch dates when user enters more recent date for Begin Date
 ;than End Date
 S:BEGDT>ENDDT OUT=1_U_ENDDT_U_BEGDT
 Q OUT
 ;
GETBEGDT(PROMPT1,PROMPT2,DTPROMPT) ;Get beginning date
 ;INPUT:
 ;   PROMPT1 - Message to display prior to prompting for date
 ;   PROMPT2 - Message to display prior to prompting for date
 ;  DTPROMPT - Date query verbiage, if defined
 ;OUTPUT:
 ;    1^BEGDT - Data found
 ;    0       - User up arrowed or timed out
 ;
 N %DT,Y,X,BEGDT,DTOUT,OUT,DIRUT,DUOUT,DIROUT
 S OUT=0
 W !!,$G(PROMPT1)
 W:$G(PROMPT2)]"" !,PROMPT2
 S %DT="AEX"
 S %DT("A")="Enter Beginning Date: " I $G(DTPROMPT)]"" S %DT("A")=DTPROMPT
 S %DT("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT,-365,0,0,0),"1D")
 S %DT(0)=-$$FMADD^XLFDT(DT,-365,0,0,0)
 W !
 D ^%DT
 K %DT
 ;Quit if user time out or didn't enter valid date
 Q:Y<0 OUT
 S BEGDT=+Y
 S OUT=1_U_BEGDT
 Q OUT
ARSTAT(STOPIT) ;Chose AR status
 ; Yes, No and All vallues
 ;INPUT
 ;   STOPIT  - Variable to be set if user '^' out or time out
 ;OUTPUT
 ;   STOPIT  - Variable to be set if user '^' out or time out
 ;   Function returns 1-7 (1:Active;2:Open;3:Suspended;4:Collected/Closed;5:On-Hold;6:Write Off;7:All)
 ;
 N Y,X,DIR,DIRUT,DUOUT,DTOUT,DIROUT
 ;W !,"Report to Include Bills for charges without an IB status of Cancelled, with an"
 ;W !,"AR Status of Active, Open, Suspended, Write-Off, Collected/Closed, or with IB"
 ;W !,"Status of On-Hold, and date of service on or after the exemption effective date."
 S DIR(0)="S^1:Active;2:Open;3:Suspended;4:Collected/Closed;5:On-Hold;6:Write-Off;7:ALL (Includes 1-6 and AR CANCELLATIONS)"
 S DIR("A")="Select a Status"
 S DIR("B")=7
 W !
 D ^DIR
 S:$D(DIRUT)!$D(DUOUT)!$D(DTOUT)!$D(DIROUT) STOPIT=1,Y=""
 Q Y
 ;
PAUSE ;If sending report to screen display pause message at screen bottom
 N X
 U IO(0)
 W !!,"Press RETURN to continue, '^' to exit:"
 R X:DTIME
 S:'$T X="^"
 S:X["^" STOPIT=2
 U IO
 Q
 ;
PAUSE2 ;If sending report to screen display pause message at screen bottom;
 N X
 U IO(0)
 W !!,"Press RETURN to continue:"
 R X:DTIME
 S:'$T X="^"
 S:X["^" STOPIT=2
 U IO
 Q
 ;
ULINE(X,WIDTH) ;Display line of a given character
 ;INPUT:
 ;  X     - Character to display
 ;  WIDTH - Number of Character to display
 ;
 N I
 S:$G(WIDTH)'>0 WIDTH=80
 W !
 F I=1:1:WIDTH W $G(X,"-")
 Q
 ;
