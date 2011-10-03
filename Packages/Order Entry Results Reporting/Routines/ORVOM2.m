ORVOM2 ; slc/dcm - Creates rtns ending in 'ONIT1' ;12/11/90  14:28
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 S ORVROM=5,Y=DRN-1,S=""
 S ^UTILITY($J,.2,0)=" I $S('$D(DUZ)#2:1,'$D(DUZ(0))#2:1,1:0) W !,""DUZ and DUZ(0) must be defined to continue."" K DIFQ Q"
 S EH="DT^"_$E(DTL_"ONIT",1,7)_2,DH=" ; LOADS",^UTILITY($J,.3,0)=" K DIF,DIK,D,DDF,DDT,DTO,D0,DLAYGO,DIC,DIR,DA,DFR,DTN,DIX,DZ D "_EH_" S %=1,U=""^"",DSEC=1"
 S DL=0,^UTILITY($J,1.4,0)=" S NO=$P(""I 0^I $D(@X)#2,X[U"",U,%) I %<1 K DIFQ Q"
 S DIRS(1)=" I %<1 K DIFQ Q"
 S:E>1 ^UTILITY($J,2,0)=" F X="_$E(X,2,99)_" D W Q:'$D(DIFQ)"
 S ^UTILITY($J,2.4,0)=" W !,""    PROTOCOL INSTALLATION"""
 S ^UTILITY($J,2.5,0)=" Q:'$D(DIFQ)  ;S %=0 W !!,""ARE YOU SURE YOU WANT TO CONTINUE"" D YN^DICN I %-1 K DIFQ Q"
 S ^UTILITY($J,3,0)=" D "_EH_" "_$S($D(DIRS)#2:DIRS,1:"")_"W !,""...OK, this may take a while, hold on please..."" F R=1001:1:"_Y_" D @(""^"_DN_"""_$E(R,2,4)) W "".""" K Q S X=4,E="",Q=" ;"
 S DIRS=" K:%<0 DIFQ"
 S E=$E(DTL_"ONIT",1,7),DNAME=E_1,D=-9999
 D ZI^ORVOM3 G ^ORVOM3
 Q
DT W ! D 1
 I '$D(DTIME) S DTIME=999
 K %DT D NOW^%DTC S DT=X
 K DIK,DIC,%I,DICS Q
1 I 'X,$D(^%ZOSF("NBRK")) X ^%ZOSF("NBRK")
 I X,$D(^%ZOSF("BRK")) X ^%ZOSF("BRK")
 Q
