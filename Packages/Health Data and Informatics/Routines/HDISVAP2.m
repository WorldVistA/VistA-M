HDISVAP2 ;BPFO/JRP - Application Programmer API(s);03/07/12  07:47
 ;;1.0;HEALTH DATA & INFORMATICS;**7**;Feb 22, 2005;Build 33
 ;
 ; THIS IS A CONTINUATION OF LABXCPT^HDISVAP1
 ;
BUILD(ARRAY,XMLDOC,SUMTXT) ;Build XML document for Lab exceptions
 ; Input: ARRAY - Array containing information about the exception
 ;                (FULL GLOBAL REFERENCE)
 ;        XMLDOC - Array to build XML document into
 ;                 (FULL GLOBAL REFERENCE)
 ;        SUMTXT - Array to build summary text into
 ;                 (FULL GLOBAL REFERENCE) (Optional)
 ;Output: Number of exeptions added to XML document
 ;        @XMLDOC@(1..N,0) = Line N of XML document
 ;        @SUMTXT@(1..N,0) = Line N of summary text
 ;        @SUMTXT@(0) = List of IDs added to XML document
 ;                      (comma separated)
 ; Notes: See LABXCPT^HDISVAP1 for details concerning layout of
 ;        ARRAY and the nodes that are set to denote errors that
 ;        were encountered while building the XML document
 ;      : Existance and validity of required input is assumed
 ;      : XMLDOC & SUMTXT are initialized (ie KILLed) on input
 ;      : XMLDOC & SUMTXT will be KILLed if no exceptions are
 ;        are added to the XML document
 ;
 NEW XCPTTYPE,XCPTNUM,XCPTNODE,XMLNODE,XCPTADD,ERROR
 NEW TAGS,TAGREF,ERRXML,SUMNODE,ERRSUM,TEXT,ERRTXT
 SET TAGS=$NAME(^TMP("HDISVAP1",$JOB,"TAGS"))
 SET SUMTXT=$GET(SUMTXT)
 KILL @XMLDOC,@TAGS IF (SUMTXT'="") KILL @SUMTXT
 SET XMLNODE=1
 SET XCPTADD=0
 SET SUMNODE=1
 ;Initialize array of XML element names
 DO GETTAGS^HDISVAP3(TAGS)
 ;Add XML header to XML document
 SET @XMLDOC@(XMLNODE,0)=$$XMLHDR^XOBVLIB()
 SET XMLNODE=XMLNODE+1
 ;Add root element to XML document
 SET TAGREF=1 DO ADDBEG
 ;Loop through exception type codes
 SET XCPTTYPE=0
 FOR  SET XCPTTYPE=+$ORDER(@ARRAY@(XCPTTYPE)) QUIT:('XCPTTYPE)  DO
 .SET ERROR=0
 .;Remember current locations in XML document & summary text
 .; Needed for errors
 .SET ERRXML=XMLNODE
 .SET ERRSUM=SUMNODE
 .;Unsupported exception type code
 .IF (",1,2,3,"'[XCPTTYPE) DO  QUIT
 ..SET XCPTNUM=0
 ..SET ERRTXT="Exception Type Code "_XCPTTYPE_" not supported"
 ..DO ERR
 ..QUIT
 .;Loop through exceptions
 .SET XCPTNUM=0
 .FOR  SET XCPTNUM=+$ORDER(@ARRAY@(XCPTTYPE,XCPTNUM)) QUIT:('XCPTNUM)  DO
 ..;Remember current locations in XML document & summary text
 ..; Needed for errors
 ..SET ERRXML=XMLNODE
 ..SET ERRSUM=SUMNODE
 ..;Add begin tag to XML document
 ..SET TAGREF=2 DO ADDBEG
 ..;Build contents of XML document (also creates summary text)
 ..DO ADMIN QUIT:(ERROR)
 ..DO SNOMED QUIT:(ERROR)
 ..DO RSLTN QUIT:(ERROR)
 ..DO REFLAB QUIT:(ERROR)
 ..;Separator for summary text
 ..IF (SUMTXT'="") DO
 ...SET TEXT="" SET $PIECE(TEXT,"= ",40)="="
 ...DO SUMADD^HDISVAP3(TEXT,SUMTXT,.SUMNODE)
 ...DO SUMADD^HDISVAP3(" ",SUMTXT,.SUMNODE)
 ..;Add end tag to XML document
 ..SET TAGREF=2 DO ADDEND
 ..;Increment counter of exceptions added to XML document
 ..SET XCPTADD=XCPTADD+1
 ..;Add ID to list of IDs in summary text
 ..IF (SUMTXT'="") DO SUMID^HDISVAP3(SUMTXT,$NAME(@ARRAY@(XCPTTYPE,XCPTNUM,"SA")))
 ..QUIT
 .QUIT
 ;End root element in XML document
 SET TAGREF=1 DO ADDEND
 ;No exceptions added to XML document - delete it & summary text
 IF ('XCPTADD) KILL @XMLDOC IF (SUMTXT'="") KILL @SUMTXT
 ;Done - clean up and quit
 KILL @TAGS
 QUIT XCPTADD
 ;
ADMIN ;Administrative data
 NEW NODE,TMP,DATA,ARRTYPE,DELIM,TEXT
 SET ERROR=0
 ;Add begin tag
 SET TAGREF=3 DO ADDBEG
 ;Facility number
 SET:('$$GETFAC^HDISVF07(,.TEXT)) TEXT=$$FACPTR^HDISVF01()
 SET TEXT=$PIECE($$NS^XUAF4(TEXT),"^",2)
 IF (TEXT="") SET TEXT=$$FACNUM^HDISVF01()
 IF (TEXT="") DO  QUIT
 .SET ERRTXT="Unable to determine current facility number"
 .DO ERR
 .QUIT
 SET TAGREF=3.01
 DO ADD
 ;Facility domain/IP
 SET:('$$GETDIP^HDISVF07(,.TEXT)) TEXT=$GET(^XMB("NETNAME"))
 IF (TEXT="") DO  QUIT
 .SET ERRTXT="Unable to determine MailMan domain for this location"
 .DO ERR
 .QUIT
 SET TAGREF=3.02
 DO ADD
 ;System type of facility
 IF ('$$GETTYPE^HDISVF07(,,.TEXT)) DO
 .SET TEXT=$$PROD^XUPROD()
 .SET TEXT=$SELECT(TEXT:"PRODUCTION",1:"TEST")
 IF (TEXT="") DO  QUIT
 .SET ERRTXT="Unable to determine if this is a production or test system"
 .DO ERR
 .QUIT
 SET TAGREF=3.03
 DO ADD
 ;Exception type
 SET TEXT=XCPTTYPE
 SET TAGREF=3.04
 DO ADD
 ;Copy into working array
 SET DELIM="^"
 SET NODE=$GET(@ARRAY@(XCPTTYPE,XCPTNUM))
 DO PRSENODE
 ;Trasaction number
 SET TEXT=$GET(DATA(1))
 IF (TEXT="") DO  QUIT
 .SET ERRTXT="Transaction Number does not have a value"
 .DO ERR
 .QUIT
 SET TAGREF=3.05
 DO ADD
 ;Time stamp (convert to XML)
 SET TEXT=$GET(DATA(2))
 IF (TEXT="") DO  QUIT
 .SET ERRTXT="Time Stamp of exception does not have a value"
 .DO ERR
 .QUIT
 SET TEXT=$$FMTXML^HDISVU01(TEXT,0,1)
 SET TAGREF=3.06
 DO ADD
 ;Exception text
 SET TEXT=$GET(@ARRAY@(XCPTTYPE,XCPTNUM,"TXT"))
 SET TAGREF=3.07
 DO ADD
 ;Add end tag
 SET TAGREF=3 DO ADDEND
 ;Summary text
 IF (SUMTXT'="") DO SUMADMIN^HDISVAP3(SUMTXT,XCPTTYPE,.DATA,.SUMNODE)
 QUIT
 ;
SNOMED ;SNOMED extract data
 NEW NODE,SPOT,DATA,ARRTYPE,DELIM,TEXT
 SET ERROR=0
 ;Add begin tag
 SET TAGREF=4 DO ADDBEG
 ;Determine array format
 SET ARRTYPE=$DATA(@ARRAY@(XCPTTYPE,XCPTNUM,"SA"))
 ;Primary and alternate format used - throw error
 IF ARRTYPE=11 DO  QUIT
 .SET ERRTXT="Primary & alternate input formats used"
 .DO ERR
 .QUIT
 ;Primary format used
 IF ARRTYPE=1 DO
 .;Copy into working array
 .SET DELIM="|"
 .SET NODE=$GET(@ARRAY@(XCPTTYPE,XCPTNUM,"SA"))
 .DO PRSENODE
 .QUIT
 ;Alternate format used
 IF ARRTYPE=10 DO
 .;Copy into working array
 .KILL DATA
 .MERGE DATA=@ARRAY@(XCPTTYPE,XCPTNUM,"SA")
 .QUIT
 ;Loop through data and add to document
 SET NODE=0
 FOR  SET NODE=+$ORDER(DATA(NODE)) QUIT:('NODE)  DO
 .SET TEXT=DATA(NODE)
 .SET TAGREF=4+(NODE*.01)
 .DO ADD
 .QUIT
 ;Add end tag
 SET TAGREF=4 DO ADDEND
 ;Summary text
 IF (SUMTXT'="") DO SUMSNOMD^HDISVAP3(SUMTXT,.DATA,.SUMNODE)
 QUIT
 ;
RSLTN ;Resolution data
 NEW NODE,SPOT,DATA,ARRTYPE,DELIM,TEXT
 SET ERROR=0
 ;Add begin tag
 SET TAGREF=5 DO ADDBEG
 ;Resolution data sent to site (load exceptions only)
 IF (XCPTTYPE=1) DO  QUIT:(ERROR)
 .;Determine array format
 .SET ARRTYPE=$DATA(@ARRAY@(XCPTTYPE,XCPTNUM,"RD"))
 .;Primary and alternate format used - throw error
 .IF ARRTYPE=11 DO  QUIT
 ..SET ERRTXT="Primary & alternate input formats used"
 ..DO ERR
 ..QUIT
 .;Primary format used
 .IF ARRTYPE=1 DO
 ..;Copy into working array
 ..SET DELIM="|"
 ..SET NODE=$GET(@ARRAY@(XCPTTYPE,XCPTNUM,"RD"))
 ..DO PRSENODE
 ..QUIT
 .;Alternate format used
 .IF ARRTYPE=10 DO
 ..;Copy into working array
 ..KILL DATA
 ..MERGE DATA=@ARRAY@(XCPTTYPE,XCPTNUM,"RD")
 ..QUIT
 .;Loop through data and add to document
 .SET NODE=0
 .FOR  SET NODE=+$ORDER(DATA(NODE)) QUIT:('NODE)  DO
 ..SET TEXT=DATA(NODE)
 ..SET TAGREF=5+(NODE*.01)
 ..DO ADD
 ..QUIT
 .QUIT
 ;Doesn't apply to exception type - send empty elements
 IF (XCPTTYPE'=1) DO
 .SET TEXT=""
 .FOR TAGREF=5.01:.01:5.06 DO ADD
 .QUIT
 ;Add end tag
 SET TAGREF=5 DO ADDEND
 QUIT
 ;
REFLAB ;Reference lab data
 NEW NODE,DATA,ARRTYPE,DELIM,TEXT
 SET ERROR=0
 ;Add begin tag
 SET TAGREF=6 DO ADDBEG
 ;Reference lab data (reference lab exceptions only)
 IF (XCPTTYPE=2) DO  QUIT:(ERROR)
 .;Determine array format
 .SET ARRTYPE=$DATA(@ARRAY@(XCPTTYPE,XCPTNUM,"RL"))
 .;Primary and alternate format used - throw error
 .IF ARRTYPE=11 DO  QUIT
 ..SET ERRTXT="Primary & alternate input formats used"
 ..DO ERR
 ..QUIT
 .;Primary format used
 .IF ARRTYPE=1 DO
 ..;Copy into working array
 ..SET DELIM="^"
 ..SET NODE=$GET(@ARRAY@(XCPTTYPE,XCPTNUM,"RL"))
 ..DO PRSENODE
 ..QUIT
 .;Alternate format used
 .IF ARRTYPE=10 DO
 ..;Copy into working array
 ..KILL DATA
 ..MERGE DATA=@ARRAY@(XCPTTYPE,XCPTNUM,"RL")
 ..QUIT
 .;Lab type code
 .SET TEXT=$GET(DATA(1))
 .IF (TEXT="") DO  QUIT
 ..SET ERRTXT="Location Type Code of reference lab does not have a value"
 ..DO ERR
 ..QUIT
 .IF (",1,2,3,4,5,6,"'[TEXT) DO  QUIT
 ..SET ERRTXT="Location Type Code of reference lab does not have a valid value"
 ..DO ERR
 ..QUIT
 .SET TAGREF=6.01
 .DO ADD
 .;Lab station number
 .SET TEXT=$GET(DATA(2))
 .IF (TEXT="") DO  QUIT
 ..SET ERRTXT="Location Number of reference lab does not have a value"
 ..DO ERR
 ..QUIT
 .SET TAGREF=6.02
 .DO ADD
 .;Lab name
 .SET TEXT=$GET(DATA(3))
 .IF (TEXT="") DO  QUIT
 ..SET ERRTXT="Location Name of reference lab does not have a value"
 ..DO ERR
 ..QUIT
 .SET TAGREF=6.03
 .DO ADD
 .;OBX-3
 .SET TEXT=$GET(@ARRAY@(XCPTTYPE,XCPTNUM,"OBX",3))
 .SET TAGREF=6.04
 .DO ADD
 .;OBX-5
 .SET TEXT=$GET(@ARRAY@(XCPTTYPE,XCPTNUM,"OBX",5))
 .SET TAGREF=6.05
 .DO ADD
 .;Summary text
 .IF (SUMTXT'="") DO SUMRFLAB^HDISVAP3(SUMTXT,.DATA,.SUMNODE)
 .QUIT
 ;Doesn't apply to exception type - send empty elements
 IF (XCPTTYPE'=2) DO
 .SET TEXT=""
 .FOR TAGREF=6.01:.01:6.05 DO ADD
 .QUIT
 ;Add end tag
 SET TAGREF=6 DO ADDEND
 QUIT
 ;
ADD ;Add text to XML document
 NEW TAGNAME
 ;Get element name
 SET TAGNAME=$GET(@TAGS@(TAGREF))
 IF (TAGNAME="") QUIT
 ;Add text
 DO ADD^HDISVAP3(TEXT,TAGNAME,XMLDOC,.XMLNODE)
 QUIT
 ;
ADDBEG ; Add beginning tag to XML document
 NEW TAGNAME
 ;Get element name
 SET TAGNAME=$GET(@TAGS@(TAGREF))
 IF (TAGNAME="") QUIT
 ;Add beginning tag
 DO ADDBEG^HDISVAP3(TAGNAME,XMLDOC,.XMLNODE)
 QUIT
 ;
ADDEND ;Add ending tag to XML document
 NEW TAGNAME
 ;Get element name
 SET TAGNAME=$GET(@TAGS@(TAGREF))
 IF (TAGNAME="") QUIT
 ;Add closing tag
 DO ADDEND^HDISVAP3(TAGNAME,XMLDOC,.XMLNODE)
 QUIT
 ;
PRSENODE ;Parse delimited data in NODE into individual pieces
 NEW LOOP
 KILL DATA
 FOR LOOP=1:1:$LENGTH(NODE,DELIM) DO
 .SET DATA(LOOP)=$PIECE(NODE,DELIM,LOOP)
 QUIT
 ;
ERR ;Error found
 NEW X
 ;Remove data from XML document
 FOR X=ERRXML:1:XMLNODE KILL @XMLDOC@(X)
 ;Remove data from summary text
 IF (SUMTXT'="") DO
 .FOR X=ERRSUM:1:SUMNODE KILL @SUMTXT@(X)
 ;Log exception
 IF ($GET(XCPTNUM)) SET @ARRAY@("ERROR",XCPTTYPE,XCPTNUM)=ERRTXT
 IF ('$GET(XCPTNUM)) SET @ARRAY@("ERROR",XCPTTYPE)=ERRTXT
 ;Reset insertion points
 SET XMLNODE=ERRXML
 SET SUMNODE=ERRSUM
 ;Set error flag
 SET ERROR=1
 QUIT
