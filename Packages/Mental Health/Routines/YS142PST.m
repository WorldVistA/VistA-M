YS142PST ;SLC/KCM - Patch 142 post-init ; 03/20/2017
 ;;5.01;MENTAL HEALTH;**142**;Dec 30, 1994;Build 14
 ;
EXPDATE ; export date used to update 601.71:18
 ;;3190815.1731
 Q
 ;
POST ; post-init for patch 142
 N REC,MMPI2RF,QOLI
 ;Queue check of extraneous scales
 D QTASK^YS142FIX(($H+1)_",3600")
 ;
 ;Re-score QOLI to catch problems between patch 139 and this install
 K REC
 S REC(93)=2 ; Set scoring revision to 2
 S QOLI=$O(^YTT(601.71,"B","QOLI",0))
 I QOLI D
 . D FMUPD^YTXCHGU(601.71,.REC,QOLI)
 . D QTASK^YTSCOREV(QOLI_"~2",($H+3)_",3600")
 ;
 ;Re-score MMPI-2-RF to fix the EID, PSYC-r scales
 S REC(93)=3 ; Set scoring revision to 3
 S MMPI2RF=$O(^YTT(601.71,"B","MMPI-2-RF",0))
 I MMPI2RF D
 . D FMUPD^YTXCHGU(601.71,.REC,MMPI2RF)
 . D QTASK^YTSCOREV(MMPI2RF_"~3",($H+5)_",3600")
 ;
 ;Reporting updates to C-SSRS
 D INSTALLQ^YTXCHG("XCHGLST","YS142PST")
 Q
 ;
XCHGLST(ARRAY) ; return array of instrument exchange entries
 ; ARRAY(cnt,1)=instrument exchange entry name
 ; ARRAY(cnt,2)=instrument exchange entry creation date
 N I,X
 F I=1:1 S X=$P($T(ENTRIES+I),";;",2,99) Q:X="zzzzz"  D
 . S ARRAY(I,1)=$P(X,U)
 . S ARRAY(I,2)=$P(X,U,2)
 Q
ENTRIES ; New MHA instruments ^ Exchange Entry Date
 ;;YS*5.01*142 UPDATES^09/19/2019@11:58:09
 ;;zzzzz
 ;
MODDATE ; Set new dates for tests listed so the GUI will reload the definition
 ; This is best done in the account where the build is created so that the
 ; original and destination accounts match.
 N I,X,NEWDT
 S NEWDT=$P($T(EXPDATE+1),";;",2)
 F I=1:1 S X=$P($P($T(TESTS+I),";;",2),"^") Q:X="zzzzz"  D NEWDATE^YTXCHGU(X,NEWDT)
 Q
TESTS ; exported instruments
 ;;C-SSRS^updated
 ;;QOLI^updated
 ;;zzzzz
 ;
