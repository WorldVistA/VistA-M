IBCE837ACCU ;EDE/JWS - ACC consume X12 claim data ;
 ;;2.0;INTEGRATED BILLING;**770**;23-MAY-18;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to $$OUTPTPR^SDUTL3(dfn) in ICR #1252
 ; Reference to $$QI^XUSNPI in ICR #4532
 ; Reference to $$CODEN^ICDEX in ICR #5747
 Q
 ;
D(XD) ;file diagnosis codes
 N X1,X1D,XORD,Y
 S XORD=$O(^IBA(362.3,"AO",IBIFN,"A"),-1)
 ;JWS;9/29/25;changed "AB" index reference to $$CODEN^ICDEX(code,80)
 F I=2:1 S X1=$P($P(XD,"*",I),":",2) Q:X1=""  S X1=$E(X1,1,3)_"."_$E(X1,4,99),X1D=$P($$CODEN^ICDEX(X1,80),"~") I +X1D>0 D
 . K DO,DD,DLAYGO,DA,DIC,DIE,DR
 . S XORD=XORD+1,DIC("DR")=".02////"_IBIFN_";.03////"_XORD,DIC="^IBA(362.3,",DIC(0)="Z",X=+X1D,DLAYGO=362.3 K DD,DO D FILE^DICN
 . S IBDIG(XORD)=$P(Y,"^")
 . K DIE,DIC,DA,DLAYGO,DO,DD
 Q
 ;
VAL(IBX12) ;function to call to re-try validation/auto-bill creation / auto-transmit
 ; IBX12 - ien to file 364.9
 I +IBX12=0 Q 0
 N IBDOB,DOB,IBSEG,IBSEGN,IBIO,LOOP,IBSITE,IBI,ARG,X,XX,Y,I,IBIFN,SEG,SEG2,OK,IBDOS,IBLDOS,IBSLINE,IBER,B,D,DFN,DI,DIC,DICR,DIK,IBAT,IBAU,IBBNO,IBCL
 N IBPATFN,IBPATLN,IBPATMN,IBPATSSN,IBPN,IBPN1,IBREFD9,IBXARRY,IBXARRAY,IBXERR,IBERRMSG,IBEU,IBEVDT,IBFDT,IBLOC,IBM,IBMOD,IBMRAF,IBND0,IBNDM
 N IBCPT,IBCPTS,IBFT,IBPNPI,IBPT,IBSPID,IBNOTE,IBPN2
 N D0,D1,DG,DGRVRCAL,DIV,RDATES,VA,VADM,IBX,IBBAD
 N IBDUP,IBND,IBPATIEN,IBPDX,IBTNUM,IBPAYERID,IBPATICN,IBAUTH,IBREF
 K ^TMP("IB837ACC",$J) ; use this global to save claim info that will be used to create the K# in file 399
 ;JWS;IB*2.0*770v8;make sure RPC entry flag is cleared when performing val
 K IBACCRPC1
 ;JWS;6/12/25;skip if purged
 I $P($G(^IBA(364.9,IBX12,0)),"^",16)=3 Q 0
 I $G(IBND)="" D NOW^%DTC S Y=% D DD^%DT S IBND=%
 I $P($G(^IBA(364.9,+IBX12,2)),"^",2)'="" D  Q 0  ;can't auto create bill more than once
 . ;12/9/24;EBILL-3551;JWS;report Failure Reason when attempting to re-gen/process an encounter that already has a K# assigned
 . D UP^IBCE837ACC(IBX12,106,5,"USE ENTER/EDIT BILL")
 . D USERUP^IBCE837ACC(IBX12)
 . Q
 S X=0
 F I=1:1 S X=$O(^IBA(364.9,IBX12,1,X)) Q:X'=+X  S ARG("SEG"_I)=^(X,0)
 S IBSITE(1)=$P($G(^IBA(364.9,IBX12,0)),"^",24) I IBSITE(1)="" S IBSITE(1)=$P(^IBA(364.9,IBX12,0),"^",20) I IBSITE(1)="" S IBSITE(1)=$P($$SITE^VASITE,"^",3)   ;ICR #10112 (Supported)
 S IBSITE=$$DIV^IBCE837ACC(IBSITE(1))
 S IBX=0 F  S IBX=$O(^IBA(364.9,IBX12,5,IBX)) Q:IBX'=+IBX  S DA(1)=IBX12,DIK="^IBA(364.9,"_DA(1)_",5,",DA=IBX D ^DIK
 S IBSEG="",IBIO="O",LOOP=1,IBBAD=1
 F IBI=1:1 S IBSEG="SEG"_IBI Q:'$D(ARG(IBSEG))  D
 . ;JWS;EBILL-6035;IB*2.0*770v46;semi-colon issue in billing provider name, change to space ' ' 
 . S ARG(IBSEG)=$TR(ARG(IBSEG),">;",": ") ; colon (:) is a reserved character in JSON, so data is coming over with > delimiter for sub-fields
 . S SEG=$P(ARG(IBSEG),"*",1,3),SEG2=$P(SEG,"*",2)
 . ; skip ST (transaction set header)
 . I $E(SEG,1,3)="ST*" S IBBAD=0 Q  ;trans set header
 . I $E(SEG,1,4)="BHT*" Q
 . I $E(SEG,1,3)="SE*" Q  ;trans set trailer
 . ; skip BHT (beginning of hierarchical transaction)
 . I $E(SEG,1,3)="HL*" D  Q
 .. S LOOP=$P(ARG(IBSEG),"*",4)  ;20=information source, 22=subscriber , 23=patient/dependent
 .. I LOOP=23 S LOOP="23^IBCE837ACCU1" Q
 .. Q
 . ;JWS;12/4/24;IB*2.0*770v15;EBILL-4618;adding line payment amounts to encounter
 . I $E(SEG,1,3)="LX*" D  Q
 .. S IBSLINE=$P(ARG(IBSEG),"*",2),LOOP="24^IBCE837ACCU2"
 .. S X=$$GET1^DIQ(364.96,IBSLINE_","_IBX12_",",.02) I X="" Q
 .. S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",6)=X
 . I $E(SEG,1,4)="CAS*" Q  ;skip all adjustment segments
 . I $E(SEG,1,4)="AMT*" Q  ;skip all payor paid amt segments
 . I $E(SEG,1,3)="OI*" Q  ;other insurance info
 . I $E(SEG,1,4)="MOA*" Q  ;adj info
 . I $E(SEG,1,4)="MIA*" Q  ;inpatient adjudication info
 . I $E(SEG,1,7)="NM1*41*" Q  ;submitter
 . I $E(SEG,1,7)="PER*IC*" Q  ;contact info - skip all,$G(LOOP)=1 Q
 . I $E(SEG,1,7)="NM1*40*" Q  ;skip receiver segments
 . I +$G(LOOP)>1 S:$E(SEG,1,4)="CLM*" LOOP="23^IBCE837ACCU1" D @LOOP Q
 . Q
 I $G(IBBAD)=1 Q 0
 ;do service facility and rendering provider check
 ;; 10/29/24 JWS duplicate/not needed here ;D SFRP^IBCE837ACCU2
 G ALL^IBCE837ACC
 ; above is attempt to share code
 ;
20 ;LOOP 20
 I $E(SEG,1,4)="NM1*" D  Q
 . I SEG2=85 D  Q  ;billing provider name,address info
 .. D NEXT
 .. S IBPN1=$P(ARG(IBSEG),"*",4) I IBPN1="" Q  ;other payer service facility
 .. S OK=$$CHK35593($P(ARG(IBSEG),"*",10),85)
 .. D SET^IBCE837ACC1($P(ARG(IBSEG),"*",10),1.1,85),SET^IBCE837ACC1(IBPN1,1.2,85),SET^IBCE837ACC1($S(OK=1:355.93,1:200),1.3,85)
 .. Q
 . I SEG2=87 D NEXT Q  ;pay-to provider, address info
 . I SEG2="PE" D NEXT Q  ;pay-to plan name
 Q
 ;
22 ;LOOP 22
 ;I $E(SEG,1,4)="SBR*" Q  ;subscriber info
 I $E(SEG,1,4)="PAT*" D  Q  ;patient death and/or weight - prof
 . N IBDOD,IBPW
 . S IBDOD=$P(ARG(IBSEG),"*",7) I IBDOD'="" S IBDOD=$S($E(IBDOD,1,2)=19:2,1:3)_$E(IBDOD,3,8) D SET^IBCE837ACC1(IBDOD,31)
 . S IBPW=$P(ARG(IBSEG),"*",9) I IBPW'="" D SET^IBCE837ACC1(IBPW,32)
 . Q
 I $E(SEG,1,4)="NM1*" D  Q
 . I SEG2="IL" S IBPATICN=$P(ARG(IBSEG),"*",10) D PAT^IBCE837ACC4,NEXT Q  ;subscriber name, address info
 . I SEG2="PR" D  Q
 .. S IBPAYERID=$P(ARG(IBSEG),"*",10)
 ..D NEXT Q  ;payer name
 ;get patient DOB from DMG subscriber segment;only set if not already defined with VistA patient info
 I $E(SEG,1,4)="DMG*" S DOB=$P(ARG(IBSEG),"*",3) I DOB'="",$G(IBDOB)="" S IBDOB=$S($E(DOB,1,2)=19:2,1:3)_$E(DOB,3,8) Q
 I $E(SEG,1,4)="REF*" D  Q
 . I SEG2="SY" D  Q
 .. ;5/14/25 JWS;found during documentation, added if ssn="", try to get it from REF seg
 .. I $G(IBPATLN)'="",$G(IBPATSSN)="" S IBPATSSN=$P(ARG(IBSEG),"*",3) Q  ;sub secondary id - ssn 
 . Q
 Q
 ;
NEXT ;
 S IBSEGN="SEG"_(IBI+1) I $E($G(ARG(IBSEGN)),1,3)="N3*" S IBI=IBI+1
 S IBSEGN="SEG"_(IBI+1) I $E($G(ARG(IBSEGN)),1,3)="N4*" S IBI=IBI+1
 Q
 ;
DT(FIELD) ;
 N XDT,DATE
 S DATE=$P(ARG(IBSEG),"*",4)
 I $F(DATE,"-") S XDT=$S($E(DATE,1,2)=19:2,1:3)_$E(DATE,3,8)_"-"_$S($E(DATE,10,11)=19:2,1:3)_$E(DATE,12,17) D SET^IBCE837ACC1(XDT,FIELD) Q
 I DATE'="" S XDT=$S($E(DATE,1,2)=19:2,1:3)_$E(DATE,3,8) I XDT'="" D SET^IBCE837ACC1(XDT,FIELD) Q
 Q
 ;
CHKINS(IBPATIEN,IBDOS,IBFT,IBINSNAME) ;
 ; IBPATIEN = patient IEN pointer
 ; IBDOS = date of service from 1st service line item in X12 claim
 ; IBFT = vista form type, 2=Prof, 3=Inst, 7=Dental
 ; IBINSNAME = return ins name value
 N X,X1,IBINS,IBEXP,X2,IBX,IBX1,IB3553,IBTOP,IB35531,IBCAT,IBGP,IBCOB,IBCID,IBMID
 S IBCID=$$GET1^DIQ(350.9,"1,",51.01) I IBCID="" S IBCID=180
 S IBMID=$$GET1^DIQ(350.9,"1,",51.32) I IBMID="" S IBMID=365
 ; X - returned by ^%DTC indicates number of days between dos and ins last verified date
 ; IBINS - array of patient insurance from ALL^IBCNS1
 ; IBX - cob priority
 ; IBX1 - insurance entry ptr in patient file
 ; IBEXP - return value of exception #
 ; IB3553 - ptr to file 355.3
 D ALL^IBCNS1(IBPATIEN,"IBINS",4,IBDOS,1)
 I $G(IBINS(0))=0 Q 3  ;no OHI information found for this patient, return error code 3
 ;JWS;IB*2.0*770v4;if no commercial insurance, just Medicare, then no OHI to bill
 I $O(IBINS("S",.5))="" Q 3  ;only medicare, so no OHI to bill
 ; loop thru all active insurance & medicare to determine which insurances apply
 S IBX=0 F  S IBX=$O(IBINS("S",IBX)) Q:IBX'=+IBX  S IBX1="" F  S IBX1=$O(IBINS("S",IBX,IBX1)) Q:IBX1=""  D
 . ; get file 355.3 pointer - group plan, IBGP=group name
 . S IBEXP="",IB3553=$P(IBINS(IBX1,0),"^",18) I IB3553 S IBGP=$$GET1^DIQ(355.3,IB3553_",",2.01),IBTOP=$$GET1^DIQ(355.3,IB3553_",",.09)
 . ; check for plan category to see if claim type is covered, inpatient, outpatient or dental
 . S IBCAT=$S(IBFT=7:"DENTAL",IBIO="I":"INPATIENT",IBIO="O":"OUTPATIENT",1:"")
 . I IBCAT="" Q
 . S IB35531=$O(^IBE(355.31,"B",IBCAT,0))
 . ; call eIns funct to see this insurance entry covers the claim type, if not skip
 . ;JWS;EBILL-3551;IB*2.0*770v7; remove check for insurance coverage indication for medicare only
 . I IBX'=".5",'$$PLCOV^IBCNSU3(IB3553,IBDOS,IB35531,0) Q
 . I IBX=".5",IBFT'=3,$F(IBGP,"PART A") Q
 . I IBX=".5",IBFT'=2,$F(IBGP,"PART B") Q
 . ;JWS;EBILL-5365;exclude ins with type-of-coverage CHAMPVA, MEDI-CAL, TRICARE, MEDICARE, MEDICAID
 . I $$TOC($P(IBINS(IBX1,0),"^")) Q
 . S IBINSNAME=$P($G(^DIC(36,$P(IBINS(IBX1,0),"^"),0)),"^")
 . ; do not create K# for claims for patients that have insurance setup indicating CAMP LEJEUNE or IVF
 . ;JWS;2/18/25;EBILL-4972;IB*2.0*770v20;allow to skip sc/sa (all RUR reasons) failure reasons
 . I $F(IBINSNAME,"CAMP LEJEUNE") D:'$P($G(^IBA(364.9,IBX12,0)),"^",31) UP^IBCE837ACC(IBX12,8,5,IBINSNAME) Q  ; SKIP CAMP LEJEUNE
 . I $F(IBINSNAME,"IVF") D:'$P($G(^IBA(364.9,IBX12,0)),"^",31) UP^IBCE837ACC(IBX12,9,5,IBINSNAME) Q  ; SKIP IVF
 . I $F(IBINSNAME,"REGIONAL COUNSEL") D:'$P($G(^IBA(364.9,IBX12,0)),"^",31) UP^IBCE837ACC(IBX12,15,5,IBINSNAME) Q  ;LEGAL ISSUE
 . I $F(IBINSNAME,"US DEPART OF LABOR")!$F(IBINSNAME,"US DEPT OF LABOR")!$F(IBINSNAME,"U.S. DEPT OF LABOR")!$F(IBINSNAME,"US DEPARTMENT OF LABOR") D:'$P($G(^IBA(364.9,IBX12,0)),"^",31) UP^IBCE837ACC(IBX12,23,5,IBINSNAME) Q
 . I $F(IBTOP,"NO-FAULT")!($F(IBTOP,"TORT FEASOR"))!($F(IBTOP,"WORKERS' COMPENSATION")) D:'$P($G(^IBA(364.9,IBX12,0)),"^",31) UP^IBCE837ACC(IBX12,15,5,IBINSNAME) Q  ;plan type
 . S IBCOB=$P(IBINS(IBX1,0),"^",20)
 . ; check last verify date, if medicare allow 365 days, otherwise 180 days
 . ;JWS;7/23/25;EBILL-5790; check if patient death date exists, if so, skip ins verification date check
 . I '+$$GET1^DIQ(2,IBPATIEN_",",.351,"I") D
 .. S X1=IBDOS,X2=$P($G(IBINS(IBX1,1)),"^",3)
 .. D ^%DTC   ; GET NUMBER OF DAYS BETWEEN X1(DOS) AND X2(INSURANCE VERIFICATION DATE)
 .. I IBX<1,X>IBMID S IBEXP=18 D UP^IBCE837ACC(IBX12,18,5,IBINSNAME) Q  ;Medicare 365?
 .. I IBX'<1,X>IBCID S IBEXP=18 D UP^IBCE837ACC(IBX12,18,5,IBINSNAME)
 . ;IBCOB=1 indicates primary
 . I IBCOB=1 D
 .. I $P(^TMP("IB837ACC",$J),"^",2)'="" D UP^IBCE837ACC(IBX12,103,5,IBINSNAME) Q
 .. S X=$P(IBINS(IBX1,0),"^")_"*"_IBX1_"*"_$S(IBX<1:"M",1:"C"),$P(^TMP("IB837ACC",$J),"^",2)=X
 .. I IBX<1,$F(IBGP,"MCR"),$F(IBGP,"WNR"),$F(IBTOP,"MEDICARE ADVANTAGE") S $P(^TMP("IB837ACC",$J),"^",40)=1
 .. D UPDATE^IBCE837ACC2A(IBX12,$P(IBINS(IBX1,0),"^"),.17)
 . ;IBCOB=2 indicates secondary
 . I IBCOB=2 D
 .. I $P($G(^TMP("IB837ACC",$J)),"^",3)'="" D UP^IBCE837ACC(IBX12,103,5,IBINSNAME) Q
 .. S X=$P(IBINS(IBX1,0),"^")_"*"_IBX1,$P(^TMP("IB837ACC",$J),"^",3)=X
 .. D UPDATE^IBCE837ACC2A(IBX12,$P(IBINS(IBX1,0),"^"),.18)
 . ;IBCOB=3 indicates tertiary
 . I IBCOB=3 D
 .. I $P(^TMP("IB837ACC",$J),"^",4)'="" D UP^IBCE837ACC(IBX12,103,5,IBINSNAME) Q
 .. S X=$P(IBINS(IBX1,0),"^")_"*"_IBX1,$P(^TMP("IB837ACC",$J),"^",4)=X
 .. D UPDATE^IBCE837ACC2A(IBX12,$P(IBINS(IBX1,0),"^"),.19)
 I IBFT=7,$P(^TMP("IB837ACC",$J),"^",2)="",$P(^($J),"^",3)'="" D
 . S $P(^($J),"^",2)=$P(^TMP("IB837ACC",$J),"^",3),$P(^($J),"^",3)=""
 . D UPDATE^IBCE837ACC2A(IBX12,$P($P(^TMP("IB837ACC",$J),"^",3),"*"),.17)
 . D UPDATE^IBCE837ACC2A(IBX12,"",.18)
 ;JWS;IB*2.0*770v4;if no primary OHI, close encounter
 I $P($G(^TMP("IB837ACC",$J)),"^",2)="" D UP^IBCE837ACC(IBX12,16,5,"") Q 3
 ;JWS;IB*2.0*770v4;if primary is Medicare and no secondary, close encounter
 I $P($P($G(^TMP("IB837ACC",$J)),"^",2),"*",3)="M",$P($G(^TMP("IB837ACC",$J)),"^",3)="" Q 3
 Q +$G(IBEXP)
 ;
 ;
CHK35593(IBPNPI,IBPT1,IBSLINE) ;
 ; IBPNPI=NPI to look for
 ; IBPT1=provider type
 ;       85=billing provider
 ;       DN=referring provider
 ;       82=rendering provider
 ;       77=service facility
 ;       DQ=supervising provider
 ;       71=attending provider
 ;       72=operating physician
 ;       ZZ=other operating physician
 ;       DD=assistant surgeon
 ; IBSLINE=service line number, if provider is at the line level
 ;
 N XNPI,RES,RES1,I,OK,PCP,IBPT2
 S IBPN2=""
 ;JWS;7/16/25;EBILL-5743;if NPI value is null, and if prov type is Rendering (82), Service Facility (77) or Operating (72), use Billing Prov (85) NPI
 ;JWS;9/16/25;EBILL-6055;remove defaulting Billing Prov if Rendering or operating is not available
 I $G(IBPNPI)="" D  I $G(IBPNPI)="" Q 0
 . ;I IBPT1=82!(IBPT1=77)!(IBPT1=72) S IBPNPI=$P($G(^TMP("IB837ACC",$J,1,85)),"^"),$P(ARG(IBSEG),"*",10)=IBPNPI
 . I IBPT1=77 S IBPNPI=$P($G(^TMP("IB837ACC",$J,1,85)),"^"),$P(ARG(IBSEG),"*",10)=IBPNPI
 ;. Q
 ;JWS;5/28/25;EBILL-5458;Pat's PCP addition;add the use of $$QI^XUSNPI(IBPNPI) to find provider(s) 
 S RES=$$QI^XUSNPI(IBPNPI)
 ;;I +RES=0 Q 0
 S OK=0
 ;JWS;5/28/25;EBILL-5458;add the use of $$OUTPTPR^SDUTL3(IBPATIEN) to get primary care provider info;dbia 1252
 I $G(IBPATIEN) S PCP=$$OUTPTPR^SDUTL3(IBPATIEN)
 I $P(RES,"^")'=0 F I=1:1 S RES1=$P(RES,";",I) Q:RES1=""  D  I OK>0 Q
 . I $P(RES1,"^")="Organization_ID" Q
 . N OK1
 . S OK=$S($P(RES1,"^")="Individual_ID":2,1:1)
 . ;JWS;10/30/25;EBILL-6206; prioritize provider file 200 for DN (Referring) and 71 (attending) only, file 355.93 for all others only
 . ;I OK=1,$F(",DN,71,",","_IBPT1_",") S OK=0 Q
 . I OK=2,'$F(",DN,71,",","_IBPT1_",") S OK=0 Q
 . ;JWS;1/15/26;EBILL-6386;IB*2.0*770v57;for non-va file (355.93) entries, if 77 service facility, must be non-person, otherwise it can only be a person
 . I OK=1 D  I OK=0 Q
 .. S IBPT2=$$GET1^DIQ(355.93,$P(RES1,"^",2)_",",.02,"I")
 .. ;JWS/1/22/26;EBILL-6415;IB*2.0*770v59;allow Billing Provider
 .. I IBPT1=85 S:IBPT2=2 OK=0 Q
 .. ;JWS;1/15/26;EBILL-6386;IB*2.0*770v57;if service facility lookup and entry is a person, quit and skip entry
 .. I IBPT1=77 S:IBPT2=2 OK=0 Q
 .. ;JWS;1/15/26;EBILL-6386;IB*2.0*770v57;if any other provider lookup and entry is a non-person, quit and skip entry
 .. I IBPT2=1 S OK=0 Q
 . ; if individual_id (file 200) then check if person class is there, if missing skip. (8/6/25);IB*2.0*770v51(11/3/25); ; DBIA 1625
 . ;I OK=2,$P($$GET^XUA4A72($P(RES1,"^",2)),"^")=-1 S OK=0 Q
 . ;11/19/25;JWS;EBILL-6206;check if taxonomy exists
 . D  I $P($G(OK1),"^")="",OK<1 Q  ;S:$F(",DN,71,",","_IBPT1_",") OK=0 S:OK'=0 OK=-1 Q
 .. I OK=2 S OK1=$$GETTAX^IBCEF73A($P(RES1,"^",2)_";VA(200,") D  Q
 ... I $P($G(OK1),"^")'="" Q
 ... S OK=0
 .. S OK1=$$GETTAX^IBCEF73A($P(RES1,"^",2)_";IBA(355.93,")
 .. I $P($G(OK1),"^")="",$F(",DN,71,82,",","_IBPT1_",") S OK=-1
 .. Q
 . I '+$G(IBSLINE) D SET^IBCE837ACC1($P(RES1,"^",2),1.4,IBPT1)
 . E  S $P(^TMP("IB837ACC",$J,"L",IBSLINE,1,IBPT1),"^",4)=$P(RES1,"^",2)
 . I OK=2 S IBPN2=$$GET1^DIQ(200,$P(RES1,"^",2)_",",.01) Q
 . S IBPN2=$$GET1^DIQ(355.93,$P(RES1,"^",2)_",",.01)
 . Q
 I OK'=0 Q OK
 I +$G(PCP),(IBPT1=71!(IBPT1="DN")) D  Q 2
 . I '+$G(IBSLINE) D SET^IBCE837ACC1($P(PCP,"^"),1.4,IBPT1) Q
 . S $P(^TMP("IB837ACC",$J,"L",IBSLINE,1,IBPT1),"^",4)=$P(PCP,"^")
 . Q
 Q 0
 ;
TOC(IBINS) ;
 N IBTOC
 ;JWS;EBILL-5365;exclude ins with type-of-coverage CHAMPVA, MEDI-CAL, TRICARE, MEDICARE, MEDICAID
 S IBTOC=$$GET1^DIQ(36,IBINS_",",.13)
 I $F(",CHAMPVA,MEDI-CAL,TRICARE,MEDICAID,",","_IBTOC) Q 1
 Q 0
 ;
PCP(IBPATIEN,IBFT) ;swap primary care physician or billing provider
 ;JWS;7/16/25;EBILL-5743; if Rendering (82), Service Facility (77) or Operating (72) are not defined, use Billing Prov (85) NPI
 I +$G(IBFT)=0 Q
 N PCP,XIBPNPI,XBP
 S PCP=$$OUTPTPR^SDUTL3(IBPATIEN) I +PCP'=0 S XIBPNPI=$$GET1^DIQ(200,$P(PCP,"^")_",",41.99)
 S XBP=$G(^TMP("IB837ACC",$J,1,85))
 ;77 - service facility
 ;JWS;1/22/26;EBILL-6415;IB*2.0*770v59;when service facility does not exist, and Billing provider is not found in VistA,need to report error #5
 I '$D(^TMP("IB837ACC",$J,1,77)) D
 . I +$P(XBP,"^",4) S ^TMP("IB837ACC",$J,1,77)=XBP Q
 . N IB36491 S IB36491=$O(^IBA(364.91,"B",5,0)) I 'IB36491 Q
 . I $D(^IBA(364.9,"B",5,IB36491)) Q
 . D UP^IBCE837ACC(IBX12,5,5,"")
 . Q
 ; PCP = 8031^MCDONALD,KERRY A
 ; JWS;3/5/26;EBILL-6805;IB*2.0*770v64;need to add Dental claim to rendering provider check
 I IBFT=2!(IBFT=7) D
 . N IBX,DA,DIK,IBX1
 . I IBFT=2,'$D(^TMP("IB837ACC",$J,1,"DN")),$G(XIBPNPI) D
 .. ;DN - referring provider with primary care
 .. S ^TMP("IB837ACC",$J,1,"DN")=XIBPNPI_"^"_$P(PCP,"^",2)_"^200^"_$P(PCP,"^")
 .. Q
 . ;JWS;9/16/25;EBILL-6055;remove defaulting Billing Prov if Rendering(82) is not available, allow K# creation, go to FRT wl
 . I '$D(^TMP("IB837ACC",$J,1,82))!($P($G(^(82)),"^")="") D
 .. ;82 - rendering provider
 .. S IBX1=$P($G(^TMP("IB837ACC",$J,1,82)),"^",2)
 .. I IBX1'="" S IBX=0 F  S IBX=$O(^IBA(364.9,IBX12,5,IBX)) Q:IBX'=+IBX  I $F($P($G(^(IBX,0)),"^",2),IBX1) S DA(1)=IBX12,DIK="^IBA(364.9,"_DA(1)_",5,",DA=IBX D ^DIK
 .. D UP^IBCE837ACC(IBX12,109,5,"")
 .. Q
 ;
 I IBFT=3 D
 . N IBX,DA,DIK,IBX1
 . I '$D(^TMP("IB837ACC",$J,1,71)),$G(XIBPNPI) D
 .. ;71 - attending provider with primary care
 .. S ^TMP("IB837ACC",$J,1,71)=XIBPNPI_"^"_$P(PCP,"^",2)_"^200^"_$P(PCP,"^")
 .. Q
 . ;JWS;9/16/25;EBILL-6055;remove defaulting Billing Prov if operating is not available, and check procedure codes if surgical and assign error code 110
 . I '$D(^TMP("IB837ACC",$J,1,72))!($P($G(^(72)),"^")="") D
 .. ;72 - operating physician
 .. I $P(^TMP("IB837ACC",$J),"^",45) D
 ... S IBX1=$P($G(^TMP("IB837ACC",$J,1,72)),"^",2)
 ... I IBX1'="" S IBX=0 F  S IBX=$O(^IBA(364.9,IBX12,5,IBX)) Q:IBX'=+IBX  I $F($P($G(^(IBX,0)),"^",2),IBX1) S DA(1)=IBX12,DIK="^IBA(364.9,"_DA(1)_",5,",DA=IBX D ^DIK
 ... D UP^IBCE837ACC(IBX12,110,5,"")
 .. Q
 . Q
 Q
 ;
