ECDEAL2 ;ALB/MRY - Remove DSS UNITS from terminated users; 03 JUL 2009
 ;;2.0; EVENT CAPTURE ;**100**;8 May 96;Build 21
 Q
USER ;
 N ECDUZ,X,CNT,DSSU,DSSUN S (CNT,ECDUZ)=0
 K ^TMP($J,"ECDEAL2"),^TMP("ECDEAL2",$J)
 F  S ECDUZ=$O(^VA(200,ECDUZ)) Q:'ECDUZ  D
 . S X=$$ACTIVE^XUSER(ECDUZ) I +X Q
 . I $P(X,"^",2)'="TERMINATED" Q
 . I '$O(^VA(200,ECDUZ,"EC",0)) Q
 . S CNT=CNT+1,DSSU=0
 . F  S DSSU=$O(^VA(200,ECDUZ,"EC",DSSU)) Q:'DSSU  D
 . . S DSSUN=$$GET1^DIQ(724,+DSSU,.01)
 . . S ^TMP($J,"ECDEAL2",DSSUN,$P(^VA(200,ECDUZ,0),"^"),ECDUZ)=""
 . S DA(1)=ECDUZ,DA=0 F I=0:0 S DA=$O(^VA(200,DA(1),"EC",DA)) Q:'DA  S DIK="^VA(200,"_DA(1)_",""EC""," D ^DIK
 . K DA,DIK
 I CNT=0 K ^TMP($J,"ECDEAL2"),^TMP("ECDEAL2",$J) Q
 ;
MSG ;generate message to ECXMGR mailgroup
 N X,XMDUZ,XMTEXT,XMSUB,XMY,LINECT,DSSUN,EC200
 S XMDUZ="EVENT CAPTURE",XMSUB="Removed Terminated Users from DSS UNIT Access"
 S XMTEXT="^TMP(""ECDEAL2"",$J,",XMY(DUZ)="",XMY("G.ECMGR")=""
 S ^TMP("ECDEAL2",$J,1)="Event Capture - Terminated Users removed from DSS UNITS"
 S ^TMP("ECDEAL2",$J,2)=""
 S ^TMP("ECDEAL2",$J,3)="Total number of Terminated users: "_CNT
 S ^TMP("ECDEAL2",$J,4)=""
 S ^TMP("ECDEAL2",$J,5)="DSS UNITS           NAME of Terminated User Removed from DSS UNIT"
 S ^TMP("ECDEAL2",$J,6)="-----------------------------------------------------------------"
 S LINECT=6
 S DSSUN="",CNT=0
 F  S DSSUN=$O(^TMP($J,"ECDEAL2",DSSUN)) Q:DSSUN=""  D
 . S SPACES="",SPACESN=0
 . S ^TMP("ECDEAL2",$J,LINECT+1)=DSSUN
 . S SPACESN=20-(+$L(DSSUN)) F I=1:1:SPACESN S SPACES=SPACES_" "
 . S LINECT=LINECT+1
 . S CNT=0,EC200=""
 . F  S EC200=$O(^TMP($J,"ECDEAL2",DSSUN,EC200)) Q:EC200=""  D
 . . S CNT=CNT+1
 . . I CNT=1 S ^TMP("ECDEAL2",$J,LINECT)=^TMP("ECDEAL2",$J,LINECT)_SPACES_EC200
 . . I CNT>1 S ^TMP("ECDEAL2",$J,LINECT+1)="                    "_EC200
 . . S LINECT=LINECT+1,CNT=CNT+1
 . S ^TMP("ECDEAL2",$J,LINECT+1)=" ",LINECT=LINECT+1
 I CNT=0 S ^TMP("ECDEAL2",$J,LINECT+1)="No terminated users to display."
 D ^XMD K ^TMP("ECDEAL2",$J),^TMP($J,"ECDEAL2"),XMY
 Q
