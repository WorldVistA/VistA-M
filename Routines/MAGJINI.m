MAGJINI ;;WIRMFO/JHC VistaRad Maintenance functions [ 07/07/1999  2:42 PM ]
 ;;3.0;IMAGING;;Mar 01, 2002
 ;990707--created routine
 ; Subroutines for VistaRad KIDS  inits
 ;
ENV ; "Environment Check" for KIDS Install
 Q
KOLDDD ; K ^DD(2006.631,3),^(4),^DD(2006.631,"B","SEARCH"),^DD(2006.631,"B","SEARCH2")
 ; K ^DD(2006.631,"GL",3),^(4),^DD(2006.631,"SB",2006.6313,3),^DD(2006.631,"SB",2006.6314,4)
 Q
MAG30T5A ; EP for KIDS PRE-Install init magj 3.0t5
 D PREFKIL
 Q
MAG30T5B ; EP for KIDS POST-Install init magj 3.0t5
 D B2006631,D2006631
 Q
MAG30T7A ; EP for KIDS PRE-Install init magj 3.0t7
 D BGCSTOP
 Q
MAG30T7B ; EP for KIDS POST-Install init magj 3.0t7
 D BGCSTRT
 Q
 ;
MAG30T8A ; EP for KIDS Pre-Install init magj 3.0t8
 ;D BGCSTOP
 Q
MAG30T8B ; EP for KIDS POST-Install init magj 3.0t8
 D B2006631,BGCSTRT
 Q
 ;
MG30T11A ; EP for KIDS Pre-Install init magj 3.0t11
 D BGCSTOP
 Q
MG30T11B ; EP for KIDS POST-Install init magj 3.0t11
 D BUILD72,B2006631,BGCSTRT
 Q
 ;
MG30T18A ; EP for KIDS Pre-Install init magj 3.0t18
 D INIT63
 Q
MG30T18B ; EP for KIDS POST-Install init magj 3.0t18
 D B2006631
 Q
 ;
BUILD72 ; copy Exam Status Category data to RAD file #72
 N IEN,CAT,RAIEN S IEN=0
 I $D(^MAG(2006.69,"FILE72")) Q  ; already did this
 F  S IEN=$O(^MAG(2006.61,IEN)) Q:'IEN  S X=$G(^(IEN,0)) D
 . I X S RAIEN=+X,CAT=$P(X,U,2) I CAT]"",("DETW"[CAT) D
 . . I '$D(^RA(72,RAIEN)) Q  ; should never occur, but . . .
 . . S DIE=72,DA=RAIEN,DR="9////"_CAT D ^DIE
 . . K DIE,DA,DR,DIC
 S ^MAG(2006.69,"FILE72")=$H
 Q
 ;
BGCSTOP ; Stop Background Compile program
 S MAGCSTRT=0,GO=1 K RETRY
 K ^MAG(2006.69,"KIDS")
 S X=$G(^MAG(2006.69,1,0))
 I X]"",$P(X,U,8) D
 . S ^MAG(2006.69,"KIDS")=X  ; save current settings for restore later
 . S MAGCSTRT=1
 . S $P(X,U,8)=0
 . S ^MAG(2006.69,1,0)=X  ; disable compile
 . W !!,*7,"Wait for Background Compile program to stop;"
 . W !,"     this might take up to a few minutes."
 . S NTRY=100
 . F I=1:1:NTRY L +^XTMP("MAGJ2","BKGND2","RUN"):3 I  Q
 . W !!,"Background Compile "
 . I  W "Stopped; proceed with install."  L -^XTMP("MAGJ2","BKGND2","RUN")
 . E  W "NOT Stopped -- Try again? Y// " D
 . . R X:120 S X=$TR($E(X),"ynYN","YNYN") S RETRY="Y"[X,GO=0
 . . S ^MAG(2006.69,1,0)=^MAG(2006.69,"KIDS") K ^MAG(2006.69,"KIDS")
 I 'GO G BGCSTOP:RETRY W !!,"Exiting out of Install" S XPDQUIT=1
 Q
BGCSTRT ; re-enable Background Compile
 I '$D(^MAG(2006.69,"KIDS")) Q  ; had not been enabled
 S ^MAG(2006.69,1,0)=^MAG(2006.69,"KIDS") K ^MAG(2006.69,"KIDS")
 W !!,"Background Compile Enabled again"
 Q
 ;
PREFKIL ; initialize the Prior Exams Logic File (Prefetch logic)
 I $D(^MAG(2006.65,0)) S X=^(0) D
 . S $P(X,U,3,4)="0^0"
 . K ^MAG(2006.65) S ^MAG(2006.65,0)=X
 Q
 ;
D2006631 ; Clean Up old vs List Definition file
 K DIU S DIU=2006.6313 S DIU(0)="DS" D EN^DIU2
 K DIU S DIU=2006.6314 S DIU(0)="DS" D EN^DIU2
 K DIU
 Q
 ;
INIT63 ; Initialize 2006.63 for re-create updated version
 ; This must always be followed by running B2006631
 K ^MAG(2006.63)
 Q
 ;
B2006631 ; Create "DEF" nodes, Button labels for updated List Def'ns
 N SS,LSTDAT,LSTNUM,BUTTON,LSTTYP
 S SS=0
 F  S SS=$O(^MAG(2006.631,SS)) Q:'SS  S LSTDAT=$G(^(SS,0)) I LSTDAT]"" D
 . S LSTNUM=$P(LSTDAT,U,2),BUTTON=$P(LSTDAT,U,7),LSTTYP=$P(LSTDAT,U,3)
 . I LSTNUM>9900!$P(LSTDAT,U,6) D BLDDEF^MAGJMN1(SS)  ; build DEF nodes for System Lists & any Enabled lists
 . I BUTTON="",(LSTTYP]"") D           ; Create Button Labels
 . . S BUTTON=$S(LSTTYP="U":"Unread #",LSTTYP="R":"Recent #",LSTTYP="A":"All Active #",LSTTYP="P":"Pending #",1:"List #")_LSTNUM
 . . S $P(^MAG(2006.631,SS,0),U,7)=BUTTON
 Q
END ;
