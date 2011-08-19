ORVOM6 ; slc/dcm - ONIT creation ;12/11/90  14:30 ;
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 S DH=" ;",Q=" K DIF,DIK,DDF,DDT,DTO,D0,DLAYGO,DIC,DIR,DA,ORVROM,DFR,DTN,DIX,DZ"
 S ^UTILITY($J,.3,0)=" S DIFQ=0,ORVROM="_$S($D(DR):DR,1:0)_" W !!,""This version of '"_DTL_"ONIT' was created on "_DIFROM(1)_""""
 S X=$E(DTL_"ONIT",1,7)
 S ^UTILITY($J,4,0)=" G Q:DIFQ D ^"_X_"1 G Q:'$D(DIFQ) S DIK(0)=""B"""
 S ^UTILITY($J,6,0)=" D ^"_X_"2,^"_X_3,X=0
 D VERS^OR
 S ^UTILITY($J,.6,0)=" W !?9,""("_$S($D(^DD("SITE")):"at "_^("SITE")_",",1:"")_" by "_X_")"",!"
 K ^UTILITY(U,$J),^UTILITY($J,0),E,F S D=-9999,DNAME=DTL_"ONIT",DL=0,^(0,1)=DNAME_" ; ; "_DIFROM(1) D 2^ORVOM3
 G Q^ORVOM0
