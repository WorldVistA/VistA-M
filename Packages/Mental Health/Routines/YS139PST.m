YS139PST ;SLC/BLD - MH Exchange Sample Code  ; 10/11/18 3:01pm
 ;;5.01;MENTAL HEALTH;**139**;Dec 30, 1994;Build 134
 ;
EXPDATE ; export date used to update 601.71:18
 ;;3190801.1956
 ;
PRE ; nothing necessary
 Q
POST ; post-init
 ; UPDSET^YTXCHG("TAG","RTN") will loop through the array returned by TAG^RTN
 ; and install the specification supplied by that Instrument Exchange entry
 ; name.
 ;
 N I,YTXLOG,LSTEDT,OLD,NEW,NEWDT,REC,IEN
 ;
 S LSTEDT=$P($T(EXPDATE+1),";;",2)
 D CHGNM("DERS","D.ERS")
 D DROPTST("RAID")
 ;
 D INSTALLQ^YTXCHG("XCHGLST","YS139PST")
 D MODDATA   ;CHANGE LAST EDIT DATE, WRITE FULL TEXT, GENERATE PNOTE AND R PRIVILEGE ON INSTRUMENTS IN PATCH
 ;
 Q 
 ;
MODDATA ; Set new dates for tests listed so the GUI will reload the definition
 ; This is best done in the account where the build is created so that the
 ; original and destination accounts match.
 N I,X,NEWDT,REC
 S NEWDT=$P($T(EXPDATE+1),";;",2)
 F I=1:1 S X=$P($T(INSTDT+I),";;",2) Q:X="zzzzz"  D   ; D NEWDATE^YTXCHGU(X,NEWDT)
 .K REC
 .S IEN=$O(^YTT(601.71,"B",$P(X,"^",1),""))
 .S REC(18)=NEWDT       ;LAST EDIT DATE
 .I $P(X,"^",2)'="" S REC(26)=$P(X,"^",2) ; WRITE FULL TEXT
 .I $P(X,"^",3)'="" S REC(28)=$P(X,"^",3) ;GENERATE PNOTE
 .I $P(X,"^",4)'="" S REC(9)=$P(X,"^",4)  ;R PRIVILEGE
 .D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
 ;
INSTDT ;
 ;;BBHI-2^N^N^YSP
 ;;COPD^Y^Y^
 ;;CSDD-RS^Y^Y^
 ;;D.ERS^Y^Y^
 ;;BPRS-A^Y^^
 ;;HSI^Y^^
 ;;MHRM^Y^^
 ;;MPI-PAIN-INTRF^Y^^
 ;;PCL-5 WEEKLY^Y^^
 ;;PC-PTSD-5+I9^Y^^
 ;;PHQ-2+I9^Y^^
 ;;PSS-3 2ND^Y^^
 ;;QOLI^N^N^
 ;;RAID^N^N^
 ;;zzzzz
 ;
CHGNM(OLD,NEW) ; Change test name
 N REC,IEN
 S IEN=$O(^YTT(601.71,"B",OLD,0))
 I 'IEN QUIT  ; already updated
 S REC(.01)=NEW
 S REC(18)=LSTEDT
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
 ;
DROPTST(NAME) ; Change OPERATIONAL to dropped
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(10)="D"
 S REC(18)=$P($T(EXPDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
 ;
 ;
SCREEN ; sample line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ; 
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS139PST")
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
 ;;YS*5.01*139^08/15/2019@13:36:22
  ;;zzzzz
 ;;YS*5.01*139^01/18/2019@13:10:05
 ;;YS*5.01*139^02/20/2019@10:33:29
 ;;YS*5.01*139 V31^08/12/2019@12:53:21
 ;;YS*5.01*139^08/15/2019@13:36:22
