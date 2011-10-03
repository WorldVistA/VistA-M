PXRRPCE2 ;HIN/MjK - Clinic Specfic Workload Reports ;6/7/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**47**;Aug 12, 1996
 ;P = Appointment Date ; N = Patient Name
 S (PXRRTVS,PXRRTPAT)=0 F I=1:1 S PXRRCLIN=$P($G(PXRRCLIN(I)),U) Q:PXRRCLIN=""  S P=0 F  S P=$O(^TMP($J,1,PXRRCLIN,P)) Q:'P  S N=0 F  S N=$O(^TMP($J,1,PXRRCLIN,P,"NM",N)) Q:N=""  S PXRRSSN=$O(^(N,"")) D
 . S ^TMP($J,"PATIENT",$O(^DPT("SSN",PXRRSSN,"")))="",PXRRTVS=PXRRTVS+1
 Q:'$D(^TMP($J,"PATIENT"))
ADM ;_._._._._._._._._._.Admission/Discharge Data_._._._._._._._._._.
 ;A=search begin date ;B=search end date ;C=admission date
 ;F=discharge date    ;R=room-bed
 S PXRRDIFF=$$FMDIFF^XLFDT(PXRREDT,PXRRBDT),A=$P(PXRRBDT,"."),B=$P(PXRREDT,"."),PXRJ=0 F  S PXRJ=$O(^TMP($J,"PATIENT",PXRJ)) Q:'PXRJ  S DFN=PXRJ,PXRRTPAT=PXRRTPAT+1 D  D LAB,ER,FUT
 .  F PXR=1:1:PXRRDIFF S Y=$S(PXR=1:+A,1:$$DTADD(+A,PXR)) S VAIP("D")=Y D IN5^VADPT I (+VAIP(2)=1)!(+VAIP(2)=3) S C=+VAIP(3),F=$S(+VAIP(14,1):+VAIP(14,1),1:"Not Disch"),R=$S(VAIP(6):$P(VAIP(6),U,2),1:"No Room") D ADD^VADPT D
 .. S ^TMP($J,"ADM",DFN,C)=F_U_$P(R,"-")_"-"_$P(R,"-",2)_U_VAPA(1)_U_VAPA(2)_U_VAPA(4)_U_$P(VAPA(5),U,2)_U_VAPA(6)_U_VAPA(8)
Q ;_._._._._._._._._._._._.Return to PXRRPCE_._._._._._._._._._._.
 Q
LAB ;_._._._._._._._._._._._.Critical Lab Data_._._._._._._._._._._.
 S PXRLRDFN=$G(^DPT(DFN,"LR")) Q:'PXRLRDFN  S PXRRG=(9999999.9999999-PXRREDT)  F  S PXRRG=$O(^LR(PXRLRDFN,"CH",PXRRG)) Q:'PXRRG!(PXRRG>(9999999.9999999-PXRRBDT))  S PXRRH=0 D
 .  F  S PXRRH=$O(^LR(PXRLRDFN,"CH",PXRRG,PXRRH)) Q:'PXRRH  I $P($G(^LR(PXRLRDFN,"CH",PXRRG,PXRRH)),U,2)?1A1"*" D FIELD^DID(63.04,PXRRH,"","LABEL","PXRR"),ADD^VADPT D
 .. S ^TMP($J,"LAB",DFN,(9999999.9999999-PXRRG),PXRRH)=PXRR("LABEL")_"= "_$P($G(^LR(PXRLRDFN,"CH",PXRRG,PXRRH)),U)_U_VAPA(1)_U_VAPA(2)_U_VAPA(4)_U_$P(VAPA(5),U,2)_U_VAPA(6)_U_VAPA(8)_U_$P($P($G(^LR(PXRLRDFN,"CH",PXRRG,PXRRH)),U,2),"*")
ER ;_._._._._._._._._._._._._._ER Visits_._._._._._._._._._._._._._
 ;          **Site Specific IENS from file 44 for ER Clinics**
 S PX=$O(^PX(815,0)),Y=0 F  S Y=$O(^PX(815,PX,"RR1",Y)) Q:'Y  S PXRRER=$P(^(Y,0),U),VASD("C",PXRRER)=""
 I $D(PXRRER) S VASD("F")=PXRRBDT,VASD("T")=PXRREDT D SDA^VADPT S PXRRK=0 F  S PXRRK=$O(^UTILITY("VASD",$J,PXRRK)) Q:'PXRRK  S PXRRT=$P(^UTILITY("VASD",$J,PXRRK,"I"),U) D ADD^VADPT D
 .  S ^TMP($J,"ER",DFN,PXRRT)=VAPA(1)_U_VAPA(2)_U_VAPA(4)_U_$P(VAPA(5),U,2)_U_VAPA(6)_U_VAPA(8)
 Q
FUT ;_._._._._._._._._._._._._._Future Visits_._._._._._._._._._._._._._
 ;L = Appointment Date
 D KVAR^VADPT S (L,X1)=DT,X2=90 D C^%DTC S VASD("T")=X D SDA^VADPT
 F PXRRN=1:1:5 I $D(^UTILITY("VASD",$J,PXRRN)) S L=$G(^(PXRRN,"I")) D
 .  S ^TMP($J,"FUT",DFN,$P(L,U))=$P($G(^UTILITY("VASD",$J,PXRRN,"E")),U,2)
 Q
DTADD(X1,X2) ; returns fm date X2 days in future
 ;  X1 = starting date
 ;  X2 = # days to add
 ;
 N X
 D C^%DTC
 Q X
 ;
