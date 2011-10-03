DG53819D ;ALB/MM - POST INSTALL FOR DG*5.3*819 ADDING SUFFIX TO VA DOMICILIARY IN STATION TYPE FILE (#45.81) ; 10/23/97
 ;;5.3;Registration;**819**;Aug 13, 1993;Build 16
 ;
EN ; START UPDATES
 D ADD
 Q
ADD ;Add suffixes to the STATION TYPE file (#45.81)
 N DGI,DGERR,DGSUFF,DGIFN,DGQUES
 S DGIFN=0
 F DGI=1:1 S DGSUFF=$P($T(DGSUFF+DGI),";;",2) Q:DGSUFF="QUIT"  D
 .D STATION
 Q
STATION ;Find or add new suffix to VA Domicililary in Station Type file (#45.81)
 N DGDOM
 S DGDOM=$G(^DIC(45.81,30,0))
 I 'DGDOM D BMES^XPDUTL(">>Could not find VA DOMICILIARY in STATION TYPE file.") Q
 I $P(DGDOM,"^",2)'="VA DOMICILIARY" D BMES^XPDUTL(">>Entry #30 in STATION TYPE file is not VA DOMICILIARY.") Q
 N DA,DIC,X,Y
 S DA(1)=30
 S DIC="^DIC(45.81,"_DA(1)_",""S"","
 S DIC("P")=$P(^DD(45.81,50,0),"^",2)
 S DIC(0)="LMQ"
 S X=$P(DGSUFF,U,1)
 D ^DIC
 I +Y=-1 D BMES^XPDUTL(">>Unable to add suffix to SUFFIX PTR multiple (#50) for VA DOMICILIARY station type.") Q
 I '$P(Y,"^",3) D BMES^XPDUTL(">>suffix found in SUFFIX PTR multiple (#50) for VA DOMICILIARY station type.  Nothing changed.") Q
 D BMES^XPDUTL(">>Suffix added to SUFFIX PTR multiple (#50) for VA DOMICILIARY station type.")
 Q
DGSUFF ; SUFFIX
 ;;B1^3091214
 ;;B2^3091214
 ;;B3^3091214
 ;;B4^3091214
 ;;PB^2971001
 ;;PC^2971001
 ;;PD^2971001
 ;;PE^2971001
 ;;QUIT
