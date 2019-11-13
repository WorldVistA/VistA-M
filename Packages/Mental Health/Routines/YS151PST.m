YS151PST ;SLC/KCM - MH Exchange Sample Code  ; 10/11/18 3:01pm
 ;;5.01;MENTAL HEALTH;**151**;Dec 30, 1994;Build 92
 ;
EXPDATE ; export date used to update 601.71:18
 ;;3190815.1956
 ;
PRE ; nothing necessary
 Q
POST ; post-init
 ; UPDSET^YTXCHG("TAG","RTN") will loop through the array returned by TAG^RTN
 ; and install the specification supplied by that Instrument Exchange entry
 ; name.
 ;
 N LSTEDT
 S LSTEDT=$P($T(EDPDATE+1),";;",2)
 ;
 D CHGNM   ;CHANGE INSTRUMENT NAMES
 ;
 D INSTALLQ^YTXCHG("XCHGLST","YS151PST")
 D MODDATA   ;CHANGE LAST EDIT DATE, WRITE FULL TEXT, GENERATE PNOTE AND R PRIVILEGE ON INSTRUMENTS IN PATCH
 ;
 Q
 ;
SCREEN ; sample line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ; 
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS151PST")
 Q
 ;
MODDATA ; Set new dates for tests listed so the GUI will reload the definition
 ; This is best done in the account where the build is created so that the
 ; original and destination accounts match.
 N I,X,NEWDT,REC
 S NEWDT=$P($T(EXPDATE+1),";;",2)
 F I=1:1 S X=$P($T(INSTDT+I),";;",2) Q:X="zzzzz"  D
 .S IEN=$O(^YTT(601.71,"B",$P(X,"^",1),""))
 .S REC(18)=NEWDT       ;LAST EDIT DATE
 .I $P(X,"^",2)'="" S REC(26)=$P(X,"^",2) ; WRITE FULL TEXT
 .I $P(X,"^",3)'="" S REC(28)=$P(X,"^",3) ;GENERATE PNOTE
 .I $P(X,"^",4)'="" S REC(9)=$P(X,"^",4)  ;R PRIVILEGE
 .D FMUPD^YTXCHGU(601.71,.REC,IEN)
 .K REC
 Q
 ;
INSTDT ;
 ;;D.BAS^Y^Y^
 ;;IMRS^Y^Y^
 ;;ISS-2^Y^Y^
 ;;I9+C-SSRS^Y^Y^
 ;;MCMI4^N^N^YSP
 ;;PROMIS29^Y^Y^
 ;;Q-LES-Q-SF^Y^Y
 ;;WHOQOL BREF^Y^Y^
 ;;zzzzz
 ;
CHGNM ; Change test name
 N REC,IEN,NEW,OLD
 F I=1:1 S X=$P($T(NMCHG+I),";;",2,99) Q:X="zzzzz"  D
 .S OLD=$P(X,"^",1),NEW=$P(X,"^",2)
 .S IEN=$O(^YTT(601.71,"B",OLD,0))
 .I 'IEN QUIT  ; already updated
 .S REC(.01)=NEW
 .S REC(18)=LSTEDT
 .D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
 ;
NMCHG ;USED TO CHANGE THE NAME OF AN INSTRUMENT
 ;;DBAS^D.BAS
 ;;WHOQOL-BREF^WHOQOL BREF
 ;;zzzzz
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
 ;;YS*5.01*151^07/24/2019@08:30:57
 ;;zzzzz
 ;;YS*5.01*151^07/24/2019@08:30:57
