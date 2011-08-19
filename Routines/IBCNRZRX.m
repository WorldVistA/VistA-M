IBCNRZRX ;DAOU/DMK - Receive HL7 e-Pharmacy ZRX Segment ;23-OCT-2003
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Description
 ;
 ; Receive HL7 e-Pharmacy ZRX Segment
 ; 366.03 PLAN File Update (Pharmacy)
 ;
 ; Called by IBCNRHLT
 ;
 ; Entry point
 ;
1000 ; Control ZRX Segment processing
 D INIT
 I $D(ERROR) Q
 D INITBPS
 Q
 ;
INIT ; Initialize ZRX Segment variables
 ; 366.03 PLAN File
 ;
 N NAME
 ;
 ; Error?
 ; V505 = Plan ID Missing
 I $TR($G(IBSEG(3))," ","") S ERROR="V505" Q
 ;
 ; 10.01 = PHARMACY BENEFITS MANAGER NAME (pointer - 366.02)
 S DATA(10.01)=$G(IBSEG(4))
 I DATA(10.01)]"" S DATA(10.01)=$$LOOKUP1^IBCNRFM1(366.02,DATA(10.01))
 ;
 ; Error?
 ; V510 = Pharmacy Benefits Manager (PBM) Undefined
 I DATA(10.01)=-1 S ERROR="V510" Q
 ;
 ; 10.02 = BANKING IDENTIFICATION NUMBER
 S DATA(10.02)=$G(IBSEG(5))
 ;
 ; Error?
 ; V515 = Plan BIN Missing
 I $TR(DATA(10.02)," ","")="" S ERROR="V515" Q
 ;
 ; 10.03 = PROCESSOR CONTROL NUMBER (PCN)
 S DATA(10.03)=$G(IBSEG(6))
 ;
 ; 10.04 = NCPDP PROCESSOR NAME (pointer - 366.01)
 S DATA(10.04)=$G(IBSEG(7))
 I DATA(10.04)]"" S DATA(10.04)=$$LOOKUP1^IBCNRFM1(366.01,DATA(10.04))
 ;
 ; Error?
 ; V520 = NCPDP Processor Name Undefined
 I DATA(10.04)=-1 S ERROR="V520" Q
 ;
 ; 10.05 = ENABLED?
 S DATA(10.05)=$S($G(IBSEG(8))="Y":1,1:0)
 ;
 ; Error?
 ; V525 = Plan Enabled? Missing
 I $TR(DATA(10.05)," ","")="" S ERROR="V525" Q
 ;
 ; 10.06 = SOFTWARE VENDOR ID
 S DATA(10.06)=$G(IBSEG(9))
 ;
 ; 10.07 = BILLING PAYER SHEET NAME (pointer - 9002313.92)
 S DATA(10.07)=$G(IBSEG(10))
 I DATA(10.07)]"" S DATA(10.07)=$$LOOKUP1^IBCNRFM1(9002313.92,DATA(10.07))
 ;
 ; Error?
 ; V530 = Billing Payer Sheet Name Undefined
 I DATA(10.07)=-1 S ERROR="V530" Q
 ;
 ; 10.08 = REVERSAL PAYER SHEET NAME (pointer - 9002313.92)
 S DATA(10.08)=$G(IBSEG(11))
 I DATA(10.08)]"" S DATA(10.08)=$$LOOKUP1^IBCNRFM1(9002313.92,DATA(10.08))
 ;
 ; Error?
 ; V535 = Reversal Payer Sheet Name Undefined
 I DATA(10.08)=-1 S ERROR="V535" Q
 ;
 ; 10.09 = REBILL PAYER SHEET NAME (pointer - 9002313.92)
 S DATA(10.09)=$G(IBSEG(12))
 I DATA(10.09)]"" S DATA(10.09)=$$LOOKUP1^IBCNRFM1(9002313.92,DATA(10.09))
 ;
 ; Error?
 ; V540 = Rebill Payer Sheet Name Undefined
 I DATA(10.09)=-1 S ERROR="V540" Q
 ;
 ; 10.1  = MAXIMUM NCPDP TRANSACTIONS
 S DATA(10.1)=$G(IBSEG(13))
 ;
 ; Initialize RX primary contact name variables
 S NAME=$G(IBSEG(14))
 D NAME
 ;
 ; 11.01 = RX PRIMARY CONTACT NAME
 S DATA(11.01)=NAME("NAME")
 ;
 ; 11.02 = RX PRIMARY CONTACT PREFIX
 S DATA(11.02)=NAME("PREFIX")
 ;
 ; 11.03 = RX PRIMARY CONTACT DEGREE
 S DATA(11.03)=NAME("DEGREE")
 ;
 ; Initialize RX alternate contact name variables
 S NAME=$G(IBSEG(15))
 D NAME
 ;
 ; 11.04 = RX ALTERNATE CONTACT NAME
 S DATA(11.04)=NAME("NAME")
 ;
 ; 11.05 = RX ALETRNATE CONTACT PREFIX
 S DATA(11.05)=NAME("PREFIX")
 ;
 ; 11.06 = RX ALTERNATE CONTACT DEGREE
 S DATA(11.06)=NAME("DEGREE")
 Q
 ;
INITBPS ; Initialize variables from ZRX Segment variables
 ; 90002313.92 BPS NCPDP FORMATS File
 ;
 ; 1.03 = Maximum RX's Per Claim
 S DATABPS(1.03)=DATA(10.1)
 I DATABPS(1.03)'?1.N S DATABPS(1.03)=1
 ;
 ; 1.07 = Is A Reversal Format
 S DATABPS(1.07)=0
 ;
 ; 1.13 = SOFTWARE VENDOR/CERT ID
 S DATABPS(1.13)=DATA(10.06)
 ;
 ; 1001 = Reversal Format
 S DATABPS(1001)=DATA(10.08)
 Q
 ;
NAME ; Initialize name variables from NAME string
 S NAME("SURNAME")=$P($P(NAME,$E(HLECH,1),1),$E(HLECH,4),1)
 S NAME("SURNAME PREFIX")=$P($P(NAME,$E(HLECH,1),1),$E(HLECH,4),2)
 S NAME("FAMILY")=$S(NAME("SURNAME PREFIX")]"":NAME("SURNAME PREFIX")_" ",1:"")_NAME("SURNAME")
 S NAME("GIVEN")=$P(NAME,$E(HLECH,1),2)
 S NAME("MIDDLE")=$P(NAME,$E(HLECH,1),3)
 S NAME("SUFFIX")=$P(NAME,$E(HLECH,1),4)
 S NAME("NAME")=""
 I NAME("FAMILY")]"" S NAME("NAME")=NAME("FAMILY")_","_NAME("GIVEN")_$S(NAME("MIDDLE")]"":" "_$E(NAME("MIDDLE"),1),1:"")_$S(NAME("SUFFIX")]"":" "_NAME("SUFFIX"),1:"")
 S NAME("PREFIX")=$P(NAME,$E(HLECH,1),5)
 S NAME("DEGREE")=$P(NAME,$E(HLECH,1),6)
 Q
