SCRPBK0 ;MJK/ALB - RPC Broker Utilities ; 27 FEB 96
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;
GETREC(SCDATA,SCQRY) ; -- get QUERY record
 ; input  :    SCQRY := ien of query definition
 ; output : SCDATA is the return array
 ;          SCDATA(0) := 0th node of qry def
 ;                (1) := externals for 0th
 ;             (2..n) := sections for
 ;                       [Description], [Fields], [Selections]
 ;
 ; -- SEE BOTTOM OF SCRPBK FOR MORE VARIABLE DEFINITIONS
 ;
 ; Related RPC: SCRP QUERY GETRECORD
 ;
 N SC,X,SCINC
 S SCINC=-1,SCQRY=+SCQRY
 ; -- get 0th node of team 
 D QRYDEF(.X,SCQRY)
 ; -- add 0TH to return array
 D SET(X(0),.SCINC,.SCDATA)
 ; -- add external values for 0th to ret array
 D SET(X(1),.SCINC,.SCDATA)
 ; -- get description
 D DESC(.SCINC,SCQRY,.SCDATA)
 ; -- get fields
 D FIELDS(.SCINC,SCQRY,.SCDATA)
 ; -- get files
 D SELECT(.SCINC,SCQRY,.SCDATA)
 Q
 ;
SET(X,INC,SCDATA) ; -- set value in return array
 S INC=$G(INC)+1,SCDATA(INC)=X
 Q
 ;
QRYDEF(X,SCQRY) ; -- retrieve rpt def demographics
 N Y,Z
 S Y=$G(^SD(404.95,SCQRY,0))
 S X(0)=Y ; 0th node
 S X(1)=SCQRY ; query name
 S $P(X(1),U,2)=$P($G(^VA(200,+$P(Y,U,2),0)),U) ; creator
 S $P(X(1),U,3)=$S($P(Y,U,3)=1:"PRIVATE",1:"PUBLIC") ; access level
 S $P(X(1),U,4)=$P($G(^SD(404.92,+$P(Y,U,4),0)),U) ; report name
 S $P(X(1),U,5)=$$FMTE^XLFDT($P(Y,U,5),"2FP")
 Q
 ;
DESC(SCINC,SCQRY,SCDATA) ; -- get query description
 N I,X
 D SET("[Description]",.SCINC,.SCDATA)
 S I=0 F  S I=$O(^SD(404.95,SCQRY,1,I)) Q:'I  S X=$G(^(I,0)) D
 . D SET(X,.SCINC,.SCDATA)
 D SET("$$END",.SCINC,.SCDATA)
 Q
 ;
FIELDS(SCINC,SCQRY,SCDATA) ; -- get fields to ask
 N I,X,Y
 D SET("[Fields]",.SCINC,.SCDATA)
 S I=0 F  S I=$O(^SD(404.95,SCQRY,"FIELDS",I)) Q:'I  S X=$G(^(I,0)) D
 . S Y=""
 . S Y=Y_$P($G(^SD(404.93,+X,0)),U,2)_U ; component name
 . S Y=Y_$P(X,U,2)_U ; value
 . D SET(Y,.SCINC,.SCDATA)
 D SET("$$END",.SCINC,.SCDATA)
 Q
 ;
SELECT(SCINC,SCQRY,SCDATA) ; -- get files to select
 N I,X,Y
 D SET("[Selections]",.SCINC,.SCDATA)
 S I=0 F  S I=$O(^SD(404.95,SCQRY,"FILES",I)) Q:'I  S X=$G(^(I,0)) D
 . IF X["DIC(4" S SCGLB="^DIC(4)",SCTYPE="DIVISION"
 . IF X["SCTM(404.51" S SCGLB="^SCTM(404.51)",SCTYPE="TEAM"
 . IF X["VA(200" S SCGLB="^VA(200)",SCTYPE="PRACTITIONER"
 . IF X["SD(403.46" S SCGLB="^SD(403.46)",SCTYPE="ROLE"
 . IF X["USR(8930" S SCGLB="^USR(8930)",SCTYPE="USERCLASS"
 . IF X["SC(" S SCGLB="^SC",SCTYPE="CLINIC"
 . IF $D(@SCGLB@(+X,0)) D SET($P(^(0),U)_U_SCTYPE_U_+X,.SCINC,.SCDATA)
 D SET("$$END",.SCINC,.SCDATA)
 Q
 ;
