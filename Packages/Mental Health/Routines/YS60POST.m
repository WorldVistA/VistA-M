YS60POST ; HIOFO/hrubovcak,FT - PATCH YS*5.01*60 post-init. ;8/8/12 4:07pm
 ;;5.01;MENTAL HEALTH;**60**;Dec 30, 1994;Build 47
 ; post-init  to delete FileMan files
 ;Reference to EN^DIU2 supported by DBIA #10014
 ;Reference to XPDUTL APIs supported by DBIA #10141
 ;Reference to XLFDT APIs supported by DBIA #10103
 ;
EN ;
 D DELFLS,DDMOD,FX60193
 Q
 ;
DELFLS ; files to be deleted
 ; # ; name  ; storage global
 ;602;MENTAL HEALTH SITE PARAMETERS;^YSA(602,
 ;605;MH TEXT;^YTX(
 ;624;JOB BANK;^YSG("JOB",
 ;627.99;DSM CONVERSION;^YSD(627.99,
 ;628;YSEXPERT;^YS(628,
 ;
 D MES^XPDUTL("File deletion started "_$$NOW)
 ; delete DD's, sub-files first
 K DIU
 ; MENTAL HEALTH SITE PARAMETERS (#602)
 F DIU=602.01,602.015 S DIU(0)="DET" D EN^DIU2
 S DIU=602,DIU(0)="DET" D EN^DIU2
 ; MH TEXT (#605)
 S DIU=605.01,DIU(0)="DET" D EN^DIU2
 S DIU=605,DIU(0)="ET" D EN^DIU2  ; leave data to prevent <PROTECT> error
 ; JOB BANK (#624)
 S DIU=624,DIU(0)="DET" D EN^DIU2
 ; DSM CONVERSION (#627.99)
 F DIU=627.99103,627.9901,627.99111,627.99 S DIU(0)="DET" D EN^DIU2
 ; YSEXPERT (#628)
 F DIU=628.232,628.23,628.02,628 S DIU(0)="DET" D EN^DIU2
 ;
 ; delete any ^YSG("ERR") data
 N J,C S J="",C=0
 F  S J=$O(^YSG("ERR",J)) Q:J=""  S C=C+1  ; count entries
 K ^YSG("ERR") D MES^XPDUTL("Deleted "_$FN(C,",")_" entr"_$S(C'=1:"ies",1:"y")_" from ^YSG(""ERR"")")
 ;
 ; 605;MH TEXT;^YTX(
 ; delete ^YTX data, prevent <PROTECT> error
 ; don't touch ^YTX(614.501,0)="MH INSTRUMENT EXCHANGE LOG^614.501"
 S J="" F  S J=$O(^YTX(J)) Q:(J="")!(J>600)  K ^YTX(J)
 ;
 D MES^XPDUTL("File deletion finished "_$$NOW)
 ;
 K DIU
 Q
 ;
DDMOD ; modify DD access
 ;
 D MES^XPDUTL("Updating DD access "_$$NOW)
 N J,YSF,YSLN,X
 F YSLN=1:1 S X=$P($T(DDLST+YSLN),";;",2),YSF=$P(X,U) Q:'YSF  D
 .Q:'$$VFILE^DILFD(YSF)  ; does the file exist?
 .N YSECURTY,YSDDERR
 .F J="DD","RD","WR","DEL","LAYGO","AUDIT" S YSECURTY(J)="@"
 .D FILESEC^DDMOD(YSF,.YSECURTY,"YSDDERR")
 .D MES^XPDUTL("Updated the DD for file #"_YSF)
 ;
 Q
 ;
FX60193 ; strip control chars. in W-P field in file #601.93
 D MES^XPDUTL("Checking entries in file 601.93 "_$$NOW)
 D AL60193^YTRPWRP
 D MES^XPDUTL("Done checking file 601.93 "_$$NOW)
 Q
 ;
 ; now, external format
NOW() Q $$FMTE^XLFDT($$NOW^XLFDT)
 ;
DDLST ; list of data dictionaries to have security updated
 ;;90^MEDICAL RECORD
 ;;99^PT. TEXT
 ;;615^MH CLINICAL FILE
 ;;600.7^CRISIS NOTE DISPLAY
 ;;617^MH WAIT LIST
 ;;618^MENTAL HEALTH CENSUS
 ;;618.2^MENTAL HEALTH TEAM
 ;;618.4^MENTAL HEALTH INPT
 ;;620^PROBLEM
 ;;625^INDICATOR
 ;
