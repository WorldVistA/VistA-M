HMPMONL ;asmr-ven/toad&mcglk-dashboard: library ;Aug 25, 2016 21:17:38
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;April 14,2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6526 - routine refactored, August 25, 2016
 ;
UHEAD(STREAM,TITLE) ; update-screen header line
 ; called by:
 ;   U^HMPMOND
 ;   UE^HMPMONE
 ;   UH^HMPMONH
 ;   US^HMPMONS
 ; calls:
 ;   $$CJ^XLFSTR = center-justify
 ;   SETLEFT: set a substring into the left of a string
 ;   SETRIGHT: set a substring into the right of a string
 ;   $$NOW = current date-time in iso format
 ; input:
 ;   STREAM
 ;   TITLE
 ; in symbol table:
 ;   HMPSRVR = server IEN in HMP SUBSCRIPTION (#800000)
 ;   HMPROMPT = current prompt; ^ to exit option; else leave alone
 ; output = header line
 S TITLE=$G(TITLE,"eHMP Dashboard")
 N HEADER,SERVER
 S HEADER=$$CJ^XLFSTR(TITLE,79) ; center
 ;
 S SERVER=$P($G(^HMP(800000,HMPSRVR,0)),U)  ; ^DD(800000,.01,0)="SERVER"
 D SETLEFT(.HEADER,SERVER) ; server name on left
 D SETRIGHT(.HEADER,$$NOW) ; timestamp on right
 ;
 Q HEADER ; return update for screen header line
 ;
 ;
LASTREAM(HMPSRVR) ; last freshness stream entry for this server
 ; called by:
 ;   U^HMPMOND
 ;   UE^HMPMONE
 ;   UH^HMPMONH
 ;   J^HMPMONJ
 ;   US^HMPMONS
 ;
 ; input:
 ;   HMPSRVR = # of server in file HMP SUBSCRIPTION (#800000)
 ;   field Server (.01) in file HMP Subscription (800000)
 ;   ^XTMP(stream)
 ;
 N HEADER,SERVER,STREAM
 S HEADER=$G(^HMP(800000,HMPSRVR,0)) ; subscription hdr
 S SERVER=$P(HEADER,U) ; field Server (.01)
 S STREAM=$O(^XTMP("HMPFS~"_SERVER_"~99999999"),-1) ; get last freshness stream entry
 S:$P(STREAM,"~")'="HMPFS" STREAM=""  ; not a freshness stream, found nothing
 S:$P(STREAM,"~",2)'=SERVER STREAM="" ; nothing for this server
 ;
 Q STREAM  ; return freshness stream
 ;
 ;
SLOTS() ; function, # of available resource device slots
 ;
 ; called by:
 ;   EXTRBATS^HMPMONJ
 ;
 N HMPOUT
 D FIND^DIC(3.54,"",1,"BX","HMP EXTRACT RESOURCE","","","","","HMPOUT")  ; B cross-ref., exact match
 Q $G(HMPOUT("DILIST","ID",1,1)) ; Available Slots
 ;
 ;
FRESHPRE(HMPSUB) ; ^xtmp freshness prefix
 ; called by:
 ;   EXTRBATS^HMPMONL
 Q "HMPFX~"_$P(HMPSUB,U)_"~" ; ^XTMP prefix
 ;
NOW() ;
 ; called by:
 ;   $$UHEAD
 ; calls:
 ;   $$FMTHL7^HMPSTMP($$NOW^XLFDT) - 14 character HL7 date
 ; outputs now in iso format
 N HL7DT S HL7DT=$$FMTHL7^HMPSTMP($$NOW^XLFDT)
 ; e.g. 2016-12-20 09:26:51
 Q $E(HL7DT,1,4)_"-"_$E(HL7DT,5,6)_"-"_$E(HL7DT,7,8)_" "_$E(HL7DT,9,10)_":"_$E(HL7DT,11,12)_":"_$E(HL7DT,13,14)
 ;
SETLEFT(STRING,SUBSTR) ; set a substring into the left of a string
 ; called by:
 ;   $$UHEAD
 ;   $$LINE4^HMPMOND
 ;   EXTRBATS^HMPMONJ
 ; input:
 ;   SUBSTR - substring to set into the left of the string
 ;   STRING - passed by ref.
 ;
 S $E(STRING,1,$L(SUBSTR))=SUBSTR Q
 ;
SETRIGHT(STRING,SUBSTR) ; set a substring into the right of a string
 ; called by:
 ;   $$UHEAD
 ;   $$LINE3^HMPMOND
 ;   $$QLINE1^HMPMOND
 ;
 ; input:
 ;   SUBSTR - substring to set into the right of the string
 ;   STRING - passed by ref.
 ;
 S $E(STRING,$L(STRING)-$L(SUBSTR)+1,$L(STRING))=SUBSTR Q
 ;
TABLHEAD(TABLDEF) ; produce a table header from table definition
 ; called by:
 ;   QHEAD^HMPMOND
 ;   VHEAD^HMPMONV
 ; calls:
 ;   SETCOL: set a column into row of a table
 ; input:
 ;  .TABLDEF(column #,0) = definition of that column
 ; output = table header, based on definition
 ; examples:
 ;   if:
 ;     freshq(1,0)="1^8^item^l"
 ;     freshq(2,0)="11^21^patient^l"
 ;     freshq(3,0)="24^35^transaction^r"
 ;     freshq(4,0)="38^64^type^l"
 ;     freshq(5,0)="67^79^waiting^r"
 ;   $$TABLHEAD^HMPMONL(.freshq) =
 ;     item      patient    transaction  type         . . . waiting
 ;
 N COLUMN,TABLHEAD
 S TABLHEAD=""  ; header to return
 S COLUMN=""  ; each column
 F  S COLUMN=$O(TABLDEF(COLUMN)) Q:COLUMN=""  D SETCOL(.TABLHEAD,.TABLDEF,COLUMN)
 ;
 Q TABLHEAD ; return table header
 ;
 ;
TABLLINE(TABLDEF) ; produce a table line from table definition
 ; called by:
 ;   QHEAD^HMPMOND
 ;   VHEAD^HMPMONV
 ; calls:
 ;   $$COLLENG = length of a column
 ;   $$REPEAT^XLFSTR = repeat a character
 ;   SETCOL: set a column into row of a table
 ; input:
 ;  .TABLDEF(column #,0) = definition of that column
 ; output = table line, based on definition
 ; examples:
 ;   if:
 ;     freshq(1,0)="1^8^item^l"
 ;     freshq(2,0)="11^21^patient^l"
 ;     freshq(3,0)="24^35^transaction^r"
 ;     freshq(4,0)="38^64^type^l"
 ;     freshq(5,0)="67^79^waiting^r"
 ;   $$TABLLINE^HMPMONL(.freshq) =
 ;
 N COLUMN,LENGTH,LINE,TABLLINE
 S TABLLINE="" ; table line to return
 S COLUMN="" ; each column
 F  S COLUMN=$O(TABLDEF(COLUMN)) Q:COLUMN=""  D
 . S LENGTH=$$COLLENG(.TABLDEF,COLUMN)
 . S LINE=$$REPEAT^XLFSTR("-",LENGTH)
 . D SETCOL(.TABLLINE,.TABLDEF,COLUMN,LINE)
 ;
 Q TABLLINE  ; return table line
 ;
 ;
SETCOL(ROW,TABLDEF,COLUMN,VALUE) ; set a column into row of a table
 ; called by:
 ;   $$TABLHEAD
 ;   $$TABLLINE
 ;   $$QROW^HMPMOND
 ;   $$VROW^HMPMONV
 ; calls:
 ;   $$FIELD = fixed-length field with justified value
 ; input:
 ;   TABLDEF(column #,0) = definition of that column, passed by ref.
 ;   COLUMN = column to set, defaults to 1
 ;   VALUE = new value to set into column, defaults to column name
 ;   ROW = row to change, passed by ref.
 ; examples:
 ;   if:
 ;     freshq(1,0)="1^8^item^l"
 ;     freshq(2,0)="11^21^patient^l"
 ;     freshq(3,0)="24^35^transaction^r"
 ;     freshq(4,0)="38^64^type^l"
 ;     freshq(5,0)="67^79^waiting^r"
 ;   and
 ;     qhead = "item    "
 ;     name = "patient"
 ;     column = 2
 ;   after do SETCOL^HMPMONL(.qhead,.freshq,column,name)
 ;     qhead="item      patient    "
 ;
 S ROW=$G(ROW) ; initialize row
 ;
 S COLUMN=$G(COLUMN,1)
 Q:COLUMN=""  ; don't change if bad column selection
 N COLDEF,FIELD,FROM,JUSTIFY,LENGTH,NAME,TO
 S COLDEF=$G(TABLDEF(COLUMN,0)) Q:COLDEF=""  ; don't change if no column definition
 S FROM=$P(COLDEF,U)  Q:'FROM  ; don't change if no from attribute
 S TO=$P(COLDEF,U,2) Q:'TO  ; don't change if no to attribute
 ;
 S LENGTH=1+TO-FROM
 S JUSTIFY=$P(COLDEF,U,4) S:JUSTIFY="" JUSTIFY="l"
 Q:$L(JUSTIFY)'=1  ; single-character code
 Q:"lrc"'[JUSTIFY  ; code must be from set
 ;
 S NAME=$P(COLDEF,U,3)
 S:$D(VALUE)[0 VALUE=NAME  ; $d of zero or ten
 ;
 S FIELD=$$FIELD(VALUE,LENGTH,JUSTIFY)
 S $E(ROW,FROM,TO)=FIELD
 ;
 Q
 ;
COLLENG(TABLDEF,COLUMN) ; length of column
 ; called by:
 ;   $$TABLLINE
 ; input:
 ;  TABLDEF(column #,0) = definition of that column, passed by ref.
 ;   column = column to set, defaults to 1
 ; output = length of column
 ; examples:
 ;   if:
 ;     freshq(1,0)="1^8^item^l"
 ;     freshq(2,0)="11^21^patient^l"
 ;     freshq(3,0)="24^35^transaction^r"
 ;     freshq(4,0)="38^64^type^l"
 ;     freshq(5,0)="67^79^waiting^r"
 ;   $$COLLENG^HMPMONL(.freshq,5) = 13
 ;   $$COLLENG^HMPMONL(.freshq) = 8
 ;   $$COLLENG^HMPMONL(.nonsense,-40) = ""
 ;
 N COLDEF,FROM,LENGTH,TO S LENGTH=""
 D
 . S COLUMN=$G(COLUMN,1) Q:COLUMN=""  ; no length if bad column selection
 . S COLDEF=$G(TABLDEF(COLUMN,0)) Q:COLDEF=""  ; no length if no column definition
 . S FROM=$P(COLDEF,U) Q:'FROM  ; no length if no from attribute
 . S TO=$P(COLDEF,U,2) Q:'TO  ; no length if no to attribute
 . S LENGTH=1+TO-FROM
 ;
 Q LENGTH ; return column length
 ;
 ;
FIELD(VALUE,LENGTH,JUSTIFY) ; fixed-length field with justified value
 ; called by:
 ;   SETCOL
 ; calls:
 ;   $$LJ^XLFSTR = left-justify
 ;   $$RJ^XLFSTR = right-justify
 ;   $$CJ^XLFSTR = center-justify
 ; input:
 ;   VALUE = new value to set into field
 ;   LENGTH = length of field
 ;   JUSTIFY = which way to justify value within field
 ; output = field containing new value
 ; examples:
 ;   $$FIELD^HMPMONL("item",8,"l") = "item    "
 ;   $$FIELD^HMPMONL("waiting",13,"r") = "      waiting"
 ;
 S VALUE=$G(VALUE),LENGTH=$G(LENGTH),JUSTIFY=$G(JUSTIFY,"l")
 ;
 N FIELD S FIELD=""
 S:JUSTIFY="l" FIELD=$$LJ^XLFSTR(VALUE,LENGTH)
 S:JUSTIFY="r" FIELD=$$RJ^XLFSTR(VALUE,LENGTH)
 S:JUSTIFY="c" FIELD=$$CJ^XLFSTR(VALUE,LENGTH)
 ;
 Q FIELD  ; return field with new value
 ;
CHKIOSL ; check for and handle end of page
 ; called by:
 ;   EXTRBATS^HMPMONJ
 ;   VIEWXTMP^HMPMONV
 ;   VIEWTMP^HMPMONV
 ;   VSHOWROW^HMPMONV
 ; calls:
 ;   ENDPAGE: prompt for end-of-page
 ;   FORMFEED: issue form feed to current device or output array
 ; input:
 ;   input from user of current device
 ; output:
 ;   HMPROMPT = current prompt; ^ to exit; else leave alone
 ;   output prompt to user on current device
 ;
 Q:'((IOSL-4)>$Y)  ; not at bottom, exit
 D ENDPAGE  ; prompt for end-of-page
 Q:HMPROMPT=U  ; no formfeed if timeout or ^-escape
 D FORMFEED  ; clear screen
 ;
 Q
 ;
ENDPAGE ; prompt for end-of-page
 ; called by:
 ;   CHKIOSL
 ;   OPTION^HMPMON
 ;   NOSRVR^HMPMONM
 ; calls:
 ;   ^DIR: Fileman Reader Main API, to issue end-of-page prompt
 ; input:
 ;   input from user of current device
 ; output:
 ;   output prompt to user on current device
 ;
 D EN^DDIOL("",,"!")
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DIR(0)="E" ; end-of-page prompt
 D ^DIR  ; prompt user to continue or exit
 ; timeout or '^'
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S HMPROMPT=U ; exit ehmp dashboard
 ;
 Q
 ;
FORMFEED ; issue form feed
 ; called by:
 ;   CHKIOSL
 ;   OPTION^HMPMON
 ;   J^HMPMONJ
 ;   V^HMPMONV
 ; calls: none
 ;
 W @IOF S $X=0 Q  ; reset cursor and $X
 ;
