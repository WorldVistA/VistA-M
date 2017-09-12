YS60PRE ; HIOFO/hrubovcak,FT - PATCH YS*5.01*60 pre-init. ;8/8/12 3:59pm
 ;;5.01;MENTAL HEALTH;**60**;Dec 30, 1994;Build 47
 ; pre-init  to delete Mental Health files
 ;Reference to XLFDT APIs supported by DBIA #10103
 ;Reference to XPDUTL APIs supported by DBIA #10141
 ;Reference to LIST^DIC(19, supported by DBIA #10075
 ;Reference to ^%ZOSF supported by IA #10096
 ;
EN ;
 D ENTDEL,D60186,D60187
 Q
 ;
ENTDEL ;file entry deletion
 ;;605;MH TEXT;^YTX(
 ;;627.99;DSM CONVERSION;^YSD(627.99,
 ;;628;YSEXPERT;^YS(628,
 ;* end of file list *
 ;
 D MES^XPDUTL("File entry deletion started "_$$NOW)
 ; delete file entries first
 K DA,DIK,DIU,X,Y,YSCNT,YSDA,YSDELDT,YSDTAFND,YSL,YSND,YSNOW,YSUB
 F YSL=1:1 S X=$P($T(ENTDEL+YSL),";;",2) Q:X=""  D
 .S DIK=$P(X,";",3),YSDA=0,YSCNT=0 D MES^XPDUTL("  Deleting entries for "_DIK)
 .F  S YSDA=$O(@(DIK_YSDA_")")) Q:'YSDA  S DA=YSDA,YSCNT=YSCNT+1 D ^DIK
 .S Y=" Deleted "_$S(YSCNT=0:"Zero",1:$FN(YSCNT,","))_" entr"_$S(YSCNT=1:"y",1:"ies")  D MES^XPDUTL(Y)
 ;
 ;backup and delete 1 file
 ;624;JOB BANK;^YSG("JOB",
 ;
 ;YSDTAFND - flag, indicates data found
 S YSND="YS*5.01*60",YSDTAFND=0
 S YSNOW=$$NOW,YSDELDT=$$H2F^XLFDT($H+93) ; 3 months (93 days)
 F YSUB="JOB" D
 .Q:$O(^YSG(YSUB,0))=""  S X=$G(^(0))  ; quit if no data
 .S Y=$P(X,U) D MES^XPDUTL("Saving "_Y_" data to ^XTMP("_YSND_")")
 .M ^XTMP(YSND,YSNOW,YSUB)=^YSG(YSUB)  ; YSNOW allows multiple runs of pre-init
 .; cleanup data, leave file's zero node
 .S YSDTAFND=YSDTAFND+1,X=0 F  S X=$O(^YSG(YSUB,X)) Q:X=""  K ^YSG(YSUB,X)
 .D MES^XPDUTL("Entries in "_Y_" deleted.")
 ;
 ; if data found set zero node
 S:YSDTAFND ^XTMP(YSND,0)=YSDELDT_U_YSNOW_U_"Backup for "_YSND_" installation"
 ;
 D MES^XPDUTL("File entry deletion finished "_$$NOW)
 ;
 K DA,DIK,DIU,X,Y,YSCNT,YSDA,YSDELDT,YSDTAFND,YSL,YSND,YSNOW,YSUB
 Q
 ;
 ; now, external format
NOW() Q $$FMTE^XLFDT($$NOW^XLFDT)
 ;
CHKSUM(RTN) ; function, return routine Checksum
 N %,%1,%2,%3,X,Y S X=$G(RTN) Q:X="" "*"
 X ^%ZOSF("RSUM1") Q Y
 ;
D60186 ;Delete entries where SCALEGROUPNAME="RPCBroker1" in MH SCALEGROUPS file (601.86)
 N DA,DIK,X,YSC,YSIEN
 S YSC=0  ; counter
 F YSIEN=127:1:131 D
 .Q:$P($G(^YTT(601.86,YSIEN,0)),U,3)'="RPCBroker1"  ;wrong entry
 .S DA=YSIEN,DIK="^YTT(601.86,"
 .D ^DIK S YSC=YSC+1
 ;
 S X="Deleted "_$S(YSC:YSC,1:"zero")_" entr"_$S('(YSC=1):"ies",1:"y")_" in MH SCALEGROUPS File (#601.86)"
 D MES^XPDUTL(X)
 Q
D60187 ;Delete entries where SCALE NAME="R1 Scale" in MH SCALES file (601.87)
 N DA,DIK,X,YSC,YSIEN
 S YSC=0  ; counter
 F YSIEN=497,498 D
 .Q:$P($G(^YTT(601.87,YSIEN,0)),U,4)'="R1 Scale"  ;wrong entry
 .S DA=YSIEN,DIK="^YTT(601.87,"
 .D ^DIK S YSC=YSC+1
 ;
 S X="Deleted "_$S(YSC:YSC,1:"zero")_" entr"_$S('(YSC=1):"ies",1:"y")_" in MH SCALES File (#601.87)"
 D MES^XPDUTL(X)
 Q
 ;
