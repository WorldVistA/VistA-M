SCAPMC9 ;ALB/REW - Team API's:PRCL ; JUN 26, 1995
 ;;5.3;Scheduling;**41,112,520**;AUG 13, 1993;Build 26
 ;;1.0
PRCL(SC44,SCDATES,SCPOSA,SCUSRA,SCROLEA,SCLIST,SCERR) ;-- list of practitioners for clinic
 ; input:
 ;  SC44 = ien of CLINIC <FILE#44> [required]
 ;  SCDATES("BEGIN") = begin date to search (inclusive)
 ;                       [default: TODAY]
 ;         ("END")   = end date to search (inclusive)
 ;                       [default: TODAY]
 ;         ("INCL")  = 1: only use pracitioners who were on
 ;                       team for entire date range
 ;                     0: anytime in date range
 ;                      [default: 1] 
 ;  SCPOSA= array of positions to include reverse with scposa('exclude')
 ;  SCUSRA= array of usr classes included reverse with scusra('exclude')
 ;  SCROLEA= array of roles included reverse with SCROLEA('exclude')
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
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
 ;                 10      Inactivation Date for 404.52
 ;                 11      IEN of Position Ass History (404.52)
 ;                 12      IEN of Preceptor Position
 ;                 13      Name of Preceptor Position
 ;  @sclist@('scpr',sc200,sctp,scact,scn)=""
 ;
 ;  SCERR() = Array of DIALOG file messages(errors) .
 ;             Foramt:
 ;  @SCERR@(0) = Number of errors, undefined if none
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;   Returned: 1 if ok, 0 if error
 ;
 ;
ST N SCPOSNM,SCTP,SCPOS0,SCOK,SCND,SCU,SCR,SCPRCL
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 ; -- initialize control variables
 G:'$$OKDATA PRACQ ; check/setup variables
 ; -- loop through team positions
 S SCTP=0
 F  S SCTP=$O(^SCTM(404.57,"E",SC44,SCTP)) Q:SCTP=""  D
 .Q:'$$OKARRAY^SCAPU1(.SCPOSA,SCTP)
 .S SCND=$G(^SCTM(404.57,SCTP,0))
 .S SCU=$P(SCND,U,13)
 .Q:'$$OKUSRCL^SCAPU1(.SCUSRA,SCU)
 .S SCR=$P(SCND,U,3)
 .Q:'$$OKARRAY^SCAPU1(.SCROLEA,.SCR)
 .IF 'SCTP D  Q
 ..S SCPARM("Position")=$G(SCTP,"Undefined")
 ..D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",SCERR)
 .ELSE  D
 ..S SCX=$$ACTHIST^SCAPMCU2(404.52,SCTP,SCDATES,.SCERR,"SCPRCL")
 ..S:SCX X=$$PRTP^SCAPMC8(SCTP,SCDATES,.SCLIST,.SCERR)
PRACQ Q $G(@SCERR@(0))<1
OKDATA() ;check/setup variables - return 1 if ok/ 0 if error
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 ;
 IF '$D(^SC(+$G(SC44),0)) D  S SCOK=0
 . S SCPARM("CLINIC")=$G(SC44,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 Q SCOK
