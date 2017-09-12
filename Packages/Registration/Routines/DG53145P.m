DG53145P ;ALB/MM - POST INSTALL FOR DG*5.3*145 ADDING PA SUFFIX TO VA DOMICILIARY IN STATION TYPE FILE (#45.81) ; 10/23/97
 ;;5.3;Registration;**145**;Aug 13, 1993
 ;
EN ;Find or add PA suffix to VA Domicililary in Station Type file (#45.81)
 N DGDOM
 S DGDOM=$G(^DIC(45.81,30,0))
 I 'DGDOM D BMES^XPDUTL(">>Could not find VA DOMICILIARY in STATION TYPE file.") Q
 I $P(DGDOM,"^",2)'="VA DOMICILIARY" D BMES^XPDUTL(">>Entry #30 in STATION TYPE file is not VA DOMICILIARY.") Q
 N DA,DIC,X,Y
 S DA(1)=30
 S DIC="^DIC(45.81,"_DA(1)_",""S"","
 S DIC("P")=$P(^DD(45.81,50,0),"^",2)
 S DIC(0)="LMQ"
 S X="PA"
 D ^DIC
 I +Y=-1 D BMES^XPDUTL(">>Unable to add PA suffix to SUFFIX PTR multiple (#50) for VA DOMICILIARY station type.") Q
 I '$P(Y,"^",3) D BMES^XPDUTL(">>PA suffix found in SUFFIX PTR multiple (#50) for VA DOMICILIARY station type.  Nothing changed.") Q
 D BMES^XPDUTL(">>PA Suffix added to SUFFIX PTR multiple (#50) for VA DOMICILIARY station type.")
 Q
