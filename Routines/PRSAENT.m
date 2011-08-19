PRSAENT ;HISC/MGD-Entitlement String ;10/21/04
 ;;4.0;PAID;**6,21,45,69,75,76,90,96,112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;VARS:
 ; C0=employees 0 node of master record in file 450
 ; NH= employees 8B normal hours
 ; FLX= compressed/flextime code (0=none,C=compressed,F=flextime)
 ; PMP= premium pay indicator 
 ;     ( D = entitled Sun.,   F = entitled Sat./Sun.,
 ;       E = entitled variable Sat./Sun. premium pay,
 ;       G = entitled variable Sun. prem pay
 ;       X = title 5 employees
 ;       R, C, O = 3 types of firefighters )
 ; AC= 3 single char codes concat. w/o delims + a possible 4th char.
 ; AC= PP_DutyBasis(full-1,part-2,intermit-3)_FLSA(E=Exempt,N=NonExempt)
 ;     _(*EWXY8BT02S9P)
 ; PP= employees pay plan (possible chars 0AEFGJKLMNPQRSTUWXY)
 ; PB= pay basis-code for time condition for computing pay.
 ; TA= type of appointment (career, career conditional, etc.)
 ; OCC= 4 digit cost center for fund appropriation accounting
 ; LVG= one digit code for employees leave group.
 ; ASS= specialty assignment of physicians,dentists, nurses,
 ;      summer employees,trainees and other special programs.
 ; ENT= 39 character entitlement string
 ; PMP = Premium Pay Code
 ;
 N PAYPDTMP,PPLOLD,DUTYTEMP,FLSATEMP
 ;
 S C0=^PRSPC(DFN,0)
 ;
 ; pay plan in master record.
 S PP=$P(C0,"^",21)
 ;
 ;=====================================================================
 ; duty basis from master record
 S DUTYTEMP=$P(C0,"^",10)
 ;
 ; FLSA indicator from master record
 S FLSATEMP=$P(C0,"^",12)
 ;
 ;Make sure we've called this routine from an entry point that uses
 ;PY for pay period.  A few reports, call PRSAENT from TYPSTF^PRSRUT0
 ;and the reports aren't concerned about differing pay plans from 
 ;other pay periods.
 ;
 I +($G(PY))>0 D
 .S PAYPDTMP=$P($G(^PRST(458,+PY,0)),"^") ;pay period we're working with.
 .S PPLOLD=$$OLDPP^PRS8UT(PAYPDTMP,+DFN) ;pay plan from PAYPDTMP.
 .;if we find an old pay plan and it's different than the master record
 .;use the old pay plan to determine VCS or FEE.
 .I PPLOLD'=0,(PP'=PPLOLD) D
 ..   S PP=PPLOLD
 ..   S DUTYTEMP=OLDPP("DUTYBS")
 ;=====================================================================
 ;
 ; Numeric Pay plans are all Wage grade. Set them to 0.
 S:PP?1N PP=0
 ;
 ;
 S:"BC"[PP PP="A"
 I "0AEFGJKLMNPQRSTUWXY"'[PP D NO Q
 S NH=+$P(C0,"^",16)
 S FLX=$P($G(^PRSPC(DFN,1)),"^",7)
 S PMP=$P($G(^PRSPC(DFN,"PREMIUM")),"^",6)
 S AC=PP_DUTYTEMP_FLSATEMP
 I $L(AC)'=3 D NO Q
 ;
 ;
 D @PP
 D FND
 Q
 ;===========================================================
 ;
0 Q
 ;
A ;patch 45: firefighters entitlements are based on PMP Codes.  
 ; Code O still uses nh>80 to determine entitlement. 
 I "RC"[PMP S AC=AC_PMP Q
 ;
 ;This check does not concern itself with whether or not a code
 ; O is present.  Simply if not a code R or C then an over 80
 ; must be a code O firefighter under the rules implemented in 
 ; patch 45.  
 ;
 I "CR"'[PMP,NH>80 S AC=AC_"*" Q
 ;
 Q:PMP=""
 I $E(AC,2)'=3,"WXY"[PMP S AC=AC_PMP Q
 S:"EF"[PMP AC=AC_"E"
 ;The following check is for Public Law 108-170
 S:"STUV"[PMP AC=AC_PMP
 Q
E Q
F Q
G I $E(AC,2)<3 Q
 S TA=$P(C0,"^",43) S:TA=8 AC=AC_"8" Q
J Q
K S:NH=48 AC=AC_"B" Q
L I $E(AC,2)=2 S PB=$P(C0,"^",20) S:PB=0 AC=AC_"*" Q
 I $E(AC,2)=3 S OCC=$P(C0,"^",17),OCC=+$E(OCC,5,6) S:OCC>20&(OCC<38) AC=AC_"*" Q
 S LVG=$P(C0,"^",15) S:LVG=5 AC=AC_"*" Q
M I $E(AC,2)=1,NH=48 S AC=AC_"B" Q
 I $E(AC,2)=2,NH=80 S AC=AC_"R" Q
 I $E(AC,2)=2 S PB=$P(C0,"^",20) I PB=0 S AC=AC_"0" Q
 I $E(AC,2)=3 S PB=$P(C0,"^",20) I PB=2 S AC=AC_"2" Q
 S OCC=$P(C0,"^",17) S:OCC="" OCC="*"
 S:" 061056 061057 "[OCC AC=AC_"T"
 S:" 061071 061072 061080 061083 061084 "[OCC AC=AC_"T"
 S:" 060552 060556 "[OCC AC=AC_"T" Q
N S ASS=$P(C0,"^",4),PB=$P(C0,"^",20)
 ;The following check is for Public Law 108-170
 I "^S^T^U^V^"[("^"_PMP_"^") S AC=AC_PMP Q
 I AC="N2E",PB=0 S AC=AC_"0" Q
 I $E(AC,2)=3,PB="S" S AC=AC_"$" Q
 S OCC=$P(C0,"^",17) S:OCC="" OCC="*"
 I OCC="069961" S AC=AC_"T" Q  ; Student Nurse Technician
 I OCC="069964" S AC=AC_"T" Q  ; Student Nurse Technician
 S AC=AC_$S(ASS="TR":"T",ASS?1"T"1N:"T",ASS?1"A"1N:"T",1:"") Q
P Q
Q I $E(AC,2)'=2 Q
 S PB=$P(C0,"^",20) S:PB=0 AC=AC_"0" Q
R Q
S Q
T I $E(AC,2)'=3 Q
 S PB=$P(C0,"^",20) S:PB=9 AC=AC_"9" Q
U S PB=$P(C0,"^",20) I $E(AC,3)="N",PB="P" S AC=AC_"P"
 Q
W Q
X S:'NH AC=AC_"0" Q
Y Q
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = =
FND ;Look up the 39 character entitlement string in the entitlement table
 ;The lookup is based on the AC x-ref that matches the AC variable that
 ;is built in this routine from the three 1 character codes from the 
 ;450 fields (pay plan, duty basis, FLSA).
 ;
 S A1=$O(^PRST(457.5,"AC",AC,0))
 D NO
 I +A1 S ENT=^PRST(457.5,A1,1)
 ; The following check was added to address the Hybrid employees
 ; defined in Public Law 107-135.  These Hybrids do not have a
 ; Premium Pay Indicator but are entitled to Saturday and Sunday
 ; Premium Pay.
 I $$HYBRID^PRSAENT1(DFN) D
 . S $E(ENT,8,9)="11"
 ;
 Q
 ;= = = = = = = = = = = = = = = = = = = = = = = =
NO S ENT=""
 Q
 ;
MLINHRS(IEN) ; 
 ;----------------------------------------------------------------------
 ; Determine if the employee is entitled to Military Leave in hours.
 ;
 ; Input Vars:
 ;  IEN - the ien number of the employee in the PAID EMPLOYEE (#450)
 ;        file.
 ;
 ; Local Vars:
 ;  DATA - the 0 node of the employee from the PAID EMPLOYEE (#450)
 ;         file.
 ;    DB - Duty Basis    field #9    from the #450 file.
 ;    NH - Normal Hours  field # 15  from the #450 file.
 ;    PP - Pay Plan      field # 20  from the #450 file.
 ;
 ; Output:
 ;  1 : Entitled to ML in hours.
 ;  0 : Entitled to ML in days.
 ;  X : Some of the required fields were not defined or the employee
 ;      is not entitled to Military Leave.
 ;----------------------------------------------------------------------
 ; Quit if no IEN passed in
 ;
 Q:'+IEN "X"
 ;
 ; Verify that ENT is defined.  If not call PRSAENT to define it.
 ;
 I '$D(ENT) D PRSAENT
 ;
 ; Quit if the Entitlement string is not defined for the employee
 ;
 Q:ENT="" "X"
 ;
 ; Quit if the employee is not entitled to Military Leave
 ;
 Q:'$E(ENT,34) "X"
 ;
 N DATA,PP,DB,NH
 S DATA=$G(^PRSPC(IEN,0))
 Q:DATA="" "X"
 S DB=$P(DATA,U,10),NH=$P(DATA,U,16),PP=$P(DATA,U,21)
 Q:DB=""!(NH="")!(PP="") "X" ; Quit if DB or NH or PP is not defined.
 ;
 ; Check for ML in Days
 ;
 I DB=1,NH=0,"^J^L^P^Q^X^"[PP  Q 0
 ;
 ; Otherwise the employee is entitled to ML in hours.
 ;
 Q 1
