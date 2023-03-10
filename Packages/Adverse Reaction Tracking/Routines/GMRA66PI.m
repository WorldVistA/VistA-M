GMRA66PI ;BIR/MFR - Clean up for problematic 120.86 records after patient merge ; 05/03/21 13:52
 ;;4.0;Adverse Reaction Tracking;**66**;Mar 29, 1996;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
EN ; Fix ADVERSE REACTION ASSESSMENT (#120.86) records
 N DFN,DFN01,VADM,X,L4SSN
 S GMRALINE=0 K ^TMP("GMRA66PI",$J)
 D SETTXT("When two patients are merged there is a possibility that the ADVERSE REACTION")
 D SETTXT("ASSESSMENT file (#120.86) entry for the 'TO' patient (patient that remains")
 D SETTXT("after the merge is complete) is corrupt.")
 D SETTXT(" ")
 D SETTXT("The patch GMRA*4*66 addressed the problem caused by the Kernel Patient Merge")
 D SETTXT("Utility and also fixed all the patients on file that currently have this")
 D SETTXT("problem at your site (if any). See list below:")
 D SETTXT("-------------------------------------------------------------------------------")
 D SETTXT("PATIENT                                     WRONG DFN VALUE   CORRECT DFN VALUE")
 D SETTXT("-------------------------------------------------------------------------------")
 D BMES^XPDUTL("  Starting post-install for GMRA*4*66")
 ;
 S (DFN,FOUND)=0
 F  S DFN=$O(^GMR(120.86,DFN)) Q:'DFN  D
 . S DFN01=$P($G(^GMR(120.86,DFN,0)),"^",1) I 'DFN01!(DFN01=DFN) Q
 . D BMES^XPDUTL("  Fixing entry #"_DFN_"...")
 . S $P(^GMR(120.86,DFN,0),"^",1)=DFN
 . S ^GMR(120.86,"B",DFN,DFN)=""
 . K ^GMR(120.86,"B",DFN01,DFN)
 . K VADM D DEM^VADPT S L4SSN=$P($P(VADM(2),"^",2),"-",3)
 . S X=$P(VADM(1),"^")_" ("_L4SSN_")",$E(X,49)=DFN01,$E(X,68)=DFN
 . D SETTXT(X) S FOUND=1
 ;
 I FOUND D
 . D SETTXT(" ")
 . D SETTXT("End of report.")
 E  D
 . D SETTXT("No problem found.")
 ;
 D SETTXT(" "),SETTXT("Please, run the Assessment clean up utility option [GMRA ASSESSMENT UTILITY]")
 D SETTXT("and address any remaining entries on the list.")
 D MAIL
 ;
 D BMES^XPDUTL("  Mailman message sent.")
 D BMES^XPDUTL("  Post-install completed for GMRA*4*66")
 ;
END ; Exit point
 K ^TMP("GMRA66PI",$J)
 Q
 ;
SETTXT(TXT) ; Setting Plain Text
 S GMRALINE=$G(GMRALINE)+1,^TMP("GMRA66PI",$J,GMRALINE)=TXT
 Q
 ;
SETRX(RXIEN,DOSE,UNITS,STREN) ; Setting Rx Line
 N TXTLN
 S $E(TXTLN,3)=$$GET1^DIQ(52,RXIEN,.01),$E(TXTLN,16)=$E($$GET1^DIQ(52,RXIEN,6),1,30)
 S $E(TXTLN,48)=$J(DOSE,7),$E(TXTLN,62)=$J(UNITS,4),$E(TXTLN,73)=$J(STREN,5)
 S GMRALINE=$G(GMRALINE)+1,^TMP("GMRA66PI",$J,GMRALINE)=TXTLN
 Q
 ;
MAIL ; Sends Mailman message
 N II,XMX,XMSUB,XMDUZ,XMTEXT,XMY
 S II=0 F  S II=$O(^XUSEC("PSNMGR",II)) Q:'II  S XMY(II)=""
 S XMY(DUZ)="",XMSUB="GMRA*4*66 - ADVERSE REACTION ASSESSMENT file (#120.86) Clean-up"
 S XMDUZ=.5,XMTEXT="^TMP(""GMRA66PI"",$J," N DIFROM D ^XMD
 Q
