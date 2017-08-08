HMPDJ02A ;ASMR/MKB/JD,CK,CPC,PB - Problems,Allergies,Vitals ;Jan 17, 2107 09:56:26
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**3**;Jan 17, 2017;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          ----- 
 ; ^AUPNVSIT(                    2028
 ;
 Q
GETVIEN(DFNN,VISITDT)  ;JL; get the Visit IEN from VISIT file based on patient ID and Datetime
 Q:'+$G(DFNN)!'$L(VISITDT) -1  ;return -1 if bad parameter
 N REVDT,VISITIEN
 S REVDT=9999999-$P(VISITDT,".",1)_$S($P(VISITDT,".",2)'="":"."_$P(VISITDT,".",2),1:"")
 S VISITIEN=$O(^AUPNVSIT("AA",DFNN,REVDT,""))  ; using "AA" cross-reference
 Q:VISITIEN="" -1
 Q VISITIEN
 ;
VSTIEN(VSTIEN) ; Jan 17, 2017 - PB - DE6877 - Function to check for the visit and the patient to exist for the visit in the Visit File
 ; INPUT - VSTIEN the IEN for the visit in the Visit File
 ; OUTPUT - 1 = missing required data element, 0 = required data elements are present
 N VSTDATA
 S VSTDATA=$G(^AUPNVSIT(VSTIEN,0))  ;ICR 2028
 Q:$P(VSTDATA,U)="" 1  ; if the .01 field is null quit and return 1
 Q:$P(VSTDATA,U,5)="" 1  ; if field .05 is null quit and return 1
 Q 0
