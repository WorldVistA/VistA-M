SDECPAT3 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
AGE(DFN,D,F) ;EP - Given DFN, return Age.
 I '$G(DFN) Q -1
 I '$D(^DPT(DFN,0)) Q -1
 I $$DOB^SDECPAT(DFN,"")<0 Q -1
 ;S:$G(D)="" D=DT ;IHS/CMI/LAB - added DOD check patch 8
 S:$G(D)="" D=$S(+$$DOD^SDECPAT3(DFN):$$DOD^SDECPAT3(DFN),1:DT)
 S:$G(F)="" F="Y"
 N %,%1
 S %=$$FMDIFF^XLFDT(D,$$DOB^SDECPAT(DFN,""))
 S %1=%\365.25
 I F="Y" Q %1
 Q $S(%1>2:%1_" YRS",%<31:%_" DYS",1:%\30_" MOS")
 ;
CDEATH(DFN,F) ;EP - returns Cause of Death in F format
 ;F="E":ICD narrative, F="I":ien of icd code, F="C":icd code
 I '$G(DFN) Q ""
 I '$D(^AUPNPAT(DFN)) Q ""
 I '$P($G(^AUPNPAT(DFN,11)),"^",14) Q ""
 I '$D(^ICD9($P(^AUPNPAT(DFN,11),"^",14))) Q ""
 S F=$G(F)
 I F="I" Q $P(^AUPNPAT(DFN,11),"^",14)
 I F="E" Q $P($$ICDDX^ICDCODE($P(^AUPNPAT(DFN,11),"^",14),$S($P($G(^DPT(DFN,.35)),U,1)]"":$P(^DPT(DFN,.35),U,1),1:DT)),"^",2) ;CSV
 Q $P($$ICDDX^ICDCODE($P(^AUPNPAT(DFN,11),"^",14)),"^",2)
 ;
DOB(DFN,F) ;EP - Given DFN, return Date of Birth according to F.
 ; If F="E" produce the External form, else FM format.
 I '$G(DFN) Q -1
 I '$D(^DPT(DFN,0)) Q -1
 S F=$G(F)
 ;beginning Y2K mods - change 2 parameter is FMTE call to 5
 ;Q $S(F="E":$$FMTE^XLFDT($P(^DPT(DFN,0),"^",3)),F="S":$$FMTE^XLFDT($P(^DPT(DFN,0),"^",3),2),1:$P(^DPT(DFN,0),"^",3)) ;Y2000 IHS/CMI/LAB - commented out
 Q $S(F="E":$$FMTE^XLFDT($P(^DPT(DFN,0),"^",3)),F="S":$$FMTE^XLFDT($P(^DPT(DFN,0),"^",3),5),1:$P(^DPT(DFN,0),"^",3))  ;Y2000 IHS/CMI/LAB
 ;end Y2K mods
 ;
DOD(DFN,F) ;EP - Given DFN, return Date of Death according to F.
 ; If F="E" produce the External form, else FM format.
 I '$G(DFN) Q -1
 I '$D(^DPT(DFN,0)) Q -1
 S F=$G(F)
 Q $S(F="E":$$FMTE^XLFDT($P($G(^DPT(DFN,.35)),"^")),1:$P($G(^DPT(DFN,.35)),"^"))
 ;
ELIGSTAT(DFN,F) ;EP - returns eligibility status in F format
 ;F="E":eligibility type (name), F="I":internal set of codes
 I '$G(DFN) Q -1
 I '$D(^AUPNPAT(DFN,11)) Q -1
 S F=$G(F)
 Q $S(F="E":$$EXTSET^SDECFUNC(9000001,1112,$P(^AUPNPAT(DFN,11),"^",12)),1:$P(^AUPNPAT(DFN,11),"^",12))
 ;
HRN(DFN,L,F) ;EP - return HRN at L location
 ;L must be ien of location of encounter
 ;F is optional.  If F=2 hrn will be prefixed with site abbreviation
 I '$G(DFN) Q -1
 I '$D(^AUPNPAT(DFN)) Q -1
 I '$G(L) Q -1
 I $G(F)=2,'$D(^AUTTLOC(L,0)) Q -1
 Q $S($D(^AUPNPAT(DFN,41,L,0)):$S($G(F)=2:$P(^AUTTLOC(L,0),"^",7)_" ",1:"")_$P(^AUPNPAT(DFN,41,L,0),"^",2),1:"")
 Q $P($G(^AUPNPAT(DFN,41,L,0)),"^",2)
 ;
SEX(DFN) ;EP - Given DFN, return Sex.
 I '$G(DFN) Q -1
 I '$D(^DPT(DFN,0)) Q -1
 Q $P(^DPT(DFN,0),"^",2)
 ;
SSN(DFN) ;EP - Given DFN, return SSN.
 I '$G(DFN) Q -1
 I '$D(^DPT(DFN,0)) Q -1
 Q $P(^DPT(DFN,0),"^",9)
