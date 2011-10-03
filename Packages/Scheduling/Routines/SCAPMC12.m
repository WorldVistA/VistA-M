SCAPMC12 ;ALB/REW - Team API's: TPPR ; 2/10/00 8:14am
 ;;5.3;Scheduling;**41,204**;AUG 13, 1993
 ;;1.0
TPPR(SC200,SCDATES,SCPURPA,SCROLEA,SCLIST,SCERR) ; -- positions for a pract
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
 ;  SCROLEA - array of pointers to standard position file 403.46
 ;          if none are defined - returns all positions
 ;          if @SCROLEA@('exclude') is defined - exclude listed roles
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
 ;                 1       IEN of TEAM POSITION File (#404.57)
 ;                 2       Name of Position
 ;                 3       IEN of Team #404.51
 ;                 4       IEN of file #404.59 (Tm Pos History)
 ;                 5       current effective date
 ;                 6       current inactivate date (if any)
 ;                 7       pointer to 403.46 (role)
 ;                 8       Name of Standard Role
 ;                 9       pointer to User Class (#8930)
 ;                10       Name of User Class
 ;                Subscript: "SCTP",SCTM,IEN =""
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
ST N SCTPA,SCTPA,SCTPA0,SCTP,SCR,SCACTHIS,SCTM,SCTPPR,SCPTA
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCBEGIN,SCEND,SCINCL,SCDTS
 ; -- initialize control variables
 G:'$$OKDATA PRACQ
 ; -- loop through position assignment history
 S SCTPA=0
 F  S SCTPA=$O(^SCTM(404.52,"C",SC200,SCTPA)) Q:'SCTPA  D
 .S SCTPA0=$G(^SCTM(404.52,SCTPA,0))
 .S SCTP=+$P(SCTPA0,U,1)
 .Q:'SCTP
 .S SCTM=+$P($G(^SCTM(404.57,SCTP,0)),U,2)
 .Q:'SCTM
 .S SCACTHIS=$$ACTHIST^SCAPMCU2(404.52,SCTP,SCDATES,SCERR,"SCTPPR")
 .Q:'SCACTHIS
 .;
 .;djb/bp Next line fixes NOIS NOP-0499-11252 & ISA-0899-12551
 .Q:$P(SCACTHIS,"^",2)'=SCTPA
 .;
 .S SCP=+$P($G(^SCTM(404.51,+SCTM,0)),U,3)
 .Q:'$$OKARRAY^SCAPU1(.SCPURPA,.SCP)
 .S SCPTA=0
 .S SCR=+$P($G(^SCTM(404.57,SCTP,0)),U,3)
 .Q:'$$OKARRAY^SCAPU1(.SCROLEA,.SCR)
 .D BLD^SCAPMC24(.SCLIST,SCTM,SCTP,SCACTHIS,SCR)
PRACQ Q $G(@SCERR@(0))<1
 ;
OKDATA() ;setup/check variables
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 IF '$D(^VA(200,+$G(SC200),0)) D  S SCOK=0
 . S SCPARM("Practitioner")=$G(SC200,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 ;
 Q SCOK
 ;
