ECXUTL5 ;ALB/JRC - Utilities for DSS Extracts ;5/17/12  15:52
 ;;3.0;DSS EXTRACTS;**71,84,92,103,105,120,136**;Dec 22, 1997;Build 28
 ;
REPEAT(CHAR,TIMES) ;REPEAT A STRING
 ;INPUT  : CHAR - Character to repeat
 ;         TIMES - Number of times to repeat CHAR
 ;OUTPUT : s - String of CHAR that is TIMES long
 ;         "" - Error (bad input)
 ;
 ;CHECK INPUT
 Q:($G(CHAR)="") ""
 Q:((+$G(TIMES))=0) ""
 ;RETURN STRING
 Q $TR($J("",TIMES)," ",CHAR)
INSERT(INSTR,OUTSTR,COLUMN,LENGTH) ;INSERT A STRING INTO ANOTHER
 ;INPUT  : INSTR - String to insert
 ;         OUTSTR - String to insert into
 ;         COLUMN - Where to begin insertion (defaults to end of OUTSTR)
 ;         LENGTH - Number of characters to clear from OUTSTR
 ;                  (defaults to length of INSTR)
 ;OUTPUT : s - INSTR will be placed into OUTSTR starting at COLUMN
 ;             using LENGTH characters
 ;         "" - Error (bad input)
 ;
 ;NOTE : This module is based on $$SETSTR^VALM1
 ;
 ;CHECK INPUT
 Q:('$D(INSTR)) ""
 Q:('$D(OUTSTR)) ""
 S:('$D(COLUMN)) COLUMN=$L(OUTSTR)+1
 S:('$D(LENGTH)) LENGTH=$L(INSTR)
 ;DECLARE VARIABLES
 N FRONT,END
 S FRONT=$E((OUTSTR_$J("",COLUMN-1)),1,(COLUMN-1))
 S END=$E(OUTSTR,(COLUMN+LENGTH),$L(OUTSTR))
 ;INSERT STRING
 Q FRONT_$E((INSTR_$J("",LENGTH)),1,LENGTH)_END
TYPE(DFN) ;Determine patient type DBIA #2511
 ;   input 
 ;   DFN = patient ien
 ;
 ;   output
 ;   ECXPTYPE = patient type external value from fle 391
 ;
 ;          AC = ACTIVE DUTY        MI = MILITARY RETIREE
 ;          AL = ALLIED VETERAN     NO = NON-VETERAN (OTHER)
 ;          CO = COLLATERAL         NS = NSC VETERAN
 ;          EM = EMPLOYEE           SC = SC VETERAN
 ;          IN = INELIGIBLE         TR = TRICARE
 ;          return value 0 if no data found, 1 if data found
 ;
 N TYPE,ECXPTYPE
 ;Check input
 Q:'$D(DFN) ""
 S (TYPE,ECXPTYPE)=""
 S TYPE=$G(^DPT(DFN,"TYPE"))
 I 'TYPE Q ECXPTYPE
 S ECXPTYPE=$P($G(^DG(391,TYPE,0)),U,1)
 S ECXPTYPE=$E(ECXPTYPE,1,2)
 Q ECXPTYPE
CVEDT(DFN,DATE) ;Determine patient CV status DBIA #4156
 ;   input
 ;   DFN = patient ien
 ;
 ;   output
 ;   ECXCVE = combat veteran status eligibility
 ;   ECXCVEDT = combat veteran eligibility end date
 ;   ECXCVENC = combat veteran encounter
 ;Initialize variables
 N CVSTAT
 S (CVSTAT,ECXCVE,ECXCVEDT,ECXCVENC)=""
 ;Check input
 Q:'$D(DFN) 0
 ;Call CV API
 S CVSTAT=$$CVEDT^DGCV(DFN,DATE)
 I CVSTAT<1 Q 0
 ;Veteran been given CV eligibility
 S ECXCVE=$S($P(CVSTAT,U,3)=1:"Y",$P(CVSTAT,U,3)=0:"E",1:"")
 ;Save CV eligibility end date and convert from FM to HL7 format
 S ECXCVEDT=$P(CVSTAT,U,2)
 S ECXCVEDT=$$FMTHL7^XLFDT(ECXCVEDT)
 ;Is the veteran eligible for CV in the date of encounter
 S ECXCVENC=$S($P(CVSTAT,U,3)=1:"Y",1:"")
 Q 1
NPRF ;National patient record flags DBIA #3860
 N ECXARR,FLG
 S ECXNPRFI="",CNT=$$GETACT^DGPFAPI(ECXDFN,"ECXARR"),FLG=""
 I 'CNT Q
 F I=1:1:CNT D  Q:FLG
 .I ECXARR(I,"CATEGORY")["NATIONAL" S ECXNPRFI="Y",FLG=1
 Q
RXPTST(K) ;Rx patient status DBIA #2511
 N ECXDIC,STAT
 S (ECXDIC,STAT)=""
 ;Check input
 Q:'$D(K) STAT
 S DA=K,DIC="^PS(53,",DIQ(0)="I",DIQ="ECXDIC",DR="6"
 D EN^DIQ1
 S STAT=$G(ECXDIC(53,K,6,"I"))
 S STAT=$S(STAT=1:"SC",STAT=2:"AA",STAT=3:"OTH",STAT=4:"INP",STAT=5:"NON",1:"")
 Q STAT
NONVAP(K) ;Non-va prescriber DBIA #10060
 N ECXDIC,NONVAP
 S (ECXDIC,NONVAP)=""
 Q:'$D(K) NONVAP
 S DA=K,DIC="^VA(200,",DIQ(0)="I",DIQ="ECXDIC",DR="53.91"
 D EN^DIQ1
 S NONVAP=$G(ECXDIC(200,K,53.91,"I"))
 I NONVAP S NONVAP="Y"
 Q NONVAP
DOIVPO(K,L) ;Add destination for outpatient ivp orders
 ;     Input     K - DFN
 ;               L - Order # from Pharmacy Patient File (#55)
 ;
 ;     Output     ordering stop code
 ;
 N ECXDIC,ECXDICA,ECXDICB,DOIVPO,CLINIC,SCODE,DIC,DIQ,DR,DA
 S (ECXDIC,ECXDICA,ECXDICB,DOIVPO,CLINIC,SCODE)=""
 ;Check input
 Q:'K!'(L) SCODE
 ;Check treating specialty
 S SCODE=$$TSSC($G(ECXTS)) I SCODE>0 Q SCODE
 ;Go to pharmacy patient file (#55) and return value of field (#136)
 S DIC=55,DIQ(0)="I",DIQ="ECXDIC",DR="100",DR(55.01)="136",DA=K,DA(55.01)=L
 D EN^DIQ1
 S CLINIC=$G(ECXDIC(55.01,L,136,"I"))
 I 'CLINIC Q SCODE
 ;Get stop code pointer to file 40.7 from file 44
 S DIC="^SC(",DIQ(0)="I",DIQ="ECXDICA",DR="8",DA=CLINIC D EN^DIQ1
 S SCODE=ECXDICA(44,CLINIC,8,"I")
 ;Get stop code external value
 S DIC="^DIC(40.7,",DIQ(0)="E",DIQ="ECXDICB",DR="1",DA=SCODE D EN^DIQ1
 S SCODE=$G(ECXDICB(40.7,SCODE,1,"E"))
 Q SCODE
 ;
DOUDO(K,L) ;Add destination for outpatient udp orders
 ;     Input     K - DFN
 ;               L - Order # from Pharmacy Patient File (#55)
 ;
 ;     Output     ordering stop code
 ;
 N ECXDIC,ECXDICA,ECXDICB,DOIVPO,CLINIC,SCODE,DIC,DIQ,DR,DA
 S (ECXDIC,ECXDICA,ECXDICB,DOIVPO,CLINIC,SCODE)=""
 ;Check treating specialty
 S SCODE=$$TSSC($G(ECXTS)) I SCODE>0 Q SCODE
 ;Check input
 Q:'K!'(L) SCODE
 S DIC=55,DIQ(0)="I",DIQ="ECXDIC",DR="62",DR(55.06)="130",DA=K,DA(55.06)=L
 D EN^DIQ1
 S CLINIC=$G(ECXDIC(55.06,L,130,"I"))
 I 'CLINIC Q SCODE
 ;Get stop code pointer to file 40.7 from file 44
 S DIC="^SC(",DIQ(0)="I",DIQ="ECXDICA",DR="8",DA=CLINIC D EN^DIQ1
 S SCODE=ECXDICA(44,CLINIC,8,"I")
 ;Get stop code external value
 S DIC="^DIC(40.7,",DIQ(0)="E",DIQ="ECXDICB",DR="1",DA=SCODE D EN^DIQ1
 S SCODE=$G(ECXDICB(40.7,SCODE,1,"E"))
 Q SCODE
 ;
PHAAPI(DRUG) ;Call Pharmacy drug file API dbia 4483
 ;   Input: drug file (#50) ien
 ;
 ;   Output: generic name ^ classification ^ ndc ^ dea hand
 ;            ^ ndf file entry # ^ psndf va product entry ^
 ;            price per disp unit ^ dispense unit
 ;
 ;Initialize variables and scratch global
 N NAME,CLASS,NDC,INV,NDF,P1,P3,PPDU,UNIT,ARRAY,DATA
 S (NAME,CLASS,NDC,INV,NDF,P1,P3,PPDU,ARRAY,DATA)=""
 S ARRAY="^TMP($J,""ECXLIST"")"
 K @ARRAY
 D DATA^PSS50(DRUG,,,,,"ECXLIST")
 I @ARRAY@(0)'>0 Q "^^^^^^"
 S NAME=@ARRAY@(DRUG,.01),CLASS=@ARRAY@(DRUG,2),NDC=@ARRAY@(DRUG,31)
 S INV=@ARRAY@(DRUG,3),P1=$P(@ARRAY@(DRUG,20),U),P3=$P(@ARRAY@(DRUG,22),U),PPDU=@ARRAY@(DRUG,16),UNIT=@ARRAY@(DRUG,14.5)
 K @ARRAY
 Q NAME_U_CLASS_U_NDC_U_INV_U_P1_U_P3_U_PPDU_U_UNIT
 ;
TSSC(X) ;Check treating specialty (ts) and if ts equals any of the following
 ;18,23,24,36,41,65,94,108(1J) then assign predefined code and return value
 ;
 ;    Input: treating specialty
 ;    Output: Ordering stop code
 ;
 S CODE=$S(X=18:293,X=23:295,X=24:290,X=36:294,X=41:296,X=65:291,X=94:292,X=108:297,1:"")
 Q CODE
 ;
PSJ59P5(X) ;Get iv room division
 ;   Input  X - iv room ien
 ;
 ;   Output - field .02 division
 ;Init variables
 N DIV S DIV=""
 ;Check input
 I 'X  Q DIV
 D ALL^PSJ59P5(X,,"ECXDIV")
 S DIV=$P($G(^TMP($J,"ECXDIV",X,.02)),U)
 K ^TMP($J,"ECXDIV")
 Q DIV
 ;
SCRX(IEN) ;Service connected prescription
 ;Init variables
 N DIC,DR,DA,ECXDIQ
 ;Check input
 I '$G(IEN) Q ""
 S DIC=52,DR="116",DA=IEN,DIQ="ECXDIQ"
 D DIQ^PSODI(DIC,DIC,DR,DA,DIQ)
 Q $S($G(ECXDIQ(52,DA,116))="YES":"Y",$G(ECXDIQ(52,DA,116))="NO":"N",1:"")
 ;
SSN(SSN,FILE) ; extended validation of ssn
 ;       input:     ssn - social security number to validate
 ;                  file - optional "", 2 or 67, the only check is for
 ;                         reference lab file (#67) in which case ssn
 ;                         "000123456" is considered a valid ssn.
 ;        output:   0 - test patient or invalid ssn
 ;                  1 - valid ssn
 ;
 ;check input
 I $G(SSN)']"" Q 0
 S FILE=$G(FILE)
 I (FILE=67)&(SSN="000123456") Q 1
 ;I "89"[$E(SSN) Q 0  ;136 Removed filtering of SSNs that start with 8 or 9
 I (SSN="123456789")!(SSN="111111111")!(SSN="222222222")!(SSN="333333333")!(SSN="444444444")!(SSN="555555555")!($E(SSN,1,3)="666")!($E(SSN,4,5)="00")!($E(SSN,1,3)="000") Q 0
 I SSN="777777777"!(SSN="888888888")!(SSN="999999999") Q 0  ;136 adding new exclusions for the 7, 8, and 9 series where the numbers repeat
 Q 1
 ;
