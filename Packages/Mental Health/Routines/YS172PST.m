YS172PST ;SLC/KCM - Patch 172 Post-init  ; 12/10/2020
 ;;5.01;MENTAL HEALTH;**172**;Dec 30, 1994;Build 10
 ;
EDTDATE ; date used to update 601.71:18
 ;;3210222.1212
 Q
PRE ; nothing necessary
 Q
POST ; post-init
 D INSTALLQ^YTXCHG("XCHGLST","YS172PST")
 D SETCAT("PHI","Quality of Life")
 D SETAD8
 Q
 ;
SETAD8 ; Update key fields in AD8
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B","AD8",0)) Q:'IEN
 S REC(9)=""    ; remove YSP key requirement
 S REC(26)="Y"  ; write full text
 S REC(28)="Y"  ; generate progress note
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
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
 ;;YS*5.01*172 PHI^12/10/2020@13:15:37
 ;;YS*5.01*172 AD8 Report^03/16/2021@11:52:24 
 ;;zzzzz
