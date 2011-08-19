LA7VSET1 ;DALOI/JMC - MENU TO SETUP VISN LABS ; 12/3/1997
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,51,55,46,64**;Sep 27, 1994
 ;
 ; Reference to HL LOGICAL LINK file (#870) supported by DBIA #1495, 1496, 2063
 ; Reference to PROTOCOL file (#101) supported by DBIA #872
 ; Reference to MAIL GROUP file (#3.8) supported by DBIA #2061
 ;
COLLECT ; Collection Lab Setup Menu
 ;
 N LA7CNT,LA7,LA7P,LA7A,REMOTE
 ;
 ;
 F  D  Q:'LA7A
 . S REMOTE="COLLECTION Lab(s)"
 . D RMTBLD,RMTHDR,RMTLST,KDIR
 . W !! S DIR(0)="NO^1:"_LA7CNT
 . D R1HLP
 . D ^DIR
 . I $D(DIRUT) S LA7A=0 Q
 . S LA7A=Y D AEREMT
 Q
 ;
 ;
RMTBLD ; Identify all COLLECTION labs using LA7 MESSAGE PARAMETER file (#62.48)
 ;
 N LA7,LA74,SNAME,SNUM
 S LA7CNT=1,(LA7,LA7P)="LA7V COLLECTION "
 F  S LA7=$O(^LAHM(62.48,"B",LA7)) Q:LA7=""!(LA7'[LA7P)  D
 . S SNUM=$P(LA7,"COLLECTION ",2)
 . S LA74=$$FINDSITE^LA7VHLU2(SNUM,2,1) Q:LA74'>0
 . S SNAME=$P($$NS^XUAF4(LA74),"^")
 . S REMOTE(LA7CNT)=SNUM_U_SNAME_U_LA7_U_LA74,LA7CNT=LA7CNT+1
 S REMOTE(LA7CNT)=""
 Q
 ;
 ;
RMTHDR ; Collection setup header
 ;
 W @IOF,! F X=1:1:79 W "-"
 W !,?((80-$L(REMOTE))/2),REMOTE
 W ! F X=1:1:79 W "-"
 W !!
 ;
 Q
 ;
 ;
RMTLST ;
 S LA7CNT=1,LA7=0
 F  S LA7=$O(REMOTE(LA7)) Q:'LA7  D
 . I REMOTE(LA7)="" Q
 . W !,LA7,".",?5,$P(REMOTE(LA7),U,2)_"  ("_$P(REMOTE(LA7),U,3)_")"
 . S LA7CNT=LA7CNT+1
 ;
 W !,LA7CNT,".",?5,"Add COLLECTION Lab"
 ;
 Q
 ;
 ;
RMTHDR2 ;
 N LA7624,LA76248,LA7870,LA7X
 ;
 S LA7CNT=1
 W !!,"1. COLLECTION Lab: ",?15,$P(REMOTE(LA7A),U,2)
 W:$P(REMOTE(LA7A),U,2)'="" "  (Uneditable)"
 ;
 I $P(REMOTE(LA7A),U,2)="" Q
 ;
 D LINK^HLUTIL3($P(REMOTE(LA7A),"^",4),.LA7X,"")
 S LA7870=+$O(LA7X(0))
 I 'LA7870 D
 . S LA7870=+$$FIND1^DIC(870,"","OX","LA7V"_$P(REMOTE(LA7A),U))
 . I 'LA7870 S LA7870=+$$FIND1^DIC(870,"","OX","LA7V "_$P(REMOTE(LA7A),U))
 . I LA7870 S LA7X(LA7870)=$$GET1^DIQ(870,LA7870_",",.01)
 S LA7CNT=2
 W !,"2. Logical Link (TCP/IP): ",$G(LA7X(LA7870))
 ;
 S LA76248=$$FIND1^DIC(62.48,"","OX","LA7V COLLECTION "_$P(REMOTE(LA7A),U)),LA7CNT=3
 W !,"3. Message Configuration: ",$$GET1^DIQ(62.48,LA76248_",",.01)
 Q
 ;
 ;
AEREMT ;
 ;
 N CHA
 ;
 F  S REMOTE="COLLECTION Lab Setup" D RMTHDR,RMTHDR2,KDIR W !! S DIR(0)="NO^1:"_LA7CNT D R2HLP D ^DIR S CHA=Y D:CHA>0   Q:+CHA'>0
 . I CHA=1 D RLAB($P(REMOTE(LA7A),U))
 . I CHA=2 D RLL
 . I CHA=3 D LMC
 Q
 ;
 ;
LMC ; Edit Lab message configuration file
 ;
 N DIC,DA,DR,DIE,LA76248
 ;
 S LA76248=$$FIND1^DIC(62.48,"","OX","LA7V COLLECTION "_$P(REMOTE(LA7A),U))
 I LA76248<0 W !,"You have not entered a "_LAB_" lab." Q
 S DA=LA76248,DIE="^LAHM(62.48,",DR="3;4;10;@20;20;I X'="""" S Y=""@20"""
 D ^DIE
 Q
 ;
 ;
RLAB(LRI) ;Add REMOTE LAB
 ;
 N INST,LA7VER
 ;
 I $P(REMOTE(LA7A),U)'="" D KDIR S DIR("A")="Are you sure you want to update the "_$P(REMOTE(LA7A),U,2)_" interface",DIR(0)="Y0" D ^DIR Q:+Y'>0
 ;
 I $P(REMOTE(LA7A),U)="" D
 . N DIC,DA,DO
 . S DIC="^DIC(4,",DIC(0)="AEMQZ"
 . S DIC("S")="N LA7X S LA7X=$G(^(99)) I ($L($P(LA7X,U))&$P(LA7X,U,5)=""VA"")!($P(LA7X,U)=""""&$P(LA7X,U,5)'=""VA"")"
 . D ^DIC Q:Y<1
 . S INST=+Y
 . I PRIMARY=INST!(INST=DUZ(2)) D  Q
 . . W !,"To add your Hospital as a COLLECTION site just add HOST sites."
 . S REMOTE(LA7A+1)=REMOTE(LA7A)
 . S REMOTE(LA7A)=$$RETFACID^LA7VHLU2(INST,2,1)_U_$P($$NS^XUAF4(INST),"^")_"^^"_INST
 ;
 I $P(REMOTE(LA7A),U)="" S $P(REMOTE(LA7A),U,2)="" Q
 ;
 I PRIMARY'=$P(REMOTE(LA7A),U) D
 . S LA7VER=2.3
 . I $$NVAF^LA7VHLU2($P(REMOTE(LA7A),"^",4))=1 S LA7VER=2.2
 . D REMOTE^LA7VSTP(PRIMARY,PRSITE,$P(REMOTE(LA7A),U),$P(REMOTE(LA7A),U,2),LA7VER)
 ;
 Q
 ;
 ;
 ;
RLL ; add/edit logical link
 ;
 N HDR,PR,LA7LL
 ;
 S HDR="Logical Link for transmissions to/from "_$P(REMOTE(LA7A),U,2)
 W @IOF,! F X=1:1:79 W "-"
 W !,?((80-$L(HDR))/2),HDR
 W ! F X=1:1:79 W "-"
 W !,?3,"Protocol",?40,"Logical Link",!,?3,"----------",?40,"---------------",!!
 ;
 S PR=$O(^ORD(101,"B","LA7V Process Order from "_$P(REMOTE(LA7A),U),0))
 I PR D GETLL^LA7VSET(PR)
 ;
 S PR=$O(^ORD(101,"B","LA7V Send Results to "_$P(REMOTE(LA7A),U),0))
 I PR D GETLL^LA7VSET(PR)
 ;
 W !!
 D KDIR
 S DIR("A")="Setup/update Logical Link",DIR(0)="YO"
 D ^DIR
 I $D(DIRUT) Q
 I Y=1 D TCP^LA7VLL(REMOTE(LA7A),LA7VS)
 ;
 Q
 ;
 ;
R1HLP ; HOST Lab(s) help
 S DIR("?")="Enter a number between 1 and "_LA7CNT_"."
 S DIR("?",1)="Enter a '"_LA7CNT_"' to create a new COLLECTION lab."
 Q
 ;
 ;
R2HLP ; HOST Lab Setup help
 S DIR("?")="Enter a number between 1 and "_LA7CNT_".  For new entries begin with '1.  HOST Lab:'"
 S DIR("?",1)="Enter a '1' to create the HL7 environment along with the Auto-Instrument"
 S DIR("?",2)="and LA7 Message Configuration."
 S DIR("?",3)="Enter a '2' to create the link between the COLLECTION and HOST labs."
 S DIR("?",4)="Enter a '3' to configure the LA7 MESSAGE PARAMETER file."
 Q
 ;
KDIR ;
 K DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 Q
