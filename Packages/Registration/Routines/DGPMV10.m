DGPMV10 ;ALB/MRL/MIR - PATIENT MOVEMENT, CONT.; 11 APR 89 ; 4/15/03 5:48pm
 ;;5.3;Registration;**84,498,509,683,719**;Aug 13, 1993
CS ;Current Status
 ;first print primary care team/practitioner/attending
 D PCMM^SCRPU4(DFN,DT)
 S X=$S('DGPMT:1,DGPMT<4:2,DGPMT>5:2,1:3) ;DGPMT=0 if from pt inq (DGRPD)
 I '$D(^DGPM("C",DFN)) W !!,"Status      : PATIENT HAS NO INPATIENT OR LODGER ACTIVITY IN THE COMPUTER",*7 D CS2 Q
 S A=$S("^3^5^"[("^"_+DGPMVI(2)_"^"):0,1:+DGPMVI(2)) W !!,"Status      : ",$S('A:"IN",1:""),"ACTIVE ",$S("^4^5^"[("^"_+DGPMVI(2)_"^"):"LODGER",1:"INPATIENT")
 G CS1:'A W "-" S X=+DGPMVI(4) I X=1 W "on PASS" G CS1
 I "^2^3^25^26^"[("^"_X_"^") W "on ",$S("^2^26^"[X:"A",1:"U"),"A" G CS1
 I "^13^43^44^45^"[("^"_X_"^") W "ASIH" G CS1
 I X=6 W "OTHER FAC" G CS1
 W "on WARD"
CS1 I +DGPMVI(2)=3,$D(^DGPM(+DGPMVI(17),0)) W ?39,"Discharge Type : ",$S($D(^DG(405.1,+$P(^(0),"^",4),0)):$P(^(0),"^",1),1:"UNKNOWN")
 I "^3^4^5^"'[("^"_+DGPMVI(2)_"^"),$D(^DPT(DFN,"DAC")),($P(^("DAC"),"^",1)="S") W "  (Seriously ill)"
 W ! I +DGPMVI(19,1) W "Patient chose not to be included in the Facility Directory for this admission"
 W !,$S("^4^5^"'[("^"_+DGPMVI(2)_"^"):"Admitted    ",1:"Checked-in  "),": "_$P(DGPMVI(13,1),"^",2)
 W ?39,$S("^4^5^"[("^"_+DGPMVI(2)_"^"):"Checked-out",+DGPMVI(2)=3:"Discharged ",1:"Transferred"),"    : ",$S("^1^4^"'[("^"_+DGPMVI(2)_"^"):$P(DGPMVI(3),"^",2),$P(DGPMVI(3),"^",2)'=$P(DGPMVI(13,1),"^",2):$P(DGPMVI(3),"^",2),1:"")
 W !,"Ward        : ",$E($P(DGPMVI(5),"^",2),1,24),?39,"Room-Bed       : ",$E($P(DGPMVI(6),"^",2),1,21) I "^4^5^"'[("^"_+DGPMVI(2)_"^") W !,"Provider    : ",$E($P(DGPMVI(7),"^",2),1,26),?39,"Specialty      : ",$E($P(DGPMVI(8),"^",2),1,21)
 W !,"Attending   : ",$E($P(DGPMVI(18),"^",2),1,26)
 D CS2
 S DGPMIFN=DGPMVI(13) I +DGPMVI(2)'=4&(+DGPMVI(2)'=5) D ^DGPMLOS W !!,"Admission LOS: ",+$P(X,"^",5),"  Absence days: ",+$P(X,"^",2),"  Pass Days: ",+$P(X,"^",3),"  ASIH days: ",+$P(X,"^",4)
 K A,C,I,J,X
 Q
 ;
CS2 ;-- additional fields for admission screen
 Q:DGPMT'=1
 S DGHOLD=$S($D(^DPT(DFN,0)):^(0),1:"")
 W !!,"Religion    : ",$S($D(^DIC(13,+$P(DGHOLD,U,8),0)):$E($P(^(0),U),1,24),1:"")
 W ?39,"Marital Status : ",$S($D(^DIC(11,+$P(DGHOLD,U,5),0)):$P(^(0),U),1:"")
 S DGHOLD=$S($D(^DPT(DFN,.36)):$P(^(.36),U),1:"")
 W !,"Eligibility : ",$S($D(^DIC(8,+$P(DGHOLD,U),0)):$P(^(0),U),1:"")
 S DGHOLD=$S($D(^DPT(DFN,.361)):^(.361),1:"")
 W:$P(DGHOLD,U)]"" " (",$P($P($P(^DD(2,.3611,0),U,3),$P(DGHOLD,U)_":",2),";"),")"
 W:$P(DGHOLD,U)']"" " (NOT VERIFIED)"
 K DGHOLD
 Q
 ;
LODGER ;set-up necessary variables if getting last lodger episode
 ;only need 1,2,13,17 - date/time,TT,check-in IFN,check-out IFN
 S I=$O(^DGPM("ATID4",DFN,0)),I=$O(^(+I,0))
 S X=$S($D(^DGPM(+I,0)):^(0),1:"") I 'X D NULL Q
 I $D(^DGPM(+$P(X,"^",17),0)) S (DGPMDCD,DGPMVI(1))=+^(0),DGPMVI(2)=5,DGPMVI(13)=I,DGPMVI(17)=$P(X,"^",17) Q
 S (DGPMDCD,DGPMVI(17))="",DGPMVI(1)=+X,DGPMVI(2)=4,DGPMVI(13)=I
 Q
NULL S DGPMDCD="" F I=1,2,13,17 S DGPMVI(I)=""
 Q
 ;
INP ;set-up inpt vbls needed (mimic VAIP array)
 ;
 ;Called from scheduling, too
 ;
 D NOW^%DTC S (VAX("DAT"),NOW)=%,NOWI=9999999.999999-% I '$D(VAIP("E")) D LAST^VADPT3
 F I=1:1:8,13,17 S DGPMVI(I)=""
 F I=13,19 S DGPMVI(I,1)=""
 S DGPMVI(1)=$S($D(VAIP("E")):VAIP("E"),1:E) ;use ifn of last mvt from VADPT call or one passed from DGPMV
 S DGX=$G(^DGPM(+DGPMVI(1),0)),DGPMVI(2)=$P(DGX,"^",2),DGPMVI(4)=$P(DGX,"^",18) S Y=+DGX X ^DD("DD") S DGPMVI(3)=$P(DGX,"^",1)_"^"_Y
 S DGPMVI(5)=$P(DGX,"^",6)_"^"_$S($D(^DIC(42,+$P(DGX,"^",6),0)):$P(^(0),"^",1),1:""),DGPMVI(6)=$P(DGX,"^",7)_"^"_$S($D(^DG(405.4,+$P(DGX,"^",7),0)):$P(^(0),"^",1),1:""),DGPMVI(13)=$P(DGX,"^",14)
 I "^3^5^"[("^"_DGPMVI(2)_"^") D GETWD ;get from ward if d/c or check-out
 S DGX=$G(^DGPM(+DGPMVI(13),0)) I DGX]"" S Y=+DGX X ^DD("DD") S DGPMVI(13,1)=$P(DGX,"^",1)_"^"_Y,DGPMVI(17)=$P(DGX,"^",17) I $D(DGPMSVC) S DGPMSV=$P($G(^DIC(42,+$P(DGX,"^",6),0)),"^",3)
 S DGPMDCD=$S($D(^DGPM(+DGPMVI(17),0)):$P(^(0),"^",1),1:"")
 S (DGTS,DGPP,DGAP)="" ;t.s., primary care physician, attending
 F I=NOWI:0 S I=$O(^DGPM("ATS",DFN,+DGPMVI(13),I)) Q:'I  F J=0:0 S J=$O(^DGPM("ATS",DFN,+DGPMVI(13),I,J)) Q:'J  F IFN=0:0 S IFN=$O(^DGPM("ATS",DFN,+DGPMVI(13),I,J,IFN)) Q:'IFN  D TS1 G TSQ:DGTS&DGPP&DGAP
TSQ S DGPMVI(7)=DGPP,DGPMVI(8)=DGTS,DGPMVI(18)=DGAP
 S DGX=$G(^DGPM(+DGPMVI(13),0)) I $P(DGX,"^",2)=1 D
 .S DGX=$G(^DGPM(+DGPMVI(13),"DIR"))
 .S DGX=$P(DGX,"^",1)
 .I DGX="" S DGX=$S('DGPMDCD:1,(DGPMDCD<3030414.999999):"",1:1) Q:DGX=""
 .S DGPMVI(19,1)=DGX_"^"_$$EXTERNAL^DILFD(405,41,,DGX)
 D Q^VADPT3 K DGAP,DGPP,DGTS,DGX,IFN
 Q
 ;
TS1 ; set DGTS, DGPP, and DGAP
 Q:'$D(^DGPM(IFN,0))  S DGX=^(0)
 I 'DGPP,$D(^VA(200,+$P(DGX,"^",8),0)) S Y=$P(DGX,"^",8)_"^"_$P(^(0),"^") S DGPP=Y
 I 'DGAP,$D(^VA(200,+$P(DGX,"^",19),0)) S Y=$P(DGX,"^",19)_"^"_$P(^(0),"^") S DGAP=Y
 I 'DGTS,$D(^DIC(45.7,+$P(DGX,"^",9),0)) S DGTS=$P(DGX,"^",9)_"^"_$P(^(0),"^")
 Q
GETWD ;get the from ward if last mvt is discharge or check-out
 I DGPMVI(2)=5 S J=DGPMVI(13) D SETWD Q
 F I=0:0 S I=$O(^DGPM("APMV",DFN,DGPMVI(13),I)) Q:'I!+DGPMVI(5)  F J=0:0 S J=$O(^DGPM("APMV",DFN,DGPMVI(13),I,J)) Q:'J  D SETWD Q:+DGPMVI(5)
 Q
 ;
SETWD ;set ward and room-bed variables for discharge/check-out mvts
 S X=$G(^DGPM(J,0))
 I $D(^DIC(42,+$P(X,"^",6),0)) S DGPMVI(5)=$P(X,"^",6)_"^"_$P(^(0),"^",1)
 I $D(^DG(405.4,+$P(X,"^",7),0)) S DGPMVI(6)=$P(X,"^",7)_"^"_$P(^(0),"^",1)
 Q
