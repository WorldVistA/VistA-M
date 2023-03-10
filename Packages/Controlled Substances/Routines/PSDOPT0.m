PSDOPT0 ;BIR/JPW,LTL,BJW - Outpatient Rx Entry (cont'd) ;Jun 22, 1998@12:15
 ;;3.0;CONTROLLED SUBSTANCES ;**10,30,37,39,45,48,66,79,90**;13 Feb 97;Build 4
 ;Reference to PS(52.5 supported by DBIA #786
 ;Reference to PS(59.7 supported by DBIA #1930
 ;References to ^PSD(58.8 are covered by DBIA #2711
 ;References to file 58.81 are covered by DBIA #2808
 ;Reference to ^PSDRUG( supported by DBIA #221
 ;Reference to PSRX( supported by DBIA #986
 ;called by ^PSDOPT,mod.for nois#:tua-0498-32173
 ;08/02/2004 KAM PSD*3*45 Modification to stop posting of the same 
 ;                        partial multiple times
LOOP ;loop to find new, refills and partials
 W !!,"Accessing the prescription history..."
 N PSDOIN,PSDRXFD,PSDSUPN,PSDLBL S PSDOIN=+$P($G(^PS(59.7,1,49.99)),U,2)
 ;check for unposted refills not returned to stock and not in suspense
 S (RF,DAT)=0 F JJ=0:0 S JJ=$O(^PSRX(PSDRX,1,JJ)) Q:'JJ  I $D(^PSRX(PSDRX,1,JJ,0)),'$P(^(0),U,16),$P($G(^(0)),U)'<PSDOIN D
 .;checking for suspense
 .S PSDRXFD=$E($P(^PSRX(PSDRX,1,JJ,0),U),1,7)
 .S PSDSUPN=$O(^PS(52.5,"B",PSDRX,0))
 .I PSDSUPN,$D(^PS(52.5,"C",PSDRXFD,PSDSUPN)),$G(^PS(52.5,PSDSUPN,"P"))'=1 W !!,"Refill #",JJ," suspended." Q
 .S RXNUM("RF",JJ)=+^PSRX(PSDRX,1,JJ,0)_U_$P(^(0),U,4),$P(PSDSEL("RF",JJ),"^",1)=$P(RXNUM("RF",JJ),"^",1),$P(PSDSEL("RF",JJ),"^",2)=$P(RXNUM("RF",JJ),"^",2),$P(PSDSEL("RF",JJ),"^",3)=$P($G(PSDRX("RF",JJ)),"^",3) K PSDLBLP
 ;
 ;check for unposted partials not returned to stock or suspended
 ;
 S PRF=0 F JJ=0:0 S JJ=$O(^PSRX(PSDRX,"P",JJ)) Q:'JJ  I $D(^PSRX(PSDRX,"P",JJ,0)),'$P(^(0),U,16),$P($G(^(0)),U)'<PSDOIN D
 .;check for suspense
 .S PSDRXFD=$E($P(^PSRX(PSDRX,"P",JJ,0),U),1,7)
 .S PSDSUPN=$O(^PS(52.5,"B",PSDRX,0))
 .I PSDSUPN,$D(^PS(52.5,"C",PSDRXFD,PSDSUPN)),$G(^PS(52.5,PSDSUPN,"P"))'=1,($G(JJ)=$P(^PS(52.5,PSDSUPN,0),U,5)) W !!,"Partial #",JJ," suspended." Q
 .S RXNUM("PR",JJ)=+^PSRX(PSDRX,"P",JJ,0)_U_$P(^(0),U,4),$P(PSDSEL("PR",JJ),"^",1)=$P(RXNUM("PR",JJ),"^",1),$P(PSDSEL("PR",JJ),"^",2)=$P(RXNUM("PR",JJ),"^",2) K PSDLBL
 ;
 ;original returned to stock
 S:$P($G(^PSRX(+PSDRX,2)),U,15) PSDRX(1)=""
 ;Check for suspense
 I +$P($G(^PSRX(PSDRX,2)),U,2)'<PSDOIN S PSDRXFD=$P(^(2),U,2) D
 .S PSDSUPN=$O(^PS(52.5,"B",PSDRX,0))
 .I PSDSUPN,$D(^PS(52.5,"C",PSDRXFD,PSDSUPN)),$G(^PS(52.5,PSDSUPN,"P"))'=1 W !!,"Original suspended." S PSDRX(1)="" Q
PSDDAVE ;PSD*3*30 (Major overhaul, Dave B)
 ;PSDSEL("RF",#)=refill Date ^ QTY ^ posted (y/n) ^ released date
 ;PSDSEL("PR"  ''
 ;PSDSEL("OR"  same thing
 ;
 I '$D(PSDRX(1)) S $P(PSDSEL("OR"),"^",2)=$P(^PSRX(+PSDRX,0),"^",7) ;Quantity
 S $P(PSDSEL("OR"),"^",3)=$P($G(PSDRX("OR",0)),"^",3) ;Posted
 I $P($G(^PSRX(+PSDRX,2)),"^",13)'="" S Y=$P(^PSRX(+PSDRX,2),"^",13) X ^DD("DD") S $P(PSDSEL("OR"),"^",4)=Y ;released date
 I $D(PSDSEL("OR")),$P(PSDSEL("OR"),"^",3)'="",$P(PSDSEL("OR"),"^",4)'="",'$$PSDREPR(+PSDRX)  K PSDSEL("OR"),RXNUM("OR")
 S (PSDRF1,PSDPR1)=0
RFLCHK ;
 S PSDRF1=$O(PSDSEL("RF",PSDRF1)) G PRTLCHK:PSDRF1'>0 S DATA=PSDSEL("RF",PSDRF1)
 I $P($G(^PSRX(+PSDRX,1,PSDRF1,0)),"^",18)'="" S Y=$P(^(0),"^",18) X ^DD("DD") S $P(PSDSEL("RF",PSDRF1),"^",4)=Y ;Already released
 I $P(PSDSEL("RF",PSDRF1),"^",3)>0,$P(PSDSEL("RF",PSDRF1),"^",4)'="" K PSDSEL("RF",PSDRF1),RXNUM("RF",PSDRF1)
 G RFLCHK
 ;
PRTLCHK S PSDPR1=$O(PSDSEL("PR",PSDPR1)) G CHKALL:PSDPR1'>0
 ; 08/02/2004 PSD*3*45 Added next line
 I $D(PSDRX("PR",PSDPR1)) S $P(PSDSEL("PR",PSDPR1),"^",3)=1 ;Posted 
 I $P($G(^PSRX(+PSDRX,"P",PSDPR1,0)),"^",19)'="" S Y=$P(^(0),"^",19) X ^DD("DD") S $P(PSDSEL("PR",PSDPR1),"^",4)=Y
 I $P(PSDSEL("PR",PSDPR1),"^",3)>0,$P(PSDSEL("PR",PSDPR1),"^",4)'="" K PSDSEL("PR",PSDPR1),RXNUM("PR",PSDPR1)
 G PRTLCHK
 ;
CHKALL ;Check to see if any left to post or release
 I $G(PSDERR)=1 G ASKP^PSDOPT
 I $O(PSDSEL(0))="" W !!,"ALL FILLS FOR THIS PRESCRIPTION HAVE BEEN POSTED AND RELEASED." G ASKP^PSDOPT
 ;
 ;Check for DIR call
 S CNT=0 K DIR
 G CHK^PSDOPT
 ;
PSDREPR(PSDRXIN) ;p90 return 1 (true) if type RETURNED TO STOCK
 N PSDREC,PREVTYPE K PSDTT("OR"),PSDTT("RS")
 S PSDTT("OR")=$O(^PSD(58.84,"B","OUTPATIENT RX",0)),PSDTT("RS")=$O(^PSD(58.84,"B","RETURNED TO STOCK",0))
 S PSDREC=0
 ; Cycle through accountability trans records to obtain if last trans type was OUTPATIENT RX or RETURNED TO STOCK
 F  S PSDREC=$O(^PSD(58.81,"AOP",PSDRXIN,PSDREC)) Q:PSDREC=""  D
 . S:$P($G(^PSD(58.81,PSDREC,0)),"^",2)=PSDTT("OR") PREVTYPE=$P($G(^PSD(58.81,PSDREC,0)),"^",2)
 . S:$P($G(^PSD(58.81,PSDREC,0)),"^",2)=PSDTT("RS") PREVTYPE=$P($G(^PSD(58.81,PSDREC,0)),"^",2)
 I $G(PREVTYPE)=PSDTT("RS") Q 1 ; return true if last type is RTS
 Q 0
PSDRTS(PSDRX,PSDNUM,PSDSITE,PSDQTY) ; API for Outpatient Pharmacy; Patch PSD*3*30
 ; This subroutine is called each time an Rx is returned to stock
 ; in Outpatient Pharmacy. The code does the following:
 ; 1.Check Rx, quit if not a controlled substance.
 ; 2.Give the user the option to update the transaction and
 ;   balance details
 ;PSDCS = 1 is controlled subs/0 for not CS
 ;PSDRS = 1 they have key, ok to return to stock, 0 - no key
 ;Variables:
 ;PSDRX   = Prescription Number IEN
 ;PSDNUM  = O^0 = The letter O for original fill and the number0
 ;          R^# = The letter R for refill and # equal to refill #
 ;          P^# = The letter P for partial and # equal to partial #
 ;PSDSITE = Division
 ;PSDQTY  = Quantity being returned to stock
 ;
 ;PSD*3*30 Check for PSDMGR key
 S PSDRS=0 I $D(^XUSEC("PSDMGR",DUZ)) S PSDRS=1 ;possess key
1 ;begin process
 I $D(^PSD(58.81,"AOP",PSDRX)) D RTSCHK G RETERR:$G(PSDERR)>0
 S PSDOUT=0,RXNUM=$P($G(^PSRX(+PSDRX,0)),"^") ;Prescription Number
 S (RPDT,DAT)=$P($G(^PSRX(+PSDRX,2)),"^",2)
 S DFN=+$P($G(^PSRX(+PSDRX,0)),"^",2)
 S PSDS=$S($G(PSDSITE)["^":$P(PSDSITE,"^",3),1:PSDSITE)
 S PSDR=$P($G(^PSRX(+PSDRX,0)),"^",6) I $G(PSDR)'="" S PSDRN=$P($G(^PSDRUG(PSDR,0)),"^")
 ;Setup like balance adjustment
 S PSDRN=$S($G(PSDRN)="":"Unknown Drug "_PSDR,1:PSDRN)
 I $P($G(^PSDRUG(PSDR,2)),"^",3)'["N" S PSDCS=0 Q
 S PSDCS=1
 I $G(PSDRS)'>0 W !,"Sorry you do not possess the PSDMGR key" G RETERR
 ;
POSTED ;check to see if posted
 S (JJ,PSDPOST)=0
 F  S JJ=$O(^PSD(58.81,"AOP",+PSDRX,JJ)) Q:'JJ  I $D(^PSD(58.81,JJ,6)) D
 .S NODE6=$G(^PSD(58.81,JJ,6))
 .I $P(PSDNUM,"^",1)="R",$P(NODE6,"^",2)'="",$P(NODE6,"^",2)=$P(PSDNUM,"^",2) S PSDPOST=1 Q
 .I $P(PSDNUM,"^",1)="P",$P(NODE6,"^",4)'="",$P(NODE6,"^",4)=$P(PSDNUM,"^",2) S PSDPOST=1 Q
 .I $P(PSDNUM,"^",1)="O",$P(NODE6,"^",4)="",$P(NODE6,"^",2)="" S PSDPOST=1 Q
 ;
 ;now check to see if CMOP
 S X1=0 F  S X1=$O(^PSRX(+PSDRX,4,X1)) Q:X1=""  S DATA=$G(^PSRX(+PSDRX,4,X1,0)) D
 .I $P(PSDNUM,"^",1)="R",$P(DATA,"^",3)=$P(PSDNUM,"^",2) S PSDPOST=1 Q
 .I $P(PSDNUM,"^",1)="P",$P(DATA,"^",3)=$P(PSDNUM,"^",2) S PSDPOST=1 Q
 .I $P(PSDNUM,"^",1)="O",$P(DATA,"^",3)=$P(PSDNUM,"^",2) S PSDPOST=1 Q
 I $G(PSDPOST)'=1 W !!,"Could not find any posting information in the Controlled Substance package,",!,"balance cannot be updated",!
 ;
ESIG K X D SIG^XUSESIG I X["^" W !,"No signature code entered, RX not returned to stock." S RETSK=1 Q
 I X1="" W !,"An Electronic Signature Code is required to return a Controlled Substance RX to stock.",! G ESIG
ASK S DIR(0)="Y",DIR("A")="Do you want "_$G(PSDQTY)_" added to balance in the Narcotic vault",DIR("B")="Yes",DIR("?")="Answer Yes and the amount being returned to stock will be placed in inventory" D ^DIR K DIR I $D(DIRUT) S RETSK=1 G RETERR
 I Y=0 S PSDRET=0 D  G RETERR
 .I '$D(PSDEL) S PSDMSG="RX RETURNED 0 TO STOCK("_PSDQTY_" TO BE DESTROYED)"
 .D NOW^%DTC S PSDS=$$PSDS(PSDRX,PSDNUM),PSDT=+%,PSDQTY=0
 .I PSDS,$D(^PSD(58.8,+PSDS,1,PSDR,0)) S BAL=+$P(^PSD(58.8,+PSDS,1,PSDR,0),"^",4) D FND1 Q
 .W !,"Nothing updated" G RETERR
 S:Y'=0 PSDMSG="RX RETURNED TO STOCK"
LOCATION S DIC(0)="QEA",DIC="^PSD(58.8,",DIC("A")="Return Drug to which vault: "
 S DIC("S")="I ""MSN""[$P($G(^PSD(58.8,Y,0)),U,2)" D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT)) W !,"No selection made, no balance adjusted." W !!?5,"Prescription Not Returned to Stock!",$C(7),! S RETSK=1 G RETERR
 I X="" W !,"The Vault is required. Please, select a valid Vault or '^' to exit.",$C(7),! G LOCATION
 I "MSN"'[$P($G(^PSD(58.8,+Y,0)),"^",2) W !,"Sorry, the location type must be a Master Vault, satellite or narcotic location." K Y G LOCATION
 S PSDS=+Y I '$D(^PSD(58.8,+PSDS,1,PSDR,0)) W !,"Sorry, the drug is not stocked in this vault." K PSDS G LOCATION
 S PSDBAL=$P($G(^PSD(58.8,+PSDS,1,PSDR,0)),"^",4) W !,"Previous Balance: ",$G(PSDBAL)_"    New Balance: "_($G(PSDBAL)+PSDQTY)
 ;
 W !,"Updating balances"
 F  L +^PSD(58.8,+PSDS,1,PSDR,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D NOW^%DTC S PSDT=+%,BAL=+$P(^PSD(58.8,+PSDS,1,PSDR,0),"^",4)
 S $P(^PSD(58.8,+PSDS,1,PSDR,0),"^",4)=$P(^PSD(58.8,+PSDS,1,PSDR,0),"^",4)+PSDQTY
 L -^PSD(58.8,+PSDS,1,PSDR,0) W "."
 ;
FND1 F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND1 S PSDA=$P(^PSD(58.81,0),"^",3)+1 I $D(^PSD(58.81,PSDA)) S $P(^PSD(58.81,0),"^",3)=PSDA G FIND1
 K DA,DIC,DLAYGO S (DIC,DLAYGO)=58.81,DIC(0)="L",(X,DINUM)=PSDA D ^DIC K DIC,DLAYGO
 L -^PSD(58.81,0)
 S PSDNUM1=$P($G(PSDNUM),"^",2)
 S ^PSD(58.81,PSDA,0)=PSDA_"^3^"_+PSDS_"^"_PSDT_"^"_PSDR_"^"_PSDQTY_"^"_DUZ_"^^^"_BAL
 S ^PSD(58.81,PSDA,3)=PSDT_"^"_PSDQTY_"^"_$G(PSDMSG)
 S ^PSD(58.81,PSDA,"CS")=1
 S ^PSD(58.81,PSDA,6)=PSDRX_"^"_$S($P(PSDNUM,"^")="R":PSDNUM1,1:"")_"^"_DAT_"^"_$S($P(PSDNUM,"^")="P":PSDNUM1,1:"")_"^"_RXNUM
 S DIK="^PSD(58.81,",DA=PSDA D IX^DIK K DA,DIC,DIK
DIE I '$D(^PSD(58.8,+PSDS,1,PSDR,4,0)) S ^(0)="^58.800119PA^^"
 K DA,DIC,DD,DO S DA(1)=PSDR,DA(2)=+PSDS,(X,DINUM)=PSDA,DIC(0)="L",DIC="^PSD(58.8,"_+PSDS_",1,"_PSDR_",4," D FILE^DICN K DIC,DINUM
 ;monthly activity
 I '$D(^PSD(58.8,+PSDS,1,PSDR,5,0)) S ^(0)="^58.801A^^"
 I '$D(^PSD(58.8,+PSDS,1,PSDR,5,$E(DT,1,5)*100,0)) K DA,DIC S DIC="^PSD(58.8,"_+PSDS_",1,"_PSDR_",5,",DIC(0)="LM",DLAYGO=58.8,(X,DINUM)=$E(DT,1,5)*100,DA(2)=+PSDS,DA(1)=PSDR D ^DIC K DA,DIC,DINUM,DLAYGO
 K DA,DIE,DR S DIE="^PSD(58.8,"_+PSDS_",1,"_PSDR_",5,",DA(2)=+PSDS,DA(1)=PSDR,DA=$E(DT,1,5)*100,DR="9////^S X=$P($G(^(0)),""^"",6)+PSDQTY" D ^DIE K DA,DIE,DR,PSDRET
RETERR Q
RTSCHK ;Check to see if already returned to stock.
 D RTSMUL
 S PSD1=0
 S:$D(PSDXXX) PSD1=PSDXXX-.1
 K PSD1MUL,PSDMUL,PSDXXX
 S PSDERR=0
 F  S PSD1=$O(^PSD(58.81,"AOP",PSDRX,PSD1)) Q:PSD1'>0  S DATA=$G(^PSD(58.81,PSD1,0)),DATA6=$G(^PSD(58.81,PSD1,6)) D
 .S PSDFLL=$P(PSDNUM,"^",2)
 .I PSDFLL>0,$D(^PSD(58.81,PSD1,6)),$P(^PSD(58.81,PSD1,6),"^",2)=PSDFLL,$D(^PSD(58.81,PSD1,3)) D ERRMSG
 .I $D(^PSD(58.81,PSD1,3)),PSDFLL=0,'$D(^PSD(58.81,PSD1,6)) D ERRMSG
 Q
ERRMSG S Y=$P(^PSD(58.81,PSD1,3),"^") X ^DD("DD") S PSDRTS(1)=Y,PSDUSER=$P(^PSD(58.81,PSD1,0),"^",7),PSDUSER=$P(^VA(200,PSDUSER,0),"^")
 W !!?8,"According to the Controlled Substances package, this fill/refill",!?8,"was returned to stock on "_PSDRTS(1)_" by "_$G(PSDUSER)_".",!?16,"Nothing updated in the Controlled Substances package."
 S PSDERR=1 Q
RTSMUL D RTSMUL^PSDOPT1
 Q
PSDS(RXIEN,FLNUM) ; Returns the Vault where the fill was last dispensed from or 0 (none)
 ;RXIEN = Prescription Number IEN
 ;FLNUM = Fill Number:
 ;         O^0 = The letter O for original fill and the number 0
 ;         R^# = The letter R for refill and # equal to refill #
 ;         P^# = The letter P for partial and # equal to partial #
 ;
 N PSDS,TRX,NODE0,NODE6 S PSDS=0
 S TRX=99999999 F  S TRX=$O(^PSD(58.81,"AOP",RXIEN,TRX),-1) Q:'TRX  D  I PSDS Q
 . I $$GET1^DIQ(58.81,TRX,1)="RETURNED TO STOCK" Q   ; Not an Outpatient Pharmacy Transaction
 . I $$GET1^DIQ(58.81,TRX,34,"I") Q   ; Returned To Stock Transaction
 . S NODE0=$G(^PSD(58.81,TRX,0)),NODE6=$G(^PSD(58.81,TRX,6))
 . I $P(FLNUM,"^")="O",'$P(NODE6,"^",2) S PSDS=+$P(NODE0,"^",3) Q
 . I $P(FLNUM,"^")="R",$P(NODE6,"^",2)=$P(FLNUM,"^",2) S PSDS=$P(NODE0,"^",3) Q
 . I $P(FLNUM,"^")="P",$P(NODE6,"^",4)=$P(FLNUM,"^",2) S PSDS=$P(NODE0,"^",3) Q
 Q PSDS
