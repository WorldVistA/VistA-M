ONCSAPIV ;Hines OIFO/SG - ONCOLOGY WEB SERVICE (VERSIONS)  ; 12/7/06 2:25pm
 ;;2.11;ONCOLOGY;**40,47**;Mar 07, 1995;Build 19
 ;
 Q
 ;
 ;***** CHECKS THE VERSION OF THE LOCAL CACHE
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see ^ONCSAPI)
 ;
 ; Return Values:
 ;        0  Ok
 ;       <0  Error code
 ;
CHKVER(ONCSAPI) ;
 N NODE,RC,TMP,VER
 D CLEAR^ONCSAPIE()
 ;--- Get the versions of web-service components
 S VER=$$VERSION(.ONCSAPI)  Q:VER<0 VER
 ;--- Lock the cache
 S NODE=$NA(^XTMP("ONCSAPI"))
 L +@NODE:5  E  Q $$ERROR^ONCSAPIE(-15,,"local cache")
 ;--- Check the version of the local CS table cache
 S TMP=$P(VER,U,2)
 I TMP'="",$G(@NODE@("TABLES"))'=TMP  D  S @NODE@("TABLES")=TMP
 . K @NODE@("TABLES"),@NODE@("SCHEMAS")
 ;--- Check the version of the local edit info cache
 S TMP=$P(VER,U,3)
 I TMP'="",$G(@NODE@("EDITS"))'=TMP  D  S @NODE@("EDITS")=TMP
 . K @NODE@("EDITS")
 ;--- Refresh the cache descriptor
 S TMP=$$FMADD^XLFDT(DT,30)
 S @NODE@(0)=TMP_U_DT_U_"Local Oncology seb-service cache"
 L -@NODE
 Q 0
 ;
 ;***** SETS THE EVENT INTERFACE ENTRY POINTS
 ;
 ; .CBK          Reference to the destination list
 ;
SETCBK(CBK) ;
 ;;CHARACTERS^TEXT^ONCSAPIV
 ;
 D SETCBK^ONCSAPIX(.CBK,"SETCBK^ONCSAPIV")
 Q
 ;
 ;***** TEXT CALLBACK FOR THE SAX PARSER
 ;
 ; TXT           Line of unmarked text
 ;
TEXT(TXT) ;
 N L,L2E
 S L=$L(ONCXML("PATH"),","),L2E=$P(ONCXML("PATH"),",",L-1,L)
 ;--- CS API version
 I L2E="RESPONSE,CS-APIVER"   S ONCXML("CS-APIVER")=TXT   Q
 ;--- EDITS metafile version
 I L2E="RESPONSE,ED-METAVER"  S ONCXML("ED-METAVER")=TXT  Q
 ;--- Oncology web-service version
 I L2E="RESPONSE,VERSION"  S ONCXML("VERSION")=TXT  Q
 ;--- Default processing
 D TEXT^ONCSAPIX(TXT)
 Q
 ;
 ;***** RETURNS THE WEB-SERVICE VERSIONS
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see ^ONCSAPI)
 ;
 ; The ^TMP("ONCSAPIV",$J) global node is used by this function.
 ;
 ; Return Values:
 ;       <0  Error code
 ;           Versions (e.g. "2.00^010300^2.00)
 ;             ^01: Oncology web-service version
 ;             ^02: Version of the CS DLL
 ;             ^03: EDITS metafile version
 ;
VERSION(ONCSAPI) ;
 N CBK,ONCREQ,ONCRSP,ONCXML,RC,URL
 D CLEAR^ONCSAPIE()
 S ONCRSP=$NA(^TMP("ONCSAPIV",$J))  K @ONCRSP
 ;--- Get the server URL
 S URL=$$GETCSURL^ONCSAPIU()
 ;
 S RC=0  D
 . ;--- Prepare the request data
 . S RC=$$PARAMS^ONCSAPIR("ONCREQ","GET-VERSION")         Q:RC<0
 . ;--- Request the DLL version
 . D:$G(ONCSAPI("DEBUG"))
 . . D ZW^ONCSAPIU("ONCREQ","*** 'VERSION' REQUEST ***",1)
 . S RC=$$REQUEST^ONCSAPIR(URL,ONCRSP,"ONCREQ")           Q:RC<0
 . D:$G(ONCSAPI("DEBUG"))
 . . D ZW^ONCSAPIU(ONCRSP,"*** 'VERSION' RESPONSE ***",1)
 . K ONCREQ
 . ;--- Parse the response
 . D SETCBK(.CBK),EN^MXMLPRSE(ONCRSP,.CBK,"W")
 . ;--- Check for parsing and web-service errors
 . S RC=$$CHKERR^ONCSAPIR(.ONCXML)                        Q:RC<0
 . ;--- Check the version numbers
 . I $G(ONCXML("CS-APIVER"))=""   S RC=$$ERROR^ONCSAPIE(-13)  Q
 . I $G(ONCXML("ED-METAVER"))=""  S RC=$$ERROR^ONCSAPIE(-23)  Q
 ;
 ;--- Cleanup
 K @ONCRSP
 I RC'<0  S RC=""  D
 . S $P(RC,U,1)=$G(ONCXML("VERSION"))     ; Web-service
 . S $P(RC,U,2)=$G(ONCXML("CS-APIVER"))   ; CS API
 . S $P(RC,U,3)=$G(ONCXML("ED-METAVER"))  ; EDITS metafile
 Q RC
