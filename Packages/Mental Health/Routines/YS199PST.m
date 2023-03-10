YS199PST ;BAL/KTL - Patch 199 Post-init ; 01/27/2022
 ;;5.01;MENTAL HEALTH;**199**;Dec 30, 1994;Build 18
 ;
 ; Reference to EN^XPAR in ICR #2263
 ; Reference to GETLST^XPAR in ICR #2263
 ; Reference to XLFSTR in ICR #10104
 Q
EDTDATE ; date used to update 601.71:18
 ;;3220127.2029
 Q
PRE ; nothing necessary
 Q
POST ; post-init
 D INSTALLQ^YTXCHG("XCHGLST","YS199PST")
 D UPDTST("BARTHEL INDEX")
 D UPDTST("BASIS-24 PSYCHOSIS")
 D UPDTST("BBHI-2")
 D UPDTST("BPRS-A")
 D UPDTST("C-SSRS")
 D UPDTST("I9+C-SSRS")
 D UPDTST("PSS-3")
 D UPDTST("PSS-3 2ND")
 D UPDTST("WHODAS2.0-12")
 D CATS4CAT
 D UPDURL
 Q
 ;
UPDTST(NAME) ; Update Date Edited
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
 ;
CATS4CAT ; Add categories for new CAT's
 D SETCAT("CAD-PTSD-DX","CAT/CAD")
 D SETCAT("CAD-PTSD-DX","Anxiety/PTSD")
 D SETCAT("CAT-PTSD-E","CAT/CAD")
 D SETCAT("CAT-PTSD-E","Anxiety/PTSD")
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
 ;
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ; 
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS199PST")
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
 S ^XTMP("YS199-TOOLS",0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"MH Backup Tools Menu"
 M ^XTMP("YS199-TOOLS","XPAR")=^TMP($J,"XPAR")
 S SPEC("/home?")="/home/a/?",SPEC("/home/?")="/home/a/?"  ;In case URL entered home/?
 S ENT="" F  S ENT=$O(^TMP($J,"XPAR",ENT)) Q:ENT=""  D
 . S INST=0 F  S INST=$O(^TMP($J,"XPAR",ENT,INST)) Q:+INST=0  D
 .. S VAL=^TMP($J,"XPAR",ENT,INST)
 .. I (VAL["mha.domain.ext/app/home?"!(VAL["mha.domain.ext/app/home/?")) D
 ... S TITL=$P(VAL,"="),CMD=$P(VAL,"=",2,99)
 ... S CMD=$$REPLACE^XLFSTR(CMD,.SPEC)
 ... S NEWVAL=TITL_"="_CMD
 ... D BMES^XPDUTL("Updating "_CMD_" for "_ENT)
 ... D EN^XPAR(ENT,PARM,INST,NEWVAL,.ERR)
 K ^TMP($J,"XPAR")
 Q
ENTRIES ; New MHA instruments^Exchange Entry Date
 ;;YS*5.01*199 UPDATES^01/27/2022@09:02:19
 ;;YS*5.01*199 CAT PTSD^02/28/2022@16:15:18 
 ;;zzzzz
