PSOORUT2 ;BIR/SAB - Build Listman Screen ;Jan 05, 2021@12:08
 ;;7.0;OUTPATIENT PHARMACY;**11,146,132,182,233,243,261,268,264,305,390,411,402,500,556,622**;DEC 1997;Build 44
 ;External reference to $$PRIAPT^SDPHARM1 supported by DBIA 4196
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ^DIC(31 supported by DBIA 658
 ;External reference to ^ORRDI1 supported by DBIA 4659
 ;External reference to ^DPT(DFN,.372 supported by DBIA 1476
 ;External reference to ^XTMP("ORRDI" supported by DBIA 4660
 ;External reference to ^GMRADPT supported by DBIA 10099
 ;External reference to $$TERMLKUP^ORB31 supported by DBIA 5140
 ;External reference to $$BSA^PSSDSAPI supported by DBIA 5425
 ;External reference to ^ORQQVI supported by DBIA 5770
 ;External reference to ^ORQQLR1 supported by DBIA 5787
 ;External reference to ^VADPT supported by DBIA 10061
 ;
 K ^TMP("PSOHDR",$J),^TMP("PSOPI",$J) S DFN=PSODFN D ^VADPT,ADD^VADPT
 N I1,PSCNT,PSDIS,PSON,PSOTEL,PSOTMP
 S ^TMP("PSOHDR",$J,1,0)=VADM(1),^TMP("PSOHDR",$J,2,0)=$P(VADM(2),"^",2)
 S ^TMP("PSOHDR",$J,3,0)=$P(VADM(3),"^",2),^TMP("PSOHDR",$J,4,0)=VADM(4),^TMP("PSOHDR",$J,5,0)=$P(VADM(5),"^",2)
 D NVA
 S POERR=1 D RE^PSODEM K POERR
 S ^TMP("PSOHDR",$J,6,0)=$S($P(WT,"^",8):$P(WT,"^",9)_" ("_$P(WT,"^")_")",1:"_______ (______)")
 S ^TMP("PSOHDR",$J,7,0)=$S($P(HT,"^",8):$P(HT,"^",9)_" ("_$P(HT,"^")_")",1:"_______ (______)") K VM,WT,HT S PSOHD=7
 S GMRA="0^0^111" D ^GMRADPT S ^TMP("PSOHDR",$J,8,0)=+$G(GMRAL)
 S $P(^TMP("PSOHDR",$J,9,0)," ",62)="ISSUE  LAST REF DAY"
 S ^TMP("PSOHDR",$J,10,0)=" #  RX #         DRUG                                 QTY ST  DATE  "_$S($G(PSORFG):"RELD",1:"FILL")_" REM SUP"
 ;
 ;  Display CrCl/BSA - show serum creatinine if CrCl can't be calculated
 S PSOBSA=$$BSA^PSSDSAPI(DFN),PSOBSA=$P(PSOBSA,"^",3),PSOBSA=$S(PSOBSA'>0:"_______",1:$J(PSOBSA,4,2)) S ^TMP("PSOHDR",$J,12,0)=PSOBSA
 S RSLT=$$CRCL(DFN)
 ; RSLT -- DATE^CRCL^Serum Creatinine -- Ex.  11/25/11^68.7^1.1
 ; Display format of CrCL and Creatinine results updated - PSO*7.0*556
 I ($P($G(RSLT),"^",2)["Not Found")&($P($G(RSLT),"^",3)<.01) S ZDSPL="  CrCL: "_$P(RSLT,"^",2)_" (CREAT: Not Found)"
 I ($P($G(RSLT),"^",2)["Not Found")&($P($G(RSLT),"^",3)>=.01) S ZDSPL="  CrCL: "_$P(RSLT,"^",2)_"  (CREAT: "_$P($G(RSLT),"^",3)_"mg/dL "_$P($G(RSLT),"^")_")"
 I ($P($G(RSLT),"^",2)'["Not Found")&($P($G(RSLT),"^",3)<.01) S ZDSPL="  CrCL: "_$P(RSLT,"^",2)_" (CREAT: Not Found)"
 I ($P($G(RSLT),"^",2)'["Not Found")&($P($G(RSLT),"^",3)>=.01) S ZDSPL="  CrCL: "_$P(RSLT,"^",2)_"(est.)"_" (CREAT: "_$P($G(RSLT),"^",3)_"mg/dL "_$P($G(RSLT),"^")_")"
 S ^TMP("PSOHDR",$J,13,0)=$G(ZDSPL)
 S ^TMP("PSOHDR",$J,14,0)=$$POSTSHRT^WVRPCOR(PSODFN)
 ;
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
 K ^UTILITY("VASD",$J),X,PSOAPPI,PSOAPPE,PSOAPP,N,PSOBSA,ZDSPL,RSLT
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
 ..S A=$G(^XTMP("ORRDI","ART",DFN,S1,"GMRALLERGY",0))
 ..S REAC=$P(A,"^",2) Q:REAC=""
 ..S FILE=$P($P(A,"^",3),"99VA",2)
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
 N GMRA,GMRAL,PSORY,ALCNT,EEE,PSOLG,PSOLGA,TEXT,CCC,CCC2,LENGTH
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
 N OUT S CCC=1,OUT=0
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
CRCL(DFN) ;
 N HTGT60,ABW,IBW,BWRATIO,BWDIFF,LOWBW,ADJBW,X1,X2,RSLT,PSCR,PSRW,ABW,ZHT,PSRH,PSCXTL,PSCXTLS,SCR,SCRD,OCXT,OCXTS,SCRV,ZAGE,ZSERUM,SEX
 S RSLT="0^<Not Found>"
 S PSCR="^^^^^^0"
 S PSCXTL="" Q:'$$TERMLKUP^ORB31(.PSCXTL,"SERUM CREATININE") RSLT
 S PSCXTLS="" Q:'$$TERMLKUP^ORB31(.PSCXTLS,"SERUM SPECIMEN") RSLT
 S SCR="",OCXT=0 F  S OCXT=$O(PSCXTL(OCXT)) Q:'OCXT  D
 .S OCXTS=0 F  S OCXTS=$O(PSCXTLS(OCXTS)) Q:'OCXTS  D
 ..S SCR=$$LOCL^ORQQLR1(DFN,$P(PSCXTL(OCXT),U),$P(PSCXTLS(OCXTS),U))
 ..I $P(SCR,U,7)>$P(PSCR,U,7) S PSCR=SCR
 S SCR=PSCR,SCRV=$P(SCR,U,3) Q:+$G(SCRV)<.01 RSLT
 S SCRD=$P(SCR,U,7) Q:'$L(SCRD) RSLT
 S RSLT=SCRD_"^<Not Found>^"_$P($G(SCR),"^",3)
 S X1=$P(RSLT,"^"),X2=$$FMTE^XLFDT(X1,"2M"),$P(RSLT,"^")=$P(X2,"@") K X1,X2
 D VITAL^ORQQVI("WEIGHT","WT",DFN,.PSRW,0,"",$$NOW^XLFDT)
 Q:'$D(PSRW) RSLT
 S ABW=$P(PSRW(1),U,3) Q:+$G(ABW)<1 RSLT
 S ABW=ABW/2.2046226  ;ABW (actual body weight) in kg; changed 2.2 to 2.2046226 per CQ 10637 ; PSO 402
 D VITAL^ORQQVI("HEIGHT","HT",DFN,.PSRH,0,"",$$NOW^XLFDT)
 Q:'$D(PSRH) RSLT
 S ZHT=$P(PSRH(1),U,3) Q:+$G(ZHT)<1 RSLT
 N VADM D DEM^VADPT S ZAGE=$G(VADM(4)) Q:'$L(ZAGE) RSLT
 ;S ZAGE=$$AGE^ORQPTQ4(DFN) Q:'ZAGE RSLT
 S SEX=$P($G(VADM(5)),"^") Q:'$L(SEX) RSLT
 ;S SEX=$P($$SEX^ORQPTQ4(DFN),U,1) Q:'$L(SEX) RSLT
 I '$G(ABW)!($G(ZHT)<1)!'$G(ZAGE)!'$D(SEX) Q RSLT
 S SCRD=$P(SCR,U,7) Q:'$L(SCRD) RSLT
 S HTGT60=$S(ZHT>60:(ZHT-60)*2.3,1:0)  ;if ht > 60 inches
 I HTGT60>0 D
 .S IBW=$S(SEX="M":50+HTGT60,1:45.5+HTGT60)  ;Ideal Body Weight
 .S BWRATIO=(ABW/IBW)  ;body weight ratio
 .S BWDIFF=$S(ABW>IBW:ABW-IBW,1:0)
 .S LOWBW=$S(IBW<ABW:IBW,1:ABW)
 .I BWRATIO>1.3,(BWDIFF>0) S ADJBW=((0.3*BWDIFF)+IBW)
 .E  S ADJBW=LOWBW
 I +$G(ADJBW)<1 D
 .S ADJBW=ABW
 S CRCL=(((140-ZAGE)*ADJBW)/(SCRV*72))
 S:SEX="M" RSLT=SCRD_U_$J(CRCL,1,1)
 S:SEX="F" RSLT=SCRD_U_$J((CRCL*.85),1,1)
 S X1=$P(RSLT,"^"),X2=$$FMTE^XLFDT(X1,"2M"),$P(RSLT,"^")=$P(X2,"@") K X1,X2
 S $P(RSLT,"^",3)=$P($G(SCR),"^",3)
 K HTGT60,ABW,IBW,BWRATIO,BWDIFF,LOWBW,ADJBW,X1,X2,PSCR,PSRW,ABW,ZHT,PSRH,ZAGE,PSCXTL,PSCXTLS,SCR,OCXT,OCXTS,SCRV,CRCL,ZSERUM
 Q RSLT
