IBCNRMFE ;BHAM ISC/DMK - Receive HL7 e-Pharmacy MFE Segment ;23-OCT-2003
 ;;2.0;INTEGRATED BILLING;**251,276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Description
 ;
 ; Receive HL7 e-Pharmacy MFE Segment
 ; Master File Entry
 ;
 ; Prepare for potential subsequent Z** Segment(s)
 ;
 ; Called by IBCNRHLT
 ;
 ; Entry point
 ;
1000 ; Control MFE Segment processing
 D INIT
 Q
 ;
INIT ; Initialize MFE Segment variables
 K DATA,DATAAP,DATACM,ERROR
 N ANAME,FILENO1,KEY
 ;
 S EPHARM=1
 S FILENO=FLN
 ;
 S DATE("NOW")=$$NOW^XLFDT()
 ;
 ; Record-Level Event Code (action)
 ; MAC = Activate
 ; MAD = Add
 ; MDC = Deactivate
 ; MDL = Delete
 ; MUP = Update
 S IBCNACT=$G(IBSEG(2))
 ;
 ; Primary Key Value ID
 S KEY=$P($G(IBSEG(5)),$E(HLECH,1),1)
 ;
 ; Convert HL7 special characters if necessary
 I KEY[$E(HLECH,3) S KEY=$$TRAN1^IBCNRHLU(KEY)
 ;
 I FILENO'=365.12 S IEN=$$LOOKUP1^IBCNRFM1(FILENO,KEY)
 I FILENO=365.12 S IEN=$$LOOKUP3^IBCNRFM1(FILENO,"C",KEY)
 ;
 ; Error?
 ; V100 = Payer ID Undefined
 ; V200 = NCPDP Processor Name Undefined
 ; V300 = Pharmacy Benefits Manager (PBM) Name Undefined
 ; V400 = Plan ID Undefined
 ; V500 = Plan ID Undefined
 I FILE["Pharmacy Plan",IEN=-1 S ERROR="V500" Q
 I IBCNACT'="MAD",IEN=-1 S ERROR=$S(FILENO=365.12:"V100",FILENO=366.01:"V200",FILENO=366.02:"V300",FILENO=366.03:"V400") Q
 ;
 S FIELDNO=$S(FILENO=365.12:1,1:3)
 S FILENO1=$S(FILENO=365.12:365.13,1:FILENO+.1)
 S ANAME="E-PHARM"
 S AIEN=$$LOOKUP1^IBCNRFM1(FILENO1,ANAME)
 I AIEN=-1 S AIEN=$$ADD1^IBCNRFM1(FILENO1,ANAME)
 I IEN'=-1 S APIEN=$$LOOKUP2^IBCNRFM1(FILENO,IEN,FIELDNO,ANAME)
 I IEN=-1 S APIEN=-1
 ;
 ; Error?
 ; V101 = E-PHARM Application Undefined
 ; V201 = E-PHARM Application Undefined
 ; V301 = E-PHARM Application Undefined
 ; V401 = E-PHARM Application Undefined
 ; V501 = E-PHARM Application Undefined
 I IBCNACT'="MAD",APIEN=-1 D  Q
 . S ERROR=$S(FILENO=365.12:"V101",FILENO=366.01:"V201",FILENO=366.02:"V301",FILENO=366.03:"V401")
 . I FILE["Pharmacy" S ERROR="V501"
 ;
 ; MAC = Activate
 I IBCNACT="MAC" D INITMAC
 ;
 ; MAD = Add
 I IBCNACT="MAD" D INITMAD
 ;
 ; MDC = Deactivate
 I IBCNACT="MDC" D INITMDC
 ;
 ; MDL = Delete
 I IBCNACT="MDL" D INITMDL
 ;
 ; MUP = Update
 I IBCNACT="MUP" D INITMUP
 Q
 ;
INITMAD ; Initialize APPLICATION Subfile variables if MAD (Add) action
 ; 365.121 PAYER APPLICATION Subfile
 ; 366.013 NCPDP PROCESSOR APPLICATION Subfile
 ; 366.023 PHARMACY BENEFITS MANAGER (PBM) APPLICATION Subfile
 ; 366.033 PLAN APPLICATION Subfile
 ;
 ; Process MAD (Add) as MAC (Activate)
 D INITMAC
 ;
 ; .03 LOCAL ACTIVE?
 ; Set to INACTIVE for PLAN, all others ACTIVE
 S DATAAP(.03)=$S(FILENO=366.03:0,1:1)
 ;
 ; .04 USER EDITED LOCAL
 S DATAAP(.04)=IDUZ
 ;
 ; .05 DATE/TIME LOCAL EDITED
 S DATAAP(.05)=DATE("NOW")
 ;
 ; .13 DATE/TIME CREATED
 S DATAAP(.13)=DATE("NOW")
 Q
 ;
INITMAC ; Initialize APPLICATION Subfile variables if MAC (Activate) action
 ; 365.121 PAYER APPLICATION Subfile
 ; 366.013 NCPDP PROCESSOR APPLICATION Subfile
 ; 366.023 PHARMACY BENEFITS MANAGER (PBM) APPLICATION Subfile
 ; 366.033 PLAN APPLICATION Subfile
 ;
 ; .02 NATIONAL ACTIVE?
 S DATAAP(.02)=1
 ;
 ; .06 DATE/TIME NATIONAL EDITED
 S DATAAP(.06)=DATE("NOW")
 ;
 ; .11 DEACTIVATED?
 S DATAAP(.11)=0
 ;
 ; .12 DATE/TIME DEACTIVATED
 S DATAAP(.12)="@"
 Q
 ;
INITMDC ; Initialize APPLICATION Subfile variables if MDC (deactivate) action
 ; 365.121 PAYER APPLICATION Subfile
 ; 366.013 NCPDP PROCESSOR APPLICATION Subfile
 ; 366.023 PHARMACY BENEFITS MANAGER (PBM) APPLICATION Subfile
 ; 366.033 PLAN APPLICATION Subfile
 ;
 ; .02 NATIONAL ACTIVE?
 S DATAAP(.02)=0
 ;
 ; .06 DATE/TIME NATIONAL EDITED
 S DATAAP(.06)=DATE("NOW")
 ;
 ; .11 DEACTIVATED?
 S DATAAP(.11)=1
 ;
 ; .12 DATE/TIME DEACTIVATED
 S DATAAP(.12)=DATE("NOW")
 Q
 ;
INITMDL ; Initialize APPLICATION Subfile variables if MDL (Delete) action
 ; 365.121 PAYER APPLICATION Subfile
 ; 366.013 NCPDP PROCESSOR APPLICATION Subfile
 ; 366.023 PHARMACY BENEFITS MANAGER (PBM) APPLICATION Subfile
 ; 366.033 PLAN APPLICATION Subfile
 ;
 ; Process MDL (Delete) as MDC (Deactivate)
 D INITMDC
 Q
 ;
INITMUP ; Initialize APPLICATION Subfile variables if MUP (Update) action
 ; 365.121 PAYER APPLICATION Subfile
 ; 366.013 NCPDP PROCESSOR APPLICATION Subfile
 ; 366.023 PHARMACY BENEFITS MANAGER (PBM) APPLICATION Subfile
 ; 366.033 PLAN APPLICATION Subfile
 Q
