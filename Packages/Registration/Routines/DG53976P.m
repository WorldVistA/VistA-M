DG53976P ;ALB/JAM - DG*5.3*976 POST INSTALL TO UPDATE HEALTH BENEFIT PLANS FOR COMMUNITY CARE PROGRAM ;12/27/18 9:18pm
 ;;5.3;Registration;**976**;Aug 13, 1993;Build 14
 ;
 ;  Integration Agreements:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;        10018 : UPDATE^DIE
 Q
POST ; Entry point for post-install
 ;
 L +^DGHBP(25.11,0):10 I '$T D BMES^XPDUTL("     Health Benefit Plan (#25.11) File is locked by another user.  Please log YOUR IT Services ticket.") Q
 D BMES^XPDUTL("    Adding Entry in HEALTH BENEFIT PLAN (#25.11) File -")
 D MES^XPDUTL("     Veteran Plan - CCP Grandfather   ")
 D UPDPS1
 D BMES^XPDUTL("    Adding Entry in HEALTH BENEFIT PLAN (#25.11) File -")
 D MES^XPDUTL("     Veteran Plan - CCP State with no Full-Service Medical Facility    ")
 D UPDPS2
 D BMES^XPDUTL("    Adding Entry in HEALTH BENEFIT PLAN (#25.11) File - ")
 D MES^XPDUTL("     Veteran Plan - CCP Urgent Care    ")
 D UPDPS3
 D BMES^XPDUTL("    Adding Entry in HEALTH BENEFIT PLAN (#25.11) File -")
 D MES^XPDUTL("     Veteran Plan - CCP Basic    ")
 D UPDPS4
 D BMES^XPDUTL("    Adding Entry in HEALTH BENEFIT PLAN (#25.11) File -")
 D MES^XPDUTL("     Veteran Plan - CCP Hardship Determination    ")
 D UPDPS5
 ;
 L -^DGHBP(25.11,0)
 Q
 ;
UPDPS1 ;Setup new Health Benefit Plan - Veteran Plan - CCP Grandfather
 ;
 N DGFIELDS,DGERR
 S DGERR=""
 S DGFIELDS("NAME")="Veteran Plan - CCP Grandfather"
 S DGFIELDS("PLANCODE")=211
 S DGFIELDS("COVERAGECODE")="CC01001"
 S DGFIELDS("SD",1)="Veteran Plan - CCP Grandfather"
 S DGFIELDS("LD",1)="Grandfathered Veterans have their eligibility extended from Veterans Choice"
 S DGFIELDS("LD",2)="Program to the new Community Care Program established under the MISSION Act."
 S DGFIELDS("LD",3)="There are two groups of Grandfathered Veterans: "
 S DGFIELDS("LD",4)="'5 Lowest Population Density States'"
 S DGFIELDS("LD",5)="or 'Received Title 38 Care'."
 S DGFIELDS("LD",6)="Both groups require that the enrolled Veteran"
 S DGFIELDS("LD",7)="(1) was distance-eligible on the day before the MISSION Act was signed (June 5, 2018), and"
 S DGFIELDS("LD",8)="(2) live in a place that is still distance-eligible under Veterans Choice"
 S DGFIELDS("LD",9)="rules as of the start of the MISSION Act on June 6, 2019."
 D UPDREQ(.DGFIELDS,.DGERR)
 I DGERR'="" D
 . D BMES^XPDUTL("     *** An Error occurred during updating Plan:")
 . D MES^XPDUTL("     *** "_DGERR_" ***")
 . D MES^XPDUTL("     Please log YOUR IT Services ticket.")
 Q
UPDPS2 ;Setup new Health Benefit Plan - Veteran Plan - CCP State with no Full-Service Medical Facility
 ;
 N DGFIELDS,DGERR
 S DGERR=""
 S DGFIELDS("NAME")="Veteran Plan - CCP State with no Full-Service Medical Facility"
 S DGFIELDS("PLANCODE")=209
 S DGFIELDS("COVERAGECODE")="CC01002"
 S DGFIELDS("SD",1)="Veteran Plan - CCP State with no Full-Service Medical Facility"
 S DGFIELDS("LD",1)="Enrolled Veterans who reside in a state with no full-service "
 S DGFIELDS("LD",2)="VA health care facility."
 S DGFIELDS("LD",3)="This eligibility will be determined and assigned with the start of the MISSION Act on June 6, 2019."
 D UPDREQ(.DGFIELDS,.DGERR)
 I DGERR'="" D
 . D BMES^XPDUTL("     *** An Error occurred during updating Plan:")
 . D MES^XPDUTL("     *** "_DGERR_" ***")
 . D MES^XPDUTL("     Please log YOUR IT Services ticket.")
 Q
 ;
UPDPS3 ;Setup new Health Benefit Plan - Veteran Plan - CCP Urgent Care
 ;
 N DGFIELDS,DGERR
 S DGERR=""
 S DGFIELDS("NAME")="Veteran Plan - CCP Urgent Care"
 S DGFIELDS("PLANCODE")=210
 S DGFIELDS("COVERAGECODE")="CC01003"
 S DGFIELDS("SD",1)="Veteran Plan - CCP Urgent Care"
 S DGFIELDS("LD",1)="Enrolled Veterans who have received Title 38 care within the past two years who meet the administrative eligibility for non-VA Urgent Care for services."
 S DGFIELDS("LD",2)="This eligibility will be determined and assigned with the start of the MISSION Act on June 6, 2019."
 D UPDREQ(.DGFIELDS,.DGERR)
 I DGERR'="" D
 . D BMES^XPDUTL("     *** An Error occurred during updating Plan:")
 . D MES^XPDUTL("     *** "_DGERR_" ***")
 . D MES^XPDUTL("     Please log YOUR IT Services ticket.")
 Q
 ;
UPDPS4 ;Setup new Health Benefit Plan - Veteran Plan - CCP Basic
 ;
 N DGFIELDS,DGERR
 S DGERR=""
 S DGFIELDS("NAME")="Veteran Plan - CCP Basic"
 S DGFIELDS("PLANCODE")=208
 S DGFIELDS("COVERAGECODE")="CC01006"
 S DGFIELDS("SD",1)="Veteran Plan - CCP Basic"
 S DGFIELDS("LD",1)="The Veteran must be enrolled in the VA healthcare system."
 S DGFIELDS("LD",2)="Veteran is eligible for the Community Care Program but does not meet"
 S DGFIELDS("LD",3)="the criteria for Community Care services."
 D UPDREQ(.DGFIELDS,.DGERR)
 I DGERR'="" D
 . D BMES^XPDUTL("     *** An Error occurred during updating Plan:")
 . D MES^XPDUTL("     *** "_DGERR_" ***")
 . D MES^XPDUTL("     Please log YOUR IT Services ticket.")
 Q
 ;
UPDPS5 ;Setup new Health Benefit Plan - Veteran Plan - CCP Hardship Determination
 ;
 N DGFIELDS,DGERR
 S DGERR=""
 S DGFIELDS("NAME")="Veteran Plan - CCP Hardship Determination"
 S DGFIELDS("OLDNAME")="Veteran Plan - CCP Admin VCCPE Consults"
 S DGFIELDS("PLANCODE")=212
 S DGFIELDS("COVERAGECODE")="CC01007"
 S DGFIELDS("SD",1)="Veteran Plan - CCP Hardship Determination"
 S DGFIELDS("LD",1)="The Veteran must be enrolled in the VA health care system. The Veteran who may"
 S DGFIELDS("LD",2)="meet new MISSION Act access standards (wait time and drive time) may still face"
 S DGFIELDS("LD",3)="an unusual or excessive burden in accessing care at the VA based on:"
 S DGFIELDS("LD",4)=". Geographical challenges"
 S DGFIELDS("LD",5)=". Environmental factors such as:"
 S DGFIELDS("LD",6)="o Roads that are not accessible to the general public, such as a road through a military base or restricted area"
 S DGFIELDS("LD",7)="o Traffic, or"
 S DGFIELDS("LD",8)="o Hazardous weather conditions"
 S DGFIELDS("LD",9)=". A medical condition that impacts the ability to travel"
 S DGFIELDS("LD",10)="Or"
 S DGFIELDS("LD",11)=". Meets MISSION Act access standard, but, must travel by air, boat, or ferry"
 S DGFIELDS("LD",12)="And"
 S DGFIELDS("LD",13)=". Veteran has received a ""COMMUNITY CARE-HARDSHIP DETERMINATION"" consult and"
 S DGFIELDS("LD",14)="  the consult has not expired then the Veteran will be eligible for Hardship."
 D UPDREQ(.DGFIELDS,.DGERR)
 I DGERR'="" D
 . D BMES^XPDUTL("     *** An Error occurred during updating Plan:")
 . D MES^XPDUTL("     *** "_DGERR_" ***")
 . D MES^XPDUTL("     Please log YOUR IT Services ticket.")
 Q
 ;
UPDREQ(DGFIELDS,DGERR) ; Update entries in the HEALTH BENEFIT PLAN File (25.11)
 ;
 ;  Input: DGFIELDS - Array of Field Values
 ;
 ;  Output:   DGERR - Error Text
 ;
 N DGIEN,DGNAME,DGPCODE,DGCCODE,DGSD,DGLD,DGFDA,DGPFMSG,DGPFMS1,DGUPDATE,DGRENAME
 K DGERR
 S DGERR=""
 S DGNAME=$G(DGFIELDS("NAME"))
 S DGRENAME=$G(DGFIELDS("OLDNAME"))
 S DGPCODE=$G(DGFIELDS("PLANCODE"))
 M DGSD=DGFIELDS("SD")
 M DGLD=DGFIELDS("LD")
 S DGCCODE=$G(DGFIELDS("COVERAGECODE"))
 I DGNAME="" S DGERR="Missing Health Benefit Plan Name" Q
 D  Q:DGERR'=""
 . I DGPCODE="" S DGERR="Missing Plan Code" Q
 . I '$D(DGSD) S DGERR="Missing Short Description" Q
 . I '$D(DGLD) S DGERR="Missing Long Description" Q
 . I DGCCODE="" S DGERR="Missing Coverage Code" Q
 ;
 ; Check if entry exists, use it if it does (and rename if a new name is specified)
 S DGUPDATE=0,DGIEN=""
 I DGRENAME'="" D
 . S DGIEN=$O(^DGHBP(25.11,"B",DGRENAME,0))
 . I DGIEN D
 . . S DGUPDATE=1
 . . D MES^XPDUTL("      Plan name "_DGRENAME)
 . . D MES^XPDUTL("       will be renamed to "_DGNAME)
 I DGIEN="" D
 . S DGIEN=$O(^DGHBP(25.11,"B",DGNAME,0))
 . I DGIEN D
 . . S DGUPDATE=1
 . . D MES^XPDUTL("      Plan already exists - it will be updated.")
 I 'DGIEN S DGIEN="+1"
 S DGIEN=DGIEN_","
 ;
 S DGFDA(25.11,DGIEN,.01)=DGNAME
 S:DGPCODE'="" DGFDA(25.11,DGIEN,.02)=DGPCODE
 S:DGCCODE'="" DGFDA(25.11,DGIEN,.05)=DGCCODE
 D UPDATE^DIE("E","DGFDA","","DGERR")
 I $D(DGERR("DIERR")) S DGERR=$G(DGERR("DIERR",1,"TEXT",1)) Q
 S DGIEN=$O(^DGHBP(25.11,"B",DGNAME,0))
 I 'DGIEN D BMES^XPDUTL("    "_DGIEN_" entry is not found to update Short and Long Description fields.  ") Q
 D WP^DIE(25.11,DGIEN_",",.03,"","DGSD","DGPFMSG") ; SHORT DESCRIPTION
 I $D(DGPFMSG) S DGERR=$G(DGPFMSG("DIERR",1,"TEXT",1)) Q
 D WP^DIE(25.11,DGIEN_",",.04,"","DGLD","DGPFMS1") ; LONG DESCRIPTION
 I $D(DGPFMS1) S DGERR=$G(DGPFMS1("DIERR",1,"TEXT",1)) Q
 D MES^XPDUTL("      Plan has been "_$S(DGUPDATE=1:"updated",1:"added")_".")
 Q
 ;
