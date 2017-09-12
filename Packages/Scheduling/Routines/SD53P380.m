SD53P380 ;ALB/JAM - Restricting Stop Code Phase II Post Install;12-Jan-05
 ;;5.3;Scheduling;**380**;Aug 13, 1993
 ;
 ;Routine adapted from routine IB20P210
 ;
EN ;Recompile Input Templates
 N SDC,DMAX,SDMAX,SDN
 ;
 S SDMAX=$$ROUSIZE^DILF
 D MES^XPDUTL("Recompiling affected input template ...")
 F SDC=1:1 S SDN=$P($T(TMPL+SDC),";;",2) Q:SDN=""  D COMP(SDN,SDMAX)
 D MES^XPDUTL("Completed compiling input template.")
 Q
 ;
COMP(TNAME,DMAX) ; Compile the Input Template
 N SDIEN,SDRTN,X,Y
 ;find the ien of the input template
 S SDIEN=$O(^DIE("B",TNAME,0)) Q:'SDIEN
 ;
 ;quit if input template not compiled
 S SDRTN=$P($G(^DIE(SDIEN,"ROUOLD")),U) Q:SDRTN=""
 ;
 D MES^XPDUTL("Compiling "_TNAME_" , compiled routine is "_SDRTN_" ...")
 S X=SDRTN,Y=SDIEN
 D EN^DIEZ
 D MES^XPDUTL("done")
 D MES^XPDUTL("")
 Q
 ;
TMPL ;
 ;;SDB
 ;;
