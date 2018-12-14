YS136PST ;SLC/KCM - MH Exchange Sample Code  ; 08-AUG-2016
 ;;5.01;MENTAL HEALTH;**136**;Dec 30, 1994;Build 235
 ;
PRE ; nothing necessary
 Q
POST ; post-init
 ; UPDSET^YTXCHG("TAG","RTN") will loop through the array returned by TAG^RTN
 ; and install the specification supplied by that Instrument Exchange entry
 ; name.
 ;  
 D INSTALLQ^YTXCHG("XCHGLST","YS136PST")
 Q
 ;
SCREEN ; sample line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ; 
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS136PST")
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
 ;;YS*5.01*136^10/15/2018@18:54:50 
 ;;zzzzz
 ;;YS*5.01*136^06/08/2018@14:01:31
 ;;YS*5.01*136^07/17/2018@11:59:50
 ;;YS*5.01*136 T1C26^09/10/2018@15:47:22
 ;;YS*5.01*136^10/15/2018@18:54:50
