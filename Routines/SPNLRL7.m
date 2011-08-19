SPNLRL7 ;SD/WDE - Pharmacy Utilization rpt RPC;Jan 12, 2007
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
 ;PTLIST  THE LIST OF PATIENTS TO REPORT ON  dfn^dfn^dfn...
 ;HIUSERS Number of highest users to identify:  (0-100)
 ;
 ;
RPC(ROOT,FDATE,TDATE,COST,MINCOST,MINFILL,PTLIST,HIUSERS) ;
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
 ; cost must to either actual or current
 S QLIST("COST")=COST
 ;Minimum dollar cost of dispensed fills to display:  (0-9999999)
 S QLIST("MINCOST")=MINCOST
 ;Minimum number of fills to display:  (1-999999)
 S QLIST("MINFILL")=MINFILL
 ;Number of highest users to identify:  (0-100)
 S HIUSERS=HIUSERS
 S CNT=0
 S ICN=0 F ZYZ=1:1 S ICN=$G(PTLIST(ZYZ)) Q:ICN=""  D
 .S DFN=$$FLIP^SPNRPCIC(ICN)
 .Q:DFN=""
 .D GATHER^SPNLRL(DFN,FDATE,TDATE,HIUSERS,.QLIST)
 .Q
 S (FACNAME,XFDATE,XTDATE,ABORT)=""
 S SPNPAGE=1
 D PRINT^SPNLRL(FACNAME,XFDATE,XTDATE,HIUSERS,.QLIST,ABORT)
 K ABORT,CNT,COST,DFN,FACNAME,FDATE,HIUSERS,ICN,MINCOST,MINFILL,PTLIST,QLIST,SPNPAGE,STR,TDATE,X,XFDATE,XTDATE,Y,ZYZ
 Q
 ;---------------------------------------------------------------
NEWT ;
 ;TEST TAG JUST FOR DAYT42
 S PTLIST(1)=1002651548
 S PTLIST(2)=1002633845
 S PTLIST(3)=1002632389
 S PTLIST(4)=1002636280
 S PTLIST(5)=1005409510
 S PTLIST(6)=1002623561
 S PTLIST(7)=1002654116
 S PTLIST(8)=1002625018
 S PTLIST(9)=1002624576
 S PTLIST(10)=1005547840
 S PTLIST(11)=1002624513
 D RPC(.ROOT,"JAN 1 2004","JAN 3 2004","ACTUAL",10,2,.PTLIST,0)
 Q
