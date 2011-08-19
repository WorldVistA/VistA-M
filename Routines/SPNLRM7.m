SPNLRM7 ;SD/WDE - RAD Utilization rpt RPC;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ;
 ;
 ;
 ;
 ;FDATE  DATE TO START FROM
 ;TDATE  DATE TO END
 ;COST ACTUAL OR CURRENT
 ;MINCOST Minimum dollar cost of dispensed fills to display:  (0-9999999)
 ;MINFILL Minimum number of fills to display:  (1-999999)
 ;PTLIST  THE LIST OF PATIENTS TO REPORT ON  ICN^ICN^ICN....
 ;HIUSERS Number of highest users to identify:  (0-100)
 ;
 ;
RPC(ROOT,FDATE,TDATE,MINPROC,MINCOST,HIUSERS,PTLIST) ;
 K ^TMP($J)
 K ^TMP("SPN",$J)
DATES ;----------------------------------------------------------------
 ;convert dates to fm style
 ;  ;fdate
 S X=FDATE D ^%DT S FDATE=Y
 ;  ;tdate
 S X=TDATE D ^%DT S TDATE=Y
 ;----------------------------------------------------------------
 S ROOT=$NA(^TMP($J))
 ;Minimum dollar cost of dispensed fills to display:  (0-9999999)
 S QLIST("MINCOST")=MINCOST
 ;Minimum number of fills to display:  (1-999999)
 S QLIST("MINNUM")=MINPROC
 ;Number of highest users to identify:  (0-100)
 S HIUSERS=HIUSERS
 S CNT=0
 S ICN=0 F ZYZ=1:1 S ICN=$G(PTLIST(ZYZ)) Q:ICN=""  D
 .S DFN=$$FLIP^SPNRPCIC(ICN)
 .Q:$G(DFN)=""
 .D ROLLUP^SPNLGRRA(DFN,FDATE,TDATE,HIUSERS) ; gather radiology data
 .Q
 D NAMEIT^SPNLGRRA
 D P1^SPNLRM8
 D P2^SPNLRM8
 D P3^SPNLRM8
 I HIUSERS D
 . D P4^SPNLRM9
 . D P5^SPNLRM9
 . Q
 K ABORT,CNT,COST,DFN,FACNAME,FDATE,HIUSERS,ICN,MINCOST,MINFILL,PTLIST,QLIST,SPNPAGE,STR,TDATE,X,XFDATE,XTDATE,Y,ZYZ
 Q
 ;---------------------------------------------------------------
SS ;JUST USED TO SET UP DFNS FOR TESTING
 S STR="",DFN="" F X=1:1:20 S DFN=$O(^SPNL(154,DFN)) Q:DFN=""  D
 .S STR=STR_"^"_DFN
 Q
