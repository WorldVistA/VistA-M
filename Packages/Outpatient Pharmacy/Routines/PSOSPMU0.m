PSOSPMU0 ;BIRM/MFR - State Prescription Monitoring Program - Load ASAP Definition Utility ;10/07/12
 ;;7.0;OUTPATIENT PHARMACY;**451**;DEC 1997;Build 114
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
 . . ; - Don't want to load default (ALL) definitions for entirely cloned ASAP versions
 . . I ASAPDEF="STANDARD ASAP DEFINITION",'$D(^PS(58.4,FILEIEN,"VER","B",VERSION)) Q
 . . S VERIEN=$O(^PS(58.4,FILEIEN,"VER","B",VER,0)) I 'VERIEN Q
 . . I VER'="ALL" S ASARRAY=$G(^PS(58.4,FILEIEN,"VER",VERIEN,0))
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
VERLIST(DEFTYPE,ARRAY) ; Return a list of ASAP Versions
 ; Input: (r) DEFTYPE - ASAP Definition Type (D: Default Only; C: Customized Only, F: Fully Customized Only,
 ;                      A: All. A combination is also allowed, e.g., "CF") 
 ;Output:     ARRAY   - ASAP Version List (ARRAY("3.0")="S", ARRAY("4.0")="S", etc...)
 N STDIEN,CUSIEN,VERSION
 K ARRAY
 S STDIEN=$O(^PS(58.4,"B","STANDARD ASAP DEFINITION",0))
 S CUSIEN=$O(^PS(58.4,"B","CUSTOM ASAP DEFINITION",0))
 I DEFTYPE["A"!(DEFTYPE["S") D
 . S VERSION="" F  S VERSION=$O(^PS(58.4,STDIEN,"VER","B",VERSION))  Q:VERSION=""  D
 . . I VERSION="ALL" Q
 . . S ARRAY(VERSION_" ")="S"
 I DEFTYPE["A"!(DEFTYPE["C")!(DEFTYPE["F") D
 . S VERSION="" F  S VERSION=$O(^PS(58.4,CUSIEN,"VER","B",VERSION))  Q:VERSION=""  D
 . . I DEFTYPE["A"!(DEFTYPE["C"),$D(^PS(58.4,STDIEN,"VER","B",VERSION)) S ARRAY(VERSION_" ")="C"
 . . I DEFTYPE["A"!(DEFTYPE["F"),'$D(^PS(58.4,STDIEN,"VER","B",VERSION)) S ARRAY(VERSION_" ")="F"
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
