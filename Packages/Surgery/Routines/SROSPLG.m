SROSPLG ;B'HAM ISC/ADM - MOVE SP DATA FROM SURGICAL RECORD ;4/12/94  08:54
 ;;3.0; Surgery ;**28**;24 Jun 93
 Q:$P(^LR(LRDFN,0),"^",2)'=2  D END
 S:'$D(DFN) DFN=$P(^LR(LRDFN,0),"^",3) D DEM^VADPT S PNM=VADM(1),SSN=VA("PID")
 S X1=DT,X2=-7 D C^%DTC S SREND=9999999.999999-X D NOW^%DTC S SRDT=9999999.999999-%
 W !!,"Checking surgical record for this patient...",!
 S CNT=0 F  S SRDT=$O(^SRF("ADT",DFN,SRDT)) Q:'SRDT!(SRDT>SREND)  S SROP=0 F  S SROP=$O(^SRF("ADT",DFN,SRDT,SROP)) Q:'SROP!$D(SRTN)  D LIST
 I CNT=0 W !,"No operations on record in the past 7 days for this patient.",! D END Q
 I CNT=1 K DIR W ! S DIR("A",1)="Only one operation on record in the past 7 days.",DIR("A")="Is this the correct operation for the specimen(s) (Y/N)",DIR(0)="Y" D ^DIR I $D(DTOUT)!$D(DUOUT)!'Y D NOOP Q
 I CNT=1,Y=1 S SRTN=+SRCASE(1) D DOC Q
OPT K DIR S DIR("?",1)="Enter the number of the operation associated with the specimen(s)",DIR("?")="or press RETURN to bypass operation selection."
 W ! S DIR("A")="Select operation associated with the specimen(s)",DIR(0)="NO^1:"_CNT
 D ^DIR I $D(DTOUT)!$D(DUOUT)
 I +Y S SRTN=+SRCASE(+Y),CNT=+Y
NOOP I '$D(SRTN) W !!,"No operation selected.",! D END Q
DOC S SRDOC=$S($P($G(^SRF(SRTN,"NON")),"^")="Y":$P(^("NON"),"^",6),1:$P($G(^SRF(SRTN,.1)),"^",4)) Q
DISP I $D(SRTN) S SROP=SRTN,SRSDATE=$P(^SRF(SRTN,0),"^",9) D ^SROSPLG2
END K CNT,DIR,DR,I,J,K,LOOP,M,MM,MMM,SR,SRABORT,SRCASE,SRD,SRDOC,SRDT,SREND,SRJ,SRK,SRLONG,SRN,SROP,SROPER,SROPERS,SROPS,SROTHER,SRSCAN,SRSDATE,SRSTAT,SRSTATUS,SRTN,VA,VADM,VAERR,X,%
 Q
LIST ; list cases
 S SRSCAN=1 I $P($G(^SRF(SROP,.2)),"^",10)!$P($G(^SRF(SROP,.2)),"^",12)!($P($G(^SRF(SROP,"NON")),"^")="Y") K SRSCAN
 I $D(SRSCAN),$D(^SRF(SROP,30)),$P(^(30),"^") Q
 I $D(SRSCAN),$D(^SRF(SROP,31)),$P(^(31),"^",8) Q
 I $D(^SRF(SROP,37)),$P(^(37),"^") Q
 S CNT=CNT+1,SRSDATE=$P(^SRF(SROP,0),"^",9) W !,CNT_". "
CASE W $E(SRSDATE,4,5)_"-"_$E(SRSDATE,6,7)_"-"_$E(SRSDATE,2,3)
 S SROPER=$P(^SRF(SROP,"OP"),"^") I $O(^SRF(SROP,13,0)) S SROTHER=0 F I=0:0 S SROTHER=$O(^SRF(SROP,13,SROTHER)) Q:'SROTHER  D OTHER
 S SROPER="Case #"_SROP_" >> "_SROPER D ^SROSPLG1 K SROPS,MM,MMM S:$L(SROPER)<65 SROPS(1)=SROPER I $L(SROPER)>64 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W ?14,SROPS(1) I $D(SROPS(2)) W !,?14,SROPS(2) I $D(SROPS(3)) W !,?14,SROPS(3) W:$D(SROPS(4)) !,?14,SROPS(4)
 S SRCASE(CNT)=SROP_"^"_SRDT
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SROP,13,SROTHER,0),"^"))>235 S SRLONG=0,SROTHER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SROP,13,SROTHER,0),"^")
 S SROPER=SROPER_$S(SROPERS=" ...":SROPERS,1:", "_SROPERS)
 Q
LOOP ; break procedures
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<65  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
