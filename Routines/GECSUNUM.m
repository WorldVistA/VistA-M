GECSUNUM ;WISC/RFJ-get next counter number                          ;01 Nov 93
 ;;2.0;GCS;**34**;MAR 14, 1995
 Q
 ;
 ;
COUNTER(GECSNAME) ;  return next counter number
 ;  gecsname=station-batch type-fiscal year
 ;  example for fms: 460-FMS:MO-94
 ;  return next counter number
 I $L($G(GECSNAME))<10!($L($G(GECSNAME))>20) Q "invalid format for "_$G(GECSNAME)
 N %,DA
 ;
 S DA=+$O(^GECS(2101.5,"B",GECSNAME,0))
 I 'DA D
 .   ;  add entry to file
 .   L +^GECS(2101.5,0)
 .   ;  check to make sure another job did not add entry between locks
 .   S DA=+$O(^GECS(2101.5,"B",GECSNAME,0)) I DA Q
 .   S %=^GECS(2101.5,0)
 .   F DA=$P(%,"^",3)+1:1 Q:'$D(^GECS(2101.5,DA))
 .   S ^GECS(2101.5,DA,0)=GECSNAME_"^0"
 .   S ^GECS(2101.5,"B",GECSNAME,DA)=""
 .   S $P(%,"^",3)=DA,$P(%,"^",4)=$P(%,"^",4)+1,^GECS(2101.5,0)=%
 .   L -^GECS(2101.5,0)
 ;
 L +^GECS(2101.5,DA)
 S %=$P(^GECS(2101.5,DA,0),"^",2)+1
 I %>9999999 S %=1
 I %=0 S %=1
 S $P(^GECS(2101.5,DA,0),"^",2)=%
 L -^GECS(2101.5,DA)
 Q %
 ;
ACOUNTER(GECSNAME) ;  return next alphanumeric counter number
 ;  gecsname=station-batch type-fiscal year
 ;  example for fms: 460-FMS:MO-94
 ;  return next alphanumeric counter number
 I $L($G(GECSNAME))<10!($L($G(GECSNAME))>20) Q "invalid format for "_$G(GECSNAME)
 N %,DA,GECALPHA,GECCNT,X1,X2,X3
 ;
 S GECALPHA="ABCDEFGHIJKLMNPQRSTUVWXYZA"
 S DA=+$O(^GECS(2101.5,"B",GECSNAME,0))
 I 'DA D
 .   ;  add entry to file
 .   L +^GECS(2101.5,0)
 .   ;  check to make sure another job did not add entry between locks
 .   S DA=+$O(^GECS(2101.5,"B",GECSNAME,0)) I DA Q
 .   S %=^GECS(2101.5,0)
 .   F DA=$P(%,"^",3)+1:1 Q:'$D(^GECS(2101.5,DA))
 .   S ^GECS(2101.5,DA,0)=GECSNAME_"^0"
 .   S ^GECS(2101.5,"B",GECSNAME,DA)=""
 .   S $P(%,"^",3)=DA,$P(%,"^",4)=$P(%,"^",4)+1,^GECS(2101.5,0)=%
 .   L -^GECS(2101.5,0)
 ;
 L +^GECS(2101.5,DA)
 S %=$P(^GECS(2101.5,DA,0),"^",2)
 I %?1N2A D  G ACNTEND
 . I %="9ZZ"!(%="9zz") S %=1 Q  ;Highest value reached, start over at 1
 . S X3=$E(%,3)
 . S X2=$E(%,2)
 . S X1=$E(%,1)
 . S X3=$$ALPHA(X3) ;increment 3rd digit alpha
 . I X3="A" D  ;if 3rd digit alpha equal "A", then increment 2nd digit alpha
 .. S X2=$$ALPHA(X2) ; increment 2nd digit alpha
 .. I X2="A" S X1=X1+1 ;if 2nd digit alpha equal "A", then increase 1st digit number
 . S %=X1_X2_X3
 I %?2N1A D  G ACNTEND
 . I %="99Z"!(%="99z") S %="0AA" Q  ;Highest value reached, begin using alpha for 2nd digit
 . S X3=$E(%,3)
 . S GECCNT=$E(%,1,2)+1 ; increment number by 1
 . I GECCNT>99 S GECCNT="00" D  ;reset cnt to zero and increment 3rd digit alpha
 .. S X3=$$ALPHA(X3) ;increment 3rd digit alpha
 . I $L(GECCNT)=1 S GECCNT="0"_GECCNT
 . S %=GECCNT_X3
 S %=%+1
 I %>999 S %="00A" ;Highest all numeric value reached, begin using alpha as 3rd digit
ACNTEND S $P(^GECS(2101.5,DA,0),"^",2)=%
 L -^GECS(2101.5,DA)
 Q %
 ;
ALPHA(A) ;Increment alpha character to next letter in the alphabet
 ; A = Any letter in the alphabet except O to prevent confusion with zero
 N X,Y
 I A'?1A!(A="") Q "Z" ;when in doubt return "Z"
 S X=A X ^%ZOSF("UPPERCASE") S A=Y
 I A="O" Q "P"
 S A=$E(GECALPHA,$F(GECALPHA,A))
 Q A
