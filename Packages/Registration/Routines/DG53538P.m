DG53538P ;BPFO/MM Post Init routine for DG*5.3*538 - ;2/19/2004
 ;;5.3;Registration;**538**;Aug 13, 1993
 ;
 ; This is the post-initialization routine for DG*5.3*538.
 ; It will populate the package level for the parameter definitions
 ; distributed with this patch.
 ;
 N DGRRI,LINE
 D BMES^XPDUTL("Updating Parameter Definitions with package values...")
 F DGRRI=1:1 S LINE=$P($T(PREF+DGRRI),";;",2) Q:LINE="QUIT"  D
 .N DGRRPREF,DGRRVAL,ERR
 .S DGRRPREF=$P(LINE,U)
 .S DGRRVAL=$P(LINE,U,2)
 .D EN^XPAR("PKG.REGISTRATION",DGRRPREF,1,DGRRVAL,.ERR)
 .I ERR'=0 D  Q
 ..D MES^XPDUTL("     "_DGRRPREF_" NOT Updated.")
 ..D MES^XPDUTL("      Error message:  "_$P($G(ERR),U,2))
 .D MES^XPDUTL("     "_DGRRPREF_" updated with package value of "_DGRRVAL)
 D MES^XPDUTL("Updating done.")
 Q
PREF ;Parameter definition^package value
 ;;DGRR PL MAX NUM PATIENTS RET^50
 ;;DGRR PL NUM PATIENTS PER PAGE^10
 ;;DGRR PL PATIENT TYPE^Enabled
 ;;DGRR PL GENDER^Enabled
 ;;DGRR PL PRIMARY ELIGIBILITY^Enabled
 ;;DGRR PL ROOM BED^Disabled
 ;;DGRR PL SERVICE CONNECTED^Disabled
 ;;DGRR PL VETERAN STATUS^Disabled
 ;;DGRR PL WARD^Disabled
 ;;DGRR PL VETERAN IMAGE^Enabled
 ;;QUIT
 Q
