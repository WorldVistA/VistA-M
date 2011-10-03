FBAAPIE1 ;AISC/GRR-ENTER FEE PHARMACY INVOICE ;11/13/2003
 ;;3.5;FEE BASIS;**68**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
LISTLI I '$D(^FBAA(162.1,DA,"RX","AB")) W !,"No prescriptions currently in this invoice.",! Q
 D HOME^%ZIS S FSW=1
 S FBAAOUT=0 F J=0:0 S J=$O(^FBAA(162.1,DA,"RX",J)) Q:J'>0  I $D(^FBAA(162.1,DA,"RX",J,0)) S Y(0)=^(0) D GETIT Q:FBAAOUT
 Q
Q K DIE,DIC,STAT,IN,VIN,DA,LCNT,AC,TAC,DATEF,DR,X,%DT,INVDATE,CNT,DAT,FBAABDT,FBAAEDT,FBAAIN,FBAAOUT,FBAAPN,FBAAPTC,FBBATCH,FBDRUG,FBDX,FBI,FBINTOT,FBINVN,FBMDF,FBPD,FBPOV,FBPT,FBSITE,FBRBC,FBREIM,PSRX,Y,Z,FBFDC,FBMST,FBTTYPE,FBPOP
 K FBRR,FBT,FBTOV,FBTT,FBTV,FBTYPE,FEEO,FTP,FY,I,J,K,N,NAME,S,SSN,VAL,VAR,VID,VNAM,Z1,Z2,ZZ,D,F,FBAC,FBAP,FBFD,FBPROG,FBRX,FBXX,FSW,PI,POP,PTYPE,T,TA,DFN,D0,FBDEL,FBAUT,FBPSA,A1,A2,CHN,DOB,FBPV,FBQTY,FBSTR,FBSUSP,FID,L,PSA,Q,X1
 K FB7078,FBASSOC,FBD1,FBLOC,FBVEN,DIRUT,FBAR,FBDA,FBJ,FBID,FBPARCD,FBTOUT,FBVINVDT,FBFPPSC
 Q
GETIT S FBRX=$P(Y(0),"^"),FBFD=$P(Y(0),"^",3),FBAC=$P(Y(0),"^",4),DFN=+$P(Y(0),"^",5)
 S SSN=$$SSN^FBAAUTL(DFN),VID=+$P($G(^FBAA(162.1,DA,0)),"^",4),VNAM=$P($G(^FBAAV(VID,0)),"^")
 I FSW S FSW=0 D HED
 I $Y+5>IOSL S DIR(0)="E" D ^DIR K DIR S:'Y FBAAOUT=1 Q:FBAAOUT   D HED
 W !,SSN,?19,$E(FBFD,4,5),"-",$E(FBFD,6,7),"-",$E(FBFD,2,3),?31,FBRX,?44,FBAC
 Q
HED W @IOF,"Invoice #: ",DA,?25,"Vendor Name: ",VNAM,!!,"Patient  I.D.",?18,"Fill Date",?30," RX  #",?40,"Amt Claimed",!
 Q
CHKK W !!,*7,"There already is a prescription number entered, from this vendor, ",!,"for that fill date. The invoice number is ",$O(^FBAA(162.1,"AL",VIN,PSRX,DATEF,""))_" ."
 G RDD^FBAAPIE
CALC ;Calculate Invoice Total
 S FBINTOT=0 I $D(^FBAA(162.1,IN,"RX")) F I=0:0 S I=$O(^FBAA(162.1,IN,"RX",I)) Q:I'>0  I $D(^(I,0)) S FBINTOT=FBINTOT+$P(^FBAA(162.1,IN,"RX",I,0),"^",16)
 K I Q
RDM W ! S DIR("A")="Do you want to continue a previously entered Invoice",DIR("B")="No",DIR(0)="Y" D ^DIR K DIR G Q:$D(DIRUT)!('Y)
RD2 W !! S DIC="^FBAA(162.1,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,5)'=4" D ^DIC G Q:X="^"!(X=""),RD2:Y<0 S (DA,DA(1),IN)=+Y,VIN=$P(^(0),"^",4)
 D CALC W:FBINTOT>0 !,?30,"Current Total: $ "_$J(FBINTOT,1,2)
RD3 W ! S DIR("A")="Want to list previously entered line items",DIR("B")="No",DIR(0)="Y" D ^DIR K DIR G Q:$D(DIRUT) D:Y LISTLI
 S LCNT=+$P(^FBAA(162.1,IN,0),"^",9),TAC=+$P(^(0),"^",6),STAT=+$P(^(0),"^",5),STAT(STAT)="",FBFPPSC=$P(^FBAA(162.1,IN,0),"^",13) G RDP^FBAAPIE
 Q
RX2 W !!,*7,"This prescription number already exsists in this invoice.",!
 W ! S DIR("A")="Do you wish to enter this prescription again",DIR("B")="No",DIR(0)="Y" D ^DIR K DIR G CHK^FBAAPIE:$D(DIRUT),RDRX^FBAAPIE:'Y,RXADD^FBAAPIE
 Q
PROB W !!,"You do not have access to the Fee Invoice File, contact your IRM Service.",! G Q
CHK2 ;Checks for duplicate payments on all linked vendors.
 S FBJ=0 F  S FBJ=$O(FBAR(FBJ)) Q:$S('FBJ:1,$D(^FBAA(162.1,"AL",FBJ,PSRX,DATEF)):1,1:0)
 Q
