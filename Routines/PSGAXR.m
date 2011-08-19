PSGAXR ;BIR/CML3-EXECUTE VARIOUS XREFS ;24 JUN 96 / 12:06 PM
 ;;5.0; INPATIENT MEDICATIONS ;**111**;16 DEC 97
 ;
ENSS ; set x-refs under 53.1,28
 S ZZ=+$G(^PS(53.1,DA,.2)) S:$D(PSGP)[0 PSGP=$P($G(^PS(53.1,DA,0)),"^",15)_"^1" I 'PSGP,'ZZ K ZZ K:$P(PSGP,"^",2) PSGP Q
 I PSGP D 
 . S ^PS(53.1,"AS",X,+PSGP,DA)="" I $S(X["A":0,1:X'["D") S ^PS(53.1,"AC",+PSGP,DA)="" S:ZZ ^PS(53.1,"AOD",+PSGP,ZZ,DA)=""
 . I X="P",+$P($G(^PS(53.1,DA,4)),U) S ^PS(53.1,"AV",+PSGP,DA)=""
 ;I X]"" S ZZ=$S($G(ORIFN):ORIFN,1:$P($G(^PS(53.1,DA,0)),"^",21)_"^1") I ZZ S ORIFN=+ZZ D ENSC^PSGORU K:$P(ZZ,"^",2) ORIFN
 ;D EN1^PSJHL2(PSGP,"OC",DA_"P")
 K ZZ K:$P(PSGP,"^",2) PSGP Q
 ;
ENSK ; kill x-refs under 53.1,28
 S:$D(PSGP)[0 PSGP=$P($G(^PS(53.1,DA,0)),"^",15)_"^1" S ZZ=+$G(^PS(53.1,DA,.1)),ZZZ=+$G(^PS(53.1,DA,"DSS"))
 I PSGP K ^PS(53.1,"AC",+PSGP,DA),^PS(53.1,"AS",X,+PSGP,DA),^PS(53.1,"AV",+PSGP,DA) K:ZZ ^PS(53.1,"AOD",+PSGP,ZZ,DA) K:ZZZ ^PS(53.1,"AD",ZZZ,+PSGP,DA)
 K ZZ K:$P(PSGP,"^",2) PSGP Q
 ;
ENNDS ; set x-refs under 53.1,.1
 S ^PS(53.1,"D",X,DA)="" S:$D(PSGP)[0 PSGP=$P($G(^PS(53.1,DA,0)),"^",15)_"^1" I PSGP S PSGX=X D END^PSGSICHK S X=PSGX,PSGX=$P($G(^PS(53.1,DA,0)),"^",9) I $S(PSGX["A":0,1:PSGX'["D") S ^PS(53.1,"AOD",+PSGP,X,DA)=""
 K PSGX K:$P(PSGP,"^",2) PSGP Q
 ;
ENNDK ; kill x-refs under 53.1,.1
 S:$D(PSGP)[0 PSGP=$P($G(^PS(53.1,DA,0)),"^",15)_"^1" K ^PS(53.1,"D",X,DA) K:PSGP ^PS(53.1,"AOD",+PSGP,X,DA) K:$P(PSGP,"^",2) PSGP Q
 ;
ENNPS ; set x-refs under 53.1,.5
 S ^PS(53.1,"C",X,DA)="",PSGX=$P($G(^PS(53.1,DA,0)),"^",9) S:PSGX]"" ^PS(53.1,"AS",PSGX,X,DA)=""
 I $S(PSGX["A":0,1:PSGX'["D") S ^PS(53.1,"AC",X,DA)=""
 I PSGX="P",+$P($G(^PS(53.1,DA,4)),U) S ^PS(53.1,"AV",X,DA)=""
 S:PSGX ^PS(53.1,"AOD",X,PSGX,DA)=""
 K PSGX Q
 ;
ENNPK ; kill x-refs under 53.1,.5
 K ^PS(53.1,"AC",X,DA),^PS(53.1,"C",X,DA) S PSGX=$P($G(^PS(53.1,DA,0)),"^",9) K:PSGX]"" ^PS(53.1,"AS",PSGX,X,DA) S PSGX=+$G(^PS(53.1,DA,.1)) K:PSGX ^PS(53.1,"AOD",X,PSGX,DA)
 K ^PS(53.1,"AV",X,DA)
 K PSGX Q
ENNACK ; Set x-refs under Nurse verification for acknowleged pending orders.
 S PSGX=$G(^PS(53.1,DA,0)) S PSGP=$P(PSGX,U,15)
 S PSGST=$P(PSGX,U,9)
 I PSGP,+X,(PSGST="P") S ^PS(53.1,"AV",PSGP,DA)=""
 K PSGX,PSGP,PSGST Q
ENNACKK ; Kill x-refs under Nurse verification
 S PSGP=$P($G(^PS(53.1,DA,0)),U,15)
 K:+PSGP ^PS(53.1,"AV",+PSGP,DA) Q
