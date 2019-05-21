YS148PST ;SLC/KCM - Patch 148 post-init ; 03/28/2019
 ;;5.01;MENTAL HEALTH;**148**;Dec 30, 1994;Build 8
 ;
POST ; post-init
 D EN^XPAR("SYS","YS123 RE-INDEX STATUS",1,"Re-index Skipped")
 I XPDQUES("POST-Q1")=1 QUIT  ; do nothing -- skip selected
 D QTASK(XPDQUES("POST-Q2"))
 Q
QTASK(QTIME) ; Create background task for re-indexing result files
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK,YS148IN,MSG
 S YS148IN=DUZ
 S ZTIO=""
 S ZTRTN="REIDX^YS148IDX"
 S ZTDESC="Re-index MH Results"
 S ZTDTH=QTIME
 S ZTSAVE("YS148IN")=""
 D ^%ZTLOAD
 I '$G(ZTSK) S MSG="Unsuccessful queue of re-indexing job." I 1
 E  S MSG="Re-indexing queued as TASK #"_ZTSK
 D MES^XPDUTL(MSG)
 D EN^XPAR("SYS","YS123 RE-INDEX STATUS",1,MSG)
 Q
