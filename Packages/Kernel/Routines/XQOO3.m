XQOO3 ;Luke/Sea - Out-Of-Order Utilities ;01/14/97  13:57
 ;;8.0;KERNEL;**57**;Jul 10, 1995
 ;
LALL ;List all options and protocols that are Out Of Order
 N XQ,XQMES,XQTXT,XQIEN
 S (XQIEN,XQS)=0
 F  Q:XQIEN'=+XQIEN  D
 .S XQIEN=$O(^DIC(19,XQIEN))
 .Q:XQIEN'=+XQIEN
 .I $D(^DIC(19,XQIEN,0)),$P(^(0),U,3)]"" D
 ..S XQMES=$P(^DIC(19,XQIEN,0),U,3),XQNM=$P(^(0),U),XQMT=$P(^(0),U,2)
 ..S ^TMP($J,"XQOO",XQMES,XQNM)=XQMT
 ..S:'$D(XQ(XQMES)) XQ(XQMES)=0,XQS=XQS+1 S XQ(XQMES)=XQ(XQMES)+1
 ..Q
 .Q
 ;
 I XQS=0 W !,"No options marked ""Out-Of-Order"" were found." Q
 I XQS=1 D
 .S XQMES="",XQMES=$O(XQ(XQMES))
 .W !,"There is one set of options marked ""Out-Of-Order"" with the message:",!!?5,XQMES
 .S XQN(1)=XQMES,XQUR=1
 .Q
 I XQS>1 W !,"There are "_XQS_" sets of options Out-Of-Order with the messages:" S %="" F XQI=1:1:XQS D 
 .S %=$O(XQ(%)) W !!?1,XQI_".",?4,%," ("_XQ(%)_" option"_$S(XQ(%)=1:":",1:"s)")
 .I XQ(%)=1 S X=$O(^TMP($J,"XQOO",%,"")) W " ",X,", ",^(X),")"
 .S XQN(XQI)=%
 .Q
 ;
ASK3 ;See a particular set in detail
 S DIR(0)="Y",DIR("A")="Would you like to see more detail?"
 S DIR("B")="NO",DIR("?")="If you enter YES you can see the options/protocols of a set."
 W ! D ^DIR G:Y=0!($D(DIRUT)) OUT
 I XQS>1 W !!,"To see the options of a particular set enter a number between 1 and "_XQS_": " R XQUR:DTIME
 I XQUR=U!(XQUR="") G OUT
 I XQUR["?"!(XQUR'=+XQUR)!(XQUR>XQS)!(XQUR<1) W !?5,"Enter a number between 1 and "_XQS,!?5,"or ""^"" to quit without seeing a detailed option set." G ASK3
 I XQUR=U!(XQUR="") G OUT
 S XQMES=XQN(XQUR)
 D HEAD(XQMES)
 S %=0 F XQI=1:1  S %=$O(^TMP($J,"XQOO",XQMES,%)) Q:%=""  W !,XQI_".",?5,%,"  ",^(%)
 G OUT
 Q
 ;
HEAD(XQMES) ;Print page header
 W @IOF
 W !,"Out-Of-Order with the message """_XQMES_"""",!!
 Q
 ;
OUT ;Clean up and quit
 K X,XQI,XQMT,XQN,XQNM,XQS,XQUR
 K ^TMP($J,"XQOO")
 W !
 Q
 ;
LAPR ;List all the protocols that are OOO
 N XQ,XQMES,XQTXT,XQIEN
 S (XQIEN,XQS)=0
 F  Q:XQIEN'=+XQIEN  D
 .S XQIEN=$O(^ORD(101,XQIEN))
 .Q:XQIEN'=+XQIEN
 .I $D(^ORD(101,XQIEN,0)),$P(^(0),U,3)]"" D
 ..S XQMES=$P(^ORD(101,XQIEN,0),U,3),XQNM=$P(^(0),U),XQMT=$P(^(0),U,2)
 ..S ^TMP($J,"XQOO",XQMES,XQNM)=XQMT
 ..S:'$D(XQ(XQMES)) XQ(XQMES)=0,XQS=XQS+1 S XQ(XQMES)=XQ(XQMES)+1
 ..Q
 .Q
 ;
 I XQS=0 W !,"No protocols marked ""Out-Of-Order"" were found." Q
 I XQS=1 D
 .S XQMES="",XQMES=$O(XQ(XQMES))
 .W !,"There is one set of protocols marked ""Out-Of-Order"" with the message:",!!?5,XQMES
 .S XQN(1)=XQMES
 .Q
 I XQS>1 W !,"There are "_XQS_" sets of protocols Out-Of-Order with the messages:" S %="" F XQI=1:1:XQS D 
 .S %=$O(XQ(%)) W !!?1,XQI_".",?4,%," ("_XQ(%)_" protocol"_$S(XQ(%)=1:":",1:"s)")
 .I XQ(%)=1 S X=$O(^TMP($J,"XQOO",%,"")) W " ",X,", ",^(X),")"
 .S XQN(XQI)=%
 .Q
 ;
ASK4 ;See a particular set in detail
 I XQS>1 D  I XQUR=U G OUT
 .W !!,"To see the protocols of a particular set enter a number between 1 and "_XQS_": " R XQUR:DTIME
 .I XQUR=U!(XQUR="") S XQUR=U Q
 .I XQUR["?"!(XQUR'=+XQUR)!(XQUR>XQS)!(XQUR<1) D
 ..W !?5,"Enter a number between 1 and "_XQS,!?5,"or ""^"" to quit without seeing a detailed set." R XQUR:DTIME
 ..I XQUR=U!(XQUR="") S XQUR=U Q
 ..I XQUR'=+XQUR!(XQUR>XQS)!(XQUR<1) S XQUR=U
 ..Q
 .Q
 ;
 I XQS=1 D  I XQUR=U G OUT
 .S DIR(0)="Y",DIR("A")="Do you want to see it in detail? ",DIR("B")="Y" D ^DIR K DIR
 .S XQUR=$S(Y=1:1,1:U)
 .Q
 ;
 S XQPAGE=$S($D(IOSL):IOSL,1:20),XQLINE=2
 S XQMES=XQN(XQUR)
 D HEAD(XQMES)
 S %=0 F XQI=1:1  S %=$O(^TMP($J,"XQOO",XQMES,%)) Q:%=""  W !,XQI_".",?5,%,"  ",^(%),XQLINE," ",XQPAGE S XQLINE=XQLINE+1 I XQLINE=XQPAGE D PAUSE^XQOO2 S XQLINE=0 Q:$D(XQUPAR)
 G OUT
 Q
