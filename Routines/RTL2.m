RTL2 ;MJK/TROY ISC;Routine to print labels; ; 1/30/87  10:08 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
CMP Q:'$D(^DIC(194.4,RTFMT,0))  S RTROW=$S($P(^(0),"^",2):$P(^(0),"^",2),1:6) K ^DIC(194.4,RTFMT,"E")
 F RTI=0:0 S RTI=$O(^DIC(194.4,RTFMT,1,RTI)) Q:RTI'>0  I $D(^(RTI,0)) S ^TMP($J,"FORM",+$P(^(0),"^",2),+$P(^(0),"^",3),$P(^(0),"^",1))=$P(^(0),"^",4,5)
 S RTN=1 F RTI=1:1:RTROW S RTFL=1 S:'$D(^TMP($J,"FORM",RTI)) ^DIC(194.4,RTFMT,"E",RTN,0)="W !",RTN=RTN+1 I $D(^(RTI)) F RTCOL=0:0 S RTCOL=$O(^TMP($J,"FORM",RTI,RTCOL)) Q:RTCOL'>0  S %="",%=$O(^(RTCOL,%)) S J=^(%) D STORE
 W !!?5,"...format '",$P(^DIC(194.4,RTFMT,0),"^",1),"' has been compiled."
 K RTROW,RTI,RTII,RTIV,RTDEF,J,RTITL,RTCOL,RTN,^TMP($J,"FORM") Q
 ;
STORE S RTIV="DT",RTDEF="" S:$D(^DIC(194.5,+%,0)) RTIV=$P(^(0),"^",5),RTDEF=$P(^(0),"^",3)
 S RTITLE=$S(RTIV="RTV(1)":"",$P(J,"^",1)="NONE":"",$P(J,"^",1)]"":$P(J,"^",1),1:RTDEF)
 S ^DIC(194.4,RTFMT,"E",RTN,0)="W "_$S(RTFL:"!",1:"")_"?"_(RTCOL-1)_","""_RTITLE_""","_$S(RTIV="RTV(1)":""""_$P(J,"^",2)_"""",1:RTIV) S RTN=RTN+1,RTFL=0
 Q
 ;
TEST S RTEST="",RTNUM=1
 W ! S DIC="^DIC(194.4,",DIC("S")="I $P(^(0),U,3)=+RTAPL",DIC("A")="Select Label Format: ",DIC(0)="IAEMQ" D ^DIC K DIC G Q:Y<0 S RTFMT=+Y
 D ^%ZIS I 'POP U IO D PRT^RTL1 D ^%ZISC U IO(0)
Q K RTEST,RTNUM,RTFMT,DUOUT
 K A,DIC,J,K,POP,RTBC,Y Q
BC ;DIC("S") for print fields multiple of 194.4 (LABEL FORMAT file)
 ;      Z1 = type of label from 194.4
 ;      Z2 =  "   "    "   from 194.5 (LABEL PRINT FIELD file)
 ;      Z3 = 1 or 0 depending is Z1 and Z2 are compatible 
 ;           AND if the field is a barcode field, that it is
 ;           the ONLY barcode field for the label format
 ;
 S Z1=$P(^DIC(194.4,D0,0),U,4),Z2=$P(^DIC(194.5,+Y,0),U,2),Z3=$S(Z2="a"!(Z1=Z2):1,Z1="q"&(Z2="r"):1,1:0)
 I Z3,$P(^DIC(194.5,+Y,0),U,6)="y" F RAI=0:0 S RAI=$O(^DIC(194.4,D0,1,RAI)) Q:'RAI  I $D(^(RAI,0)),+Y'=+^(0),$D(^DIC(194.5,+^(0),0)),$P(^(0),U,6)="y" S Z3=0 Q
 I Z3
 K Z1,Z2,Z3,RAI Q
