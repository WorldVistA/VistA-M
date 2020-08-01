ISIIMP23 ;ISI GROUP/MLS -- Merge Users Utility 2.0 ;6/26/12
 ;;2.0;;;Jun 26,2012;Build 93
 ;
 ; NOTE -- This routine should be used with EXTREME caution.
 ;         It is ONLY(!!!) for test and demonstration systems.
 Q
 ;
 ; *****************************************************************
 ; Entry point for Utility to copy User file information
 ;
 ; INPUT:
 ; FPROV = DFN of source NEW PERSON (#200) record
 ; TPROV = DFN of target NEW PERSON (#200) record
 ;
 ;******************************************************************
 ;
COPYUSR(FPROV,TPROV) ;
 ;
 N X,Y,Z
 S FPROV=+$G(FPROV)
 S TPROV=+$G(TPROV)
 I '$D(^VA(200,TPROV,0)) Q
 I '$D(^VA(200,FPROV,0)) Q
 I TPROV=1 Q ;Don't overwrite one
 ;
 ; Start
 D BEGIN(FPROV,TPROV)
 D CROSSREF(FPROV,TPROV)
 Q
 ;
BEGIN(FPROV,TPROV) ;
 ;
 ;Kill
 K ^VA(200,TPROV,.2) ;UCIs (set of uscs user my choose)
 K ^VA(200,TPROV,2) ; Divisions
 K ^VA(200,TPROV,3.1)
 K ^VA(200,TPROV,4) ;Mutually exclusive keys (cannot be held by this user)
 K ^VA(200,TPROV,5) ;Service Section, mail code
 K ^VA(200,TPROV,19.5) ;Delegated options
 K ^VA(200,TPROV,19.6) ; Allowable New Menu
 K ^VA(200,TPROV,19.8) ; Menu template
 K ^VA(200,TPROV,50) ;Key delegation level
 K ^VA(200,TPROV,51) ;keys
 K ^VA(200,TPROV,52) ;Delegated keys
 K ^VA(200,TPROV,101) ;Restrict patient Selection
 K ^VA(200,TPROV,125) ; Problem list Primary view
 K ^VA(200,TPROV,200) ; Multiple Sign-on
 K ^VA(200,TPROV,201) ;Primary Menu option
 K ^VA(200,TPROV,202.1) ;Last option accessed
 K ^VA(200,TPROV,203) ;Secondary Menu option
 K ^VA(200,TPROV,351) ;Personal diagnosis codes
 K ^VA(200,TPROV,500) ;network addresss
 K ^VA(200,TPROV,8910) ;Visited from
 K ^VA(200,TPROV,"FOF") ;Accessible file (#200.032)
 K ^VA(200,TPROV,"EC") ;DMMS Units
 K ^VA(200,TPROV,"LM1") ; Spelling exception
 K ^VA(200,TPROV,"LM2") ; DEFINED FORMATS FOR LM
 K ^VA(200,TPROV,"LM3") ; DEFINED PHRASES FOR LM
 K ^VA(200,TPROV,"LM4") ; LM LIMIT WP FIELDS TO EDIT
 K ^VA(200,TPROV,"ORD") ;CPRS TABs
 K ^VA(200,TPROV,"NPI")
 K ^VA(200,TPROV,"PS") ;authorized to write medicao orders
 K ^VA(200,TPROV,"PS1") ;Licensing State (credentialling)
 K ^VA(200,TPROV,"PS2") ; STATE ISSUING DEA NUMBER
 K ^VA(200,TPROV,"PS3") ; SCHEDULE II NARCOTIC, etc.
 K ^VA(200,TPROV,"RAC") ;Rad/Nun Classification
 K ^VA(200,TPROV,"RAL") ;Rad/Nuc Location
 K ^VA(200,TPROV,"USC1") ;PERSON Class
 K ^VA(200,TPROV,"USC2") ;Program of Study
 K ^VA(200,TPROV,"USC3") ;user class multiple
 ;
 ;Merge
 I $D(^VA(200,FPROV,.2)) M ^VA(200,TPROV,.2)=^VA(200,FPROV,.2)
 I $D(^VA(200,FPROV,1.2)) M ^VA(200,TPROV,1.2)=^VA(200,FPROV,1.2) ;Terminal type last used
 I $D(^VA(200,FPROV,2)) M ^VA(200,TPROV,2)=^VA(200,FPROV,2)
 I $D(^VA(200,FPROV,3.1)) M ^VA(200,TPROV,3.1)=^VA(200,FPROV,3.1)
 I $D(^VA(200,FPROV,4)) M ^VA(200,TPROV,4)=^VA(200,FPROV,4)
 I $D(^VA(200,FPROV,5)) M ^VA(200,TPROV,5)=^VA(200,FPROV,5)
 I $D(^VA(200,FPROV,19.5)) M ^VA(200,TPROV,19.5)=^VA(200,FPROV,19.5)
 I $D(^VA(200,FPROV,19.6)) M ^VA(200,TPROV,19.6)=^VA(200,FPROV,19.6)
 I $D(^VA(200,FPROV,19.8)) M ^VA(200,TPROV,19.8)=^VA(200,FRPOV,19.8)
 I $D(^VA(200,FPROV,50)) S ^VA(200,TPROV,50)=^VA(200,FPROV,50)
 I $D(^VA(200,FPROV,51)) M ^VA(200,TPROV,51)=^VA(200,FPROV,51)
 I $D(^VA(200,FPROV,52)) M ^VA(200,TPROV,52)=^VA(200,FPROV,52)
 I $D(^VA(200,FPROV,101)) M ^VA(200,TPROV,101)=^VA(200,FPROV,101)
 I $D(^VA(200,FPROV,125)) S ^VA(200,TPROV,125)=^VA(200,FPROV,125)
 I $D(^VA(200,FPROV,200)) S ^VA(200,TPROV,200)=^VA(200,FPROV,200)
 I $D(^VA(200,FPROV,201)) S ^VA(200,TPROV,201)=^VA(200,FPROV,201)
 I $D(^VA(200,FPROV,202.1)) M ^VA(200,TPROV,202.1)=^VA(200,FPROV,202.1)
 I $D(^VA(200,FPROV,203)) M ^VA(200,TPROV,203)=^VA(200,FPROV,203)
 I $D(^VA(200,FPROV,351)) M ^VA(200,TPROV,351)=^VA(200,FPROV,351)
 I $D(^VA(200,FPROV,400)) S ^VA(200,TPROV,400)=^VA(200,FPROV,400) ;supply employee
 I $D(^VA(200,FPROV,450)) S ^VA(200,TPROV,450)=^VA(200,FPROV,450) ;paid employee
 I $D(^VA(200,FPROV,500)) M ^VA(200,TPROV,500)=^VA(200,FPROV,500)
 I $D(^VA(200,FPROV,654)) M ^VA(200,TPROV,500)=^VA(200,FPROV,654) ; social worker
 I $D(^VA(200,FPROV,8910)) M ^VA(200,TPROV,8910)=^VA(200,FPROV,8910)
 I $D(^VA(200,FPROV,"FOF")) M ^VA(200,TPROV,"FOF")=^VA(200,FPROV,"FOF")
 I $D(^VA(200,FPROV,"EC")) M ^VA(200,TPROV,"EC")=^VA(200,FPROV,"EC")
 I $D(^VA(200,FPROV,"LM1")) M ^VA(200,TPROV,"LM1")=^VA(200,FPROV,"LM1")
 I $D(^VA(200,FPROV,"LM2")) M ^VA(200,TPROV,"LM2")=^VA(200,FPROV,"LM2")
 I $D(^VA(200,FPROV,"LM3")) M ^VA(200,TPROV,"LM3")=^VA(200,FPROV,"LM3")
 I $D(^VA(200,FPROV,"LM4")) M ^VA(200,TPROV,"LM4")=^VA(200,FPROV,"LM4")
 I $D(^VA(200,FPROV,"NPI")) M ^VA(200,TPROV,"NPI")=^VA(200,FPROV,"NPI")
 I $D(^VA(200,FPROV,"ORD")) M ^VA(200,TPROV,"ORD")=^VA(200,FPROV,"ORD") 
 I $D(^VA(200,FPROV,"PS")) M ^VA(200,TPROV,"PS")=^VA(200,FPROV,"PS")
 I $D(^VA(200,FPROV,"PS1")) M ^VA(200,TPROV,"PS1")=^VA(200,FPROV,"PS1")
 I $D(^VA(200,FPROV,"PS2")) M ^VA(200,TPROV,"PS2")=^VA(200,FPROV,"PS2")
 I $D(^VA(200,FPROV,"PS2")) S ^VA(200,TPROV,"PS2")=^VA(200,FPROV,"PS2")
 I $D(^VA(200,FPROV,"RAC")) M ^VA(200,TPROV,"RAC")=^VA(200,FPROV,"RAC") 
 I $D(^VA(200,FPROV,"RAL")) M ^VA(200,TPROV,"RAL")=^VA(200,FPROV,"RAL")
 I $D(^VA(200,FPROV,"USC1")) M ^VA(200,TPROV,"USC1")=^VA(200,FPROV,"USC1")
 I $D(^VA(200,FPROV,"USC2")) M ^VA(200,TPROV,"USC2")=^VA(200,FPROV,"USC2")
 I $D(^VA(200,FPROV,"USC3")) M ^VA(200,TPROV,"USC3")=^VA(200,FPROV,"USC3")
 ;
 ;extra cleanup
 I $D(^VA(200,TPROV,8910)) S $P(^VA(200,TPROV,8910,1,0),"^",3)=TPROV
 I $P(^VA(200,FPROV,0),U,4)="@" S $P(^VA(200,TPROV,0),"^",4)="@"  ;file access mode
 ;
 Q
 ;
CROSSREF(FPROV,TPROV)
 ;Set new cross ref
 N DIV S DA=TPROV,DIK="^VA(200,DA," D IX1^DIK
 Q
 ;
 ; *******************************************************************
 ; Entry point to copy pnt data from one patient to another
 ;  using Dataloader (import) and VPR (export) utilities
 ;
 ; INPUT:
 ;   FPNT - FROM PATIENT (#2)
 ;   TPNT - TO PATIENT (#2)
 ; OUT:
 ;   ISIRC - -1^description if Error
 ; *******************************************************************
 ;
COPYPNT(FPNT,TPNT)
 ;
 N X,Y,Z,ZSSN,ISIRESUL
 S FPNT=+$G(FPNT)
 S TPNT=+$G(TPNT)
 I '$D(^DPT(TPNT,0)) Q
 I '$D(^DPT(FPNT,0)) Q
 ;
 D PNTFETCH
 Q
 ;
PNTFETCH ;
 N TYPE,ISIVPR,ISII,ISIRC
 K ISIVPR S (ISIRC,ISII)=0
 S TYPE="vitals;problems;allergies;meds"
 ;S TYPE="meds"
 ;
 D LOADMAP(.ISIMAP)
 ;
 D GET^VPRD(.ISIVPR,FPNT,TYPE)
 ;
 D TRANSLAT
 ;
 Q ISIRC
 ; 
LOADMAP(ISIMAP) ;
 N BUF,FILE,FIELD,I,ELEMENT,TRANSFORM
 K ISIMAP
 F I=3:1  S BUF=$P($T(MAPTOEXT+I),";;",2)  Q:BUF=""  D
 . S ELEMENT=$$TRIM^XLFSTR($P(BUF,"|"))  Q:ELEMENT=""
 . S TRANSFORM=$$TRIM^XLFSTR($P(BUF,"|",2))
 . S ISIMAP(ELEMENT)=TRANSFORM ; _"|"_FILE_"|"_FIELD
 Q
 ;
MAPTOEXT ;; +++ Element translation table ***
 ;; VPR ELEMENT    | TRANSFORM
 ;;--------------------------------
 ;; problem        | F - PROBLEM
 ;; allergy        | F - ALLERGY
 ;; vital          | F - VITAL
 ;; med            | F - MEDS
 Q
 ;
TRANSLAT ;
 N NODE,ELEMENT,TRANS,TRANS1,VALUE,DESCR,LINE,FILE,FIELD
 N ISII S ISII=0
 F  S ISII=$O(@ISIVPR@(ISII)) Q:'ISII  D  
 . S NODE=$G(@ISIVPR@(ISII))
 . I $L(NODE)=0 Q
 . S ELEMENT=$TR($P(NODE," "),"<>","")
 . Q:$L(ELEMENT)=0
 . I '$D(ISIMAP(ELEMENT)) Q
 . S LINE=$G(ISIMAP(ELEMENT))
 . S TRANS=$P(LINE,"|")
 . S TRANS1=$$TRIM^XLFSTR($P(TRANS,"-",2))
 . S TRANS=$$TRIM^XLFSTR($P(TRANS,"-"))
 . S DESCR=""
 . I TRANS="F" D FUNCTION
 . Q
 Q
 ;
FUNCTION ;call to translation functions
 I $T(@TRANS1)]"" D @TRANS1
 Q
 ;
VITAL ;
 N ZLINE,ZLOC,ZNUM,ZARY,ZTEST,ZVAL,ZIEN,ZENT,EXIT
 N ZMISC K ZMISC S ISIRC=0
 ; grab location
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"location","measurements")
 I ZNUM'=1 Q
 S ZLINE=$P($G(ZARY(1)),U)
 S ZLOC=+$P(ZLINE,"code='",2)
 I 'ZLOC Q
 ; grab Date Taken value
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"entered","facility")
 I ZNUM'=1 Q
 S ZLINE=$P($G(ZARY(1)),U)
 S ZENT=$P(ZLINE,"value='",2)
 S ZENT=$P(ZENT,"'") 
 I $L(ZENT)=0 S ZENT=$$NOW^XLFDT
 ; grab test values
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"measurement","/measurements")
 I 'ZNUM Q
 N Z,Y F Z=1:1:ZNUM S ZLINE=$P($G(ZARY(Z)),U) D  
 . I ZLINE'["measurement " Q
 . K ZMISC
 . ; Grab Vital Type
 . S ZTEST=$P(ZLINE,"name='",2)
 . Q:$L(ZTEST)=0
 . S ZTEST=$P(ZTEST,"'") Q:$L(ZTEST)=0
 . S Y=$O(^GMRD(120.51,"B",ZTEST,"")) I Y="" D  
 . . S Y=$O(^GMRD(120.51,"C",ZTEST,""))
 . . Q
 . S ZMISC("VITAL_TYPE")=Y
 . ; Get Rate value
 . S ZVAL=$P(ZLINE,"value='",2)
 . S ZVAL=$P(ZVAL,"'") Q:$L(ZVAL)=0
 . S ZMISC("RATE")=ZVAL
 . S ZMISC("DFN")=TPNT
 . S ZMISC("ENTERED_BY")=$G(DUZ)
 . S ZMISC("LOCATION")=ZLOC
 . S ZMISC("DT_TAKEN")=ZENT
 . S ISIRC=$$IMPORTVT^ISIIMP09(.ZMISC)  
 . Q
 ;
 Q
 ;
PROBLEM ;
 N ZLINE,ZTYP,ZNUM,ZARY,ZTEST,ZVAL,ZIEN,ZENT,EXIT,ZPROV,ZICD,ZSTAT
 N ZICDIEN,ZNAME
 N ZMISC S ISIRC=0 K ZMISC
 ; grab accuity
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"acuity","/problem")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZTYP=$P(ZLINE,"code='",2)
 S ZTYP=$P(ZTYP,"'")
 S ZTYP=$S(ZTYP="A":"A",ZTYP="C":"C",1:"A")
 S ZMISC("TYPE")=ZTYP
 ; grab Onset date value
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"onset","/problem")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZENT=$P(ZLINE,"value='",2)
 S ZENT=$P(ZENT,"'") 
 I $L(ZENT)=0 S ZENT=$$NOW^XLFDT
 S ZMISC("ONSET")=ZENT
 ; grab Provider ID
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"provider","/problem")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZPROV=$P(ZLINE,"code='",2)
 S ZPROV=$P(ZPROV,"'")
 Q:'ZPROV  
 S ZMISC("PROVIDER")=ZPROV
 ; grab Status value
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"status","/problem")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZSTAT=$P(ZLINE,"code='",2)
 S ZSTAT=$P(ZSTAT,"'")
 Q:$L(ZSTAT)=0 
 S ZMISC("STATUS")=ZSTAT
 ; Grab Problem (ICD9) values
 ;  #1 grab icd value
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"icd","/problem")
 ;I ZNUM'=1 Q
 S ZLINE=$P($G(ZARY(1)),U)
 S ZICD=$P(ZLINE,"value='",2)
 S ZICD=$P(ZICD,"'")
 Q:$L(ZICD)=0
 ; #2 get problem name
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"name","/problem")
 ;I ZNUM'=1 Q
 S ZLINE=$P($G(ZARY(1)),U)
 S ZNAME=$P(ZLINE,"value='",2)
 S ZNAME=$P(ZNAME," (")
 Q:$L(ZNAME)=0
 S ZNAME=$$UP^XLFSTR(ZNAME)
 ; #3 grab lexicon value
 N OUT,EXPIEN,MAJCON,CODE,ICD
 S (OUT,EXPIEN)="" F  S EXPIEN=$O(^LEX(757.01,"B",ZNAME,EXPIEN)) Q:'EXPIEN  D  Q:OUT=1
 . S EXPNM=$G(^LEX(757.01,EXPIEN,0)) Q:EXPNM=""
 . S MAJCON=$P($G(^LEX(757.01,EXPIEN,1)),"^") Q:MAJCON=""
 . S CODE="" F  S CODE=$O(^LEX(757.02,"AMC",MAJCON,CODE)) Q:'CODE  D  Q:OUT=1
 . . S ICD=$P($G(^LEX(757.02,CODE,0)),"^",2) Q:ICD=""
 . . I ICD=ZICD S OUT=1 Q
 . . Q
 I EXPNM="" Q
 I EXPIEN="" Q
 I MAJCON="" Q
 S ZICDIEN=$O(^ICD9("AB",ZICD_" ","")) I ZICDIEN="" Q
 S ZMISC("EXPIEN")=EXPIEN
 S ZMISC("MAJCON")=MAJCON
 S ZMISC("ICD")=ZICD
 S ZMISC("ICDIEN")=ZICDIEN
 S ZMISC("EXPNM")=EXPNM
 S ZMISC("DFN")=TPNT
 S ISIRC=$$CREATE^ISIIMP07(.ZMISC)
 Q
 ;
ALLERGY ;
 N ZLINE,ZID,ZNUM,ZARY,ZVAL,ZIEN,ZSYMP,ZHIST,ZDT,ZALL,EXIT
 N ZMISC S ISIRC=0 K ZMISC
 ; Set PAT_SSN
 S ZMISC("PAT_SSN")=$P($G(^DPT(TPNT,0)),U,9)
 ; Grab Allergen
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"name","/allergy")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZALL=$P(ZLINE,"value='",2)
 S ZALL=$P(ZALL,"' ")
 I $L(ZALL)=0 Q
 S ZMISC("ALLERGEN")=ZALL
 ; Get #120.8 IEN
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"id","/allergy")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZID=+$P(ZLINE,"value='",2)
 I 'ZID Q
 I '$D(^GMR(120.8,ZID,0)) Q
 ; Grab Originator from ID
 S ZIEN=$P($G(^GMR(120.8,ZID,0)),U,5)
 S ZMISC("ORIGINTR")=$P($G(^VA(200,ZIEN,0)),U)
 ; Grab Symptom
 K ZARY S ZMISC("SYMPTOM")=""
 S ZNUM=$$NESTED(.ZARY,ISII,"reaction","/reactions")
 F X=1:1:ZNUM D  
 . S ZLINE=$P($G(ZARY(1)),U)
 . S ZSYMP=$P(ZLINE,"name='",2)
 . S ZSYMP=$P(ZSYMP,"' ")
 . I $L(ZSYMP)=0 Q
 . S ZMISC("SYMPTOM")=ZMISC("SYMPTOM")_ZSYMP_"|"
 . Q
 ; Grab Historic/Observed
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"source","/allergy")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZHIST=$P(ZLINE,"value='",2)
 S ZHIST=$P(ZHIST,"' ")
 I $L(ZHIST)=0 Q
 S ZHIST=$S(ZHIST="H":1,ZHIST="O":0,1:1)
 S ZMISC("HISTORIC")=ZHIST
 ; Grab Orig Date
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"entered","/allergy")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZDT=$P(ZLINE,"value='",2)
 S ZDT=$P(ZDT,"' ")
 I $L(ZDT)=0 Q
 S Y=ZDT X ^DD("DD") S ZDT=Y
 S ZMISC("ORIG_DATE")=ZDT
 ; Grab Observe Date
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"verified","/allergy")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZDT=$P(ZLINE,"value='",2)
 S ZDT=$P(ZDT,"' ")
 S Y=ZDT X ^DD("DD") S ZDT=Y
 I $L(ZDT)>0 S ZMISC("OBSRV_DT")=ZDT
 E  S ZMISC("OBSRV_DT")=ZMISC("ORIG_DATE")
 ;
 S ISIRC=$$VALALG^ISIIMPU6(.ZMISC)
 I +ISIRC<0 Q
 S ISIRC=$$IMPRTALG^ISIIMP11(.ZMISC)
 Q
 ;
MEDS ;
 N ZLINE,ZID,ZNUM,ZARY,ZPRV,ZDT,EXIT,ZDRUG,ZSIG,ZQNT,ZSUP,ZFIL
 N ZMISC S ISIRC=0 K ZMISC
 ; Set PAT_SSN
 S ZMISC("DFN")=$G(TPNT)
 ; Grab DRUG
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"product","/product")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZDRUG=+$P(ZLINE,"code='",2)
 I '$D(^PSDRUG(ZDRUG,0)) Q
 S ZMISC("DRUG")=$O(^PSDRUG("B",ZDRUG,""))
 ; Grab issue,dispense,fill date
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"lastFilled","/med")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZDT=$P(ZLINE,"value='",2)
 S ZDT=$P(ZDT,"' ")
 I 'ZDT D  
 . K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"ordered","/med")
 . S ZLINE=$P($G(ZARY(1)),U)
 . S ZDT=$P(ZLINE,"value='",2)
 . S ZDT=$P(ZDT,"' ")
 . Q
 I 'ZDT Q
 S ZMISC("DATE")=ZDT
 ; Grab expiration date
 K ZARY S ZDT="" S ZNUM=$$NESTED(.ZARY,ISII,"expires","/med")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZDT=$P(ZLINE,"value='",2)
 S ZDT=$P(ZDT,"' ")
 S ZMISC("EXPIRDT")=ZDT
 ; Grab medication instructions
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"dose","/doses")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZSIG=$P(ZLINE,"schedule='",2)
 S ZSIG=$P(ZSIG,"' ")
 I $L(ZSIG)=0 Q
 S ZSIG=$O(^PS(51,"B",ZSIG,""))
 S ZMISC("SIG")=ZSIG
 ; Grab Quantity
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"quantity","/med")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZQNT=$P(ZLINE,"value='",2)
 S ZQNT=$P(ZQNT,"' ")
 I 'ZQNT Q
 S ZMISC("QTY")=ZQNT
 ; Grab Days Supply
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"daysSupply","/med")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZSUP=$P(ZLINE,"value='",2)
 S ZSUP=$P(ZSUP,"' ")
 I 'ZSUP D  
 . S ZSUP=0 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"dose","/doses")
 .  S ZLINE=$P($G(ZARY(1)),U)
 . S ZSUP=+$P(ZLINE,"dose='",2)
 . Q
 I 'ZSUP Q
 S ZMISC("SUPPLY")=ZSUP
 ; Grab Refills
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"fillsAllowed","/med")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZFIL=$P(ZLINE,"value='",2)
 S ZFIL=$P(ZFIL,"' ")
 I 'ZFIL Q
 S ZMISC("REFILL")=ZFIL
 ; Grab Ordering Provider
 K ZARY S ZNUM=$$NESTED(.ZARY,ISII,"orderingProvider","/med")
 S ZLINE=$P($G(ZARY(1)),U)
 S ZPRV=$P(ZLINE,"code='",2)
 S ZPRV=$P(ZPRV,"' ")
 I '$D(^VA(200,ZPRV,0)) Q
 S ZMISC("PROV")=ZPRV
 ;
 N PSOSITE S PSOSITE=0 F  S PSOSITE=$O(^PS(59,PSOSITE)) Q:'PSOSITE  D  I $G(ZMISC("PSOSITE"))'="" Q
 . S Y=+$G(^PS(59,PSOSITE,"I"))
 . I Y="" S ZMISC("PSOSITE")=PSOSITE Q
 . I Y>DT Q
 . S ZMISC("PSOSITE")=PSOSITE
 . Q
 Q:$G(ZMISC("PSOSITE"))=""
 ;
 S ISIRC=$$MEDS^ISIIMP17(.ZMISC)
 Q
 ;
NESTED(ZARY,ZISII,ZMATCH,ZTERM)
 ; IN:
 ;   ISII starting location
 ;   ZMATCH = matching element
 ;   ZTERM = terminating element
 ;
 ; OUT: 
 ;    ZCNT = number of recs found
 ;    ZARY(ZCNT) = node_U_ien location
 ;
 N ZNODE,ZELEM,ZCNT,EXIT
 S (ZCNT,EXIT)=0 K ZARY
 S ZISII=+$G(ZISII) Q:'ZISII  
 S ZMATCH=$G(ZMATCH) Q:$L(ZMATCH)=0
 S ZTERM=$G(ZTERM)
 ;
 F  S ZISII=$O(@ISIVPR@(ZISII)) Q:'ZISII!(EXIT)  D  
 . S ZNODE=$G(@ISIVPR@(ZISII))
 . I $L(ZNODE)=0 Q
 . S ZELEM=$TR($P(ZNODE," "),"<>","")
 . Q:$L(ZELEM)=0
 . I ZELEM=ZTERM S EXIT=1 Q
 . I ZELEM=ZMATCH S ZCNT=ZCNT+1,ZARY(ZCNT)=ZNODE_U_ZISII Q
 . Q
 Q ZCNT
