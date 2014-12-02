RMPFRPC1  ;DALC/PJU - Module to get Demographics for Patient ;06/18/08
 ;;3.0;REMOTE ORDER ENTRY SYSTEM;**1,4**;Feb 9, 2011;Build 19
 ;;Per VHA Directive 10-92-142 this routine should not be modified
 ;;Uses supported IA's: 2701, 4440, 10061
 ;;Added to IA: 767
START(RE,DFN) ;Descrip of ret array(RE) in EXAMP at bottom of pg
  ;Called from RPC 'RMPFDEMOG' in Delphi routine uRMPFR3Patient.pas
  ;input: array name by ref, DFN
  ;output: 2 char term used in name-value pairs for URL
  I '$G(DFN) D  G END
  .S ER="** Must have a DFN defined to continue. Exiting **"
  K RE ;can set param to clear between calls
  N ARR,BD,CL,CI,ED,EL,ER,ES,GP,ICN,L1,L2,L3
  N NM,PD,PN,PR,SR,SS,ST,TE,TD,VH,VT,ZP
  S (BD,CL,CI,ED,EL,ER,ES,GP,ICN,L1,L2,L3)=""
  S (NM,PD,PN,PR,SR,SS,ST,TE,TD,VH,VT,ZP)=""
  F X=0,11:1:31 S RE(X)=""
  D DEM^VADPT ; demographic vars
  I $G(VAERR) D  G END
  .S ER="**Problem in retrieving Demographic values. Exiting.**"
  I $D(^DGSL(38.1,"B",DFN)) D  ;IA#767
  .S SR=$O(^DGSL(38.1,"B",DFN,0)) ;ck for sensitive record
  .I SR,$P($G(^DGSL(38.1,SR,0)),U,2) S RE(26)=1
  S NM=$G(VADM(1)),RE(11)=NM ;name
  S SS=$P($G(VADM(2)),U,1),RE(12)=SS ;ssn
  S BD=$G(VADM(3)),RE(13)=BD ;DOB
  D ADD^VADPT ; current addr
  I $G(VAERR) D  G END
  .S ER="**Problem in retrieving Address values. Exiting**"
  S L1=$G(VAPA(1)),RE(14)=L1
  S L2=$G(VAPA(2)),RE(15)=L2
  S L3=$G(VAPA(3)),RE(16)=L3
  S CI=$G(VAPA(4)),RE(17)=CI
  S ST=$P($G(VAPA(5)),U,1) ;State file pointer
  I 'ST D  G END
  .S ER="**STATE field of address in local PATIENT record is missing. Exiting."
  E  S X=ST,DIC="5",DIC(0)="NZ" D ^DIC K DIC D  G:$L(ER) END
  .I +Y<1 K Y D  Q
  ..S ER="**STATE field of address in local PATIENT record is not valid. Exiting."
  .S ST=$P(Y(0),U,2) K Y ;State abbrev
  S RE(18)=$P($G(VAPA(5)),U,1)_U_ST
  S ZP=$S($G(VAPA(11)):VAPA(11),1:VAPA(6)),RE(19)=$P(ZP,U,1)
  S TD=$G(VAPA(9)),RE(20)=TD
  S TE=$G(VAPA(10)),RE(21)=TE
  S PN=$G(VAPA(8)),RE(22)=PN
END  ;get eligibility information
  ;ARR is killed and re-set in RMPFRPC0
  D START^RMPFRPC0(.ARR,DFN) ;elig vars
  S RE(0)=$G(ARR(0)) ;FM DOD ^ external
  S RE(23)=DT ;$P(ARR(8),U,7) ;El stat dt - as of today
  S RE(24)=$G(ARR(2)) ;R3 calc elig code
  I RE(24)="" S RE(24)=$G(ARR(8)) ;just elig R3*4
  ;elig^app(1)/dis(0)/sub(2)/exp(3)^PSuser^ASuser^ReqDt^SugEl^ActDt
  S RE(25)=$P($G(ARR(3)),U,1) ;elig status
  I $L($G(ER)) S RE(27)=ER ;error msg from VADPT calls
  I $G(RE(27))="" S RE(27)=$G(ARR(5)) ;error msg from elig call
  S RE(28)=$G(ARR(6)) ;prim elig
  S RE(29)=$G(ARR(7)) ;priority group
  S ICN="",X="MPIF001" X ^%ZOSF("TEST")
  I $T S ICN=$$GETICN^MPIF001(DFN)
  S:(ICN<1) ICN="" ;"***ICN NOT FOUND***"
  S RE(30)=ICN
  S VH=0 ;ck for production account
  S X="XUPROD" X ^%ZOSF("TEST") I $T D
  .S VH=$$PROD^XUPROD()
  .I VH'=1 S VH=0
  S RE(31)=VH
EXIT  F X=11:1:31 S RE(X)=$$CLEAN(RE(X))
  ;ZW RE ;TESTING R3*4
  K S0,S1,S2,S6,YY,POP,VAERR
  D KVAR^VADPT
  Q
  ;
CLEAN(RMVAR)  ;Remove symbols that should not go through URL
  N RMPFRTN
  S RMPFRTN=$TR(RMVAR,"@#%?&/\*","")
ENDC  Q RMPFRTN
  ;
EXAMP  ;return sorted array to calling application
  ;RPCBroker lookup is done to retrieve the patient DFN.
  ;A call is then made to this routine through the RMPFDEMOG RPC.
  ;From the PATIENT file, we get the name, SSN, date of birth,
  ;current address, and temporary address parameters.
  ;will return to the Delphi app subscripts in same order
  ;created during calculation in the RE array (passed by ref)
  ;PD = RE(0)=date of death msg or ""
  ;NM = RE(11)=name
  ;SS = RE(12)=SSN
  ;BD = RE(13)=DOB
  ;L1 = RE(14)=current ad1
  ;L2 = RE(15)=current ad2
  ;L3 = RE(16)=current ad3
  ;CI = RE(17)=current city
  ;ST = RE(18)=current st
  ;ZP = RE(19)=current zip
  ;TD = RE(20)=t start date
  ;TE = RE(21)=t end date
  ;PN = RE(22)=current phone
  ;ED = RE(23)=eligibility status date FM
  ;EL = RE(24)=R3 elig cd ;;^1/2/3^PS-user^AS-user^reqDt^sugEl^actDt
  ;ES = RE(25)=eligibility status
  ;SR = RE(26)=sensitive record
  ;ER = RE(27)=error msg
  ;PR = RE(28)=primary elig
  ;GP = RE(29)=priority group
  ;ICN= RE(30)=Integration Control Number for MPI
  ;VH = RE(31)=1 if a production account
