ISIIMPUG ;ISI GROUP/MLS -- IMPORT Utility (ENCOUNTER related...)
 ;;1.0;;;Jun 26,2012;Build 93
 Q
 ;
 ; Column definitions for MISCDEF table (below):
 ; NAME =       name of parameter
 ; TYPE =       categories of values provided
 ;                      'PARAM' is internal used value 
 ;                      'FIELD' is a literal import value
 ;                      'MASK' is dynamic value w/ * wildcard
 ; DESC  =      description of value
 ;
 ;
MISCDEF ;;+++++ DEFINITIONS OF ENCOUNTER [related] MISC PARAMETERS +++++
 ;;NAME                  |TYPE       |FILE,FIELD        |DESC
 ;;--------------------------------------------------------------------------
 ;;PAT_SSN               |FIELD      |                  |PATIENT (SSN or DFN) 
 ;;HFACTOR               |FIELD      |9000010.23,.01    |HEALTH FACTOR
 ;;CPT                   |           |9000010.18,.01    |V CPT
 ;;PROVIDER_NARRATIVE    |FIELD      |9000010.18,.04    |V CPT
 ;;MODIFIER              |FIELD      |9000010.181,.01   |V CPT/V POV
 ;;EXAM                  |           |9000010.13,.01    |V EXAM
 ;;IZ                    |           |9000010.11,.01    |V IMMUNIZATION
 ;;CONTRAINDICATED       |           |9000010.11,.07    |V IMMUNIZATION
 ;;PROVIDER              |FIELD      |9000010.23,1204   |ENCOUNTER PROVIDER, pointer to #200
 ;;DATETIME              |FIELD      |                  |Datetime value to derive VISIT IEN
 ;;COMMENT               |FIELD      |9000010.23,81101  |Free text
 ;;SEVERITY              |FIELD      |9000010.23,.04    |LEVEL/SEVERITY (SET)
 ;;ICD9                  |FIELD      |9000010.07,.01    |VPOV
 ;;PRIMSEC               |FIELD      |9000010.07,.12    |VPOV (P or S)
 ;;ED_TOPIC              |FIELD      |9000010.16,.01    |V PATIENT ED FILE
 ;;LEVEL_OF_UNDERSTANDING|FIELD      |9000010.16,.06    |V PATIENT ED FILE
 ;;ALLOWDUPS             |PARAM      |                  |1 = allow dup hf w/ same Visit IEN
 Q
 ;
ENMISC(MISC,ISIMISC)
 ;
 ;INPUT: 
 ;  MISC - raw list values from RPC client
 ;
 ;OUTPUT:
 ;  ISIMISC("NAME")=VALUE
 ;
 N MISCDEF
 K ISIMISC
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 S ISIRC=$$ENMISC1("ISIMISC")
 Q ISIRC ;return code
 ;
ENMISC1(DSTNODE) 
 N PARAM,VALUE,DATE,RESULT,MSG,EXIT
 S (EXIT,ISIRC)=0,(I,VALUE)=""
 F  S I=$O(MISC(I))  Q:I=""  D  Q:EXIT
 . S PARAM=$$TRIM^XLFSTR($P(MISC(I),U))  Q:PARAM=""
 . S VALUE=$$TRIM^XLFSTR($P(MISC(I),U,2))
 . I '$D(MISCDEF(PARAM)) S ISIRC="-1^Bad parameter title passed: "_PARAM,EXIT=1 Q
 . I VALUE="" S ISIRC="-1^No data provided for parameter: "_PARAM,EXIT=1 Q
 . I PARAM="DATETIME" D  
 . . S DATE=VALUE D DT^DILF("T",DATE,.RESULT,"",.MSG)
 . . I RESULT<0 S EXIT=1,ISIRC="-1^Invalid datetime." Q
 . . S VALUE=RESULT
 . . Q
 . I EXIT Q
 . S @DSTNODE@(PARAM)=VALUE
 . Q
 Q ISIRC ;return code
 ;
LOADMISC(MISCDEF) ;
 N BUF,FIELD,I,NAME,TYPE
 K MISCDEF
 F I=3:1  S BUF=$P($T(MISCDEF+I),";;",2)  Q:BUF=""  D
 . S NAME=$$TRIM^XLFSTR($P(BUF,"|"))  Q:NAME=""
 . S TYPE=$$TRIM^XLFSTR($P(BUF,"|",2))
 . S FIELD=$$TRIM^XLFSTR($P(BUF,"|",3))
 . S MISCDEF(NAME)=TYPE_"|"_FIELD
 Q
 ;
VALHF() ;Health Factor Validation
 ;
 N EXIT,IDT,RDT,DFN,VALUE,VIEN
 S EXIT=0
 I $G(ISIPARAM("DEBUG"))>0 D  
 . W !,"+++BEFORE Validated array (VALHF^ISIIMPUG)+++",!
 . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 S ISIRC=$$CHECKENC(.ISIMISC) I ISIRC<0 Q ISIRC
 N HFACTOR S HFACTOR=$G(ISIMISC("HFACTOR"))
 S HFACTOR=$O(^AUTTHF("B",HFACTOR,""))
 I 'HFACTOR Q "-1^ ~ Missing Health Factor" 
 S ISIMISC("HFACTOR")=HFACTOR
 I $G(ISIPARAM("DEBUG"))>0 D  
 . W !,"+++AFTER Validations array (VALHF^ISIIMPUG)+++",!
 . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 N ALLOWDUPS S ALLOWDUPS=+$G(ISIMISC("ALLOWDUPS"))
 I 'ALLOWDUPS,$D(^AUPNVHF("AD",$E(VIEN,1,30))) D  
 . N HFIEN S HFIEN=0 F  S HFIEN=$O(^AUPNVHF("AD",$E(VIEN,1,30),HFIEN)) Q:'HFIEN!EXIT  D  
 . . I +$G(^AUPNVHF(HFIEN,0))=HFACTOR S EXIT=HFIEN
 . Q
 I EXIT Q "-9^HF/VISIT combo already exists"
 Q 1
 ;
VALIMZ() ;V IMMUNIZATION Validation
 N ISIRC,IZ,IZIEN,VIEN,EXIT
 S (EXIT,ISIRC)=0
 I $G(ISIPARAM("DEBUG"))>0 D  
 . W !,"+++BEFORE Validated array (VALIMZ^ISIIMPUG)+++",!
 . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 S ISIRC=$$CHECKENC(.ISIMISC) I ISIRC<0 Q ISIRC
 ;
 S IZ=$G(ISIMISC("IZ")) S IZIEN=$O(^AUTTIMM("B",IZ,0))
 I 'IZIEN Q "-1^Missing valid Immunization"
 S ISIMISC("IZ")=IZIEN
 ;
 N ALLOWDUPS S ALLOWDUPS=+$G(ISIMISC("ALLOWDUPS"))
 I 'ALLOWDUPS,$D(^AUPNVIMM("AD",$E(VIEN,1,30))) D  
 . N IMIEN S IMIEN=0 F  S IMIEN=$O(^AUPNVIMM("AD",$E(VIEN,1,30),IMIEN)) Q:'IMIEN!EXIT  D  
 . . I +$G(^AUPNVIMM(IMIEN,0))=IZIEN S EXIT=IMIEN
 . Q
 I EXIT Q "-9^IZ/VISIT combo already exists"
 I $G(ISIPARAM("DEBUG"))>0 D  
 . W !,"+++AFTER Validations array (VALIMZ^ISIIMPUG)+++",!
 . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ;
 Q 1
 ;
VALCPT()
 N ISIRC,CPT,CPTIEN,VIEN,PRVNAR,PRVNARI,EXIT
 S (EXIT,ISIRC)=0
 I $G(ISIPARAM("DEBUG"))>0 D  
 . W !,"+++BEFORE Validated array (VALCPT^ISIIMPUG)+++",!
 . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 S ISIRC=$$CHECKENC(.ISIMISC) I ISIRC<0 Q ISIRC
 ;
 S CPT=$G(ISIMISC("CPT")) S CPTIEN=$O(^ICPT("B",CPT,0))
 I 'CPTIEN Q "-1^Missing valid CPT"
 S ISIMISC("CPT")=CPTIEN
 ;
 N ALLOWDUPS S ALLOWDUPS=+$G(ISIMISC("ALLOWDUPS"))
 I 'ALLOWDUPS,$D(^AUPNVCPT("AD",$E(VIEN,1,30))) D  
 . N ZIEN S ZIEN=0 F  S ZIEN=$O(^AUPNVCPT("AD",$E(VIEN,1,30),ZIEN)) Q:'ZIEN!EXIT  D  
 . . I +$G(^AUPNVCPT(ZIEN,0))=CPTIEN S EXIT=ZIEN
 . Q
 I EXIT Q "-9^CPT/VISIT combo already exists"
 ;
 S PRVNAR=$G(ISIMISC("PROVIDER_NARRATIVE"))
 I $L(PRVNAR)=0 Q "-1^Missing Provider Narrative."
 S PRVNARI=$O(^AUTNPOV("B",PRVNAR,0))
 I 'PRVNARI Q "-1^Missing/invalid Provider Narrative."
 S ISIMISC("PROVIDER_NARRATIVE")=PRVNARI
 ;
 I $G(ISIPARAM("DEBUG"))>0 D  
 . W !,"+++AFTER Validations array (VALCPT^ISIIMPUG)+++",!
 . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ;
 Q 1
 ;
VALEXAM()
 N ISIRC,EXAM,EXAMIEN,VIEN,EXIT
 S (EXIT,ISIRC)=0
 I $G(ISIPARAM("DEBUG"))>0 D  
 . W !,"+++BEFORE Validated array (VALEXAM^ISIIMPUG)+++",!
 . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 S ISIRC=$$CHECKENC(.ISIMISC) I ISIRC<0 Q ISIRC
 ;
 S EXAM=$G(ISIMISC("EXAM")) I EXAM'="" S EXAMIEN=$O(^AUTTEXAM("B",EXAM,0))
 I '$G(EXAMIEN) Q "-1^Missing valid EXAM"
 S ISIMISC("EXAM")=EXAMIEN
 ;
 N ALLOWDUPS S ALLOWDUPS=+$G(ISIMISC("ALLOWDUPS"))
 I 'ALLOWDUPS,$D(^AUPNVXAM("AD",$E(VIEN,1,30))) D  
 . N ZIEN S ZIEN=0 F  S ZIEN=$O(^AUPNVXAM("AD",$E(VIEN,1,30),ZIEN)) Q:'ZIEN!EXIT  D  
 . . I +$G(^AUPNVXAM(ZIEN,0))=EXAMIEN S EXIT=ZIEN
 . Q
 I EXIT Q "-9^EXAM/VISIT combo already exists"
 ;
 I $G(ISIPARAM("DEBUG"))>0 D  
 . W !,"+++AFTER Validations array (VALEXAM^ISIIMPUG)+++",!
 . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ;
 Q 1
 ;
VALPOV()
 N ISIRC,ICD9,IICD9,VIEN,EXIT
 S (EXIT,ISIRC)=0
 I $G(ISIPARAM("DEBUG"))>0 D  
 . W !,"+++BEFORE Validated array (VALEXAM^ISIIMPUG)+++",!
 . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 S ISIRC=$$CHECKENC(.ISIMISC) I ISIRC<0 Q ISIRC
 ;
 S ICD9=$G(ISIMISC("ICD9")) S IICD9=$O(^ICD9("AB",ICD9_" ",""))
 I 'IICD9 Q "-1^Missing valid ICD9 Code"
 S ISIMISC("ICD9")=IICD9
 ;
 N ALLOWDUPS S ALLOWDUPS=+$G(ISIMISC("ALLOWDUPS"))
 I 'ALLOWDUPS,$D(^AUPNVPOV("AD",$E(VIEN,1,30))) D  
 . N ZIEN S ZIEN=0 F  S ZIEN=$O(^AUPNVPOV("AD",$E(VIEN,1,30),ZIEN)) Q:'ZIEN!EXIT  D  
 . . I +$G(^AUPNVPOV(ZIEN,0))=IICD9 S EXIT=ZIEN
 . Q
 I EXIT Q "-9^ICD9/VISIT combo already exists"
 ;
 I $G(ISIPARAM("DEBUG"))>0 D  
 . W !,"+++AFTER Validations array (VALEXAM^ISIIMPUG)+++",!
 . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ;
 Q 1
 ;
VALVPTED()
 N ISIRC,ETOPIC,IETOPIC,VIEN,EXIT
 S (EXIT,ISIRC)=0
 I $G(ISIPARAM("DEBUG"))>0 D  
 . W !,"+++BEFORE Validated array (VALVPTED^ISIIMPUG)+++",!
 . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 S ISIRC=$$CHECKENC(.ISIMISC) I ISIRC<0 Q ISIRC
 ;
 S ETOPIC=$G(ISIMISC("ED_TOPIC")) S IETOPIC=$O(^AUTTEDT("B",ETOPIC,0))
 I 'IETOPIC Q "-1^Missing valid EDUCATION TOPIC"
 S ISIMISC("ED_TOPIC")=IETOPIC
 ;
 N ALLOWDUPS S ALLOWDUPS=+$G(ISIMISC("ALLOWDUPS"))
 I 'ALLOWDUPS,$D(^AUPNVPED("AD",$E(VIEN,1,30))) D  
 . N ZIEN S ZIEN=0 F  S ZIEN=$O(^AUPNVPED("AD",$E(VIEN,1,30),ZIEN)) Q:'ZIEN!EXIT  D  
 . . I +$G(^AUPNVPED(ZIEN,0))=IETOPIC S EXIT=ZIEN
 . Q
 I EXIT Q "-9^EDUCATION TOPIC/VISIT combo already exists"
 ;
 I $G(ISIPARAM("DEBUG"))>0 D  
 . W !,"+++AFTER Validations array (VALEXAM^ISIIMPUG)+++",!
 . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 Q 1
 ;
CHECKENC(ISIMISC)
 N ISIRC S ISIRC=0
 ;
 ;-- PAT_SSN (required) --
 I '$D(ISIMISC("PAT_SSN")) Q "-1^Missing Patient SSN (#2,.09)."
 I $D(ISIMISC("PAT_SSN")) D  
 . S VALUE=ISIMISC("PAT_SSN") I VALUE="" S ISIRC="-1^Invalid PAT_SSN (#2,.09)." Q
 . I '$D(^DPT("SSN",VALUE)) S ISIRC="-1^Invalid PAT_SSN (#2,.09)." Q
 . S DFN=$O(^DPT("SSN",VALUE,"")) I DFN="" S ISIRC="-1^Invalid PAT_SSN (#2,.09)." Q
 . S ISIMISC("DFN")=DFN
 . Q
 I +ISIRC<0 Q ISIRC
 ;
 ; -- DATETIME (required) -- 
 I '$G(ISIMISC("DATETIME")) Q "-1^Missing Datetime."
 ; Find Associated Visit for DATETIME
 S VIEN=$$VISITCHK(ISIMISC("DFN"),ISIMISC("DATETIME"))
 I 'VIEN Q "-1^Unable to find associated visit."
 S ISIMISC("VISIT_IEN")=VIEN
 ;
 I '$D(ISIMISC("PROVIDER")) Q "-1^Missing Provider (#200)"
 N PROVIDER S PROVIDER=ISIMISC("PROVIDER")
 I 'PROVIDER S PROVIDER=$O(^VA(200,"B",PROVIDER,""))
 I 'PROVIDER QUIT "-1^ ~ Missing PROVIDER"
 N PROVNM S PROVNM=$P($G(^VA(200,PROVIDER,0)),U)
 I '$O(^VA(200,"AK.PROVIDER",PROVNM,"")) Q "-1^ User missing PROVIDER key."
 S ISIMISC("PROVIDER")=PROVIDER
 ;
 Q ISIRC
 ;
VISITCHK(DFN,DATE)
 ; Grabs a visit ien if one is available
 ; INPUT = 
 ;   DFN is patient dfn
 ;   DATE is datetime
 ; OUTPUT =
 ;   VIEN is visit ien
 ;
 ;  Note -- Currently only grabs outpatient.
 ;          Will return a VIEN on same day if time provided is after visit.
 ;
 N RVDT
 S DFN=+$G(DFN) Q:'DFN 0
 S DATE=+$G(DATE) Q:'DATE 0
 S RVDT=9999999-$P(DATE,".")_"."_$P(DATE,".",2)
 I '$D(^AUPNVSIT("AA",DFN,RVDT)) S X=$O(^AUPNVSIT("AA",DFN,RVDT),-1) I X S RVDT=X ;try previous visit
 S VIEN=$O(^AUPNVSIT("AA",DFN,RVDT,"")) I 'VIEN Q 0
 ;N VCHK,VIEN S (VIEN,VCHK)=0 F  S VCHK=$O(^AUPNVSIT("AA",DFN,RVDT,VCHK)) Q:'VCHK!VIEN  D  
 ;. I $P($G(^AUPNVSIT(VCHK,150)),U,2)'=0 Q ;only outpatients
 ;. S VIEN=VCHK
 ;. Q
 ;
 Q VIEN
