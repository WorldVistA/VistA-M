SPNLRK7 ;SD/WDE - LAB TEST UTILIZATION REPORT;JUL 23, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ;
RPC(ROOT,FDATE,TDATE,QLIST,HIUSERS,PTLIST) ;
 K ^TMP("SPN",$J)
 K ^TMP($J)
 S ROOT=$NA(^TMP($J))
DATES ;----------------------------------------------------------------
 ;convert dates to fm style
 S X=FDATE D ^%DT S FDATE=Y  ;fdate
 S X=TDATE D ^%DT S TDATE=Y  ;tdate
 ;D BQLIST  ;unload the values in values
 S QLIST("MIN")=QLIST
 ;-------------------------------------------------------------
 S CNT=0
 S ICN=0 F ZYZ=1:1 S ICN=$G(PTLIST(ZYZ)) Q:ICN=""  D COL
 K ^TMP($J)
 S CNT=0
 D NAMEIT^SPNLGRCH
 D P1^SPNLRK8  ;resort data
 D P2^SPNLRK8  ;resort data
 I +HIUSERS D P3^SPNLRK8  ;resort data for hiusers
 K CNT,DFN,ICN,X,Y,ZYZ
 Q
COL ;
 ;********************************
 Q:ICN=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;********************************
 D ROLLUP^SPNLGRCH(DFN,FDATE,TDATE,HIUSERS) ; gather lab test data
 ;Tag RPC is called by a Remote procedure
 ;   fdate = from date
 ;   tdate = to date
 ;   hiusers = report on hi users
 ;   ptlist = patient list array
 ;   abort = true or false abort yes no
 Q
