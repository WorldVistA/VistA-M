YS269PST ;BAL/KTL - Patch 269 Post-Install ;Oct 28, 2025@15:54:23
 ;;5.01;MENTAL HEALTH;**269**;Dec 30, 1994;Build 7
 ;
 ;
 ; Reference to TIUFLF7 in ICR #5352
 ; Reference to ^XWB(8994.5, in ICR #5032
 ; Reference to ^DIC(19, in ICR #10075
 ; Reference to BMES^XPDUTL in ICR # 10141
 ; Reference to CRDD^TIUCRDD in ICR # 7179
 ;
 Q
EDTDATE ; date used to update 601.71:18
 ;;3260310.13
 Q
 ;
PRE ; nothing necessary
 Q
 ;
POST ; post-init
 ;
 D INSTALLQ^YTXCHG("XCHGLST","YS269PST")
 D SETCAT("C-SSRS_V2","Suicide Prevention")
 D SETCAT("C-SSRS_V2","Screening")
 ;
 D UPDURL  ; Update GUI TOOLS URL for MHA Web
 Q
 ;
 ;
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
 ;
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ;
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS269PST")
 Q
 ;
UPDURL ; Update GUI TOOLS URL for MHA Web
 N LIST,PARM,ERR,ENT,INST,VAL,TITL,CMD,SPEC,NEWVAL
 K ^TMP($J,"XPAR")
 S LIST=$NA(^TMP($J,"XPAR"))
 S PARM="ORWT TOOLS MENU"
 D ENVAL^XPAR(LIST,PARM,"",.ERR,1)
 S ^XTMP("YS269-TOOLS",0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"MH Backup Tools Menu"
 M ^XTMP("YS269-TOOLS","XPAR")=^TMP($J,"XPAR")
 S SPEC("/home?")="/home/patch269/?",SPEC("/home/?")="/home/patch269/?"  ;In case URL entered home/? Patch 236
 S SPEC("/home/patch236/?")="/home/patch269/?"  ;Patch 269
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
 ;
ENTRIES ; New MHA instruments ^ Exchange Entry Date
 ;;YS*5.01*269 C-SSRS_V2^03/06/2026@08:57:15
 ;;zzzzz
 ;
 Q
 ;
