PXRMP80I ;ISP/AGP - PATCH 80 INSTALLATION ;03/09/2022
 ;;2.0;CLINICAL REMINDERS;**80**;Feb 04, 2005;Build 7
 ;
 ;
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="PXRM*2.0*80 SMART UPDATES"
 I MODE["I" S ARRAY(LN,2)="03/09/2022@14:43:21"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 Q
 ;
POST ;Post-init
 ;Install Exchange File entries.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP80I")
 ;Enable options and protocols
 D OPTIONS^PXRMUTIL("ENABLE","Install of PXRM*2.0*80")
 D PROTCOLS^PXRMUTIL("ENABLE","Install of PXRM*2.0*80")
 Q
 ;
PRE ;Pre-init
 ;Disable options and protocols
 D OPTIONS^PXRMUTIL("DISABLE","Install of PXRM*2.0*80")
 D PROTCOLS^PXRMUTIL("DISABLE","Install of PXRM*2.0*80")
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP80I")
 Q
