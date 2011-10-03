XTERSUM3 ;ISF/RWF - Transport and save Error summaries ;03/10/11
 ;;8.0;KERNEL;**431**;Jul 10, 1995;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
SEND ;Send summary to consolidation site.
 N XMZ,XMY,XMTEXT,XTI,XT1,XT2,XT3,XTFG,FDA,XTNOW
 Q:'$P(^XTV(8989.3,1,"ZTER"),U,2)  ;Check if we should send
 S XT1=0,XTNOW=$$NOW^XLFDT
 L +^%ZTER(3.077,0):15 E  Q  ;Quit if don't get lock
 F  S XT1=$O(^%ZTER(3.077,XT1)) Q:'XT1  D
 . S XT2=$G(^(XT1,0)) I $P(XT2,"^",1)="" D REMOVE(XT1) Q
 . I $P(XT2,U,7)<$P(XT2,U,3) D SND1(XT1) ;Send if UPLOAD < MOST RECENT
 L -^%ZTER(3.077,0)
 Q
 ;
SND1(XT1) ;Send one entry
 N XTX,IEN K ^TMP($J),FDA
 D ADD("$DATA"),ADD("~~ERROR TRAP SUMMARY^3.077"),ADD("$FILE:3.077")
 S IEN=XT1_","
 D GETS^DIQ(3.077,IEN,".01;1;2;3;6;20;7","IN","XTX") ;Fields to get
 S XTI=0
 F  S XTI=$O(XTX(3.077,IEN,XTI)) Q:'XTI  D ADD("~"_XTI_":"_XTX(3.077,IEN,XTI,"I"))
 S XT2=0
 F  S XT2=$O(^%ZTER(3.077,XT1,1,XT2)) Q:'XT2  D
 . I $P(^%ZTER(3.077,XT1,1,XT2,0),U,5) Q
 . K XTX S IEN=XT2_","_XT1_","
 . D GETS^DIQ(3.07701,IEN,".01;1;2;3;13;6","IN","XTX")
 . S FDA(3.07701,IEN,19)=1 ;Mark as sent.
 . S XTI=0 D ADD("$SUB:3.07701")
 . F  S XTI=$O(XTX(3.07701,IEN,XTI)) Q:'XTI  D ADD("~"_XTI_":"_XTX(3.07701,IEN,XTI,"I"))
 . D ADD("$END")
 . Q
 D ADD("$SAVE")
 S FDA(3.077,XT1_",",8)=XTNOW D FILE^DIE("K","FDA") ;Mark as sent.
 Q:'$O(^TMP($J,0))
 N XMDUZ,XMSUB,XMTEXT,XMY,XMSTRIP,XMMG,XMZ
 S XMTEXT="^TMP($J,",XMSUB="ERROR SUMMARY - "_XTNOW
 S XMY("G.XTER SUMMARY LOAD")=""
 D ^XMD
 Q
 ;
ADD(TXT) ;
 S C=$G(^TMP($J)),C=C+1,^TMP($J)=C,^TMP($J,C,0)=TXT
 Q
 ;
 ;This is the server code.
LOAD ;Load Summary
 N XT1,XT2,XT3,FDA,XTF,XTE,XI1,XI2,XTS,XTER,DONE
 S XMER=0,XT1=0,DONE=0,XI1=1,XI2=1,XTS=0
 X XMREC I XMRG'="$DATA" D FORWARD(XMZ) Q  ;Not correct start.
 X XMREC I $E(XMRG,1,4)'="~~ER" D FORWARD(XMZ) Q
 F  X XMREC Q:XMER  D  Q:DONE  ;XMRG has line from msg
 . I $E(XMRG,1,5)="$FILE" S XTF=+$P(XMRG,":",2),XTS=0 Q
 . I $E(XMRG,1,4)="$SUB" S XTF=+$P(XMRG,":",2),XTS=1,XI2=XI2+1 Q
 . I $E(XMRG,1)="~",$L($P(XMRG,":",2)) S FDA(XTF,$$IEN(XI1,XI2,XTS),+$P(XMRG,"~",2))=$P(XMRG,":",2,99) Q
 . I $E(XMRG,1,5)="$SAVE" S DONE=1 Q
 . I $E(XMRG,1,4)="$END" S XTS=0 Q
 . Q
 S XT1=$G(FDA(3.077,$$IEN(1,,0),.01)),XT2=0 S:$L(XT1) XT2=$O(^%ZTER(3.077,"B",XT1,0)) ;See if error allready record.
 I XT2 K FDA(3.077,$$IEN(1,,0),1) ;Remove First seen so don't over write
 I $D(FDA)>2 D UPDATE^DIE("","FDA","XTE","XTER") I $D(XTER) D FORWARD(XMZ)
 Q
 ;
IEN(V1,V2,V3) ;Build an ien
 Q $S('V3:"?+"_V1_",",1:"?+"_V2_",?+"_V1_",")
 ;
FORWARD(XMZ) ;Forward to group to look at error
 N XMY,XMDUZ
 S XMY("G.XTER SUMMARY ERROR")=""
 D ENT1^XMD
 Q
 ;
REMOVE(XTA) ;Remove a dangling count record
 N XTB
 K ^%ZTER(3.077,XTA)
 S XTB=""
 F  S XTB=$O(^%ZTER(3.077,"B",XTB)) Q:XTB=""  I $D(^%ZTER(3.077,"B",XTB,XTA)) K ^%ZTER(3.077,"B",XTB)
 Q
 ;
TESTL ;
 N XMCNT,XMER,XMREC,XMRG
 R !,"Msg#: ",XMZ:DTIME Q:'XMZ
 S XMCNT=.9,XMER=0
 S XMREC="S XMCNT=$O(^XMB(3.9,XMZ,2,XMCNT)) S:'XMCNT XMER=1 Q:XMER  S XMRG=^(XMCNT,0)"
 D LOAD
 Q
