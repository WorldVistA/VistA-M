SCAPMC3 ;ALB/REW - Team API's:TMPT ; 6/3/99 3:18pm
 ;;5.3;Scheduling;**41,177,297**;AUG 13, 1993
 ;;1.0
TMPT(DFN,SCDATES,SCPURPA,SCLIST,SCERR) ; -- list of teams for a patient
 ; input:
 ;  DFN = ien of PATIENT file [required]
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
 ;                 3       IEN of file #404.42 (Pt Tm Assignment)
 ;                 4       current effective date
 ;                 5       current inactivate date (if any)
 ;                 6       pointer to 403.47 (purpose)
 ;                 7       Name of Purpose
 ;                 8       Is this the pt's PC Team?
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
 ;
ST N SCTM,SCPTA,SCPTA0,SCP,SCTMPT
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 ; -- initialize control variables
 G:'$$OKDATA PRACQ
 ; -- loop through patient team assignments
 S SCTM=0
 F  S SCTM=$O(^SCPT(404.42,"APTTM",DFN,SCTM)) Q:'SCTM  D
 .Q:1>$$ACTHIST^SCAPMCU2(404.58,SCTM,SCDATES,.SCERR,"SCTMPT")
 .S SCP=$P(^SCTM(404.51,SCTM,0),U,3)
 .Q:'$$OKARRAY^SCAPU1(SCPURPA,SCP)
 .S SCPTA=0
 .F  S SCPTA=$O(^SCPT(404.42,"APTTM",DFN,SCTM,SCPTA)) Q:'SCPTA  D
 ..S SCPTA0=$G(^SCPT(404.42,SCPTA,0))
 ..Q:'SCPTA0
 ..Q:'$$DTCHK^SCAPU1(SCBEGIN,SCEND,SCINCL,$P(SCPTA0,U,2),$P(SCPTA0,U,9))
 ..D BLD(.SCLIST,SCPTA,SCPTA0)
PRACQ Q $G(@SCERR@(0))<1
 ;
 ;
BLD(SCLIST,SCPTA,SCPTA0) ; -- build list of patient's teams
 ;
 ; SCLIST  - output array
 ; SCPTA   - ien of pt team assignment
 ; SCPTA0  - 0 node of pt team assignment file
 ; 
 ; this builds the array:
 ;                 1      2      3     4     5        6        7      8 
 ;   sclist(1->n)=sctm^tmname^scpta^effdt^inactdt^p403.47^purpname^pctm?
 ;  
 ;    for each scpta zero node passed to it
 ;    AND a xref  sclist('sctm',sctm,scpta,scn)=""
 N SCEFFDT,SCCNT,SCTM,SCN,SCTMNODE,SCP,SCPC
 S SCTM=$P(SCPTA0,U,3)
 Q:$D(@SCLIST@("SCTM",SCTM,SCPTA))
 S SCN=$G(@SCLIST@(0),0)+1
 S @SCLIST@(0)=SCN
 S SCTMNODE=$G(^SCTM(404.51,SCTM,0)),SCP=$P(SCTMNODE,U,3)
 ;is assignment type=1?
 S SCPC=$P(SCPTA0,U,8)=1
 S @SCLIST@(SCN)=SCTM_U_$P(SCTMNODE,U,1)_U_SCPTA_U_$P(SCPTA0,U,2)_U_$P(SCPTA0,U,9)_U_SCP_U_$S(SCP:$P($G(^SC(403.47,SCP,0)),U,1),1:SCP)_U_SCPC
 S @SCLIST@("SCTM",SCTM,SCPTA,SCN)=""
 Q
OKDATA() ;setup/check variables
 N SCOK
 S SCOK=1
 S SCPURPA=$G(SCPURPA,"")
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 IF $L($G(SCPURPA))&($G(SCPURPA)'?1A1.7AN) D  S SCOK=0
 . S SCPARM("PURPOSE")=$G(SCPURPA,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 IF '$D(^DPT(+$G(DFN),0)) D  S SCOK=0
 . S SCPARM("PATIENT")=$G(PATIENT,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 ; -- is it a valid DFN passed (Error # 20001 in DIALOG file)
 IF '$D(^DPT(+DFN,0)) D   S SCOK=0
 . S SCPARM("PATIENT")=DFN
 . D ERR^SCAPMCU1(SCESEQ,20001,.SCPARM,"",.SCERR)
 Q SCOK
 ;
