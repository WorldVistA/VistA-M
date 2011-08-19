DGSDU ;ALB/TMP - ACRP API UTILITIES ; 12/8/97  15:09
 ;;5.3;Registration;**151**;Aug 13, 1993
 ;;
SCAN(DGINDX,DGVAL,DGFILTER,DGCBK,DGCLOSE,DGQUERY,DGDIR) ; Scan encounters
 ;  *** NOTE *** When using this call, the variable passed as DGQUERY
 ;               must be  newed or killed in the callling program
 ; DGINDX = index name property of the query object 
 ; DGVAL = array of data elements for start/end of search
 ;         DGVAL("DFN") = patient DFN
 ;         DGVAL("BDT") = begin date
 ;         DGVAL("EDT") = end date
 ;         DGVAL("VIS") = encounter file ien
 ; DGFILTER = the executable code to use to screen entries
 ; DGCBK = the executable scan callback code to create the result set
 ; DGCLOSE = Flag that says whether or not to close the QUERY object
 ;         1 = Perform close     0 or null = Do not close object
 ; DGQUERY = the # of the current query, if not a new query. If passed by
 ;          reference and query closed, this variable will be nulled
 ; DGDIR = the direction of the scan (optional)
 ;         null, undefined or FORWARD : Scan forwards
 ;         BACKWARD : Scan backwards
 ;
 N QUERY
 S QUERY=$G(DGQUERY)
 I '$G(QUERY) D
 .D OPEN^SDQ(.DGQUERY) Q:'$G(DGQUERY)
 .D INDEX^SDQ(.DGQUERY,DGINDX,"SET")
 .I $G(DGFILTER)'="" D FILTER^SDQ(.DGQUERY,DGFILTER,"SET")
 .D SCANCB^SDQ(.DGQUERY,DGCBK,"SET")
 I $G(QUERY) D ACTIVE^SDQ(.DGQUERY,"FALSE","SET")
 D SETINDX(.DGQUERY,DGINDX)
 D ACTIVE^SDQ(.DGQUERY,"TRUE","SET")
 S:$G(DGDIR)="" DGDIR="FORWARD"
 D SCAN^SDQ(.DGQUERY,DGDIR)
 I $G(DGCLOSE) D CLOSE(.DGQUERY)
SCANQ Q
 ;
CLOSE(DGQUERY) ; Close the query
 G:'$G(DGQUERY) CLOSEQ
 D CLOSE^SDQ(.DGQUERY)
CLOSEQ Q
 ;
SETINDX(DGQUERY,DGINDX) ;
 I DGINDX="PATIENT/DATE" D PAT,DATE
 I DGINDX="DATE/TIME" D DATE
 I DGINDX="PATIENT" D PAT
 I DGINDX="VISIT" D VIS
 Q
 ;
PAT ; Verify patient
 D PAT^SDQ(.DGQUERY,$G(DGVAL("DFN")),"SET")
 Q
 ;
DATE ; Verify date range
 D DATE^SDQ(.DGQUERY,$G(DGVAL("BDT")),$G(DGVAL("EDT")),"SET")
 Q
 ;
VIS ; Verify visit
 D VISIT^SDQ(.DGQUERY,$G(DGVAL("VIS")),"SET")
 Q
 ;
SCE(DGOE,PC,NODE,ZXERR) ; Returns the specific piece or entire node of the enctr
 ; NODE = the node to return ... if undefined, the 0-node is assumed
 ; If PC is null or undefined, the whole node is returned, otherwise
 ;   just the PC-piece is returned
 ; DGERR = the name of the array where errors should be passed back in
 ;       (pass in quotes I.E.: "DGERR").  If no name passed, errors are
 ;       not returned
 N DGX
 S:$G(NODE)="" NODE=0
 D GETGEN^SDOE(DGOE,"DGX",$G(ZXERR))
 I $G(ZXERR)="" K ^TMP("DIERR",$J)
 S DGX=$S($G(PC):$P($G(DGX(NODE)),U,+PC),1:$G(DGX(NODE)))
 Q DGX
 ;
