PSO7P570 ;AITC/GN-Post install to alter ERX DD'S to Fileman user RD accessible ;8/07/18 10:00am
 ;;7.0;OUTPATIENT PHARMACY;**570**;13 Feb 97;Build 8
 ;
 ; Routine should be deleted after install.
 Q
EN ; Entry point
 N SEC,ERXFIL,ERR
 D BMES^XPDUTL()
 D MES^XPDUTL("Marking ERX files Fileman Read accessible for Users and Supervisors.")
 D BMES^XPDUTL()
 S SEC("RD")="Pp"      ;P = Std user  p = Supervisor user
 F ERXFIL=52.45:.01:52.49 K ERR D FILESEC^DDMOD(ERXFIL,.SEC,.ERR) D
 . I '$D(ERR) D BMES^XPDUTL(),MES^XPDUTL($P($G(^DIC(ERXFIL,0)),"^")_" file #"_ERXFIL_" marked.")
 . I $D(ERR) D BMES^XPDUTL(),MES^XPDUTL($P($G(^DIC(ERXFIL,0)),"^")_" file #"_ERXFIL_" NOT marked.")
 D BMES^XPDUTL()
 Q
