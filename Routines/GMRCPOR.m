GMRCPOR ;SLC/DCM,DLT - Get DOC,LOC,TS in interactive defaults ;5/20/98  14:20
 ;;3.0;CONSULT/REQUEST TRACKING;**1**;DEC 27, 1997
DEM ;Similiar to load of variables done by ORUDPA
 ;;Call from ^GMRCR0
 S ORVP=DFN_";DPT(",VA200=1
 K VAINDT D OERR^VADPT S GMRCPNM=VADM(1),GMRCSN=VA("PID"),GMRCDOB=$P(VADM(3),"^",2),GMRCAGE=VADM(4),SEX=$P(VADM(5),"^")
 S ORTS=+VAIN(3),ORTS=$S(ORTS:ORTS,1:""),ORNP=+VAIN(2),ORWARD=VAIN(4),GMRCWARD=$P(VAIN(4),"^",2),(GMRCRB,ORL(1))=VAIN(5),(ORL,ORL(0),ORL(2))=""
 I ORNP,'$D(^VA(200,ORNP,0)) S ORNP=""
 S ORPV="" I ORNP,$D(^XUSEC("PROVIDER",ORNP)) S ORPV=ORNP
 S ORATTEND=ORNP
 I $P(ORWARD,"^")?1N.N S X=+ORWARD I $D(^DIC(42,+X,44)) S X=$P(^(44),"^") I X,$D(^SC(X,0)) S ORL=X_";SC(",ORL(0)=$S($L($P(^(0),"^",2)):$P(^(0),"^",2),1:$E($P(^(0),"^"),1,4)),ORL(2)=ORL
 D DOC,LOC,DOC1
 K O,ORL(0),DIC,VA,VAIN,VADM,VAERR,Y
 Q
DOC ;Get the requesting clinician
 S DOC=""
 I ORNP,$D(^VA(200,+ORNP,0)) S X=$P(^(0),"^") S:$P(^ORD(100.99,1,0),"^",15) DOC=X
 I $D(ORATTEND),$D(^VA(200,+ORATTEND,0)) S X=$P(^(0),"^") W !!,"Primary Care Physician is "_X,!
 Q
DOC1 ;Display Requesting Clinician
 W !,?5,"Requesting CLINICIAN : ",$S($L(DOC):DOC,1:"****** missing required information ******")
 Q
LOC ;GET PT. LOCATION
 D INP^VADPT,SDE^VADPT
 D:$L(VAIN(4)) LOC1 S (CT,C)=0,O=1 I $O(^UTILITY("VAEN",$J,0)) W !!,"Currently enrolled in the following clinics: ",!
 S I=0 F  S I=$O(^UTILITY("VAEN",$J,I)) Q:I'>0  S CT=CT+1 W:(CT#2) !?17 W:'(CT#2) ?47 W $P(^UTILITY("VAEN",$J,I,"E"),"^") S C=C+1,C(1)=$P(^("E"),"^") S:C'=1 C=-1
 K I,VAIN
 Q
LOC1 ;Check for patient location
 W !!,?5,"Patient Location     : "_$P(VAIN(4),"^",2) I '$L(VAIN(4)) W "****** missing required information ******"
 Q
