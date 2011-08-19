ONCXURL ;HCIOFO/SG - HTTP AND WEB SERVICES (URL TOOLS) ; 5/14/04 11:00am
 ;;2.11;ONCOLOGY;**40**;Mar 07, 1995
 ;
 Q
 ;
 ;***** CREATES URL FROM COMPONENTS
 ;
 ; HOST          Host name
 ; [PORT]        Port number (80, by default)
 ; [PATH]        Resource path ("/", by default)
 ;
 ; [.QUERY]      Reference to a local variable containing values of
 ;               the query parameters: QUERY(Name)=Value.
 ;
 ; Return values:
 ;       <0  Error Descriptor
 ;      ...  Resulting URL
 ;
CREATE(HOST,PORT,PATH,QUERY) ;
 N NAME,QSTR,VAL
 S:HOST'["://" HOST="http://"_HOST
 S PORT=$S($G(PORT)>0:":"_(+PORT),1:"")
 ;---
 S (NAME,QSTR)=""
 F  S NAME=$O(QUERY(NAME))  Q:NAME=""  D
 . S VAL=$G(QUERY(NAME))
 . S QSTR=QSTR_"&"_$$ENCODE(NAME)_"="_$$ENCODE(VAL)
 S:QSTR'="" $E(QSTR,1)="?"
 ;---
 Q HOST_PORT_$$PATH($G(PATH)_QSTR)
 ;
 ;***** ENCODES THE STRING
 ;
 ; STR           String to be encoded
 ;
ENCODE(STR) ;
 N CH,I
 F I=1:1  S CH=$E(STR,I)  Q:CH=""  I CH?1CP  D
 . I CH=" "  S $E(STR,I)="+"  Q
 . S $E(STR,I)="%"_$$RJ^XLFSTR($$CNV^XLFUTL($A(CH),16),2,"0"),I=I+2
 Q STR
 ;
 ;***** PARSES THE URL INTO COMPONENTS
 ;
 ; URL           Source URL
 ;
 ; .HOST         Reference to a local variable for the host name
 ; .PORT         Reference to a local variable for the port number
 ; .PATH         Reference to a local variable for the path
 ;
 ; Return values:
 ;       <0  Error Descriptor
 ;        0  Ok
 ;
PARSE(URL,HOST,PORT,PATH) ;
 S:$F(URL,"://") URL=$P(URL,"://",2,999)
 S HOST=$TR($P(URL,"/")," ")
 S PATH=$$PATH($P(URL,"/",2,999))
 S PORT=$P(HOST,":",2),HOST=$P(HOST,":")
 Q:HOST?." " $$ERROR^ONCXERR(-1,,URL)
 S:PORT'>0 PORT=80
 Q 0
 ;
 ;***** DEFAULT PATH PROCESSING (NORMALIZATION)
 ;
 ; PATH          Source path
 ;
PATH(PATH) ;
 N LAST
 ;--- Make sure the path has a leading slash if it
 ;--- is not empty and has no query string
 I $E(PATH,1)'="/"  S:$E(PATH,1)'="?" PATH="/"_PATH
 ;--- Append a trailing slash to the path if it has
 ;--- neither a file name nor a query string
 S LAST=$L(PATH,"/"),LAST=$P(PATH,"/",LAST)
 I LAST'="",LAST'["?",LAST'["."  S PATH=PATH_"/"
 Q PATH
