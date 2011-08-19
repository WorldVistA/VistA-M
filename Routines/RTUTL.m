RTUTL ;MJK/TROY ISC; Utility Routine; ; 5/5/87  10:16 AM ;
 ;;v 2.0;Record Tracking;**9,26**;10/22/91 
TYPE W ! S DIC="^DIC(195.2,",DIC("S")="I $P(^(0),U,3)=+RTAPL",DIC("A")="Select Record Type: ",DIC(0)="IAEMQ" D ^DIC K DIC Q:Y<0
TYPE1 K RTTY Q:'$D(^DIC(195.2,+Y,0))  S RTTY=+Y_";"_^(0) Q
 ;
INST K F,RTINST Q:$S(X="":1,'$D(^RT(+^RTV(190.1,DA,0),0)):1,1:0)  S A=+$P(^(0),"^",4)
 ;Entry pt with A equal to application and X equal to borrower
 ;Returns RTINST equals institution file pointer
INST1 K F,RTINST S X=$S($D(^RTV(195.9,+X,0)):$P(^(0),"^"),1:"") G INSTQ:'X S F=$P(X,";",2)
 I F="DIC(4,",$D(^DIC(4,+X,0)) S RTINST=+X G INSTQ
 S I=+$O(^DIC(195.1,A,"INST",0)) I I,'$O(^(I)),$D(^DIC(4,I,0)) S RTINST=I G INSTQ
 I F="SC(" S X1=+X D DIV G INSTQ
 I F="DIC(42,",$D(^DIC(42,+X,44)) S X1=+^(44) D DIV G INSTQ
 I F="VA(200," D
 . N Y,Y1
 . S Y=$O(^VA(200,+X,2,0)),Y1=$O(^(+Y))
 . I Y1 Q  ; two or more divisions...user must select
 . I Y S RTINST=Y Q  ; only one entry for division
 . S RTINST=$P($G(^XTV(8989.3,1,"XUS")),"^",17) ; use site default
 . I 'RTINST K RTINST
INSTQ I $D(RTINST),F'="DIC(4,",'$D(^DIC(195.1,A,"INST",RTINST,0)) K RTINST
 K F,X1,I,I1 Q
 ;
DIV I $D(^SC(X1,0)),$D(^DIC(4,+$P(^(0),"^",4),0)) S RTINST=+$P(^SC(X1,0),"^",4)
 Q
 ;
Q X ^%ZOSF("UCI") S ZTUCI=Y,ZTRTN="DQ^RTUTL"
 F RTI="RTHD","RTVAR","RTPGM","DUZ(0)" I $D(@RTI) S ZTSAVE(RTI)=""
 F RTI=1:1 Q:$P(RTVAR,"^",RTI)']""  S ZTSAVE($P(RTVAR,"^",RTI))=@($P(RTVAR,"^",RTI))
 S ZTDESC=$S($D(RTDESC):RTDESC,1:"Record Tracking Job")
 S X1=ION_";"_IOST_";"_IOM,ZTIO=$S(X1=";;":"",1:X1) D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED!" K RTDESC,RTI,RTPGM,RTVAR,ZTSK Q
 ;
DQ S IO(0)=IO,U="^" S X="T",%DT="" D ^%DT S DT=Y G @RTPGM
 ;
ZIS S:$S('$D(RTDEV):0,1:RTDEV]"") %ZIS("B")=RTDEV S %ZIS="QMP" D ^%ZIS K %ZIS K:POP IO("Q") Q:POP  I $D(IO("Q"))!(IO'=IO(0)) D Q S POP=1 Q
 Q
 ;
CLOSE K ZTSK D ^%ZISC U:IO'=IO(0)&(IO]"") IO(0) Q
 ;
DATE S POP=0 K RTBEG,RTEND W !!,"**** Date Range Selection ****"
 W ! S %DT="AETX",%DT("A")="   Beginning DATE/TIME : " D ^%DT S:Y<0 POP=1 Q:Y<0  S (%DT(0),RTBEG)=Y
 W ! S %DT="AETX",%DT("A")="   Ending    DATE/TIME : " D ^%DT K %DT S:Y<0 POP=1 Q:Y<0  W ! S RTEND=Y
 Q
 ;
