IBYPPOST ; ALB/TMP - IB*2*52 POST-INIT ; 22-JAN-96
 ;;Version 2.0 ; INTEGRATED BILLING ;**52**; 21-MAR-94
 ;
POST ;
 D OGEN ;         output generator post init
 D START^IBYPPC ; charge master post init
 D ACTTYP ;       add action types to file #350.1
 D MGRP ;         add new mailgroups
 Q
 ;
 ;
OGEN ;Set up check points for post-init
 N %,Z
 S %=$$NEWCP^XPDUTL("U399","U399^IBYPPOST")
 S %=$$NEWCP^XPDUTL("U353","U353^IBYPPOST")
 Q
 ;
U399 N DONE,S1,Z,Z1,CT,%
 S DONE="Step Complete.",CT=0
 S S1=+$$PARCP^XPDUTL("U399")
 D BMES^XPDUTL("Updating Bill/Claims file")
 F  S S1=$O(^DGCR(399,S1)) Q:'S1  S Z=$G(^DGCR(399,S1,0)),Z1=$P(Z,U,11) D
 .S CT=CT+1
 .I $P(Z,U,13)<2!$P(Z,U,13)>4!($P(Z,U,21)'="")!$S(Z1="":1,1:"pi"'[Z1) S:'(CT#200) %=$$UPCP^XPDUTL("U399",S1) Q
 .S Z1=$S(Z1="p":"A",Z1="i":"P",1:"") S:Z1'="" $P(^(0),U,21)=Z1 S:'(CT#200) %=$$UPCP^XPDUTL("U399",S1)
 D MES^XPDUTL(DONE)
 Q
 ;
U353 N DONE,Z
 S DONE="Step Complete."
 D BMES^XPDUTL("Updating Bill Form Type file")
 F Z=2,3 I $G(^IBE(353,Z,2))="" S ^IBE(353,Z,2)="399^P^66^1",^("PRE")="D ENTPRE^IBCFP1",^("POST")="D ENTPOST^IBCFP1",^("EXT")="D QB1^IBCFP1",^("FPRE")="D FORMPRE^IBCFP1",^("FPOST")="D FORMPOST^IBCFP1"
 S Z=0 F  S Z=$O(^IBE(353,Z)) Q:'Z  I $P($G(^(Z,2)),U,2)="" S $P(^IBE(353,Z,2),U,2)="P"
 I $P($G(^IBE(353,2,2)),U,6)="" S $P(^IBE(353,2,2),U,6)="NATIONAL HCFA-1500",$P(^IBE(353,3,2),U,6)="NATIONAL UB-92"
 D MES^XPDUTL(DONE)
 Q
 ;
 ;
ACTTYP ; Add Action Types
 D BMES^XPDUTL(" ")
 D BMES^XPDUTL(">>> Adding new IB Action Types into file #350.1...")
 ;
 ; - get IBAR
 S IBAR=$O(^PRCA(430.2,"B","CHAMPUS PATIENT",0))
 I 'IBAR D BMES^XPDUTL(" >> Can't add action types!  Install PRCA*4.5*48 first!") G ACTTYPQ
 ;
 ; - get rx serv
 S IBSERV=$P($G(^IBE(350.1,1,0)),"^",4)
 I '$$SERV^IBARX1(IBSERV) D BMES^XPDUTL(" >> Please check entry #1 in file #350.1 - the service should be Pharmacy.") G ACTTYPQ
 ;
 ; - add action types
 D NEWAT
 ;
 ; - point them to the correct action types
 D ATAT
 ;
ACTTYPQ K IBAR,IBSERV
 Q
 ;
 ;
NEWAT ; Add new IB Action Types into file #350.1
 F IBI=1:1 S IBCR=$P($T(NAT+IBI),";;",2) Q:IBCR="QUIT"  D
 .S X=$P(IBCR,"^")
 .S $P(IBCR,"^",3,4)=IBAR_"^"_IBSERV
 .I $O(^IBE(350.1,"B",X,0)) D BMES^XPDUTL(" >> '"_X_"' is already on file...") Q
 .K DD,DO S DIC="^IBE(350.1,",DIC(0)="" D FILE^DICN Q:Y<0
 .S ^(0)=^IBE(350.1,+Y,0)_"^"_$P(IBCR,"^",2,11) S DIK=DIC,DA=+Y D IX1^DIK
 .D BMES^XPDUTL(" >> '"_$P(IBCR,"^")_"' has been filed...")
 K DA,DIC,DIE,DR,IBI,IBCR,X,Y
 Q
 ;
NAT ; Action Types to add into file #350.1
 ;;DG CHAMPUS RX COPAY NEW^CUS RX^^^1^^^CHAMPUS RX COPAY^^^7
 ;;DG CHAMPUS OPT COPAY NEW^CUS OPT^^^1^^^CHAMPUS OPT COPAY^^^7
 ;;DG CHAMPUS INPT COPAY NEW^CUS INPT^^^1^^^CHAMPUS INPT COPAY^^^7
 ;;DG CHAMPUS RX COPAY CANCEL^CAN CRX^^^2
 ;;DG CHAMPUS OPT COPAY CANCEL^CAN COPT^^^2
 ;;DG CHAMPUS INPT COPAY CANCEL^CAN CINP^^^2
 ;;QUIT
 ;
 ;
ATAT ; Resolve pointers to file #350.1 from file #350.1
 F IBI=1:1 S IBX=$P($T(ACT+IBI),";;",2,99) Q:IBX="QUIT"  D
 .S IBNEW=$O(^IBE(350.1,"B",$P(IBX,"^"),0))
 .S IBCAN=$O(^IBE(350.1,"B",$P(IBX,"^",2),0))
 .F IBJ=IBNEW,IBCAN D
 ..S DIE="^IBE(350.1,",DA=IBJ
 ..S DR=".06////"_IBCAN_";.09////"_IBNEW
 ..D ^DIE K DA,DR,DIE
 ;
 K IBI,IBX,IBNEW,IBCAN,IBJ
 Q
 ;
 ;
ACT ;New Action (#350.1)^Cancel Action (#350.1)
 ;;DG CHAMPUS RX COPAY NEW^DG CHAMPUS RX COPAY CANCEL
 ;;DG CHAMPUS OPT COPAY NEW^DG CHAMPUS OPT COPAY CANCEL
 ;;DG CHAMPUS INPT COPAY NEW^DG CHAMPUS INPT COPAY CANCEL
 ;;QUIT
 ;
 ;
MGRP ; Add new mailgroups
 D BMES^XPDUTL(" ")
 D BMES^XPDUTL(">>> Adding new mailgroups... (Be sure to add members!)")
 ;
 S X="XMBGRP" X ^%ZOSF("TEST") E  D BMES^XPDUTL(" >> Need MailMan v7.1 to add new mailgroups!") G MGRPQ
 ;
 N IBUSER,IBD,IBNAME,IBJ,IBJJ
 ;
 F IBJ=1:1:3 D
 .S IBNAME=$P($T(@("GRP"_IBJ)+1),";",3) Q:IBNAME=""
 .S IBUSER(DUZ)=""
 .F IBJJ=2:1 S X=$P($T(@("GRP"_IBJ)+IBJJ),";",3) Q:X=""!(X="QUIT")  S IBDESC(IBJJ-1)=X
 .D BMES^XPDUTL(" >> Adding the group '"_IBNAME_"' ...")
 .S X=$$MG^XMBGRP(IBNAME,0,DUZ,0,.IBUSER,.IBDESC,1)
 ;
MGRPQ Q
 ;
 ;
GRP1 ; Add mailgroup 1
 ;;IB CHAMP RX REJ
 ;;This mailgroup is used to report billing transactions rejected
 ;;from the CHAMPUS fiscal intermediary.
 ;;QUIT
 ;
GRP2 ; Add mailgroup 2
 ;;IB CHAMP RX REV
 ;;This mailgroup is used to report cancellation transactions rejected
 ;;from the CHAMPUS fiscal intermediary.
 ;;QUIT
 ;
GRP3 ; Add mailgroup 3
 ;;IB CHAMP RX START
 ;;This is used to report when the CHAMPUS billing engines have
 ;;been started.  It also reports when AWP updates are received.
 ;;QUIT
