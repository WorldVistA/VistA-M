SDPST746 ;;MS/PB - CCRA PRE INSTALL;MARCH 26, 2020
 ;;5.3;Scheduling;**746**;MARCH 26, 2020;Build 85
 ;;Per VA directive 6402, this routine should not be modified.
 ;Set up routine for patch SD*5.3*746.
 ;Adds the TELE HEALTH MANAGEMENT entry to the VistA REMOTE APPLICATION File.
 Q
REMAPP ; update the Remote Application file
 N VAL,LIEN,SDERR1,OPTIEN
 S OPTIEN=$$FIND1^DIC(19,,"B","SDECRPC")
 I $G(OPTIEN)'>0 D MES^XPDUTL("The SDECRPC Option is not in the OPTION FILE.") G EXIT
 S VAL="TELE HEALTH MANAGEMENT"
 S LIEN=$$FIND1^DIC(8994.5,,"B",.VAL)
 I +$G(LIEN)>0 D
 .S FDA(8994.5,LIEN_",",.01)="TELE HEALTH MANAGEMENT"
 .S FDA(8994.5,LIEN_",",.02)=$G(OPTIEN)
 .S FDA(8994.5,LIEN_",",.03)="zxDT60uA8f3XQwarbmFS8YIrGUUblZ66RIui0LK+sis="
 .D UPDATE^DIE(,"FDA",$G(LIEN)_",","SDERR") K FDA
 G:$G(LIEN)>0 EXIT
 I $G(LIEN)'>0 D
 .K DIC,DIC(0),X,Y,DLAYGO
 .S DIC="^XWB(8994.5,",DLAYGO=8994.5,DIC(0)="L",X="TELE HEALTH MANAGEMENT" D FILE^DICN
 .I +$G(Y)'>0 D MES^XPDUTL("Unable to create the new Remote Application File entry.") G EXIT
 .S:+$G(Y)>0 LIEN=+Y
 .S FDA(8994.5,LIEN_",",.01)="TELE HEALTH MANAGEMENT"
 .S FDA(8994.5,LIEN_",",.02)=$G(OPTIEN)
 .S FDA(8994.5,LIEN_",",.03)="zxDT60uA8f3XQwarbmFS8YIrGUUblZ66RIui0LK+sis="
 .D UPDATE^DIE(,"FDA","SDERR1")
 I $D(SDERR1) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when adding the TELE HEALTH MANAGEMENT app to the Remote Application File.")
 D MES^XPDUTL("TELE HEALTH MANAGEMENT has been added as an app in the REMOTE APPLICATION FILE.")
EXIT ;
 K FDA,LIEN,Y,X,DIC,DIC(0),DLAYGO,VAL
 Q
