XQALSUR2 ;FO-OAK.SEA/JLI-Continuation of alert surrogate processing ;9/6/05  14:23
 ;;8.0;KERNEL;**366**;Jul 10, 1995
 Q
 ; added to handle adjustment for manual or Fileman editing of surrogate on top zero node
CHEKSUBS(XQAUSER) ;
 N XQA0,XQASTR1,XQANOW,XQB0,XQB1
 S XQANOW=$$NOW^XLFDT()
 S XQA0=$G(^XTV(8992,XQAUSER,0)) I $P(XQA0,U,2)>0 D
 . N XQAFDA,XQAIEN
 . S XQASTR1=$P(XQA0,U,3) S:XQASTR1'>0 XQASTR1=XQANOW,XQAFDA(8992,XQAUSER_",",.03)=XQASTR1 I '$D(^XTV(8992,XQAUSER,2,"B",XQASTR1)) D  Q
 . . S XQAIEN="+1,"_XQAUSER_"," S XQAFDA(8992.02,XQAIEN,.01)=XQASTR1
 . . S XQAFDA(8992.02,XQAIEN,.02)=$P(XQA0,U,2) S:$P(XQA0,U,4)>0 XQAFDA(8992.02,XQAIEN,.03)=$P(XQA0,U,4)
 . . D UPDATE^DIE("","XQAFDA")
 . . Q
 . K XQAFDA S XQB0=$O(^XTV(8992,XQAUSER,2,"B",XQASTR1,0))
 . I XQB0>0 S XQB1=^XTV(8992,XQAUSER,2,XQB0,0) I $P(XQB1,U,3)>0,$P(XQA0,U,4)="" D
 . . ; have an entry appearing to have ended, but still data on zero node.
 . . I $P(XQB1,U,3)<XQANOW D  Q
 . . . ; add a matching subfile with startdate two seconds before, and end to now less one second - next time it is looked at it will be removed.
 . . . S XQAFDA(8992,XQAUSER_",",.03)=XQASTR1-.000002,XQAFDA(8992,XQAUSER_",",.04)=XQANOW-.000001 D FILE^DIE("","XQAFDA") K XQAFDA
 . . . S XQAIEN="+1,"_XQAUSER_",",XQAFDA(8992.02,XQAIEN,.01)=XQASTR1-.000002,XQAFDA(8992.02,XQAIEN,.02)=$P(XQA0,U,2),XQAFDA(8992.02,XQAIEN,.03)=XQANOW-.000001 D UPDATE^DIE("","XQAFDA")
 . . . Q
 . . ; add end date/time in future to zero node
 . . S $P(^XTV(8992,XQAUSER,0),U,4)=$P(XQB1,U,3) ; set 0 node end date/time to that of the subfile
 . . Q
 . Q
 Q
