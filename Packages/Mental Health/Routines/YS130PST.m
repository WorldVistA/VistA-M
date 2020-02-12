YS130PST ;SLC/KCM - Patch 130 Post-Init ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130**;Dec 30, 1994;Build 62
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; ^VA(200)             10060
 ; XPDUTL               10141
 ; XUSAP                 4677 
 ;
 Q
EDTDATE ; date used to update 601.71:18
 ;;3190315.1855
 Q
POST ; Post-init for YS*5.01*130
 D FIXANS("WHODAS2.0-12")
 D FIXANS("PSS-3 2ND")
 D SAVE96^YTWJSONF   ; set up all instruments as JSON files in 601.96
 D PROXY             ; set up application proxy for patient-entered
 D LPSTAFF           ; mark instruments that should be staff-entered
 D SETCATS^YS130PS0  ; set up instrument categories
 Q
PROXY ; Create proxy user
 I $$FIND1^DIC(200,"","BQX","YTQR,PATIENTENTRY PROXY")>0 D  QUIT
 . D MES^XPDUTL("YTQR Proxy Found")
 I $$CREATE^XUSAP("YTQR,PATIENTENTRY PROXY","","YTQREST PATIENT ENTRY") D
 . D MES^XPDUTL("YTQR Proxy Created")
 Q
LPSTAFF ; Loop through instruments to set staff entry only
 N I,X
 F I=1:1 S X=$P($P($T(STAFF+I),";;",2),U) Q:X="zzzzz"  D UPDSTAFF(X,"Y")
 Q
UPDSTAFF(NAME,VALUE) ; Update STAFF ENTRY ONLY field
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(94)=VALUE
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
FIXANS(TESTNM) ; Fix the case of the answer tags for 
 N SWAP,RPT,TEST,I,X
 S SWAP("<*ANSWER_7771*>")="<*Answer_7771*>"
 S SWAP("<*ANSWER_7778*>")="<*Answer_7778*>"
 N RPT,TEST,I
 S TEST=$O(^YTT(601.71,"B",TESTNM,0)) Q:'TEST
 S RPT=$O(^YTT(601.93,"C",TEST,0)) Q:'RPT
 S I=0 F  S I=$O(^YTT(601.93,RPT,1,I)) Q:'I  D
 . S X=^YTT(601.93,RPT,1,I,0)
 . I X["<*ANSWER_" D
 . . S X=$$REPLACE^XLFSTR(X,.SWAP)
 . . S ^YTT(601.93,RPT,1,I,0)=X
 Q
STAFF ; Staff Entry Only Instruments
 ;;AIMS^
 ;;BBHI-2^
 ;;BOMC^
 ;;BPRS^
 ;;BPRS-A^
 ;;BRADEN SCALE^
 ;;CDR^
 ;;CIWA-AR-^
 ;;COPD^
 ;;COWS^
 ;;CSDD-RS^
 ;;CSI^
 ;;CSI PARTNER VERSION^
 ;;D.BAS^
 ;;FAST^
 ;;GDS DEMENTIA^
 ;;GPCOG^
 ;;IADL^
 ;;ISS-2^
 ;;I9+C-SSRS^
 ;;KATZ-ADL-18PT^
 ;;KATZ-ADL-6PT^
 ;;MINICOG^
 ;;MOCA^
 ;;MOCA ALT 1^
 ;;MOCA ALT 2^
 ;;MORSE FALL SCALE^
 ;;MPI-PAIN-INTRF^
 ;;PC-PTSD-5+I9^
 ;;PHQ-2+I9^
 ;;POQ^
 ;;PROMIS29^
 ;;PSS-3^
 ;;RAID^
 ;;SBR^
 ;;SLUMS^
 ;;SSF^
 ;;STMS^
 ;;WHYMPI^
 ;;zzzzz
 ;
