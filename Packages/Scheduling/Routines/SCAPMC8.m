SCAPMC8 ;;bp/cmf - List of Practitioners for a Position ; 7/12/99 10:03am
 ;;5.3;Scheduling;**41,177**;AUG 13, 1993
 ;;1.0
 ;
PRTP(SCTP,SCDATES,SCLIST,SCERR,SCPRCPTR,SCALLHIS) ;-- list of practitioners for position  (bp/cmf 177-->SCPRCPTR,SCALLHIS param added)
 ; input:
 ;  SCTP = ien of TEAM POSITION[required]
 ;  SCDATES("BEGIN") = begin date to search (inclusive)
 ;                      [default: TODAY]
 ;         ("END")   = end date to search (inclusive)
 ;                       [default: DT]
 ;         ("INCL")  = 1: only use pracitioners who were on
 ;                       team for entire date range
 ;                     0: anytime in date range
 ;                       [default: 1]
 ;  SCLIST= array NAME for output 
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;  SCPRCPTR = 1: return preceptor sub-array in SCLIST
 ;                       [default: 0]
 ;  SCALLHIS = 1: return unfiltered sub-array in SCLIST
 ;                       [default: 0]
 ;
 ; Output:
 ;  SCLIST(scn) = array of practitioners
 ;             Format:
 ;               scn: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of NEW PERSON file entry (#200)
 ;                 2       Name of person
 ;                 3       IEN of TEAM POSITION file (#404.57)
 ;                 4       Name of Position
 ;                 5       IEN OF USR CLASS(8930) of POSITION (404.57)
 ;                 6       USR Class Name
 ;                 7       IEN of STANDARD POSITION (#403.46)
 ;                 8       Standard Role (Position) Name
 ;                 9       Activation Date for 404.52 (not 404.59!)
 ;                 10      Inactivation Date for 404.52
 ;                 11      IEN of Position Asgn History (404.52)
 ;                 12      IEN of Current(=DT) Preceptor Position
 ;                 13      Name of Current(=DT) Preceptor Position
 ;
 ;  SCLIST(scn,'PR',scn1) = sub-array of preceptors
 ;             Format: same as SCLIST(scn) PLUS
 ;               scn1: Sequential number from 1 to n
 ;                Piece    Description
 ;                 14      precept start date
 ;                 15      precept end date
 ;                 16      IEN of Preceptor Asgn History (404.53)
 ;
 ;  SCLIST("ALL",file,scn2) = sub array of all asgns within date range
 ;             Format:
 ;               file: 404.52 or 404.53
 ;               scn2: Sequential number form 1 to n
 ;                Piece    Description
 ;                 1       status int [1:active,0:inactive]
 ;                 2       status ext ["ACTIVE","INACTIVE"]
 ;                 3       status FM date
 ;                 4       status ext date
 ;                 5       file = 404.52: practitioner ien (200)
 ;                              = 404.53: prec tm pos ien (404.57)
 ;                 6       file = 404.52: practitioner name
 ;                              = 404.53: prec tm pos name
 ;                 7       ien of [file] history
 ;
 ;  SCLIST('SCPR',sc200,sctp,scact,scn)=""
 ;
 ;  SCLIST('CH')= position asgn history status
 ;             Format:
 ;                Piece    Description
 ;                 1       [1:corrupt hist file,0:ok]
 ;                 2       global first act hist date
 ;                 3       global first act hist ien
 ;
 ;  SCLIST('PR','CH')= preceptor asgn history status       
 ;             Format:
 ;                Piece    Description
 ;                 1       [1:corrupt hist file,0:ok]
 ;                 2       global first act hist date
 ;                 3       global first act hist ien
 ;
 ;  SCERR() = Array of DIALOG file messages(errors)
 ;             Format:
 ;  @SCERR@(0) = Number of errors, undefined if none
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;   Returned: 1 if ok, 0 if error
 ;
 ; -- initialize control variables
 ;
ST N SCPOSNM,SCPOS0,SCEFF,SCPRTP,SCTPNODE,SCVALHIS,SCI,SCN,SCSTOP
 N SCP1,SCP2,SCP3,SCP4,SCP5,SCP6,SCP7,SCP8,SCP9,SCP10,SCP11,SCP12
 N SCLSEQ,SCRN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 ;
 G:'$$OKDATA PRACQ                          ; no team pos/date array
 G:'$D(^SCTM(404.52,"AIDT",SCTP)) PRACQ     ; no history
 ;
 S SCPRCPTR=$S(+$G(SCPRCPTR):1,1:0)
 S SCALLHIS=$S(+$G(SCALLHIS):1,1:0)
 ;
 S @SCLIST@("CH")=$$VALHIST^SCAPMCU5(404.52,SCTP,"SCVALHIS")
 G:'$$ACTHIST^SCAPMCU5("SCVALHIS","SCDATES") PRACQ
 ;G:'$$ACTHIST^SCAPMCU2(404.52,SCTP,SCDATES,.SCERR,"SCPRTP") PRACQ
 G:'$D(SCVALHIS) TPALL                      ; no coherent history
 ;
 ; get static return pieces
 S SCP3=SCTP                                ;tm pos ien
 S SCTPNODE=$G(^SCTM(404.57,SCTP,0))        ;tm pos node
 S SCP4=$P(SCTPNODE,U)                      ;tm pos name
 S SCP5=$P(SCTPNODE,U,13)                   ;user class pointer
 S SCP6=$P($G(^USR(8930,+SCP5,0)),U)        ;user class name
 S SCP7=$P(SCTPNODE,U,3)                    ;std pos pointer
 S SCP8=$P($G(^SD(403.46,+SCP7,0)),U)       ;std pos name
 S SCP12=$$OKPREC3^SCMCLK(SCTP,DT)          ;prec tm pos ien^name
 ;
 ; --    get list from position assignments
 S SCRN=0
 S SCEFF=-(SCEND+.000001)
 F  S SCEFF=$O(^SCTM(404.52,"AIDT",SCTP,1,SCEFF)) Q:'SCEFF  D
 . ;Q:'$$ACTHIST^SCAPMCU2(404.52,SCTP,SCDATES,.SCERR,"SCPRTP")
 . S SCP11=""                                ; posn act hist ien
 . F  S SCP11=$O(^SCTM(404.52,"AIDT",SCTP,1,SCEFF,SCP11),-1) Q:'SCP11  D
 . . Q:'$D(SCVALHIS("I",SCP11))
 . . S SCP1=+$P($G(^SCTM(404.52,SCP11,0)),U,3)   ;practitioner ien
 . . S SCP2=$P($G(^VA(200,+SCP1,0)),U)           ;practitioner name
 . . S SCI=$O(SCVALHIS("I",SCP11,0))
 . . S SCP9=$O(SCVALHIS(SCI,0))                  ;hist start date
 . . Q:$D(@SCLIST@("SCPR",SCP1,SCTP,SCP9))
 . . S SCP10=$P(SCVALHIS(SCI,SCP9,SCP11),U)      ;hist end date
 . . Q:'$$DTCHK^SCAPU1(SCBEGIN,SCEND,SCINCL,SCP9,SCP10)
 . . S SCRN=SCRN+1
 . . S @SCLIST@(0)=SCRN
 . . S @SCLIST@("SCPR",SCP1,SCTP,SCP9,SCRN)=""
 . . S @SCLIST@(SCRN)=SCP1_U_SCP2_U_SCP3_U_SCP4_U_SCP5_U_SCP6_U_SCP7_U_SCP8_U_SCP9_U_SCP10_U_SCP11_U_SCP12
 . . Q
 . Q
 ;
 I $G(@SCLIST@(0))>0,+SCPRCPTR D PRCTP^SCAPMC8P
TPALL I +SCALLHIS D TPALL^SCAPMC8A(404.52)
 ;
PRACQ Q $G(SCERR(0))<1  ;bp/djb 7/12/99
 ;
OKDATA() ;check/setup variables - return 1 if ok/0 if error
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 IF '$D(^SCTM(404.57,+$G(SCTP),0)) D  S SCOK=0
 . S SCPARM("POSITION")=$G(SCTP,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 ; -- is it a valid TEAM ien passed (Error # 4045101 in DIALOG file)
 IF '$D(^SCTM(404.57,+$G(SCTP),0))!('$D(SCDATES)) D  S SCOK=0
 . S SCPARM("POSITION")=$S('$D(SCTP):"Undefined",1:SCTP)
 . S SCPARM("DATES")=$S('$D(SCDATES):"Undefined",1:SCDATES)
 . D ERR^SCAPMCU1(SCESEQ,4045101,.SCPARM,"",.SCERR)
 Q SCOK
 ;
