PSOSPMKY ;BIRM/MFR - State Prescription Monitoring Program - SSH Key Management ;01/06/16
 ;;7.0;OUTPATIENT PHARMACY;**451**;DEC 1997;Build 114
 ;
EN ; Entry-point
 N STATEIEN,DIC,X,Y,DUOUT,DTOUT,PSOOS,LOCALDIR,X1,DIR,DIRUT,LOCALDIR
 W ! K DIC S DIC("A")="Select STATE: ",DIC="^PS(58.41,",DIC(0)="QOEAM"
 I $O(^PS(58.41,0)) S DIC("B")=$O(^PS(58.41,0))
 D ^DIC I X=""!(X="^")!$D(DUOUT)!$D(DTOUT) G END
 K DIC("A") G:Y<0 EN S STATEIEN=+Y
 ;
ACTION ; SSH Key Action
 K DIR S DIR("A")="Action"
 S DIR(0)="S^V:View Public SSH Key;N:Create New SSH Key Pair;"
 S DIR(0)=DIR(0)_"D:Delete SSH Key Pair;H:Help with SSH Keys"
 S DIR("B")="V" D ^DIR I $D(DUOUT)!($D(DIRUT)) G END
 I Y="N"!(Y="D"),'$D(^XUSEC("PSO SPMP ADMIN",DUZ)) D  G ACTION
 . W !!,"The PSO SPMP ADMIN security key is required for this action.",$C(7)
 K ^TMP("PSOPUBKY",$J) D RETRIEVE(STATEIEN,"PUB")
 I Y="V"!(Y="D"),'$D(^TMP("PSOPUBKY",$J)) D  G ACTION
 . W !!,"[No SSH Key Pair found for ",$$GET1^DIQ(5,STATEIEN,.01),"]",$C(7) D PAUSE^PSOSPMU1
 I Y="N"!(Y="D") D SIG^XUSESIG I X="^"!($G(X1)="") W:$G(X1)="" " SIGNATURE NOT VERIFIED",$C(7) G ACTION
 ; 
 ; View Public SSH Key
 I Y="V" D  G ACTION
 . W ! D VIEW(STATEIEN),PAUSE^PSOSPMU1
 ;
 ; Create New SSH Key Pair
 I Y="N" D  G ACTION
 . S PSOOS=$$BKENDOS()
 . S LOCALDIR=$$GET1^DIQ(58.41,STATEIEN,$S(PSOOS["VMS":4,1:15))
 . I LOCALDIR="" D  Q
 . . W !!,"The ",$S(PSOOS["VMS":"OPEN VMS",1:"UNIX/LINUX")," LOCAL DIRECTORY parameter is missing for ",$$GET1^DIQ(5,STATEIEN,.01),". Please,"
 . . W !,"update it in the View/Edit SPMP State Parameters option and try again.",$C(7) D PAUSE^PSOSPMU1
 . K DIR S DIR("A")="SSH Key Encryption Type",DIR("?")="^D ETHELP^PSOSPMKY"
 . S DIR(0)="S^DSA:Digital Signature Algorithm (DSA);RSA:Rivest, Shamir & Adleman (RSA)"
 . S DIR("B")="DSA" D ^DIR I $D(DUOUT)!($D(DIRUT)) Q
 . S ENCRTYPE=Y
 . I $D(^TMP("PSOPUBKY",$J)) D
 . . W !!,$G(IOBON),"WARNING:",$G(IOBOFF)," You may be overwriting SSH Keys that are currently in use.",$C(7)
 . K DIR S DIR("A")="Confirm Creation of SSH Keys for "_$$GET1^DIQ(5,STATEIEN,.01),DIR(0)="Y",DIR("B")="NO"
 . W ! D ^DIR I $D(DIRUT)!$D(DUOUT)!'Y Q
 . ; Deleting Existing SSH Key
 . I $D(^TMP("PSOPUBKY",$J)) D DELETE(STATEIEN)
 . W !!,"Creating New SSH Keys, please wait..."
 . N ZTRTN,ZTIO,ZTDESC,ZTDTH,ZTSK
 . S ZTRTN="NEWKEY^PSOSPMKY("_STATEIEN_","""_ENCRTYPE_""")",ZTIO=""
 . S ZTDESC="State Prescription Monitoring Program (SPMP) SSH Key Generation"
 . S ZTDTH=$$NOW^XLFDT() D ^%ZTLOAD K ZTSK
 . K ^TMP("PSOPUBKY",$J)
 . F I=1:1:30 D RETRIEVE(STATEIEN,"PUB") Q:$D(^TMP("PSOPUBKY",$J))  H 1
 . ; If unable to create the key via Taskman after 30 seconds, creates them in the foreground
 . I '$D(^TMP("PSOPUBKY",$J)) D
 . . D NEWKEY(STATEIEN,ENCRTYPE),RETRIEVE(STATEIEN,"PUB")
 . I '$D(^TMP("PSOPUBKY",$J)) D
 . . W !!,"There was a problem with the generation of the new SSH Key Pair."
 . . W !,"Please try again and if the problem persists contact IT Support.",$C(7) D PAUSE^PSOSPMU1
 . E  W "Done",$C(7)
 ;
 ; Delete SSH Key Pair
 I Y="D" D  G ACTION
 . D RETRIEVE(STATEIEN,"PUB")
 . I '$D(^TMP("PSOPUBKY",$J)) D  Q
 . . W !!,"[No SSH Key Pair found for ",$$GET1^DIQ(5,STATEIEN,.01),"]",$C(7)
 . W !!,$G(IOBON),"WARNING:",$G(IOBOFF)," You may be deleting SSH Keys that are currently in use.",$C(7)
 . K DIR S DIR("A")="Confirm Deletion of "_$$GET1^DIQ(5,STATEIEN,.01)_"'s SSH Keys",DIR(0)="Y",DIR("B")="NO"
 . W ! D ^DIR I $D(DIRUT)!$D(DUOUT)!'Y Q
 . W !!,"Deleting SSH Keys..." D DELETE(STATEIEN) H 1 W "Done",$C(7)
 ;
 ; SSH Key Help
 I Y="H" D HELP G ACTION
 ;
 G ACTION
 ;
END Q
 ;
NEWKEY(STATEIEN,ENCRTYPE) ; Generate and store a pair of SSH keys for a specific state
 ; Input: (r) STATEIEN - State that will be using the new key pair. Pointer to the STATE file (#5)
 ;        (o) ENCRTYPE - SSH Encryption Type (DSA / RSA) (Default: DSA)
 N LOCALDIR,DATETIME,PSOOS,KEYFILE,PV,FILE2DEL,LINE,OVFLINE,NMSPC,KEYTXT,SAVEKEY,DIE,DR,DA
 ;
 I '$G(STATEIEN) Q  ;Error: State missing
 S PSOOS=$$OS^%ZOSV()
 S LOCALDIR=$$GET1^DIQ(58.41,STATEIEN,$S(PSOOS["VMS":4,1:15)) I LOCALDIR="" Q  ;Error: Missing directory
 I $G(ENCRTYPE)'="DSA",$G(ENCRTYPE)'="RSA" S ENCRTYPE="DSA"
 ;
 ; LOCK to avoid OS files overwrite
 F  S DATETIME=$P($$FMTHL7^XLFDT($$HTFM^XLFDT($H)),"-") S KEYFILE="KEY"_DATETIME L +@KEYFILE:0 Q:$T  H 2
 ;
 ; Deleting existing SSH Keys first
 D DELETE(STATEIEN)
 ;
 ; OpenVMS SSH Key Generation
 I PSOOS["VMS" D
 . N COMFILE
 . S COMFILE="COM"_DATETIME_".COM"
 . D OPEN^%ZISH("COMFILE",LOCALDIR,COMFILE,"W")
 . D USE^%ZISUTL("COMFILE")
 . W "SSH_KEYGEN == ""$SYS$SYSTEM:TCPIP$SSH_SSH-KEYGEN2.EXE""",!
 . W "SSH_KEYGEN -t "_$$LOW^XLFSTR($G(ENCRTYPE))_" -""P"" "_LOCALDIR_KEYFILE,!
 . D CLOSE^%ZISH("COMFILE")
 . X "S PV=$ZF(-1,""@"_LOCALDIR_COMFILE_""")"
 . S FILE2DEL(COMFILE)="",FILE2DEL(KEYFILE_".")="",FILE2DEL(KEYFILE_".PUB")=""
 ;
 ; Linux/Unix SSH Key Generation
 I PSOOS["UNIX" D
 . I '$$DIREXIST^PSOSPMU1(LOCALDIR) D MAKEDIR^PSOSPMU1(LOCALDIR)
 . X "S PV=$ZF(-1,""ssh-keygen -q -N '' -C '' -t "_$$LOW^XLFSTR($G(ENCRTYPE))_" -f "_LOCALDIR_KEYFILE_""")"
 . S FILE2DEL(KEYFILE)="",FILE2DEL(KEYFILE_".pub")=""
 ;
 K ^TMP("PSOPRVKY",$J),^TMP("PSOPUBKY",$J)
 ; Retrieving SSH Private Key Content
 S X=$$FTG^%ZISH(LOCALDIR,KEYFILE_$S(PSOOS["VMS":".",1:""),$NAME(^TMP("PSOPRVKY",$J,1)),3)
 I '$D(^TMP("PSOPRVKY",$J,1)) Q
 ; Retrieving SSH Public Key Content
 S X=$$FTG^%ZISH(LOCALDIR,KEYFILE_$S(PSOOS["VMS":".PUB",1:".pub"),$NAME(^TMP("PSOPUBKY",$J,1)),3)
 I '$D(^TMP("PSOPUBKY",$J,1)) Q
 ;
 ; Deleting temporary files used to generate the keys
 D DEL^%ZISH(LOCALDIR,"FILE2DEL")
 ;
 ; Saving new SSH Keys content in the SPMP STATE PARAMETERS file (#58.41)
 F NMSPC="PSOPRVKY","PSOPUBKY" D
 . K KEYTXT,SAVEKEY
 . F LINE=1:1 Q:'$D(^TMP(NMSPC,$J,LINE))  D
 . . ; Unix/Linux Public SSH Key has no line-feed (one long line)
 . . I PSOOS["UNIX",NMSPC="PSOPUBKY" D  Q
 . . . S KEYTXT(1)=^TMP(NMSPC,$J,LINE)
 . . . F OVFLINE=1:1 Q:'$D(^TMP(NMSPC,$J,LINE,"OVF",OVFLINE))  D
 . . . . S KEYTXT(1)=$G(KEYTXT(1))_^TMP(NMSPC,$J,LINE,"OVF",OVFLINE)
 . . S KEYTXT(LINE)=$$ENCRYP^XUSRB1(^TMP(NMSPC,$J,LINE))
 . I PSOOS["UNIX",NMSPC="PSOPUBKY" S KEYTXT(1)=$$ENCRYP^XUSRB1(KEYTXT(1))
 . S SAVEKEY(58.41,STATEIEN_",",$S(NMSPC="PSOPRVKY":100,1:200))="KEYTXT"
 . D UPDATE^DIE("","SAVEKEY")
 . K ^TMP(NMSPC,$J)
 ;
 ; Saving SSH Key Format (SSH2/OpenSSH) and Encryption Type (DSA/RSA) fields
 K DIE S DIE="^PS(58.41,",DA=STATEIEN
 S DR="18///"_$S(PSOOS["VMS":"SSH2",1:"OSSH")_";19///"_ENCRTYPE D ^DIE
 ;
 L -@KEYFILE
 Q
 ;
RETRIEVE(STATEIEN,KEYTYPE) ; Retrieve the SSH Key into the ^TMP global
 ; Input: (r) STATEIEN - State to retrieve the SSH Key from
 ;        (o) KEYTYPE  - SSH Key Type (PUB - Public / PRV - PRivate) (Default: Public)
 ;Output: ^TMP("PSO[PUB/PRV]KY",$J,0)="SSH Key Format (SSH2 / OpenSSH)^Encryption Type (DSA / RSA)"
 ;        ^TMP("PSO[PUB/PRV]KY",$J,1-N)=[SSH Key Content]
 N X,LINE,KEYTXT,NMSPC
 I $G(KEYTYPE)'="PUB",$G(KEYTYPE)'="PRV" S KEYTYPE="PUB"
 S X=$$GET1^DIQ(58.41,STATEIEN_",",$S(KEYTYPE="PRV":100,1:200),,"KEYTXT")
 S NMSPC=$S(KEYTYPE="PRV":"PSOPRVKY",1:"PSOPUBKY")
 K ^TMP(NMSPC,$J)
 F LINE=1:1 Q:'$D(KEYTXT(LINE))  D
 . S ^TMP(NMSPC,$J,LINE)=$$DECRYP^XUSRB1(KEYTXT(LINE))
 I $D(^TMP(NMSPC,$J)) D
 . S ^TMP(NMSPC,$J,0)=$$GET1^DIQ(58.41,STATEIEN,18,"I")_"^"_$$GET1^DIQ(58.41,STATEIEN,19,"I")
 Q
 ;
VIEW(STATEIEN) ; Displays the SSH Public Key
 ;Input: (r) STATEIEN - State to display the Public SSH Key for
 ;       ^TMP("PSOPUBKY",$J,0)="SSH Key Format (SSH2 / OpenSSH)^Encryption Type (DSA / RSA)"
 ;       ^TMP("PSOPUBKY",$J,1-N)=[SSH Key Content]
 N SSHKEY,DASHLN
 I '$G(STATEIEN) Q
 S SSHKEY=$$OPENSSH(),$P(DASHLN,"-",81)=""
 W !,$$GET1^DIQ(5,STATEIEN,.01),"'s Public SSH Key (",$P($G(^TMP("PSOPUBKY",$J,0)),"^",2),") content (does not include dash lines):"
 W !,DASHLN
 F  Q:$L(SSHKEY)=0  W !,$E(SSHKEY,1,80) S SSHKEY=$E(SSHKEY,81,9999)
 W !,DASHLN
 Q
 ;
DELETE(STATEIEN) ; Delete Both SSH Keys associated with the State
 ;Input: (r) STATEIEN - State from what the key should be deleted from in the SPMP STATE PARAMETERS file (#58.41)
 N DIE,DA,DR
 S DIE="^PS(58.41,",DA=+$G(STATEIEN),DR="18///@;19///@;100///@;200///@" D ^DIE
 K ^TMP("PSOPRVKY",$J),^TMP("PSOPUBKY",$J)
 Q
 ;
OPENSSH() ; Returns the SSH Public Key in OpenSSH Format (Converts if necessary)
 ;Input: ^TMP("PSOPUBKY",$J,0)="SSH Key Format (SSH2 / OpenSSH)^Encryption Type (DSA / RSA)"
 ;       ^TMP("PSOPUBKY",$J,1-N)=[SSH Key Content]
 N OPENSSH,ENCRTYPE,LINE
 S OPENSSH=""
 I $P($G(^TMP("PSOPUBKY",$J,0)),"^",1)="SSH2" D
 . S ENCRTYPE=$P($G(^TMP("PSOPUBKY",$J,0)),"^",2),OPENSSH=""
 . F LINE=5:1 Q:'$D(^TMP("PSOPUBKY",$J,LINE))  D
 . . I $G(^TMP("PSOPUBKY",$J,LINE))["---- END" Q
 . . S OPENSSH=OPENSSH_$G(^TMP("PSOPUBKY",$J,LINE))
 . S OPENSSH=$S(ENCRTYPE="RSA":"ssh-rsa",1:"ssh-dss")_" "_OPENSSH
 E  D
 . F LINE=1:1 Q:'$D(^TMP("PSOPUBKY",$J,LINE))  D
 . . S OPENSSH=OPENSSH_$G(^TMP("PSOPUBKY",$J,LINE))
 Q OPENSSH
 ;
BKENDOS() ; Returns the Backend Server Operating System (OS)
 ;Output: Backend Operating System (e.,g., "VMS", "UNIX")
 N BKENDOS,ZTRTN,ZTIO,ZTDESC,ZTDTH,ZTSK,I
 K ^XTMP("PSOSPMKY",$J,"OS")
 S BKENDOS="",ZTRTN="SETOS^PSOSPMKY("_$J_")",ZTIO=""
 S ZTDESC="State Prescription Monitoring Program (SPMP) Backend Server OS Check"
 S ZTDTH=$$NOW^XLFDT() D ^%ZTLOAD
 F I=1:1:5 S BKENDOS=$G(^XTMP("PSOSPMKY",$J,"OS")) Q:BKENDOS'=""  H 1
 K ^XTMP("PSOSPMKY",$J,"OS")
 Q $S(BKENDOS'="":BKENDOS,1:$$OS^%ZOSV())
 ;
SETOS(JOB) ; Sets the Operating Systems in ^XTMP("PSOSPMKY",$J,"OS") (Called via Taskman)
 ;Input: JOB - $Job value from calling process
 S ^XTMP("PSOSPMKY",JOB,"OS")=$$OS^%ZOSV()
 Q
 ;
HELP ; SSH Key Help Text
 W !!,"Secure SHell (SSH) Encryption Keys are used to automate the data transmission"
 W !,"to the State Prescription Monitoring Programs (SPMPs). Follow the steps below"
 W !,"to successfully setup SPMP transmissions from VistA to the state/vendor server:"
 W !,""
 W !,"Step 1: Select the 'N' (Create New SSH Key Pair) Action and follow the prompts"
 W !,"        to create a new pair of SSH keys. If you already have an existing SSH"
 W !,"        Key Pair you can skip this step."
 W !,"        You can check whether you already have an existing SSH Key Pair"
 W !,"        through the 'V' (View Public SSH Key) Action."
 W !,""
 W !,"        Encryption Type: DSA or RSA?"
 W !,"        ----------------------------"
 D ETHELP,PAUSE^PSOSPMU1
 W !!,"Step 2: Share the Public SSH Key content with the state/vendor. In order to"
 W !,"        successfully establish SPMP transmissions the state/vendor will have"
 W !,"        to install/configure the new SSH Key created in step 1 for the"
 W !,"        user id they assigned to your site. Use the 'V' (View Public SSH Key)"
 W !,"        Action to retrieve the content of the Public SSH key. The Public SSH"
 W !,"        Key should not contain line-feed characters, therefore after you copy"
 W !,"        & paste it from the terminal emulator into an email or text editor"
 W !,"        make sure it contains only one line of text (no wrapping)."
 Q
ETHELP ; Encryption Type Help
 W !,"        Digital Signature Algorithm (DSA) and Rivest, Shamir & Adleman (RSA)"
 W !,"        are two of the most common encryption algorithms used by the IT"
 W !,"        industry for securely sharing data. The majority of SPMP servers can"
 W !,"        handle either type; however there are vendors that accept only one"
 W !,"        specific type. You will need to contact the SPMP vendor support to"
 W !,"        determine which type to select."
 Q
