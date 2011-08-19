PSOVWI ;IHS/DSD/JCM - DISPLAY ENTRIES IN FILES IN A CAPTIONED FORMAT ; 07/20/92 14:38
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 ;
 ; This routine will display entries in certain files
 ; in a captioned format.  It calls EN^DIQ
 ;
 ; Input Variables: PSOVWI("DIC") The global root for DIC
 ; External Calls: ^DIC,EN^DIQ
 ;--------------------------------------------------------------
START ;
 K PSOVWI("DA'S")
 D SELECT ; Select Entries To View
 G:'$D(PSOVWI("DA'S")) END
 D DISP ; Display enties
 G START
END D EOJ ; Clean up variables
 Q
 ;---------------------------------------------------------------
SELECT ; Select Entries to View
 S DIC=PSOVWI("DIC")
 S DIC(0)="AEQM"
 D ^DIC K DIC,DR
 I Y>0 S PSOVWI("DA'S",+Y)="",DIC("A")="ANOTHER ONE: " G SELECT
 K:$D(DTOUT)!($D(DUOUT)) PSOVWI("DA'S")
 Q
DISP ; Calls EN^DIQ to display entries in captioned form
 ;
 F PSOVWI("DA")=0:0 S DIC=PSOVWI("DIC"),PSOVWI("DA")=$O(PSOVWI("DA'S",PSOVWI("DA"))) Q:'PSOVWI("DA")  S DA=PSOVWI("DA") D EN^DIQ K DIC,DR,DA
 Q
EOJ ; Clean up variables
 K PSOVWI,X,Y,DIC,DTOUT,DUOUT
 Q
