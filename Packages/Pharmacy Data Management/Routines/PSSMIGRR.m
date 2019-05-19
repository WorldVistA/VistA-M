PSSMIGRR ;AJF - Process Synch XML message from PEPS;  07/23/2012 1425
 ;;1.0;PHARMACY ENTERPRISE PRODUCT SYSTEM;;;Build 36
 ;;
 ; Called from ^PSSMIGRD
 ;;
 Q
 ;
VAPD ;VA Product Sync
 ;
 ;
 N X,Y,DIC,DA,DR,DIE,EFFDT,STATUS,EDT,PACK,UTIEN,GCNO
 N RTYPE,NAME,GENNAME,GENIEN,DFNAME,DFIEN,STRGEN,UNITS,NFNAME,PRINTNAME,PRODID,TRANSTC,DUIEN
 N AINAME,AIIEN,AISTRG,AIUNAME,AINAME2,AIIEN2,AIUNAME2,GCNSEQNO,PVADCCODE,PVADCCLASS,PVADCIEN
 N NFINDICATOR,CSFSCHED,SMSPROD,EDDINTER,CPDOSAGE,MVUID,VUID,PRODID,PDTCREATE,ODFDCHKX,VAPTN
 ; Check REQUIRED Fields
 I $G(PSS("NAME"))="" D OUT^PSSMIGRC(" Error...Missing Required VA PRODUCT NAME") Q
 I $G(PSS("MVUID"))="" D OUT^PSSMIGRC(" Error...Missing Required VA PRODUCT Master Entry VUID") Q
 I $G(PSS("VUID"))="" D OUT^PSSMIGRC(" Error...Missing Required VA PRODUCT VUID") Q
 I $G(PSS("EFFDT"))="" D OUT^PSSMIGRC(" Error...Missing Required VA PRODUCT EFFECTIVE DATE/TIME") Q
 I $G(PSS("EDTS"))="" D OUT^PSSMIGRC(" Error...Missing Required VA PRODUCT PRODUCT EFFECTIVE DATE/TIME") Q
 I $G(PSS("ODFDCHKX"))="" D OUT^PSSMIGRC(" Error...Missing Required VA PRODUCT OVERRIDE DF DOSE CHK EXCLUSION") Q
 ;
 ;
 S RTYPE=$G(PSS("RTYPE")) ;RequestType
 S NAME=$G(PSS("NAME")) ;vaProductName
 S GENNAME=$G(PSS("GENNAME")) ;vaGenericNameName
 S GENIEN=$G(PSS("GENIEN")) ;vaGenericIen
 S DFNAME=$G(PSS("DFNAME")) ;dosageFormName
 S DFIEN=$G(PSS("DFIEN")) ;dosageFormIen
 S STRGEN=$G(PSS("STRGEN")) ;strength
 S UNITS=$G(PSS("UNITS")) ;units
 S NFNAME=$G(PSS("NFNAME")) ;nationalFormularyName
 S PRINTNAME=$G(PSS("PRINTNAME")) ;vaPrintName
 S PRODID=$G(PSS("PRODID")) ;vaProductIdentifier
 S TRANSTC=$G(PSS("TRANSTC")) ;transmitToCmop
 S DUNAME=$G(PSS("DUNAME")) ;vaDispenseName
 S DUNIEN=$G(PSS("DUIEN")) ;vaDispenseUnitIen
 S GCNO="0000000"_$G(PSS("GCNSEQNO")) ;gcnSeqNo padded with zeros
 S GCNSEQNO=$E(GCNO,($L(GCNO)-5),$L(GCNO)) ;gcnSeqNo
 S PVADCCLASS=$G(PSS("PVADCCLASS")) ;primaryVaDrugClassClassification
 S PVADCCODE=$G(PSS("PVADCCODE")) ;primaryVaDrugClassCode
 S PVADCIEN=$G(PSS("PVADCIEN")) ;primaryVaDrugClassIen
 S NFINDICATOR=$G(PSS("NFINDICATOR")) ;nationalFormularyIndicator
 S CSFSCHED=$G(PSS("CSFSCHED")) ;csFederalSchedule
 S SMSPROG=$G(PSS("SMSPROD")) ;singleMultiSourceProduct
 S EDDINTER=$G(PSS("EDDINTER")) ;excludeDrugDrugInteraction
 S:EDDINTER'=1 EDDINTER=""
 S ODFDCHKX=$G(PSS("ODFDCHKX")) ;overrideDfDoseChkExclusion
 S CPDOSAGE=$G(PSS("CPDOSAGE")) ;createPossibleDosage
 S PDTCREATE=$G(PSS("PDTCREATE")) ;possibleDosagesToCreateS
 S MVUID=$G(PSS("MVUID")) ;masterEntryForVuid
 S VUID=$G(PSS("VUID")) ;Vuid
 S PRODID=$G(PSS("PRODID")) ;Vuid
 S IDATE=$TR($P($G(PSS("INACTDATE")),"T"),"-",""),IDATE=$$HL7TFM^XLFDT(IDATE)
 S FNUM=50.68,FNAME="syncResponse.XML",FNAME1="dosageForm"
 S ACTID=$G(PSS("ACTID"))
 S EFFDT=$$DATE^PSSMIGRD($G(PSS("EFFDT"))) ;effectiveDateTime
 S STATUS=$G(PSS("EDTS")) ;effectiveDateTimeStatus
 S FDAMG=$G(PSS("FDAMEDGUIDE")) ;fdamedguide
 S SCODE=$G(PSS("SCODE")) ; servicecode
 S PACK=$G(PSS("PACK")) ;package
 S:SMSPROG="" SMSPROG="@"
 ;
 I $L(UNITS),'$O(^PS(50.607,"B",UNITS,"")) D OUT^PSSMIGRC(" Error...Invaild Units Name") Q 
 ;
 ;Add the VA PRODUCT record to the Database 
 D:RTYPE="ADD"
 . ;L +^PSNDF(50.68):5 E  D OUT^PSSMIGRC(" Another USER editing VA PRODUCT FILE file") Q
 . ;
 . ; Cheating - Remove the check for LAYGO temporarly
 . S ^TMP("AJF LAYGO",$J)=$G(^DD(50.68,.01,"LAYGO",.01,0))
 . I ^TMP("AJF LAYGO",$J)]"" K ^DD(50.68,.01,"LAYGO",.01,0)
 . ;
 . ; Get the IEN
 . S X=NAME,DIC=50.68,DIC(0)="LMXZ"
 . D ^DIC
 . ; Quit if cannot get IEN
 . I Y<1 D  Q
 . . S:^TMP("AJF LAYGO",$J)]"" DD(50.68,.01,"LAYGO",1,0)=^TMP("AJF LAYGO",$J)
 . . L -^PS(50.68)
 . . D OUT^PSSMIGRC(" Error...Cannot obtain an IEN for VA PRODUCT NAME")
 . ;L -^PS(50.68)
 . ;
 . ; Set Database Variables
 . S DIE=DIC K DIC
 . S DA=+Y
 . S DR=".05////^S X=GENIEN;1////^S X=DFIEN;2///^S X=STRGEN;17///^S X=NFINDICATOR;3///^S X=UNITS;4///^S X=NFNAME;"
 . S DR=DR_"5///^S X=PRINTNAME;6///^S X=PRODID;7///^S X=TRANSTC;8///^S X=DUNAME;"
 . S DR=DR_"11////^S X=GCNSEQNO;15///^S X=PVADCIEN;42///^S X=PACK;"
 . S DR=DR_"19///^S X=CSFSCHED;20///^S X=SMSPROG;23///^S X=EDDINTER;31///^S X=ODFDCHKX;"
 . S DR=DR_"40///^S X=CPDOSAGE;41///^S X=PDTCREATE;99.98///^S X=MVUID;99.99///^S X=VUID;"
 . S DR=DR_"100///^S X=FDAMG;2000///^S X=SCODE"
 . ;
 . S (PSS("IEN"),PIEN)=DA
 . ; Update Database
 . D ^DIE
 . ;
 . ; Update Active Ingredients multiple
 . I +ACTID D UAI
 . ;
 . ;  Update Effective Date/Time
 . S DIC="^PSNDF(50.68,"_PIEN_",""TERMSTATUS"",",DIC(0)="L",DIC("P")="50.6899DA"
 . S DA(1)=PIEN,DA=1,X=EFFDT
 . D FILE^DICN
 . S DIE=DIC,DR=".02///^S X=STATUS"
 . D ^DIE
 . ; Put LAYGO back 
 . S:^TMP("AJF LAYGO",$J)]"" DD(50.68,.01,"LAYGO",1,0)=^TMP("AJF LAYGO",$J)
 . ;
 . ;
 . ; Updating ^NDFK files
 . ;
 . I NAME]"" S X=NAME,DIC=5000.506,DIC(0)="LMXZ" D ^DIC
 . ;I IDATE]"" S X=NAME,DIC=5000.2,DIC(0)="LMXZ" D ^DIC
 ;
 ;
 ;
 ;Modify the VA PRODUCT record
 D:RTYPE="MODIFY"
 . ; Setting variables for NDFK checking
 . S (PIEN,DA)=PSS("IEN"),DIE=50.68
 . S PS0=^PSNDF(50.68,DA,0),PS1=$G(^PSNDF(50.68,DA,1))
 . S NAFI=$P($G(^PSNDF(50.68,DA,5)),"^"),EDCK=$P($G(^PSNDF(50.68,DA,8)),"^")
 . S PVDC=$P($G(^PSNDF(50.68,DA,3)),"^"),PS1=$G(^PSNDF(50.68,DA,1))
 . S OVCK=$P($G(^PSNDF(50.68,DA,9)),"^",1),PS7=$G(^PSNDF(50.68,DA,7))
 . S DOS=$G(^PSNDF(50.68,DA,"DOS")),FMG=$P($G(^PSNDF(50.68,DA,"MG")),"^")
 . S VUID0=$G(^PSNDF(50.68,DA,"VUID")),PSF0=$G(^PSNDF(50.68,DA,"PFS"))
 . S DR="",PQ=""
 . ;
 . S:$P(PS0,"^",2)'=GENIEN DR=".05////"_$S(GENIEN]"":"^S X=GENIEN",1:"@") S:$L(DR) PQ=";"
 . S:$P(PS0,"^",3)'=DFIEN DR=DR_PQ_"1////"_$S(DFIEN]"":"^S X=DFIEN",1:"@") S:$L(DR) PQ=";"
 . I $P(PS0,"^",4)'=STRGEN S DR=DR_PQ_"2///"_$S(STRGEN]"":"^S X=STRGEN",1:"@") S:$L(DR) PQ=";" D
 .. ; Strength Change
 .. S X=NAME,DIC=5000.4,DIC(0)="LMXZ" D ^DIC
 .. S X=NAME,DIC=5000.2,DIC(0)="LMXZ" D ^DIC
 . S UIEN=$P(PS0,"^",5)
 . S UNT=$S($L(UIEN):$P($G(^PS(50.607,UIEN,0)),"^",1),1:"")
 . S:UNT'=UNITS DR=DR_PQ_"3///"_$S(UNITS]"":"^S X=UNITS",1:"@") S:$L(DR) PQ=";"
 . I $P(DOS,"^",1)'=$E(CPDOSAGE,1) S DR=DR_PQ_"40///^S X=CPDOSAGE" S:$L(DR) PQ=";" D
 .. ; Possible Dosage Setting Changes
 .. S (X,DINUM)=PIEN,DIC=5000.92,DIC(0)="LMXZ" D FILE^DICN
 . I $P(DOS,"^",3)'=PACK S DR=DR_PQ_"42///"_$S(PACK]"":"^S X=PACK",1:"@") S:$L(DR) PQ=";" D
 .. S (X,DINUM)=PIEN,DIC=5000.92,DIC(0)="LMXZ" D FILE^DICN
 . I $P(DOS,"^",2)'=PDTCREATE S DR=DR_PQ_"41///"_$S(PDTCREATE]"":"^S X=PDTCREATE",1:"@") D
 .. S:$L(DR) PQ=";"
 .. S (X,DINUM)=PIEN,DIC=5000.92,DIC(0)="LMXZ" D FILE^DICN
 . S:$P(PS0,"^",6)'=NFNAME DR=DR_PQ_"4///"_$S(NFNAME]"":"^S X=NFNAME",1:"@") S:$L(DR) PQ=";"
 . S VAPTN=$$TRIM^XLFSTR($$UP($P(PS1,"^",1)))
 . S:VAPTN'=PRINTNAME DR=DR_PQ_"5///"_$S(PRINTNAME]"":"^S X=PRINTNAME",1:"@") S:$L(DR) PQ=";"
 . S:$P(PS1,"^",2)'=PRODID DR=DR_PQ_"6///"_$S(PRODID]"":"^S X=PRODID",1:"@") S:$L(DR) PQ=";"
 . I $P(PS1,"^",3)'=TRANSTC S DR=DR_PQ_"7///"_$S(TRANSTC]"":"^S X=TRANSTC",1:"@") S:$L(DR) PQ=";" D
 .. ; Umarked For CMOP
 .. I TRANSTC=0&($P(PS1,"^",3)=1) S X=NAME,DIC=5000.7,DIC(0)="LMXZ" D ^DIC
 . S:$P(PS1,"^",4)'=DUNIEN DR=DR_PQ_"8///"_$S(DUNAME]"":"^S X=DUNAME",1:"@") S:$L(DR) PQ=";"
 . S:$P(PS1,"^",5)'=GCNSEQNO DR=DR_PQ_"11////"_$S(GCNSEQNO]"":"^S X=GCNSEQNO",1:"@") S:$L(DR) PQ=";"
 . I PVDC'=PVADCIEN S DR=DR_PQ_"15///^S X=PVADCIEN" S:$L(DR) PQ=";" D PVDC
 . I $P($G(^PSNDF(50.68,PIEN,5)),"^")'=NFINDICATOR S DR=DR_PQ_"17///^S X=NFINDICATOR" S:$L(DR) PQ=";" D
 .. ; National Formulary Indicator
 .. S X=NAME,DIC=5000.5,DIC(0)="LMXZ" D ^DIC
 . I $P(PS7,"^",1)'=CSFSCHED S DR=DR_PQ_"19///^S X=CSFSCHED" S:$L(DR) PQ=";" D
 ..; Product With Schedule Change
 ..I CSFSCHED'=0 S X=NAME,DIC=5000.9,DIC(0)="LMXZ" D ^DIC
 . S:$P(PS7,"^",2)'=SMSPROG DR=DR_PQ_"20///^S X=SMSPROG" S:$L(DR) PQ=";"
 . I EDCK'=EDDINTER Q:EDCK=""&(EDDINTER=0)  S DR=DR_PQ_"23///"_$S(EDDINTER=1:"^S X=EDDINTER",1:"@") S:$L(DR) PQ=";" D EDCK
 . ;S OVCKX=$S(ODFDCHKX="YES":1,ODFDCHKX="NO":0,1:"")
 . I OVCK'=ODFDCHKX S DR=DR_PQ_"31///^S X=ODFDCHKX" S:$L(DR) PQ=";" D OVCK
 . ;S MVUIDX=$S(MVUID="YES":1,MVUID="NO":0,1:"")
 . S:$P(VUID0,"^",2)'=MVUID DR=DR_PQ_"99.98///^S X=MVUID" S:$L(DR) PQ=";"
 . S:$P(VUID0,"^",1)'=VUID DR=DR_PQ_"99.99///^S X=VUID" S:$L(DR) PQ=";"
 . S:$P(PS7,"^",3)'=IDATE DR=DR_PQ_"21///"_$S(IDATE]"":"^S X=IDATE",1:"@") S:$L(DR) PQ=";"
 . I FMG'=FDAMG S DR=DR_PQ_"100///"_$S(FDAMG]"":"^S X=FDAMG",1:"@") S:$L(DR) PQ=";" D FMG
 . S:$P(PSF0,"^",1)'=SCODE DR=DR_PQ_"2000///"_$S(SCODE]"":"^S X=SCODE",1:"@") S:$L(DR) PQ=";"
 . ;
 . ; Update Database
 . S DA=PSS("IEN"),DIE=50.68
 . D ^DIE
 . ;
 . ; Update Active Ingredients multiple
 . I +ACTID D UAI
 . ;
 . ; Check for NDFK changes
 . ; Inactivation Date
 . S UTIEN=$P(^PSNDF(50.68,DA,0),"^",5)
 . I IDATE]"",$P(PS7,"^",3)="" S X=NAME,DIC=5000.2,DIC(0)="LMXZ" D ^DIC D ^DIC S ^TMP("NDFK",DA,"0")=""
 . I GENIEN'=$P(PS0,"^",2) S X=NAME,DIC=5000.2,DIC(0)="LMXZ" D ^DIC S ^TMP("NDFK",DA,"1")=""
 . I DFIEN'=$P(PS0,"^",3) S X=NAME,DIC=5000.2,DIC(0)="LMXZ" D ^DIC S ^TMP("NDFK",DA,"2")=""
 . I UTIEN'=$P(PS0,"^",5) S X=NAME,DIC=5000.2,DIC(0)="LMXZ" D ^DIC S ^TMP("NDFK",DA,"3")=""
 . I VAPTN'=PRINTNAME S X=NAME,DIC=5000.2,DIC(0)="LMXZ" D ^DIC S ^TMP("NDFK",DA,"4")=""
 . I PRODID'=$P(PS1,"^",2) S X=NAME,DIC=5000.2,DIC(0)="LMXZ" D ^DIC S ^TMP("NDFK",DA,"5")=""
 . I DUNIEN'=$P(PS1,"^",4) S X=NAME,DIC=5000.2,DIC(0)="LMXZ" D ^DIC S ^TMP("NDFK",DA,"6")=""
 ;
 ;PVADCIEN
 ;
 S XMESS="<message> <![CDATA[ Updated VA Product "_NAME_" ]]> </message>"
 S XIEN="<ien>"_PSS("IEN")_"</ien>"
 K DIC,DA,DR,DIE,^TMP("AJF LAYGO",$J)
 Q
 ;
UAI ; Update Active Ingredients multiple
 ;
 ; Removing old Active Ingredients
 ;K ^PSNDF(50.68,DA,2)  
 ;
 N CNT,AIIEN,AISTRG,AINAME S CNT=0,PIEN=DA
 N DA
 F  S CNT=$O(^PSNDF(50.68,PIEN,2,CNT)) Q:CNT=""  D
 . S DIE="^PSNDF(50.68,"_PIEN_",2,",DA(1)=PIEN,DA=CNT
 . S DR=".01///@"
 . D ^DIE
 ;
 ; Adding new Active Ingredients
 ;
 F CNT=1:1:ACTID I $D(PSS("AIIEN"_CNT)) D
 . S DIC="^PSNDF(50.68,"_PIEN_",2,",DIC(0)="L",DIC("P")="50.6814P"
 . S AIIEN=$G(PSS("AIIEN"_CNT)) ;activeIngredientsIen
 . S AISTRG=$G(PSS("AISTRG"_CNT)) ;activeIngredientsStrength
 . S AINAME=$G(PSS("AIUNAME"_CNT)) ;activeIngredientsUnitsName
 . S DA(1)=PIEN,(DA,DINUM,X)=AIIEN
 . D FILE^DICN
 . S DIE=DIC,DR="1///^S X=AISTRG;2///^S X=AINAME"
 . D ^DIE
 Q
 ;
 ; Check for NDFK changes 
EDCK  ; Interaction Exclusion/Inclusion
 ;I EDCK'=EDDINTER D
 N DR
 S X=NAME,DIC=5000.23,DIC(0)="LMXZ" D ^DIC
 S DIE=DIC,DA=+Y K DIC
 S DR="1///"_$S(EDDINTER]"":"^S X=EDDINTER",1:"@")
 D ^DIE
 Q
PVDC ; Product Name With Change Code
 N DR
 S X=NAME,DIC=5000.507,DIC(0)="LMXZ" D ^DIC
 S DIE=DIC,DA=+Y K DIC
 S DR="2///^S X=PVDC;3///^S X=PVADCIEN"
 D ^DIE
 ; Class Changes
 S X=NAME,DIC=5000.8,DIC(0)="LMXZ" D ^DIC
 S DIE=DIC,DA=+Y K DIC
 S DR="1///^S X=PVDC;2///^S X=PVADCIEN;3///^S X=GENIEN"
 D ^DIE
 Q
 ;
OVCK ; Override Change
 ;S OVCK=$S(OVCK="YES":1,OVCK="NO":0,1:""
 ;I OVCK'=ODFDCHKX D
 N DR
 S X=NAME,DIC=5000.608,DIC(0)="LMXZ" D ^DIC
 S DIE=DIC,DA=+Y K DIC
 S DR="1///^S X=OVCK;2///^S X=ODFDCHKX"
 D ^DIE
 Q
 ;
FMG ; Med Guide Changes
 ;I FMG'=FDAMG D
 N DR,FAMG
 S (X,DINUM)=PSS("IEN"),DIC=5000.91,DIC(0)="LMXZ" D FILE^DICN
 S FAMG=$S(FMG="":"A",FDAMG]"":"E",1:"D")
 S DIE=DIC,DA=+Y K DIC
 S DR="1///^S X=FAMG"
 D ^DIE
 Q
 ;
UP(X)    Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
