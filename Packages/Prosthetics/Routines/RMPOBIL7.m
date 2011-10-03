RMPOBIL7 ;HINES CIO/RVD - HOME OXYGEN BILLING TRANSACTIONS ;9/16/02  11:11
 ;;3.0;PROSTHETICS;**70,99**;Feb 09, 1996
 ;RVD 7/8/02 patch #70 - this is a copy of RMPOBIL5 routine.
 ;                       For Read Only 2319.
 ;
 ;DBIA # 800 - for this routine, the agreement covers the field #.01 NAME
 ;             file #440.
 ;DBIA # 801 - for this routine, the agreement covers the field
 ;             #.05 Short Description, file #441.
 ;DBIA # 10090 - Fileman read of file #4, field #99.
 ;
 N DA,DR,DIQ,DIC
 K ^UTILITY("DIQ1",$J)
 S (RC,RA,AN,ANS,RK,RZ)=0 D HDR
 F  S RA=$O(^RMPR(660,"AC",RMPRDFN,RA)) Q:RA=""  D
 . S AN=""
 . F  S AN=$O(^RMPR(660,"AC",RMPRDFN,RA,AN)) Q:AN=""  D
 . . I $D(^RMPO(665.72,"AC",AN))>0 S RC=RC+1,IT(RC)=AN
 G:'$D(IT) END
DIS ;DISPLAY APPLIANCES OR REPAIRS
 I $G(RK)="" S (RC,RK)=""
 I RK+1'>RC S RK=RK+1,AN=+IT(RK) D  G:$$XIT EXIT G DIS
 . S Y=^RMPR(660,AN,0) D PRT,OVER:((IOSL-4)<$Y)
END I RC=0 W !,"No home oxygen items for this veteran!",!! H 3 G EXIT
 E  D  G EXIT
 .I RC>0 D  I $G(RK)+1'>$G(RC) D DIS
 . . W !!,"End of Home Oxygen records for this veteran!" D OVER
 .I $G(RC)="" Q
EXIT Q:'$D(RMPRDFN)
 W ! K I,J,L,R0,IT,RA
 I $D(DUOUT)!($D(DTOUT)) G ASK1^RMPOPAT
 S FL=4 G ASK2^RMPOPAT
 K RMPRCNUM,TRANS,TRANS1,TYPE,VEN,RMPRSTN,DIQ,^UTILITY("DIQ1",$J)
 K AMIS,AN,CST,DATE,DEL,DUOUT,DTOUT,FL,FRM,PAGE,QTY,RC,REM,RZ,RK,SN,STA
 Q
XIT() Q '$D(ANS)!(ANS=U)!($D(DUOUT))!($D(DTOUT))
PRT MERGE RMY=Y
 S DATE=$P(Y,U,3),TYPE=$P(Y,U,6),QTY=$P(Y,U,7)
 S VEN=$P(Y,U,9),TRANS=$P(Y,U,4),STA=$P(Y,U,10),SN=$P(Y,U,11)
 S DEL=$P(Y,U,12)
 S CST=$S($P(Y,U,16)'="":$P(Y,U,16),$D(^RMPR(660,AN,"LB")):$P(^RMPR(660,AN,"LB"),U,9),1:"")
 ;form requested on
 S FRM=$P(Y,U,13),REM=$P(Y,U,18)
 S DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 ;S TYPE=$S(TYPE="":"",$D(^RMPR(661,TYPE,0)):$P(^(0),U,1),1:"")
 S TYPE=$P($G(^RMPR(660,AN,1)),U,4)
 S AMIS=$P(Y,U,15),VEN=$S(VEN="":"",$D(^PRC(440,VEN,0)):$P(^(0),U,1),1:"")
 I $D(^RMPR(660.1,"AC",AN)),$P(^RMPR(660.1,$O(^RMPR(660.1,"AC",AN,0)),0),U,11)]"" S AMIS=AMIS_"+"
 S TRANS=$S(TRANS]"":TRANS,1:""),TRANS1=""
 S:TRANS="X" TRANS1=TRANS,TRANS=""
 S DEL=$E(DEL,4,5)_"/"_$E(DEL,6,7)_"/"_$E(DEL,2,3) S:DEL="//" DEL=""
 W !,RK,". ",DATE,?13,QTY,?17
 ;W AMIS_$S(TYPE'="":$E($P(^PRC(441,TYPE,0),U,2),1,10),$P(Y,U,26)="D":"DELIVERY",$P(Y,U,26)="P":"PICKUP",$P(Y,U,17):"SHIPPING",1:"")
 W AMIS_$S(TYPE'="":$E($P($G(^RMPR(661.1,TYPE,0)),U,1),1,10),$P(Y,U,26)="D":"DELIVERY",$P(Y,U,26)="P":"PICKUP",$P(Y,U,17):"SHIPPING",1:"")
 ;W:$D(^RMPR(660,$P(IT(RK),U,1),"HST")) $E($P(^("HST"),U,1),1,10)
 I TYPE=""&($D(^RMPR(660,$P(IT(RK),U,1),"HST"))) W $E($P(^("HST"),U,1),1,10)
 W ?30,TRANS,?31,TRANS1
 ;display source of procurement for 2529-3 under vendor header
 I $D(RMPRLPRO) W ?33,RMPRLPRO
 K RMPRLPRO
 I VEN'="" W ?33,$E(VEN,1,10)
 W:$D(^RMPR(660,$P(IT(RK),U,1),"HST")) $E($P(^("HST"),U,3),1,10)
 I STA'="" D
 .S DIC="^DIC(4,",DIQ(0)="E",DR=99,DIQ="RMPRSTN",DA=STA D EN^DIQ1
 .W:$D(RMPRSTN(4,STA,99,"E")) ?45,RMPRSTN(4,STA,99,"E")
 W ?50,$E(SN,1,9),?60,DEL
 W ?71,$J($FN($S(CST'="":CST,$P(RMY,U,17):$P(RMY,U,17),1:""),"T",2),9)
 W:REM]"" !,?3,REM
 I $P(IT(RK),U,2)="" S IT(RK)=IT(RK)_"^"_RZ
 Q
OVER N ANS
 S RZ=RK W !,"+=Turned-In  *=Historical Data  I=Initial  X=Repair  S=Spare  R=Replacement",!,"Enter 1-",RK," to show full entry, '^' to exit or `return` to continue.  " R ANS:DTIME S:'$T ANS="^"
 I ANS="^^" S ANS="^" G ASK1^RMPOPAT Q
 I ANS="^" G ASK1^RMPOPAT Q
 I ANS="",RK+1'>RC D HDR Q
 I ANS="" Q
 I ANS'?1N.N!(ANS>RK)!(+ANS=0)!(+ANS'=ANS) W $C(7),!," Must be between 1 and ",RK," to be valid" G OVER
 I ANS>0,(ANS<(RK+1)) S AN=ANS,RZ=RK D ^RMPOPAT3 I RMOXY=0 K RK Q
 S RK=$P(IT(ANS),U,2)
 Q
HDR ;Print Header, Screen 4
 W @IOF
 S PAGE=3
 W !,$E(RMPRNAM,1,20),?23,"SSN: "
 W $E(RMPRSSN,1,3)_"-"_$E(RMPRSSN,4,5)_"-"_$E(RMPRSSN,6,10)
 W ?42,"DOB: "
 S Y=RMPRDOB X ^DD("DD") W Y K Y
 W ?61,"CLAIM# ",$G(RMPRCNUM)
 W !?4,"Date",?12,"Qty",?19,"Item",?28,"Type",?34,"Vendor",?45,"Sta",?50,"Serial",?58,"Delivery Date",?72,"Tot Cost"
 Q
