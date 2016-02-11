PSO7P370 ;VGH - Patch 370 Post Install routine;4/1/2014
 ;;7.0;OUTPATIENT PHARMACY;**370**;DEC 1997;Build 14
 ;
 ;External reference ^DD(52 supported by DBIA 6034
 ;
 Q
 ;
RH ;Remove HELP-PROMPT for LABEL DATE/TIME - Since this is a multiple, it should not have help text
 ;^DD(52,32,3)="Enter date/time when and if medication was returned to inventory due not being icked up or mailed to the patient."
 S X1=DT,X2=+30 D C^%DTC
 S ^XTMP("PSO7P370",0)=$G(X)_"^"_DT_"^HELP-PROMPT DELETION^"
 S ^XTMP("PSO7P370",1)="^DD(52,32,3)=Enter date/time when and if medication was returned to inventory due not being icked up or mailed to the patient."
 K ^DD(52,32,3)
 Q
