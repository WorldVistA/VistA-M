IBCE837L ;EDE/JWS - OUTPUT FOR 837 FHIR TRANSMISSION ;5/23/18 10:48am
 ;;2.0;INTEGRATED BILLING;**623**;23-MAY-18;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
SET(RES,SQ,FLD,NAME,TASDATA) ;
 ;RES = FHIR resource name
 ;SQ = Output Formatter seq #
 ;FLD = Output Formatter field #
 ;NAME = Output Formatter field name
 N DATA
 S DONE=0
 S DATA="{""valueString"":""837-"
 D  Q:DONE
 . I FLD=1 S FILE=TASDATA,DONE=1 Q
 . I RES="Basic" D  Q
 .. I SQ=5 D  Q  ;GEN
 ... I FLD>1 D S Q
 .. I SQ=16 D  Q  ;PRV1
 ... F I=2,3 I FLD=I D S Q
 .. I SQ=30 D  Q  ;CI2
 ... I FLD=2 D S Q
 .. I SQ=32 D  Q  ;CI2A
 ... I FLD=2 D S Q
 .. I SQ=36 D  Q  ;CI3A
 ... F I=3:1:9 I FLD=I D S Q
 .. I SQ=50 D  Q  ;CL1
 ... F I=7,32 I FLD=I D S Q
 .. I SQ=51 D  Q  ;CL1A
 ... F I=10:1:12,14,23 I FLD=I D S Q
 .. I SQ=65 D  Q  ;OC1-OC12
 ... F I=2,3 I FLD=I D S Q
 .. I SQ=70 D  Q  ;OS1-OS12
 ... I FLD=4 D S Q
 .. I SQ=105 D  Q  ;OI1
 ... I FLD=9 D S Q
 .. I SQ=180 D  Q  ;PRF
 ... F I=6,22:1:24,29 I FLD=I D S Q
 .. I SQ=185 D  Q  ;INS
 ... F I=2,3,5,12,15,16 I FLD=I D S Q
 .. I SQ=186 D  Q  ;DEN
 ... F I=2,3,14:1:19 I FLD=I D S Q
 .. I SQ=186.1 D  Q  ;DEN1
 ... F I=2,3,8,10,12,14 I FLD=I D S Q
 .. I SQ=186.2 D  Q  ;DEN2
 ... I FLD>1 D S Q
 .. I SQ=190 D  Q  ;RX1
 ... F I=2,11 I FLD=I D S Q
 .. I SQ=191 D  Q  ;LDAT
 ... F I=2,7,8,11,12 I FLD=I D S Q
 .. I SQ=191.4 D  Q  ;CMN
 ... F I=2,3,5,10,12,14,15 I FLD=I D S Q
 .. I SQ=191.7 D  Q  ;MEA
 ... I FLD=2 D S Q
 .. I SQ=192 D  Q  ;LOPE
 ... I FLD=2 D S Q
 .. I SQ=193 D  Q  ;LOP1
 ... I FLD=2 D S Q
 .. I SQ=193.3 D  Q  ;LREN
 ... I FLD=2 D S Q
 .. I SQ=193.6 D  Q  ;LPUR
 ... I FLD=2 D S Q
 .. I SQ=194 D  Q  ;LSUP
 ... I FLD=2 D S Q
 .. I SQ=194.3 D  Q  ;LREF
 ... I FLD=2 D S Q
 .. I SQ=194.5 D  Q  ;LSUR
 ... I FLD=2 D S Q
 .. I SQ=194.6 D  Q  ;LSR1
 ... I FLD=2 D S Q
 .. I SQ=195 D  Q  ;LCOB
 ... F I=2,6,12,13,18 I FLD=I D S Q
 .. I SQ=200 D  Q  ;LCAS
 ... F I=2,3,9,12,15,18,21,22 I FLD=I D S Q
 .. I SQ=205 D  Q  ;LQ
 ... F I=2:1:4 I FLD=I D S Q
 .. I SQ=210 D  Q  ;FRM
 ... F I=2,7 I FLD=I D S Q
 . I RES="CarePlan" D  Q
 .. I SQ=62 D  Q  ;DN1
 ... F I=4:1:6 I FLD=I D S Q
 .. I SQ=104.9 D  Q  ;AMB1
 ... I FLD=4 D S Q
 .. I SQ=191.4 D  Q  ;CMN
 ... I FLD=11 D S Q
 . I RES="ChargeItem" D  Q
 .. I SQ=60 D  Q  ;UB1
 ... I FLD=19 D S Q
 .. I SQ=80 D  Q  ;VC1-VC12
 ... I FLD=2 D S Q
 ... I FLD=3 D S Q
 . I RES="Claim" D  Q
 .. I SQ=20 D  Q  ;CI1
 ... I FLD=15 D S Q
 .. I SQ=45 D  Q  ;PT2
 ... F I=5,6 I FLD=I D S Q
 .. I SQ=50 D  Q  ;CL1
 ... F I=2,4:1:6,9:1:17,20,21,28:1:31,38 I FLD=I D S Q
 .. I SQ=51 D  Q  ;CL1A
 ... F I=13,29,30 I FLD=I D S Q
 .. I SQ=55 D  Q  ;SUB
 ... F I=7,10 I FLD=I D S Q
 .. I SQ=62 D  Q  ;DN1
 ... F I=2,3 I FLD=I D S Q
 .. I SQ=63 D  Q  ;DN2
 ... F I=2:1:4 I FLD=I D S Q
 .. I SQ=105 D  Q  ;OI1
 ... I FLD=7 D S Q
 .. I SQ=107 D  Q  ;OI1A
 ... F I=8,9 I FLD=I D S Q
 .. I SQ=112 D  Q  ;OI4
 ... F I=11,12 I FLD=I D S Q
 .. I SQ=115 D  Q  ;COB1
 ... I FLD=7 D S Q
 .. I SQ=180 D  Q  ;PRF
 ... I FLD=5 D S Q
 .. I SQ=185 D  Q  ;INS
 ... I FLD=9 D S Q
 .. I SQ=186 D  Q  ;DEN
 ... I FLD=12 D S Q
 .. I SQ=191 D  Q  ;LDAT
 ... I FLD=14 D S Q
 .. I SQ=191.4 D  Q  ;CMN
 ... I FLD=7 D S Q
 . I RES="ClaimResponse" D  Q
 .. I SQ=60 D  Q  ;UB1
 ... I FLD=2 D S Q
 .. I SQ=105 D  Q  ;OI1
 ... I FLD=2 D S Q
 .. I SQ=107 D  Q  ;OI1A
 ... F I=2:1:7 I FLD=I D S Q
 .. I SQ=110 D  Q  ;OI2
 ... I FLD=2 D S Q
 .. I SQ=112 D  Q  ;OI4
 ... I FLD=2 D S Q
 .. I SQ=113 D  Q  ;OI5
 ... I FLD=2 D S Q
 .. I SQ=114 D  Q  ;OI6
 ... I FLD=2 D S Q
 .. I SQ=115 D  Q  ;COB1
 ... I FLD=2 D S Q
 .. I SQ=120 D  Q  ;MOA1
 ... I FLD=2 D S Q
 .. I SQ=125 D  Q  ;MIA1
 ... I FLD=2 D S Q
 .. I SQ=130 D  Q  ;MIA2
 ... I FLD=2 D S Q
 .. I SQ=135 D  Q  ;CCAS
 ... F I=2:1:21 I FLD=I D S Q
 .. I SQ=170 D  Q  ;OP1
 ... I FLD=2 D S Q
 .. I SQ=170.5 D  Q  ;OP1A
 ... I FLD=2 D S Q
 .. I SQ=171 D  Q  ;OP2
 ... I FLD=2 D S Q
 .. I SQ=172 D  Q  ;OP3
 ... I FLD=2 D S Q
 .. I SQ=173 D  Q  ;OP4
 ... I FLD=2 D S Q
 .. I SQ=176 D  Q  ;OP7
 ... I FLD=2 D S Q
 .. I SQ=177 D  Q  ;OP8
 ... I FLD=2 D S Q
 .. I SQ=178 D  Q  ;OP9
 ... I FLD=2 D S Q
 .. I SQ=178.1 D  Q  ;OP10
 ... I FLD=2 D S Q
 .. I SQ=195 D  Q  ;LCOB
 ... I FLD=4 D S Q
 . I RES="Communication" D  Q
 .. I SQ=52 D  Q  ;CL1B
 ... F I=3:1:5 I FLD=I D S Q
 .. I SQ=60 D  Q  ;UB1
 ... F I=20,21 I FLD=I D S Q
 .. I SQ=191 D  Q  ;LDAT
 ... F I=3:1:6 I FLD=I D S Q
 .. I SQ=191.4 D  Q  ;CMN
 ... F I=16,17 I FLD=I D S Q
 .. I SQ=210 D  Q  ;FRM
 ... F I=3:1:6 I FLD=I D S Q
 . I RES="Condition" D  Q
 .. I SQ=50 D  Q  ;CL1
 ... I FLD=18 D S Q
 .. I SQ=51 D  Q  ;CL1A
 ... F I=7,8,16,18,20,22,24 I FLD=I D S Q
 .. I SQ=85 D  Q  ;CC1-CC12
 ... I FLD=2 D S Q
 .. I SQ=180 D  Q  ;PRF
 ... F I=11:1:14 I FLD=I D S Q
 .. I SQ=186.1 D  Q  ;DEN1
 ... F I=4:1:7,9 I FLD=I D S Q
 .. I SQ=191.4 D  Q  ;CMN
 ... F I=8,9 I FLD=I D S Q
 . I RES="Coverage" D  Q
 .. I SQ=20 D  Q  ;CI1
 ... I FLD=12 D S Q
 .. I SQ=35 D  Q  ;CI3
 ... F I=2,3 I FLD=I D S Q
 .. I SQ=40 D  Q  ;PT1
 ... I FLD=2 D S Q
 .. I SQ=60 D  Q  ;UB1
 ... I FLD=3 D S Q
 .. I SQ=105 D  Q  ;OI1
 ... F I=4,5,8 I FLD=I D S Q
 .. I SQ=110 D  Q  ;OI2
 ... F I=3,11 I FLD=I D S Q
 . I RES="DocumentManifest" D  Q
 .. I SQ=52 D  Q  ;CL1B
 ... I FLD=2 D S Q
 . I RES="EligibilityRequest" D  Q
 .. I SQ=60 D  Q  ;UB1
 ... I FLD=4 D S Q
 .. I SQ=191.4 D  Q  ;CMN
 ... I FLD=13 D S Q
 . I RES="Encounter" D  Q
 .. I SQ=50 D  Q  ;CL1
 ... F I=22:1:24 I FLD=I D S Q
 .. I SQ=51 D  Q  ;CL1A
 ... F I=15,17,19,21 I FLD=I D S Q
 .. I SQ=90 D  Q  ;DC1-DC12
 ... F I=2:1:4 I FLD=I D S Q
 . I RES="EpisodeOfCare" D  Q
 .. I SQ=51 D  Q  ;CL1A
 ... F I=25:1:28 I FLD=I D S Q
 . I RES="ExplanationOfBenefit" D  Q
 .. I SQ=50 D  Q  ;CL1
 ... I FLD=8 D S Q
 .. I SQ=51 D  Q  ;CL1A
 ... I FLD=5 D S Q
 .. I SQ=120 D  Q  ;MOA1
 ... F I=3:1:11 I FLD=I D S Q
 .. I SQ=125 D  Q  ;MIA1
 ... F I=3:1:12 I FLD=I D S Q
 .. I SQ=130 D  Q  ;MIA2
 ... F I=3:1:15 I FLD=I D S Q
 .. I SQ=195 D  Q  ;LCOB
 ... F I=14,16,17 I FLD=I D S Q
 .. I SQ=200 D  Q  ;LCAS
 ... F I=4:1:8,10,11,13,14,16,17,19,20 I FLD=I D S Q
 . I RES="HealthcareService" D  Q
 .. I SQ=104.9 D  Q  ;AMB1
 ... F I=5:1:8 I FLD=I D S Q
 .. I SQ=104.91 D  Q  ;AMB2
 ... F I=2:1:8 I FLD=I D S Q
 .. I SQ=195 D  Q  ;LCOB
 ... I FLD=15 D S Q
 . I RES="ImagingStudy" D  Q
 .. I SQ=51 D  Q  ;CL1A
 ... F I=3,6,9 I FLD=I D S Q
 . I RES="Location" D  Q
 .. I SQ=50 D  Q  ;CL1
 ... F I=3,33 I FLD=I D S Q
 .. I SQ=104.8 D  Q  ;AMB
 ... I FLD=8 D S Q
 .. I SQ=172 D  Q  ;OP3
 ... F I=3:1:10 I FLD=I D S Q
 .. I SQ=176 D  Q  ;OP7
 ... F I=3:1:10 I FLD=I D S Q
 .. I SQ=180 D  Q  ;PRF
 ... I FLD=7 D S Q
 .. I SQ=186 D  Q  ;DEN
 ... I FLD=13 D S Q 
 . I RES="Medication" D  Q
 .. I SQ=190 D  Q  ;RX1
 ... I FLD=4 D S Q
 . I RES="MedicationDispense" D  Q
 .. I SQ=190 D  Q  ;RX1
 ... I FLD=7 D S Q
 . I RES="MedicationRequest" D  Q
 .. I SQ=190 D  Q  ;RX1
 ... F I=3,6,8,10,12 I FLD=I D S Q
 . I RES="Observation" D  Q
 .. I SQ=40 D  Q  ;PT1
 ... F I=14,15 I FLD=I D S Q
 .. I SQ=50 D  Q  ;CL1
 ... I FLD=25 D S Q
 .. I SQ=104.9 D  Q  ;AMB1
 ... F I=2,3 I FLD=I D S Q
 .. I SQ=180 D  Q  ;PRF
 ... F I=20,25 I FLD=I D S Q
 .. I SQ=185 D  Q  ;INS
 ... F I=13,17 I FLD=I D S Q
 .. I SQ=191.4 D  Q  ;CMN
 ... I FLD=4 D S Q 
 .. I SQ=191.7 D  Q  ;MEA
 ... F I=3:1:5 I FLD=I D S Q
 . I RES="Organization" D  Q
 .. I SQ=15 D  Q  ;PRV
 ... F I=3:1:9,11,12 I FLD=I D S Q
 .. I SQ=16 D  Q  ;PRV1
 ... F I=7:1:11 I FLD=I D S Q
 .. I SQ=20 D  Q  ;CI1
 ... F I=2:1:6,10 I FLD=I D S Q
 .. I SQ=36 D  Q  ;CI3A
 ... I FLD=2 D S Q
 .. I SQ=37 D  Q  ;CI5
 ... F I=2:1:9 I FLD=I D S Q
 .. I SQ=45 D  Q  ;PT2
 ... F I=7:1:12 I FLD=I D S Q
 .. I SQ=55 D  Q  ;SUB
 ... F I=2:1:6,12 I FLD=I D S Q
 .. I SQ=57 D  Q  ;SUB2
 ... F I=2,3,5:1:13 I FLD=I D S Q
 .. I SQ=104.8 D  Q  ;AMB
 ... F I=2:1:7 I FLD=I D S Q
 .. I SQ=110 D  Q  ;OI2
 ... I FLD=7 D S Q
 .. I SQ=112 D  Q  ;OI4
 ... F I=3:1:7 I FLD=I D S Q
 .. I SQ=114 D  Q  ;OI6
 ... F I=3:1:10 I FLD=I D S Q
 .. I SQ=195 D  Q  ;LCOB
 ... I FLD=3 D S Q
 . I RES="Patient" D  Q
 .. I SQ=30 D  Q  ;CI2
 ... F I=3:1:8 I FLD=I D S Q
 .. I SQ=32 D  Q  ;CI2A
 ... F I=3:1:8 I FLD=I D S Q
 .. I SQ=38 D  Q  ;CI6
 ... F I=2:1:5 I FLD=I D S Q
 .. I SQ=40 D  Q  ;PT1
 ... F I=4:1:13,16,20 I FLD=I D S Q
 .. I SQ=45 D  Q  ;PT2
 ... F I=3,4 I FLD=I D S Q
 . I RES="PaymentNotice" D  Q
 .. I SQ=112 D  Q  ;OI4
 ... F I=8:1:10 I FLD=I D S Q
 . I RES="Person" D  Q
 .. I SQ=110 D  Q  ;OI2
 ... F I=4:1:6 I FLD=I D S Q
 .. I SQ=113 D  Q  ;OI5
 ... F I=3:1:10 I FLD=I D S Q
 . I RES="Practitioner" D  Q
 .. I SQ=28 D  Q  ;CI1A
 ... F I=2:1:9 I FLD=I D S Q
 .. I SQ=96 D  Q  ;OPR
 ... F I=2:1:4,6:1:11,13:1:17 I FLD=I D S Q
 .. I SQ=97 D  Q  ;OPR1
 ... F I=2:1:12,14,15 I FLD=I D S Q
 .. I SQ=98 D  Q  ;OPR2
 ... F I=2:1:9 I FLD=I D S Q
 .. I SQ=99 D  Q  ;OPR3
 ... F I=2:1:9 I FLD=I D S Q
 .. I SQ=100 D  Q  ;OPR4
 ... F I=2:1:9 I FLD=I D S Q
 .. I SQ=101 D  Q  ;OPR5
 ... F I=2:1:10 I FLD=I D S Q
 .. I SQ=103 D  Q  ;OPR7
 ... F I=2:1:7 I FLD=I D S Q
 .. I SQ=104 D  Q  ;OPR8
 ... F I=2:1:9 I FLD=I D S Q
 .. I SQ=104.2 D  Q  ;OPR9
 ... F I=2:1:11 I FLD=I D S Q
 .. I SQ=104.4 D  Q  ;OPRA
 ... F I=2:1:9 I FLD=I D S Q
 .. I SQ=104.6 D  Q  ;OPRB
 ... F I=2:1:11 I FLD=I D S Q
 .. I SQ=104.61 D  Q  ;OPRC
 ... F I=2:1:9 I FLD=I D S Q
 .. I SQ=170 D  Q  ;OP1
 ... F I=3:1:10 I FLD=I D S Q
 .. I SQ=170.5 D  Q  ;OP1A
 ... F I=3:1:10 I FLD=I D S Q
 .. I SQ=171 D  Q  ;OP2
 ... F I=3:1:10 I FLD=I D S Q
 .. I SQ=173 D  Q  ;OP4
 ... F I=3:1:10 I FLD=I D S Q
 .. I SQ=177 D  Q  ;OP8
 ... F I=3:1:10 I FLD=I D S Q
 .. I SQ=178 D  Q  ;OP9
 ... F I=3:1:10 I FLD=I D S Q
 .. I SQ=178.1 D  Q  ;OP10
 ... F I=3:1:10 I FLD=I D S Q
 .. I SQ=191 D  Q  ;LDAT
 ... I FLD=13 D S Q
 .. I SQ=192 D  Q  ;LOPE
 ... F I=4:1:15 I FLD=I D S Q
 .. I SQ=193 D  Q  ;LOP1
 ... F I=4:1:15 I FLD=I D S Q
 .. I SQ=193.3 D  Q  ;LREN
 ... F I=4:1:17 I FLD=I D S Q
 .. I SQ=193.6 D  Q  ;LPUR
 ... F I=4:1:7 I FLD=I D S Q
 .. I SQ=194 D  Q  ;LSUP
 ... F I=4:1:15 I FLD=I D S Q
 .. I SQ=194.3 D  Q  ;LREF
 ... F I=4:1:15 I FLD=I D S Q
 .. I SQ=194.5 D  Q  ;LSUR
 ... F I=4:1:9 I FLD=I D S Q
 .. I SQ=194.6 D  Q  ;LSR1
 ... F I=3:1:10 I FLD=I D S Q
 . I RES="PractitionerRole" D  Q
 .. I SQ=192 D  Q  ;LOPE
 ... I FLD=3 D S Q
 .. I SQ=193 D  Q  ;LOP1
 ... I FLD=3 D S Q
 .. I SQ=193.3 D  Q  ;LREN
 ... I FLD=3 D S Q
 .. I SQ=193.6 D  Q  ;LPUR
 ... I FLD=3 D S Q
 .. I SQ=194 D  Q  ;LSUP
 ... I FLD=3 D S Q
 .. I SQ=194.3 D  Q  ;LREF
 ... I FLD=3 D S Q
 .. I SQ=194.5 D  Q  ;LSUR
 ... I FLD=3 D S Q
 . I RES="Procedure" D  Q
 .. I SQ=51 D  Q  ;CL1A
 ... I FLD=2 D S Q
 .. I SQ=180 D  Q  ;PRF
 ... F I=2:1:4,9,10,15:1:19,21,30 I FLD=I D S Q
 .. I SQ=185 D  Q  ;INS
 ... F I=4,7,8,10,14 I FLD=I D S Q
 .. I SQ=186 D  Q  ;DEN
 ... F I=4:1:11 I FLD=I D S Q
 .. I SQ=186.1 D  Q  ;DEN1
 ... F I=11,13,15:1:17 I FLD=I D S Q
 .. I SQ=191 D  Q  ;LDAT
 ... I FLD=15 D S Q
 .. I SQ=195 D  Q  ;LCOB
 ... F I=5,7:1:11 I FLD=I D S Q
 . I RES="ProcedureRequest" D  Q
 .. I SQ=70 D  Q  ;OS1-OS12
 ... F I=2,3 I FLD=I D S Q
 .. I SQ=75 D  Q  ;PC1-PC12
 ... F I=2:1:4 I FLD=I D S Q
 .. I SQ=77 S FILE="SPC" D  Q  ;SPC
 ... F I=2:1:5 I FLD=I D S Q
 . I RES="RelatedPerson" D  Q
 .. I SQ=105 D  Q  ;OI1
 ... F I=3,6 I FLD=I D S Q
 . I RES="SupplyRequest" D  Q
 .. I SQ=191.4 D  Q  ;CMN
 ... I FLD=6 D S Q
 . I RES="ValueSet" D  Q
 .. I SQ=15 D  Q  ;PRV
 ... F I=13,14 I FLD=I D S Q
 Q
 ;
S ; update ^TMP global
 D SETD^IBCE837I
 Q
 ;
