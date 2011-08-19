SCAPMC13 ;ALB/REW - Team API's: TMPR ; JUN 30, 1995 [10/22/98 2:10pm]
 ;;5.3;Scheduling;**41,157**;AUG 13, 1993
 ;
TMPR(SC200,SCDATES,SCPURPA,SCLIST,SCERR) ; -- list of teams for a pract
 ; input:
 ; SC200 = ien of NEW PERSON file(#200) [required]
 ; SCDATES("BEGIN") = begin date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("END")   = end date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("INCL")  = 1: only use patients who were assigned to
 ;                       team for entire date range
 ;                    0: anytime in date range
 ;                      [default: 1] 
 ;  SCPURPA -array of pointers to team purpose file 403.47
 ;          if none are defined - returns all teams
 ;          if @SCPURPA@('exclude') is defined - exclude listed teams
 ;  SCLIST -array name to store list
 ;          [ex. ^TMP("SCPT",$J)]
 ;        
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  SCLIST() = array of teams (includes SCTM xref)
 ;             Format:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of TEAM file entry
 ;                 2       Name of team
 ;                 3       IEN of file #404.52 (Pos Assign History)
 ;                 4       current effective date
 ;                 5       current inactivate date (if any)
 ;                 6       pointer to 403.47 (purpose)
 ;                 7       Name of Purpose
 ;                Subscript: "SCTM",SCTM,IEN =""
 ;
 ;  SCERR() = Array of DIALOG file messages(errors) .
 ;  @SCERR@(0) = number of errors, undefined if none
 ;             Format:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;  Returned: 1 if ok, 0 if error
 ;
 ;
ST N SCTM,SCPTA,SCPTA0,SCTP,SCTMPR
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 ; -- initialize control variables
 G:'$$OKDATA PRACQ
 ; -- loop through position assignments (404.52) for pract
 S SCTPA=0
 F  S SCTPA=$O(^SCTM(404.52,"C",SC200,SCTPA)) Q:'SCTPA  D
 .S SCTP=$P($G(^SCTM(404.52,SCTPA,0)),U,1)
 .Q:'SCTP
 .S SCTM=$P($G(^SCTM(404.57,+$G(SCTP),0)),U,2)
 .Q:'SCTM
 .;;bp/djb Fix error due to bad pointers in TEAM field of
 .;;       TEAM POSITION file
 .;;new code begin
 .Q:'$D(^SCTM(404.51,SCTM,0))
 .;;new code end
 .S SCP=$P(^SCTM(404.51,SCTM,0),U,3)
 .;;bp/djb Fix error due to calling rtn not initializing SCPURPA in
 .;;       parameter list. Change line to pass SCPURPA by reference.
 .;;changed code begin
 .Q:'$$OKARRAY^SCAPU1(.SCPURPA,SCP)
 .;;changed code end
 .S ACTHIST=$$ACTHIST^SCAPMCU2(404.52,SCTP,SCDATES,.SCERR,"SCTMPR")
 .Q:'ACTHIST
 .D BLDTM^SCAPMC4(SCTM,SCDATES,ACTHIST,.SCLIST,.SCERR)
PRACQ Q $G(@SCERR@(0))<1
 ;
OKDATA() ;setup/check variables
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 IF '$D(^VA(200,+$G(SC200),0)) D  S SCOK=0
 . S SCPARM("PRACTITIONER")=$G(SC200,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 Q SCOK
 ;
