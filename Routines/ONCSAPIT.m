ONCSAPIT ;Hines OIFO/SG - COLLABORATIVE STAGING (TABLES) ;06/23/10
 ;;2.11;ONCOLOGY;**40,41,47,51**;Mar 07, 1995;Build 65
 ;
 ;--- STRUCTURE OF THE RESPONSE
 ;
 ; <?xml version="1.0" encoding="utf-8"?>
 ; <soap:Envelope
 ;   xmlns:soap="http://www.w3.org/2001/12/soap-envelope"
 ;   soap:encodingStyle="http://www.w3.org/2001/12/soap-encoding">
 ;   <soap:Body>
 ;     <CS-RESPONSE xmlns="http://vista.med.va.gov/oncology">
 ;       <SCHEMA>...</SCHEMA>
 ;       <TABLE>
 ;         <NUMBER>...</NUMBER>
 ;         <PATTERN>...</PATTERN>
 ;         <ROLE>...</ROLE>
 ;         <SUBTITLE>...</SUBTITLE>
 ;         <TITLE>...</TITLE>
 ;         <ROWS>
 ;           <ROW>
 ;             <CODE>...</CODE>
 ;             <DESCR>
 ;               <P>...</P>
 ;               ...
 ;             </DESCR>
 ;             <AC>...</AC>
 ;             ...
 ;           </ROW>
 ;           ...
 ;         </ROWS>
 ;         <NOTES>
 ;           <TN>
 ;             <P>...</P>
 ;             ...
 ;           </TN>
 ;           ...
 ;           <FN>
 ;             <P>...</P>
 ;             ...
 ;           </FN>
 ;           ...
 ;         </NOTES>
 ;       </TABLE>
 ;       ...
 ;     </CS-RESPONSE>
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
 ;***** LOADS THE CS CODE DESCRIPTION
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see the ^ONCSAPI)
 ;
 ; SITE          Primary site
 ; HIST          Histology
 ;
 ; TABLE         Table number (see the ^ONCSAPI routine)
 ; CODE          Primary code of a table row
 ;
 ; ONC8DST       Closed reference of the destination buffer
 ;
 ; Return Values:
 ;        0  Ok
 ;       <0  Error code
 ;
CODEDESC(ONCSAPI,SITE,HIST,TABLE,CODE,ONC8DST) ;
 N I,NODE,RC,ROW,TBLIEN,TMP
 D CLEAR^ONCSAPIE()  K @ONC8DST
 Q:$G(CODE)?." " $$ERROR^ONCSAPIE(-6,,"CODE",$G(CODE))
 ;---
 L +^XTMP("ONCSAPI","TABLES","JOB",$J):5  E  D  Q RC
 . S RC=$$ERROR^ONCSAPIE(-15,,"access control node")
 ;
 S RC=0  D
 . ;--- Get the table IEN
 . S TBLIEN=$$GETCSTBL(.ONCSAPI,SITE,HIST,TABLE)
 . I TBLIEN<0  S RC=TBLIEN  Q
 . S NODE=$NA(^XTMP("ONCSAPI","TABLES",TBLIEN))
 . S CODE=+$G(CODE)
 . ;--- Check the single code
 . S ROW=$G(@NODE@("C",CODE))
 . ;--- Check the interval
 . I ROW'>0  D  I ROW'>0  S RC=$$ERROR^ONCSAPIE(-6,,"CODE",CODE)  Q
 . . S TMP=$O(@NODE@("C",CODE),-1)  Q:TMP=""
 . . S ROW=$G(@NODE@("C",TMP))
 . . S:CODE>$P(ROW,U,2) ROW=0
 . ;--- Load the description
 . M @ONC8DST=@NODE@(+ROW,3)
 ;
 L -^XTMP("ONCSAPI","TABLES","JOB",$J)
 Q $S(RC<0:RC,1:0)
 ;
 ;***** END ELEMENT CALLBACK FOR THE SAX PARSER
 ;
 ; ELMT          Name of the element
 ;
ENDEL(ELMT) ;
 N I,J,L,L2E,L3E,SUBS,TMP
 S L=$L(ONCXML("PATH"),","),L2E=$P(ONCXML("PATH"),",",L-1,L)
 S L3E=$P(ONCXML("PATH"),",",L-2,L)
 D ENDEL^ONCSAPIX(ELMT)
 ;---
 I L2E="CS-RESPONSE,TABLE"  D  Q
 . N NAME,SCHEMA,TABLE
 . S SCHEMA=+$G(ONCXML("SCHEMA")),TABLE=+$P(ONCTBDSC,U,3)
 . S NAME=$P(ONCTBDSC,U,5)
 . I (SCHEMA'>0)!(TABLE'>0)!(NAME="")  K @ONCXML@(ONCTBIEN)  Q
 . S $P(ONCTBDSC,U,2)=SCHEMA
 . ;---
 . S @ONCXML@(ONCTBIEN,0)=$E(ONCTBDSC,1,254)
 . S @ONCXML@("ST",SCHEMA,TABLE)=ONCTBIEN
 ;---
 I L2E="ROW,CODE"  D  Q
 . S $P(@ONCXML@(ONCTBIEN,ONCTBROW,1),U)=ONCXML("ROWCODE")
 . Q:ONCXML("ROWCODE")?."-"
 . S TMP=ONCTBROW
 . S:ONCXML("ROWCODE")["-" $P(TMP,U,2)=+$P(ONCXML("ROWCODE"),"-",2)
 . S @ONCXML@(ONCTBIEN,"C",+ONCXML("ROWCODE"))=TMP
 I L3E="ROW,DESCR,P"  D  Q
 . S J=+$O(@ONCXML@(ONCTBIEN,ONCTBROW,3,""),-1)
 . S I=""
 . F  S I=$O(^UTILITY($J,"W",1,I))  Q:I=""  D
 . . S TMP=$G(^UTILITY($J,"W",1,I,0)),J=J+1
 . . S @ONCXML@(ONCTBIEN,ONCTBROW,3,J)=$$TRIM^XLFSTR(TMP,"R")
 ;---
 I (L3E="NOTES,FN,P")!(L3E="NOTES,TN,P")  D  Q
 . S SUBS=$P(L3E,",",2)
 . S J=+$O(@ONCXML@(ONCTBIEN,SUBS,ONCXML(SUBS),""),-1)
 . S I=""
 . F  S I=$O(^UTILITY($J,"W",1,I))  Q:I=""  D
 . . S TMP=$G(^UTILITY($J,"W",1,I,0)),J=J+1
 . . S @ONCXML@(ONCTBIEN,SUBS,ONCXML(SUBS),J)=$$TRIM^XLFSTR(TMP,"R")
 Q
 ;
 ;***** RETURNS THE TABLE IEN (LOADS THE TABLES IF NECESSARY)
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see the ^ONCSAPI)
 ;
 ; SITE          Primary site
 ; HIST          Histology
 ; TABLE         Table number                    (see the ^ONCSAPI)
 ;
 ; The ^TMP("ONCSAPIT",$J) global node is used by this function.
 ;
 ; Return Values:
 ;       >0  IEN of the table
 ;       <0  Error code
 ;
GETCSTBL(ONCSAPI,SITE,HIST,TABLE) ;
 N ONCTBDSC      ; Descriptor of the table
 N ONCTBIEN      ; IEN of the table
 N ONCTBROW      ; Row number
 ;
 N DST,ONCREQ,ONCRSP,ONCXML,SCHEMA,URL,XHIST,XSITE
 D CLEAR^ONCSAPIE()
 Q:TABLE'>0 $$ERROR^ONCSAPIE(-6,,"TABLE",TABLE)
 ;--- Initialize constants and variables
 S ONCXML=$NA(^XTMP("ONCSAPI","TABLES"))
 S ONCXML("XSITE")=$S(SITE'="":SITE,1:" ")
 S ONCXML("XHIST")=$S(HIST'="":HIST,1:" ")
 S ONCXML("XDISC")=$S(DISCRIM'="":DISCRIM,1:" ")
 ;
 ;--- Check if the schema number is available
 S SCHEMA=+$G(@ONCXML@("SH",ONCXML("XSITE"),ONCXML("XHIST"),ONCXML("XDISC")))
 I SCHEMA'>0  D  Q:SCHEMA<0 SCHEMA
 . S SCHEMA=+$$SCHEMA^ONCSAPIS(.ONCSAPI,SITE,HIST,DISCRIM)
 ;
 ;--- Check if the table is available
 S ONCTBIEN=+$G(@ONCXML@("ST",SCHEMA,TABLE))
 Q:ONCTBIEN>0 ONCTBIEN
 S ONCRSP=$NA(^TMP("ONCSAPIT",$J))  K @ONCRSP
 ;
 ;---  Get the server URL
 S URL=$$GETCSURL^ONCSAPIU()
 ;
 L +@ONCXML@("ST",SCHEMA,TABLE):5
 E  Q $$ERROR^ONCSAPIE(-15,,"local CS table")
 S RC=0  D
 . ;--- Check if the table has become available
 . S ONCTBIEN=+$G(@ONCXML@("ST",SCHEMA,TABLE))  Q:ONCTBIEN>0
 . ;--- Prepare the request data
 . S DST="ONCREQ"
 . D HEADER^ONCSAPIR(.DST,"CS-GET-TABLES")
 . D PUT^ONCSAPIR(.DST,"SCHEMA",SCHEMA)
 . D PUT^ONCSAPIR(.DST,"TABLE",TABLE)
 . D TRAILER^ONCSAPIR(.DST)
 . K DST
 . ;--- Send the request and get the response
 . D:$G(ONCSAPI("DEBUG"))
 . . D ZW^ONCSAPIU("ONCREQ","*** 'TABLE' REQUEST ***")
 . S RC=$$REQUEST^ONCSAPIR(URL,ONCRSP,"ONCREQ")  Q:RC<0
 . D:$G(ONCSAPI("DEBUG"))
 . . D ZW^ONCSAPIU(ONCRSP,"*** 'TABLE' RESPONSE ***")
 . ;--- Load the table into the XTMP global
 . D SETCBK(.CBK),EN^MXMLPRSE(ONCRSP,.CBK,"W")
 . ;--- Check for parsing and web service errors
 . S RC=$$CHKERR^ONCSAPIR(.ONCXML)  Q:RC<0
 L -@ONCXML@("ST",SCHEMA,TABLE)
 ;
 ;--- Cleanup
 K @ONCRSP
 Q $S(RC<0:RC,1:+$G(ONCTBIEN))
 ;
 ;***** SETS THE EVENT INTERFACE ENTRY POINTS
 ;
 ; .CBK          Reference to the destination list
 ;
SETCBK(CBK) ;
 ;;CHARACTERS  ^   TEXT^ONCSAPIT
 ;;ENDELEMENT  ^  ENDEL^ONCSAPIT
 ;;STARTELEMENT^STARTEL^ONCSAPIT
 ;
 D SETCBK^ONCSAPIX(.CBK,"SETCBK^ONCSAPIT")
 Q
 ;
 ;***** START ELEMENT CALLBACK FOR THE SAX PARSER
 ;
 ; ELMT          Name of the element
 ;
 ; .ATTR         List of attributes and their values
 ;
STARTEL(ELMT,ATTR) ;
 N L,L2E,L3E,SUBS,TBLIEN
 D STARTEL^ONCSAPIX(ELMT,.ATTR)
 S L=$L(ONCXML("PATH"),","),L2E=$P(ONCXML("PATH"),",",L-1,L)
 S L3E=$P(ONCXML("PATH"),",",L-2,L)
 ;---
 I L2E="CS-RESPONSE,TABLE"  D  Q
 . S ONCTBIEN=+$O(@ONCXML@(" "),-1)+1
 . S ONCTBDSC="",ONCTBROW=0
 . S (ONCXML("FN"),ONCXML("TN"))=0
 ;---
 I L2E="ROWS,ROW"  D  Q
 . S ONCXML("ROWCODE")="",ONCXML("AC")=1
 . S ONCTBROW=ONCTBROW+1
 ;---
 I L2E="ROW,AC"  S ONCXML("AC")=ONCXML("AC")+1  Q
 I L3E="ROW,DESCR,P"  K ^UTILITY($J,"W")  Q
 ;---
 I (L2E="NOTES,FN")!(L2E="NOTES,TN")  D   Q
 . S SUBS=$P(L2E,",",2),ONCXML(SUBS)=$G(ONCXML(SUBS))+1 ; Note number
 I L3E="NOTES,FN,P"   K ^UTILITY($J,"W")  Q
 I L3E="NOTES,TN,P"   K ^UTILITY($J,"W")  Q
 Q
 ;
 ;***** RETURNS THE TABLE TITLE AND SUBTITLE
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see the ^ONCSAPI)
 ;
 ; SITE          Primary site
 ; HIST          Histology
 ; TABLE         Table number                    (see the ^ONCSAPI)
 ;
 ; Tables other than site specific factors (10-15) usually do not
 ; have subtitles.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  0^Title^Subtitle
 ;
TBLTTL(ONCSAPI,SITE,HIST,TABLE) ;
 N TBLIEN
 ;--- Make sure that table info is loaded
 S TBLIEN=$$GETCSTBL(.ONCSAPI,SITE,HIST,TABLE)  Q:TBLIEN<0 TBLIEN
 ;--- Return the table subtitle
 Q 0_U_$P($G(^XTMP("ONCSAPI","TABLES",TBLIEN,0)),U,5,6)
 ;
 ;***** TEXT CALLBACK FOR THE SAX PARSER
 ;
 ; TXT           Line of unmarked text
 ;
TEXT(TXT) ;
 N I,L,L2E,L3E,TMP
 S L=$L(ONCXML("PATH"),","),L2E=$P(ONCXML("PATH"),",",L-1,L)
 S L3E=$P(ONCXML("PATH"),",",L-2,L)
 ;---
 I L2E="CS-RESPONSE,SCHEMA"  S ONCXML("SCHEMA")=TXT  Q
 ;--- Table descriptor
 I L2E="TABLE,NUMBER"   S $P(ONCTBDSC,U,3)=$P(ONCTBDSC,U,3)_TXT  Q
 I L2E="TABLE,PATTERN"  S $P(ONCTBDSC,U,4)=$P(ONCTBDSC,U,4)_TXT  Q
 I L2E="TABLE,SUBTITLE" S $P(ONCTBDSC,U,6)=$P(ONCTBDSC,U,6)_TXT  Q
 I L2E="TABLE,TITLE"    S $P(ONCTBDSC,U,5)=$P(ONCTBDSC,U,5)_TXT  Q
 ;--- Codes
 I L2E="ROW,AC"  D  Q
 . S $P(@ONCXML@(ONCTBIEN,ONCTBROW,1),U,ONCXML("AC"))=TXT
 I L2E="ROW,CODE"  D  Q
 . S ONCXML("ROWCODE")=ONCXML("ROWCODE")_TXT
 ;--- Row description
 I L3E="ROW,DESCR,P"  D WW(.TXT,70)  Q
 ;--- Notes
 I L3E="NOTES,FN,P"  D WW(.TXT,75)  Q
 I L3E="NOTES,TN,P"  D WW(.TXT,75)  Q
 ;--- Default processing
 D TEXT^ONCSAPIX(TXT)
 Q
 ;
 ;***** REFORMATS THE TEXT AND WRAPS THE LINES
WW(TXT,DIWR) ;
 N CR,DIWF,DIWL,I,ONCI1,ONCI2,LF,X
 S DIWF="|",DIWL=1
 S ONCI1=1,(ONCI2,L)=$L(TXT)
 F  D  Q:ONCI2>L  S ONCI1=ONCI2
 . S ONCI2=$F(TXT,$C(13),ONCI1),(CR,LF)=0
 . I ONCI2>0  S CR=1  S:$A(TXT,ONCI2)=10 LF=1,ONCI2=ONCI2+1
 . E  D
 . . S ONCI2=$F(TXT,$C(10),ONCI1)
 . . I ONCI2>0  S LF=1
 . . E  S ONCI2=L+1
 . F I=ONCI1:1:ONCI2  Q:$E(TXT,I)'=" "
 . S X=$E(TXT,(I+ONCI1)\2,ONCI2-1-CR-LF)
 . D ^DIWP
 Q
 ;
CLEANUP ;Cleanup
 K DISCRIM
