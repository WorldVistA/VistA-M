YS182PST ;SLC/KCM - Patch 182 Post-init ; 12/10/2020
 ;;5.01;MENTAL HEALTH;**182**;Dec 30, 1994;Build 13
 ;
EDTDATE ; date used to update 601.71:18
 ;;3210713.2053
 Q
PRE ; nothing necessary
 Q
POST ; post-init
 D FIXCTNT
 D INSTALLQ^YTXCHG("XCHGLST","YS182PST")
 ; need to set all the categories...
 D NEWCTG("CAT/CAD")
 D SETCAT("CAT-ADHD","CAT/CAD")
 D SETCAT("CAT-ANX","CAT/CAD")
 D SETCAT("CAT-DEP","CAT/CAD")
 D SETCAT("CAT-MANIA-HYPOMANIA","CAT/CAD")
 D SETCAT("CAT-PSY-C","CAT/CAD")
 D SETCAT("CAT-PSY-S","CAT/CAD")
 D SETCAT("CAT-PTSD","CAT/CAD")
 D SETCAT("CAT-SDOH","CAT/CAD")
 D SETCAT("CAT-SS","CAT/CAD")
 D SETCAT("CAT-SUD","CAT/CAD")
 D SETCAT("CAD-MDD","CAT/CAD")
 D SETCAT("CAT-ANX","Anxiety/PTSD")
 D SETCAT("CAT-DEP","Depression")
 D SETCAT("CAT-PSY-C","Psychosis")
 D SETCAT("CAT-PSY-S","Psychosis")
 D SETCAT("CAT-PTSD","Anxiety/PTSD")
 D SETCAT("CAT-SS","Suicide Prevention")
 D SETCAT("CAT-SUD","Addiction-SUD")
 D SETCAT("CAD-MDD","Depression")
 Q
NEWCTG(CTGNM) ; add a new category name
 I $O(^YTT(601.97,"B",CTGNM,0))>0 QUIT
 N REC
 S REC(.01)=CTGNM
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
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ; 
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS182PST")
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
 ;;YS*5.01*182 NEW CAT TESTS^07/14/2021@00:00:23
 ;;zzzzz
 ;
FIXCTNT ; Remove old content entries before instrument install
 I $P($G(^YTT(601.76,8681,0)),U,2)=271 QUIT  ; already fixed
 N IEN
 F IEN=8681:1:8692 D
 . I +$P($G(^YTT(601.76,IEN,0)),U,2)<271 QUIT
 . I +$P($G(^YTT(601.76,IEN,0)),U,2)>282 QUIT
 . D FMDEL^YTXCHGU(601.76,IEN)
 Q
