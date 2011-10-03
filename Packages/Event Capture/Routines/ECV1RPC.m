ECV1RPC ;ALB/ACS;Event Capture Spreadsheet Upload Broker Utilities ;13 Oct 00
 ;;2.0; EVENT CAPTURE ;**25,33,49,61**;8 May 96
 ;
IN(RESULTS,ECDATA) ;
 ;-----------------------------------------------------------------------
 ;This broker entry point receives a row of data from the Event
 ;Capture GUI Spreadsheet (a module of the Event Capture GUI app).
 ;The data is validated and an array is returned to the spreadsheet
 ;module.
 ;
 ;          RPC: EC VALIDATE SPREADSHEET DATA
 ;
 ;INPUT     ECDATA  - Contains either the column headers or a row of
 ;                    spreadshet data.  Fields included are:
 ;                    Record number, station, SSN, patient last
 ;                    name, patient first name, DSS unit IEN, DSS
 ;                    unit number, DSS unit name, procedure code,
 ;                    volume, ordering section, provider last name,
 ;                    provider first name, encounter date/time,
 ;                    event code category, diag code, associated clinic,
 ;                    patient status override flag, override deceased
 ;                    flag and file duplicate(s) flag.
 ;
 ;OUTPUT    RESULTS - If an error is found during data validation,
 ;                    then the output contains an array of error
 ;                    messages:
 ;
 ;                    PIECE     Description
 ;                    -----     ------------------------
 ;                      1       Record number
 ;                      2       Column number (on spreadsheet)
 ;                              containing the record number
 ;                      3       Column number (on spreadsheet)
 ;                              containing the data in error
 ;                      4       Error message
 ;
 ;                  - If no errors are found during data validation,
 ;                    then the output contains a string of Event
 ;                    Capture data for that patient, beginning with
 ;                    the string "NO ERRORS":
 ;
 ;                    "NO ERRORS"^Patient SSN IEN^Encounter Date/Time^
 ;                    Station IEN^DSS Unit IEN^0^Procedure^Volume^
 ;                    Provider IEN^Ordering Section IEN^Provider IEN^
 ;                    Patient Status^
 ;                 
 ;OTHER     ^TMP($J,"COLS") will store the column/data order
 ;          (used as data 'piece') of the input data string.
 ;          For example:
 ;
 ;          ^TMP($J,"COLS","ECRECPC")=1   => Record number is 1st piece
 ;          ^TMP($J,"COLS","ECSTAPC")=2   => Station is 2nd piece
 ;
 ;SPECIAL PROCESSING
 ;          An exception to the above described output exists when no
 ;          exact match is found on the provider.  In this case, some
 ;          provider info will be sent back with the error message
 ;          so the user can determine which provider they want.  For
 ;          example, provider JONES,WILLIAM is entered by the user, but
 ;          the file contains JONES,WILLIAM H and JONES,WILLIAM J.
 ;          Both of those providers and their associated information 
 ;          will be sent with the error message.
 ;       
 ;
 ;-----------------------------------------------------------------------
 ;
INIT ;-- piece numbers (associated with column numbers in the spreadsheet)
 N ECRECPC,ECSTAPC,ECSSNPC,ECPATLPC,ECPATFPC,ECDSSPC,ECDCMPC,ECUNITPC
 N ECPROCPC,ECVOLPC,ECOSPC,ECPRVLPC,ECPRVFPC,ECENCPC,ECCATPC,ECDXPC
 N ECCLNPC
 ;-- spreadsheet values entered by user
 N ECRECV,ECSTAV,ECSSNV,ECPATLV,ECPATFV,ECPATV,ECDSSV,ECDCMV,ECUNITV
 N ECPROCV,ECVOLV,ECOSV,ECPROVLV,ECPROVFV,ECPROVV,ECENCV,ECCATV,ECDXV
 N ECCLNV,ECPSTATV,ECDECPAT,ECFILDUP
 ;-- error flags and derived data
 N ECERR,ECERRFLG,ECERRMSG,ECCOLERR,ECPRVIEN,ECOSIEN,ECVSSN,ECDSSIEN
 N ECINDEX,ECSSNIEN,ECPCLASS,ECPRVTYP,ECCATIEN,ECDXIEN,ECCLNIEN
 N ECPSTAT
 ;
 S U="^"
 S (ECINDEX,ECERR)=0
 K RESULTS
 ;
 ;--Call utility program to set up piece numbers and column header info
 I ECDATA["COLHEADERS" D ECHDRS^ECU1RPC(ECDATA) Q
 ;
 I ECDATA["END OF PROCESSING" D CLEANUP Q
 ;
MAIN ;--Call utility program to get piece numbers and set up data values
 D GETDATA^ECU1RPC(ECDATA)
 ;
 ;--Call validation routines to validate the data
 D ^ECV2RPC
 D ^ECV3RPC
 D ^ECV4RPC
 ;
FINAL ;If no errors, send data back to spreadsheet module
 ;note: ECDXIEN and ECCLNIEN will not be sent back if the record is 
 ;not being sent to PCE.
 ;
 I '($D(RESULTS(1))) D
 . N RESDATA
 . S RESDATA="NO ERRORS"_"^"_ECSSNIEN_"^"_ECENCV_"^"_ECSTAV_"^"_ECDSSIEN
 . S RESDATA=RESDATA_"^"_ECCATIEN_"^"_ECPROCV_"^"_ECVOLV_"^"_ECPRVIEN
 . S RESDATA=RESDATA_"^"_ECOSIEN_"^"_ECDUZ_"^"_$G(ECDXIEN)
 . S RESDATA=RESDATA_"^"_$G(ECCLNIEN)_"^"_ECPSTAT_"^"
 . S RESULTS(1)=RESDATA
 . Q
 Q
 ;
CLEANUP ;Delete temporary files
 I $D(^TMP($J,"COLS")) K ^TMP($J,"COLS")
 Q
