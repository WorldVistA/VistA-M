PSOTPCAN ;BIR/RTR - TPB Utility routine ;08/23/03
 ;;7.0;OUTPATIENT PHARMACY;**146,153,163,227**;DEC 1997
 ;External reference to PS(55 supported by DBIA 2228
 ;External reference to VA(200 supported by DBIA 224
 ;
 ;Check Rx being DC'd, if it's a TPB Rx, check to inactivate patient
 ;Called from all DC actions
CAN(PSOTPRCX) ;
 Q  ; placed out of order by PSO*7*227
 I '$G(PSOTPRCX) Q
 N PSOTPRC
 S PSOTPRC=$P($G(^PSRX(PSOTPRCX,0)),"^",2)
 I '$G(PSOTPRC) Q
 I '$P($G(^PSRX(PSOTPRCX,"TPB")),"^") Q
 I '$D(^PS(52.91,PSOTPRC,0)) Q
 I $P($G(^PS(52.91,PSOTPRC,0)),"^",3),$P($G(^(0)),"^",3)'>DT Q
 ;Patient is active in the TPB File, and TPB Rx is being canceled
 I PSOTPRC'=$P($G(^PSRX(PSOTPRCX,0)),"^",2) Q
 N PSOTPCSS,PSOTCXFL,PSOTC1,PSOTC2,PSOTC3,X1,X2,DA,DR,DIE,X,Y
 S PSOTCXFL=0
 S X1=DT,X2=-1 D C^%DTC S PSOTC3=X
 F PSOTC1=PSOTC3:0 S PSOTC1=$O(^PS(55,PSOTPRC,"P","A",PSOTC1)) Q:'PSOTC1!(PSOTCXFL)  S PSOTC2="" F  S PSOTC2=$O(^PS(55,PSOTPRC,"P","A",PSOTC1,PSOTC2)) Q:PSOTC2=""!(PSOTCXFL)  D
 .I $P($G(^PSRX(PSOTC2,0)),"^",2)'=PSOTPRC Q
 .S PSOTPCSS=$P($G(^PSRX(PSOTC2,"STA")),"^")
 .I PSOTPCSS'=0,PSOTPCSS'=1,PSOTPCSS'=2,PSOTPCSS'=3,PSOTPCSS'=4,PSOTPCSS'=5,PSOTPCSS'=16 Q
 .I $P($G(^PSRX(PSOTC2,"TPB")),"^"),$P($G(^(2)),"^",6)'<DT S PSOTCXFL=1
 I 'PSOTCXFL K DA,DIE,DR S DA=PSOTPRC,DIE="^PS(52.91,",DR="2////"_DT_";3////"_6 D ^DIE K DIE,DA,DR
 Q
 ;
MARK ;Mark Rx as TPB Rx if applicable
 N PSOTPODE,PSOZTRX
 I '$G(PSOX("IRXN")) Q
 I '$D(^PSRX(PSOX("IRXN"),0)) Q
 I '$G(PSOTPBFG) Q
 ;I $G(PSOFDR) Q
 S PSOTPODE=$G(^PSRX(PSOX("IRXN"),0))
 I '$P(PSOTPODE,"^",2)!('$P(PSOTPODE,"^",3))!('$P(PSOTPODE,"^",4)) Q
 S PSOZTRX=$P($G(^PS(53,+$P(PSOTPODE,"^",3),0)),"^") I $$UP^XLFSTR(PSOZTRX)'="NON-VA" Q
 I '$P($G(^VA(200,+$P(PSOTPODE,"^",4),"TPB")),"^") Q
 I $P($G(^VA(200,+$P(PSOTPODE,"^",4),"TPB")),"^",5)'=0 Q
 I '$D(^PS(52.91,+$P(PSOTPODE,"^",2),0)) Q
 I $P($G(^PS(52.91,+$P(PSOTPODE,"^",2),0)),"^",3),$P($G(^(0)),"^",3)'>DT Q
 ;Hard setting, to avoid DIE kiling any needed variables, no cross references on field, if added, need to use FileMan here
 S $P(^PSRX(PSOX("IRXN"),"TPB"),"^")=1
 Q
MARKV ;Mark from Verify action
 N PSOTPV1,PSOTPV2
 I '$G(PSONVLP) Q
 I '$D(^PSRX(PSONVLP,0)) Q
 I '$G(PSOTPBFG) Q
 ;I $G(PSOFDR) Q
 S PSOTPV1=$G(^PSRX(PSONVLP,0))
 I '$P(PSOTPV1,"^",2)!('$P(PSOTPV1,"^",3))!('$P(PSOTPV1,"^",4)) Q
 S PSOTPV2=$P($G(^PS(53,+$P(PSOTPV1,"^",3),0)),"^") I $$UP^XLFSTR(PSOTPV2)'="NON-VA" Q
 I '$P($G(^VA(200,+$P(PSOTPV1,"^",4),"TPB")),"^") Q
 I $P($G(^VA(200,+$P(PSOTPV1,"^",4),"TPB")),"^",5)'=0 Q
 I '$D(^PS(52.91,+$P(PSOTPV1,"^",2),0)) Q
 I $P($G(^PS(52.91,+$P(PSOTPV1,"^",2),0)),"^",3),$P($G(^(0)),"^",3)'>DT Q
 S $P(^PSRX(PSONVLP,"TPB"),"^")=1
 Q
RXPAT ;Sets Rx patient status to null
 N PSOZZTRX
 I $G(X),$G(X)'>DT D
 .S PSOZZTRX=$P($G(^PS(53,+$P($G(^PS(55,DA,"PS")),"^"),0)),"^") S PSOZZTRX=$$UP^XLFSTR(PSOZZTRX) I PSOZZTRX="NON-VA" S $P(^PS(55,DA,"PS"),"^")=""
 Q
SET(PSOTPPST) ;Pass in DFN on a hard set of INACTIVATION OF BENEFIT DATE
 N PSOZXTRX
 I $P($G(^PS(52.91,PSOTPPST,0)),"^",3),$P($G(^(0)),"^",3)'>DT S PSOZXTRX=$P($G(^PS(53,+$P($G(^PS(55,PSOTPPST,"PS")),"^"),0)),"^") I $$UP^XLFSTR(PSOZXTRX)="NON-VA" S $P(^PS(55,PSOTPPST,"PS"),"^")=""
 Q
PCAP(PSOPAPPT) ;Find nearest Primary Care appointment
 Q "TODAY AT NOON"
 ;
PDIR(PSOTPEX) ;
 Q:'$G(PSOTPEX)
 N PSOTPEXS
 S PSOTPEXT=0
 S PSOTPEXS=$P($G(^DPT(PSOTPEX,0)),"^",9)
 W !!?10,$C(7),$P($G(^DPT(PSOTPEX,0)),"^")_" ("_$E(PSOTPEXS,1,3)_"-"_$E(PSOTPEXS,4,5)_"-"_$E(PSOTPEXS,6,9)_")"
 W !?10,"Patient is eligible for the Transitional Pharmacy Benefit!!"
 W ! K DIR S DIR(0)="E",DIR("A")="Press <ret> to continue, '^' to exit"  D ^DIR K DIR I Y'=1 S PSOTPEXT=1
 Q
VOPN ;
 I '$G(PSOTPPEN) Q
 I '$D(^PSRX(PSOTPPEN,0)) Q
 N PSOTPPE3,PSOTPPE4,PSOTPPE5,PSOTPPE6,PSOTPPE7,PSOTPPE8
 S PSOTPPE6=1
 S PSOTPPE3=$P($G(^PSRX(PSOTPPEN,0)),"^",3),PSOTPPE4=$P($G(^PSRX(PSOTPPEN,0)),"^",4)
VOPNX ;
 I 'PSOTPPE4 S PSOTPPEX=1,PSOTPPE5(PSOTPPE6)="Unknown Provider!",PSOTPPE6=PSOTPPE6+1
 I 'PSOTPPE3 S PSOTPPEX=1 S PSOTPPE5(PSOTPPE6)="Unknown Patient Status!",PSOTPPE6=PSOTPPE6+1
 I PSOTPPE4,'$P($G(^VA(200,PSOTPPE4,"TPB")),"^") S PSOTPPE5(PSOTPPE6)="Provider is not flagged as a NON-VA PRESCRIBER!",PSOTPPE6=PSOTPPE6+1,PSOTPPEX=1
 I PSOTPPE4,$P($G(^VA(200,PSOTPPE4,"TPB")),"^",5)'=0 S PSOTPPE5(PSOTPPE6)="Provider is not flagged as not being on exclusionary list!",PSOTPPE6=PSOTPPE6+1,PSOTPPEX=1
 I PSOTPPE3 S PSOTPPE7=$P($G(^PS(53,PSOTPPE3,0)),"^") S PSOTPPE7=$$UP^XLFSTR(PSOTPPE7) I PSOTPPE7'="NON-VA" S PSOTPPE5(PSOTPPE6)="Rx Patient Status is not equal to 'NON-VA'!",PSOTPPE6=PSOTPPE6+1,PSOTPPEX=1
 I $G(PSOTPPEX) D  I $G(PSOTPPE9) S VALMSG="Cannot Verify through this option"
 .W ! F PSOTPPE8=0:0 S PSOTPPE8=$O(PSOTPPE5(PSOTPPE8)) Q:'PSOTPPE8  W !,$G(PSOTPPE5(PSOTPPE8))
 .K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
VOPNR ;
 I '$G(PSOTPPEN) Q
 I '$D(^PS(52.41,PSOTPPEN,0)) Q
 N PSOTPPE3,PSOTPPE4,PSOTPPE5,PSOTPPE6,PSOTPPE7,PSOTPPE8
 S PSOTPPE6=1
 I $P(^PS(52.41,PSOTPPEN,0),"^",3)="RNW",$D(^PSRX(+$P(^PS(52.41,PSOTPPEN,0),"^",21),0)) S PSOTPPE3=$P($G(^PSRX(+$P(^PS(52.41,PSOTPPEN,0),"^",21),0)),"^",3) G NOREN
 S PSOTPPE3=$P($G(^PS(55,+$P($G(^PS(52.41,PSOTPPEN,0)),"^",2),"PS")),"^")
NOREN ;
 S PSOTPPE4=$P($G(^PS(52.41,PSOTPPEN,0)),"^",5)
 G VOPNX
 ;
DSPL(PSOTPWRN) ;
 N DIR,PSOTPWR1,PSOTPWR2,PSOTPWR3
 I '$G(PSOTPWRN) Q
 I '$D(^PS(52.41,PSOTPWRN,0)) Q
 I $P(^PS(52.41,PSOTPWRN,0),"^",3)="RNW",$D(^PSRX(+$P(^PS(52.41,PSOTPWRN,0),"^",21),0)) D  Q
 . S PSOTPWR1=$P($G(^PSRX(+$P(^PS(52.41,PSOTPWRN,0),"^",21),0)),"^",3)
 . S PSOTPWR2=$P($G(^PS(53,+PSOTPWR1,0)),"^"),PSOTPWR3=$$UP^XLFSTR(PSOTPWR2)
 . I PSOTPWR3="NON-VA" D
 . . K DIR W !!,"This order has an Rx Patient Status of 'NON-VA'!",! K DIR S DIR(0)="E",DIR("A")="Press return to continue" D ^DIR K DIR
 . . Q
 . Q
 S PSOTPWR1=$P($G(^PS(55,+$P($G(^PS(52.41,PSOTPWRN,0)),"^",2),"PS")),"^")
 S PSOTPWR2=$P($G(^PS(53,+PSOTPWR1,0)),"^") S PSOTPWR3=$$UP^XLFSTR(PSOTPWR2)
 I PSOTPWR3="NON-VA" D
 .W !!,"This order has an Rx Patient Status of 'NON-VA'!",! K DIR S DIR(0)="E",DIR("A")="Press return to continue"  D ^DIR K DIR
 Q
EXFLAG(PSOTPPX) ;Exit TPB RX option, reset TPG flag if necessary,
 ;and possibly delete inactive date and reason code for patient in 52.91
 I '$G(DT) S DT=$$DT^XLFDT
 I '$G(PSOTPPX) Q
 I '$D(^PS(52.91,PSOTPPX,0)) Q
 I $E($P(^PS(52.91,PSOTPPX,0),"^",3),1,7)'=DT Q
 I $P(^PS(52.91,PSOTPPX,0),"^",4)'=6 Q
 N DR,DIE,X1,X2,X,Y,DA,PSOTPPX1,PSOTPPX2,PSOTPPX3,PSOTPPX4,PSOTPPX5,PSOTPPX6,PSOTPPX7,PSOTPPX9
 S X1=DT,X2=-1 D C^%DTC S PSOTPPX1=X
 S PSOTPPX9=0
 F PSOTPPX2=PSOTPPX1:0 S PSOTPPX2=$O(^PS(55,PSOTPPX,"P","A",PSOTPPX2)) Q:'PSOTPPX2  S PSOTPPX3="" F  S PSOTPPX3=$O(^PS(55,PSOTPPX,"P","A",PSOTPPX2,PSOTPPX3)) Q:PSOTPPX3=""  D
 .I PSOTPPX'=$P($G(^PSRX(PSOTPPX3,0)),"^",2) Q
 .I $P($G(^PSRX(PSOTPPX3,"TPB")),"^") Q
 .I $E($P($G(^PSRX(PSOTPPX3,2)),"^"),1,7)'=DT Q
 .S PSOTPPX4=$P($G(^PSRX(PSOTPPX3,"STA")),"^") I PSOTPPX4="" Q
 .I PSOTPPX4'=0,PSOTPPX4'=1,PSOTPPX4'=2,PSOTPPX4'=3,PSOTPPX4'=4,PSOTPPX4'=5,PSOTPPX4'=16 Q
 .S PSOTPPX5=$P(^PSRX(PSOTPPX3,0),"^",3),PSOTPPX6=$P(^(0),"^",4)
 .I 'PSOTPPX5!('PSOTPPX6) Q
 .S PSOTPPX7=$P($G(^PS(53,+PSOTPPX5,0)),"^") S PSOTPPX7=$$UP^XLFSTR(PSOTPPX7) I PSOTPPX7'="NON-VA" Q
 .I '$P($G(^VA(200,PSOTPPX6,"TPB")),"^")!($P($G(^("TPB")),"^",5)'=0) Q
 .S $P(^PSRX(PSOTPPX3,"TPB"),"^")=1,PSOTPPX9=1
 I PSOTPPX9 K DA,DIE,DR S DIE="^PS(52.91,",DA=PSOTPPX,DR="2////"_"@"_";3////"_"@" D ^DIE K DIE,DA,DR
 Q
 ;
SCH ;DBIA to return TPB patients to Scheduling
 N PSOSCT,PSOSCTD
 K ^TMP($J,"PSODFN")
 F PSOSCT=0:0 S PSOSCT=$O(^PS(52.91,PSOSCT)) Q:'PSOSCT  I PSOSCT=$P($G(^(PSOSCT,0)),"^") D
 .S PSOSCTD=$P($G(^PS(52.91,PSOSCT,0)),"^",3)
 .I 'PSOSCTD!(PSOSCTD>DT) D
 ..I $P($G(^DPT(PSOSCT,0)),"^")="" Q
 ..S ^TMP($J,"PSODFN",$P($G(^DPT(PSOSCT,0)),"^"),PSOSCT)=""
 Q
