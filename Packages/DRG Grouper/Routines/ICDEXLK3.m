ICDEXLK3 ;SLC/KER - ICD Extractor - Lookup, Search ;12/19/2014
 ;;18.0;DRG Grouper;**57,67**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^ICDS(              N/A
 ;    ^ICDS("F"           N/A
 ;    ^TMP(ID,$J,         SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables Newed or Killed by calling application
 ;     DIC(0)    Fileman Lookup Parameters
 ;  
LK(TXT,ROOT,CDT,SYS,VER,OUT) ; Lookup - Versioned
 ;
 ; Input 
 ; 
 ;   TXT    Text to Search for (Required)
 ;   
 ;             Diagnosis or Procedure Code
 ;             Diagnosis or Procedure Descriptive Text
 ;             
 ;   ROOT   Global Root/File # to Search (Fileman DIC, Required)
 ;   
 ;             ^ICD9(
 ;             ^ICD0(
 ;             
 ;   CDT    Date (default = TODAY) (Optional)
 ;   
 ;   SYS    Coding System (Optional but encouraged)
 ;   
 ;              1      ICD-9-CM
 ;              2      ICD-9 Proc
 ;             30      ICD-10-CM
 ;             31      ICD-10-PCS
 ;
 ;   VER    Versioned Lookup
 ;   
 ;             0  No, include all codes, active and inactive
 ;             1  Yes, include only Active codes for date CDT
 ;
 ;   OUT    Output Format
 ;   
 ;             1  Fileman, Code and Short Text (default)
 ;             
 ;                250.00    DMII CMP NT ST UNCNTR
 ;                
 ;             2  Fileman, Code and Description
 ;             
 ;                250.00    DIABETES MELLITUS NO MENTION OF
 ;                          COMPLICATION, TYPE II OR UNSPECIFIED
 ;                          TYPE, NOT STATED AS UNCONTROLLED
 ;                          
 ;             3  Lexicon, Short Text and Code
 ;             
 ;                DMII CMP NT ST UNCNTR (250.00)
 ;                
 ;             4  Lexicon, Description and Code
 ;             
 ;                DIABETES MELLITUS NO MENTION OF 
 ;                COMPLICATION, TYPE II OR UNSPECIFIED TYPE,
 ;                NOT STATED AS UNCONTROLLED (250.00)
 ;             
 ; Output (if successful)
 ; 
 ;   $$LK  Number of entries found
 ;   
 ;   Global Array of entries found:
 ; 
 ;      ^TMP(ID,$J,"SEL")
 ;      ^TMP(ID,$J,"SEL",0)=# of entries
 ;      ^TMP(ID,$J,"SEL",#)=IEN^Display Text
 ;   
 ;         where ID is a package namespaced subscript:
 ;        
 ;           ICD9 - for the Diagnosis file #80
 ;           ICD0 - for the Operations/Procedure file #80.1
 ;               
 ; Local Variables used but Newed or Killed Elsewhere
 ; 
 ;     DIC(0)
 ;     
 Q $$LK2
 Q
CD(TXT,ROOT,CDT,SYS,VER,OUT) ; Lookup Code - Versioned
 N ICDBYCD S ICDBYCD="" S TXT=$$TM(TXT)
 Q $$LK2
 Q
LK2() ; Lookup - Part 2
 N FILE,IEN,INP1,INP2,KEY,SUB,NUM,NXT,OK,ORD,SEQ,TDT,VCC,VCD,VDS,VSD,VST,PR,PARS,LOR,VII,VNM,Y
 S TXT=$$TM($TR($G(TXT),"#"," ")) Q:'$L(TXT) 0  S ROOT=$$ROOT^ICDEX($G(ROOT)) Q:'$L(ROOT) 0
 S FILE=$$FILE^ICDEX(ROOT) Q:"^80^80.1^"'[("^"_FILE_"^") 0
 S SUB=$TR(ROOT,"^(","") Q:'$L(SUB) 0  K ^TMP(SUB,$J) S CDT=$$CDT($G(CDT))
 S SYS=$S($L($G(SYS)):$$SYS^ICDEX($G(SYS)),1:""),VER=+($G(VER))
 S:+($G(SYS))'>0&(CDT?7N)&(+VER>0) SYS=$$SYS(ROOT,CDT)
 S:$D(^ICDS(+SYS,0))&(+VER>0) CDT=$$DTBR^ICDEX(CDT,,+($G(SYS)))
 S OUT=$G(OUT) S:+OUT'>0 OUT=1 S:+OUT>4 OUT=1
 S INP1=$E(TXT,1),INP2=$E($G(TXT),2,245)
 Q:$D(^TMP(SUB,$J)) +($G(^TMP(SUB,$J,"SEL",0)))
 ;   Exact Match
 I $L(TXT) D
 . N ICDI,LOR K Y,X S LOR=0,X=$$EXM^ICDEXLK5(TXT,ROOT,.Y,CDT,SYS,VER)
 . S ICDI=0 F  S ICDI=$O(Y(ICDI)) Q:+ICDI'>0  D
 . . N IEN S IEN=+($G(Y(ICDI))) Q:+IEN'>0  D FND^ICDEXLK5(ROOT,IEN,CDT,SYS,VER,+($G(LOR)),OUT)
 . I $G(DIC(0))'["A",$G(DIC(0))["O" D
 . . N ENT,TXT,IEN S ENT=$O(^TMP(SUB,$J,"FND",0)) Q:+ENT'>0
 . . S TXT=$G(^TMP(SUB,$J,"FND",+ENT,1)) Q:'$L(TXT)  S IEN=+($P(TXT,"^",1)) Q:+IEN'>0
 . . K ^TMP(SUB,$J,"FND",ENT,1),^TMP(SUB,$J,"FND","IEN",+IEN)
 . . S ^TMP(SUB,$J,"FND",1,1)=TXT,^TMP(SUB,$J,"FND","IEN",+IEN)=""
 I $G(DIC(0))["X" D SEL^ICDEXLK5(ROOT,+($G(LOR))) Q:+($G(^TMP(SUB,$J,"SEL",0)))>0 +($G(^TMP(SUB,$J,"SEL",0)))
 ;   By Code
 D:$L(TXT)'>8&($$ISCODE(TXT,ROOT)>0) CODE
 Q:+($G(^TMP(SUB,$J,"SEL",0)))>0 +($G(^TMP(SUB,$J,"SEL",0)))
 ;   By Text
 D TXT^ICDEXLK4
 Q +($G(^TMP(SUB,$J,"SEL",0)))
 ;
CODE ;   Lookup by Code (Requires TXT and ROOT)
 Q:'$L($G(TXT))  Q:'$L($G(ROOT))  Q:$L(TXT)>8  Q:$G(DIC(0))["B"
 Q:$$ISCODE($G(TXT),$G(ROOT))'>0
 S CDT=$$CDT($G(CDT)) N KEY,ORD,PRV,EROOT
 S KEY=TXT,PRV=+($G(^TMP(SUB,$J,"SEL",0)))
 S ORD=$E(KEY,1,($L(KEY)-1))_$C(($A($E(KEY,$L(KEY)))-1))_"~ "
 S EROOT=ROOT_"""BA""," S:+($G(SYS))>0&($D(@(ROOT_"""ABA"","_+($G(SYS))_")"))) EROOT=ROOT_"""ABA"","_+($G(SYS))_","
 F  S ORD=$O(@(EROOT_""""_ORD_""")")) Q:'$$ISORD  D
 . S IEN=0 I $G(DIC(0))["X",ORD'=KEY Q
 . F  S IEN=$O(@(EROOT_""""_ORD_""","_+IEN_")")) Q:+IEN'>0  D
 . . N STA S STA=1 S:VER>0 STA=$$LS(ROOT,IEN,CDT)
 . . Q:+($G(VER))>0&(+STA'>0)
 . . I $G(DIC(0))'["A",$G(DIC(0))["O",ORD=KEY S CNT=CNT+1 Q:CNT>1
 . . D FND^ICDEXLK5(ROOT,IEN,CDT,$G(SYS),$G(VER),1,OUT)
 I '$D(^TMP(SUB,$J,"FND","IEN")) D
 . S KEY=$$UP^XLFSTR(TXT),PRV=+($G(^TMP(SUB,$J,"SEL",0)))
 . S ORD=$E(KEY,1,($L(KEY)-1))_$C(($A($E(KEY,$L(KEY)))-1))_"~ "
 . S EROOT=ROOT_"""BA""," S:+($G(SYS))>0&($D(@(ROOT_"""ABA"","_+($G(SYS))_")"))) EROOT=ROOT_"""ABA"","_+($G(SYS))_","
 . F  S ORD=$O(@(EROOT_""""_ORD_""")")) Q:'$$ISORD  D
 . . S IEN=0 I $G(DIC(0))["X",ORD'=KEY Q
 . . F  S IEN=$O(@(EROOT_""""_ORD_""","_+IEN_")")) Q:+IEN'>0  D
 . . . N STA S STA=1 S:VER>0 STA=$$LS(ROOT,IEN,CDT)
 . . . Q:+($G(VER))>0&(+STA'>0)
 . . . I $G(DIC(0))'["A",$G(DIC(0))["O",ORD=KEY S CNT=CNT+1 Q:CNT>1
 . . . D FND^ICDEXLK5(ROOT,IEN,CDT,$G(SYS),$G(VER),1,OUT)
 D SEL^ICDEXLK5(ROOT,1)
 Q
 S STA=1 S:VER>0 STA=$$LS^ICDEXLK3(ROOT,IEN,CDT)
 Q:+($G(VER))>0&(+STA'>0)
 ;                    
 ; Miscellaneous
TOK(X) ;   Parse Text into Tokens
 K PARS D PAR^ICDTOKN($G(X),.PARS,1)
 Q
TOKEN(X,ROOT,SYS,ARY) ;   Parse Text into Tokens
 D TOKEN^ICDTOKN($G(X),$G(ROOT),$G(SYS),.ARY)
 Q
SS ;   Show Select/Find Global Arrays
 N NN,NC S NN="^TMP(""ICD9"","_$J_")",NC="^TMP(""ICD9"","_$J_","
 F  S NN=$Q(@NN) Q:'$L(NN)!(NN'[NC)  D
 . W !,NN,"=",@NN Q
 S NN="^TMP(""ICD0"","_$J_")",NC="^TMP(""ICD0"","_$J_","
 F  S NN=$Q(@NN) Q:'$L(NN)!(NN'[NC)  D
 . W !,NN,"=",@NN Q
 Q
WORD(X,ROOT,SYS) ;   Word is contained in a Set
 ;
 ; Input 
 ; 
 ;   X      A single word (Required)
 ;   
 ;   ROOT   Global Root/File # to Search (Optional, if 
 ;          not supplied both files 80 and 80.1 are used)
 ;   
 ;             ^ICD9(   or 80
 ;             ^ICD0(   or 80.1
 ;             
 ;   SYS    Coding System  (Optional, if not supplied all
 ;          coding systems for the file are used)
 ;   
 ;              1  or  ICD  or  ICD-9-CM
 ;              2  or  ICP  or  ICD-9 Proc
 ;             30  or  10D  or  ICD-10-CM
 ;             31  or  10P  or  ICD-10-PCS
 ;
 ; Output (if successful)
 ; 
 ;   $$WORD  Boolean value
 ;   
 ;           1 = Word was found
 ;           
 ;               If ROOT is not supplied, the word was found in 
 ;               either file 80 or 80.1
 ;               
 ;               If SYS is not supplied, the word was found in 
 ;               the file designated by ROOT in any coding system
 ;               in the file
 ;               
 ;               If both ROOT and SYS are supplied, the word was
 ;               found in the specified coding system
 ;               
 ;           0 = Word was not found
 ;           
 N TKN S TKN=$G(X),X=0 Q:'$L(TKN) 0  S ROOT=$$ROOT^ICDEX($G(ROOT)),SYS=$$SYS^ICDEX($G(SYS))
 I '$L(ROOT)!(ROOT'["^")!(ROOT'["(") D  Q X
 . N TRT,FI F FI=80,80.1 S TRT=$$ROOT^ICDEX(FI) D
 . . I +SYS'>0!('$D(^ICDS(+SYS))) D
 . . . N SYS S SYS=0 F  S SYS=$O(@(TRT_"""AD"","_SYS_")")) Q:+SYS'>0  D
 . . . . S:$D(@(TRT_"""AD"","_SYS_","""_TKN_""")")) X=1
 . . I +SYS>0&('$D(^ICDS(+SYS))) D
 . . . S:$D(@(TRT_"""AD"","_+SYS_","""_TKN_""")")) X=1
 I +SYS'>0!('$D(^ICDS(+SYS))) D  Q X
 . N SYS S SYS=0 F  S SYS=$O(@(ROOT_"""AD"","_SYS_")")) Q:+SYS'>0  D
 . . S:$D(@(ROOT_"""AD"","_SYS_","""_TKN_""")")) X=1
 Q:'$L(ROOT)!(ROOT'["^")!(ROOT'["(") 0
 Q:+SYS'>0!('$D(^ICDS(+SYS))) 0
 S:$D(@(ROOT_"""AD"","_+SYS_","""_TKN_""")")) X=1
 Q X
LS(ROOT,IEN,VDT) ;   Last Status
 N EFF,HIS,STA,CDT S IEN=+($G(IEN)),ROOT=$G(ROOT),VDT=$$CDT($G(VDT))
 Q:+IEN'>0 "-1"  Q:'$L(ROOT) "-1"  Q:VDT'?7N "-1"  S CDT=VDT+.00001
 S EFF=$O(@(ROOT_+IEN_",66,""B"","_CDT_")"),-1) Q:EFF'?7N "-1"
 S HIS=$O(@(ROOT_+IEN_",66,""B"","_EFF_","" "")"),-1) Q:+HIS'>0 "-1"
 S STA=$G(@(ROOT_+IEN_",66,"_+HIS_",0)")) Q:'$L(STA) "-1"
 S EFF=$P(STA,"^",1),STA=$P(STA,"^",2) Q:EFF'?7N "-1"  Q:STA'?1N "-1"
 S X=STA_"^"_EFF
 Q X
LD(ROOT,IEN,VDT,VER) ;   Last Description
 N EFF,LDI,LDS,CDT S IEN=+($G(IEN)),ROOT=$G(ROOT),VDT=$$CDT($G(VDT))
 Q:+IEN'>0 ""  Q:'$L(ROOT) ""  Q:VDT'?7N ""  S CDT=VDT+.00001
 S EFF=$O(@(ROOT_+IEN_",68,""B"","_CDT_")"),-1)
 Q:+($G(VER))>0&(EFF'?7N) ""
 S:+($G(VER))'>0&(EFF'?7N) EFF=$O(@(ROOT_+IEN_",68,""B"",0)"))
 S LDI=$O(@(ROOT_+IEN_",68,""B"","_+EFF_","" "")"),-1) Q:+LDI'>0 ""
 S LDS=$$UP^XLFSTR($G(@(ROOT_+IEN_",68,"_+LDI_",1)"))) Q:'$L(LDS) ""
 S X=LDS
 Q X
ISCODE(X,ROOT) ;   Check if Text is a Code
 N KEY,ORG,LAS,ORD,OUT,SI,SYS
 S KEY=$G(X) Q:'$L($TR(KEY,"""","")) 0
 S ORG=$E(KEY,1,($L(KEY)-1))_$C(($A($E(KEY,$L(KEY)))-1))_"~ "
 S OUT=0,SI=0
 F  S SI=$O(^ICDS(SI)) Q:+SI'>0  D  Q:+OUT>0
 . N ORD,RES S ORD=ORG
 . S RES=$O(@(ROOT_"""ABA"","_+SI_","""_ORD_""")"))
 . Q:'$L(RES)  S:$E(RES,$L(RES))=" " RES=$E(RES,1,($L(RES)-1))
 . I RES=KEY S OUT="1^"_SI_"^"_KEY Q
 . I $L(KEY)<$L(RES),KEY=$E(RES,1,$L(KEY)) S OUT="1^"_SI_"^"_KEY
 S KEY=$$UP^XLFSTR($G(X))
 S ORG=$E(KEY,1,($L(KEY)-1))_$C(($A($E(KEY,$L(KEY)))-1))_"~ "
 S SI=0 F  S SI=$O(^ICDS(SI)) Q:+SI'>0  D  Q:+OUT>0
 . N ORD,RES S ORD=ORG
 . S RES=$O(@(ROOT_"""ABA"","_+SI_","""_ORD_""")"))
 . Q:'$L(RES)  S:$E(RES,$L(RES))=" " RES=$E(RES,1,($L(RES)-1))
 . I RES=KEY S OUT="1^"_SI_"^"_KEY Q
 . I $L(KEY)<$L(RES),KEY=$E(RES,1,$L(KEY)) S OUT="1^"_SI_"^"_KEY
 Q:+OUT>0 OUT
 Q 0
UNQ(X,ROOT) ;   Check if Text is a Unique Code
 ;
 ; Input
 ; 
 ;   X      Input String/Code
 ;   ROOT   Global Root of file
 ;   
 ; Output
 ; 
 ;   $$UNQ  3 Piece ^ delimited string
 ;   
 ;             Piece  Content
 ;             1      String is Unique in file
 ;                       1 if X is unique
 ;                       0 if X is not unique
 ;             2      String is a Code
 ;                       1 is a code
 ;                       0 X is not a code
 ;             3      String has Multiple Entries
 ;                       1 Yes, X occurs more than once
 ;                       0 No, X occurs once (aka unique)
 ;             
 ;          or -1 if the code string X is not found
 ;
 N KEY,ORG,LAS,ORD,OUT,IENS,IEN,NXT,NIEN,SI,SYS Q:'$L($G(X)) -1
 S KEY=$TR($G(X),"""","") Q:'$L(KEY) -1
 S ORG=$E(KEY,1,($L(KEY)-1))_$C(($A($E(KEY,$L(KEY)))-1))_"~ "
 S OUT=-1,(IEN,NXT,SI)=0
 F  S SI=$O(@(ROOT_"""ABA"","_+SI_")")) Q:+SI'>0  D  Q:OUT>0  Q:+IEN>0  Q:+NXT>0
 . N ORD S ORD=ORG S IEN=$O(@(ROOT_"""ABA"","_+SI_","""_KEY_" "",0)"))
 . S (NXT,NIEN)=0
 . F  S ORD=$O(@(ROOT_"""ABA"","_+SI_","""_ORD_""")")) Q:'$L(ORD)  Q:$E(ORD,1,$L(KEY))'=KEY  D
 . . S NIEN=0 F  S NIEN=$O(@(ROOT_"""ABA"","_+SI_","""_ORD_""","_NIEN_")")) Q:+NIEN'>0  D
 . . . S:ORD'=(KEY_" ") IENS(+NIEN)=""
 S (NXT,NIEN)=0 F  S NIEN=$O(IENS(NIEN)) Q:+NIEN'>0  S NXT=NXT+1
 S:+IEN>0 $P(OUT,"^",1)=1,$P(OUT,"^",2)=1
 I +IEN>0 S:+NXT>0 $P(OUT,"^",3)=1,$P(OUT,"^",1)=0
 I +($G(OUT))'<0 F SI=1:1:3 S $P(OUT,"^",SI)=+($P($G(OUT),"^",SI))
 I NXT>0,+IEN'>0 S OUT=$S(NXT>1:0,1:1)_"^0^"_$S(NXT>1:1,1:0)
 S X=OUT
 Q X
ISORD(X) ;   Check if in $ORDER
 Q:'$L($G(ORD)) 0  Q:'$L($G(KEY)) 0
 Q:$E($G(ORD),1,$L($G(KEY)))=$G(KEY) 1
 Q 0
CDT(X,Y) ;   ICD-10 Code Set Date
 N CDT,SYS S CDT=$G(X),SYS=+($G(Y)) S:CDT'?7N CDT=$$DT^XLFDT
 Q X
SYS(ROOT,CDT) ;   System from File and Date
 N FILE,CTL,FDT,NDT,IEN,SYS S (NDT,SYS)=0
 S FILE=$S($G(ROOT)="^ICD9(":80,$G(ROOT)="^ICD0(":80.1,1:"") Q:FILE'>0 0
 S CTL=$G(CDT) Q:CTL'?7N 0
 S IEN=0 F  S IEN=$O(^ICDS("F",FILE,IEN)) Q:+IEN'>0  D
 . S FDT=$P($G(^ICDS(+IEN,0)),"^",4) Q:FDT'?7N
 . I FDT<(CTL+.001),FDT>NDT S FDT=CTL,SYS=IEN
 Q SYS
SH ;   Show TMP
 N SUB,NN,NC S SUB="ICD9" S:'$D(^TMP(SUB)) SUB="ICD0" Q:'$D(^TMP(SUB))
 S NN="^TMP("""_SUB_""","_$J_")",NC="^TMP("""_SUB_""","_$J_","
 W:'$D(@NN) ! Q:'$D(@NN)  F  S NN=$Q(@NN) Q:'$L(NN)!(NN'[NC)  W !,NN,"=",@NN
 W !
 Q
TM(X,Y) ;   Trim Y
 S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
