OOPSXP8 ;WIOFO/LLH-INIT ROUTINE FOR PATCH 8 ;5/1/2000 
 ;;1.0;ASISTS;**8**;Jun 01, 1998
 ;
VAL(IEN) ; Determine pay rate, convert if called from ????
 ;  input  - IEN of case
 ; output  - VAL returns 1 is field is convertable
 ;         - PAY is set to the conversion value to be set into fld 167
 ;           in the subroutine PAY below
 ;
 ; Code to test for a value of 1,2,6 is included as defensive code
 ; in the event that the package file check fails and this code is
 ; run more than once.  It 'protects' valid codes.  These values should
 ; not be present prior to the conversion.
 ;
 N STR,VAL
 S STR=$G(^OOPS(2260,IEN,"CA1L")),PAY=$P($G(STR),U,2)
 S PAY=$$UP^OOPSUTL4(PAY),PAY=$TR(PAY,"- ","")
 I PAY="Y"!(PAY="YR")!($E(PAY,1,4)="YEAR")!(PAY="A")!(PAY="AN")!($E(PAY,1,4)="ANNU") S PAY="ANNUAL"
 I PAY="H"!(PAY="HR")!($E(PAY,1,4)="HOUR") S PAY="HOURLY"
 I PAY="W"!(PAY=1)!(PAY="WK")!($E(PAY,1,4)="WEEK") S PAY="WEEKLY"
 I PAY="B"!(PAY=2)!(PAY="BI")!($E(PAY,1,4)="BIWE") S PAY="BI-WEEKLY"
 I PAY="D"!(PAY=6)!(PAY="DA")!(PAY="DAILY")!(PAY="PERDIEM") S PAY="DAILY"
 S VAL=$S(PAY="ANNUAL":1,PAY="HOURLY":1,PAY="WEEKLY":1,PAY="BI-WEEKLY":1,PAY="DAILY":1,PAY="":1,1:0)
 Q VAL
POST ;
 N MSG,PAY,PMSG
 S MSG(1)=" "
 S MSG(2)="The PAY RATE PER Field (#167) in the ASISTS ACCIDENT REPORTING "
 S MSG(3)="File (#2260) has been changed from a free text field to a "
 S MSG(4)="set of codes field."
 S MSG(5)="This routine will convert the current data in the PAY RATE PER "
 S MSG(6)="field for cases that a valid code can be determined."
 S MSG(7)="The Set of Codes are: "
 S MSG(8)="1 -   Weekly                   H -   Hourly"
 S MSG(9)="2 -   Bi-weekly                A -   Annual"
 S MSG(10)="6 -   Daily"
 S MSG(11)="Any case that the correct code cannot be determined for will"
 S MSG(12)="be included in the install file and the PAY RATE PER data deleted."
 S MSG(13)="An option is provided with the patch that will allow"
 S MSG(14)="a user to correct the data after installation of the patch."
 S MSG(15)="If required (cases are present with data that could not be "
 S MSG(16)="converted), install the option as a secondary menu on the"
 S MSG(17)="appropriate users' menu and instruct them to make the data"
 S MSG(18)="corrections."
 ;
 I $$PATCH^XPDUTL("OOPS*1.0*8") D  Q
 . D BMES^XPDUTL("  Skipping post install since patch was previously installed.")
 D BMES^XPDUTL("Data Conversion in Progress...") H 1
 D MES^XPDUTL(" ")
 D PAY
 I PMSG D MES^XPDUTL(.MSG) H 3
 D DICT
 K DIC,DLAYGO
 Q
 ;
PAY ; Convert the PAY RATE PER field to the set of codes.  Also convert
 ; the WITNESS NAME (#115) and move to WITNESS NAME (#2260.0125,.01)
 N IEN,INJ,DR,DA,DIE,WITNM
 S IEN=0,DIE="^OOPS(2260,",PMSG=0
 F  S IEN=$O(^OOPS(2260,IEN)) Q:IEN'>0  D
 . S WITNM=$P($G(^OOPS(2260,IEN,"CA1D")),U)
 . I $G(WITNM)'="" D
 .. ; set the witness name into new field, kill #115)
 .. S ^OOPS(2260,IEN,"CA1W",0)="^2260.0125A^1^1"
 .. S $P(^OOPS(2260,IEN,"CA1W",1,0),U)=WITNM
 .. S ^OOPS(2260,IEN,"CA1W","B",WITNM,1)=""
 .. S $P(^OOPS(2260,IEN,"CA1D"),U)=""
 . S INJ=$P($G(^OOPS(2260,IEN,0)),U,7)
 . I INJ=1 D
 .. I '$$VAL(IEN) D  Q
 ... D MES^XPDUTL("Pay Rate Per cannot be converted for Case "_$$GET1^DIQ(2260,IEN,.01,"E")_" - "_$$GET1^DIQ(2260,IEN,167,"I"))
 ... S $P(^OOPS(2260,IEN,"CA1L"),U,2)="",PMSG=1
 .. S DA=IEN,DR="167///^S X=PAY"
 .. D:PAY]"" ^DIE
 D BMES^XPDUTL("Pay Rate Per Conversion complete.")
 Q
DICT NEW DIE,DA,DIC,X,DR,I
 K DES,CODE,MODCODE,NEWCODE
MODC F I=1:1 S MODCODE=$P($T(MODCODE+I),";;",2) Q:MODCODE=""  D
 . K DO,DD,DR
 . S (DIC,DIE)="^OOPS(2261.1,",DR=""
 . S DA=$P(MODCODE,";",3)
 . Q:'DA
 . S DES=$P(MODCODE,";",2),CODE=$P(MODCODE,";")
 . Q:($$GET1^DIQ(2261.1,DA,.01,"E")=DES)
 . S DR(1,2261.1,1)=".01////^S X=DES"
 . S DR(1,2261.1,2)="1////^S X=CODE"
 . D ^DIE
 K DES,CODE,MODCODE
NEWC F I=1:1 S NEWCODE=$P($T(NEWCODE+I),";;",2) Q:NEWCODE=""  D
 . S DIC="^OOPS(2261.1,",DIC(0)="LQZ",DLAYGO=2261.1
 . S X=$P(NEWCODE,";",2),CODE=$P(NEWCODE,";")
 . Q:$D(^OOPS(2261.1,"C",CODE))               ; don't set if code exists
 . S DIC("DR")="1////^S X=CODE"
 . K DO,DD D FILE^DICN K DLAYGO
 K CODE,DES,NEWCODE
 D BMES^XPDUTL("Table updates completed.")
 Q
 ;
MODCODE(LINE) ; MODIFY BODY PART DESCRIPTION AND CODE
 ;;BA;ABDOMEN;1
 ;;BC;CHEST;7
 ;;HF;FACE;11
 ;;CM;MOUTH;18
 ;;HK;NECK;19
 ;;CN;NOSE, INTERNAL;20
 ;;BZ;EXTERNAL, EXTERNAL, OTHER;21
 ;;RP;PELVIS;22
 ;;RB;RIB;23
 ;;CC;SKULL (CRANIAL BONES);25
 ;;BL;LOWER BACK/BUTTOCKS;29
 ;;
NEWCODE(LINE) ; ADD NEW BODY PART CODE AND DESCRIPTION
 ;;AB;BOTH ARMS AND/OR WRIST
 ;;AS;SINGLE ARM AND/OR WRIST
 ;;B1;SINGLE BREAST
 ;;B2;BOTH BREASTS
 ;;B3;SINGLE TESTICLE
 ;;B4;BOTH TESTICLES
 ;;BP;PENIS
 ;;BS;SIDE/FLANK
 ;;BU;UPPER BACK
 ;;BW;WAIST
 ;;C1;SINGLE EAR
 ;;C2;BOTH EARS
 ;;C3;SINGLE EYE
 ;;C4;BOTH EYES
 ;;CB;BRAIN
 ;;CD;TEETH
 ;;CJ;JAW, MANDIBLE
 ;;CL;LARYNX
 ;;CR;THROAT, OTHER
 ;;CT;TONGUE
 ;;CZ;HEAD, INTERNAL, OTHER
 ;;EB;BOTH ELBOWS
 ;;ES;SINGLE ELBOW
 ;;F1;SINGLE FIRST FINGER
 ;;F2;BOTH FIRST FINGERS
 ;;F3;SINGLE SECOND FINGER
 ;;F4;BOTH SECOND FINGERS
 ;;F5;SINGLE THIRD FINGER
 ;;F6;BOTH THIRD FINGERS
 ;;F7;SINGLE FOURTH FINGER
 ;;F8;BOTH FOURTH FINGERS
 ;;G1;SINGLE GREAT TOE
 ;;G2;BOTH GREAT TOES
 ;;G3;OTH/MULT TOE(S), SINGLE FOOT
 ;;G4;OTH/MUTL TOE(S), BOTH FEET
 ;;H1;SINGLE EYE (EXTERNAL)
 ;;H2;BOTH EYES (EXTERNAL)
 ;;H3;SINGLE EAR (EXTERNAL)
 ;;H4;BOTH EARS (EXTERNAL)
 ;;HC;CHIN
 ;;HM;LIPS
 ;;HN;NOSE
 ;;HS;SCALP
 ;;KB;BOTH KNEES
 ;;KS;SINGLE KNEE
 ;;LB;BOTH LEGS/HIPS/ANKLES/BUTTOCKS
 ;;LS;SINGLE LEG/HIP/ANKLE/BUTTOCK
 ;;MB;BOTH HANDS
 ;;MS;SINGLE HAND
 ;;PB;BOTH FEET
 ;;PS;SINGLE FOOT
 ;;R1;SINGLE CLAVICLE
 ;;R2;BOTH CLAVICLES
 ;;R3;SINGLE SCAPULA
 ;;R4;BOTH SCAPULAE
 ;;RS;STERNUM
 ;;RV;VERTEBRA (SPINE, SPINAL COL)
 ;;RZ;TRUNK BONE, OTHER
 ;;SB;BOTH SHOULDERS
 ;;SS;SINGLE SHOULDER
 ;;TB;BOTH THUMBS
 ;;TS;SINGLE THUMB
 ;;V1;SINGLE LUNG
 ;;V2;BOTH LUNGS
 ;;V3;SINGLE KIDNEY
 ;;V4;BOTH KIDNEYS
 ;;VH;HEART
 ;;VL;LIVER
 ;;VR;REPRODUCTIVE ORGANS
 ;;VS;STOMACH
 ;;VI;Intestines
 ;;VZ;TRUNK, INTERNAL, OTHER
 ;;L4;BOTH LOWER LEG/ANKLES
 ;;A1;SINGLE UPPER ARM
 ;;A2;BOTH UPPER ARMS
 ;;A3;SINGLE FOREARM
 ;;A4;BOTH FOREARMS
 ;;A5;SINGLE WRIST
 ;;A6;BOTH WRISTS
 ;;AZ;ARM(S), OTHER
 ;;AX;ARM(S), MULTIPLE SITES
 ;;FS;MULTIPLE FINGERS, SINGLE HAND
 ;;FB;MULTIPLE FINGERS, BOTH HANDS
 ;;L1;SINGLE HIP/THIGH
 ;;L2;BOTH HIPS/THIGHS
 ;;L3;SINGLE LOWER LEG/ANKLE
 ;;LZ;LEG(S), OTHER
 ;;LX;LEG(S), MULTIPLE SITES
 ;;HZ;HEAD, EXTERNAL, OTHER
 ;;HX;HEAD, EXTERNAL, MULTIPLE SITES
 ;;CK;BONES OF FACE, OTHER(S)
 ;;CS;SINUS (ES)
 ;;CX;HEAD, INTERNAL, MULTIPLE SITES
 ;;B5;VULVA/VAGINA
 ;;BX;TRUNK, EXTERNAL, MULT SITES
 ;;RC;RIBS, MULTIPLE
 ;;RX;TRUNK, MULTIPLE BONES
 ;;V5;BLADDER, URETHRA
 ;;VC;SPINAL CORD
 ;;VN;NERVE
 ;;VM;SPLEEN
 ;;VX;TRUNK, INTERNAL, MULT ORGANS
 ;;XX;MULTIPLE ANATOMICAL SITES
 ;;XZ;ANATOMIC SITE NOT MENTIONED
 ;;
 Q
