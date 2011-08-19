ORWCS ; ALB/MJK - Consult Tab Calls ;9/18/96  15:02
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;
LIST(ORY,DFN,SERV,BEGDT,ENDDT,STATUS) ;
 ;  RPC: ORWCS LIST OF CONSULT REPORTS
 ;  See RPC definition for details on input and output parameters
 ;
 N ORI,ORX,ID,DATE,STAT,PROC,LN
 IF '$D(SERV) N SERV S SERV=""
 IF '$D(BEGDT) N BEG S BEGDT=""
 IF '$D(ENDDT) N END S ENDDT=""
 IF '$D(STATUS) N STATUS S STATUS=""
 S LN=0
 ;
 S ORY=$NA(^TMP("ORCS",$J)) K @ORY
 D OER^GMRCSLM1(DFN,SERV,BEGDT,ENDDT,STATUS)
 S ORI=0 F  S ORI=$O(^TMP("GMRCR",$J,"CS",ORI)) Q:'ORI  S ORX=$G(^(ORI,0)) D
 . S ID=$P(ORX,U)
 . S DATE=$P(ORX,U,2)
 . S STAT=$P(ORX,U,3)
 . S PROC=$P(ORX,U,5)
 . IF PROC="Consult" S PROC=$$UP^XLFSTR($P(ORX,U,4)_" "_PROC)
 . S LN=LN+1
 . S @ORY@(LN,0)=ID_U_DATE_U_PROC_U_STAT
 Q
 ;
RPT(ORY,DFN,ORID) ; -- retrieve report text
 ;  RPC: ORWCS REPORT TEXT
 ;  See RPC definition for details on input and output parameters
 ;
 S ORY=$NA(^TMP("GMRCR",$J,"DT")) K @ORY Q:+ORID=0
 D DT^GMRCSLM2(ORID)
 Q
 ;
TEST ; -- get a list of reports
 N ORY,ORI
 D LIST(.ORY,16)
 S ORI=0 F  S ORI=$O(@ORY@(ORI)) Q:'ORI  W !,@ORY@(ORI,0)
 Q
TEST1 ; -- print a report
 N ORY,ORI
 D RPT(.ORY,16,100)
 S ORI=0 F  S ORI=$O(@ORY@(ORI)) Q:'ORI  W !,@ORY@(ORI,0)
 Q
 ;
