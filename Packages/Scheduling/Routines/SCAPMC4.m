SCAPMC4 ;ALB/REW - Team API's:TMINST ; JUN 30, 1995
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;;1.0
TMINST(SCINST,SCDATES,SCPURPA,SCLIST,SCERR) ; -- list of teams for institution
 ; input:
 ;  SCINST = ien of INSTITUTION file (#4)
 ;  SCDATES("BEGIN") = begin date to search (inclusive)
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
 ;          [ex. ^TMP("SCTM",$J)]
 ;        
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  SCLIST() = array of teams
 ;             Format:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of TEAM file entry
 ;                 2       Name of team
 ;                 3       current effective date
 ;                 4       current inactivate date (if any)
 ;
 ;  SCERR() = Array of DIALOG file messages(errors) .
 ;             Foramt:
 ;  @SCERR@(0) = Number of errors, undefined if none
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;
 ;
 ;    Returned: 1 if ok, 0 if error
 ;
 ; -- initialize control variables
ST N SCTM,SCTM0,SCX,SCPRP,SCTMINST
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 G:'$$OKDATA PRACQ ;check/setup variables
 ;
 ; -- loop through teams for institution
 S SCTM=0
 F  S SCTM=$O(^SCTM(404.51,"AINST",SCINST,SCTM)) Q:'SCTM  D
 .S SCTM0=$G(^SCTM(404.51,SCTM,0))
 .Q:SCTM0=""
 .S SCPRP=$P(SCTM0,U,3)
 .Q:'$$OKARRAY^SCAPU1(.SCPURPA,SCPRP)
 .S ACTHIST=$$ACTHIST^SCAPMCU2(404.58,SCTM,SCDATES,.SCERR,"SCTMINST")
 .Q:ACTHIST'>0
 .D BLDTM(SCTM,SCDATES,ACTHIST,.SCLIST,.SCERR)
PRACQ Q $G(@SCERR@(0))<1
 ;
BLDTM(SCTM,SCDATES,ACTHIST,SCLIST,SCERR) ;build team list
 ; ACTHIST is per $$acthist - dates may be tighter than team activation
 ;      e.g. practitioners' dates will be dates they not team is active
 N SCACT,SCINACT
 S SCACT=+$P(ACTHIST,U,3)
 Q:'SCACT
 S SCINACT=@SCDATES@("END")
 S SCINACT=$S('SCINACT:$P(ACTHIST,U,4),'$P(ACTHIST,U,4):SCINACT,(SCINACT<$P(ACTHIST,U,4)):SCINACT,1:$P(ACTHIST,U,4))
 Q:$D(@SCLIST@("SCTM",SCTM,SCACT))
 S SCN=$G(@SCLIST@(0),0)+1
 S @SCLIST@(0)=SCN
 S @SCLIST@(SCN)=SCTM_U_$P(^SCTM(404.51,SCTM,0),U,1)_U_SCACT_U_SCINACT
 S @SCLIST@("SCTM",SCTM,SCACT,SCN)=""
 Q
OKDATA() ;check/setup variables - return 1 if ok; 0 if error
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 IF '$D(^DIC(4,+$G(SCINST),0)) D  S SCOK=0
 . S SCPARM("INSTITUTION")=$G(SCINST,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 Q SCOK
