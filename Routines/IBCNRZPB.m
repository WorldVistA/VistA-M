IBCNRZPB ;DAOU/DMK - Receive HL7 e-Pharmacy ZPB Segment ;23-OCT-2003
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Description
 ;
 ; Receive HL7 e-Pharmacy ZPB Segment
 ; 366.02 PHARMACY BENEFITS MANAGER (PBM) File Update
 ;
 ; Called by IBCNRHLT
 ;
 ; Entry point
 ;
1000 ; Control ZPB Segment processing
 D INIT
 Q
 ;
INIT ; Initialize ZPB Segment variables
 ; 366.02 PHARMACY BENEFITS MANAGER (PBM) File
 ;
 N NAME
 ;
 ; .01 = NAME
 S DATA(.01)=$G(IBSEG(4))
 ;
 ; Error?
 ; V305 = Pharmacy Benefits Manager (PBM) Name Missing
 I $TR(DATA(.01)," ","")="" S ERROR="V305" Q
 ;
 ; .02 = DATE/TIME CREATED
 ; MAD = Add
 I IBCNACT="MAD",IEN=-1 S DATA(.02)=DATE("NOW")
 ;
 ; Initialize primary contact name variables
 S NAME=$G(IBSEG(5))
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
 S NAME=$G(IBSEG(6))
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
