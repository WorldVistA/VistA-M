YS258PST ;ISP/LMT - Patch 258 Post-init ;Jan 31, 2025@12:20:54
 ;;5.01;MENTAL HEALTH;**258**;Dec 30, 1994;Build 2
 ;
 ;
 Q
EDTDATE ; date used to update 601.71:18
 ;;3250131.1300
 Q
 ;
PRE ; nothing necessary
 Q
 ;
POST ; post-init
 D INSTALLQ^YTXCHG("XCHGLST","YS258PST")
 Q
 ;
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ;
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS258PST")
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
 ;
ENTRIES ; New MHA instruments ^ Exchange Entry Date
 ;;YS*5.01*258 SRCS^02/03/2025@14:27:52
 ;;zzzzz
 ;
 Q
