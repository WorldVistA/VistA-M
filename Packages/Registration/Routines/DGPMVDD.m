DGPMVDD ;ALB/MIR - MISCELLANEOUS DD CALLS FROM FILE 405 AND 405.1 ; 4/14/04 6:26pm
 ;;5.3;Registration;**418,593**;Aug 13, 1993
W ;called from input transform for ward location
 I '$D(DGPMT) K X,DIC Q
 S DGPMTYP=$P(^DGPM(DA,0),"^",18),DGPMWD=$P(DGPMP,"^",6) D W1:DGPMT=1,W2:DGPMT=2!($P(^DGPM(DA,0),"^",2)=2) Q
W1 ;consistency edits for ward location from admit option
 I $D(DGPMSVC) S DIC("S")=DIC("S")_","_$S(DGPMSVC="H":"""^NH^D^""'[(""^""_$P(^(0),""^"",3)_""^"")",1:"$P(^(0),""^"",3)=DGPMSVC") Q
 S DGX=$P(DGPMP,"^",17) I DGX,(DGPMTYP=40),$S('$D(^DGPM(+DGX,0)):0,+^(0):1,1:0) S DIC("S")="I +Y=DGPMWD" Q
 ;S DGX="" I DGPMTYP=18 S DIC("S")=DIC("S")_",""^NH^D^""[(""^""_$P(^(0),""^"",3)_""^"")" Q
 S DGX="" I DGPMTYP=18 S DIC("S")=DIC("S")_",""^NH^D^""[(""^""_$P(^(0),""^"",3)_""^"")!($P(^(0),""^"",17)=1)" ;p-418
 ;I (DGPMWD&$S($P(DGPM2,"^",2)=2:1,1:0))!(DGPMTYP=40) S DGX=$S($D(^DIC(42,+DGPMWD,0)):$P(^(0),"^",3),1:""),DGX=$S("^NH^D^"'[("^"_DGX_"^"):"H",1:DGX)
 ;S DGPMWD="",DGPMTYP=40  ; simulate NOIS REN-0304-60611
 I (DGPMWD&$S($P(DGPM2,"^",2)=2:1,1:0))!(DGPMTYP=40) S DGX=$S($D(^DIC(42,+DGPMWD,0)):$P($G(^DIC(42,+DGPMWD,0)),U,3),1:""),DGX=$S("^NH^D^"'[("^"_DGX_"^")&($P($G(^DIC(42,+DGPMWD,0)),U,17)'=1):"H",1:DGX) ;p-418/593
 ;I DGX]"" S DIC("S")=DIC("S")_",("_$S(DGX="NH":"""^NH^:""[",DGX="D":"""^D^""[",1:"""^NH^D^""'[")_"(""^""_$P(^(0),""^"",3)_""^""))"
ZZ I DGX]"" S DIC("S")=DIC("S")_",("_$S(DGX="NH":"""^NH^:""[",DGX="D":"""^D^""[",1:"""^NH^D^""'[")_"(""^""_$P(^(0),""^"",3)_""^"")&($P(^(0),""^"",17)'=1))" ;p-418
 I $P(DGPM2,"^",2)=2&$P(DGPM2,"^",6),'DGPMABL S DIC("S")=DIC("S")_",+Y'=$P(DGPM2,""^"",6)"
 Q
W2 ;Ward consistency check for transfer.  interward transfers not to same ward.  unless ASIH mvt, can't go from hospital to NHCU/DOM, vice versa
 ;I "^13^44^"[("^"_DGPMTYP_"^") S DIC("S")=DIC("S")_",""^NH^D^""'[(""^""_$P(^(0),""^"",3)_""^"")" Q
 I "^13^44^"[("^"_DGPMTYP_"^") S DIC("S")=DIC("S")_",""^NH^D^""'[(""^""_$P(^(0),""^"",3)_""^"")&($P(^(0),U,17)'=1)" Q  ;added p-418
 S DGX=$S($D(^DGPM(+$P(^DGPM(DA,0),"^",14),0)):$P(^(0),"^",6),1:0),DGX=$S($D(^DIC(42,+DGX,0)):$P(^(0),"^",3),1:"")
 N DGRAI S DGRAI=$S(DGX="":"",1:$P(^(0),"^",17)) ;added p-418
 ;I "^14^43^45^"[("^"_DGPMTYP_"^") S DIC("S")=DIC("S")_",DGX=$P(^(0),""^"",3)" Q
 I "^14^43^45^"[("^"_DGPMTYP_"^") D  Q  ;added p-418
 .I DGX="D" S DIC("S")=DIC("S")_",($P(^(0),""^"",3)="""_DGX_""")"
 .I DGX="NH"!(DGX="I"&(DGRAI=1)) S DIC("S")=DIC("S")_",""^NH^""[(""^""_$P(^(0),""^"",3)_""^"")!(""^I^""[(""^""_$P(^(0),""^"",3)_""^"")&($P(^(0),""^"",17)=1))" ;added p-418
 S DGX=$S($D(^DIC(42,+$P(DGPM0,"^",6),0)):$P(^(0),"^",3),1:"")
 S DGRAI=$S(DGX="":"",1:$P(^(0),"^",17)) ;added p-418
 ;I DGX="D"!(DGX="NH") S DIC("S")=DIC("S")_",($P(^(0),""^"",3)="""_DGX_""")"
 I DGX="D"!(DGX="NH")!(DGX="I"&(DGRAI=1)) D
 .I DGX="D" S DIC("S")=DIC("S")_",($P(^(0),""^"",3)="""_DGX_""")"
 .I DGX="NH"!(DGX="I"&(DGRAI=1)) S DIC("S")=DIC("S")_",""^NH^""[(""^""_$P(^(0),""^"",3)_""^"")!(""^I^""[(""^""_$P(^(0),""^"",3)_""^"")&($P(^(0),""^"",17)=1))" ;added p-418
 ;I DGX'="D"&(DGX'="NH") S DIC("S")=DIC("S")_",""^NH^D^""'[(""^""_$P(^(0),""^"",3)_""^"")"
 I DGX'="D"&(DGX'="NH")&(DGX'="I"!(DGRAI'=1)) D
 .S DIC("S")=DIC("S")_",""^NH^D^""'[(""^""_$P(^(0),""^"",3)_""^"")&((""^I^""'[(""^""_$P(^(0),""^"",3)_""^"")!($P(^(0),""^"",17)'=1)))" ;added p-418
 I $D(^DG(405.2,+DGPMTYP,"E")),'^("E") S DGX=$S(DGPMABL:0,1:$P(DGPM2,"^",6)),DIC("S")=DIC("S")_",+Y'=DGX,+Y'=$P(DGPM0,""^"",6)"
 Q
WARD ;is ward active at time of movement?
 S DGPMOS=+^DGPM(DA,0) N D0,X S D0=+Y D WIN^DGPMDDCF I X W !,"Ward inactive at time of movement" S DGOOS=1 Q
 Q
ROOM ;is room-bed active at time of movement? - called from input transform of .07 in 405
 S DGPMOS=$S('$D(DGSWITCH):+^DGPM(DA,0),1:DT) N D0,X S D0=+Y D RIN^DGPMDDCF I X W !,"Room-bed inactive at time of movement" S DGOOS=1 Q
 Q
 ;
TROC ;is bed occupied when transferring from 1 or 23 movement?
 ;called from DGPM TRANSFER edit template
 ;output variables DGPMOC &/or DGOOS
 ;DGPMOC = 2 if occupied & no more beds on ward, 1 if occupied, 0 if unoccupied
 ;DGOOS = 1 if inactive (out-of-service), otherwise = 0
 S (DGPMOC,DGOOS)=0,DGZ7=$P(DGPM0,"^",7),DGZ6=+$P(DGPM0,"^",6)
 F DGPMX=0:0 S DGPMX=$O(^DGPM("ARM",+DGZ7,DGPMX)) Q:DGPMX'>0  I $D(^DGPM(DGPMX,0)),$P(DGPM0,"^",3)'=$P(^DGPM(DGPMX,0),"^",3) S DGPMOC=1
 ;I 'DGPMOC,$S('$D(^DGPM(+DGPMX,0)):0,'$D(^DG(405.4,DGZ7,"W","B",+$P(DGPM0,"^",6))):1,1:0) S DGPMOC=1
 ;I DGPMOC S DGOCC=0 D TROCWB I DGOCC=DGB S DGPMOC=2
 I 'DGPMOC S DGPMOS=+DGPM0 N D0,X S D0=+DGZ7 D RIN^DGPMDDCF S:X DGOOS=1
 K DGB,DGOCC,DGPMX,DGPMOS,I Q
 Q
TROCWB ;check if ward still has available beds
 S I=0 F DGB=0:1 S I=$O(^DG(405.4,"W",DGZ6,I)) Q:I'>0  I $D(^DGPM("ARM",I)) S DGOCC=DGOCC+1
 ;
ABSRET ;check absence return date for consistency with movement type
 S DGPMX=^DGPM(DA,0),DGPMTYP=$P(DGPMX,"^",18),DGPMRD=X
 I DGPMTYP=1 S X1=$P(+DGPMX,".",1),X2=4 D C^%DTC I DGPMRD>X K X W !,"Must be within 4 days"
 I DGPMTYP=2 S X1=$P(+DGPMX,".",1),X2=5 D C^%DTC I DGPMRD<X K X W !,"Must be more than 4 days"
 I $D(X) S X1=$P(+DGPMX,".",1),X2=30 D C^%DTC I DGPMRD>X K X W !,"Must be within 30 days of transfer"
 S:$D(X) X=DGPMRD K DGPMTYP,DGPMX,DGPMRD
 Q
 ;
UARET ;called from DGPM TRANSFER template...default 30 day return from UA
 N DGPMX,X,X1,X2,Y
 S DGPMX=^DGPM(DA,0)
 I $P(DGPMX,"^",18)'=3 S DGPMRET="" Q
 S X1=$P(+DGPMX,".",1),X2=30 D C^%DTC S Y=X X ^DD("DD") S DGPMRET=Y
 Q
