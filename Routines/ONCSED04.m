ONCSED04 ;Hines OIFO/SG - EDITS API (EDIT INFO)  ; 9/22/06 11:58am
 ;;2.11;ONCOLOGY;**47**;Mar 07, 1995;Build 19
 ;
 ;--- SOAP REQUST TO THE ONCOLOGY WEB SERVICE
 ;
 ; <?xml version="1.0" encoding="utf-8"?>
 ; <soap:Envelope
 ;   xmlns:soap="http://www.w3.org/2001/12/soap-envelope"
 ;   soap:encodingStyle="http://www.w3.org/2001/12/soap-encoding">
 ;   <soap:Body>
 ;     <ED-GET-EDITINFO ver="2.0"
 ;       xmlns="http://vista.med.va.gov/oncology">
 ;       <EDIT-SET> ... </EDIT-SET>
 ;       <EDIT> ... </EDIT>
 ;       <TEXT-WIDTH> ... </TEXT-WIDTH>
 ;     </ED-GET-EDITINFO>
 ;   </soap:Body >
 ; </soap:Envelope>
 ;
 ;--- SOAP RESPONSE FROM THE ONCOLOGY WEB SERVICE
 ;
 ; <?xml version="1.0" encoding="utf-8"?>
 ; <soap:Envelope
 ;   xmlns:soap="http://www.w3.org/2001/12/soap-envelope"
 ;   soap:encodingStyle="http://www.w3.org/2001/12/soap-encoding">
 ;   <soap:Body>
 ;     <ED-RESPONSE xmlns="http://vista.med.va.gov/oncology">
 ;       <NAME> ... </NAME>
 ;       <DESCRIPTION>
 ;         ...
 ;       </DESCRIPTION>
 ;       <HELP>
 ;         ...
 ;       </HELP>
 ;     </ED-RESPONSE>
 ;     <soap:Fault>
 ;       <faultcode> ... </faultcode>
 ;       <faultstring> ... </faultstring>
 ;       <detail>
 ;         <RC> ... </RC>
 ;       </detail>
 ;     </soap:Fault>
 ;   </soap:Body >
 ; </soap:Envelope>
 ;
 Q
 ;
 ;***** END ELEMENT CALLBACK FOR THE SAX PARSER
 ;
 ; ELMT          Name of the element
 ;
ENDEL(ELMT) ;
 N I,L,L2E,TMP
 S L=$L(ONCXML("PATH"),","),L2E=$P(ONCXML("PATH"),",",L-1,L)
 D ENDEL^ONCSAPIX(ELMT)
 ;--- Description line
 I L2E="DESCRIPTION,P"  D  Q
 . S I=$O(@ONCXML@(ONCEDIEN,"D"," "),-1)+1
 . S @ONCXML@(ONCEDIEN,"D",I)=$$TRIM^XLFSTR($G(ONCXML("TEXT")),"R")
 ;--- Help line
 I L2E="HELP,P"  D  Q
 . S I=$O(@ONCXML@(ONCEDIEN,"H"," "),-1)+1
 . S @ONCXML@(ONCEDIEN,"H",I)=$$TRIM^XLFSTR($G(ONCXML("TEXT")),"R")
 Q
 ;
 ;***** GETS EDIT INFO FROM THE SERVER IF NECESSARY
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see the ^ONCSED)
 ;
 ; ESNAME        Edit set name
 ;
 ; EDTNDX        Edit index
 ;
 ; Return Values:
 ;       <0  Error descriptor
 ;       >0  IEN of the edit info
 ;
GETINFO(ONCSAPI,ESNAME,EDTNDX) ;
 N ONCEDESC      ; Edit descriptor
 N ONCEDIEN      ; IEN of the description
 ;
 N DST,ESNSUB,ONCREQ,ONCRSP,ONCXML,SVX,SVY,URL
 S ESNSUB=$E(ESNAME,1,250)
 ;--- Initialize constants and variables
 S ONCXML=$NA(^XTMP("ONCSAPI","EDITS"))
 ;
 ;--- Check if the edit info is available
 S ONCEDIEN=+$G(@ONCXML@("ES",ESNSUB,EDTNDX))
 I ONCEDIEN>0  Q:$D(@ONCXML@(ONCEDIEN))>1 ONCEDIEN
 S ONCRSP=$NA(^TMP("ONCSED04",$J))  K @ONCRSP
 ;
 ;---  Get the server URL
 S URL=$$GETCSURL^ONCSAPIU()
 ;
 D LOCK^DILF($NA(@ONCXML@("ES",ESNSUB,EDTNDX)))
 E  Q $$ERROR^ONCSAPIE(-15,,"local cache")
 S SVX=$X,SVY=$Y
 S RC=0  D
 . ;--- Check if the info has become available
 . S ONCEDIEN=+$G(@ONCXML@("ES",ESNSUB,EDTNDX))
 . I ONCEDIEN>0  Q:$D(@ONCXML@(ONCEDIEN))>1
 . ;
 . ;--- Prepare the request data
 . S DST="ONCREQ"
 . D HEADER^ONCSAPIR(.DST,"ED-GET-EDITINFO")
 . D PUT^ONCSAPIR(.DST,"EDIT-SET",ESNAME)
 . D PUT^ONCSAPIR(.DST,"EDIT",EDTNDX)
 . D PUT^ONCSAPIR(.DST,"TEXT-WIDTH",75)
 . D TRAILER^ONCSAPIR(.DST)
 . K DST
 . ;
 . ;--- Send the request and get the response
 . D:$G(ONCSAPI("DEBUG"))
 . . D ZW^ONCSAPIU("ONCREQ","*** 'ED-GET-EDITDESC' REQUEST ***")
 . S RC=$$REQUEST^ONCSAPIR(URL,ONCRSP,"ONCREQ")  Q:RC<0
 . D:$G(ONCSAPI("DEBUG"))
 . . D ZW^ONCSAPIU(ONCRSP,"*** 'ED-GET-EDITDESC' RESPONSE ***")
 . ;
 . ;--- Parse the response
 . S ONCEDIEN=+$O(@ONCXML@(" "),-1)+1,ONCEDESC=EDTNDX
 . D SETCBK(.CBK),EN^MXMLPRSE(ONCRSP,.CBK,"W")
 . ;--- Check for parsing and web service errors
 . S RC=$$CHKERR^ONCSAPIR(.ONCXML)  Q:RC<0
 . ;
 . ;--- Complete the edit info
 . S @ONCXML@(ONCEDIEN,0)=ONCEDESC
 . S @ONCXML@("ES",ESNSUB,EDTNDX)=ONCEDIEN
 S $X=SVX,$Y=SVY
 L -@ONCXML@("ES",ESNSUB,EDTNDX)
 ;
 ;--- Cleanup
 K @ONCRSP
 Q $S(RC<0:RC,1:ONCEDIEN)
 ;
 ;***** RETURNS THE EDIT DESCRIPTION NODE (LOADS DATA IF NECESSARY)
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see the ^ONCSED)
 ;
 ; ESNAME        Edit set name
 ;
 ; EDTNDX        Edit index
 ;
 ; The ^TMP("ONCSED04",$J) global node is used by this function.
 ;
 ; Return Values:
 ;       <0  Error descriptor
 ;           Closed root of the edit description node
 ;
GETEDESC(ONCSAPI,ESNAME,EDTNDX) ;
 N NODE,RC
 D CLEAR^ONCSAPIE()
 Q:$G(EDTNDX,-1)<0 $$ERROR^ONCSAPIE(-6,,"EDTNDX",$G(EDTNDX))
 S RC=$$GETINFO(.ONCSAPI,ESNAME,EDTNDX)
 Q $S(RC<0:RC,1:$NA(^XTMP("ONCSAPI","EDITS",RC,"D")))
 ;
 ;***** RETURNS THE EDIT HELP NODE (LOADS DATA IF NECESSARY)
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see the ^ONCSED)
 ;
 ; ESNAME        Edit set name
 ;
 ; EDTNDX        Edit index
 ;
 ; The ^TMP("ONCSED04",$J) global node is used by this function.
 ;
 ; Return Values:
 ;       <0  Error descriptor
 ;           Closed root of the edit help node
 ;
GETEDHLP(ONCSAPI,ESNAME,EDTNDX) ;
 N NODE,RC
 D CLEAR^ONCSAPIE()
 Q:$G(EDTNDX,-1)<0 $$ERROR^ONCSAPIE(-6,,"EDTNDX",$G(EDTNDX))
 S RC=$$GETINFO(.ONCSAPI,ESNAME,EDTNDX)
 Q $S(RC<0:RC,1:$NA(^XTMP("ONCSAPI","EDITS",RC,"H")))
 ;
 ;***** SETS THE EVENT INTERFACE ENTRY POINTS
 ;
 ; .CBK          Reference to the destination list
 ;
SETCBK(CBK) ;
 ;;CHARACTERS^ TEXT^ONCSED04
 ;;ENDELEMENT^ENDEL^ONCSED04
 ;
 D SETCBK^ONCSAPIX(.CBK,"SETCBK^ONCSED04")
 Q
 ;
 ;***** TEXT CALLBACK FOR THE SAX PARSER
 ;
 ; TXT           Line of unmarked text
 ;
TEXT(TXT) ;
 N I,L,L2E,TMP
 S L=$L(ONCXML("PATH"),","),L2E=$P(ONCXML("PATH"),",",L-1,L)
 ;--- Text of the edit description or help
 I (L2E="DESCRIPTION,P")!(L2E="HELP,P")  D  Q
 . S ONCXML("TEXT")=$G(ONCXML("TEXT"))_TXT
 ;--- Edit name
 I L2E="ED-RESPONSE,NAME"  S $P(ONCEDESC,U,2)=$P(ONCEDESC,U,2)_TXT  Q
 ;--- Default processing
 D TEXT^ONCSAPIX(TXT)
 Q
