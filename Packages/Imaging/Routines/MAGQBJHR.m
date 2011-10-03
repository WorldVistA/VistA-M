MAGQBJHR ;WOIFO/RP; Report of Currently Queued items [ 03/28/2001 18:40 ]
 ;;3.0;IMAGING;**20**;Apr 12, 2006
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a Class II medical device.  As such, it may not be changed    |
 ;; | in any way.  Modifications to this software may result in an  |
 ;; | adulterated medical device under 21CFR820, the use of which   |
 ;; | is considered to be a violation of US Federal Statutes.       |
 ;; +---------------------------------------------------------------+
 ;;
 ;Report of currently queued JBTOHD
JHRPT(RESULT) ;[MAGQ JH RPT]
 N INDEX,CNT,TYPE,SUBTYPE,PDUZ,PAT,IEN,QUEUER,SESS,PLACE
 S TYPE="JBTOHD",CNT=-1,PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 ;S INDEX=550
 S INDEX=$P($G(^MAGQUEUE(2006.031,$O(^MAGQUEUE(2006.031,"C",PLACE,TYPE,0)),0)),"^",2)
 D SL("Current JBTOHD queue: "_INDEX_" "_$P($G(^MAGQUEUE(2006.03,INDEX,0)),"^",4),2)
 F  S INDEX=$O(^MAGQUEUE(2006.03,"C",PLACE,TYPE,INDEX)) Q:INDEX'?1N.N  D
 . S NODE=$G(^MAGQUEUE(2006.03,INDEX,0))
 . Q:NODE=""
 . S SUBTYPE=$P(NODE,"^",8),PDUZ=+$P(NODE,"^",2),IEN=$P(NODE,"^",7)
 . S PAT=+$P($G(^MAG(2005,IEN,0)),"^",7)
 . S:'$D(^TMP("MAGQJDE",$J,PDUZ,0,PAT,0)) ^TMP("MAGQJDE",$J,PDUZ,0,PAT,0)=INDEX
 . S ^TMP("MAGQJDE",$J,PDUZ,0,PAT)=+$G(^TMP("MAGQJDE",$J,PDUZ,0,PAT))+1
 . S ^TMP("MAGQJDE",$J,PDUZ,0)=+$G(^TMP("MAGQJDE",$J,PDUZ,0))+1
 . S ^TMP("MAGQJDE",$J,PDUZ,SUBTYPE)=+$G(^TMP("MAGQJDE",$J,PDUZ,SUBTYPE))+1
 ;Reporting
 S INDEX=""
 N TITLE
 F  S INDEX=$O(^TMP("MAGQJDE",$J,INDEX)) Q:INDEX'?1N.N  D
 . S QUEUER=$$GET1^DIQ(200,INDEX,.01)
 . Q:QUEUER=""
 . D SL("Image Queuer: "_QUEUER,2)
 . S TITLE=$$GET1^DIQ(200,INDEX,20.3)
 . S:TITLE="" TITLE=$$GET1^DIQ(200,INDEX,8)
 . D SL("  "_TITLE_"-"_$$GET1^DIQ(200,INDEX,29),1)
 . D SL("  "_"Number of Queues: "_^TMP("MAGQJDE",$J,INDEX,0),1)
 . D SESS(QUEUER,.SESS)
 . N INDX S INDX=""
 . F  S INDX=$O(SESS(INDX)) Q:INDX'?1N.N  D
 . . D SL("  Today's WS logins: "_$P(SESS(INDX),"^")_" Display Version: "_$P(SESS(INDX),"^",2),1)
 . S INDX=$O(^MAG(2006.19,"AC",INDEX,""))
 . I INDX?1N.N D SL("  Queuer's View of Jukebox images: "_$S($P(^MAG(2006.19,INDX,0),"^",6)=1:"true",1:"false"),1)
 . D SUBT(INDEX)
 . D PATIN(INDEX)
 . D SL(" ",1)
 K ^TMP("MAGQJDE")
 Q
SL(LINE,CR) ;
 S CNT=CNT+1
 S RESULT(CNT)=LINE
 Q
SESS(ID,SESS) ;
 N INDX,NODE,TODAY,DONE,WS,WSNODE
 K SESS
 S INDX=" ",DONE=0
 D NOW^%DTC S TODAY=$P(%,".")
 F  S INDX=$O(^MAG(2006.82,"B",+ID,INDX),-1) Q:INDX'?1N.N  D  Q:DONE
 . S NODE=$G(^MAG(2006.82,INDX,0))
 . I $P($P(NODE,"^",3),".")<TODAY S DONE=1 Q
 . S WS=$P(NODE,"^",5)
 . S WSNODE=$G(^MAG(2006.81,WS,0))
 . S SESS(WS)=$P(WSNODE,"^")_"^"_$P(WSNODE,"^",9)
 Q
PATIN(MD) ;
 N PID
 S PID=0
 F  S PID=$O(^TMP("MAGQJDE",$J,MD,0,PID)) Q:PID'?1N.N  D
 . D SL("  Patient: "_$P($G(^DPT(PID,0)),"^")_" - "_$G(^TMP("MAGQJDE",$J,MD,0,PID,0)),1)
 Q
SUBT(MD) ;
 N SUBTYPE
 S SUBTYPE=0
 F  S SUBTYPE=$O(^TMP("MAGQJDE",$J,MD,SUBTYPE)) Q:SUBTYPE=""  D
 . D SL("  Number of "_SUBTYPE_" : "_^TMP("MAGQJDE",$J,MD,SUBTYPE),1)
 Q
