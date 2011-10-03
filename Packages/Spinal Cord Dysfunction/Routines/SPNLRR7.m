SPNLRR7 ;SD/WDE Laboratory Utilization rpt specific RPC;JUL 23, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ;
RPC(ROOT,FDATE,TDATE,HIUSERS,VALUES,PTLIST) ;
 K ^TMP("SPN",$J)
 K ^TMP($J)
 S ROOT=$NA(^TMP($J))
DATES ;----------------------------------------------------------------
 ;convert dates to fm style
 S X=FDATE D ^%DT S FDATE=Y  ;fdate
 S X=TDATE D ^%DT S TDATE=Y  ;tdate
 D BQLIST  ;unload the values in values
 ;-------------------------------------------------------------
 S CNT=0
 S ICN=0 F ZYZ=1:1 S ICN=$G(PTLIST(ZYZ)) Q:ICN=""  D COL
 K ^TMP($J)
 S CNT=0
 I HIUSERS=0 D P1  ;resort data
 I HIUSERS=1 D P2  ;resort data
 Q
COL ;
 ;*****************************
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;*****************************
 D SELECT^SPNLGSCH(DFN,FDATE,TDATE,HIUSERS,.QLIST) ; gather lab test data
 ;Tag RPC is called by a Remote procedure
 ;   fdate = from date
 ;   tdate = to date
 ;   hiusers = report on hi users
 ;   qlist = array that has the LAB TEST names and numbers
 ;   ptlist = patient list array
 ;   abort = true or false abort yes no
 Q
 ;---------------------------------------------------------------
P1 ;
 S CNT=0
 S TESTNR="" ; create list in test name order
 F  S TESTNR=$O(QLIST(TESTNR)) Q:TESTNR=""  D
 . S LABTEST(QLIST(TESTNR))=TESTNR
 S TESTNAME=""
 F  S TESTNAME=$O(LABTEST(TESTNAME)) Q:TESTNAME=""  D
 . S TESTNR=LABTEST(TESTNAME)
 . S RESULTS=+$G(^TMP("SPN",$J,"CH","TEST",TESTNR))
 . S NPATS=+$G(^TMP("SPN",$J,"CH","TEST",TESTNR,"PAT"))
 . S CNT=CNT+1 S ^TMP($J,CNT)=TESTNAME_U_NPATS_U_RESULTS_"^EOL999"
 Q
 ;----------------------------------------------------------------------
P2 ;USAGE DATA IS YES  HIUSERS=1
 S TESTNR="" ; create list in test name order
 F  S TESTNR=$O(QLIST(TESTNR)) Q:TESTNR=""  D
 . S LABTEST(QLIST(TESTNR))=TESTNR
 S TESTNAME=""
 F  S TESTNAME=$O(LABTEST(TESTNAME)) Q:TESTNAME=""  D
 . S TESTNR=LABTEST(TESTNAME)
 . S RESULTS=+$G(^TMP("SPN",$J,"CH","TEST",TESTNR))
 . S NPATS=+$G(^TMP("SPN",$J,"CH","TEST",TESTNR,"PAT"))
 . S CNT=CNT+1 S ^TMP($J,CNT)="BOS999"_U_TESTNAME_U_NPATS_U_RESULTS_"^EOL999"
 . S PID=""
 . F  S PID=$O(^TMP("SPN",$J,"CH","TEST",TESTNR,"PID",PID)) Q:(PID="")  D
 . . S PNAME=$P(PID,U,1),PSSN=$P(PID,U,2)
 . . S RESULTS=+$G(^TMP("SPN",$J,"CH","TEST",TESTNR,"PID",PID))
 . . S CNT=CNT+1 S ^TMP($J,CNT)=PNAME_U_PSSN_U_RESULTS_"^EOL999"
 . .Q
 .Q
 Q
KILL ;
 K ABORT,CNT,COST,DFN,FACNAME,FDATE,HIUSERS,ICN,MINCOST,MINFILL,PTLIST,QLIST,SPNPAGE,STR,TDATE,X,XFDATE,XTDATE,Y,ZYZ
 K PID,DRGNAM,NPATS,TESTNR,TESTNAME,VALUE,AA,DRGNUM,LABTEST,PNAM,PSSN,TESTPTS,VAL,XYZZ,ZZ,ZZA,PNAME,RESULTS
 ;==================================================================
BQLIST ;TESTIEN;TESTNAME^TESTIEN;TESTNAME
 F ZZA=1:1 S VAL=$G(VALUES(ZZA)) Q:VAL=""  D
 .S DRGNUM=$P(VAL,";",1)
 .S DRGNAM=$P(VAL,";",2)
 .S QLIST(DRGNUM)=DRGNAM
 .Q
 Q
