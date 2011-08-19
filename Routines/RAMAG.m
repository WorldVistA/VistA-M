RAMAG ;HCIOFO/SG - ORDERS/EXAMS API (README) ; 2/27/08 1:31pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 ; RAMISC -------------- MISCELLANEOUS PARAMETERS
 ;
 ; RAMISC(
 ;   Name1)              Value(s)
 ;   Name2,Seq#)         Value(s)
 ;   Name3,Seq#,Name4)   Value(s)
 ;
 ; See the MSCPRMS^RAMAGU01 for the complete list of parameter
 ; definitions.
 ;
 ; If a parameter is required and there is no default value, a non-
 ; empty value must be assigned to the corresponding array node
 ; before the call.
 ;
 ; If a parameter is required but there is a default value, then the
 ; latter will be assigned internally to the corresponding array node 
 ; if it is not defined or empty. If the default value is empty, then 
 ; an error will be returned.
 ;
 ; If a parameter is not required, then its default value (if
 ; indicated), will be internally assigned to the corresponding array 
 ; node only if it has no value ($DATA(...)#10=0). If an empty string 
 ; is assigned to such node, the corresponding field will not have the
 ; default value; it will be empty!
 ;
 ; If you want to clear a multiple that already has a value, assign
 ; "@" or empty string to the parameter itself and do not set any
 ; subscripts. For example, the following construction will clear
 ; the CONTRAST MEDIA multiple: S RAMISC("CONTMEDIA")="@".
 ;
 ; NOTE: The RAMISC parameter can be modified by the functions:
 ;       default values are assigned to some parameters.
 ;
 ; Control Flags - RAMISC("FLAGS")
 ; -------------------------------
 ;
 ; A  If this flag is provided, then the registration entry point
 ;    adds the new case to the existing ones with the same date/time
 ;    instead of returning the error code -28.
 ;
 ;    If the existing date/time record stores an exam set and the
 ;    "D" flag is not provided, then the error code -54 is returned.
 ;
 ; D  If there is an existing case with the same date/time, then the
 ;    time of the new case is incremented by 1 minute until an unused 
 ;    date/time is found.
 ;
 ;    If the "A" flag is also provided, then time increments also
 ;    stop when a non-examset date/time record is found.
 ;
 ;    If the date is also changed during the time modification, then
 ;    the case is not registered and the error code -29 is returned.
 ;
 ; F  Try to enforce the new status even if some required fields are
 ;    not populated.
 ;
 ;    NOTE: If such case is later edited by a regular Radiology
 ;          option, the status may be reverted.
 ;
 ; S  Do not send HL7 message to speech recognition (dictation)
 ;    systems.
 ;
 ; RAMSPSDEFS ---------- DATA FOR MISCELLANEOUS PARAMETERS VALIDATION
 ;
 ; RAMSPSDEFS(
 ;
 ;   "F",
 ;     File#,Name)       ""
 ;
 ;   "N",
 ;     Name)             Parameter descriptor
 ;                         ^01: (Sub)file number
 ;                         ^02: Field number
 ;                         ^03: Field type that requires special
 ;                              processing:
 ;                                D - Date/time, M - Multiple,
 ;                                P - Pointer,   W - Word processing,
 ;                                * - Add this parameter to the "F"
 ;                                    index (see the VEXAMND^RAMAGU14 
 ;                                    for details).
 ;                         ^04: Number of the "^"-piece of the value
 ;                              returned by the $$EXMSTREQ^RAMAGU06.
 ;                              It determines if a non-empty field
 ;                              value is required.
 ;
 ;   "R")                Exam status requirements (value returned by
 ;                       the $$EXMSTREQ^RAMAGU06 function).
 ;
 ; NAMESPACE ----------- DESCRIPTION
 ;
 ; RAMAGHL*              HL7 utilities
 ; RAMAGRP*              Remote procedures
 ; RAMAGU*               Utilities
 ;
 ; API ENTRY POINT ----- DESCRIPTION
 ;
 ;    $$ORDER^RAMAG02    Orders/requests an exam
 ; $$REGISTER^RAMAG03    Registers the exam
 ;  $$ORDCANC^RAMAG04    Cancels the order
 ; $$EXAMCANC^RAMAG05    Cancels the exam
 ; $$COMPLETE^RAMAG06    Completes the exam
 ; $$EXAMINED^RAMAG07    Indicates that procedure has been performed
 ;
 ; UTILITY ------------- DESCRIPTION
 ;
 ; $$LDMSPRMS^RAMAGU01   Loads definitions of miscellaneous parameters
 ;  $$RPCMISC^RAMAGU01   Parses miscellaneous RPC parameters
 ;
 ;  $$ORDSTAT^RAMAGU02   Returns current order status
 ; $$UPDORDST^RAMAGU02   Updates order status
 ;
 ;  $$CHKPROC^RAMAGU03   Checks Radiology procedure and modifiers
 ; $$DESCPLST^RAMAGU03   Translates parent procedure into descendents
 ;
 ;   $$ACCNUM^RAMAGU04   Constructs the site accession number
 ; $$CHKEXMID^RAMAGU04   Checks examination identifiers
 ;  $$DAYCASE^RAMAGU04   Constructs the day-case exam identifier
 ; $$EXAMIENS^RAMAGU04   Converts exam identifiers into the exam IENS
 ; $$EXAMNODE^RAMAGU04   Returns the exam global node
 ;   $$INVDTE^RAMAGU04   Calculates 'inverted' date/time
 ;  $$RAPTREG^RAMAGU04   Registers the patient in the file #70
 ; $$UPDEXMPR^RAMAGU04   Updates exam procedure and modifiers
 ;
 ;  $$EXMSTAT^RAMAGU05   Returns current exam status
 ; $$UPDEXMAL^RAMAGU05   Updates exam activity log
 ; $$UPDEXMST^RAMAGU05   Updates exam status
 ;
 ; $$EXMSTINF^RAMAGU06   Returns descriptor of the exam status
 ; $$EXMSTREQ^RAMAGU06   Returns exam status requirements
 ; $$GETEXMND^RAMAGU06   Searches for "EXAMINED" status
 ; $$NXTEXMST^RAMAGU06   Returns the following exam status
 ;
 ;    $$RAINP^RAMAGU07   Returns service, ward, and bedsection
 ;    $$VADEM^RAMAGU07   Wrapper for the DEM^VADPT
 ;    $$VAIN5^RAMAGU07   Wrapper for the IN5^VADPT
 ;
 ;    $$VAL70^RAMAGU08   Validates RAMISC params related to file #70
 ;    $$VAL74^RAMAGU10   Validates RAMISC params related to file #74
 ;
 ;       VARS^RAMAGU11   Writes variables and their values
 ;          W^RAMAGU11   Writes a long string
 ;
 ;  $$RPTSTUB^RAMAGU12   Creates a report stub record
 ;  $$RPTSTAT^RAMAGU12   Returns report status
 ; $$UPDRPTAL^RAMAGU12   Updates report activity log
 ; $$UPDRPTST^RAMAGU12   Updates report status
 ;
 ; $$NMEDSTUB^RAMAGU13   Creates a nuclear medicine stub record
 ; $$RARSNIEN^RAMAGU13   Searches for reason synonym
 ;  $$UPDMULT^RAMAGU13   Updates values of the multiple(s)
 ;
 ; REMOTE PROCEDURE ---- DESCRIPTION
 ;
 ; RAMAG EXAM CANCEL     Cancels the exam
 ; RAMAG EXAM COMPLETE   Completes the exam
 ; RAMAG EXAM ORDER      Orders/requests an exam
 ; RAMAG EXAM REGISTER   Registers the exam
 ; RAMAG EXAMINED        Procedure has been performed
 ; RAMAG ORDER CANCEL    Cancels the order
 ;
 Q
