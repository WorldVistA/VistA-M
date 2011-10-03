SRONON ;B'HAM ISC/ADM - NON-O.R. PROCEDURE REPORT ; [ 02/18/04  9:55 AM ]
 ;;3.0; Surgery ;**48,77,100**;24 Jun 93
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 I '$D(SRSITE) D ^SROVAR G:'$D(SRSITE) END S SRSITE("KILL")=1
 I '$D(SRTN) D NON G:'$D(SRTN) END S SRTN("KILL")=1
 N SREXP,SRSINED,SRDTITL,SRSTAT,SRTIU
 S SRDTITL="Procedure Report"
 S SRSINED=0,SRTIU=$P($G(^SRF(SRTN,"TIU")),"^",3)
 I SRTIU S SRSTAT=$$STATUS^SROESUTL(SRTIU) S:SRSTAT=7 SRSINED=1
 D DISPLY,END
 Q
DISPLY I SRSINED S SRTIU=$P($G(^SRF(SRTN,"TIU")),"^",3) I SRTIU D PRNT^SROESPR(SRTN,SRTIU,SRDTITL) Q
 I 'SRSINED S SREXP=$P($G(^SRF(SRTN,"TIU")),"^",5) D  D LAST
 .I 'SREXP W !!," * * A Procedure Report (Non-OR) will not be created for this procedure. * *" Q
 .W !!," * * A Procedure Report (Non-OR) is not available. * *"
 Q
END W @IOF I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^SRSKILL K VAIN,VAINDT I $D(SRSITE("KILL")) K SRSITE
 I $D(SRTN("KILL")) K SRTN
 Q
NON K DIC S DIC("A")="Select Patient: ",DIC=2,DIC(0)="QEAMZ" D ^DIC I Y<0 S SRSOUT=1 G END
 S DFN=+Y D DEM^VADPT S SRNM=VADM(1)
 W @IOF,!,"Non-O.R. Procedures for "_SRNM_" ("_VA("PID")_")" I $D(^DPT(DFN,.35)) S Y=$P(^(.35),"^") I Y D D^DIQ S Y=$P(Y,"@")_" "_$P(Y,"@",2) W !,"  (DIED ON "_Y_")"
 W !! S (SROP,CNT)=0 F I=0:0 S SROP=$O(^SRF("ANOR",DFN,SROP)) Q:'SROP  D LIST
SEL W !!!,"Select Procedure: " R X:DTIME I '$T!("^"[X) G END
 I '$D(SRCASE(X)) W !!,"Enter the number corresponding to the procedure for which you want to print",!,"a report." G SEL
 S SRTN=+SRCASE(X)
 Q
LIST ; list case
 I $Y+5>IOSL S SRBACK=0 D SEL^SROPER Q:$D(SRTN)!(SRSOUT)  W @IOF,!,?1,"NON-O.R. PROCEDURES FOR "_VADM(1)_" ("_VA("PID")_")",! I SRBACK S CNT=0,SROP=SRCASE(1)-1,SRDT=$P(SRCASE(1),"^",2)
 S CNT=CNT+1,SRSDATE=$P(^SRF(SROP,0),"^",9),SROPER=$P(^SRF(SROP,"OP"),"^"),SRCASE(CNT)=SROP
 K SROPS,MM,MMM S:$L(SROPER)<55 SROPS(1)=SROPER I $L(SROPER)>54 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S Y=SRSDATE D D^DIQ S SRSDATE=$P(Y,"@")_" "_$P(Y,"@",2)
 W !,CNT_".",?4,SRSDATE,?25,SROPS(1) I $D(SROPS(2)) W !,?25,SROPS(2) I $D(SROPS(3)) W !,?25,SROPS(3) I $D(SROPS(4)) W !,?25,SROPS(4)
 W !
 Q
LOOP ; break procedure if greater than 55 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<55  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
LAST W ! K DIR S DIR(0)="E" D ^DIR K DIR
 Q
CODE ; entry point from coding menu
 N SREXP,SRSINED,SRDTITL,SRSTAT,SRTIU
 S SRDTITL="Procedure Report"
 S SRSINED=0,SRTIU=$P($G(^SRF(SRTN,"TIU")),"^",3)
 I SRTIU S SRSTAT=$$STATUS^SROESUTL(SRTIU) S:SRSTAT=7 SRSINED=1
 D DISPLY,END
 Q
