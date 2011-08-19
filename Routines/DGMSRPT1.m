DGMSRPT1 ;ALB/LBD,BRM - Military Service Inconsistency Report; 01/05/04 ; 5/18/04 9:53am
 ;;5.3;Registration;**562,603**; Aug 13,1993
 ;
 ; This routine scans the Patient file #2 and checks military service
 ; data for inconsistencies.  The inconsistencies are stored in 
 ; ^XTMP("DSMSRPT"). 
 Q
EN ; Entry point called from ^DGMSRPT
 ; Initialize ^XTMP global and set start date
 S ^XTMP("DGMSRPT",0)=$$FMADD^XLFDT(DT,60)_U_DT_U_"DG MILITARY SERVICE INCONSISTENCY REPORT"
 S $P(^XTMP("DGMSRPT","DATE"),U,1)=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 S:$G(ZTSK) ZTREQ="@"
 D INIT^DGMSRPT
 ; Loop through Patient file #2.  If patient meets report criteria, check
 ; military service data for inconsistencies.
 N DFN
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:'DFN  I $$CHK(DFN)  D MSINC(DFN)
 ; Send message containing inconsistency counts, update stop date/time
 S $P(^XTMP("DGMSRPT","DATE"),U,2)=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 D MSG^DGMSRPT(DGXTMP)
 K ^XTMP("DGMSRPT","RUNNING"),DGXTMP
 Q
CHK(DFN) ; Check if patient meets criteria to include in report
 ; OUTPUT: 1=Meets report criteria; 0=Doesn't meet report criteria
 N CHK,ENR,ENRDT,UE,UESITE,SITE
 S CHK=0 I '$G(DFN) Q CHK
 ; Patient is a veteran
 I $P($G(^DPT(DFN,"VET")),U)'="Y" Q CHK
 ; Patient not deceased
 I +$G(^DPT(DFN,.35)) Q CHK
 ; Primary eligibility not 'Humanitarian Emergency', 'Sharing Agreement',
 ; or 'Employee'
 I "^8^9^14^"[(U_+$G(^DPT(DFN,.36))_U) Q CHK
 ; User Enrollee of this facility
 S UE=$P($G(^DPT(DFN,.361)),U,7) I UE="" Q CHK
 S UESITE=$P($G(^DPT(DFN,.361)),U,8) I +UESITE=0 Q CHK
 S SITE=$P($$SITE^VASITE,U,3),SITE=$$PSITE^EASUER(SITE)
 I $P($G(^DIC(4,UESITE,99)),U)'=$P($G(^DIC(4,SITE,99)),U) Q CHK
 ; Has a current enrollment record
 I '$G(^DPT(DFN,"ENR")) Q CHK
 ; Meets report criteria
 S CHK=1
 Q CHK
MSINC(DFN) ; Check military service data for inconsistencies.
 N DGMS,NAM,SSN
 Q:'$G(DFN)
 ; Get veteran's military service data
 D GETMS(DFN,.DGMS)
 ; Check Military Service Episodes
 D MSECHK(DFN,.DGMS)
 ; Check Combat and POW data
 D CMPWCHK(DFN,.DGMS)
 ; Check Conflict data
 D CONFCHK(DFN,.DGMS)
 ; If inconsistencies were found, add 0 node and x-refs
 I $D(@DGXTMP@(DFN)) D
 .S NAM=$P($G(^DPT(DFN,0)),U,1),SSN=$P($G(^DPT(DFN,0)),U,9)
 .S @DGXTMP@(DFN,0)=NAM_U_SSN
 .I NAM'="" S @DGXTMP@("NAM",NAM,DFN)=""
 .I SSN'="" S @DGXTMP@("SSN",+$E(SSN,8,9),+$E(SSN,6,9),+SSN,DFN)=""
 .D SETCNT("VET")
 Q
GETMS(DFN,DGMS) ; Build DGMS array of military service data
 ; OUTPUT: DGMS(CATEGORY,FIELD) - array of Military Service data
 N MS,I,CAT,FLD
 Q:'$G(DFN)
 F I=.32,.321,.322,.52 S MS(I)=$G(^DPT(DFN,I))
 S CAT="MSE1^MSE2^MSE3",FLD="DIS^BOS^FDT^TDT^NUM"
 D ARRY(CAT,FLD,.32,4,18,.MS,.DGMS)
 I $P(MS(.32),U,19)'="Y" K DGMS("MSE2")  ;Delete data for inactive MSE
 I $P(MS(.32),U,20)'="Y" K DGMS("MSE3")  ;Delete data for inactive MSE
 S CAT="LEB^GREN^PAN^GULF",FLD="IND^FDT^TDT"
 D ARRY(CAT,FLD,.322,1,12,.MS,.DGMS)
 S CAT="SOM^YUG"
 D ARRY(CAT,FLD,.322,16,21,.MS,.DGMS)
 S CAT="VIET",FLD="IND"
 D ARRY(CAT,FLD,.321,1,1,.MS,.DGMS)
 S FLD="FDT^TDT"
 D ARRY(CAT,FLD,.321,4,5,.MS,.DGMS)
 S CAT="POW",FLD="IND^LOC^FDT^TDT"
 D ARRY(CAT,FLD,.52,5,8,.MS,.DGMS)
 S CAT="COM"
 D ARRY(CAT,FLD,.52,11,14,.MS,.DGMS)
 Q
ARRY(CAT,FLD,SB,P1,P2,MS,DGMS) ; Set array
 ; INPUT: CAT - MS categories (e.g. MSE1 = 1st Military Service Episode)
 ;        FLD - MS fields (e.g. FDT = From Date, TDT = To Date)
 ;        SB - MS array subscript
 ;        P1 - Starting piece in MS string
 ;        P2 - Ending piece in MS string
 ;        MS( - Array with MS data from the Patient file
 ; OUTPUT: DGMS( - Array returned with MS data grouped by category
 N I,J,K
 S J=1,K=0
 F I=P1:1:P2 D
 .I K=$L(FLD,U) S J=J+1,K=0
 .S K=K+1
 .I $P(MS(SB),U,I)'="" S DGMS($P(CAT,U,J),$P(FLD,U,K))=$P(MS(SB),U,I)
 Q
MSECHK(DFN,DGMS) ; Check military service episodes for inconsistencies
 N DGTXT,CAT,DG,OVR,BOS,WWIIDT,WWIIS,WWIIE
 ; Is there MSE data for this veteran?
 I '$D(DGMS("MSE1")),'$D(DGMS("MSE2")),'$D(DGMS("MSE3")) Q
 F CAT="MSE1","MSE2","MSE3" K DGTXT S DG=1 I $D(DGMS(CAT)) D
 .; Check Branch of Service (B.E.C. and Merchant Seaman)
 .S BOS=+$G(DGMS(CAT,"BOS")),BOS=$P($G(^DIC(23,BOS,0)),U,1)
 .I BOS="B.E.C." S DGTXT="BEC" D SETTXT(.DG,.DGTXT),SETCNT(2)
 .I BOS="MERCHANT SEAMAN" D
 ..S WWIIDT=$$GETCNFDT^DGRPDT("WWIIP"),WWIIS=$P(WWIIDT,U),WWIIE=$P(WWIIDT,U,2)
 ..Q:$$WITHIN^DGRPDT(WWIIS,WWIIE,$G(DGMS(CAT,"FDT")))
 ..Q:$$WITHIN^DGRPDT(WWIIS,WWIIE,$G(DGMS(CAT,"TDT")))
 ..Q:$$RWITHIN^DGRPDT($G(DGMS(CAT,"FDT")),$G(DGMS(CAT,"TDT")),WWIIS,WWIIE)
 ..S DGTXT="MERC SEA NO WWII SVC" D SETTXT(.DG,.DGTXT),SETCNT(3)
 .; Check for missing data
 .I $$MISS(CAT,"BOS^DIS^FDT^TDT") S DGTXT="DATA MISS" D SETTXT(.DG,.DGTXT),SETCNT(4)
 .; Check for imprecise dates (year only)
 .I $$IMPR(CAT,"FDT^TDT") S DGTXT="DT IMPR" D SETTXT(.DG,.DGTXT),SETCNT(5)
 .; Check if To Date is before From Date
 .I $G(DGMS(CAT,"FDT")),$G(DGMS(CAT,"TDT")),$$B4^DGRPDT(DGMS(CAT,"TDT"),DGMS(CAT,"FDT")) D
 ..S DGTXT="END DT BEFORE START DT" D SETTXT(.DG,.DGTXT),SETCNT(6)
 .; Check if dates overlap with another MSE
 .S OVR=$$OVRLP(CAT) I OVR S DGTXT="DT OVRLP W/ "_$P(OVR,U,2) D SETTXT(.DG,.DGTXT),SETCNT(7)
 .;If inconsistencies found, update ^XTMP("DGMSRPT","MSINC",DFN,
 .I $D(DGTXT) D SETVET(DFN,CAT,.DGTXT)
 Q
CMPWCHK(DFN,DGMS) ; Check Combat and POW data for inconsistencies
 ; INPUT: DFN - Patient file IEN
 ;        DGMS( - MS data array
 N DGTXT,CAT,DG,LOC
 F CAT="COM","POW" K DGTXT S DG=1 I $G(DGMS(CAT,"IND"))="Y" D
 .; Check for missing data
 .I $$MISS(CAT,"FDT^TDT^LOC") S DGTXT="DATA MISS" D SETTXT(.DG,.DGTXT),SETCNT($S(CAT="COM":8,1:16))
 .; Check for imprecise dates (year only)
 .I $$IMPR(CAT,"FDT^TDT") S DGTXT="DT IMPR" D SETTXT(.DG,.DGTXT),SETCNT($S(CAT="COM":9,1:17))
 .; Check if dates are valid for the location
 .I $G(DGMS(CAT,"LOC")) S LOC=$$LOC(DGMS(CAT,"LOC")) I LOC'="" D
 ..Q:$$CNFLCTDT^DGRPDT($G(DGMS(CAT,"FDT")),$G(DGMS(CAT,"TDT")),LOC)
 ..S DGTXT="DT INVALID FOR LOC" D SETTXT(.DG,.DGTXT),SETCNT($S(CAT="COM":10,1:18))
 .; Check if dates are within a Military Service Episode
 .I $G(DGMS(CAT,"FDT"))!($G(DGMS(CAT,"TDT"))) D
 ..Q:$$OVRLPCHK^DGRPDT(DFN,$G(DGMS(CAT,"FDT")),$G(DGMS(CAT,"TDT")),-1)
 ..S DGTXT="DT NOT W/IN MSE" D SETTXT(.DG,.DGTXT),SETCNT($S(CAT="COM":11,1:19))
 .;If inconsistencies found, update ^XTMP("DGMSRPT","MSINC",DFN,
 .I $D(DGTXT) D SETVET(DFN,CAT,.DGTXT)
 Q
CONFCHK(DFN,DGMS) ; Check Conflict data for inconsistencies
 N DGTXT,CAT,DG
 F CAT="VIET","LEB","GREN","PAN","GULF","SOM","YUG" K DGTXT S DG=1 I $G(DGMS(CAT,"IND"))="Y" D
 .; Check for missing data
 .I $$MISS(CAT,"FDT^TDT") S DGTXT="DATA MISS" D SETTXT(.DG,.DGTXT),SETCNT(12)
 .; Check for imprecise dates (year only)
 .I $$IMPR(CAT,"FDT^TDT") S DGTXT="DT IMPR" D SETTXT(.DG,.DGTXT),SETCNT(13)
 .; Check if dates are valid for the location
 .I $G(DGMS(CAT,"FDT"))!($G(DGMS(CAT,"TDT"))) D
 ..Q:$$CNFLCTDT^DGRPDT($G(DGMS(CAT,"FDT")),$G(DGMS(CAT,"TDT")),CAT)
 ..S DGTXT="DT INVALID FOR LOC" D SETTXT(.DG,.DGTXT),SETCNT(14)
 .; Check if dates are within a Military Service Episode
 .I $G(DGMS(CAT,"FDT"))!($G(DGMS(CAT,"TDT"))) D
 ..Q:$$OVRLPCHK^DGRPDT(DFN,$G(DGMS(CAT,"FDT")),$G(DGMS(CAT,"TDT")),-1)
 ..S DGTXT="DT NOT W/IN MSE" D SETTXT(.DG,.DGTXT),SETCNT(15)
 .;If inconsistencies found, update ^XTMP("DGMSRPT","MSINC",DFN,
 .I $D(DGTXT) D SETVET(DFN,CAT,.DGTXT)
 Q
SETTXT(DG,DGTXT) ; Set array of MS inconsistency text DGTXT(
 ; INPUT: DG - Subscript for DGTXT array
 Q:'$G(DG)
 I $G(DGTXT(DG))="" S DGTXT(DG)=DGTXT Q
 I $L(DGTXT(DG)_"; "_DGTXT)>36 S DG=DG+1,DGTXT(DG)=DGTXT Q
 S DGTXT(DG)=DGTXT(DG)_"; "_DGTXT
 Q
SETVET(DFN,CAT,DGTXT) ; Update ^XTMP("DGMSRPT","MSINC",DFN, with MS inconsistencies for veteran
 ;
 Q:'$G(DFN)  Q:'$D(CAT)  Q:'$D(DGTXT)
 N DG S DG=0
 F  S DG=$O(DGTXT(DG)) Q:'DG  S @DGXTMP@(DFN,CAT,DG)=DGTXT(DG)
 Q
SETCNT(SUB) ; Update ^XTMP("DGMSRPT","MSINC","CNT",
 ; INPUT: SUB - Subscript in ^("CNT") array to increment
 Q:$G(SUB)=""
 S $P(@DGXTMP@("CNT",SUB),U,1)=+(@DGXTMP@("CNT",SUB))+1
 Q
MISS(CAT,FLD) ; Check for missing data elements
 ; INPUT: CAT - MS category, 1st subscript in DGMS array
 ;        FLD - List of fields to check for missing data
 ; OUTPUT: 1=Missing data; 0=No missing data
 N MISS,I,X
 S MISS=0
 I $G(CAT)=""!($G(FLD)="") Q MISS
 F I=1:1 S X=$P(FLD,U,I) Q:X=""  I '$D(DGMS(CAT,X)) S MISS=1 Q
 Q MISS
IMPR(CAT,FLD) ; Check for imprecise dates (year only)
 ; INPUT: CAT - MS category, 1st subscript in DGMS array
 ;        FLD - List of fields to check for imprecise dates
 ; OUTPUT: 1=Imprecise date; 0=No imprecise date
 N IMPR,I,X
 S IMPR=0
 I $G(CAT)=""!($G(FLD)="") Q IMPR
 F I=1:1 S X=$P(FLD,U,I) Q:X=""  I $D(DGMS(CAT,X)),'$$MNTHYR^DGRPDT(DGMS(CAT,X)) S IMPR=1 Q
 Q IMPR
OVRLP(CAT) ; Check if MSE dates overlap with another MSE
 ; INPUT: CAT - MS category, 1st subscript in DGMS array
 ; OUTPUT: 0=No overlap; 1^X=Overlap^MSE that overlaps
 N OVR,MSE,DGI,DGX
 S OVR=0
 I $G(CAT)="" Q OVR
 S DGX=$E(CAT,4)
 ; If MSE1, no check; if MSE2, check overlap with MSE1; if MSE3, check
 ; overlap with MSE2 or MSE1
 F DGI=(DGX-1):-1:1 S MSE="MSE"_DGI I $D(DGMS(MSE)) D  Q:OVR
 .S OVR=$$WITHIN^DGRPDT($G(DGMS(CAT,"FDT")),$G(DGMS(CAT,"TDT")),$G(DGMS(MSE,"FDT"))) I OVR S OVR=+OVR_U_MSE Q
 .S OVR=$$WITHIN^DGRPDT($G(DGMS(CAT,"FDT")),$G(DGMS(CAT,"TDT")),$G(DGMS(MSE,"TDT"))) I OVR S OVR=+OVR_U_MSE Q
 Q OVR
LOC(LN) ; Return conflict location abbreviation to pass to $$CNFLCTDT^DGRPDT
 ; INPUT: LN - POW Location file #22 IEN
 ; OUTPUT: Conflict location abbreviation
 Q:'$G(LN) ""
 S LN=$P($G(^DIC(22,LN,0)),U,1) I LN="" Q ""
 Q:LN="WORLD WAR I" "WWI"
 Q:LN["EUROPE" "WWIIE"
 Q:LN["PACIFIC" "WWIIP"
 Q:LN["KOREA" "KOR"
 Q:LN["VIETNAM" "VIET"
 Q:LN="OTHER" ""
 Q:LN["GULF" "GULF"
 Q:LN["YUGOSLAVIA" "YUG"
 Q ""
