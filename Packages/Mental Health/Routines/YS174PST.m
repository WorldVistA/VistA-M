YS174PST ;SLC/KCM - Patch 174 Post-init  ; 12/10/2020
 ;;5.01;MENTAL HEALTH;**174**;Dec 30, 1994;Build 6
 ;
EDTDATE ; date used to update 601.71:18
 ;;3210210.1550
 Q
POST ; post-init
 D INSTALLQ^YTXCHG("XCHGLST","YS174PST")
 D SETCAT("CASE MIX","ADL/Func Status")
 Q
SETCAT(TEST,CATNM) ; add CATegory to TEST if not already there
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
 ; added to data screen:
 ; I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS174PST")
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
ENTRIES ; New MHA instruments ^ Exchange Entry Date
 ;;YS*5.01*174 CASE MIX^02/10/2021@16:54:16
 ;;zzzzz
