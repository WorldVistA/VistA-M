YS177PST ;SLC/KCM - Patch 177 Post-init ; 12/10/2020
 ;;5.01;MENTAL HEALTH;**177**;Dec 30, 1994;Build 6
 ;
EDTDATE ; date used to update 601.71:18
 ;;3210510.2029
 Q
PRE ; nothing necessary
 Q
POST ; post-init
 D INSTALLQ^YTXCHG("XCHGLST","YS177PST")
 D SETCAT("SRCS","EBP")
 D SETCAT("SRCS","Depression")
 D SETCAT("SRCS","Suicide Prevention")
 D SETCAT("NPO-Q","EBP")
 D SETCAT("NPO-Q","Quality of Life")
 D SETCAT("B-IPF","EBP")
 D SETCAT("B-IPF","Quality of Life")
 Q
 ;
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
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ; 
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS177PST")
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
ENTRIES ; New MHA instruments^Exchange Entry Date
 ;;YS*5.01*177 NEW INSTRUMENTS^05/10/2021@23:36:27
 ;;YS*5.01*177 FOCI CORRECTION^05/11/2021@10:50:12
 ;;zzzzz
