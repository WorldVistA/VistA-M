YS255PST ;ISP/LMT - Patch 255 Post-init ;Jan 31, 2025@12:20:54
 ;;5.01;MENTAL HEALTH;**255**;Dec 30, 1994;Build 13
 ;
 ;
 Q
EDTDATE ; date used to update 601.71:18
 ;;3250324.1300
 Q
 ;
PRE ; nothing necessary
 Q
 ;
POST ; post-init
 D INSTALLQ^YTXCHG("XCHGLST","YS255PST")
 D SETCAT("MAHC-10","Screening")
 D SETCAT("NSI FOR TBI","General Symptoms")
 D REACTTST("COPD")
 Q
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
REACTTST(NAME) ; Change OPERATIONAL to YES
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0))
 I +IEN'=0 D
 . S REC(10)="Y"
 . S REC(18)=$P($T(EDTDATE+1),";;",2)
 . D FMUPD^YTXCHGU(601.71,.REC,IEN)
 K REC,IEN
 S IEN=$O(^YTT(601,"B",NAME,0))
 I 'IEN QUIT
 S REC(32)="@"
 D FMUPD^YTXCHGU(601,.REC,IEN)
 Q
 ;
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ;
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS255PST")
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
 ;;YS*5.01*255 COWS^03/07/2025@15:38:13
 ;;YS*5.01*255 MAHC-10^03/18/2025@13:02:50
 ;;YS*5.01*255 NSI FOR TBI^03/18/2025@13:03:16
 ;;zzzzz
 ;
 Q
