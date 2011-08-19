RMPRP55 ;PHX/DWL/HNB-PRINT 10-55 ;3/17/03  13:05
 ;;3.0;PROSTHETICS;**20,55,77**;Feb 09, 1996
 ;
 ; ODJ - patch 55 - 1/29/01 - replace 121 hard coded mail symbol with
 ;                            call to site param. extrinsic
 ;                            nois AUG-1097-32118
 ; RVD 3/17/03 patch #77 - allow queing to p-message. IO to ION
 ;
 I '$D(RMPR) D DIV4^RMPRSIT G:$D(X) EXIT
 I $D(RMPRA) G ZIS
EN ;ENTRY POINT FOR REPRINTING A 10-55
 D DIV4^RMPRSIT G:$D(X) EXIT
 S DIC="^RMPR(664,",DIC(0)="AEMQ",DIC("W")="D EN2^RMPRD1"
 S DIC("A")="Select Transaction or Patient Name: "
 S DIC("S")="I $D(^RMPR(664,Y,1)) S R1=$O(^RMPR(664,Y,1,0)) I R1 S RX=$P(^(R1,0),U,13) S:$D(^RMPR(660,+RX,0)) RX=$P(^(0),U,13)  I RX=1!(RX=10) I '$D(^RMPR(664,""AP"",RMPR(""STA""),Y))"
 D ^DIC G:+Y<1 EXIT
 S RMPRA=+Y,RMPRACT=1 I $P(^RMPR(664,+Y,0),U,5) D M2^RMPRM G EXIT
 D PR^RMPR21A I %'>0 G EXIT
 S RX=^RMPR(664,RMPRA,0)
ZIS ;
 I $P(^RMPR(669.9,RMPRSITE,0),U,5) S IOP="Q;"_$P(^%ZIS(1,$P(^(0),U,5),0),U,1),%ZIS="MQ" D ^%ZIS G:POP EXIT G PT
 S %ZIS="MQ" D ^%ZIS G:POP EXIT I $D(IO("Q")) S ZTIO=ION G PT
 U IO
EN1 ;ADDRESS DEFINED
 W:$E(IOST)["C" @IOF S %X="^RMPR(664,RMPRA,",%Y="R55(" D %XY^%RCR
 S Y=DT D DD^%DT S DATE=Y,RMPRTT="" W:$D(RMPRACT) ?30,"****DUPLICATE COPY****" I $P($G(R55(4)),U,8)=1 W ?30,"***WORKING COPY***"
 W !!!,?5,"DEPARTMENT OF VETERANS AFFAIRS" W !,?5,RMPR("NAME"),!,?5,RMPR("ADD"),!,?5,RMPR("CITY")
ADD ;ADDRESS INFO
 S RMPRUP=0,I=0,RMPRV=$P(^RMPR(664,RMPRA,0),U,4),RMPRV=^PRC(440,RMPRV,0),RMPRST=$P(RMPRV,U,7),RMPRST=$S(RMPRST="":"NO STATE",1:$P(^DIC(5,RMPRST,0),U,2)),RMPRDUZ="",RMPRDUZ=$P(^RMPR(664,RMPRA,0),U,9),RMPRDUZ=$P(^VA(200,RMPRDUZ,0),U,1)
 S RMPRDFN=$P(^RMPR(664,RMPRA,0),U,2)
 S I=$O(^RMPR(664,RMPRA,1,I))
 S RMPRI=$P(^RMPR(664,RMPRA,1,I,0),U,1)
 S RMPRUP=$O(^RMPR(665,"C",RMPRI,RMPRDFN,RMPRUP))
 S:RMPRUP RMPRSN=$P(^RMPR(665,RMPRDFN,5,RMPRUP,0),U,3)
 ;Should call VADPT not look at global directly
 S RMPRNAM=$P(^DPT(RMPRDFN,0),U,1)
 S RMPRSSN=$P(^DPT(RMPRDFN,0),U,9)
 S RMPRTN=$P(^RMPR(664,RMPRA,0),U,7)
WRITE W !!!!!,?5,$P(RMPRV,U,1),?53,"In Reply Refer to:",?73,$$STA^RMPRUTIL_"-",$$ROU^RMPRUTIL(RMPRSITE),!,?5,$P(RMPRV,U,2),?53,RMPRNAM
 W !?5,$P(RMPRV,U,6),", ",RMPRST," ",$P(RMPRV,U,8)
 W ?53,$E(RMPRSSN,1,3)_"-"_$E(RMPRSSN,4,5)_"-"_$E(RMPRSSN,6,9),!,?53,RMPRTN
 W !!,?5,$P(RMPRV,U,1),!!,?5,"With reference to your request of ",?39,$E($P(^RMPR(664,RMPRA,0),U,1),4,5),"/",$E($P(^RMPR(664,RMPRA,0),U,1),6,7),"/",$E($P(^RMPR(664,RMPRA,0),U,1),2,3),", authority is granted to repair "
 W !,?5,"the appliance described below for the above-named veteran."
DESC ;ITEM,DES,COST,QTY
 S $P(LINE,".",75)=""
 W !!,?5,LINE,!,?23,"DESCRIPTION OF APPLIANCE OR REPAIR",!,?63,"Unit",?73,"Total",!,?5,"Item",?11,"Name",?32,"Serial Number",?55,"Qty",?63,"Price",?73,"Cost",!,?5,LINE
 S I=0,RMPRTO=0 F I=0:0 S I=$O(^RMPR(664,RMPRA,1,I)),RMPRDFN="" G COST:I'>0 D LIST
COST S X=RMPRTO,X2="2$",X3=9 D COMMA^%DTC
 W !!,?5,"The total cost, not including mailing cost, will not exceed ",?RR+1,X,!!,?5,"When repairs are completed, please attach the original of this letter to"
 W !,?5,"the original copy of your invoice covering repair charges.  Your invoice,",!,?5,"in original and one copy should then be forwarded to this office for"
 W !?5,"payment.",!!?5,"Please retain the duplicate  copy of this letter for your files."
 W !!,?5,"Sincerely,",!!!!,?5,RMPR("SIG"),", Chief",!,?5,RMPR("SBT")
END S L=19-RMPRTT F I=1:1:L W !
 W ?5,"Initiator: ",RMPRDUZ,?45,"REF: ",RMPRA,?64,"ADP FORM 10-55" D:$D(RMPRPRIV) ^RMPRP23
EXIT K RMPRACT,ZTSK,RX,RMPRI,RMPRTN,RMPRDS,RMPRQT,RMPRCT,RMPRTO,RMPRUP,RR,I,DATE,DIC,RG,L,LINE,RMPRA,RMPRDFN,RMPRIS,RMPRNAM,RMPRNM,RMPRSN,RMPRSSN,RMPRST,RMPRTT,RMPRPRIV,RMPRCC,RXT,RX1
 K RMPRV,X2,X3,RMPRDUZ,RMPRI1,RMPRIT,RMPRN,VA,VAEL,RZZZ,VAERR,Y,RMPRPRIV,RTX D ^%ZISC Q
LIST S RR=^RMPR(664,RMPRA,1,I,0),RMPRIS=$P(RR,U,5),RMPRIS=$P(^PRCD(420.5,RMPRIS,0),U,1),RMPRI=$P(RR,U,1),RMPRI=$P(^RMPR(661,RMPRI,0),U,1),RMPRI=^PRC(441,RMPRI,0),RMPRNM=$P(RMPRI,U,2),RMPRI=$P(RMPRI,U,1)
 S RMPRCT=$P(RR,U,3),RMPRQT=$P(RR,U,4),RMPRTO=(RMPRCT*RMPRQT)+RMPRTO,RMPRDS=$P(RR,U,2),X=RMPRCT,X2="2$",X3=9 D COMMA^%DTC S RR=$L(X),RR=79-RR W !,?5,RMPRI,?11,$E(RMPRNM,1,18),?32,$G(RMPRSN),?56,RMPRQT,?59,X,!,?11,RMPRDS
 I $P(^RMPR(664,RMPRA,0),U,10)!($P(^(0),U,11)) S RR=$S($P(^(0),U,11):$P(^(0),U,11),1:$P(^(0),U,10)) I RR S X=RR,X2="2$",X3=9 D COMMA^%DTC S RR=$L(X),RR=79-RR W !,?32,"Shipping Charge: ",?59,X,!
 I $D(R55(1,1,1,0)) F RTX=0:0 S RTX=$O(R55(1,1,1,RTX)) Q:RTX'>0  W !,?5,R55(1,1,1,RTX,0)
CNTER S RMPRTT=(RMPRTT+1) K R55 Q
PT F RG="DT","RMPRSITE","RMPRA","RMPRUP","RMPR(" S ZTSAVE(RG)="" S:$D(RMPRACT) ZTSAVE("RMPRACT")="" S:$D(RMPRPRIV) ZTSAVE("RMPRPRIV")=""
 I $D(IO("Q")) S ZTRTN="EN1^RMPRP55",ZTDTH=$H,ZTDESC="PROSTHETICS PRINT OF 10-55",ZTIO=ION D ^%ZTLOAD
 W !,$S($D(ZTSK):"<REQUEST QUEUED!>",1:"<REQUEST DID NOT QUEUE!>")
 D HOME^%ZIS G EXIT
