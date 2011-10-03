ONCSAPI3 ;Hines OIFO/SG - COLLABORATIVE STAGING (CALCULATE) ;06/23/10
 ;;2.11;ONCOLOGY;**40,51**;Mar 07, 1995;Build 65
 ;
 ;--- SOAP REQUST TO THE COLLABORATIVE STAGING WEB SERVICE
 ;
 ; <?xml version="1.0" encoding="utf-8"?>
 ; <soap:Envelope
 ;   xmlns:soap="http://www.w3.org/2001/12/soap-envelope"
 ;   soap:encodingStyle="http://www.w3.org/2001/12/soap-encoding">
 ;   <soap:Body>
 ;     <CS-CALCULATE xmlns="http://vista.med.va.gov/oncology">
 ;       <HIST> ... </HIST>
 ;       <SITE> ... </SITE>
 ;       <DIAGNOSIS_YEAR> ... </DIAGNOSIS_YEAR>
 ;       <CSVER_ORIGINAL> ... </CSVER_ORIGINAL>
 ;       <BEHAV> ... </BEHAV>
 ;       <GRADE> ... </GRADE>
 ;       <AGE> ... </AGE>
 ;       <LVI> ... </LVI>
 ;       <SIZE> ... </SIZE>
 ;       <EXT> ... </EXT>
 ;       <EXTEVAL> ... </EXTEVAL>
 ;       <NODES> ... </NODES>
 ;       <NODESEVAL> ... </NODESEVAL>
 ;       <LNPOS> ... </LNPOS>
 ;       <LNEXAM> ... </LNEXAM>
 ;       <METS> ... </METS>
 ;       <METSEVAL> ... </METSEVAL>
 ;       <SSF1> ... </SSF1>
 ;       <SSF2> ... </SSF2>
 ;       <SSF3> ... </SSF3>
 ;       <SSF4> ... </SSF4>
 ;       <SSF5> ... </SSF5>
 ;       <SSF6> ... </SSF6>
 ;       <SSF7> ... </SSF7>
 ;       <SSF8> ... </SSF8>
 ;       <SSF9> ... </SSF9>
 ;       <SSF10> ... </SSF10>
 ;       <SSF11> ... </SSF11>
 ;       <SSF12> ... </SSF12>
 ;       <SSF13> ... </SSF13>
 ;       <SSF14> ... </SSF14>
 ;       <SSF15> ... </SSF15>
 ;       <SSF16> ... </SSF16>
 ;       <SSF17> ... </SSF17>
 ;       <SSF18> ... </SSF18>
 ;       <SSF19> ... </SSF19>
 ;       <SSF20> ... </SSF20>
 ;       <SSF21> ... </SSF21>
 ;       <SSF22> ... </SSF22>
 ;       <SSF23> ... </SSF23>
 ;       <SSF24> ... </SSF24>
 ;       <SSF25> ... </SSF25>
 ;     </CS-CALCULATE>
 ;   </soap:Body >
 ; </soap:Envelope>
 ;
 ;--- SOAP RESPONSE FROM THE COLLABORATIVE STAGING WEB SERVICE
 ;
 ; <?xml version="1.0" encoding="utf-8"?>
 ; <soap:Envelope
 ;   xmlns:soap="http://www.w3.org/2001/12/soap-envelope"
 ;   soap:encodingStyle="http://www.w3.org/2001/12/soap-encoding">
 ;   <soap:Body>
 ;     <CS-RESPONSE xmlns="http://vista.med.va.gov/oncology">
 ;       <CS-STOR>
 ;         <T> ... </T>
 ;         <TDESCR> ... </TDESCR>
 ;         <N> ... </N>
 ;         <NDESCR> ... </NDESCR>
 ;         <M> ... </M>
 ;         <MDESCR> ... </MDESCR>
 ;         <AJCC> ... </AJCC>
 ;         <AJCC7-T> ... </AJCC7-T>
 ;         <AJCC7-TDESCR> ... </AJCC7-TDESCR>
 ;         <AJCC7-N> ... </AJCC7-N>
 ;         <AJCC7-NDESCR> ... </AJCC7-NDESCR>
 ;         <AJCC7-M> ... </AJCC7-M>
 ;         <AJCC7-MDESCR> ... </AJCC7-MDESCR>
 ;         <AJCC7-STAGE> ... </AJCC7-STAGE>
 ;         <SS1977> ... </SS1977>
 ;         <SS2000> ... </SS2000>
 ;       </CS-STOR>
 ;       <CS-DISP>
 ;         <T> ... </T>
 ;         <TDESCR> ... </TDESCR>
 ;         <N> ... </N>
 ;         <NDESCR> ... </NDESCR>
 ;         <M> ... </M>
 ;         <MDESCR> ... </MDESCR>
 ;         <AJCC> ... </AJCC>
 ;         <AJCC7-T> ... </AJCC7-T>
 ;         <AJCC7-TDESCR> ... </AJCC7-TDESCR>
 ;         <AJCC7-N> ... </AJCC7-N>
 ;         <AJCC7-NDESCR> ... </AJCC7-NDESCR>
 ;         <AJCC7-M> ... </AJCC7-M>
 ;         <AJCC7-MDESCR> ... </AJCC7-MDESCR>
 ;         <AJCC7-STAGE> ... </AJCC7-STAGE>
 ;         <SS1977> ... </SS1977>
 ;         <SS2000> ... </SS2000>
 ;       </CS-DISP>
 ;       <APIVER> ... </APIVER>
 ;       <VERSION> ... </VERSION>
 ;     </CS-RESPONSE>
 ;     <soap:Fault>
 ;       <faultcode> ... </faultcode>
 ;       <faultstring> ... </faultstring>
 ;       <detail>
 ;         <ERROR> ... </ERROR>
 ;         <MSG>
 ;         ...
 ;         </MSG>
 ;         <RC> ... </RC>
 ;       </detail>
 ;     </soap:Fault>
 ;   </soap:Body >
 ; </soap:Envelope>
 ;
 Q
 ;
 ;***** CALLS THE COLLABORATIVE STAGING WEB SERVICE
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see ^ONCSAPI)
 ;
 ; .INPUT(       Reference to a local variable containing
 ;               input parameters.
 ;
 ;   "AGE")             Age at Diagnosis
 ;   "BEHAV")           Behavior Code ICD-O-3
 ;   "CSVER_ORIGINAL")  CS Version Original
 ;   "DIAGNOSIS_YEAR")  Year of Diagnosis
 ;   "EXT")             CS Extension
 ;   "EXTEVAL")         CS Size/Ext Eval
 ;   "GRADE")           Grade
 ;   "HIST")            Histologic Type ICD-O-3
 ;   "LNPOS")           Regional Nodes Positive
 ;   "LNEXAM")          Regional Nodes Examined
 ;   "LVI")             Lymph-vascular invasion
 ;   "METS")            CS Mets at DX
 ;   "METSEVAL")        CS Mets Eval
 ;   "NODES")           CS Lymph Nodes
 ;   "NODESEVAL")       CS Reg Nodes Eval
 ;   "SITE")            Primary site
 ;   "SIZE")            CS Tumor Size
 ;   "SSF1")            CS Site-Specific Factor 1
 ;   "SSF2")            CS Site-Specific Factor 2
 ;   "SSF3")            CS Site-Specific Factor 3
 ;   "SSF4")            CS Site-Specific Factor 4
 ;   "SSF5")            CS Site-Specific Factor 5
 ;   "SSF6")            CS Site-Specific Factor 6
 ;   "SSF7")            CS Site-Specific Factor 7
 ;   "SSF8")            CS Site-Specific Factor 8
 ;   "SSF9")            CS Site-Specific Factor 9
 ;   "SSF10")           CS Site-Specific Factor 10
 ;   "SSF11")           CS Site-Specific Factor 11
 ;   "SSF12")           CS Site-Specific Factor 12
 ;   "SSF13")           CS Site-Specific Factor 13
 ;   "SSF14")           CS Site-Specific Factor 14
 ;   "SSF15")           CS Site-Specific Factor 15
 ;   "SSF16")           CS Site-Specific Factor 16
 ;   "SSF17")           CS Site-Specific Factor 17
 ;   "SSF18")           CS Site-Specific Factor 18
 ;   "SSF19")           CS Site-Specific Factor 19
 ;   "SSF20")           CS Site-Specific Factor 20
 ;   "SSF21")           CS Site-Specific Factor 21
 ;   "SSF22")           CS Site-Specific Factor 22
 ;   "SSF23")           CS Site-Specific Factor 23
 ;   "SSF24")           CS Site-Specific Factor 24
 ;   "SSF25")           CS Site-Specific Factor 25
 ;
 ; .ONCSTOR(     Reference to a local variable where output
 ;               storage values are returned.
 ;
 ;   "AJCC-6")       6th Edition Derived AJCC Stage Group
 ;   "N-6")          6th Edition Derived AJCC N
 ;   "NDESCR-6")     6th Edition Derived AJCC N Descriptor
 ;   "M-6")          6th Edition Derived AJCC M
 ;   "MDESCR-6")     6th Edition Derived AJCC M Descriptor
 ;   "AJCC-7")       7th Edition Derived AJCC Stage Group
 ;   "N-7")          7th Edition Derived AJCC N
 ;   "NDESCR-7")     7th Edition Derived AJCC N Descriptor
 ;   "M-7")          7th Edition Derived AJCC M
 ;   "MDESCR-7")     7th Edition Derived AJCC M Descriptor
 ;   "SS1977")       Derived SS1977
 ;   "SS2000")       Derived SS2000
 ;   "T-6")          6th Edition Derived AJCC T
 ;   "TDESCR-6")     6th Edition Derived AJCC T Descriptor
 ;   "T-7")          7th Edition Derived AJCC T
 ;   "TDESCR-7")     7th Edition Derived AJCC T Descriptor
 ;
 ; .ONCDISP(     Reference to a local variable where output
 ;               display values are returned.
 ;
 ;   "AJCC-6")       6th Edition Derived AJCC Stage Group
 ;   "N-6")          6th Edition Derived AJCC N
 ;   "NDESCR-6")     6th Edition Derived AJCC N Descriptor
 ;   "M-6")          6th Edition Derived AJCC M
 ;   "MDESCR-6")     6th Edition Derived AJCC M Descriptor
 ;   "AJCC-7")       7th Edition Derived AJCC Stage Group
 ;   "N-7")          7th Edition Derived AJCC N
 ;   "NDESCR-7")     7th Edition Derived AJCC N Descriptor
 ;   "M-7")          7th Edition Derived AJCC M
 ;   "MDESCR-7")     7th Edition Derived AJCC M Descriptor
 ;   "SS1977")       Derived SS1977
 ;   "SS2000")       Derived SS2000
 ;   "T-6")          6th Edition Derived AJCC T
 ;   "TDESCR-6")     6th Edition Derived AJCC T Descriptor
 ;   "T-7")          7th Edition Derived AJCC T
 ;   "TDESCR-7")     7th Edition Derived AJCC T Descriptor
 ;
 ; .ONCSTAT(     Reference to a local variable where status
 ;               values are returned.
 ;
 ;   "APIVER")     Version of the CS API
 ;
 ;   "ERROR",      Error Code
 ;     Name)       Symbolic names of error bits (see
 ;                 the INVLDINP^ONCSAPI3 for details)
 ;
 ;   "MSG",
 ;     i)          Error message returned by the CStage_calculate
 ;
 ;   "RC")         Error code returned by the CS web-service
 ;
 ;   "VERSION")    Version of the service
 ;
 ; The ^TMP("ONCSAPI3",$J) global node is used by this function.
 ;
 ; Note: Patch XT*7.3*67 (VistA XML Parser)) is required for this
 ;       API to work.
 ;
 ; Return values:
 ;
 ;       <0  Error Descriptor (see ^ONCSAPI for details)
 ;           For example:
 ;             "-1^Missing input parameters^CALC+4^ONCSAPI"
 ;
 ;        0  Ok
 ;
 ;        1  Probably Ok (warnings)
 ;
CALC(ONCSAPI,INPUT,ONCSTOR,ONCDISP,ONCSTAT) ;
 N ONCCBK,ONCRDAT,ONCSDAT,ONCXML,RC,TMP,URL,X
 D CLEAR^ONCSAPIE()
 S ONCRDAT=$NA(^TMP("ONCSAPI3",$J))
 K ONCDISP,ONCSTAT,ONCSTOR,@ONCRDAT
 F X="T","TDESCR","N","NDESCR","M","MDESCR","AJCC","AJCC7-T","AJCC7-TDESCR","AJCC7-N","AJCC7-NDESCR","AJCC7-M","AJCC7-MDESCR","AJCC7-STAGE","SS1977","SS2000" D
 . S (ONCSTOR(X),ONCDISP(X))=""
 Q:$D(INPUT)<10 $$ERROR^ONCSAPIE(-1)
 ;
 ;--- Get the server URL
 S URL=$$GETCSURL^ONCSAPIU()  Q:URL<0 URL
 ;
 ;--- Prepare the request parameters
 S RC=$$PARAMS^ONCSAPIR("ONCSDAT","CS-CALCULATE",.INPUT)
 Q:RC<0 RC
 ;
 S RC=0  D
 . ;--- Call the web service
 . D:$G(ONCSAPI("DEBUG"))
 . . D ZW^ONCSAPIU("ONCSDAT","*** 'CALCULATE' REQUEST ***")
 . S RC=$$REQUEST^ONCSAPIR(URL,ONCRDAT,"ONCSDAT")  Q:RC<0
 . D:$G(ONCSAPI("DEBUG"))
 . . D ZW^ONCSAPIU(ONCRDAT,"*** 'CALCULATE' RESPONSE ***")
 . ;--- Parse the results
 . D SETCBK(.ONCCBK),EN^MXMLPRSE(ONCRDAT,.ONCCBK,"W")
 . ;--- Check the CS error codes
 . S:$G(ONCXML("RC"))<0 ONCSTAT("RC")=ONCXML("RC")
 . D INVLDINP(.STATUS)
 . ;--- Check for parsing and web-service errors
 . S RC=$$CHKERR^ONCSAPIR(.ONCXML,$NA(ONCSTAT("MSG")))
 ;
 ;--- Cleanup
 K ^TMP("ONCSAPI3",$J)
 Q $S(RC<0:RC,$D(ONCSTAT("MSG"))>1:1,1:0)
 ;
 ;***** COMPILES A LIST OF SYMBOLIC ERROR CODES
 ;
 ; .STATUS       Reference to a local variable where the list
 ;               of invalid input parameters is created.
 ;
INVLDINP(STATUS) ;
 ;;01^ NONFAILMSG    ^
 ;;02^ EXTAJCCFAIL   ^ CS Extension
 ;;03^ NODESAJCCFAIL ^ CS Lymph Nodes
 ;;04^ METSAJCCFAIL  ^ CS Mets at DX
 ;;05^ EXTEVALFAIL   ^ Ext Eval
 ;;06^ NODESEVALFAIL ^ Nodes Eval
 ;;07^ METSEVALFAIL  ^ Mets Eval
 ;;08^ STAGEAJCCFAIL ^ Stage Group
 ;;09^ EXT77FAIL     ^ SEER 77 Ext
 ;;10^ NODES77FAIL   ^ SEER 77 Nodes
 ;;11^ METS77FAIL    ^ SEER 77 Mets
 ;;12^ STAGE77FAIL   ^ SEER Summary Stage 77
 ;;13^ EXT2000FAIL   ^ SEER 2000 Ext
 ;;14^ NODES2000FAIL ^ SEER 2000 Nodes
 ;;15^ METS2000FAIL  ^ SEER 2000 Mets
 ;;16^ STAGE2000FAIL ^ SEER Summary Stage 2000
 ;;17^ SITEFAIL      ^ Primary Site
 ;;18^ HISTFAIL      ^ Histology
 ;
 N ERR,IB,IN,NLST,TMP
 S ERR=+$G(STATUS("ERROR"))  Q:'ERR
 S ERR=$REVERSE($$CNV^XLFUTL(ERR,2))
 ;--- Analyze separate bits of the error code
 F IB=1:1:18  D:$E(ERR,IB)
 . S NLST=$TR($P($T(INVLDINP+IB),U,2)," ")
 . F IN=1:1  S TMP=$P(NLST,",",IN)  Q:TMP=""  D
 . . S STATUS("ERROR",TMP)=""
 Q
 ;
 ;***** SETS THE EVENT INTERFACE ENTRY POINTS
SETCBK(ONCCBK) ;
 ;;CHARACTERS^TEXT^ONCSAPI3
 ;
 D SETCBK^ONCSAPIX(.ONCCBK,"SETCBK^ONCSAPI3")
 Q
 ;
 ;***** TEXT CALLBACK FOR THE SAX PARSER
 ;
 ; TXT           Line of unmarked text
 ;
TEXT(TXT) ;
 N ELMT,L,SECT
 ;--- Individual elements
 S L=$L(ONCXML("PATH"),","),ELMT=$P(ONCXML("PATH"),",",L-1,L)
 I ELMT="detail,MSG"  D  Q
 . S ONCSTAT("MSG",$O(ONCSTAT("MSG"," "),-1)+1)=$TR(TXT,U,"~")
 I ELMT="CS-RESPONSE,APIVER"  D  Q
 . S ONCSTAT("APIVER")=$G(ONCSTAT("APIVER"))_TXT
 I ELMT="CS-RESPONSE,VERSION"  D  Q
 . S ONCSTAT("VERSION")=$G(ONCSTAT("VERSION"))_TXT
 ;--- Sections
 S SECT=$P(ONCXML("PATH"),",",L-1),ELMT=$P(ONCXML("PATH"),",",L)
 I SECT="CS-DISP"  D  Q
 . S ONCDISP(ELMT)=$G(ONCDISP(ELMT))_TXT
 I SECT="CS-STOR"  D  Q
 . S ONCSTOR(ELMT)=$G(ONCSTOR(ELMT))_TXT
 I SECT="detail","ERROR"[ELMT  D  Q
 . S ONCSTAT(ELMT)=$G(ONCSTAT(ELMT))_TXT
 ;--- Default processing
 D TEXT^ONCSAPIX(TXT)
 Q
