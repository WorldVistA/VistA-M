SCAPMC1 ;ALB/REW - Team API's: PRTM ; JUN 26, 1995
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;;1.0
PRTM(SCTEAM,SCDATES,SCUSRA,SCROLEA,SCLIST,SCERR) ; -- practitioners for team
 ; input:
 ;  SCTEAM = ien of TEAM [required]
 ;  SCDATES("BEGIN") = begin date to search (inclusive)
 ;                       [default: TODAY]
 ;         ("END")   = end date to search (inclusive)
 ;                       [default: TODAY]
 ;         ("INCL")  = 1: only use pracitioners who were on
 ;                       team for entire date range
 ;                     0: anytime in date range
 ;                      [default: 1] 
 ;  SCUSRA = array of usr classes to use/exclude
 ;           if $d(@scusra@('exclude')) -> list to exclude
 ;  SCROLEA = array of roles to use/exclude
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J
 ; Output:
 ;  SCLIST() = array of practitioners
 ;             Format:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of NEW PERSON file entry (#200)
 ;                 2       Name of person
 ;                 3       IEN of TEAM POSITION file (#404.57)
 ;                 4       Name of Position
 ;                 5       IEN OF USR CLASS(#8930) of POSITION (#404.57)
 ;                 6       USR Class Name
 ;                 7       IEN of STANDARD POSITION (#403.46)
 ;                 8       Standard Role (Position) Name
 ;                 9       Activation Date for 404.52 (not 404.59!)
 ;                10       Inactivation Date for 404.52
 ;                11       IEN of Position Ass History (404.52)
 ;                12       IEN of Preceptor Position
 ;                13       Name of Preceptor Position
 ;
 ;  SCERR()  = Array of DIALOG file messages(errors) .
 ;  @SCERR(0)= Number of error(s), UNDEFINED if no errors
 ;             Foramt:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;   Returned: 1 if ok, 0 if error
 ;
 ; -- initialize control variables
 ;
ST N SCPOSNM,SCTP,SCPOS0,SCOK,SCND,SCU,SCR,SCPRTM
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 G:'$$OKDATA PRACQ ; setup/check variables
 ; -- loop through team positions
 S SCTP=0
 F  S SCTP=$O(^SCTM(404.57,"C",SCTEAM,SCTP)) Q:'SCTP  D
 .S SCND=$G(^SCTM(404.57,SCTP,0))
 .S SCU=$P(SCND,U,13)
 .Q:'$$OKUSRCL^SCAPU1(.SCUSRA,.SCU)
 .S SCR=$P(SCND,U,3)
 .Q:'$$OKARRAY^SCAPU1(.SCROLEA,.SCR)
 .Q:'$$ACTHIST^SCAPMCU2(404.52,SCTP,SCDATES,.SCERR,"SCPRTM")
 .Q:'$$PRTP^SCAPMC8(SCTP,SCDATES,.SCLIST,.SCERR)
PRACQ Q $G(@SCERR@(0))<1
OKDATA() ; setup/check variables - return 1 if ok; 0 if error
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK) ; default dates & error array if undefined
 IF '$D(^SCTM(404.51,+$G(SCTEAM),0)) D  S SCOK=0
 . S SCPARM("TEAM")=$G(SCTEAM,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 Q SCOK
