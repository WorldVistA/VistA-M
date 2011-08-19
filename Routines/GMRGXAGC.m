GMRGXAGC ;CISC/RM-AGGREGATE TERM FILE CHANGES ;8/27/93
 ;;3.0;Text Generator;;Jan 24, 1996
POST ;
 W !!,"Making corrections to aggregate term file entries"
 F GMRGXAGC=1:1 S GMRGXAGC(0)=$P($T(CHIL+GMRGXAGC),";;",2) Q:GMRGXAGC(0)=""  D FXCH0
 F GMRGXAGC=1:1 S GMRGXAGC(0)=$P($T(OTHER+GMRGXAGC),";;",2) Q:GMRGXAGC(0)=""  D FXOT0
 Q
PRE ;
 W !!,"Making corrections to aggregate term file entries"
 F GMRGXAGC=1:1 S GMRGXAGC(0)=$P($T(ZERO+GMRGXAGC),";;",2) Q:GMRGXAGC(0)=""  D FXZR0
 Q
FXCH0 ;
 S DA(1)=$O(^GMRD(124.2,"AA",$P(GMRGXAGC(0),"^",3),$P(GMRGXAGC(0),"^",2),$P(GMRGXAGC(0),"^"),+$P(GMRGXAGC(0),"^",5),0)) Q:DA(1)'>0
 F DA=0:0 S DA=$O(^GMRD(124.2,DA(1),1,DA)) Q:DA'>0  I $D(^GMRD(124.2,DA(1),1,DA,0)),$P(^(0),"^",2,5)=$P($P(GMRGXAGC(0),";",2),"^",1,4) Q
 Q:DA'>0  S DIK="^GMRD(124.2,DA(1),1," D ^DIK W "."
 Q
FXZR0 ;
 S DA=$O(^GMRD(124.2,"AA",$P(GMRGXAGC(0),"^",3),$P(GMRGXAGC(0),"^",2),$P(GMRGXAGC(0),"^"),+$P(GMRGXAGC(0),"^",5),0)) Q:DA'>0
 F GMRGXAGC=.01,.02,.03,.05 D FZ
 W "."
 Q
FZ ;
 S X=$P($P(GMRGXAGC(0),";"),"^",100*GMRGXAGC) F GMRGXAGC(1)=0:0 S GMRGXAGC(1)=$O(^DD(124.2,GMRGXAGC,1,GMRGXAGC(1))) Q:GMRGXAGC(1)'>0  X:$D(^DD(124.2,GMRGXAGC,1,GMRGXAGC(1),2)) ^(2)
 S X=$P($P(GMRGXAGC(0),";",2),"^",100*GMRGXAGC),$P(^GMRD(124.2,DA,0),"^",100*GMRGXAGC)=X F GMRGXAGC(1)=0:0 S GMRGXAGC(1)=$O(^DD(124.2,GMRGXAGC,1,GMRGXAGC(1))) Q:GMRGXAGC(1)'>0  X:$D(^DD(124.2,GMRGXAGC,1,GMRGXAGC(1),1)) ^(1)
 Q
FXOT0 ;
 S DA=$O(^GMRD(124.2,"AA",$P(GMRGXAGC(0),"^",3),$P(GMRGXAGC(0),"^",2),$P(GMRGXAGC(0),"^"),+$P(GMRGXAGC(0),"^",5),0)) Q:DA'>0
 S DR=+$P(GMRGXAGC(0),";",2) Q:DR'>0
 S DR=DR_"///"_$P(GMRGXAGC(0),";",3),DIE="^GMRD(124.2," D ^DIE
 Q
CHIL ;;Parent;Child to delete
 ;;
ZERO ;;Old zero;New zero
 ;;
OTHER ;;Parent;Field #;New data (@=delete)
 ;;Nursing Intervention/Orders^2^NURSC^^2;9;@
 ;;
