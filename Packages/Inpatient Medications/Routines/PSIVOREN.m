PSIVOREN ;BIR/MLM-UTILITIES FOR IV FLUIDS - OE/RR INTERFACE ; 8/10/09 7:12am
 ;;5.0; INPATIENT MEDICATIONS ;**3,18,69,110,127,133,140,134,207**;16 DEC 97;Build 31
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^VA(200 is supported by DBIA 10060.
 ; Reference to ^DIE is supported by DBIA 10018.
 ;
ENCPP ; Check Package Parameter
 D ORPARM I 'PSJORF W !!,"Inpatient Medications is not turned on for OE/RR.",!,"You will not be able to enter or edit IV or Unit Dose orders."
 I 'PSJIVORF W !!,"IV Medications is not turned on for OE/RR.",!,"You will not be able to enter or edit IV orders."
 I 'PSJORF!'PSJIVORF S PSJIVORF="" D DONE^PSIVORA1 Q
 S PSJORL=$G(VAIN(4)) I 'PSJORL,$G(DFN) D INP^VADPT S PSJORL=$G(VAIN(4))
 S PSJORPF=0,P("OT")="F^",PSJORNP=$S($G(PSJORNP):PSJORNP,1:+$G(DUZ))
 Q
 ;
PS ; Check if MD is authorized to write med. orders.
 S PSJORPF=0 S:PSJORNP X=$G(^VA(200,+PSJORNP,"PS")) Q:$S('PSJORNP:0,'X:0,'$P(X,U,4):1,$P(X,U,4)>DT:1,1:0)  D
 .W !?2,"(The selected PROVIDER is NOT qualified to write MEDICATION orders.  You must",!,"select a valid provider to be able to continue with Inpatient Medications.)"
 .K DIC S DIC="^VA(200,",DIC(0)="AEMQZ",DIC("A")="Select PHARMACY PROVIDER: ",DIC("S")="S PSIV=$G(^(""PS"")) I PSIV,$S($P(PSIV,""^"",4)="""":1,DT<$P(PSIV,""^"",4):1,1:0)" F  W ! D ^DIC Q:$D(DUOUT)!$D(DTOUT)!(Y>0)  W $C(7),"  (Required.)"
 .K DIC S:Y'>0 PSJORPF=11 S:Y>0 PSJORNP=+Y Q
 K DTOUT
 Q
 ;
RUPDATE(DFN,ON,NSTRT) ;
 ; Update renewal orders (called from Pharmacy options).
 N DA,DIE,DR,ND,NSTOP,OSTOP,NOO,ORETURN,PSIVACT,PSIVAL,PSIVALCK,PSJOSTRT,PSGOLDOE S DIE="^PS(55,"_DFN_","
 I ON["P" S OLDON=$P($G(^PS(53.1,+ON,0)),"^",25),NOO=$P($G(^PS(53.1,+ON,.2)),"^",3)
 I ON["V" S OLDON=ON,NOO=$P($G(^PS(55,DFN,"IV",+ON,.2)),"^",5)
 I ON["U" S OLDON=$P($G(^PS(55,DFN,5,+ON,0)),U,25)
 I OLDON["P" S OLDON=$P($G(^PS(53.1,+OLDON,0)),U,25)
 I OLDON["V" S ON55=OLDON,X=$G(^PS(55,DFN,"IV",+OLDON,2)),PSJOSTRT=$P(X,U,7),OSTOP=$S(($G(PSJOSTOP)>PSJOSTRT):PSJOSTOP,1:$P($G(^(0)),U,3)),DIE=DIE_"""IV"",",DR="100////A",PSIVACT=1
 I OLDON["U" S X=$G(^PS(55,DFN,5,+OLDON,2)),PSJOSTRT=$P(X,U,7),OSTOP=$P(X,U,4),DIE=DIE_"5,"
 S NSTOP=+$S($G(P(3)):P(3),1:0),DA=+OLDON,DA(1)=DFN I 'NSTOP W !,"CAN'T RENEW THIS ORDER!" D PAUSE^VALM1 Q
 ;
 I ON["V"!(ON["P") D EXPOE^PSGOER(DFN,ON)
 ;
 S DR=DR_";"_$S(OLDON["V":.03,OLDON["U":34,1:25)_"////"_NSTOP_";"_$S(OLDON["V":"114////@;123////@",1:"105////@;107////@") S:+$G(P(6))?1.30N DR=DR_";.06////"_+P(6) D ^DIE
 I $G(P("OPI"))'="" S ^PS(55,DFN,"IV",+OLDON,3)=P("OPI")
 I ON["P" S DIE="^PS(53.1,",DR="28////A;105////@;",DA=+ON D ^DIE D
 .I $G(OLDON)["V" S PSGOLDOE=$P($G(^PS(55,DFN,"IV",+OLDON,0)),"^",21)
 .N NOEORD,VN,VNDT S NOEORD=$P(^PS(53.1,+ON,0),U,21) S VN=$P($G(^PS(53.1,+ON,4)),"^") I VN S VNDT=$P($G(^PS(53.1,+ON,4)),"^",2)
 .I NOEORD K DA,DR,DIE S DIE="^PS(55,"_DFN_",""IV"",",DA(1)=DFN,DA=+ON55,DR="110////"_+NOEORD D
 ..S DR=DR_";16////"_$S($G(VN):VN,1:"@")_";17////"_$S($G(VNDT):VNDT,1:"@")_";" D ^DIE I NOEORD[";" S $P(^PS(53.1,+ON,0),U,21)=NOEORD
 ..I $G(VN) D EN1^PSJHL2(DFN,"ZV",ON55)
 I ON["V" S DIE="^PS(55,DFN,""IV"",",DR="100////A;114////@;16////@;17////@" S DA=+ON55 D ^DIE
 N RDT S RDT=$P($G(@("^PS(53.1,"_+ON_",14,0)")),U,3) S:RDT RDT=+(^(RDT,0)) S RDT=$S(RDT:RDT,1:$$DATE^PSJUTL2) I RDT D UPDREN^PSIVOPT2(DFN,OLDON,RDT,+P(6),+$G(OSTOP),$G(NOO))
 ;
 I ON["V" D EN1^PSJHL2(DFN,"SN",ON,"NEW ORDER CREATED")
 I OLDON["V" S (ON,ON55)=OLDON,PSIVAL="",PSIVALCK="STOP",(P("FRES"),PSIVREA)="R" D LOG^PSIVORAL D
 .I $G(ON55),$G(OSTOP),$G(DFN) D STIX(OSTOP,OLDON,DFN)
 .;Add check to If statement below. If New Stop date ='s the old Stop Don't delete AIV x-ref (NSTOP'=PSJOSTOP)
 .I $G(PSJOSTOP),$G(NSTOP) I NSTOP=$P($G(^PS(55,DFN,"IV",+ON55,0)),"^",3),$D(^PS(55,"AIV",NSTOP,DFN,+ON55)),NSTOP'=PSJOSTOP K ^PS(55,"AIV",PSJOSTOP,DFN,+ON55)
 D:'$D(PSJIVORF) ORPARM Q:'PSJIVORF
 Q
 ;
RUPTXT(DFN,OLDON) ;
 ;Update ORTX( in OE/RR
 I OLDON'["V" ;; D ENUDTX^PSJOREN(DFN,OLDON,"OR") S ORIFN=$P($G(^PS(55,DFN,"IV",+OLDON,0)),U,21)
 I OLDON["V" S P("FRES")="R" D GTPC^PSIVORFB(OLDON),SORTX^PSIVORFE S ORIFN=$P($G(^PS(55,DFN,"IV",+OLDON,0)),U,21)
 Q
 ;
ORPARM ;Check if inpatient pkges are on.
 S (PSJORF,PSJIVORF)=1
 Q
 ;
NATURE ; Ask nature of order.
 Q:$G(PSJDCTYP)=2
 I '+$G(PSJSYSU) S P("NAT")="W" Q
 K P("NAT") NEW X
 I $D(XQORNOD(0)) S X=$E($P(XQORNOD(0),U,3),1,1) S:X="" X="E"
 S:'$D(X) X="N" S:"AF"[X X="E"
 I $G(PSIVCOPY) S X="N"
 S P("NAT")=$$ENNOO^PSJUTL5(X)
 K:P("NAT")=-1 P("NAT")
 Q
CLINIC ;Ask clinic where outpt is being seen for DSS
 K P("CLIN") NEW X1,X2,X,PSJDT,DIC,Y
 S X1=DT,X2=-7 D C^%DTC S PSJDT=X
 S DIC("S")="I $P($G(^SC(Y,0)),U,3)=""C"",$S('$P($G(^(""I"")),U):1,($P($G(^(""I"")),U)>PSJDT):1,(($P($G(^(""I"")),U)<PSJDT)&($P($G(^(""I"")),U,2)]"""")&(DT>$P($G(^(""I"")),U,2))):1,1:0)"
 S DIC=44,DIC(0)="QEAZ",DIC("A")="Select CLINIC LOCATION: " D ^DIC
 I $S($D(DTOUT):1,$D(DUOUT):1,1:0) Q
 S:+Y>0 P("CLIN")=+Y,$P(^PS(55,DFN,"IV",+ON55,"DSS"),"^")=+Y
 Q
 ;
STIX(OST,OON,DFN) ; Check start index, cleanup old start
 I $G(OST),$G(OON) S OS="" F  S OS=$O(^PS(55,DFN,"IV","AIS",OS)) Q:'OS  D
 . Q:'$D(^PS(55,DFN,"IV","AIS",OS,+OON))
 . I $P($G(^PS(55,DFN,"IV",+OON,0)),"^",3)'=OS K ^PS(55,DFN,"IV","AIS",OS,+OON)
 Q
