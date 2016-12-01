IBTRH6 ;ALB/FA - HCSR Send 278 Short Worklist ;11-NOV-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ;
EN ; Main entry point for the IBT HCSR SEND 278 SHORT worklist
 ; Displays the selected 278 short form for sending 278 requests
 ; Input:   IBTRIEN - IEN of the selected entry to send a request for
 N FROMDATA,IBTRENT,INPAT,NODE2,NODE7,NODE19,VADM,WHICH
 ;;12/9/14 JWS - prevent entry if status is PENDING a response
 I $$STATUS^IBTRH2(IBTRIEN)="07" D STATMSG^IBTRH2A(4) Q
 S VALMBCK="R"
 S FROMDATA=0
 S INPAT=$S($P(NODE0,U,4)="I":1,1:0) ; 1 if inpatient, 0 if outpatient
 S WHICH=$$SELSHORT(INPAT)           ; type of request
 I WHICH'="" D EN^VALM("IBT HCSR SEND 278 SHORT")
 I $D(IBFASTXT) S VALMBCK="Q"
 Q
 ;
SELSHORT(INPAT) ; User selection of which 278 request to send
 ; Input: INPAT=1 if inpatient, 0 otherwise
 ; Returns: Selected Input Type or "" if none selected
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,XX,Y
 D FULL^VALM1
 I INPAT S XX="1:Admission (initial);2:Mental Health Inpatient (initial)"
 I 'INPAT S XX="1:Appointment (initial);2:Mental Health Outpatient (initial)"
 S XX=XX_";3:Prescription (initial)"
 S DIR(0)="S^"_XX,DIR("A")="Select Input Type"
 D ^DIR
 Q:$D(DIRUT) ""                                 ; User Pressed ^ or timed out
 I Y'=1 D  S Y=""
 . W !,"Mental Health and Prescription options are not currently available."
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 . S DIR(0)="EA"
 . S DIR("A",1)=" "
 . S DIR("A")="Press RETURN to continue " D ^DIR
 Q Y
 ;
HDR ;EP
 ; Protocol action to display Worklist Patient header information
 ; Input:   IBTRIEN - IEN of the selected entry to send a request for
 ; Output:  Header information for the patient of the selected entry is set
 ;
 N Z
 S Z=$E(VADM(1),1,28),Z=Z_$J("",35-$L(Z))_$P(VADM(2),U,2)_"    DOB: "_$P(VADM(3),U,2)_"    AGE: "_VADM(4)
 S VALMHDR(1)=Z
 S VALMSG="*/Required"
 Q
 ;
INIT ;EP
 ;
 K ^TMP("IBTRH6",$J)
 S VALMBG=1
 D DEM^VADPT ; get patient demographics
 S NODE0=$G(^IBT(356.22,IBTRIEN,0))
 S NODE2=$G(^IBT(356.22,IBTRIEN,2))
 S NODE7=$G(^IBT(356.22,IBTRIEN,7))
 S NODE19=$G(^IBT(356.22,IBTRIEN,19))
 D WRTFLDS D:'FROMDATA WRTCNUM ; auto populate fields
 ; re-read nodes to get auto-populated values
 S NODE0=$G(^IBT(356.22,IBTRIEN,0))
 S NODE2=$G(^IBT(356.22,IBTRIEN,2))
 S NODE7=$G(^IBT(356.22,IBTRIEN,7))
 S NODE19=$G(^IBT(356.22,IBTRIEN,19))
 D BLD
 I WHICH=1 S VALM("TITLE")="HCSR 278 "_$S(INPAT:"Admission",1:"Appointment")_" - Brief"
 I WHICH=2 S VALM("TITLE")="HCSR 278 Mental - Brief"
 I WHICH=3 S VALM("TITLE")="HCSR 278 Prescription - Brief"
 Q
 ;
BLD ; Creates the body of the worklist
 ;
 N ELINEL,ELINER,SLINE
 S SLINE=1
 D BLDUMO(SLINE,.ELINEL)                ; Build UMO Field section
 D BLDSUB(ELINEL,.ELINEL)               ; Build Subscriber Field section
 D BLDREQ(SLINE,.ELINER)                ; Build Requester Field section
 S SLINE=$S(ELINEL>ELINER:ELINEL,1:ELINER)
 D BLDDEP(SLINE,.ELINEL)                ; Build Dependent Field section
 D BLDDIAG(SLINE,.ELINER)               ; Build Diagnoses Field section
 S SLINE=$S(ELINEL>ELINER:ELINEL,1:ELINER)
 D BLDHCSR(SLINE,.ELINEL)               ; Build Health Care Services Field section
 D BLDPROV(SLINE,.ELINER)               ; Build Provider Field section
 S SLINE=$S(ELINEL>ELINER:ELINEL,1:ELINER)
 D BLDSVC(SLINE,.ELINEL)                ; Build Service Line Field section
 D BLDAPI(SLINE,.ELINER)                ; Build API Line Field section
 S SLINE=$S(ELINEL>ELINER:ELINEL,1:ELINER)
 D BLDCOM(SLINE,.ELINEL)                ; Build Comment Field section
 S VALMCNT=ELINEL-1
 Q
 ;
BLDUMO(SLINE,ELINE) ; Build the UMO Field Section
 ; Input:
 ;          SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N PAYER,PAYID
 S ELINE=$$SET("",$J("",40),SLINE,1)            ; Spacing Blank Line
 S ELINE=$$SETN("UM Organization",ELINE,1,1)
 S ELINE=$$SET("Name*: ",$$GET1^DIQ(36,IEN36_",",.01),ELINE,1)
 S PAYER=+$$GET1^DIQ(36,IEN36_",",3.1,"I") ; file 365.12 ien
 S PAYID="" I PAYER>0 S PAYID=$P($G(^IBE(365.12,PAYER,0)),U,2) ; VA national id
 S ELINE=$$SET("National Payer ID: ",PAYID,ELINE,1)
 S ELINE=$$SET("HPID: ",$$HPD^IBCNHUT1(IEN36),ELINE,1)
 Q
 ;
BLDSUB(SLINE,ELINE) ; Build the Subscriber Fields
 ; Input:
 ;          SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N INSNODE3,ZIP
 S INSNODE3=$G(^DPT(DFN,.312,IEN312,3))
 S ELINE=$$SET("",$J("",40),SLINE,1)            ; Spacing Blank Line
 S ELINE=$$SETN("Subscriber",ELINE,1,1)
 S ELINE=$$SET("Name*: ",$P(INSNODE0,U,17),ELINE,1)
 S ELINE=$$SET("Primary ID*: ",$P(INSNODE0,U,2),ELINE,1)
 S ELINE=$$SET("Address Line 1: ",$P(INSNODE3,U,6),ELINE,1)
 S ELINE=$$SET("Address Line 2: ",$P(INSNODE3,U,7),ELINE,1)
 S ELINE=$$SET("City: ",$P(INSNODE3,U,8),ELINE,1)
 S ELINE=$$SET("State: ",$$GET1^DIQ(5,$P(INSNODE3,U,9)_",",1),ELINE,1)
 S ZIP=$P(INSNODE3,U,10) I $L(ZIP)>5,$E(ZIP,6)'="-" S ZIP=$E(ZIP,1,5)_"-"_$E(ZIP,6,99)
 S ELINE=$$SET("Zip Code: ",ZIP,ELINE,1)
 Q
 ;
BLDREQ(SLINE,ELINE) ; Build the Requester fields
 ; Input:
 ;          SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N CNARY,REQIEN,REQSTR,REQDATA,ZIP
 S REQIEN=$P($$SITE^VASITE(),U),REQSTR=$$PRVDATA^IBTRHLO2(REQIEN,4)
 D GETCNUM(.CNARY)
 S ELINE=$$SET("",$J("",40),SLINE,41)           ; Spacing Blank Line
 S ELINE=$$SETN("Requester",ELINE,41,1)
 S ELINE=$$SET("Name*: ",$P(REQSTR,U),ELINE,41)
 S ELINE=$$SET("NPI*: ",$P(REQSTR,U,7),ELINE,41)
 S ELINE=$$SET("Taxonomy Code: ",$P($$TAXORG^XUSTAX(REQIEN),U),ELINE,41)
 S ELINE=$$SET("Address Line 1*: ",$P(REQSTR,U,2),ELINE,41)
 S ELINE=$$SET("Address Line 2: ",$P(REQSTR,U,3),ELINE,41)
 S ELINE=$$SET("City*: ",$P(REQSTR,U,4),ELINE,41)
 S ELINE=$$SET("State*: ",$$GET1^DIQ(5,$P(REQSTR,U,5)_",",1),ELINE,41)
 S ZIP=$P(REQSTR,U,6) I $L(ZIP)>5,$E(ZIP,6)'="-" S ZIP=$E(ZIP,1,5)_"-"_$E(ZIP,6,99)
 S ELINE=$$SET("Zip Code*: ",ZIP,ELINE,41)
 S ELINE=$$SET("Contact Name*: ",$$EXTERNAL^DILFD(356.22,.11,,$P(NODE0,U,11)),ELINE,41)
 S ELINE=$$SET("Contact Phone: ",$G(CNARY("TE")),ELINE,41)
 S ELINE=$$SET("Contact Phone Ext.: ",$G(CNARY("EX")),ELINE,41)
 S ELINE=$$SET("Contact Fax: ",$G(CNARY("FX")),ELINE,41)
 Q
 ;
BLDDEP(SLINE,ELINE) ; Build the Dependent fields
 ; Input:
 ;          SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N INSNODE4
 S INSNODE4=$G(^DPT(DFN,.312,IEN312,4))
 I $P(INSNODE4,U,3)="18" Q  ; pat. relationship is "self"
 S ELINE=$$SET("",$J("",40),SLINE,1)
 S ELINE=$$SETN("Dependent",ELINE,1,1)
 S ELINE=$$SET("Name*: ",VADM(1),ELINE,1)
 Q
 ;
BLDDIAG(SLINE,ELINE) ; Build the Diagnosis fields
 ; Input:
 ;          SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N DATA,DPTR,QPTR,Z
 S ELINE=$$SET("",$J("",40),ELINE,41)
 S ELINE=$$SETN("Diagnoses",ELINE,41,1)
 S Z=0 F  S Z=$O(^IBT(356.22,IBTRIEN,3,Z)) Q:'Z!(Z?1.A)  D
 .S DATA=$G(^IBT(356.22,IBTRIEN,3,Z,0)) I DATA'="" D
 ..S QPTR=+$P(DATA,U),DPTR=$P(DATA,U,2)
 ..S ELINE=$$SET("Qualifier: ",$$GET1^DIQ(356.006,QPTR_",",.02),ELINE,41)
 ..S ELINE=$$SET("Diagnosis: ",$$EXTERNAL^DILFD(356.223,.02,,DPTR),ELINE,41)
 ..Q
 .Q
 Q
 ;
BLDHCSR(SLINE,ELINE) ; Build the Health Care Service Review Fields
 ; Input:
 ;          SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N Z
 S ELINE=$$SET("",$J("",40),SLINE,1)
 S ELINE=$$SETN("Health Care Service Review",ELINE,1,1)
 S ELINE=$$SET("Category*: ",$$GET1^DIQ(356.001,+$P(NODE2,U)_",",.02),ELINE,1)
 S ELINE=$$SET("Certification Type*: ",$$GET1^DIQ(356.002,+$P(NODE2,U,2)_",",.02),ELINE,1)
 S ELINE=$$SET("Service Type*: ",$$GET1^DIQ(365.013,+$P(NODE2,U,3)_",",.02),ELINE,1)
 I 'INPAT S ELINE=$$SET("Facility Type*: ",$$GET1^DIQ(353.1,+$P(NODE2,U,5)_",",.02),ELINE,1)
 I INPAT D
 .S Z=$P(NODE2,U,6)_$P(NODE2,U,7)
 .I Z="11" S ELINE=$$SET("Bill Type*: ","HOSPITAL/INPATIENT",ELINE,1)
 .S ELINE=$$SET("Adm Type: ",$$EXTERNAL^DILFD(356.22,7.01,,$P(NODE7,U)),ELINE,1)
 .Q
 Q
 ;
BLDPROV(SLINE,ELINE) ; Build the Provider Information Fields 
 ; Input:
 ;          SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N DATA,PRVDATA,PRVPTR,Z
 S ELINE=$$SET("",$J("",40),ELINE,41)
 S ELINE=$$SETN("Provider Information",ELINE,41,1)
 S Z=0 F  S Z=$O(^IBT(356.22,IBTRIEN,13,Z)) Q:'Z!(Z?1.A)  D
 .S DATA=$G(^IBT(356.22,IBTRIEN,13,Z,0)) I DATA'="" D
 ..S PRVPTR=$P(DATA,U,3),PRVDATA=$$PRVDATA^IBTRHLO2(+$P(PRVPTR,";"),$P($P(PRVPTR,"(",2),","))
 ..S ELINE=$$SET("Provider Type: ",$$GET1^DIQ(365.022,$P(DATA,U)_",",.02),ELINE,41)
 ..S ELINE=$$SET("Provider Name: ",$P(PRVDATA,U),ELINE,41)
 ..S ELINE=$$SET("Provider NPI: ",$P(PRVDATA,U,7),ELINE,41)
 ..Q
 .Q
 Q
 ;
BLDSVC(SLINE,ELINE) ; Build the Service Line Fields
 ; Input:
 ;          SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N CNT,PRCODE,PRTYPE,SNODE0,SNODE1,SNODE12,Z
 S ELINE=$$SET("",$J("",40),SLINE,1)
 S ELINE=$$SETN("Service Lines",ELINE,1,1)
 S (CNT,Z)=0 F  S Z=$O(^IBT(356.22,IBTRIEN,16,Z)) Q:'Z!(Z?1.A)  D
 .S SNODE0=$G(^IBT(356.22,IBTRIEN,16,Z,0)),SNODE1=$G(^IBT(356.22,IBTRIEN,16,Z,1)),CNT=CNT+1
 .S SNODE12=$G(^IBT(356.22,IBTRIEN,16,Z,12))
 .S ELINE=$$SET("Service Line #: ",CNT,ELINE,1)
 .S ELINE=$$SET("Date of Service: ",$$FMTE^XLFDT($P(SNODE0,U,11),5),ELINE,1)
 .S PRTYPE=$P(SNODE1,U)
 .S PRCODE=$S(PRTYPE="N4":$P(SNODE12,U),1:$$EXTERNAL^DILFD(356.2216,1.02,,$P(SNODE1,U,2)))
 .S ELINE=$$SET("Procedure Code*: ",PRCODE,ELINE,1)
 .Q
 Q
 ;
BLDAPI(SLINE,ELINE) ; Build the Additional Patient Information Fields
 ; Input:
 ;          SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N ANODE0,Z
 S ELINE=$$SET("",$J("",40),SLINE,41)
 S ELINE=$$SETN("Paperwork Attachments",ELINE,41,1)
 S Z=0 F  S Z=$O(^IBT(356.22,IBTRIEN,11,Z)) Q:'Z!(Z?1.A)  D
 .S ANODE0=$G(^IBT(356.22,IBTRIEN,11,Z,0))
 .S ELINE=$$SET("Report Type: ",$$GET1^DIQ(356.018,+$P(ANODE0,U)_",",.02),ELINE,41)
 .S ELINE=$$SET("Transmission Method: ",$$EXTERNAL^DILFD(356.2211,.02,,$P(ANODE0,U,2)),ELINE,41)
 .S ELINE=$$SET("Attachment Control Number: ",$P(ANODE0,U,3),ELINE,41)
 .Q
 Q
 ;
BLDCOM(SLINE,ELINE) ; Build the Comment Fields
 ; Input:
 ;          SLINE   - Starting Section Line Number
 ;          ELINE   - Current Ending Section Line Number
 ; Output:  ELINE   - Updated Ending Section Line Number
 ;
 N XX
 S ELINE=$$SET("",$J("",40),SLINE,1)
 S ELINE=$$SETN("Request Comments",ELINE,1,1)
 K ^UTILITY($J,"W")
 D FORMAT^IBDFU6("^IBT(356.22,IBTRIEN,12)",80,"Message: ")
 S XX=0 F  S XX=$O(^UTILITY($J,"W",1,XX)) Q:XX=""  S ELINE=$$SET("",$G(^UTILITY($J,"W",1,XX,0)),ELINE,1)
 K ^UTILITY($J,"W")
 Q
 ;
SET(LABEL,DATA,LINE,COL) ; Sets text into the body of the worklist
 ; Input:   LABEL   - Label text to set into the line
 ;          DATA    - Field Data to set into the line
 ;          LINE    - Line to set LABEL and DATA into
 ;          COL     - Starting column position in LINE to insert
 ;                    LABEL_DATA text
 ; Returns: LINE    - Updated Line by 1
 ;
 N IBY
 S IBY=LABEL_DATA
 D SET1(IBY,LINE,COL,$L(IBY))
 S LINE=LINE+1
 Q LINE
 ;
SETN(TITLE,LINE,COL,RV) ; Sets a field Section title into the body of the worklist
 ; Input:   TITLE   - Text to be used for the field Section Title
 ;          LINE    - Line number in the body to insert the field section title
 ;          COL     - Starting Column position to set Section Title into
 ;          RV      - 1 - Set Reverse Video, 0 or null don't use Reverse Video
 ;                        Optional, defaults to ""
 ; Returns: LINE    - Line number increased by 1
 ;
 N IBY
 S IBY=" "_TITLE_" "
 D SET1(IBY,LINE,COL,$L(IBY),$G(RV))
 S LINE=LINE+1
 Q LINE
 ;
SET1(TEXT,LINE,COL,WIDTH,RV) ; Sets the TMP array with body data
 ; Input:   TEXT                - Text to be set into the specified line
 ;          LINE                - Line to set TEXT into
 ;          COL                 - Column of LINE to set TEXT into
 ;          WIDTH               - Width of the TEXT being set into line
 ;          RV                  - 1 - Set Reverse Video, 0 or null don't use
 ;                                    Reverse Video
 ;                                Optional, defaults to ""
 ;          ^TMP("IBTRH6",$J)   - Current ^TMP array
 ; Output:  ^TMP("IBTRH6",$J)   - Updated ^TMP array
 ;
 N IBX
 S IBX=$G(^TMP("IBTRH6",$J,LINE,0))
 S IBX=$$SETSTR^VALM1(TEXT,IBX,COL,WIDTH)
 D SET^VALM10(LINE,IBX)
 D:$G(RV)'="" CNTRL^VALM10(LINE,COL,WIDTH,IORVON,IORVOFF)
 Q
 ;
DATA ;EP
 ; Protocol action to add/edit fields for the brief 278 request fields
 N DA,DIE,DR,DTOUT,IBPSTAT,IBUPOUT,X,Y
 S VALMBCK="R"
 S FROMDATA=1
 D FULL^VALM1
 I $$STATUS^IBTRH2(IBTRIEN)="0" D PRMARK1^IBTRH1(IBTRIEN,"01") ; Set 'in-progress mark'
 ; Set Initial Values
 S IBPSTAT=$P(NODE0,U,4)         ; Patient Status of the entry
 ;
 S DA=IBTRIEN,DIE=356.22,DR="[IB CREATE 278 REQUEST SHORT]",IBUPOUT=0
 D ^DIE
 I +$G(IBUPOUT)!$D(Y) I "^01^03^"[(U_$$STATUS^IBTRH2(IBTRIEN)_U) D:$$CLRASK^IBTRH5K() CLRENTRY^IBTRH5K(IBTRIEN)
 D CLEAN^VALM10,INIT^IBTRH6
 Q
 ;
SEND278 ;EP
 ; Protocol action to send the completed brief 278 request
 N IBRESP
 S IBTRENT=1
 S VALMBCK="R"
 D SEND278^IBTRH2
 Q
 ;
HELP ;EP
 ; Protocol Action to display help information
 S X="?"
 D DISP^XQORM1
 W !!
 Q
 ;
EXIT ;EP
 ; Protocol action to exit the worklist
 K ^TMP("IBTRH6",$J)
 D CLEAR^VALM1
 Q
 ;
WRTFLDS ; auto populate some fields in 356.22
 N DA,DIE,DR,DTOUT,DUOUT,DIRUT,RIEN,X,Y
 S RIEN=+$P(NODE0,U,11) I 'RIEN S RIEN=DUZ D CLRCNUM(IBTRIEN)
 S DIE=356.22,DA=IBTRIEN,DR="",DR=".11////"_RIEN
 I $P(NODE2,U)="" D
 .I INPAT,WHICH<3 S DR=DR_";2.01///AR" Q
 .S DR=DR_";2.01///HS"
 .Q
 I $P(NODE2,U,3)="" S DR=DR_";2.03///"_$S(WHICH=1:"1",WHICH=2:"MH",1:"88")
 I 'INPAT S DR=DR_";2.04////B" S:$P(NODE2,U,5)="" DR=DR_";2.05///22;2.06///@;2.07///@"
 I INPAT S DR=DR_";2.04////A" S:$P(NODE2,U,6)="" DR=DR_";2.05///@;2.06////1;2.07////1"
 I $P(NODE2,U,2)="" S DR=DR_";2.02///I"
 I $P(NODE7,U)="" S DR=DR_";7.01///Urgent"
 D ^DIE
 Q
 ;
CLRCNUM(IBTRIEN) ; clear contact numbers in file 356.22
 N FDA,FLD,IENS
 S IENS=IBTRIEN_","
 F FLD=19.01,19.02,19.03,20,21,22 S FDA(356.22,IENS,FLD)="@"
 D FILE^DIE("ET","FDA")
 Q
 ;
WRTCNUM ; auto populate contact numbers in file 356.22
 N CNARY,FDA,FLD,IENS,IENS200,QUAL,RDATA,RIEN,STOPFLG,VALUE,Z
 S RIEN=+$P($G(^IBT(356.22,IBTRIEN,0)),U,11) I 'RIEN Q
 S IENS200=RIEN_"," D GETS^DIQ(200,IENS200,".131;.132;.135;.136",,"RDATA"),GETCNUM(.CNARY)
 ; loop through contact #s in file 200
 S IENS=IBTRIEN_",",STOPFLG=0 F FLD=.135,.132,.136,.131 D  Q:STOPFLG
 .I '$D(CNARY("EMPTY")) S STOPFLG=1 Q  ; no more empty comm. # fields in 356.22
 .S VALUE=$$NOPUNCT^IBCEF($G(RDATA(200,IENS200,FLD)),1) I VALUE=""!($L(VALUE)>10) Q  ; no value to file or value is too long
 .S QUAL=$S(FLD=.136:"FX",1:"TE")
 .I $G(CNARY(QUAL))'="" Q  ; this type of comm # already exists in 356.22
 .S Z=$O(CNARY("EMPTY",""))
 .K FDA S FDA(356.22,IENS,$P(Z,U))=QUAL D FILE^DIE("E","FDA")
 .K FDA S FDA(356.22,IENS,$P(Z,U,3))=VALUE D FILE^DIE("E","FDA")
 .K CNARY("EMPTY",Z) S CNARY(QUAL)=VALUE
 .Q
 Q
 ;
GETCNUM(CNARY) ; get contact numbers from file 356.22
 ; CNARY - array of results, passed by reference
 ;
 N QUAL,VALUE,Z
 S CNARY=0 F Z="19.01^2^20","19.02^3^21","19.03^4^22" D
 .S QUAL=$$EXTERNAL^DILFD(356.22,$P(Z,U),,$P(NODE19,U,$P(Z,U,2)))
 .S VALUE=$G(^IBT(356.22,IBTRIEN,$P(Z,U,3)))
 .I QUAL'="",VALUE'="" S CNARY(QUAL)=VALUE Q
 .S CNARY("EMPTY",Z)=""
 .Q
 Q
 ;
NEWSL(IBTRIEN) ; create new entry in service line multiple (356.2216) if no entries are there
 ; IBTRIEN - ien of the entry in file 356.22
 ;
 N DA,DD,DIC,DO,DINUM,DLAYGO,DTOUT,DUOUT,RES,X,Y
 S RES=0 I '+$G(IBTRIEN) G NEWSLX
 S RES=1 I '$D(^IBT(356.22,IBTRIEN,16,1)) D
 .S DA(1)=IBTRIEN,DLAYGO=356.2216,DIC(0)="L",DIC="^IBT(356.22,"_DA(1)_",1,",X=1
 .D FILE^DICN S RES=+Y K DD,DO
 .Q
NEWSLX ;
 Q RES
