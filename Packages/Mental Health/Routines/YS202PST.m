YS202PST ;BAL/KTL - Patch 202 Post-Init ; Apr 01, 2021@16:31
 ;;5.01;MENTAL HEALTH;**202**;Dec 30, 1994;Build 47
 ;
 ; Reference to OPTION in ICR #10075
 ; Reference to XPAR in ICR #2263
 ; Reference to DIQ in ICR #2056
 Q
EDTDATE ; date used to update 601.71:18
 ;;3220909.1029
 Q
POST ; Post-init for YS*5.01*202
 N YNOW,YSDT,NDX
 D DEQUEUE
 D RMPARM
 D RMWIDG
 S NDX="YSB-DASH-"
 F  S NDX=$O(^XTMP(NDX)) Q:NDX=""!(NDX'["YSB-DASH")  D
 . K ^XTMP(NDX)  ;Clear cached data if present
 D INSTALLQ^YTXCHG("XCHGLST","YS202PST")
 D UPDTST("PCL-5")
 D UPDTST("PCL-5 WEEKLY")
 D UPDTST("CSI PARTNER VERSION")
 D UPDTST("CAD-PTSD-DX")
 D UPDTST("MCMI4")
 D CHGCAT("Cognitive","Cognitive/Learning")
 D SETCAT("CAT-PSYCHOSIS","CAT/CAD")
 D SETCAT("CAT-PSYCHOSIS","Psychosis")
 D SETCAT("EHS-14","Employment")
 D SETCAT("PEBS-20","Employment")
 D SETCAT("PEBS-27","Employment")
 D SETCAT("WBS","Screening")
 D SETCAT("WBS","Quality of Life")
 D SETCAT("ASRS","Screening")
 D SETCAT("ASRS","Cognitive/Learning")
 D SETCAT("DAR-5","Screening")
 D SETCAT("DAR-5","Frequent MBCs")
 D UPDREV("FAST",2)
 D DROPTST("CAT-PTSD")
 D DROPTST("CAT-ADHD")
 D DROPTST("CAT-SDOH")
 D RMBLNK("BASIS-24")
 D UPDURL
 S OLD="SCL90R",NEW="SCL9R" D CHGNM(OLD,NEW)  ;Revert back the name if it was changed
 D UPDINTRP^YS202TXT
 ;D UPD^YS202UPT  ;Update Print Titles in MH TEST/SURVEY SPEC file.
 Q
UPDTST(NAME) ; Update Date Edited
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
RMBLNK(NAME)  ; Remove blank fields from instrument
 N YSIEN,IEN,REC,YSTMP,DIERR,FLD
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S YSIEN=IEN_","
 D GETS^DIQ(601.71,YSIEN,"4;5;7.5;12;13;14","","YSTMP","DIERR")
 Q:+$G(DIERR)'=0
 F FLD=4,5,7.5,12,13,14 D
 . I $G(YSTMP(601.71,YSIEN,FLD))=" " S REC(FLD)="@"
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
DEQUEUE ;Dequeue Old Taskman job if present
 N YSRET,YST,ZTSK
 K ^TMP($J)
 D RTN^%ZTLOAD("VST^YSBBKG",.YSRET)
 S YST=0 F  S YST=$O(^TMP($J,YST)) Q:YST=""  D
 . S ZTSK=YST
 . D STAT^%ZTLOAD
 . I $G(ZTSK(1))=1 D REM(YST)  ;Remove Active
 K ^TMP($J)
 Q
REM(TSK) ;
 N ZTSK
 S ZTSK=TSK
 D KILL^%ZTLOAD
 Q
RMPARM ;Remove Parameters no longer used
 N ERR
 D EN^XPAR("SYS","YSB CSRE HF CATEGORY",1,"@",.ERR)
 D EN^XPAR("SYS","YSB SAFETY PLAN HF CATEGORY",1,"@",.ERR)
 Q
RMWIDG ;Remove MBC Widget
 N FDA,YSIEN
 S YSIEN=$O(^YSD(605.1,"B","MBC",""))
 Q:YSIEN=""
 S FDA(605.1,YSIEN_",",.01)="@"
 D FILE^DIE("","FDA")
 Q
UPDREV(NAME,REV) ; Update scoring revision
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(93)=REV
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
DROPTST(NAME) ; Change OPERATIONAL to dropped
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(10)="D"
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
NEWCAT(CATNM) ; add new category
 I $D(^YTT(601.97,"B",CATNM)) QUIT  ; already there
 N REC
 S REC(.01)=CATNM
 D FMADD^YTXCHGU(601.97,.REC)
 Q
SETCAT(TEST,CATNM) ; add category to TEST if not already there
 N CAT
 I TEST'=+TEST S TEST=$O(^YTT(601.71,"B",TEST,0)) QUIT:'TEST
 S CAT=$O(^YTT(601.97,"B",CATNM,0)) QUIT:'CAT
 I $D(^YTT(601.71,TEST,10,"B",CAT))=10 QUIT  ; already there
 ;
 N YTFDA,YTIEN,DIERR
 S YTFDA(601.71101,"+1,"_TEST_",",.01)=CATNM
 D UPDATE^DIE("E","YTFDA","YTIEN")
 I $D(DIERR) D MES^XPDUTL(CATNM_": "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 Q
CHGCAT(OLD,NEW) ; change category name
 N IEN,REC
 S IEN=$O(^YTT(601.97,"B",OLD,0)) Q:'IEN
 S REC(.01)=NEW
 D FMUPD^YTXCHGU(601.97,.REC,IEN)
 Q
 ;
XCHGLST(ARRAY) ; return array of instrument exchange entries
 ; ARRAY(cnt,1)=instrument exchange entry name
 ; ARRAY(cnt,2)=instrument exchange entry creation date
 ;
 N I,X
 F I=1:1 S X=$P($T(ENTRIES+I),";;",2,99) Q:X="zzzzz"  D
 . S ARRAY(I,1)=$P(X,U)
 . S ARRAY(I,2)=$P(X,U,2)
 Q
UPDURL ; Update GUI TOOLS URL for MHA Web
 N LIST,PARM,ERR,ENT,INST,VAL,TITL,CMD,SPEC,NEWVAL
 K ^TMP($J,"XPAR")
 S LIST=$NA(^TMP($J,"XPAR"))
 S PARM="ORWT TOOLS MENU"
 D ENVAL^XPAR(LIST,PARM,"",.ERR,1)
 S ^XTMP("YS202-TOOLS",0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"MH Backup Tools Menu"
 M ^XTMP("YS202-TOOLS","XPAR")=^TMP($J,"XPAR")
 S SPEC("/home?")="/home/b/?",SPEC("/home/?")="/home/b/?"  ;In case URL entered home/? Patch 187 to 202
 S SPEC("/home/a/?")="/home/b/?"  ;Patch 199 to 202
 S ENT="" F  S ENT=$O(^TMP($J,"XPAR",ENT)) Q:ENT=""  D
 . S INST=0 F  S INST=$O(^TMP($J,"XPAR",ENT,INST)) Q:+INST=0  D
 .. S VAL=^TMP($J,"XPAR",ENT,INST)
 .. I (VAL["mha.domain.ext/app/home?"!(VAL["mha.domain.ext/app/home/")) D
 ... S TITL=$P(VAL,"="),CMD=$P(VAL,"=",2,99)
 ... S CMD=$$REPLACE^XLFSTR(CMD,.SPEC)
 ... S NEWVAL=TITL_"="_CMD
 ... D BMES^XPDUTL("Updating "_CMD_" for "_ENT)
 ... D EN^XPAR(ENT,PARM,INST,NEWVAL,.ERR)
 K ^TMP($J,"XPAR")
 Q
CHGNM(OLD,NEW) ; Change test name
 N REC,IEN
 S IEN=$O(^YTT(601.71,"B",OLD,0))
 I 'IEN QUIT  ; already updated
 S REC(.01)=NEW
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
 ;
ENTRIES ; New MHA instruments^Exchange Entry Date
 ;;YS*5.01*202 PRINT TITLE UPDATE^04/08/2022@16:02:13
 ;;YS*5.01*202 NEW INSTRUMENTS^05/31/2022@11:02:45
 ;;YS*5.01*202 MCMI4 UPDATE^06/08/2022@17:49:11
 ;;zzzzz
 ;
 Q
