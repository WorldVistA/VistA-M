RORUTL06 ;HCIOFO/SG - DEVELOPER ENTRY POINTS ; 11/20/05 5:09pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !,"CLINICAL CASE REGISTRIES DEVELOPER'S UTILITIES"
 S X=""
 S X=X_";M:Metadata definitions"
 S X=X_";V:Verify registry definition"
 S X=X_";P:Prepare for KIDS"
 S DIR(0)="SO^"_$P(X,";",2,999)
 D ^DIR  W !  Q:$D(DIRUT)
 G PRTMDE:Y="M",VERIFY:Y="V",DISTPREP:Y="P"
 Q
 ;
 ;***** VERIFIES REGISTRY DEFINITION
VERIFY ;
 N RORERRDL      ; Default error location
 N RORERROR      ; Error processing data
 N RORLOG        ; Log parameters
 N RORPARM       ; Application parameters
 ;
 N RC,REGLST,REGNAME,TMP
 W !,"REGISTRY DEFINITION VERIFIER",!
 D KILL^XUSCLEAN,INIT^RORUTL01("ROR")
 S RORPARM("DEBUG")=2
 S RORPARM("ERR")=1
 S RORPARM("LOG")=1
 F TMP=1:1:6  S RORPARM("LOG",TMP)=1
 D CLEAR^RORERR("START^RORUTL06")
 ;--- Select registries
 Q:$$SELREG^RORUTL07(.REGLST)'>0
 ;--- Validate registry update defintion
 S RC=$$UPDDEF(.REGLST)  G:RC<0 ERROR
 ;--- Validate data extraction defintion
 S RC=$$EXTDEF(.REGLST)  G:RC<0 ERROR
 ;--- Cleanup
 D INIT^RORUTL01("ROR")
 Q
 ;
 ;***** PREPARES THE REGISTRY FOR KIDS DISTRIBUTION
DISTPREP ;
 N RORERRDL      ; Default error location
 N RORERROR      ; Error processing data
 N RORFULL       ; Full installation (backpull, population, etc.)
 N RORPARM       ; Application parameters
 ;
 N IENS,FLD,FULL,RC,REGIEN,REGNAME,RORFDA,RORMSG
 N DA,DIR,DIRUT,DTOUT,DUOUT,X,Y
 W !,"REGISTRY PREPARATION FOR KIDS DISTRIBUTION",!
 D KILL^XUSCLEAN
 S RORPARM("ERR")=1
 D CLEAR^RORERR("DISTPREP^RORUTL06")
 ;--- Select a registry
 S RC=$$SELREG^RORUTL18(.REGNAME)  G:RC<0 ERROR
 Q:RC'>0  S REGIEN=RC
 ;--- Select the type of distribution
 K DIR  S DIR(0)="S^I:Installation;U:Update",DIR("B")="Update"
 S DIR("A")="Slect the type of distribution"
 D ^DIR  Q:$D(DIRUT)  W !
 S RORFULL=(Y="I")
 ;--- Request a confirmation
 K DIR  S DIR(0)="Y",DIR("B")="NO"
 S DIR("A",1)="Some fields of the '"_REGNAME_"' registry parameters"
 S DIR("A",2)="will be cleared to prepare them for KIDS distribution."
 S DIR("A")="Do you really want to do this"
 D ^DIR  Q:'$G(Y)  W !
 ;--- Clear Registry parameters (single-valued)
 S IENS=REGIEN_","
 F FLD=1,2,5,13,19.1,19.2,19.3,21.01,21.04,21.05  D
 . S RORFDA(798.1,IENS,FLD)="@"
 D FILE^DIE(,"RORFDA","RORMSG")
 G:$$DBS^RORERR("RORMSG",-9,,,798.1,IENS) ERROR
 ;--- Clear Registry parameters (multiples)
 S IENS=","_REGIEN_","
 G:$$CLEAR^RORUTL05(798.11,IENS)<0 ERROR  ; LOG EVENT (8.1)
 G:$$CLEAR^RORUTL05(798.114,IENS)<0 ERROR ; NOTIFICATION (14)
 G:$$CLEAR^RORUTL05(798.122,IENS)<0 ERROR ; LAST BATCH CONTROL ID (22)
 G:$$CLEAR^RORUTL05(798.128,IENS)<0 ERROR ; LOCAL LAB TEST (28)
 G:$$CLEAR^RORUTL05(798.129,IENS)<0 ERROR ; LOCAL DRUG (29)
 G:$$CLEAR^RORUTL05(798.12,IENS)<0 ERROR  ; REPORT STATS (30)
 ;--- Registry-specific data
 I REGNAME="VA HEPC"  G:$$HEPC(REGIEN)<0 ERROR
 I REGNAME="VA HIV"   G:$$HIV(REGIEN)<0 ERROR
 ;--- Clean the ROR LOCAL FIELD file (#799.53)
 G:$$LOCFLDS()<0 ERROR
 ;--- Success
 W !,"Registry parameters are ready for distribution."
 Q
 ;
 ;***** DISPLAYS THE ERRORS
ERROR ;
 D DSPSTK^RORERR()
 Q
 ;
 ;***** VALIDATES DATA EXTRACTION DEFINITION
 ;
 ; .REGLST       Reference to a local array containing
 ;               registry names as subscripts
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;
EXTDEF(REGLST) ;
 N RORERRDL      ; Default error location
 N ROREXT        ; Data extraction descriptor
 N RORHL         ; HL7 variables
 N RORLRC        ; List of codes of Lab results to be extracted
 ;
 N RC
 W !,"DATA EXTRACTION DEFINITION",!
 D CLEAR^RORERR("UPDDEF^RORUTL06")
 S RC=$$PREPARE^ROREXPR(.REGLST)
 D:RC'<0 DEBUG^ROREXTUT
 Q RC
 ;
 ;***** HEPC-SPECIFIC PREPARATIONS
HEPC(REGIEN) ;
 N IENS,RORFDA,RORMSG
 S IENS=(+REGIEN)_","
 D:$G(RORFULL)
 . S RORFDA(798.1,IENS,1)=2900101  ; REGISTRY UPDATED UNTIL
 . S RORFDA(798.1,IENS,2)=2850101  ; DATA EXTRACTED UNTIL
 S RORFDA(798.1,IENS,25)=1         ; ENABLE PROTOCOLS
 D FILE^DIE(,"RORFDA","RORMSG")
 Q $$DBS^RORERR("RORMSG",-9,,,798.1,IENS)
 ;
 ;***** HIV-SPECIFIC PREPARATIONS
HIV(REGIEN) ;
 N IENS,RORFDA,RORMSG
 S IENS=(+REGIEN)_","
 D:$G(RORFULL)
 . S RORFDA(798.1,IENS,1)=2850101  ; REGISTRY UPDATED UNTIL
 . S RORFDA(798.1,IENS,2)=2850101  ; DATA EXTRACTED UNTIL
 S RORFDA(798.1,IENS,25)=1         ; ENABLE PROTOCOLS
 D FILE^DIE(,"RORFDA","RORMSG")
 Q $$DBS^RORERR("RORMSG",-9,,,798.1,IENS)
 ;
 ;***** CLEANS THE 'ROR LOCAL FIELD' FILE (#799.53)
LOCFLDS() ;
 N DA,DIK,ROOT
 S DIK=$$ROOT^DILFD(799.53),ROOT=$$CREF^DILF(DIK)
 S DA=0
 F  S DA=$O(@ROOT@(DA))  Q:DA'>0  D ^DIK
 Q 0
 ;
 ;***** PRINTS THE DATA ELEMENT METADATA
PRTMDE ;
 N RORCOLS       ; Lits of column descriptors
 N RORERRDL      ; Default error location
 N RORERROR      ; Error processing data
 N RORLST        ; List of files grouped by parents
 N RORPAGE       ; Current page number
 N RORPARM       ; Application parameters
 N RORTTL        ; Title of the report
 ;
 N DIR,DIRUT,DTOUT,DUOUT,MODE,TMP,X,Y
 D KILL^XUSCLEAN
 S (DDBDMSG,RORTTL)="METADATA OF THE DATA ELEMENTS"
 W !,RORTTL,!  S RORPARM("ERR")=1
 D CLEAR^RORERR("PRTMDE^RORUTL06")
 ;---Request report sort mode from user
 S DIR(0)="S^H:Hierarhical;L:List of codes"
 S DIR("A")="Sort mode",DIR("B")="List of codes"
 D ^DIR  Q:$D(DIRUT)  S MODE=Y
 ;--- Generate and print the report
 I MODE="H"  S RC=0  D
 . N %ZIS,I,FILE,PARENT,ROOT,RORMSG
 . S ROOT=$$ROOT^DILFD(799.2,,1),RORPAGE=0
 . ;--- Load column descriptors
 . F I=1:1  S TMP=$P($T(PRTMDEH+I),";;",2)  Q:TMP=""  D
 . . S RORCOLS(I)=$TR($P(TMP,U,1,3)," ")_U_$P(TMP,U,4)
 . ;--- Load file list
 . S FILE=0,RC=0
 . F  S FILE=$O(@ROOT@(FILE))  Q:FILE'>0  D  Q:RC<0
 . . S PARENT=+$$GET1^DIQ(799.2,FILE_",",1,"I",,"RORMSG")
 . . I $G(DIERR)  D  Q
 . . . S RC=$$DBS^RORERR("RORMSG",-9,,,799.2,FILE_",")
 . . S RORLST(PARENT,FILE)=""
 . Q:RC<0
 . ;--- Print the report
 . S %ZIS("B")=""
 . D ^%ZIS   Q:$G(POP)  U IO
 . S RC=$$PRTMDEH()  S:RC'<0 RC=$$PRTMDE1(0,1)
 . D ^%ZISC
 E  S RC=$$PRTMDE2()
 G:RC<0 ERROR
 Q
 ;
 ;***** PRINTS A LEVEL OF THE "FILE-PROCESSING TREE"
 ;
 ; PARENT        Parent file number
 ; LEVEL         Number of the current level in the tree
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;
PRTMDE1(PARENT,LEVEL) ;
 N FIELDS,FILE,FLD,I,IENS,IR,L,RORBUF,RORMSG
 S FIELDS="@;.01E;.02I;1I;2E;4I;4.1;4.2;6I"
 ;---
 S FILE="",RC=0
 F  S FILE=$O(RORLST(PARENT,FILE))  Q:FILE=""  D  Q:RC<0
 . ;--- Load descriptors of the data elements
 . K RORBUF  S IENS=","_FILE_","
 . D LIST^DIC(799.22,IENS,FIELDS,,,,,"B",,,"RORBUF","RORMSG")
 . ;--- Print header (if necessary) and file number
 . I ($Y+5)>IOSL  S RC=$$PRTMDEH()  Q:RC<0
 . D PRTMDEL(LEVEL-1),PRTMDEL(LEVEL-1,FILE)
 . ;--- Print data element descriptors
 . S IR="",RC=0
 . F  S IR=$O(RORBUF("DILIST","ID",IR))  Q:IR=""  D  Q:RC<0  W !
 . . I ($Y+5)>IOSL  S RC=$$PRTMDEH()  Q:RC<0
 . . D:IR>1 PRTMDEL(LEVEL,"")
 . . S I=""
 . . F  S I=$O(RORCOLS(I))  Q:I=""  D
 . . . S FLD=+$P(RORCOLS(I),U,2)  Q:FLD'>0
 . . . S L=+$P(RORCOLS(I),U,3)  S:L'>0 L=999
 . . . W ?(+RORCOLS(I)),$E($G(RORBUF("DILIST","ID",IR,FLD)),1,L)
 . Q:RC<0
 . S:$D(RORLST(FILE))>1 RC=$$PRTMDE1(FILE,LEVEL+1)
 Q $S(RC<0:RC,1:0)
 ;
 ;***** PRINTS A TABLE OF DATA ELEMENTS
PRTMDE2() ;
 N BY,DHD,FR,L,DIC,FLDS,TO
 S L=0,DIC=799.2,DHD=RORTTL
 S BY="[ROR DATA ELEMENTS]",FLDS="[ROR DATA ELEMENTS]"
 D EN1^DIP
 Q 0
 ;
 ;***** PRINTS A HEADER OF THE DATA ELEMENT REPORT
 ;  X  Field Width Title
PRTMDEH() ;
 ;;  0^     ^     ^File
 ;; 22^  .01^   25^Data Name
 ;; 49^  .02^     ^Code
 ;; 55^ 2   ^     ^Req
 ;; 60^ 1   ^     ^API
 ;; 65^ 6   ^     ^Field Number
 ;; 82^ 4   ^     ^VT
 ;; 86^ 4.1 ^   20^External
 ;;108^ 4.2 ^   20^Internal
 ;
 N DIR,DIRUT,DTOUT,DUOUT,I,X,Y
 I RORPAGE,$E(IOST,1,2)="C-"  D  Q:'Y $S(Y="":-72,1:-71)
 . S DIR(0)="E"  D ^DIR
 W:RORPAGE!($E(IOST,1,2)="C-") @IOF
 S RORPAGE=RORPAGE+1,I=""  W RORTTL,!
 F  S I=$O(RORCOLS(I))  Q:I=""  W ?(+RORCOLS(I)),$P(RORCOLS(I),U,4)
 S X="",$P(X,"-",IOM)=""
 W !,X,!
 Q 0
 ;
 ;***** PRINTS THE LEVEL INDICATOR
 ;
 ; N             Number of dots in the indicator
 ; [FILE]        File number
 ;
PRTMDEL(N,FILE) ;
 N I  W:$X>0 !  F I=1:1:N  W ". "
 W:$D(FILE) FILE  W:'$D(FILE) !
 Q
 ;
 ;***** VALIDATES REGISTRY UPDATE DEFINITION
 ;
 ; .REGLST       Reference to a local array containing
 ;               registry names as subscripts
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;
UPDDEF(REGLST) ;
 N RORERRDL      ; Default error location
 N RORLRC        ; List of Lab result codes to check
 N RORUPD        ; Update descriptor
 N RORUPDPI      ; Closed root of the temporary storage
 N RORVALS       ; Calculated values
 ;
 N RC
 W !,"REGISTRY UPDATE DEFINITION",!
 D CLEAR^RORERR("UPDDEF^RORUTL06")
 S RORUPDPI=$NA(^TMP("RORUPD",$J))
 S RC=$$PREPARE^RORUPR(.REGLST)
 D:RC'<0 DEBUG^RORUPDUT
 Q RC
