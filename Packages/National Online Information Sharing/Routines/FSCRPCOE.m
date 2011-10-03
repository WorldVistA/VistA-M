FSCRPCOE ;SLC/STAFF-NOIS RPC Other Edits ;1/18/97  15:46
 ;;1.1;NOIS;;Sep 06, 1998
 ;
EDITS(IN,OUT) ; from FSCRPX (RPCCallEdits)
 N CALL,CNT,LINE,NUM,STATUS0,ZERO
 S CALL=+$G(^TMP("FSCRPC",$J,"INPUT",1))
 I 'CALL Q
 S CNT=0,ZERO=^FSCD("CALL",CALL,0),STATUS0=^(120)
 S CNT=CNT+1,^TMP("FSCRPC",$J,"OUTPUT",CNT)="It's been "_+$P(ZERO,U,18)_" days since this call was first entered."
 S CNT=CNT+1,^TMP("FSCRPC",$J,"OUTPUT",CNT)="This call was last edited on "_$P($$FMTE^XLFDT($P(STATUS0,U,4),1),":",1,2)_" ("_+$P(ZERO,U,19)_" days ago) by "_$$VALUE^FSCGET($P(STATUS0,U,5),7100,124)_"."
 S CNT=CNT+1,^TMP("FSCRPC",$J,"OUTPUT",CNT)="The last status change was "_+$P(ZERO,U,23)_" days ago."
 I $P(ZERO,U,4),$P(ZERO,U,3) S CNT=CNT+1,^TMP("FSCRPC",$J,"OUTPUT",CNT)="The number of days from reported until closed was "_$$FMDIFF^XLFDT($P(ZERO,U,4),$P(ZERO,U,3),1)_" days."
 S CNT=CNT+1,^TMP("FSCRPC",$J,"OUTPUT",CNT)="Status History:"
 S NUM=0 F  S NUM=$O(^FSCD("CALL",CALL,110,NUM)) Q:NUM<1  S LINE=^(NUM,0) D
 .S CNT=CNT+1,^TMP("FSCRPC",$J,"OUTPUT",CNT)=LINE
 I $O(^FSCD("CALL",CALL,100,0)) D
 .S CNT=CNT+1,^TMP("FSCRPC",$J,"OUTPUT",CNT)="Audit History:"
 .S NUM=0 F  S NUM=$O(^FSCD("CALL",CALL,100,NUM)) Q:NUM<1  S LINE=^(NUM,0) D
 ..S CNT=CNT+1,^TMP("FSCRPC",$J,"OUTPUT",CNT)=LINE
 Q
