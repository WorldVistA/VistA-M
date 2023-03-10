YS141PS0 ;SLC/KCM - Patch 141 Post-Init Update Categories ; 1/27/2020
 ;;5.01;MENTAL HEALTH;**130,141**;Dec 30, 1994;Build 85
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; %ZOSV                10097
 ; DIE                   2053
 ; DIK                  10013
 ; DILF                  2054
 ; XPDUTL               10141
 ;
 Q
SHOCATS ; List out categories for inclusion in routine 
 N TEST,X,CAT,IEN,LIST
 S TEST=0 F  S TEST=$O(^YTT(601.71,TEST)) Q:'TEST  D
 . I $P($G(^YTT(601.71,TEST,2)),U,2)'="Y" QUIT  ; active instrument?
 . S X="",CAT=0 F  S CAT=$O(^YTT(601.71,TEST,10,CAT)) Q:'CAT  D
 . . S IEN=+^YTT(601.71,TEST,10,CAT,0)
 . . S X=X_$S($L(X):U,1:"")_$P(^YTT(601.97,IEN,0),U)
 . I $L(X) S LIST($P(^YTT(601.71,TEST,0),U))=X
 S X="" F  S X=$O(LIST(X)) Q:'$L(X)  W !," ;;"_X_U_LIST(X)
 Q
SETCATS ; Set categories from CATLST into 601.71
 ; Don't run this install in the dev environment
 N Y D GETENV^%ZOSV I $P(Y,U,4)="SPPNXT:VISTA" Q
 ;
 N YSI,YSJ,YSX,YSNM,YSIEN,YSCATS,YSCAT,YSCNT
 S YSCNT=0
 F YSI=1:1 S YSX=$P($T(CATLST+YSI),";;",2,99) Q:YSX="zzzzz"  D
 . S YSNM=$P(YSX,U,1),YSCATS=$P(YSX,U,2,99)
 . S YSIEN=$O(^YTT(601.71,"B",YSNM,0)) Q:'YSIEN
 . D DELCATS(YSIEN)
 . N FDA,FDAIEN,DIERR
 . F YSJ=1:1:$L(YSCATS,U) D
 . . S YSCAT=$P(YSCATS,U,YSJ) Q:'$L(YSCAT)
 . . S YSCNT=YSCNT+1
 . . S FDA(601.71101,"+"_YSJ_","_YSIEN_",",.01)=YSCAT
 . Q:$D(FDA)<10
 . D UPDATE^DIE("E","FDA","FDAIEN")
 . I $D(DIERR) D MES^XPDUTL(YSNM_": "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 . D CLEAN^DILF
 D MES^XPDUTL("Instrument categories updated: "_YSCNT)
 Q
DELCATS(YSIEN) ; Delete the categories for instrument YSIEN
 I '$O(^YTT(601.71,YSIEN,10,0)) Q  ; no child nodes
 N DA,DIK
 S DA=0,DA(1)=YSIEN,DIK="^YTT(601.71,"_DA(1)_",10,"
 F  S DA=$O(^YTT(601.71,YSIEN,10,DA)) Q:'DA  D ^DIK
 Q
CATLST ; Instrument Categories
 ;;ACE^Screening
 ;;AD8^Pain^Cognitive
 ;;BSL-23^General Symptoms
 ;;BSS^Suicide Prevention
 ;;CMQ^Sleep
 ;;EAT-26^Screening
 ;;ERS^Employment
 ;;FOCI^Anxiety/PTSD
 ;;KATZ-ADL-18PT^ADL/Func Status
 ;;MHRM-10^Recovery
 ;;SCL9R^General Symptoms
 ;;zzzzz
 ;;SIP-AD-START^Sleep
