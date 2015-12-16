ECXLBB1 ;ALB/JRC - DSS VBECS EXTRACT ;4/16/13  16:06
 ;;3.0;DSS EXTRACTS;**105,102,120,127,144,156**;Dec 22, 1997;Build 8
 ;Per VA Directive 6402, this routine should not be modified.  Medical Device # BK970021
 ; access to the VBECS EXTRACT file (#6002.03) is supported by
 ; controlled subscription to IA #4953  (global root ^VBECS(6002.03)
BEG ;entry point from option
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ; Entry point from tasked job
 ; begin package specific extract
 N ECTRSP,ECADMT,ECTODT,ECENCTR,ECPAT,ECLRDFN,ECXPHY,ECXPHYPC
 N ECD,ECXDFN,ECARRY,EC66,ECERR,ECTRFDT,ECTRFTM,ECX,ECINOUT,ECXINST
 N ECPHYNPI,ECREQNPI,ECXPATCAT,ECXESC ;144
 ;variables ECFILE,EC23,ECXYM,ECINST,ECSD,ECSD1,ECED passed in 
 ; by taskmanager 
 ; ECED defined in ^ECXTRAC - end date of the extract
 ; TRANSFUSION DATE should be within start and end dates
 ; ECED and ECSD input provided by the user interface
 ; and ECSD1 = ECSD-.1
 ; Read through the VBECS DSS EXTRACT file (6002.03)
 I $D(ZTQUEUED),$$S^%ZTLOAD S QFLG=1 Q  ;quit if tasked and user sends stop request  (QFLG assigned in ECXTRAC)
 ;
AUDRPT ; entry point for pre-extract audit report
 N RECORD
 S RECORD=0,ECD=ECSD-.1,ECTODT=ECED+.9
 F  S ECD=$O(^VBEC(6002.03,"C",ECD)) Q:'ECD!(ECD>ECTODT)  S RECORD=0 F  S RECORD=$O(^VBEC(6002.03,"C",ECD,RECORD)) Q:RECORD'>0  S EC0=^VBEC(6002.03,RECORD,0) D
 .; ECARRY(1)=TRANSFUSION DATE AND TIME, ECARRY(3)=COMPONENT 
 .; ECARRY(4)=COMPONENT ABBREVIATION, ECARRY(5)=UNITS POOLED
 .; ECARRY(6)=TRANSFUSION REACTION,ECARRY(7)=VOLUME TRANSFUSED
 .; ECARRY(8)=TRANSFUSION REACTION TYPE, ECARRY(9)=REQUESTING PROVIDER
 .; ECARRY(10)=REQUEST. PROV. PERSON CLASS, ECARRY(11)=UNIT MODIFIED
 .; ECARRY(12)=UNIT MODIFICATION, ECARRY(13)=PRODUCTION DIVISION CODE
 .;
 . S ECXDFN=$P(EC0,U,2),ECERR=$$PAT(ECXDFN) Q:ECERR
 . S ECARRY(1)=$P(EC0,U,10),ECARRY(3)=$P(EC0,U,7),ECARRY(4)=$P(EC0,U,8),ECARRY(5)=$S(+$P(EC0,U,9)=0:1,1:+$P(EC0,U,9)),ECARRY(6)=$S($P(EC0,U,15):"Y",1:"N"),ECARRY(7)=$P(EC0,"^",12),ECARRY(8)=$P(EC0,U,13)
 . S ECARRY(9)=$P(EC0,U,6),ECINST=$P(EC0,U,3),ECARRY(12)=$P(EC0,U,14),ECARRY(11)=$S(ECARRY(12)'="":"Y",1:"N"),ECARRY(13)=$P(EC0,U,4)
 . ;get requesting and ordering providers and their person class
 . S ECXPHY=$P(EC0,U,5),(ECXPHYPC,ECARRY(10),ECPHYNPI,ECREQNPI)=""
 . I ECXPHY]"" S ECXPHY=$O(^VA(200,"B",ECXPHY,0))
 . I ECXPHY>0 D
 .. N PERCLS S PERCLS=$$GET^XUA4A72(ECXPHY,ECD)
 .. I +PERCLS>0 S ECXPHYPC=$P(PERCLS,U,7)
 .. S ECPHYNPI=$$NPI^XUSNPI("Individual_ID",ECXPHY,ECD)
 .. S:+ECPHYNPI'>0 ECPHYNPI="" S ECPHYNPI=$P(ECPHYNPI,U)
 .. S ECXPHY=2_ECXPHY
 . I ECARRY(9)>0 D
 .. N PERCLS S PERCLS=$$GET^XUA4A72(ECARRY(9),ECD)
 .. I +PERCLS>0 S ECARRY(10)=$P(PERCLS,U,7)
 .. S ECREQNPI=$$NPI^XUSNPI("Individual_ID",ECARRY(9),ECD)
 .. S:+ECREQNPI'>0 ECREQNPI="" S ECREQNPI=$P(ECREQNPI,U)
 .. S ECARRY(9)=2_ECARRY(9)
 . D GETDATA
 . K ECARRY
 Q
 ;
GETDATA ; gather rest of extract data that will be recorded in an 
 ; entry in file 727.829
 N ECXSTR
 S ECTRFDT=$$ECXDOB^ECXUTL(ECARRY(1)),ECTRFTM=$$ECXTIME^ECXUTL(ECARRY(1))
 S ECX=$$INP^ECXUTL2(ECXDFN,ECARRY(1)),ECINOUT=$P(ECX,U),ECTRSP=$P(ECX,U,3),ECADMT=$P(ECX,U,4)
 ;
 ;- Observation patient indicator (YES/NO)
 S ECXOBS=$$OBSPAT^ECXUTL4(ECINOUT,ECTRSP)
 ;- If no encounter number don't file record
 S ECENCTR=$$ENCNUM^ECXUTL4(ECINOUT,ECPAT("SSN"),ECADMT,ECARRY(1),ECTRSP,ECXOBS,ECHEAD,,) ; [FLD #6]
 Q:ECENCTR=""
 ;get emergency response indicator (FEMA)
 S ECXERI=$G(ECPAT("ERI"))
 ;
 ; ******* - PATCH 127, ADD PATCAT CODE ********
 S ECXPATCAT=$$PATCAT^ECXUTL(ECXDFN)
 S ECXESC="" ;144
 S ECXSTR=$G(EC23)_"^"_ECINST_"^"_ECXDFN_"^"_ECPAT("SSN")_"^"_ECPAT("NAME")_"^"_ECINOUT_"^"_ECENCTR_"^"_ECTRFDT_"^"_ECTRFTM_"^"_ECARRY(3)_"^"_ECARRY(4)_"^"_ECARRY(5)_"^"_ECARRY(7)_"^"_ECARRY(6)_"^"_ECARRY(8)_"^BB"_ECARRY(13)_"^^"
 I $G(ECXLOGIC)>2005 S ECXSTR=ECXSTR_U_ECXPHY_U_ECXPHYPC
 I $G(ECXLOGIC)>2006 D
 .S ECXSTR=ECXSTR_U_ECXERI_U_ECARRY(11)_U_ECARRY(12)_U_ECARRY(9)_U_ECARRY(10)_U_ECARRY(13)_U
 I '$D(ECXRPT) D FILE(ECXSTR) Q
 S ^TMP("ECXLBB",$J,ECXDFN,ECD,RECORD)=ECXSTR  ;temporary global array,156-added additional subscript
 I $D(ECXCRPT) D
 . N ECCOUNT S ECCOUNT=0
 . F  S ECCOUNT=ECCOUNT+1 Q:'$D(^TMP("ECXLBBC",$J,$S($G(ECXCFLG)=1:ECARRY(4),1:"ZZNOZZ"),ECXDFN,ECTRFDT_"."_ECTRFTM_"."_ECCOUNT,"S"))
 . S ^TMP("ECXLBBC",$J,$S($G(ECXCFLG)=1:ECARRY(4),1:"ZZNOZZ"),ECXDFN,ECTRFDT_"."_ECTRFTM_"."_ECCOUNT,"S")=ECXSTR
 ;   used in ECXPLBB/ECXLBBC (pre-extract audit report)
 Q
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
 ;ECODE1- requesting provider npi ECREQNPI^PATCAT^Encounter SC ECXESC
 ;note:  DSS product dept and DSS IP # are dependent on the release of
 ; ECX*3*61
 N DA,DIK,EC7
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE=EC7_"^"_ECODE
 I ECXLOGIC>2007 D
 .S ECODE=ECODE_ECPHYNPI_U
 .S ECODE1=$G(ECREQNPI)
 .I ECXLOGIC>2010 S ECODE1=ECODE1_U_ECXPATCAT
 I ECXLOGIC>2013 S ECODE1=ECODE1_U_ECXESC ;144
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=$G(ECODE1),ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 Q
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
CHKMOD(MD) ;check if modifier is contained in string
 N RES,MODX
 I MD="" Q ""
 S (RES,MODX)="" F  S MODX=$O(MODARY(MODX)) Q:MODX=""  D  I RES'="" Q
 .I MD[MODX S RES=MODARY(MODX)
 Q RES
 ;
QUE ; entry point for the background requeuing handled by ECXTAUTO
 D SETUP,QUE^ECXTAUTO,^ECXKILL
 Q
 ;
 ;ECXLBB
