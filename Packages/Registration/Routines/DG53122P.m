DG53122P ;ALB/RMO/CJM - Initial Extract Post Install Updates; 10/14/97
 ;;5.3;Registration;**122**;Aug 13, 1993
 ;
EN ;
 ;-- re-compile input templates
 D COMP
 Q
 ;
COMP ;-- Re-compile input templates
 ;
 N DGCOUNT,X,Y,DMAX,DGNAME,DGMAX
 S DGMAX=$$ROUSIZE^DILF
 D MES^XPDUTL("Recompiling affected input templates ...")
 F DGCOUNT=1:1 S DGNAME=$P($T(TEMP+DGCOUNT),";;",2) Q:DGNAME=""  D
 .;
 .;find the ien of the input template
 .S Y=$O(^DIE("B",DGNAME,0))
 .Q:('Y)
 .;
 .;quit if input template not compiled
 .S X=$P($G(^DIE(Y,"ROUOLD")),"^")
 .Q:(X="")
 .;
 .D MES^XPDUTL("Compiling "_DGNAME_" , compiled routine is "_X_" ...")
 .S DMAX=DGMAX
 .D EN^DIEZ
 .D MES^XPDUTL("done")
 D MES^XPDUTL("Completed compiling input templates")
 Q
 ;
TEMP ;
 ;;DVBA C ADD 2507 PAT
 ;;DG101
 ;;DVBHINQ UPDATE
 ;;IB SCREEN1
 ;;DGRPT 10-10T REGISTRATION
 ;;SDM1
 ;;DG LOAD EDIT SCREEN 7
