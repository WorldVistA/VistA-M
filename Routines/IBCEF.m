IBCEF ;ALB/TMP - FORMATTER SPECIFIC BILL FUNCTIONS ;22-JAN-96
 ;;2.0;INTEGRATED BILLING;**52,80,51,137,288,296,361,371**;21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;IBIFN = bill ien throughout this routine
COB(IBIFN) ; Bill seq
 N A
 S A=$P($G(^DGCR(399,IBIFN,0)),U,21) S:A="" A="P"
 Q A
 ;
COBN(IBIFN,A) ; Return seq # of selected payer
 ; A = 'PST' or null to get current bill payer seq #
 I $G(A)="" S A=$$COB(IBIFN) S:"PST"'[A A="P"
 I 'A S A=$F("PST",A)-1 S:A<1 A=1
 Q A
 ;
POLICY(IBIFN,IBPC,IBCOBN) ; Return raw data from policy info on bill
 ; IBPC  = pc # of data element in policy (optional)
 ;          if null, 0-node is returned
 ; IBCOBN = bill designation 1-3 or 'PST' (optional)
 ;          if null, default to current
 N IBI
 I "PST"[$G(IBCOBN) S IBCOBN=$$COBN(IBIFN,$G(IBCOBN))
 S IBI=$G(^DGCR(399,IBIFN,"I"_IBCOBN))
 I $G(IBPC) S IBI=$P(IBI,U,IBPC)
POLICYQ Q IBI
 ;
INSADDR(IBIFN,IBCOB) ; Return insured's address in 7 pieces:
 ; ALL STREET ADDRESSES^CITY^STATE ABBREVIATION^ZIP^STREET ADDRESS 1^
 ;  STREET ADDRESS 2^STREET ADDRESS 3
 ; IBIFN = bill ien
 ; IBCOB = bill designation (P)rimary, (S)econdary, (T)ertiary
 ;          or 1-2-3. If not defined or null, return current
 ; If insured is patient or spouse, take from patient file top level
 ;   fields, then if top-level street addresses are blank and policy
 ;   level fields are not, use policy level
 ; If insured is other than patient/spouse, use policy level fields only
 N A,B,IBADDR,IBI,DFN,VAPA,VATEST
 S:$G(IBCOB)="" IBCOB=""
 I 'IBCOB S IBCOB=$$COBN(IBIFN,$G(IBCOB))
 S IBI=+$$POLICY(IBIFN,16,IBCOB)     ; pt relationship to insured
 S DFN=+$P($G(^DGCR(399,IBIFN,0)),U,2)
 I $S('IBI:1,1:"12"'[IBI) S IBADDR="" G INSADDQ
 ; insured's address (patient/spouse) same as patient's
 S VATEST("ADD",9)=+$G(^DGCR(399,IBIFN,"U")),VATEST("ADD",10)=+$P($G(^("U")),U,2)
 D ADD^VADPT
 S IBADDR=VAPA(1)_" "_VAPA(2)_" "_VAPA(3)_U_VAPA(4)_U_$P($G(^DIC(5,+VAPA(5),0)),U,2)_U_VAPA(6)_U_VAPA(1)_U_VAPA(2)_U_VAPA(3)
INSADDQ S A=$P($G(^DGCR(399,IBIFN,"M")),U,(11+IBCOB))
 S A=$G(^DPT(DFN,.312,+A,3))
 I $TR($P(IBADDR,U)," ")="" D PI3
 I IBI=2,$$NOPUNCT($P(A,U,6,10),1)'="" D PI3
 Q IBADDR
 ;
PI3 ; build IBADDR string from patient insurance 3 node data
 S $P(IBADDR,U,1)=$P(A,U,6)_" "_$P(A,U,7)
 S $P(IBADDR,U,5,6)=$P(A,U,6,7)
 F B=2,4 S $P(IBADDR,U,B)=$P(A,U,B+6)
 S $P(IBADDR,U,3)=$P($G(^DIC(5,+$P(A,U,9),0)),U,2)
 S $P(IBADDR,U,7)=""   ; no street address 3 in file 2.312
 Q
 ;
PTADDR(IBIFN,ELE) ;Return part of patient's permanent address
 ;IBIFN = bill ien
 ;ELE = subscript in ^UTILITY("VAPA", array for element needed
 ;
 I '$D(^UTILITY("VAPA",$J)) D  ; once per pt
 .N VAHOW,DFN,VAPA
 .S VAHOW=2,DFN=+$P($G(^DGCR(399,IBIFN,0)),U,2),VAPA("P")=""
 .D ADD^VADPT
 Q $P($G(^UTILITY("VAPA",$J,ELE)),U)
 ;
PTDEM(IBIFN,ELE,PC) ;Return part of patient's demographics
 ;IBIFN = bill ien
 ;ELE = subscript in ^UTILITY("VADM" array for demographic element needed
 ;PC = pc of string at subscript ELE to be returned
 ;
 I '$G(PC) S PC=1
 I '$D(^UTILITY("VADM",$J)) D  ; once per pt
 .N VAHOW,DFN,VADM
 .S VAHOW=2,DFN=+$P($G(^DGCR(399,IBIFN,0)),U,2)
 .D DEM^VADPT
 Q $P($G(^UTILITY("VADM",$J,ELE)),U,PC)
 ;
PTEMPL(IBIFN,ELE,WHOSE,VAOA) ;Return part of pt's or spouse's employer info
 ;ELE = subscript in VAOA array for employer element needed
 ;WHOSE = 6 if spouse's info needed  5 if pt info needed (DEFAULT)
 ;
 N DFN
 S DFN=+$P($G(^DGCR(399,IBIFN,0)),U,2),VAOA("A")=$S($G(WHOSE):WHOSE,1:5)
 D OAD^VADPT
 Q $P($G(VAOA(ELE)),U)
 ;
INSDEM(IBIFN,IBCOB) ; Return insured's demographics in 6 pieces:
 ; DATE OF BIRTH^SEX^PHONE^BRANCH pointer^RANK^SSN(no dashes)
 ; IBIFN = bill ien
 ; IBCOB = bill designation (P)rimary (default), (S)econdary, (T)ertiary
 ;          or 1,2,3 ... if not defined or null, return current
 ; If insured is patient/spouse, take from patient file top level
 ;   fields, then if top-level are blank and policy level aren't,
 ;   use policy level
 ; If insured other than patient/spouse, use policy level fields only
 N A,B,IBDEM,IBI,DFN,VADM
 S:$G(IBCOB)="" IBCOB=""
 S:'IBCOB IBCOB=$$COBN(IBIFN,IBCOB)
 S IBI=$$WHOSINS(IBIFN,IBCOB)
 S DFN=+$P($G(^DGCR(399,IBIFN,0)),U,2)
 I $S('IBI:1,1:"12"'[IBI) S IBDEM="" G INSDEM1
 ; If it gets here, assume insured is patient/spouse
 S A=$$PTDEM(IBIFN,0),A=$$PTADDR(IBIFN,0)
 F A=2,3,5 S VADM(A)=$P($G(^UTILITY("VADM",$J,A)),U)
 S VAPA(8)=$P($G(^UTILITY("VAPA",$J,8)),U)
 I VADM(5)="",'VADM(3),VAPA(8)="" S IBDEM="" G INSDEM1
 S $P(IBDEM,U,3)=VAPA(8),$P(IBDEM,U,6)=VADM(2)
 I IBI=1,VADM(3) S $P(IBDEM,U)=VADM(3) ;Patient's own policy only
INSDEM1 S A=$P($G(^DGCR(399,IBIFN,"M")),U,(11+IBCOB))
 S A=$G(^DPT(DFN,.312,+A,3))
 S:"MF"'[$G(VADM(5)) VADM(5)=""
 S $P(IBDEM,U,2)=$S(IBI=1:VADM(5),1:$P(A,U,12))
 S $P(IBDEM,U,4,5)=$P(A,U,2)_U_$P(A,U,3)
 S:'$P(IBDEM,U) $P(IBDEM,U)=$P(A,U)
 S:$P(IBDEM,U,3)="" $P(IBDEM,U,3)=$P(A,U,11)
 S:$P(IBDEM,U,6)="" $P(IBDEM,U,6)=$P(A,U,5)
 Q IBDEM
 ;
INSEMPL(IBIFN,IBCOB) ; Return insured's employer data in 5 pieces:
 ; EMPLOYER NAME^EMPLOYER CITY^EMPLOYER STATE ABBREVIATION^STATE IEN^STREET 1
 ; IBCOB = bill designation (P)rimary-default, (S)econdary, (T)ertiary
 ;            or 123 - if not defined or null, return current
 N A,IBEMPL,IBI,DFN,VAOA
 S IBI=$$WHOSINS(IBIFN,$G(IBCOB))
 I $S('IBI:1,1:"12"'[IBI) S IBEMPL="^^" G INSEMPQ
 ; insured = pt/spouse
 S DFN=+$P($G(^DGCR(399,IBIFN,0)),U,2)
 S A=$$PTEMPL(IBIFN,0,IBI+4,.VAOA)
 S IBEMPL=VAOA(9)_U_VAOA(4)_U_$P($G(^DIC(5,+VAOA(5),0)),U,2)_U_+VAOA(5)_U_VAOA(1)
INSEMPQ Q IBEMPL
 ;
WHOSINS(IBIFN,IBCOB) ; Determine who is insured for bill IBIFN and 
 ; seq of coverage COB (123 or PST) or if not defined or null, current
 N Z,Z0,VAEL,DFN
 S Z=+$$POLICY(IBIFN,16,$G(IBCOB))
 I 'Z D
 .S Z0=$$POLICY(IBIFN,6,$G(IBCOB)),DFN=$P($G(^DGCR(399,IBIFN,0)),U,2)
 .I Z0="v" D ELIG^VADPT I VAEL(4) S Z=1 Q  ;vet is pt
 .I Z0="s" D ELIG^VADPT I VAEL(4) S Z=2 Q  ;vet is pt, so vets spouse is pt's spouse
 .S Z=9 ; relationship of insured to pt unknown
 Q Z
 ;
EMPSTAT(IBIFN,WHOSE) ;Return employment status
 ; IBIFN = bill ien
 ; WHOSE = v for vet, s for spouse status
 N STAT,DFN,VAPD
 S STAT="",DFN=+$P($G(^DGCR(399,IBIFN,0)),U,2)
 I WHOSE="v" D OPD^VADPT S STAT=$P(VAPD(7),U)
 I WHOSE="s" S STAT=$P($G(^DPT(DFN,.25)),U,15)
 I STAT="" S STAT=9
 Q STAT
 ;
INPAT(IBIFN,OUT) ; Determine if bill is inpatient
 ; OUT = optional - if 1, return output value based on 
 ;  inpatient/outpatient from UB-04 type of bill field
 ; Return 1 if inpatient, 0 if not inpatient or can't be determined
 N INPT,CODE,CODE0,IB0
 S IB0=$G(^DGCR(399,IBIFN,0))
 S OUT=+$G(OUT),CODE=+$P(IB0,U,5)
 I 'OUT S INPT=CODE
 I OUT D
 . S CODE0=$P($G(^DGCR(399.1,+$P(IB0,U,25),0)),U,2)
 . I CODE0=8,$P(IB0,U,24)=1 S INPT=$P(IB0,U,5) Q  ; 18X
 . I CODE0=9,$P(IB0,U,24)=8 S INPT=$P(IB0,U,5) Q  ; 89X
 . I CODE0=1,$P(IB0,U,24)=8 S INPT=0 Q  ; 81X
 . I CODE0=1,$P(IB0,U,24)=7 S INPT=0 Q  ; 71X
 . I CODE0=2,$P(IB0,U,24)=7 S INPT=0 Q  ; 72X
 . S INPT=CODE0
 Q $S(INPT:INPT'>2,1:0)
 ;
INSPRF(IBIFN) ; Function to determine if bill is prof or inst
 ; Return 1 if institutional (UB-04) claim, 0 if professional (CMS-1500) claim
 N A
 S A=$G(^DGCR(399,IBIFN,0))
 I $P(A,U,27)="" S $P(A,U,27)=$S($P(A,U,19)=3:1,1:0)
 Q $S($P(A,U,27)=1:1,1:0)
 ;
F(FLD,IBXRET,IBXERR1,IBIEN) ;Execute extract for data element FLD and bill IBIEN
 ; If IBXDATA array to be returned as data value(s) of fld
 ;   D F^IBCEF("FLD NAME","IBXDATA","IBXERR") or D F^IBCEF("FLD NAME") 
 ; Variable ref-ed by IBXERR1 will contain error message if an error
 ; @IBXRET always defined on return.  It will be null if error
 I $G(IBIEN) N IBXIEN S IBXIEN=IBIEN
 I $G(IBXERR1)="" S IBXERR1="IBXERR"
 N IBXHOLD
 S IBXHOLD=""
 I $G(IBXRET)=""!($G(IBXRET)="IBXDATA") S IBXHOLD="IBXDATA",IBXRET="IBXRET"
 S @IBXERR1=""
 ;
 N FLDN,OFLD,STOP,Z,IBXERR2,IBXRETX
 ;
 I '$G(IBXIEN) S @IBXERR1="Invalid entry #" G FQ
 I '$D(^IBA(364.5,"B",FLD)) S OFLD=FLD,STOP=0 D  I FLD="" S @IBXERR1=OFLD_" Field not found!!" G FQ
 .F  S FLD=$O(^IBA(364.5,"B",FLD))  D  Q:STOP
 ..I $E(FLD,1,$L(OFLD))'=OFLD S FLD=""
 ..S STOP=1
 ;
 S Z=0
 F  S Z=$O(^IBA(364.5,"B",FLD,Z)) Q:'Z  I $P($G(^IBA(364.5,Z,0)),U,5)=399 Q
 I 'Z S @IBXERR1=FLD_" Field not found!!" G FQ
 ;
 S FLDN(1)=Z D EXTONE^IBCEFG0(IBXIEN,.FLDN,""_IBXRET_"",.IBXERR2)
 ;
 I $G(IBXERR2)'="" S @IBXERR1=IBXERR2
FQ S IBXARRY=$S(IBXHOLD="IBXDATA":"IBXDATA",1:""_IBXRET_"")
 I @IBXERR1'="" K @IBXARRY S @IBXARRY="" Q
 ;
 I IBXHOLD="IBXDATA" S IBXRET="IBXRET"
 M IBXRETX=@IBXRET K @IBXARRY M @IBXARRY=IBXRETX(1)
 S:'($D(@IBXARRY)#2) @IBXARRY=""
 Q
 ;
SERVDT(IBIFN,LENGTH,FORMAT) ; Return default service date for 
 ; outpatient/UB-04 lines or X12-837 institutional lines
 ; LENGTH = null/8 for 8 digit date, 6 for 6 digit date
 ; FORMAT = 1 = X12 format (YYYYMMDD), 2 = FM internal (NNNNNNN),
 ;          0 = external (MMDDYY or MMDDYYYY)
 N IBZ
 G:$$INPAT^IBCEF(IBIFN,1)!($$FT^IBCEF(IBIFN)'=3) SERVDTQ ;Inpatient claim or billed on a CMS-1500
 S LENGTH=$G(LENGTH),FORMAT=$G(FORMAT)
 D F("N-STATEMENT COVERS FROM DATE","IBZ",,IBIFN)
 I '$G(IBZ)!(FORMAT=2) G SERVDTQ
 ;
 I FORMAT=1 S IBZ=$$DT^IBCEFG1(IBZ,"",$S(LENGTH'=6:"D8",1:"D6")) G SERVDTQ
 S IBZ=$$DATE^IBCF2(IBZ,$S(LENGTH=6:0,1:1),1)
 ;
SERVDTQ Q $G(IBZ)
 ;
NOPUNCT(X,SPACE,EXC) ; Strip punctuation from data in X
 ; SPACE = flag if 1 strip SPACES
 ; EXC = list of punctuation not to strip
 ;
 N PUNCT,Z
 S PUNCT=".,-+(){}[]\/><:;?|=_*&%$#@!~`^'"""
 I $G(SPACE) S PUNCT=PUNCT_" "
 I $G(EXC)'="" F Z=1:1:$L(EXC) S PUNCT=$TR(PUNCT,$E(EXC,Z))
 S X=$TR(X,PUNCT)
 Q X
 ;
FT(IBIFN) ; Internal code for bill form type
 Q +$P($G(^DGCR(399,IBIFN,0)),U,19)
 ;
COBCT(IBIFN) ; # of payers on claim
 N CT,Z
 S CT=0 F Z="I1","I2","I3" Q:'$D(^DGCR(399,IBIFN,Z))  S CT=CT+1
 Q CT
 ;
