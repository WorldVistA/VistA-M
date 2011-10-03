LA7VSET ;DALOI/JMC - MENU TO SETUP VISN LABS ; 12/3/1997
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,51,55,46,64**;Sep 27, 1994
 ;
 ; Reference to HL LOGICAL LINK file (#870) supported by DBIA #1495, 1496, 2063
 ; Reference to PROTOCOL file (#101) supported by DBIA #872
 ; Reference to MAIL GROUP file (#3.8) supported by DBIA #2061
 ;
 D CONV
 ;
 N LA76248,LA7629,LA7VNVC,PRIMARY,PRSITE,HDR,LAB,HOST,REMOTE,LRY,LRX,LA7VS,NAME
 ;
 S LA7VS=$$PRIM^VASITE(DT)
 I $G(LA7VS)'="" D
 . S LA7VS=$$SITE^VASITE(DT,LA7VS)
 . S PRIMARY=$P(LA7VS,U,3),PRSITE=$P(LA7VS,U,2)
 ;
 I $G(PRIMARY)="" W !!,"No Primary Site is defined!!!!",!! R !,"Press RETURN to continue: ",X:DTIME Q
 ;
 S HDR="LEDI Setup"
 S HDR(1)="Add/Edit HOST Lab",HDR(2)="Add/Edit COLLECTION Lab"
 F  S LAB=$$MAIN Q:LAB=""  D @LAB
 ;
 K DIE,DA,DR,DO,DIC
 ;
 Q
 ;
MAIN() ; Display the main LEDI setup screen
 N HDRCNT,HDRA
 W @IOF,! F X=1:1:79 W "-"
 W !,?((80-$L(HDR))/2),HDR
 W ! F X=1:1:79 W "-"
 W !
 W !,"COLLECTION Labs:  Use option #1 to setup HOST labs."
 W !,"  HOST Labs    :  Use option #2 to setup COLLECTION labs."
 W !!
 S HDRCNT=0
 F  S HDRCNT=$O(HDR(HDRCNT)) Q:'HDRCNT  W !,HDRCNT,".",?5,HDR(HDRCNT)
 D KDIR
 W !!
 S DIR(0)="NO^1:2"
 D MHLP,^DIR
 S HDRA=$S(Y=1:"HOST",Y=2:"REMOTE",1:"")
 D KDIR
 Q HDRA
 ;
 ;
KDIR ; kill all DIR variables
 K DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 Q
 ;
 ;
HOST ; HOST Lab Setup Menu
 ;
 N LA7CNT,LA7,LA7P,SNUM,SNAME,HOST,LA7A
 ;
 F  D  Q:'LA7A
 . D HOSTBLD,HSTHDR,HOSTLST,KDIR
 . W !! S DIR(0)="NO^1:"_LA7CNT
 . D H1HLP,^DIR
 . I $D(DIRUT) S LA7A=0 Q
 . S LA7A=Y D AEHOST
 K SNAME
 Q
 ;
 ;
HOSTBLD ; Build list of host facilities.
 ; Identify all HOST labs using LA7 MESSAGE PARAMETER file (#62.48)
 ;
 N LA7,LA74,LA76248,LA7629,SNAME,SNUM
 ;
 K HOST
 S LA7CNT=1,(LA7,LA7P)="LA7V HOST "
 F  S LA7=$O(^LAHM(62.48,"B",LA7)) Q:LA7=""!(LA7'[LA7P)  D
 . S SNUM=$P(LA7,"HOST ",2)
 . S LA74=$$FINDSITE^LA7VHLU2(SNUM,1,1) Q:LA74'>0
 . S SNAME=$P($$NS^XUAF4(LA74),"^")
 . S HOST(LA7CNT)=SNUM_U_SNAME_U_LA7_U_LA74,LA7CNT=LA7CNT+1
 S HOST(LA7CNT)=""
 ;
 Q
 ;
 ;
HSTHDR ; HOST setup header
 S HOST="HOST Lab(s)"
 W @IOF,! F X=1:1:79 W "-"
 W !,?((80-$L(HOST))/2),HOST
 W ! F X=1:1:79 W "-"
 W !!
 Q
 ;
 ;
HOSTLST ;
 S LA7CNT=1,LA7=0
 F  S LA7=$O(HOST(LA7)) Q:'LA7  I HOST(LA7)'="" W !,LA7,".",?5,$P(HOST(LA7),U,2)_"  ("_$P(HOST(LA7),U,3)_")" S LA7CNT=LA7CNT+1
 W !,LA7CNT,".",?5,"Add HOST Lab"
 Q
 ;
AEHOST ;
 N CHA,UI
 F  S HOST="HOST Lab Setup" D HSTHDR,HSTHDR2,KDIR W !! S DIR(0)="NO^1:"_LA7CNT D H2HLP D ^DIR S CHA=Y D:CHA>0  Q:+CHA'>0
 . I CHA=1 D HLAB($P(HOST(LA7A),U))
 . I CHA=2 D HLL
 . I CHA=3 D LMC
 . I CHA=4 D CHTST
 D KDIR
 Q
 ;
 ;
HSTHDR2 ;
 N LA7624,LA76248,LA7870,LA7X
 ;
 S LA7CNT=1
 W !!,"1. HOST Lab: ",?15,$P(HOST(LA7A),U,2)
 W:$P(HOST(LA7A),U,2)'="" "  (Uneditable)"
 ;
 I $P(HOST(LA7A),U,2)="" Q
 ;
 D LINK^HLUTIL3($P(HOST(LA7A),"^",4),.LA7X,"")
 S LA7870=+$O(LA7X(0))
 I 'LA7870 D
 . S LA7870=+$$FIND1^DIC(870,"","OX","LA7V"_$P(HOST(LA7A),U))
 . I 'LA7870 S LA7870=+$$FIND1^DIC(870,"","OX","LA7V "_$P(HOST(LA7A),U))
 . I LA7870 S LA7X(LA7870)=$$GET1^DIQ(870,LA7870_",",.01)
 S LA7CNT=2
 W !,"2. Logical Link: ",$G(LA7X(LA7870))
 ;
 S LA76248=$$FIND1^DIC(62.48,"","OX","LA7V HOST "_$P(HOST(LA7A),U)),LA7CNT=3
 W !,"3. Message Configuration: ",$$GET1^DIQ(62.48,LA76248_",",.01)
 ;
 S LA7624=$$FIND1^DIC(62.4,"","OX","LA7V HOST "_$P(HOST(LA7A),U)),LA7CNT=4
 W !,"4. Auto Instrument: ",$$GET1^DIQ(62.4,LA7624_",",.01)
 ;
 Q
 ;
 ;
LMC ; Edit lab message configuration file.
 ;
 N DIC,DA,DR,DIE
 ;
 S X="LA7V HOST "_$P(@LAB@(LA7A),U),DIC(0)="EMX",DIC="^LAHM(62.48,"
 D ^DIC
 I +Y<0 W !,"You have not entered a "_LAB_" lab." Q
 ;
 S DA=+Y,DIE="^LAHM(62.48,",DR="3;4;10;11////10;@20;20;I X'="""" S Y=""@20"""
 D ^DIE
 ;
 Q
 ;
 ;
HLAB(LRI) ;Add Host LAB
 ;
 N INST,LA7VNVC,LA7629,LA7VER,LA7X
 ;
 I $P(HOST(LA7A),U)'="" D KDIR S DIR("A")="Are you sure you want to update the "_$P(HOST(LA7A),U,2)_" interface",DIR(0)="Y0" D ^DIR Q:+Y'>0
 ;
 I $P(HOST(LA7A),U)="" D
 . N DIC,DA,DO
 . S DIC="^DIC(4,",DIC(0)="AEMQZ"
 . S DIC("S")="N LA7X S LA7X=$G(^(99)) I ($L($P(LA7X,U))&$P(LA7X,U,5)=""VA"")!($P(LA7X,U)=""""&$P(LA7X,U,5)'=""VA"")"
 . D ^DIC Q:Y<1
 . S INST=+Y
 . I PRIMARY=INST!(INST=DUZ(2)) D  Q
 . . W !,"To add your Hospital as a HOST site just add COLLECTION sites."
 . S HOST(LA7A+1)=HOST(LA7A)
 . S HOST(LA7A)=$$RETFACID^LA7VHLU2(INST,1,1)_U_$P($$NS^XUAF4(INST),"^")_"^^"_INST
 ;
 I $P(HOST(LA7A),U)="" S $P(HOST(LA7A),U,2)="" Q
 ;
 I PRIMARY'=$P(HOST(LA7A),U) D
 . S LA7VER=2.3
 . I $$NVAF^LA7VHLU2($P(HOST(LA7A),"^",4))=1 S LA7VER=2.2
 . D HOST^LA7VSTP(PRIMARY,PRSITE,$P(HOST(LA7A),U),$P(HOST(LA7A),U,2),LA7VER)
 ;
 Q
 ;
 ;
HLL ;add/edit logical link
 ;
 N HDR,PR,LA7LL
 S HDR="Logical Link for transmissions to/from "_$P(HOST(LA7A),U,2)
 W @IOF,! F X=1:1:79 W "-"
 W !,?((80-$L(HDR))/2),HDR
 W ! F X=1:1:79 W "-"
 W !,?3,"Protocol",?40,"Logical Link",!,?3,"----------",?40,"---------------"
 W !!
 S PR=$O(^ORD(101,"B","LA7V Process Results from "_$P(HOST(LA7A),U),0))
 I PR D GETLL(PR)
 ;
 S PR=$O(^ORD(101,"B","LA7V Send Order to "_$P(HOST(LA7A),U),0))
 I PR D GETLL(PR)
 ;
 W !!
 D KDIR
 S DIR("A")="Setup/update Logical Link",DIR(0)="YO"
 D ^DIR
 I $D(DIRUT) Q
 I Y=1 D TCP^LA7VLL(HOST(LA7A),LA7VS)
 ;
 Q
 ;
 ;
CHTST ;Enter CHEM Test into the AUTO INSTRUMENT file (#62.4)
 ;
 N DA,DIC,DIE,DR,AI,LA7624
 ;
 S (AI,X)="LA7V HOST "_$P(HOST(LA7A),U)
 S DIC(0)="QEM",DIC="^LAB(62.4," D ^DIC
 I +Y<1 Q
 S LA7624=+Y
 ;
 W !!,"AUTOMATED INSTRUMENT: ",$P(^LAB(62.4,LA7624,0),U)
 ;
 L +^LAB(62.4,LA7624):1
 I '$T W !,?5,"Another user is editing this entry." Q
 ;
 S DA=LA7624,DIE=DIC,DR="3;10;11;12;18;107"
 D ^DIE
 W !,"Add Chem Tests to the "_AI_" Automated Instrument for "_$P(HOST(LA7A),U,2)_".",!!
 D CHSET
 ;
 L -^LAB(62.4,LA7624)
 ;
 Q
 ;
 ;
CHSET ; Edit chem test multiple for selected fields
 ; Entry locked from above.
 N DA,DO,DIC,DIE,DLAYGO,DR,LA7NLT,LA7Y
 ;
 S DA(1)=LA7624,DLAYGO=62.4
 S DIC="^LAB(62.4,"_DA(1)_",3,",DIC(0)="AELMQZ",DIC("DR")=".01",DIC("P")=$P(^DD(62.4,30,0),U,2)
 F  D  Q:LA7Y<1
 . D ^DIC S LA7Y=Y Q:LA7Y<1
 . S DIE=DIC
 . N DA,DIC,DLAYGO ; Protect variables in case changed in DIE call.
 . S LA7NLT=$$GET1^DIQ(64,+$P($G(^LAB(60,$P(LA7Y,U,2),64)),U,2)_",",1)
 . S DA=+LA7Y,DA(1)=LA7624
 . S DR=".01;2;6//"_LA7NLT_";14;16;18//YES;19;22//NO"
 . D ^DIE
 . W !
 Q
 ;
 ;
REMOTE ;COLLECTION Lab Setup Menu
 ;
 D COLLECT^LA7VSET1
 Q
 ;
 ;
MHLP ;Main help
 S DIR("?")=" "
 S DIR("?",1)="Option #1 will setup HOST site auto-instruments, HOST site message"
 S DIR("?",2)="configuration, and HOST and COLLECTION sites HL7 environment."
 S DIR("?",3)=" "
 S DIR("?",4)="Option #2 will setup COLLECTION site auto-instruments, COLLECTION site message"
 S DIR("?",5)="configuration, and COLLECTION and HOST sites HL7 environment."
 S DIR("?",6)=" "
 S DIR("?",7)="Option #1 and #2 SHOULD be used by sites that are both a HOST"
 S DIR("?",8)="and a COLLECTION site."
 Q
 ;
 ;
H1HLP ;HOST Lab(s) help
 S DIR("?")="Enter a number between 1 and "_LA7CNT_"."
 S DIR("?",1)="Enter a '"_LA7CNT_"' to create a new HOST lab."
 Q
 ;
 ;
H2HLP ;HOST Lab Setup help
 S DIR("?")=" "
 S DIR("?",1)="Enter a '1' to create the HL7 environment along with the Auto-Instrument"
 S DIR("?",2)="and LA7 Message Configuration."
 S DIR("?",3)="Enter a '2' to create the link between the HOST and COLLECTION labs."
 S DIR("?",5)="Enter a '3' to configure the LA7 MESSAGE PARAMETER file."
 S DIR("?",4)="Enter a '4' to identify the list of test you expect back from the HOST lab."
 Q
 ;
 ;
CONV ;Convert #62.4 and #62.48 from REMOTE to COLLECTION (File #771 will remain REMOTE).
 N RMT,RMT1,UPDT,IEN
 K DA,DR,DIE
 S DIE="^LAB(62.4,"
 S RMT1="LA7V REMOTE ",RMT=RMT1
 F  S RMT=$O(^LAB(62.4,"B",RMT)) Q:RMT=""!(RMT'[RMT1)  D
 . S IEN=$O(^LAB(62.4,"B",RMT,0))
 . S NAME="LA7V COLLECTION"_$P($P(^LAB(62.4,IEN,0),U),"REMOTE",2)
 . S DA=IEN,DR=".01///"_NAME
 . W !,"Renaming Auto-Instrument "_$P(^LAB(62.4,IEN,0),U)_" to "_NAME
 . D ^DIE
 . S UPDT=1
 K DA,DR,DIE
 S DIE="^LAHM(62.48,"
 S RMT1="LA7V REMOTE ",RMT=RMT1
 F  S RMT=$O(^LAHM(62.48,"B",RMT)) Q:RMT=""!(RMT'[RMT1)  D
 . S IEN=$O(^LAHM(62.48,"B",RMT,0))
 . S NAME="LA7V COLLECTION"_$P($P(^LAHM(62.48,IEN,0),U),"REMOTE",2)
 . S DA=IEN,DR=".01///"_NAME
 . W !,"Renaming LA7 Message Configuration "_$P(^LAHM(62.48,IEN,0),U)_" to "_NAME
 . D ^DIE
 . S UPDT=1
 I $G(UPDT)=1 D
 . N DIR,DIRUT
 . W !!,"For consistency and clarity the above Auto-Instrument names"
 . W !,"and Message Configurations have been changed from REMOTE to COLLECTION."
 . S DIR(0)="E" D ^DIR
 Q
 ;
 ;
GETLL(LA7X) ; Get Lower Level Protocol information for displaying
 ; Call with LA7X = ien of file #101 protocol
 ;
 ; Called from above and LA7VSET1
 ;
 N LA7Y
 ;
 D GETS^DIQ(101,LA7X_",",".01;770.7","IE","LA7Y")
 ;
 W !,?3,$G(LA7Y(101,LA7X_",",.01,"E"))
 W ?40,$G(LA7Y(101,LA7X_",",770.7,"E"))
 I $G(LA7Y(101,LA7X_",",770.7,"I")) W " ("_$$GET1^DIQ(870,+LA7Y(101,LA7X_",",770.7,"I")_",",2)_")"
 ;
 Q
