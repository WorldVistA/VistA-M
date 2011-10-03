SROXRET ;B'HAM ISC/MAM - UNEXPECTED RETURNS ; 17 JAN 1991 9:00 AM
 ;;3.0; Surgery ;**16,34,46**;24 Jun 93
 N SRSDATE S SRSDATE=$P(^SRF(SRTN,0),"^",9),X1=SRSDATE,X2=-30 D C^%DTC S SRDATES=X-.0001 I $P(SRSDATE,".",2)="" S SRSDATE=SRSDATE+.9999
 S CNT=0,DFN=$P(^SRF(SRTN,0),"^") F  S SRDATES=$O(^SRF("AC",SRDATES)) Q:'SRDATES!(SRDATES>SRSDATE)  S SRETURN=0 F  S SRETURN=$O(^SRF("AC",SRDATES,SRETURN)) Q:'SRETURN  I ^(SRETURN)=DFN,DA'=SRETURN D SET
 I '$O(SRETURN(0)) Q
 I '$D(SRETURN(2)) D ONE Q:X=""  S SRELATE="R" G STUFF
ASK W !!,"Is this a return to surgery related to one of the cases listed",!,"above ?  NO//  " R SRYN:DTIME I '$T!(SRYN["^") W @IOF Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="N" I "Nn"[SRYN W @IOF Q
 I "Yy"'[SRYN D HELP G ASK
SEL W !!,"Select the number corresponding to the appropriate case: " R X:DTIME I '$T!("^"[X) W @IOF Q
 I '$D(SRETURN(X)) W !!,"Enter the number corresponding to the operative procedure associated with",!,"this unexpected return to surgery." G SEL
 S SRELATE="R"
STUFF S SRETURN=$P(SRETURN(X),"^") I '$D(^SRF(SRETURN,29,0)) S ^(0)="^130.43PA^^0"
 K DA,D0,DD,DINUM,DIC S DA(1)=SRETURN,DIC="^SRF("_SRETURN_",29,",(DINUM,X)=SRTN,DIC(0)="L",DLAYGO=130.43 D FILE^DICN K DIC,DINUM,DLAYGO
 S $P(^SRF(SRETURN,29,SRTN,0),"^",3)=SRELATE,DA=SRTN
 W:SRELATE="R" @IOF Q
ONE S X="" W !!,"Is this a return to surgery related to the case listed ",!,"above ?  NO//  " R SRYN:DTIME I '$T!(SRYN["^") W @IOF Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="N" I "Nn"[SRYN S X="" W @IOF Q
 I "Yy"'[SRYN D HELP G ONE
 S X=1
 Q
SET I $D(^SRF(SRETURN,29,SRTN,0))!'$D(^SRF(SRETURN,.2)) Q
 I '$P(^SRF(SRETURN,.2),"^",12) Q
 S CNT=CNT+1,SRETURN(CNT)=SRETURN_"^"_SRDATES_"^"_$P(^SRF(SRETURN,"OP"),"^")
 S Y=SRDATES D D^DIQ S OPDATE=$P(Y,"@")
 S SROPER=$P(^SRF(SRETURN,"OP"),"^") K SROP,MM,MMM
 S:$L(SROPER)<50 SROP(1)=SROPER I $L(SROPER)>49 F MAM=1:1 D LOOP Q:'MMM
 I CNT=1 D DEM^VADPT W @IOF,!,"Completed cases for "_VADM(1)_" within the past 30 days:",!!
 W !,CNT_".",?5,OPDATE,?25,SROP(1) I $D(SROP(2)) W !,?25,SROP(2) I $D(SROP(3)) W !,?25,SROP(3) I $D(SROP(4)) W !,?25,SROP(4)
 S X=CNT,SRELATE="U" D STUFF
 Q
HELP W !!,"If this surgical case is related to a previous case, enter 'YES'.  Otherwise, ",!,"press RETURN to continue entering information for this operative procedure."
 Q
LOOP ; break procedure if greater than 50 characters
 S SROP(MAM)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROP(MAM))+$L(MM)'<50  S SROP(MAM)=SROP(MAM)_MM_" ",SROPER=MMM
 Q
