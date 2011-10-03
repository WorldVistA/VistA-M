PSNPRE1 ;BIR/WRT-pre-init routine to kill off old reference files sent with the package  ;09/23/98 9:55
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
 ; INITIALIZATION ROUTINE
 N ROOT,ROOT1,DA,I,J,X,DIU
KILLIT D BMES^XPDUTL("I Am Deleting Your ""DRUG INGREDIENTS"" File So That It Can Be Updated.") S DIU=50.416,DIU(0)="D" D EN^DIU2 K DIU
 D BMES^XPDUTL("I Am Deleting Your ""VA DRUG CLASS"" File So That It Can Be Updated.") S DIU="^PS(50.605,",DIU(0)="D" D EN^DIU2 K DIU
 D BMES^XPDUTL("I Am Deleting Your ""DRUG UNITS"" File So That It Can Be Updated.") S DIU="^PS(50.607,",DIU(0)="D" D EN^DIU2 K DIU
 D BMES^XPDUTL("I Am Deleting Your ""PACKAGE TYPE"" File So That It Can Be Updated.") S DIU="^PS(50.608,",DIU(0)="D" D EN^DIU2 K DIU
 D BMES^XPDUTL("I Am Deleting Your ""PACKAGE SIZE"" File So That It Can Be Updated.") S DIU="^PS(50.609,",DIU(0)="D" D EN^DIU2 K DIU
 D BMES^XPDUTL("I Am Deleting Your ""DRUG MANUFACTURER"" File So That It Can Be Updated.") S DIU="^PS(55.95,",DIU(0)="D" D EN^DIU2 K DIU
 D BMES^XPDUTL("I Am Deleting Your ""NATIONAL DRUG TRANSLATION"" File So That It Can Be Updated.") S DIU="^PSNTRAN(",DIU(0)="D" D EN^DIU2 K DIU
 D BMES^XPDUTL("Now deleting the data dictionary for the ""NATIONAL DRUG"" File.")
 F NDF=50.68,50.67,50.66,50.65,50.64,50.63,50.62,50.61 S DIU=NDF,DIU(0)="S" D EN^DIU2
 S DIU=50.6,DIU(0)="" D EN^DIU2
 ;
 S ROOT=$NA(@XPDGREF@("LOCAL")),ROOT1=$NA(@XPDGREF@("OLD")),DA=0,I=1,J=1
 F  S DA=$O(^PS(56,DA)) Q:'DA  S X=^(DA,0) S:'$P(X,"^",5) @ROOT@(I)=X,I=I+1 S:$P(X,"^",5) @ROOT1@(J)=X,J=J+1
 S DIU="^PS(56,",DIU(0)="D" D EN^DIU2
 ;
 Q
 Q
