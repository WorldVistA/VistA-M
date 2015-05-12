LEXUH ;ISL/KER - Miscellaneous Lexicon Utilities (Help) ;12/19/2014
 ;;2.0;LEXICON UTILITY;**80,86**;Sep 23, 1996;Build 1
 ;               
EN ; Main Entry Point
 N %ZIS,ACT,ANS,CAL,CF,COM,CONT,CT,DIR,DIRB,DIROUT,DIRUT,DNC,DTOUT,DUOUT,ENT,EOP,EXEC,EXIT
 N HDR,HLP,I,ICR,IEN,INC,INT,ITEM,LAST,LC,LEN,LIN,LINE,LOC,MAX,MEN,NAM,NEXT,PAR,POP,PRE
 N RAN,ROOT,RTN,SEL,TAG,TEXT,TOT,TXT,TXT1,TXT2,TXT3,X,Y,ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ
 N ZTRTN,ZTSAVE,ZTSK K TEXT D MA W ! S ENT=$$ASK
 S MEN=$$TM($G(SEL(+ENT))) Q:'$L(MEN)  S LOC=$$TM($G(SEL(+ENT,"A"))),NAM=$$TM($G(SEL(+ENT,"C")))
 S ICR=$$TM($G(SEL(+ENT,"I"))) S:$L(ICR) ICR="(ICR "_ICR_")" S CAL=$$TM($G(SEL(+ENT,"X")))
 K TEXT D:ENT>0 OA D:$O(TEXT(0))>0 DHLP K TEXT,COM,SEL
 Q
 ;
DHLP ;   Display Help
 N %ZIS,CF,CONT,DNC,EOP,I,LC,ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK,POP
 S %ZIS("A")=" Device:  ",ZTRTN="DISP^LEXUH",ZTDESC="Display Lexicon API Help"
 S ZTIO=ION,ZTDTH=$H,%ZIS="Q",ZTSAVE("SEL(")="",ZTSAVE("ANS")="" W ! D ^%ZIS I POP K %ZIS("A") Q
 S ZTIO=ION I $D(IO("Q")) D QUE,^%ZISC,HOME^%ZIS K %ZIS("A") Q
 K %ZIS("A") D NOQUE Q
NOQUE ;   Do not queue Display
 W @IOF W:IOST["P-" !,"< Not queued, printing Lexicon API Help >",! U:IOST["P-" IO D @ZTRTN,^%ZISC,HOME^%ZIS Q
QUE ;   Task queued to print Help
 K IO("Q") D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued",1:"Request Cancelled"),! Q
 Q
DISP ; Display
 W:$L($G(IOF)) @IOF N LINE,LC,CF,CONT,EOP,EXIT S EXIT=0,EOP=+($G(IOSL))
 S:EOP=0 EOP=24 S EOP=EOP-2 S (LC,LINE)=0 F  S LINE=$O(TEXT(LINE)) Q:+LINE'>0  D  Q:EXIT
 . N TXT S TXT=$G(TEXT(LINE)) W !," ",TXT S CF=0 D LF
 I CF,EXIT>0 D EOP W:$L($G(IOF)) @IOF Q
 I 'CF D EOP W:$L($G(IOF)) @IOF
 Q
LF ;   Line Feed
 S LC=LC+1 D:IOST["P-"&(LC>(EOP-7)) EOP D:IOST'["P-"&(LC>(EOP-4)) EOP
 Q
EOP ;   End of Page
 N CONT S LC=0 W:IOST["P-" @IOF Q:IOST["P-"  W !! S CONT=$$CONT S CF=1
 Q
CONT(X) ;   Ask to Continue
 Q:+($G(EXIT))>0 "^^"  N DIR,DIROUT,DIRUT,DUOUT,DTOUT,Y S DIR(0)="EAO",DIR("A")=" Enter RETURN to continue or '^' to exit: "
 S DIR("PRE")="S:X[""?"" X=""??"" S:X[""^"" X=""^""",(DIR("?"),DIR("??"))="^D CONTH^LEXUH"
 D ^DIR S:X["^"!($D(DTOUT)) EXIT=1 Q:$D(DIROUT)!($D(DIRUT))!($D(DUOUT))!($D(DTOUT))!(X["^") "^"
 Q ""
CONTH ;      Ask to Continue Help
 W !,"     Enter either RETURN or '^'."
 Q
 ; 
ASK(X) ; Ask to Select an API
 Q:+($G(EXIT))>0 "^^"
 N IEN,ITEM,TOT,MAX,ENT,ANS,EXIT,LEN,ROOT,Y,INT S INT=" API Help available for:"
 S:$L($G(HDR)) INT=$G(HDR) S LEN=+($G(LEN)) S:+LEN'>0 LEN=10 S (MAX,ENT,ANS,EXIT)=0,U="^"
 S TOT=$O(SEL(" "),-1) G:+TOT=0 ASKQ S ANS=0 W:+TOT>1 !,INT
 S ENT=0 F  S ENT=$O(SEL(ENT)) Q:+ENT'>0  Q:((ANS>0)&(ANS'>ENT))  Q:EXIT  D  Q:EXIT
 . N ITEM,IEN,TEXT S (TEXT,ITEM)=$$TM($G(SEL(ENT))) Q:'$L(ITEM)
 . S MAX=ENT W:ENT#LEN=1 ! W !,$J(ENT,3),".  ",ITEM
 . W:TOT#LEN=0 ! S:ENT#LEN=0 ANS=$$ASKS(MAX,ENT) S:ANS["^" EXIT=1
 I TOT#LEN'=0,+ANS=0 W ! S ANS=$$ASKS(MAX,TOT) S:ANS["^" EXIT=1
 G ASKQ
 Q X
ASKS(MAX,ENT) ;   Select Multiple
 Q:+($G(EXIT))>0 "^^"
 N X,Y,LAST,NEXT,RAN,DIR,DTOUT,DUOUT,DIROUT,DIRUT,DIRB,HLP
 S MAX=+($G(MAX)),LAST=+($G(ENT)) Q:MAX'>0 -1
 S RAN=" Select 1-"_MAX_":  ",NEXT=$O(SEL(+LAST))
 S:+NEXT>0 DIR("A")=" Press <RETURN> for more, '^' to exit, or"_RAN
 S:+NEXT'>0 DIR("A")=RAN
 S HLP="    Answer must be from 1 to "_MAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??"""
 S (DIR("?"),DIR("??"))="^D ASKSH^LEXUH"
 S DIR(0)="NAO^1:"_MAX_":0" D ^DIR
 S:X["^^"!($D(DTOUT)) EXIT=1,X="^^"
 I X["^^"!(+($G(EXIT))>0) Q "^^"
 S Y=+Y S:$D(DTOUT)!(X["^") Y="^" K DIR
 Q Y
ASKSH ;   Select Multiple Help
 I $L($G(HLP)) W !,$G(HLP) Q
 Q
ASKQ ;   Quit Multiple
 Q:+($G(ANS))'>0 -1  S X=+($G(ANS))
 Q X
 ;
 ; Build Arrays
MA ;   Menu Array
 N MAX,TXT,LINE S MAX=0,TXT="" F LINE=1:1  D  Q:'$L(TXT)
 . N ACT,CAL,COM,CT,EXEC,ICR,LIN,PAR,PRE,RTN,TAG,TAGL,TXT1,TXT2,TXT3
 . S (TXT,TXT1,TXT2)="",EXEC="S TXT1=$T(APIS+"_LINE_"^LEXUH)" X EXEC
 . S TXT1=$TR($G(TXT1),"""",""),TXT=$P($G(TXT1),2) Q:'$L(TXT)
 . Q:'$L($P($G(TXT1),";;",3))  S TAG=$P($G(TXT1),";;",8),TAGL=$P($G(TXT1),";;",2)
 . S RTN=$P($G(TXT1),";;",3),ACT=$P($G(TXT1),";;",9),PAR=$P($G(TXT1),";;",10)
 . S LIN=$T(@(TAG_"^"_ACT)),ICR=$P($G(TXT1),";;",5),COM=$$TM($P(LIN,";",2,299))
 . S PRE=$P($G(TXT1),";;",7),CAL=$$TM($P(LIN,";",1))
 . S:CAL["(" CAL=$P(CAL,"(",1)_"^"_RTN_"("_$P(CAL,"(",2,299)
 . S:CAL'["(" CAL=CAL_"^"_RTN S:PRE["$$"&(CAL'["$$") CAL="$$"_CAL
 . Q:'$L(LIN)  Q:'$L(CAL)  Q:'$L(COM)
 . S TXT2=$P($G(TXT1),";;",7)_$S('$L($G(TAGL)):TAGL,1:TAG)_"^"_RTN_PAR
 . S TXT3=$P($G(TXT1),";;",11) S:$L(TXT2)>+(MAX) MAX=$L(TXT2)_"^"_TXT2
 . S TXT=TXT2,TXT=TXT_$J(" ",(43-$L(TXT)))_TXT3 S CT=$O(SEL(" "),-1)+1
 . S SEL(CT)=TXT,SEL(CT,"A")=TAG_"^"_ACT,SEL(CT,"I")=ICR,SEL(CT,"C")=COM,SEL(CT,"X")=CAL
 Q
OA ;   Output Array
 Q:'$L($G(LOC))  N TAG,RTN,COM,TXT,LINE,HDR S TAG=$P(LOC,"^",1),RTN=$P(LOC,"^",2)
 Q:'$L(TAG)  Q:'$L(RTN)  Q:'$L($$TM($T(@(TAG_"^"_RTN))))  Q:'$L(NAM)  Q:'$L(CAL)
 S:CAL="EN^LEXA1" CAL="^LEXA1" I $L($G(ICR)) S CAL=CAL_$J(" ",(65-$L(CAL)))_$G(ICR)
 S TEXT(1)=" "_CAL,TEXT(2)=" ",TEXT(3)=" "_NAM,TEXT(4)=" "
 S TXT="" F LINE=1:1  D  Q:'$L(TXT)
 . N EXEC,TXT2,TXT3,INC S (TXT,TXT2,TXT3)=""
 . S EXEC="S (TXT,TXT2)=$T("_TAG_"+"_LINE_"^"_RTN_")" X EXEC
 . S EXEC="S TXT3=$T("_TAG_"+"_(LINE+1)_"^"_RTN_")" X EXEC
 . S TXT2=$$TM(TXT2) I TXT2="Q"!(TXT2'[";") S TXT="" Q
 . S:TXT3'[";" TXT3="" S:TXT2[";" TXT2=" "_$P(TXT2,";",2,299)
 . I $L(TXT2),$L(TXT3) S INC=$O(COM(" "),-1)+1,COM(INC)=TXT2
 S LINE=0 F  S LINE=$O(COM(LINE)) Q:$L($$TM($G(COM(LINE))))  K COM(LINE)
 S LINE=999999 F  S LINE=$O(COM(LINE),-1) Q:$L($$TM($G(COM(LINE))))  K COM(LINE)
 S LINE=0 F  S LINE=$O(COM(LINE)) Q:+LINE'>0  D
 . N INC S INC=$O(TEXT(" "),-1)+1,TEXT(INC)=$G(COM(LINE))
 S LINE=$O(TEXT(" "),-1) S:+LINE>0 TEXT(0)=LINE
 K COM
 Q
 ; 
 ; Miscellaneous
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" " F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
APIS ;   List of APIs
 ;;LOOK;;LEXA;;"(LEXX,LEXAP,LEXLL,LEXSUB,DATE)";;2950;;1;;;;LOOK;;LEXA;;"(X,AP,LEN,SUB,CDT,SRC,CAT)";;Main Lexicon Lookup
 ;;;;LEXA1;;;;10006;;1;;;;EN;;LEXA1;;;;Lexicon Special Lookup
 ;;$$ICDSRCH;;LEX10CS;;"(TEXT,.ARRAY,DATE,LEN,FILTER)";;5681;;2;;$$;;ICDSRCH;;LEX10CS;;"(X,ARRAY,CDT,LEN,FIL)";;ICD-9/ICD-10 Diagnosis Lookup
 ;;$$DIAGSRCH;;LEX10CS;;"(TEXT,.ARRAY,DATE,LEN,FILTER)";;5681;;2;;$$;;DIAGSRCH;;LEX10CS;;"(X,ARRAY,CDT,LEN,FIL)";;ICD-10 Diagnosis Lookup
 ;;$$PCSDIG;;LEX10CS;;"(FRAG,DATE)";;5681;;2;;$$;;PCSDIG;;LEX10CS;;"(X,CDT)";;ICD-10 Procedure Lookup
 ;;$$CODELIST;;LEX10CS;;"(SYS,SPEC,SUB,DATE,LEN,FMT)";;5681;;2;;$$;;CODELIST;;LEX10CS2;;"(X,SPEC,SUB,CDT,LEN,FIL)";;Wild Card Code Lookup
 ;;CONFIG;;LEXSET;;"(LEXNS,LEXSS,DATE)";;1609;;1;;;;CONFIG;;LEXSET;;"(NS,SS,CDT)";;Setup Search Parameters
 ;;$$SC;;LEXU;;"(Y,STRING,DATE)";;5386;;1;;$$;;SC;;LEXU6;;"(IEN,SEM,CDT)";;Filter Search by Semantics
 ;;$$SO;;LEXU;;"(Y,STRING,DATE)";;5386;;1;;$$;;SO;;LEXU6;;"(IEN,SRC,CDT)";;Filter Search by Coding System
 ;;$$SCT;;LEXU;;"(Y,DATE)";;5679;;1;;$$;;SCT;;LEXU;;"(IEN,CDT)";;Filter by SNOMED CT (Human)
 ;;$$DX;;LEXU;;"(IEN,VDT)";;5679;;3;;$$;;DX;;LEXU;;"(IEN,CDT)";;Filter by Diagnosis System
 ;;$$ONE;;LEXU;;"(IEN,DATE,SAB)";;5679;;2;;$$;;ONE;;LEXU;;"(IEN,CDT,SAB)";;One Code for Source
 ;;$$ALL;;LEXU;;"(IEN,DATE,SAB)";;5679;;3;;$$;;ALL;;LEXU;;"(IEN,CDT,SAB)";;Get all Codes for a Source
 ;;$$CPTONE;;LEXU;;"(IEN,DATE)";;1573;;1;;$$;;CPTONE;;LEXU;;"(IEN,CDT)";;Get CPT Code
 ;;$$CPCONE;;LEXU;;"(IEN,DATE)";;1573;;3;;$$;;CPCONE;;LEXU;;"(IEN,CDT)";;Get HCPCS Code
 ;;$$ICDONE;;LEXU;;"(IEN,DATE)";;1573;;1;;$$;;ICDONE;;LEXU;;"(IEN,CDT)";;Get one ICD-9-CM Code
 ;;$$ICD;;LEXU;;"(IEN,DATE)";;1573;;3;;$$;;ICD;;LEXU;;"(IEN,CDT)";;Get all ICD-9-CM Codes
 ;;$$D10ONE;;LEXU;;"(IEN,DATE)";;5679;;3;;$$;;D10ONE;;LEXU;;"(IEN,CDT)";;Get one ICD-10-CM
 ;;$$D10;;LEXU;;"(IEN,DATE)";;5679;;3;;$$;;D10;;LEXU;;"(IEN,CDT)";;Get all ICD-10-CM Codes
 ;;$$P10ONE;;LEXU;;"(IEN,DATE)";;5679;;3;;$$;;P10ONE;;LEXU;;"(IEN,CDT)";;Get one ICD-10-PCS Code
 ;;$$DSMONE;;LEXU;;(IEN);;1573;;3;;$$;;DSMONE;;LEXU;;"(IEN,CDT)";;Get one DSM-IV Code
 ;;INFO;;LEXA;;"(IEN,DATE)";;1597;;3;;;;INFO;;LEXA;;"(X,CDT)";;Get Information about a Term
 ;;EN;;LEXCODE;;"(LEXSO,DATE)";;1614;;3;;;;EN;;LEXCODE;;"(SO,CDT)";;Get Terms associated with Code
 ;;$$HIST;;LEXU;;"(CODE,SYS,.ARY)";;5679;;2;;$$;;HIST;;LEXU4;;"(CODE,SYS,.ARY)";;Get Activation History
 ;;$$PERIOD;;LEXU;;"(CODE,SYS,ARY)";;5679;;2;;$$;;PERIOD;;LEXU4;;"(CODE,SYS,.ARY)";;Get Activation Periods
 ;;$$TAX;;LEX10CS;;"(TEXT,SRC,CDT,SUB,VER)";;5681;;2;;$$;;TAX;;LEX10TAX;;"(X,SRC,CDT,SUB,VER)";;Get Taxonomies
 ;;$$CSDATA;;LEXU;;"(CODE,CSYS,VDT,.ARY)";;5679;;2;;$$;;CSDATA;;LEXU2;;"(CODE,CSYS,CDT,ARY)";;Get Code Data
 ;;$$EXP;;LEXCODE;;"(CODE,SAB,DATE)";;5680;;3;;$$;;EXP;;LEXCODE;;"(SO,SAB,CDT)";;Get the Term for a Code
 ;;$$CAT;;LEXU;;(CODE);;5679;;2;;$$;;CAT;;LEX10DU;;(CODE);;Get ICD-10 Category
 ;;$$ISCAT;;LEXU;;(CODE);;5679;;2;;$$;;ISCAT;;LEX10DU;;(CODE);;Is an ICD-10 Code a Category
 ;;$$FREQ;;LEXU;;(TEXT);;5679;;2;;$$;;FREQ;;LEXU3;;(TEXT);;Get Frequency of Text
 ;;$$MAX;;LEXU;;(SYS);;5679;;2;;$$;;MAX;;LEXU3;;(SYS);;Maximum Number to Search
 ;;$$NXSAB;;LEXU;;"(SAB,REV)";;5679;;3;;$$;;NXSAB;;LEXU3;;"(SYS,REV)";;Get Next Source Abbrievation
 ;;$$PFI;;LEXU;;"(FRAG,CDT,.ARY)";;5679;;3;;$$;;PFI;;LEXU4;;"(FRAG,CDT,.ARY)";;Get Procedure Fragment Info
 ;;$$CSYS;;LEXU;;"(SYS)";;5679;;2;;$$;;CSYS;;LEXU5;;(SYS);;Get Coding System Info
 ;;$$IMPDATE;;LEXU;;(SAB);;5679;;2;;$$;;IMPDATE;;LEXU5;;(SYS);;Get System Implementation Date
 ;;$$LUPD;;LEXU;;"(SAB,DATE)";;5679;;3;;$$;;LUPD;;LEXU3;;"(SYS,CDT)";;Get System Last Updated
 ;;$$RUPD;;LEXU;;(SAB);;5679;;3;;$$;;RUPD;;LEXU3;;(SYS);;Get System Recent Update
 ;;$$CODE;;LEXTRAN;;"(CODE,SOURCE,DATE,ARRAY)";;4912;;3;;$$;;CODE;;LEXTRAN;;"(CODE,SRC,CDT,ARRAY)";;Get Concept for Code/Source
 ;;$$TEXT;;LEXTRAN;;"(TEXT,DATE,SUBSET,SOURCE,ARRAY)";;4913;;3;;$$;;TEXT;;LEXTRAN;;"(TEXT,CDT,SUB,SRC,ARRAY)";;Get Concept for Text/Source
 ;;$$TXT4CS;;LEXTRAN;;"(TEXT,SOURCE)";;4914;;3;;$$;;TXT4CS;;LEXTRAN;;"(TEXT,SRC,ARRAY,SUB)";;Is Text valid for an SCT code
 ;;$$VERSION;;LEXTRAN;;"(LEXSRC,LEXCODE,CDT)";;5011;;3;;$$;;VERSION;;LEXTRAN;;"(SRC,CODE,VDT)";;Get a Code's Version
 ;;$$GETASSN;;LEXTRAN1;;"(LEXCODE,LEXMAP,CDT,LEXRAY)";;5010;;3;;$$;;GETASSN;;LEXTRAN1;;"(CODE,MAP,CDT,ARRAY)";;Get Mapped Associations
 ;;$$GETFSN;;LEXTRAN1;;"(LEXSRC,LEXCODE,CDT)";;5007;;3;;$$;;GETFSN;;LEXTRAN1;;"(SRC,CODE,CDT)";;Get Fully Specified Name
 ;;$$GETPREF;;LEXTRAN1;;"(LEXSRC,LEXCODE,CDT)";;5008;;3;;$$;;GETPREF;;LEXTRAN1;;"(SRC,CODE,CDT)";;Get Preferred Term
 ;;$$GETSYN;;LEXTRAN1;;"(LEXSRC,LEXCODE,CDT,LEXRAY,LEXIENS)";;5006;;3;;$$;;GETSYN;;LEXTRAN1;;"(SRC,CODE,CDT,ARARY,IENS)";;Get Concept Synonyms
 ;;$$GETDES;;LEXTRAN1;;"(LEXSRC,LEXTEXT,CDT)";;5009;;3;;$$;;GETDES;;LEXTRAN1;;"(SRC,TEXT,CDT)";;Get Designation Code
 ;;EN;;LEX10CX;;;;5840;;4;;;;EN;;LEX10CX;;;;Get Suggested Code
 ;;EN2;;LEX10CX;;"(CODE,SAB)";;5840;;4;;;;EN2;;LEX10CX;;"(CODE,SYS)";;Get Suggested Code/Source
 ;;EN3;;LEX10CX;;"(CODE,SAB,.ARY,MAX)";;5840;;4;;;;EN3;;LEX10CX;;"(CODE,SYS,.ARY,MAX)";;Get Suggested Code (silent)
 ;;$$PAR;;LEXU;;"(TXT,.ARY)";;5679;;3;;$$;;PAR;;LEXU3;;"(TEXT,.ARY)";;Get Words from Text String
 ;;;;;;
