RORERR20 ;HCIOFO/SG - LIST OF ERROR MESSAGES  ; 1/22/06 7:00pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** RETURNS THE TEXT OF THE MESSAGE
 ;
 ; ERRCODE       Error code
 ; [.TYPE]       Type of the error
 ; [ARG1-ARG5]   Optional parameters that substitute the |n| "windows"
 ;               in the text of the message (for example, the |2| will
 ;               be substituted by the value of the ARG2).
 ;
MSG(ERRCODE,TYPE,ARG1,ARG2,ARG3,ARG4,ARG5) ;
 S TYPE=6  Q:ERRCODE'<0 ""
 N ARG,I1,I2,MSG
 ;--- Get a descriptor of the message
 S I1=-ERRCODE,MSG=$P($T(MSGLIST+I1),";;",2)
 S I1=+$TR($P(MSG,U,2)," "),MSG=$P(MSG,U,3,999)
 S:I1>0 TYPE=I1
 Q:MSG?." " "Unknown error ("_ERRCODE_")"
 ;--- Substitute parameters
 S I1=2
 F  S I1=$F(MSG,"|",I1-1)  Q:'I1  D
 . S I2=$F(MSG,"|",I1)  Q:'I2
 . X "S ARG=$G(ARG"_+$TR($E(MSG,I1,I2-2)," ")_")"
 . S $E(MSG,I1-1,I2-1)=ARG
 Q $$TRIM^XLFSTR(MSG)
 ;
 ;***** RETURNS TYPE OF THE MESSAGE
 ;
 ; ERRCODE       Error code
 ;
TYPE(ERRCODE) ;
 Q:ERRCODE'<0 0
 N I,TYPE  S I=-ERRCODE
 S I=$P($T(MSGLIST+I),";;",2),TYPE=+$TR($P(I,U,2)," ")
 Q $S(TYPE>0:TYPE,1:6)
 ;
 ;***** LIST OF THE MESSAGES (THERE SHOULD BE NOTHING AFTER THE LIST!)
 ;
 ; The error codes are provided in the table only for clarity.
 ; Text of the messages are extracted using the $TEXT function and
 ; absolute values of the ERRCODE parameter.
 ;
 ; Message Type:
 ;               1  Debug          4  Warning
 ;               2  Information    5  Database Error
 ;               3  Data Quality   6  Error
 ;
MSGLIST ; Code Type  Message Text
 ;;  -1 ^ 6 ^ Cannot find a descriptor of the registry
 ;;  -2 ^ 6 ^ Duplicate registry names
 ;;  -3 ^ 6 ^ Cannot find a descriptor of the selection rule
 ;;  -4 ^ 6 ^ Duplicate rule names
 ;;  -5 ^ 6 ^ Circle rule references
 ;;  -6 ^ 6 ^ Invalid update entry point: |2|
 ;;  -7 ^ 6 ^ Field '|2|' not found
 ;;  -8 ^ 6 ^ Duplicate patients in the registry
 ;;  -9 ^ 5 ^ FileMan DBS call error(s)|2|
 ;; -10 ^ 6 ^ Bad registry name: '|2|'
 ;; -11 ^ 6 ^ Cannot lock the record(s) of |2|
 ;; -12 ^ 6 ^ Cannot load and prepare lab search data
 ;; -13 ^ 6 ^ Cannot lock the registries
 ;; -14 ^ 6 ^ Cannot prepare selection rules
 ;; -15 ^ 6 ^ Error(s) during processing of the patient data
 ;; -16 ^ 6 ^ Cannot update demographic data
 ;; -17 ^ 6 ^ Invalid entry point: '|2|'
 ;; -18 ^ 6 ^ Routine '|2|' does not exist
 ;; -19 ^ 6 ^ Cannot load the selection rules
 ;; -20 ^ 6 ^ Cannot sort the selection rules
 ;; -21 ^ 6 ^ Syntax error in the expression
 ;; -22 ^ 6 ^ Cannot prepare data extraction definitions
 ;; -23 ^ 6 ^ Cannot set up HL7 environment variables
 ;; -24 ^ 6 ^ Cannot send the batch HL7 message
 ;; -25 ^ 6 ^ No HL7 event driver protocol
 ;; -26 ^ 3 ^ Neither ICN nor SSN is available
 ;; -27 ^ 5 ^ Cannot obtain results of the Lab tests
 ;; -28 ^ 4 ^ No active registries to |2|!
 ;; -29 ^ 1 ^ Non-existent LOINC code |2| in the registry parameters
 ;; -30 ^ 5 ^ Duplicate records in the file #95.3 for LOINC code |2|
 ;; -31 ^ 4 ^ Cannot remove the patient #|1| from the pending list
 ;; -32 ^ 6 ^ Incorrect data extraction period: '|2|-|3|'
 ;; -33 ^ 6 ^ Cannot de-queue data extraction task
 ;; -34 ^ 6 ^ Cannot open an output file
 ;; -35 ^ 6 ^ Device Handler error
 ;; -36 ^ 6 ^ Cannot retrieve Patient details (DFN:|1|) from File #|2|
 ;; -37 ^ 6 ^ Cannot retrieve details of medication
 ;; -38 ^ 6 ^ Cannot retrieve CPT code
 ;; -39 ^ 6 ^ Duplicate HL7 message ID in the file #798: '|2|'
 ;; -40 ^ 6 ^ Undefined variable: '|2|'
 ;; -41 ^ 2 ^ Registry setup has been completed
 ;; -42 ^ 4 ^ Task has been interrupted by user or by parent task
 ;; -43 ^ 6 ^ Error during the |2|. See log files.
 ;; -44 ^ 6 ^ Invalid extraction entry point: '|2|'
 ;; -45 ^ 6 ^ Invalid or missing IEN of selection rule
 ;; -46 ^ 5 ^ Cannot load registry parameters
 ;; -47 ^ 5 ^ Cannot find the '|2|' drug class
 ;; -48 ^ 2 ^ Registry '|2|' is inactive
 ;; -49 ^ 4 ^ Cannot find HL7 message #|2| to check its status
 ;; -50 ^ 6 ^ Cannot create the '|2|' checkpoint!
 ;; -51 ^ 6 ^ Cannot complete the '|2|' checkpoint!
 ;; -52 ^ 6 ^ Cannot find HL7 message ID in the file #798: '|2|'
 ;; -53 ^ 6 ^ Cannot enable the '|2|' protocol
 ;; -54 ^ 6 ^ The '|2|' Lab Search is not defined
 ;; -55 ^ 4 ^ No indicators are defined for the '|2|' Lab Search
 ;; -56 ^ 6 ^ Error code '|2|' is returned by the '|3|'
 ;; -57 ^ 4 ^ Error code '|2|' is returned by the '|3|'
 ;; -58 ^ 6 ^ File '|2|' not found
 ;; -59 ^ 3 ^ ICN checksum is shorter than 6 digits
 ;; -60 ^ 6 ^ Subtask #|2| crashed (see TaskMan logs)
 ;; -61 ^ 6 ^ Cannot start the registry update in multitask mode
 ;; -62 ^ 2 ^ Registry Update subtask #|2| has been scheduled
 ;; -63 ^ 6 ^ Data search in file #|2| is not supported
 ;; -64 ^ 6 ^ Data element #|3| (file #|2|) is not supported
 ;; -65 ^ 6 ^ |4| value of element #|3| (file #|2|) is not supported
 ;; -66 ^ 1 ^ Patient was skipped due to counter in the file #798.3
 ;; -67 ^ 6 ^ CCR HL7 messages created |2| day(s) ago have not been sent yet.
 ;; -68 ^ 6 ^ Invalid header of the HL7 message (or no header at all)
 ;; -69 ^ 6 ^ Cannot find the data element
 ;; -70 ^ 6 ^ Duplicate names of the data element
 ;; -71 ^ 1 ^ User entered the "^"
 ;; -72 ^ 6 ^ Timeout
 ;; -73 ^ 4 ^ HL7 message #|2| is being processed/transmitted
 ;; -74 ^ 6 ^ Number of messages in the batch does not match the BTS
 ;; -75 ^ 6 ^ Not all four HL7 encoding characters are defined
 ;; -76 ^ 6 ^ The [|2|] option must not be running during installation
 ;; -77 ^ 6 ^ Cannot create MailMan message stub
 ;; -78 ^ 6 ^ Scheduled subtasks have not been started by TaskMan
 ;; -79 ^ 6 ^ Missing or dangling pointer
 ;; -80 ^ 6 ^ Cannot find a list item (file #799.1)
 ;; -81 ^ 6 ^ Duplicate item codes (file #799.1)
 ;; -82 ^ 6 ^ The task '|2|' cannot be scheduled at '|3|'
 ;; -83 ^ 6 ^ Cannot find the task #|2| in the ROR TASK file
 ;; -84 ^ 6 ^ The task #|2| has not responded on the stop request yet
 ;; -85 ^ 6 ^ Invalid task number: '|2|'
 ;; -86 ^ 6 ^ Cannot find report parameters (file #799.34)
 ;; -87 ^ 6 ^ Duplicate report parameters (file #799.34)
 ;; -88 ^ 6 ^ Parameter |2| has an invalid value: '|3|'
 ;; -89 ^ 2 ^ No output file has been created
 ;; -90 ^ 2 ^ The patient has been deleted from the |2| registry
 ;; -91 ^ 6 ^ Illegal attempt to access the registries from the GUI
 ;; -92 ^ 6 ^ Cannot re-queue unsent batch HL7 message #|2|
 ;; -93 ^ 4 ^ Batch HL7 message #|2| has been re-queued
 ;; -94 ^ 2 ^ Data Extraction task #|2| has been scheduled
 ;; -95 ^ 3 ^ Invalid value. File: #|2|; IENS: "|3|"; Field(s): |4|
 ;; -96 ^ 6 ^ Cannot rename the '|2|' security key to '|3|'
 ;; -97 ^ 6 ^ The patient is not in the |2|
 ;; -98 ^ 6 ^ Cannot get closed root name of file #|2| (IENS: |3|)
 ;; -99 ^ 1 ^ FileMan DBS call error(s)|2|
 ;;-100 ^ 3 ^ |2| was returned by the |3|
 ;;-101 ^ 2 ^ Your CCR task #|2| has finished (|3|)
 ;;-102 ^ 5 ^ Invalid or missing record in the |2| file (IEN: |3|)
 ;;-103 ^ 6 ^ The registry |2| has not been populated yet.
 ;;-104 ^ 4 ^ XML parsing warning
 ;;-105 ^ 6 ^ XML parsing error
 ;;-106 ^ 6 ^ Error(s) during parsing the report parameters
 ;;-107 ^ 6 ^ Incompatible version of the GUI
 ;;-108 ^ 2 ^ Backpull parameters have been loaded.
 ;;-109 ^ 2 ^ Automatic backpull has been completed.
 ;;-110 ^ 5 ^ Pointer(s) in the restored data cannot be resolved.
 ;;-111 ^ 2 ^ Patient "merge" from DFN #|2| to DFN #|3|.
