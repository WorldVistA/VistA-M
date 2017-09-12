ECP113PT ;ALB/GTS/JAP/BR - PATCH EC*2.0*113 Post-Init Rtn ; 1/19/10 2:48pm
 ;;2.0;EVENT CAPTURE;**113**;8 May 96;Build 10
 ;
 Q
POST ; entry point
 N ECVRRV
 ;* if 725 converted, write message
 ;  since check inserted in addproc subroutine, patch may be re-installed
 I $$GET1^DID(725,"","","PACKAGE REVISION DATA")["EC*2*113" D
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL("It appears that the EC NATIONAL PROCEDURE")
 .D MES^XPDUTL("file (#725) has already been updated")
 .D MES^XPDUTL("with Patch EC*2*113.")
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL("But the patch may be re-installed...")
 .D MES^XPDUTL(" ")
 D ENTUP
 D F7203
 Q
 ;
ENTUP ; 
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Updating the National Procedures file (#725)...")
 D MES^XPDUTL(" ")
 ;* add new/edit national procedures
 D INACT  ;inactivate code
 ;* set VRRV node (file #725)
 S ECVRRV=$$GET1^DID(725,"","","PACKAGE REVISION DATA")
 S ECVRRV=ECVRRV_"^EC*2*113"
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
 ;; after installation of patch EC*2*113 which updated the EC NATIONAL
 ;; PROCEDURE file (#725).  This message provides the results of that
 ;; review.
 ;;
 ;; The EC EVENT CODE SCREENS file (#720.3) records indicated below
 ;; point to an inactive record in the EC NATIONAL PROCEDURE file
 ;; (#725).
 ;;
 ;; The user should use the Event Code Screen option in the Event Capture
 ;; GUI to inactivate the Event Code Screen.  If necessary, a new
 ;; Event Code Screen can be created using a currently active CPT code
 ;; or National Procedure.
 ;;
 ;;QUIT
 ;
F7203 ;* inspect/report 720.3
 D BMES^XPDUTL("Inspecting EC Event Code Screens file (#720.3)...")
 D BMES^XPDUTL("You will receive a MailMan message regarding file #720.3 ")
 D BMES^XPDUTL("  ")
 S ZTRTN="F7203Q^ECP113PT",ZTDESC="File #720.3 Review from EC*2*113",ZTIO=""
 S ZTDTH=$H,ZTREQ="@",ZTSAVE("ZTREQ")="" D ^%ZTLOAD
 Q
 ;
F7203Q ;* background job entry point
 N ECPTR,ECPROCT,EC01,ECSCDA,ECFILE,ECDATA,ECLOC,ECCAT,ECCATNM,ECUNIT,ECNAM,ECPROC,ECINACT,COUNT,TXTVAR
 S COUNT=0 K ^TMP($J,"ECP113")
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
 ..Q:(ECINACT<3111001)
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
 I ECPROCT=0 D
 .D LINE(" ")
 .D LINE(" "_ECPROCT_" Event Code Screens were found to be pointing to an inactive")
 .D LINE(" or soon to be inactive procedure in file #725.")
 .D LINE(" ")
 D MAIL
 K ^TMP($J,"ECP113"),I,Y
 Q
 ;
LINE(TEXT) ; Add line to message global
 S COUNT=COUNT+1,^TMP($J,"ECP113",COUNT)=TEXT
 Q
 ;
MAIL ; Send message
 N XMDUZ,XMY,XMTEXT,XMSUB
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="Event Code Screens to Review"
 S XMTEXT="^TMP($J,""ECP113"","
 D ^XMD
 Q
INACT ;* inactivate national procedures
 ;
 ;  ECXX is in format:
 ;   NATIONAL NUMBER^INACTIVATION DATE^FIRST NATIONAL NUMBER SEQUENCE^
 ;   LAST NATIONAL NUMBER SEQUENCE
 ;
 N ECX,ECXX,ECEXDT,ECINDT,ECDA,DIC,DIE,DA,DR,X,Y,%DT,ECBEG,ECEND,ECADD
 N ECSEQ,CODE,CODX
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Inactivating procedures EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 F ECX=1:1 K DD,DO,DA S ECXX=$P($T(OLD+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECEXDT=$P(ECXX,U,2),X=ECEXDT,%DT="X" D ^%DT S ECINDT=$P(Y,".",1)
 .S CODE=$P(ECXX,U),ECBEG=$P(ECXX,U,3),ECEND=$P(ECXX,U,4),CODX=CODE
 .I ECBEG="" D UPINACT Q
 .F ECSEQ=ECBEG:1:ECEND D
 ..S ECADD="000"_ECSEQ,ECADD=$E(ECADD,$L(ECADD)-2,$L(ECADD))
 ..S CODE=CODX_ECADD
 ..D UPINACT
 Q
UPINACT ;Update codes as inactive
 ;
 S ECDA=+$O(^EC(725,"D",CODE,0))
 I $D(^EC(725,ECDA,0)) D
 .S DA=ECDA,DR="2///^S X=ECINDT",DIE="^EC(725," D ^DIE
 .D MES^XPDUTL(" ")
 .D BMES^XPDUTL("   "_CODE_" inactivated as of "_ECEXDT_".")
 Q
 ;
OLD ;national procedures to be inactivated - national code #^inact. date
 ;;MH066^10/17/2011
 ;;MH067^10/17/2011
 ;;MH068^10/17/2011
 ;;MH069^10/17/2011
 ;;MH070^10/17/2011
 ;;MH071^10/17/2011
 ;;PM504^10/17/2011
 ;;PM505^10/17/2011
 ;;PM506^10/17/2011
 ;;PM507^10/17/2011
 ;;PM508^10/17/2011
 ;;PM509^10/17/2011
 ;;FE100^10/31/2011
 ;;FE101^10/31/2011
 ;;FE102^10/31/2011
 ;;FE103^10/31/2011
 ;;FE104^10/31/2011
 ;;FE105^10/31/2011
 ;;FE106^10/31/2011
 ;;FE107^10/31/2011
 ;;FE108^10/31/2011
 ;;FE109^10/31/2011
 ;;FE110^10/31/2011
 ;;FE111^10/31/2011
 ;;FE112^10/31/2011
 ;;FE113^10/31/2011
 ;;FE114^10/31/2011
 ;;FE115^10/31/2011
 ;;FE116^10/31/2011
 ;;FE117^10/31/2011
 ;;FE118^10/31/2011
 ;;FE119^10/31/2011
 ;;FE120^10/31/2011
 ;;FE121^10/31/2011
 ;;FE122^10/31/2011
 ;;FE123^10/31/2011
 ;;FE124^10/31/2011
 ;;FE125^10/31/2011
 ;;FE126^10/31/2011
 ;;FE127^10/31/2011
 ;;FE128^10/31/2011
 ;;FE129^10/31/2011
 ;;FE130^10/31/2011
 ;;FE131^10/31/2011
 ;;FE132^10/31/2011
 ;;FE133^10/31/2011
 ;;FE134^10/31/2011
 ;;FE135^10/31/2011
 ;;FE136^10/31/2011
 ;;FE137^10/31/2011
 ;;FE138^10/31/2011
 ;;FE139^10/31/2011
 ;;FE140^10/31/2011
 ;;FE141^10/31/2011
 ;;FE142^10/31/2011
 ;;FE143^10/31/2011
 ;;FE144^10/31/2011
 ;;FE145^10/31/2011
 ;;FE146^10/31/2011
 ;;FE147^10/31/2011
 ;;FE148^10/31/2011
 ;;FE149^10/31/2011
 ;;FE150^10/31/2011
 ;;FE151^10/31/2011
 ;;FE152^10/31/2011
 ;;FE153^10/31/2011
 ;;FE154^10/31/2011
 ;;FE155^10/31/2011
 ;;FE156^10/31/2011
 ;;FE157^10/31/2011
 ;;FE158^10/31/2011
 ;;FE159^10/31/2011
 ;;FE160^10/31/2011
 ;;FE161^10/31/2011
 ;;FE162^10/31/2011
 ;;FE163^10/31/2011
 ;;FE164^10/31/2011
 ;;FE165^10/31/2011
 ;;FE166^10/31/2011
 ;;FE167^10/31/2011
 ;;FE168^10/31/2011
 ;;FE169^10/31/2011
 ;;FE170^10/31/2011
 ;;FE171^10/31/2011
 ;;FE172^10/31/2011
 ;;FE173^10/31/2011
 ;;FE174^10/31/2011
 ;;FE175^10/31/2011
 ;;FE176^10/31/2011
 ;;FE177^10/31/2011
 ;;FE178^10/31/2011
 ;;FE179^10/31/2011
 ;;FE180^10/31/2011
 ;;FE181^10/31/2011
 ;;FE182^10/31/2011
 ;;FE183^10/31/2011
 ;;FE184^10/31/2011
 ;;FE185^10/31/2011
 ;;FE186^10/31/2011
 ;;FE187^10/31/2011
 ;;FE188^10/31/2011
 ;;FE189^10/31/2011
 ;;FE190^10/31/2011
 ;;FE191^10/31/2011
 ;;FE192^10/31/2011
 ;;FE193^10/31/2011
 ;;FE194^10/31/2011
 ;;FE195^10/31/2011
 ;;FE196^10/31/2011
 ;;FE197^10/31/2011
 ;;FE198^10/31/2011
 ;;FE199^10/31/2011
 ;;QUIT
 ;
