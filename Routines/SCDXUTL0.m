SCDXUTL0 ;ALB/ESD - Generic functions for Amb Care HL7 Interface ; 5/31/05 11:23am
 ;;5.3;Scheduling;**44,55,69,77,85,110,122,94,66,132,180,235,256,258,325,451,441,562**;Aug 13, 1993;Build 7
 ;
 ; This routine contains functions used with the Ambulatory Care
 ; Reporting Project (ACRP).
 ;
MTI(DFN,DATE,EC,AT,SDOE) ;Calculate Means Test Indicator
 ;
 ;    Input:     DFN   =  Patient IEN
 ;               Date  =  Encounter Date/Time
 ;               EC    =  Eligibility (Code) of Encounter
 ;               AT    =  Appointment Type of Encounter
 ;               SDOE  =  Outpatient Encounter IEN
 ;
 ;   Output:     MTI   =  Means Test Indicator
 ;
 N MT,MTI,SDVD1,SDINPT,SDANS,SDANS1,SDINPT,SDMT,VET,X
 S MTI=""
 S DFN=$G(DFN),DATE=$G(DATE),EC=$G(EC),AT=$G(AT),SDOE=$G(SDOE)
 I (DFN="")!(DATE="")!(EC="")!(EC=0)!(AT="")!(SDOE="") G MTQ
 ;
 ;SD*562 check for other possible invalid Eligibility codes
 I $L(EC)>2!(EC="-1") G MTQ
 ;
 ;- VA Code (get from MAS Eligibility Code IEN)
 S X=$G(^DIC(8.1,$P($G(^DIC(8,+EC,0)),"^",9),0))
 S EC=$P(X,"^",4),VET=$P(X,"^",5)
 ;- Non-Veteran
 I $P($G(^DPT(DFN,"VET")),"^")="N"!(VET="N") S MTI="N" G MTQ
 ;- Dom patient
 I EC=6 S MTI="X" G MTQ
 ;- Inpatient status
 S SDVD1=DATE D INPT^SDOPC1 I SDMT="X0" S MTI="X" G MTQ
 ;- Service Connected > 50 %
 I EC=1 S MTI="AS" G MTQ
 ;-- Service Connected < 50 %
 I EC=3,$$SC^DGMTR(DFN) D  I MTI'="" G MTQ
 .; 'AS' if seen for SC condition
 .I $P($G(^SDD(409.42,+$O(^SDD(409.42,"AO",+SDOE,3,0)),0)),U,3) S MTI="AS"
 ;-Military Disability Retiree
 ;S X=$P($G(^DPT(DFN,.36)),"^",2) I X,(X<3) S MTI="AS" G MTQ
 ;-Military Disability Retirement OR Discharge Due To Disability
 I $P($G(^DPT(DFN,.36)),"^",12)!($P($G(^DPT(DFN,.36)),"^",13)) S MTI="AS" G MTQ
 ;
 I EC=2 D  I MTI'="" G MTQ
 .;- Mexican Border Period or World War I
 .I $P($G(^DIC(21,+$P($G(^DPT(DFN,.32)),"^",3),0)),"^",3)=1!($P($G(^DIC(21,+$P($G(^DPT(DFN,.32)),"^",3),0)),"^",3)=3) S MTI="AS" Q
 .;- Prisoner of War (POW)
 .I $P($G(^DPT(DFN,.52)),"^",5)="Y" S MTI="AS" Q
 .;- Purple Heart Recipient
 .I $P($G(^DPT(DFN,.53)),"^")="Y" S MTI="AS" Q
 .;- Aid and Attendance
 .I $P($G(^DPT(DFN,.362)),"^",12)="Y" S MTI="AN" Q
 .;- Housebound
 .I $P($G(^DPT(DFN,.362)),"^",13)="Y" S MTI="AN" Q
 ;- Receiving VA Pension
 I EC=4,$P($G(^DPT(DFN,.362)),"^",14)="Y" S MTI="AN" G MTQ
 ;
 I EC=5!(EC=3) D  I MTI'="" G MTQ
 .;- Eligible for Medicaid
 .I $P($G(^DPT(DFN,.38)),"^")=1 S MTI="AN" Q
 .;- Appt types with ignore billing set to 1 (except comp gen)
 .I AT'=10,$P($G(^SD(409.1,+AT,0)),"^",2) S MTI="X" Q
 .;- Treatment for AO, IR, EC, MST, HNC
 .F SDANS1=1,2,4,5,6 S SDANS=$S('$D(^SDD(409.42,"AO",+SDOE,SDANS1)):"",$P($G(^SDD(409.42,$O(^(SDANS1,0)),0)),"^",3):1,1:0) I SDANS=1 S MTI="AS" Q
 .I MTI]"" Q
 .;- Means Test Code A, C, or G  (also Pending Adj = Code C or Code G)
 .S MT=$$LST^DGMTU(DFN,DATE)
 .I $P(MT,"^",4)="A" S MTI="AN" Q
 .I $P(MT,"^",4)="C" S MTI="C" Q
 .I $P(MT,"^",4)="G" S MTI="G" Q
 .I $P(MT,"^",4)="P" D  Q
 . .S MTI=$$PA^DGMTUTL($P(MT,"^")),MTI=$S('$D(MTI):"U",MTI="MT":"C",MTI="GMT":"G",1:"U")
 .;- no means test status or no longer required...check current eligibility data
 .S X=+$G(^DPT(DFN,.36)),X=+$P($G(^DIC(8,X,0)),U,9) ; get MAS eligibility
 .;- Service connected > 50 %
 .I X=1 S MTI="AS" Q
 .;- Service connected < 50 %
 .I EC=3,'$$SC^DGMTR(DFN) S MTI="AS" Q
 .;- mex border or WWI or POW
 .I X=16!(X=17)!(X=18)!(X=22) S MTI="AS" Q
 .;- A&A or Pension or HB
 .I X=2!(X=4)!(X=15) S MTI="AN" Q
 ;- Means Test required and not done/completed
 S MTI="U"
MTQ Q MTI
 ;
 ;
PATCLASS(DFN,SDOE) ; - Return classification questions from PATIENT (#2) file
 ;           (Agent Orange, Radiation Exposure, Service Connected,
 ;            Environmental Contaminants, Military Sexual Trauma and
 ;            Head/Neck Cancer questions)
 ;
 ;   Input:  DFN  = Patient IEN (from file #2)
 ;           SDOE = Outpatient Encounter File IEN [Optional]
 ;
 ;  Output:  String containing Y if classification question = YES, N if 
 ;           = NO, null otherwise (classifications separated by "^")
 ;
 N NODE,PATCLASS,SDTEMP,X
 S SDTEMP(1)=$$AO^SDCO22(DFN,$G(SDOE))
 S SDTEMP(2)=$$IR^SDCO22(DFN,$G(SDOE))
 S SDTEMP(3)=$$SC^SDCO22(DFN,$G(SDOE))
 S SDTEMP(4)=$$EC^SDCO22(DFN,$G(SDOE))
 S SDTEMP(5)=$$MST^SDCO22(DFN,$G(SDOE))
 S SDTEMP(6)=$$HNC^SDCO22(DFN,$G(SDOE))
 S SDTEMP(7)=$$CV^SDCO22(DFN,$G(SDOE))
 S SDTEMP(8)=$$SHAD^SDCO22(DFN)
 F X=1:1:8 S $P(PATCLASS,U,X)=$S(SDTEMP(X)=1:"Y",1:"N")
 Q PATCLASS
 ;
 ;
CLASS(SDOE,SCDXARRY) ; - Return array of classification types for encounter
 ;
 ;   Input:  SDOE = Outpatient Encounter IEN (from file #409.68)
 ;
 ;  Output:  Array (pass desired name as parameter) containing
 ;           Classification Type^Value
 ;
 N CLASS,I,X
 S CLASS="",(I,X)=0
 S SDOE=+$G(SDOE)
 F  S CLASS=+$O(^SDD(409.42,"OE",SDOE,CLASS)) Q:'CLASS  D
 . S I=$P($G(^SDD(409.42,CLASS,0)),"^"),X=X+1
 . S @SCDXARRY@(I)=$P($G(^SDD(409.42,CLASS,0)),"^")_"^"_$P($G(^SDD(409.42,CLASS,0)),"^",3)
CLASSQ S @SCDXARRY@(0)=X
 Q
 ;
 ;
CHKCLASS(DFN,SDOE) ; - Get classification data for HL7 VAFHLZCL segment
 ;
 ;   Input:  DFN = Patient IEN (from file #2)
 ;          SDOE = Outpatient Encounter IEN (from file #409.68)
 ;
 ;  Output:  String separated by "^" containing: 
 ;           1 (patient class = YES and encounter class = YES)
 ;           0 (patient class = YES and encounter class = NO)
 ;           HLQ ("""""") otherwise
 ;
EN N OECLASS,OUT,PATCLASS,TYPE,ENCVAL,CLCNT,PATVAL
 S PATCLASS=$$PATCLASS(DFN,SDOE)
 D CLASS(SDOE,"OECLASS")
 S CLCNT=$L(PATCLASS,"^")
 F TYPE=1:1:CLCNT D
 .S ENCVAL=$P($G(OECLASS(TYPE)),"^",2)
 .S PATVAL=$P(PATCLASS,"^",TYPE)
 .S $P(OUT,"^",TYPE)=""""""
 .I PATVAL="Y" S $P(OUT,"^",TYPE)=ENCVAL
ENQ Q OUT
 ;
 ;
POV(DFN,DATE,CLINIC,APTYP) ; - Determine Purpose of Visit for encounter
 ;
 ;   Input:  DFN = Patient IEN
 ;          DATE = Appointment Date/Time
 ;        CLINIC = Clinic
 ;         APTYP = Appointment Type
 ;
 ;  Output:  Purpose of Visit value (combination of Purpose of Visit
 ;           and Appointment Type)
 ;
 N POV,SCDXPOV
 I (DFN=""!(DATE="")!(CLINIC="")!(APTYP="")) G POVQ
 I $P($G(^DPT(DFN,"S",+DATE,0)),"^")'=CLINIC G POVQ
 S POV=$P($G(^DPT(DFN,"S",+DATE,0)),"^",7),POV=$S($L(POV)=1:"0"_POV,1:POV)
 S APTYP=$S($L(APTYP)=1:"0"_APTYP,1:APTYP)
 S SCDXPOV=POV_APTYP
POVQ Q $G(SCDXPOV)
 ;
 ;
SCODE(SDOE,SCDXARRY) ; Return array of stop codes for encounter
 ;
 ;   Input:  SDOE = Outpatient Encounter IEN (from file #409.68)
 ;
 ;  Output:  Array (pass desired name as parameter) containing
 ;           stop codes
 ;
 ;
 N CNT,I,SDOE0,SDOEC,SDOEC0
 S CNT=1,(I,SDOEC)=0
 S SDOE=+$G(SDOE)
 I '$D(^SCE(SDOE,0)) G SCODEQ
 I '$P($G(^SCE(SDOE,0)),"^",3) G SCODEQ
 S SDOE0=$G(^SCE(SDOE,0))
 ;
 ;- Get stop code from parent encounter
 I $P(SDOE0,"^",3) S @SCDXARRY@(CNT)=$P(SDOE0,"^",3),I=CNT
 ;
 ;- Get stop code from child encounter (credit stop)
 F  S SDOEC=+$O(^SCE("APAR",SDOE,SDOEC)) Q:('SDOEC)!(CNT=2)  D
 . S SDOEC0=$G(^SCE(SDOEC,0))
 . I $P(SDOEC0,"^",3),($P(SDOEC0,"^",8)=4) D
 .. S CNT=CNT+1,I=CNT
 .. S @SCDXARRY@(CNT)=$P(SDOEC0,"^",3)
SCODEQ S @SCDXARRY@(0)=I
 Q
 ;
 ;
PROC(SDOE,SCDXARRY) ; Return array of procedures for encounter
 ;
 ;
 ;   Input:  SDOE = Outpatient Encounter IEN (from file #409.68)
 ;
 ;  Output:  Array (pass desired name as parameter) containing
 ;           procedures
 ;
 N CNT
 S CNT=0,SDOE=+$G(SDOE)
 I '$D(^SCE(SDOE,0)) G PROCQ
 ;
 D GETPROC(.CNT,SDOE,SCDXARRY) G PROCQ
 ;
 ;- Array of procedures
PROCQ S @SCDXARRY@(0)=CNT
 Q
 ;
 ;
GETPROC(CNT,ENC,SCDXARRY) ;Get procedures from Scheduling Visits file
 ;
 N CPTS,VCPT
 D GETCPT^SDOE(ENC,"CPTS")
 N CPT,QTY,I
 S VCPT=0
 F  S VCPT=$O(CPTS(VCPT)) Q:'VCPT  D
 . S CPT=$G(CPTS(VCPT))
 . S QTY=+$P(CPT,U,16)
 . F I=1:1:QTY S CNT=CNT+1,@SCDXARRY@(CNT)=+CPT
 Q
