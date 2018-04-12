PSU23PI ;BIR/MFR - Post-Install to update the HL LOGICAL LINK file w/ correct DNS DOMAIN ;30 OCT 2017
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**23**;MAR 2005;Build 3
 ;
EN ; - Entry Point
 N HLDNS,HLIEN,DIE,DA,DR,X,Y,FOUND,LIST,LSTIDX
 S HLDNS="" F  S HLDNS=$O(^HLCS(870,"DNS",HLDNS)) Q:(HLDNS="")  D
 . I $$UP^XLFSTR(HLDNS)'="CMOP-NAT.DOMAIN.EXT" Q
 . S HLIEN=0 F  S HLIEN=$O(^HLCS(870,"DNS",HLDNS,HLIEN)) Q:'HLIEN  D
 . . D BMES^XPDUTL("Updating DNS DOMAIN field (#.08) for the HL LOGICAL LINK entry '"_$$GET1^DIQ(870,HLIEN,.01)_"'")
 . . S LSTIDX=$G(LSTIDX)+1,LIST(LSTIDX)=$E($$GET1^DIQ(870,HLIEN,.01),1,25)_"^"_HLDNS
 . . S DIE="^HLCS(870,",DA=HLIEN,DR=".08///HL7.CMOP-NAT.DOMAIN.EXT" D ^DIE
 . . S $P(LIST(LSTIDX),"^",3)=$$GET1^DIQ(870,HLIEN,.08)
 . . D BMES^XPDUTL("Done!") S FOUND=1
 I '$G(FOUND) D
 . D BMES^XPDUTL("No records found in the HL LOGICAL LINK file (#870) with the DNS DOMAIN field set to 'CMOP-NAT.DOMAIN.EXT'. No updates performed.")
 ;
 ; Sends Mailman message about update or no update
 N XMX,PSOTEXT,XMSUB,XMDUZ,XMTEXT,I
 S XMDUZ=.5,XMY(DUZ)=DUZ,XMY("G.PSU PBM")=""
 S XMSUB="PSU*4*23 DNS DOMAIN CMOP-NAT.DOMAIN.EXT Update"
 I $G(FOUND) D
 . S PSOTEXT(1)="The post-install routine performed the following updates:"
 . S PSOTEXT(2)=""
 . S PSOTEXT(3)="HL LOGICAL LINK          DNS DOMAIN (Before Patch)    DNS DOMAIN (After Patch)"
 . S PSOTEXT(4)="------------------------ --------------------------   -------------------------"
 . F I=1:1 Q:'$D(LIST(I))  S PSOTEXT(4+I)=$P(LIST(I),"^"),$E(PSOTEXT(4+I),26)=$P(LIST(I),"^",2),$E(PSOTEXT(4+I),55)=$P(LIST(I),"^",3)
 E  D
 . S PSOTEXT(1)="The post-install routine found no records in the HL LOGICAL LINK file (#870)"
 . S PSOTEXT(2)="with the DNS DOMAIN field (#.08) set to 'CMOP-NAT.DOMAIN.EXT'."
 . S PSOTEXT(3)="No updates performed."
 S XMTEXT="PSOTEXT(" N DIFROM D ^XMD
 Q
