MAGQE4 ;WOIFO/RMP - Support for MAG Enterprise ; 05/06/2004  06:32
 ;;3.0;IMAGING;**27,29,30,78**;May 9, 2006
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
TASK ;Re-task the job
 N DA,DIE,DR,I,MAGTSK,X,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 ; First clean up any entries that might already be there
 D RTN^%ZTLOAD("ISU^MAGQE2","MAGTSK")
 ; EdM: Note: The above procedure only returns tasks submitted
 ;      with the DUZ of the current requestor, unless...:
 ;      When $D(^XUSEC("ZTMQ",DUZ))>0,
 ;      tasks with other DUZs are reported as well.
 S I=0 F  S I=$O(MAGTSK(I)) Q:'I  D
 . N ZTSK
 . S ZTSK=I D KILL^%ZTLOAD
 . Q
 ; Then queue up the next report for 2nd day of the next month
 S ZTDTH=$$NOW^XLFDT()\100+1 S:(ZTDTH#100)>12 ZTDTH=ZTDTH+88
 S ZTDTH=ZTDTH_"01.040101"
 S ZTRTN="ISU^MAGQE2",ZTDESC="Site Imaging Utilization report",ZTIO=""
 S:$D(MAGDUZ) ZTSAVE("MAGDUZ")=MAGDUZ
 D ^%ZTLOAD
 ; Record the task number in the Site Parameter Table
 S DA=$S($T(PLACE^MAGBAPI)'="":$$PLACE^MAGBAPI($$MAGDUZ2^MAGQE5()),1:1)
 S DIE="^MAG(2006.1,",DR="10///^S X=ZTSK" D ^DIE
 Q
 ;
STTASK ; Start the Imaging task report
 N DAYS,MAGDUZ,MCON,REC,TASK,ZTSK
 S REC=$$PLACE^MAGQE5($$MAGDUZ2^MAGQE5()) Q:'$D(^MAG(2006.1,REC))
 S TASK=$P($G(^MAG(2006.1,REC,1)),"^",7)
 I TASK'="" D  Q:TASK'=""
 . S ZTSK=TASK D STAT^%ZTLOAD
 . I ZTSK(0)=0 S TASK=""
 . E  W:$G(XQY0)["MAG" !,"Task is already running"
 . Q
 S MCON="",MAGDUZ=DUZ,DAYS=1
 D RESTASK ; Also called from elsewhere
 Q
 ;
RESTASK ; Restart the Imaging task report
 N DA,DIC,DIE,DR,ZTDESC,ZTIO,ZTRTN,ZTSAVE
 S ZTRTN="ISU^MAGQE2",ZTDESC="Site Imaging Utilization report",ZTIO=""
 S:$D(MAGDUZ) ZTSAVE("MAGDUZ")=MAGDUZ
 S ZTDTH=$$NOW^XLFDT()\100+1 S:(ZTDTH#100)>12 ZTDTH=ZTDTH+88
 S ZTDTH=ZTDTH_"01.040101"
 D ^%ZTLOAD
 S DIE="^MAG(2006.1,",DA=$$PLACE^MAGQE5($$MAGDUZ2^MAGQE5()),DR="10///^S X=ZTSK" D ^DIE
 W:$G(XQY0)["MAG" !,"Task is started. To remove task execute option MAGREPSTOP"
 K MCDUZ
 Q
 ;
REMTASK ;Remove the Imaging Task Report
 N DA,DIE,DR,FIND,REC,TASK,ZTSK
 S REC=$$PLACE^MAGQE5($$MAGDUZ2^MAGQE5())
 S TASK=$P($G(^MAG(2006.1,REC,1)),"^",7)
 I TASK D  Q
 . S DIE="^MAG(2006.1,",DA=REC,DR="10///@" D ^DIE
 . S ZTSK=TASK D KILL^%ZTLOAD
 . Q:$G(XQY0)'["MAG"
 . I ZTSK(0)=1 W !,"Task is removed.  To restart execute option MAGREPSTART"
 . E  W !,"Could not stop task or task was no longer active."
 . Q
 I $G(XQY0)["MAG" W !,"No task to stop."
 Q
 ;
UPPER(X) ;
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
