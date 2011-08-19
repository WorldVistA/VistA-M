SRORIN ;B'HAM ISC/MAM - INITIALIZE UTILIZATION TIMES ; [ 07/27/98   2:33 PM ]
 ;;3.0; Surgery ;**50**;24 Jun 93
 N SRINST S SRSOUT=0,X="",SRMSG=1,(SRFLAG,SRMSG1)=0,SRSDATE=SRSD D DAY F  S SRSDATE=SRSDATE+1 Q:'SRSDATE!(SRSDATE>SRED1)!(SRSOUT)  S SRMSG1=0 D DAY
 I 'SRFLAG S SRYN="Y" Q
STILL W !!!,"The start and end times for each operating room for the above dates have been",!,"entered with default start and end times.  Do you still want to print the"
 W !,"report even though the start and end times might be inaccurate ?  NO// " R SRYN:DTIME I '$T!(SRYN["^") S SRYN="N" Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="N"
 I "YyNn"'[SRYN W !!,"Enter RETURN if you want to update the start and end times to accurately",!,"reflect utilization, or 'YES' to print the report with the days listed"
 I "YyNn"'[SRYN W !,"having the default start and end times.",!! G STILL
 Q
DAY I $E(SRSDATE,6,7)>28 S X=SRSDATE,%DT="" D ^%DT I Y<0 D DATE
 S Y=SRSDATE D D^DIQ S SRDT=Y
 I '$D(^SRU(SRSDATE)) K DA,DIC,DD,DO,DINUM,SRTN S (X,DINUM)=SRSDATE,DIC="^SRU(",DIC(0)="L",DLAYGO=131.8 D FILE^DICN K DIC,DLAYGO S SRMSG1=1
 S:'$D(^SRU(SRSDATE,1)) ^SRU(SRSDATE,1,0)="^131.81PA^0^0" ;S:'$D(^SRU(SRSDATE,2)) ^SRU(SRSDATE,2,0)="^131.82PA^0^0"
 S X=SRSDATE D H^%DTC S SRDAY=%Y,(SROR,SRSS,SRMG)=0
 F  S SROR=$O(^SRS(SROR)) Q:'SROR  I $$ORDIV^SROUTL0(SROR,SRDIV),'$P(^SRS(SROR,0),"^",6),'$D(^SRU(SRSDATE,1,SROR)) D SETOR D  S SRMG=1
 .S ^SRU(SRSDATE,1,SROR,0)=SROR_"^"_SRTMS,X=$P(^SRU(SRSDATE,1,0),"^",4),$P(^(0),"^",3)=SROR,$P(^(0),"^",4)=X+1
 S:SRMG SRMSG1=1
 ;F  S SRSS=$O(^SRO(137.45,SRSS)) Q:'SRSS  I '$D(^SRU(SRSDATE,2,SRSS)) D SETSP S ^SRU(SRSDATE,2,SRSS,0)=SRSS_"^"_SRTMS,X=$P(^SRU(SRSDATE,2,0),"^",4),$P(^(0),"^",3)=SRSS,$P(^(0),"^",4)=X+1
 I $Y+9>IOSL D PAGE I SRSOUT Q
MSG I SRMSG,SRMSG1 W @IOF,"The following dates are missing start and end times for all operating rooms.",!,"The times will be automatically entered.",! S SRMSG=0,SRFLAG=1 F LINE=1:1:80 W "-"
 I $D(^HOLIDAY(SRSDATE,0)) W !!,SRDT,?16,"This date is a holiday, some/all Operating Rooms and Specialties",!,?16,"may have been inactivated." S SRFLAG=1 Q
 I SRMSG1 W !!,SRDT,?17,"Start Times and End Times Entered."
 Q
PAGE W !!,"Press RETURN to continue  " R X:DTIME I '$T!(X["^") S SRSOUT=1,SRFLAG=0,SRYN="N" W !!,"The Utilization Report can not be generated with incomplete dates.",!!,"Press RETURN to exit the option  " R X:DTIME Q
 W @IOF
 Q
DATE ; correct date
 I $E(SRSDATE,4,5)=12 S SRSDATE=$E(SRSDATE,1,3)_"0101"+10000 Q
 S SRNEWM=$E(SRSDATE,4,5)+1 S:$L(SRNEWM)=1 SRNEWM="0"_SRNEWM S SRNEWM=SRNEWM_"01",SRSDATE=$E(SRSDATE,1,3)_SRNEWM
 Q
SETSP ; set information in global
 S SRHOLID=0 I $D(^HOLIDAY(SRSDATE,0)) S SRHOLID=1 S SRINST=0 F  S SRINST=$O(^SRO(133,SRINST)) Q:'SRINST  I $D(^SRO(133,SRINST,3,SRSDATE,0)) S SRHOLID=0
 I $D(^HOLIDAY(SRSDATE,0)),SRHOLID S SRTMS="^^Y" Q
 S SRTMS=SRSDATE_".07^"_SRSDATE_".17^"_"N"
 Q
SETOR ; set information for OR in global
 S SRINST=$P(^SC($P(^SRS(SROR,0),"^"),0),"^",4) S:SRINST SRINST=$O(^SRO(133,"B",SRINST,0))
 I $D(^HOLIDAY(SRSDATE,0)),SRINST,'$D(^SRO(133,SRINST,3,SRSDATE,0)) S SRTMS="^^Y" Q
 I $D(^HOLIDAY(SRSDATE,0)),'SRINST S SRTMS="^^Y" Q
 S (SRET,SRST,SRACT)="",SRWD=$O(^SRS(SROR,4,"B",SRDAY,0)) I 'SRWD S SRTMS=SRSDATE_".07^"_SRSDATE_".17^N" Q
 I $P(^SRS(SROR,4,SRWD,0),"^",2) S SRST=SRSDATE_"."_$P(^(0),"^",2),SRST=+SRST
 I SRST,$P(^SRS(SROR,4,SRWD,0),"^",3) S SRET=SRSDATE_"."_$P(^(0),"^",3),SRET=+SRET
 I SRST,'SRET S SRST=""
 I $P(^SRS(SROR,4,SRWD,0),"^",4) S SRACT="Y"
 I SRACT'="Y",'SRST S SRST=SRSDATE_".07",SRET=SRSDATE_".17"
 S SRTMS=SRST_"^"_SRET_"^"_SRACT
 Q
