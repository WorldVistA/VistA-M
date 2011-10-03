LBRVCOND ;SSI/ALA/JSR-Consolidate library files env check ;[ 06/27/2000  7:29 PM ]
 ;;2.5;Library;**8**;Mar 11, 2000
 ;
EN ; Checking for patch load requirements
 N QUIT
 I '$G(DUZ)!($G(DUZ(0))'["@") W !,"USER 'DUZ' VARIABLES **NOT** CORRECTLY DEFINED.  CONFIRM THAT DUZ(0)='@'.  THEN D ^XUP." S XPDQUIT=1 Q
 ;
 ;
 S LBRPT2=$$PATCH^XPDUTL("LBR*2.5*2")
 I LBRPT2'=1 D  S XPDQUIT=1 Q
 . W !!,"*** Patch LBR*2.5*2 must be installed prior to loading"
 . W !,"this patch.  This install will now abort.",!
 ;
 S LBRPT3=$$PATCH^XPDUTL("LBR*2.5*3")
 I LBRPT3'=1 D  S XPDQUIT=1 Q
 . W !!,"*** Patch LBR*2.5*3 must be installed prior to loading"
 . W !,"this patch.  This install will now abort.",!
 ;;
RX ; re-index file 680.6 for checks
 F LBRXREF="B","C" K ^LBRY(680.6,LBRXREF)
 S DIK="^LBRY(680.6," D IXALL^DIK
LEG ;Check for Legacy Station
 S LBRPRT=$P($G(^A7RLBRY("LBRV",0)),"^",3),LBRSYS=$P(LBRPRT,";",2)
 I LBRSYS="LEG" K LBRSYS,LBRPRT,LBRPT2,LBRXREF Q
 ;
PL ;
 S QUIT=0,XPDQUIT=1,DIRUT=1
 D MES^XPDUTL("")
 D MES^XPDUTL(" ** PLEASE IDENTIFY YOUR STATION TYPE **  ")
 S DIR(0)="SX^1:Primary;2:Legacy"
 S DIR("A")="SELECT SITE TYPE"
 S DIR("B")=""
 D ^DIR
 I $D(DIRUT) K DIR,X S QUIT=1,FLAG="YES" Q
 I Y=2 S LBRLEGP="LEGACY"
 I Y=1 S LBRLEGP="PRIMARY"
QUEST1 K FLAG
 D MES^XPDUTL("*** WARNING PLEASE VERIFY THE FOLLOWING ***")
 D MES^XPDUTL("Have all the entries in the Legacy's National Library Files (680.1,680.2, 680.8 and 680.9) been confirmed in the Primary's National Library Files? ")
 D MES^XPDUTL(" Enter 'Y'es to continue or 'N'o to stop the install.")
 D MES^XPDUTL("  ")
 S DIR(0)="Y",DIR("A")="Enter 'N' to quit, or 'Y' to continue: "
 S DIR("B")="NO" D ^DIR
 I Y=0!$D(DIRUT) K DIR,X,Y S QUIT=1,FLAG="YES" Q
QUEST2 K FLAG
 D MES^XPDUTL("*** WARNING - PLEASE VERIFY THE FOLLOWING ***")
 D MES^XPDUTL("Have your Service File (#49) and New Person File (#200) been consolidated?")
 D MES^XPDUTL(" Enter 'Y'es to continue or 'N'o to stop the install.")
 D MES^XPDUTL("  ")
 S DIR(0)="Y",DIR("A")="Enter 'N' to quit, or 'Y' to continue: "
 S DIR("B")="NO" D ^DIR
 I Y=0!$D(DIRUT) K DIR,X,Y S QUIT=1,FLAG="YES" Q
WRN ;  Warning on existence of Translated global
 I $D(^A7RLBRY) S QUIT=0 D  I QUIT S XPDQUIT=1,DIRUT=1 Q
 . W !!
 . D MES^XPDUTL("*** WARNING - A7RLBRY global exists! ***")
 . D MES^XPDUTL("If you are a LEGACY STATION this data should not exist in prepare data")
 . D BMES^XPDUTL("If you are a PRIMARY STATION this file must EXIST to proceed")
 . D MES^XPDUTL(" Enter 'Y'es to continue or 'N'o to stop the install.")
 . D MES^XPDUTL("  ")
 . S DIR(0)="Y",DIR("A")="Enter 'N' to quit, or 'Y' to continue: "
 . S DIR("B")="NO" D ^DIR
 . I Y=0!$D(DIRUT) K DIR,X,Y S QUIT=1,FLAG="YES" Q
 . I LBRLEGP="LEGACY" K DIR,X,Y S QUIT=1,FLAG="YES" D MES^XPDUTL("*** Legacy Station cannot proceed  ***") Q
CNF ;  Warning on existence of Translated global
 I '$D(^A7RLBRY) S QUIT=0 D  I QUIT S XPDQUIT=1,DIRUT=1 Q
 . D MES^XPDUTL("*** WARNING - A7RLBRY global does not exist! ***")
 . D MES^XPDUTL("If you are a LEGACY SITE this global CANNOT exist to proceed!")
 . D MES^XPDUTL("  ")
 . S DIR(0)="Y",DIR("A")="Enter 'N' to quit, or 'Y' to continue: "
 . S DIR("B")="NO" D ^DIR
 . I Y=0!$D(DIRUT) K DIR,X S QUIT=1,FLAG="YES" Q
 . I Y=1 S FLAG="",QUIT=1 Q
 . I LBRLEGP="PRIMARY" S FLAG="YES" D MES^XPDUTL("**WARNING**") G EXIT
 I QUIT=1 G EXIT
STA ;
 S LBRVSTA=0,CT=0
 F  S LBRVSTA=$O(^A7RLBRY(LBRVSTA)) Q:LBRVSTA=""  S CT=CT+1
 I CT>0 S $P(^A7RLBRY(0),"^",3)=CT
 I CT>1 D
 . D MES^XPDUTL("**WARNING** Temporary global contains multiple stations.")
 . D MES^XPDUTL("The integration may take a couple of hours.")
 K CT,LBRPT2,LBRVSTA
QUEST3 ;
 W !!
 S FLAG=""
 D MES^XPDUTL("*** WARNING PLEASE VERIFY ***")
 D MES^XPDUTL("    Below is a list of Sites which exist in the Primary System:")
 S LBRX=0
 F  S LBRX=$O(^LBRY(680.6,LBRX)) Q:'LBRX  D
 . S LBRDATA=^LBRY(680.6,LBRX,0)
 . S LBRAB=$P(LBRDATA,"^",7)
 . S LBRSTA=$P(LBRDATA,"^",1)
 . S LBRLST(LBRAB)=""
 . D MES^XPDUTL("ID Code:"_LBRAB_"  Site:"_LBRSTA)
 W !!
 D MES^XPDUTL("    Below is a list of Sites ready for integration")
 S LBRA7=0
 F  S LBRA7=$O(^A7RLBRY(LBRA7)) Q:LBRA7=""  D
 . D MES^XPDUTL("ID Code:"_LBRA7)
 . S:'$D(LBRLST(LBRA7)) LBRHLT=1
 . W !!
 D MES^XPDUTL("If no Division Site Name defined in Library Parameters File for integrating")
 D MES^XPDUTL("site then enter the corresponding SITE NAME to match the above 5 letter code.")
 W !!
 D MES^XPDUTL("PRESS ANY KEY WHEN READY TO CONTINUE")
 R DUMB:400
 I $G(LBRHLT) D MES^XPDUTL("SITE MISMATCH -- You must Define Site[s] PRIOR TO INTEGRATION.  This install is  now aborted.") S QUIT=1,FLAG="YES" Q
EXIT ;Kill local variables
 K LBRVSTA,LBRVNM,DIR,DIC,DIE,D,DA,D0,DR,X,Y
 I QUIT S DIRUT=1
 Q
