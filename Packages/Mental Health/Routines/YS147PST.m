YS147PST ;SLC/KCM - MH Exchange Sample Code  ; 08-AUG-2016
 ;;5.01;MENTAL HEALTH;**147**;Dec 30, 1994;Build 283
 ;
PRE ; nothing necessary
 Q
POST ; post-init
 ; UPDSET^YTXCHG("TAG","RTN") will loop through the array returned by TAG^RTN
 ; and install the specification supplied by that Instrument Exchange entry
 ; name.
 ;  
 D INSTALLQ^YTXCHG("XCHGLST","YS147PST")
 N IEN
 F I="AD8","CES","EPDS","FTND","MPI-PAIN-INTRF","IJSS","BASIS-24 PSYCHOSIS" D
 .S IEN=$O(^YTT(601.71,"B",I,""))
 .I IEN'="",$D(^YTT(601.71,IEN,8)) D
 ..S:$P(^YTT(601.71,IEN,8),"^",8)'="N" $P(^YTT(601.71,IEN,8),"^",8)="Y"
 Q
 ;
SCREEN ; sample line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ; 
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS147PST")
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
 ;;YS*5.01*147^03/29/2019@08:42:40
 ;;zzzzz
 ;;YS*5.01*147^03/29/2019@08:42:40
