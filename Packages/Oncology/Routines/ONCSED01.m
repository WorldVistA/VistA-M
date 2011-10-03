ONCSED01 ;Hines OIFO/SG - EDITS 'RUN BATCH' REQUEST ; 11/6/06 11:48am
 ;;2.11;ONCOLOGY;**47**;Mar 07, 1995;Build 19
 ;
 ;--- SOAP REQUST TO THE ONCOLOGY WEB SERVICE
 ;
 ; <?xml version="1.0" encoding="utf-8"?>
 ; <soap:Envelope
 ;   xmlns:soap="http://www.w3.org/2001/12/soap-envelope"
 ;   soap:encodingStyle="http://www.w3.org/2001/12/soap-encoding">
 ;   <soap:Body>
 ;     <ED-RUN-BATCH [edits-config="..."] ver="2.0"
 ;       xmlns="http://vista.med.va.gov/oncology">
 ;       <NAACCR-RECORD> ... </NAACCR-RECORD>
 ;     </ED-RUN-BATCH>
 ;   </soap:Body >
 ; </soap:Envelope>
 ;
 ;--- ATTRIBUTES
 ;
 ; edits-config  Name of the configuration that should be used by
 ;               the server to validate the data.  By default,
 ;               the "DEFAULT" name is used.
 ;
 Q
 ;
 ;***** EXECUTES THE 'RUN BATCH' EDITS REQUEST
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see ^ONCSAPI)
 ;
 ; .ONC8REQ      Reference to a local variable that stores the
 ;               closed root of the request.
 ;
 ;               Sub-nodes of the variable are used internally
 ;               (see ^ONCSNACR and ^ONCSAPIR for details).
 ;
 ; [ONC8MSG]     Closed root of the buffer for error messages. By
 ;               default ($G(ONC8MSG)=""), the ^TMP("ONCSED01M",$J)
 ;               global node is used.
 ;
 ; @ONC8MSG@(
 ;   0)                  Result descriptor
 ;                         ^01: Number of errors
 ;                         ^02: Number of warnings
 ;                         ^03: Web-service version
 ;                         ^04: Metafile version
 ;   set#,
 ;     0)                Edit set descriptor
 ;                         ^01: Number of errors
 ;                         ^02: Number of warnings
 ;     1)                Edit set name
 ;     "E",
 ;       edit#,
 ;         0)            Edit descriptor
 ;                         ^01: Number of errors
 ;                         ^02: Number of warnings
 ;                         ^03: Edit index
 ;         1)            Edit name
 ;         "F",
 ;           fld#,
 ;             0)        Field descriptor
 ;                         ^01: Start position
 ;           1)          Field name
 ;           2)          Field value
 ;
 ;         "M",
 ;           msg#,
 ;             0)        Message descriptor
 ;                         ^01: Code
 ;                         ^02: Type
 ;             1)        Message text
 ;
 ;   "ES",
 ;     edit#)            set#
 ;
 ; The ^TMP("ONCSED01R",$J) and ^TMP("ONCSED01M",$J) global nodes
 ; are used by this function.
 ;
 ; Return values:
 ;
 ;       <0  Error Descriptor (see ^ONCSAPI for details)
 ;           For example:
 ;             "-6^Parameter 'ONC8REQ' has an invalid value: ''^
 ;              RBQEXEC+3^ONCSED01"
 ;
 ;        0  Ok
 ;
 ;        1  EDITS Warnings
 ;
 ;        2  EDITS Errors
 ;
RBQEXEC(ONCSAPI,ONC8REQ,ONC8MSG) ;
 N ONC8RDAT,RC,TMP,URL,X
 ;--- Validate parameters
 Q:$G(ONC8REQ)?." " $$ERROR^ONCSAPIE(-6,,"ONC8REQ",$G(ONC8REQ))
 S:$G(ONC8MSG)?." " ONC8MSG=$NA(^TMP("ONCSED01M",$J))
 ;--- Initialize variables
 S ONC8RDAT=$NA(^TMP("ONCSED01R",$J))
 K @ONC8RDAT,@ONC8MSG
 ;
 ;--- Finish preparation of the NAACCR record
 D END^ONCSNACR(.ONC8REQ)
 ;
 ;--- Complete the request
 D TRAILER^ONCSAPIR(.ONC8REQ)
 ;
 ;--- Get the server URL
 S URL=$$GETCSURL^ONCSAPIU()  Q:URL<0 URL
 ;
 S RC=0  D
 . ;--- Call the web service
 . D:$G(ONCSAPI("DEBUG"))
 . . D ZW^ONCSAPIU(ONC8REQ,"*** 'RUN BATCH' REQUEST ***")
 . S RC=$$REQUEST^ONCSAPIR(URL,ONC8RDAT,ONC8REQ)  Q:RC<0
 . D:$G(ONCSAPI("DEBUG"))
 . . D ZW^ONCSAPIU(ONC8RDAT,"*** 'RUN BATCH' RESPONSE ***")
 . ;--- Parse the response
 . S RC=$$PARSE^ONCSED02(.ONCSAPI,ONC8RDAT,ONC8MSG)
 ;
 ;--- Cleanup
 K ^TMP("ONCSED01R",$J)
 D:RC'<0
 . S TMP=$G(@ONC8MSG@(0))
 . S RC=$S($P(TMP,U,1)>0:2,$P(TMP,U,2)>0:1,1:0)
 Q RC
 ;
 ;***** STARTS PREPARATION OF THE 'RUN BATCH' EDITS REQUEST
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see ^ONCSAPI)
 ;
 ; .ONC8REQ      Reference to a local variable that stores the
 ;               closed root of the buffer for the request.
 ;
 ;               Sub-nodes of the variable are used internally
 ;               (see ^ONCSNACR and ^ONCSAPIR for details).
 ;
 ; [CFGNAME]     Name of the configuration that should be used by
 ;               the server to validate the data.  By default,
 ;               the default configuration is used.
 ;
 ; Return values:
 ;
 ;       <0  Error Descriptor (see ^ONCSAPI for details)
 ;           For example:
 ;             "-6^Parameter 'ONC8REQ' has an invalid value: ''^
 ;              RBQPREP+3^ONCSED01"
 ;
 ;        0  Ok
 ;
RBQPREP(ONCSAPI,ONC8REQ,CFGNAME) ;
 N ATTS
 D CLEAR^ONCSAPIE()
 ;--- Validate parameters
 Q:$G(ONC8REQ)?." " $$ERROR^ONCSAPIE(-6,,"ONC8REQ",$G(ONC8REQ))
 ;
 ;--- Standard request header
 S:'($G(CFGNAME)?." ") ATTS("edits-config")=CFGNAME
 D HEADER^ONCSAPIR(.ONC8REQ,"ED-RUN-BATCH",.ATTS)
 ;
 ;--- Start preparation of the NAACCR record
 D BEGIN^ONCSNACR(.ONC8REQ)
 ;---
 Q 0
 ;
 ;***** PRINTS 'EDITS' REPORT ON THE CURRENT DEVICE
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see ^ONCSAPI)
 ;
 ; ONC8MSG       Closed root of the list of parsed error messages
 ;               (generated by the RBQEXEC^ONCSED0101)
 ;
 ; [FLAGS]       Flags that control the output (can be combined):
 ;                 M  Include messages
 ;                 T  Include totals
 ;
 ; Return values:
 ;
 ;       <0  Error Descriptor (see ^ONCSAPI for details)
 ;           For example:
 ;             "-6^Parameter 'ONC8REQ' has an invalid value: ''^
 ;              RBQEXEC+3^ONCSED01"
 ;
 ;        0  Ok
 ;
 ;        1  Timeout
 ;        2  User canceled the output ('^' was entered) 
 ;
REPORT(ONCSAPI,ONC8MSG,FLAGS) ;
 N RC,TMP
 S TMP=$G(@ONC8MSG@(0))
 Q:($P(TMP,U,1)'>0)&($P(TMP,U,2)'>0) 0
 S FLAGS=$G(FLAGS)
 I $TR(FLAGS,"MT")'=FLAGS  W:$E(IOST,1,2)="C-" @IOF
 ;--- EDITS messages
 I FLAGS["M"  D  Q:RC RC
 . S RC=$$MESSAGES^ONCSED03(.ONCSAPI,ONC8MSG,FLAGS)
 ;--- EDITS totals
 I FLAGS["T"  D  Q:RC RC
 . S RC=$$TOTALS^ONCSED03(.ONCSAPI,ONC8MSG,FLAGS)
 ;---
 Q 0
