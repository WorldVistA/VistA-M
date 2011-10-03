DGPMV ;ALB/MRL/MIR - PATIENT MOVEMENT DRIVER; 10 MAR 89
 ;;5.3;Registration;**60,200,268**;Aug 13, 1993
 ;
 ;OPTION         VALUE OF DGPMT
 ;------         --------------
 ;admit                 1
 ;transfer              2
 ;discharge             3
 ;check-in              4
 ;check-out             5
 ;t.s. transfer         6
 ;
PAT K ORACTION,ORMENU
 D LO^DGUTL I '$D(IOF) S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
PAT1 W ! I DGPMT=5 S DGPMN=0 D SPCLU^DGPMV0 G OREN:'DGER,Q
 S DIC="^DPT(",DIC(0)="AEQMZ",DIC("A")=$S('$D(DGPMPC):$P("Admit^Transfer^Discharge^Check-in^Check-out^Specialty Change for","^",DGPMT),1:"Provider Change for")_" PATIENT: "
 S:DGPMT=1 DIC(0)=DIC(0)_"L",DLAYGO=2 S:"^1^4^"'[("^"_DGPMT_"^") DIC("S")="I $D(^DGPM($S(DGPMT'=5:""APTT1"",1:""APTT4""),+Y))" D ^DIC K DIC,DLAYGO G Q:Y'>0 S DFN=+Y,DGPMN=$P(Y,"^",3)
OREN S DGUSEOR=$$USINGOR()
 I DGUSEOR Q:'$D(ORVP)  S DFN=+ORVP,DGPMN="",Y(0)=$G(^DPT(DFN,0))
 I $$LODGER(DFN)&(DGPMT=1) D  Q
 .W !,*7,"Patient is a lodger...you can not add an admission!"
 .W !,"    Press RETURN to continue"
 .R XTEMP:30
 .D DISPOQ K DGPMDER
MOVE ;
 S XQORQUIT=1,DGPME=0 D UC
 G CHK:"^1^4^"[("^"_DGPMT_"^") I '$D(^DGPM("APTT"_$S(DGPMT'=5:1,1:4),DFN)) W !!,"'",$P(Y(0),"^",1),"' HAS NEVER BEEN ",$S(DGPMT'=5:"ADMITTED",1:"CHECK-IN")," TO THE DHCP ADMISSIONS MODULE" G PAT1:'DGUSEOR,Q
CHK D:DGPMN REG I 'DGPME,$D(^DPT(DFN,.35)),+^(.35) S Y=+^(.35) D DIED
 D NEW^DGPMVODS I $S('DGODSON:0,'$D(^DPT(DFN,.32)):1,'$D(^DIC(21,+$P(^(.32),"^",3),0)):1,1:0) S DGPME=1
 D:'DGPME ^DGPMV1 G PAT1:'DGUSEOR,Q
 ;
REG ;new patient
 D NEW^DGRP
 W !!,"NEW PATIENT!  WANT TO LOAD 10-10 DATA NOW" S %=1 D YN^DICN I %=1 D ENED^DGRP S:'$D(^DPT(DFN,0)) DGPME=1 Q
 Q:%>0  I % S DGPME=1 Q
 W !?4,"Answer YES if you want to load 10/10 data at this time otherwise answer NO.",*7 G REG
 ;
DIED X ^DD("DD") W !!,"PATIENT EXPIRED '",Y,"'...WANT TO CONTINUE" S %=2 D YN^DICN Q:%=1  I % S DGPME=1 Q
 W !?4,*7,"Answer YES if you want to continue this process even though the patient",!?4,"has expired otherwise answer NO!" G DIED
 ;
Q K %,DFN,DGER,DGPM5X,DGODS,DGODSON,DGPMUC,DGPME,DGPMN,DGPMT,DGPMPC,DIC,X,Y,^UTILITY("VAIP",$J) D KVAR^VADPT
 I '$G(DGUSEOR) K XQORQUIT
 K DGUSEOR
 Q
 ;
UC ; -- set type of mvt literal
 S DGPMUC=$P("ADMISSION^TRANSFER^DISCHARGE^LODGER CHECK-IN^CHECK-OUT LODGER^SPECIALTY TRANSFER^ROOM-BED CHANGE","^",DGPMT)
 I DGPMT=6,$D(DGPMPC) S DGPMUC="PROVIDER CHANGE"
 Q
 ;
CA ; -- bypass interactive process and allows editing of past admission
 ;    mvts
 ;
 ;    input: DFN
 ;           DGPMT  - mvt transaction type
 ;           DGPMCA - coresp. adm
 ;
 ;   output: Y - the mvt entry added/edited
 ;
 D UC
 K VAIP S VAIP("E")=DGPMCA N DGPMCA D INP^DGPMV10
 S DGPMBYP="" D C^DGPMV1
 S Y=DGPMBYP K DGPMUC,DGPMBYP
 Q
DISPO ;called from admission disposition types
 ;input  DGPMSVC=SVC OF WARD REQUIRED (FROM DISPOSITION TYPE FILE)
 ;           DFN=patient file IFN (this variable is NOT killed on exit)
 ;output DGPMDER=disposition error?? - FOR FUTURE USE
 ;
 S DGPMT=1,(DGPML,DGPMMD)="" K DGPMDER,VAIP S VAIP("D")="L" D UC^DGPMV,INP^DGPMV10,NOW^%DTC
 I DGPMVI(1)&('DGPMDCD!(DGPMDCD>%)) W !,"Patient is already an inpatient...editing the admission is not allowed." D DISPOQ K DGPMDER Q
 I $$LODGER(DFN) W !,*7,"Patient is a lodger...you can not add an admission!" D DISPOQ K DGPMDER Q
 ;next line should be involked in future release to error if wrong service
 ;I DGPMVI(1)&('DGPMDCD!(DGPMDCD>%)) S DGPMDER=$S(DGPMSVC="H"&("^NH^D^"'[("^"_DGPMSV_"^")):0,DGPMSVC=DGPMSV:0,1:1) W:DGPMDER=1 "Current inpatient, but not to proper service" Q
 D NEW^DGPMVODS I $S('DGODSON:0,'$D(^DPT(DFN,.32)):1,'$D(^DIC(21,+$P(^(.32),"^",3),0)):1,1:0) S DGPME=1
 S DEF="NOW",DGPM1X=0 D SEL^DGPMV2 I '$D(DGPMDER) S DGPMDER=1
DISPOQ D Q^DGPMV1 K DGODS,DGODSON,DGPMT,DGPMSV,DGPMSVC,DGPMUC,DGPMN,^UTILITY("VAIP",$J) Q
 ;
USINGOR() ; return a 1 if OE/RR option is being used or 0 otherwise
 N RETURN,X
 S RETURN=0,X=+$$VERSION^XPDUTL("OR")
 I X<3,$D(ORACTION) S RETURN=1
 I X'<3,$D(ORMENU) S RETURN=1
 Q RETURN
LODGER(DFN) ; Determine lodger status
 ; Input: DFN=patient IEN
 ; Output: '1' if currently a lodger, '0' otherwise
 N DGPMDCD,DGPMVI,I,X
 D LODGER^DGPMV10
 Q DGPMVI(2)=4
