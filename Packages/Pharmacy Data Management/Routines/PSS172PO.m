PSS172PO ;BIR/JCH-Environment check routine for patch PSS*1*172 ;Oct 18, 2012
 ;;1.0;PHARMACY DATA MANAGEMENT;**172**;9/30/97;Build 28
 ;
 Q
 ;
EN ; Add new entries to 9009032.3 (intervention type) and 9009032.5 (intervention recommendation)
 ;
 D AIR
 D AIT
 D SECURITY
 Q
AIR ;Add Intervention recommendation
 ;
 I $$FIND1^DIC(9009032.5,"","X","UNABLE TO ASSESS","B") D AITX(2) D KTM Q
 D BMES^XPDUTL("Adding new Intervention Recommendation")
 I '$$FIND1^DIC(9009032.5,"","X","UNABLE TO ASSESS","B") D ADDIR I '$$FIND1^DIC(9009032.5,"","X","UNABLE TO ASSESS","B") D AITX(1) D KTM Q
 D KTM D BMES^XPDUTL("Intervention Recommendation 'UNABLE TO ASSESS' successfully added.")
 Q
AIT ;Add Intervention type
 ;
 I $$FIND1^DIC(9009032.3,"","X","NO ALLERGY ASSESSMENT","B") D AITX(4) D KTM Q
 D BMES^XPDUTL("Adding new Intervention Recommendation")
 I '$$FIND1^DIC(9009032.3,"","X","NO ALLERGY ASSESSMENT","B") D ADDIT I '$$FIND1^DIC(9009032.3,"","X","NO ALLERGY ASSESSMENT","B") D AITX(3) D KTM Q
 D KTM D BMES^XPDUTL("Intervention Type 'NO ALLERGY ASSESSMENT' successfully added.")
 Q
ADDIR ;Add intervention recommendation
 N PSSMRMPD K PSSMRMPD
 K PSSMRMER S PSSMRMPD(1,9009032.5,"+1,",.01)="UNABLE TO ASSESS" D UPDATE^DIE("","PSSMRMPD(1)",,"PSSMRMER(1)")
 Q
ADDIT ; Add No allergy assessment type
 N PSSMRMPD K PSSMRMPD
 K PSSMRMER S PSSMRMPD(1,9009032.3,"+1,",.01)="NO ALLERGY ASSESSMENT" D UPDATE^DIE("","PSSMRMPD(1)",,"PSSMRMER(1)")
 Q
 ;
AITX(PSSMRMIT) ;
 D BMES^XPDUTL(" ")
 I PSSMRMIT=1 D BMES^XPDUTL("Cannot create 'UNABLE TO ASSESS' intervention recommendation.") Q
 I PSSMRMIT=2 D BMES^XPDUTL("'UNABLE TO ASSESS' intervention recommendation already exists.") Q
 I PSSMRMIT=3 D BMES^XPDUTL("Cannot create 'NO ALLERGY ASSESSMENT' intervention type.") Q
 I PSSMRMIT=4 D BMES^XPDUTL("'NO ALLERGY ASSESSMENT' intervention type already exists.") Q
 Q
KTM ;Kill TMP global
 K ^TMP("DIERR",$J)
 Q
SECURITY ; Set security nodes in DIC(53.47
 N SECURITY S SECURITY("DD")="",SECURITY("AUDIT")="",SECURITY("DEL")="",SECURITY("LAYGO")="",SECURITY("RD")="",SECURITY("WR")=""
 D FILESEC^DDMOD(53.47,.SECURITY)
 Q
