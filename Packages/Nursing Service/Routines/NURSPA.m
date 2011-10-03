NURSPA ; GENERATED FROM 'NURS-P-STF' PRINT TEMPLATE (#574) ; 06/28/03 ; (FILE 210, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(574,"DXS")
 S I(0)="^NURSF(210,",J(0)=210
 S DIWF="W"
 D T Q:'DN  D N D N D N:$X>27 Q:'DN  W ?27 W "INDIVIDUAL STAFF REPORT"
 D N:$X>27 Q:'DN  W ?27 W "-----------------------"
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "NAME: "
 S X=$G(^NURSF(210,D0,0)) D N:$X>6 Q:'DN  W ?6 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,35)
 D N:$X>36 Q:'DN  W ?36 W "SSN: "
 D N:$X>41 Q:'DN  W ?41 S:$D(^VA(200,$P(^NURSF(210,D0,0),"^"),1)) NSSN=$P(^(1),"^",9),X=$E(NSSN,1,3)_"-"_$E(NSSN,4,5)_"-"_$E(NSSN,6,9) K NSSN W $E(X,1,11) K Y(210,1)
 D N:$X>54 Q:'DN  W ?54 W "DATE: "
 D N:$X>60 Q:'DN  W ?60 S X=DT S Y=X K DIP K:DN Y S Y=X D DT
 D N:$X>1 Q:'DN  W ?1 W "DOB: "
 D N:$X>6 Q:'DN  W ?6 X ^DD(210,7,9.2) S X=$P(Y(210,7,101),U,3) S D0=Y(210,7,80) S Y=X D DT
 D N:$X>36 Q:'DN  W ?36 W "AGE: "
 D N:$X>41 Q:'DN  W ?41 X ^DD(210,7.5,9.6) S X=$S(Y(210,7.5,2):Y(210,7.5,18),Y(210,7.5,19):X) W $E(X,1,8) K Y(210,7.5)
 D N:$X>55 Q:'DN  W ?55 W "SEX: "
 D N:$X>60 Q:'DN  W ?60 X ^DD(210,8,9.3) S X=$P($P(Y(210,8,102),$C(59)_$P(Y(210,8,101),U,2)_":",2),$C(59),1) S D0=Y(210,8,80) W $E(X,1,8) K Y(210,8)
 D N:$X>0 Q:'DN  W ?0 W "----------------------------------------"
 D N:$X>40 Q:'DN  W ?40 W "----------------------------------------"
 D N:$X>27 Q:'DN  W ?27 W "CURRENT FTEE INFORMATION"
 D N:$X>27 Q:'DN  W ?27 W "------------------------"
 W ?53 D EN1^NURASPL K DIP K:DN Y
 D N:$X>14 Q:'DN  W ?14 W "GRADE/STEP:"
 S X=$G(^NURSF(210,D0,7)) D N:$X>26 Q:'DN  W ?26 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^NURSF(211.1,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,10)
 D N:$X>7 Q:'DN  W ?7 W "UNIFORM ALLOWANCE:"
 S X=$G(^NURSF(210,D0,13)) D N:$X>26 Q:'DN  W ?26 S Y=$P(X,U,3) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 W ?31 K NURSX S $P(NURSX,"-",80)="" W !,NURSX K DIP K:DN Y
 D N:$X>27 Q:'DN  W ?27 W "ADDRESS/TELEPHONE"
 D N:$X>27 Q:'DN  W ?27 W $E(NURSX,1,17) K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "HOME ADDRESS INFORMATION"
 D N:$X>0 Q:'DN  W ?0 W "------------------------"
 D T Q:'DN  D N D N:$X>6 Q:'DN  W ?6 W "STREET: "
 D N:$X>14 Q:'DN  W ?14 X DXS(1,9.2) S X=$P(DIP(101),U,1) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>14 Q:'DN  W ?14 X DXS(2,9.2) S X=$P(DIP(101),U,2) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>14 Q:'DN  W ?14 X DXS(3,9.2) S X=$P(DIP(101),U,3) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>8 Q:'DN  W ?8 W "CITY: "
 D N:$X>14 Q:'DN  W ?14 X DXS(4,9.2) S X=$P(DIP(101),U,4) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>7 Q:'DN  W ?7 W "STATE: "
 D N:$X>14 Q:'DN  W ?14 X ^DD(210,12,9.2) S Y(210,12,101)=$S($D(^VA(200,D0,.11)):^(.11),1:"") S X=$S('$D(^DIC(5,+$P(Y(210,12,101),U,5),0)):"",1:$P(^(0),U,1)) S D0=Y(210,12,80) W $E(X,1,8) K Y(210,12)
 D N:$X>47 Q:'DN  W ?47 W "ZIP"
 D N:$X>52 Q:'DN  W ?52 X DXS(5,9.2) S X=$P(DIP(101),U,6) S D0=I(0,0) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "MAILING ADDRESS INFORMATION"
 D N:$X>0 Q:'DN  W ?0 W "---------------------------"
 D T Q:'DN  D N D N:$X>6 Q:'DN  W ?6 W "STREET: "
 S X=$G(^NURSF(210,D0,15)) D N:$X>14 Q:'DN  W ?14,$E($P(X,U,1),1,50)
 D N:$X>14 Q:'DN  W ?14,$E($P(X,U,2),1,50)
 D N:$X>14 Q:'DN  W ?14,$E($P(X,U,3),1,35)
 D N:$X>8 Q:'DN  W ?8 W "CITY: "
 D N:$X>14 Q:'DN  W ?14,$E($P(X,U,4),1,30)
 D N:$X>7 Q:'DN  W ?7 W "STATE: "
 D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^DIC(5,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>47 Q:'DN  W ?47 W "ZIP: "
 D N:$X>52 Q:'DN  W ?52,$E($P(X,U,6),1,10)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "TELEPHONE NUMBER INFORMATION"
 D N:$X>0 Q:'DN  W ?0 W "----------------------------"
 S I(1)=2,J(1)=210.01 F D1=0:0 Q:$O(^NURSF(210,D0,2,D1))'>0  X:$D(DSC(210.01)) DSC(210.01) S D1=$O(^(D1)) Q:D1'>0  D:$X>30 T Q:'DN  D A1
 G A1R
A1 ;
 D T Q:'DN  D N D N:$X>6 Q:'DN  W ?6 W "NUMBER: "
 S X=$G(^NURSF(210,D0,2,D1,0)) D N:$X>14 Q:'DN  W ?14,$E($P(X,U,1),1,30)
 D N:$X>7 Q:'DN  W ?7 W "OWNER: "
 D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(7,Y)):DXS(7,Y),1:Y)
 D N:$X>1 Q:'DN  W ?1 W "OTHER OWNER: "
 D N:$X>14 Q:'DN  W ?14,$E($P(X,U,3),1,30)
 Q
A1R ;
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "EMERGENCY CONTACT INFORMATION"
 D N:$X>0 Q:'DN  W ?0 W "-----------------------------"
 S I(1)=3,J(1)=210.02 F D1=0:0 Q:$O(^NURSF(210,D0,3,D1))'>0  X:$D(DSC(210.02)) DSC(210.02) S D1=$O(^(D1)) Q:D1'>0  D:$X>31 T Q:'DN  D B1
 G B1R
B1 ;
 D T Q:'DN  D N D N:$X>8 Q:'DN  W ?8 W "NAME: "
 S X=$G(^NURSF(210,D0,3,D1,0)) D N:$X>14 Q:'DN  W ?14,$E($P(X,U,1),1,30)
 D N:$X>0 Q:'DN  W ?0 W "RELATIONSHIP: "
 D N:$X>14 Q:'DN  W ?14,$E($P(X,U,2),1,30)
 D N:$X>6 Q:'DN  W ?6 W "STREET: "
 D N:$X>14 Q:'DN  W ?14,$E($P(X,U,3),1,50)
 D N:$X>8 Q:'DN  W ?8 W "CITY: "
 D N:$X>14 Q:'DN  W ?14,$E($P(X,U,5),1,30)
 D N:$X>7 Q:'DN  W ?7 W "STATE: "
 D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,6) S Y=$S(Y="":Y,$D(^DIC(5,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>47 Q:'DN  W ?47 W "ZIP: "
 D N:$X>52 Q:'DN  W ?52,$E($P(X,U,7),1,10)
 D N:$X>0 Q:'DN  W ?0 W "PHONE NUMBER: "
 S X=$G(^NURSF(210,D0,3,D1,1)) D N:$X>14 Q:'DN  W ?14,$E($P(X,U,1),1,30)
 Q
B1R ;
 D N:$X>0 Q:'DN  W ?0 W "----------------------------------------"
 D N:$X>40 Q:'DN  W ?40 W "----------------------------------------"
 D N:$X>27 Q:'DN  W ?27 W "VA EMPLOYMENT INFORMATION"
 D N:$X>27 Q:'DN  W ?27 W "-------------------------"
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "STATION ENTRY ON DUTY DATE: "
 S X=$G(^NURSF(210,D0,0)) D N:$X>28 Q:'DN  W ?28 S Y=$P(X,U,6) D DT
 D N:$X>2 Q:'DN  W ?2 W "SERVICE COMPUTATION DATE: "
 D N:$X>28 Q:'DN  W ?28 S X=$$COMPDAT^NURSUT4(D0) S Y=X D DT
 D N:$X>10 Q:'DN  W ?10 W "VA STARTING DATE:"
 S X=$G(^NURSF(210,D0,0)) D N:$X>28 Q:'DN  W ?28 S Y=$P(X,U,5) D DT
 D N:$X>8 Q:'DN  W ?8 W "VETERAN PREFERENCE:"
 D N:$X>28 Q:'DN  W ?28 S Y=$P(X,U,8) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "END OF PROBATIONARY PERIOD:"
 S X=$G(^NURSF(210,D0,13)) D N:$X>28 Q:'DN  W ?28 S Y=$P(X,U,2) D DT
 S I(1)=9,J(1)=210.17 F D1=0:0 Q:$O(^NURSF(210,D0,9,D1))'>0  X:$D(DSC(210.17)) DSC(210.17) S D1=$O(^(D1)) Q:D1'>0  D:$X>48 T Q:'DN  D C1
 G C1R
C1 ;
 D T Q:'DN  D N D N:$X>9 Q:'DN  W ?9 W "DATE OF PROMOTION: "
 S X=$G(^NURSF(210,D0,9,D1,0)) D N:$X>28 Q:'DN  W ?28 S Y=$P(X,U,1) D DT
 D N:$X>22 Q:'DN  W ?22 W "TYPE: "
 D N:$X>28 Q:'DN  W ?28 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 Q
C1R ;
 W ?65 W !,NURSX K DIP K:DN Y
 D N:$X>27 Q:'DN  W ?27 W "EVALUATIONS/BOARD REVIEWS"
 D N:$X>27 Q:'DN  W ?27 W "-------------------------"
 S I(1)=14,J(1)=210.18 F D1=0:0 Q:$O(^NURSF(210,D0,14,D1))'>0  X:$D(DSC(210.18)) DSC(210.18) S D1=$O(^(D1)) Q:D1'>0  D:$X>54 T Q:'DN  D D1
 G D1R^NURSPA1
D1 ;
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "DATE PROFICIENCY/NARRATIVE IS DUE: "
 S X=$G(^NURSF(210,D0,14,D1,0)) D N:$X>35 Q:'DN  W ?35 S Y=$P(X,U,1) D DT
 D N:$X>16 Q:'DN  W ?16 W "NAME OF EVALUATOR: "
 G ^NURSPA1
