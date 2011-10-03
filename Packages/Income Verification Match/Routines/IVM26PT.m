IVM26PT ;ALB/SEK - POST-INSTALL FOR PATCH IVM*2.0*6 ; 27-AUG-96
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;**6**; 21-OCT-94
 ;
 ;
 ;This routine will run as the post-install for patch IVM*2.0*6.
 ;The DHCP LOCATION LOGIC field (#10) and the DHCP OUTPUT LOGIC
 ;field (#20) will be modified in the IVM DEMOGRAPHIC UPLOAD FIELDS
 ;file (#301.92).
 ;Notification will be sent to the IVM Center that that the facility
 ;has installed the patch.
 ;
EN ;begin processing
 D SETFILE
 D SENDNOT
 Q
 ;
SETFILE ;modify IVM DEMOGRAPHIC UPLOAD FIELDS file (#301.92)
 D BMES^XPDUTL("  >> Modifying IVM DEMOGRAPHIC UPLOAD FIELDS file")
 S ^IVM(301.92,30,1)="S DR=.314 D LOOK^IVMPREC9 S Y=$P($G(^DIC(4,Y,99)),""^"")_$P($G(^DIC(4,Y,0)),""^"")"
 S ^IVM(301.92,30,2)="S DR=.314 D LOOK^IVMPREC9 S Y=$P($G(^DIC(4,Y,99)),""^"")_$P($G(^DIC(4,Y,0)),""^"")"
 Q
 ;
SENDNOT ;Send notification to the IVM Center once the facility has installed
 ;IVM*2*6 patch.
 ;
 N DIFROM
 D BMES^XPDUTL("  >> Sending a 'completed installation' notice to the IVM Center... ")
 S XMSUB="IVM*2*6 PATCH INSTALLATION"
 S XMDUZ="IVM PACKAGE"
 S XMY("BONNER@IVM.VA.GOV")="",XMY(DUZ)="",XMY(.5)=""
 S XMTEXT="IVMTEXT("
 S IVMX=$$SITE^VASITE
 S IVMTEXT(1)="  Facility:                   "_$P(IVMX,"^",2)
 S IVMTEXT(2)="  Station Number:             "_$P(IVMX,"^",3)
 ;
 D NOW^%DTC S Y=% D DD^%DT
 S IVMTEXT(3)="  Installed IVM*2*6 patch on: "_Y
 D ^XMD
 K IVMTEXT,IVMX,XMDUZ,XMSUB,XMTEXT,XMY,%
 Q
