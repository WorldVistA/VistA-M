PSOPROD1 ;ALB/MRD - Pharmacy Productivity and Revenue Report ;9/8/15
 ;;7.0;OUTPATIENT PHARMACY;**448**;DEC 1997;Build 25
 ;Reference to File 9002313.93 - BPS NCPDP REJECT CODES supported by IA 4720
 ;
 Q
 ;
EN ; Main entry point for user prompts.
 ;
 W @IOF,!,"Pharmacy Productivity/Revenue Report",!!
 ;
 N PSODIV,PSODTBEGIN,PSODTEND,PSOEXCEL,PSOINCLUDE,PSOREPORT,PSOSHOWPAT,PSOSORT,PSOSTATUS
 ;
P1 I '$$DIVISION(.PSODIV) G EXIT
P2 I '$$REPORT(.PSOREPORT) G EXIT:$$STOP,P1
P3 I PSOREPORT="P" S PSOSTATUS="B",PSOSTATUS(0)="" G P4
 I '$$STATUS(.PSOSTATUS) G EXIT:$$STOP,P2
P4 I '$$DATES(.PSODTBEGIN,.PSODTEND) G EXIT:$$STOP,P2:PSOREPORT="P",P3
P5 I '$$INCLUDE(.PSOINCLUDE) G EXIT:$$STOP,P4
P6 I '$$SORT(.PSOSORT) G EXIT:$$STOP,P5
P7 I '$$PATIENT(.PSOSHOWPAT) G EXIT:$$STOP,P6
P8 I '$$EXCEL(.PSOEXCEL) G EXIT:$$STOP,P7
 I '$$DEVICE() G EXIT:$$STOP,P8
 ;
EXIT ; Exit point.
 Q
 ;
STOP() ; Determine if user wishes to exit out of the option entirely.
 ; Function return values:
 ;   1 - Yes, exit entirely.
 ;   0 - No, do not exit but return to the previous question.
 ;
 N DIR,DIRUT,Y
 ;
 S DIR(0)="Y"
 S DIR("A")="Do you want to exit out of this option entirely"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter YES to immediately exit out of this option."
 S DIR("?")="  Enter NO to return to the previous question."
 W !
 D ^DIR
 I $D(DIRUT) S Y=1
 Q Y
 ;
DIVISION(PSODIV) ; Allow user to select Divisions or All Divisions.
 ; Input: None.
 ; Output: PSODIV
 ;   PSODIV = "ALL" if the user opted to include all divisions.
 ;   PSODIV = "D" if the user selected specific division.  If that is
 ;       the case, the selected pharmacies will be listed in PSODIV:
 ;       PSODIV(IEN) = Division name, where IEN is a pointer to file#
 ;       59, Outpatient Site.
 ; Function return values:
 ;   1 - A valid entry or entries were selected.
 ;   0 - User has exited out (^).
 ;
 N DIC,DIR,DIROUT,DIRUT,X,Y,Z
 ;
 ; Allow user to indicate that all divisions should be included or
 ; that they wish to enter specific divisions.
 ;
 S DIR(0)="S^D:DIVISION;A:ALL"
 S DIR("A")="Select Pharmacy (D)ivisions or (A)LL"
 I $G(PSODIV)'="" S DIR("B")=$S(PSODIV="ALL":"ALL",1:"D")
 D ^DIR
 I $D(DIRUT) W $C(7) Q 0
 ;
 ; If user selected all divisions, Quit with 1.
 ;
 I Y="A" K PSODIV S PSODIV="ALL" Q 1
 ;
 ; Allow user to enter multiple specific divisions.
 ;
 F  D  I Y=0 Q
 . ;
 . ; Display the list of divisions selected.
 . ;
 . I $D(PSODIV)>9 D
 . . W !!?2,"Selected:"
 . . S X="" F  S X=$O(PSODIV(X)) Q:X=""  W !,?10,PSODIV(X)
 . . Q
 . ;
 . K DIC
 . S DIC=59
 . S DIC(0)="QEAM"
 . S DIC("A")="Select Pharmacy Division(s): "
 . W !
 . D ^DIC
 . ;
 . ; If "^" or timeout, clear array and Quit out.
 . ;
 . I $D(DIRUT) K PSODIV S PSODIV="",Y=0 W $C(7) Q
 . ;
 . ; If blank entry, conditionally clear out array and then Quit out.
 . ;
 . I $G(X)="" S Y=0 Q
 . ;
 . ; At this point, the user entered a division.  If it is already on the
 . ; list, allow user to delete from the list.  Otherwise, add to the list.
 . ;
 . I $D(PSODIV(+Y)) D
 . . ;
 . . ; Allow user to delete an entry already on the list.
 . . ;
 . . S Z=Y  ; Need to save the original value in case we delete from the list.
 . . K DIR
 . . S DIR(0)="S^Y:YES;N:NO",DIR("A")="Delete "_$P(Z,U,2)_" from your list?"
 . . S DIR("B")="NO"
 . . D ^DIR
 . . I $D(DIROUT) K PSODIV S PSODIV="",Y=0 W $C(7) Q
 . . I Y="Y" K PSODIV(+Z)
 . . Q
 . E  D
 . . ;
 . . ; Add the new entry to the PSODIV array.
 . . ;
 . . S PSODIV(+Y)=$P(Y,U,2)
 . . Q
 . Q
 ;
 I $D(PSODIV)<10 K PSODIV Q 0
 ;
 ; Display the list of divisions selected.  Build the string of
 ; selected divisions to display on report header.
 ;
 W !!?2,"Selected:"
 S X="" F  S X=$O(PSODIV(X)) Q:X=""  W !,?10,PSODIV(X)
 S PSODIV="",PSOX=""
 F  S PSOX=$O(PSODIV(PSOX)) Q:PSOX=""  D
 . I PSODIV'="" S PSODIV=PSODIV_", "
 . S PSODIV=PSODIV_PSODIV(PSOX)
 . Q
 ;
 Q 1
 ;
REPORT(PSOREPORT) ; Allow user to select report to run (Productivity or Revenue).
 ; Input: None.
 ; Output: PSOREPORT, set to one of the following.
 ;   PSOREPORT = "" if no selection was made.
 ;   PSOREPORT = "R" if user selected the RRR Revenue report.
 ;   PSOREPORT = "P" if user selected the Productivity Report.
 ; Function return values:
 ;   1 - The user selected one of the two reports.
 ;   0 - The user exited out.
 ;
 N DIR,DIRUT,Y
 ;
 S DIR(0)="S^R:RRR Revenue;P:Productivity"
 S DIR("A")="Select (R)RR Revenue or (P)roductivity Report"
 I $G(PSOREPORT)'="" S DIR("B")=PSOREPORT
 S DIR("?",1)="Enter a code from the list to indicate the type of report to run."
 S DIR("?",2)="     Select one of the following:"
 S DIR("?",3)="          R         RRR Revenue"
 S DIR("?",4)="          Includes: All fills for a prescription with a resolved RRR reject"
 S DIR("?",5)="                    and associated revenue"
 S DIR("?",6)="          P         Productivity"
 S DIR("?",7)="          Includes: Reports only on rejects for the original fills or refills"
 S DIR("?")="                    from the Pharmacy Worklist"
 D ^DIR
 I $D(DIRUT) W $C(7) Q 0
 S PSOREPORT=Y
 Q 1
 ;
STATUS(PSOSTATUS) ; Allow user to select statuses to include in report.
 ; Input: None.
 ; Output: PSOSTATUS, set to one of the following.
 ;   PSOSTATUS = "" if no selection was made.
 ;   PSOSTATUS = "P" if user selected Closed/Resolved - ePayable.
 ;   PSOSTATUS = "R" if user selected Closed/Resolved - eRejected.
 ;   PSOSTATUS = "B" if users opted to include both of the above.
 ;   PSOSTATUS(0) = String to display on report header.
 ; Function return values:
 ;   1 - A valid selection was made.
 ;   0 - The user exited out.
 ;
 N DIR,DIRUT,Y
 ;
 S DIR(0)="S^P:CLOSED/RESOLVED - E PAYABLE;R:CLOSED/RESOLVED - E REJECTED;B:BOTH"
 S DIR("A")="Select (P) Closed/Resolved - ePAYABLE, (R) Closed/Resolved - eREJECTED, (B)oth"
 I $G(PSOSTATUS)'="" S DIR("B")=PSOSTATUS
 E  S DIR("B")="B"
 S DIR("L",1)="     Select Status:"
 S DIR("L",2)=""
 S DIR("L",3)="          P         CLOSED/RESOLVED - E PAYABLE"
 S DIR("L",4)="          R         CLOSED/RESOLVED - E REJECTED"
 S DIR("L")="          B         BOTH"
 D ^DIR
 I $D(DIRUT) W $C(7) Q 0
 ;
 S PSOSTATUS=Y
 S PSOSTATUS(0)=Y(0)
 I PSOSTATUS="B" S PSOSTATUS(0)="CLOSED/RESOLVED - E PAYABLE, E REJECTED"
 ;
 Q 1
 ;
DATES(PSODTBEGIN,PSODTEND) ; Prompt user for a date range.
 ; Function return values:
 ;   1 - A valid date range was entered.
 ;   0 - A valid date range was not entered.
 ;
 N DIR,DIRUT,Y
 ;
 S DIR(0)="D^:DT:EX"
 S DIR("A")="Begin Date Resolved"
 I $G(PSODTBEGIN)'="" S DIR("B")=$$FMTE^XLFDT(PSODTBEGIN,2)
 E  S DIR("B")="T-90"
 S DIR("?",1)="The start and end dates for this report refer to"
 S DIR("?")="the date that the rejects were resolved."
 W !
 D ^DIR
 I $D(DIRUT)!'Y W $C(7) Q 0
 S PSODTBEGIN=Y
 ;
 K DIR
 S DIR(0)="D^"_PSODTBEGIN_":DT:EX"
 S DIR("A")="End Date Resolved"
 I $G(PSODTEND)'="" S DIR("B")=$$FMTE^XLFDT(PSODTEND,2)
 E  S DIR("B")="T"
 S DIR("?",1)="The start and end dates for this report refer to"
 S DIR("?")="the date that the rejects were resolved."
 W !
 D ^DIR
 I $D(DIRUT)!'Y W $C(7) Q 0
 S PSODTEND=Y
 Q 1
 ;
INCLUDE(PSOINCLUDE) ; Allow user to enter specific Patients, Drugs, etc., to include.
 ; Input: None.
 ; Output:
 ;   PSOINCLUDE, set to PATIENT, DRUG, RX, INSURANCE or REJECT CODE.
 ;   For the field selected by the user to include-by, the list of
 ;   entries to include will be at PSOINCLUDE(include-by,value)="",
 ;   for example PSOINCLUDE("RX",12345)="" to include RxIEN 12345.
 ;   All are defaulted to "ALL", e.g. PSOINCLUDE("RX")="ALL", and
 ;   only the one selected by the user may be reset to be a string
 ;   being a list of the external values of the items selected.
 ; Function return values:
 ;   1 - A valid selection was made.
 ;   0 - The user exited out.
 ;
 N DIR,DIRUT,PSOARRAY,PSOX,Y
INC ;
 S DIR(0)="S^P:Patient;D:Drug;R:Rx;I:Insurance;C:Reject Code"
 S DIR("A")="By (P)atient, (D)rug, (R)x, (I)nsurance or Reject (C)ode"
 I $G(PSOINCLUDE)'="" S DIR("B")=PSOINCLUDE
 E  S DIR("B")="P"
 D ^DIR
 I $D(DIRUT) W $C(7) Q 0
 ;
 ; Set PSOINCLUDE to the sort selected by the user.
 ;
 K PSOINCLUDE
 S PSOINCLUDE=$$UP^XLFSTR(Y(0))
 S PSOINCLUDE("PATIENT")="ALL"
 S PSOINCLUDE("DRUG")="ALL"
 S PSOINCLUDE("RX")="ALL"
 S PSOINCLUDE("INSURANCE")="ALL"
 S PSOINCLUDE("REJECT CODE")="ALL"
 ;
 ; Allow user to select which Patients to include.
 ;
 I PSOINCLUDE="PATIENT" D  I $G(PSOARRAY)="^" G INC
 . S PSOINCLUDE("PATIENT")=""
 . D SEL^PSOREJU1("PATIENT","^DPT(",.PSOARRAY)
 . I $G(PSOARRAY)="^" Q
 . M PSOINCLUDE("PATIENT")=PSOARRAY
 . S PSOX=""
 . F  S PSOX=$O(PSOINCLUDE("PATIENT",PSOX)) Q:PSOX=""  D
 . . I PSOINCLUDE("PATIENT")'="" S PSOINCLUDE("PATIENT")=PSOINCLUDE("PATIENT")_"; "
 . . S PSOINCLUDE("PATIENT")=PSOINCLUDE("PATIENT")_$$GET1^DIQ(2,PSOX,.01)
 . . Q
 . Q
 ;
 ; Allow user to select which Drugs to include.
 ;
 I PSOINCLUDE="DRUG" D  I $G(PSOARRAY)="^" G INC
 . S PSOINCLUDE("DRUG")=""
 . D SEL^PSOREJU1("DRUG","^PSDRUG(",.PSOARRAY)
 . I $G(PSOARRAY)="^" Q
 . M PSOINCLUDE("DRUG")=PSOARRAY
 . S PSOX=""
 . F  S PSOX=$O(PSOINCLUDE("DRUG",PSOX)) Q:PSOX=""  D
 . . I PSOINCLUDE("DRUG")'="" S PSOINCLUDE("DRUG")=PSOINCLUDE("DRUG")_", "
 . . S PSOINCLUDE("DRUG")=PSOINCLUDE("DRUG")_$$GET1^DIQ(50,PSOX,.01)
 . . Q
 . Q
 ;
 ; Allow user to select which Rx's to include.
 ;
 I PSOINCLUDE="RX" D  I $G(PSOARRAY)="^" G INC
 . S PSOINCLUDE("RX")=""
 . D SEL^PSOREJU1("PRESCRIPTION","^PSRX(",.PSOARRAY)
 . I $G(PSOARRAY)="^" Q
 . M PSOINCLUDE("RX")=PSOARRAY
 . S PSOX=""
 . F  S PSOX=$O(PSOINCLUDE("RX",PSOX)) Q:PSOX=""  D
 . . I PSOINCLUDE("RX")'="" S PSOINCLUDE("RX")=PSOINCLUDE("RX")_", "
 . . S PSOINCLUDE("RX")=PSOINCLUDE("RX")_$$GET1^DIQ(52,PSOX,.01)
 . . Q
 . Q
 ;
 ; Allow user to select which Insurances to include.
 ;
 I PSOINCLUDE="INSURANCE" D  I $G(PSOARRAY)="^" G INC
 . S PSOINCLUDE("INSURANCE")=""
 . D SEL^PSOREJU1("INSURANCE","^DIC(36,",.PSOARRAY)
 . I $G(PSOARRAY)="^" Q
 . M PSOINCLUDE("INSURANCE")=PSOARRAY
 . S PSOX=""
 . F  S PSOX=$O(PSOINCLUDE("INSURANCE",PSOX)) Q:PSOX=""  D
 . . I PSOINCLUDE("INSURANCE")'="" S PSOINCLUDE("INSURANCE")=PSOINCLUDE("INSURANCE")_", "
 . . S PSOINCLUDE("INSURANCE")=PSOINCLUDE("INSURANCE")_$$GET1^DIQ(36,PSOX,.01)
 . . Q
 . Q
 ;
 ; Allow user to select which Reject Codes to include.
 ;
 I PSOINCLUDE="REJECT CODE" D  I $G(PSOARRAY)="^" G INC
 . S PSOINCLUDE("REJECT CODE")=""
 . D SEL^PSOREJU1("REJECT CODE","^BPSF(9002313.93,",.PSOARRAY)  ; IA 4720.
 . I $G(PSOARRAY)="^" Q
 . M PSOINCLUDE("REJECT CODE")=PSOARRAY
 . S PSOX=""
 . F  S PSOX=$O(PSOINCLUDE("REJECT CODE",PSOX)) Q:PSOX=""  D
 . . I PSOINCLUDE("REJECT CODE")'="" S PSOINCLUDE("REJECT CODE")=PSOINCLUDE("REJECT CODE")_", "
 . . S PSOINCLUDE("REJECT CODE")=PSOINCLUDE("REJECT CODE")_$$GET1^DIQ(9002313.93,PSOX,.01)_" - "_$$GET1^DIQ(9002313.93,PSOX,.02)  ; IA 4720.
 . . Q
 . Q
 ;
 I PSOINCLUDE="" K PSOINCLUDE Q 0
 Q 1
 ;
SORT(PSOSORT) ; Prompt user for the sort order.
 ; Input: None.
 ; Output: PSOSORT, set to one of the following.
 ;   PSOSORT = "" if no selection was made.
 ;   PSOSORT = "D" if user selected Division.
 ;   PSOSORT = "R" if user selected Date Resolved.
 ;   PSOSORT = "B" if user selected Resolved By.
 ;   PSOSORT = "N" if user selected Drug Name.
 ;   PSOSORT = "C" if user selected Reject Code.
 ; Function return values:
 ;   1 - A valid selection was made.
 ;   0 - The user exited out.
 ;
 N DIR,DIRUT,Y
 ;
 S DIR(0)="S^D:Division;R:Date Resolved;B:Resolved By;N:Drug Name;C:Reject Code"
 S DIR("A")="Sort"
 I $G(PSOSORT)'="" S DIR("B")=PSOSORT
 E  S DIR("B")="Division"
 S DIR("L",1)="Enter a code from the list to indicate the sort order."
 S DIR("L",2)="     Select one of the following:"
 S DIR("L",3)=""
 S DIR("L",4)="          D         Division"
 S DIR("L",5)="          R         Date Resolved"
 S DIR("L",6)="          B         Resolved By"
 S DIR("L",7)="          N         Drug Name"
 S DIR("L")="          C         Reject Code"
 D ^DIR
 I $D(DIRUT) W $C(7) Q 0
 S PSOSORT=Y,PSOSORT(0)=$$UP^XLFSTR(Y(0))
 Q 1
 ;
PATIENT(PSOSHOWPAT) ; Display Patient Name on report?
 ; Input: None.
 ; Output: PSOSHOWPAT, set to one of the following.
 ;   1 - Yes, display Patient Name on the report.
 ;   0 - No, do not display the Patient Name.
 ;       * Note: The Patient Name will always be displayed if the user
 ;         requests output in Excel format.
 ; Function return values:
 ;   1 - User answered the Y/N question.
 ;   0 - User exited out.
 ;
 N DIR,DIRUT
 ;
 S DIR(0)="Y"
 S DIR("A")="Show PATIENT NAME (Y/N)"
 I $G(PSOSHOWPAT)=1 S DIR("B")="YES"
 E  S DIR("B")="NO"
 W !
 D ^DIR
 I $D(DIRUT) W $C(7) Q 0
 S PSOSHOWPAT=Y
 Q 1
 ;
EXCEL(PSOEXCEL) ; Export the report to MS Excel?
 ; Function return values:
 ;   1 - User made a valid selection.
 ;   0 - User exited out.
 ; This function allows the user to indicate whether the report should be
 ; printed in a format that could easily be imported into an Excel
 ; spreadsheet.  If the user wants that, the variable PSOEXCEL will be set
 ; to '1', otherwise PSOEXCEL will be set to '0'.
 ;
 N DIR,DIRUT,Y
 ;
 S DIR(0)="Y"
 S DIR("A")="Export the report to Microsoft Excel (Y/N)"
 I $G(PSOEXCEL)=1 S DIR("B")="YES"
 E  S DIR("B")="NO"
 S DIR("?",1)="If you want to capture the output from this report in a format that"
 S DIR("?",2)="could easily be imported into an Excel spreadsheet, then answer YES here."
 S DIR("?")="If you want a normal report output, then answer NO here."
 W !
 D ^DIR
 K DIR
 I $D(DIRUT) W $C(7) Q 0
 S PSOEXCEL=+Y
 Q 1
 ;
DEVICE() ; Prompt user for output device.
 ; Function return values:
 ;   1 - User selected a device.
 ;   0 - User exited out.
 ;
 N DIR,POP,PSORETURN,X,Y,ZTDESC,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK
 S PSORETURN=1
 ;
 I 'PSOEXCEL W !!,"This report is 132 characters wide.  Please choose an appropriate device.",!
 I PSOEXCEL D
 . W !!?5,"Before continuing, please set up your terminal to capture the"
 . W !?5,"detail report data and save the detail report data in a text file"
 . W !?5,"to a local drive. This report may take a while to run."
 . W !!?5,"Note: To avoid undesired wrapping of the data saved to the file,"
 . W !?11,"please enter '0;256;99999' at the 'DEVICE:' prompt.",!
 . Q
 ;
 S ZTRTN="EN^PSOPROD2"
 I PSOREPORT="P" S ZTDESC="Pharmacy Productivity Report"
 E  S ZTDESC="RRR Revenue Report"
 S ZTSAVE("PSO*")=""
 ;
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
 I POP S PSORETURN=0
 I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR
 Q PSORETURN
 ;
