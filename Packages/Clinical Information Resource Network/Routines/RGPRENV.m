RGPRENV ;SLC/NCG-PRE-IMP ENV CHECK ;6-30-1998
 ;;0.5; CLINICAL INFO RESOURCE NETWORK ;;30 Sep 98
 ;Checks first for patch PSO*7*11 when CPRS and OUTPATIENT
 ;version 7 are both installed. If patch not found, set
 ;XPDQUIT to tell KIDS to abort the install.  
 ;Checks next for existence of another entry in package file
 ;that contains RG as the prefix and will then remove it.
 ;CIRN's namespace is RG.  Found an entry during testing
 ;called OKC REGISTRATION with a prefix of RG
 ;
PSOCHK ; If CPRS and If OUTPATIENT v7, abort if no patch PSO*7*11.
 S Y=$$VERSION^XPDUTL("OR") I Y'<3 D
 .S Y=$$VERSION^XPDUTL("PSO") I Y'<7 D
 ..S Y=$$PATCH^XPDUTL("PSO*7.0*11") I Y<1 S XPDABORT=1
 ..I $D(XPDABORT) D BMES^XPDUTL(" PATCH PSO*7*11 is not installed.")
 K Y
 ;
LOOK ;
 S RGFLAG=0,RG1="RG",RG2=0,U="^"
 F  S RG2=$O(^DIC(9.4,"C",RG1,RG2)) Q:'RG2  D
 . S RG3=$P(^DIC(9.4,RG2,0),U)
 . I RG3'["CLINICAL INFO RESOURCE" D
 . . S DA=RG2,DIK="^DIC(9.4," D ^DIK
 . . D BMES^XPDUTL(RG3_" (ien="_RG2_") had an RG prefix")
 . . D BMES^XPDUTL("deleted from PACKAGE file")
 . . S RGFLAG=1
QUIT ; kill variables and quit
 I RGFLAG=0 D BMES^XPDUTL("No RG prefixes found in PACKAGE file.")
 K DA,DIK,RG1,RG2,RG3,RGFLAG
 Q
