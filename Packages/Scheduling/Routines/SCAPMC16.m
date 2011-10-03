SCAPMC16 ;ALB/CMM - TEAM/CLINIC APIs ;03/19/96
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;
TMCL(SCCLN,SCDATES,SCLIST,SCERR) ;  -- list of teams for a clinic
 ; input:
 ; SCCLN = ien of HOSPITAL LOCATION <FILE#44> [required]
 ; SCDATES("BEGIN") = begin date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("END")   = end date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("INCL")  = 1: only use patients who were assigned to
 ;                       team for entire date range
 ;                    0: anytime in date range
 ;                      [default: 1] 
 ;  SCLIST -array name to store list
 ;          [ex. ^TMP("SCPT",$J)]
 ;        
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  SCLIST() = array of positions (includes SCTP xref)
 ;             Format:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of Team #404.51
 ;                 2       Team Name
 ;                Subscript: "SCTP",SCTM,IEN =""
 ;
 ;  SCERR() = Array of errors
 ;  @SCERR@(0) = number of errors, undefined if none
 ;             Format:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       error description
 ;  Returned: 1 if ok, 0 if error
 ;
ST ;
 N OKAY,NODE,ENT,PCLIST,ERR2,CNT,TIEN
 I '$D(SCCLN)!('$D(SCLIST)) S @SCERR@(0)="undefined variables" Q 0
 I '$D(SCERR) Q 0
 ;
 S PCLIST="PCLST",ERR2="ERROR2"
 S OKAY=$$TPCL^SCAPMC30(SCCLN,.SCDATES,"","","","",.PCLIST,.ERR2)
 ;  ^ positions for a clinic SCCLN
 I 'OKAY S @SCERR@(0)="error in TPCL^SCAPMC30 call"
 Q:'OKAY 0
 ;
 S (CNT,ENT)=0
 F  S ENT=$O(@PCLIST@(ENT)) Q:ENT=""!(ENT'?.N)  D
 .S NODE=$G(@PCLIST@(ENT))
 .S TIEN=+$P(NODE,"^",3) ;team ien
 .I $D(@SCLIST@("SCTP",TIEN)) Q
 .;unique entries only
 .S CNT=CNT+1
 .S @SCLIST@(CNT)=TIEN ;team ien
 .S @SCLIST@("SCTP",TIEN,CNT)=""
 .S $P(@SCLIST@(CNT),"^",2)=$P($G(^SCTM(404.51,TIEN,0)),"^") ;team name
 S @SCLIST@(0)=CNT
 Q 1
