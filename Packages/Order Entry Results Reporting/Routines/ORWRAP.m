ORWRAP ; ALB/MJK - Background Imaging Report Print Driver ;1/24/95  15:49
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;
PRINT(ORY,ORIO,DFN,ORID)        ; -- print report entry point
 ;  RPC: ORWRA PRINT REPORT
 ;  See RPC definition for details on input and output parameters
 ;
 IF '$$CHK^ORWCSP() G PRINTQ
 ; -- task job
 N TASKDATA
 S TASKDATA("DESC")="Imaging Report Print"
 S TASKDATA("RTN")="DEQUE^ORWRAP"
 D TASK^ORWCSP(.ORY,.ORIO,.DFN,.ORID,.TASKDATA)
PRINTQ Q
 ;
DEQUE ; -- logic to print queued imaging report
 N ROOT,HDRDATA
 ; 
 ; -- retrieve report text
 D RPT^ORWRA(.ROOT,.DFN,.ORID)
 ;
 ; -- print report text
 S HDRDATA("TITLE")="Imaging Report"
 S HDRDATA("DFN")=DFN
 D OUTPUT^ORWCSP(.ROOT,.HDRDATA)
DEQUEQ Q
 ;
