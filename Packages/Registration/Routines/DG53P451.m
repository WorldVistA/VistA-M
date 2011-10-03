DG53P451 ;TDM/BRM - Patch DG*5.3*451 Install Utility Routine ; 4/27/04 2:14pm
 ;;5.3;Registration;**451**; Aug 13,1993
 ;
 D CHKBOS Q:$G(XPDABORT)=2
 D ADDBOS
 D ADDINC Q:$G(XPDABORT)=2
 D EDITINC^DG53E451
 Q
CHKBOS ;Check to ensure that Merchant Seaman and B.E.C. are in the BOS file
 ;
 K XPDABORT
 N BOS
 F BOS="MERCHANT SEAMAN","B.E.C." Q:$D(XPDABORT)  D
 .Q:$D(^DIC(23,"B",BOS))
 .S XPDABORT=2
 .D BMES^XPDUTL("     >>> ERROR: Branch of Service File (#23) needs to be reviewed by NVS! <<<")
 .D MES^XPDUTL("           The National Entry for '"_BOS_"' does not exist!")
 .D BMES^XPDUTL("                        <<<< INSTALLATION ABORTED >>>>")
 Q
ADDBOS ;Add new entries to BRANCH OF SERVICE file (#23)
 N ARY,BOS,FDA,ERR,MSG
 S ARY(1)="F.COMMONWEALTH"
 S ARY(2)="F.GUERILLA"
 S ARY(3)="F.SCOUTS NEW"
 S ARY(4)="F.SCOUTS OLD"
 ;
 D BMES^XPDUTL("  >> Adding New Branch Of Service Entries.")
 S BOS="" F  S BOS=$O(ARY(BOS)) Q:BOS=""  D
 .K FDA,ERR
 .S MSG="     "_ARY(BOS)_" - "
 .I $$FIND1^DIC(23,"","X",ARY(BOS)) D BMES^XPDUTL(MSG_"entry already exists!") Q
 .S FDA(23,"+1,",.01)=ARY(BOS)
 .D UPDATE^DIE("","FDA","","ERR")
 .I $D(ERR) D BMES^XPDUTL(MSG_"not added!  ERROR:"),MES^XPDUTL(ERR("DIERR",1)_": "_ERR("DIERR",1,"TEXT",1)) Q
 .D MES^XPDUTL(MSG_"successfully added.")
 Q
 ;
ADDINC ; add new entries to the INCONSISTENT DATA ELEMENTS file (#38.6)
 N DGK,DGWP,ROOT,DGFDA,DGWP,DGERR,DGIEN,DGTITL
 K XPDABORT
 D BMES^XPDUTL("  >> Adding entries 72-85 into the INCONSISTENT DATA ELEMENTS file (#38.6)")
 F DGK=72:1:85 Q:$G(XPDABORT)=2  D
 .I $D(^DGIN(38.6,DGK)) D  Q
 ..D BMES^XPDUTL("     Internal Entry # "_DGK_" already exists in file #38.6")
 ..S ROOT="DGFDA(38.6,"""_DGK_","")" D @DGK
 ..I $P($G(^DGIN(38.6,DGK,0)),"^")=$G(@ROOT@(.01)) D MES^XPDUTL("     Entry "_DGK_" matches incoming entry - OK") Q
 ..D MES^XPDUTL("     >>> ERROR: Entry # "_DGK_" needs to be reviewed by NVS! <<<")
 ..D MES^XPDUTL("           Existing entry: "_$P($G(^DGIN(38.6,DGK,0)),"^"))
 ..D MES^XPDUTL("           Incoming entry: "_$G(@ROOT@(.01)))
 ..D BMES^XPDUTL("                        <<<< INSTALLATION ABORTED >>>>")
 ..S XPDABORT=2
 .K DGFDA,ROOT,DGWP
 .S ROOT="DGFDA(38.6,""?+1,"")"
 .D @DGK Q:'$D(DGFDA)
 .S DGIEN(1)=DGK
 .S DGTITL=@ROOT@(.01)
 .D UPDATE^DIE("","DGFDA","DGIEN","DGERR")
 .I $D(DGERR) D  Q
 ..D BMES^XPDUTL("   >>> ERROR! "_DGTITL_" not added to file #38.6")
 ..D MES^XPDUTL("     "_DGERR("DIERR",1)_": "_DGERR("DIERR",1,"TEXT",1))
 ..D BMES^XPDUTL("                        <<<< INSTALLATION ABORTED >>>>")
 ..S XPDABORT=2
 .D BMES^XPDUTL("      "_DGTITL_" successfully added.")
 Q
72 ;
 S @ROOT@(.01)="MSE DATA MISSING/INCOMPLETE"
 S @ROOT@(2)="MSE REQUIRED DATA FIELDS ARE MISSING OR INCOMPLETE"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="Inconsistency results when any of the required MSE data fields are "
 S DGWP(2,0)="either left blank or an imprecise date (less than month/year precision) "
 S DGWP(3,0)="is entered.  The following fields are required for any given Military "
 S DGWP(4,0)="Service Episode: BRANCH OF SERVICE, SERVICE ENTRY DATE, SERVICE "
 S DGWP(5,0)="SEPARATION DATE, DISCHARGE TYPE."
 Q
73 ;
 S @ROOT@(.01)="MSE DATES INCONSISTENT"
 S @ROOT@(2)="SERVICE SEPARATION DATE PRECEDES SERVICE ENTRY DATE"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="Inconsistency results when a SERVICE ENTRY DATE is found to be after the"
 S DGWP(2,0)="SERVICE SEPARATION DATE."
 Q
74 ;
 S @ROOT@(.01)="CONFLICT DT MISSING/INCOMPLETE"
 S @ROOT@(2)="CONFLICT DATE IS MISSING OR INCOMPLETE"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="This inconsistency results when a conflict date is either missing or "
 S DGWP(2,0)="incomplete (imprecise dates must have at least month and year).  The "
 S DGWP(3,0)="following date fields can trigger this inconsistency: SOMALIA FROM DATE,"
 S DGWP(4,0)="SOMALIA TO DATE, YUGOSLAVIA FROM DATE, YUGOSLAVIA TO DATE, PANAMA FROM "
 S DGWP(5,0)="DATE, PANAMA TO DATE, GRENADA FROM DATE, GRENADA TO DATE, LEBANON FROM "
 S DGWP(6,0)="DATE, LEBANON TO DATE, VIETNAM FROM DATE, VIETNAM TO DATE, GULF WAR FROM"
 S DGWP(7,0)="DATE, GULF WAR TO DATE."
 Q
75 ;
 S @ROOT@(.01)="CONFLICT TO DT BEFORE FROM DT"
 S @ROOT@(2)="CONFLICT TO DATE PRECEDES THE CONFLICT FROM DATE"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="This inconsistency results when a conflict to date is prior to a conflict "
 S DGWP(2,0)="from date.  The following date fields can trigger this inconsistency:"
 S DGWP(3,0)="SOMALIA FROM DATE, SOMALIA TO DATE, YUGOSLAVIA FROM DATE, YUGOSLAVIA TO"
 S DGWP(4,0)="DATE, PANAMA FROM DATE, PANAMA TO DATE, GRENADA FROM DATE, GRENADA TO"
 S DGWP(5,0)="DATE, LEBANON FROM DATE, LEBANON TO DATE, VIETNAM FROM DATE, VIETNAM TO"
 S DGWP(6,0)="DATE, GULF WAR FROM DATE, GULF WAR TO DATE."
 Q
76 ;
 S @ROOT@(.01)="INACCURATE CONFLICT DATE"
 S @ROOT@(2)="CONFLICT DATE IS NOT WITHIN THE ACCEPTABLE CONFLICT DATE RANGE"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="This inconsistency results when a conflict from and/or to date is not "
 S DGWP(2,0)="within the designated date ranges for the specific conflict."
 S DGWP(3,0)=" "
 S DGWP(4,0)="The following date fields can trigger this inconsistency:"
 S DGWP(5,0)="SOMALIA FROM DATE, SOMALIA TO DATE, YUGOSLAVIA FROM DATE, YUGOSLAVIA TO"
 S DGWP(6,0)="DATE, PANAMA FROM DATE, PANAMA TO DATE, GRENADA FROM DATE, GRENADA TO"
 S DGWP(7,0)="DATE, LEBANON FROM DATE, LEBANON TO DATE, VIETNAM FROM DATE, VIETNAM TO"
 S DGWP(8,0)="DATE, GULF WAR FROM DATE, GULF WAR TO DATE."
 Q
77 ;
 S @ROOT@(.01)="INACCURATE POW DT/LOCATION"
 S @ROOT@(2)="POW DATE(S) AND LOCATION DO NOT MATCH"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="This inconsistency results when the POW from and/or to date is not "
 S DGWP(2,0)="within the designated date range for the specified POW LOCATION."
 Q
78 ;
 S @ROOT@(.01)="INACCURATE COMBAT DT/LOC"
 S @ROOT@(2)="COMBAT DATES ARE NOT VALID FOR SPECIFIED LOCATION"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="This inconsistency results when the COMBAT from and/or to date is "
 S DGWP(2,0)="not within the designated date range for the specified COMBAT LOCATION."
 Q
79 ;
 S @ROOT@(.01)="MSE DATES OVERLAP"
 S @ROOT@(2)="MSE DATES OVERLAP"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="This inconsistency results when more than one Military Service "
 S DGWP(2,0)="Episode exists for this patient on a single day."
 Q
80 ;
 S @ROOT@(.01)="POW DT NOT WITHIN MSE"
 S @ROOT@(2)="POW DATES ARE NOT WITHIN THE MSE RANGE"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="This inconsistency results when the entered POW From/To Dates are not "
 S DGWP(2,0)="within the patient's military service episodes."
 Q
81 ;
 S @ROOT@(.01)="COMBAT DT NOT WITHIN MSE"
 S @ROOT@(2)="COMBAT DATE IS NOT WITHIN THE MSE RANGE"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="This inconsistency results when the entered COMBAT From/To Dates are not"
 S DGWP(2,0)="within the patient's military service episodes."
 Q
82 ;
 S @ROOT@(.01)="CONFLICT DT NOT WITHIN MSE"
 S @ROOT@(2)="CONFLICT DATES ARE NOT WITHIN MSE DATE RANGE"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="This inconsistency results when the entered Conflict From/To Dates are not"
 S DGWP(2,0)="within the patient's military service episodes."
 S DGWP(3,0)=" "
 S DGWP(4,0)="The following fields could cause this inconsistency to occur:  SOMALIA"
 S DGWP(5,0)="FROM DATE, SOMALIA TO DATE, YUGOSLAVIA FROM DATE, YUGOSLAVIA TO DATE,"
 S DGWP(6,0)="PANAMA FROM DATE, PANAMA TO DATE, GRENADA FROM DATE, GRENADA TO DATE,"
 S DGWP(7,0)="LEBANON FROM DATE, LEBANON TO DATE, VIETNAM FROM DATE, VIETNAM TO DATE,"
 S DGWP(8,0)="GULF WAR FROM DATE, GULF WAR TO DATE."
 Q
83 ;
 S @ROOT@(.01)="BOS REQUIRES DATE W/IN WWII"
 S @ROOT@(2)="MERCH SEA OR FILIPINO VET BOS REQUIRES SERVICE DATES DURING WWII"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="Inconsistency results when the Branch of Service is MERCHANT SEAMAN or"
 S DGWP(2,0)="one of the Filipino Veteran branches of service (F.COMMONWEALTH,"
 S DGWP(3,0)="F.GUERILLA, F.SCOUTS NEW, F.SCOUTS OLD) but neither the Military"
 S DGWP(4,0)="Service Start Date nor the Service End Date is within World War II"
 S DGWP(5,0)="(12/7/1941 - 8/15/1945)."
 Q
84 ;
 S @ROOT@(.01)="FILIPINO VET, PROOF MISSING"
 S @ROOT@(2)="FILIPINO VETERAN BOS WAS ENTERED, FILIPINO VET PROOF IS MISSING"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="Inconsistency results if a Filipino Veteran branch of service is entered"
 S DGWP(2,0)="(F.COMMONWEATH, F.GUERILLA, or F.SCOUTS NEW) but the FILIPINO VET PROOF"
 S DGWP(3,0)="field is left blank."
 Q
85 ;
 S @ROOT@(.01)="FILIPINO VET SHOULD BE VET='Y'"
 S @ROOT@(2)="VERIFIED FILIPINO VETERAN SHOULD HAVE A VETERAN STATUS OF 'YES'"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="Inconsistency results if a veteran has a Filipino Veteran branch of"
 S DGWP(2,0)="service (F.COMMONWEALTH, F.GUERILLA, F.SCOUTS NEW, or F.SCOUTS OLD),"
 S DGWP(3,0)="military service dates during World War II, proof of F.Vet eligibility"
 S DGWP(4,0)="(for the first three BOS only), but the Veteran Status is not 'YES'."
 Q
