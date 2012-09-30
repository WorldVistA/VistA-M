DG53739P ;ALB/DHH - post-install for DG*5.3*739 ; 1/18/07 9:42am
 ;;5.3;Registration;**739**;Aug 13, 1993;Build 5
EN ;
 ;FIND SERVER
 N DGI,DGPROT,DA,Y,DIC,X,DGS,DIK
 F DGI=1:1 S DGPROT=$P($T(PROT+DGI),";;",2) Q:DGPROT="QUIT"  D
 . S X=$P(DGPROT,"^")
 . S DIC="^ORD(101," D ^DIC Q:+Y'>0  D
 .. S DGS=+Y D ITEM
 .. I +Y'>0&(DGPROT'["A19") D MES^XPDUTL("  "_$P(DGPROT,"^",2)_" client item was not found!!!")
 .. S X=$P(DGPROT,"^",2),DIC="^ORD(101,"_DGS_",775," D ^DIC Q:+Y'>0  D
 ... S DA(1)=DGS,DA=+Y,DIK="^ORD(101,"_DA(1)_",775," D ^DIK S Y=1
 ... D MES^XPDUTL("  "_$P(DGPROT,"^",2)_" client subscriber deleted ")
 . I Y'>0 D MES^XPDUTL("  "_$P(DGPROT,"^",2)_" client subscriber not found !!!")
 I +Y'>0&(DGPROT'="QUIT") D MES^XPDUTL("  "_$P(DGPROT,"^",1)_" server protocol not found!!!")
 Q
 ;
ITEM ;Remove item entry from server protocol
 S DIC="^ORD(101,"_DGS_",10,",X=$P(DGPROT,"^",2) D ^DIC Q:+Y'>0  D
 . S DA=+Y,DA(1)=DGS,DIK="^ORD(101,"_DA(1)_",10," D ^DIK S Y=1
 . D MES^XPDUTL("  "_$P(DGPROT,"^",2)_" client item has been deleted from "_$P(DGPROT,"^")_" server protocol")
 Q
 ;
PROT ;Protocol (Server)^Protocol (Subscriber)
 ;;VAFC ADT-A01 SERVER^DG PTF ADT-A01 CLIENT
 ;;VAFC ADT-A02 SERVER^DG PTF ADT-A02 CLIENT
 ;;VAFC ADT-A03 SERVER^DG PTF ADT-A03 CLIENT
 ;;VAFC ADT-A04 SERVER^DG PTF ADT-A04 CLIENT
 ;;VAFC ADT-A08 SERVER^DG PTF ADT-A08 CLIENT
 ;;VAFC ADT-A08-TSP SERVER^DG PTF ADT-A08-TSP CLIENT
 ;;VAFC ADT-A11 SERVER^DG PTF ADT-A11 CLIENT
 ;;VAFC ADT-A12 SERVER^DG PTF ADT-A12 CLIENT
 ;;VAFC ADT-A13 SERVER^DG PTF ADT-A13 CLIENT
 ;;VAFC ADT-A19 SERVER^DG PTF ADT-A19 CLIENT
 ;;QUIT
 ;
