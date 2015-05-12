ICDEXA3 ;SLC/KER - ICD Extractor - APIs/Utilities (cont) ;12/19/2014
 ;;18.0;DRG Grouper;**57,67**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^ICDS(              N/A
 ;    ^ICDS("F")          N/A
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;    ^DIR                ICR  10026
 ;               
OBA(FILE,CODE,SYS,REV) ; Replace $Order for "ABA" and "BA" indexes
 ;
 ; Input:
 ; 
 ;    CODE = ICD Code, can be null
 ;    FILE   File Number 80 or 80.1
 ;    SYS    Coding System (internal, file 80.4)
 ;    REV    Reverse $Order if set to 1
 ;    
 ; Output:
 ; 
 ;    $$OBA  Next or Previous Code
 ;
 ;  This API replaces the need to access the BA Index
 ;  in a FOR loop.
 ;  
 ;     $$OBA(<file>,<code>,<system>) replaces:
 ; 
 ;        $O(^ICD9("BA",(<code>_" ")) and
 ;        $O(^ICD0("BA",(<code>_" "))
 ;        
 ;     F  S CODE=$$OBA^ICDEX(80,CODE,1) Q:'$L(CODE)  D
 ;     F  S CODE=$$OBA^ICDEX(80,CODE,30) Q:'$L(CODE)  D
 ;     F  S CODE=$$OBA^ICDEX(80.1,CODE,2) Q:'$L(CODE)  D
 ;     F  S CODE=$$OBA^ICDEX(80.1,CODE,31) Q:'$L(CODE)  D
 ;  
 ;  Retire IA 5388, 5404
 ;  
 N ICDC,ICDG,ICDF,ICDI,ICDID,ICDR,ICDU,ICDS,ICDO,ICDN,ICDX,ICDD
 S ICDC=$TR($G(CODE)," ",""),ICDU=$$UP^XLFSTR(ICDC) S ICDS=$G(SYS)
 S ICDF=$G(FILE) Q:"^80^80.1^"'[("^"_ICDF_"^") ""
 I $L(ICDS) S ICDS=$$SYS^ICDEX(ICDS) Q:+ICDS'>0 ""
 S ICDR=$$ROOT^ICDEX(ICDF) Q:'$L(ICDR) ""  S ICDD=+($G(REV))
 I +ICDS>0 D  Q ICDO
 . N ICDX,ICDN,ICDI S ICDX="ABA"
 . I ICDD'>0 D
 . . N ICD1,ICD2
 . . S ICD1=$TR($O(@(ICDR_""""_ICDX_""","_+ICDS_","""_(ICDC_" ")_""")"))," ","")
 . . S ICD2=$TR($O(@(ICDR_""""_ICDX_""","_+ICDS_","""_(ICDU_" ")_""")"))," ","")
 . . S:ICD1]ICD2!(ICD1=ICD2) ICDN=ICD2 S:ICD2]ICD1 ICDN=ICD1
 . S:ICDD>0&('$L(ICDC)) ICDC="~"
 . I ICDD>0 D
 . . N ICD1,ICD2
 . . S ICD1=$TR($O(@(ICDR_""""_ICDX_""","_+ICDS_","""_(ICDC_" ")_""")"),-1)," ","")
 . . S ICD2=$TR($O(@(ICDR_""""_ICDX_""","_+ICDS_","""_(ICDU_" ")_""")"),-1)," ","")
 . . S:ICD1]ICD2!(ICD1=ICD2) ICDN=ICD2 S:ICD2]ICD1 ICDN=ICD1
 . S ICDI=$$CODEABA^ICDEX(ICDN,ICDR,ICDS)
 . S ICDO=ICDN S:'$L(ICDN)!(+ICDI'>0) ICDO=""
 I '$L(ICDS) D  Q ICDO
 . N ICDX,ICDN,ICDI S ICDX="BA"
 . I +ICDD'>0 D
 . . N ICD1,ICD2
 . . S ICD1=$TR($O(@(ICDR_""""_ICDX_""","""_(ICDC_" ")_""")"))," ","")
 . . S ICD2=$TR($O(@(ICDR_""""_ICDX_""","""_(ICDU_" ")_""")"))," ","")
 . . S:ICD1]ICD2!(ICD1=ICD2) ICDN=ICD2 S:ICD2]ICD1 ICDN=ICD1
 . S:ICDD>0&('$L(ICDC)) ICDC="~"
 . I +ICDD>0 D
 . . N ICD1,ICD2
 . . S ICD1=$TR($O(@(ICDR_""""_ICDX_""","""_(ICDC_" ")_""")"),-1)," ","")
 . . S ICD2=$TR($O(@(ICDR_""""_ICDX_""","""_(ICDU_" ")_""")"),-1)," ","")
 . . S:ICD1]ICD2!(ICD1=ICD2) ICDN=ICD2 S:ICD2]ICD1 ICDN=ICD1
 . S ICDI=$$CODEBA^ICDEX(ICDN,ICDR)
 . S ICDO=ICDN S:'$L(ICDN)!(+ICDI'>0) ICDO=""
 Q ""
OD(FILE,WORD,SYS,REV) ; Replace $Order on "D" Index
 ; 
 ; Input:
 ; 
 ;    FILE   File Number
 ;    WORD   Word, can be null or a 2 piece string
 ;           containing Word and IEN where the word
 ;           is stored
 ;    SYS    Coding System (internal)
 ;             Acceptable values can be found on the ASYS
 ;             Index and includes:
 ;             
 ;             File 80
 ;                1   ICD-9-CM
 ;               30   ICD-10-CM
 ;                 
 ;             File 80.1
 ;                2   ICD-9 Proc
 ;               31   ICD-10-PCS
 ;    
 ;    REV    Reverse $Order if set to 1
 ;    
 ; Output:
 ; 
 ;    2 Piece "^" delimited string
 ;    
 ;         1   WORD   Next or Previous word in D Index
 ;         2   IEN    Internal Entry Number where WORD is found
 ;  
 ;  Retire IA 5388, 5404
 ;  
 N ICDW,ICDWI,ICDG,ICDF,ICDI,ICDR,ICDS,ICDO,ICDN,ICDX,ICDD
 S ICDW=$$UP^XLFSTR($G(WORD)),ICDWI=+($P(ICDW,"^",2)),ICDW=$P(ICDW,"^",1)
 S ICDS=$G(SYS) S ICDF=$G(FILE) Q:"^80^80.1^"'[("^"_ICDF_"^") ""
 I $L(ICDS) S ICDS=$$SYS^ICDEX(ICDS) Q:+ICDS'>0 ""
 S ICDR=$$ROOT^ICDEX(ICDF) Q:'$L(ICDR) ""  S ICDD=+($G(REV))
 I +ICDS>0 D  Q ICDO
 . N ICDX,ICDN,ICDNI,ICDI S ICDX="AD"
 . I ICDD'>0 D  Q
 . . S ICDNI=0 S:$L($G(ICDW)) ICDNI=$O(@(ICDR_""""_ICDX_""","_+ICDS_","""_ICDW_""","_+ICDWI_")"))
 . . I ICDNI>0 S ICDO=ICDW_"^"_ICDNI Q
 . . S ICDNI="",ICDN=$O(@(ICDR_""""_ICDX_""","_+ICDS_","""_ICDW_""")"))
 . . S:$L(ICDN) ICDNI=$O(@(ICDR_""""_ICDX_""","_+ICDS_","""_ICDN_""","_0_")"))
 . . S ICDO=ICDN_"^"_ICDNI
 . I ICDD>0 D  Q
 . . I $L(ICDW) D  Q
 . . . S ICDNI=$O(@(ICDR_""""_ICDX_""","_+ICDS_","""_ICDW_""","_+ICDWI_")"),-1)
 . . . I ICDNI>0 S ICDO=ICDW_"^"_ICDNI Q
 . . . S ICDN=$O(@(ICDR_""""_ICDX_""","_+ICDS_","""_ICDW_""")"),-1)
 . . . I '$L(ICDN) S ICDO="" Q
 . . . S:$L(ICDN) ICDNI=$O(@(ICDR_""""_ICDX_""","_+ICDS_","""_ICDN_""","" "")"),-1)
 . . . I +ICDNI>0 S ICDO=ICDN_"^"_ICDNI Q
 . . S ICDW="~",ICDWI=""" """ S ICDNI=""
 . . S ICDN=$O(@(ICDR_""""_ICDX_""","_+ICDS_","""_ICDW_""")"),-1)
 . . S:$L(ICDN) ICDNI=$O(@(ICDR_""""_ICDX_""","_+ICDS_","""_ICDN_""","_ICDWI_")"),-1)
 . . S ICDO=ICDN_"^"_ICDNI
 I '$L(ICDS) D  Q ICDO
 . N ICDX,ICDN,ICDNI,ICDI S ICDX="D"
 . I +ICDD'>0 D  Q
 . . S ICDNI=0 S:$L($G(ICDW)) ICDNI=$O(@(ICDR_""""_ICDX_""","_+ICDS_","""_ICDW_""","_+ICDWI_")"))
 . . I ICDNI>0 S ICDO=ICDW_"^"_ICDNI Q
 . . S ICDNI="",ICDN=$O(@(ICDR_""""_ICDX_""","_+ICDS_","""_ICDW_""")"))
 . . S:$L(ICDN) ICDNI=$O(@(ICDR_""""_ICDX_""","_+ICDS_","""_ICDN_""","_0_")"))
 . . S ICDO=ICDN_"^"_ICDNI
 . I ICDD>0 D  Q
 . . I $L(ICDW) D  Q
 . . . S ICDNI=$O(@(ICDR_""""_ICDX_""","_+ICDS_","""_ICDW_""","_+ICDWI_")"),-1)
 . . . I ICDNI>0 S ICDO=ICDW_"^"_ICDNI Q
 . . . S ICDN=$O(@(ICDR_""""_ICDX_""","_+ICDS_","""_ICDW_""")"),-1)
 . . . I '$L(ICDN) S ICDO="" Q
 . . . S:$L(ICDN) ICDNI=$O(@(ICDR_""""_ICDX_""","_+ICDS_","""_ICDN_""","" "")"),-1)
 . . . I +ICDNI>0 S ICDO=ICDN_"^"_ICDNI Q
 . . S ICDW="~",ICDWI=""" """ S ICDNI=""
 . . S ICDN=$O(@(ICDR_""""_ICDX_""","_+ICDS_","""_ICDW_""")"),-1)
 . . S:$L(ICDN) ICDNI=$O(@(ICDR_""""_ICDX_""","_+ICDS_","""_ICDN_""","_ICDWI_")"),-1)
 . . S ICDO=ICDN_"^"_ICDNI
 Q ""
DLM(FILE,IEN,FIELD,CDT) ; Date Last Modified
 ;
 ; Input
 ;    
 ;    FILE     File Number (required)
 ;    IEN      Internal Entry Number (required)
 ;    FIELD    Field Number of Versioned Data  (optional)
 ;    
 ;               File 80
 ;              
 ;                  10   Sex                          5;0
 ;                  11   Age Low                      6;0
 ;                  12   Age High                     7;0
 ;                  66   Status                      66;0
 ;                  67   Diagnosis                   67;0
 ;                  68   Description                 68;0
 ;                  71   DRG Grouper                  3;0
 ;                  72   Major Diagnostic Category    4;0
 ;                 103   Complication/Comorbidity    69;0
 ;
 ;               File 80.1
 ;              
 ;                  10   Sex                          3;0
 ;                  66   Status                      66;0
 ;                  67   Operation/Procedure         67;0
 ;                  68   Description                 68;0
 ;                  71   DRG Grouper                  2;0
 ;                 
 ;             If the field is passed, then the date last 
 ;             modified (based on date) for the field is
 ;             returned.  If the field is not passed, then
 ;             the date last modified (based on date) for 
 ;             the record at IEN is returned.
 ;           
 ;    CDT     Date to base output on (default is today)
 ;            Business rules apply
 ;    
 ; Output:
 ; 
 ;    $$DLM   Date Last Modified
 ;    
 ;     or -1 ^ message on error
 ;  
 N ICD0,ICDA,ICDC,ICDD,ICDE,ICDF,ICDH,ICDI,ICDL,ICDN,ICDNS,ICDO,ICDP,ICDR
 S ICDI=$G(IEN) Q:+ICDI'>0 "-1^Invalid IEN"
 S ICDF=$G(FILE) Q:"^80^80.1^"'[("^"_ICDF_"^") "-1^Invalid File"
 S ICDR=$$ROOT^ICDEX(ICDF) Q:'$L(ICDR) "-1^Invalid File Root"
 S ICDC=+($P($G(@(ICDR_+ICDI_",1)")),"^",1))
 Q:+ICDC'>0 "-1^Invalid Coding System "_ICDC
 Q:'$D(@(ICDR_+ICDI_",0)")) "-1^IEN not found"
 S ICDL=$G(FIELD)
 S ICDD=$G(CDT) S:ICDD'?7N ICDD=$$DT^XLFDT
 S ICDD=$$DTBR^ICDEX($G(ICDD),0,ICDC)
 Q:ICDD'?7N "-1^Invalid Date for File"
 I '$L(ICDL) D  Q ICDO
 . N ICDA,ICDNS,ICDP,ICDN,ICDE,ICDH,ICD0,ICDL
 . K ICDA S ICDNS="",ICDO="-1^Date Last Modified not found"
 . S:ICDF=80 ICDNS="3^4^5^6^7^66^67^68^69" S:ICDF=80.1 ICDNS="2^3^66^67^68" Q:'$L(ICDNS)
 . F ICDP=1:1 Q:'$L($P(ICDNS,"^",ICDP))  D
 . . S ICDN=$P(ICDNS,"^",ICDP)
 . . S ICDE=$O(@(ICDR_+ICDI_","_ICDN_",""B"","_(ICDD+.001)_")"),-1) Q:ICDE'?7N
 . . S ICDH=$O(@(ICDR_+ICDI_","_ICDN_",""B"","_ICDE_","" "")"),-1)
 . . S ICD0=$G(@(ICDR_+ICDI_","_ICDN_","_ICDH_",0)"))
 . . S:$P(ICD0,"^",1)?7N ICDA($P(ICD0,"^",1))=""
 . S ICDL=$O(ICDA(" "),-1) S:ICDL?7N ICDO=ICDL K ICDA
 S:ICDF=80 ICDN=$S(ICDL=10:5,ICDL=11:6,ICDL=12:7,ICDL=66:66,ICDL=67:67,ICDL=68:68,ICDL=71:3,ICDL=72:4,ICDL=103:69,1:"")
 S:ICDF=80.1 ICDN=$S(ICDL=10:3,ICDL=66:66,ICDL=67:67,ICDL=68:68,ICDL=71:2,1:"")
 Q:+ICDL'>0!('$L(ICDN)) "-1^Invalid Field"
 Q:$O(@(ICDR_+ICDI_","_ICDN_",0)"))'>0 "-1^Field #"_ICDL_" not found for IEN "_ICDI
 S ICDE=$O(@(ICDR_+ICDI_","_ICDN_",""B"","_(ICDD+.001)_")"),-1)
 Q:ICDE'?7N ("-1^Date Last Modified not found based on "_$$FMTE^XLFDT($G(ICDD),"5DZ"))
 S ICDH=$O(@(ICDR_+ICDI_","_ICDN_",""B"","_ICDE_","" "")"),-1)
 Q:+ICDH'>0 "-1^Modified Data Not Found"
 S ICDO="-1^Modified Data Not Found"
 S ICD0=$G(@(ICDR_+ICDI_","_ICDN_","_ICDH_",0)"))
 S ICDL=$P(ICD0,"^",1)
 S:ICDL?7N ICDO=ICDL
 Q ICDO
CS(FILE,FMT,CDT) ; Select Coding System (lookup)
 ;
 ; Input
 ; 
 ;    FILE   File Number 80 or 80.1 (optional)
 ;           If not provided, you will be prompted
 ;           for the ICD File, there is no default
 ;           value.
 ; 
 ;    FMT    Format
 ;    
 ;             E  Display External only (default)
 ;             I  Display Internal with External for selection
 ;             
 ;    CDT    Code Set Date (optional) if not supplied then
 ;           it is not used
 ; Output
 ;     
 ;    $$CS   2 piece "^" delimited string
 ;    
 ;              1  Coding System (internal)
 ;              2  Coding System (external)
 ;      
 ;           or -1 on error or non-selection
 ;              ^^ double up-arrows
 ;               ^ timeout or single up-arrow
 ;    
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,ICDDIR,ICD0,ICD1,ICD2,ICDA,ICDC,ICDD,ICDE
 N ICDIMP,ICDF,ICDI,ICDM,ICDR,ICDT,ICDTMP,ICDO,ICDV,ICDX,X,Y
 S ICDIMP=$$IMP^ICDEX(30),ICDD=$S($P($G(CDT),".")?7N:$P($G(CDT),"."),1:"")
 S ICDF=$$FIT($G(FILE),1) Q:ICDF["^" ICDF  S ICDDIR="Select ICD file number" S:+ICDF'>0 ICDF=$$FI
 Q:"^80^80.1^"'[("^"_ICDF_"^") "-1^Invalid File"
 S ICDR=$$ROOT^ICDEX(ICDF) Q:'$L(ICDR) "-1^Invalid File"
 K ICDA S ICDA(0)=0
 I $G(ICDD)?7N D
 . N ICDAA,ICDE,ICDI,ICDS S (ICDC,ICDI)=0 F  S ICDI=$O(^ICDS("F",ICDF,ICDI)) Q:+ICDI'>0  D
 . . S ICDE=$P($G(^ICDS(+ICDI,0)),"^",1) Q:'$L(ICDE)
 . . S ICDTMP=$P($G(^ICDS(+ICDI,0)),"^",4) Q:$G(ICDD)?7N&((ICDD+.001)'>ICDTMP)
 . . S ICDAA(ICDTMP,ICDI)=ICDI_"^"_ICDE
 . S ICDE=$O(ICDAA(" "),-1)
 . S ICDI=$O(ICDAA(+ICDE," "),-1)
 . S ICDS=$G(ICDAA(+ICDE,+ICDI))
 . S:ICDE?7N&(ICDI>0)&($L(ICDS)) ICDC=1,ICDA(ICDC)=ICDS,ICDA(0)=1
 I $G(ICDD)'?7N!($O(ICDA(0))'>0) D
 . S (ICDC,ICDI)=0 F  S ICDI=$O(^ICDS("F",ICDF,ICDI)) Q:+ICDI'>0  D
 . . S ICDE=$P($G(^ICDS(+ICDI,0)),"^",1) Q:'$L(ICDE)
 . . S ICDTMP=$P($G(^ICDS(+ICDI,0)),"^",4)
 . . S ICDC=ICDC+1,ICDA(ICDC)=ICDI_"^"_ICDE,ICDA(0)=ICDC
 Q:ICDA(0)=1&($L($G(ICDA(1)))) $G(ICDA(1)) Q:ICDA(0)=1&('$L($G(ICDA(1)))) "-1^Invalid Selection"
 S ICDX=$G(FMT) S:ICDX'="I" ICDX="E" S ICDM=$O(ICDA(" "),-1) Q:ICDM'>0 "-1^Invalid Selection"
 Q:ICDM=1&($D(ICDA(1))) $G(ICDA(1))  Q:ICDM'>1 "-1^Invalid Selection"  S DIR(0)="NAO^1:"_ICDM_":0"
 S DIR("A",1)=" Coding System Selection for file "_ICDF,DIR("A",2)=" "
 S DIR("A")=" Select Coding System (1-"_ICDM_"):  "
 S ICDC=0,ICDI=0 F  S ICDI=$O(ICDA(ICDI)) Q:+ICDI'>0  D
 . N ICD1,ICD2,ICDT S ICD1=$P($G(ICDA(ICDI)),"^",1) Q:ICD1'>0  S ICD2=$P($G(ICDA(ICDI)),"^",2) Q:'$L(ICD2)
 . S ICDT=ICD2 S:$G(ICDX)="I" ICDT=ICDT_$J(" ",(15-$L(ICDT)))_"(#"_ICD1_")"
 . S ICDC=ICDC+1 S DIR("A",(ICDC+2))="    "_$J(ICDC,2)_"   "_ICDT
 S:ICDC>1 ICDC=ICDC+1,DIR("A",(ICDC+2))=" " S DIR("PRE")="S:X[""?"" X=""??""",(DIR("?"),DIR("??"))="^D CSH^ICDEXA3"
 W ! D ^DIR Q:$D(DIROUT) "^^" Q:$D(DTOUT)!($D(DUOUT)) "^"  Q:'$L(Y) "-1^No Coding System Selected"  Q:+Y>0&($D(ICDA(+Y))) $G(ICDA(+Y))
 Q "-1^Invalid Selection"
CSH ; Select Coding System Help
 W:+($G(ICDM))'>1 !,?5,"This response must be a number."
 W:+($G(ICDM))>1 !,?5,"This response must be a number from 1 to ",+($G(ICDM)),"."
 Q
 ;
FI(X) ; Select ICD File
 ;
 ; Input
 ; 
 ;    X      File Number 80 or 80.1 or NULL
 ; 
 ; Output
 ;     
 ;    $$FI   File Number or -1 on error
 ;    
 ;           or -1 on error or non-selection
 ;              ^^ double up-arrows
 ;               ^ timeout or single up-arrow
 ;  
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,ICD1,ICD2,ICDA,ICDC,ICDE,ICDF,ICDI,ICDM,ICDR,ICDT,Y
 S X=$G(X),ICDO=$$FIT(X,1) Q:"^80^80.1^"[("^"_ICDO_"^") ICDO  S ICD0=""
 S DIR("A")=" Select ICD file:  " S ICDDIR=$$TRIM($G(ICDDIR))
 S DIR("A",1)=" ICD file" S:$L($G(ICDDIR)) DIR("A",1)=" "_$G(ICDDIR) K ICDDIR
 S DIR("A",2)=" "
 S DIR("A",3)="     1   ICD Diagnosis file              #80     ^ICD9("
 S DIR("A",4)="     2   ICD Operations/Procedures file  #80.1   ^ICD0("
 S DIR("A",5)=" "
 S DIR(0)="NAO^1:2:0"
 S DIR("PRE")="S X=$$FIT^ICDEXA3(X)",(DIR("?"),DIR("??"))="^D FIH^ICDEXA3"
 D ^DIR Q:'$L($G(X)) "-1^No Selection"  Q:$D(DIROUT) "^^" Q:$D(DTOUT)!($D(DUOUT)) "^"
 S ICDO=$$FIT(Y,1)  S X="-1^Invalid File Selection"
 S:"^80^80.1^"[("^"_ICDO_"^") X=ICDO
 Q X
FIH ; File Help
 W !,?5,"This response must be a number from 1 to 2."
 Q
DP(X) ; Select Diagnosis or Procedure
 ;
 ; Input
 ; 
 ;    X      Date
 ; 
 ; Output
 ;     
 ;    $$DP   Coding System based on Date or -1 on error
 ;    
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,ICCD,ICDCS,ICDIMP,ICD1,ICD2,ICDA,ICDC,ICDE,ICDF,ICDI,ICDM,ICDR,ICDT,ICDTY,Y
 S ICDD=$P($G(X),".",1),ICD0="",ICDIMP=$$IMP^ICDEX(30),ICDTY="",ICDCS="" S:ICDD'?7N ICDD=$$DT^XLFDT
 F ICDI=0 F  S ICDI=$O(^ICDS("F",80,ICDI)) Q:+ICDI'>0  D
 . N ICDS,ICDSD S ICDS=$G(^ICDS(ICDI,0)),ICDSD=$P(ICDS,"^",4) Q:ICDSD'?7N
 . S:ICDSD<(ICDD+.0001) ICDTY=$P($P(ICDS,"^",1)," ",1) S:$L(ICDTY,"-")=2 ICDTY=$P(ICDTY,"-",1,2)
 S:'$L(ICDTY) ICDTY="ICD" S DIR("A")=" Select ICD Code Type:  " S ICDDIR=$$TRIM($G(ICDDIR))
 S DIR("A",1)=" Select one of the following:"
 S:$L($G(ICDDIR)) DIR("A",1)=" "_$G(ICDDIR) K ICDDIR
 S DIR("A",2)=" "
 S DIR("A",3)="     1   "_ICDTY_" Diagnosis Code"
 S DIR("A",4)="     2   "_ICDTY_" Operations/Procedures Code"
 S DIR("A",5)=" "
 S DIR(0)="NAO^1:2:0"
 S DIR("PRE")="S:X[""?"" X=""??""",(DIR("?"),DIR("??"))="^D DPH^ICDEXA3"
 D ^DIR Q:'$L($G(X)) "-1^No Selection"  Q:$D(DIROUT) "^^" Q:$D(DTOUT)!($D(DUOUT)) "^"
 S:"^80^80.1^"[("^"_ICDO_"^") X=ICDO
 Q X
DPH ; File Help
 W !,?5,"This response must be a number from 1 to 2."
 Q
 ;
FIT(FILE,FMT) ; File Input Transform
 N ICDF,ICDT,ICDO S ICDF=$G(FILE),ICDT=+($G(FMT)) Q:'ICDT&(ICDF["^^") "^^"  Q:'ICDT&(ICDF["^") "^"
 S ICDO="" S:ICDF["?" ICDO="??" Q:'ICDT&($L(ICDO)) ICDO
 S:ICDF="80"!(ICDF="1")!(ICDF="30")!(ICDF["ICD9")!(ICDF["ICD-9")!(ICDF["DX")!(ICDF["DIAG")!(ICDF="ICD")!(ICDF="10D") ICDO=1
 S:ICDF="80.1"!(ICDF="2")!(ICDF="31")!(ICDF["ICD0")!(ICDF["ICP")!(ICDF["OP")!(ICDF["PR")!(ICDF["PROC")!(ICDF="ICP")!(ICDF="10P") ICDO=2
 S:ICDT ICDO=$S(ICDO=1:80,ICDO=2:80.1,1:"")
 Q ICDO
TRIM(X,Y) ; Trim Character
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
