PSOUTL ;BHAM ISC/SAB - pso utility routine ;4/28/09 4:14pm
 ;;7.0;OUTPATIENT PHARMACY;**1,21,126,174,218,259,324,390**;DEC 1997;Build 86
 ;External reference SERV^IBARX1 supported by DBIA 2245
 ;External reference ^PS(55,     supported by DBIA 2228
 ;External reference ^PSSDIUTL is supported by DBIA# 5737.
 ;
 ;*218 prevent refill from being deleted if pending processing via
 ; external dispense machines
 ;*259 reverse *218 restrictions & Add del only last refill logic.
 ;
SUSPCAN ;dcl rx from suspense used in new, renew AND verification of Rxs
 S PSLAST=0 F PSI=0:0 S PSI=$O(^PSRX(PSRX,1,PSI)) Q:'PSI  S PSLAST=PSI
 I PSLAST S PSI=^PSRX(PSRX,1,PSLAST,0) K ^PSRX(PSRX,1,PSLAST),^PSRX(PSRX,1,"B",+PSI,PSLAST) S ^(0)=$P(^PSRX(PSRX,1,0),"^",1,3)_"^"_($P(^(0),"^",4)-1) K PSLAST,PSI,SUSX,SUS1,SUS2 Q
 S $P(^PSRX(PSRX,3),"^",7)="DISCONTINUED FROM SUSPENSE BEFORE FILLING" K PSI,SUSX,SUS1,SUS2 Q
 ;
ACTLOG ;
 F PSI=0:0 S PSI=$O(^PSRX(PSRX,"A",PSI)) I 'PSI!'$O(^(PSI)) S ^PSRX(PSRX,"A",+PSI+1,0)=DT_"^"_PSREA_"^"_PSOCLC_"^"_PSRXREF_"^"_PSMSG,^PSRX(PSRX,"A",0)="^52.3DA^"_(+PSI+1)_"^"_(+PSI+1) Q
ACTOUT I PSREA="C" S PSI=$S($D(^PSRX(PSRX,2)):+$P(^(2),"^",6),1:0) K:$D(^PS(55,PSDFN,"P","A",PSI,PSRX)) ^(PSRX) S ^PS(55,PSDFN,"P","A",DT,PSRX)="" Q
 I PSREA="R" F PSI=0:0 S PSI=$O(^PSRX(PSRX,"A",PSI)) Q:'PSI  I $D(^(PSI,0)),$P(^(0),"^",2)="C" S PSS=+^(0)
 I $D(PSS),PSS K:$D(^PS(55,PSDFN,"P","A",PSS,PSRX)) ^(PSRX)
 I PSREA="R",$D(^PSRX(PSRX,2))#2 S ^PS(55,PSDFN,"P","A",+$P(^PSRX(PSRX,2),"^",6),PSRX)=""
 Q
 ;
QUES ;INSTRUCTIONS FOR RENEW AND REFILL
 W !?5,"Enter the item #(s) or RX #(s) you wish to ",$S(PSFROM="N":"renew ",PSFROM="R":"REFILL "),"separated by commas."
 W !?5,"For example: 1,2,5 or 123456,33254A,232323B."
 W !?5,"Do not enter the same number twice, duplicates are not allowed."
 Q
ENDVCHK S PSOPOP=0 Q:'PSODIV  Q:'$P(^PSRX(PSRX,2),"^",9)!($P(^(2),"^",9)=PSOSITE)
CHK1 I '$P(PSOSYS,"^",2) W !?10,$C(7),"RX# ",$P(^PSRX(PSRX,0),"^")," is not a valid choice. (Different Division)" S PSPOP=1 Q
 I $P(PSOSYS,"^",3) W !?10,$C(7),"RX# ",$P(^PSRX(PSRX,0),"^")," is from another division. Continue? (Y/N) " R ANS:DTIME I ANS="^"!(ANS="") S PSPOP=1 Q
 I (ANS']"")!("YNyn"'[$E(ANS)) W !?10,$C(7),"Answer 'YES' or 'NO'." G CHK1
 S:$E(ANS)["Nn" PSPOP=1 Q
 ;PSO*7*259; SET VAR PSOSFN TO CHECK FOR SUSPENDED REFILL
K52 K PSOSFN S SFN=+$O(^PS(52.5,"B",DA(1),0)),PSOSFN=SFN Q:SFN=0
 I $P($G(^PS(52.5,SFN,0)),"^",5)=$P($G(^PSRX(+^PS(52.5,SFN,0),"P",0)),"^",3),$P($G(^PSRX($P(^PS(52.5,SFN,0),"^"),"P",0)),"^",4)=0 N PSOXX S PSOXX=1 G KILL
 G:X'=""&($G(Y)=1) KILL I $G(Y)'=1,SFN I $D(^PS(52.5,SFN,0)),'$P(^(0),"^",5),'$P($G(^("P")),"^") D
 .S SDT=+$P(^PS(52.5,SFN,0),"^",2) K ^PS(52.5,"C",SDT,SFN)
 .I $P($G(^PS(52.5,SFN,0)),"^",7)="Q" K ^PS(52.5,"AQ",SDT,+$P(^PS(52.5,SFN,0),"^",3),SFN) D KCMPX^PSOCMOP(SFN,"Q")
 .I $P($G(^PS(52.5,SFN,0)),"^",7)="" K ^PS(52.5,"AC",+$P(^PS(52.5,SFN,0),"^",3),SDT,SFN)
 .K SFN,SDT
 Q
S52 S (RIFN,PSOSX)=0 F  S RIFN=$O(^PSRX(DA(1),1,RIFN)) Q:'RIFN  S RFID=$P(^PSRX(DA(1),1,RIFN,0),"^"),PSOSX=PSOSX+1
 S SFN=+$O(^PS(52.5,"B",DA(1),0)) I SFN,'$G(^PS(52.5,SFN,"P")),$P($G(^PSRX($P($G(^PS(52.5,SFN,0)),"^"),"STA")),"^")=5 D
 .I '$D(^PS(52.5,SFN,0))!($P($G(^(0)),"^",5)) Q
 .S $P(^PS(52.5,SFN,0),"^",2)=RFID,^PS(52.5,"C",RFID,SFN)=""
 .I $P($G(^PS(52.5,SFN,0)),"^",7)="Q" S ^PS(52.5,"AQ",RFID,+$P(^PS(52.5,SFN,0),"^",3),SFN)="" D SCMPX^PSOCMOP(SFN,"Q")
 .I $P($G(^PS(52.5,SFN,0)),"^",7)="" S ^PS(52.5,"AC",+$P(^PS(52.5,SFN,0),"^",3),RFID,SFN)=""
 K SFN,RFIN,RFID,PSOSX,PSOSXDT Q
KILL N DFN
 I SFN D
 .S $P(^PSRX(DA(1),"STA"),"^")=0 Q:'$D(^PS(52.5,SFN,0))  S DFN=+$P(^PS(52.5,SFN,0),"^",3),PAT=$P(^DPT(DFN,0),"^")
 .;I $P(^PS(52.5,SFN,0),"^",5) Q
 .K ^PS(52.5,"B",+$P(^PS(52.5,SFN,0),"^"),SFN),^PS(52.5,"C",+$P(^PS(52.5,SFN,0),"^",2),SFN),^PS(52.5,"D",PAT,SFN),^PS(52.5,"AF",DFN,SFN)
 .I $P($G(^PS(52.5,SFN,0)),"^",7)="" D
 ..I $G(^PS(52.5,SFN,"P")) K ^PS(52.5,"AS",+$P(^(0),"^",8),+$P(^(0),"^",9),+$P(^(0),"^",6),+$P(^(0),"^",11),SFN),^PS(52.5,"ADL",$E(+$P(^PS(52.5,SFN,0),"^",8),1,7),SFN) Q
 ..K ^PS(52.5,"AC",DFN,+$P(^PS(52.5,SFN,0),"^",2),SFN)
 .I $P($G(^PS(52.5,SFN,0)),"^",7)'="" D
 ..;Kill CMOP xrefs
 ..N PSOC7 S PSOC7=$P($G(^PS(52.5,SFN,0)),"^",7)
 ..I PSOC7="Q"!(PSOC7="P") K ^PS(52.5,"AG",+$P(^PS(52.5,SFN,0),"^",3),SFN) D KCMPX^PSOCMOP(SFN,PSOC7)
 ..I PSOC7="X"!(PSOC7="P")!(PSOC7="L") K ^PS(52.5,$S(PSOC7="X":"AX",PSOC7="P":"AP",1:"AL"),$P(^PS(52.5,SFN,0),"^",2),$P(^(0),"^",3),SFN) D KCMPX^PSOCMOP(SFN,PSOC7)
 ..K ^PS(52.5,"APR",+$P(^PS(52.5,SFN,0),"^",8),+$P(^(0),"^",9),+$P(^(0),"^",6),+$P(^(0),"^",11),SFN),^PS(52.5,"ADL",$E(+$P(^PS(52.5,SFN,0),"^",8),1,7),SFN)
 .K ^PS(52.5,SFN,0),^PS(52.5,SFN,"P"),DFN,SFN,PAT
 S CNT=0 F SUB=0:0 S SUB=$O(^PSRX(DA(1),"A",SUB)) Q:'SUB  S CNT=SUB
 S:DA>5 DA=DA+1 D NOW^%DTC S CNT=CNT+1
 S ^PSRX(DA(1),"A",0)="^52.3DA^"_CNT_"^"_CNT,^PSRX(DA(1),"A",CNT,0)=%_"^D^"_DUZ_"^"_DA_"^"
 I '$D(PSOXX) S ^PSRX(DA(1),"A",CNT,0)=^PSRX(DA(1),"A",CNT,0)_"Refill "
 ;if PSOXX not exist, = refill. otherwise, it is a partial.
 S ^PSRX(DA(1),"A",CNT,0)=^PSRX(DA(1),"A",CNT,0)_$S($G(RESK):"returned to stock.",$G(PSOPSDAL):"deleted during Controlled Subs release.",$G(PSOXX)=1:"Partial deleted from suspense file.",1:"deleted during Rx edit.") K CNT,SUB
 Q
CID ;calculates six months limit on issue dates
 S PSID=X,X="T-6M",%DT="X" D ^%DT S %DT(0)=Y,X=PSID,%DT="EX" D ^%DT K PSID
 Q
CIDH S X="T-6M",%DT="X" D ^%DT X ^DD("DD") D EN^DDIOL("Issue Date must be greater or equal to "_Y,"","!")
 Q
SPR F RF=0:0 S RF=$O(^PSRX(DA(1),1,RF)) Q:'RF  S NODE=RF
 I NODE=1 S $P(^PSRX(DA(1),3),"^",4)=$P(^PSRX(DA(1),2),"^",2) Q
SREF I $G(NODE) S NODE=NODE-1 G:'$D(^PSRX(DA(1),1,NODE,0)) SREF
 I NODE=0 S $P(^PSRX(DA(1),3),"^",4)=$P(^PSRX(DA(1),2),"^",2) Q
 S $P(^PSRX(DA(1),3),"^",4)=$P(^PSRX(DA(1),1,NODE,0),"^",1) Q
 K NODE,RF
 Q
KPR F RF=0:0 S RF=$O(^PSRX(DA(1),1,RF)) Q:'RF  S NODE=RF
 I NODE=DA&(X'="") S NODE=NODE-1 S:NODE=1 NODE=0 G:'NODE ORIG G:NODE>1 KREF
 I NODE=1 S $P(^PSRX(DA(1),3),"^",4)=$P(^PSRX(DA(1),2),"^",2) G EX
KREF S NODE=NODE-1 G:'NODE EX
 I NODE=1 S $P(^PSRX(DA(1),3),"^",4)=$P(^PSRX(DA(1),2),"^",2) G EX
 G:NODE=DA&(X'="") KREF G:'$D(^PSRX(DA(1),1,NODE,0)) KREF
ORIG I 'NODE S $P(^PSRX(DA(1),3),"^",4)=$P(^PSRX(DA(1),2),"^",2) G EX
 S $P(^PSRX(DA(1),3),"^",4)=$P(^PSRX(DA(1),1,NODE,0),"^",1) G EX
EX K NODE,RF
 Q
IBSS N PSOHLP S PSOHLP(1,"F")="!!"
 S PSOHLP(1)="Entry in this field must match the SERVICE field for pharmacy action"
 S PSOHLP(2,"F")="!"
 S PSOHLP(2)="types in the IB ACTION TYPE file AND be a valid entry in your"
 S PSOHLP(3,"F")="!"
 S PSOHLP(3)="SERVICE/SECTION file to generate copay charges!"
 S PSOHLP(4,"F")="!!"
 D EN^DDIOL(.PSOHLP) K PSOHLP
 Q
IBSSR S PSOIBFL=0 F PSOIBLP=0:0 S PSOIBLP=$O(^DIC(49,PSOIBLP)) Q:'PSOIBLP!(PSOIBFL)  S Y=PSOIBLP,PSOIBST=$$SERV^IBARX1(+Y) I $G(PSOIBST) S DIE="^PS(59,",DA=PSOSITE,DR="1003////"_PSOIBLP D ^DIE K DIE D  S PSOIBFL=1
 .W $C(7),!!,"There was an invalid entry in your IB SERVICE/SECTION field in your Outpatient",!,"Site Parameter file, but we have fixed the problem for you, and you",!,"may continue!" Q
 Q
WARN ;
 I $G(PSOUNHLD) D  Q
 .D EN^DDIOL("You cannot delete a refill while removing from Hold! Use the Edit Action.","","$C(7),!!"),EN^DDIOL(" ","","!!")
 I $G(CMOP(DA))]""&(+$G(CMOP(DA))<3) D  K CMOP Q
 .D EN^DDIOL("You cannot delete a refill that"_$S(+$G(CMOP(DA))=1:" has been released by",1:" is being transmitted to")_" the CMOP","","!!")
 .D EN^DDIOL(" ","","!!")
 K CMOP
 ;
 N PSOL,PSR
 S PSR=0 F  S PSR=$O(^PSRX(DA(1),1,PSR)) Q:'PSR  S PSOL=PSR
 I DA=PSOL,$P(^PSRX(DA(1),1,DA,0),"^",18) D  Q
 .D EN^DDIOL("Refill Released! Use the 'Return to Stock' option!","","$C(7),!!"),EN^DDIOL(" ","","!")
 ;
 ;Only allow deletion if last refill      *259
 I $O(^PSRX(DA(1),1,DA)) D  Q
 .D EN^DDIOL("Only the last refill can be deleted.  Later refills must be deleted first.","","$C(7),!!")
 .D EN^DDIOL("","","!!")
 ;
 ;Warn of In Process, Only delete if answered Yes         ;*259
 I $$REFIP^PSOUTLA1(DA(1),DA,"R") D  I 'Y Q               ;reset $T
 . D EN^DDIOL("** Refill has previously been sent to the External Dispense Machine","","!!,?2")
 . D EN^DDIOL("** for filling and is still Pending Processing","","$C(7),!,?2")
 . D EN^DDIOL("","","!")
 . K DIR
 . S DIR("A")="Do you want to continue? "
 . S DIR("B")="Y"
 . S DIR(0)="YA^^"
 . S DIR("?")="Enter Y for Yes or N for No."
 . D ^DIR
 . K DIR
 Q
 ;
WARN1 ;move to PSOUTLA1
 D WARN1^PSOUTLA1
 Q
 ;
CAN(PSOXRX) ;Clean up Rx when discontinued
 N SUSD,IFN,RF,NODE,DA
 Q:'$D(^PSRX(PSOXRX,0))
 S DA=$O(^PS(52.5,"B",PSOXRX,0)) I DA S DIK="^PS(52.5,",SUSD=$P($G(^PS(52.5,DA,0)),"^",2) D ^DIK K DIK I $O(^PSRX(PSOXRX,1,0)) S DA=PSOXRX D REF^PSOCAN2
 I $D(^PS(52.4,PSOXRX,0)) S DIK="^PS(52.4,",DA=PSOXRX D ^DIK K DIK
 I $G(^PSRX(PSOXRX,"H"))]"" K:$P(^PSRX(PSOXRX,"H"),"^") ^PSRX("AH",$P(^PSRX(PSOXRX,"H"),"^"),PSOXRX) S ^PSRX(PSOXRX,"H")=""
 I '$P($G(^PSRX(PSOXRX,2)),"^",2) K DIE S DIE="^PSRX(",DA=PSOXRX,DR="22///"_DT D ^DIE
 Q
ECAN(PSOXRX) ;Clean up Rx when expired
 N DA
 Q:'$D(^PSRX(PSOXRX,0))
 S DA=$O(^PS(52.5,"B",PSOXRX,0)) I DA K DIK S DIK="^PS(52.5," D ^DIK K DIK
 I $D(^PS(52.4,PSOXRX,0)) K DIK S DIK="^PS(52.4,",DA=PSOXRX D ^DIK K DIK
 I $G(^PSRX(PSOXRX,"H"))]"" K:$P(^PSRX(PSOXRX,"H"),"^") ^PSRX("AH",$P(^PSRX(PSOXRX,"H"),"^"),PSOXRX) S ^PSRX(PSOXRX,"H")=""
 I '$P($G(^PSRX(PSOXRX,2)),"^",2) K DIE S DIE="^PSRX(",DA=PSOXRX,DR="22///"_DT D ^DIE
 Q
CMOP ;CMOP("L")=LAST FILL... if it is orig Rx =0
 ;CMOP(FILL #)=CMOP status from 52[TRAN=0,DISP=1,RETRAN=2,NOT DISP=3
 ;If suspended CMOP("S")=CMOP suspense status Q,L,X,P,R
 ;All returned variables can be killed by K CMOP
 ;
 S CRX=DA
CMOP1 N X
 S (CMOP("L"),X)=0  F  S X=$O(^PSRX(CRX,1,X)) Q:'X  S CMOP("L")=X
 I $O(^PSRX(CRX,4,0)) F X=0:0 S X=$O(^PSRX(CRX,4,X)) Q:'X  D
 .S CMOP($P($G(^PSRX(CRX,4,X,0)),"^",3))=$P($G(^(0)),"^",4)
 S X=$O(^PS(52.5,"B",CRX,0)) I X]"" S CMOP("S")=$P($G(^PS(52.5,X,0)),"^",7)
 K CRX,X
 Q
 ;
CHKCMOP(RX,REA) ;Check if an RX is Transmitted/Retransmitted to CMOP and send alert mail
 ;
 ; Input:  RX - ien to file #52
 ;        REA - reason DC's "A" = admission, "D" = death
 ; Output: none
 ;
 N CMOP,PSOCMOP
 S REA=$G(REA)
 I $$TRANCMOP(RX),$G(PSOCMOP)]"" D MAILCMOP(RX,PSOCMOP,REA)
 Q
 ;
TRANCMOP(RX) ;check if a fill is Transmitted or Retransmitted
 ;
 ; Input:          = RX number
 ; Function output:= RX number if CMOP status is Trans or Retrans
 ;                 = 0 if neither
 ; Global parm out:= PSOCMOP = string from call to ^PSOCMOPA
 ;
 N DA,PSOTRANS
 S DA=RX D ^PSOCMOPA
 S PSOTRANS=$P($G(PSOCMOP),"^")
 Q:PSOTRANS=0!(PSOTRANS=2) RX
 Q 0
 ;
MAILCMOP(RX,STR,REA) ;Send mail message to mail group PSX EXTERNAL DISPENSE ALERTS
 ;
 ; Input:  RX  = ien of PSRX
 ;         STR = CMOP STATUS # ^ TRANSMIT DATE (FM) ^ LAST FILL #
 ;         REA = reason DC'd  "A" = admission, "D" = death
 ; Output: none
 ;
 N CMDT,CMST,DFN,VADM,PSOTEXT,PSOIEN,PSOKEYN,XMY,XMDUZ,XMSUB,XMTEXT
 N DIV,SSN,RXO,FILL,DRUG,DIVN,MAILGRP,NAME,PRV,RXSTS
 S RXO=$$GET1^DIQ(52,RX,.01)
 S CMDT=$P(STR,U,2)
 S CMDT=$E(CMDT,4,5)_"/"_$E(CMDT,6,7)_"/"_$E(CMDT,2,3)
 S FILL=$P(STR,U,3)
 S CMST=$P(STR,U),CMST=$S(CMST=2:"RETRANSMITTED",1:"TRANSMITTED")
 S DIV=$P(^PSRX(RX,2),"^",9),DIVN=$P($G(^PS(59,DIV,0)),"^")
 S MAILGRP="PSX EXTERNAL DISPENSE ALERTS"
 S XMY("G."_MAILGRP)=""
 ;if no members & no member groups & no remote members, then send to
 ; the default: PSXCMOPMGR key holders
 S PSOIEN=$O(^XMB(3.8,"B",MAILGRP,0))
 I '$O(^XMB(3.8,PSOIEN,1,0))&'$O(^XMB(3.8,PSOIEN,5,0))&'$O(^XMB(3.8,PSOIEN,6,0)) D
 . S PSOKEYN=0
 . F  S PSOKEYN=$O(^XUSEC("PSXCMOPMGR",PSOKEYN)) Q:'PSOKEYN  D
 . . S XMY(PSOKEYN)=""
 S DFN=$$GET1^DIQ(52,RX,2,"I") D DEM^VADPT
 S NAME=VADM(1)
 S SSN=$P($P(VADM(2),"^",2),"-",3)
 S RXSTS=$$GET1^DIQ(52,RX,100)
 S DRUG=$$GET1^DIQ(52,RX,6)
 S PRV=$$GET1^DIQ(52,RX,4)
 S XMDUZ=.5
 S XMSUB=DIVN_" - DC Alert on CMOP Rx "_RXO_" "_CMST
 S PSOTEXT(1)="             Rx #: "_RXO_"   Fill: "_FILL
 S PSOTEXT(2)="          Patient: "_NAME_" ("_SSN_")"
 S PSOTEXT(3)="             Drug: "_DRUG
 S PSOTEXT(4)="        Rx Status: "_RXSTS
 S:REA="A" PSOTEXT(4)=PSOTEXT(4)_" (due to Admission)"
 S:REA="D" PSOTEXT(4)=PSOTEXT(4)_" (due to Date of Death)"
 S PSOTEXT(5)="Processing Status: "_CMST_" to CMOP on "_CMDT
 S PSOTEXT(6)="         Provider: "_PRV
 S PSOTEXT(7)=""
 S PSOTEXT(8)="********    Please contact CMOP or take appropriate action    ********"
 S XMTEXT="PSOTEXT(" D ^XMD
 D KVA^VADPT
 Q
 ;
PSOCK ;
 W !!!,"*The following list of order checks is a comprehensive report of all"
 W !,"Outpatient, Non-VA, and Clinic medication orders on this patient's profile."
 W !,"It may include orders that are local, remote, active, pending, recently"
 W !,"discontinued, or expired. Please note that the sort order and format"
 W !,"displayed in this report differs from the display of MOCHA 1.0 order"
 W !,"checks which occurs during order processing.*",!
 Q
 ;
PSSDGCK ;
 D ^PSSDIUTL
 Q
 ;
PSOSUPCK(CHK) ;
 I '($P($G(^PSDRUG(CHK,0)),"^",3)["S"!($E($P($G(^PSDRUG(CHK,0)),"^",2),1,2)="XA")) K CHK Q 0
 W !!,"You have selected a supply item, please select another drug"
 W !,"or leave blank and hit enter for Profile Order Checks." W !
 K CHK
 Q 1
 ;
PRFLP ;ZB POST+18^PSODRG THE RUN D LOOP^ZZME3
 N PSODRUG S (DGCKSTA,DGCKDNM)="" S PSODGCKF=1
 I $D(PSOSD) F  S DGCKSTA=$O(PSOSD(DGCKSTA)) Q:DGCKSTA=""  F  S DGCKDNM=$O(PSOSD(DGCKSTA,DGCKDNM)) Q:DGCKDNM=""  D
 .S DIC=50,DIC(0)="MQZV",X=DGCKDNM D ^DIC K DIC
 .S DIC=50,DIC(0)="MQZV",X=+Y D ^DIC K DIC Q:Y=-1
 .S PSODRUG("IEN")=DGCKDNM,PSODRUG("VA CLASS")=$P(Y(0),"^",2),PSODRUG("NAME")=$P(Y(0),"^")
 .S:+$G(^PSDRUG(+Y,2)) PSODRUG("OI")=+$G(^(2)),PSODRUG("OIN")=$P(^PS(50.7,+$G(^(2)),0),"^")
 .S PSODRUG("NDF")=$S($G(^PSDRUG(DGCKDNM,"ND"))]"":+^("ND")_"A"_$P(^("ND"),"^",3),1:0)
 .S PSODFN=DFN D ^PSODGAL1
 .K X,Y,DTOUT,DUOUT
 K DGCKSTA,DGCKDNM,PSODGCKF,X,Y,DTOUT,DUOUT
 Q
