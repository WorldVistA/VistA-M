ICDEXC4 ;SLC/KER - ICD Extractor - Code APIs (cont) ;12/19/2014
 ;;18.0;DRG Grouper;**57,67**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    None
 ;               
 Q
SDH(FILE,IEN,ARY) ; Short Description History
 ;            
 ; Input:
 ; 
 ;   FILE    File Number (Required)
 ;   IEN     Internal Entry Number (Required)
 ;  .ARY     Array Passed by Reference (Optional)
 ;   
 ; Output:
 ; 
 ;   $$SDH   This is a three piece "^" delimited 
 ;           string containing:
 ;           
 ;              1   Number of short descriptions found
 ;              2   The earliest date found
 ;              3   The latest date found
 ;              
 ;           OR -1 ^ Error Message
 ;           
 ;   ARY     Short Descriptions by date
 ;   
 ;              ARY(0)= # ^ Earliest Date ^ Latest Date
 ;              ARY(DATE)=Long Description
 ;   
 K ARY N EFF,TXT,HIS,ROOT,CNT,FD,LD,BEG,END S IEN=+($G(IEN)),LD=0,FD=9999999
 S FILE=$$FILE^ICDEX($G(FILE)) Q:"^80^80.1^"'[("^"_FILE_"^") "-1^File not found"
 S ROOT=$S(FILE=80:"^ICD9(",FILE=80.1:"^ICD0(",1:"")
 Q:'$L(ROOT) "-1^File not found"  S CNT=0
 S HIS=0 F  S HIS=$O(@(ROOT_+IEN_",67,"_+HIS_")")) Q:+HIS'>0  D
 . N NOD,EFF,TXT S NOD=$G(@(ROOT_+IEN_",67,"_+HIS_",0)"))
 . S EFF=$P(NOD,"^",1),TXT=$P(NOD,"^",2) Q:EFF'?7N  Q:'$L(TXT)
 . S:EFF<FD FD=EFF  S:EFF>LD LD=EFF
 . S CNT=CNT+1,ARY(0)=CNT,ARY(EFF)=TXT
 S (BEG,END)="" S:FD?7N&(FD'=9999999)&(FD'>LD) BEG=FD S:LD?7N&(LD'<FD) END=LD
 S:BEG?7N&(END?7N)&(CNT>0) ARY(0)=CNT_"^"_BEG_"^"_END S CNT=ARY(0)
 I +CNT'>0 D  Q ERR
 . N TYP S TYP=$S(FILE=80:"Diagnosis",FILE=80.1:"Operation/Procedure",1:"")
 . S:$L(TYP) ERR="-1^No "_TYP_" Short Descriptions found"
 . S:'$L(TYP) ERR="-1^No Short Descriptions found"
 Q CNT
LDH(FILE,IEN,ARY) ; Long Description History
 ;            
 ; Input:
 ; 
 ;   FILE    File Number (Required)
 ;   IEN     Internal Entry Number (Required)
 ;  .ARY     Array Passed by Reference (Optional)
 ;  
 ; Output:
 ; 
 ;   $$LDH   This is a three piece "^" delimited 
 ;           string containing:
 ;           
 ;             1   Number of long descriptions found
 ;             2   The earliest date found
 ;             3   The latest date found
 ;              
 ;           OR -1 ^ Error Message
 ;           
 ;   ARY     Long Descriptions by date
 ;   
 ;             ARY(0)= # ^ Earliest Date ^ Latest Date
 ;             ARY(DATE)=Long Description
 ;              
 K ARY N EFF,TXT,HIS,ROOT,CNT,FD,LD,BEG,END S IEN=+($G(IEN)),LD=0,FD=9999999
 S FILE=$$FILE^ICDEX($G(FILE)) Q:"^80^80.1^"'[("^"_FILE_"^") "-1^File not found"
 S ROOT=$S(FILE=80:"^ICD9(",FILE=80.1:"^ICD0(",1:"")
 Q:'$L(ROOT) "-1^File not found"  S CNT=0
 S HIS=0 F  S HIS=$O(@(ROOT_+IEN_",68,"_+HIS_")")) Q:+HIS'>0  D
 . N NOD,EFF,TXT S EFF=$P($G(@(ROOT_+IEN_",68,"_+HIS_",0)")),"^",1)
 . S TXT=$P($G(@(ROOT_+IEN_",68,"_+HIS_",1)")),"^",1)
 . Q:EFF'?7N  Q:'$L(TXT)
 . S:EFF<FD FD=EFF  S:EFF>LD LD=EFF
 . S CNT=CNT+1,ARY(0)=CNT,ARY(EFF)=TXT
 S (BEG,END)="" S:FD?7N&(FD'=9999999)&(FD'>LD) BEG=FD S:LD?7N&(LD'<FD) END=LD
 S:BEG?7N&(END?7N)&(CNT>0) ARY(0)=CNT_"^"_BEG_"^"_END S CNT=ARY(0)
 I +CNT'>0 D  Q ERR
 . N TYP S TYP=$S(FILE=80:"Diagnosis",FILE=80.1:"Operation/Procedure",1:"")
 . S:$L(TYP) ERR="-1^No "_TYP_" Long Descriptions found"
 . S:'$L(TYP) ERR="-1^No Long Descriptions found"
 Q CNT
RDX(CODE,CDT) ; Resolve Diagnosis Code Fragment
 ;
 ; Input
 ; 
 ;    X         Code or Code Fragment (Required)
 ;    CDT       Versioning Date (Optional, Default TODAY)
 ;    
 ; Output
 ; 
 ;    $$RDX     Code if resolved
 ;              -1 ^ error message if not resolved
 ;    
 ; Example: 
 ;    
 ;    Fragment    Oct 1, 2014     Oct 1, 2015
 ;    E8310         E831.0           E83.10
 ;    311           311.             311.
 ;    A870          A87.0            A87.0
 ;    A0201         -1^Could not resolve code fragment
 ;    
 N ICD1,ICD2,ICDC,ICDCD,ICDID,ICDIN,ICDND,ICDNX,ICDO,ICDON,ICDOP,ICDPR,ICDR,ICDS,ICDT,ICDX
 S (ICDO,ICDX)=$$UP^XLFSTR(CODE),ICDC=$E(ICDO,1),ICDR="^ICD9(" Q:'$L(ICDX) "-1^Invalid input"  S ICDCD=$P($G(CDT),".",1)
 S:'$L(ICDCD) ICDCD=$$DT^XLFDT S ICDID=$$IMP^ICDEX(30) S ICDS="" S:ICDCD?7N ICDS=$S((ICDCD+.001)>ICDID:30,1:1)
 S:ICDS=1&("ABCDFGHIJKLMNOPQRSTUWXYZ"[ICDC) ICDS=30 S:ICDS=30&(ICDC?1N) ICDS=1
 Q:'$L(ICDS)!(ICDS'?1N.N) "-1^Invalid system"  I $D(@(ICDR_"""ABA"","_+ICDS_","""_ICDX_" "")")) S CODE=ICDX Q CODE
 F ICDT=".",".0",".00","0","00" D
 . S:$E(ICDX,1)?1N&($D(@(ICDR_"""ABA"","_+ICDS_","""_ICDX_ICDT_" "")"))) ICDX=ICDX_ICDT
 . S:$E(ICDX,1)="E"&($E(ICDX,2,4)?3N)&($D(@(ICDR_"""ABA"","_+ICDS_","""_ICDX_ICDT_" "")"))) ICDX=ICDX_ICDT
 . S:$E(ICDX,1)?1U&($E(ICDX,2,3)?2N)&($D(@(ICDR_"""ABA"","_+ICDS_","""_ICDX_ICDT_" "")"))) ICDX=ICDX_ICDT
 I ICDX'=ICDO,$D(@(ICDR_"""ABA"","_+ICDS_","""_ICDX_" "")")) S CODE=ICDX Q CODE
 I ICDX=ICDO,ICDX'["." D
 . N ICD1,ICD2 S ICD1=$E(ICDX,1,3),ICD2=$E(ICDX,4,$L(ICDX)) S:$E(ICDX,1)="E"&(ICDS=1) ICD1=$E(ICDX,1,4),ICD2=$E(ICDX,5,$L(ICDX))
 . S:$E(ICDX,1)="E"&(ICDS=30) ICD1=$E(ICDX,1,3),ICD2=$E(ICDX,4,$L(ICDX)) Q:$E(ICDX,1)="E"&(ICDS=1)&($L(ICD1)'=4)
 . Q:$E(ICDX,1)="E"&(ICDS=30)&($L(ICD1)'=3)  Q:$E(ICDX,1)'="E"&($L(ICD1)'=3)  S ICDX=ICD1_"."_ICD2
 I ICDX'=ICDO,$D(@(ICDR_"""ABA"","_+ICDS_","""_ICDX_" "")")) S CODE=ICDX Q CODE
 I ICDX=ICDO D
 . F ICDT=".",".0",".00","0","00" D
 . . S:$E(ICDX,1)?1N&($D(@(ICDR_"""BA"","""_ICDX_ICDT_" "")"))) ICDX=ICDX_ICDT
 . . S:$E(ICDX,1)="E"&($E(ICDX,2,4)?3N)&($D(@(ICDR_"""BA"","""_ICDX_ICDT_" "")"))) ICDX=ICDX_ICDT
 . . S:$E(ICDX,1)?1U&($E(ICDX,2,3)?2N)&($D(@(ICDR_"""BA"","""_ICDX_ICDT_" "")"))) ICDX=ICDX_ICDT
 S CODE="-1^Could not resolve code fragment" S:$D(@(ICDR_"""BA"","""_ICDX_" "")")) CODE=ICDX
 Q CODE
TRIM(X,Y) ; Trim Character
 ;
 ; Input:
 ;
 ;   X     Input String
 ;   Y     Character to Trim (default " ")
 ;
 ; Output:
 ; 
 ;   X     String without Leading/Trailing character Y
 ;
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
