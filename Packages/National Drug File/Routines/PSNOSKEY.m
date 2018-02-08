PSNOSKEY ;BIR/SJA-PPS-N SSH Key Management ;09/16/2016
 ;;4.0;NATIONAL DRUG FILE;**513**; 30 Oct 98;Build 53
 ;
 ; taken mostly from: PSOSPMKY - State Prescription Monitoring Program - SSH Key Management
 ;
EN ; -- Entry point
 N X,Y,PSNOS,LOCALDIR,X1,DIR
 ;
ACTION ; -- SSH Key Action
 K DIR S DIR("A")="Action"
 S DIR(0)="S^V:View Public SSH Key;C:Create New SSH Key Pair;D:Delete SSH Key Pair;H:Help with SSH Keys",DIR("B")="V"
 D ^DIR
 I $D(DUOUT)!($D(DIRUT)) G END
 I Y="C"!(Y="D"),'$D(^XUSEC("PSN PPS COORD",DUZ)) D  G ACTION
 .W !!,"The PSN PPS COORD security key is required for this action.",$C(7)
 K ^TMP("PSNPUBKY",$J) D RETRIEVE("PUB")
 I Y="V"!(Y="D"),'$D(^TMP("PSNPUBKY",$J)) D  G ACTION
 .W !!,"[No SSH Key Pair found]",$C(7) D PAUSE
 I Y="C"!(Y="D") D SIG^XUSESIG I X="^"!($G(X1)="") W:$G(X1)="" " SIGNATURE NOT VERIFIED",$C(7) G ACTION
 ; 
 ; -- View Public SSH Key
 I Y="V" W ! D VIEW,PAUSE G ACTION
 ;
 ; -- Create New SSH Key Pair
 I Y="C" D  G ACTION
 .I '$$ASK() W !!,"No action taken!",$C(7) Q
 .S PSNOS=$$ENDOS()
 .S LOCALDIR=$$GET1^DIQ(57.23,1,$S(PSNOS["VMS":1,1:3))
 .I LOCALDIR="" D  Q
 ..W !!,"The ",$S(PSNOS["VMS":"OPEN VMS",1:"UNIX/LINUX")," LOCAL DIRECTORY parameter is missing. Please, update it in"
 ..W !,"the 'PPS-N Site Parameters (Enter/Edit)' option and try again.",$C(7) D PAUSE
 .K DIR S DIR("A")="SSH Key Encryption Type",DIR("?")="^D HELP1^PSNOSKEY"
 .S DIR(0)="S^RSA:Rivest, Shamir & Adleman (RSA);DSA:Digital Signature Algorithm (DSA)"
 .S DIR("B")="RSA" D ^DIR I $D(DUOUT)!($D(DIRUT)) Q
 .S ENCRTYPE=Y
 .I $D(^TMP("PSNPUBKY",$J)) D
 ..W !!,$G(IOBON),"WARNING:",$G(IOBOFF)," You may be overwriting SSH Keys that are currently in use.",$C(7)
 .K DIR S DIR("A")="Confirm Creation of SSH Keys",DIR(0)="Y",DIR("B")="NO"
 .W ! D ^DIR I $D(DIRUT)!$D(DUOUT)!'Y Q
 .;
 .; -- Deleting Existing SSH Key
 .I $D(^TMP("PSNPUBKY",$J)) D DELETE
 .W !!,"Creating New SSH Keys, please wait..."
 .N ZTRTN,ZTIO,ZTDESC,ZTDTH,ZTSK
 .S ZTRTN="NEWKEY^PSNOSKEY("""_ENCRTYPE_""")",ZTIO="",ZTDESC="SSH Key Generation",ZTDTH=$$NOW^XLFDT()
 .D ^%ZTLOAD K ZTSK,^TMP("PSNPUBKY",$J)
 .F I=1:1:30 D RETRIEVE("PUB") Q:$D(^TMP("PSNPUBKY",$J))  H 1
 .; -- If unable to create the key via Taskman after 30 seconds, creates them in the foreground
 .I '$D(^TMP("PSNPUBKY",$J)) D
 ..D NEWKEY(ENCRTYPE),RETRIEVE("PUB")
 .I '$D(^TMP("PSNPUBKY",$J)) D
 ..W !!,"There was a problem with the generation of the new SSH Key Pair."
 ..W !,"Please try again and if the problem persists contact IT Support.",$C(7) D PAUSE
 .E  W "Done",$C(7)
 ;
 ; -- Delete SSH Key Pair
 I Y="D" D  G ACTION
 .D RETRIEVE("PUB")
 .I '$D(^TMP("PSNPUBKY",$J)) W !!,"[No SSH Key Pair found]",$C(7) Q
 .W !!,$G(IOBON),"WARNING:",$G(IOBOFF)," You may be deleting SSH Keys that are currently in use.",$C(7)
 .K DIR S DIR("A")="Confirm Deletion of SSH Keys",DIR(0)="Y",DIR("B")="NO"
 .W ! D ^DIR I $D(DIRUT)!$D(DUOUT)!'Y Q
 .W !!,"Deleting SSH Keys..." D DELETE H 1 W "Done",$C(7)
 ; SSH Key Help
 I Y="H" D HELP G ACTION
 G ACTION
 ;
END ;
 Q
 ;
NEWKEY(ENCRTYPE) ; Generate and store a pair of SSH keys
 ; Input:  (o) ENCRTYPE - SSH Encryption Type (DSA/RSA) (Default: DSA)
 ;
 N LOCALDIR,DTE,PSNOS,KEYFILE,PV,FILE2DEL,LN,OVFLN,PSNSPC,KYTXT,SAVEKEY,DIE,DR,DA
 S PSNOS=$$OS^%ZOSV()
 S LOCALDIR=$$GET1^DIQ(57.23,1,$S(PSNOS["VMS":1,1:3)) I LOCALDIR="" Q  ;Error: Missing directory
 I $G(ENCRTYPE)'="RSA" S ENCRTYPE="DSA"
 ; -- LOCK to avoid OS files overwrite
 F  S DTE=$P($$FMTHL7^XLFDT($$HTFM^XLFDT($H)),"-") S KEYFILE="KY"_DTE L +@KEYFILE:0 Q:$T  H 2
 ; -- Deleting existing SSH Keys first
 D DELETE
 ;
 ; -- OpenVMS SSH Key Generation
 I PSNOS["VMS" D
 .N COMFILE S COMFILE="COM"_DTE_".COM"
 .D OPEN^%ZISH("COMFILE",LOCALDIR,COMFILE,"W")
 .D USE^%ZISUTL("COMFILE")
 .W "SSH_KEYGEN == ""$SYS$SYSTEM:TCPIP$SSH_SSH-KEYGEN2.EXE""",!
 .W "SSH_KEYGEN -t "_$$LOW^XLFSTR($G(ENCRTYPE))_" -""P"" "_LOCALDIR_KEYFILE,!
 .D CLOSE^%ZISH("COMFILE")
 .X "S PV=$ZF(-1,""@"_LOCALDIR_COMFILE_""")"
 .S FILE2DEL(COMFILE)="",FILE2DEL(KEYFILE_".")="",FILE2DEL(KEYFILE_".PUB")=""
 ;
 ; -- Linux/Unix SSH Key Generation
 I PSNOS["UNIX" D
 .I '$$DIREXIST^PSNFTP2(LOCALDIR) D MAKEDIR^PSNFTP2(LOCALDIR)
 .X "S PV=$ZF(-1,""ssh-keygen -q -N '' -C '' -t "_$$LOW^XLFSTR($G(ENCRTYPE))_" -f "_LOCALDIR_KEYFILE_""")"
 .S FILE2DEL(KEYFILE)="",FILE2DEL(KEYFILE_".pub")=""
 ;
 K ^TMP("PSNPRVKY",$J),^TMP("PSNPUBKY",$J)
 ; -- Retrieving SSH Private Key Content
 S X=$$FTG^%ZISH(LOCALDIR,KEYFILE_$S(PSNOS["VMS":".",1:""),$NAME(^TMP("PSNPRVKY",$J,1)),3)
 I '$D(^TMP("PSNPRVKY",$J,1)) Q
 ; -- Retrieving SSH Public Key Content
 S X=$$FTG^%ZISH(LOCALDIR,KEYFILE_$S(PSNOS["VMS":".PUB",1:".pub"),$NAME(^TMP("PSNPUBKY",$J,1)),3)
 I '$D(^TMP("PSNPUBKY",$J,1)) Q
 ;
 ; -- Deleting temporary files used to generate the keys
 D DEL^%ZISH(LOCALDIR,"FILE2DEL")
 ;
 ; -- Saving new SSH Keys content in the PPS-N UPDATE CONTROL file (#57.23)
 F PSNSPC="PSNPRVKY","PSNPUBKY" D
 .K KYTXT,SAVEKEY
 .F LN=1:1 Q:'$D(^TMP(PSNSPC,$J,LN))  D
 ..; Unix/Linux Public SSH Key has no line-feed
 ..I PSNOS["UNIX",PSNSPC="PSNPUBKY" D  Q
 ...S KYTXT(1)=^TMP(PSNSPC,$J,LN) F OVFLN=1:1 Q:'$D(^TMP(PSNSPC,$J,LN,"OVF",OVFLN))  D
 ....S KYTXT(1)=$G(KYTXT(1))_^TMP(PSNSPC,$J,LN,"OVF",OVFLN)
 ..S KYTXT(LN)=$$ENCRYP^XUSRB1(^TMP(PSNSPC,$J,LN))
 .I PSNOS["UNIX",PSNSPC="PSNPUBKY" S KYTXT(1)=$$ENCRYP^XUSRB1(KYTXT(1))
 .S SAVEKEY(57.23,"1,",$S(PSNSPC="PSNPRVKY":33,1:34))="KYTXT"
 .D UPDATE^DIE("","SAVEKEY")
 .K ^TMP(PSNSPC,$J)
 ;
 ; -- Saving SSH Key Format (SSH2/OpenSSH) and Encryption Type (DSA/RSA) fields
 K DIE S DIE="^PS(57.23,",DA=1
 S DR="39///"_$S(PSNOS["VMS":"SSH2",1:"OSSH")_";41///"_ENCRTYPE D ^DIE
 L -@KEYFILE
 Q
 ;
RETRIEVE(KTYPE) ; Retrieve the SSH Key into the ^TMP global
 ;        (o) KTYPE  - SSH Key Type (PUB - Public/PRV - PRivate) (Default: Public)
 ;Output: ^TMP("PSN[PUB/PRV]KY",$J,0)="SSH Key Format (SSH2/OpenSSH)^Encryption Type (DSA/RSA)"
 ;        ^TMP("PSN[PUB/PRV]KY",$J,1-N)=[SSH Key Content]
 ;
 N X,LN,KYTXT,PSNSPC
 I $G(KTYPE)'="PRV" S KTYPE="PUB"
 S X=$$GET1^DIQ(57.23,"1,",$S(KTYPE="PRV":33,1:34),,"KYTXT")
 S PSNSPC=$S(KTYPE="PRV":"PSNPRVKY",1:"PSNPUBKY")
 K ^TMP(PSNSPC,$J)
 F LN=1:1 Q:'$D(KYTXT(LN))  S ^TMP(PSNSPC,$J,LN)=$$DECRYP^XUSRB1(KYTXT(LN))
 I $D(^TMP(PSNSPC,$J)) D
 .S ^TMP(PSNSPC,$J,0)=$$GET1^DIQ(57.23,1,39,"I")_"^"_$$GET1^DIQ(57.23,1,41,"I")
 Q
 ;
VIEW ; Displays the SSH Public Key
 ;       ^TMP("PSNPUBKY",$J,0)="SSH Key Format (SSH2/OpenSSH)^Encryption Type (DSA/RSA)"
 ;       ^TMP("PSNPUBKY",$J,1-N)=[SSH Key Content]
 N SSHKEY,DASHLN
 S $P(DASHLN,"-",81)="",SSHKEY=$$OPENSSH()
 W !,"Public SSH Key (",$P($G(^TMP("PSNPUBKY",$J,0)),"^",2),") content (does not include dash lines):"
 W !,DASHLN
 F  Q:$L(SSHKEY)=0  W !,$E(SSHKEY,1,80) S SSHKEY=$E(SSHKEY,81,9999)
 W !,DASHLN
 Q
 ;
DELETE ; Delete Both SSH Keys associated
 N DIE,DA,DR
 S DIE="^PS(57.23,",DA=1,DR="39///@;41///@;33///@;34///@" D ^DIE
 K ^TMP("PSNPRVKY",$J),^TMP("PSNPUBKY",$J)
 Q
 ;
OPENSSH() ; Returns the SSH Public Key in OpenSSH Format (Converts if necessary)
 ;Input: ^TMP("PSNPUBKY",$J,0)="SSH Key Format (SSH2/OpenSSH)^Encryption Type (DSA/RSA)"
 ;       ^TMP("PSNPUBKY",$J,1-N)=[SSH Key Content]
 ;
 N OPENSSH,ENCRTYPE,LN
 S OPENSSH=""
 I $P($G(^TMP("PSNPUBKY",$J,0)),"^")="SSH2" D
 .S ENCRTYPE=$P($G(^TMP("PSNPUBKY",$J,0)),"^",2),OPENSSH=""
 .F LN=5:1 Q:'$D(^TMP("PSNPUBKY",$J,LN))  D
 ..I $G(^TMP("PSNPUBKY",$J,LN))["---- END" Q
 ..S OPENSSH=OPENSSH_$G(^TMP("PSNPUBKY",$J,LN))
 .S OPENSSH=$S(ENCRTYPE="RSA":"ssh-rsa",1:"ssh-dss")_" "_OPENSSH
 E  D
 .F LN=1:1 Q:'$D(^TMP("PSNPUBKY",$J,LN))  D
 ..S OPENSSH=OPENSSH_$G(^TMP("PSNPUBKY",$J,LN))
 Q OPENSSH
 ;
ENDOS() ; Returns the Backend Server Operating System (OS)
 ;Output: Backend Operating System (e.,g., "VMS", "UNIX")
 ;
 N ENDOS,ZTRTN,ZTIO,ZTDESC,ZTDTH,ZTSK,I
 K ^XTMP("PSNKEY",$J,"OS")
 S ENDOS="",ZTRTN="SETOS^PSNOSKEY("_$J_")",ZTIO=""
 S ZTDESC="Backend Server OS Check"
 S ZTDTH=$$NOW^XLFDT() D ^%ZTLOAD
 F I=1:1:5 S ENDOS=$G(^XTMP("PSNKEY",$J,"OS")) Q:ENDOS'=""  H 1
 K ^XTMP("PSNKEY",$J,"OS")
 Q $S(ENDOS'="":ENDOS,1:$$OS^%ZOSV())
 ;
SETOS(JOB) ; Sets the Operating Systems in ^XTMP("PSNKEY",$J,"OS") (Called via Taskman)
 ;Input: JOB - $Job value from calling process
 S ^XTMP("PSNKEY",JOB,"OS")=$$OS^%ZOSV()
 Q
 ;
HELP ; Encryption Type Help
 W !!,"Secure SHell (SSH) Encryption Keys are used to allow data file download."
 W !,"Follow the steps below to successfully setup data file download from Austin "
 W !,"server to VistA sites:",!
 W !,"Step 1: Select the 'C' (Create New SSH Key Pair) Action and follow the prompts"
 W !,"        to create a new pair of SSH keys. If you already have an existing SSH"
 W !,"        Key Pair you can skip this step."
 W !,"        You can check whether you already have an existing SSH Key Pair"
 W !,"        through the 'V' (View Public SSH Key) Action."
 W !,""
 D HELP1,PAUSE
 W !!,"Step 2: Share the Public SSH Key content with the PPS-N SFTP server (Austin)."
 W !,"        Inorder to successfully establish the data download files, the SFTP  "
 W !,"        server at Austin needs to install/configure the new SSH Key created in"
 W !,"        step 1 for the user id they assigned to your site. Use the 'V' (View "
 W !,"        Public SSH Key) Action to retrieve the content of the Public SSH key."
 W !,"        The Public SSH Key should not contain line-feed characters, therefore "
 W !,"        after you copy & paste it from the terminal emulator into an email or "
 W !,"        text editor make sure it contains only one line of text (no wrapping)."
 Q
 ;
HELP1 ; Encryption Type Help
 W !,"        Encryption Type: RSA or DSA?"
 W !,"        ----------------------------"
 W !,"        The Rivest, Shamir & Adleman (RSA) and Digital Signature Algorithm"
 W !,"        (DSA) are two of the most common encryption algorithms used in IT "
 W !,"        industry for securely sharing data."
 Q
PAUSE ; Pauses screen until user hits Return
 W ! K DIR S DIR("A")="Press Return to continue",DIR(0)="E" D ^DIR
 Q
 ;
ASK() ; confirm creating new pair
 N Y S Y=0 Q:'$D(^TMP("PSNPUBKY",$J)) 1
 K DIRUT,DUOUT,DIR,X,Y S DIR(0)="Y",DIR("?")="Please enter Y or N."
 S DIR("A")="Do you want to delete existing key pair and create new pair" W !!
 S DIR("B")="NO" D ^DIR
 Q Y
