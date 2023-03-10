YS173PST ;SLC/KCM - Patch 173 Post-init  ; 12/10/2020
 ;;5.01;MENTAL HEALTH;**173**;Dec 30, 1994;Build 10
 ;
EDTDATE ; date used to update 601.71:18
 ;;3210210.1454
 Q
PRE ; nothing necessary
 Q
POST ; post-init
 D INSTALLQ^YTXCHG("XCHGLST","YS173PST")
 D SETCAT("PROMIS29 V2.1","Frequent MBCs")
 D SETCAT("PROMIS29+2 V2.1","Frequent MBCs")
 D DROPTST("PHQ-2+I9")
 D DROPTST("PC-PTSD-5+I9")
 D DROPTST("I9+C-SSRS")
 D DROPTST("PROMIS29")
 D SETDTR("C-SSRS",0)       ; set to not restartable
 Q
 ;
DROPTST(NAME) ; Change OPERATIONAL to dropped
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(10)="D"
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
SETDTR(NAME,DAYS) ; Set DAYS TO RESTART for NAME
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(27)=DAYS
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
 ;
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
 ;;YS*5.01*173 PROMIS29^02/10/2021@16:00:06
 ;;YS*5.01*173 AD8^02/19/2021@18:26:41
 ;;zzzzz
