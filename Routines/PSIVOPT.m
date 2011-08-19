PSIVOPT ;BIR/PR,MLM-OPTION DRIVER ;06 Aug 98 / 2:17 PM
 ;;5.0; INPATIENT MEDICATIONS ;**17,27,58,88,104,110,155,181**;16 DEC 97;Build 190
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191
 ; Reference to ^PSDRUG is supported by DBIA# 2192        
 ; Reference to ^PS(52.6 is supported by DBIA# 1231
 ; Reference to ^PS(52.7 is supported by DBIA# 2173
 ;
 NEW PSIVLOCK S PSIVLOCK=0
 ;I ON["P" L +^PS(53.1,+ON):1 S:'$T PSIVLOCK=1
 I ON["V" L +^PS(55,DFN,"IV",+ON55):1 S:'$T PSIVLOCK=1
 I PSIVLOCK W !,$C(7),$C(7),"This order is being edited by another user. Try later." G K
 ;W ! L +^PS(55,DFN,"IV",+ON55):1 I '$T W !,$C(7),$C(7),"This order is being edited by another user. Try later." G K
 I PSIVAC="O"!(PSIVAC="H") S PSIVAC=PSIVAC_"(DFN,ON,P(17),P(3))"
 S TEX="Active order ***" I $D(UWLFLAG),UWLFLAG="1.001" S XED=0 D @PSIVAC G K
 S DONE=0 F  D ACT Q:DONE
 ;
UNLOCK ; Unlock order.
 ;I ON["P" L -^PS(53.1,+ON)
 ;E  L -^PS(55,DFN,"IV",+ON55)
 I ON["V" L -^PS(55,DFN,"IV",+ON55)
 ;
K ; Kill variables.
 K %,DA,DIE,DIK,DLAYGO,DNE,DR,DRG,DRGI,DRGT,ERR,HELP,J,OD,P,P16,PSIVAL,PSIVC,PSIVLOG,PSIVNOL,PSIVOK,PSIVOPT,PSIVREA,SCRNPRO,TEX,XED
 Q
ACT ; Prompt for order action.
 K PSJIVBD NEW PSGFDX,PSGSDX S (PSJORD,ON)=ON55
 S PSJCOM=$S(ON["V":$P($G(^PS(55,DFN,"IV",+ON,.2)),"^",8),1:$P($G(^PS(53.1,+ON,.2)),"^",8))
 D:ON["V" EN^PSJLIORD(DFN,ON)
 I ON["P",($P($G(^PS(53.1,+ON,0)),U,9)="N"),'PSJCOM D GT531^PSIVORFA(DFN,ON),VF^PSIVORC2 S DONE=1 Q
 I ON["P",PSJCOM Q:'$$LOCK^PSJOEA(DFN,PSJCOM)  N PSJO,ON,PSJORD S PSJO=0 F  S PSJO=$O(^PS(53.1,"ACX",PSJCOM,PSJO)) Q:'PSJO  Q:$G(Y)="Q"  S (PSJORD,ON)=PSJO_"P" D
 .D:($P($G(^PS(53.1,+ON,0)),U,9)="N") GT531^PSIVORFA(DFN,ON),VF^PSIVORC2
 .D:($P($G(^PS(53.1,+ON,0)),U,9)="P") EN^PSJLIFN
 I $G(PSJCOM) N PSJORD S PSJORD=PSJCOM D CHK^PSJOEA1
 I ON'["V",'+$G(PSJCOM) D EN^PSJLIFN
 S DONE=1
 Q
 ;
CK ; Check if drugs are still valid.
 F DRGT="AD","SOL" S FIL=$S(DRGT="AD":52.6,1:52.7) F DRGI=0:0 S DRGI=$O(DRG(DRGT,DRGI)) Q:'DRGI  D
 .S DRG=+$P(DRG(DRGT,DRGI),U),X=$G(^PS(FIL,DRG,"I")) I $S('X:0,DT<X:0,1:1)!$S('$G(^PSDRUG(+$P($G(^PS(FIL,DRG,0)),U,2),"I")):0,^("I")>DT:0,1:1) S ERR=1
 Q
 ;
D ; Discontinue order.
 D D^PSIVOPT2
 Q
 ;
O(DFN,ON,STAT,STOP) ; On/Off Call
 D NOW^%DTC I STAT="H",STOP<% D EXPIR Q
 I "OA"'[STAT W !,$C(7),"Only active orders may be placed on hold." Q
 S PSIVALT=1,PSIVREA=$S(STAT'="O":"O",1:"C"),(P(17),STAT)=$S(PSIVREA="O":"O",1:"A") W:PSIVREA="C" ?$X+4,$C(7),TEX
 D UPSTAT,LOG^PSIVORAL D:STAT="A" CKO^PSIVCHK
 Q
 ;
E ; Entry for Pharmacy edit
 N PSJEDIT1 D E^PSIVOPT1
 Q
 ;
R ; Renew order.
 D R^PSIVOPT2
 Q
 ;
H(DFN,ON,STAT,STOP)          ; Place order on hold.
 D NOW^%DTC I STAT="H" I STOP<% D EXPIR Q
 I "HA"'[STAT W !,$C(7),"Only active orders may be placed on hold." Q
 D NATURE^PSIVOREN I '$D(P("NAT")) W !!,"Order unchanged." Q
 S PSIVALT=1,PSIVREA=$S(STAT'="H":"H",1:"U"),(P(17),STAT)=$S(PSIVREA="H":"H",1:"A") W:PSIVREA="U" ?$X+4,$C(7),TEX
 D UPSTAT,LOG^PSIVORAL,HOLD^PSIVOE,ENLBL^PSIVOPT(2,DUZ,DFN,3,+ON55,$S(PSIVREA="H":"H1",1:"H0")) D:STAT="A" CKO^PSIVCHK
 Q
 ;
S ; View order.
 D @$S(ON55["V":"GT55^PSIVORFB",1:"GT531^PSIVORFA("_DFN_","""_ON55_""")") W @IOF D EN^PSIVORV2
 Q
 ;
EXPIR ; Update status of expired orders.
 I STAT="H" S PSIVREA="H",P(17)="E"
 S STAT="E" D UPSTAT,EXPIR^PSIVOE W $C(7),"  This order has expired."
 Q
 ;
UPSTAT ; Update orders status.
 N DA,DR,DIE,PSIVACT S PSIVACT=1,DA=+ON55,DA(1)=DFN,DIE="^PS(55,"_DFN_",""IV"",",DR="100///"_P(17)_$S($G(PSIVREA)="H":";149///1",$G(PSIVREA)="U":";149///@",1:"") D ^DIE
 Q
 ;
ENIN ; Entry for inpatient order entry/profile options.
 N DFN,ON,P,PSIVAC S PSIVAC="C" I PSJORD["P" S (P("PON"),ON)=+PSJORD_"P",DFN=PSGP D SHOW1^PSIVORC Q
 S (P("PON"),ON,ON55)=+PSJORD_"V",DFN=PSGP D GT55^PSIVORFB,EN^PSIVORV2,PSIVOPT:'$D(PSJPRF)
 L -^PS(55,DFN,"IV",+PSJORD)
 Q
 ;
ENARI(DFN,ON,PSGUOW,PSIVAL) ; Auto-reinstate IV orders if movement is deleted.
 ;Create a list of recipients beyond normal mail group
 S PSGORNUM=$S($G(PSGORD):PSGORD,$G(PSJORD):PSJORD,$G(OR55):OR55,1:"")
 I $G(PSGORNUM) D
 .I $D(^PS(55,PSGP,"IV",+PSGORNUM,0)),$P(^PS(55,PSGP,"IV",+PSGORNUM,0),U,6)'="" S PSJSENTO($J,$P(^PS(55,PSGP,"IV",+PSGORNUM,0),U,6))="" ; Provider
 .I $D(^PS(55,PSGP,"IV",+PSGORNUM,2)),$P(^PS(55,PSGP,"IV",+PSGORNUM,2),U,11)'="" S PSJSENTO($J,$P(^PS(55,PSGP,"IV",+PSGORNUM,2),U,11))="" ; Entered by
 .I $D(^PS(55,PSGP,"IV",+PSGORNUM,4)),$P(^PS(55,PSGP,"IV",+PSGORNUM,4),U,1)'="" S PSJSENTO($J,$P(^PS(55,PSGP,"IV",+PSGORNUM,4),U,1))="" ; Verifying Nurse
 ; find pharmacist that finished the IV order
 N PSJX,ENTBY S PSJX=$G(^PS(55,PSGP,"IV",+ON,"A",1,0))
 I $P(PSJX,U,2)="F" S ENTBY=$$VA200($P(PSJX,U,3)) I ENTBY'="" S PSJSENTO($J,ENTBY)=""
 ;
 I $G(PSGALO)'=18530,$G(PSGORNUM),$$IVDUPADD^PSIVOPT(PSGP,+PSGORNUM) S ^TMP("PSJNOTUNDC",$J,PSGP,+PSGORNUM_"V")="" Q
 N DA,DR,DIE,DIK,PSIVREA,PSIVALCK,PSIVOPT,PSIVALT,X,Y
 S X=$G(^PS(55,DFN,"IV",+ON,"ADC")) I X K ^PS(55,"ADC",X,DFN,+ON),^PS(55,DFN,"IV",+ON,"ADC")
 ;S PSIVACT=1,DR=$S(+$P($G(^PS(55,DFN,"IV",+ON,4)),U,18)=1:"100///H",+$P($G(^PS(55,DFN,"IV",+ON,0)),U,10)=1:"100///H",1:"100///A")_";.03////"_+$P($G(^PS(55,DFN,"IV",+ON,2)),U,7)_";109///@;116///@;121///@;157////@"
 S PSIVACT=1,DR=$S(+$P($G(^PS(55,DFN,"IV",+ON,0)),U,10)=1:"100///H;157///HP",+$P($G(^PS(55,DFN,"IV",+ON,4)),U,18)=1:"100///H;157///@",1:"100///A;157///@")_";.03////"_+$P($G(^PS(55,DFN,"IV",+ON,2)),U,7)_";109///@;116///@;121///@"
 S DIE="^PS(55,"_DFN_",""IV"",",DA=+ON,DA(1)=DFN
 N CHKIT S CHKIT=$G(^PS(55,DFN,"IV",+ON,2)) I $P(CHKIT,U,6)["P",($P(CHKIT,U,9)="R") S DR=DR_";114///@;123///@"
 D ^DIE
 S ^TMP("PSJUNDC",$J,DFN,ON_"V")=""
 S ON55=ON,P(17)="A",PSIVREA=$S($D(PSJUNDC):"AI",1:"I"),PSIVALCK="STOP",(PSIVOPT,PSIVALT)=1,PSIVAL=$P($G(^PS(53.3,+PSIVAL,0)),U) D LOG^PSIVORAL
 ;* S Y=^PS(55,DFN,"IV",+ON,0),P(3)=+$P(Y,U,3),ORIFN=$P(Y,U,21),P(12)="" D:'$D(PSJIVORF) ORPARM^PSIVOREN I PSJIVORF D
 S Y=^PS(55,DFN,"IV",+ON,0),P(3)=+$P(Y,U,3),P(12)="" D:'$D(PSJIVORF) ORPARM^PSIVOREN I PSJIVORF D
 .D EN1^PSJHL2(DFN,"SC",+ON55_"V","AUTO REINSTATED")
 S PSGTOL=$S($D(PSJUNDC):3,1:2)
 Q:$S('$D(PSJUNDC):0,PSGALO=18540:1,1:'$P($G(PSJSYSW0),U,15))
 I $D(^PS(53.41,1,1,PSGUOW,1,DFN,1,3,1,+ON)) K DIK,DA S DIK="^PS(53.41,1,1,"_PSGUOW_",1,"_DFN_",1,3,1,",DA=+ON,DA(1)=1,DA(2)=PSGP,DA(3)=PSGUOW,DA(4)=3 D ^DIK
 E  K DA D ENLBL^PSIVOPT(PSGTOL,PSGUOW,DFN,3,+ON,"RE")
 Q
 ;
ENINP(DFN,ON) ; Entry from Inpatient Profile.
 N PSIVAC,ON55 S PSIVAC="PRO" D @($S(ON["V":"GT55^PSIVORFB",1:"GT531^PSIVORFA("_DFN_","""_ON_""")")),ENNH^PSIVORV2(ON)
 Q
ENLBL(PSGTOL,PSGUOW,PSGP,PSGTOO,DA,RES) ;
 ;Queue MAR labels for IV orders.
 Q:'$D(^DPT(PSGP,.1))  I '$D(PSJSYSW0) N PSJACPF,PSJACNWP S PSJACPF=11 D WP^PSJAC Q:'PSJSYSL
 N P,X,Y
 S X=$P(PSJSYSW0,U,2),Y=$P($G(^PS(55,PSGP,"IV",DA,0)),U,4)
 S Y=$S(Y="A":4,Y="H":5,Y="C":6,1:3) I X=1!(X[Y) D NOW^%DTC S PSGDT=% D ENL^PSGVDS S ^PS(55,DFN,"IV",DA,7)=PSGDT_U_RES
 Q
 ;
IVDUPADD(PSGP,ORDERNUM) ;
 N PSJCOM
 S DUPLOOP=0
 S DUPFOUND=0
 ;Loop through the additives of order to reinstate
 S PSJCOM=+$P($G(^PS(55,+PSGP,"IV",ORDERNUM,.2)),"^",8) F  S DUPLOOP=$O(^PS(55,PSGP,"IV",ORDERNUM,"AD",DUPLOOP)) Q:((DUPLOOP="")!(DUPFOUND))  D
 .;Get the additive code no.
 .S TARGET=$P(^PS(55,PSGP,"IV",ORDERNUM,"AD",DUPLOOP,0),"^",1)
 .D NOW^%DTC
 .S DATELOOP=%
 .;Loop through the current orders for the patient by date
 .F  S DATELOOP=$O(^PS(55,PSGP,"IV","AIS",DATELOOP)) Q:((DATELOOP="")!(DUPFOUND))  D
 ..S EXISTORD=""
 ..;Loop through the orders for date by order number
 ..F  S EXISTORD=$O(^PS(55,PSGP,"IV","AIS",DATELOOP,EXISTORD)) Q:((EXISTORD="")!(DUPFOUND))  D
 ...;Loop through additives for the existing order
 ...I PSJCOM>0 Q:+$P($G(^PS(55,+PSGP,"IV",EXISTORD,.2)),"^",8)
 ...S EXISTADD=0
 ...F  S EXISTADD=$O(^PS(55,PSGP,"IV",EXISTORD,"AD",EXISTADD)) Q:((EXISTADD="")!(DUPFOUND))  D 
 ....;Extract the Additive Code number for the Order
 ....S MATCHADD=$P(^PS(55,PSGP,"IV",EXISTORD,"AD",EXISTADD,0),"^",1)
 ....;If the existing order and the order to be reinstated have the same additive code then return FOUND=TRUE
 ....I MATCHADD=TARGET D
 .....S DUPFOUND=1
 Q DUPFOUND
 ;
VA200(X) ;Return the IEN for the user.
 ; X = User name
 NEW DIC,Y S DIC="^VA(200,",DIC(0)="NZ" D ^DIC
 I +Y=-1 Q ""
 Q $P(Y,U)
