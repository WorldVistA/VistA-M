ONCSAPIX ;Hines OIFO/SG - COLLABORATIVE STAGING (XML TOOLS)  ; 8/11/06 8:11am
 ;;2.11;ONCOLOGY;**40,47**;Mar 07, 1995;Build 19
 ;
 ; ONCXML -------------- DESCRIPTOR FOR THE XML PARSING
 ;
 ; ONCXML(               Closed root of the destination buffer
 ;
 ;   "ERR")              Number of parsing errors
 ;
 ;   "FAULTCODE")        SOAP error code
 ;   "FAULTSTRING")      SOAP error description
 ;
 ;   "PATH")             Path to the current XML tag
 ;
 ;   "RC")               Error code returned by the web-service
 ;
 ;   "TI")               Number of the current text line of
 ;                       the current tag value
 ;
 ;   "TEXT")             Buffer for the current tag text
 ;
 Q
 ;
 ;***** DUMMY CALLBACKS FOR THE SAX PARSER
DUMMY(DUMMY1,DUMMY2,DUMMY3) ;
DUMMY1 Q
 ;
 ;***** END ELEMENT CALLBACK FOR THE SAX PARSER
 ;
 ; ELMT          Name of the element
 ;
ENDEL(ELMT) ;
 S ONCXML("PATH")=$P(ONCXML("PATH"),",",1,$L(ONCXML("PATH"),",")-1)
 Q
 ;
 ;***** ERROR CALLBACK FOR THE SAX PARSER
 ;
 ; .ERR          Reference to a local variable containing
 ;               informations about the error
 ;
ERROR(ERR) ;
 N ERRCODE,ONCINFO,TMP
 I ERR("SEV")  D
 . S ERRCODE=-4,ONCXML("ERR")=$G(ONCXML("ERR"))+1
 E  S ERRCODE=-3
 ;--- Prepare message details
 S TMP=$P("Warning^Validation Error^Conformance Error",U,ERR("SEV")+1)
 S ONCINFO(1)=TMP_" in line #"_ERR("LIN")_" (position #"_ERR("POS")_")"
 S ONCINFO(2)=$TR(ERR("XML"),$C(9,10,13)," ")
 ;--- Record the error message
 D STORE^ONCSAPIE(ERRCODE_U_$TR(ERR("MSG"),U,"~"),"ONCINFO")
 Q
 ;
 ;***** SETS THE EVENT INTERFACE ENTRY POINTS
 ;
 ; .CBK          Reference to the destination list
 ;
SETCBK(CBK,CBKTBL) ;
 ;;CHARACTERS   ^    TEXT^ONCSAPIX
 ;;COMMENT      ^   DUMMY^ONCSAPIX
 ;;DOCTYPE      ^   DUMMY^ONCSAPIX
 ;;ENDDOCUMENT  ^  DUMMY1^ONCSAPIX
 ;;ENDELEMENT   ^   ENDEL^ONCSAPIX
 ;;ERROR        ^   ERROR^ONCSAPIX
 ;;EXTERNAL     ^   DUMMY^ONCSAPIX
 ;;NOTATION     ^   DUMMY^ONCSAPIX
 ;;PI           ^   DUMMY^ONCSAPIX
 ;;STARTDOCUMENT^STARTDOC^ONCSAPIX
 ;;STARTELEMENT ^ STARTEL^ONCSAPIX
 ;
 N I,NAME,TMP,XGET  K CBK
 D:$G(CBKTBL)'=""
 . S XGET(2)="S TMP=$T("_$P(CBKTBL,"^")_"+I^"_$P(CBKTBL,"^",2)_")"
 S XGET(1)="S TMP=$T(SETCBK+I)"
 ;---
 S XGET=""
 F  S XGET=$O(XGET(XGET))  Q:XGET=""  D
 . F I=1:1  X XGET(XGET)  S TMP=$TR($P(TMP,";;",2)," ")  Q:TMP=""  D
 . . S NAME=$P(TMP,U),CBK(NAME)=$P(TMP,U,2,3)
 Q
 ;
 ;***** START DOCUMENT CALLBACK FOR THE SAX PARSER
STARTDOC ;
 S ONCXML("PATH")="",ONCXML("ERR")=0
 Q
 ;
 ;***** START ELEMENT CALLBACK FOR THE SAX PARSER
 ;
 ; ELMT          Name of the element
 ;
 ; .ATTR         List of attributes and their values
 ;
STARTEL(ELMT,ATTR) ;
 S ONCXML("PATH")=ONCXML("PATH")_$S(ONCXML("PATH")'="":",",1:"")_ELMT
 S ONCXML("TI")=1  K ONCXML("TEXT")
 Q
 ;
 ;***** TEXT CALLBACK FOR THE SAX PARSER
 ;
 ; TXT           Line of unmarked text
 ;
TEXT(TXT) ;
 I ONCXML("PATH")?1.E1"Fault,faultcode"  D  Q
 . S ONCXML("FAULTCODE")=$G(ONCXML("FAULTCODE"))_TXT
 I ONCXML("PATH")?1.E1"Fault,faultstring"  D  Q
 . S ONCXML("FAULTSTRING")=$G(ONCXML("FAULTSTRING"))_TXT
 I ONCXML("PATH")?1.E1"Fault,detail,RC"  D  Q
 . S ONCXML("RC")=$G(ONCXML("RC"))_TXT
 Q
