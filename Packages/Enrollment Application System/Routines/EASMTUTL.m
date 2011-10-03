EASMTUTL ; ALB/SCK/BRM/PHH - AUTOMATED MEANS TEST LETTERS UTILITIES ; 7/2/01
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**3,14,15,29,22,54**;MAR 15,2001
 ;
 ;
PAUSE ;  Screen pause, user must press key to continue
 S DIR(0)="FAO",DIR("A")="Press any key to continue..."
 D ^DIR K DIR
 Q
 ;
CLRFLG(EAX,DA) ; Clears flags in File #713.2, For development
 N DIE,DR
 ;
 Q:EAX=1
 S:EAX=2 DR="9///0"
 S:EAX=3 DR="9///0;12///0"
 S:EAX=4 DR="9///0;12///0"
 S:EAX=0 DR="9///0;12///0;18///0"
 S DIE="^EAS(713.2,"
 D ^DIE K DIE
 Q
 ;
LOCK(ACTION) ; Flag IN USE field in EAS Parameters file, #713
 ; Input
 ;   ACTION - Locking action
 ;            1 = Flag IN USE for Automated Generator is running
 ;            0 = Flag IN USE for Automated Generator is not running
 ; Output
 ;        1 if action was successful
 ;        0 if action was not successful
 N RSLT
 ;
 I ACTION,$D(^EAS(713,"ALOCK",1)) Q $G(RSLT)
 ;
 S DIE="^EAS(713,",DA=1,DR="30////^S X=ACTION"
 D ^DIE K DIE
 S RSLT=1
 Q +$G(RSLT)
 ;
ALERT(ERRMSG) ; Post an alert message to the EAS Letters Mail group
 N XMY,XMTEXT,XMDUZ,XMSUB,MSG
 ;
 S MSG(1)="Notification:"
 S MSG(2)=ERRMSG
 ;
 S XMY("G.EAS MTLETTERS")=""
 S XMTEXT="MSG("
 S XMDUZ="EAS Auto MT Letters"
 S XMSUB="EAS Means Test Letter's Notice"
 D ^XMD
 Q
 ;
ADRERR(EASADD,DFN) ; Error notification for missing or invalid patient address
 N MSG,XMY,XMTEXT,XMDUZ,XMSUB,VAROOT,EASDEM,VA,EASPRF
 ;
 S VAROOT="EASDEM"
 D DEM^VADPT
 D PID^VADPT6
 S EASPRF=$$GET1^DIQ(2,DFN,27.02)
 I EASPRF']"" S EASPRF="No Preferred Facility"
 ;
 S MSG(1)="The following patient does not have a complete permanent mailing"
 S MSG(2)="address.  A means test reminder letter could not be mailed."
 S MSG(3)=" "
 S MSG(4)="       Patient : "_EASDEM(1)
 S MSG(5)="        Last 4 : "_VA("BID")
 S MSG(6)="Address Line 1 : "_EASADD(1)
 S MSG(7)="          City : "_EASADD(4)
 S MSG(8)="         State : "_$P(EASADD(5),U,2)
 S MSG(9)="       Zipcode : "_$P(EASADD(11),U,2)
 S MSG(9.5)="      Bad Addr : "_$P(EASADD("BAI"),U,2)
 S MSG(10)=""
 S MSG(11)="           DFN : "_$G(DFN)
 S MSG(13)=""
 S MSG(14)="This patient's letter entry will stay in 'FLAGGED-TO-PRINT' status until"
 S MSG(15)="the address is corrected."
 ;
 I +EASADD(9)>0!(+EASADD(10)>0) D
 . S MSG(5.5)="** Temporary Address in effect **"
 S XMY("G.EAS MTLETTERS")=""
 S XMTEXT="MSG("
 S XMDUZ="EAS Auto MT Letters"
 S XMSUB="Incomplete/Bad Addr: "_EASPRF
 D ^XMD
 Q
 ;
CLRLCK ;  Clears IN USE field of the EAS MT PARAMETERS if an error occurs and locks the field
 N DIE,DR,DA
 ;
 S DA=1,DIE="^EAS(713,",DR="30///0"
 D ^DIE
 Q
 ;
PROHBIT ; Set or delete the Prohibit fields in the Patient Status file, #713.1
 N DIR,DIRUT,EASF,Y,X,EASIEN,DFN,DGFDA,FDAIEN,ERRMSG
 ;
 S DIR(0)="S^S:Set Prohibit Flag;R:Remove Prohibit Flag"
 S DIR("A")="Set or remove the MT Prohibit flag"
 S DIR("?")="Select 'S' to set flag, 'R' to remove the flag"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S EASF=Y
 ;
 I EASF="R"!(EASF="r") D  Q:$D(DIRUT) 
 . S DIR(0)="PAO^713.1:EMZ"
 . S DIR("A")="Select Patient: "
 . D ^DIR K DIR
 . S EASIEN=+Y
 ;
 I EASF="S"!(EASF="s") D  Q:$D(DIRUT)
 . S DIR(0)="PAO^2:EMZ"
 . S DIR("A")="Select Patient: "
 . D ^DIR K DIR
 . Q:$D(DIRUT)
 . S DFN=+Y
 . I '$D(^EAS(713.1,"B",DFN)) D  Q:$D(DIRUT)
 . . S DIR(0)="Y",DIR("B")="YES"
 . . S DIR("A")="Add patient to the Patient Status File"
 . . D ^DIR K DIR
 . . Q:$D(DIRUT)
 . . I 'Y S DIRUT=1 Q
 . . S DGFDA(1,713.1,"+1,",.01)=DFN
 . . D UPDATE^DIE("","DGFDA(1)","FDAIEN","ERRMSG")
 . . S EASIEN=FDAIEN(1)
 . I $D(^EAS(713.1,"B",DFN)) S EASIEN=$O(^EAS(713.1,"B",DFN,0))
 ;
 Q:'$G(EASIEN)
 ;
 N DGFDA,DGIEN,DGEFF,DIR,DIRUT,DGERR,DIE
 ;
 S DGIEN=EASIEN_","
 I EASF="S" D
 . S DIR(0)="DAO^"_$$DT^XLFDT_"::EX"
 . S DIR("A")="Effective Date: "
 . D ^DIR K DIR
 . Q:$G(DIRUT)
 . S DGFDA(1,713.1,DGIEN,3)=Y
 . S DGFDA(1,713.1,DGIEN,2)=1
 . S DGFDA(1,713.1,DGIEN,5)=$$NOW^XLFDT
 . S DGFDA(1,713.1,DGIEN,4)=DUZ
 . D:$D(DGFDA) FILE^DIE("","DGFDA(1)","DGERR")
 . I $D(DGERR) D  Q
 . . D DSPLYER(.DGERR)
 . S DIE="^EAS(713.1,",DA=EASIEN,DR="10"
 . D ^DIE K DIE
 ;
 I EASF="R" D
 . S DGFDA(1,713.1,DGIEN,2)=0
 . S DGFDA(1,713.1,DGIEN,3)="@"
 . S DGFDA(1,713.1,DGIEN,5)="@"
 . S DGFDA(1,713.1,DGIEN,4)="@"
 . S DGFDA(1,713.1,DGIEN,10)="@"
 . D:$D(DGFDA) FILE^DIE("","DGFDA(1)","DGERR")
 . I $D(DGERR) D
 . . D DSPLYER(.DGERR)
 . E  W !!?3,"Prohibit Flag Removed from Patient.",!
 ;
 Q
 ;
DSPLYER(ERRARY) ;
 N DGER
 ;
 W !!?3,"The following error(s) occurred:"
 S DGER=0
 F  S DGER=$O(ERRARY("DIERR",DGER)) Q:'DGER  D
 . W !?3,ERRARY("DIERR",DGER)," - ",ERRARY("DIERR",DGER,"TEXT",1)
 W !?3,"Please check, this record update may not have processed completely."
 Q
 ;
EDTLTRS ;
 N DIR,EASIEN
 ;
 S DIR(0)="P^713.3:EMZ"
 S DIR("A")="Select Letter"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S EASIEN=+Y
 ;
 S DIE="^EAS(713.3,",DA=EASIEN,DR="4"
 D ^DIE
 Q
 ;
MTRTN ; Update the letter status file, #713.2, with returned Means Test information
 N DIE,DIC,EASIEN,DR,DA,Y
 ;
 S DIC="^EAS(713.2,",DIC(0)="AEQM",DIC("A")="Select the Letter Status entry to update: "
 D ^DIC K DIC
 Q:Y<0
 S EASIEN=+Y
 ;
 S DIE="^EAS(713.2,",DA=EASIEN
 S DR="4;I X=0 S Y=0;5;7;6////^S X=DUZ;9///0;12///0;18///0"
 L +^EAS(713.2,EASIEN):0 I $T D 
 . D ^DIE K DIE
 E  W !,$CHAR(7),"Entry is being edited by another user."
 L -^EAS(713.2,EASIEN)
 ;
 Q
 ;
DECEASED(EASIEN,DFN) ;  Check deceased status for patient
 N RSLT,EADEM,EAS1,VAROOT
 ;
 S EASIEN=$G(EASIEN)
 S DFN=$G(DFN)
 I EASIEN>0 D
 . S EAS1=$$GET1^DIQ(713.2,EASIEN,2,"I")
 . S DFN=$$GET1^DIQ(713.1,EAS1,.01,"I")
 Q:'DFN 0
 S RSLT=0
 ;
 S VAROOT="EADEM"
 D DEM^VADPT
 S:+EADEM(6) RSLT=1
 D KVA^VADPT
 Q RSLT
 ;
CHECKMT(EASPT,EAIEN) ; Check current MT status
 N DFN,RTN,EACHK,DIE,DR,DA
 ;
 S RTN=0
 I '$G(EASPT) S RTN=1 G CHKQ ; Safety check
 S DFN=$$GET1^DIQ(713.1,EASPT,.01,"I") ; Get DFN
 I '$G(DFN) S RTN=1 G CHKQ ; Safety check
 ;
 S EACHK=$$MTCHK^EASMTCHK(DFN,"L") ; Check current MT to see if it's changed
 I 'EACHK D  ; If MT no longer required, update letter status file
 . S DIE="^EAS(713.2,",DA=EAIEN
 . S DR="4///YES;5///TODAY;7///AUTO-GENERATED;9///NO;12///NO;18///NO"
 . D ^DIE K DIE ;; Remove before release
 . S RTN=1
 ;
CHKQ Q RTN
 ;
FUTMT(EASIEN) ; Check for a future MT
 ;  Input
 ;    EASIEN - IEN for record in Letter Status file
 ;
 ;  Output
 ;     1 - Future MT exist's (API call)
 ;     0 - Future MT does not exist
 ;
 N EASPTR,DFN,EASFUT
 ;
 S RTN=0
 S EASPTR=$$GET1^DIQ(713.2,EASIEN,2,"I")
 S DFN=$$GET1^DIQ(713.1,EASPTR,.01,"I")
 ;
 ;; Call API for future MT check
 S EASFUT=$$FUT^DGMTU(DFN)
 ;
 I +$G(EASFUT) D  ; Turn off letters if future MT present
 . Q:'EASIEN
 . S DIE="^EAS(713.2,",DA=EASIEN
 . S DR="4///YES;5///TODAY;7///FUTURE MEANS TEST;9///NO;12///NO;18///NO"
 . D ^DIE K DIE
 . S RTN=1
 Q RTN
 ;
TESTLTR ;
 N EASIEN,EATYP,DIR,DIRUT,ZTSAVE
 ;
 S DIR(0)="SO^1:60-Day;2:30-Day;4:0-Day"
 S DIR("A")="Select letter type to test"
 S DIR("?")="Select the type of letter to print a test output of"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S EATYP=+Y
 S EASIEN=-1
 S ZTSAVE("EASIEN")="",ZTSAVE("EATYP")=""
 D EN^XUTMDEVQ("ZTEST^EASMTUTL","EAS MT TEST LETTER",.ZTSAVE)
 Q
 ;
TESTIT ;
 D LETTER^EASMTL6A(EASIEN,EATYP)
 Q
 ;
ZTEST ;
 D LETTER^EASMTL6A(EASIEN,EATYP)
 Q
ADDLEAP(DATE) ; Adding a year with Leap Year checking
 ; Input:
 ;       DATE   -  Date passed in.
 ;
 ; Output:
 ;       Date passed in plus one year (with leap year ck/adj).
 ;
 N YEAR
 S YEAR=$E($$FMTHL7^XLFDT(DATE),1,4)
 I $E(DATE,4,7)="0229",'$$LEAP^XLFDT3(YEAR+1) D
 .S DATE=$$FMADD^XLFDT(DATE,-1)
 Q $E(DATE,1,3)+1_$E(DATE,4,7)
 ;
SUBLEAP(DATE) ; Subtracting a year with Leap Year checking
 ; Input:
 ;       DATE   -  Date passed in.
 ;
 ; Output:
 ;       Date passed in minus one year (with leap year ck/adj).
 ;
 N YEAR
 S YEAR=$E($$FMTHL7^XLFDT(DATE),1,4)
 I $E(DATE,4,7)="0229",'$$LEAP^XLFDT3(YEAR-1) D
 .S DATE=$$FMADD^XLFDT(DATE,-1)
 Q $E(DATE,1,3)-1_$E(DATE,4,7)
