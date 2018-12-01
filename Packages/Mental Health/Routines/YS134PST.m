YS134PST ;SLC/KCM - MH Exchange Sample Code  ; 08-AUG-2016
 ;;5.01;MENTAL HEALTH;**134**;Dec 30, 1994;Build 230
 ;
PRE ; nothing necessary
 Q
POST ; post-init
 ; UPDSET^YTXCHG("TAG","RTN") will loop through the array returned by TAG^RTN
 ; and install the specification supplied by that Instrument Exchange entry
 ; name.
 ;  
 D INSTALLQ^YTXCHG("XCHGLST","YS134PST")
 Q
 ;
SCREEN ; sample line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ; 
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS134PST")
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
 ;;YS*5.01*134 T10C4^07/30/2018@01:22:34
 ;;zzzzz
 ;;YS*5*01*134 T7^06/04/2018@10:49:19
 ;;YS*5.01*134 T10C3^07/27/2018@13:00:43
 ;;YS*5.01*134 T10C4^07/30/2018@01:22:34
