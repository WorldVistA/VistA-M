XUS6 ;ISCSF/RWF - Clear users at startup. ;06/17/2003  13:18
 ;;8.0;KERNEL;**258,312**;Jul 10, 1995
 I '$D(ZTQUEUED) W !,"This is only to be run by taskman at startup." Q
A ;
 N I,J,NOW,FDA,IEN,ERR S I=0,NOW=$$NOW^XLFDT
 F  S I=$O(^XUSEC(0,"CUR",I)),J=0 Q:I'>0  F  S J=$O(^XUSEC(0,"CUR",I,J)) Q:J'>0  D
 . I $D(^XUSEC(0,J,0))[0 K ^XUSEC(0,"CUR",I,J) Q  ;No data record.
 . S FDA(3.081,J_",",3)=NOW,FDA(3.081,J_",",16)=1 D UPDATE^DIE("","FDA","IEN","ERR")
 . K FDA,IEN,ERR
 . Q
 ;Clear the signed on flag.
 F I=0:0 S I=$O(^VA(200,I)) Q:I'>0  I $P($G(^VA(200,I,1.1)),U,3) S $P(^VA(200,I,1.1),U,3)=0
 Q
