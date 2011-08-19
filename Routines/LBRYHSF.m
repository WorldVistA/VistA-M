LBRYHSF ;ISC2/DJM-NETWORK AUDIOVISUAL UPDATE ;[ 05/23/97  12:13 PM ]
 ;;2.5;Library;**2**;Mar 11, 1996
SERV W @IOF,?5,"VA Library Service File View ",?60 S Y=DT X ^DD("DD") W Y,!
 S DIC="^DIC(49,",DIC(0)="AEMQ" D ^DIC Q:Y<0  S DA=+Y
 K DR D EN^DIQ
 R !!,"Press return to continue...",C:DTIME
 G SERV
