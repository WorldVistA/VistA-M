VADPT3 ;ALB/MRL - PATIENT VARIABLES [IN5]; 12 DEC 1988 ; 7/22/03 5:00pm
 ;;5.3;Registration;**532,749**;Aug 13, 1993;Build 10
 ;Inpatient variables [Version 5.0 and above]
6 ;
 S (NOW,VAX("DAT"))=$$NOW^XLFDT,NOWI=9999999.999999-NOW
 ;
 I $D(VAIP("E")),$D(^DGPM(+VAIP("E"),0)) S VAX("DT")=+^(0),E=+VAIP("E") G GO ;Specific Entry
 ;
 I $D(VAIP("D")),"^l^L^"[("^"_$E(VAIP("D"))_"^") D LAST G GO:E,Q
 ;
 S VAX=$S($D(VAIP("D")):VAIP("D"),$D(VAINDT):VAINDT,1:0)
 I VAX S:VAX?7N!(VAX?7N1".".N) VAX("DT")=VAX I '$D(VAX("DT")) G Q ;Invalid Entry
 ;
 S:'$D(VAX("DT")) VAX("DT")=NOW
 I VAX("DT")=VAX("DAT") S E=$S($D(^DPT(DFN,.102)):+^(.102),1:0),E=$S($D(^DGPM(E,0)):E,1:0) G GO:E D LODGER G GO:E D ASIHOF G GO:E,Q ;Current IP
 ;
 ;Find Past Movement
 S VAX=+$O(^DGPM("APID",DFN,9999999.999999-VAX("DT"))) I 'VAX D LODGER G GO:E,Q
 S VAX=+$O(^DGPM("APID",DFN,VAX,0)) I '$D(^DGPM(VAX,0)) D LODGER G GO:E,Q
 S VAZ=^DGPM(VAX,0) D OK G GO:E D LODGER G GO:E,Q
 ;
GO S:'$D(VAX("DT")) VAX("DT")=NOW D ^VADPT31 ; setting of VAX("DT") can be removed??
 ;
Q K NOW,NOWI,VAX,VAZ,VAZ2,E,VACC,VAQ,VANN,VASET,^UTILITY("VADPTZ",$J,DFN) D KVAR^VADPT30 Q
 ;
OK N VAADT,VADDT,VAQUIT
 S E=0,VAZ2="^"_(+$P(VAZ,"^",18))_"^"
 I "^13^41^46^"[VAZ2 D OK1 Q:'VAX  G OK
 I "^42^"[VAZ2 D 42 I 'Y D OK1 Q:'VAX  G OK
 I "^47^"[VAZ2 D 47 I 'Y D OK1 Q:'VAX  G OK
 I $D(VAX("DT")),$P(VAZ,"^",2)=3,VAZ'>VAX("DT") Q
 ;DG*5.3*532
 ;Check for out-of-order disch. recs caused by same day adm./disch.
 ;where disch. date < adm. date because disch. date had no time
 I +VAZ<2890000,$D(VAX("DT")),$P(VAZ,"^",2)'=3 S VAQUIT=0 D  Q:VAQUIT
 .S VAADT=$P(VAZ,"^",14) Q:'VAADT
 .S VADDT=$P($G(^DGPM(VAADT,0)),"^",17) Q:'VADDT
 .S VADDT=$P($G(^DGPM(VADDT,0)),"^",14) I $P(VADDT,".",2)="",VADDT=$P(VAADT,"."),VAZ'>VAX("DT") S VAQUIT=1
 S E=+VAX Q
 ;
OK1 S VAX=+$O(^DGPM("APID",DFN,9999999.9999999-(VAZ+($P(VAZ,"^",22)/10000000)))),VAX=+$O(^(VAX,0))
 I VAX,$D(^DGPM(VAX,0)) S VAZ=^(0)
 Q
 ;
LAST ; returns last movement for patient
 ; called by bed control and pt inquiry
 S VAX=+$O(^DGPM("APID",DFN,NOWI)),E=0
 I $D(VAIP("L")) D LLDCHK G LASTQ:E
 S VAX=+$O(^DGPM("APID",DFN,VAX,0)) I $D(^DGPM(VAX,0)) S VAZ=^(0) D OK
LASTQ S VAX("DT")=NOW
 Q
 ;
LODGER ;
 S E=0 G LODGERQ:'$D(VAIP("L"))
 I VAX("DT")=VAX("DAT") S VAX=$S($D(^DPT(DFN,.107)):^(.107),1:"") G LODGERQ:VAX']"" S E=$S($D(^DPT("LD",VAX,DFN)):+^(DFN),1:0) G LODGERQ
 ;
 S VAX=$O(^DGPM("ATID4",DFN,9999999.999999-VAX("DT"))) S:VAX E=+$O(^DGPM("ATID4",DFN,VAX,0))
 I E S E=$S($D(^DGPM(E,0)):E,1:0) I E,$D(^DGPM(+$P(^(0),"^",17),0)),^(0)'>VAX("DT") S E=0
LODGERQ Q
 ;
LLDCHK ; -- last lodger mvt checking ; build array of inverse dates and chk
 N IDT S IDT(VAX)=0
 S IDT=+$O(^DGPM("ATID4",DFN,NOWI)) S:IDT IDT(IDT)=+$O(^(IDT,0))
 S IDT=+$O(^DGPM("ATID5",DFN,NOWI)) S:IDT IDT(IDT)=+$O(^(IDT,0))
 S IDT=+$O(IDT(0)) I IDT S E=IDT(IDT),E=$S($D(^DGPM(E,0)):E,1:0)
 Q
 ; 
CHK ;
 G VAR^VADPT30
 ;
ASIHOF ; -- is last mvt asih oth fac
 S E=0,VAX=$S('$O(^DGPM("APID",DFN,NOWI)):"",1:$O(^DGPM("APID",DFN,$O(^(NOWI)),0)))
 I VAX,$D(^DGPM(VAX,0)),"^43^45^"[("^"_$P(^(0),"^",18)_"^") S E=VAX
 Q
 ;
42 ; -- check to see if this mvt can be used; for 'while asih' d/c category
 ;   If Y returned high then mvt is good
 ;
 I VAZ'<VAX("DAT") S Y=0 G Q42 ; not a real d/c yet
 I $P(VAZ,"^",22)=2 S Y=0 G Q42 ; nhcu d/c assoicated w/asih d/c (seq #2)
 D SCAN
Q42 Q
 ;
SCAN ; -- determine is d/c while in other fac(Y=1 returned if so.)
 ;
 N VAID,VACA,M S Y=0,VAID=9999999.999999-VAZ,VACA=+$P(VAZ,"^",14)
 F VAID=VAID:0 S VAID=$O(^DGPM("APMV",DFN,VACA,VAID)) Q:'VAID  I $D(^DGPM(+$O(^(VAID,0)),0)) S M=$P(^(0),"^",18) I "^13^44^43^45^"[("^"_M_"^") S Y=$S(M=43!(M=45):1,1:0) Q
 Q
 ;
47 ; -- check to see if d/c from nhcu while asih in other fac
 ;   If y returned high then mvt is good.
 D SCAN Q
 ;
 ; 13 = to asih (vah)     (xfr)|44 = resume asih in parent facility (xfr)
 ; 41 = from asih         (d/c)|45 = change asih location(other fac)(xfr)
 ; 42 = while asih        (d/c)|46 = continues asih (other fac)     (d/c)
 ; 43 = to asih(other fac)(xfr)|47 = discharge from nhcu while asih (d/c)
