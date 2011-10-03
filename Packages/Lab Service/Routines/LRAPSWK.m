LRAPSWK ;AVAMC/REG - STUFF AP WORKLOAD ;2/22/96  10:27
 ;;5.2;LAB SERVICE;**91**;Sep 27, 1994
 S LRK=LRRC S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0)) ^(0)="^68.04PA^^" D STF
 I "SPEM"[LRSS S A(1)=0 F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A  S A(1)=A(1)+1,A(2)=$E($P(^(A,0),"^"),1,9) D @(LRSS_1)
 I "SPCYEM"[LRSS,$G(LRW("S")) S C=LRW("S") D CAP
 D:LRSS="AU" AU1 S A(1)=1 F C=0:0 S C=$O(^LAB(60,LRT,9,C)) Q:'C  D CAP
 S A(1)=1 F C=0:0 S C=$O(^LAB(60,LRT,9.1,C)) Q:'C  D CAP
 S ^LRO(68,"AA",LRAA_"|"_LRAD_"|"_LRAN_"|"_LRT)=""
 Q
 ;
SP1 S ^LR(LRDFN,"SP",LRI,.1,A,1,0)="^63.8121A^1^1",^(1,0)=A(2),^(1,0)="^63.8122PA^"_LRW("H&E")_"^1",^(LRW("H&E"),0)=LRW("H&E")_"^1" S:A(2)]"" ^LR(LRDFN,"SP",LRI,.1,A,1,"B",A(2),1)="" Q
EM1 S ^LR(LRDFN,"EM",LRI,.1,A,1,0)="^63.2021A^1^1",^(1,0)="EPON 1",^(1,0)="^63.20211PA^"_+LRW("G")_"^2",^(+LRW("SS"),0)=LRW("SS")
 S ^LR(LRDFN,"EM",LRI,.1,A,1,1,1,+LRW("G"),0)=LRW("G"),^LR(LRDFN,"EM",LRI,.1,A,1,"B","EPON 1",1)="" Q
AU1 K E I $O(^LRO(69.2,LRAA,6,0)) S E=0 F A=0:0 S A=$O(^LRO(69.2,LRAA,6,A)) Q:'A  S B=$P(^(A,0),"^") I B]"" S E=E+1,^LR(LRDFN,33,E,0)=B,^LR(LRDFN,33,"B",B,E)="" D AU2
 S:$D(E) ^LR(LRDFN,33,0)="^63.033A^"_E_"^"_E Q
AU2 S ^LR(LRDFN,33,E,1,0)="^63.331A^1^1",^(1,0)=$E(B,1,9),^(1,0)="^63.3311PA^"_LRW("H&E")_"^1",^(LRW("H&E"),0)=LRW("H&E")_"^1" Q
 ;
STF I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,0)) S ^(0)=LRT_"^50^^"_DUZ_"^"_LRRC,X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,0),^(0)=$P(X,"^",1,2)_"^"_LRT_"^"_($P(X,"^",4)+1)
 S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0)) ^(0)="^68.14P^^" Q
 ;
CAP I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,C,0)) S ^(0)=C_"^"_A(1)_"^0^0^^"_LRRC_"^"_DUZ_"^"_DUZ(2)_"^"_LRAA_"^"_LRAA_"^"_LRAA,X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0),^(0)=$P(X,"^",1,2)_"^"_C_"^"_($P(X,"^",4)+1) Q
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,C,0),$P(X,"^",2)=$S($P(X,"^",3):A(1),1:$P(X,"^",2)+A(1)),$P(X,"^",3)=0,^(0)=X Q
 ;
SP S X="SURGICAL PATHOLOGY LOG-IN" D A^LRUWK Q:'$D(X)  S (LRW("S"),X)=$O(^LAM("E","88000.0000",0)) Q:X  S X="SP SPECIMEN",Y="88000.0000" D W^LRUWK Q
CY S LRT="",(LRW("S"),X)=$O(^LAM("E","88056.0000",0)) Q:X  S X="CY Specimen",Y="88056.0000" D W^LRUWK Q
EM S LRW("S")=$O(^LAM("E","88057.0000",0)),X="EM LOG-IN" D A^LRUWK Q:$D(X)  S X="EM Specimen",Y="88057.0000" D W^LRUWK Q
AU S X="AUTOPSY LOG-IN" D A^LRUWK Q
 ;
CK I '$O(^LR(LRDFN,LRSS,LRI,.1,0)) S Y=1 W !!,"No SPECIMEN entered." G OUT
 S A=0 F B=1:1 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A  S X=^(A,0) I '$P(X,"^",2) W:B=1 ! W !,"WORKLOAD PROFILE NOT ENTERED FOR ",$P(X,U) S Y=1
 ;
C ;count number of specimens, called by LRAPED,LRAPDA,LRAPM
 K LRL,LRN S LRM=0
D S LRL=0 F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A  S LRL=LRL+1 I LRSS="CY",'LRM S X=^(A,0),B=$P(X,"^",2) I B S:'$D(LRN(B)) LRN(B)=0 S LRN(B)=LRN(B)+1
 Q
C1 ; Workload code count update SURG PATH, CYTO or EM specimens
 I "EM"[LRSS,$G(LRSOP)="Z" Q
 Q:'LRW("S")  S LRL(1)=LRL,LRM=1 D D Q:LRL'>LRL(1)  S A(1)=LRL-LRL(1) I LRSS'="CY" D STF1,SET Q
 K LRL F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A  S X=^(A,0),B=$P(X,"^",2) I B S:'$D(LRL(B)) LRL(B)=0 S LRL(B)=LRL(B)+1
 S LRT=0 F  S LRT=$O(LRL(LRT)) Q:'LRT  S LRL=LRL(LRT) S A(1)=LRL(LRT)-$G(LRN(LRT)) D:A(1)>0 STF1,SET
 Q
SET S ^LRO(68,"AA",LRAA_"|"_LRAD_"|"_LRAN_"|"_LRT)=""
 Q
 ;
STF1 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,0)) S ^(0)=LRT_"^50^^"_DUZ_"^"_LRRC
 S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0)) ^(0)="^68.04PA^^"
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,0),^(0)=$P(X,"^",1,2)_"^"_LRT_"^"_($P(X,"^",4)+1)
 S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0)) ^(0)="^68.14P^^" S C=LRW("S")
 I $D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,C,0)) S X=^(0) N LRTALLY D
 . S LRTALLY=$P(X,U,4)
 . S A(1)=LRL-LRTALLY
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,C,0)) S ^(0)=C_"^"_A(1)_"^0^0^^"_LRRC_"^"_DUZ_"^"_DUZ(2)_"^"_LRAA_"^"_LRAA_"^"_LRAA,X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0),^(0)=$P(X,"^",1,2)_"^"_C_"^"_($P(X,"^",4)+1) Q
 ;S X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,C,0),Y=$P(X,"^",2) S Y=Y+A(1),$P(X,"^",2)=Y,^(0)=X Q
 S ^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,C,0)=C_"^"_A(1)_"^"_"0"_"^"_LRTALLY_"^^"_LRRC_"^"_DUZ_"^"_DUZ(2)_"^"_LRAA_"^"_LRAA_"^"_LRAA Q
 ;
OUT Q
