SPNFMENU ;HISC/DAD/WAA-INPUT/OUTPUT MENU PROCESS ;8/19/96  11:06
 ;;2.0;Spinal Cord Dysfunction;**12,19,20,21**;01/02/1997
 ;
 ; This program is a menu program that allow the user to maintain
 ; the current patient and system varables.
 ; 
 ; This program will be called from the three major
 ; screen edit programs and allow the user to select another
 ; for those programs.
 ; 
 ; Input:
 ;     SPNFDFN = Patient DFN within file 2
 ;     SPNFREG = The menu Manager option that called him.
 ;
MENU(SPNFREG,SPNFDFN) ; Main menu loop
 ; This is to select the type of data to enter for a patient.
 ; If none of the give report are selected then SPNFEXIT is set to 1
 ; and the program exits.
 ; Returns SPNFREG as a value of 1 to 4 indicating the type
 ; of OPTION to be USED.
 ; Input:
 ;      SPNFREG = Menu Option
 ;      SPNFDFN = Patient DFN
 ;
 ; Output:
 ;      SPNFEXIT = 1 User exited
 ;                 0 User passed
 K DIRUT
 N SPNFREG1
 S SPNFEXIT=0
 D  G:SPNFEXIT EXIT
 . I SPNFDFN=0 D PAT^SPNFMENU Q:SPNFEXIT
 . I SPNFREG=0 D
 . .D  ; Menu Header
 . . .S DFN=SPNFDFN
 . . .D DEM^VADPT
 . . .W !!,"Patient: ",VADM(1),"  ",$P(VADM(2),U,2)
 . . .W ?60,"DOB: ",$P(VADM(3),U,2)
 . . .D KVAR^VADPT
 . . .Q
 . .K DIR S DIR(0)="SOM^1:Registration and Health Care Information;2:Outcome Information;3:Clinical Information;4:Select a NEW Patient"
 . .S DIR("A")="Select the type of record you wish to enter/edit"
 . .S DIR("?",1)="   Enter 1 to enter/edit Registration and Health Care Information"
 . .S DIR("?",2)="   Enter 2 to enter/edit Outcome Information"
 . .S DIR("?",3)="   Enter 3 to enter/edit Clinical Information"
 . .S DIR("?",4)="   Enter 4 to Select a NEW Patient"
 . .S DIR("?")="   Choose either 1,2,3, or 4."
 . .W ! D ^DIR K DIR S SPNFREG=+Y
 . .I $D(DIRUT) S:$D(DTOUT)!($D(DUOUT)) SPNFEXIT=1 Q
 . .Q
 . I SPNFREG=0 S SPNFEXIT=1 Q
 . D EDIT(SPNFREG,.SPNFDFN)
 . S SPNFREG=0
 . Q
 Q
EXIT K DA,DDSCHANG,DDSFILE,DDSSAVE,DIC,DIE,DIMSG,DR,DTOUT
 K SPNFFIM,SPNLD0,SPNFDFN,SPNLFLAG,X,Y
 Q
 ;
EDIT(SPNFTYPE,SPNFDFN) ; *** Choose add / edit a record
 ;  SPNFTYPE = 1 - Registration and Health Care Information
 ;             2 - Outcome Information
 ;             3 - Clinical Information
 ;             4 - Select a NEW Patient
 ;  SPNFDFN  = DFN in PATIENT file (#2)
 S SPNFEXIT=0
 I SPNFTYPE=2 D REPT^SPNFEDT0(SPNFDFN) Q
 I SPNFTYPE=1!(SPNFTYPE=3) D  Q
 .D PAT^SPNFEDT1(SPNFTYPE,SPNFDFN)
 .Q
 I SPNFTYPE=4 D PAT^SPNFMENU Q
 Q
 ;
PAT ;Select a patient from the patient file
 ;    Return list:
 ;          SPNFDFN = If DFN is null patient DFN from the patient file
 ;          SPNFMS  = 1 patient has MS Etiology
 ;                    0 Patient doesn't have MS
 ;
 I SPNFREG=3 D PAT1541 Q  ;USED TO ROUTE USER ON THE CLINICAL DATA
 S SPNFEXIT=0
 K DIC
 W ! S DLAYGO=154,DIC="^SPNL(154,",DIC(0)="AELMQ" D ^DIC
 I +Y'>0 S SPNFEXIT=1 Q
 S SPNFDFN=+Y
 Q
PAT1541 ;Used to look up patients for Outcomes info or Clinical info
 S SPNFEXIT=0
 K DIC
 S DIC("A")="Select SCD (SPINAL CORD) REGISTRY PATIENT: "
 S DIC="^SPNL(154,",DIC(0)="AEMQ" D ^DIC  ;no help text
 I +Y'>0 S SPNFEXIT=1 Q
 S SPNFDFN=+Y
