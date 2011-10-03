ORWMHV ;;SLC OIFO/CLA - My HealtheVet Indicator for CPRS GUI;[01/025/06]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215**;Dec 17, 1999
 ;
MHV(ORY,ORDFN) ; Returns "MHV" if patient has My HealtheVet data
 ;Ouput Variable
 ; ORY = 0      if patient does not have My HealtheVet (MHV) data
 ;     = "MHV"  if patient does have My HealtheVet data   
 ;
 N I,ORX
 S ORY=0
 ;
 ; check for My HealtheVet data:
 D TFL^VAFCTFU1(.ORX,ORDFN)       ; DBIA #2990
 S I=0 F  S I=$O(ORX(I)) Q:'I  D
 .;pt has MHV treat fac (200MH) and event reason wasn't "discharge" (3):
 .I $P(ORX(I),U)="200MH",$P(ORX(I),U,4)'=3 D
 ..S $P(ORY,U)="MHV",$P(ORY,U,2)="Patient has data in My HealtheVet"
 ;
 Q
