PSSENVN ;BIR/WRT-Environment check routine ; 09/02/97 8:36
 ;;1.0;PHARMACY DATA MANAGEMENT;;9/30/97
 ; ENVIRONMENTAL CHECK ROUTINE
START I ^XMB("NETNAME")?1"CMOP-".E S XPDQUIT=1 Q
 S XQABT1=$H
 I ^XMB("NETNAME")'?1"CMOP-".E
 E  S XPDABORT=2 Q
VERSION I '$D(^PS(59.7,1,10)) W !,"Install Aborted. You do not have NDF V. 3.15 loaded." S XPDQUIT=2
 I $D(^PS(59.7,1,10)),$P(^PS(59.7,1,10),"^",1)<3.15 W !,"Install Aborted. You do not have NDF V. 3.15 or greater loaded." S XPDQUIT=2
 Q
