YS141PST ;BAH/QSB - Patch 141 Post-Init ; 1/27/2020
 ;;5.01;MENTAL HEALTH;**141**;Dec 30, 1994;Build 85
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; XPDUTL               10141
 ;
 Q
EDTDATE ; date used to update 601.71:18
 ;;3200227.0006
 Q
POST ; Post-init for YS*5.01*141
 D INSTALLQ^YTXCHG("XCHGLST","YS141PST")
 D LPSTAFF           ; mark instruments that should be staff-entered
 D DROPTST("SBR")
 D SETAUDC
 D SETSWEM
 D SETQOLI
 D FIXNEO3
 D SETMOCA^YS141MCA
 I '$$GET^XPAR("ALL","YSMOCA ATTESTATION ENABLED") D QMOCA^YS141MCA
 D SETCATS^YS141PS0
 Q
 ;
SCREEN ; sample line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ; 
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YTXCHGS")
 Q
 ;
DROPTST(NAME) ; Change OPERATIONAL to dropped
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(10)="D"
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
 ;
SETAUDC ; Set date AUDC scoring changed
 I $$GET^XPAR("SYS","YSAUDC CHANGE DATE",1,"I") QUIT
 D EN^XPAR("SYS","YSAUDC CHANGE DATE",1,$$NOW^XLFDT)
 Q
SETSWEM ; Update key fields in SWEMWBS
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B","SWEMWBS",0)) Q:'IEN
 S REC(9)=""    ; read result privilege
 S REC(26)="Y"  ; write full text
 S REC(28)="Y"  ; generate progress note
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
SETQOLI ; Update scoring revision in QOLI
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B","QOLI",0)) Q:'IEN
 S REC(93)=3
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
FIXNEO3 ; Remove the stub rule for NEO-PI-3
 N TEST,REC
 S TEST=$O(^YTT(601.71,"B","NEO-PI-3",0)) Q:'TEST
 ; remove the erroneous association (question 5723 and rule 93)
 I $P($G(^YTT(601.83,93,0)),U,2)=TEST D FMDEL^YTXCHGU(601.83,93)
 ; remove the erroneous rule 93 (which has no skipped questions)
 I $P($G(^YTT(601.82,149,0)),U,2)=5723 D FMDEL^YTXCHGU(601.82,149)
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,TEST)
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
 ;
LPSTAFF ; Loop through instruments to set staff entry only
 N I,X
 F I=1:1 S X=$P($P($T(STAFF+I),";;",2),U) Q:X="zzzzz"  D UPDSTAFF(X,"N")
 Q
 ;
UPDSTAFF(NAME,VALUE) ; Update STAFF ENTRY ONLY field
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(94)=VALUE
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
 ;
STAFF ;Staff Entry Only Instruments
 ;;BBHI-2^
 ;;CSI^
 ;;CSI PARTNER VERSION^
 ;;D.BAS^
 ;;ISS-2^
 ;;I9+C-SSRS^
 ;;MPI-PAIN-INTRF^
 ;;PC-PTSD-5+I9^
 ;;PHQ-2+I9^
 ;;POQ^
 ;;PROMIS29^
 ;;PSS-3^
 ;;SSF^
 ;;WHYMPI^
 ;;zzzzz
 ;
ENTRIES ; New MHA instruments ^ Exchange Entry Date
 ;;YS*5.01*141 PSS-3^01/30/2020@13:30:42
 ;;YS*5.01*141 CIWA-AR REPORT^03/12/2020@18:14:40
 ;;YS*5.01*141 PHQ9 SCORING^05/14/2020@23:38:19
 ;;YS*5.01*141 SWEMWBS REPORT^06/09/2020@11:25:32
 ;;YS*5.01*141 AUDC UPDATE^06/23/2020@19:50:32
 ;;YS*5.01*141 D.BAS TYPO^08/12/2020@17:23:14
 ;;zzzzz
