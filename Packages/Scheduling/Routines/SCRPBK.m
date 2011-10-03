SCRPBK ;MJK/ALB - RPC Broker Utilities ; 27 FEB 96
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;
GETREC(SCDATA,SCRPT) ; -- get REPORT record
 ; input  :     SCRPT := ien of report definition
 ; output : SCDATA is the return array
 ;          SCDATA(0) := 0th node of rpt def
 ;             (1..n) := sections for
 ;                       [Description], [Sorts], [Fields], [Files]
 ;
 ; Related RPC: SCRP DEFINITION GETRECORD
 ;
 N SC,X,SCINC
 S SCINC=-1,SCRPT=+SCRPT
 ; -- get 0th node of team
 S X=$$RPTDEF(SCRPT)
 ; -- add to return array
 D SET(X,.SCINC,.SCDATA)
 ; -- get description
 D DESC(.SCINC,SCRPT,.SCDATA)
 ; -- get sorts
 D SORTS(.SCINC,SCRPT,.SCDATA)
 ; -- get fields
 D FIELDS(.SCINC,SCRPT,.SCDATA)
 ; -- get files
 D FILES(.SCINC,SCRPT,.SCDATA)
 Q
 ;
SET(X,INC,SCDATA) ; -- set value in return array
 S INC=$G(INC)+1,SCDATA(INC)=X
 Q
 ;
RPTDEF(SCRPT) ; -- retrieve rpt def demographics
 N X,Y
 S X=$G(^SD(404.92,SCRPT,0))
 S Y=$P(X,U)_U_$P($G(^SD(404.94,+$P(X,U,2),0)),U)
 Q Y
 ;
DESC(SCINC,SCRPT,SCDATA) ; -- get rpt description
 N I,X
 D SET("[Description]",.SCINC,.SCDATA)
 S I=0 F  S I=$O(^SD(404.92,SCRPT,1,I)) Q:'I  S X=$G(^(I,0)) D
 . D SET(X,.SCINC,.SCDATA)
 D SET("$$END",.SCINC,.SCDATA)
 Q
 ;
SORTS(SCINC,SCRPT,SCDATA) ; -- get possible sorts
 N I,X
 D SET("[Sorts]",.SCINC,.SCDATA)
 S I=0 F  S I=$O(^SD(404.92,SCRPT,"SORTS",I)) Q:'I  S X=$G(^(I,0)) D
 . D SET(X,.SCINC,.SCDATA)
 D SET("$$END",.SCINC,.SCDATA)
 Q
 ;
FIELDS(SCINC,SCRPT,SCDATA) ; -- get fields to ask
 N I,X,Y
 D SET("[Fields]",.SCINC,.SCDATA)
 S I=0 F  S I=$O(^SD(404.92,SCRPT,"FIELDS",I)) Q:'I  S X=$G(^(I,0)) D
 . S Y=""
 . S Y=Y_$P($G(^SD(404.93,+X,0)),U,2)_U ; component name
 . S Y=Y_$P(X,U,2)_U ; required
 . S Y=Y_$P(X,U,3)_U ; always ask
 . S Y=Y_$P(X,U,4)_U ; default value
 . D SET(Y,.SCINC,.SCDATA)
 D SET("$$END",.SCINC,.SCDATA)
 Q
 ;
FILES(SCINC,SCRPT,SCDATA) ; -- get files to select
 N I,X,Y,SCTYPE
 D SET("[Files]",.SCINC,.SCDATA)
 S I=0 F  S I=$O(^SD(404.92,SCRPT,"FILES",I)) Q:'I  S X=$G(^(I,0)) D
 . S SCTYPE=$$TYPE(+X)
 . S Y=""
 . S Y=Y_SCTYPE_U ; file type
 . S Y=Y_+X_U ; file #
 . S Y=Y_+$P(X,U,2)_U ; selections allowed
 . IF $$CHKTYPE^SCRPBK2(SCTYPE) D SET(Y,.SCINC,.SCDATA)
 D SET("$$END",.SCINC,.SCDATA)
 Q
 ;
TYPE(FILENUM) ; -- determine file type for file
 N X
 S X=""
 IF FILENUM=4 S X="DIVISION" G TYPEQ
 IF FILENUM=404.51 S X="TEAM" G TYPEQ
 IF FILENUM=200 S X="PRACTITIONER" G TYPEQ
 IF FILENUM=403.46 S X="ROLE" G TYPEQ
 IF FILENUM=8930 S X="USERCLASS" G TYPEQ
 IF FILENUM=44 S X="CLINIC" G TYPEQ
TYPEQ Q X
 ;
 ;
 ; -- variable descriptions for SCRPBK* routines 
 ; SCDATA  -> result return array
 ; SCINC   -> incrmental variable used when build SCDATA
 ; SCQRY   -> ien of 404.95
 ; SCQDEF  -> raw query defintion received from client
 ; SCQREC  -> query definition
 ; SCRPT   -> ien of 404.92 - query definition
 ; SCRPTID -> ien of 404.92 - report definifion
 ; SCRPT   -> report name
 ; SCTYPE  -> selection file type (DIVISION, TEAM, etc.)
 ; SCGLB   -> closed global root of a file [i.e. ^SC]
 ; SCAN    -> array where the name of used/required report
 ;            fields or file selections are stored
 ; SCPROC  -> process being performed when error occured
 ; SCPARM()-> error parameters to be used by BLD^DIALOG call
 ; SCLOG   -> contains the array name where application generated
 ;            error messages are stored(usually SCDATA)
 ; SCERR() -> array where FM DBS generated errors are stored
 ; SCTEXT  -> text used to search files
 ; SCSELS()-> array of file entry selections
 ; VAUTD() -> array of divisions subscripted by iens
 ; VAUTT() -> array of teams subscripted by iens
 ; VAUTP() -> array of practitioners subscripted by iens
 ; VAUTR() -> array of roles subscripted by iens
 ; VAUTC() -> array of clinics subscripted by iens
 ; VAUTUC()-> array of user classes subscripted by iens
 ; 
