VAFCMIS ;SF/CMC-MISSING ICN CROSS REFERENCE ;1/7/98
 ;;5.3;Registration;**149**;Aug 13, 1993
 ;
SET(DA) ;
 ;setting Missing ICN Cross Reference
 N X S X="MPIFVTQ" X ^%ZOSF("TEST") Q:'$T
 S ^DPT("AMPIMIS",DA)=""
 Q
KILL(DA) ;
 ;deleting Missing ICN Cross Reference
 N X S X="MPIFVTQ" X ^%ZOSF("TEST") Q:'$T
 K ^DPT("AMPIMIS",DA)
 Q
 ;
PROCESS ;old line tag
 Q
IN ;processing in bound messages
 Q
