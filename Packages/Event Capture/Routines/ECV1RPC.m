ECV1RPC ;ALB/ACS - Event Capture Spreadsheet Upload Broker Utilities ;12/2/22  15:57
 ;;2.0;EVENT CAPTURE;**25,33,49,61,131,139,159**;8 May 96;Build 61
 ;
 ; Reference to ^TMP supported by SACC 2.3.2.5.1
 ;
IN(RESULTS,ECDATA) ;
 ;----------------------------------------------------------------------
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
 ;                    name, patient first name, DSS unit name, DSS
 ;                    unit number, DSS unit IEN, procedure code,
 ;                    volume, ordering section, encounter d/t,category,
 ;                    diag code, associated clinic name,
 ;                    Associated Clinic IEN, CPT Mod #1, CPT Mod #2, 
 ;                    CPT Mod #3, CPT Mod #4, CPT Mod #5, Agent Orange, 
 ;                    Ionizing Rad, Service connected, SW Asia, MST, 
 ;                    HNC, Combat Vet, SHAD, Camp Lejeune, Prov #1,
 ;                    Prov #2, Prov #3, Prov #4,Prov #5, Prov #6,
 ;                    Prov #7, patient status override flag, override 
 ;                    deceased flag and file duplicate(s) flag.
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
 ;                    Station IEN^DSS Unit IEN^Category^Procedure^Volume
 ;                    ^Ordering Section IEN^User IEN^Primary Diagnosis^
 ;                    Associated ClinicCPT Mod #1 IEN^CPT Mod #2 IEN^
 ;                    CPT Mod #3 IEN^CPT Mod #4 IEN^CPT Mode #5 IEN^
 ;                    AO^Ion Rad^SC^SW Asia^MST^HNC^CV^SHAD^Camp 
 ;                    Lejeune^Prov 1^Prov 2^Prov 3^Prov 4^Prov 5^Prov 6^
 ;                    Prov 7^Patient Status^Sec Dx 1^Sec Dx 2^Sec Dx 3^
 ;                    Sec Dx 4^
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
 ;State Home Spreadsheet
 ;        If incoming data in ECDATA is from a state home spreadsheet
 ;        then the first piece of ECDATA will be set to 'State Home
 ;        Record'.  This identifier will be used when processing the
 ;        location associated with the record.
 ;----------------------------------------------------------------------
 ;
INIT ;-- piece numbers (associated with column numbers in the spreadsheet)
 N ECRECPC,ECSTAPC,ECSSNPC,ECPATLPC,ECPATFPC,ECDSSPC,ECDCMPC,ECUNITPC
 N ECPROCPC,ECVOLPC,ECOSPC,ECPRV1PC,ECENCPC,ECCATPC,ECDXPC ;131
 N ECCLNNPC,ECCLNIPC,ECMOD1PC,ECMOD2PC,ECMOD3PC,ECMOD4PC,ECMOD5PC,ECAOPC,ECIRPC,ECSCPC,ECSWAPC,ECMSTPC,ECHNCPC,ECCVPC,ECSHADPC,ECCLPC ;131
 N ECPRV2PC,ECPRV3PC,ECPRV4PC,ECPRV5PC,ECPRV6PC,ECPRV7PC ;131
 N ECSEC1PC,ECSEC2PC,ECSEC3PC,ECSEC4PC ;159
 ;-- spreadsheet values entered by user
 N ECRECV,ECSTAV,ECSSNV,ECPATLV,ECPATFV,ECPATV,ECDSSV,ECDCMV,ECUNITV
 N ECPROCV,ECVOLV,ECOSV,ECPRV1V,ECENCV,ECCATV,ECDXV ;131
 N ECCLNNV,ECPSTATV,ECDECPAT,ECFILDUP ;131
 N ECPRV2V,ECPRV3V,ECPRV4V,ECPRV5V,ECPRV6V,ECPRV7V,ECCLNIV,ECMOD1V,ECMOD2V,ECMOD3V,ECMOD4V,ECMOD5V,ECAOV,ECIRV,ECSCV,ECSWAV,ECMSTV,ECHNCV,ECCVV,ECSHADV,ECCLV ;131
 N ECSEC1V,ECSEC2V,ECSEC3V,ECSEC4V ;159
 ;-- error flags and derived data
 N ECERR,ECERRFLG,ECERRMSG,ECCOLERR,ECPRVIEN,ECOSIEN,ECVSSN,ECDSSIEN
 N ECINDEX,ECSSNIEN,ECPCLASS,ECPRVTYP,ECCATIEN,ECDXIEN,ECCLNIEN
 N ECPSTAT,ECSOURCE ;139
 N ECSECDX1,ECSECDX2,ECSECDX3,ECSECDX4 ;159
 ;
 S U="^"
 S (ECINDEX,ECERR)=0
 K RESULTS
 ;
 ;--Call utility program to set up piece numbers and column header info
 I ECDATA["COLHEADERS" D ECHDRS^ECU1RPC(ECDATA) Q
 ;
 I ECDATA["END OF PROCESSING" D CLEANUP Q
 I $P(ECDATA,U)="State Home Record" S ECSOURCE="STATE HOME",ECDATA=$P(ECDATA,U,2,999) ;139 For state home records, strip off state home identifier before processing
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
 ;note: ECDXIEN and ECCLNIEN will be set to null if the record is 
 ;not being sent to PCE or the DSS Unit is an OOS type unit.
 ;For OOS type DSS units, the encoutner status values (combat vet, etc.)
 ;will be returned as null as they aren't needed.
 ;
 I '($D(RESULTS(1))) D
 . N RESDATA
 . S RESDATA="NO ERRORS"_U_ECSSNIEN_U_ECENCV_U_ECSTAV_U_ECDSSIEN ;131
 . S RESDATA=RESDATA_U_ECCATIEN_U_ECPROCV_U_ECVOLV ;131
 . S RESDATA=RESDATA_U_ECOSIEN_U_ECDUZ_U_$G(ECDXIEN) ;131
 . S RESDATA=RESDATA_U_$G(ECCLNIEN)_U_ECMOD1V_U_ECMOD2V_U_ECMOD3V_U_ECMOD4V_U_ECMOD5V ;131
 . S RESDATA=RESDATA_U_ECAOV_U_ECIRV_U_ECSCV_U_ECSWAV_U_ECMSTV_U_ECHNCV_U_ECCVV_U_ECSHADV_U_ECCLV ;131
 . S RESDATA=RESDATA_U_ECPRV1V_U_ECPRV2V_U_ECPRV3V_U_ECPRV4V_U_ECPRV5V_U_ECPRV6V_U_ECPRV7V_U_ECPSTAT ;131
 . S RESDATA=RESDATA_U_$G(ECSECDX1)_U_$G(ECSECDX2)_U_$G(ECSECDX3)_U_$G(ECSECDX4)_U ;159
 . S RESULTS(1)=RESDATA
 . Q
 Q
 ;
CLEANUP ;Delete temporary files
 I $D(^TMP($J,"COLS")) K ^TMP($J,"COLS")
 Q
