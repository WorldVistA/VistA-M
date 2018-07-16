DGNOZMH ;ALB/CLT,DJS - NO ZMH SEGMENT IN Z11 HL7 MESSAGE AND CLEAN UP INCOMPLETE MILITARY SERVICE EPISODES ;17 Mar 2018  12:09pm
 ;;5.3;REGISTRATION;**935,959**;AUG 13, 1993;Build 7
 ;
 ;The primary purpose of this routine is to delete all HEC issued military service episodes (MSE).
 ;Also used to delete any incomplete MSEs (no Discharge Date and no Future Discharge Date).
 ;
EN(DFN) ;Primary entry point
 Q:$G(^DPT(DFN,.3216,0))="^2.3216D"
 N DGMSE,DGMSEDT,DGMSEREC,DGDFLG,DIK,DA
 S DGMSEDT=""
 F  S DGMSEDT=$O(^DPT(DFN,.3216,"B",DGMSEDT),-1) Q:DGMSEDT=""  D
 . S DGMSE="",DGMSE=$O(^DPT(DFN,.3216,"B",DGMSEDT,DGMSE))
 . S DGMSEREC=^DPT(DFN,.3216,DGMSE,0)
 . S DGDFLG=0
 . I $P(DGMSEREC,U,7)=1 S DGDFLG=1 ;if data is locked by HEC
 . E  D
 . . Q:$P(DGMSEREC,U,2)'=""  ;quit if Service Separation Date not null
 . . Q:$P(DGMSEREC,U,8)'=""  ;quit if Future Discharge Date not null
 . . S DGDFLG=1 Q
 . I +DGDFLG S DA=DGMSE,DA(1)=DFN,DIK="^DPT("_DA(1)_","_.3216_"," D ^DIK
 Q
 ;
ID1(DFN,DA,DGNEW) ;DELETE AN MSE IF INCOMPLETE
 Q:$G(DGNEW)=1
 G:$G(DA)="" IDQ
 Q:$L($P($G(^DPT(DFN,.3216,DA,0)),U,2))>4
 Q:$P(^DPT(DFN,.3216,DA,0),U,8)'=""
 S DA(1)=DFN,DIK="^DPT("_DA(1)_","_.3216_"," D ^DIK K DIK
IDQ ;
 Q
