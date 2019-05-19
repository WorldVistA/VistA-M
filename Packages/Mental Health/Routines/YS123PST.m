YS123PST ;SLC/LLH - Patch 123 post-init ; 03/20/2017
 ;;5.01;MENTAL HEALTH;**123**;Dec 30, 1994;Build 72
 ;
 ;Added PSOCQ to complex instruments 07/16/2018
 ;
 Q
 ;
EDTDATE ; date used to update 601.71:18
 ;;3190205.1931
 Q
 ;  
POST ; Post-init calls for patch 129
 N I,YTXLOG,LSTEDT
 S LSTEDT=$P($T(EDTDATE+1),";;",2)
 ;
 D CHGNM("BSI","BSS")
 ;Update 601.71: SCORING REVISION (#93), LAST EDIT DATE (#18)
 D UPD60171
 ;Add new Questions 7784-7787 (#14-#17) AND 7921-7924 (#18-21) for Computed Answers for BDI2
 D COMPANS
 ;Fileman delete, remove extra entry in MH CHOICETYPES for question 7 (5611)
 D FMDEL^YTXCHGU(601.751,53056)
 ;Remove duplicate entries in MH REPORTS (601.93), 2 Minicog, 1 BAM-R
 F I=73,74,92 D FMDEL^YTXCHGU(601.93,I)
 ;Fix VR-12 question 7 responses
 D FIXVR
 ;Use the Instrument Exchange to update Instruments
 D INSTALLQ^YTXCHG("XCHGLST","YS123PST")
 ;Drop retired instrument
 D DROPTST("BAM")
 ; D DROPTST("PC PTSD")
 ;Set up re-scoring task to run at T+1@1am
 D EN^XPAR("SYS","YS123 TASK LIMIT HOURS",1,4)
 ;Re-score all instruments if that hasn't been done yet
 D QTASK^YTSCOREV("0~1",($H+1)_",3600")
 ;Re-score MMPI-2-RF if not done in initial install
 N MMPI2RF S MMPI2RF=$O(^YTT(601.71,"B","MMPI-2-RF",0))
 I MMPI2RF D QTASK^YTSCOREV(MMPI2RF_"~2",($H+1)_",3600")
 Q
XCHGLST(ARRAY) ; return array of instrument exchange entries
 ; ARRAY(cnt,1)=instrument exchange entry name
 ; ARRAY(cnt,2)=instrument exchange entry creation date
 N I,X
 F I=1:1 S X=$P($T(ENTRIES+I),";;",2,99) Q:X="zzzzz"  D
 . S ARRAY(I,1)=$P(X,U)
 . S ARRAY(I,2)=$P(X,U,2)
 Q
ENTRIES ; New MHA instruments ^ Exchange Entry Date
 ;;YS*5.01*123 INSTRUMENT UPDATE^07/16/2018@19:08:26
 ;;zzzzz
 ;
CHGNM(OLD,NEW) ; Change test name
 N REC,IEN
 K REC
 S IEN=$O(^YTT(601.71,"B",OLD,0))
 I 'IEN D  Q  ; already updated
 .D BMES^XPDUTL(NEW_" Instrument name already changed")
 S REC(.01)=NEW
 S REC(18)=LSTEDT
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
DROPTST(NAME) ; Change OPERATIONAL to dropped
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(10)="D"
 S REC(18)=$P($T(EXPDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
 ;
UPD60171 ;
 N IEN,NM,REC,STR
 K REC
 S NM=""
 F  S NM=$O(^YTT(601.71,"B",NM)) Q:$G(NM)=""  D
 .S IEN=$O(^YTT(601.71,"B",NM,0))
 .I 'IEN D  Q
 ..D BMES^XPDUTL("Problem updating"_NM)
 .S STR=$G(^YTT(601.71,IEN,2))
 .I $P(STR,U,2)'="Y" Q  ; not operational, don't update
 .S REC(18)=LSTEDT
 .S REC(93)=1
 .D FMUPD^YTXCHGU(601.71,.REC,IEN)
 .K REC
 Q
 ; 
COMPANS ; add "computed answer" questions
 K ^TMP($J,"WP")
 N IEN,REC,NUM
 S NUM=7770
 K REC
 F IEN=7784:1:7787,7921:1:7924 D
 .I $D(^YTT(601.72,IEN,0)) D  Q  ; already added
 ..D BMES^XPDUTL("Question "_IEN_" previously added, check")
 .S:IEN=7921 NUM=7903
 .S ^TMP($J,"WP",IEN,1,0)="Computed Answer #"_(IEN-NUM)
 .S REC(.01)=IEN
 .S REC(1)=$NA(^TMP($J,"WP",IEN))
 .S REC(3)=3
 .D FMADD^YTXCHGU(601.72,.REC,IEN)
 .K REC
 K ^TMP($J,"WP")
 Q
 ;
FIXVR ;
 ;fix Answer File (601.85) for VR-12 (601.71 IEN = 177)
 N YSINS,YSADDT,YSAD
 S YSINS=$O(^YTT(601.71,"B","VR-12",""))
 I 'YSINS Q  ; No VR-12 instrument
 S YSADDT=""
 F  S YSADDT=$O(^YTT(601.84,"AC",YSINS,YSADDT)) Q:'YSADDT  S YSAD="" D
 .F  S YSAD=$O(^YTT(601.84,"AC",YSINS,YSADDT,YSAD)) Q:'YSAD  D
 ..;Questions needing checked: 5600, 5607, 5608, 5609, 5610, 5611
 ..D CHK85
 Q
 ;
CHK85 ;
 N ANS,YSCH,YSANS,QUES
 D BLDARR
 F QUES=5600,5607:1:5611 D
 .S YSANS=$O(^YTT(601.85,"AC",YSAD,QUES,""))
 .Q:'YSANS
 .S YSCH=$P($G(^YTT(601.85,YSANS,0)),U,4)
 .I QUES'=5611 S NEWCH=$S($D(ANS(YSCH)):ANS(YSCH),1:YSCH)
 .;this is question 7 which goes from 6 responses to 5, map response 3 (2996) to 2 (3637)
 .;I QUES=5611 S NEWCH=$S(YSCH=817:3644,YSCH=772:3637,YSCH=2996:3637,YSCH=774:3639,YSCH=815:3640,YSCH=814:3641,1:YSCH)
 .I QUES=5611 S NEWCH=$S(YSCH=817:3788,YSCH=772:3781,YSCH=2996:3781,YSCH=774:3783,YSCH=815:3784,YSCH=814:3785,1:YSCH)
 .I $G(NEWCH) D UPD85(YSANS,NEWCH)
 Q
 ;
UPD85(YSANS,NEWCH) ;
 N REC
 S REC(4)=NEWCH
 D FMUPD^YTXCHGU(601.85,.REC,YSANS)
 Q
 ;
BLDARR ;values used to convert choices in the MH ANSWER File for the VR-12 
 S ANS(684)=1007
 S ANS(685)=718
 S ANS(686)=719
 S ANS(687)=720
 S ANS(772)=3781 ;3637
 S ANS(774)=3782 ;3638
 S ANS(814)=3786 ;3642
 S ANS(815)=3787 ;3643
 S ANS(817)=3788 ;3644
 S ANS(1059)=3776 ;3632
 S ANS(1060)=3777 ;3633
 S ANS(1061)=3778 ;3634
 S ANS(1062)=3779 ;3635
 S ANS(1063)=3780 ;3636
 Q
 ;
MODDATE ; Set new dates for tests listed so the GUI will reload the definition
 ; This is best done in the account where the build is created so that the
 ; original and destination accounts match.
 N I,X,NEWDT
 S NEWDT=$P($T(EDTDATE+1),";;",2)
 F I=1:1 S X=$P($T(TESTS+I),";;",2) Q:X="zzzzz"  D NEWDATE^YTXCHGU(X,NEWDT)
 Q
 ;
TESTS ;
 ;;AUDC
 ;;BAI
 ;;BAM-C
 ;;BAM-R
 ;;BASIS-24
 ;;BDI2
 ;;BHS
 ;;BSS
 ;;CDR
 ;;CEMI
 ;;ERS
 ;;FAST
 ;;ISMI
 ;;MINICOG
 ;;MMPI-2-RF
 ;;NEO-PI-3
 ;;PHQ-2
 ;;POQ
 ;;PC PTSD
 ;;PSOCQ
 ;;QOLI
 ;;STMS
 ;;VR-12
 ;;WHODAS 2
 ;;WHYMPI
 ;;zzzzz
 Q
