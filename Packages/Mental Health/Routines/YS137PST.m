YS137PST ;SLC/KCM - MH Exchange Sample Code  ; 08-AUG-2016
 ;;5.01;MENTAL HEALTH;**137**;Dec 30, 1994;Build 273
 ;
PRE ; nothing necessary
 Q
POST ; post-init
 ; UPDSET^YTXCHG("TAG","RTN") will loop through the array returned by TAG^RTN
 ; and install the specification supplied by that Instrument Exchange entry
 ; name.
 ;  
 D INSTALLQ^YTXCHG("XCHGLST","YS137PST")
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
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS137PST")
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
 ;;YS*5.01*137^11/13/2018@19:10
 ;;zzzzz
 ;;YS*5.01*137 T20^10/17/2018@14:30:44
 ;;YS*5.01*137 CES^10/17/2018@15:19:48
 ;;YS*5.01*137 V21^10/30/2018@14:56:07
 ;;137 TEST FOR PNOTES^12/11/2018@11:38:30
 ;;YS*5.01*137^11/13/2018@19:10
