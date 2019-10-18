PSOCLUTL ;BHAM ISC/DMA - utilities for clozapine reporting system ;10 May 2019 09:01:28
 ;;7.0;OUTPATIENT PHARMACY;**28,56,122,222,268,457**;DEC 1997;Build 116
 ;External reference ^YSCL(603.01 supported by DBIA 2697
 ;External reference ^PS(55 supported by DBIA 2228
 ;
REG ; Register Clozapine Patient
 N DIC,DIR
 S DIC=55,DLAYGO=55,DIC(0)="AEQL",DIC("A")="Select patient to register: " D ^DIC K DIC,DLAYGO G END:Y<0
 S PSO1=+Y,PSONAME=$$GET1^DIQ(2,PSO1,.01)
 D:$$GET1^DIQ(55,PSO1,52.1,"I")'=2 EN^PSOHLUP(PSO1) N ANQX
 I '$$FIND1^DIC(603.01,,"Q",PSO1,"C") W !!,PSONAME_" has not been authorized for Clozapine",!,"by the NCCC in Dallas.  Contact the NCCC in Dallas for authorization." D OVER G:'$G(%) REG S JADOVER=""
 S PSO4=$$GET1^DIQ(55,PSO1,53) I PSO4]"" W !!,PSONAME_" is already registered with number "_PSO4,!!,"Use the edit option to change registration data, or",!,"contact your supervisor",! G REG
NUMBER ;
 S DIR(0)="55,53",Y=$$GET1^DIQ(603.01,$$FIND1^DIC(603.01,,"Q",PSO1,"C"),.01)
 S:Y]"" DIR("B")=Y
 D ^DIR S PSO2=Y K DIR I $D(DIRUT) W !,"Not registered",! D END G REG
 N PSOEX S PSOEX=$$FIND1^DIC(55,,"X",PSO2,"ASAND1")
 I PSOEX,PSOEX'=PSO1 W !,PSO2," is already assigned to ",$$GET1^DIQ(2,PSOEX,.01) W !,"Please contact your supervisor" D END G REG
 I '$D(JADOVER),'$$FIND1^DIC(603.01,"","X",PSO2,"B") D  I '$G(%) W ! G NUMBER
 . W !!,"The NCCC in Dallas has not authorized "_PSO2_" to be used",!
 . W "at this facility.  Contact the NCCC in Dallas for authorization." D OVER
NUMBER1 ;
 S PSO3="A"  ; (#54) CLOZAPINE STATUS
PHY ;
 N DIC,DIR
 S DIC="^VA(200,",DIC(0)="AEQMZ",DIC("A")="Provider responsible: ",DIC("S")="I $$GET1^DIQ(200,+Y,53.1)]"""""
 D ^DIC K DIC I Y<0 D END D  G:'$G(PSCLOZ) REG G END1
 .I '$G(PSCLOZ) W !!,"Not registered",!! Q
 .S ANQX=1 Q
 I $G(PSCLOZ) D PROVCHK(+Y) G:$G(ANQX) PHY
 S PSO4=+Y
 ;/RBN Begin NCC changes Ask if okay to register the unregistered patient - PSO*7.0*457
 N DFN,VADM S DFN=PSO1 D DEM^VADPT
 S SSN=$P(VADM(2),"^")
 S LSTFOUR=$E(SSN,6,9)
 I '$G(PSCLOZ) D
 . S DIR("A",1)="OK to register "_PSONAME_" ("_$G(LSTFOUR)_")"_" with number "_PSO2
 . S DIR("A")="as a"_$S('PSO3:" new",1:"n ongoing")_" patient in this program? "
 I $G(PSCLOZ) D
 . S DIR("A",2)="Would you like to override the registration requirement"
 . S DIR("A",1)="and assign a temporary local authorization number"
 . S DIR("A")="for  "_PSONAME_" ("_$G(LSTFOUR)_")"_" with number "_PSO2_"? "
 S DIR(0)="YA",DIR("B")="NO" D ^DIR K DIR I Y=0!($D(DUOUT)) S ANQX=1 D END G END1
 ;/RBN End NCC changes to remove Pretreatment choice - PSO*7.0*457
SAVE ;
 S DA=PSO1,DIE=55,DR="53////"_PSO2_";54////"_PSO3_";57////"_PSO4_";56////0;58////"_DT
 L +^PS(55,DA):DILOCKTM E  W !!,$C(7),"Patient "_PSONAME_" is being edited by another user!  Try Later." S ANQX=1 D END G END1
 D ^DIE L -^PS(55,DA)
 S $P(^XTMP("PSJ CLOZ",0),U,4)=PSO2  ; save last temp reg#
END ;
 K %,%Y,C,D,D0,DA,DI,DQ,DIC,DIE,DR,PSO,PSO1,PSO2,PSO3,PSO4,PSOC,PSOLN,PSONAME,PSONO,PSOT,R,SSNVAERR,XMDUZ,XMSUB,XMTEXT,Y
 I '$G(PSCLOZ) K ^TMP($J),^TMP("PSO",$J)
 Q
END1 ;
 I $G(ANQX) W !!,"Patient Not Registered"
 Q
 ;
FACILITY ;Enter facility DEA number to set up clozapine system
 ;this entry point is no longer used.  this functionality was taken over
 ;by the mental health package with the release of YS*5.01*18
 ;W ! S DIC=59,DIC(0)="AEQM",DIC("A")="Select site to participate in clozapine program : " D ^DIC G END:Y<0
 ;S DIE=DIC,DA=+Y,DR="1R;2R;" L +^PS(59,DA) D ^DIE L -^PS(59,DA) G FACILITY
 Q
 ;
 ;
AGAIN ; re-enter patient - new number, status and provider
 S DIC=55,DIC(0)="AEQM",DIC("A")="Select clozapine patient : " D ^DIC K DIC G END:Y<0 S (DA,PSO1)=+Y,PSONAME=$$GET1^DIQ(2,DA,.01)
 I $$GET1^DIQ(55,DA,53)="" W !,PSONAME_" is not registered.  Use the register option." G AGAIN
 I '$$FIND1^DIC(603.01,,"Q",PSO1,"C") W !!,PSONAME_" has not been authorized for Clozapine",!,"by the NCCC in Dallas.  Contact the NCCC in Dallas for authorization." D OVER G:'$G(%) AGAIN S JADOVER=""
 S DIR(0)="55,53" D ^DIR G END:$D(DIRUT) S PSO2=Y
 N PSOEX S PSOEX=$$FIND1^DIC(55,,"X",PSO2,"ASAND1")
 I PSOEX,PSOEX'=PSO1 W !,PSO2," already assigned to ",$$GET1^DIQ(2,PSOEX,.01) G END
 I '$D(JADOVER),'$$FIND1^DIC(603.01,,"X",PSO2) W !!,"The NCCC in Dallas has not authorized "_PSO2_" for usage",!,"at this facility.  Contact the NCCC in Dallas for authorization." D OVER G:'$G(%) END
 W !,"CLOZAPINE STATUS: "_$$GET1^DIQ(55,PSO1,54)
 S PSO3=$$GET1^DIQ(55,PSO1,54,"I")
PHY1 ;
 S DIR(0)="55,57" D ^DIR G END:$D(DIRUT) I Y S PSO4=+Y
 I $$GET1^DIQ(200,PSO4,53.2)="" W !!,"Only providers with DEA numbers entered in the New Person",!,"file can register patients in this program.",!! G PHY1
 G SAVE
 ;
OVER ;allow registration of patients and clozapine numbers not yet authorized by the NCCC.
 K DIR,% W ! S DIR("A")="Do you want to override this warning",DIR(0)="Y",DIR("B")="No" D ^DIR
 I Y S %=1
 K DIR,DIRUT,DUOUT Q
 ;
CLOZPAT ;VERIFY PATIENT IS A CLOZAPINE PATIENT
 K CLOZPAT,CLOZST S CLOZST=$$GET1^DIQ(55,DFN,54,"I")
 I $L(CLOZST),CLOZST'="D" D
 .N CLOZNUM,CLOZUID S CLOZNUM=$$GET1^DIQ(55,DFN,53)
 .I CLOZNUM?1U6N S CLOZPAT=3 Q
 .S CLOZUID=$$FIND1^DIC(603.01,,"X",CLOZNUM) Q:'CLOZUID  ;Q:'$D(^YSCL(603.01,CLOZUID,0))
 .S CLOZPAT=$$GET1^DIQ(603.01,CLOZUID,2,"I")
 .S CLOZPAT=$S($G(CLOZPAT)="M":2,$G(CLOZPAT)="B":1,$G(CLOZPAT)="W":0,1:90)
 Q
 ;
PROVCHK(PROV) ;
 N PSJQUIT S (ANQX,PSJQUIT)=0 I '$G(PROV) Q
 I '$L($$DEA^XUSER(,PROV)) S (ANQX,PSJQUIT)=1 D  Q
 .W !," ",!,"*** Provider must have a DEA# or VA# to write prescriptions for this drug."
 I '$$FIND1^DIC(200.051,","_PROV_",","X","YSCL AUTHORIZED") S (ANQX,PSJQUIT)=1 D
 .W !," ",!,"*** Provider must hold YSCL AUTHORIZED key to write prescriptions for clozapine."
 Q
 ;
MSG1 ;
 W !!,"Permission to dispense clozapine has been denied. The results of the latest",!
 W "Lab Test drawn in the past 7 days show ANC results but No Matching WBC.",!
 W "If you wish to dispense outside the FDA and VA protocol ANC limits,",!
 W "document your request to Request for Override of Pharmacy Lockout ",!
 W "(from VHA Handbook 1160.02) Director of the",!
 W "VA National Clozapine Coordinating Center",!
 W "(Phone: 214-857-0068 Fax: 214-857-0339) for a one-time override permission.",!
 W !,"No order entered!"
 S ANQX=1
 Q
MSG2 ;
 W !!,"Permission to dispense clozapine has been denied. The results of the latest",!
 W "Lab Test drawn in the past 7 days show No ANC results. If you wish to dispense",!
 W "outside the FDA and VA protocol ANC limits, document your request to Request",!
 W "for Override of Pharmacy Lockout (from VHA Handbook 1160.02) Director of the",!
 W "VA National Clozapine Coordinating Center",!
 W "(Phone: 214-857-0068 Fax: 214-857-0339) for a one-time override permission.",!
 W !,"No order entered!"
 S ANQX=1
 Q
MSG3 ;
 W !,"A CBC/Differential including ANC Must Be Ordered and Monitored on a",!
 W "Daily basis until the ANC above 1000/mm3 with no signs of infection.",!
 W "If ANC is between 1000-1499, therapy can be continued but physician must order",!
 W "lab test three times weekly."
 Q
MSG4 ;
 W !,"Permission to dispense clozapine has been denied. If the results of the latest"
 W !,"Lab Test drawn in the past 7 days show ANC below 1000/mm3 and you wish to"
 W !,"dispense outside the FDA and VA protocol ANC limits, document your request to"
 W !,"Request for Override of Pharmacy Lockout (from VHA Handbook 1160.02)"
 W !,"Director of the VA National Clozapine Coordinating Center"
 W !,"(Phone: 214-857-0068 Fax: 214-857-0339) for a one-time override permission.",!
 S ANQX=1
 Q
MSG5 ;
 W !!,"Permission to dispense clozapine has been denied. Please contact the"
 W !,"Director of the VA National Clozapine Coordinating Center"
 W !!,"Request for Override of Pharmacy Lockout (from VHA Handbook 1160.02)"
 W !,"(Phone: 214-857-0068 Fax: 214-857-0339).",!
 Q
MSG6 ; ; ** START NCC REMEDIATION ** 457 AND PSJ 327/RTW MSG 6 added for new critically low ANC levels clozapine override requirements
 W !!,"This clozapine drug may not be dispensed to the patient at this time based on the available lab tests related to the clozapine treatment program."
 W !!,"Please contact the NCCC to request an override in order to proceed with dispensing this drug. "
 W !!,"Request for Override of Pharmacy Lockout (from VHA Handbook 1160.02)"
 W !!,"The matching ANC counts which caused the lockout are of lab test results performed on "
 S ANQX=1,Y=$P(PSOYS,"^",6) X ^DD("DD") W $P(Y,"@")
 W !!,?5,"ANC: "_$P(PSOYS,"^",4),!
 Q
MSG9 ;
 W !,"*** Permission to dispense clozapine has been denied based on the available"
 W !,"    lab tests related to the clozapine treatment program. ***"
 W !!,"For a National Override to dispense at the patient's normal frequency,"
 W !,"please contact the VA National Clozapine Coordinating Center to request"
 W !,"an Override of Pharmacy Lockout (from VHA Handbook 1160.02)"
 W !,"(Phone: 214-857-0068 Fax: 214-857-0339)."
 W !,"A Special Conditions Local Override can be approved for"
 W !,"(1) weather-related conditions, (2) mail order delays of clozapine, or"
 W !,"(3) inpatient going on leave. With Provider's documentation of approval,"
 W !,"you may dispense a one-time supply not to exceed 4 days.",!
 Q
 ;
 ;/RBN Begin of modifications for new message for IP 4 day overrride.
MSG10 ;
 W !,"*** Permission to dispense clozapine has been denied based on the available"
 W !,"    lab tests related to the clozapine treatment program. ***"
 W !!,"For a National Override to dispense at the patient's normal frequency,"
 W !,"please contact the VA National Clozapine Coordinating Center to request an"
 W !,"Override of Pharmacy Lockout (from VHA Handbook 1160.02) (Phone: 214-857-0068"
 W !,"Fax: 214-857-0339)."
 W !,"A Special Conditions Local Override for Inpatients can be approved for an"
 W !,"IP Override Order with Outside Lab Results. With Provider's documentation of"
 W !,"approval, you may dispense a one-time IP supply not to exceed 4 days."
 W !,"The ANC from another facility must be recorded in the Progress note/comments"
 W !,"in pharmacy"
 Q
 ;
CRXTMP(DFN,PSOYS) ; track OP 4 day supply
 S ^XTMP("PSO4D-"_DFN,0)=$$FMADD^XLFDT(DT,5)_U_DT_"^Clozapine Local Override 4 day supply tracking"
 S ^XTMP("PSO4D-"_DFN,"PSOYS")=PSOYS
 Q
 ;
CRXTMPI(DFN,PSOYS) ; track IP 4 day supply
 S ^XTMP("PSJ4D-"_DFN,0)=$$FMADD^XLFDT(DT,5)_U_DT_"^Clozapine Local Override 4 day supply tracking"
 S ^XTMP("PSJ4D-"_DFN,"PSOYS")=PSOYS
 Q
 ;
CLKEYWRN() ; uniform message to users - PSO*7*457
 Q "Provider must hold YSCL AUTHORIZED key to write medication orders for clozapine."
 ;
