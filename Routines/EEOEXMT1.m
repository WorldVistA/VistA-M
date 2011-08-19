EEOEXMT1 ;HISC/JWR - PREPARES DATA FOR TRANSMITION ;01/17/94  14:00
 ;;2.0;EEO Complaint Tracking;**10**;AUG-20-96
TASK ;Entry point for transmission to Nat'l data base of formal complaints marked for transmission, and local timeliness reminder bulletins
 K ^TMP("EEOXMT") S DA=0
 F  S DA=$O(^EEO(785,DA)) Q:DA=""!(+DA'=DA)  I $P($G(^(DA,"XMT")),U)'="" D INFO
 D ^EEOEXMT2
 K ^XTMP("EEOX")
 I DT#2=0 S EFLG="P" D ^EEOETICK
 I DT#4=0 S EFLG="" D ^EEOETICK
 D ERAS Q
SINGLE ;Entry point for selecting individual complaints to be transmitted immediately
 S DIC="^EEO(785,",DIC(0)="AEMQZ",DIC("A")="Select Complainant to transmit:  ",DIC("S")="I $P($G(^EEO(785,+Y,12)),U,2)'=""D"" I $P($G(^EEO(785,+Y,1)),U,3)>0"
LOP ;Gathers complaints to be transmitted through the menu option and transmits
 D ^DIC S DA=$P(Y,U) Q:DA'>0  D INFO S DIC("A")="Another: ",EEONE(DA)="" D LOP
 D ^EEOEXMT2
 I $O(EEONE(""))>0 F  S DA=$O(EEONE(DA)) Q:DA'>0  D
 .S DIE=785,DR="62///@" D ^DIE
 K EEONE Q
INFO ;Gathers the data from the global for the complaints to be retransmitted
 F NO=0:1:4,5,6,12 S LABEL="ANODE",EEOS="EEON"_NO,@EEOS=$G(^EEO(785,DA,NO)) D
 .I $D(^XTMP("EEOX",DA,NO)) D DELETE
 .Q:@EEOS=""
 .D:NO=0!(NO=5)!(NO=3)!(NO=1) @("EEO"_NO) D SAVE
 S LABEL="CORR",NEE="C",NOD=8,PFILE=785.2 D MULT
 S LABEL="BASIS",NEE="B",NOD=9,PFILE=785.1 D MULT
 S LABEL="ISSUE",NEE="I",NOD=10,PFILE=786 D MULT
 S LABEL="INVEST",NEE="IN",NOD=11,PFILE=787.5 D MULT
 Q
MULT ;HANDLES MULTIPLES FOR BASIS, ISSUES, AND CORRECTIVE ACTION
 D DELTA
 Q:$O(^EEO(785,DA,NOD,""))=""  K CNT D
 .S CNT=0 F  S CNT=$O(^EEO(785,DA,NOD,CNT)) Q:CNT=""!(+CNT'=CNT)  S EEO(NOD,CNT)=$G(^(CNT,0)),$P(EEO(NOD,CNT),U)=$S($D(^EEO(PFILE,$P(EEO(NOD,CNT),U),0)):$P(^(0),U),1:"") D DELTA,SAVEM
 Q
SAVEM ;Saves multiples data to transmission file (^TMP)
 I NEE="IN",CNT>0 S:$P($G(EEO(NOD,CNT)),U,6)'="" $P(EEO(NOD,CNT),U,6)=$S($D(^EEO(PFILE,$P(EEO(NOD,CNT),U,6),0)):$P(^(0),U),1:"")
 I $G(EEO(NOD,CNT))'="" S ^TMP("EEOXMT",$J,785,DA,LABEL,NOD,CNT)=EEO(NOD,CNT)
 Q
EEO0 ;Puts ^EEO(785,DA,0) node information into proper format
 ;S:$P(EEON0,U,3)'=""&($P(EEON0,U,3)'="@") $P(EEON0,U,3)=$P($G(^DIC(4,$P(EEON0,U,3),0)),U)
 S:$P(EEON0,U,4)'=""&($P(EEON0,U,4)'="@") $P(EEON0,U,4)=$P($G(^ECC(730,$P(EEON0,U,4),0)),U)
 S:$P(EEON0,U,6)'=""&($P(EEON0,U,6)'="@") $P(EEON0,U,6)=$P($G(^DIC(5,$P(EEON0,U,6),0)),U)
 S:$P(EEON0,U,11)'=""&($P(EEON0,U,11)'="@") $P(EEON0,U,11)=$P($G(^DIC(5,$P(EEON0,U,11),0)),U)
 Q
EEO5 ;Puts ^EEO(785,DA,5) node information into proper format
 S:$P(EEON5,U,4)'=""&($P(EEON5,U,4)'="@") $P(EEON5,U,4)=$P($G(^DIC(5,$P(EEON5,U,4),0)),U)
 Q
EEO1 ;Puts ^EEO(785,DA,1) node information into proper format
 I +EEON1>0 I $D(^VA(200,+EEON1)) S $P(EEON1,U)=$P(^(+EEON1,0),U)
 Q
SAVE ;Saves non-multiple information into global for transmission
 S ^TMP("EEOXMT",$J,785,DA,LABEL,NO,"N")=@("EEON"_NO)
 Q
DELETE ;Gathers delete information from ^XTMP("EEOX", global for transmit record
 F PIECE=1:1 Q:$P(^XTMP("EEOX",DA,NO),U,PIECE,PIECE+100)=""  I $P(^(NO),U,PIECE)'="" S:$P(@EEOS,U,PIECE)="" $P(@("EEON"_NO),U,PIECE)="@"
 K ^XTMP("EEOX",DA,NO)
 Q
ERAS ;Gets rid of transmission flag
 S DA=0 F  S DA=$O(^EEO(785,DA)) Q:DA=""!(+DA'=DA)  I $P($G(^(DA,"XMT")),U)'="" S DIE=785,DR="62///@" D ^DIE
 Q
EEO3 ;Eliminates old unused investigator fields from the string for transmission
 F PIECE=1,2,4,5,7:1:16 S $P(EEON3,U,PIECE)=""
 Q
DELTA ;Multiple field deletes loaded into transmit file
 N CNT  S CNT=""
 I $D(^XTMP("EEOX",DA,NOD)) F  S CNT=$O(^XTMP("EEOX",DA,NOD,CNT)) Q:CNT=""  D
 .F BEE=1:1 Q:$P(^XTMP("EEOX",DA,NOD,CNT),U,BEE,99)=""  I $E($P(^(CNT),U,BEE),1)="@" D
 ..S $P(EEO(NOD,CNT),U,BEE)=$P(^XTMP("EEOX",DA,NOD,CNT),U,BEE)
 .D SAVEM
