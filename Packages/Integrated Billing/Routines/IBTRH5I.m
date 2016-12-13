IBTRH5I ;ALB/FA - HCSR Create 278 Request ;18-NOV-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ; Contains Entry points and functions used in creating a 278 request from a
 ; selected entry in the HCSR Response worklist
 ;
 ; --------------------------   Entry Points   --------------------------------
 ; COMQUAL      - Dictionary screen for Requester Contact Qualifier fields
 ; CONTINFO     - Retrieves Contact related information
 ; CRT278       - Allows the user to create a new 278 request for the selected
 ;                entry in the HCSR Response worklist
 ; PERSON       - Determines if the specified Provider is a Person or Non/Person
 ; PDATA        - Retrieves the specified Provider's NPI and taxonomy numbers
 ; REFDATA      - Retrieves the Previous Authorization and Reference Numbers for
 ;                the specified entry.
 ; REQMISS      - Checks for missing required fields in a request 
 ; SEND278      - Prompts the user to send a brief 278 transmission
 ; SVCTYPE      - Dictionary Screen for Service Type 2.03 and 356.2216,.03
 ; TIMEPDQ      - Dictionary Screen for Time Period Qualifier, 4.05
 ; UDREASN      - Dictionary Screen for UMO Denial Reasons
 ;-----------------------------------------------------------------------------
 ;
CONTINFO(IBTRIEN,CNARY) ;EP
 ; Retrieves Contact related information for the specified entry
 ; Input:   IBTRIEN - IEN of the entry to retrieve information from
 ; Output:  CNARY   - Array of populated information
 N NODE19,QUAL,Z
 S NODE19=$G(^IBT(356.22,IBTRIEN,19))
 F Z="19.01^2^20","19.02^3^21","19.03^4^22" D
 . S QUAL=$$EXTERNAL^DILFD(356.22,$P(Z,"^",1),,$P(NODE19,"^",$P(Z,"^",2)))
 . I QUAL'="" S CNARY(QUAL)=$G(^IBT(356.22,IBTRIEN,$P(Z,"^",3)))
 Q
 ;
SEND278() ;EP
 ; Called from the input template to allow the user to send a brief 278 request
 ; transmission, continue answering all questions in the template or skip to 
 ; Service level information
 ; Input: None
 ; Returns: 0       - User either wants to send a brief 278 or exit the input
 ;                    template
 ;          255     - User tried to field jump
 ;          1       - User wants to continue entering info
 ;          1400    - User wants to skip to Service Detail Information
 I +$P($G(^IBT(356.22,DA,16,0)),U,4) Q 1  ; data already entered for service lines.  don't let them use short cut to send.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,SEL,XX
 S XX="^Y:YES;N:NO;S:SKIP"
 S DIR(0)="SAO"_XX,DIR("A")="Send 278 Request w/o Additional Info? "
 S XX="Select YES to transmit a basic 278 Request now.  Select No to enter"
 S XX=XX_" additional data before transmitting the 278 Request. Enter S to"
 S XX=XX_" skip to Service Line Detail."
 S DIR("?")=XX
 D ^DIR
 I X?1"^"1.E D JUMPERR^IBTRH5H Q "@260"
 S Y=$S($D(DUOUT):0,Y="Y":0,Y="N":"@270",Y="S":"@1400",1:"@270")
 Q Y
 ;
SVCTYPE()   ;EP
 ; Dictionary Screen function called from fields: 2.03 and 356.2216,.03
 ; Screens some specific entries from 365.013
 ; Input:   DA      - IEN of the 356.22 entry being edited
 ;          Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 N CDE,IEN,IENS
 ; First Get all of IENS that we want to filter out
 F CDE=9,10,13,19,22,30,32,34,41,43,47,48,49,50,51,52,53,55,57,58,59,60,81,89 D
 . S IEN=$O(^IBE(365.013,"B",CDE,""))
 . S:IEN'="" IENS(IEN)=""
 F CDE=90,81,91,92,94,95,96,97,98,99,"A0","A1","A2","A3","A5","A7","A8","AA","AB" D
 . S IEN=$O(^IBE(365.013,"B",CDE,""))
 . S:IEN'="" IENS(IEN)=""
 F CDE="AC","AH","AM","AN","AO","AQ","B2","B3","BA","BH","BI","BJ","BK","BM","BR" D
 . S IEN=$O(^IBE(365.013,"B",CDE,""))
 . S:IEN'="" IENS(IEN)=""
 F CDE="BT","BU","BV","BW","BX","CA","CB","CC","CD","CE","CF","CG","CH","CI" D
 . S IEN=$O(^IBE(365.013,"B",CDE,""))
 . S:IEN'="" IENS(IEN)=""
 F CDE="CJ","CK","CL","CM","CN","CO","CP","DG","DM","DS","GF","GN","UC" D
 . S IEN=$O(^IBE(365.013,"B",CDE,""))
 . S:IEN'="" IENS(IEN)=""
 Q:$D(IENS(Y)) 0
 Q 1
 ;
UDREASN(FIELD)   ;EP
 ; Dictionary Screen function called from fields: 356.2215,.03, 356.2215,.04
 ; 356.2215,.05, 356.2215,.06.
 ; Prevents Duplicate UMO Denial Reasons
 ; Input:   FIELD   - Field being checked
 ;          DA(1)   - IEN of the 356.22 entry being edited
 ;          DA      - IEN of the UMO multiple
 ;          Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 N NDE,RET,Z
 S RET=1     ; Assume Valid Input
 Q:Y="" 1    ; No value entered
 S NDE=$G(^IBT(356.22,DA(1),15,DA,0))
 ; Make sure there are no duplicates
 I FIELD=.03 D  Q RET
 . F Z=4,5,6 D CHK(Z)
 I FIELD=.04 D  Q RET
 . F Z=3,5,6 D CHK(Z)
 I FIELD=.05 D  Q RET
 . F Z=3,4,6 D CHK(Z)
 I FIELD=.06 D  Q RET
 . F Z=3,4,5 D CHK(Z)
 Q RET
 ;
CHK(NUM) ;
 I $P(NDE,"^",NUM)=Y S RET=0 Q 
 Q
 ;
TIMEPDQ()   ;EP
 ; Dictionary Screen function called from Time Period Qualifier, fields: 4.05,
 ; 356.2216/5.05
 ; Screens some specific entries from 365.015
 ; Input:   DA      - IEN of the 356.22 entry being edited
 ;          Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 N CDE,IEN,IENS
 ; First Get all of IENS that we want to filter out
 F CDE=13,22,23,24,25,28,30,31,32,33,36 D
 . S IEN=$O(^IBE(365.015,"B",CDE,""))
 . S:IEN'="" IENS(IEN)=""
 Q:$D(IENS(Y)) 0
 Q 1
 ;
PDATA(PROV) ; EP
 ; Retrieves the NPI and Taxonomy codes for the requested Provider
 ; PROV     - Provider to retrieve codes for
 ; Output:  NPI^Taxonomy number
 N XX,ZZ
 S ZZ=$$PRVDATA^IBTRHLO2(+$P(PROV,";",1),$P($P(PROV,"(",2),",",1))
 S XX=$$GTXNMY^IBTRH3(PROV)
 S XX=$P(XX,"^",1)_"^"_$P(ZZ,"^",7)
 Q XX
 ;
REFDATA(IBTRIEN)    ;EP
 ; Input:   IBTRIEN - IEN of the entry being checked
 N REFINFO,RIEN,XX
 S XX=$G(^IBT(356.22,IBTRIEN,0)),REFINFO=""
 S RIEN=$P(XX,"^",19)
 Q REFINFO
 ;
REQMISS(IBTRIEN,IBEXIT) ;EP
 ; Checks to see if all required fields in the request
 ; been answered and the user did not '^' the input template
 ; Input:   IBTRIEN - IEN of the entry being checked
 ;          IBEXIT  - 0 if user '^' exited the template, 1 otherwise
 ; Returns: 0 if all required fields have been entered and no '^' exit
 ;          1 if missing required fields and/or '^' exit.  All missing fields
 ;            will be displayed in a warnings message.
 N CTC,IENS,MISSING,XX,YY,YY1,YY2,TYPE
 S MISSING=0,IENS=IBTRIEN_","
 I $$GET1^DIQ(356.22,IENS,2.01,"I")="" D
 . D MISSING("Request Category","Request Category is required and does not have a value entered.")
 S CTC=$$GET1^DIQ(356.22,IENS,2.02,"I") I CTC="" D
 . D MISSING("Certification Type Code","Certification Type Code is required and does not have a value entered.")
 S XX=$O(^IBT(356.22,IBTRIEN,16,0))  ; Check for a service line
 I XX="" D
 . I $$GET1^DIQ(356.22,IENS,2.03,"I")="" D  ; No Service Line and No Service Type
 .. D MISSING(2.03,"Service Type is required if no Service Lines were entered.")
 . S TYPE=$$GET1^DIQ(356.22,IENS,2.04,"I") I TYPE="" D  ; No Service Line(s) and no Facility Type Qualifier
 .. D MISSING(2.04,"Service Location Qualifier is required if no Service Lines are entered.")
 . I TYPE'="A",$$GET1^DIQ(356.22,IENS,2.05,"I")="" D  ; No Service Line(s) and no Facility Type
 .. D MISSING(2.05,"Service Location is required if no Service Lines are entered.")
 . I TYPE="A" D
 .. I $$GET1^DIQ(356.22,IENS,2.06,"I")="" D MISSING(2.06,"Location of Care is required if no Service Lines are entered and Facility Type is 'A'")
 .. I $$GET1^DIQ(356.22,IENS,2.07,"I")="" D MISSING(2.07,"Bill Classification is required if no Service Lines are entered and Facility Type is 'A'")
 ;
 D REQMISS^IBTRH5J ;additional required fields checking 12/11/14 JWS
 ;
 ; If Home Health Care Information Home Health Start date is entered, then
 ; Prognosis must be defined and we must have a Principal Diagnosis and Date.
 I $$GET1^DIQ(356.22,IENS,10.01,"I")'="" D
 . I $$GET1^DIQ(356.22,IENS,2.15,"I")="" D
 .. S MISSING=MISSING+1
 .. S XX="Prognosis is required if Home Health Start Date is defined."
 .. S MISSING("Prognosis")=XX
 . I '$D(^IBT(356.22,IBTRIEN,3)) D MISSING("Diagnosis","A Principal Diagnosis and Date must be entered for Home Health Care service.")
 ; Check for Diagnosis values
 I $D(^IBT(356.22,IBTRIEN,3)) D DIAGMISS(IBTRIEN,.MISSING)
 ; Check for a Procedure on every Service line
 I $D(^IBT(356.22,IBTRIEN,16)) D SVCMISS(IBTRIEN,.MISSING)
 ; Check for Attending Physician line for Inpatient entries
 D ATTMISS(IBTRIEN,.MISSING)
 ; User completed the entire template and no require fields are missing
 I IBEXIT,'MISSING Q 0
 W !!
 I 'IBEXIT D
 . W !,*7,"'^' exit from the template has been detected. You must complete"
 . W !,"the entire 278 request before sending it. Currently entered information"
 . W !,"has been saved. Use the SR action to finish entering data to send the request."
 I MISSING D
 . W !!,*7,"The following required fields are missing or incorrect:"
 . S XX=""
 . F  D  Q:XX=""
 .. S XX=$O(MISSING(XX))
 .. Q:XX=""
 .. I MISSING(XX)="" W !,XX Q
 .. N TEXT,XX1
 .. D FSTRNG^IBJU1(MISSING(XX),76,.TEXT)
 .. S XX1="" F  S XX1=$O(TEXT(XX1)) Q:XX1=""  W !,TEXT(XX1)
 .. ;W !,MISSING(XX)
 . I IBEXIT D
 .. W !!,"A 278 request cannot be sent with missing required fields."
 .. I $G(IBTRENT)=1 W !,"Use the AD action to enter required data" Q
 .. W !,"Currently entered information has been saved. Use the SR action to finish"
 .. W !,"entering data to send the request."
 Q 1
 ;
DIAGMISS(IBTRIEN,MISSING)   ; Checks for Diagnosis information when Home Health
 ; Start Date been defined
 ; Input:   IBTRIEN - IEN of the entry being checked
 ;          MISSING - Current array and count of missing required fields
 ; Output:  MISSING - Updated array and count of missing required fields
 ; Note:    Only called if the Prognosis code (2.03) has a value
 N DXCODE,DXDATE,DXTYPE,XX,YY,XX1,START
 S XX=0,START=$O(^IBT(356.22,IBTRIEN,3,0))
 F  S XX=$O(^IBT(356.22,IBTRIEN,3,XX)) Q:XX'=+XX  D
 . S DXTYPE=$$GET1^DIQ(356.223,XX_","_IBTRIEN_",",.01,"I")
 . S DXCODE=$$GET1^DIQ(356.223,XX_","_IBTRIEN_",",.02,"I")
 . S DXDATE=$$GET1^DIQ(356.223,XX_","_IBTRIEN_",",.03,"I")
 . I DXTYPE="" D
 .. I XX=START,$$GET1^DIQ(356.22,IENS,10.01,"I")'="" S XX1="Diagnosis entry number "_XX_" Diagnosis Type must be defined if Home Health Start Date is defined."
 .. E  S XX1="Diagnosis entry number "_XX_" Diagnosis Type is required."
 .. S MISSING=MISSING+1,MISSING("Diagnosis Type "_XX)=XX1
 . I DXCODE="" D
 .. I XX=START,$$GET1^DIQ(356.22,IENS,10.01,"I")'="" S XX1="Diagnosis entry number "_XX_" Diagnosis Code must be defined if Home Health Start Date is defined."
 .. E  S XX1="Diagnosis entry number "_XX_" Diagnosis Code is required."
 .. S MISSING=MISSING+1,MISSING("Diagnosis Code "_XX)=XX1
 . I DXDATE="",XX=START,$$GET1^DIQ(356.22,IENS,10.01,"I")'="" D
 .. S XX1="Diagnosis Date Known must be defined if Home Health Start Date is defined."
 .. S MISSING=MISSING+1,MISSING("Diagnosis Date Known "_XX)=XX1
 . I DXTYPE'="",DXTYPE'=3,DXTYPE'=7,XX=START,$$GET1^DIQ(356.22,IENS,10.01,"I")'="" D
 .. S YY=$$GET1^DIQ(356.223,XX_","_IBTRIEN_",",.01)
 .. S XX="Diagnosis Type: '"_YY_"' must be 'Principal Diagnosis'"
 .. S MISSING=MISSING+1,MISSING("Diagnosis Type")=XX
 Q
 ;
SVCMISS(IBTRIEN,MISSING)    ; Checks for a Procedure code on every Service Line
 ; Input:   IBTRIEN - IEN of the entry being checked
 ;          MISSING - Current array and count of missing required fields
 ; Output:  MISSING - Updated array and count of missing required fields
 N PCODE,PTYP,SIEN,XX,YY,TYPE,REV,UNIT,COUNT
 S SIEN=0
 F  D  Q:+SIEN=0
 . S SIEN=$O(^IBT(356.22,IBTRIEN,16,SIEN))
 . Q:+SIEN=0
 . S YY="Service Line #"_$$SLINE(IBTRIEN,SIEN)
 . S PTYPE=$$GET1^DIQ(356.2216,SIEN_","_IBTRIEN_",",1.01,"I")
 . I PTYPE="N4" S PCODE=$$GET1^DIQ(356.2216,SIEN_","_IBTRIEN_",",12.01,"I")
 . E  S PCODE=$$GET1^DIQ(356.2216,SIEN_","_IBTRIEN_",",1.02,"I")
 . S TYPE=$$GET1^DIQ(356.2216,SIEN_","_IBTRIEN_",",1.12,"I")
 . S REV=$$GET1^DIQ(356.2216,SIEN_","_IBTRIEN_",",2.06,"I")
 . I PTYPE="" D
 .. I TYPE="I",REV'="" Q  ; for Institutional Lines, Service Line Revenue Code may be used instead of Proc Code
 .. S XX=YY_" is missing the Procedure Coding Method"
 .. S MISSING=MISSING+1,MISSING(YY_" A")=XX
 . I PCODE="" D
 .. I TYPE="I",REV'="" Q  ; for Institutional Lines, Service Line Revenue Code may be used instead of Proc Code
 .. S XX=YY_" is missing the Procedure Code"
 .. S MISSING=MISSING+1,MISSING(YY_" B")=XX
 . I TYPE'="D" D  ;Dental lines do not have Unit Count or Unit Measurement Indicator
 .. S UNIT=$$GET1^DIQ(356.2216,SIEN_","_IENS,1.1),COUNT=$$GET1^DIQ(356.2216,SIEN_","_IENS,1.11)
 .. I (UNIT=""&(COUNT'=""))!(UNIT'=""&(COUNT="")) D  ;If either Unit Measurement Code or Service Unit Count exist, both are required
 ... I UNIT="" D MISSING(YY_" C",YY_" is missing the Units Count measurement indicator.") Q
 ... D MISSING(YY_" D",YY_" is missing the Unit Count for the service.")
 . S UNIT=$$GET1^DIQ(356.2216,SIEN_","_IENS,5.01),COUNT=$$GET1^DIQ(356.2216,SIEN_","_IENS,5.02)
 . I (UNIT=""&(COUNT'=""))!(UNIT'=""&(COUNT="")) D  ;If either HCSD Quant Qual or HCSD Serv Unit Count exits, both are required
 .. I UNIT="" D MISSING(YY_" E",YY_" is missing the HCSD Quantity Qualifier for this service line.") Q
 .. D MISSING(YY_" F",YY_" is missing the HCSD Service Unit Count for this service line.")
 . I $$GET1^DIQ(356.2216,SIEN_","_IENS,5.05)="",$$GET1^DIQ(356.2216,SIEN_","_IENS,5.06)'="" D
 .. D MISSING(YY_" G",YY_" is missing the HCSD Time Period Qualifier value that describes the HCSD Perdio Count.")
 . I $D(^IBT(356.22,IBTRIEN,16,SIEN,4)) D
 .. N TOO
 .. S TOO=0 F  S TOO=$O(^IBT(356.22,IBTRIEN,16,SIEN,4,TOO)) Q:TOO'=+TOO  D
 ... I $$GET1^DIQ(356.22164,TOO_","_SIEN_","_IENS,.01)="" D MISSING(YY_" Tooth "_TOO,YY_" Tooth multiple "_TOO_" is missing the required Tooth Code.")
 . I $D(^IBT(356.22,IBTRIEN,16,SIEN,6)) D
 .. N AT
 .. S AT=0 F  S AT=$O(^IBT(356.22,IBTRIEN,16,SIEN,6,AT)) Q:AT'=+AT  D
 ... I $$GET1^DIQ(356.22166,AT_","_SIEN_","_IENS,.01)="" D MISSING(YY_" Attachments .01"_AT,YY_" Attachment multiple "_AT_" is missing the required Report Type Code.")
 ... I $$GET1^DIQ(356.22166,AT_","_SIEN_","_IENS,.02)="" D MISSING(YY_" Attachments .02"_AT,YY_" Attachment multiple "_AT_" is missing the required Report Transmission Code.")
 Q
 ;
SLINE(IBTRIEN,SIEN) ; Returns the Service line number for a line
 ; Input:   IBTRIEN - IEN of the entry being checked
 ;          SIEN    - IEN of the service line being checked
 ; Returns: Service line number
 N CNT,IEN
 S (CNT,IEN)=0
 F  D  Q:+IEN=0!(SIEN=IEN)
 . S IEN=$O(^IBT(356.22,IBTRIEN,16,IEN))
 . Q:+IEN=0
 . S CNT=CNT+1
 Q CNT
 ;
ATTMISS(IBTRIEN,MISSING)   ; Checks for an Attending Physician multiple for
 ; inpatient entries
 ; Input:   IBTRIEN - IEN of the entry being checked
 ;          MISSING - Current array and count of missing required fields
 ; Output:  MISSING - Updated array and count of missing required fields
 N DXCODE,DXDATE,DXTYPE,FOUND,IEN,XX,YY
 Q:$$GET1^DIQ(356.22,IBTRIEN_",",.04,"I")="O"   ; Outpatient entry
 S (FOUND,IEN)=0
 F  D  Q:+IEN=0!FOUND
 . S IEN=$O(^IBT(356.22,IBTRIEN,13,IEN))
 . Q:+IEN=0
 . S XX=$$GET1^DIQ(356.2213,IEN_","_IBTRIEN_",",.01,"I")
 . S XX=$$GET1^DIQ(365.022,XX_",",.01,"I")
 . Q:XX'=71
 . S:$$GET1^DIQ(356.2213,IEN_","_IBTRIEN_",",.03,"I")'="" FOUND=1
 Q:FOUND
 ;
 S XX="Attending Physician must be defined for inpatient entries"
 S MISSING=MISSING+1,MISSING("Attending Physician")=XX
 Q
 ;
PERSON(PROV)   ;EP
 ; Checks to see if the specified Provider Type PTYPE is a Person or Non-Person
 ; Input:   PROV    - IEN of the Provider
 ; Output:  1 if PROV is a Person, 2 - Otherwise
 N PTYPE,XX
 S XX=$P(PROV,";",2)                            ; What file is it filed in?
 I XX="VA(200," Q 1
 I XX="DIC(4," Q 2
 S XX=$P(PROV,";",1)
 S PTYPE=$$GET1^DIQ(355.93,XX_",",.02,"I")
 Q:PTYPE=2 1
 Q 2
 ;
CRT278(IBTRIEN) ;EP
 ; Creates a 278 Request for the selected worklist event
 ; Input:   IBTRIEN     - Internal IEN of the selected event
 ; Output:  278 Request created for the selected worklist event.
 ; Returns: 1 - if the user exited 'normally', 0 if user '^' exited
 N CNARY,DA,DIE,DFN,DR,DTOUT,IBBACK,IBCCAT,IBCERTCD,IBDISDT,IBDXCTR,IBEVDT
 N IBEXIT,IBFILT,IBMLN,IBNEW,IBOXYET,IBREQCAT,IBRESP,IBPSTAT,IBSSTYP,IBSTYP,IBTEMP
 N IBUPOUT,NODE19,PATLINE,VADM,X,XX,XX2,Y,YY,Z
 ; New special effects characters
 N IOHTS,IOHUP,IOICH,IOIND,IOINH,IOINLOW,IOINORM,IOINSERT,IOIRM0,IOIRM1
 N IOKP0,IOKP1,IOPK2,IOPK3,IOKP4,IOKP5,IOREMOVE,IORESET,IORLF,IORVOFF,IORVON
 N IOSC,IOSELECT,IOSGR0,IOSMPLX,IOSTBM,IOSWL,IOTBC,IOTBCALL,IOUOFF,IOUON,IOUPAR
 S DA=IBTRIEN,DIE=356.22,DR="[IB ADD/EDIT 278]",IBUPOUT=0
 S NODE19=$G(^IBT(356.22,IBTRIEN,19))
 ; Set-up special effects characters (next 3 lines)
 D HOME^%ZIS
 S X="IORVON;IORVOFF"
 D ENS^%ZISS
 D FULL^VALM1
 ; Set up Patient Data line
 S DFN=$$GET1^DIQ(356.22,IBTRIEN_",",.02,"I")
 S Z=""
 I +$G(DFN) D
 . D DEM^VADPT
 . S PATLINE="Patient: "_$E(VADM(1),1,28),Z=Z_$J("",35-$L(Z))_$P(VADM(2),"^",2)
 . S PATLINE=PATLINE_"    DOB: "_$P(VADM(3),"^",2)_"    AGE: "_VADM(4)
 W @IOF
 ; Set 'in-progress mark'
 I $$STATUS^IBTRH2(IBTRIEN)="0" D PRMARK1^IBTRH1(IBTRIEN,"01")
 ; Set Initial Values
 S IBRESP=$P($G(^IBT(356.22,IBTRIEN,0)),"^",18)         ; 1 - Created from Response
 S IBOXYET=$$OXYET^IBTRH5C(IBTRIEN)                     ; Oxygen Equip Type 'D' or 'E'
 S IBPSTAT=$$GET1^DIQ(356.22,IBTRIEN_",",.04,"I")       ; Patient Status of the entry
 S IBEVDT=$$GET1^DIQ(356.22,IBTRIEN_",",.07,"I")        ; Internal Event Date, which may be a range.
 S IBDISDT=$P(IBEVDT,"-",2)                             ; Grab second "-" piece for Discharge Date.
 S IBEVDT=$P(IBEVDT,"-",1)                              ; Grab first "-" piece for Event Date.
 I IBPSTAT="I" D
 . I IBDISDT'="" S IBDISDT=$$FMTE^XLFDT(IBDISDT,"5Z") Q
 . S IBDISDT=$$GET1^DIQ(356.22,IBTRIEN_",",2.22,"I")
 . I IBDISDT'="" S IBDISDT=$$FMTE^XLFDT(IBDISDT,"5Z") Q
 . ; Attempt to pull discharge date from Patient Movement file.
 . N VAIP
 . S VAIP("D")=IBEVDT
 . D IN5^VADPT
 . S IBDISDT=$G(VAIP(17,1))
 . I IBDISDT="" Q
 . S IBDISDT=$$FMTE^XLFDT(IBDISDT,"5Z")
 S IBEVDT=$$FMTE^XLFDT(IBEVDT,"5Z")                     ; Format Event Date
 K DUOUT
 D ^DIE
 S XX=$S(IBUPOUT:0,$D(Y):0,1:1)                         ; Detect '^' exit
 I 'XX,"^01^03^"[(U_$$STATUS^IBTRH2(IBTRIEN)_U) D:$$CLRASK^IBTRH5K() CLRENTRY^IBTRH5K(IBTRIEN)
 Q XX
 ;
COMQUAL()   ;Function EP for Screening Communication Qualifier fields
 ; This Function is called from the 356.22 Dictionary Communication Qualifier fields.
 ; These fields include the following:
 ;              356.22 - 19.01, 19.02, 19.03
 ;              356.2213 - .07, .08, .09
 ;              356.22168 - .07, .08, .09              
 ; Screens some specific entries from 365.021
 ; Input:   DA      - IEN of the 356.22 entry being edited
 ;          Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 N CDE,IEN,IENS
 ; First Get all of IENS that we want to filter out
 F CDE="ED","HP","WP" D
 . S IEN=$O(^IBE(365.021,"B",CDE,""))
 . S:IEN'="" IENS(IEN)=""
 Q:$D(IENS(Y)) 0
 Q 1
 ;
MISSING(SUB,DESC) ; Function to generate MISSING array
 ; Input: SUB - subscript of MISSING array
 ;        DESC - description of error condition
 ; Returns: MISSING  array
 ;
 S MISSING=MISSING+1
 S MISSING(SUB)=DESC
 Q
