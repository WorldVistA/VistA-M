RORTSK10 ;HCIOFO/SG - REPORT RETRIEVING UTILITIES ; 11/14/06 1:11pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 Q
 ;
 ;***** TRACES THE PATH FROM THE ELEMENT TO THE ROOT
 ;
 ; IEN           IEN of the report element
 ;
 ; .STACK        Reference to a local variable where the path will
 ;               be stored to.
 ;
 ;  STACK                Number of elements in the path (n)
 ;  STACK(i)             Identifiers of the elements (i=1 - the source
 ;                       element; i=n - the root element)
 ;                         ^1: IEN of the report element
 ;                         ^2: Where exactly the rendering process
 ;                             has stopped (see $$XMLSTR for details)
 ;                         ^3: IEN of the text line
 ;
PATH(IEN,STACK) ;
 K STACK  S STACK=0
 F  D  Q:IEN'>0
 . S STACK=STACK+1,STACK(STACK)=IEN
 . S:'$P(IEN,U,2) $P(STACK(STACK),U,2)=4
 . S IEN=$P($G(@RORSRC@(+IEN,0)),U,2)
 Q
 ;
 ;***** RENDERS THE REPORT INTO XML
 ;
 ; ROR8DST       Closed root of the destination buffer
 ;
 ; TASK          Task number
 ;
 ; [.SORT]       Sort modes for the report
 ;
 ; [.FROM]       Where to start/continue the rendering process
 ;                 ^1: IEN of the report element
 ;                 ^2: Where exactly the rendering process has stopped
 ;                     (see the $$XMLSTR function for details)
 ;                 ^3: IEN of the text line (if the 2nd piece = 3)
 ;
 ;               You must not make any assumptions about structure of 
 ;               this parameter (it can be changed at any time without
 ;               warning). The only exception is the IEN of the report
 ;               element. You can assign a positive value to this
 ;               parameter before the call to start the rendering from
 ;               the corresponding element.
 ;
 ; [MAXSIZE]     Either the maximum number of lines to retrieve or
 ;               the maximum size of the output in bytes (append the
 ;               "B" to the number). By default (if $G(MAXSIZE)'>0,)
 ;               the whole report (starting from the point indicated
 ;               by the FROM parameter if it is defined) is retrieved.
 ;
 ;               Examples:
 ;                 500    Retrieve no more than 500 lines
 ;                 4096B  Retrieve no more than 4Kb
 ;
 ;         NOTE: If the "B" suffix is used, the size of the retrieved
 ;               portion of the document can be somewhat bigger than
 ;               MAXSIZE! The last line of the chunk is not truncated
 ;               even if the size will be bigger than MAXSIZE.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of rendered lines
 ;
 ; If the maximum size (MAXSIZE) is reached, the identifiers
 ; of the last item (it has not been added to the output buffer) are
 ; returned via the FROM parameter. The next call of the function will
 ; continue the rendering process starting from that item.
 ;
XMLREP(ROR8DST,TASK,SORT,FROM,MAXSIZE) ;
 N RORNUM        ; Number of rendered lines of the report
 N RORSIZE       ; Size of the output (in bytes)
 N RORSORT       ; Sort modes for the report
 N RORSTACK      ; Path from the FROM element to the root
 N RORSRC        ; Closed root of the source report data
 ;
 N DIR,I,RC,SORTFLD,SORTLST  K @ROR8DST
 S RORSRC=$$ROOT^DILFD(798.87,","_TASK_",",1)
 ;--- Setup the size limits
 S (RORNUM,RORSIZE)=0
 S MAXSIZE=$$UP^XLFSTR($G(MAXSIZE))
 I MAXSIZE["B"  S RORNUM(1)=0,RORSIZE(1)=+MAXSIZE
 E  S RORNUM(1)=+MAXSIZE,RORSIZE(1)=0
 ;--- Setup the starting point
 I $G(FROM)>0  D
 . S:$P(FROM,U,2)'>0 $P(FROM,U,2)=1
 . D PATH(FROM,.RORSTACK)
 E  S I=$$XMLSTR("<?xml version=""1.0""?>")
 ;--- Setup the sorting
 S (FROM,I)=""
 F  S I=$O(SORT(I))  Q:I=""  D
 . S SORTLST=$P(SORT(I),"=")            Q:SORTLST=""
 . S SORTFLD=$P($P(SORT(I),"=",2),":")  Q:SORTFLD=""
 . S DIR=$S($P(SORT(I),":",2)?1"D".1"ESC":-1,1:1)
 . S RORSORT($$XEC^RORTSK11(SORTLST))=$$XEC^RORTSK11(SORTFLD)_U_DIR
 ;--- Get the report
 S RC=$$XMLREPI(0,0)
 S:RC>0 FROM=$P(RC,U,2)_U_$P(RC,U)_U_$P(RC,U,3)
 Q $S(RC'<0:RORNUM,1:RC)
 ;
 ;***** RECURSIVELY RENDERS THE REPORT INTO XML
 ;
 ; PARENT        IEN of the parent element
 ; PELC          Type of the parent element
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of rendered lines has reached the limit
 ;           (see the $$XMLSTR function for details)
 ;
XMLREPI(PARENT,PELC) ;
 N RORIEN        ; IEN of the report element being processed
 ;
 N BUF,DIR,LC,ELEMENT,I,LINE,MODE,RC,SVC,TMP,VAL,XREF
 I $G(PELC)>0  D
 . S BUF=$G(RORSORT(PELC)),SVC=+$P(BUF,U),DIR=$S($P(BUF,U,2)<0:-1,1:1)
 E  S SVC=0,DIR=1
 S XREF=$NA(@RORSRC@("APSV",PARENT,SVC))
 ;--- Use order of creation if the xref is not available
 S:$D(@XREF)<10 XREF=$NA(@RORSRC@("APSV",PARENT,0))
 ;--- Determine the starting point (FROM)
 I $G(RORSTACK)>0  S RC=0  D  Q:RC RC
 . S RORIEN=+$P(RORSTACK(RORSTACK),U)
 . S MODE=+$P(RORSTACK(RORSTACK),U,2)
 . S LINE=+$P(RORSTACK(RORSTACK),U,3)
 . S RORSTACK=RORSTACK-1
 . S I=+$O(@RORSRC@("APSR",RORIEN,SVC,""))
 . I I>0  D
 . . S TMP=+$P($G(@RORSRC@(I,0)),U,3)
 . . S VAL=$$SORTBY^RORDD01(TMP,$G(@RORSRC@(I,1)))
 . E  S VAL=" "
 . S RORIEN=$O(@RORSRC@("APSV",PARENT,SVC,VAL,RORIEN),-DIR)
 . S VAL=$O(@RORSRC@("APSV",PARENT,SVC,VAL),-DIR)
 E  K RORSTACK  S (LINE,MODE)=0,(RORIEN,VAL)=""
 ;--- Render the report elements
 S RC=0
 F  S VAL=$O(@XREF@(VAL),DIR)  Q:VAL=""  D  Q:RC
 . F  S RORIEN=$O(@XREF@(VAL,RORIEN),DIR)  Q:RORIEN=""  D  S MODE=0  Q:RC
 . . S TMP=$G(@RORSRC@(RORIEN,0))  Q:$P(TMP,U,4)
 . . S ELC=+$P(TMP,U)  Q:ELC'>0
 . . S ELEMENT=$P(^ROR(799.31,ELC,0),U)
 . . S I=0,BUF="<"_ELEMENT
 . . ;--- Render the attributes of the element
 . . F  S I=$O(@RORSRC@(RORIEN,2,I))  Q:I'>0  D
 . . . S TMP=$P(@RORSRC@(RORIEN,2,I,0),U)
 . . . S BUF=BUF_" "_$P(^ROR(799.31,TMP,0),U)
 . . . S TMP=$G(@RORSRC@(RORIEN,2,I,1))
 . . . S BUF=BUF_"="""_$$XMLENC^RORUTL03(TMP)_""""
 . . ;--- Append the SORT attribute(s) to a table
 . . D:$D(RORSORT(ELC))
 . . . S TMP=+$P(RORSORT(ELC),U)  Q:TMP'>0
 . . . S BUF=BUF_" SORT="""_$P(^ROR(799.31,TMP,0),U)_""""
 . . . S TMP=+$P(RORSORT(ELC),U,2)
 . . . S:TMP<0 BUF=BUF_" SORTDESC=""1"""
 . . ;--- Leaf element (without children)
 . . I $D(@RORSRC@("APSV",RORIEN))<10  D  Q
 . . . ;--- <ELEMENT...>VALUE</ELEMENT>
 . . . S TMP=$G(@RORSRC@(RORIEN,1))
 . . . I TMP'=""  D:MODE'>2  Q
 . . . . S BUF=BUF_">"_$$XMLENC^RORUTL03(TMP)_"</"_ELEMENT_">"
 . . . . S RC=$$XMLSTR(BUF,2)
 . . . ;--- <ELEMENT.../>
 . . . S I=$O(@RORSRC@(RORIEN,3,0))
 . . . I I'>0  S:MODE'>2 RC=$$XMLSTR(BUF_"/>",2)  Q
 . . . ;--- <ELEMENT...>
 . . . ;    TEXT
 . . . ;--- </ELEMENT>
 . . . I MODE'>3  D  Q:RC
 . . . . S:MODE'>1 RC=$$XMLSTR(BUF_">",1)
 . . . . S:LINE>0 I=LINE,LINE=0
 . . . . F  Q:RC  D  S I=$O(@RORSRC@(RORIEN,3,I))  Q:I'>0
 . . . . . S RC=$$XMLSTR($G(@RORSRC@(RORIEN,3,I,0)),3,I)
 . . . S RC=$$XMLSTR("</"_ELEMENT_">",5)
 . . ;--- Parent element and all children (recursively)
 . . I MODE'>4  D  Q:RC
 . . . I MODE'>1  S RC=$$XMLSTR(BUF_">",1)  Q:RC
 . . . S RC=$$XMLREPI(RORIEN,ELC)
 . . S RC=$$XMLSTR("</"_ELEMENT_">",5)
 . S RORIEN=""
 Q RC
 ;
 ;***** APPENDS THE STRING TO THE OUTPUT BUFFER
 ;
 ; STR           String that should be appended to the document
 ; TYPE          Type of the rendered item
 ; [LINE]        IEN of the text line
 ;
 ; Return Values:
 ;        0  Ok
 ;       >0  Number of rendered lines has reached the limit
 ;             ^1: Where exactly the rendering process has stopped
 ;                   1  Opening tag
 ;                   2  Single value
 ;                   3  Multiline text value
 ;                   4  Nested tag
 ;                   5  Closing tag
 ;             ^2: IEN of the report element
 ;             ^3: IEN of the text line (if the 1st piece = 3)
 ;
XMLSTR(STR,TYPE,LINE) ;
 N SL  S SL=$L(STR)+2
 I RORNUM(1)>0  Q:RORNUM'<RORNUM(1) TYPE_U_RORIEN_U_$G(LINE)
 I RORSIZE(1)>0  Q:RORSIZE'<RORSIZE(1) TYPE_U_RORIEN_U_$G(LINE)
 S RORNUM=RORNUM+1,@ROR8DST@(RORNUM)=STR
 S RORSIZE=RORSIZE+SL
 Q 0
 ;
 ;*****
XREFNODE(TASK,PARENT,SORT) ;
 N NODE
 S NODE=$$ROOT^DILFD(798.87,","_TASK_",",1)
 S SORT=$$XEC^RORTSK11(SORT)
 Q $S(SORT>0:$NA(@NODE@("APSV",PARENT,SORT)),1:"")
