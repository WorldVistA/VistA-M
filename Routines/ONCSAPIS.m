ONCSAPIS ;Hines OIFO/SG - COLLABORATIVE STAGING (SCHEMAS) ;08/12/10
 ;;2.11;ONCOLOGY;**40,51**;Mar 07, 1995;Build 65
 ;
 Q
 ;
 ;***** RETURNS SCHEMA NUMBER AND NAME
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see ^ONCSAPI)
 ;
 ; SITE          Primary site
 ; HIST          Histology
 ;
 ; The ^TMP("ONCSAPIS",$J) global node is used by this function.
 ;
 ; Return Values:
 ;       >0  SchemaNumber^SchemaName
 ;       <0  Error code
 ;
SCHEMA(ONCSAPI,SITE,HIST,DISCRIM) ;
 ;N DST,NODE,ONCREQ,ONCRSP,ONCXML,RC,SCHEMA,SCHNAME,TMP,URL,XHIST,XSITE
 N DISCRIMINATOR,DST,NODE,ONCREQ,ONCRSP,ONCXML,RC,SCHEMA,TMP,URL,XDISC
 N XHIST,XSITE
 D CLEAR^ONCSAPIE()
 ;--- Initialize constants and variables
 S NODE=$NA(^XTMP("ONCSAPI","SCHEMAS"))
 S XSITE=$S(SITE'="":SITE,1:" ")
 S XHIST=$S(HIST'="":HIST,1:" ")
 S XDISC=$S(DISCRIM'="":DISCRIM,1:" ")
 ;--- Check if the schema is available in the local cache
 ;S SCHEMA=+$G(@NODE@("SH",XSITE,XHIST))
 ;
 S SCHEMA=+$G(@NODE@("SH",XSITE,XHIST,XDISC))
 ;
 I SCHEMA>0  D  Q:SCHNAME'="" SCHEMA_U_SCHNAME
 . S SCHNAME=$P($G(@NODE@(SCHEMA)),U)
 S ONCRSP=$NA(^TMP("ONCSAPIS",$J))  K @ONCRSP
 ;--- Get the server URL
 S URL=$$GETCSURL^ONCSAPIU()
 ;
 S RC=0  D
 . ;--- Prepare the request data
 . S DST="ONCREQ"
 . D HEADER^ONCSAPIR(.DST,"CS-GET-SCHEMA")
 . S DISCRIMINATOR=DISCRIM
 . D PUT^ONCSAPIR(.DST,"SITE",SITE)
 . D PUT^ONCSAPIR(.DST,"HIST",HIST)
 . D PUT^ONCSAPIR(.DST,"DISCRIMINATOR",DISCRIMINATOR)
 . D TRAILER^ONCSAPIR(.DST)
 . ;--- Request the schema number
 . D:$G(ONCSAPI("DEBUG"))
 . . D ZW^ONCSAPIU("ONCREQ","*** 'SCHEMA' REQUEST ***",1)
 . S RC=$$REQUEST^ONCSAPIR(URL,ONCRSP,"ONCREQ")            Q:RC<0
 . D:$G(ONCSAPI("DEBUG"))
 . . D ZW^ONCSAPIU(ONCRSP,"*** 'SCHEMA' RESPONSE ***",1)
 . K DST,ONCREQ
 . ;--- Parse the response
 . D SETCBK(.CBK),EN^MXMLPRSE(ONCRSP,.CBK,"W")
 . ;--- Check for parsing and web service errors
 . S RC=$$CHKERR^ONCSAPIR(.ONCXML)                         Q:RC<0
 . ;--- Check the schema number and name
 . S SCHEMA=+$G(ONCXML("SCHEMA"))
 . S SCHNAME=$G(ONCXML("SCHEMA-NAME"))
 . I (SCHEMA'>0)!(SCHNAME="")  S RC=$$ERROR^ONCSAPIE(-14)  Q
 . ;--- Update the local cache
 . S @NODE@(SCHEMA)=SCHNAME
 . S @NODE@("SH",XSITE,XHIST,XDISC)=SCHEMA
 . S @NODE@("N",SCHNAME)=SCHEMA
 ;
 ;--- Cleanup
 K @ONCRSP
 Q $S(RC<0:RC,1:SCHEMA_U_SCHNAME)
 ;
 ;***** SETS THE EVENT INTERFACE ENTRY POINTS
 ;
 ; .CBK          Reference to the destination list
 ;
SETCBK(CBK) ;
 ;;CHARACTERS^TEXT^ONCSAPIS
 ;
 D SETCBK^ONCSAPIX(.CBK,"SETCBK^ONCSAPIS")
 Q
 ;
 ;***** TEXT CALLBACK FOR THE SAX PARSER
 ;
 ; TXT           Line of unmarked text
 ;
TEXT(TXT) ;
 N L,L2E
 S L=$L(ONCXML("PATH"),","),L2E=$P(ONCXML("PATH"),",",L-1,L)
 ;--- Schema number and name
 I L2E="CS-RESPONSE,SCHEMA"  S ONCXML("SCHEMA")=TXT  Q
 I L2E="CS-RESPONSE,SCHEMA-NAME"  S ONCXML("SCHEMA-NAME")=TXT  Q
 ;--- Default processing
 D TEXT^ONCSAPIX(TXT)
 Q
 ;
CLEANUP ;Cleanup
 K SCHNAME
