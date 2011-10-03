PXRMDLFI ; SLC/PKR - Handle Reminder dialog findings. ;06/08/2009
 ;;2.0;CLINICAL REMINDERS;**12**;Feb 04, 2005;Build 73
 ;
 ;=================================================
DISP(IEN,SC) ;Display findings and additional findings.
 ;Called from print template PXRM DIALOG ELEMENT. SC is the starting
 ;column for the display.
 N ABBR,FI,FIEN,FMTSTR,GBL,IND,JND,NAME,NL,OUTPUT,TEXT,VPLIST
 ;Finding output
 ;This is the full calculation S FMTSTR=SC_"R2^2L1^"_(72-SC-4)_"L"
 S FMTSTR=SC_"R2^2L1^"_(68-SC)_"L"
 S FI=$P($G(^PXRMD(801.41,IEN,1)),U,5)
 I FI'="" D
 .;Get the variable pointer list.
 . D BLDRLIST^PXRMVPTR(801.41,15,.VPLIST)
 . S FIEN=$P(FI,";",1)
 . S GBL=$P(FI,";",2)
 . S ABBR=$P(VPLIST(GBL),U,4)
 . S NAME=$P($G(@(U_GBL_FIEN_",0)")),U,1)
 . S TEXT="Finding Item:"_U_ABBR_U_NAME
 I FI="" S TEXT="Finding Item:"_"^none"
 D COLFMT^PXRMTEXT(FMTSTR,TEXT," ",.NL,.OUTPUT)
 F IND=1:1:NL W !,OUTPUT(IND)
 ;
 ;Additional findings
 ;This is the full calculation S FMTSTR=SC_"R2^4L1^"_(72-SC-13)_"L^9L1^3R"
 S FMTSTR=SC_"R2^4L1^"_(59-SC)_"L^9L1^3R"
 S TEXT="Additional Findings:"
 I '$D(^PXRMD(801.41,IEN,3)) S TEXT=TEXT_U_"none"
 D COLFMT^PXRMTEXT(FMTSTR,TEXT," ",.NL,.OUTPUT)
 F IND=1:1:NL W !,OUTPUT(IND)
 I '$D(^PXRMD(801.41,IEN,3)) Q
 ;Get the variable pointer list.
 K VPLIST
 D BLDRLIST^PXRMVPTR(801.4118,.01,.VPLIST)
 S JND=0
 F  S JND=+$O(^PXRMD(801.41,IEN,3,JND)) Q:JND=0  D
 . S FI=^PXRMD(801.41,IEN,3,JND,0)
 . S FIEN=$P(FI,";",1)
 . S GBL=$P(FI,";",2)
 . S ABBR=$P(VPLIST(GBL),U,4)
 . S NAME=$P($G(@(U_GBL_FIEN_",0)")),U,1)
 . S TEXT=U_ABBR_U_NAME_U_"Finding #"_U_JND
 . D COLFMT^PXRMTEXT(FMTSTR,TEXT," ",.NL,.OUTPUT)
 . F IND=1:1:NL W !,OUTPUT(IND)
 Q
 ;
 ;=================================================
INPUT(IEN) ;Input finding and additional findings.
 ;Called from input template PXRM EDIT ELEMENT
 N ABBR,FI,FIEN,FMTSTR,GBL,IND,JND,NL,OUTPUT,SAVEFI,TEXT,VPLIST
 ;Protect FileMan variables
 N D,D0,DA,DC,DE,DG,DH,DI,DIC,DIDEL,DIE,DIEDA,DIEL,DIEN,DIETMP
 N DIEXREF,DIFLD,DIEIENS,DINUSE,DIP,DISYS,DK,DL,DM,DP,DQ,DR,DU
 N X,Y
 S FI=$P($G(^PXRMD(801.41,IEN,1)),U,5)
 I FI'="" D
 .;Get the variable pointer list.
 . D BLDRLIST^PXRMVPTR(801.41,15,.VPLIST)
 . S FIEN=$P(FI,";",1)
 . S GBL=$P(FI,";",2)
 . S ABBR=$P(VPLIST(GBL),U,4)
 . S NAME=$P($G(@(U_GBL_FIEN_",0)")),U,1)
 . S FMTSTR="13L1^2L1^60L"
 . S TEXT="Finding item:"_U_ABBR_U_NAME
 . D COLFMT^PXRMTEXT(FMTSTR,TEXT," ",.NL,.OUTPUT)
 . F IND=1:1:NL W !,OUTPUT(IND)
 S DIE="^PXRMD(801.41,"
 S DA=IEN,DR=15
 D ^DIE
 I $D(Y) Q U
 S SAVEFI=X
 I $P(X,";",2)="YTT(601.71," D MHLICR(+X)
 ;
 ;Additional findings.
 S FMTSTR="4L1^60L1^9L1^3R"
 ;Get the variable pointer list.
 K VPLIST
 D BLDRLIST^PXRMVPTR(801.4118,.01,.VPLIST)
 ;Setup DA(1) for additional findings.
 K DA S DA(1)=IEN
AFLIST W !!,"Additional findings:"
 I '$D(^PXRMD(801.41,IEN,3,"B")) W " none"
 S JND=0
 F  S JND=+$O(^PXRMD(801.41,IEN,3,JND)) Q:JND=0  D
 . S FI=^PXRMD(801.41,IEN,3,JND,0)
 . S FIEN=$P(FI,";",1)
 . S GBL=$P(FI,";",2)
 . S ABBR=$P(VPLIST(GBL),U,4)
 . S NAME=$P($G(@(U_GBL_FIEN_",0)")),U,1)
 . S TEXT=ABBR_U_NAME_U_"Finding #"_U_JND
 . D COLFMT^PXRMTEXT(FMTSTR,TEXT," ",.NL,.OUTPUT)
 . F IND=1:1:NL W !,OUTPUT(IND)
 ;Edit, if done quit,if not go back to AFLIST.
 S DIC="^PXRMD(801.41,"_IEN_",3,"
 S DIC(0)="AELQ"
 S DIC("A")="Select ADDITIONAL FINDING: "
 S DIC("P")=$P(^DD(801.41,18,0),U,2)
 D ^DIC
 I $G(DUOUT) Q U
 I Y=-1 Q SAVEFI
 S DIE=DIC K DIC
 S DIE("NO^")="OUTOK"
 S DA=+Y,GBL=$P($P(Y,U,2),";",2) Q:GBL=""
 S DR=".01"
 W !!,"Editing Finding Number: "_$G(DA)
 D ^DIE
 I $D(Y) Q U
 S $P(^PXRMD(801.41,IEN,3,0),U,3)=0
 I $D(Y) Q SAVEFI
 ;Check if deleted
 I '$D(DA) Q SAVEFI
 G AFLIST
 Q
 ;
 ;=================================================
MHLICR(IEN) ;Check to see if mental health licensing is required.
 ;DBIA #5042
 I $$RL^YTQPXRM3(IEN)="Y" D
 . W !,"This MH test requires a license."
 . W !,"The question text will not appear in the progress note.",!
 . H 1
 Q
