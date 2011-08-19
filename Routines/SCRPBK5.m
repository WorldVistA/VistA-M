SCRPBK5 ;MJK/ALB - RPC Broker Utilities ; 27 FEB 96
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;
PARSE(SCQDEF,SCQREC) ; -- parse incoming raw broker array
 ; -- return formatted query record
 ;
 ; -- SEE BOTTOM OF SCRPBK FOR VARIABLE DEFINITIONS
 ;
 N SCINC,X
 ;
 ; -- build internal formatted variables
 S SCINC=1,X=SCQDEF(SCINC)
 S SCQREC("NAME")=$P(X,U)
 S SCQREC("CREATORID")=+$P(X,U,2)
 S SCQREC("ACCESSID")=+$P(X,U,3)
 S SCQREC("REPORTID")=+$P(X,U,4)
 ;
 ; -- build external formatted variables
 S SCINC=2,X=SCQDEF(SCINC)
 S SCQREC("QUERYID")=$P(X,U)
 S SCQREC("CREATOR")=$P(X,U,2)
 S SCQREC("ACCESS")=$P(X,U,3)
 S SCQREC("REPORT")=$P(X,U,4)
 ;
 F  S SCINC=$O(SCQDEF(SCINC)) Q:'SCINC  S X=$G(SCQDEF(SCINC)) D
 . IF X="[Description]" D DESC(.SCINC,.SCQDEF,.SCQREC)
 . ; -- get fields
 . IF X="[Fields]" D FIELDS(.SCINC,.SCQDEF,.SCQREC)
 . ; -- get files
 . IF X="[Selections]" D SELECT(.SCINC,.SCQDEF,.SCQREC)
 Q
 ;
DESC(SCINC,SCQDEF,SCQREC) ; -- build query description
 N I,X
 S I=0
 F  S SCINC=$O(SCQDEF(SCINC)) Q:'SCINC  S X=$G(SCQDEF(+SCINC)) Q:X="$$END"  D
 . S I=I+1,SCQREC("DESCRIPTION",I,0)=X
 Q
 ;
FIELDS(SCINC,SCQRY,SCQREC) ; -- build field answeredk
 N X
 F  S SCINC=$O(SCQDEF(SCINC)) Q:'SCINC  S X=$G(SCQDEF(+SCINC)) Q:X="$$END"  D
 . S SCQREC("FIELDS",$P(X,U))=$P(X,U,2)
 Q
 ;
SELECT(SCINC,SCQRY,SCQREC) ; -- build file entries selected
 N X
 F  S SCINC=$O(SCQDEF(SCINC)) Q:'SCINC  S X=$G(SCQDEF(+SCINC)) Q:X="$$END"  D
 . S SCQREC("SELECTIONS",$P(X,U,2),$$SEL(X))=""
 Q
 ;
SEL(SEL) ; -- set vp for selection
 N Y,IEN,SCTYPE
 S SCTYPE=$P(SEL,U,2),IEN=+$P(SEL,U,3),Y="NOT VALID: "_SCTYPE
 IF SCTYPE="DIVISION" S Y="DIC(4," G SELQ
 IF SCTYPE="TEAM" S Y="SCTM(404.51," G SELQ
 IF SCTYPE="PRACTITIONER" S Y="VA(200," G SELQ
 IF SCTYPE="ROLE" S Y="SD(403.46," G SELQ
 IF SCTYPE="CLINIC" S Y="SC(" G SELQ
 IF SCTYPE="USERCLASS" S Y="USR(8930," G SELQ
SELQ Q IEN_";"_Y
 ;
