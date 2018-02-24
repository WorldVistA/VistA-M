PXRM68P ; ALB/ART - Inactivate MHV Reminders ;07/28/2017
 ;;2.0;CLINICAL REMINDERS;**68**;Feb 04, 2005;Build 2
 ;
 Q
 ;The purpose of this routine is to rescind old national reminders
 ;that are no longer needed. The name is changed to add "ZZVA" in the
 ;place of VA, and inactivate it.
 ;There are no linked reminder dialogs for these VA-MHA reminders.
 ;
 ;Public, Supported ICRs
 ; #2053 - Data Base Server API: Editing Utilities (DIE)
 ; #10141 - XPDUTL - Public APIs for KIDS
 ;=================================================
EN ;Start of loop for rescinding national reminders
 D BMES^XPDUTL("Rescinding outdated National Reminders")
 ;
 N II,OREM,OREMDA,PNAME,REM,PXRMN
 N TEMP,TEXT,ZZREM
 ;
 ;Update the reminders
 S PXRMN=$P($$NOW^XLFDT(),".")
 F II=1:1 S TEMP=$T(TEXT+II),OREM=$P(TEMP,";",3)  Q:OREM="END"  D
 . S ZZREM=$P(TEMP,";",4)
 . S OREMDA=+$O(^PXD(811.9,"B",OREM,0))
 . I OREMDA>0 D
 . . K REM
 . . S PNAME=$P($G(^PXD(811.9,OREMDA,0)),"^",3) ;get print name
 . . S REM(1,811.9,OREMDA_",",.01)=ZZREM ;name
 . . S REM(1,811.9,OREMDA_",",1.2)="ZZ "_PNAME ;print name
 . . S REM(1,811.9,OREMDA_",",1.6)=1 ;inactive flag
 . . ; inactive change date (1.7) is updated by trigger on inactive flag
 . . S REM(1,811.9,OREMDA_",",69)=PXRMN ;rescission date 
 . . D FILE^DIE("K","REM(1)")
 . . S TEXT(1)="Rescinding reminder: "_OREM
 . . S TEXT(2)="It was renamed to: "_ZZREM
 . . S TEXT(3)=""
 . . D BMES^XPDUTL(.TEXT)
 Q
 ;=================================================
TEXT ;
 ;;VA-MHV BMI > 25.0;ZZVA-MHV BMI > 25.0
 ;;VA-MHV CERVICAL CANCER SCREEN;ZZVA-MHV CERVICAL CANCER SCREEN
 ;;VA-MHV COLORECTAL CANCER SCREEN;ZZVA-MHV COLORECTAL CANCER SCREEN
 ;;VA-MHV DIABETES FOOT EXAM;ZZVA-MHV DIABETES FOOT EXAM
 ;;VA-MHV DIABETES HBA1C;ZZVA-MHV DIABETES HBA1C
 ;;VA-MHV DIABETES RETINAL EXAM;ZZVA-MHV DIABETES RETINAL EXAM
 ;;VA-MHV HYPERTENSION;ZZVA-MHV HYPERTENSION
 ;;VA-MHV INFLUENZA VACCINE;ZZVA-MHV INFLUENZA VACCINE
 ;;VA-MHV LDL CONTROL;ZZVA-MHV LDL CONTROL
 ;;VA-MHV LIPID MEASUREMENT;ZZVA-MHV LIPID MEASUREMENT
 ;;VA-MHV MAMMOGRAM SCREENING;ZZVA-MHV MAMMOGRAM SCREENING
 ;;VA-MHV PNEUMOVAX;ZZVA-MHV PNEUMOVAX
 ;;END
 Q
 ;=================================================
UNDO ;Undo all the changes
 N II,OREM,OREMDA,PNAME,TEMP,REM,ZZREM,ZZREMDA
 F II=1:1 S TEMP=$T(TEXT+II),OREM=$P(TEMP,";",3)  Q:OREM="END"  D
 . S ZZREM=$P(TEMP,";",4)
 . S OREMDA=+$O(^PXD(811.9,"B",OREM,0))
 . I OREMDA>0 Q
 . S ZZREMDA=+$O(^PXD(811.9,"B",ZZREM,0))
 . I ZZREMDA>0 D
 . . S PNAME=$P($G(^PXD(811.9,ZZREMDA,0)),"^",3)
 . . K REM
 . . S REM(1,811.9,ZZREMDA_",",.01)=OREM ;name
 . . S REM(1,811.9,ZZREMDA_",",1.2)=$P(PNAME,"ZZ ",$L(PNAME,"ZZ ")) ;print name
 . . S REM(1,811.9,ZZREMDA_",",1.6)="" ;inactive flag
 . . S REM(1,811.9,ZZREMDA_",",1.7)="" ;inactive change date
 . . S REM(1,811.9,ZZREMDA_",",69)="" ;rescission date
 . . D FILE^DIE("K","REM(1)")
 Q
 ;
