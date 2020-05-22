YS150PST ;SLC/BLD - MH Exchange Sample Code  ; 10/11/18 3:01pm
 ;;5.01;MENTAL HEALTH;**150**;Dec 30, 1994;Build 210
 ;
EXPDATE ; export date used to update 601.71:18
 ;;3200212.0001
PRE ; nothing necessary
 Q
POST ; post-init
 ; UPDSET^YTXCHG("TAG","RTN") will loop through the array returned by TAG^RTN
 ; and install the specification supplied by that Instrument Exchange entry
 ; name.
 ;
 N I,YTXLOG,LSTEDT,OLD,NEW,NEWDT,REC,IEN
 ;
 S (OLD,NEW)=""
 S LSTEDT=$P($T(EXPDATE+1),";;",2)
 S OLD="NuDESC",NEW="NUDESC" D CHGNM(OLD,NEW) ;Change instrument name only if OLD instrument exists on target system
 S OLD="SIP-AD-Start",NEW="SIP-AD-START" D CHGNM(OLD,NEW)
 ;
 D INSTALLQ^YTXCHG("XCHGLST","YS150PST")
 D LPSTAFF ;Update "Staff Entry Only" field on selected instruments
 D MODDATA   ;CHANGE LAST EDIT DATE, WRITE FULL TEXT, GENERATE PNOTE AND R PRIVILEGE ON INSTRUMENTS IN PATCH
 ;
 Q
 ;
MODDATA ; Set new dates for tests listed so the GUI will reload the definition
 ; This is best done in the account where the build is created so that the
 ; original and destination accounts match.
 N I,X,NEWDT,REC
 S NEWDT=$P($T(EXPDATE+1),";;",2)
 F I=1:1 S X=$P($T(INSTDT+I),";;",2) Q:X="zzzzz"  D
 .S IEN=$O(^YTT(601.71,"B",$P(X,"^",1),""))
 .I IEN D
 ..S REC(18)=NEWDT       ;LAST EDIT DATE
 ..S REC(26)=$P(X,"^",2) ; WRITE FULL TEXT
 ..S REC(28)=$P(X,"^",3) ;GENERATE PNOTE
 ..S REC(9)=$P(X,"^",4)  ;R PRIVILEGE
 ..D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
 ;
INSTDT ;
 ;;CMQ^Y^Y^
 ;;SIP-AD-30^Y^Y^
 ;;SIP-AD-START^Y^Y
 ;;BSL-23^Y^Y
 ;;NUDESC^Y^Y
 ;;FOCI^Y^Y^
 ;;SWEMWBS^N^N^YSP
 ;;MHRM-10^Y^Y^
 ;;EAT-26^Y^Y^
 ;;ACE^Y^Y^
 ;;AD8^N^N^YSP
 ;;zzzzz
 ;
CHGNM(OLD,NEW) ; Change test name
 ;Q
 N REC,IEN
 S IEN=$O(^YTT(601.71,"B",OLD,0))
 I 'IEN QUIT  ; already updated
 S REC(.01)=NEW
 S REC(18)=LSTEDT
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
 ;
SCREEN ; sample line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ; 
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS150PST")
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
 ;;YS*5.01*150^02/12/2020@08:54:39
 ;;zzzzz
 ;;YS*5.01*150^09/16/2019@12:47:06
 ;;YS*5.01*150^08/29/2019@10:27:56
 ;;YS*5.01*150^09/10/2019@09:27:08
 ;;YS*5.01*150^09/16/2019@12:47:06
 ;
LPSTAFF ; Loop through instruments to set staff entry only
 N I,X,Y
 F I=1:1 D  Q:X="zzzzz"
 . S X=$P($P($T(STAFF+I),";;",2),U) Q:X="zzzzz"
 . S Y=$P($P($T(STAFF+I),";;",2),U,2)
 . D UPDSTAFF(X,Y)
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
 ;;NUDESC^Y
 ;;zzzzz
 ;
