MCPARC ; GENERATED FROM 'MCNONENDOPARAC' PRINT TEMPLATE (#1278) ; 12/09/02 ; (FILE 699, MARGIN=75)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 I $D(DXS)<9 M DXS=^DIPT(1278,"DXS")
 S I(0)="^MCAR(699,",J(0)=699
 D N:$X>4 Q:'DN  W ?4 W "PRIMARY PROVIDER: "
 S X=$G(^MCAR(699,D0,"PROV")) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,35)
 D N:$X>4 Q:'DN  W ?4 W "FELLOW: "
 S X=$G(^MCAR(699,D0,200)) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,35)
 D N:$X>39 Q:'DN  W ?39 W "2ND FELLOW: "
 S X=$G(^MCAR(699,D0,29)) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,35)
 D N:$X>4 Q:'DN  W ?4 W "PERFORMED AT: "
 S X=$G(^MCAR(699,D0,0)) S Y=$P(X,U,10) S Y=$S(Y="":Y,$D(^SC(Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 W "PERFORMED BY: "
 S Y=$P(X,U,8) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,35)
 D N:$X>4 Q:'DN  W ?4 W "WARD/CLINIC: "
 S Y=$P(X,U,11) S Y=$S(Y="":Y,$D(^SC(Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROCEDURE: "
 S I(100)="^MCAR(697.2,",J(100)=697.2 S I(0,0)=D0 S DIP(1)=$S($D(^MCAR(699,D0,0)):^(0),1:"") S X=$P(DIP(1),U,12),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 S X=$G(^MCAR(697.2,D0,0)) W ?0,$E($P(X,U,8),1,30)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>4 Q:'DN  W ?4 W "PROCEDURE SUMMARY: "
 S X=$G(^MCAR(699,D0,.2)) W ?0,$E($P(X,U,2),1,79)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROCEDURE START TIME: "
 S X=$G(^MCAR(699,D0,9)) W ?0,$E($P(X,U,1),1,4)
 D N:$X>39 Q:'DN  W ?39 W "PROCEDURE STOP TIME: "
 W ?0,$E($P(X,U,2),1,4)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "URGENCY: "
 S Y=$P(X,U,3) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROTOCOL: "
 S X=$G(^MCAR(699,D0,31)) W ?0,$E($P(X,U,1),1,79)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "EGD SIMPLE PRI. EXAM: "
 W ?0,$E($P(X,U,2),1,50)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "LAB OR XRAY: "
 W ?0,$E($P(X,U,3),1,50)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "OCCULT BLOOD: "
 S X=$G(^MCAR(699,D0,32)) W ?0,$E($P(X,U,1),1,50)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SPECIMEN COLLECTION: "
 W ?0,$E($P(X,U,2),1,50)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PRESCRIPTION GIVEN: "
 S I(1)=26,J(1)=699.74 F D1=0:0 Q:$O(^MCAR(699,D0,26,D1))'>0  X:$D(DSC(699.74)) DSC(699.74) S D1=$O(^(D1)) Q:D1'>0  D:$X>26 T Q:'DN  D B1
 G B1R
B1 ;
 D N:$X>9 Q:'DN  W ?9 W " "
 S X=$G(^MCAR(699,D0,26,D1,0)) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^PSDRUG(Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>49 Q:'DN  W ?49 W "DOSAGE: "
 W ?0,$E($P(X,U,2),1,30)
 Q
B1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INSTRUCTION: "
 S I(1)=203,J(1)=699.0203 F D1=0:0 Q:$O(^MCAR(699,D0,203,D1))'>0  S D1=$O(^(D1)) D:$X>19 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^MCAR(699,D0,203,D1,0)) S DIWL=20,DIWR=73 D ^DIWP
 Q
C1R ;
 D 0^DIWW
 D ^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INSTRUMENT: "
 S I(1)=34,J(1)=699.05 F D1=0:0 Q:$O(^MCAR(699,D0,34,D1))'>0  X:$D(DSC(699.05)) DSC(699.05) S D1=$O(^(D1)) Q:D1'>0  D:$X>18 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^MCAR(699,D0,34,D1,0)) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.48,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 Q
D1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "MEDICATIONS: "
 S I(1)=8,J(1)=699.38 F D1=0:0 Q:$O(^MCAR(699,D0,8,D1))'>0  X:$D(DSC(699.38)) DSC(699.38) S D1=$O(^(D1)) Q:D1'>0  D:$X>19 T Q:'DN  D E1
 G E1R
E1 ;
 D N:$X>9 Q:'DN  W ?9 W " "
 S X=$G(^MCAR(699,D0,8,D1,0)) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695,Y,0))#2:$P(^(0),U),1:Y) S Y=$S(Y="":Y,$D(^PSDRUG(Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>29 Q:'DN  W ?29 W "DOSE ROUTE: "
 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>59 Q:'DN  W ?59 W "TOTAL DOSE: "
 S Y=$P(X,U,3) W:Y]"" $J(Y,8,2)
 Q
E1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "POST-PROCEDURE INST. CLEANING: "
 S X=$G(^MCAR(699,D0,15)) S Y=$P(X,U,10) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SIGNS AND SYMPTOMS: "
 S I(1)=3,J(1)=699.18 F D1=0:0 Q:$O(^MCAR(699,D0,3,D1))'>0  X:$D(DSC(699.18)) DSC(699.18) S D1=$O(^(D1)) Q:D1'>0  D:$X>26 T Q:'DN  D F1
 G F1R
F1 ;
 S X=$G(^MCAR(699,D0,3,D1,0)) D N:$X>25 Q:'DN  W ?25 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695.5,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,99)
 Q
F1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SUMMARY: "
 S X=$G(^MCAR(699,D0,.2)) S Y=$P(X,U,1) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "RESULTS: "
 S I(1)=16,J(1)=699.56 F D1=0:0 Q:$O(^MCAR(699,D0,16,D1))'>0  X:$D(DSC(699.56)) DSC(699.56) S D1=$O(^(D1)) Q:D1'>0  D:$X>15 T Q:'DN  D G1
 G G1R
G1 ;
 S X=$G(^MCAR(699,D0,16,D1,0)) D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.81,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,60)
 Q
G1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "FOLLOWUP DEVICE/THERAPY: "
 S I(1)=6,J(1)=699.36 F D1=0:0 Q:$O(^MCAR(699,D0,6,D1))'>0  X:$D(DSC(699.36)) DSC(699.36) S D1=$O(^(D1)) Q:D1'>0  D:$X>31 T Q:'DN  D H1
 G H1R
H1 ;
 S X=$G(^MCAR(699,D0,6,D1,0)) D N:$X>30 Q:'DN  W ?30 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.85,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 Q
H1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SURVEILLANCE: "
 S I(1)=7,J(1)=699.37 F D1=0:0 Q:$O(^MCAR(699,D0,7,D1))'>0  X:$D(DSC(699.37)) DSC(699.37) S D1=$O(^(D1)) Q:D1'>0  D:$X>20 T Q:'DN  D I1
 G I1R
I1 ;
 S X=$G(^MCAR(699,D0,7,D1,0)) D N:$X>20 Q:'DN  W ?20 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.86,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 Q
I1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INDICATION COMMENTS: "
 S X=$G(^MCAR(699,D0,0)) W ?0,$E($P(X,U,6),1,110)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INDICATED THERAPY: "
 S I(1)=2,J(1)=699.17 F D1=0:0 Q:$O(^MCAR(699,D0,2,D1))'>0  X:$D(DSC(699.17)) DSC(699.17) S D1=$O(^(D1)) Q:D1'>0  D:$X>25 T Q:'DN  D J1
 G J1R
J1 ;
 S X=$G(^MCAR(699,D0,2,D1,0)) D N:$X>24 Q:'DN  W ?24 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.6,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,60)
 Q
J1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "DISEASE FOLLOWUP: "
 S I(1)=5,J(1)=699.35 F D1=0:0 Q:$O(^MCAR(699,D0,5,D1))'>0  X:$D(DSC(699.35)) DSC(699.35) S D1=$O(^(D1)) Q:D1'>0  D:$X>24 T Q:'DN  D K1
 G K1R
K1 ;
 S X=$G(^MCAR(699,D0,5,D1,0)) D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.84,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,45)
 Q
K1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "COMPLICATION: "
 S I(1)=17,J(1)=699.58 F D1=0:0 Q:$O(^MCAR(699,D0,17,D1))'>0  X:$D(DSC(699.58)) DSC(699.58) S D1=$O(^(D1)) Q:D1'>0  D:$X>20 T Q:'DN  D L1
 G L1R
L1 ;
 D N:$X>9 Q:'DN  W ?9 W " "
 S X=$G(^MCAR(699,D0,17,D1,0)) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(696.9,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,40)
 D N:$X>49 Q:'DN  W ?49 W "COMP. RESULTS: "
 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 Q
L1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "DIAGNOSIS: "
 S I(1)=33,J(1)=699.04 F D1=0:0 Q:$O(^MCAR(699,D0,33,D1))'>0  S D1=$O(^(D1)) D:$X>17 T Q:'DN  D M1
 G M1R
M1 ;
 S X=$G(^MCAR(699,D0,33,D1,0)) S DIWL=18,DIWR=73 D ^DIWP
 Q
M1R ;
 D 0^DIWW
 D ^DIWW
 D T Q:'DN  W ?2 S MCFILE=699 D DISP^MCMAG K DIP K:DN Y
 W ?13 K MCFILE K DIP K:DN Y
 K Y K DIWF
 Q
HEAD ;
 W !,"---------------------------------------------------------------------------",!!
