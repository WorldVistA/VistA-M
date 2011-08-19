PXRRPCE3 ;HIN/MjK - Clinic Specific Workload Reports ;6/7/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**121,146**;;Aug 12, 1996
EN ;_._._._._._._.Visit Totals/ Patient Ages/ Unsched Totals_._._._._._.
 ; Z = Visit Dt/Time
 D INITVAR^PXRRPCE5 ;Initialize counter variables
 S (X,Y)=0 F  S X=$O(PXRRCLIN(X)) Q:'X  S Y=Y+1,PXRCLNUM=Y
 S PXRRY=PXRRYR F  S PXRRY=$O(^AUPNVSIT("B",PXRRY)) Q:'PXRRY!((PXRRY>PXRREDT))  S PXRRVIFN=0 F  S PXRRVIFN=$O(^AUPNVSIT("B",PXRRY,PXRRVIFN)) Q:'PXRRVIFN  I $P($G(^AUPNVSIT(PXRRVIFN,0)),U,22)=PXRRCLIN D
 . S X=$P($G(^AUPNVSIT(PXRRVIFN,0)),U,7) Q:X'="A"&(X'="I")&(X'="S")
 . S Z=$P(^AUPNVSIT(PXRRVIFN,0),U),DFN=$P(^AUPNVSIT(PXRRVIFN,0),U,5)
 . ;_._._._._._._._.Demographics - Sessions, Ages_._._._._._._._.
 . S PXRRTVS=PXRRTVS+1 I Z>PXRRBDT S PXRRSESS=$S($D(Z($P(Z,"."))):PXRRSESS,1:PXRRSESS+1),Z($P(Z,"."))=""
 . D AGE
 . ;_._._._._._._._._._All Clinic Patients_._._._._._._._._._
 . S PXRRAPT=$P(Z,".") F  S PXRRAPT=$O(^DPT(DFN,"S",PXRRAPT)) Q:'PXRRAPT!(PXRRAPT>($$FMADD^XLFDT(PXRRAPT,1)))  I $P(^DPT(DFN,"S",PXRRAPT,0),U)=PXRRCLIN S:$P(^DPT(DFN,"S",PXRRAPT,0),U,7)=4 PXRRSXUN=PXRRSXUN+1
 . S ^TMP($J,PXRRCLIN,"PATIENT APPTS",Z,DFN)=""
 . S ^TMP($J,PXRRCLIN,"CLINIC PATIENTS",DFN)=""
 . ;_._._._._._._._._._._._._Diagnoses_._._._._._._._._._._._._.
 . ;B = V POV IEN ; C = ICD Code
 . ;S B="" F  S B=$O(^AUPNVPOV("AD",PXRRVIFN,B)) Q:'B  S C=$P(^ICD9($P(^AUPNVPOV(B,0),U),0),U),C=$S('+C:C,1:+C) S:(C'?1"272.".E)&(C'?1"305.".E) C=$P(C,".") S ^TMP($J,PXRRCLIN,"ICD",Z,C,DFN)="",^TMP($J,PXRRCLIN,"ICD PAT",C,DFN,Z""
 . S B="" F  S B=$O(^AUPNVPOV("AD",PXRRVIFN,B)) Q:'B  S C=$P($$ICDDX^ICDCODE($P(^AUPNVPOV(B,0),U)),U,2),C=$S('+C:C,1:+C) S:(C'?1"272.".E)&(C'?1"305.".E) C=$P(C,".") S ^TMP($J,PXRRCLIN,"ICD",Z,C,DFN)="",^TMP($J,PXRRCLIN,"ICD PAT",C,DFN,Z)=""
MEDAGE ;_._._._._._._._._._._._._._Median Age_._._._._._._._._._._._._._._.
 S X=0 F  S X=$O(^TMP($J,PXRRCLIN,"PATIENT AGE",X)) Q:'X  S DFN=0 F  S DFN=$O(^TMP($J,PXRRCLIN,"PATIENT AGE",X,DFN)) Q:'DFN  D
 . S Y=$G(^TMP($J,PXRRCLIN,"PATIENT AGE",X,DFN))
 . I (Y>PXRRBDT),(Y<PXRREDT) S PXRRAGE=PXRRAGE+1,Y(PXRRAGE)=X
 S PXRRAGE=PXRRAGE\2,PXRRAG=$G(Y(PXRRAGE)) K Y
 ;_._._._._._._._._._._._._._Diagnosis Totals_._._._._._._._._._._._._.
 ;C = ICD ;E = date
 Q:'$D(^TMP($J,PXRRCLIN,"CLINIC PATIENTS"))!'(PXRRSESS)
 F C=272.2,272.4,250,401,414,305.1 S PXRR(C)=0
 S E=0 F  S E=$O(^TMP($J,PXRRCLIN,"ICD",E)) Q:'E  I $D(^TMP($J,PXRRCLIN,"ICD",E,C)) S DFN=0 F  S DFN=$O(^TMP($J,PXRRCLIN,"ICD",E,C,DFN)) Q:'DFN  S PXRR(C)=$S('$D(C(DFN)):PXRR(C)+1,1:PXRR(C)),C(DFN)=""
 K C S E=PXRRBDT F  S E=$O(^TMP($J,PXRRCLIN,"ICD",E)) Q:'E!(E>PXRREDT)  S C=0 F  S C=$O(^TMP($J,PXRRCLIN,"ICD",E,C)) Q:'C  S DFN=0 F  S DFN=$O(^TMP($J,PXRRCLIN,"ICD",E,C,DFN)) Q:'DFN  D
 . I '$D(PXRR(C)) S PXRR(C)=0
 . S PXRR(C)=$S('$D(C(C,DFN)):PXRR(C)+1,1:0),C(C,DFN)=""
 K C S PXRR(272)=PXRR(272.4)+$G(PXRR(272.2)),PXRR(305)=0 F C=305.1:.01:305.13 S PXRR(305)=PXRR(305)+$G(PXRR(C))
 S PXRRDM=$G(PXRR(250)),PXRRHTN=$G(PXRR(401)),PXRRCAD=$G(PXRR(414)),PXRRHLIP=PXRR(272),PXRRSMYR=PXRR(305)
 ;_._._._._._._._._.Diabetes and Hypertensive Patients_._._._._._._._.
 S PXRRHTDM=0,E=PXRRBDT F  S E=$O(^TMP($J,PXRRCLIN,"ICD",E)) Q:'E!(E>PXRREDT)  S DFN=0 F  S DFN=$O(^TMP($J,PXRRCLIN,"ICD",E,250,DFN)) Q:'DFN  I $D(^TMP($J,PXRRCLIN,"ICD PAT",401,DFN)) D
 . S X=PXRRBDT F  S X=$O(^TMP($J,PXRRCLIN,"ICD PAT",401,DFN,X)) Q:'X  I X<PXRREDT S PXRRHTDM=PXRRHTDM+1
 ; _._._._._._._._._._._Smokers with CAD DX_._._._._._._._._._._._._.
 S PXRRCDSM=0,C=304 F  S C=$O(^TMP($J,PXRRCLIN,"ICD PAT",C)) Q:'C!(C>305.13)  S DFN=0 F  S DFN=$O(^(C,DFN)) Q:'DFN  S E=PXRRSXMO F  S E=$O(^(C,DFN,E)) Q:'E  I $D(^TMP($J,PXRRCLIN,"ICD PAT",414,DFN)) S PXRRCDSM=PXRRCDSM+1
HBA1 ; _._._._._._._._._._.HTN AND/OR HBA1C w/ DM DX_._._._._._._._._._._._.
 ;             **Site Specific Entries for Selected Labs**
 S PX=$O(^PX(815,0)),C=250,(DFN,PXRRHBA1)=0,PXRRLED=(9999999.9999999-PXRRSXMO) F  S DFN=$O(^TMP($J,PXRRCLIN,"ICD PAT",C,DFN)) Q:'DFN  D
 .  S PXRLRDFN=$P($G(^DPT(DFN,"LR")),U) Q:'PXRLRDFN  S L=0 F  S L=$O(^PX(815,PX,"RR5",L)) Q:'L  S X=$P(^(L,0),U),X=$P($P(^LAB(60,X,0),U,5),";",2),E=9999999.9999999-DT F  S E=$O(^LR(PXRLRDFN,"CH",E)) Q:'E!(E>PXRRLED)  D
 .. S:+$P($G(^LR(PXRLRDFN,"CH",E,X)),U) PXRRHBA1=PXRRHBA1+$P($G(^LR(PXRLRDFN,"CH",E,X)),U),^TMP($J,PXRRCLIN,"HBA1C",DFN,E)=$P($G(^LR(PXRLRDFN,"CH",E,X)),U)
 S (PXRRHBG7,PXRRHBPT,DFN)=0 F  S DFN=$O(^TMP($J,PXRRCLIN,"HBA1C",DFN)) Q:'DFN  S X=0 F  S X=$O(^TMP($J,PXRRCLIN,"HBA1C",DFN,X)) Q:'X  S PXRRHBPT=PXRRHBPT+1 D
 . I $G(^TMP($J,PXRRCLIN,"HBA1C",DFN,X))>6.99,'$D(X(DFN))  S PXRRHBG7=PXRRHBG7+1
 . S X(DFN)=""
 K X I $G(PXRRHBA1)>0 S PXRRHBA1=PXRRHBA1/PXRRHBPT
 S:'PXRRHBPT PXRRHBA1="N/A",PXRRHBG7=0
SXUTTOT ;_._._._._._._._._.Quality Care & Util 7 other Totals_._._._._._._._.
 D ^PXRRPCE4
 I '$D(^TMP($J,PXRRCLIN,"CLINIC PATIENTS")) S ^TMP($J,PXRRCLIN,"PATIENT","NONE",PXRRCLIN)=""
QT Q
AGE ;_._._._._._._._._._.Calculate a patient's age_._._._._._._._._._.
 I $D(^TMP($J,PXRRCLIN,"CLINIC PATIENTS",DFN)) S X=0 Q
 D DEM^VADPT I VADM(4) S ^TMP($J,PXRRCLIN,"PATIENT AGE",VADM(4),DFN)=Z D KVAR^VADPT
 Q
