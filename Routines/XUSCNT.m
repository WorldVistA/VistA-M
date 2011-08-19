XUSCNT ;ISF/RWF - Job counting for GTM ;6/24/04  15:22
 ;;8.0;KERNEL;**275**;July 10, 1995;
 ;0 return CNT
 ;1 inc CNT
 ;-1 dec CNT
COUNT(INC,JOB) ;Keep count of jobs
 N XUCNT,X
 S JOB=$G(JOB,$J)
 ;Return Current Count
 I INC=0 D TOUCH Q +$G(^XUTL("XUSYS","CNT"))
 ;Increment Count
 I INC>0 D  Q
 . S X=$G(^XUTL("XUSYS",JOB,"NM")) K ^XUTL("XUSYS",JOB) S ^XUTL("XUSYS",JOB,"NM")=X
 . D TOUCH
 . L +^XUTL("XUSYS","CNT"):5
 . S XUCNT=$G(^XUTL("XUSYS","CNT"))+1,^XUTL("XUSYS","CNT")=XUCNT
 . L -^XUTL("XUSYS","CNT")
 . Q
 ;Decrement Count
 I INC<0 D  Q
 . L +^XUTL("XUSYS","CNT"):5
 . S XUCNT=$G(^XUTL("XUSYS","CNT"))-1,^XUTL("XUSYS","CNT")=$S(XUCNT>0:XUCNT,1:0)
 . L -^XUTL("XUSYS","CNT")
 . K ^XUTL("XUSYS",JOB)
 Q
 ;
CHECK(JOB) ;Check if job number active
 ; 0 = Job doesn't seem to be running
 ; 1 = Job maybe running
 ; 2 = Job still has Lock out.
 Q:$G(JOB)'>0 0
 I '$D(^XUTL("XUSYS",JOB)) Q 0
 N LK,%T
 S %T=0,LK=$$GETLOCK()
 I $L(LK) L +@LK:0 S %T=$T L:%T -@LK
 Q $S(%T:2,1:1)
 ;
SETLOCK(NLK) ;Set the Lock we will keep
 I $L($G(NLK)) S ^XUTL("XUSYS",$J,"LOCK")=NLK
 E  K ^XUTL("XUSYS",$J,"LOCK")
 D TOUCH ;Update the time
 Q
 ;
TOUCH ;Update the time
 S ^XUTL("XUSYS",$J,0)=$H
 Q
 ;
GETLOCK() ;Get the node to Lock
 Q $G(^XUTL("XUSYS",$J,"LOCK"))
 ;
CLEAR(DB) ;Check for locks and time clear old ones.
 N %J,%T,CNT,CT,LK,IM,IMAGE,H K ^TMP($J)
 D TOUCH ;See that we are current
 ;S %J=0 F  S %J=$ZPID(%J) Q:%J'>0  S ^TMP($J,%J)="",^TMP($J,%J,1)=$ZGETJPI(%J,"IMAGNAME")
 S DB=+$G(DB),IMAGE="mumps" ;$ZGETJPI($J,"IMAGNAME") ; ours
 S %J=0,CNT=0,H=$H,CT=$$H3($H)
 I DB W !,"Current Job Count: ",$$COUNT(0)
 F  S %J=$O(^XUTL("XUSYS",%J)) Q:%J'>0  D
 . S CNT=CNT+1
 . I DB W !,CNT," Job: ",%J
 . S LK=$G(^XUTL("XUSYS",%J,"LOCK")) ;Get lock name
 . I '$L(LK) W:DB " No Lock node"
 . I $L(LK) L +@LK:0 S %T=$T D  Q:'%T  L -@LK ;Quit if lock still held
 . . I '%T,DB W " Lock Held"
 . . I %T,DB W " Lock Fail"
 . S IM=$G(^TMP($J,%J,1))
 . I IM=IMAGE W:DB " Image Match: ",IM  Q
 . I IM["ZFOO.EXE" W:DB " ZFOO Image" Q  ;Quit if in same image
 . S H=$G(^XUTL("XUSYS",%J,0)) I H>0 S H=$$H3(H)
 . I H+60>CT D  Q  ;Updated in last 30 seconds.
 . .  I DB W " Current TimeStamp"
 . S NM=$G(^XUTL("XUSYS",%J,"NM"))
 . I NM["Task " S TM=+$P(NM,"Task ",2) I TM>0 D  Q:%
 . . S TM(1)=$G(^%ZTSK(TM,.1)),%=(TM(1)=5)
 . . I DB,% W " Running Task"
 . . Q
 . ;More checks
 . D COUNT(-1,%J) I DB W " Not Active: Removed" ;Not Active
 . Q
 L +^XUTL("XUSYS","CNT"):3
 S CNT=0,%J=0 F  S %J=$O(^XUTL("XUSYS",%J)) Q:%J'>0  S CNT=CNT+1
 S ^XUTL("XUSYS","CNT")=CNT
 L -^XUTL("XUSYS","CNT")
 I DB W !,"New JOB count: ",CNT
 Q
 ;
H3(%H) ;Just seconds
 Q %H*86400+$P(%H,",",2)
 ;
 ;Called from the X-REF both the volume and Max signon from file 8989.3
XREF(X1,V) ;V="S" or "K"
 N %,N
 S %=$G(^XTV(8989.3,1,4,X1,0)),N=$P(%,"^") Q:%=""
 I V="K" K ^XTV(8989.3,"AMAX",N) Q
 S ^XTV(8989.3,"AMAX",N)=$P(%,"^",3)
 Q
