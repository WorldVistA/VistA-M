RORRP011 ;HCIOFO/SG - RPC: TASK MANAGER (REPORTS) ; 11/21/05 1:02pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** ADDS A LINE TO THE RESULTS ARRAY
ADD(STR) ;
 S RESULTS(0)=$G(RESULTS(0))+1,RESULTS(RESULTS(0))=STR
 Q
 ;
 ;***** THE REPORT RETRIEVER
 ; RPC: [ROR REPORT RETRIEVE]
 ;
 ; .RORESULT     Reference to a local variable where the report
 ;               lines are returned to.
 ;
 ; TASK          Task number
 ;
 ; [FROM]        Where to start/continue the rendering process
 ;               (see the $$XMLREP^RORTSK10 function for details).
 ;               By default (if $G(FROM)'>0), the rendering starts
 ;               from the beginning of the report.
 ;
 ; [MAXSIZE]     Either the maximum number of lines to retrieve or
 ;               the maximum size of the output in bytes (append the
 ;               "B" to the number). By default (if $G(MAXSIZE)'>0,)
 ;               the whole report (starting from the point indicated
 ;               by the FROM parameter if it is defined) is retrieved.
 ;
 ; [.SORT]       Sort modes for the report
 ;
 ; See the description of the ROR REPORT RETRIEVE remote procedure
 ; for more details.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) node
 ; indicates an error (see the RPCSTK^RORERR procedure for details).
 ;
GETXML(RORESULT,TASK,FROM,MAXSIZE,SORT) ;
 N DST,RC,RORERRDL,TMP  K RORESULT
 D CLEAR^RORERR("GETXML^RORRP039",1)
 ;--- Change the type of the result from the ARRAY to
 ;--- the GLOBAL ARRAY if a long report is suspected.
 S DST="RORESULT",MAXSIZE=$G(MAXSIZE)
 S TMP=$S(MAXSIZE["B":+MAXSIZE,1:MAXSIZE*80)
 I 'TMP!(TMP>16384),$$RTRNFMT^XWBLIB(4,1)  D
 . S (DST,RORESULT)=$$ALLOC^RORTMP()
 ;--- Render the report into XML
 S RC=$$XMLREP^RORTSK10(DST,TASK,.SORT,.FROM,MAXSIZE)
 I RC<0  K @DST  D RPCSTK^RORERR(.RORESULT,RC)  Q
 ;--- Return the starting point for the next call
 S:MAXSIZE>0 @DST@(0)=$G(FROM)
 Q
 ;
 ;***** RETURNS THE REPORT STYLESHEET
 ; RPC: [ROR REPORT STYLESHEET]
 ;
 ; .RESULTS      Reference to a local variable where the XSL
 ;               stylesheet lines are returned to.
 ;
 ; RPTCODE       Code of the report
 ;
 ; [TYPE]        Type of the stylesheet
 ;                 1  Report preview (default)
 ;                 2  Comma-separated output
 ;                 3  Printer output
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the @RESULTS@(0) node
 ; indicates an error (see the RPCSTK^RORERR procedure for details).
 ;
GETXSL(RESULTS,RPTCODE,TYPE) ;
 N DLG,RC,RORERRDL
 D CLEAR^RORERR("GETXSL^RORRP039",1)
 K RESULTS  S RESULTS=$$ALLOC^RORTMP()
 ;--- Check the parameters
 S DLG=7981000,TYPE=$S($G(TYPE)>0:TYPE/1000,1:.001)
 I $G(RPTCODE)>0  S:RPTCODE'>999 DLG=DLG+RPTCODE+TYPE
 ;--- Load the stylesheet into the buffer
 D BLD^DIALOG(DLG,,,RESULTS)
 D:$D(@RESULTS)<10
 . D BLD^DIALOG(7981000+TYPE,,,RESULTS)
 . D:$D(@RESULTS)<10 BLD^DIALOG(7981000,,,RESULTS)
 Q
 ;
 ;***** RETURNS A LIST OF AVAILABLE REPORTS AND THEIR PARAMETERS
 ; ROR: [ROR REPORTS AVAILABLE]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) indicates
 ; an error (see the RPCSTK^RORERR procedure for more details).
 ;
 ; Otherwise, the report descriptors are returned in the RESULTS array
 ; (see the $$RPINFO^RORUTL08 entry point for details).
 ;
 ; RESULTS(0)            Number of available reports
 ;
 ; RESULTS(i)            XML document that describes the reports
 ;
RPAVAIL(RESULTS,REGIEN) ;
 N BUF,CODE,INFO,NAME,NREP,RC,RPLST
 D CLEAR^RORERR("RPAVAIL^RORRP039",1)
 ;--- The the list of available reports
 S RC=$$RPLIST^RORUTL08(.RPLST,REGIEN)
 I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 ;--- Sort the reports alphabetically
 S CODE=0
 F  S CODE=$O(RPLST(CODE))  Q:CODE'>0  D
 . S NAME=$P(RPLST(CODE),U,2)
 . S:NAME'="" RPLST("B",NAME,CODE)=""
 ;---
 K RESULTS
 D ADD($$XMLHDR^MXMLUTL())
 D ADD("<REPORTS>")
 ;--- Get the parameters of the reports
 S NAME="",(NREP,RC)=0
 F  S NAME=$O(RPLST("B",NAME))  Q:NAME=""  D  Q:RC<0
 . S CODE=0
 . F  S CODE=$O(RPLST("B",NAME,CODE))  Q:CODE'>0  D  Q:RC<0
 . . S RC=$$RPINFO^RORUTL08(CODE,.INFO,"E")  Q:RC<0
 . . S NREP=NREP+1
 . . S BUF="REPORT CODE="""_CODE_""" NAME="""_INFO(1)_""""
 . . S BUF=BUF_" IEN="""_INFO(5)_""""
 . . S:'INFO(2) BUF=BUF_" FGP=""1"""
 . . S:'INFO(7) BUF=BUF_" LOCAL=""1"""
 . . S:INFO(12) BUF=BUF_" SHARED_TEMPLATES=""1"""
 . . D ADD("<"_BUF_">")
 . . D:INFO(6)>0 ADD("<INADT>"_(+INFO(6))_"</INADT>")
 . . D ADD("<PANELS>"_INFO(8)_"</PANELS>")
 . . D:INFO(10)?." "1"<PARAMS>"1.E ADD(INFO(10))
 . . D:INFO(11)?." "1"<SORT_MODES>"1.E ADD(INFO(11))
 . . D ADD("</REPORT>")
 ;---
 I RC'<0  D ADD("</REPORTS>")  S RESULTS(0)=NREP
 E  D RPCSTK^RORERR(.RESULTS,RC)
 Q
