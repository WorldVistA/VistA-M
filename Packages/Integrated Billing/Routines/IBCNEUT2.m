IBCNEUT2 ;DAOU/DAC - eIV MISC. UTILITIES ;06-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,416,435,713,737,806,822**;21-MAR-94;Build 21
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^XLFDT  in ICR #10103
 ;
 ; Can't be called from the top
 Q
 ;
SAVETQ(IEN,TDT) ;  Update service date in TQ record
 ;
 N DIE,DA,DR,D,D0,DI,DIC,DQ,X
 S DIE="^IBCN(365.1,",DA=IEN,DR=".12////"_TDT
 D ^DIE
 Q
 ;
 ;
SST(IEN,STAT) ;  Set the Transmission Queue Status
 ;  Input parameters
 ;    IEN = Internal entry number for the record
 ;    STAT= Status IEN
 ;
 NEW DIE,DA,DR,D,D0,DI,DIC,DQ,X
 ;
 I IEN="" Q
 ;
 S DIE="^IBCN(365.1,",DA=IEN,DR=".04////^S X=STAT;.15////^S X=$$NOW^XLFDT()"
 D ^DIE
 Q
 ;
RSP(IEN,STAT) ;  Set the Response File Status
 ;  Input parameters
 ;    IEN = Internal entry number for the record
 ;    STAT= Status IEN
 ;
 NEW DIE,DA,DR,D,D0,DI,DIC,DQ,X
 S DIE="^IBCN(365,",DA=IEN,DR=".06////^S X=STAT"
 D ^DIE
 Q
 ;
BUFF(BUFF,BNG) ;  Set error symbol into Buffer File
 ;  Input Parameter
 ;    BUFF = Buffer internal entry number
 ;    BNG = Buffer Symbol IEN
 I 'BUFF!'BNG Q
 ;IB*822/CKB - no longer valid -I +$P($G(^IBA(355.33,BUFF,0)),U,17) Q    ; .12 field not for ePharmacy IB*2*435
 NEW DIE,DA,DR,D,D0,DI,DIC,DQ,X,DISYS
 S DIE="^IBA(355.33,",DA=BUFF,DR=".12////^S X=BNG"
 D ^DIE
 Q
 ;
BADMSG(EXT,QUERY) ; Checks to see if the msg is allowed
 ; IB*713 Introduced this tag, checks for foreign characters as defined
 ;        in FOREIGN^IBCNINSU. If foreign characters are encountered, some 
 ;        times the msg can't be created/sent via HL7. Other times, if you
 ;        clear out the field with the foreign character you can still send
 ;        the message.  (Watch for the STOP variable.)
 ;        This could be expanded in the future to check other scenarios that
 ;        should stop the transmissions.
 ;
 ;INPUT:
 ;  EXT = WHICH EXTRACT (#365.1,.1)
 ;  QUERY = QUERY FLAG(#365.1,.11)
 ;  PID, IN1, HLFS, HLECH - existing global variables
 ;  GT1 global variable that may or may not exist
 ;
 ;OUTPUT: 0 - Continue with creating and sending HL7 msg
 ;        1 - Do not send this TQ entry out as a HL7 msg
 ;            * NOTE: If Abort, this function sets the
 ;              TRANSMISSION QUEUE (#365.1,.04) to "Cancelled"
 ;
 N FLD,HCT,SEG,STOP,TMP
 S HCT="",STOP=0
 F  S HCT=$O(^TMP("HLS",$J,HCT)) Q:'HCT  S SEG=$P(^(HCT),HLFS,1),TMP(SEG)=HCT
 ;
 ; Regular 270 Messages
 I (EXT=1)!(EXT=2)!(EXT=5)!(EXT=6) D  G BADMSGX
 . I $$FOREIGN^IBCNINSU($P(PID,HLFS,6),"1;2;3;4;5;6") S STOP=1 Q   ;PID-5 PATIENT NAME
 . I $$FOREIGN^IBCNINSU($P(IN1,HLFS,3)) S STOP=1 Q                 ;IN1-2 PATIENT/SUBSCRIBER ID
 . I $D(GT1) D  I STOP Q
 .. I $$FOREIGN^IBCNINSU($P(GT1,HLFS,3)) S STOP=1 Q                ;GT1-2 SUBSCRIBER ID
 .. I $$FOREIGN^IBCNINSU($P(GT1,HLFS,4),"1;2;3;4;5;6") S STOP=1 Q  ;GT1-3 SUBSCRIBER NAME
 . ;
 . ;If foreign chars encountered clear field and continue with msg
 . ;
 . ; PID-11 Addr (street,ignore,city,state,zip)
 . S FLD=$P(PID,HLFS,12) I $$FOREIGN^IBCNINSU(.FLD,"1;3;4;5",1) S $P(PID,HLFS,12)=FLD ;PID-11
 . S FLD=$P(IN1,HLFS,9) I $$FOREIGN^IBCNINSU(.FLD,1,1) S $P(IN1,HLFS,9)=FLD ;IN1-8 GROUP NUMBER
 . S FLD=$P(IN1,HLFS,10) I $$FOREIGN^IBCNINSU(.FLD,1,1) S $P(IN1,HLFS,10)=FLD ;IN1-9 GROUP NAME
 . ;
 . I $D(GT1) D
 .. ; GT1-6 Addr (street,ignore,city,state,zip)
 .. S FLD=$P(GT1,HLFS,7) I $$FOREIGN^IBCNINSU(.FLD,"1;3;4;5",1) S $P(GT1,HLFS,7)=FLD ;GT1-6
 ;
 ; EICD-Identifications (aka A1 msgs)
 ; [Asking clearinghouse if they know insurance for this patient]
 I (EXT=4),(QUERY="I") D  G BADMSGX
 . I $$FOREIGN^IBCNINSU($P(PID,HLFS,6),"1;2;3;4;5;6") S STOP=1 Q  ;PID-5 PATIENT NAME
 . ; PID-11 Addr (ignore,ignore,city,state,zip)
 . I $$FOREIGN^IBCNINSU($P(PID,HLFS,12),"3;4;5") S STOP=1 Q       ;PID-11
 . ;
 . ;If foreign chars encountered clear field and continue with msg
 . ;
 . S FLD=$P(PID,HLFS,12) I $$FOREIGN^IBCNINSU(.FLD,1,1) S $P(PID,HLFS,12)=FLD ;PID-11-1 ADDR STREET
 ;
 ; EICD-Verification (aka A2 msgs)
 ; [Confirming policies clearinghouse found for VA]
 I (EXT=4),(QUERY="V") D  G BADMSGX
 . I $$FOREIGN^IBCNINSU($P(PID,HLFS,6),"1;2;3;4;5;6") S STOP=1 Q  ;PID-5 PATIENT NAME
 . I $$FOREIGN^IBCNINSU($P(IN1,HLFS,3)) S STOP=1 Q                ;IN1-2 PATIENT/SUBSCRIBER ID
 . I $D(GT1) D  I STOP Q
 .. I $$FOREIGN^IBCNINSU($P(GT1,HLFS,3)) S STOP=1 Q                ;GT1-2 SUBSCRIBER ID
 .. I $$FOREIGN^IBCNINSU($P(GT1,HLFS,4),"1;2;3;4;5;6") S STOP=1 Q  ;GT1-3 SUBSCRIBER NAME
 . ;
 . ;If foreign chars encountered clear field and continue with msg
 . ;
 . ; PID-11 Addr (street,ignore,city,state,zip)
 . S FLD=$P(PID,HLFS,12) I $$FOREIGN^IBCNINSU(.FLD,"1;3;4;5",1) S $P(PID,HLFS,12)=FLD ;PID-11
 . S FLD=$P(IN1,HLFS,9) I $$FOREIGN^IBCNINSU(.FLD,1,1) S $P(IN1,HLFS,9)=FLD ;IN1-8 GROUP NUMBER
 . S FLD=$P(IN1,HLFS,10) I $$FOREIGN^IBCNINSU(.FLD,1,1) S $P(IN1,HLFS,10)=FLD ;IN1-9 GROUP NAME
 . I $D(GT1) D
 .. ; GT1-6 Addr (street,ignore,city,state,zip)
 .. S FLD=$P(GT1,HLFS,7) I $$FOREIGN^IBCNINSU(.FLD,"1;3;4;5",1) S $P(GT1,HLFS,7)=FLD ;GT1-6
 ;
 ; MBI REQUEST
 I EXT=7 D  G BADMSGX
 . I $$FOREIGN^IBCNINSU($P(PID,HLFS,6),"1;2;3;4;5;6") S STOP=1 Q  ;PID-5 SUBSCRIBER NAME
 . ;
 . ;If foreign chars encountered clear field and continue with msg
 . ;
 . ; PID-11 Addr (street,ignore,city,state,zip)
 . S FLD=$P(PID,HLFS,12) I $$FOREIGN^IBCNINSU(.FLD,"1;3;4;5",1) S $P(PID,HLFS,12)=FLD   ;PID-11
 ;
BADMSGX ;Exit BADMSG
 I 'STOP D
 . S HCT=$G(TMP("PID")) I HCT S ^TMP("HLS",$J,HCT)=PID
 . S HCT=$G(TMP("IN1")) I HCT S ^TMP("HLS",$J,HCT)=IN1
 . S HCT=$G(TMP("GT1")) I HCT S ^TMP("HLS",$J,HCT)=GT1
 Q STOP
 ;
EBSUMMARY(DFN,RIEN,SOI,ARRAY) ; Added IB*806
 ;
 ; ***********************
 ; DO NOT change this code without careful consideration !!!
 ; It is called by IBCNEHL5A to Auto-load policies as eIV Responses are processed
 ; Also, it is called by IBCNES for the ELIG. Benefits (from both file #2 and #365 perspectives)
 ; ***********************
 ;
 ; Example:
 ; Insurance Type: Medicare Part A Elig/Ben Info: Active Coverage
 ; Date/Time Qual: Plan D/T Period: 05/01/2019 
 ;
 ; Returns ARRAY(EBCNT,"Medicare Part A")=DFN^"Medicare Part A"^3190501^SOI^"Active Coverage"
 ; - if Other Potential Insurance - ARRAY("OHI)=1
 ; - if the Effective Date for an Active policy is missing - ARRAY("MISSING_EFFDT")=1
 ;
 ; How to determine effective date:
 ;   1st attempt to pull from EB loop 
 ;      Loop must have:(INSTYP'="") & ELGBENINFO="Active Coverage" or "Inactive"
 ;        If Medicare pull the 1st date where qualifier = "PLAN"
 ;        If not Medicare pull 1st date where qualifier ="PLAN" or "PLAN BEGIN"
 ;           check all dates as "PLAN BEGIN" trumps "PLAN"
 ;   if no eff dt then continue other attempts
 ;      2nd attempt - If not Medicare pull from Subscriber dates (#365.28,.02)
 ;         pull 1st date where qualifier ="PLAN" or "PLAN BEGIN"
 ;           check all dates as "PLAN BEGIN" trumps "PLAN"
 ;   if no eff dt then continue other attempts
 ;      LAST attempt - pull from Effective date (#365,1.11)
 ;        applies to both Medicare and non Medicare
 ;   Otherwise effective date is "Unknown"
 ;
 ;
 N DTQUAL,EBCNT,ELGBENINFO,EXTELIG,FSCSTAT,HLDT,HLDNDT
 N IBA,IBBERR,IBCHK,IBEFFDT,IBEINFO,IBELGINF,IBNOTCOV,IBNOTDT,IBNOTTYP,IBPEDT,IBSPDT,IBSUSCT
 N IBVIENS,INSTYP,MWNRTYP,TMP,XXDT,ZIEN
 K ARRAY,^TMP("EBSUMEUT2",$J)
 ;
 I '$D(^IBCN(365,RIEN,2)) G XEBSUM  ; NO Benefits received
 ;
 S (IBSPDT,IBSUSCT,IBPEDT,IBELGINF)=""
 ; determine the default date if the HLDT is not there
 ;use the subscriber date plan date if it is a plan, or the Effective date, Unknown if still not found
 ;  this is to calculate the default eff date if it can't be determined by the EB loops from the response
 K IBCHK,IBBERR D GETS^DIQ(365,RIEN_",","7*","IEN","IBCHK","IBBERR")
 I $D(IBCHK(365.07)) D  ; loop through for Subscribers collect the 'plan' and 'plan begin' dates
 . N DQUAL,DTYP,IBA,IBB,IBL,IBOK,IBP,IBPB,IBTDT,IBTDT1
 . K IBP,IBPB
 . S IBB="",(IBOK,IBP,IBPB)=0
 . F  S IBB=$O(IBCHK(365.07,IBB)) Q:IBB=""  D  Q:IBOK
 . . S DTYP=$G(IBCHK(365.07,IBB,.04,"E")) Q:DTYP'["C"  ; C is for Subscriber
 . . S DQUAL=$G(IBCHK(365.07,IBB,.03,"I")) Q:'DQUAL  S IBA=$$X12^IBCNERP2(365.026,DQUAL)
 . . I IBA'="Plan"&(IBA'="Plan Begin") Q  ; Must be Plan or Plan Begin
 . . S IBTDT=$G(IBCHK(365.07,IBB,.02,"I")),IBTDT=$P(IBTDT,"-",1),IBTDT=$TR(IBTDT," ","")
 . . I IBTDT="" Q  ; must have a date
 . . S IBTDT1=$$HL7TFM^XLFDT(IBTDT)
 . . I IBTDT1=""!(IBTDT1="-1") Q  ;must be valid date
 . . I IBA="Plan" I IBSPDT="" S IBSPDT=IBTDT1
 . . I IBA="Plan Begin" S IBSPDT=IBTDT1,IBOK=1
 ;
 I IBSPDT="" S IBSPDT=$$GET1^DIQ(365,RIEN,"1.11","I")  ; get Effective dt from top display as 2nd default (from IN1 segment)
 I IBSPDT="" S IBSPDT="Unknown"  ;  eff dt default to use for non medicare policies if not found in EB loops
 ;
 S IBEFFDT="",IBEFFDT=$$GET1^DIQ(365,RIEN,"1.11","I") S:'IBEFFDT IBEFFDT="Unknown"
 ;
 S MWNRTYP=$$ISMCARE(RIEN) ; is the payer medicare
 ;
 S EBCNT=0 F  S EBCNT=$O(^IBCN(365,RIEN,2,EBCNT)) Q:'EBCNT  D
 . S IBVIENS=EBCNT_","_RIEN_","
 . K EB,ERROR
 . D GETS^DIQ(365.02,IBVIENS,".02;.03;.04;.05;.06;8*","IEN","EB","EBERR")
 . ;
 . I (EBCNT=1),($G(EB(365.02,IBVIENS,.06,"E"))="eIV Eligibility Determination") D  Q  ; use EB loop 1 only to pull FSC's determination and nothing else
 . . S FSCSTAT=$G(EB(365.02,IBVIENS,.02,"E"))
 . . S FSCSTAT=$S((FSCSTAT'=1&(FSCSTAT'=6)):"Unknown",1:FSCSTAT) ; this is what FSC said (Active, Inactive, Ambiguous)
 . . S IBELGINF=$S(FSCSTAT=1:"ACTIVE Coverage",FSCSTAT=6:"INACTIVE Coverage",1:"Unknown")
 . ;
 . S INSTYP=$P($G(^IBE(365.014,+$G(EB(365.02,IBVIENS,.05,"I")),0)),U,2)
 . ;
 . ; X12 271 ELIGIBILITY/BENEFIT file #365.011 - this tag only uses the following codes below:
 . ; 1="Active coverage"
 . ; 2="Active - Full Risk Capitation"
 . ; 3="Active - Services Capitated"
 . ; 4="Active - Services Capitated to Primary Care Physician"
 . ; 6="Inactive"
 . ; R="Other or Additional Payor"
 . ; U="Contract Following Entity for Eligibility or Benefit Information"
 . S EXTELIG=$G(EB(365.02,IBVIENS,.02,"E"))
 . ;
 . ; Indicates potential Other Health Insurance (OHI) do OHI checks before quits
 . I (EXTELIG=2)!(EXTELIG=3)!(EXTELIG=4)!(EXTELIG="R")!(EXTELIG="U") S ARRAY("OHI")=1
 . ;
 . I INSTYP="" Q  ; moved quit to after the OHI check
 . ;
 . I (EXTELIG'=1)&(EXTELIG'=6)&(EXTELIG'=2)&(EXTELIG'=3)&(EXTELIG'=4)&(EXTELIG'="R")&(EXTELIG'="U") Q
 . ;
 . S ELGBENINFO=$P($G(^IBE(365.011,+$G(EB(365.02,IBVIENS,.02,"I")),0)),U,2)
 . I ELGBENINFO'="Active Coverage"&(ELGBENINFO'="Inactive") Q
 . ;
 . S HLDT=""
 . S ZIEN="0,"_IBVIENS,IBOK=0
 . F  S ZIEN=$O(EB(365.28,ZIEN)) Q:ZIEN=""  D  Q:IBOK=1 
 . . S DTQUAL=$P($G(^IBE(365.026,+$G(EB(365.28,ZIEN,.03,"I")),0)),U,2)
 . . I (MWNRTYP),(DTQUAL'="Plan") Q  ; Medicare policies are only looking for "Plan"
 . . I ('MWNRTYP),((DTQUAL'="Plan")&(DTQUAL'="Plan Begin")) Q  ; Non Medicare policies look for "Plan" & "Plan Begin"
 . . S XXDT=$$HL7TFM^XLFDT($G(EB(365.28,ZIEN,.02,"E")))
 . . I MWNRTYP S HLDT=XXDT,IBOK=1 Q  ;Medicare will not have multiple plan dates in same EB loop
 . . I DTQUAL="Plan" I HLDT="" S HLDT=XXDT
 . . I DTQUAL="Plan Begin" S HLDT=XXDT,IBOK=1
 . ;
 . I HLDT="",ELGBENINFO'="Inactive" S ARRAY("MISSING_EFFDT")=1
 . ;
 . I HLDT=""&('MWNRTYP) D  ; Non Medicare and no eff dt found in EB loop use default from above
 . . S HLDT=IBSPDT
 . ;  
 . S HLDNDT=$S('HLDT:IBEFFDT,1:HLDT)
 . ;
 . ;  TMP array used to avoid repeating duplicate data in summary section (payers repeat themselves)
 . I $D(^TMP("EBSUMEUT2",$J,$S(INSTYP="":" ",1:INSTYP),$S(ELGBENINFO="":" ",1:ELGBENINFO),HLDNDT)) Q
 . ;
 . S ARRAY(EBCNT,INSTYP)=DFN_U_INSTYP_U_HLDT_U_SOI_U_ELGBENINFO
 . ;
 . S ^TMP("EBSUMEUT2",$J,$S(INSTYP="":" ",1:INSTYP),$S(ELGBENINFO="":" ",1:ELGBENINFO),HLDNDT)=""
 ;
 ;
 I '$O(ARRAY(0)) D  ; if no ins type is found 
 . I 'MWNRTYP S ARRAY(1,"Unknown")=$G(DFN)_U_"Unknown"_U_$G(IBSPDT)_U_$G(SOI)_U_$G(IBELGINF) Q
 . ; Medicare only
 . S ARRAY(1,"Unknown")=$G(DFN)_U_"Unknown"_U_"Unknown"_U_$G(SOI)_U_$G(IBELGINF)
 ;
XEBSUM ;
 ;
 K ^TMP("EBSUMEUT2",$J)
 Q
 ;
ISMCARE(RIEN) ;check if response is from eIV Medicare Payer defined in file 350.9
 ; new tag with IB*806
 N IB3650,IBPIEN,MWNRIEN,MWNRTYPA
 S IB3650=$G(^IBCN(365,RIEN,0)),IBPIEN=$P(IB3650,U,3)
 S MWNRIEN=$P($G(^IBE(350.9,1,51)),U,25),MWNRTYPA=0
 I IBPIEN=MWNRIEN S MWNRTYPA=1
 Q MWNRTYPA
 ;
