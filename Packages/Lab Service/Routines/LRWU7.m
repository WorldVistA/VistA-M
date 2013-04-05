LRWU7 ;DALOI/JMC - ADD A NEW ANTIBIOTIC TO FILE 63 ;04/02/09  09:59
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; Reference to ^DD supported by ICR #29/999
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
ACCESS ;
 N LRX
 D OWNSKEY^XUSRB(.LRX,"LRLIASON",DUZ)
 I LRX(0)'=1 D  Q
 . D EN^DDIOL("You do not have proper access for using this option.","","!?2")
 ;
BEGIN ;
 ;
 ;ZEXCEPT: DTIME - Kernel variable which can be set by applications via API
 ;
 N %,I,DA,DIC,DIK,DIR,DIROUT,DIRUT,DTOUT,LR4,LRINC,LRNAME,LRNAME1,LRNAME2,LRNUM,LRNUM1,LRNUM2,LROK,LRSITE,LRSUBFIL,LRTYPE,LRY,X,Y
 S U="^",DTIME=$$DTIME^XUP(DUZ),DT=$$DT^XLFDT,LROK=1
 S LR4=$$KSP^XUPARAM("INST")
 S LRSITE=$$STA^XUAF4(LR4)
 I 'LRSITE D  Q
 . N A
 . S A(1)="Your site number is not defined, indicating that FileMan was not",A(1,"F")="!"
 . S A(2)="installed correctly.  Contact your site manager!",A(2,"F")="!"
 . D EN^DDIOL(.A)
 ;
 S DIR(0)="S^1:Bacterial Antibiotic;2:Mycobacterium Antibiotic"
 S DIR("A")="Select Antibiotic Type to Add",DIR("B")=1
 D ^DIR
 I $D(DIRUT) D END Q
 S LRTYPE=Y,LRSUBFIL=$S(LRTYPE=1:63.3,LRTYPE=2:63.39,1:"")
 ;
 D NAME
 I 'LROK D END Q
 D NUMBER,SETUP,END
 Q
 ;
 ;
END ; Cleanup before quiting
 ;
 ;ZEXCEPT: %,DA,DIC,DIK,I,LRINC,LRNAME,LRNAME1,LRNAME2,LRNUM,LRNUM1,LRNUM2,LROK,LRSITE,X
 ;
 K %,I,DA,DIC,DIK,LRINC,LRNAME,LRNAME1,LRNAME2,LRNUM,LRNUM1,LRNUM2,LROK,LRSITE,X
 Q
 ;
 ;
NAME ; Prompt user for the name of the new antibiotic to be added.
 ;
 ;ZEXCEPT: LRNAME,LRNAME1,LRNAME2,LROK - used by calling process
 ;
 N DA,DIR,DIROUT,DIRUT,DTOUT,Y
 S DIR(0)="FO^3:20^D CHECK^LRWU7"
 S DIR("A")="Enter the name of the new antibiotic you wish to create"
 D ^DIR
 I $D(DIRUT) S LROK=0 Q
 S LROK=1,LRNAME=Y,LRNAME1=LRNAME_" INTERP",LRNAME2=LRNAME_" SCREEN"
 Q
 ;
 ;
CHECK ; Check if field already exists for the same name.
 ;
 ;ZEXCEPT: LROK,LRSUBFIL,X - set by calling process
 ;
 D EN^DDIOL("Checking if field exists...","","!!")
 S X=$$UP^XLFSTR(X)
 I '$$FLDNUM^DILFD(LRSUBFIL,X) D EN^DDIOL("OK","","?1") Q
 D EN^DDIOL($C(7)_X_" already exists!","","?1")
 S LROK=0 K X
 Q
 ;
 ;
NUMBER ; Determine the next field number by checking existing fields.
 ;
 ;ZEXCEPT: LRINC,LRNUM,LRNUM1,LRNUM2,LRSITE,LRSUBFIL - set by calling process
 ;
 N LROK
 S LRNUM="2.00"_LRSITE,LRINC=$S($L(LRSITE)=3:.00000001,1:.000000001),LRNUM=LRNUM+LRINC,LROK=0
 ;
 F  D  Q:LROK
 . I '$$VFIELD^DILFD(LRSUBFIL,LRNUM),'$D(^DD(LRSUBFIL,"GL",LRNUM)) S LROK=1 Q
 . S LRNUM=LRNUM+LRINC
 ;
 S LRNUM1=+$S($L(LRSITE)=3:LRNUM+.000000001,1:LRNUM+.0000000001)
 S LRNUM2=+$S($L(LRSITE)=3:LRNUM+.000000002,1:LRNUM+.0000000002)
 S LRNUM=+LRNUM
 Q
 ;
 ;
SETUP ; Confirm creation of new antibiotic and setup corresponding fields in DD
 ;
 ;ZEXCEPT: LR6206,LRNAME,LRNUM,LRTYPE - set by calling process
 ;
 N A,DA,DIR,DIROUT,DIRUT,DTOUT,X,Y
 S DIR(0)="YO"
 S DIR("A")="Are you sure you wish to create "_LRNAME
 S DIR("A",1)=" (DRUG NODE will be "_LRNUM_")"
 S DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) Q
 I Y<1 Q
 ;
 ; Create new field(s) in file #63 Data Dictionary
 D SETFLDS
 ;
 ; Ask if user wants to setupcorresponding entry in file #62.06
 S A(1)=LRNAME_" has now been created.",A(1,"F")="!!"
 S A(2)="You must now add a new antibiotic in the ANTIMICROBIAL SUSCEPTIBILITY file",A(2,"F")="!"
 S A(3)="and use "_LRNAME_" as the entry for the "_$S(LRTYPE=1:"",LRTYPE=2:"AFB ",1:"")_"INTERNAL NAME field.",A(3,"F")="!"
 D EN^DDIOL(.A)
 ;
 ;
 K DIR,DIROUT,DIRUT,DTOUT,X,Y
 S DIR(0)="YO"
 S DIR("A")="Do you want to setup "_LRNAME_" as a new "_$S(LRTYPE=1:"Bacterial",LRTYPE=2:"Mycobacterium",1:"")_" Antibiotic"
 S DIR("A",1)=" "
 S DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) Q
 I Y<1 Q
 ;
 N FDA,LRDIE,LRIEN
 S FDA(1,62.06,"+1,",.01)=LRNAME
 D UPDATE^DIE("","FDA(1)","LRIEN","LRDIE(1)")
 S LR6206=LRIEN(1)
 I $D(LRDIE) D  Q
 . D EN^DDIOL("Encountered an error adding new antibiotic","","!?2")
 D DIE
 Q
 ;
 ;
SETFLDS ; Create the fields in the DD for bacterial and mycobacteria
 ;  LRSUBFIL = sub file # within MI subscript
 ;     LRNUM = field number of antibiotic field
 ;    LRNUM1 = field number of bacterial interpretation field
 ;    LRNUM2 = field number of bacterial screen field
 ;    LRNAME = field name for field LRNUM
 ;   LRNAME1 = field name for field LRNUM1
 ;   LRNAME2 = field name for field LRNUM2
 ;    LRTYPE = 1 (BACTERIAL) / 2 (MYCOBACTERIUM)
 ;
 ;
 ;ZEXCEPT: LRNAME,LRNAME1,LRNAME2,LRNUM,LRNUM1,LRNUM2,LRSUBFIL,LRTYPE - set by calling process
 ;
 N DA,DIK
 ; Setup antibiotic - bacterial and AFB.
 S ^DD(LRSUBFIL,LRNUM,0)=LRNAME_"^FX^^"_LRNUM_";1^"_$S(LRTYPE=1:"D ^LRMISR",LRTYPE=2:"D COM^LRMISR",1:"")
 S ^DD(LRSUBFIL,LRNUM,3)=""
 S ^DD(LRSUBFIL,LRNUM,4)=$S(LRTYPE=1:"D EN^LRMISR",LRTYPE=2:"D ZQ^LRMISR",1:"")
 S ^DD(LRSUBFIL,LRNUM,"DT")=DT
 ;
 ; Setup two additional fields used for bacterial antibiotics
 I LRTYPE=1 D
 . S ^DD(LRSUBFIL,LRNUM1,0)=LRNAME1_"^FX^^"_LRNUM_";2^D INT^LRMISR",^(3)="",^(4)="D HINT^LRMISR",^("DT")=DT
 . S ^DD(LRSUBFIL,LRNUM2,0)=LRNAME2_"^S^A:ALWAYS DISPLAY;N:NEVER DISPLAY;R:RESTRICT DISPLAY;^"_LRNUM_";3^Q",^("DT")=DT
 ;
 S $P(^DD(LRSUBFIL),U,4)=$P(^DD(LRSUBFIL,0),U,4)+3
 ;
 ; Call FileMan to reindex the new fields.
 S DIK="^DD(LRSUBFIL,",DA=LRNUM,DA(1)=LRSUBFIL
 D IX1^DIK
 I LRTYPE=1 F DA=LRNUM1,LRNUM2 D IX1^DIK
 Q
 ;
 ;
DIE ; Edit file #62.06
 ; LRTYPE = 1-BACTERIAL, 2-MYCOBACTERIUM
 ; LR6206 = ien of entry to edit
 ;  LRNUM = drug node
 ;
 ;ZEXCEPT: LR6206,LRNUM,LRTYPE - set by calling process
 ;
 N DA,DIE,DR
 ;
 S DA=LR6206,DIE="^LAB(62.06,"
 I LRTYPE=1 S DR=".01;5//"_LRNUM_";4;6;7;.5;2;64",DR(2,62.061)=".01;1"
 I LRTYPE=2 S DR=".01;5.1//"_LRNUM_";64"
 D ^DIE
 ;
 Q
 ;
 ;
EDIT ; Edit an existing entry in file #62.06
 N DIC,DIR,DIROUT,DIRUT,DTOUT,LR6206,LRNUM,LRTYPE,X,Y
 ;
 S DIR(0)="S^1:Bacterial Antibiotic;2:Mycobacterium Antibiotic"
 S DIR("A")="Select Antibiotic Type to Edit",DIR("B")=1
 D ^DIR
 I $D(DIRUT) Q
 S LRTYPE=Y
 S DIC="^LAB(62.06,",DIC(0)="AELMOQZ",DIC("S")="I $P(^(0),U,$S(LRTYPE=1:8,1:4))="""""
 D ^DIC
 I Y<1 Q
 ;
 S LR6206=+Y,LRNUM=$P(Y(0),"^",$S(LRTYPE=1:4,1:8)) D DIE
 ;
 Q
