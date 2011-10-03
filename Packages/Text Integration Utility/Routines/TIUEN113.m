TIUEN113 ; SLC/JAK - Environment Check for TIU*1*113 ;28-AUG-2001 08:43
 ;;1.0;TEXT INTEGRATION UTILITIES;**113**;Jun 20, 1997
MAIN ; -- Control Unit
 ; Check all Hospital Location entries for division and all
 ; Medical Center Division entries for institution file pointer;
 ; if not all data present, quit
 ;
 N CHKOK,TIULOC S CHKOK=1,TIULOC=0
 W !!,"Checking DIVISION for all Hospital Location file (#44)"
 W !,"entries <AND> INSTITUTION FILE POINTER for all Medical"
 W !,"Center Division file (#40.8) entries..."
 W !!
 ;
 F  S TIULOC=$O(^SC(TIULOC)) Q:'TIULOC!('CHKOK)  D
 . N TIUDVHL
 . S TIUDVHL=+$P($G(^SC(TIULOC,0)),U,15) I 'TIUDVHL S CHKOK=0 Q
 I CHKOK=1 D
 . N TIUDIV,TIUIFP S TIUDIV=0
 . F  S TIUDIV=$O(^DG(40.8,TIUDIV)) Q:'TIUDIV!('CHKOK)  D
 . . S TIUIFP=+$G(^DG(40.8,"ADV",TIUDIV)) I 'TIUIFP S CHKOK=0 Q
 ;
 I 'CHKOK D
 . S XPDQUIT=1 ; kill transport global from ^XTMP
 . W !,"Sorry...DIVISION cannot be determined for all Hospital"
 . W !,"Location file (#44) entries <AND/OR> INSTITUTION FILE"
 . W !,"POINTER cannot be determined for all Medical Center"
 . W !,"Division file (#40.8) entries. Please review and correct"
 . W !,"both files as necessary."
 . W !!,"** ABORTING INSTALLATION **"
 E  D
 . W !,"** Files are OK **"
 Q
