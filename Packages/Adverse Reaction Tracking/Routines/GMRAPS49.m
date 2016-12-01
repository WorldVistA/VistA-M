GMRAPS49 ;BPOIFO/HW - Patient Allergies with comments containing carriage returns; 5/05/16 3:42pm
 ;;4.0;Adverse Reaction Tracking;**49**;Mar 29, 1996;Build 2
 ;
 ;      This routine uses the following IAs:
 ;      #10061 - DEM^VADPT         (supported)
 ;      #10070 - ^XMD              (supported)
 ;      #4440  - PROD^XUPROD       (supported)
 ;      #10112 - SITE^VASITE       (supported)
 Q  ;Must be called at entry point
EN N GMRAIEN,DFN,GMRTOTAL,DIFROM
 K ^TMP("GMRA",$J)
 S GMRAIEN=0,GMRTOTAL=0
 D BMES^XPDUTL("   PATIENT ALLERGY RECORDS WITH CARRIAGE RETURNS IN COMMENTS")
 D MES^XPDUTL("          (CARRIAGE RETURNS REMOVED BY THIS PATCH)")
 D BMES^XPDUTL("                                                                       ")
 D BMES^XPDUTL("DFN         Patient Allergy IEN   Reactant                               ")
 D MES^XPDUTL("                                                                       ")
 S ^TMP("GMRA",$J,1)="        ****ATTENTION Pharmacy Manager or ADPAC****"
 S ^TMP("GMRA",$J,2)="                                                   "
 S ^TMP("GMRA",$J,3)="Please review the records in this report/mail message and edit these patient "
 S ^TMP("GMRA",$J,4)="allergy records to trigger a new HL7 message to HDR. Use the GMRA PATIENT "
 S ^TMP("GMRA",$J,5)="A/AR EDIT [Enter/Edit Patient Reaction Data] option to select the affected "
 S ^TMP("GMRA",$J,6)="records. You will need the GMRA-ALLERGY VERIFY key to complete this action:"
 S ^TMP("GMRA",$J,7)="  "
 S ^TMP("GMRA",$J,8)="    Select PATIENT NAME:`(enter the grave accent followed by a DFN from report"
 S ^TMP("GMRA",$J,9)="    below)"
 S ^TMP("GMRA",$J,10)="        (List of reactants displays here)"
 S ^TMP("GMRA",$J,11)="    Enter Causative Agent: (enter corresponding Reactant from report below)"
 S ^TMP("GMRA",$J,12)="        (Allergy Information displays here)"
 S ^TMP("GMRA",$J,13)="    Is the reaction information correct? Yes//   (Yes)"
 S ^TMP("GMRA",$J,14)="    DO YOU WISH TO EDIT VERIFIED DATA? NO// YES"
 S ^TMP("GMRA",$J,15)="        (Allergy Data displays here)"
 S ^TMP("GMRA",$J,16)="    Would you like to edit any of this data? YES"
 S ^TMP("GMRA",$J,17)="  "
 S ^TMP("GMRA",$J,18)="Then accept all existing values. When asked again ""Would you like to edit any"
 S ^TMP("GMRA",$J,19)="of this data?"" respond ""NO"" to end the correction process. This will update"
 S ^TMP("GMRA",$J,20)="the data in HDR. When completed please notify Pharmacy Benefits Management"
 S ^TMP("GMRA",$J,21)="Services by replying to this message (send to Silverman.Robert@DOMAIN.EXT)."
 S ^TMP("GMRA",$J,22)="Please include your site information in the message. "
 S ^TMP("GMRA",$J,23)="                                                   "
 S ^TMP("GMRA",$J,24)="  PATIENT ALLERGY RECORDS WITH CARRIAGE RETURNS IN COMMENTS"
 S ^TMP("GMRA",$J,25)="       (CARRIAGE RETURNS REMOVED BY PATCH GMRA*4.0*49)      "
 S ^TMP("GMRA",$J,26)="                                                   "
 S ^TMP("GMRA",$J,27)="DFN"_"         Patient Allergy IEN"_"   Reactant   "
 D FIND(.GMRTOTAL)
 S GMRASITE=$$SITE^VASITE
 S GMRASTNM=$P($G(GMRASITE),"^",2)
 S GMRASTN=$P($G(GMRASITE),"^",3)
 I GMRTOTAL'<1 D
 .S GMRAGLNR=GMRTOTAL+31
 .S ^TMP("GMRA",$J,GMRAGLNR)="  "
 .S ^TMP("GMRA",$J,GMRAGLNR+1)="  "
 .S ^TMP("GMRA",$J,GMRAGLNR+2)="  "
 .S ^TMP("GMRA",$J,GMRAGLNR+3)="Site Name: "_GMRASTNM
 .S ^TMP("GMRA",$J,GMRAGLNR+4)="Station: "_GMRASTN
 I GMRTOTAL<1 D
 .D BMES^XPDUTL("  No records with carriage returns found. NO FURTHER ACTION IS NEEDED.")
 .D BMES^XPDUTL("                                                                       ")
 .S ^TMP("GMRA",$J,28)="  "
 .S ^TMP("GMRA",$J,29)="  No records with carriage returns found. NO FURTHER ACTION IS NEEDED."
 .S ^TMP("GMRA",$J,30)="  "
 .S ^TMP("GMRA",$J,31)="  "
 .S ^TMP("GMRA",$J,32)="Site Name: "_GMRASTNM
 .S ^TMP("GMRA",$J,33)="Station: "_GMRASTN
 S XMSUB="ACTION REQUIRED GMRA*4*49 Post-Install Results"
 I GMRTOTAL<1 S XMSUB="GMRA*4*49 Post-Install Results"
 S XMTEXT="^TMP(""GMRA"",$J,",XMY(DUZ)=""
 I $$PROD^XUPROD S XMY("Silverman.Robert@DOMAIN.EXT")="" ;only send to PBM from prod
 S XMY("Wolf.Honorata@DOMAIN.EXT")=""
 S USR=0 F  S USR=$O(^XUSEC("GMRA-ALLERGY VERIFY",USR)) Q:'USR  S XMY(USR)=""
 S XMDUZ="GMRA*4.0*49 POST INSTALL"
 D BMES^XPDUTL("                                                                       ")
 D BMES^XPDUTL("                                                                       ")
 D BMES^XPDUTL("                                                                       ")
 D MES^XPDUTL("A copy of this report (with instructions) has been sent to the appropriate recipients")
 D ^XMD K XMSUB,XMTEXT,XMY,USR,XMDUZ,GMRAGLNR,GMRASITE,GMRASTN,GMRASTNM
 Q
FIND(GMRTOTAL) ;Check 120.8 for carriage returns in comments
 N GMRAX,DFN,VADM,VA,GMRASP1,GMRASPN1,GMRASP2,GMRASPN2,GMRAREAC
 N GMRAIEN,GMRSEC,GMRTHIRD,DFN
 S GMRAIEN=0,GMRTOTAL=0
 F  S GMRAIEN=$O(^GMR(120.8,GMRAIEN)) Q:GMRAIEN'>0  D
 .;Exclude if patient has Date of Death
 .S DFN=$P($G(^GMR(120.8,GMRAIEN,0)),"^",1)
 .I DFN>0 D
 ..D DEM^VADPT
 ..I $G(VADM(6))>0 Q
 .;Check Comments field
 .S GMRSEC=0
 .F  S GMRSEC=$O(^GMR(120.8,GMRAIEN,26,GMRSEC)) Q:GMRSEC'>0  D
 ..S GMRTHIRD=0
 ..F  S GMRTHIRD=$O(^GMR(120.8,GMRAIEN,26,GMRSEC,2,GMRTHIRD)) Q:GMRTHIRD'>0  D
 ...I ^GMR(120.8,GMRAIEN,26,GMRSEC,2,GMRTHIRD,0)'[$C(13) Q
 ...S ^GMR(120.8,GMRAIEN,26,GMRSEC,2,GMRTHIRD,0)=$TR(^GMR(120.8,GMRAIEN,26,GMRSEC,2,GMRTHIRD,0),$C(13)," ") ;Replace <CR> with space
 ...S ^GMR(120.8,GMRAIEN,26,GMRSEC,2,GMRTHIRD,0)=$TR(^GMR(120.8,GMRAIEN,26,GMRSEC,2,GMRTHIRD,0),$C(10)," ") ;Replace <LF> with space
 ...S GMRTOTAL=GMRTOTAL+1
 ...S GMRAREAC=$P($G(^GMR(120.8,GMRAIEN,0)),"^",2)
 ...S GMRASP1="",GMRASP2=""
 ...S GMRASPN1=12-$L(DFN) F GMRAX=1:1:GMRASPN1 S GMRASP1=GMRASP1_" "
 ...S GMRASPN2=34-$L(GMRAIEN)-$L(DFN)-$L(GMRASP1) F GMRAX=1:1:GMRASPN2 S GMRASP2=GMRASP2_" "
 ...S ^TMP("GMRA",$J,GMRTOTAL+28)=DFN_GMRASP1_GMRAIEN_GMRASP2_GMRAREAC
 ...D MES^XPDUTL(DFN_GMRASP1_GMRAIEN_GMRASP2_GMRAREAC)
 Q
