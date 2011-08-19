ORVAA ;;SLC OIFO/GDU - VA Advantage Indicator for GUI;[01/04/05 08:33]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215**;Dec 17, 1999
 ;Input Variable
 ;  DFN     - Patient IEN
 ;Ouput Variable
 ; ORY      - Any array variable that will contain the following.
 ;    If the patient does not have insurance
 ;    Y(0)=0
 ;    If the patient has active insurance
 ;    Y(0)="Pt Insur"^"Patient has active insurance"
 ;    Y(1)=Company ID
 ;    Y(2)=Company Name
 ;    Y(3)=Company Street Address
 ;    Y(4)=Company State, Zip Code
 ;    Y(5)=Phone number
 ;    Y(6)=Coordination of Benefits indicator
 ;    Y(7)=Policy Name
 ;    Y(8)=Policy Reimburasble indicator
 ;    Y(9)=Effective date
 ;    Y(10)=Expiration date
 ;    Y(11)=Subscriber relationship to patient
 ;    Y(12)=Subscriber name
 ;    Y(13)=Subscriber ID
 ;    Y(14)=Pharmacy coverage
 ;    Y(15)=Outpatient coverage
 ;    Y(16)=Inpatient coverage
 ;    Y(17)=Group Number
 ;    Y(18)=Patient relationship to subscriber
 ;    If this is a Tricare plan or Champus plan:
 ;    Y(19)="This is a TriCare/Champus plan."
 ;    If this is a VA Advantage plan:
 ;    Y(19)="This is a VA Advantage plan"
 ;    Y(20)=A blank line
 ;    Repeats as needed for each active policy
 ;
 ;Internal Variables
 ;  LC      - Loop Counter
 ;  LQ      - Loop Quit, stop loop execution
 ;  U       - Default delimiter variable, set to "^" by FileMan/Kernel
 ;External References
 ; %ZTER          - DBIA 1621
 ;            Kernel Standard Error Recording Routine
 ; $$NOW^XLFDT    - DBIA 10103
 ;            Returns current date/time
 ; $$REPEAT^XLFSTR - DBIA 10104
 ;            Returns a string of character repeated a number of times
 ; $$INSUR^IBBAPI - DBIA 4419
 ;  API input variables:
 ;    DFN    - Patient IEN
 ;    IBDT   - Date to check for active insurance
 ;    IBSTAT - Status filter
 ;    ORIBR  - Array to store returned Insurance information
 ;    IBFLDS - Specifies what insurance information is to be returned
 ;  API output variables:
 ;    PIC    - Patient Insurance Check
 ;             If equal to -1 an error occured during insurance lookup.
 ;             Error message is built and returned to user. This data
 ;             is contained in ORIBR.
 ;
 ;             If equal to 0 patient has no active insurance. Y is set
 ;             to 0, program run ended.
 ;
 ;             If equal to 1 patient has actie insurance. The insurance
 ;             information is parsed, a message is built, and returned 
 ;             to the user. This data is contained in ORIBR.
 ;
VAA(ORY,DFN) ;
 ;Returns primary insurance policy name if VAA or TriCare
 N I,IBDT,IBFLDS,IBSTAT,LC,LQ,ORIBR,ORX,PIC,WI
 S ORY(0)=""
 ;Get active insurance information
 S IBSTAT="RB",(LC,ORIBR,PIC)="",(LQ,WI)=0,IBFLDS="*"
 S IBDT=$$NOW^XLFDT
 S PIC=$$INSUR^IBBAPI(DFN,IBDT,IBSTAT,.ORIBR,IBFLDS)
 I PIC<0 S ORY(0)=0 Q
 I PIC=0 S:ORY(0)="" ORY(0)=0 Q
 S $P(ORY(0),U)="Pt Insur",$P(ORY(0),U,2)="Patient has active Insurance"
 S $P(ORY(0),U,3)=""
 F  S LC=$O(ORIBR("IBBAPI","INSUR",LC)) Q:LC=""!(LQ)  D
 . D FLD01,FLD02,FLD03,FLD04,FLD05,FLD06,FLD07,FLD08,FLD09,FLD10
 . D FLD11,FLD12,FLD13,FLD14,FLD15,FLD16,FLD17,FLD18,FLD19,FLD20
 . S WI=WI+1,ORY(WI)=""
 I ORY(0)="" S ORY(0)=0
 Q
FLD01 ;Insurance Company Name
 S WI=WI+1,ORY(WI)=$$SBS($P($P($T(F01T),";",3),U),30)
 I $G(ORIBR("IBBAPI","INSUR",LC,1))'="" D
 . S ORY(WI)=ORY(WI)_$P(ORIBR("IBBAPI","INSUR",LC,1),U)
 S WI=WI+1,ORY(WI)=$$SBS($P($P($T(F01T),";",3),U,2),30)
 I $G(ORIBR("IBBAPI","INSUR",LC,1))'="" D
 . S ORY(WI)=ORY(WI)_$P(ORIBR("IBBAPI","INSUR",LC,1),U,2)
 Q
FLD02 ;Insurance Company Street Address
 S WI=WI+1,ORY(WI)=$$SBS($P($T(F02T),";",3),30)
 I $G(ORIBR("IBBAPI","INSUR",LC,2))="" Q
 S ORY(WI)=ORY(WI)_ORIBR("IBBAPI","INSUR",LC,2)
 Q
FLD03 ;Insurance Company City
 I $G(ORIBR("IBBAPI","INSUR",LC,3))="" S WI=WI+1,ORY(WI)="" Q
 S WI=WI+1,ORY(WI)=$$REPEAT^XLFSTR(" ",30)_ORIBR("IBBAPI","INSUR",LC,3)
 Q
FLD04 ;Insurance Company State
 I $G(ORIBR("IBBAPI","INSUR",LC,4))="" Q
 S ORY(WI)=ORY(WI)_", "_$P(ORIBR("IBBAPI","INSUR",LC,4),U,2)
 Q
FLD05 ;Insurance Company Zip
 I $G(ORIBR("IBBAPI","INSUR",LC,5))="" Q
 S ORY(WI)=ORY(WI)_" "_ORIBR("IBBAPI","INSUR",LC,5)
 Q
FLD06 ;Insurance Company Phone
 S WI=WI+1,ORY(WI)=$$SBS($P($T(F06T),";",3),30)
 I $G(ORIBR("IBBAPI","INSUR",LC,6))="" Q
 S ORY(WI)=ORY(WI)_ORIBR("IBBAPI","INSUR",LC,6)
 Q
FLD07 ;Coordination of Benefits
 S WI=WI+1,ORY(WI)=$$SBS($P($P($T(F07T),";",3),U),30)
 I $G(ORIBR("IBBAPI","INSUR",LC,7))="" Q
 S ORY(WI)=ORY(WI)_$P(ORIBR("IBBAPI","INSUR",LC,7),U,2)_" insurer"
 Q
FLD08 ;Policy Name
 S WI=WI+1,ORY(WI)=$$SBS($P($T(F08T),";",3),30)
 I $G(ORIBR("IBBAPI","INSUR",LC,8))="" Q
 S ORY(WI)=ORY(WI)_$P(ORIBR("IBBAPI","INSUR",LC,8),U)
 S ORY(WI)=ORY(WI)_" - "_$P(ORIBR("IBBAPI","INSUR",LC,8),U,2)
 Q
FLD09 ;Policy Reimbursable
 S WI=WI+1,ORY(WI)=$$SBS($P($T(F09T),";",3),30)
 I $G(ORIBR("IBBAPI","INSUR",LC,9))="" Q
 S ORY(WI)=ORY(WI)_$P(ORIBR("IBBAPI","INSUR",LC,9),U,2)
 Q
FLD10 ;Effective Date
 S WI=WI+1,ORY(WI)=$$SBS($P($T(F10T),";",3),30)
 I $G(ORIBR("IBBAPI","INSUR",LC,10))="" Q
 S ORY(WI)=ORY(WI)_$$FMTE^XLFDT(ORIBR("IBBAPI","INSUR",LC,10))
 Q
FLD11 ;Expiration Date
 S WI=WI+1,ORY(WI)=$$SBS($P($T(F11T),";",3),30)
 I $G(ORIBR("IBBAPI","INSUR",LC,11))="" Q
 S ORY(WI)=ORY(WI)_$$FMTE^XLFDT(ORIBR("IBBAPI","INSUR",LC,11))
 Q
FLD12 ;Subscriber Relationship
 S WI=WI+1,ORY(WI)=$$SBS($P($T(F12T),";",3),40)
 I $G(ORIBR("IBBAPI","INSUR",LC,12))="" Q
 S ORY(WI)=ORY(WI)_$P(ORIBR("IBBAPI","INSUR",LC,12),U,2)
 Q
FLD13 ;Subscriber Name
 S WI=WI+1,ORY(WI)=$$SBS($P($T(F13T),";",3),40)
 I $G(ORIBR("IBBAPI","INSUR",LC,13))="" Q
 S ORY(WI)=ORY(WI)_ORIBR("IBBAPI","INSUR",LC,13)
 Q
FLD14 ;Subscriber ID
 S WI=WI+1,ORY(WI)=$$SBS($P($T(F14T),";",3),40)
 I $G(ORIBR("IBBAPI","INSUR",LC,14))="" Q
 S ORY(WI)=ORY(WI)_ORIBR("IBBAPI","INSUR",LC,14)
 Q
FLD15 ;Pharmacy Coverage
 S WI=WI+1,ORY(WI)=$$SBS($P($T(F15T),";",3),30)
 I $G(ORIBR("IBBAPI","INSUR",LC,15))="" Q
 S ORY(WI)=ORY(WI)_$P(ORIBR("IBBAPI","INSUR",LC,15),U,2)
 Q
FLD16 ;Outpatient Coverage
 S WI=WI+1,ORY(WI)=$$SBS($P($T(F16T),";",3),30)
 I $G(ORIBR("IBBAPI","INSUR",LC,16))="" Q
 S ORY(WI)=ORY(WI)_$P(ORIBR("IBBAPI","INSUR",LC,16),U,2)
 Q
FLD17 ;Inpatient Coverage
 S WI=WI+1,ORY(WI)=$$SBS($P($T(F17T),";",3),30)
 I $G(ORIBR("IBBAPI","INSUR",LC,17))="" Q
 S ORY(WI)=ORY(WI)_$P(ORIBR("IBBAPI","INSUR",LC,17),U,2)
 Q
FLD18 ;Group Number
 S WI=WI+1,ORY(WI)=$$SBS($P($T(F18T),";",3),30)
 I $G(ORIBR("IBBAPI","INSUR",LC,18))="" Q
 S ORY(WI)=ORY(WI)_ORIBR("IBBAPI","INSUR",LC,18)
 Q
FLD19 ;Patient Relationship to Subscriber
 S WI=WI+1,ORY(WI)=$$SBS($P($T(F19T),";",3),40)
 I $G(ORIBR("IBBAPI","INSUR",LC,19))="" Q
 S ORY(WI)=ORY(WI)_$P(ORIBR("IBBAPI","INSUR",LC,19),U,2)
 Q
FLD20 ;VA Advantage Flag - Tricare/Champus Flag
 S WI=WI+1,ORY(WI)=""
 I $G(ORIBR("IBBAPI","INSUR",LC,20))="" Q
 I $P(ORIBR("IBBAPI","INSUR",LC,20),U)=1 D
 . S ORY(WI)="This is a VA Advantage plan"
 I $P(ORIBR("IBBAPI","INSUR",LC,20),U,2)=1 D
 . S ORY(WI)="This is a TriCare/Champus plan"
 Q
SBS(X,X1) ;Stuff Blank Spaces in line headers
 N X2
 S X2=X1-$L(X)
 S X=X_$$REPEAT^XLFSTR(" ",X2)
 Q X
 ;Field text for output
F01T ;;Company ID:^Company Name:
F02T ;;Company Address:
F06T ;;Phone Number:
F07T ;;Coordination of Benefits:^insurer
F08T ;;Policy Name:
F09T ;;Policy Reimbursable:
F10T ;;Effective Date:
F11T ;;Expiration Date:
F12T ;;Subscriber Relationship to Patient:
F13T ;;Subscriber Name:
F14T ;;Subscriber ID:
F15T ;;Pharmacy Coverage:
F16T ;;Outpatient Coverage:
F17T ;;Inpatient Coverage:
F18T ;;Group Number:
F19T ;;Patient Relationship to Subscriber:
F20T1 ;;This is a VA Advantage plan.
F20T2 ;;This is a TriCare/Champus plan.
