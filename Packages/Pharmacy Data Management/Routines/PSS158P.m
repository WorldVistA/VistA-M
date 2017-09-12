PSS158P ;BIR/MR-Set FDA MED GUIDE SERVER URL field (#100) in the VA PHARMACY SYSTEM file (#59.7) ;09/14/10
 ;;1.0;PHARMACY DATA MANAGEMENT;**158**;09/30/97;Build 8
 ;
 N DIE,DA,DR
 S DIE="^PS(59.7,",DA=1,DR="100////http://vaww.national.cmop.domain.ext/FDAMedGuides/"
 D ^DIE
 ;
 Q
