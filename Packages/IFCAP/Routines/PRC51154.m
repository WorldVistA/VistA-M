PRC51154 ;SSOI&TFO/LKG - POST-INIT PRC*5.1*154 ;1/5/11  16:02
 ;;5.1;IFCAP;**154**;OCT 20, 2000;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
POST ;Post-Init code to index new AF cross reference in INVOICE TRACKING file (#421.5)
 L +^PRCF(421.5):30
 K ^PRCF(421.5,"AF")
 N DIK S DIK="^PRCF(421.5,",DIK(1)="61.9^AF" D ENALL^DIK
 L -^PRCF(421.5)
 Q
