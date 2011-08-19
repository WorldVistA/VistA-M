DGPMGLC ;ALB/XAK,JDS,MJK,LM - G&L CORRECTIONS ;10 AUG 84  15:19
 ;;5.3;Registration;**36,59,170**;Aug 13, 1993
 ;
 ;
EN ;
 I $D(DGPMPC) G KILL ; if provider change, only, does not make entry in corrections file.
 I DGHNYT<16 N DGADTM,DFN S DFN=$P(^DGPM(DA,0),U,3),DGADTM=$S($D(^DGPM(+$P(^(0),U,14),0)):+^(0),1:"")
 I DGHNYT=13!(DGHNYT=14) S IVD=$O(^DGPM("ATS",DFN,+$P(^DGPM(DA,0),"^",14),9999999.9999999-$P(^DGPM(DA,0),U))) I IVD S DGTS=$O(^DGPM("ATS",DFN,+$P(^DGPM(DA,0),"^",14),IVD,0)) I DGTS S DGOTS=$S($D(^DIC(45.7,+DGTS,0)):$P(^(0),U),1:"") Q:DGTS=X
 S H=$P($H,",",2),H=DT+(H\3600/100)+(H\60#60/10000) I $D(DGIDX) S H=DGIDX,W=H\1 K ^DGS(43.5,"AGL",+$P(^DGS(43.5,H,0),U,8)\1,H) G BR
LOCK L ^DGS(43.5,H):1 I '$T!$D(^DGS(43.5,H)) L  S H=H+.00001 G LOCK
 S DGIDX=H,W=H\1,^DGS(43.5,H,0)=W,^DGS(43.5,"B",W,H)="",^DGS(43.5,"C",DFN,H)="",^(0)=$P(^DGS(43.5,0),"^",1,2)_"^"_H_"^"_($P(^(0),"^",4)+1),^DISV(DUZ,"^DGS(43.5,")=H L
BR ;
 ; -- get adm d/t
 G 3:DGHNYT=3,3:DGHNYT=6,3:DGHNYT=9,2:DGHNYT=2,2:DGHNYT=5,2:DGHNYT=8,1:DGHNYT<10,FTS:DGHNYT=13,2:DGHNYT=14,FTS:DGHNYT=15,@DGHNYT
Z S Z=$E(X,1,12),Z=$$FMTE^XLFDT(Z,"5F"),Z=$TR(Z," ","0"),Z=$TR(Z,":") Q
1 ; ADM,XFR,DIS ENTERED
 D Z S ^DGS(43.5,H,0)=W_"^"_DGHNYT_"^^"_Z_"^"_DFN_"^"_DGADTM_"^"_DUZ_U_$P(X,"."),^DGS(43.5,"AGL",$P(X,"."),H)="" K DGIDX,DGHNYT Q
2 ; ADM,XFR,DIS,FACILITY TS DELETED
 N X S X=+^DGPM(DA,0) ; gets date/time of mvt
 D Z S ^DGS(43.5,H,0)=W_"^"_DGHNYT_"^"_Z_"^^"_DFN_"^"_DGADTM_"^"_DUZ_U_$P(X,".")_$S(DGHNYT=5:U_X,1:""),^DGS(43.5,"AGL",$P(X,"."),H)="" K DGHNYT Q
3 ; ADM,XFR,DIS DATE EDITED
 D Z,NUM S DGED=$S(DGED&(DGED<X):DGED,1:X)\1,^(0)=W_"^"_DGHNYT_"^"_$P(^DGS(43.5,H,0),"^",3)_"^"_Z_"^"_DFN_"^"_DGADTM_"^"_DUZ_U_DGED,^DGS(43.5,"AGL",DGED,H)="" K DGIDX,DGED,DGHNYT Q
10 ; ADM WARD EDITED
 S ^DGS(43.5,H,0)=W_"^10^"_$S($D(DGOWD):DGOWD,1:"")_"^"_$S($D(^DIC(42,+X,0)):$P(^(0),"^",1),1:X)_"^"_DFN_"^"_DGADTM_"^"_DUZ_U_$P(DGADTM,"."),^DGS(43.5,"AGL",$P(DGADTM,"."),H)="" K DGOWD,DGIDX,DGHNYT Q
11 ; MAS TYPE EDITED
 S L=+^DGPM(DA,0),^DGS(43.5,H,0)=W_"^11^"_$S($D(DGOTY):DGOTY,1:"")_"^"_$S($D(^DG(405.2,+X,0)):$P(^(0),"^",1),1:X)_"^"_DFN_"^"_DGADTM_"^"_DUZ_U_$P(L,".")_U_L,^DGS(43.5,"AGL",$P(L,"."),H)="" K DGOTY,DGIDX,DGHNYT Q
12 ; XFR WARD EDITED
 S L=+^DGPM(DA,0),^DGS(43.5,H,0)=W_"^12^"_$S($D(DGOWD):DGOWD,1:"")_"^"_$S($D(^DIC(42,+X,0)):$P(^(0),"^",1),1:X)_"^"_DFN_"^"_DGADTM_"^"_DUZ_U_$P(L,".")_U_L,^DGS(43.5,"AGL",$P(L,"."),H)="" K DGOWD,DGIDX,DGHNYT Q
 Q
FTS ;  FACILITY TS
 ;  13 = ENTERED
 ;  14 = DELETED
 ;  15 = FACILITY TS DATE EDITED
 ;S IVD=$O(^DGPM("ATS",DFN,+$P(^DGPM(DA,0),"^",14),9999999.9999999-$P(^DGPM(DA,0),U))) S:IVD DGTS=$O(^DGPM("ATS",DFN,+$P(^DGPM(DA,0),"^",14),IVD,0)) S:DGTS DGOTS=$S($D(^DIC(45.7,+DGTS,0)):$P(^(0),U),1:"") Q:DGTS=X
 I DGHNYT=15 D Z
 S L=+^DGPM(DA,0),^DGS(43.5,H,0)=W_"^"_DGHNYT_"^"_$S(DGHNYT=15:$P(^DGS(43.5,H,0),"^",3),$D(DGOTS):DGOTS,1:"")_"^"_$S(DGHNYT=15:"",$D(^DIC(45.7,+X,0)):$P(^(0),"^",1),1:X)_"^"_DFN_"^"_DGADTM_"^"_DUZ_U_$P(L,".")_U_L
 S ^DGS(43.5,"AGL",$P(L,"."),H)="" ; sets flag in G&L Corrections file
KILL K DGOTS,DGIDX,DGHNYT,DGTS,IVD Q
 Q
NUM S DGX=X,%DT="",X=$P($P(^DGS(43.5,H,0),U,3),"@",1) D ^%DT S DGED=$P(+Y,"."),X=DGX K DGX Q
 ;
