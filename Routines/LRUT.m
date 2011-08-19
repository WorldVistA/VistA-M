LRUT ;AVAMC/REG - TIME DIFFERENCES ; 8/22/88  21:0 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S Z=+^LRE(DA(2),5,DA(1),66,DA,0),Z(0)=$P(^LAB(66,Z,0),"^",13) Q:'Z(0)
 S Z=$P(^LRE(DA(2),5,DA(1),2),"^",3) D H S W(1)=Z(3)+Z(0) D C S C=W
 S Z=X D H S W(1)=Z(3) D C D:W>C E K W,Z,C Q
H ;from LRBLDC,LRBLDCR
 S %Y=$E(Z,1,3),%M=$E(Z,4,5),%D=$E(Z,6,7)
 S %H=%M>2&'(%Y#4)+$P("^31^59^90^120^151^181^212^243^273^304^334","^",%M)+%D
 S %='%M!'%D,%Y=%Y-141,%H=%H+(%Y*365)+(%Y\4)-(%Y>59)+%,%Y=$S(%:-1,1:%H+4#7)
A S Z=Z_"000",Z(1)=$E($P(Z,".",2),1,2),Z(2)=$E($P(Z,".",2),3,4) S Z(3)=Z(1)*60+Z(2)
 K %M,%D,% Q
C ;from LRBLDC
 S W=%H+(W(1)\1440),W(1)=W(1)#1440,W(1)=$E("0000",1,4-$L(W(1)))_W(1),W=W_W(1) Q
E W $C(7),!!,"Time between collection and storage too long !!",! K X Q
 ;
 ;Z(0)=MINUTES ALLOWED BETWEEN COLLECTION AND PREPARATION OF COMPONENT
D ;from LRBLJD, LRBLPCS1
 S %=%H>21549+%H-.1,%Y=%\365.25+141,%=%#365.25\1 ;also called by LRBLPCS1
 S %D=%+306#(%Y#4=0+365)#153#61#31+1,%M=%-%D\29+1
 S X=%Y_"00"+%M_"00"+%D Q
