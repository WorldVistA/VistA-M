RMPFRPC1        ;DDC/PJU - Module to get demographics from patient files ;7/8/04
 ;;3.0;REMOTE ORDER/ENTRY SYSTEM;**1**;11/1/02
 ;;Called from RMPFDEMOG
START(RE,DFN)       ;see description at end of program
 ;;input: array name by ref, DFN
 ;;output: 2 char term used in name-value pairs for URL
 ;;will return to the Delphi app subscripts in same order
 ;created during calculation in the RE array (passed by reference)
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
 ;EL = RE(24)=R3 eligibility code
 ;ES = RE(25)=eligibility status
 ;SR = RE(26)=sensitive record
 ;ER = RE(27)=error msg
 ;PR = RE(28)=primary elig
 ;GP = RE(29)=priority group
 ;ICN= RE(30)=Integration Control Number for MPI
 I '$G(DFN) D  G END
 .S ER="**ERROR** Must have a DFN to run routine RMPFRPC "
 K RE ;can set param to clear between calls
N N ARR,BD,CL,CI,ED,EL,ER,ES,GP,ICN,L1,L2,L3
 N NM,PD,PN,PR,SR,SS,ST,TE,TD,VT,ZP
 S (BD,CL,CI,ED,EL,ER,ES,GP,ICN,L1,L2,L3)=""
 S (NM,PD,PN,PR,SR,SS,ST,TE,TD,VT,ZP)=""
 F X=0,11:1:30 S RE(X)=""
D D DEM^VADPT ;sets up VADM() - demographic variables *** ck for errors
 I $G(VAERR) D  G END
 .S ER="**ERROR** Problem in retrieving Demographic values"
 I $D(^DGSL(38.1,"B",DFN)) D  ;ck for sensitive record
 .S SR=$O(^DGSL(38.1,"B",DFN,0)) ;IA#767 after approval from Mary Marks/Cameron Schlehuber
 .I SR,$P($G(^DGSL(38.1,SR,0)),U,2) S RE(26)=1
 S NM=$G(VADM(1)),RE(11)=NM ;name
 S SS=$P($G(VADM(2)),U,1),RE(12)=SS ;ssn
 S BD=$G(VADM(3)),RE(13)=BD ;DOB
 D ADD^VADPT ;sets up VAPA() *** get current addr and ck errors
 I $G(VAERR) D  G END
 .S ER="**ERROR** Problem in retrieving Address values"
 S L1=$G(VAPA(1)),RE(14)=L1
 S L2=$G(VAPA(2)),RE(15)=L2
 S L3=$G(VAPA(3)),RE(16)=L3
 S CI=$G(VAPA(4)),RE(17)=CI
 S ST=$P($G(VAPA(5)),U,1) ;State file pointer
 I 'ST D  G END
 .S ER="**ERROR** Invalid State entry in PATIENT file"
 E  S X=ST,DIC="5",DIC(0)="NZ" D ^DIC K DIC D  G:$L(ER) END
 .I +Y<1 K Y D  Q  ;2/6/04 chg'd to part of ELSE
 ..S ER="**ERROR** Patient State not in the STATE file"
 .S ST=$P(Y(0),U,2) K Y ;State abbrev
 S RE(18)=$P($G(VAPA(5)),U,1)_U_ST
 S ZP=$S($G(VAPA(11)):VAPA(11),1:VAPA(6)),RE(19)=$P(ZP,U,1)
 S TD=$G(VAPA(9)),RE(20)=TD
 S TE=$G(VAPA(10)),RE(21)=TE
 S PN=$G(VAPA(8)),RE(22)=PN ;OK to here
END D START^RMPFRPC0(.ARR,DFN) ;elig variables
 ;ARR is killed and re-set in RMPFRPC0
 S RE(0)=$G(ARR(0)) ;FM DOD ^ external
 S RE(23)=$G(ARR(1)) ;eligibility FM status date
 S RE(24)=$G(ARR(2)) ;R3 calculated eligibility code OR
 S:$L($G(ARR(8))) RE(24)=$G(ARR(8)) ;code^approval/disapproval^PSAS USER NAME
 S RE(25)=$P($G(ARR(3)),U,1) ;eligibility status
 S RE(26)=$G(ARR(4)) ;0 OR 1 FOR sensitive record
 I $L($G(ER)) S RE(27)=ER ;error msg from VADPT calls
 E  S RE(27)=$G(ARR(5)) ;error msg from elig call
 S RE(28)=$G(ARR(6)) ;prim elig
 S RE(29)=$G(ARR(7)) ;priority group
 S X="MPIF001" X ^%ZOSF("TEST")
 I $T S ICN=$$GETICN^MPIF001(DFN)
 S:(ICN<1) ICN="" ;"***ICN NOT FOUND***"
 S RE(30)=ICN
EXIT F X=11:1:30 S RE(X)=$$CLEAN(RE(X))
 K S0,S1,S2,S6,YY,POP
 D KVAR^VADPT ;kill VADPT variables
 Q
CLEAN(RMVAR)    ;Remove symbols that should not go through URL
 N RMPFRTN
 S RMPFRTN=$TR(RMVAR,"@#%?&/\","")
ENDC Q RMPFRTN
 ;
EXAMP ;return array to calling application
 ;sorts numerically by orig subscript
 ;RE(0)= DOD numeric and text
 ;RE(1)= name text
 ;RE(2)= SSN
 ;RE(3)= DOB numeric and text
 ;RE(4)= current address line 1
 ;RE(5)= "" line 2
 ;RE(6)= "" line 3
 ;RE(7)= "" city
 ;RE(8)= "" numeric and abbrev state
 ;RE(9)= "" zip
 ;RE(10)= temp start date numeric ^ text
 ;RE(11)= temp end date numeric ^ text
 ;RE(12)= current phone
 ;RE(13)= elig status date  numeric ^ text
 ;RE(14)= elig
 ;RE(15)= elig status (V^VERIVIED)
 ;RE(16)= sensitive record (1 or '')
 ;RE(17)=error msg
 ;RE(18)=primary elig
 ;RE(19)=priority group
 ;RE(20)=integration control number ICN
 ;
 ;RPCBroker lookup is done to retrieve the patient DFN.
 ;A call is then made to this routine through the RMPFDEMOG RPC.
 ;From the PATIENT file, we get the name, SSN, date of birth,
 ;current address, and temporary address parameters.
