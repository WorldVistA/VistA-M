ECXLBB ;DALOI/KML - DSS BLOOD BANK EXTRACT ;9/13/10  13:32
 ;;3.0;DSS EXTRACTS;**78,84,90,92,104,105,102,120,127**;Dec 22, 1997;Build 36
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ; access to the LAB DATA file (#63) is supported by 
 ; controlled subscription to IA 525  (global root ^LR)  
 ; access to the BLOOD PRODUCT (#66) is supported by IA 4510
BEG ;entry point from option
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
START ; Entry point from tasked job
 ; begin package specific extract
 N ECTRSP,ECADMT,ECTODT,ECENCTR,ECPAT,ECLRDFN,ECXPHY,ECXPHYPC,ECPHYNPI
 N ECD,ECXDFN,ECARRY,EC66,ECERR,ECTRFDT,ECTRFTM,ECX,ECINOUT,ECXINST,ECXPATCAT
 ;variables ECFILE,EC23,ECXYM,ECINST,ECSD,ECSD1,ECED passed in 
 ; by taskmanager 
 ; ECED defined in ^ECXTRAC - it represents the end date of the extract
 ; sort process.  TRANSFUSION DATE should be within start and end dates
 ; ECED and ECSD were assigned with input provided by the user interface
 ; and ECSD1 = ECSD-.1
 ; Read through the TRANSFUSION RECORD sub-file (63.017) of 
 ; the LAB DATA file (#63)
 ;the global nodes containing transfusion record entries are constructed
 ; by calculating the TRANSFUSION DATE/TIME (.01)
 ; into its reverse date/time representation and then DINUM'd when 
 ;filing the record entry 
 ; ECD equals the reverse date/time of ECED+.3 and will need to be
 ; reset for each DFN.
 I $D(ZTQUEUED),$$S^%ZTLOAD S QFLG=1 Q  ;quit if tasked and user sends stop request  (QFLG assigned in ECXTRAC)
AUDRPT ; entry point for pre-extract audit report
 S ECTODT=9999999-ECSD1,ECLRDFN=0
 F  S ECLRDFN=$O(^LR(ECLRDFN)) Q:'ECLRDFN  S ECXDFN=$$GETDFN(ECLRDFN),ECERR=$$PAT(ECXDFN) S ECD=9999999-(ECED+.3) F  S ECD=$O(^LR(ECLRDFN,1.6,ECD)) Q:ECERR  Q:'ECD!(ECD>ECTODT)  S EC0=^LR(ECLRDFN,1.6,ECD,0) D
 .; ECARRY(1)=TRANSFUSION DATE AND TIME, 
 .; ECARRY(3)=COMPONENT, ECARRY(4)=COMPONENT ABBREVIATION
 .; ECARRY(5)=UNITS POOLED, ECARRY(6)=TRANSFUSION REACTION, 
 .; ECARRY(7)=VOLUME TRANSFUSED, ECARRY(8)=TRANSFUSION REACTION TYPE
 .; ECARRY(9)=REQUESTING PROVIDER, ECARRY(10)=REQUEST. PROV. PERSON CLASS
 .; ECARRY(11)=UNIT MODIFIED,ECARRY(12)=UNIT MODIFICATION
 .; ECARRY(13)=PRODUCTION DIVISION CODE
 . S ECARRY(1)=$P(EC0,"^"),EC66=$G(^LAB(66,$P(EC0,"^",2),0))
 . S ECARRY(3)=$E($P(EC66,"^"),1,15),ECARRY(4)=$P(EC66,"^",2)
 . S ECARRY(5)=$S(+$P(EC0,"^",7)=0:1,1:+$P(EC0,"^",7))
 . S ECARRY(6)=$S($P(EC0,"^",8)=1:"Y",1:"N"),ECARRY(7)=$P(EC0,"^",10)
 . S ECARRY(8)=$E($P($G(^LAB(65.4,+$P(EC0,"^",11),0)),"^"),1,10)
 . S (ECARRY(9),ECARRY(10),ECARRY(13))="" D GETRPRV
 . S ECARRY(11)=$$MODIFIED(),(ECXPHY,ECXPHYPC,ECPHYNPI)=""
 . S ECARRY(12)=$S(ECARRY(11)="Y":$$UNITMODS(),1:"")
 . D GETDATA
 . K ECARRY
 D AUDRPT^ECXLBB1
 Q
UNITMODS() ; Get modification criteria from fields #.06 and #3 from file #66
 N MODARY,MO,EC66A,MODSTR,STR3
 S MODARY("DIVIDED")="D",MODARY("POOLED")="P",MODARY("WASHED")="W"
 S MODARY("FROZEN")="F",MODARY("LEUKOCYTE POOR")="L"
 S MODARY("REJUVENATED")="R",MODARY("DEGLYCEROLIZED")="G"
 S MODARY("IRRADIATED")="I",MODARY("SEPARATED")="S"
 ;if modification criteria is null determine value from description
 S MODSTR=$S($P(EC66,U,6)'="":$P(EC66,U,6),1:$$CHKMOD^ECXLBB1($P(EC66,"^")))
 ;get modification criteria for entries at field #3 in file #66
 S MOD=0 F  S MOD=$O(^LAB(66,$P(EC0,"^",2),3,MOD)) Q:'MOD  D
 .S EC66A=$G(^LAB(66,MOD,0)) I EC66A="" Q
 .S STR3=$S($P(EC66A,U,6)'="":$P(EC66A,U,6),1:$$CHKMOD^ECXLBB1($P(EC66A,"^")))
 .I STR3'="",MODSTR'[STR3 S MODSTR=MODSTR_STR3
 Q MODSTR
MODIFIED() ; Was unit modified
 ; Init variables
 N XMATCH,UNIT,MOD,COMPID,MODNODE,MODTO
 S (XMATCH,UNIT)=0,MOD=""
 ; Check input
 Q:'$G(ECLRDFN)!'$P(EC0,U,2) "N"
 ;Find xmatch for blood component request
 S XMATCH=$O(^LR(ECLRDFN,1.8,$P(EC0,U,2),1,XMATCH)) Q:'XMATCH "N"
 ;Get blood inventory file (#65) pointer
 S UNIT=$P($G(^LR(ECLRDFN,1.8,$P(EC0,"^",2),1,XMATCH,0)),U)
 ;Look at disposition field (#4.1) in blood inventory file (#65)
 S MOD=$P($G(^LRD(65,+XMATCH,4)),U),COMPID=$P(EC66,U,3)
 ; Get 'the modified to' entry pointer to blood inventory file (#66)
 I MOD="MO" S MODTO=0 F  S MODTO=$O(^LRD(65,+XMATCH,9,MODTO)) Q:'MODTO  D
 .S MODNODE=$G(^LRD(65,+XMATCH,9,MODTO,0)) Q:$P(^(0),U,3)'>1
 .Q:$P(MODNODE,U,2)'=COMPID
 .; Set the modify to unit ien for file (#66)
 Q $S(MOD="MO":"Y",1:"N")
GETRPRV ; get requesting provider, requesting provider person class and 
 ; production division code
 ; input: ECD      =INVERTED DATE SUBSCRIPT
 ;        ECARRY(1)=TRANSFUSION DATE AND TIME
 ; note: Accessioned data in file #68 is stored up to 90 days.
 N ECXBNOD,ACC,ACCDT,ACCNODE,PERCLS,DIV,NUM
 I ECARRY(1)="" Q  ;there is no transfusion date
 ;get BLOOD BANK record, field #1, in file #63 located on "BB" node
 ;since there is a slight time lapse, $O will find the BB record
 S ECXBNOD=$O(^LR(ECLRDFN,"BB",ECD)) I ECXBNOD="" Q
 S ECXBNOD=^LR(ECLRDFN,"BB",ECXBNOD,0) I ECXBNOD="" Q
 ;Compose accession number,originating from field #.06 subfile #63.01
 ; ex. ACC=BB 0528 27
 S ACC=$P(ECXBNOD,U,6),ACC=$TR($P(ACC," ",2,99)," ")
 S ACCDT=$E(ECARRY(1),1,3)_$E(ACC,1,4),NUM=$E(ACC,5,99)
 ;Get field #2 from file #68, field #1 from subfile #68.01 which is
 ;subfile #68.02. Look at 29=blood bank ien, from 0th node, get fields
 ;#6.5 PROVIDER and #26 DIV
 I (ACCDT)=""!(NUM="") Q
 ; identify bb accession area the patient was in to get the right DIV
 S AREA=$$AREA
 S ACCNODE=$G(^LRO(68,+AREA,1,ACCDT,1,NUM,0))
 S ECARRY(9)=$P(ACCNODE,U,8) I ECARRY(9)'="" D
 . S PERCLS=$$GET^XUA4A72(ECARRY(9),ACCDT)
 . I +PERCLS>0 S ECARRY(10)=$P(PERCLS,U,7)
 . S ECREQNPI=$$NPI^XUSNPI("Individual_ID",ECARRY(9),ACCDT)
 . S:+ECREQNPI'>0 ECREQNPI="" S ECREQNPI=$P(ECREQNPI,U)
 . S ECARRY(9)=2_ECARRY(9)
 S DIV=$P($G(^LRO(68,+AREA,1,ACCDT,1,NUM,.4)),U)
 I DIV'="" S ECARRY(13)=$$RADDIV^ECXDEPT(DIV)
 Q
AREA() ; resolve accession area's ien to use and validate
 ;          Accession number
 ;          Patient LRDFN
 ; note: if there is only one accession area use '29'
 N A,CNT,BBLIST,DFN,ACC,AREA,DATE,TDATE,ACCNODE
 S (CNT,FLAG,A)=0,DFN=""
 ; set the date from the "bb" node in file (#63)
 S DATE=$P(ECXBNOD,U)
 ; setup array for bb accession areas if more than one
 F  S A=$O(^LRO(68,A)) Q:'A  I $P($G(^LRO(68,A,0)),"^",2)="BB" D
 . S BBLIST(A)=""
 . S CNT=CNT+1
 I CNT'>1 Q 29
 S AREA=0 F  S AREA=$O(BBLIST(AREA)) Q:'AREA  D  Q:FLAG
 . ; get additional accession information for validation
 . S ACCNODE=$G(^LRO(68,AREA,1,$P(DATE,"."),1,NUM,0))
 . S ACC=$G(^LRO(68,AREA,1,$P(DATE,"."),1,NUM,.2))
 . S DFN=$P($G(ACCNODE),U)
 . S TDATE=$P($G(^LRO(68,AREA,1,$P(DATE,"."),1,NUM,3)),U)
 . I (DFN=ECLRDFN)&(ACC=$P(ECXBNOD,U,6))&(DATE=TDATE) S FLAG=1
 Q AREA
GETDATA ; gather rest of extract data that will be recorded in an 
 ; entry in file 727.829
 N ECXSTR
 S ECTRFDT=$$ECXDOB^ECXUTL(ECARRY(1)),ECTRFTM=$$ECXTIME^ECXUTL(ECARRY(1))
 S ECX=$$INP^ECXUTL2(ECXDFN,ECARRY(1)),ECINOUT=$P(ECX,U),ECTRSP=$P(ECX,U,3),ECADMT=$P(ECX,U,4) ; [FLD #5]
 ;
 ;- Observation patient indicator (YES/NO)
 S ECXOBS=$$OBSPAT^ECXUTL4(ECINOUT,ECTRSP)
 ;- If no encounter number don't file record
 S ECENCTR=$$ENCNUM^ECXUTL4(ECINOUT,ECPAT("SSN"),ECADMT,ECARRY(1),ECTRSP,ECXOBS,ECHEAD,,) ; [FLD #6]
 Q:ECENCTR=""
 ;get emergency response indicator (FEMA)
 S ECXERI=ECPAT("ERI")
 ;
 ; ******* - PATCH 127, ADD PATCAT CODE ********
 S ECXPATCAT=$$PATCAT^ECXUTL(ECXDFN)
 S ECXSTR=$G(EC23)_"^"_ECINST_"^"_ECXDFN_"^"_ECPAT("SSN")_"^"_ECPAT("NAME")_"^"_ECINOUT_"^"_ECENCTR_"^"_ECTRFDT_"^"_ECTRFTM_"^"_ECARRY(3)_"^"_ECARRY(4)_"^"_ECARRY(5)_"^"_ECARRY(7)_"^"_ECARRY(6)_"^"_ECARRY(8)_"^BB"_ECARRY(13)_"^^"
 I $G(ECXLOGIC)>2005 S ECXSTR=ECXSTR_U_ECXPHY_U_ECXPHYPC
 I $G(ECXLOGIC)>2006 D
 .S ECXSTR=ECXSTR_U_ECXERI_U_ECARRY(11)_U_ECARRY(12)_U_ECARRY(9)_U_ECARRY(10)_U_ECARRY(13)_U
 I '$D(ECXRPT) D FILE(ECXSTR) Q
 S ^TMP("ECXLBB",$J,ECXDFN,ECD)=ECXSTR  ;temporary global array
 I $D(ECXCRPT) D
 . N ECCOUNT S ECCOUNT=0
 . F  S ECCOUNT=ECCOUNT+1 Q:'$D(^TMP("ECXLBBC",$J,$S($G(ECXCFLG)=1:ECARRY(4),1:"ZZNOZZ"),ECXDFN,ECTRFDT_"."_ECTRFTM_"."_ECCOUNT,"S"))
 . S ^TMP("ECXLBBC",$J,$S($G(ECXCFLG)=1:ECARRY(4),1:"ZZNOZZ"),ECXDFN,ECTRFDT_"."_ECTRFTM_"."_ECCOUNT,"S")=ECXSTR
 ;  used in ECXPLBB/ECXLBBC (pre-extract audit report)
 Q
GETDFN(ECXLRDFN) ;
 ; INPUT - LRDFN
 ; OUTPUT - DFN
 ; Obtains DFN (Patient ID) from LRDFN (Lab Patient ID).
 ; If no valid DFN exists, 0 is returned.
 S ECXLRDFN=+$G(ECXLRDFN)
 I $P($G(^LR(ECXLRDFN,0)),"^",2)'=2 Q 0
 Q +$P(^LR(ECXLRDFN,0),"^",3)
 ; 
PAT(ECXDFN) ;get/set patient data
 ; INPUT - ECXDFN = patient ien (DFN)
 ; OUTPUT - ECPAT array:
 ;          ECPAT("SSN")
 ;          ECPAT("NAME")
 ; returns 0 or 1 in ECXERR - 0=successful
 ;                            1=error condition
 N X,OK,ECXERR
 ;get data
 S ECXERR=0
 K ECXPAT S OK=$$PAT^ECXUTL3(ECXDFN,"","1;3",.ECPAT)
 I 'OK S ECXERR=1
 Q ECXERR
 ;
FILE(ECODE) ;
 ; Input - ECODE = extract record
 ;
 ; record the extract record at a global node in file 727.829
 ; sequence #^year/month of extract^extract #^facility^patient dfn^SSN^
 ; name^i/o pt indicator^encounter #^date of transfusion^time of 
 ; transfusion^component^component abbrev^# of units^volume in mm^
 ; reaction^reaction type^feeder location^DSS product dept^DSS IP #
 ; ordering physician^ordering physician pc^emergency response indicator
 ; (FEMA)^unit modified^unit modification^requesting provider^request. 
 ; provider person class^ordering provider npi ECPHYNPI
 ;ECODE1- requesting provider npi ECREQNPI^PATCAT
 ;note:  DSS product dept and DSS IP # are dependent on the release of
 ; ECX*3*61
 N DA,DIK,EC7
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE=EC7_"^"_ECODE
 I ECXLOGIC>2007 D
 .S ECODE=ECODE_ECPHYNPI_U
 .S ECODE1=$G(ECREQNPI)_U
 .I ECXLOGIC>2010 S ECODE1=ECODE1_ECXPATCAT
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=$G(ECODE1),ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 Q
 ;
 ;
SETUP ;Set required input for ECXTRAC.
 S ECHEAD="LBB"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
 ;
LOCAL ; to extract nightly for local use not to be transmitted to TSI
 ; should be queued with a 1D frequency
 D SETUP,^ECXTLOCL,^ECXKILL Q
 ;
QUE ; entry point for the background requeuing handled by ECXTAUTO
 D SETUP,QUE^ECXTAUTO,^ECXKILL
 Q
 ;
 ;ECXLBB
