IBAUTL10 ;ALB/MGD - DUPLICATE COPAY TRANSACTION UTILITIES - ACHDT X-REF; Sep 30, 2020@15:16:44
 ;;2.0;INTEGRATED BILLING;**630**;21-MAR-94;Build 39
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Set and Kill logic for the ACHDT x-ref in the INTEGRATED BILLING ACTION (#350) file
 Q
 ;
SACHDT ; Set the ACHDT x-ref
 ; X(1) = the IEN of the PATIENT (#.02)
 ; X(2) = The EVENT DATE (#.17) if defined
 ; X(3) = The DATE BILLED FROM (#.14) if defined
 ;   DA = the IEN of the charge in the INTEGRATED BILLING ACTION (#350) file
 ; If the EVENT DATE is defined, use it for the index
 I X(1),X(2) S ^IB("ACHDT",X(1),X(2),DA)="" Q
 ; If EVENT DATE is not defined, use the DATE BILLED FROM as the index
 I X(1),X(3) S ^IB("ACHDT",X(1),X(3),DA)=""
 Q
 ;
KACHDT ; Delete the ACHDT x-ref
 ; X(1) = the IEN of the PATIENT (#.02)
 ; X(2) = The EVENT DATE (#.17) if defined
 ; X(3) = The DATE BILLED FROM (#.14) if defined
 ;   DA = the IEN of the charge in the INTEGRATED BILLING ACTION (#350) file
 ; If the EVENT DATE is defined, use it for the index
 I X(1),X(2) K ^IB("ACHDT",X(1),X(2),DA) Q
 ; If EVENT DATE is not defined, use the DATE BILLED FROM as the index
 I X(1),X(3) K ^IB("ACHDT",X(1),X(3),DA)
 Q
