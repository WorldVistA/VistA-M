PSOORUT2 ;ISC BHAM/SAB - build listman screen ; 3/20/07 9:47am
 ;;7.0;OUTPATIENT PHARMACY;**11,146,132,182,233,243,261,268,264,305**;DEC 1997;Build 8
 ;External reference to SDPHARM1 supported by DBIA 4196
 ;External reference ^PS(55 supported by DBIA 2228
 ;External reference ^DIC(31 supported by DBIA 658
 ;External reference ^DPT(D0,.372 supported by DBIA 1476
 ;External references to ^ORRDI1 supported by DBIA 4659
 ;External references to ^XTMP("ORRDI" supported by DBIA 4660
 ;
 K ^TMP("PSOHDR",$J),^TMP("PSOPI",$J) S DFN=PSODFN D ^VADPT,ADD^VADPT
 S ^TMP("PSOHDR",$J,1,0)=VADM(1),^TMP("PSOHDR",$J,2,0)=$P(VADM(2),"^",2)
 S ^TMP("PSOHDR",$J,3,0)=$P(VADM(3),"^",2),^TMP("PSOHDR",$J,4,0)=VADM(4),^TMP("PSOHDR",$J,5,0)=$P(VADM(5),"^",2)
 D NVA
 S POERR=1 D RE^PSODEM K POERR
 S ^TMP("PSOHDR",$J,6,0)=$S($P(WT,"^",8):$P(WT,"^",9)_" ("_$P(WT,"^")_")",1:"_______ (______)")
 S ^TMP("PSOHDR",$J,7,0)=$S($P(HT,"^",8):$P(HT,"^",9)_" ("_$P(HT,"^")_")",1:"_______ (______)") K VM,WT,HT S PSOHD=7
 S GMRA="0^0^111" D ^GMRADPT S ^TMP("PSOHDR",$J,8,0)=+$G(GMRAL)
 S $P(^TMP("PSOHDR",$J,9,0)," ",62)="ISSUE  LAST REF DAY"
 S ^TMP("PSOHDR",$J,10,0)=" #  RX #         DRUG                                 QTY ST  DATE  "_$S($G(PSORFG):"RELD",1:"FILL")_" REM SUP"
 D ELIG^VADPT S IEN=1,^TMP("PSOPI",$J,IEN,0)="Eligibility: "_$P(VAEL(1),"^",2)_$S(+VAEL(3):"     SC%: "_$P(VAEL(3),"^",2),1:""),IEN=IEN+1
 S N=0 F  S N=$O(VAEL(1,N)) Q:'N  S $P(^TMP("PSOPI",$J,IEN,0)," ",14)=$P(VAEL(1,N),"^",2),IEN=IEN+1
 S ^TMP("PSOPI",$J,IEN,0)="",^TMP("PSOPI",$J,IEN,0)="RX PATIENT STATUS: "_$$GET1^DIQ(55,PSODFN,3),IEN=IEN+1
 S ^TMP("PSOPI",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)="Disabilities: "
 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I  S I1=$S($D(^DPT(DFN,.372,I,0)):^(0),1:"") D:+I1
 .S PSDIS=$S($P($G(^DIC(31,+I1,0)),"^")]""&($P($G(^(0)),"^",4)']""):$P(^(0),"^"),$P($G(^DIC(31,+I1,0)),"^",4)]"":$P(^(0),"^",4),1:""),PSCNT=$P(I1,"^",2)
 .S:$L(^TMP("PSOPI",$J,IEN,0)_PSDIS_"-"_PSCNT_"% ("_$S($P(I1,"^",3):"SC",1:"NSC")_"), ")>80 IEN=IEN+1,$P(^TMP("PSOPI",$J,IEN,0)," ",14)=" "
 .S ^TMP("PSOPI",$J,IEN,0)=$G(^TMP("PSOPI",$J,IEN,0))_PSDIS_"-"_PSCNT_"% ("_$S($P(I1,"^",3):"SC",1:"NSC")_"), "
 S IEN=IEN+1 S ^TMP("PSOPI",$J,IEN,0)=" ",IEN=IEN+1
 I +VAPA(9) S ^TMP("PSOPI",$J,IEN,0)="      (Temp Address from "_$P(VAPA(9),"^",2)_" till "_$S($P(VAPA(10),"^",2)]"":$P(VAPA(10),"^",2),1:"(no end date)")_")",IEN=IEN+1
 S ^TMP("PSOPI",$J,IEN,0)=VAPA(1) S:VAPA(2)]"" IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)=VAPA(2) S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)=VAPA(3)
 S ^TMP("PSOPI",$J,IEN,0)=^TMP("PSOPI",$J,IEN,0)_$J("",50-$L(VAPA(3)))_"HOME PHONE: "_VAPA(8)
 S PSOTEL=$G(^DPT(DFN,.13))
 S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)=VAPA(4),^TMP("PSOPI",$J,IEN,0)=^TMP("PSOPI",$J,IEN,0)_$J("",50-$L(VAPA(4)))_"CELL PHONE: "_$P(PSOTEL,"^",4)
 S PSOTMP=$P(VAPA(5),"^",2)_"  "_$S(VAPA(11)]"":$P(VAPA(11),"^",2),1:VAPA(6)),IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)=PSOTMP
 S ^TMP("PSOPI",$J,IEN,0)=^TMP("PSOPI",$J,IEN,0)_$J("",50-$L(PSOTMP))_"WORK PHONE: "_$P(PSOTEL,"^",2)
 S MAILD=+$P($G(^PS(55,DFN,0)),"^",3) D  K MAILD
 .S PSOTMP="Prescription Mail Delivery: "_$S(MAILD=1:"Certified Mail",MAILD=2:"DO NOT MAIL",MAILD=3:"Local - Regular Mail",MAILD=4:"Local - Certified Mail",1:"Regular Mail") S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)=PSOTMP
 .I MAILD<2!(MAILD>4) Q  ;ONLY FOR MAIL DELIVERIES 2,3,4
 .N PSOMDEXP,Y
 .S Y=$P($G(^PS(55,DFN,0)),"^",5)
 .I Y,Y'>DT D
 ..D DD^%DT S PSOMDEXP=Y
 ..S ^TMP("PSOPI",$J,IEN,0)=^TMP("PSOPI",$J,IEN,0)_" Expire Date: "_PSOMDEXP
 S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)=$S($P($G(^PS(55,DFN,0)),"^",2):"Cannot use safety caps.",1:"") S $P(^TMP("PSOPI",$J,IEN,0)," ",40)=$S($P($G(^PS(55,DFN,0)),"^",4):"Dialysis Patient.",1:"")
 I $G(^PS(55,DFN,1))]"" S PSON=^(1),IEN=IEN+1 D
 .S ^TMP("PSOPI",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)="     Outpatient Narrative: "
 .F I=1:1 Q:$P(PSON," ",I,99)=""  S:$L(^TMP("PSOPI",$J,IEN,0)_$P(PSON," ",I)_" ")>80 IEN=IEN+1 S ^TMP("PSOPI",$J,IEN,0)=$G(^TMP("PSOPI",$J,IEN,0))_$P(PSON," ",I)_" "
 S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)=" "
 I $D(^PS(52.91,DFN,0)) I '$P(^(0),"^",3)!($P(^(0),"^",3)>DT) D
 .S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)="Primary Care Appointment: "_$$PRIAPT^SDPHARM1(DFN)
 .S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)=" "
 I 'GMRAL D
 .S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)="Allergies: "_$S(GMRAL=0:"NKA",1:"")
 .I GMRAL'=0 S PSONOAL="" D ALLERGY I PSONOAL'="" S ^TMP("PSOPI",$J,IEN,0)="Allergies: "_PSONOAL K PSONOAL
 .S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)=" "
 .D REMOTE
 .S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)="Adverse Reactions:"
 D:$G(GMRAL) ^PSOORUT3
 K ^UTILITY("VASD",$J),VASD S DFN=PSODFN,VASD("F")=DT,VASD("T")=9999999,VASD("W")="123456789" D SDA^VADPT K VASD I $D(^UTILITY("VASD",$J)) D
 .S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)="Pending Clinic Appointments:"
 .F PSOAPP=0:0 S PSOAPP=$O(^UTILITY("VASD",$J,PSOAPP)) Q:'PSOAPP  S PSOAPPE=$G(^UTILITY("VASD",$J,PSOAPP,"E")),PSOAPPI=$G(^("I")) D
 ..K X S X2=DT,X1=$P($P($G(PSOAPPI),"^"),".") I $G(X1) D ^%DTC
 ..S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)="    "_$P(PSOAPPE,"^")_"  "_$P(PSOAPPE,"^",2)_$S($P(PSOAPPI,"^",3)["C":"   *** Canceled ***",1:" ("_$G(X)_" days)")
 K ^UTILITY("VASD",$J),X,PSOAPPI,PSOAPPE,PSOAPP,N
 S PSOPI=IEN K IEN
 Q
NVA ;
 Q:'$O(^PS(55,PSODFN,"NVA",0))
 K LSTDT F I=0:0 S I=$O(^PS(55,PSODFN,"NVA",I)) Q:'I  D
 .Q:$P(^PS(55,PSODFN,"NVA",I,0),"^",7)  Q:'$P(^PS(55,PSODFN,"NVA",I,0),"^")
 .I $P(^PS(55,PSODFN,"NVA",I,0),"^",10)>+$G(LSTDT) S LSTDT=$P(^(0),"^",10)
 I $G(LSTDT)]"" D
 .S LSTDT="Non-VA Meds on File - Last entry on "_$E(LSTDT,4,5)_"/"_$E(LSTDT,6,7)_"/"_$E(LSTDT,2,3)
 .I $G(^TMP("PSOHDR",$J,5,0))="MALE" S $P(^TMP("PSOHDR",$J,5,0)," ",22)=LSTDT K LSTDT Q
 .S $P(^TMP("PSOHDR",$J,5,0)," ",20)=LSTDT K LSTDT
 K I
 Q
REMOTE ;
 I $T(HAVEHDR^ORRDI1)']"" Q
 I '$$HAVEHDR^ORRDI1 Q
 N PSORALG,REAC,S1,A,FILE,LEN,I
 K ^TMP($J,"PSOART")
 S PSORALG=1,PSORALG(1)="No remote data available"
 I $D(^XTMP("ORRDI","OUTAGE INFO","DOWN")) G REMOTE2
 I $T(GET^ORRDI1)]"" S PSOSIEN=$G(IEN) D GET^ORRDI1(DFN,"ART") S IEN=PSOSIEN K PSOSIEN D
 .I $P($G(^XTMP("ORRDI","ART",DFN,0)),"^",3)=0 S PSORALG(1)="No remote allergies"
 .S S1=0,LEN=65,PSORALG=1,PSORALG(1)="" F  S S1=$O(^XTMP("ORRDI","ART",DFN,S1)) Q:'S1  D
 ..S A=$G(^XTMP("ORRDI","ART",DFN,S1,"REACTANT",0)),REAC=$P(A,"^",2),FILE=$P($P(A,"^",3),"99VA",2)
 ..I FILE'=50.6,FILE'=120.82,FILE'=50.605,FILE'=50.416 Q
 ..S ^TMP($J,"PSOART",REAC)=""
 .S REAC="" F  S REAC=$O(^TMP($J,"PSOART",REAC)) Q:REAC=""  D
 ..I $L(PSORALG(PSORALG))+$L(REAC)<LEN S PSORALG(PSORALG)=PSORALG(PSORALG)_REAC_", " Q
 ..S PSORALG=PSORALG+1,PSORALG(PSORALG)="              "_REAC_", ",LEN=76
 .I PSORALG(PSORALG)]"",$E(PSORALG(PSORALG),$L(PSORALG(PSORALG)))="," S PSORALG(PSORALG)=$E(PSORALG(PSORALG),1,$L(PSORALG(PSORALG))-1)
REMOTE2 ;
 S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)="      Remote: "_$G(PSORALG(1)) D
 .F I=2:1:PSORALG S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)=PSORALG(I)
 K ^TMP($J,"PSOART")
 Q
  ;
ALLERGY ;ALLERGIES & REACTIONS
 N GMRA,GMRAL,PSORY,ALCNT,EEE,PSOLG,PSOLGA,TEXT,CCC,CCC2
 K ^TMP($J,"PSOALWA")
 I '$D(DFN) S DFN=PSODFN
 S GMRA="0^0^111" D ^GMRADPT
 I $G(GMRAL) S PSORY=0 F  S PSORY=$O(GMRAL(PSORY)) Q:'PSORY  S ^TMP($J,"PSOALWA",$S($P(GMRAL(PSORY),"^",4):1,1:2),$S('$P(GMRAL(PSORY),"^",5):1,1:2),$P(GMRAL(PSORY),"^",7),$P(GMRAL(PSORY),"^",2))=""
 S ^TMP($J,"PSOAPT",1)=$G(PNM)_"  "_$G(SSNP),^(2)="Verified Allergies"
 S ALCNT=0,EEE=0,(PSOLG,PSOLGA)="" F  S PSOLG=$O(^TMP($J,"PSOALWA",1,1,PSOLG)) Q:PSOLG=""  F  S PSOLGA=$O(^TMP($J,"PSOALWA",1,1,PSOLG,PSOLGA)) Q:PSOLGA=""  S EEE=1,ALCNT=ALCNT+1,^TMP($J,"PSOAPT",2,ALCNT)=PSOLGA
 I 'EEE,$G(GMRAL)=0 S ALCNT=ALCNT+1,^TMP($J,"PSOAPT",2,ALCNT)="NKA"
 S ALCNT=0,^TMP($J,"PSOAPT",3)="Non-Verified Allergies"
 S EEE=0,(PSOLG,PSOLGA)="" F  S PSOLG=$O(^TMP($J,"PSOALWA",2,1,PSOLG)) Q:PSOLG=""  F  S PSOLGA=$O(^TMP($J,"PSOALWA",2,1,PSOLG,PSOLGA)) Q:PSOLGA=""  S EEE=EEE+1,ALCNT=ALCNT+1,^TMP($J,"PSOAPT",3,ALCNT)=PSOLGA
 I 'EEE,$G(GMRAL)=0 S ALCNT=ALCNT+1,^TMP($J,"PSOAPT",3,ALCNT)="NKA"
 S ALCNT=0,^TMP($J,"PSOAPT",4)="Verified Adverse Reactions"
 S (PSOLG,PSOLGA)="" F  S PSOLG=$O(^TMP($J,"PSOALWA",1,2,PSOLG)) Q:PSOLG=""  F  S PSOLGA=$O(^TMP($J,"PSOALWA",1,2,PSOLG,PSOLGA)) Q:PSOLGA=""  S ALCNT=ALCNT+1,^TMP($J,"PSOAPT",4,ALCNT)=PSOLGA
 S ALCNT=0,^TMP($J,"PSOAPT",5)="Non-Verified Adverse Reactions"
 S (PSOLG,PSOLGA)="" F  S PSOLG=$O(^TMP($J,"PSOALWA",2,2,PSOLG)) Q:PSOLG=""  F  S PSOLGA=$O(^TMP($J,"PSOALWA",2,2,PSOLG,PSOLGA)) Q:PSOLGA=""  S ALCNT=ALCNT+1,^TMP($J,"PSOAPT",5,ALCNT)=PSOLGA
 S TEXT=^TMP($J,"PSOAPT",1) D CHKNO(TEXT)
 F CCC=3,4,5 I '$O(^TMP($J,"PSOAPT",CCC,0)) K ^TMP($J,"PSOAPT",CCC)
 D PSONOAL
 I CCC="NKA" S ^TMP($J,"PSOAPT",2,1)="No Known Allergies" K ^TMP($J,"PSOAPT",3)
 S CCC=1,OUT=0
 F  S CCC=$O(^TMP($J,"PSOAPT",CCC)) Q:CCC=""  D  Q:OUT
 .S TEXT=$G(^TMP($J,"PSOAPT",CCC))
 .I TEXT="No Allergy Assessment" S PSONOAL=TEXT Q
 .S (TEXT,CCC2)="",LENGTH=0
 .F  S CCC2=$O(^TMP($J,"PSOAPT",CCC,CCC2)) Q:CCC2=""  S TEXT=^(CCC2) D CHKNO(TEXT)
 K ^TMP($J,"PSOALWA"),^TMP($J,"PSOAPT")
 Q
CHKNO(T) ;
 I T="No Allergy Assessment" S PSONOAL=T
 Q
PSONOAL ;
 N FLG3,FLG4,FLG5
 S CCC=$G(^TMP($J,"PSOAPT",2,1))
 S FLG3=$G(^TMP($J,"PSOAPT",3,1))
 S FLG4=$G(^TMP($J,"PSOAPT",4,1))
 S FLG5=$G(^TMP($J,"PSOAPT",5,1))
 I CCC="",FLG3="",FLG4="",FLG5="" S ^TMP($J,"PSOAPT",2,1)="No Allergy Assessment" K ^TMP($J,"PSOAPT",3)
 Q
