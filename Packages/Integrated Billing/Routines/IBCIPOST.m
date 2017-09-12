IBCIPOST ;DSI/ESG - CLAIMSMANAGER POST INSTALL ;16-OCT-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ENTER ; Send an email message when software is installed
 ;
 NEW SSIMG,SITE,L1,TEXT,XMDUZ,XMSUB,XMTEXT,XMY,XMDUN,XMZ
 NEW D,D0,D1,D2,DG,DIC,DICR,DISYS,DIW,DIFROM,DA,DIK,X,Y
 ;
 S SSIMG="ClaimsManager.Interface@DAOU.COM"
 S SITE=+$P($G(^IBE(350.9,1,0)),U,2)
 S SITE=$P($G(^DIC(4,SITE,0)),U,1)
 ;
 S L1=1
 S TEXT(L1)=" ",L1=L1+1
 S TEXT(L1)="The ClaimsManager Interface has been installed at the following site:",L1=L1+1
 S TEXT(L1)=" ",L1=L1+1
 S TEXT(L1)=SITE,L1=L1+1
 S TEXT(L1)=$G(^XMB("NETNAME")),L1=L1+1
 S TEXT(L1)=$$SITE^VASITE(),L1=L1+1
 S TEXT(L1)=" ",L1=L1+1
 S TEXT(L1)="Build Identification:  May 2002 - A (T17)",L1=L1+1
 S TEXT(L1)=" ",L1=L1+1
 S TEXT(L1)="The value of the function $$ENV^IBCIUT5 is """_$$ENV^IBCIUT5_""".",L1=L1+1
 S TEXT(L1)="This should indicate either the Live or Test account.",L1=L1+1
 S TEXT(L1)=" ",L1=L1+1
 ;
 S XMTEXT="TEXT("
 S XMDUZ=DUZ
 S XMSUB="ClaimsManager Interface Installed"
 S XMY(SSIMG)=""
 S XMY(DUZ)=""
 D ^XMD
 ;
 ; =================================
 ; ** Remove old remote user from the VistA Mail Group 
 KILL DA,DIC,Y,DIK
 S DA=$O(^XMB(3.8,"B","IBCI COMMUNICATION ERROR",""))
 I DA D
 . S X="ClaimsManager.Interface@SENT"  ; value to lookup
 . S DIC(0)="B",DIC="^XMB(3.8,"_DA_",6," D ^DIC
 . I Y<1 Q
 . ; found old email address to delete
 . S DA(1)=DA,DIK="^XMB(3.8,"_DA(1)_",6,",DA=+Y D ^DIK
 ;
EXIT ;
 Q
 ;
