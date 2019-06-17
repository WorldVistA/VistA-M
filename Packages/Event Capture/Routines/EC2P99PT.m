EC2P99PT ;ALB/GTS/JAP/GT - PATCH EC*2.0*99 Post-Init Rtn ;12/16/2008
 ;;2.0; EVENT CAPTURE ;**99**;8 May 96;Build 2
 ;
POST ; entry point
 N ECVRRV
 ;* if 725 converted, write message
 ;  since check inserted in addproc subroutine, patch may be re-installed
 I $$GET1^DID(725,"","","PACKAGE REVISION DATA")["EC*2*99" D
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL("It appears that the EC NATIONAL PROCEDURE")
 .D MES^XPDUTL("file (#725) has already been updated")
 .D MES^XPDUTL("with Patch EC*2*99.")
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL("But the patch may be re-installed...")
 .D MES^XPDUTL(" ")
 D ENTUP
 D F7203
 D KILL1
 Q
 ;
ENTUP ; 
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Updating the National Procedures file (#725)...")
 D MES^XPDUTL(" ")
 ;* add new/edit national procedures
 D ADDPROC^EC725U54  ;add new procedures
 D NAMECHG^EC725U54  ;change desription
 D CPTCHG^EC725U55  ;change CPT code
 D INACT^EC725U55  ;inactivate code
 D REACT^EC725U55    ;reactivate code
 ;* set vrrv node (file #725)
 S ECVRRV=$$GET1^DID(725,"","","PACKAGE REVISION DATA")
 S ECVRRV=ECVRRV_"^EC*2*99"
 D PRD^DILFD(725,ECVRRV)
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Update of EC NATIONAL PROCEDURE file (#725)")
 D BMES^XPDUTL("   completed...")
 D MES^XPDUTL(" ")
 Q
MSGTXT ; Message intro
 ;; Please forward this message to your local DSS Site Manager or
 ;; Event Capture ADPAC.;; Event Capture ADPAC.
 ;;
 ;; A review of the EC EVENT CODE SCREENS file (#720.3) was done
 ;; after installation of patch EC*2*99 which updated the EC NATIONAL
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
 D BMES^XPDUTL("You will receive a MailMan message regarding file #720.3^ ")
 D BMES^XPDUTL("  ")
 S ZTRTN="F7203Q^EC2P99PT",ZTDESC="File #720.3 Review from EC*2*99",ZTIO=""
 S ZTDTH=$H,ZTREQ="@",ZTSAVE("ZTREQ")="" D ^%ZTLOAD
 Q
 ;
F7203Q ;* background job entry point
 N ECPTR,ECPROCT,EC01,ECSCDA,ECFILE,ECDATA,ECLOC,ECCAT,ECCATNM,ECUNIT,ECNAM,ECPROC,ECINACT,COUNT,TXTVAR
 S COUNT=0 K ^TMP($J,"EC2P99")
 F I=1:1 S TXTVAR=$P($T(MSGTXT+I),";;",2) Q:TXTVAR="QUIT"  D LINE(TXTVAR)
 S (EC01,ECPROCT)=0
 F  S EC01=$O(^ECJ("B",EC01)) Q:+EC01=0  D
 .S ECPTR=$P(EC01,"-",4),ECSCDA=$O(^ECJ("B",EC01,0))
 .Q:'$D(^ECJ(ECSCDA,0))
 .;ignore any ec screen that has been inactivated
 .Q:+$P(^ECJ(ECSCDA,0),"^",2)
 .S ECFILE=$P(ECPTR,";",2)
 .;ec screens pointing to file #725
 .I ECFILE["EC(725" S ECDATA=$G(^EC(725,$P(ECPTR,";",1),0)) D
 ..S ECINACT=$P(ECDATA,U,3)
 ..Q:ECINACT=""
 ..;ignore if procedure inactivated before this fiscal year
 ..Q:(ECINACT<3090101)
 ..S Y=ECINACT D DD^%DT S ECINACT=Y
 ..S ECLOC=$P(EC01,"-",1),ECUNIT=$P(EC01,"-",2),ECCAT=$P(EC01,"-",3)
 ..S ECLOC=$P($G(^DIC(4,ECLOC,0)),U,1),ECUNIT=$P($G(^ECD(ECUNIT,0)),U,1)
 ..S:+ECCAT'=0 ECCATNM=$P($G(^EC(726,ECCAT,0)),U,1)
 ..S:+ECCAT=0 ECCATNM="None"
 ..S ECPROC=$P(ECDATA,U,1)_" ("_$P(ECDATA,U,2)_")"
 ..S ECNAM=$P(^ECJ(ECSCDA,0),";",1)
 ..D LINE(" ")
 ..D LINE(" The National Procedure for the following Event Code")
 ..D LINE(" Screen ("_ECNAM_") is inactive or will soon be inactive --")
 ..D LINE("  Location:  "_ECLOC)
 ..D LINE("  Category:  "_ECCATNM)
 ..D LINE("  DSS Unit:  "_ECUNIT)
 ..D LINE("  Procedure: "_ECPROC)
 ..D LINE("  Inactivation Date: "_ECINACT)
 ..S ECPROCT=ECPROCT+1
 .;ec screens pointing to file #81
 .I ECFILE["ICPT" S ECDATA=$G(^ICPT($P(ECPTR,";",1),0)) D
 ..S ECINACT=$P(ECDATA,U,4)
 ..Q:ECINACT=""
 ..S ECLOC=$P(EC01,"-",1),ECUNIT=$P(EC01,"-",2),ECCAT=$P(EC01,"-",3)
 ..S ECLOC=$P($G(^DIC(4,ECLOC,0)),U,1),ECUNIT=$P($G(^ECD(ECUNIT,0)),U,1)
 ..S:+ECCAT'=0 ECCATNM=$P($G(^EC(726,ECCAT,0)),U,1)
 ..S:+ECCAT=0 ECCATNM="None"
 ..S ECPROC=$P(ECDATA,U,2)_" ("_$P(ECDATA,U,1)_")",ECNAM=$P(^ECJ(ECSCDA,0),";",1)
 ..D LINE(" ")
 ..D LINE(" The CPT procedure for the following Event")
 ..D LINE(" Code Screen ("_ECNAM_") is inactive --")
 ..D LINE("  Location:  "_ECLOC)
 ..D LINE("  Category:  "_ECCATNM)
 ..D LINE("  DSS Unit:  "_ECUNIT)
 ..D LINE("  Procedure: "_ECPROC)
 ..S ECPROCT=ECPROCT+1
 I ECPROCT=0 D
 .D LINE(" ")
 .D LINE(" "_ECPROCT_" Event Code Screens were found to be pointing to aninactive")
 .D LINE(" or soon to be inactive procedure in file #725 or file #81.")
 .D LINE(" ")
 D MAIL
 K ^TMP($J,"EC2P99"),I,Y
 Q
 ;
LINE(TEXT) ; Add line to message global
 S COUNT=COUNT+1,^TMP($J,"EC2P99",COUNT)=TEXT
 Q
 ;
MAIL ; Send message
 N XMDUZ,XMY,XMTEXT,XMSUB
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="Event Code Screens to Review"
 S XMTEXT="^TMP($J,""EC2P99"","
 D ^XMD
 Q
KILL1 ;
 K ZTDESC,ZTDTH,ZTIO,ZTREQ,ZTRTN,ZTSAVE("ZTREQ")
 Q
