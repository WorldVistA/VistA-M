DGA4001 ;ALB/MRL - LIST PENDING OR OPEN DISPOSITIONS ;01 JAN 1988@2300
 ;;5.3;Registration;**162**;Aug 13, 1993
 D UP^DGA400 I IO=DGDEV W !!,"===> Checking for Pending/Open Dispositions..."
 D VAR,H^DGUTL S $P(^DG(43,1,"AMIS"),"^",1)=DGTIME,Y=DGA1 X ^DD("DD") S DGH="PENDING/OPEN DISPOSITIONS, ",X="MONTH OF '"_Y_"'.",DGH=DGH_X,$P(^DG(43,1,"AMIS"),"^",6)=X
EN2 K ^UTILITY($J) F I=DGA1:0 S I=$O(^DPT("ADIS",I)) Q:'I!(I>DGAE1)  F DFN=0:0 S DFN=$O(^DPT("ADIS",I,DFN)) Q:'DFN  F I1=0:0 S I1=$O(^DPT("ADIS",I,DFN,I1)) Q:'I1  I $D(^DPT(DFN,"DIS",I1,0)) S DGAD=^(0) D SET
 F I=0:0 S I=$O(^UTILITY($J,"DGDISP",I)),DGAP="" Q:'I  D DV,HD F I1=0:0 S DGAP=$O(^UTILITY($J,"DGDISP",I,DGAP)) Q:DGAP=""  F I2=0:0 S I2=$O(^UTILITY($J,"DGDISP",I,DGAP,I2)) Q:'I2  S X=^(I2) D WR
Q W !! W:DGO!(DGP) DGL1,!! G QUIT1^DGA4002:DGQUIT
 D:DGHOME MES I DGO D ^DGA4003 G QUIT^DGA4002
 D PMES^DGA4003:DGP S DGA=DGA1 K %DT,DFN,DGA1,DGAD,DGAE1,DGAP,DGC,DGDATE,DGTIME,DGDV,DGH,DGHOME,DGL,DGL1,DGO,DGP,DGPGM,DGQUIT G ^DGA4004
WR I $Y>$S($D(IOSL):(IOSL-4),1:20) W !,DGL1 D HD
 W !,$E($P(DGAP,",",1)_","_$E(DGAP,$F(DGAP,",")),1,20),?22,$P(X,"^",1)
 S X1="" I +I2 S X1=$E(I2,1,12),X1=$$FMTE^XLFDT(X1,"5F"),X1=$TR(X1," ","0")
 W ?29,X1,?50,$P(X,"^",2),?72,$P(X,"^",3) Q
HD W @IOF,!,DGH,!,"DIVISION:  ",$P(DGDV,"^",2) S Y=DT X ^DD("DD") S X1="Date Printed: "_Y W ?(78-$L(X1)),X1,!!,"Patient Name",?22,"PT ID",?29,"Reg. Date/Time",?50,"Application Type",?72,"Status",!,DGL,! Q
DV I $D(^DG(43,1,"GL")),'$P(^("GL"),"^",2) S DGDV=$S($O(^DG(40.8,0))>0:$O(^DG(40.8,0)),1:"UNKNOWN") I DGDV S DGDV=DGDV_"^"_$P(^DG(40.8,+DGDV,0),"^",1) Q
 S DGDV=I_"^"_$S($D(^DG(40.8,+I,0)):$P(^(0),"^",1),1:"UNKNOWN") Q
SET Q:$P(DGAD,U,2)=1&(I>2891000)  W:IO=DGDEV "." I $P(DGAD,"^",6),$D(^DIC(37,+$P(DGAD,"^",7),0)),+$P(^(0),"^",9),$P(^(0),"^",9)'=13 D:'DGO SET1 Q
 S DGAP=$S($D(^DPT(DFN,0)):^(0),1:"") I $P(DGAD,"^",6),$P(DGAD,"^",7)]"" S DGS="  PEND",DGP=DGP+1
 E  S DGS="**OPEN",DGO=DGO+1
 D PID^VADPT6 S X=$S(VA("BID"):VA("BID"),1:"NONE")_"^"_$S($P(DGAD,"^",3)=1:"Hospital",$P(DGAD,"^",3)=2:"Domiciliary",$P(DGAD,"^",3)=3:"OP Medical",$P(DGAD,"^",3)=4:"OP Dental",$P(DGAD,"^",3)=5:"Nursing Home",1:"Unknown")_"^"_DGS K VA
 S ^UTILITY($J,"DGDISP",+$P(DGAD,"^",4),$S($P(DGAP,"^",1)]"":$P(DGAP,"^",1),1:"UNKNOWN"),$P(DGAD,"^",1))=X Q:DGO
SET1 S ^UTILITY($J,"DGDIS",DFN,I1)=DGAD,DGC=DGC+1 Q
 ;
EN D VAR S DGDEV=IO,DGQUIT=1,%DT(0)=-DT,%DT="EAX",%DT("A")="Start with REGISTRATION DATE: " D ^%DT G Q:Y'>0 S DGA1=$P(Y,".",1)
EN1 S %DT(0)=-DT,%DT="EAX",%DT("A")="     Go to REGISTRATION DATE: " D ^%DT G Q:Y'>0 I $S(DGA1=Y:0,Y'>DGA1:1,1:0) W !?4,*7,"MUST BE AFTER START DATE!" G EN1
 S DGAE1=$P(Y,".",1)_".2359",Y=DGA1 X ^DD("DD") S DGH="PENDING/OPEN DISPOSITIONS FOR '"_Y_"'" I $E(DGA1,1,7)=$E(DGAE1,1,7) S DGH=DGH_"."
 E  S Y=$E(DGAE1,1,7) X ^DD("DD") S DGH=DGH_" THROUGH '"_Y_"'."
 S X1=DGA1,X2="-1" D C^%DTC S DGA1=X_".2359",DGPGM="EN2^DGA4001",DGVAR="DUZ^DGDEV^DGL^DGL1^DGQUIT^DGA1^DGAE1^DGH^DGO^DGP^DGC" D ZIS^DGUTQ G Q:POP U IO
 G EN2
UP D H^DGUTL S $P(^DG(43,1,"AMIS"),"^",2)=DGTIME,$P(^("AMIS"),"^",5)=0 K DGDATE,DGTIME Q
VAR S:'$D(DTIME) DTIME=300 S:'$D(U) U="^" I '$D(DT) S %DT="",X="T" D ^%DT
 S (DGO,DGP,DGC,DGL,DGL1)="",$P(DGL,"=",79)="",$P(DGL1,"#",79)="" ;S IOP=$S($D(ION):ION,1:IO) D ^%ZIS K IOP Q
 Q
 S (DGO,DGP,DGC,DGL,DGL1)="",$P(DGL,"=",79)="",$P(DGL1,"#",79)="" S IOP=$S($D(ION):ION,1:IO) D ^%ZIS K IOP Q
MES W !!,"'",+DGP,"' Pending Dispositions on file...",!,"'",+DGO,"' Open Dispositions on file..."
 I +DGO W !!,"I can't let you generate this report with ""open"" dispositions remaining!",!,"Clear them up and try again later please.",! Q
