LRAPLG1 ;AVAMC/REG/WTY/KLL - LOG-IN CONT. ;07/30/04
 ;;5.2;LAB SERVICE;**72,121,248,308**;Sep 27, 1994
 ;
 ;Reference to ^%ZOSF("TEST" supported by IA #10096
 ;Reference to ^VA(200 supported by IA #10060
 ;Reference to ^%DT supported by IA #10003
 ;Reference to EN^DDIOL supported by IA #10142
 ;Reference to ^DIE supported by IA #10018
 ;Reference to DISP^SROSPLG supported by IA #893
 ;
 L +^LRO(68,LRAA,1,LRAD):5 I '$T D  Q
 .S MSG="Someone else is logging in specimens.  "
 .S MSG=MSG_"Please wait and try again."
 .D EN^DDIOL(MSG,"","!!") K MSG
 S LRAN=$P(^LRO(68,LRAA,1,LRAD,1,0),"^",3)
 F X=0:0 S LRAN=LRAN+1 Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))
 I $D(^LR(LRXREF,LRH(2),LRABV,LRAN)) F X=0:0 S LRAN=LRAN+1 Q:'$D(^LR(LRXREF,LRH(2),LRABV,LRAN))
 W !!,"Assign ",LRO(68)," (",LRABV,") accession #:  ",LRAN," " S %=1 D YN^LRU
 I %<1 L -^LRO(68,LRAA,1,LRAD) G OUT
 I %=2 D OS G:'$D(LRFND) AU K LRFND L -^LRO(68,LRAA,1,LRAD) G OUT
 S X=^LRO(68,LRAA,1,LRAD,1,0),X(2)=$P(X,"^",4)+1
 S ^LRO(68,LRAA,1,LRAD,1,0)=$P(X,"^",1,2)_"^"_LRAN_"^"_X(2)
 S ^LRO(68,LRAA,1,LRAD,1,LRAN,0)=LRDFN,X=LRAN
 L -^LRO(68,LRAA,1,LRAD)
AU S LRAN=X,LRAC=LRABV_" "_$E(LRAD,2,3)_" "_LRAN I LRSS="AU" D ^LRAUAW Q
 S DA(1)=LRDFN S:'$D(^LR(LRDFN,LRSS,0)) ^(0)="^"_LRSF_"DA^0^0"
DT W !,"Date/time Specimen taken: "
 W $S($E(LRAD,1,3)=$E(DT,1,3):"NOW// ",1:"")
 R X:DTIME G:X[U!('$T) END
 S:X=""&($E(LRAD,1,3)=$E(DT,1,3)) X="N"
 S %DT="ETX",%DT(0)="-N" D ^%DT K %DT
 G:X["?" DT G:Y=-1 END
 S LRSD=Y,LRI=9999999-Y
 L +^LR(LRDFN,LRSS):5 I '$T D  Q
 .S MSG="This record is locked by another user.  "
 .S MSG=MSG_"Please wait and try again."
 .D EN^DDIOL(MSG,"","!!"),X K MSG
F I $D(^LR(LRDFN,LRSS,LRI,0)) S LRI=LRI-.00001 G F
 S ^LR(LRDFN,LRSS,LRI,0)=LRSD
 S X=^LR(LRDFN,LRSS,0),^(0)=$P(X,"^",1,2)_"^"_LRI_"^"_($P(X,"^",4)+1)
 L -^LR(LRDFN,LRSS)
 S LR(.07)=$S($D(SRDOC):SRDOC,1:"") K SRDOC
 S:LR(.07) LR(.07)=$P($G(^VA(200,LR(.07),0)),"^")
 S DIC(0)="EQLMF",DLAYGO=63,DA=LRI,DIE="^LR(LRDFN,LRSS,"
 D @LR("L"),^DIE K DLAYGO
 I $D(Y)!($D(DTOUT)) D  Q
 .W $C(7),!!,"All Prompts not answered  <ENTRY DELETED>"
 .K ^LR(LRDFN,LRSS,DA)
 .S X=^LR(LRDFN,LRSS,0),X(1)=$O(^(0))
 .S ^LR(LRDFN,LRSS,0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-1)
 .D X
 I LRSS="CY",LRCAPA D CK^LRAPCWK
 I LRSS="SP" S X="SROSPLG" X ^%ZOSF("TEST") I $T D DISP^SROSPLG
 D ^LRUWLF D:LRSS="CY"&LRCAPA ^LRAPCWK D:"SPEM"[LRSS&LRCAPA ^LRAPSWK D:"SPCYEM"[LRSS ^LRSPGD
 D OERR^LR7OB63D
 Q
X ;from LRAUAW
 K:"CYEMSP"[LRSS ^LR(LRXREF,LRH(2),LRABV,LRAN)
 I LRSS="AU",$D(LRRC) D
 .K ^LR("AAUA",+$E(LRRC,1,3),LRABV,LRAN),^LR("AAU",+LRRC,LRDFN)
 I $D(LRRC),LRRC>1 K:"CYEMSP"[LRSS ^LR(LRXR,LRRC,LRDFN,LRI)
 K LRRC
END ;from LRAUAW, LRAPLG2
 L +^LRO(68,LRAA,1,LRAD):5 I '$T D  Q
 .S MSG="Someone else is logging in specimens.  "
 .S MSG=MSG_"Please wait and try again."
 .D EN^DDIOL(MSG,"","!!") K MSG
 K ^LRO(68,LRAA,1,LRAD,1,LRAN),^LRO(68,LRAA,1,"AC",DUZ(2),LRAD,LRAN)
 S X=^LRO(68,LRAA,1,LRAD,1,0),X(1)=$O(^(0)),X(2)=$P(X,"^",4)-1
 S ^LRO(68,LRAA,1,LRAD,1,0)=$P(X,"^",1,2)_"^"_X(1)_"^"_X(2)
 L -^LRO(68,LRAA,1,LRAD)
 Q
OS R !!,"Enter Accession # : ",X:DTIME I X=""!(X[U) S LRFND=1 Q
 I X'?1N.N!(X<1)!(X>99999) W $C(7),!!,"ENTER A WHOLE NUMBER FROM 1 TO 99999",! G OS
 I $D(^LRO(68,LRAA,1,LRAD,1,X,0)),$P(^(0),U) D ^LRUTELL G OS
 S ^LRO(68,LRAA,1,LRAD,1,X,0)=LRDFN I $D(LRXREF),$D(^LR(LRXREF,LRH(2),LRABV,X)) D ^LRAPLG2 S LRFND=1
 Q
OUT Q
