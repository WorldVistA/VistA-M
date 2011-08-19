SCAPMC14 ;ALB/REW - Team API's: PTPR ; JUN 30, 1995
 ;;5.3;Scheduling;**41,520**;AUG 13, 1993;Build 26
 ;;1.0
PTPR(SC200,SCDATES,SCPURPA,SCROLEA,SCLIST,SCERR,SCYESCL) ; -- list patients for a pract (scyescl NOT supported)
 ; input:
 ; SC200 = ien of NEW PERSON file(#200) [required]
 ;  SCDATES("BEGIN") = begin date to search (inclusive)
 ;                       [default: TODAY]
 ;        ("END")   = end date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("INCL")  = 1: only use patients who were assigned to
 ;                       team for entire date range
 ;                    0: anytime in date range
 ;                      [default: 1] 
 ;  SCPURPA -array of pointers to team purpose file 403.47
 ;          if none are defined - returns all teams
 ;          if @SCPURPA@('exclude') is defined - exclude listed teams
 ;  SCROLEA-array of pointer to 403.46 (per SCPURPA)
 ;  SCLIST -array name to store list
 ;          [ex. ^TMP("SCPT",$J)]
 ;        
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;  SCYESCL = Boolean to indicate 1=use associated clinics 0=don't
 ;            default=0
 ;
 ;
 ; Output:
 ;  SCLIST() = array of patients
 ;             Format:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of PATIENT file entry
 ;                 2       Name of patient
 ;                 3       IEN of Pt Team Posit Asment if position=source
 ;                 4       Activation Date
 ;                 5       Inactivation Date
 ;                 6       Source 1=Clinic, Null=Position
 ;                 7       IEN of Clinic if clinic=source
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
ST N SCTM,SCPTA,SCPTA0,SCOK,SCX,NODE,TPACT,TPINACT,SCTEMP,SCTP,SCUSR
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 ; -- initialize control variables
 G:'$$OKDATA PRACQ
 ; -- get list of positions for practitioner
 G:'$$TPPR^SCAPMC(SC200,SCDATES,.SCPURPA,.SCROLEA,"SCTEMP",.SCERR) PRACQ
 G:'$G(SCTEMP(0)) PRACQ
 S SCTP=0
 ;get list of patients for each position
 F SCX=1:1 S NODE=$G(SCTEMP(SCX)),SCTP=+NODE Q:'SCTP  D  Q:'SCOK
 .S TPACT=$P(SCTEMP(SCX),U,5)
 .S TPINACT=$P(SCTEMP(SCX),U,6)
 .N SCDTPR
 .S SCDTPR("BEGIN")=$S(TPACT>@SCDATES@("BEGIN"):TPACT,1:@SCDATES@("BEGIN"))
 .S SCDTPR("END")=$S('TPINACT:@SCDATES@("END"),(TPINACT<@SCDATES@("END")):TPINACT,1:@SCDATES@("END"))
 .S SCDTPR("INCL")=@SCDATES@("INCL")
 .S SCOK=$$PTTP^SCAPMC(SCTP,"SCDTPR",.SCLIST,.SCERR)
 .Q:'SCOK
 .Q:'SCYESCL
 .;S SC44=$P($G(^SCTM(404.57,+SCTP,0)),U,9)
 .;Q:'SC44
 .N CNAME,SC44
 .D SETASCL^SCRPRAC2(SCTP,.CNAME,.SC44)
 .N SCCNT S SCCNT=0
 .F  S SCCNT=$O(SC44(SCCNT)) Q:SCCNT=""  S SCOK=$$PTCL^SCAPMC(SC44(SCCNT),"SCDTPR",.SCLIST,.SCERR)
PRACQ Q $G(@SCERR@(0))<1
 ;
OKDATA() ;setup/check variables
 N SCOK
 S SCOK=1
 S SCYESCL=$G(SCYESCL,0)
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 IF '$D(^VA(200,+$G(SC200),0)) D  S SCOK=0
 . S SCPARM("PRACT")=$G(SC200,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 ; -- is it a valid DFN passed (Error # 20001 in DIALOG file)
 IF '$D(^VA(200,+SC200,0)) D   S SCOK=0
 . S SCPARM("PRACT")=SC200
 . D ERR^SCAPMCU1(SCESEQ,20001,.SCPARM,"",.SCERR)
 Q SCOK
 ;
