YS121PST ;SLC/KCM - Patch 121 post-init - utilities; 9/15/2015
 ;;5.01;MENTAL HEALTH;**121**;Dec 30, 1994;Build 61
 ;
 ;Reference to PXRMEXSI APIs supported by DBIA #4371
 Q
 ;
 ;Adding notes to make sure what I know doesn't slip between the cracks.
 ;  moved the YBOCSII, YBOCSII Symptom List, and the QOLIE-10 to OPERATONAL to Under development, HAS BEEN OPERATIONAL to No
 ;  added name changes to the Index of Adl and KTZADL
 ;  will also be adding the CSI Partner and CSI-4 Partner as new instruments
 ;
 ;
EXPDATE ; export date used to update 601.71:18
 ;;3170731.1956
 Q
PRE ; pre-init
 D BMES^XPDUTL("Re-indexing MH CHOICETYPES file")
 N DIK
 K ^YTT(601.751,"AC")
 S DIK="^YTT(601.751," D IXALL^DIK
 ;
 ; switch back to uppercase if earlier version of patch installed
 D CHGNM("ASSIST-WHOv3","ASSIST-WHOV3")
 D CHGNM("KATZ-ADL-6pt","KATZ-ADL-6PT")
 D CHGNM("KATZ-ADL-18pt","KATZ-ADL-18PT")
 
 ;
 ; set up for Reminder Exchange install of PCL-5 fixes
 D DELEXE^PXRMEXSI("EXARRAY","YS121PST")
 Q
POST ; post-init
 N YTXLOG
 D CHGNM("ASSIST","ASSIST-WHOV3")
 D CHGNM("ASSIST NIDA","ASSIST-NIDA")
 D CHGNM("INDEX OF ADL","KATZ-ADL-18PT")
 D CHGNM("KTZADL","KATZ-ADL-6PT")
 D BAK2DEV("QOLIE-10")
 D BAK2DEV("YBOCSII")
 D BAK2DEV("YBOCSII SYMPTOM LIST")
 D BAK2DEV("IMRA")
 D BAK2DEV("SIP-2L")
 D COMPANS
 D FIXSMEQ
 D REQLIC
 ;Fileman deletes, specially added to remove duplicate entries in MH REPORTS (601.93)
 D FMDEL^YTXCHGU(601.93,68)  ;old GAI report, current and valid one is entry #69
 K ^XTMP("YTXIDX") ; force building of new index across tests
 D INSTALLQ^YTXCHG("XCHGLST","YS121PST")
 ; drop tests
 F NM="CIWA-AR","AUIR","CESD5","DOM80","DOMG","ERS","HLOC" D DROPTST(NM)
 F NM="IEQ","RLOC","SAI","SDES","SMAST","VALD","WAS" D DROPTST(NM)
 ; for PSOCQ, remove YS_MHA_AUX.DLL VERSION value (currently 1.0.3.3)
 N TST S TST=$O(^YTT(601.71,"B","PSOCQ",0))
 I TST D CLRFLD(601.71,100.03,TST)
 ;
 ; call Reminder Exchange to install PCL-5 fixes
 D SMEXINS^PXRMEXSI("EXARRAY","YS121PST")
 Q
CHGNM(OLD,NEW) ; Change test name
 N REC,IEN
 S IEN=$O(^YTT(601.71,"B",OLD,0))
 I 'IEN QUIT  ; already updated
 S REC(.01)=NEW
 S REC(18)=3170914
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
COMPANS ; add "computed answer" questions
 K ^TMP($J,"WP")
 N IEN,REC
 F IEN=7771:1:7783 D
 . I $D(^YTT(601.72,IEN,0)) Q  ; already added
 . S ^TMP($J,"WP",IEN,1,0)="Computed Answer #"_(IEN-7770)
 . S REC(.01)=IEN
 . S REC(1)=$NA(^TMP($J,"WP",IEN))
 . S REC(3)=3
 . D FMADD^YTXCHGU(601.72,.REC,IEN)
 K ^TMP($J,"WP")
 Q
FIXSMEQ ; fix choice to avoid "conflict" error with existing CSM entry
 N REC
 I $E($G(^YTT(601.75,3253,1)),1,8)'="A little" Q  ; unexpected record
 S REC(3)="A little unpleasant but no great problem"
 D FMUPD^YTXCHGU(601.75,.REC,3253)
 Q
REQLIC ; change instruments to require license
 N NM,IEN,REC
 F NM="ISI","QOLI","SF36","SSF","WAI-SR","YBOCSII","YBOCSII SYMPTOM LIST" D
 . S IEN=$O(^YTT(601.71,"B",NM,0))
 . S REC(11)="Y",REC(20)="Y"
 . D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
DROPTST(NAME) ; Change OPERATIONAL to dropped
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(10)="D"
 S REC(18)=$P($T(EXPDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
CLRFLD(FILE,FLD,IEN) ;
 N REC
 S REC(FLD)=""
 D FMUPD^YTXCHGU(FILE,.REC,IEN)
 Q
BAK2DEV(NAME) ; Set instrument back to 'under development'
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(10)="U"
 S REC(10.5)="N"
 S REC(18)=$P($T(EXPDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
XCHGLST(ARRAY) ; return array of instrument exchange entries
 ; ARRAY(cnt,1)=instrument exchange entry name
 ; ARRAY(cnt,2)=instrument exchange entry creation date
 ;
 N I,X
 S I=0 F  S I=I+1,X=$P($T(ENTRIES+I),";;",2,99) Q:X="zzzzz"  D
 . S ARRAY(I,1)=$P(X,U,1)
 . S ARRAY(I,2)=$P(X,U,2)
 Q
ENTRIES ; New/Updated MHA instruments ^ Exchange Entry Date
 ;;YS*5.01*121 NEW INSTRUMENTS^12/12/2017@19:04:38
 ;;YS*5.01*121 UPDATES^12/12/2017@19:06:09
 ;;zzzzz
 ;
EXARRAY(MODE,ARRAY) ;Called by Reminder Exchange to fix PCL-5
 ;MODE values: I for include in build, A for include action.
 N LN S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="YS*5.01*121 PCL-5 FIX"
 I MODE["I" S ARRAY(LN,2)="12/20/2016@16:10:39"
 I MODE["A" S ARRAY(LN,3)="I"
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
 ;
MODDATE ; Set new dates for tests listed so the GUI will reload the definition
 ; This is best done in the account where the build is created so that the
 ; original and destination accounts match.
 N I,X,NEWDT
 S NEWDT=$P($T(EXPDATE+1),";;",2)
 F I=1:1 S X=$P($P($T(TESTS+I),";;",2),"^") Q:X="zzzzz"  D NEWDATE^YTXCHGU(X,NEWDT)
 Q
TESTS ; exported tests (renamed, added,updated, and retired)
 ;;ASSIST-WHOV3^renamed
 ;;ASSIST-NIDA^added
 ;;BRS^added
 ;;CCSA-DSM5^added
 ;;CEMI^added
 ;;CIWA-AR-^added
 ;;CSI^added
 ;;CSI PARTNER VERSION^added
 ;;CSI-4^added
 ;;CSI-4 PARTNER VERSION^added
 ;;GAI^added
 ;;ISI^added
 ;;KATZ-ADL-18PT^updated
 ;;KATZ-ADL-6PT^added
 ;;PHQ9^updated
 ;;PSOCQ^added
 ;;PSS^added
 ;;RLS^added
 ;;SMEQ^added
 ;;SNQ^added
 ;;STOP^added
 ;;WAI-SR^updated
 ;;CIWA-AR^retired
 ;;AUIR^retired
 ;;CESD5^retired
 ;;DOM80^retired
 ;;DOMG^retired
 ;;ERS^retired
 ;;HLOC^retired
 ;;IEQ^retired
 ;;RLOC^retired
 ;;SAI^retired
 ;;SDES^retired
 ;;SMAST^retired
 ;;VALD^retired
 ;;WAS^retired
 ;;zzzzz
 ;
 ; -- decided to do these later
 ;;IMRA^added
 ;;QOLIE-10^added
 ;;SIP-2L^added
 ;;YBOCSII^added
 ;;YBOCSII SYMPTOM LIST^added
