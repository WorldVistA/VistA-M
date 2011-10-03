XU8P246 ;ALB/BRM - XU*8*246 ENVIRONMENT CHK AND PREINSTALL ; 11/22/02 8:28am
 ;;8.0;KERNEL;**246**;Jul 10, 1995
 ;
 ; This routine is executed from the top for the environment check
 ; portion of the install.  The PRE tag is not executed as part of the
 ; ENVCHK process.
 ;
ENVCHK ;  Environment check to ensure the^DD(5.12,0,"UP") node does
 ; not exist prior to installation.  This node was found to have
 ; been defined in one of our test accounts.  The following check
 ; is covered by DBIA#3518.
 ;
 ; ensure that the ^XIP global has been initialized
 I '$D(^XIP) D  Q
 .D BMES^XPDUTL("     *******************************************************")
 .D MES^XPDUTL("              WARNING:  ^XIP global not initialized!")
 .D BMES^XPDUTL("       Please see the Pre-installation Instructions in the")
 .D MES^XPDUTL("         patch description for initialization instructions.")
 .D BMES^XPDUTL("                 >>>> Installation aborted <<<<")
 .D BMES^XPDUTL("     *******************************************************")
 .S XPDQUIT=2  ;terminate installation.
 ;
 ; check for UP node in the DD file
 Q:'$D(^DD(5.12,0,"UP"))
 D BMES^XPDUTL("     *******************************************************")
 D MES^XPDUTL("           Invalid Data Dictionary entry for file #5.12!")
 D BMES^XPDUTL("                Please contact NVS for assistance.")
 D BMES^XPDUTL("                  >>>> Installation aborted <<<<")
 D BMES^XPDUTL("     *******************************************************")
 S XPDQUIT=2  ;terminate installation.
 Q
 ;
PRE ; The PRE tag is meant to be run as a pre-install to
 ; patch XU*8*246.  It will add several missing county
 ; codes to the county sub-file within the state (#5) file.
 ; The following counties will be added:
 ;
 ; STATE  IEN     COUNTY NAME       COUNTY CODE
 ; MO     29      St Louis City         510
 ; NM     35      San Miguel            047
 ; VA     51      Manassas City         683
 ; VA     51      Manassas Park         685
 ; VA     51      Poquoson City         735
 ; AK      2      Skagway Yakutat Ango  231
 ; AZ      4      La Paz                012
 ;
 N FDA,TAG,CNTYDAT,CNTYNAM,CNTYCOD,ST,MSG,ERRMSG,DIERR
 D BMES^XPDUTL("*** Adding missing counties to the State file ***")
 F TAG="AK","AZ","MO","NM","VA1","VA2","VA3" D
 .S ST=$E(TAG,1,2)
 .S CNTYDAT=$P($T(@TAG),";;",2)
 .S CNTYNAM=$P(CNTYDAT,"^"),CNTYCOD=$P(CNTYDAT,"^",2)
 .S MSG="**ERROR: Missing or Corrupt State: "_ST_". This process could not add "_CNTYNAM
 .I '$D(^DIC(5,"C",ST)) D BMES^XPDUTL(MSG) Q
 .S IEN5=$O(^DIC(5,"C",ST,""))
 .I '+IEN5!'$D(^DIC(5,IEN5,1)) D BMES^XPDUTL(MSG) Q
 .I $D(^DIC(5,IEN5,1,"C",CNTYCOD)) D BMES^XPDUTL(CNTYNAM_", "_ST_" already exists - no action taken.") Q
 .S FDA(5.01,"+1,"_IEN5_",",.01)=CNTYNAM
 .S FDA(5.01,"+1,"_IEN5_",",2)=CNTYCOD
 .D UPDATE^DIE("","FDA","","ERRMSG")
 .I $D(ERRMSG) D BMES^XPDUTL("**ERROR: "_CNTYNAM_", "_ST_" was not added.") K ERRMSG,DIERR,CNTYDAT,CNTYNAM,IEN5 Q
 .D BMES^XPDUTL(CNTYNAM_", "_ST_" was added successfully.")
 .K CNTYDAT,CNTYNAM,IEN5
 Q
 ; pre-install data fields - DO NOT REMOVE!
AK ;;SKAGWAY YAKUTAT ANGO^231
AZ ;;LA PAZ^012
MO ;;ST LOUIS CITY^510
NM ;;SAN MIGUEL^047
VA1 ;;MANASSAS CITY^683
VA2 ;;MANASSAS PARK^685
VA3 ;;POQUOSON CITY^735
