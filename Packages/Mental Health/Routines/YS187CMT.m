YS187CMT ;SLC/KCM - Note titles for Case Mix Tool  ; 11/18/2021
 ;;5.01;MENTAL HEALTH;**187**;Dec 30, 1994;Build 73
 ;
 ; BMES^XPDUTL        ICR # 10141
 ; FIND1^DIC          ICR # 2051
 ; $$CRDD^TIUCRDD     ICR # 7179
 ; $$DDEFIEN^TIUFLF7  ICR # 5352
 Q
 ;
EDTDATE ; date used to update 601.71:18
 ;;3211207.1247
 Q
POST ; Post-init specific to Case Mix Tool
 N NDCL S NDCL="GEC PROGRESS NOTES"                               ; new class
 N NOTE S NOTE="PERSONAL CARE SERVICES CASE MIX TOOL"             ; note
 ;N CSLT S CSLT="PERSONAL CARE SERVICES CASE MIX TOOL FOR CONSULT" ; consult
 N CSLT S CSLT="COMMUNITY CARE-GEC HOMEMAKER/HOME HEALTH AIDE"    ; consult
 N STDT S STDT="GERIATRIC MEDICINE NOTE"                          ; standard
 D ADTITLES(NDCL,NOTE,CSLT,STDT)         ; add the new note titles
 D INSTALLQ^YTXCHG("XCHGLST","YS187CMT") ; update Case Mix instrument entries
 D UPD71(NOTE,CSLT)                      ; point CASE MIX to new titles
 D DROPTST("SSF")                        ; inactivate SSF instrument
 D DROPTST("ZUNG")                       ; inactivate ZUNG instrument
 Q
 ;
ADTITLES(NDCL,NOTE,CSLT,STDT) ; add new titles for Case Mix if not there
 N RV  ; holds return value
 ; install new parent document class
 S RV=$$CRDD^TIUCRDD(NDCL,"DC",11,"PROGRESS NOTES")
 I '+RV,$P(RV,U,2)'["already exists" D BMES^XPDUTL($P(RV,U,2)) QUIT   ; out
 D BMES^XPDUTL($S(+RV:NDCL_" created successfully",1:NDCL_" already exists"))
 ; install progress note title
 S RV=$$CRDD^TIUCRDD(NOTE,"DOC",11,NDCL,STDT)
 D BMES^XPDUTL($S(+RV:NOTE_" created successfully",1:$P(RV,U,2)))
 ; install consult title
 ; S RV=$$CRDD^TIUCRDD(CSLT,"DOC",11,"CONSULTS",STDT)
 ; D BMES^XPDUTL($S(+RV:CSLT_" created successfully",1:$P(RV,U,2)))
 Q
 ;
UPD71(NOTE,CSLT) ; update titles in MH TESTS AND SURVEYS (#601.71)
 N TESTIEN,NOTEIEN,CSLTIEN,REC
 S TESTIEN=$O(^YTT(601.71,"B","CASE MIX",0)) Q:'TESTIEN
 S NOTEIEN=+$$DDEFIEN^TIUFLF7(NOTE,"TL")
 S CSLTIEN=+$$DDEFIEN^TIUFLF7(CSLT,"TL")
 I 'NOTEIEN,'CSLTIEN QUIT  ; neither title found
 S REC(28)="Y"
 I NOTEIEN S REC(29)=NOTEIEN
 I CSLTIEN S REC(30)=CSLTIEN
 D FMUPD^YTXCHGU(601.71,.REC,TESTIEN)
 D BMES^XPDUTL("Note titles updated for Case Mix.")
 Q
DROPTST(NAME) ; Change OPERATIONAL to dropped
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(10)="D"
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
 ;
 ; added to data screen:
 ; I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS187CMT")
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
 ;;YS*5.01*187 CASE MIX FIX^12/03/2021@10:51:15
 ;;zzzzz
 Q
