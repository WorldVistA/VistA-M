PSB3P103 ;AITC/CR - POST INIT FOR PATCH PSB*3*103 ;2/27/18 9:18am
 ;;3.0;BAR CODE MED ADMIN;**103**;Mar 2004;Build 21
 ;Per VA Directive 6402, this routine should not be modified
 ;
 ; call to: $$ADD^XPDMENU - supported by ICR #1157
 ;          BMES^XPDUTL   - supported by ICR #10141
 ;
POST ; set up the new option for the report 'Report for Respiratory Therapists',
 ; the option name is [PSB RPT RESP THERAPY MEDS] and the menu receiving it is
 ; [PSB PHARMACY]
 ;
 D BMES^XPDUTL("Starting Post-installation operations for patch PSB*3.0*103...")
 D ADD1
 D EXIT
 Q
 ;
ADD1 ; update menu [PSB PHARMACY]
 N PSBOK,PSBSYN
 S PSBSYN=12
 S PSBOK=$$ADD^XPDMENU("PSB PHARMACY","PSB RPT RESP THERAPY MEDS",PSBSYN)
 I PSBOK=1 D
 . D BMES^XPDUTL("[PSB RPT RESP THERAPY MEDS] Option is part of [PSB PHARMACY]")
 E  D  G ERR
 . D BMES^XPDUTL("Couldn't add option [PSB RPT RESP THERAPY MEDS] to [PSB PHARMACY]")
 Q
 ;
ERR ; alert the user if there is an error
 D BMES^XPDUTL("Unable to attach the menu option")
 Q
 ;
EXIT ;
 D BMES^XPDUTL("Finished Post-installation of patch PSB*3.0*103.")
 Q
