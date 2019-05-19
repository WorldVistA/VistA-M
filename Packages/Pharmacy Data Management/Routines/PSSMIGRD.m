PSSMIGRD ;AJF - Process Sync XML message from PEPS;  7/2/2012 0529
 ;;1.0;PHARMACY ENTERPRISE PRODUCT SYSTEM;;7/11/2008;Build 36
 ;;
 ;  Process Sync request
 ;  Called from ^PSSMIGRC
 ;  Calls to ^PSSMIGRE and PSSMIGRR
 ;;
EN(PSS) ;Entry point into routine
 ; FL - File
 ; IEN - The starting IEN
 ; RCNT - Number of records desired
 ; TYPE - 1
 ;
 ;
 S FNAME="SyncResponse.XML"
 S FL=$G(PSS("FILE"))
 I FL="" D OUT^PSSMIGRC(" Error... Missing required data") Q
 N XST,CNT
 S CNT=0,XST=0
 I FL=50.607 D DUNI Q  ;Drug Unit
 I FL=50.416 D DING Q  ;Drug Ingredients
 I FL=50.605 D VADC Q  ;VA Drug Class
 I FL=50.606 D DSFO Q  ;Dosage Form
 I FL=50.6 D VAGN^PSSMIGRE Q  ;VA Generic Name
 I FL=50.64 D VADU Q  ; VA Dispense UNIT
 I FL=55.95 D MAN^PSSMIGRE Q  ;Manufacturer
 I FL=50.608 D PTYP^PSSMIGRE Q  ;Package Type
 I FL=50.67 D NDC^PSSMIGRE Q  ;NDC 
 I FL=50.68 D VAPD^PSSMIGRR Q  ;VA Product
 ;
 ;File Error Process
 D OUT^PSSMIGRC(" Error... Invalid File Number")
 Q
 ;
 ;DIA(50.
DUNI ; DRUG UNIT file Synch 
 ;
 N X,Y,DIC,DA,DR,DIE,IEN,NAME,RTYPE,IDATE,PS5
 I PSS("NAME")="" D OUT^PSSMIGRC(" Error...Missing Required NAME") Q
 S NAME=$G(PSS("NAME")),IEN=$G(PSS("IEN")),RTYPE=$G(PSS("RTYPE"))
 S IDATE=$TR($P($G(PSS("IDATE")),"T"),"-",""),IDATE=$$HL7TFM^XLFDT(IDATE,"L")
 S FNAME="syncResponse.XML",FNUM=50.607
 S FNAME1="drugUnits"
 ;
 ;Add the DRUG UNIT to the Database
 D:RTYPE="ADD"
 . ; Lock the Global
 . L +^PS(50.607):5 E  D OUT^PSSMIGRC(" Another USER editing DRUG UNIT file") Q
 . ;
 . ; Cheating - Remove LAYGO temporarly
 . S ^TMP("AJF LAYGO",$J)=$G(^DD(50.607,.01,"LAYGO",.01,0))
 . I ^TMP("AJF LAYGO",$J)]"" K ^DD(50.607,.01,"LAYGO",.01,0)
 . ;
 . ; Get the IEN
 . S X=NAME,DIC=50.607,DIC(0)="LMXZ"
 . D ^DIC
 . S (DA,PSS("IEN"))=+Y
 . ;
 . ; Quit if cannot get IEN
 . I Y<1 D  Q
 . . D OUT^PSSMIGRC(" Error...Cannot obtain an IEN for NAME")
 . . S:^TMP("AJF LAYGO",$J)]"" ^DD(50.607,.01,"LAYGO",.01,0)=^TMP("AJF LAYGO",$J)
 . ;
 . ; Set Database Variables
 . S PSS("IEN")=DA,DIE=DIC K DIC
 . ;S DR=".01///^S X=NAME;1///^S X=IDATE"
 . S DR="1///^S X=IDATE"
 . ;
 . ; Update Database
 . D ^DIE
 . ;
 . ; Put LAYGO back
 . S:^TMP("AJF LAYGO",$J)]"" ^DD(50.607,.01,"LAYGO",.01,0)=^TMP("AJF LAYGO",$J)
 . L -^PS(50.607)
 ;
 D:RTYPE="MODIFY"
 .S DA=PSS("IEN"),DIE="^PS(50.607,"
 .;S DR=".01///^S X=NAME;1///"_$S(IDATE]"":"^S X=IDATE",1:"@")
 .S PS5=$G(^PS(50.607,DA,0)),DR="",PQ=""
 .S:$P(PS5,"^",1)'=NAME DR=".01///^S X=NAME" S:$L(DR) PQ=";"
 .S DR=DR_PQ_"1///"_$S(IDATE]"":"^S X=IDATE",1:"@")
 .D ^DIE
 ;
 S XMESS="<message>  Updated Drug Units: "_NAME_" </message>"
 S XIEN="<ien>"_PSS("IEN")_"</ien>"
 K DIC,DA,DR,DIE,^TMP("AJF LAYGO",$J)
 Q
 ;
VADU ; VA Dispense UNIT file Synch
 ;
 N X,Y,DIC,DA,DR,DIE,IEN,NAME,RTYPE,IDATE
 S IEN=$G(PSS("IEN")),NAME=$G(PSS("NAME")),RTYPE=$G(PSS("RTYPE"))
 S IDATE=$TR($P($G(PSS("IDATE")),"T"),"-",""),IDATE=$$HL7TFM^XLFDT(IDATE,"L")
 S FNUM=50.64,FNAME="syncResponse.XML",FNAME1="vaDispenseUnits"
 S ERROR=0
 ;
 ; Quit if REQUIRED DATA is Missing
 I RTYPE="MODIFY",'+(PSS("IEN")) D OUT^PSSMIGRC(" Error... Invalid IEN") Q
 I NAME="" D OUT^PSSMIGRC(" Error...Missing Required NAME") Q
 I RTYPE'="ADD",RTYPE'="MODIFY"  D OUT^PSSMIGRC("Error...Invalid Request Type") Q
 ;
 ;Add the Dispense UNIT to the Database
 D:RTYPE="ADD"
 . ; Lock the Global
 . L +^PSNDF(50.64):5 E  S ERROR=1 D OUT^PSSMIGRC(" *Another USER editing VA Dispense Unit file") Q
 . ;
 . ; Cheating - Remove LAYGO temporarly
 . S ^TMP("AJF LAYGO",$J)=$G(^DD(50.64,.01,"LAYGO",.01,0))
 . I ^TMP("AJF LAYGO",$J)]"" K ^DD(50.64,.01,"LAYGO",.01,0)
 . ;
 . ; Get the IEN
 . S X=NAME,DIC=50.64,DIC(0)="LMXZ"
 . D ^DIC
 . S (DA,PSS("IEN"))=+Y
 . ;
 . ; Quit if cannot get IEN
 . I Y<1 D  Q
 . . S ERROR=1
 . . D OUT^PSSMIGRC(" Error...Cannot obtain an IEN for NAME")
 . . S:^TMP("AJF LAYGO",$J)]"" ^DD(50.64,.01,"LAYGO",.01,0)=^TMP("AJF LAYGO",$J)
 . ;
 . ;Set Database Variables
 . S PSS("IEN")=DA,DIE=DIC K DIC
 . ;S DR=".01///^S X=NAME;1///^S X=IDATE"
 . S DR="1///^S X=IDATE"
 . ;
 . ; Update Database
 . D ^DIE
 . ;
 . ; Put LAYGO back
 . S:^TMP("AJF LAYGO",$J)]"" ^DD(50.64,.01,"LAYGO",.01,0)=^TMP("AJF LAYGO",$J)
 . L -^PSNDF(50.64)
 ;
 Q:ERROR
 D:RTYPE="MODIFY"
 .S DA=PSS("IEN"),DIE=50.64
 .S PS5=$G(^PSNDF(50.64,DA,0)),DR="",PQ=""
 .S:$P(PS5,"^",1)'=NAME DR=".01///^S X=NAME" S:$L(DR) PQ=";"
 .S DR=DR_PQ_"1///"_$S(IDATE]"":"^S X=IDATE",1:"@")
 .D ^DIE
 ;
 S XMESS="<message> Updated Dispense Units "_NAME_" </message>"
 S XIEN="<ien>"_PSS("IEN")_"</ien>"
 Q
 ;
DING ; Drug Ingredients file Synch
 ;
 N X,Y,DIC,DA,DR,DIE,IEN,NAME,RTYPE,IDATE,PRIMARY,MVUID,VUID,EFFDT,STATUS
 S IEN=$G(PSS("IEN")),NAME=$G(PSS("NAME")),RTYPE=$G(PSS("RTYPE"))
 S PRIMARY=$G(PSS("PRIMARY")),MVUID=$G(PSS("MASTERVUID")),VUID=$G(PSS("VUID"))
 S EFFDT=$G(PSS("EFFDATE")),STATUS=$G(PSS("STATUS"))
 S IDATE=$TR($P($G(PSS("INACTDATE")),"T"),"-",""),IDATE=$$HL7TFM^XLFDT(IDATE,"L")
 S FNUM=50.416,FNAME="syncResponse.XML",FNAME1="drugIngredients"
 ;
 ; Quit if REQUIRED DATA is Missing
 I NAME="" D OUT^PSSMIGRC(" Error...Missing Required NAME") Q
 I MVUID="" D OUT^PSSMIGRC(" Error...Missing Required MASTER VUID") Q
 I VUID="" D OUT^PSSMIGRC(" Error...Missing Required VUID") Q
 I EFFDT="" D OUT^PSSMIGRC(" Error...Missing Required EFFECTIVE DATE") Q
 I STATUS="" D OUT^PSSMIGRC(" Error...Missing Required STATUS") Q
 I RTYPE="MODIFY",'+(PSS("IEN")) D OUT^PSSMIGRC(" Error... Invalid IEN") Q
 ;
 S EFFDT=$$DATE($G(PSS("EFFDATE")))
 ;
 ;Add the Ingredient to the Database
 D:RTYPE="ADD"
 . ; Lock the Global
 . ;L +^PS(50.416):5 E  D OUT^PSSMIGRC(" Another USER is editing Drug Ingredients file") Q
 . ;
 . ; Cheating - Remove LAYGO temporarly
 . S ^TMP("AJF LAYGO",$J)=$G(^DD(50.416,.01,"LAYGO",.01,0))
 . I ^TMP("AJF LAYGO",$J)]"" K ^DD(50.416,.01,"LAYGO",.01,0)
 . ;
 . ; Get the IEN
 . S X=NAME,DIC=50.416,DIC(0)="LMXZ"
 . D ^DIC
 . S (DA,PSS("IEN"),PIEN)=+Y
 . ;
 . ; Quit if cannot get IEN
 . I Y<1 D  Q
 . . D OUT^PSSMIGRC(" Error...Cannot obtain an IEN for NAME")
 . . S:^TMP("AJF LAYGO",$J)]"" ^DD(50.416,.01,"LAYGO",.01,0)=^TMP("AJF LAYGO",$J)
 . ;
 . ; Set Database Variables
 . S DIE=DIC K DIC
 . S DR="2///^S X=PRIMARY;3///^S X=IDATE;99.98///^S X=MVUID;99.99///^S X=VUID"
 . S (PSS("IEN"),PIEN)=DA
 . ;
 . ; Update Database
 . D ^DIE
 . ; Stuff EFFECTIVE DATE/TIME entries
 . S DIC="^PS(50.416,"_PIEN_",""TERMSTATUS"",",DIC(0)="L",DIC("P")="50.4169A"
 . S DA(1)=PIEN,DA=1,X=EFFDT
 . D FILE^DICN
 . S DIE=DIC,DR=".02///^S X=STATUS"
 . D ^DIE
 . ; 
 . ;
 . ; Put LAYGO back
 . S:^TMP("AJF LAYGO",$J)]"" ^DD(50.416,.01,"LAYGO",.01,0)=^TMP("AJF LAYGO",$J)
 . ;L -^PS(50.416)
 . ;
 . ; Updating ^NDFK files
 . ;
 . I NAME]"" S X=NAME,DIC=5000.508,DIC(0)="LMXZ" D ^DIC
 . ;
 D:RTYPE="MODIFY"
 .S (DA,PIEN)=PSS("IEN"),DIE=50.416
 .S PS5=$G(^PS(50.416,DA,0)),PSMV=$G(^PS(50.416,DA,"VUID")),DR="",PQ=""
 .S OPN=$P(PS5,"^",2)
 .S:+OPN OPN=$P($G(^PS(50.416,OPN,0)),"^")
 .S:OPN'=PRIMARY DR="2///"_$S(PRIMARY]"":"^S X=PRIMARY",1:"@") S:$L(DR) PQ=";"
 .S:$P($G(^PS(50.416,DA,2)),"^",1)'=IDATE DR=DR_PQ_"3///"_$S(IDATE]"":"^S X=IDATE",1:"@") S:$L(DR) PQ=";"
 .;S CMVUID=$P(PSMV,"^",2),CMVUID=$S(CMVUID=1:"YES",CMVUID=0:"NO",1:"")
 .S:$P(PSMV,"^",2)'=MVUID DR=DR_PQ_"99.98///^S X=MVUID" S:$L(DR) PQ=";"
 .S:$P(PSMV,"^",1)'=VUID DR=DR_PQ_"99.99///^S X=VUID" S:$L(DR) PQ=";"
 .;
 .; Update Database
 .D ^DIE
 .;
 ;
 S XMESS="<message>  Updated Drug Ingredients: "_NAME_" </message>"
 S XIEN="<ien>"_PSS("IEN")_"</ien>"
 K DIC,DA,DR,DIE,^TMP("AJF LAYGO",$J)
 Q
 ;
VADC ;VA DRUG CLASS Sync
 ;
 N DA,DIE,DR,CLASS,CODE,PARENTCLASS,TYPE,RTYPE,DESC,VUID,MVUID,EFFDT,STATUS,PCIEN,PCODE
 S PCLASS=$G(PSS("PCLASS")),PCODE=$G(PSS("PCODE")),PCIEN=$G(PSS("PCIEN"))
 S CODE=$G(PSS("CLASSCODE")),CLASS=$G(PSS("CLASSCLASS")),TYPE=$G(PSS("TYPE"))
 S RTYPE=$G(PSS("RTYPE")),DESC=$G(PSS("DESC")),VUID=$G(PSS("VUID"))
 S MVUID=$G(PSS("MASTERVUID")),IEN=$G(PSS("IEN"))
 S EFFDT=$G(PSS("EFFDATE")),STATUS=$G(PSS("STATUS")),DESC=$G(PSS("DESC"))
 S FNUM=50.605,FNAME="syncResponse.XML",FNAME1="vaDrugClass"
 ;
 ; Quit if REQUIRED DATA is Missing
 I CODE="" D OUT^PSSMIGRC(" Error...Missing Required VA DRUG CLASS CODE") Q
 I MVUID="" D OUT^PSSMIGRC(" Error...Missing Required VA DRUG CLASS MASTER VUID") Q
 I VUID="" D OUT^PSSMIGRC(" Error...Missing Required VA DRUG CLASS VUID") Q
 I EFFDT="" D OUT^PSSMIGRC(" Error...Missing Required VA DRUG CLASS EFFECTIVE DATE") Q
 I STATUS="" D OUT^PSSMIGRC(" Error...Missing Required VA DRUG CLASS STATUS") Q
 ;
 S EFFDT=$$DATE($G(PSS("EFFDATE")))
 ;
 ;Add the VA DRUG Class to the Database
 D:RTYPE="ADD"
 . ; Lock the Global
 . L +^PS(50.605):5 E  D OUT^PSSMIGRC(" *VA DRUG CLASS file NOT UPDATED. Another USER editing file") Q
 . ;
 . ; Cheating - Remove the check for LAYGO temporarly
 . S ^TMP("AJF LAYGO",$J)=$G(^DD(50.605,.01,"LAYGO",.01,0))
 . I ^TMP("AJF LAYGO",$J)]"" K ^DD(50.605,.01,"LAYGO",.01,0)
 . ;
 . ; Get the IEN
 . S X=CODE,DIC=50.605,DIC(0)="LMXZ"
 . D ^DIC
 . S (DA,PSS("IEN"),PIEN)=+Y
 . ;
 . ; Quit if cannot get IEN
 . I Y<1 D  Q
 . . D OUT^PSSMIGRC(" Error...Cannot obtain an IEN for VA DRUG CLASS - CLASS CODE")
 . . S:^TMP("AJF LAYGO",$J)]"" ^DD(50.605,.01,"LAYGO",.01,0)=^TMP("AJF LAYGO",$J)
 . ;
 . ; Set Database Variables
 . S DIE=DIC K DIC
 . S DR="1///^S X=CLASS;2///^S X=PCIEN;3///^S X=TYPE;4///^S X=DESC;"
 . S DR=DR_"99.98///^S X=MVUID;99.99///^S X=VUID"
 . ;
 . ; Update Database
 . D ^DIE
 . ; Stuff EFFECTIVE DATE/TIME entries
 . S DIC="^PS(50.605,"_PIEN_",""TERMSTATUS"",",DIC(0)="L",DIC("P")="50.60509DA"
 . S DA(1)=PIEN,DA=1,X=EFFDT
 . D FILE^DICN
 . S DIE=DIC,DR=".02///^S X=STATUS"
 . D ^DIE
 . L -^PS(50.605)
 ;
 D:RTYPE="MODIFY"
 .S (DA,PIEN)=PSS("IEN"),DIE=50.605
 .S PS5=$G(^PS(50.605,DA,0)),PSMV=$G(^PS(50.605,DA,"VUID")),DR="",PQ=""
 .S:$P(PS5,"^",3)'=PCIEN DR="2///"_$S(PCIEN]"":"^S X=PCIEN",1:"@"),PQ=";"
 .S:$P(PS5,"^",4)'=TYPE DR=DR_PQ_"3///^S X=TYPE",PQ=";"
 .S:$P($G(^PS(50.605,DA,1)),"^",1)'=DESC DR=DR_PQ_"4///^S X=DESC",PQ=";"
 .;S CMVUID=$P(PSMV,"^",2),CMVUID=$S(CMVUID=1:"YES",CMVUID=0:"NO",1:"")
 .S:$P(PSMV,"^",2)'=MVUID DR=DR_PQ_"99.98///^S X=MVUID" S:$L(DR) PQ=";"
 .S:$P(PSMV,"^",1)'=VUID DR=DR_PQ_"99.99///^S X=VUID" S:$L(DR) PQ=";"
 . ;
 . ; Update Database
 . D ^DIE
 ;
 S XMESS="<message>  Updated Drug Class "_CODE_" </message>"
 S XIEN="<ien>"_PSS("IEN")_"</ien>"
 Q
 ;
DSFO ;DOSAGE FORM Sync
 ;
 ;
 N X,Y,DIC,DA,DR,DIE,NAME,EXCLUDE,PACKAGE,PDPACKAGE,PERDOSE,UNIT,PIEN
 S NAME=$G(PSS("NAME")),EXCLUDE=$G(PSS("EXCLUDE")),RTYPE=$G(PSS("RTYPE"))
 S IDATE=$TR($P($G(PSS("INACTDATE")),"T"),"-",""),IDATE=$$HL7TFM^XLFDT(IDATE)
 S PERDOSE=$G(PSS("PERDOSE")),PDPACKAGE=$G(PSS("PDPACKAGE"))
 S UNIT=$G(PSS("UNITS")),PACKAGE=$G(PSS("PACKAGE"))
 S FNUM=50.606,FNAME="syncResponse.XML",FNAME1="dosageForm"
 ;
 I NAME="" D OUT^PSSMIGRC(" Error...Missing Required DOSAGE FORM NAME") Q
 I EXCLUDE="" D OUT^PSSMIGRC(" Error...Missing Required Exclude From Dosage Checks FLAG") Q
 I RTYPE'="ADD",RTYPE'="MODIFY"  D OUT^PSSMIGRC("Error...Invalid Request Type") Q
 ;
 ;Add the DOSAGE FORM to the Database 
 D:RTYPE="ADD"
 . ;L +^PS(50.606):5 E  D OUT^PSSMIGRC(" Another USER editing DOSAGE FORM file") Q
 . ;L -^PS(50.606)
 . ;
 . ; Cheating - Remove the check for LAYGO temporarly
 . S ^TMP("AJF LAYGO",$J)=$G(^DD(50.606,.01,"LAYGO",.01,0))
 . I ^TMP("AJF LAYGO",$J)]"" K ^DD(50.606,.01,"LAYGO",.01,0)
 . ;
 . ; Get the IEN
 . S X=NAME,DIC=50.606,DIC(0)="LMXZ"
 . D ^DIC I Y<1 K DIC,DA Q
 . ;
 . ; Set Database Variables
 . S DIE=DIC K DIC
 . S DA=+Y
 . S DR="7///^S X=IDATE;11///^S X=EXCLUDE"
 . S (PSS("IEN"),PIEN)=DA
 . ;
 . ; Update Database
 . D ^DIE
 . ;
 . D DUPD
 . ;
 . ; Put LAYGO back
 . S:^TMP("AJF LAYGO",$J)]"" ^DD(50.606,.01,"LAYGO",.01,0)=^TMP("AJF LAYGO",$J)
 ;
 D:RTYPE="MODIFY"
 . S DA=PSS("IEN"),DIE=50.606
 . S PS5=$G(^PS(50.606,DA,0)),DR="",PQ=""
 . S:$P(PS5,"^",2)'=IDATE DR="7///"_$S(IDATE]"":"^S X=IDATE",1:"@"),PQ=";"
 . S PSX=$P($G(^PS(50.606,DA,1)),"^",1),PSX=$S(PSX=0:"NO",PSX=1:"YES",1:"")
 . S:PSX'=EXCLUDE DR=DR_PQ_"11///^S X=EXCLUDE"
 . ;
 . ; Update Database
 . D ^DIE
 . S PIEN=DA
 . D DUPD
 ;
 ;
 ;
 Q:$G(ERROR)=1
 ;
 S XMESS="<message> <![CDATA[ Updated Dosage Form "_NAME_"]]> </message>"
 S XIEN="<ien>"_PSS("IEN")_"</ien>"
 K DIC,DA,DR,DIE,^TMP("AJF LAYGO",$J)
 Q
 ;
DUPD ;
 ;
 I +PERDOSE D
 . N CNT,UPACK,DA,PSDUPD S (DA,CNT)=0
 . S DIC="^PS(50.606,"_PIEN_",""DUPD"",",DIC(0)="L",DIC("P")="50.6069"
 . ; Cheating - Remove the check for LAYGO temporarly
 . S ^TMP("AJF LAYGO DF",$J)=$G(^DD(50.6069,.01,"LAYGO",1,0))
 . I ^TMP("AJF LAYGO DF",$J)]"" K ^DD(50.6069,.01,"LAYGO",1,0)
 . F CNT=1:1:PERDOSE Q:'$D(PSS("PDDOSE"_CNT))  D
 .. S DA=$O(^PS(50.606,PIEN,"DUPD","B",PSS("PDDOSE"_CNT),""))
 .. I '+DA S DA(1)=PIEN,DA=CNT,X=PSS("PDDOSE"_CNT) D FILE^DICN
 .. S DA(1)=PIEN,OPACK="",PSDUPD(PSS("PDDOSE"_CNT))=""
 .. S DA=$O(^PS(50.606,PIEN,"DUPD","B",PSS("PDDOSE"_CNT),""))
 .. S:+DA OPACK=$P(^PS(50.606,PIEN,"DUPD",DA,0),"^",2)
 .. S UPACK=$G(PSS("PDPACKAGE"_CNT))
 .. I OPACK'=UPACK S DIE=DIC,DR="1///"_$S(UPACK]"":"^S X=UPACK",1:"@") D ^DIE
 . ;
 . ; Removing old entries from multiple
 . S CNT=0,DIK="^PS(50.606,"_PIEN_",""DUPD"",",DA(1)=PIEN
 . F  S CNT=$O(^PS(50.606,PIEN,"DUPD","B",CNT)) Q:CNT=""  D
 .. Q:$D(PSDUPD(CNT))
 .. S DA=$O(^PS(50.606,PIEN,"DUPD","B",CNT,""))
 .. D ^DIK
 ;
 S:^TMP("AJF LAYGO DF",$J)]"" ^DD(50.6069,.01,"LAYGO",1,0)=^TMP("AJF LAYGO DF",$J)
 ;
 I +UNIT D
 . N CNT,UPACK,DA,PSUNITS S (DA,CNT)=0
 . S DIC="^PS(50.606,"_PIEN_",""UNIT"",",DIC(0)="L",DIC("P")="50.6068P"
 . ; Cheating - Remove the check for LAYGO temporarly
 . S ^TMP("AJF LAYGO UT",$J)=$G(^DD(50.6068,.01,"LAYGO",1,0))
 . I ^TMP("AJF LAYGO UT",$J)]"" K ^DD(50.6068,.01,"LAYGO",1,0)
 . ;
 . F CNT=1:1:UNIT Q:'$D(PSS("UNITS"_CNT))  D
 .. S DA=$O(^PS(50.606,PIEN,"UNIT","B",PSS("UNITSIEN"_CNT),""))
 .. I '+DA S DA(1)=PIEN,DA=CNT,X=PSS("UNITSIEN"_CNT) D FILE^DICN
 .. S DA(1)=PIEN,OPACK="",PSUNITS(PSS("UNITSIEN"_CNT))=""
 .. S DA=$O(^PS(50.606,PIEN,"UNIT","B",PSS("UNITSIEN"_CNT),""))
 .. S:+DA OPACK=$P(^PS(50.606,PIEN,"UNIT",DA,0),"^",2)
 .. S UPACK=$G(PSS("PACKAGE"_CNT))
 .. I OPACK'=UPACK S DIE=DIC,DR="1///"_$S(UPACK]"":"^S X=UPACK",1:"@") D ^DIE
 . ;
 . ; Removing old entries from multiple
 . S CNT=0,DIK="^PS(50.606,"_PIEN_",""UNIT"",",DA(1)=PIEN
 . F  S CNT=$O(^PS(50.606,PIEN,"UNIT","B",CNT)) Q:CNT=""  D
 .. Q:$D(PSUNITS(CNT))
 .. S DA=$O(^PS(50.606,PIEN,"UNIT","B",CNT,""))
 .. D ^DIK
 ;
 S:^TMP("AJF LAYGO UT",$J)]"" ^DD(50.6068,.01,"LAYGO",1,0)=^TMP("AJF LAYGO UT",$J)
 ;
 ;
 ;
DATE(DT) ; Format date time
 ;
 Q:$L(DT)="" ""
 S FDT=$TR($P($G(DT),"T"),"-","")
 ;S $TR($P(DT,"."),":",""),FDT=$TR(FDT,"-",""),FDT=$TR(FDT,"T","")
 S FDT=$$HL7TFM^XLFDT(FDT,"L")
 Q FDT
 ;
