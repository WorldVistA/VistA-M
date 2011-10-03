XUINTSK ;SEA/RDSM-TaskMan: Version 7.1 Post-init ;08/15/94  09:39
 ;;8.0;KERNEL;;Jul 10, 1995
INTRO ;
 ;This routine converts TaskMan's files from version 7.1 to 8
 ;
MAIN ;
 ;This is the post-init conversion's main subroutine.
 D MES^XPDUTL("Beginning TaskMan's post-init conversion...")
 D ^XUINTSK1,^XUINTSK2,DESC
 D MES^XPDUTL("End of TaskMan's post-init conversion.")
 Q
DESC ;Move the DESCRIPTION data for current tasks.
 N TSK
 F TSK=0:0 S TSK=$O(^%ZTSK(TSK)) Q:TSK'>0  D
 . S Z0=$P($G(^%ZTSK(TSK,0)),"^",13) Q:Z0="ZTDESC"
 . S Z3=$G(^%ZTSK(TSK,.03))
 . I Z3="",Z0]"" S $P(^%ZTSK(TSK,0),U,13)="ZTDESC",^(.03)=Z0
 . Q
 Q
