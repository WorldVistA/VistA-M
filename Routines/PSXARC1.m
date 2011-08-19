PSXARC1 ;BIR/HTW-Gather Data to Archive ;02 Aug 2001  9:57 AM
 ;;2.0;CMOP;**26,38**;11 Apr 97
 ; Reference to file #200 supported by DBIA 10060
 S (LN,PG,CT)=1,(X,LEN,BATCT,RXCT)=0,PAD="                    "
TAPEHDR U PSXT W "$$HDR|CMOP MASTER ARCHIVE^"_PSXTAPE
 D NOW^%DTC S Y=% X ^DD("DD") K %
 U IO(0) W @PSXIOF,?10,"CMOP MASTER DATABASE ARCHIVE",?45,Y
MAIN ;
 U IO(0) W !!,"Recording data on tape # ",PSXTAPE,". Write this number on the tape label!!",!!
 F ZZZ=0:0 S ZZZ=$O(^TMP("PSX",$J,ZZZ)) Q:'ZZZ  D ONE S ^PSX(552.1,I21,-9)=""
 U IO(0) W !!,"Total # of Transmissions Archived: ",$G(BATCT)
 U IO(0) W !,"Total # of Rx's Archived         : ",$G(RXCT)
 U IO(0) W !,"Total Bytes Archived             : ",$G(T1)+$G(T2)
 D NOW^%DTC S Y=% X ^DD("DD")
 U IO(0) W !,"Completed: ",Y,"   Closing Tape Device..."
 D ^%ZISC
 K I1,LN,LEN,PG,PSXAM,PSXBEE,PSXIOF,PSXPIOF,PSXPIOST,PSXP,PSXT,PSXTBS
 K PSXTIOF,PSXTPAR,%MT,Y,Z,Z1,ZPC,ZQ1,ZQ,ZZZ,RXCT,BATCT,T1,T2,%
 K %MT,%ZIS,PSXTAPE,C1,CT,I21,I24,PAD,PSXEOT,X,XX,Y,Z
 Q
ONE ;GET DATA FROM 552.1
 ;** FROM 0,1,2,P NODES **
 ;REC=(1)BAT-REF^(2)STATUS^(3)TRANS D/T^(4)REC D/T^(5)CLOSED D/T
 ;^(6)PROC D/T^(7)START SEQ^(8)END SEQ^(9)TOT ORD^(10)TOT RX'S
 ;^(11)PURGE STAT^(12)RETRANS^(13) BAT-REF^(14)DIV^(15)SITE^(16)SENDER
 S I21=$P(^TMP("PSX",$J,ZZZ),"^") Q:$G(I21)']""
 F I=1:1:6 S $P(REC,"^",I)=$P(^PSX(552.1,I21,0),"^",I)
 S PC=7 F I=1:1:5 S $P(REC,"^",PC)=$P($G(^PSX(552.1,I21,1)),"^",I),PC=PC+1
 F I=1:1:2 S $P(REC,"^",PC)=$P($G(^PSX(552.1,I21,2)),"^",I),PC=PC+1
 F I=1:1:3 S $P(REC,"^",PC)=$P($G(^PSX(552.1,I21,"P")),"^",I),PC=PC+1
 S Z=2 F Z1=1,5,6,7,16,8,9,10,11,19,12,13,2,3,4 D  S Z=Z+1
 .S Y=$P(REC,"^",Z),$P(REC,"^",Z)=$$EXTERNAL^DILFD(552.1,Z1,"",Y)
 .;S Y=$P(REC,"^",Z) I $D(^DD(552.1,Z1,0)) S C=$P(^DD(552.1,Z1,0),U,2) D Y^DIQ S $P(REC,"^",Z)=Y
 ;N X,Y S DIC=4,DIC(0)="MNZ",X=+$P(REC,"^",15),X=$E(X,1,3) S:$D(^PSX(552,"D",X)) X=$E(X,2,99) D ^DIC K DIC ;****DOD L1
 ;S:($D(Y(0,0))) $P(REC,"^",15)=Y(0,0) K X,Y
 N X,Y
 S X=+$P(REC,"^",15),AGNCY="VASTANUM" S:$D(^PSX(552,"D",X)) X=$E(X,2,99),AGNCY="DMIS" ;****DOD L1
 S X=$$IEN^XUMF(4,AGNCY,X) ;****DOD L1
 S:(X) $P(REC,"^",15)=$$GET1^DIQ(4,X,.01) K X,Y ;****DOD L1
 S REC="$$REC|"_REC
 K PC,Z,C,Y,I
CNODE I '$D(^PSX(552.1,I21,3)) G LBL
 F Z=0:0 S Z=$O(^PSX(552.1,I21,3,Z)) Q:'Z  S COM(Z)="$$COM|"_$G(^(Z,0))
 ;    Get labels printed
LBL I '$D(^PSX(552.1,I21,4)) G ACK
 S Z1=1,LBL(Z1)="$$LBL|"
 S Z=$O(^PSX(552.1,I21,4,0)) I $G(Z)']""  G ACK
LBL1 S Y=$P(^PSX(552.1,I21,4,Z,0),"^") X ^DD("DD")
 ;S NAME=$P(^VA(200,$P(^PSX(552.1,I21,4,Z,0),"^",2),0),"^")
 S NAME=$$GET1^DIQ(200,$P(^PSX(552.1,I21,4,Z,0),"^",2),.01)
 I $L(LBL(Z1))+$L(Y)+$L(NAME)<245 S LBL(Z1)=LBL(Z1)_Y_"^"_NAME_"/"
 E  S Z1=Z1+1 S LBL(Z1)="$$LBL|"_Y_"^"_NAME_"^"
 S Z=$O(^PSX(552.1,I21,4,Z)) I $G(Z)]"" G LBL1
ACK I $D(^PSX(552.1,I21,"ACK")) D
 .S ACK="$$ACK|"_$G(^PSX(552.1,I21,"ACK"))
 ;      W 552.1 data to tape
 D PSXAT
BATCH U PSXT W REC S T1=$G(T1)+$L(REC)
 I $D(COM)>1 F Z=0:0 S Z=$O(COM(Z)) Q:'Z  U PSXT W COM(Z) S T1=$G(T1)+$L(COM(Z))
 I $D(LBL)>1 F Z=0:0 S Z=$O(LBL(Z)) Q:'Z  U PSXT W LBL(Z) S T1=$G(T1)+$L(LBL(Z))
 I $D(ACK)>1 U PSXT W ACK S T1=$G(T1)+$L(ACK)
 ;Print 552.1 data
 S BATCT=$G(BATCT)+1
 ;Disallow further editing of Archived batch
HEADING U IO(0) I $Y>22 W @PSXIOF S PG=1
 I $G(PG)=1 U IO(0) W !,"TRANSMISSION #",?20,"TOT ORDERS",?36,"TOT Rx's" S PG=$G(PG)+1
 U IO(0) W !,$P($P(REC,"|",2),"^"),?20,$J($P($P(REC,"|",2),"^",9),10),?34,$J($P($P(REC,"|",2),"^",10),10)
 K NAME,Y,Z1,Z
 ; Get info for 552.4
 S I24=$P(^TMP("PSX",$J,ZZZ),"^",2) Q:$G(I24)']""
 S C1=1
RX F Z=0:0 S Z=$O(^PSX(552.4,I24,1,Z)) Q:'Z  D  Q:$G(NEWTAPE)=1
 .S REC1=$G(^PSX(552.4,I24,1,Z,0))
 .S REC2=$G(^PSX(552.4,I24,1,Z,2))
 .S ZZ=2 F Z1=1,2,3,4,5,7,8,.02,9,10,11,12 D  S ZZ=ZZ+1
 ..S Y=$P(REC1,"^",ZZ),$P(REC1,"^",ZZ)=$$EXTERNAL^DILFD(552.41,Z1,"",Y)
 ..;S Y=$P(REC1,"^",ZZ),C=$P(^DD(552.41,Z1,0),U,2) D Y^DIQ S $P(REC1,"^",ZZ)=Y
 .S ZZ=1 F Z1=13,14,15,16 D  S ZZ=ZZ+1
 ..S Y=$P(REC2,"^",ZZ),$P(REC2,"^",ZZ)=$$EXTERNAL^DILFD(552.41,Z1,"",Y)
 ..;S Y=$P(REC2,"^",ZZ) I $D(^DD(552.41,Z1,0)) S C=$P(^DD(552.41,Z1,0),U,2) D Y^DIQ S $P(REC2,"^",ZZ)=Y
 .F ZLOT=0:0 S ZLOT=$O(^PSX(552.4,I24,1,Z,1,ZLOT)) Q:($G(ZLOT)']"")  D
 ..S Y=$P($G(^PSX(552.4,I24,1,Z,1,ZLOT,0)),"^",2) X ^DD("DD")
 ..S LOT=$G(LOT)_$P($G(^PSX(552.4,I24,1,Z,1,ZLOT,0)),"^")_"^"_Y_"/"
 .; I EOT detected, reset batch info and rewrite to new tape
 .D PSXAT I $G(NEWTAPE)=1 Q
 .U PSXT W "$$RX,"_C1_"|"_REC1 S RXCT=$G(RXCT)+1,T2=$G(T2)+$L(REC1)
 .U PSXT W "$$ZX,"_C1_"|"_REC2 S T2=$G(T2)+$L(REC1)
 .I $G(LOT)]"" U PSXT W "$$LOT,"_C1_"|"_LOT S T2=$G(T2)+$L(LOT)
 .I $G(PSXP)]"" D RX^PSXARC2
 .K REC1,REC2,ZZ,ZLOT,LOT,Z1,Y,C S C1=C1+1
 I $G(NEWTAPE)=1 K NEWTAPE,Z G BATCH
 S ^PSX(552.4,I24,-9)=""
 S NAME=$$GET1^DIQ(200,DUZ,.01)
 K DD,DO
 S DIC="^PSXARC(",DIC("DR")="1////"_PSXTAPE_";2////"_DT_";3////"_NAME
 S DIC(0)="MZ",X=$P(^TMP("PSX",$J,ZZZ),"^",3)
 D FILE^DICN K DIC,X,NAME,DD,DO
 I $G(Y)<0 W !!,"An error has been encountered in the archive file for transmission number ",$P(^TMP("PSX",$J,ZZZ),"^",3)
 K REC,COM,LBL,ACK,NAME,Y,Z1,Z
NEWTAPE Q
PSXAT ;CHECK FOR EOT RETURN PSXEOT=1 IF EOT FOUND
 U PSXT S PSXEOT=0 X ^%ZOSF("EOT") I Y D EOT S PSXEOT=1
 Q
EOT U IO(0) W !!?5,"** End of tape detected **",!?5,"After current tape rewinds, mount next tape" U PSXT W ^%ZOSF("REW")
READ U IO(0) W !?5,"Type <CR> to continue" R XX:DTIME I '$T G READ
 S PSXTAPE=$E(PSXTAPE,1,5)_$E(PSXTAPE,6)+1
HDR U PSXT W "$$HDR|CMOP MASTER ARCHIVE^"_PSXTAPE
 S NEWTAPE=1
 Q
