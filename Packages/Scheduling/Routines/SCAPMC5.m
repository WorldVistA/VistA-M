SCAPMC5 ;ALB/REW - Team API's:TMAU ; JUL 3, 1995
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;;1.0
TMAU(SCAU,SCDATES,SCPURPA,SCLIST,SCERR) ; -- list of teams for autolink
 ; input:
 ;  SCAU = variable pointer to TEAM AUTOLINK file (#404.56)
 ;         e.g. 10866;VA(200 for the practitioner with duz=10866
 ;  SCDATES("BEGIN") = begin date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("END")   = end date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("INCL")  = 1: only use teams who were active
 ;                       for entire date range
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
 ;  @SCERR@(0)= Number of errors, undefined if none
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;  Returned: 1 if ok, 0 if error
 ;
ST N SCTM,SCTM0,SCPRP,SCTMAU
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 G:'$$OKDATA PRACQ ;check/setup variables
 ;
 ; -- loop through autolink assignments
 S SCTM=0
 F  S SCTM=$O(^SCTM(404.56,"AC",SCAU,SCTM)) Q:'SCTM  D
 .S SCTM0=$G(^SCTM(404.51,SCTM,0))
 .Q:SCTM0=""
 .S SCPRP=$P(SCTM0,U,3)
 .Q:'$$OKARRAY^SCAPU1(.SCPURPA,SCPRP)
 .S ACTHIST=$$ACTHIST^SCAPMCU2(404.58,SCTM,SCDATES,.SCERR,"SCTMAU")
 .IF ACTHIST>0 D
 ..Q:$D(@SCLIST@("SCTM",SCTM,$P(ACTHIST,U,3)))
 ..S SCN=$G(@SCLIST@(0),0)+1
 ..S @SCLIST@(0)=SCN
 ..S @SCLIST@(SCN)=SCTM_U_$P(^SCTM(404.51,SCTM,0),U,1)_U_$P(ACTHIST,U,3,4)
 ..S @SCLIST@("SCTM",SCTM,$P(ACTHIST,U,3),SCN)=""
PRACQ Q $G(@SCERR@(0))<1
OKDATA() ;check/setup variables
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 IF '$D(^SCTM(404.56,"AC",SCAU)) D  S SCOK=0
 . S SCPARM("AUTOLINK")=SCAU
 . D ERR^SCAPMCU1(SCESEQ,4045601,.SCPARM,"",.SCERR)
 ; -- is it a valid SCAU passed (Error # 4045601 in DIALOG file)
 Q SCOK
