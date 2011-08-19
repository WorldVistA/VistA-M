SCAPMC10 ;ALB/REW - Team API's: PRPT ; JUN 26, 1995
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;;1.0
PRPT(DFN,SCDATES,SCPOSA,SCUSRA,SCROLEA,SCPURPA,SCLIST,SCERR,SCYESCL) ; -- practs for patient (No support for scyescl)
 ; input:
 ;  DFN = ien of PATIENT <FILE#2> [required]
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
 ;  SCROLEA= array of usr classes included reverse with scusra('exclude')
 ;SCPURPA - array of pointers to team purpose file 403.47
 ; if none definded - retruns all teams
 ; if @scpurpa@('exclude') is defined - exclude listed teams
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;  SCYESCL=Boolean indicator to include patients' enrollments in
 ;          clinics - [0:strong recommendation/default=NO,1=YES] **NOT SUPPORTED **
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
ST N SCTP,SCPOS0,SCOK,SCTEAMS,INDX,SCPRACTS,SCND,SCU,SCR,SCPOSIT,SCX,SCTP,SC44
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 N SCENROLL,SCPOSIT,PT,ENR
 G:'$$OKDATA PRPTQ ; check/setup variables
 ; put list of patient's positions in SCPOSIT()
 IF '$$TPPT^SCAPMC23(DFN,.SCDATES,.SCPOSA,.SCUSA,.SCPURPA,.SCROLEA,.SCYESCL,"SCPOSIT",.SCERR) G PRPTQ
 F INDX=1:1:$G(SCPOSIT(0)) S SCX=$G(SCPOSIT(INDX)) D
 .IF 'SCX D  Q
 ..S SCPARM("Position Xref")=$G(SCX)
 ..D ERR^SCAPMCU1(.SCESEQ,,SCPARM,"",.SCERR)
 .S SCTP=$P(SCX,U,1)
 .S PT("BEGIN")=$S(SCBEGIN>$P(SCX,U,5):SCBEGIN,1:$P(SCX,U,5))
 .S PT("END")=$S('$P(SCX,U,6):SCEND,(SCEND<$P(SCX,U,6)):SCEND,1:$P(SCX,U,6))
 .S PT("INCL")=SCINCL
 .;go thru each pt team position assignment
 .Q:'$$PRTP^SCAPMC8(SCTP,"PT",.SCLIST,.SCERR)
PRPTQ Q $G(@SCERR@(0))<1
 ;
OKDATA() ;check/setup variables - return 1 if ok; 0 if error
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 IF '$D(^DPT(+$G(DFN),0)) D  S SCOK=0
 . S SCPARM("PATIENT")=$G(DFN,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 S SCPOSA=$G(SCPOSA,"")
 S SCUSRA=$G(SCUSRA,"")
 Q SCOK
