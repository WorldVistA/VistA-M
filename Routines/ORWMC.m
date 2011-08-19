ORWMC ; slc/dcm -Medicine Calls ;4/2/98  15:02
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,109**;Dec 17, 1997
PROD(ROOT,DFN) ; Return procedures
 ; RPC: ORWMC PROCEDURES
 ;  See RPC definition for details on input and output parameters
 D GET(0)
 Q
PROD1(ROOT,DFN) ; Return procedures
 ; RPC: ORWMC PROCEDURES
 ;  See RPC definition for details on input and output parameters
 D GET(1)
 Q
GET(GSITE)      ;Get the data
 N MCDATA,I,X,X1,X2,ID,SITE
 S MCDATA=$NA(^TMP("OR",$J,"MCAR","OT"))
 S ROOT=$NA(^TMP("OR",$J,"MCAR","GUI"))
 K @MCDATA,@ROOT
 D EN^MCARPS2(DFN)
 ; -- reformat data array for rpc
 S ID="",SITE=""
 I $G(GSITE) S SITE=$$SITE^VASITE,SITE=$P(SITE,"^",2)_";"_$P(SITE,"^",3)_U
 F  S ID=$O(@MCDATA@(ID)) Q:ID=""  D
 . S @ROOT@(ID)=SITE_ID_U_@MCDATA@(ID)
 ;K @MCDATA
 Q
 ;
RPT(ROOT,DFN,ORID) ; -- return medicine report
 ;  RPC: ORWMC REPORT TEXT
 ;  See RPC definition for details on input and output parameters
 ; N IORVON,IORVOFF S (IORVON,IORVOFF)=""
 ;
 ; -- init locals and globals
 N ID,LCNT,ORVP,DA,MCARGDA,MCARPPS,MCPRO
 S MCDATA=$NA(^TMP("OR",$J,"MCAR","OT"))
 S ROOT=$NA(^TMP("ORXPND",$J))
 K @ROOT ;K @MCDATA REMOVED
 ; -- set up procedure id and call to get report text
 S ID=^TMP("OR",$J,"MCAR","OT",ORID),(DA,MCARGDA)=$P(ID,U,3),MCARPPS=$P(ID,U,4,5),MCPRO=$P(ID,U,12)
 D MCPPROC^MCARP
 S MCARGRTN=$P(ID,U,6)
 D @MCARPPS
 ; -- set up counter and vp local for dfn for formating call
 K @MCDATA
 Q
 ;
TEST ; -- test to get exam list
 N I,ROOT,DFN
 S DFN=17
 D PROD1(.ROOT,DFN)
 W !,"Root: ",ROOT
 S I=0 F  S I=$O(@ROOT@(I)) Q:'I  W !,@ROOT@(I)
 Q
 ;
TEST1 ; -- test to print reprt for first 3 exams
 N I,ROOT,ROOT1,L,X,DFN,XQY0,ORHFS
 S DFN=17,XQY0="ORTEST",ORHFS=1
 D PROD1(.ROOT,DFN)
 W !,"Root: "_ROOT
 S I=0 F  S I=$O(@ROOT@(I)) Q:'I  D  Q
 . S X=@ROOT@(I)
 . D RPT(.ROOT,DFN,I)
 . ;S L=0 F  S L=$O(@ROOT@(L)) Q:'L  W !,@ROOT@(L)
 Q
