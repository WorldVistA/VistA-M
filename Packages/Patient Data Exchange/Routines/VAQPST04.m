VAQPST04 ;ALB/JFP - PDX, POST INIT ROUTINE ;01JUN93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
ALL ; --Creates an entry in the Segment Group file 394.84 of all segments
 I '$D(^VAT(394.71)) QUIT
 ;IF IT'S ALREADY THERE, DELETE IT
 S DA=""
 F  S DA=+$O(^VAT(394.84,"B","ALL",DA)) Q:('DA)  D
 .Q:($P(^VAT(394.84,DA,0),"^",2)=0)
 .S DIK="^VAT(394.84,"
 .D ^DIK K DIK
 W !,"  Creating a segment group called ""ALL"" "
 W !,"  This group will contain all data segments"
 S DIC="^VAT(394.84,",DIC(0)="L",DLAYGO=394.84,X="ALL"
 S DIC("DR")=".02///PUBLIC" ; -- Public
 K DD,DO
 D FILE^DICN K DIC,DLAYGO,X,DINUM
 I Y=-1 QUIT
 ; -- Add segments
 S DA=$P(Y,U,1),DIE="^VAT(394.84,",SEG=""
 F  S SEG=$O(^VAT(394.71,"B",SEG)) Q:SEG=""  D S1
 W !,"Done"
 K SEG,DA,DIE
 QUIT
S1 ; -- Update existing entry
 W !,"    ",SEG," - added"
 S DR="10///"_SEG
 S DR(2,394.841)=".01///"_SEG
 D ^DIE K DR
 QUIT
 ;
 ;
COP ; -- Creates entries in Segment group file from Health Summary Type file^GMT(142,
 N TMP
 I '$D(^GMT(142)) QUIT
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Create entries in Segment Groups from Health Summary Type File"
 D ^DIR K DIR
 I ('Y)!($D(DUOUT))!($D(DTOUT)) QUIT
 ;
 S GRP=""
 F  S GRP=$O(^GMT(142,"B",GRP)) Q:GRP=""  D G1
 QUIT
 ;
G1 ;
 ;IF IT'S ALREADY THERE, DELETE IT
 S DA=""
 F  S DA=+$O(^VAT(394.84,"B",GRP,DA)) Q:('DA)  D
 .Q:($P(^VAT(394.84,DA,0),"^",2)=0)
 .S DIK="^VAT(394.84,"
 .D ^DIK K DIK
 Q:(GRP="GMTS HS ADHOC OPTION")
 S ENTRY="",ENTRY=$O(^GMT(142,"B",GRP,ENTRY))
 S DIC="^VAT(394.84,",DIC(0)="L",DLAYGO=394.84,X=GRP
 S DIC("DR")=".02///PUBLIC" ; -- Public
 K DD,DO
 D FILE^DICN K DIC,DLAYGO,X,DINUM
 I Y=-1 QUIT
 ; -- Set components within entry
 W !!,?3,GRP," <-- Segment group added, the list of components follows"
 S DA=$P(Y,U,1),DIE="^VAT(394.84,",SEGPT=""
 F  S SEGPT=$O(^GMT(142,ENTRY,1,"C",SEGPT)) Q:SEGPT=""  D S0
 K SEG,DA,DIE
 QUIT
 ;
S0 ;
 S SEG=$P($G(^GMT(142.1,SEGPT,0)),U,4)
 S SEGNM=$P($G(^GMT(142.1,SEGPT,0)),U,1)
 ;FILTER OUT NON-SUPPORTED COMPONENTS
 I ((SEG'="")&($D(^VAT(394.71,"C",SEG)))) D S2
 QUIT
 ;
S2 ; -- Update existing entry
 W !,?10,SEG
 S DR="10///"_SEG
 S DR(2,394.841)=".01///"_SEG
 ;DETERMINE IF TIME & OCCURRENCE LIMITS ARE APPLICABLE
 S TMP=$$LIMITS^VAQDBIH3(SEGPT)
 ;PUT TIME LIMIT OF 1 YEAR (IF APPLICABLE)
 S:($P(TMP,"^",1)) DR(2,394.841)=DR(2,394.841)_";.04///1Y"
 ;PUT OCCURRENCE LIMIT OF 10 (IF APPLICABLE)
 S:($P(TMP,"^",2)) DR(2,394.841)=DR(2,394.841)_";.05///10"
 D ^DIE K DR
 W ?16," - ",SEGNM
 QUIT
 ;
END ; -- End of code
 QUIT
