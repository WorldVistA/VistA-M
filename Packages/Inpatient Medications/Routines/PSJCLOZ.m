PSJCLOZ ; DAL/RJS - INPATIENT CLOZAPINE ORDER CHECK ;12 June 2019 11:36:51
 ;;5.0;INPATIENT MEDICATIONS ;**327**;01 DEC 15;Build 114
 ;
CLOZ(DFN,DRUG) ;
 ; DFN is patient IEN, DRUG is drug file (#50) IEN
 I '($G(DFN)>0)!'($G(DRUG)>0) S ANQX=0 Q
 D PROVCHK($G(PSGPR)) Q:ANQX
 N RTN
 S RTN=$$GET1^DIQ(50,DRUG,17.5)
 D:$L(RTN) ^@RTN
 Q
 ;
PROVCHK(PROV) ;
 N PSJQUIT
 ;
 S (ANQX,PSJQUIT)=0
 I $G(PROV) D
 .I '$L($$DEA^XUSER(,PROV)) D
 ..S (ANQX,PSJQUIT)=1
 ..W !," ",!,"*** Provider must have a DEA# or VA# to write prescriptions for this drug."
 . Q:PSJQUIT
 .I '$$FIND1^DIC(200.051,","_PROV_",","X","YSCL AUTHORIZED") D
 ..S (ANQX,PSJQUIT)=1
 ..W !," ",!,$$CLKEYWRN^PSOCLUTL
 Q
BEFQUIT ;
 Q:'$G(QOAA)
 N QODS,QORF,ORMAX,ORCLPAT
 S QODS=$$FIND1^DIC(101.41,,"X","OR GTX DAYS SUPPLY","AB") Q:'QODS
 S QODS=$$FIND1^DIC(101.416,","_ORX_",","Q",QODS,"D") Q:'QODS
 S QODS=$$GET1^DIQ(101.416,QODS_","_ORX,.01)
 S QORF=$$FIND1^DIC(101.41,,"X","OR GTX REFILLS","AB") Q:'QORF
 S QORF=$$FIND1^DIC(101.416,","_ORX_",","Q",QORF,"D") Q:'QORF
 S QORF=$$GET1^DIQ(101.416,QORF_","_ORX,.01)
 S QORF=QORF+1
 S ORCLPAT=$P(ORYS,U,7)
 S ORMAX=$S(ORCLPAT="M":28,ORCLPAT="B":14,ORCLPAT="W":7,1:90)
 I QORF*QODS>ORMAX D
 .K ORY
 .S ORY=1_U_ORCLOZ
 .W !,?5,"Problem Ordering Clozapine Related Medication"_U_ORCLOZ
 .W !,?5,"*** This patient is only allowed an order with a maximum Days Supply of "_ORMAX_"."
 .W !,?5,"This includes the amounts added by any refills entered in with the order also."
 Q
OVERRIDE ;
 I '$$FIND1^DIC(200.051,","_PROV_",","X","PSOLOCKCLOZ") D  Q 1
 .N Y
 .W !," ",!,"     *** You are not authorized to override Clozapine orders.",!," "
 .K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." D ^DIR K DIR W @IOF
 Q
PSJFILE(DFN) ;
 S PSJCLPAT=DFN
 N PSJORN,PSJORDER I $G(PSJCOM) D  Q
 .I $G(PSGODA),$O(^TMP("PSJCOM",$J,PSGODA))'="" Q   ; Put into the file 53.8 just at the end
 .N PSJORD1 S PSJORD1=""
 .F  S PSJORD1=$O(^TMP("PSJCOM",$J,PSJORD1)) Q:'PSJORD1  D
 ..S ANQDATA=$G(^TMP("PSJCOM",$J,PSJORD1,"ANQDATA")) Q:'$L(ANQDATA)
 ..S PSJORN=+$P(^TMP("PSJCOM",$J,PSJORD1,0),"^",21)
 ..D PSJFILE1
PSJFILE1 ;
 I $D(ANQDATA) D
 .F  D NOW^%DTC I '$D(^PS(53.8,"B",%)) S NOW=% Q
 .S PSJPROV=$P(ANQDATA,"^",2),PSJ1PH=$P(ANQDATA,"^"),PSJ2PH=$P(ANQDATA,"^",5)
 .S PSJREASN=$P(ANQDATA,"^",3),PSJREMRK=$P(ANQDATA,"^",4)
 .I $G(ORO) S PSJPROV=$P(ORO,"^",4)
 .S:'$G(PSJORN)&$G(ORO) PSJORN=+ORO
 .S PSJORDER("PSJORN")=PSJORN
 .K DD,DO S DIC="^PS(53.8,",DIC(0)="L",DLAYGO=53.8,X=NOW
 .D FILE^DICN K DIC,DLAYGO,DD,DO,DA,DR
 .N PS538 S (PS538,DA)=+Y,DIE="^PS(53.8,",DR="1////^S X=PSJORDER(""PSJORN"")"_";3////^S X=PSJPROV;2////^S X=PSJ1PH;4////^S X=PSJREASN;5////^S X=PSJREMRK;6////^S X=PSJ2PH"
 .D ^DIE K DIE,DA,DR
 .S XMY(PSJPROV)="",XMY(PSJ2PH)=""
 .K ANQDATA,X,Y,%,ANQREM
 .W !,"THE OVERRIDDEN ORDER IS COMPLETE",!
 .D ALERT
 Q
ALERT ; send an alert to the TWO approving team members
 N RSLT
 S XQADATA=PSCLPAT  ;
 S PSOLAST4=$E($$GET1^DIQ(2,PSCLPAT,.09),6,9)
 S XQAARCH=1,XQAFLG="D"
 S XQA(PSJ2PH)="",XQA(PSJPROV)="",PSCDATE=$$FMTE^XLFDT($$NOW^XLFDT)
 S XQAMSG=$$GET1^DIQ(2,PSCLPAT,.01)_" ("_PSOLAST4_")"_" : Clozapine Override Rx Processed: "_PSCDATE
 S XQAID="PSI"_","_PSCLPAT
 S RSLT=$$SETUP1^XQALERT
 W !!,"OVERRIDE ALERTS HAVE BEEN SENT TO THE APPROVING TEAM MEMBERS",!!
 Q
 ;
READ ;
 S CLOZPAT=$P($P(XQX,"patient ",2)," BY",1)
 S DIR("A")="Do you concur with the requested override for "_CLOZPAT,DIR(0)="Y",DIR("B")="N" D ^DIR G END:$D(DIRUT) K DIR D:'Y!($D(DIRUT)) END
 Q
TDD ; TOTAL DAILY DOSE INPUT
 D
 .S DIR(0)="N^12.5:3000:1",DIR("A")="CLOZAPINE dosage (mg/day) ? " D ^DIR K DIR I $D(DIRUT) S (ANQX,PSGORQF)=1 Q
 .S:+$G(PSJEDITO) PSGETDD=X
 .S:+$G(PSGCOPY) PSGCTDD=X
 .S PSOSAND=X
 Q
ORD ;
 S PSGDRG=PSJDD
 I $$GET1^DIQ(50,+$G(PSGDRG),17.5)="PSOCLO1" D CLOZ(PSGP,PSGDRG) I $G(ANQX) S PSGORQF=1
END ;
 K DIRUT,DIROUT,DIR
 Q
 ;
CMPLX ;COMPLEX THEN ORDER LOGIC
 Q:'$$GET1^DIQ(53.1,+$G(PSGORD),125,"I")
 Q:+$G(PSGCOPY)
 D CLOZPAT,ANDTHEN
 Q:$G(PSGTYP)="A"
 I $D(PSGTYP),'$D(^TMP("PSGCPLX",$J,DFN,+$G(PSGORD))) S ^TMP("PSGCPLX",$J,DFN,+$G(PSGORD))=PSGSD,PSGCOMP=1
 Q
CMPLX2 ;SECOND COMPLEX THEN ORDER LOGIC
 Q:'$$GET1^DIQ(53.1,+$G(PSGORD),125,"I")
 Q:+$G(PSGCOPY)
 D CLOZPAT,ANDTHEN
 I $G(PSGTYP)="A"!($G(PSGTYP)="AT") Q
 I $D(^TMP("PSGCPLX",$J,DFN)) D
 .I $O(^TMP("PSGCPLX",$J,DFN,0)) S PSGTMP=$O(^TMP("PSGCPLX",$J,DFN,0))
 .I +$G(PSGTMP)'=+$G(PSGORD) D
 ..S $P(PSGRDTX,U,1)=$G(^TMP("PSGCPLX",$J,DFN,PSGTMP))
 ..I $G(PSGRDTX(+$G(PSJORD),"PSGSD"))=+$G(PSGRDTX)
 ..N X,X1,X2 S X1=+$G(PSGRDTX),X2=$S($G(CLOZPAT)=2:28,$G(CLOZPAT)=1:14,$G(CLOZPAT)=0:7,$G(CLOZPAT)=3:4,1:90)
 ..D C^%DTC S PSGFD=X,PSGFDN=$$ENDD^PSGMI(PSGFD)_"^"_$$ENDTC^PSGMI(PSGFD)
 Q
CMPLX3 ;SECOND COMPLEX THEN ORDER LOGIC 
 Q:'$$GET1^DIQ(53.1,+$G(PSGORD),125,"I")
 I PSGSTAT="NON-VERIFIED" D DISPCMP(PSGORD,PSGFD) D  Q
 .I $G(PSSD) S PSGFD=PSSD,PSGFDN=$$ENDD^PSGMI(PSGFD)_"^"_$$ENDTC^PSGMI(PSGFD) K PSSD
 D CLOZPAT,ANDTHEN
 I $G(PSGTYP)="T"!($G(PSGTYP)="TA") Q
 N X,X1,X2 S X1=+$G(PSGRDTX),X2=$S($G(CLOZPAT)=2:28,$G(CLOZPAT)=1:14,$G(CLOZPAT)=0:7,$G(CLOZPAT)=3:4,1:90)
 D C^%DTC S PSGFD=X,PSGFDN=$$ENDD^PSGMI(PSGFD)_"^"_$$ENDTC^PSGMI(PSGFD)
 Q
CLOZPAT ;VERIFY PATIENT IS A CLOZAPINE PATIENT
 K CLOZPAT
 I $L($$GET1^DIQ(55,DFN,53)),$$GET1^DIQ(55,DFN,54,"I")'="D" D
 .I $$GET1^DIQ(55,DFN,53)?1U6N S CLOZPAT=3 Q
 .N CLOZNUM,CLOZUID
 .S CLOZNUM=$$GET1^DIQ(55,DFN,53) Q:CLOZNUM=""
 .S CLOZUID=$$FIND1^DIC(603.01,,"X",CLOZNUM) Q:'CLOZUID
 .S CLOZPAT=$$GET1^DIQ(603.01,CLOZUID,2,"I")
 .S CLOZPAT=$S($G(CLOZPAT)="M":2,$G(CLOZPAT)="B":1,$G(CLOZPAT)="W":0,1:90)
 Q
ANDTHEN ;COMPLEX AND/THEN ORDER
 Q:'$$GET1^DIQ(53.1,+$G(PSGORD),125,"I")
 Q:+$G(PSGCOPY)
 N PSGTMP,PSGID S PSGTMP=+$$GET1^DIQ(53.1,+$G(PSGORD),125,"I"),PSGTYP=""
 S PSGID=$$FIND1^DIC(100.045,","_PSGTMP_",","X","CONJ","ID") I PSGID D
 .S PSGTYP=PSGTYP_$$GET1^DIQ(100.045,PSGID_","_PSGTMP,1)
 Q
DISPCMP(PSGORD,PSSD) ;COMPLEX ORDER CHECK
 Q:'$$GET1^DIQ(53.1,+$G(PSGORD),125,"I")
 S PSSD=+$$GET1^DIQ(53.1,+$G(PSGORD),117,"I")
 Q
EXTDT ;VERIFY EXTERNAL DATE
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
MSG6 ;  MSG 6 added for new critically low ANC levels clozapine override requirements
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
 ;/RBN End of modifications for new message for IP 4 day overrride.
 ; ** END NCC REMEDIATION ** 457 AND PSJ 327/RTW
 ;
COMPLEX ; Display Complex Order stop date warning message  <<RJS
 Q:$G(PSGFLG)
 Q:'$$GET1^DIQ(53.1,+$G(PSGORD),125,"I")
 N PSGFDT  ;,PSGSD,PSGYS,X,X1,X2
 D CLOZPAT
 S X1=+$G(PSGSD),X2=$S($G(CLOZPAT)=2:28,$G(CLOZPAT)=1:14,$G(CLOZPAT)=0:7,$G(CLOZPAT)=3:4,1:90)
 D C^%DTC S PSGFDT=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 W !!,?25,"* WARNING *",!!,?10,"This order contains a requested duration."
 W !,?8,"Please review the system calculated stop date",!,?5,"to confirm that it is within the allowable duration"
 W !,?13,"of the order based on the patient's",!,?11,"authorized clozapine dispense frequency.",!
 W !,?10,"Order stop date should not exceed ",PSGFDT,!,!,?1,"Review the entire profile to determine appropriate action(s).",!
 K PSGCOMP D PAUSE^VALM1 S PSGFLG=1
 Q
COMPLEX1 ; Display Complex Order stop date warning message  <<RJS
 Q:$G(PSGFLG)
 Q:'$$GET1^DIQ(53.1,+$G(PSGORD),125,"I")
 N PSGFDT,MSG
 D:'$D(CLOZPAT) CLOZPAT
 S X1=+$G(PSGSD),X2=$S($G(CLOZPAT)=2:28,$G(CLOZPAT)=1:14,$G(CLOZPAT)=0:7,$G(CLOZPAT)=3:4,1:90)
 D C^%DTC S PSGFDT=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 S MSG=$J("",25)_"* WARNING *" D INSTR^VALM1("",1,9,80,1),INSTR^VALM1(MSG,1,10,80,1)
 S MSG=$J("",10)_"This order contains a requested duration." D INSTR^VALM1(MSG,1,11,80,1)
 S MSG=$J("",8)_"Please review the system calculated stop date" D INSTR^VALM1(MSG,1,12,80,1)
 S MSG=$J("",5)_"to confirm that it is within the allowable duration" D INSTR^VALM1(MSG,1,13,80,1)
 S MSG=$J("",13)_"of the order based on the patient's" D INSTR^VALM1(MSG,1,14,80,1)
 S MSG=$J("",11)_"authorized clozapine dispense frequency." D INSTR^VALM1(MSG,1,15,80,1)
 S MSG=$J("",10)_"Order stop date should not exceed "_PSGFDT D INSTR^VALM1(MSG,1,17,80,1)
 S MSG=" Review the entire profile to determine appropriate action(s)." D INSTR^VALM1(MSG,1,18,80,1)
 N LN F LN=16,19 D INSTR^VALM1("",1,LN,80,1)
 K PSGCOMP D PAUSE^VALM1 S PSGFLG=1
 Q
LASTCHLD(DFN,ON) ; Last child of Complex order or not
 N FL,PSORDA,PSORD1 I ON'["U",ON'["V" Q 1
 I ON["U" D  Q:'PSORDA 1  Q:'PSORD1 1  Q 0
 .S PSORDA=$$GET1^DIQ(55.06,+ON_","_DFN,125,"I"),PSORD1=+$$GET1^DIQ(55.06,+ON_","_DFN,66,"I")
 .I 'PSORDA!'PSORD1 Q
 .N ORARR,MAX D LIST^DIC(100.002,","_PSORDA_",",,"I",,,,,,,"ORARR") S MAX=+ORARR("DILIST",0)
 .F I=1:1 Q:'$D(ORARR("DILIST",2,I))  I ORARR("DILIST",2,I)=PSORD1 Q
 .S:I=MAX PSORD1=0 Q
 I ON["V" D  Q:'PSORDA 1  Q:'PSORD1 1  Q 0
 .S PSORDA=$$GET1^DIQ(55.01,+ON_","_DFN,150,"I"),PSORD1=+$$GET1^DIQ(55.01,+ON_","_DFN,110,"I")
 .I 'PSORDA!'PSORD1 Q
 .N ORARR,MAX D LIST^DIC(100.002,","_PSORDA_",",,"I",,,,,,,"ORARR") S MAX=+ORARR("DILIST",0)
 .F I=1:1 Q:'$D(ORARR("DILIST",2,I))  I ORARR("DILIST",2,I)=PSORD1 Q
 .S:I=MAX PSORD1=0 Q
 Q 1
 ;
ISCLOZ(PSGORD,ORPSOI,DFN,PSGORDNM,PSGDRG) ; Define a clozapine order and associated drug
 ; PSGORD   - Pending Order number (file 53.1)
 ; ORPSOI   - ID containing Pharmacy Orderable Item number (file 50.7)
 ; DFN      - Patient ID (file 2)
 ; PSGORDNM - Pharmacy order number (file 55)
 ; PSGDRG   - Drug Code
 ; OROI     - Orderable Item number (file 101.43)
 N ISCLOZ S ISCLOZ=0
 I $G(PSGORD) D  Q ISCLOZ
 .I '$$GET1^DIQ(53.1,PSGORD,.01,"I") Q
 .S PSGDRG=$$GET1^DIQ(53.11,"1,"_+PSGORD,.01,"I") I PSGDRG D  Q
 ..I $$GET1^DIQ(50,+$G(PSGDRG),17.5)="PSOCLO1" S ISCLOZ=1_U_PSGDRG
 .N ORPSOI S ORPSOI=$$GET1^DIQ(53.1,PSGORD,108,"I") I 'ORPSOI Q
 .D CLOZPSOI(+ORPSOI)
 I $G(ORPSOI) D CLOZPSOI(+ORPSOI) Q ISCLOZ
 I $G(DFN),$G(PSGORDNM) D  Q ISCLOZ
 .S PSGDRG=$$GET1^DIQ(55.07,"1,"_PSGORDNM_","_DFN,.01,"I") I PSGDRG D  Q
 ..I $$GET1^DIQ(50,+$G(PSGDRG),17.5)="PSOCLO1" S ISCLOZ=1_U_PSGDRG
 .N ORPSOI S ORPSOI=$$GET1^DIQ(55.06,PSGORDNM_","_DFN,108,"I") I 'ORPSOI Q
 .D CLOZPSOI(+ORPSOI)
 ;
 I $G(PSGDRG)>0,$$GET1^DIQ(50,$G(PSGDRG),17.5)="PSOCLO1" S ISCLOZ=1_U_PSGDRG
 Q ISCLOZ
 ;
CLOZPSOI(ORPSOI) ; Define a clozapine order based on Pharmacy Orderable item
 N ARR,PSGDRG,CLOZFLG D FIND^DIC(50,,.01,"Q",ORPSOI,,"ASP",,,"ARR")
 N I F I=2:1 Q:'$D(ARR("DILIST",2,I))  S PSGDRG=+$G(ARR("DILIST",2,I)) D  Q:ISCLOZ
 .I $$GET1^DIQ(50,PSGDRG,17.5)="PSOCLO1" S ISCLOZ=1_U_PSGDRG
 Q
 ;
