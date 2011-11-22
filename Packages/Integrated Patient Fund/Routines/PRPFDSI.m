PRPFDSI ;ALTOONA/CTB  INFORMATION DISPLAY ;11/22/96  4:36 PM
V ;;3.0;PATIENT FUNDS;**6**;JUNE 1, 1989
SE D HILO^PRPFBAL S DIC=470,DIC(0)="AEMNZ" D ^DIC I Y>0 S PDFN("ZERO")=Y(0),DFN=+Y S ZTRTN="INFO^PRPFDSI",(ZTSAVE("PDFN*"),ZTSAVE("DFN"))="",ZTDESC="PATIENT FUNDS INFORMATION DISPLAY" D ^PRPFQ G SE
 K %,%H,%W,%Y,C,DFN,DIC,DIYS,F,I,J,K,N1,PDFN,PFHI,PFLO,PFNORM,POP,TMP,S,X,X2,Y Q
INFO I $D(ZTSK) S (PFHI,PFLO,PFNORM)="*0" K ^%ZTSK(ZTSK)
 F I=0,1 S DFN(I)=$S($D(^PRPF(470,DFN,I)):^(I),1:"")
 D EN^PRPFRES K DFN(0),DFN(1)
 F I=0,.31 S DFN(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 D ADD^PRPFCD1 F I=1,2 S PDFN(I)=$S($D(^PRPF(470,DFN,I)):^(I),1:"")
B D DGINPW^PRPFU1 W:$Y>1 @IOF W @PFLO,"Name: ",@PFHI,$P(DFN(0),"^"),?44 S SSN=$P(DFN(0),"^",9) W @PFLO,"SSN: ",@PFHI,$E(SSN,1,3),@PFLO,"-",@PFHI,$E(SSN,4,5),@PFLO,"-",@PFHI,$E(SSN,6,9),@PFLO,"  Claim #: ",@PFHI,$P(DFN(.31),"^",3) K SSN
 D DEAD^PRPFED
 W !,@PFLO,"Patient Address: " I '$D(DFN(.11)) W @PFHI,"NOT IN FILE"
 E  W @PFHI F I=1:1:3 W:$P(DFN(.11),"^",I)]"" ?19,$E($P(DFN(.11),"^",I),1,29),?50,$E($P(DFN(.11),"^",I+3),1,29),!
 W:$Y<12 ! W !,@PFLO,"Ward: ",@PFHI,$P(DFN(.1),U),?44,@PFLO,"Date of Admission: ",@PFHI,DOA
 W !,@PFLO,"Regional Office: ",@PFHI,$S($P(PDFN("ZERO"),U,9)>0:$P(^DIC(4,$P(PDFN("ZERO"),U,9),0),U),1:"") S Y=$P(DFN(0),U,3) D D^PRPFU1 W ?44,@PFLO,"Date of Birth: ",@PFHI,Y
 W !!,@PFLO,"Type of Account: ",@PFHI S X=$P(PDFN("ZERO"),U,3),F=2,DD=470 D ^PRPFU1 W Y,?44,@PFLO,"Date of Restriction: " S Y=$P(PDFN("ZERO"),U,12) D D^PRPFU1 W @PFHI,Y
 W !,@PFLO,"Amt Restricted/Month: ",@PFHI S X=$P(PDFN(1),"^",7) D C W X,?44,@PFLO,"Amt Restricted/Week: " S X=$P(PDFN(1),"^",8) D C W @PFHI,X
 W !,@PFLO,"Monthly Restriction Balance: " S X=$P(PDFN(1),"^",11) D C W @PFHI,X,?44,@PFLO,"Weekly Restriction Balance: " S X=$P(PDFN(1),"^",12) D C W @PFHI,X
 W !,@PFLO,"Provider Authorizing Restriction: " S X=$P(PDFN("ZERO"),"^",13),F=10.7,DD=470 D ^PRPFU1 W @PFHI,Y
 W !!,@PFLO,"Minimum Balance 1: ",@PFHI S X=$P(PDFN(2),U) D C W X,?44,@PFLO,"Minimum Balance 2: ",@PFHI S X=$P(PDFN(2),U,3) D C W X
 W !,@PFLO,"Maximum Balance 2: ",@PFHI S X=$P(PDFN(2),U,2) D C W X,@PFLO,?44,"Maximum Balance 2: ",@PFHI S X=$P(PDFN(2),U,4) D C W X
 W !,@PFLO,"Apportionee: ",@PFHI S X=$P(PDFN("ZERO"),U,6) D C W X,?44,@PFLO,"Competency: " S X=$P(PDFN("ZERO"),U,4),F=3,DD=470 D ^PRPFU1 W @PFHI,Y
 W !,@PFLO,"Guardian: ",@PFHI S X=$P(PDFN("ZERO"),U,7) D C W X,?44,@PFLO,"Gratuitous Balance: ",@PFHI S X=$P(PDFN(1),U,6) D C W X
 W !,@PFLO,"Institutional Award: ",@PFHI S X=$P(PDFN("ZERO"),U,8) D C W X,@PFLO,?44,"Private Balance: ",@PFHI S X=$P(PDFN(1),U,5) D C W X
 W !,@PFLO,"Other Assest: ",@PFHI S X=$P(PDFN("ZERO"),U,10) D C W X,@PFLO,?44,"Account Balance: ",@PFHI S X=$P(PDFN(1),U,4) D C W X
 W !,@PFLO,"Indigent: ",@PFHI S DD=470,F=4,X=$P(PDFN("ZERO"),U,5) D ^PRPFU1 W Y
 I IOST["C-" W @PFNORM,!,"Press RETURN to view next screen or '^' to EXIT: " R X:$S($D(DTIME):DTIME,1:120) G:X["^" END^PRPFDSI1 G ^PRPFDSI1
 G ^PRPFDSI1
C S X2="2$"
 S %D=X<0 S:%D X=-X S %=$S($D(X2):+X2,1:2),X=$J(X,1,%),%=$L(X)-3-$E(23456789,%)
 F %=%:-3 Q:$E(X,%)=""  S X=$E(X,1,%)_","_$E(X,%+1,99)
 S:$D(X2) X=$E("$",X2["$")_X S X=$J($E("(",%D)_X_$E(" )",%D+1),0) K %,%D Q
