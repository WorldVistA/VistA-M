IBBDOC ;OAK/ELZ - APIS FOR OTHER PACKAGES FOR PFSS - DOCUMENT ;5-AUG-2004
 ;;2.0;INTEGRATED BILLING;**267,260,286,361,384,404**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Documents the calls to the routine IBBAPI.
 ;
INSUR ;(DFN,IBDT,IBSTAT,IBR,IBFLDS)
 ; Function to return patient insurance information
 ; --Input:
 ;   DFN    = patient
 ;   IBDT   = date insured (optional - default is today's date)
 ;   IBSTAT = Insurance Status filter (combinable based on groups below)
 ;      Group 1
 ;          A = Inactive included (Default is active only)
 ;      Group 2
 ;          R = Not reimbursable included (Default is reimbursable only)
 ;          B = Indemnity included (Default is not included)
 ;      Group 3
 ;          P = Prescription coverage required (Default is all coverages)
 ;          O = Outpatient coverage required (Default is all coverages)
 ;          I = Inpatient coverage only (Default is all coverages)
 ;          E = e-Pharmacy billable coverage required, i.e. should have 
 ;            Pharmacy coverage and be able to process e-claims (Default 
 ;            is all coverages)
 ;
 ;   IBR    = Array to return insurance information - passed by reference
 ;   IBFLDS = List of fields to return (1-24) in a comma separated list or "*" for all
 ;
 ; --Output:
 ;   -1     = error occurred (error message passed back in
 ;            IBR("IBBAPI","INSUR","ERROR",x) where x is error number
 ;            between 101 & 111
 ;    0     = No insurance found based on parameters
 ;    1     = Insurance found
 ;
 ;
CIDC  ; (DFN)
 ; Input:    DFN for the patient in question.
 ; Output:   1 = Ask CIDC questions for the specified patient
 ;           0 = Don't ask CIDC questions for the specified patient
 ;
 ; The API will evaluate both a CIDC switch and the patient's insurance
 ; to determine if the CIDC questions should be asked.
 ;
 ; The switch will have three internal values:
 ;    0 = Don't ask any patients
 ;    1 = Ask for patients only with active billable insurance
 ;    2 = Ask for all patients
 ;
 ;
SWSTAT ; ()
 ; Returns the current status of the PFSS On/Off Switch
 ;
 ; Output:   <switch_status>^<status_date/time>
 ; 
 ; <switch_status> will be one of the following:
 ;    0 = OFF
 ;    1 = ON
 ;
GETACCT ; (IBBDFN,IBBARFN,IBBEVENT,IBBAPLR,IBBPV1,IBBPV2,IBBPR1,IBBDG1,IBBZCL,IBBDIV,IBBRAIEN,IBBSURG)
 ; Pass data to IBB for account/visit (ADT) messaging.
 ;
 ; Input:
 ; IBBDFN   = Patient; IEN to file #2 [required]
 ; IBBARFN  = Account Reference; 
 ;            IEN to file #375 or null [required]
 ; IBBEVENT = HL7 Event Code; e.g., "A04" [required]
 ; IBBAPLR  = Calling Application; 
 ;            <routine> or <tag>_;_<routine> 
 ; IBBPV1   = array for PV1 segment data [required]
 ;   IBBPV1(2)  - Patient Class (O=Outpatient;I=Inpatient)
 ;   IBBPV1(3)  - IEN to file #44, or "FEE BASIS"
 ;   IBBPV1(4)  - Appointment Type; IEN to file #409.1
 ;   IBBPV1(7)  - Attending Physician; IEN to file #200
 ;   IBBVP1(9)  - Consulting Physician; IEN to file #200
 ;   IBBPV1(10) - Purpose of Visit; 
 ;                (Scheduling: 1=C&P;2=10-10;3=SV;4=UV)
 ;   IBBPV1(17) - Admitting Physician or Surgeon; 
 ;                IEN to file #200
 ;   IBBPV1(18) - Primary Stop Code; IEN to file #40.7
 ;   IBBPV1(25) - Check-In Date/Time (Scheduling)
 ;   IBBPV1(41) - Credit Stop Code; IEN to file #40.7
 ;   IBBPV1(44) - Admit Date/Time
 ;   IBBPV1(45) - Check-Out Date/Time (Scheduling)
 ;   IBBPV1(50) - Prescription #; IEN to file #52 (Pharmacy)
 ;   IBBPV1(52) - Other Provider; IEN to file #200
 ; IBBPV2   = array for PV2 segment data
 ;   IBBPV2(7)  - Eligibility of Visit; IEN to file #8.1
 ;   IBBPV2(8)  - Expected Admit/Visit Date/Time
 ;   IBBPV2(24) - Appointment Status; 
 ;                (Scheduling:
 ;                 R=Scheduled/Kept;I=Inpatient;
 ;                 NS=No-Show;NSR=No-Show, Rescheduled;
 ;                 CP=Cancelled by Patient;
 ;                 CPR=Cancelled by Patient, Rescheduled;
 ;                 CC=Cancelled by Clinic;
 ;                 CCR=Cancelled by Clinic, Rescheduled;
 ;                 NT=No Action Taken)
 ;   IBBPV2(46) - Date Appointment Made (Scheduling)
 ; IBBPR1   = array for PR1 segment data
 ;   IBBPR1(3)  - Procedure; IEN to file #81
 ;   IBBPR1(4)  - Procedure; free text
 ;   IBBPR1(5)  - Procedure Date/Time
 ;   IBBPR1(6)  - Functional Type;
 ;                (Prosthetics: 
 ;                 O=Home Oxygen;P=Purchasing;
 ;                 I=Stock Issue)
 ;                (Radiology: 
 ;                 ANI=Angio/Neuro/Interventional;
 ;                 CARD=Cardiology Studies;CT=CT Scan;
 ;                 RAD=General Radiology;
 ;                 MRI=Magnetic Resonance Imaging;
 ;                 MAM=Mammography;NM=Nuclear Medicine;
 ;                 US=Ultrasound;VAS=Vascular Lab)
 ;   IBBPR1(11) - Surgeon; IEN to file #200
 ;   IBBPR1(16) - <modifier>;<modifier>;<modifier>;... 
 ;                where each <modifier> is an IEN to file #81.3
 ; IBBDG1   = array for DG1 segment data
 ;   IBBDG1(n,3) - Diagnosis; IEN to file #80
 ;   IBBDG1(1,4) - Diagnosis; free text; only one allowed
 ;   IBBDG1(n,6) - Diagnosis Type; (A=Admitting;
 ;                                  W=Working;
 ;                                  D=Discharge;
 ;                                  F=Final)
 ; IBBZCL   = array for ZCL segment data
 ;   IBBZCL(n,2) - Classification Type; 
 ;                 (1=AO;2=IR;3=SC;4=EC;5=MST;6=HNC;
 ;                  7=CV;8=SHAD)
 ;   IBBZCL(n,3) - Classification Value; (1=YES;0=NO)
 ; IBBDIV   = IEN to file #40.8
 ; IBBRAIEN = IEN to file #75.1
 ; IBBSURG  = array for special Surgery data
 ;   IBBSURG(1) - Surgical Case #; IEN to file #130
 ;   IBBSURG(2) - Surgical Specialty; IEN to file #45.3
 ;
 ; Returns the pointer to the PFSS ACCOUNT file (#375) where 
 ; all application input data is stored.
 ;
 ; Output:  IEN to file #375, or 0, if unsuccessful
 ; 
GETCHGID ; ()
 ; Returns a Unique Charge ID.
 ;
 ; Output: 1 + current value of field #2 of file #372.
 ;
CHARGE ; (IBBDFN,IBBARFN,IBBCTYPE,IBBUCID,IBBFT1,IBBPR1,IBBDG1,IBBZCL,IBBRXE,IBBORIEN,IBBPROS)
 ; Pass data to IBB for charge (DFT) messaging.
 ;
 ; Input:
 ; IBBDFN   = Patient; IEN to file #2 [required]
 ; IBBARFN  = Account Reference; IEN to file #375 [required]
 ; IBBCTYPE = Charge Type; (CG=debit;CD=credit) [required]
 ; IBBUCID  = Unique Charge ID [required]
 ; IBBFT1   = array for FT1 segment data [required]
 ;   IBBFT1(4)  - Transaction Date/Time
 ;   IBBFT1(7)  - Pharmacy Service Code
 ;   IBBFT1(10) - Transaction Quantity
 ;   IBBFT1(13) - Department Code
 ;   IBBFT1(16) - Patient Location; IEN to file #44
 ;   IBBFT1(18) - Patient Status; (Pharmacy: 1=Rx Copay Exempt;
 ;                                           0=Not Exempt)
 ;   IBBFT1(20) - Rendering Provider; IEN to file #200
 ;   IBBFT1(21) - Ordering Provider; IEN to file #200
 ;   IBBFT1(22) - Unit Cost
 ;   IBBFT1(29) - <NDC>;<generic_name>
 ;   IBBFT1(31) - Transaction Type; 
 ;                (Pharmacy: 1=PSO NSC Rx Copay;
 ;                           2=PSO SC Rx Copay;
 ;                           3=PSO NSC Rx Copay Cancel
 ;                           4=PSO NSC Rx Copay Update
 ;                           5=PSO SC Rx Copay Cancel
 ;                           6=PSO SC Rx Copay Update)
 ; IBBPR1   = array for PR1 segment data;
 ;            (required except Pharmacy)
 ;   IBBPR1(3)    - Procedure; IEN to file #81
 ;   IBBPR1(4)    - Procedure; free text
 ;   IBBPR1(5)    - Procedure Date/Time
 ;   IBBPR1(6)    - Functional Type; 
 ;                  (Prosthetics: O=Home Oxygen;
 ;                                P=Purchasing;
 ;                                I=Stock Issue)
 ;   IBBPR1(11,1) - Surgeon; IEN to file #200
 ;   IBBPR1(11,2) - Attending Surgeon; IEN to file #200
 ;   IBBPR1(16)   - <modifier>;<modifier>;<modifier>;...;
 ;                  each <modifier> is an IEN to file #81.3
 ; IBBDG1   = array for DG1 segment data
 ;   IBBDG1(n,3) - Diagnosis; IEN to file #80
 ;   IBBDG1(n,6) - Diagnosis Type; (A=Admitting;W=Working;
 ;                                  D=Discharge;F=Final)
 ; IBBZCL   = array for ZCL segment data
 ;   IBBZCL(n,2) - Classification Type; 
 ;                 (1=AO;2=IR;3=SC;4=EC;5=MST;
 ;                  6=HNC;7=CV;8=SHAD)
 ;   IBBZCL(n,3) - Classification Value; (1=YES;0=NO)
 ; IBBRXE   = data for RXE segment data (Pharmacy only)
 ;   IBBRXE(1)  - <quantity>_;_<days_supply>
 ;   IBBRXE(17) - Refills Dispensed
 ;   IBBRXE(18) - Release Date/Time
 ;   IBBRXE(31) - DEA, Special Handling codes
 ; IBBPROS  = array for special Prosthetics data
 ;   IBBPROS(1) - Vendor; IEN to file #440
 ;   IBBPROS(2) - OBL#
 ;
 ; Returns success indicator.
 ;
 ; Output: 1, if successful; 0 otherwise
 ;
SETACCT ; (IBBDFN,HLMTIENS)
 ; Store visit/account # from external billing system in PFSS
 ; ACCOUNT record; the file #375 record is found based on data
 ; contained in the HL7 message referenced by HLMTIENS.
 ; Most of the ADT messages involved originate in VistA and 
 ; are returned by the external billing system with visit#
 ; attached.
 ; Some ADT-A01 messages originate in the external billing
 ; system; these cause a new record to be created in file #375.
 ; 
 ; Input:
 ; IBBDFN   = Patient; IEN to file #2 [required]
 ; HLMTIENS = HL7 Message (standard VistA HL7 variable); 
 ;            IEN to file #773 [required]
 ;
 ; Returns PFSS Account Reference.
 ;
 ; Output: IEN to file #375
 ;
EXTNUM ; (IBBDFN,IBBARFN)
 ; Obtain the visit/account # of the external billing system
 ; that has been associated with the PFSS ACCOUNT file (#375)
 ; record.
 ; 
 ; Input:
 ; IBBDFN   = Patient; IEN to file #2 [required]
 ; IBBARFN  = Account Reference; IEN to file #375 [required]
 ;
 ; Returns the value of field #.02 from the file #375 record.
 ;
 ; Output: external visit/account #, or 0, if unsuccessful
 ;
