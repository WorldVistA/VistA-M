PSXRXQU ;BIR/BAB,WPB-CMOP RX QUEUE File Utility ;22 Feb 2002  3:24 PM
 ;;2.0;CMOP;**7,12,25,33,40,41,54**;11 Apr 97;Build 6
 ;
 ;Reference to ^PS(55, supported by DBIA #2228
PURGE ;Purge 550.1 of any entries w/Message Status "IN TRANSITION"
 Q:'$D(^PSX(550.1,"AB"))  S MSG="" F  S MSG=$O(^PSX(550.1,"AB",MSG)) Q:'MSG  S DIK=550.1,DA=MSG D ^DIK
 K DIK,MSG,DA
 Q
 ;-------------------------------------------------------------
NEWMSG ;Increment & create entry in RX QUEUE file, put pid/demog in 'T' ; return PSXMSG, PSX=3
 ;550.1 has been dinumed
 D NOW^%DTC
 S PSXMSG=PSXMSG+1,X=PSXMSG
 K DO,DD S DIC(0)="L",DIC="^PSX(550.1,",DIC("DR")="1///3;2////"_%_";3////^S X=PSXBAT",DLAYGO=550.1
 D ^DIC K DIC,DUOUT,DTOUT
MSH ; build patients MSH HL7 segment
 ;D RX5502 ;load RX,Fill,Pat,Ord
 D DEM^VADPT,ADD^VADPT,TSOUT^PSXUTL S ^PSX(550.1,PSXMSG,"T",1,0)="MSH|^~\&|VISTA||CMOP Automated System||"_PSXTS_"||ORM|"_PSXMSG_"|P|2.1|" K PSXTS ;*33
 S X1=$P(VADM(2),"^")
 S I="" F  S I=$O(VAPA(I)) Q:I=""  S VAPA(I)=$$STRIP(VAPA(I)) ; strip bad characters
 F YT=1:1:4 S VAPA(YT)=$TR(VAPA(YT),"\","/")
PID ; build patients PID HL7 segment
 S ^PSX(550.1,PSXMSG,"T",2,0)="PID|||"_$P(VADM(2),"^")_"^"_(X1#11)_"^M11||"_$P(PSXNM,",")_"^"_$P(PSXNM,",",2)_"||||||"_VAPA(1)_"^"_VAPA(2)_"^"_VAPA(4)_"^"_$P($G(^DIC(5,+VAPA(5),0)),"^",2)_"^"_$P(VAPA(11),"^",2)
 ; Telephone #
 S XX=$$HLPHONE^HLFNC(VAPA(8)) S:XX["(" XX="("_$P(XX,"(",2,99)
 S $P(^PSX(550.1,PSXMSG,"T",2,0),"|",14)=XX
 ; Add other language flag
 S PSXLANG=$P($G(^PS(55,DFN,"LAN")),"^",2)
 I $G(PSXLANG)'>1 S PSXLANG=1
 I PSXLANG>1,'$P($G(^PS(55,DFN,"LAN")),"^") S PSXLANG=1 ; DON'T MARK AS SPANISH IF NO SPANISH SIG
 I $P($G(^PS(59.7,PSSWSITE,10)),"^",10)="N" S PSXLANG=$S(PSXLANG=1:"ENG",1:"SPA")
 S $P(^PSX(550.1,PSXMSG,"T",2,0),"|",15)=$G(PSXLANG) K PSXLANG
 ; GET PATIENT ICN - DON'T SEND IF LOCAL ICN ONLY
 S PSXICN=$$MPINODE^MPIFAPI(DFN) D
 .I PSXICN<0 S PSXICN="" Q
 .I $P(PSXICN,"^",4)=1 S PSXICN="" Q
 .S PSXICN=$P(PSXICN,"^")_"V"_$P(PSXICN,"^",2)
 S $P(^PSX(550.1,PSXMSG,"T",2,0),"|",18)=$G(PSXICN) K PSXICN
 S TDT=$P(VAPA(10),"^")
 I $G(VAPA(3))]""!($G(TDT)]"") D
 .I $G(TDT)>1 S TDT=TDT+17000000,TDT1=$E(TDT,1,4),TDT2=$E(TDT,5,6),TDT3=$E(TDT,7,8) S:TDT2'>0 TDT2="01" S:TDT3'>0 TDT3="01" S TDT=$G(TDT1)_$G(TDT2)_$G(TDT3)
 .S ^PSX(550.1,PSXMSG,"T",3,0)="NTE|8||"_$S($G(TDT)>1:"1\F\"_TDT_"\F\"_VAPA(3),1:"\F\\F\"_VAPA(3))
 K VADM,VAPA,X1,TDT,YT,TDT1,TDT2,TDT3
 Q
LOADMSG ; set RXs HL7 text into PSXMSG 'T', set PSXBAT 1////1
 S PSX=3
 S X="" F  Q:'$D(PSXORD("M"))  S X=$O(PSXORD("M",X)) Q:'X  S PSX=PSX+1 S ^PSX(550.1,PSXMSG,"T",PSX,0)=$G(PSXORD("M",X))
 K PSXORD("M"),X
 S X="" F  Q:'$D(PSXORD("E"))  S X=$O(PSXORD("E",X)) Q:'X  S PSX=PSX+1 S ^PSX(550.1,PSXMSG,"T",PSX,0)=$G(PSXORD("E",X))
 K PSXORD("E"),X
 I '$D(PSXORD) Q  ;PSX*2*33
 S X="" F  S X=$O(PSXORD(X)) Q:'X  S PSX=PSX+1 S ^PSX(550.1,PSXMSG,"T",PSX,0)=$G(PSXORD(X))
 S ^PSX(550.1,PSXMSG,"T",0)="^550.11A^"_PSX_"^"_PSX
 K X1,VAPA,VADM
QMSG ;Queue message for transmission
 S DA=PSXMSG,DIE="^PSX(550.1," S DR="1////1" L +^PSX(550.1,DA):600
 D ^DIE L -^PSX(550.1,DA) K DA,DIE,DR,PSXORD
 Q
ACKN ;Flag message as Acknowledged
 K BEG
 G LOGACK^PSXPURG
PROC ;Flag message as Processed
 ;--------------------------------------------------------
STAT ;Display status of CMOP RX QUEUE
 N X,PSX1,PSX2 S PSX1=$G(^PSX(550.1,0)) Q:PSX1=""
 S PSX1=+$P(PSX1,"^",3),PSX2=+$O(^PSX(550.1,"AS",0))
 W !!,"Next Order Number to Transmit : ",$S(PSX2:PSX2,1:PSX1)
 W !!,"Last Order Number Generated     : ",PSX1
 Q
SUSP ; put RXs ien int 550.1 RX multiple
RXMSG ; put RX ien into 550.1 RX multiple , returns PSXRXMDA DA within 'M'essage multiple
 S:'$D(^PSX(550.1,PSXMSG,2,0)) ^PSX(550.1,PSXMSG,2,0)="^550.1101PA^^"
SET ;
 K DD,DO,DIC
 S DA(1)=PSXMSG,(X,DA)=RX,DIC("DR")="1////"_RXF,DIC="^PSX(550.1,"_PSXMSG_",2,",DIC(0)="FZ"
 D FILE^DICN G:$P(Y,"^",3)'=1 SET K DA,X,DIC,DIC("DR")
 S PSXRXMDA=+Y
 Q
STRIP(X) ;EP Strip control characters out and replace with " "
 ; $A(124) = Pipe Character '|'
 N I,Z
 F I=1:1:$L(X) S Z=$E(X,I),Z=$A(Z) I (Z<32)!(Z>126)!(Z=124) S X=$E(X,1,I-1)_" "_$E(X,I+1,999)
 Q X
 ;
