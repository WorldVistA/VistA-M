YS217PST ;BAL/KTL - Patch 217 Post-init ; 07/15/2022
 ;;5.01;MENTAL HEALTH;**217**;Dec 30, 1994;Build 12
 ;
 ; Reference to EN^XPAR in ICR #2263
 ; Reference to GETLST^XPAR in ICR #2263
 ; Reference to XLFSTR in ICR #10104
 Q
EDTDATE ; date used to update 601.71:18
 ;;3221117.2029
 Q
PRE ; nothing necessary
 Q
POST ; post-init
 N OLD,NEW
 S OLD="ASRS",NEW="ASRS-6" D CHGNM(OLD,NEW)
 D INSTALLQ^YTXCHG("XCHGLST","YS217PST")
 D FIXCESD
 D NEWCAT("Eating/Nutrition")
 D SETCAT("EDE-Q","Eating/Nutrition")
 D SETCAT("CIA","Eating/Nutrition")
 D DELCAT("AD8","Pain")
 D SETCAT("AD8","Pain / Health")
 D SETCAT("NUDESC","Cognitive/Learning")
 D SETCAT("SIP-AD-30","Addiction-SUD")
 D SETCAT("SIP-AD-START","Addiction-SUD")
 D SETCAT("SWEMWBS","Quality of Life")
 Q
 ;
UPDTST(NAME) ; Update Date Edited
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
 ;
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
DELCAT(TEST,CATNM) ; remove category from test if it is there
 N CAT,DIK,DA
 I TEST'=+TEST S TEST=$O(^YTT(601.71,"B",TEST,0)) QUIT:'TEST
 S CAT=$O(^YTT(601.97,"B",CATNM,0)) QUIT:'CAT
 S DA=$O(^YTT(601.71,TEST,10,"B",CAT,0)) Q:'DA
 S DA(1)=TEST
 S DIK="^YTT(601.71,"_TEST_",10,"
 D ^DIK
 Q
FIXCESD ; fix the missing scoring scale for CESD
 I $D(^YTT(601.87,1180,0)) QUIT  ; already there
 N REC,IEN
 S IEN=1180
 S REC(.01)=IEN
 S REC(1)=96
 S REC(2)=1
 S REC(3)="Total"
 S REC(4)="Total"
 D FMADD^YTXCHGU(601.87,.REC,.IEN)
 Q
 ;
CHGNM(OLD,NEW) ; Change test name
 N REC,IEN
 S IEN=$O(^YTT(601.71,"B",OLD,0))
 I 'IEN QUIT  ; already updated
 S REC(.01)=NEW
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 K REC,IEN
 S IEN=$O(^YTT(601,"B",OLD,0))
 I 'IEN QUIT
 S REC(.01)=NEW
 D FMUPD^YTXCHGU(601,.REC,IEN)
 Q
 ;
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ; 
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS217PST")
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
ENTRIES ; New MHA instruments ^ Exchange Entry Date
 ;;YS*5.01*217 CIA^11/17/2022@09:43:30
 ;;YS*5.01*217 EDE-Q^11/17/2022@09:43:52
 ;;YS*5.01*217 ASRS-6^11/17/2022@09:44:14
 ;;zzzzz
 ;
 Q
