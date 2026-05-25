PSOSPMU0 ;BIRM/MFR - State Prescription Monitoring Program - Load ASAP Definition Utility ;10/07/12
 ;;7.0;OUTPATIENT PHARMACY;**451,625,772,797**;DEC 1997;Build 7
 ;
LOADASAP(VERSION,DEFTYPE,ASARRAY) ; Loads the ASAP definition array for the specific Version
 ; Input: (r) VERSION - ASAP Version (3.0, 4.0, 4.1, 4.2)
 ;        (r) DEFTYPE - ASAP Definition Type (S: Standard Only; C: Customized Only, B: Both) 
 ;Output: ASARRAY - Array containing the ASAP Hierarchical Segment Structure/ASAP Elements Definition
 ; 
 N ASAPDEF,FILEIEN,VER,VERIEN,SEGIEN,SEGNAM,ELMIEN,ELM0,ELMPOS,STAIEN,I
 ;
 I $G(VERSION)="" Q
 K ASARRAY,SEGINFO
 D SEGTREE(VERSION,DEFTYPE,"ASARRAY")
 F ASAPDEF="STANDARD ASAP DEFINITION","CUSTOM ASAP DEFINITION" D
 . I ASAPDEF="STANDARD ASAP DEFINITION",DEFTYPE="C" Q
 . I ASAPDEF="CUSTOM ASAP DEFINITION",DEFTYPE="S" Q
 . S FILEIEN=$O(^PS(58.4,"B",ASAPDEF,0))
 . F VER="ALL",VERSION D
 . . I VER="ALL",VERSION="4.1Z"!(VERSION="4.2Z")!(VERSION="4.2AZ")!(VERSION="4.2BZ")!(VERSION="5.0Z") Q    ;Zero Report doesn't load "ALL" 
 . . ; - Don't want to load default (ALL) definitions for entirely cloned ASAP versions
 . . I ASAPDEF="STANDARD ASAP DEFINITION",'$D(^PS(58.4,FILEIEN,"VER","B",VERSION)) Q
 . . S VERIEN=$O(^PS(58.4,FILEIEN,"VER","B",VER,0)) I 'VERIEN Q
 . . I VER'="ALL" S ASARRAY=$G(^PS(58.4,FILEIEN,"VER",VERIEN,0))
 . . I VER="ALL",$$VERZERO^PSOSPMU0(PSOASVER) Q   ; 772 - Don't load "ALL" if ZERO REPORT ASAP VERSION (#.05) indicates Zero Report
 . . S SEGIEN=0
 . . F  S SEGIEN=$O(^PS(58.4,FILEIEN,"VER",VERIEN,"SEG",SEGIEN)) Q:'SEGIEN  D
 . . . S SEGNAM=$P($G(^PS(58.4,FILEIEN,"VER",VERIEN,"SEG",SEGIEN,0)),"^")
 . . . S ELMIEN=0
 . . . F  S ELMIEN=$O(^PS(58.4,FILEIEN,"VER",VERIEN,"SEG",SEGIEN,"DAT",ELMIEN)) Q:'ELMIEN  D
 . . . . S ELM0=$G(^PS(58.4,FILEIEN,"VER",VERIEN,"SEG",SEGIEN,"DAT",ELMIEN,0))
 . . . . S ELMPOS=$P(ELM0,"^",5)
 . . . . ; - Retrieving Data Element Definition
 . . . . S ASARRAY(SEGNAM,ELMPOS)=ELM0
 . . . . ; - Data Element Description
 . . . . K ASARRAY(SEGNAM,ELMPOS,"DES")
 . . . . F I=1:1 Q:'$D(^PS(58.4,FILEIEN,"VER",VERIEN,"SEG",SEGIEN,"DAT",ELMIEN,"DES",I))  D
 . . . . . S ASARRAY(SEGNAM,ELMPOS,"DES",I)=$G(^PS(58.4,FILEIEN,"VER",VERIEN,"SEG",SEGIEN,"DAT",ELMIEN,"DES",I,0))
 . . . . ; - Data Element Value - Mumps SET Command Argument
 . . . . K ASARRAY(SEGNAM,ELMPOS,"VAL")
 . . . . F I=1:1 Q:'$D(^PS(58.4,FILEIEN,"VER",VERIEN,"SEG",SEGIEN,"DAT",ELMIEN,"VAL",I))  D
 . . . . . S ASARRAY(SEGNAM,ELMPOS,"VAL",I)=$G(^PS(58.4,FILEIEN,"VER",VERIEN,"SEG",SEGIEN,"DAT",ELMIEN,"VAL",I,0))
 . . . . ; - Customized ASAP Data Element Flagging
 . . . . I ASAPDEF="CUSTOM ASAP DEFINITION" D
 . . . . . S ASARRAY(SEGNAM,ELMPOS,"CUS")=1
 Q
 ;
SEGTREE(VERSION,DEFTYPE,ARRAY) ; Retrieve  Hierarchical (Tree) Segement Positioning Information for each ASAP Version
 ; Input: (r) VERSION - ASAP Version (e.g., "3.0", "4.2", etc.)
 ;        (r) DEFTYPE - ASAP Definition Type (S: Standard Only; C: Customized Only, B: Both) 
 ;Output: ARRAY - Array containing Segment Hierarchically formatted (tree)
 ;         Example: ARRAY(1)="TH"
 ;                  ARRAY(1,1)="IS"
 ;                  ARRAY(1,1,1)="PHA"
 ;                  ARRAY(1,1,1,1)="PAT"
 ;                  ARRAY(1,1,1,1,2)="DSP"
 ;                  ...
 ;                  ARRAY(1,1,2)="TP"
 ;                  ARRAY(2)="TT"
 N ASAPDEF,FILEIEN,VER,VERIEN,SEGIEN,SEG0,PARSEG,SEGPOS,SEGINFO
 ; Retrieving information about each Segment
 K @ARRAY
 F ASAPDEF="STANDARD ASAP DEFINITION","CUSTOM ASAP DEFINITION" D
 . I ASAPDEF="STANDARD ASAP DEFINITION",DEFTYPE="C" Q
 . I ASAPDEF="CUSTOM ASAP DEFINITION",DEFTYPE="S" Q
 . S FILEIEN=$O(^PS(58.4,"B",ASAPDEF,0))
 . F VER="ALL",VERSION D
 . . ; - Prevent loading default (ALL) definitions for entirely cloned ASAP versions
 . . I ASAPDEF="STANDARD ASAP DEFINITION",'$D(^PS(58.4,FILEIEN,"VER","B",VERSION)) Q
 . . S VERIEN=$O(^PS(58.4,FILEIEN,"VER","B",VER,0)) I 'VERIEN Q
 . . S SEGIEN=0
 . . F  S SEGIEN=$O(^PS(58.4,FILEIEN,"VER",VERIEN,"SEG",SEGIEN)) Q:'SEGIEN  D
 . . . S SEG0=$G(^PS(58.4,FILEIEN,"VER",VERIEN,"SEG",SEGIEN,0))
 . . . S PARSEG=$P(SEG0,"^",3)
 . . . S SEGPOS=+$P(SEG0,"^",5)
 . . . S SEGINFO($P(SEG0,"^"))=PARSEG_"^"_SEGPOS
 . . . S @ARRAY@($P(SEG0,"^"))=SEG0
 ; Building the Segment Tree
 D BLDTREE("",.SEGINFO,ARRAY)
 Q
 ;
BLDTREE(SEG,SEGINFO,ARRAY) ; Build the ASAP Segment Tree (Recursivity Used)
 ; Input: SEG - Initial Segment (Usually "" to build from the top of the tree)
 ;        SEGINFO - Segment Information Array (Parent & Position)
 ;Output: ARRAY - ASAP Segment Tree (See above for format)
 N SEGNAM
 S SEGNAM=""
 F  S SEGNAM=$O(SEGINFO(SEGNAM)) Q:SEGNAM=""  D
 . I $P(SEGINFO(SEGNAM),"^")'=SEG Q
 . S @ARRAY@($P(SEGINFO(SEGNAM),"^",2))=SEGNAM
 . D BLDTREE(SEGNAM,.SEGINFO,$Q(@ARRAY))
 Q
 ;
VERLIST(DEFTYPE,REGZERO,ARRAY) ; Return a list of ASAP Versions  ;Zero Report adding REGZERO
 ; Input: (r) DEFTYPE - ASAP Definition Type (D: Default Only; C: Customized Only, F: Fully Customized Only,
 ;                      A: All. A combination is also allowed, e.g., "CF") 
 ;        (r) REGZERO - Regular or Zero Report or Both ASAP Definitions (R: Regular Only; 
 ;                      Z: Zero Report Only; B: Both)
 ;Output:     ARRAY   - ASAP Version List (ARRAY("3.0")="S", ARRAY("4.0")="S", etc...)
 N STDIEN,CUSIEN,VERSION,CLONE   ; Standard CLONE PSO*7*772
 N VER,ZFLG    ;adding Zero Report flag
 K ARRAY S CLONE=""   ; Standard CLONE PSO*7*772
 S STDIEN=$O(^PS(58.4,"B","STANDARD ASAP DEFINITION",0))
 S CUSIEN=$O(^PS(58.4,"B","CUSTOM ASAP DEFINITION",0))
 I DEFTYPE["A"!(DEFTYPE["S") D
 . S VERSION="" F  S VERSION=$O(^PS(58.4,STDIEN,"VER","B",VERSION))  Q:VERSION=""  D
 . . I VERSION="ALL" Q
 . . S VER=$O(^PS(58.4,STDIEN,"VER","B",VERSION,0)) S ZFLG=$P($G(^PS(58.4,STDIEN,"VER",VER,0)),"^",5)
 . . I REGZERO["Z",'ZFLG Q    ;Zero ASAP only
 . . S CLONE=$$CLONE^PSOSPML3(VERSION)   ; PSO*7*772
 . . I REGZERO["R",ZFLG Q     ;ASAP only
 . . I REGZERO["B",ZFLG S ARRAY(VERSION_" ")="SZ",ARRAY(VERSION_" ","CLONE")=+$G(CLONE) Q   ;both ASAP and Zero ASAP
 . . S ARRAY(VERSION_" ")="S"
 . . S ARRAY(VERSION_" ","CLONE")=+$G(CLONE)   ; PSO*7*772
 I DEFTYPE["A"!(DEFTYPE["C")!(DEFTYPE["F") D
 . S VERSION="" F  S VERSION=$O(^PS(58.4,CUSIEN,"VER","B",VERSION))  Q:VERSION=""  D
 . . I $D(ARRAY(VERSION_" ")) Q    ;if customized Zero Report
 . . S VER=$O(^PS(58.4,CUSIEN,"VER","B",VERSION,0)) S ZFLG=$P($G(^PS(58.4,CUSIEN,"VER",VER,0)),"^",5)
 . . I REGZERO["Z",'ZFLG Q    ;Zero ASAP only
 . . I REGZERO["R",ZFLG Q     ;ASAP only
 . . I DEFTYPE["A"!(DEFTYPE["C"),$D(^PS(58.4,STDIEN,"VER","B",VERSION)) S ARRAY(VERSION_" ")="C"
 . . I DEFTYPE["A"!(DEFTYPE["C"),$D(^PS(58.4,STDIEN,"VER","B",VERSION)),ZFLG S ARRAY(VERSION_" ")="CZ"     ;Zero Rpt
 . . I DEFTYPE["A"!(DEFTYPE["F"),'$D(^PS(58.4,STDIEN,"VER","B",VERSION)) S ARRAY(VERSION_" ")="F"
 . . I DEFTYPE["A"!(DEFTYPE["F"),'$D(^PS(58.4,STDIEN,"VER","B",VERSION)),ZFLG S ARRAY(VERSION_" ")="FZ"    ;Zero Rpt
 Q
 ;
VERDATA(VERSION,DEFTYPE) ; Returns the ASAP Version fields
 ; Input: (r) VERSION - ASAP Version (e.g., "3.0", "4.2", etc.)
 ;        (r) DEFTYPE - ASAP Definition Type (S: Standard Only; C: Customized Only, B: Both) 
 ;Output: VERDATA - Sub-file #58.4001 0 node: "Version^Data Element Delimiter Char^Segment Terminator Char^..."
 N VERDATA,ASAPDEF,ASDEFIEN,VERIEN
 S VERDATA=""
 F ASAPDEF="STANDARD ASAP DEFINITION","CUSTOM ASAP DEFINITION" D
 . I ASAPDEF="STANDARD ASAP DEFINITION",DEFTYPE="C" Q
 . I ASAPDEF="CUSTOM ASAP DEFINITION",DEFTYPE="S" Q
 . S ASDEFIEN=$O(^PS(58.4,"B",ASAPDEF,0)) I 'ASDEFIEN Q
 . S VERIEN=$O(^PS(58.4,ASDEFIEN,"VER","B",VERSION,0)) I 'VERIEN Q
 . S VERDATA=$G(^PS(58.4,ASDEFIEN,"VER",VERIEN,0))
 Q VERDATA
 ;
VERZERO(PSOASVER)  ; 772 - Is Version PSOASVER a Zero Report?
 N VERIEN,ZERO
 Q:'$G(PSOASVER) 0
 S VERIEN=$O(^PS(58.4,1,"VER","B",PSOASVER,0)) Q:'VERIEN 0
 S ZERO=$P($G(^PS(58.4,1,"VER",VERIEN,0)),"^",5) Q:ZERO 1
 Q 0
 ;
 ;
VERSIONLOCKED(VERSEL) ; PSO*7*772 
 ; check to see if VERSION  is locked
 ; input - VERSEL = VERSION the end-user selected when
 ;                  executing the View/Edit ASAP Definitions option (e.g., 5.0)
 N PSOASDEF,PSOASIEN,PSOVER,PSOVERIEN,RETURN
 S (PSOVER,RETURN)=0
 F PSOASDEF="STANDARD ASAP DEFINITION","CUSTOM ASAP DEFINITION" D
 . Q:RETURN  ; already found the version
 . S PSOASIEN=$O(^PS(58.4,"B",PSOASDEF,0))
 . F  S PSOVER=$O(^PS(58.4,PSOASIEN,"VER","B",PSOVER)) Q:PSOVER=""  D
 . . I VERSEL=PSOVER S PSOVERIEN=$O(^PS(58.4,PSOASIEN,"VER","B",PSOVER,0)) D
 . . . I +$$GET1^DIQ(58.4001,PSOVERIEN_","_PSOASIEN,.07,"I") S RETURN=1
 Q RETURN
 ;
RESETELM(CUSIEN,VERIEN,SEGIEN,SEGID,ELMIEN,ELMID,ELMPOS,CUSASAP,STDASAP) ; Reset (Remove Customizations from) Data Element
 ; CUSIEN- IEN of the CUSTOM record name from the SPMP ASAP RECORD DEFINITIONS file (#58.4)
 ; VERIEN - IEN of the ASAP version from the VERSION sub-file (#58.4001) of the SPMP ASAP RECORD DEFINITIONS file (#58.4)
 ; SEGIEN -  IEN of the segment from the SEGMENT sub-file (#58.40011) of the VERSION sub-file of the SPMP ASAP RECORD DEFINITIONS file (#58.4)
 ; SEGID - NAME (#.01) field value of the segment in the SEGMENT sub-file (#58.40011) of the VERSION sub-file of the SPMP ASAP RECORD DEFINITIONS file (#58.4)
 ; ELMIEN - IEN of the element from the DATA ELEMENT sub-file (#58.400111) of the SEGMENT sub-file (#58.40011) of the VERSION sub-file of the SPMP ASAP RECORD DEFINITIONS file (#58.4)
 ; ELMID - NAME (#.01) field value of the element in the DATA ELEMENT sub-file (#58.400111) of the SEGMENT sub-file (#58.40011) of the VERSION sub-file of the SPMP ASAP RECORD DEFINITIONS file (#58.4)
 ; ELMPOS - Position of the Data Element within the segment 
 ; CUSASAP - Array of customizations from the CUSTOM ASAP DEFINITION node of the SPMP ASAP RECORD DEFINITIONS file (#58.4).
 ; STDASAP - Array of non-customized ASAP definition from the STANDARD ASAP DEFINITION node of the SPMP ASAP RECORD DEFINITIONS file (#58.4).
 ;
 N DIK,DA
 S DIK="^PS(58.4,"_CUSIEN_",""VER"","_VERIEN_",""SEG"","_SEGIEN_",""DAT"","
 S DA(3)=CUSIEN,DA(2)=VERIEN,DA(1)=SEGIEN,DA=ELMIEN D ^DIK I $G(ELMPOS) I $P($G(CUSASAP(SEGID,ELMPOS)),"^")=ELMID K CUSASAP(SEGID,ELMPOS)
 I '$O(CUSASAP(SEGID,"")),($G(CUSASAP(SEGID))=$G(STDASAP(SEGID))) D   ; No customized elements in this segment, no customizations in this segment, remove custom segment
 . S DIK="^PS(58.4,"_CUSIEN_",""VER"","_VERIEN_",""SEG"","
 . S DA(2)=CUSIEN,DA(1)=VERIEN,DA=SEGIEN D ^DIK
 . K CUSASAP(SEGID)
 Q
 ;
ELMDIFF(SEGID,ELMPOS,ELMDATA,EDEMAXL,EDEREQ,MEXPR,ASAPAR) ; Compare NEW and OLD arrays
 N EDENAME,EDEFMT,EDESLINE,EDESDIFF,ASAPLINE
 I '$L($G(SEGID)) Q 1
 I '$L($G(ELMPOS)) Q 1
 I '$L($G(ELMDATA)) Q 1
 S EDENAME=$P(ELMDATA,"^",2),EDEFMT=$P(ELMDATA,"^",3)
 I $G(EDENAME)'=$P(ASAPAR(SEGID,ELMPOS),"^",2) Q 1  ; Element name was changed
 I $G(EDEFMT)'=$P(ASAPAR(SEGID,ELMPOS),"^",3) Q 1   ; Data format was changed
 I $G(EDEMAXL)'=$P(ASAPAR(SEGID,ELMPOS),"^",4) Q 1  ; Max length was changed
 I $G(EDEREQ)'=$P(ASAPAR(SEGID,ELMPOS),"^",6) Q 1   ; Requirement was changed
 I $G(MEXPR)'=$G(ASAPAR(SEGID,ELMPOS,"VAL",1)) Q 1  ; (Return) Value was changed 
 ;
 ; Number of lines of edited Description text
 S EDESLINE="" S EDESLINE=$O(ELMDATA("DES",EDESLINE),-1)
 ;
 ; Number of lines of comparison array Description text
 S ASAPLINE="" S ASAPLINE=$O(ASAPAR(SEGID,ELMPOS,"DES",ASAPLINE),-1)
 ;
 ; Number of lines of Description text has changed, that's a change
 I ASAPLINE'=EDESLINE Q 1
 ;
 ; If same number of lines in Description, check for changes
 S EDESLINE=0 F  S EDESLINE=$O(ELMDATA("DES",EDESLINE)) Q:'EDESLINE!$G(EDESDIFF)  D
 . I ELMDATA("DES",EDESLINE)'=$G(ASAPAR(SEGID,ELMPOS,"DES",+$G(EDESLINE))) S EDESDIFF=1
 Q:$G(EDESDIFF) 1  ; Description has changed
 Q 0   ; Nothing has changed
 ;
ASKMEXPR(LEVEL,ELMID,MAXLEN,DEFAULT) ; Prompt for M SET Expression
 ;Input: (r) LEVEL   - Level of the Segment where the Data Element is located
 ;       (r) ELMID   - Data Element ID ("PHA01", "DSP02", etc.)
 ;       (r) MAXLEN  - Element ID value Maximum Length
 ;       (o) DEFAULT - Default value
 ;Output: M SET Expression or "^"
 N ASKMEXPR,DONE,ERROR
 S DONE=0,X=$G(DEFAULT)
 F  D  I DONE Q
 . S X=$G(DEFAULT) W !,"M SET EXPRESSION: "_$S(X'="":X_"// ",1:"")
 . R X:DTIME S:X="" X=$G(DEFAULT) I '$T!(X="^") S ASKMEXPR="^",DONE=1 Q
 . I X["?" W ! D MEXPRHLP^PSOSPML3(LEVEL,ELMID) W ! Q
 . I '$$VALID^PSOSPMU3(PSOASVER,X) W !,$P($$VALID^PSOSPMU3(PSOASVER,X),"^",2),$C(7),! Q
 . I '$$CHKVAR^PSOSPMU3(LEVEL,X) Q
 . D CHKCODE^PSOSPMU3(LEVEL,X,.ERROR) I ERROR Q
 . I $E(X,1)="""",$E(X,$L(X))="""",$E(X,2,$L(X)-1)'["""",$L(X)-2>MAXLEN D  Q
 . . W !,"The length cannot be longer than the maximum (",MAXLEN,").",$C(7),!
 . S ASKMEXPR=X,DONE=1
 Q ASKMEXPR
