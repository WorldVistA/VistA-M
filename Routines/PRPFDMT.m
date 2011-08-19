PRPFDMT ;ALTOONA/CTB  DISPLAY MASTER TRANSACTION ;11/22/96  4:36 PM
V ;;3.0;PATIENT FUNDS;**6**;JUNE 1, 1989
 S DIC("A")="Select MASTER TRANSACTION ID: "
A D HILO^PRPFBAL S DIC=470.1,DIC(0)="AEMNZ" D ^DIC K DIC
 I Y>0 S MADA(0)=Y(0),MADA=+Y S ZTRTN="INFO^PRPFDMT",(ZTSAVE("MADA*"),ZTSAVE("MADA"))="",ZTDESC="PATIENT FUNDS MASTER TRANSACTION DISPLAY" D ^PRPFQ S DIC("A")="Select Another MASTER TRANSACTION ID: " G A
 K %,%H,C,DIC,I,K,MADA,PFHI,PFLO,PFNORM,POP,S,TMP,X,X2,Y W @IOF Q
INFO I $D(ZTSK) S (PFHI,PFLO,PFNORM)="*0" K ^%ZTSK(ZTSK)
 W:$Y>1 @IOF W @PFHI,"Review Individual Master Transaction ",@PFLO,!
 W !,@PFLO,"Transaction ID: ",@PFHI,$P(MADA(0),"^"),?40 S DFN=$P(MADA(0),"^",2) W @PFLO,"Patient Name: ",@PFHI,$S($D(^DPT(DFN,0)):$P(^(0),"^"),1:"UNKNOWN"),@PFLO,!?40,"Patient Transaction : ",@PFHI,$P(MADA(0),"^",3)
 W !,@PFLO,"Transaction Date: " S Y=$P(MADA(0),"^",5) D D^PRPFU1 W @PFHI,Y
 W ?40,@PFLO,"Date Entered: " S Y=$P(MADA(0),"^",6) D D^PRPFU1 W @PFHI,Y
 W !,@PFLO,"Reference: ",@PFHI,$P(MADA(0),"^",7),?40,@PFLO,"Dep/With: ",@PFHI S DD=470.1,F=7,X=$P(MADA(0),"^",8) D ^PRPFU1 W Y
 W @PFLO,!,"Source: " S X=$P(MADA(0),"^",10),X=$S(X="G":"GRATUITUOUS",X="P":"PRIVATE SOURCE",1:"BOTH") W @PFHI,X,@PFLO,?40,"Form: " S DD=470.1,F=10,X=$P(MADA(0),"^",11) D ^PRPFU1 W @PFHI,Y
 W !,@PFLO,"Amount: ",@PFHI S Y=$P(MADA(0),"^",4),Y=$S($P(MADA(0),"^",8)["W":-Y,1:Y) W "$ ",$J(Y,0,2),?40,@PFLO,"CA/CK/OTH: " S X=$P(MADA(0),"^",9),X=$S(X=1:"CASH",X=2:"CHECK",1:"OTHER") W @PFHI,X
 W !,@PFLO,"Private Source: " S Y=$P(MADA(0),"^",12),Y=$S($P(MADA(0),"^",8)["W":-Y,1:Y) W @PFHI,"$ ",$J(Y,0,2),@PFLO,?40,"Gratuitous: " S Y=$P(MADA(0),"^",13),Y=$S($P(MADA(0),"^",8)="W":-Y,1:Y) W @PFHI,"$ ",$J(Y,0,2)
 W !,@PFLO,"Clerk: ",@PFHI S X=$P(MADA(0),"^",14),F=13,DD=470.1 D ^PRPFU1 W Y,?40,@PFLO,"Remarks: ",@PFHI,$P(MADA(0),"^",16),!,@PFLO,"Deferral Date: " S Y=$P(MADA(0),"^",21) D D^PRPFU1 W @PFHI,Y,@PFNORM
 I '$D(ZTSK),$D(IOST)#2,IOST["C-" W !!,"Enter RETURN to Continue" R X:$S($D(DTIME):DTIME,1:120) W !!
 K %,DFN,MADA,MADA(0),PFHI,PFLO,PFNORM,POP,PRIOP,X,Y,ZTDESC,ZTRTN,ZTSAVE Q
