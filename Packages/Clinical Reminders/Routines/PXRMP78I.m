PXRMP78I ;ISP/AGP - PATCH 78 INSTALLATION ;02/23/2022
 ;;2.0;CLINICAL REMINDERS;**78**;Feb 04, 2005;Build 10
 ;
 ;
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-SEXUAL ORIENTATION"
 I MODE["I" S ARRAY(LN,2)="02/23/2022@15:14:17"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 Q
 ;
POST ;Post-init
 ;Install Exchange File entries.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP78I")
 ;Enable options and protocols
 D OPTIONS^PXRMUTIL("ENABLE","Install of PXRM*2.0*78")
 D PROTCOLS^PXRMUTIL("ENABLE","Install of PXRM*2.0*78")
 Q
 ;
PRE ;Pre-init
 ;Disable options and protocols
 D OPTIONS^PXRMUTIL("DISABLE","Install of PXRM*2.0*78")
 D PROTCOLS^PXRMUTIL("DISABLE","Install of PXRM*2.0*78")
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP78I")
 Q
