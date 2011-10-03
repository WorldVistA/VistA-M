DGPTFM1 ;ALB/MTC - MASTER DIAG/OP/PRO CODE ENTER/EDIT ;4/4/05 3:08pm
 ;;5.3;Registration;**114,517,635**;Aug 13, 1993
 ;
D G D^DGPTFM0
 ;
A S L="" F I=1:1:PM S L2=1 F J=5:1:9 I L2&(J'=10)&($P(M(I),U,J)="") S L=L_I_",",L2=0
 I L="" W !!,"There are no movement records that can be added to.",*7,*7 H 2 G ^DGPTFM
 S L=$E(L,1,$L(L)-1) I L=+L S RC=+L G A2
A1 I 'Z W !!,"Add to movement record <",L,"> : " R RC:DTIME G ^DGPTFM:RC[U!('$T)!(RC="")
 E  S RC=+$E(A,2,99)
A2 I +RC'=RC!(","_L_","'[(","_RC_",")) W !!,"Enter the movement record number to add ICD diagnosis to: ",L S Z="" G A1
 S DIE="^DGPT(",(DA,DGPTF)=PTF,DR="[DG501]",DGJUMP=""
 S DGMOV=+M(RC),DGADD=1 D ^DIE K DR,DA,DGADD,DIE,DGJUMP D CHK501^DGPTSCAN K DGPTF,DGMOV,DGADD
 G ^DGPTFM
 ;
M I DGPTFE G ADD^DGPTFM4
 S X=80 X ^%ZOSF("RM") D MVT K T,AM,M I $L(DGVO_DGVI)>4 S X=132 X ^%ZOSF("RM")
 G ^DGPTFM:'$D(DGPMDA) S DA=$S('$D(^DGPM(DGPMDA,"PTF")):"",1:$P(^("PTF"),"^",3)) G ^DGPTFM:'$D(^DGPT(PTF,"M",+DA,0)) S Y=^(0)
 S X=$S($D(^DIC(42.4,+$P(Y,U,2),0)):$P(^(0),U,1),1:""),Y=$P(Y,U,10)
 D D^DGPTUTL K M W !,"Editing ",$S(DA=1:"Discharge ",1:""),"Movement " W:Y]"" "of ",Y W "  Losing Specialty ",X
 S DGMOV=DA,(DA,DGPTF)=PTF,DIE="^DGPT(",DR="[DG501]",DGJUMP="1-2" D ^DIE
 K DA,DR,DIE,DGJUMP D CHK501^DGPTSCAN K DGPTF,DGMOV
 ;- update MT indicator after edit movement
 N DGPMCA,DGPMAN D PM^DGPTUTL
 I '$G(DGADM) S DGADM=+^DGPT(PTF,0)
 D MT^DGPTUTL
 G ^DGPTFM
 ;
Z I 'SU W !,"No surgeries to delete",! H 3 G ^DGPTFM
 S ST=1 I 'Z W !!,"Delete surgery record <1",$S(SU=1:"",1:"-"_SU),">: " R RC:DTIME G ^DGPTFM:'$T!(RC[U)!(RC="")
 E  S RC=$E(A,2,99) W !
 I +RC'=RC!('$D(S(RC))) W !!,"Enter the record # to delete from the PTF file, 1",$S(SU=1:"",1:"-"_SU) S Z=0 G Z
 K DA S DIK="^DGPT("_PTF_",""S"",",ST=1,(DGPTF,DA(1))=PTF,(DGSUR,DA)=+S(RC,1) D ^DIK K DA W "  ",RC,"-DELETED***" D CHK401^DGPTSCAN K DGPTF,DGSUR H 2 G ^DGPTFM
 ;
C G CEL:Z
 I '$D(S2) W !,"View codes first",! H 2 G ^DGPTFM
 I 'S2 W !,"No codes to delete",! H 2 G ^DGPTFM
C1 R !!,"Enter the item #'s of the ICD operation codes to delete: ",A1:DTIME
 S:'$T A1=U I A1'?1N.NP G ^DGPTFM:"^"[A1 W:A1'["?" "  ???",*7 D C^DGPTFM0 G C1
 S A=A_A1
CEL D EXPL^DGPTUTL
 K X,A1 S DA(1)=PTF,DP=45.01 W !!
 F J=1:1 S L=+$P(DGA,",",J),DIE="^DGPT("_PTF_",""S""," Q:'L  D
 .S L1=$S($D(S2(L)):S2(L),1:"Undefined, ") W:'L1 " ",L,"-",L1
 .I L1 S (DA,DGSUR)=+S(+L1,1),(DA(1),DGPTF)=PTF,DR=7+$P(S2(+L),U,2)_"///@" D ^DIE,CEL1
 H 3 S ST=1 G ^DGPTFM
 ;
CEL1 ;
 K DR W " ",L,"-Deleted, " W:$X>70 ! D CHK401^DGPTSCAN K DGPTF,DGSUR
 Q
 ;
O S L="" F I=1:1:SU S L2=1 F J=8:1:12 I L2,$P(S(I),U,J)="" S L=L_I_",",L2=0
 I L="" W !!,"There are no surgery records that can be added to.",*7 H 2 S ST=1 G ^DGPTFM
 S L=$E(L,1,$L(L)-1) I L=+L S RC=+L G O2
O1 I 'Z S ST=1 W !!,"Add to surgery record <",L,"> : " R RC:DTIME G ^DGPTFM:'$T!(RC[U)!(RC="")
 E  S RC=+$E(A,2,99)
O2 I +RC'=RC!(","_L_","'[(","_RC_",")) W !!,"Enter the surgery record number to add ICD operation codes to: ",L G O1:'Z S Z="" G O1
 S DIE="^DGPT(",(DGPTF,DA)=PTF,DR="[DG401]"
 S ST=1,DGZS0=RC,DGADD=1,DGSUR=S(DGZS0,1) D ^DIE,CHK401^DGPTSCAN K DR,DGPTF,DGSUR,DGADD G ^DGPTFM
 ;
S G ADD^DGPTFM5
V S DGZM0=0 G ^DGPTFM4
J S DGZS0=0 G ^DGPTFM5
Q G QEL:Z
QQ R !!,"Enter the item #'s of the ICD Procedure codes to delete: ",A1:DTIME
 S:'$T A1=U I A1'?1N.NP G ^DGPTFM:"^"[A1 W:A1'["?" "  ???",*7 D Q^DGPTFM0 G QQ
 S A=A_A1
QEL S DGA=$E(A,2,999) K X,A1 S DIE="^DGPT(",DA=PTF W !!
 F J=1:1 S DP=45,L=+$P(DGA,",",J) Q:'L  S L1=$S($D(P2(L)):P2(L),1:"Undefined, ") W:'L1 " ",L,"-",L1 I L1 S DR=+P2(+L)/100+45_"///@",DA(1)=PTF D ^DIE K DR W " ",L,"-Deleted, " W:$X>70 !
 H 2 G ^DGPTFM
 ;
P G P^DGPTFM6
Q1 Q
T G ^DGPTFM6
R G R^DGPTFM4
E I $D(^DGPT(PTF,70)),+^(70)>2871000 D MOB^DGPTFM6 G SET^DGPTFM6
 I DT>2871000 D MOB^DGPTFM6 G SET^DGPTFM6
 G ^DGPTFM6
 ;
MVT ;
 N PTF,DGPMAN
 S DGPMT=6 D CA^DGPMV S DGPMDA=+Y
 K DGPMT Q
I G ADD^DGPTFM2
Y G DEL^DGPTFM2
N G N^DGPTFM2
G G DC^DGPTFM2
F G F^DGPTFM2
