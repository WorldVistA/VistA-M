IBCNRZPL ;DAOU/DMK - Receive HL7 e-Pharmacy ZPL Segment ;23-OCT-2003
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Description
 ;
 ; Receive HL7 e-Pharmacy ZPL Segment
 ; 366.03 PLAN File Update
 ;
 ; Called by IBCNRHLT
 ;
 ; Entry point
 ;
1000 ; Control ZPL Segment processing
 D INIT
 Q
 ;
INIT ; Initialize ZPL Segment variables
 ; 366.03 PLAN File
 ;
 N NAME
 ;
 ; .01 = ID
 S DATA(.01)=$G(IBSEG(4))
 ;
 ; Error?
 ; V405 = Plan ID Missing
 I $TR(DATA(.01)," ","")="" S ERROR="V405" Q
 ;
 ; .02 = NAME
 S DATA(.02)=$G(IBSEG(5))
 ;
 ; Error?
 ; V410 = Plan Name Missing
 I $TR(DATA(.02)," ","")="" S ERROR="V410" Q
 ;
 ; .03 = PAYER NAME (pointer - 365.12)
 S DATA(.03)=$G(IBSEG(6))
 I DATA(.03)]"" S DATA(.03)=$$LOOKUP3^IBCNRFM1(365.12,"C",DATA(.03))
 ;
 ; Error?
 ; V415 = Payer ID Undefined
 I DATA(.03)=-1 S ERROR="V415" Q
 ;
 ; .04 = NAME - SHORT
 S DATA(.04)=$G(IBSEG(7))
 ;
 ; .05 = TYPE
 S DATA(.05)=$G(IBSEG(8))
 ;
 ; .06 = REGION
 S DATA(.06)=$G(IBSEG(9))
 ;
 ; .07 = DATE/TIME CREATED
 ; MAD = Add
 I IBCNACT="MAD",IEN=-1 S DATA(.07)=DATE("NOW")
 ;
 ; Initialize primary contact name variables
 S NAME=$G(IBSEG(10))
 D NAME
 ;
 ; 1.01 = PRIMARY CONTACT NAME
 S DATA(1.01)=NAME("NAME")
 ;
 ; 1.02 = PRIMARY CONTACT PREFIX
 S DATA(1.02)=NAME("PREFIX")
 ;
 ; 1.03 = PRIMARY CONTACT DEGREE
 S DATA(1.03)=NAME("DEGREE")
 ;
 ; Initialize alternate contact name variables
 S NAME=$G(IBSEG(11))
 D NAME
 ;
 ; 1.04 = ALTERNATE CONTACT NAME
 S DATA(1.04)=NAME("NAME")
 ;
 ; 1.05 = ALETRNATE CONTACT PREFIX
 S DATA(1.05)=NAME("PREFIX")
 ;
 ; 1.06 = ALTERNATE CONTACT DEGREE
 S DATA(1.06)=NAME("DEGREE")
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
