FSCLMPOE ;SLC/STAFF-NOIS List Manager Protocol Other Edit ;1/11/98  18:36
 ;;1.1;NOIS;;Sep 06, 1998
 ;
EDITS(CALL) ; from FSCLMPO
 N CNT,LINE,NUM,OK,STATUS0,ZERO
 S OK=1,ZERO=^FSCD("CALL",CALL,0),STATUS0=^(120)
 W !,"It's been ",+$P(ZERO,U,18)," days since this call was first entered."
 W !,"This call was last edited on ",$P($$FMTE^XLFDT($P(STATUS0,U,4),1),":",1,2)," (",+$P(ZERO,U,19)," days ago) by ",$$VALUE^FSCGET($P(STATUS0,U,5),7100,124),"."
 W !,"The last status change was ",+$P(ZERO,U,23)," days ago."
 S CNT=4
 I $P(ZERO,U,4),$P(ZERO,U,3) W !,"The number of days from reported until closed was ",$$FMDIFF^XLFDT($P(ZERO,U,4),$P(ZERO,U,3),1)," days." S CNT=CNT+1
 W !,"Status History:" S CNT=CNT+1
 S OK=1,NUM=0 F  S NUM=$O(^FSCD("CALL",CALL,110,NUM)) Q:NUM<1  S LINE=^(NUM,0) D  I 'OK Q
 .W !,LINE
 .S CNT=CNT+1 I CNT'<(IOSL-1) S CNT=1 D PAUSE^FSCU(.OK) I 'OK Q
 I 'OK Q
 I $O(^FSCD("CALL",CALL,100,0)) D
 .W !,"Audit History:"
 .S CNT=CNT+1
 .S NUM=0 F  S NUM=$O(^FSCD("CALL",CALL,100,NUM)) Q:NUM<1  S LINE=^(NUM,0) D  I 'OK Q
 ..W !,LINE
 ..S CNT=CNT+1 I CNT'<(IOSL-1) S CNT=1 D PAUSE^FSCU(.OK) I 'OK Q
 I 'OK Q
 D PAUSE^FSCU(.OK)
 Q
