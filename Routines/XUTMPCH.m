XUTMPCH ;ISF/RWF - Patch rouitne for Pre/post init ;09/27/2000  09:12
 ;;8.0;KERNEL;**170**;Jul 10, 1995
 ;;
 W !,"NO entry from the top."
 Q
 ;
POST170 ;Post Init work for patch XU*8*170
 D OPTSCH
 D ^ZUSET
 Q
OPTSCH ;To reschedule any entry in OPTION SCHEDULE that is not current.
 N TSK,XQ1,XQ2,XQSH,NOW
 S XQ1=0,NOW=$$NOW^XLFDT()
 F  S XQ1=$O(^DIC(19.2,XQ1)) Q:XQ1'>0  D RESCH(XQ1)
 ;Clean up any strange schedule entries.
 S XQ1=9999999999
 F  S XQ1=$O(^%ZTSCH(XQ1)),TSK=0 Q:XQ1'?1N.NP  D
 . F  S TSK=$O(^%ZTSCH(XQ1,TSK)) Q:TSK'>0  I $G(^%ZTSK(TSK,0))="" K ^%ZTSCH(XQ1,TSK)
 . Q
 Q
 ;
RESCH(DA) ;See if need to re-schedule
 N X,X0,Y,T,DR,DIE
 S X0=$G(^DIC(19.2,DA,0)) Q:X0=""  S X=$P(X0,"^",2),Y=$P(X0,"^",6)
 Q:(X'>0)!(Y="")
 ;Patch XU*8*162 was released on 08/19/00 so only reschedule from then on
 I (X<3000819)!(X>NOW) Q
 ;Schedule, last time
 S MS="Option '"_$P($G(^DIC(19,+X0,0)),U)_"' has been Re-Scheduled for "
 S T=$$SCH^XLFDT(Y,X,1),DIE="^DIC(19.2,",DR="2////"_T
 D BMES^XPDUTL(MS_T)
 D ^DIE
 Q
 
