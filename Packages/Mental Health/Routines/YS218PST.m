YS218PST ;SLC/KCM - Patch 218 Post-init ; 07/15/2022
 ;;5.01;MENTAL HEALTH;**218**;Dec 30, 1994;Build 9
 ;
 ; Reference to EN^XPAR in ICR #2263
 ; Reference to GETLST^XPAR in ICR #2263
 ; Reference to XLFSTR in ICR #10104
 Q
EDTDATE ; date used to update 601.71:18
 ;;3221129.1636
 Q
PRE ; nothing necessary
 Q
POST ; post-init
 D INSTALLQ^YTXCHG("XCHGLST","YS218PST")
 D SETCAT("PROMIS10","Quality of Life")
 D SETCAT("MIOS+B-IPF","EBP")
 D SETCAT("MIOS+B-IPF","Quality of Life")
 D SETCAT("MIOS+B-IPF","Anxiety/PTSD")
 D SETCAT("SBAF","Anxiety/PTSD")
 D SETCAT("SBAF-PTSD","Anxiety/PTSD")
 D SETCAT("MIDAS","Pain / Health")
 D SETCAT("HIT-6","Pain / Health")
 D ADDNOTE^YTXCHGI("PCL-5")
 D CATREV
 D SETSEO("CASE MIX","Y")
 D SETSEO("PSS-3 2ND","Y")
 D SETSEO("AD8","Y")
 D SETSEO("COPD","N")
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
 ;
CATREV ; update the scoring revision for all CATs (no scales for CAD)
 N NM
 S NM="CAT-" F  S NM=$O(^YTT(601.71,"B",NM)) Q:$E(NM,1,4)'="CAT-"  D NEWREV(NM,2)
 Q
NEWREV(NM,REV) ; Update scoring revision for test & queue re-score
 N TEST S TEST=$O(^YTT(601.71,"B",NM,0))
 D UPDREV(TEST,REV)
 Q:NM="CAT-CAD Interview"
 D QTASK^YTSCOREV(TEST_"~"_REV,$H)  ;($H+1)_",3600")
 Q
UPDREV(TEST,REV) ; Update scoring revision in TEST
 N REC
 I $P($G(^YTT(601.71,+TEST,9)),U,3)=REV QUIT
 S REC(93)=REV
 D FMUPD^YTXCHGU(601.71,.REC,TEST)
 Q
 ;
SETSEO(TEST,VALUE) ; Set staff-entry only field to VALUE
 I TEST'=+TEST S TEST=$O(^YTT(601.71,"B",TEST,0)) QUIT:'TEST
 N REC S REC(94)=VALUE
 D FMUPD^YTXCHGU(601.71,.REC,TEST)
 Q
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ; 
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS218PST")
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
 ;;YS*5.01*218 PROMIS10^11/29/2022@17:59:27
 ;;YS*5.01*218 MIOS+B-IPF^11/30/2022@19:37:19
 ;;YS*5.01*218 SBAF^12/05/2022@10:22:31
 ;;YS*5.01*218 HIT-6^12/05/2022@17:28:43
 ;;YS*5.01*218 MIDAS^12/05/2022@17:28:09
 ;;YS*5.01*218 PCL-5 UPDATE^12/05/2022@23:46:23
 ;;YS*5.01*218 MORSE FALL UPDATE^12/06/2022@00:14:43
 ;;YS*5.01*218 EAT-26 UPDATE^01/10/2023@23:32:27
 ;;YS*5.01*218 CAGE UPDATE^01/17/2023@15:36:01
 ;;zzzzz
 ;
 ; moved to YS*5.01*208
 ;;YS*5.01*218 FAST UPD STEP1^01/10/2023@17:07:35
 ;;YS*5.01*218 FAST UPD STEP2^01/10/2023@15:00:52
