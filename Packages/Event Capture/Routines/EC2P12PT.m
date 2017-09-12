EC2P12PT ;ALB/GTS/JAP - PATCH EC*2.0*12 Post-Init Rtn ; 5/8/98
 ;;2.0; EVENT CAPTURE ;**12**;8 May 96
 ;
POST ; entry point
 N ECVRRV
 ;* if 725 converted, write message
 ;  since check inserted in addproc subroutine, patch may be re-installed
 I $$GET1^DID(725,"","","PACKAGE REVISION DATA")["EC*2*12" D
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL("It appears that the EC NATIONAL PROCEDURE")
 .D MES^XPDUTL("file (#725) has already been updated")
 .D MES^XPDUTL("with Patch EC*2*12.")
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL("But the patch may be re-installed...")
 .D MES^XPDUTL(" ")
 .D ENTUP
 .D F7203
 ;* continue with conversion/update
 I $$GET1^DID(725,"","","PACKAGE REVISION DATA")'["EC*2*12" D
 .D ENTUP
 .D F7203
 Q
 ;
ENTUP ; 
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Updating the National Procedures file (#725)...")
 D MES^XPDUTL(" ")
 ;* inactivate national procedures
 D INACT^EC725CH5
 ;* change name of national procedures
 D NAMECHG^EC725CH6
 ;* change CPT codes for national procedures
 D CPTCHG^EC725CH5
 ;* add new national procedures
 D ADDPROC^EC725CH6
 ;* set vrrv node (file #725)
 S ECVRRV=$$GET1^DID(725,"","","PACKAGE REVISION DATA")
 S ECVRRV=ECVRRV_"^EC*2*12"
 D PRD^DILFD(725,ECVRRV)
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Update of EC NATIONAL PROCEDURE file (#725)")
 D BMES^XPDUTL("   completed...")
 D MES^XPDUTL(" ")
 Q
 ;
MSGTXT ; Message intro
 ;; Please forward this message to your local DSS Site Manager or
 ;; Event Capture ADPAC.
 ;;
 ;; A review of the EC EVENT CODE SCREENS file (#720.3) was done
 ;; after installation of patch EC*2*12 which updated the EC NATIONAL
 ;; PROCEDURE file (#725).  This message provides the results of that
 ;; review.
 ;;
 ;; The EC EVENT CODE SCREENS file (#720.3) records indicated below
 ;; point to an inactive record in the EC NATIONAL PROCEDURE file 
 ;; (#725) or to an inactive record in the CPT file (#81).
 ;;    
 ;; The user should use the Inactivate Event Code Screens [ECNACT]
 ;; option to inactivate the Event Code Screen.  If necessary, a new
 ;; Event Code Screen can be created using a currently active CPT code
 ;; or National Procedure.
 ;;   
 ;;QUIT
 ;
F7203 ;* inspect/report 720.3
 D BMES^XPDUTL("Inspecting EC Event Code Screens file (#720.3)...")
 D BMES^XPDUTL("You will receive a MailMan message regarding file #720.3.")
 D BMES^XPDUTL("  ")
 S ZTRTN="F7203Q^EC2P12PT",ZTDESC="File #720.3 Review from EC*2*12",ZTIO=""
 S ZTDTH=$H,ZTREQ="@",ZTSAVE("ZTREQ")="" D ^%ZTLOAD
 Q
 ;
F7203Q ;* background job entry point
 N ECPTR,ECPROCT,EC01,ECSCDA,ECFILE,ECDATA,ECLOC,ECCAT,ECCATNM,ECUNIT,ECNAM,ECPROC,ECINACT,ECWORD,COUNT,TXTVAR
 S COUNT=0 K ^TMP($J,"EC2P12")
 F I=1:1 S TXTVAR=$P($T(MSGTXT+I),";;",2) Q:TXTVAR="QUIT"  D LINE(TXTVAR)
 S (EC01,ECPROCT)=0
 F  S EC01=$O(^ECJ("B",EC01)) Q:+EC01=0  D
 .S ECPTR=$P(EC01,"-",4)
 .S ECSCDA=$O(^ECJ("B",EC01,0))
 .Q:'$D(^ECJ(ECSCDA,0))
 .S ECWORD="" I ($P(^ECJ(ECSCDA,0),"^",2)'="")&(+$P(^ECJ(ECSCDA,0),"^",2)<DT) S ECWORD="*inactive*"
 .S ECLOC=$P(EC01,"-",1)
 .S ECUNIT=$P(EC01,"-",2)
 .S ECCAT=$P(EC01,"-",3)
 .S ECLOC=$P($G(^DIC(4,ECLOC,0)),"^",1)
 .S ECUNIT=$P($G(^ECD(ECUNIT,0)),"^",1)
 .S:+ECCAT'=0 ECCATNM=$P($G(^EC(726,ECCAT,0)),"^",1)
 .S:+ECCAT=0 ECCATNM="None"
 .S ECFILE=$P(ECPTR,";",2)
 .I ECFILE["EC(725" S ECDATA=$G(^EC(725,$P(ECPTR,";",1),0)) D
 ..S ECINACT=$P(ECDATA,"^",3)
 ..Q:ECINACT=""
 ..I ECINACT<DT D
 ...S ECPROC=$P(ECDATA,"^",1)_" ("_$P(ECDATA,"^",2)_")",ECNAM=$P(^ECJ(ECSCDA,0),";",1)
 ...D LINE(" ")
 ...D LINE(" The National Procedure for the following "_ECWORD)
 ...D LINE(" Event Code Screen ("_ECNAM_") is inactive --")
 ...D LINE("  Location:  "_ECLOC)
 ...D LINE("  Category:  "_ECCATNM)
 ...D LINE("  DSS Unit:  "_ECUNIT)
 ...D LINE("  Procedure: "_ECPROC)
 ...S ECPROCT=ECPROCT+1
 .I ECFILE["ICPT" S ECDATA=$G(^ICPT($P(ECPTR,";",1),0)) D
 ..S ECINACT=$P(ECDATA,"^",4)
 ..Q:ECINACT=""
 ..S ECPROC=$P(ECDATA,"^",2)_" ("_$P(ECDATA,"^",1)_")",ECNAM=$P(^ECJ(ECSCDA,0),";",1) D
 ...D LINE(" ")
 ...D LINE(" The CPT procedure for the following "_ECWORD)
 ...D LINE(" Event Code Screen ("_ECNAM_") is inactive --")
 ...D LINE("  Location:  "_ECLOC)
 ...D LINE("  Category:  "_ECCATNM)
 ...D LINE("  DSS Unit:  "_ECUNIT)
 ...D LINE("  Procedure: "_ECPROC)
 ...S ECPROCT=ECPROCT+1
 I ECPROCT=0 D
 .D LINE(" ")
 .D LINE("No Event Code Screens were found to be associated with inactive")
 .D LINE("National Procedures or inactive CPT codes.")
 D MAIL
 ;D MES^XPDUTL(" ")
 ;D MES^XPDUTL(" "_ECPROCT_" active Event Code Screens were found to be pointing")
 ;D MES^XPDUTL(" to inactive procedures in file #725 or file #81.")
 ;D MES^XPDUTL(" ")
 K ^TMP($J,"EC2P12")
 Q
 ;
LINE(TEXT) ; Add line to message global
 S COUNT=COUNT+1,^TMP($J,"EC2P12",COUNT)=TEXT
 Q
 ;
MAIL ; Send message
 N XMDUZ,XMY,XMTEXT,XMSUB
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="Event Code Screens to Review"
 S XMTEXT="^TMP($J,""EC2P12"","
 D ^XMD
 Q
