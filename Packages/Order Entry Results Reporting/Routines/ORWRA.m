ORWRA ; ALB/MJK/REV/JDL -Imaging Calls ;8/6/02  1:30 [2/12/04 9:25am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,109,135,132,148,154,141,160,149,190**;Dec 17, 1997
EXAMS(ROOT,DFN) ; Return imaging exams
 ; RPC: ORWRA IMAGING EXAMS
 ;  See RPC definition for details on input and output parameters
 D GET(0)
 Q
EXAMS1(ROOT,DFN) ; Return imaging exams
 ; RPC: ORWRA IMAGING EXAMS1
 ;  See RPC definition for details on input and output parameters
 D GET(1)
 Q
GET(GSITE) ;Get the data
 N I,ID,RADATA,STRING,SITE,ORCX
 N BEG,END,MAX,P1,P2
 S RADATA=$NA(^TMP($J,"RAE1",DFN))
 S ROOT=$NA(^TMP($J,"ORAEXAMS"))
 S ORCX=1  ;show cancelled reports
 K @RADATA,@ROOT
 ;
 ; -- set date range
 D GETDEFG(.STRING)
 S BEG=$P(STRING,U)
 S END=$P(STRING,"^",2)
 S MAX=$P(STRING,"^",3)
 I GSITE="1" S MAX=MAX_"P"
 D EN1^RAO7PC1(DFN,BEG,END,MAX,ORCX)
 ;
 ; -- reformat data array for rpc
 S I=0,ID="",SITE=""
 I $G(GSITE) S SITE=$$SITE^VASITE,SITE=$P(SITE,"^",2)_";"_$P(SITE,"^",3)_U
 F  S ID=$O(@RADATA@(ID)) Q:ID=""  D
 . S P1=$P($G(^TMP($J,"RAE1",DFN,ID,"CPRS")),U) ;The member of set indicator from Radiology 
 . S P2=$P($G(^TMP($J,"RAE1",DFN,ID,"CPRS")),U,2) ;The parent procedure name from Radiology  
 . S I=I+1
 . S @ROOT@(I)=SITE_ID_U_(9999999.9999-ID)_U_@RADATA@(ID)_U_P1_U_P2
 K @RADATA
 Q
 ;
GETDEFG(Y) ; -- get default context settings for GUI imaging reports
 N BEG,END,MAX
 ;if called from CAPRI, show all reports
 D OP^XQCHK
 I $P($G(XQOPT),"^",1)="DVBA CAPRI GUI" D
 . S BEG=$$DT^ORCHTAB1("T-36500")
 . S END=$$DT^ORCHTAB1("T")
 . S MAX="9999"
 . S Y=BEG_"^"_END_"^"_MAX
 ; if not CAPRI, use CPRS defaults
 E  D GETIMG^ORWTPD(.Y,"")
 Q
GETDEF(Y) ; -- get default context settings for LM imaging reports
 N BEG,CONTEXT,END,MAX
 S CONTEXT=$$GET^XPAR("ALL","ORCH CONTEXT REPORTS")
 S BEG=$$DT^ORCHTAB1($P(CONTEXT,";"))
 S END=$$DT^ORCHTAB1($P(CONTEXT,";",2))
 S MAX=$P(CONTEXT,";",5)
 D OP^XQCHK
 I $P($G(XQOPT),"^",1)="DVBA CAPRI GUI" D
 .S BEG=$$DT^ORCHTAB1("T-36500")
 .S END=$$DT^ORCHTAB1("T")
 .S MAX="9999"
 S Y=BEG_"^"_END_"^"_MAX
 Q
 ;
RPT1(ROOT,DFN,ORID,ALPHA,OMEGA,DTRANGE,REMOTE,ORMAX,ORFHIE) ; -- return imaging report
 D RPT(.ROOT,.DFN,.ORID,.ALPHA,.OMEGA,.DTRANGE,.REMOTE,.ORMAX,.ORFHIE)
 Q
RPT(ROOT,DFN,ORID,ALPHA,OMEGA,DTRANGE,REMOTE,ORMAX,ORFHIE) ; -- return imaging report
 ;  RPC: ORWRA REPORT TEXT
 ;  See RPC definition for details on input and output parameters
 ; -- init locals and globals
 N ID,LCNT,ORVP,EXAMDATE,CASENMBR
 S RADATA=$NA(^TMP($J,"RAE3"))
 S ROOT=$NA(^TMP("ORXPND",$J))
 K @RADATA,@ROOT
 ; 
 ; -- set up exam id and call to get report text
 S ID=$TR(ORID,"-",U)
 ;
 ; -- set up counter and vp local for dfn for formating call
 S LCNT=0,ORVP=DFN_";DPT("
 D XRAYS^ORCXPND1
 K @RADATA
 Q
 ;
TEST ; -- test to get exam list
 N I,ROOT,DFN
 S DFN=16
 D EXAMS1(.ROOT,DFN)
 W !,"Root: ",ROOT
 S I=0 F  S I=$O(@ROOT@(I)) Q:'I  W !,@ROOT@(I)
 Q
 ;
TEST1 ; -- test to print reprt for first 3 exams
 N ORI,ROOT,ROOT1,L,X,DFN
 S DFN=16
 D EXAMS1(.ROOT,DFN)
 S ORI=0 F  S ORI=$O(@ROOT@(ORI)) Q:'ORI  D  Q:ORI=3
 . S X=@ROOT@(ORI)
 . D RPT1(.ROOT1,DFN,$P(X,U))
 . S L=0 F  S L=$O(@ROOT1@(L)) Q:'L  W !,@ROOT1@(L,0)
 Q
