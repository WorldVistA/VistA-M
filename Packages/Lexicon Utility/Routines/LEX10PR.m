LEX10PR ;ISL/KER - ICD-10 Procedure Code ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(757.033        N/A
 ;    ^UTILITY($J         ICR  10011
 ;               
 ; External References
 ;    ^DIWP               ICR  10011
 ;    $$IMP^ICDEX         ICR   5747
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;               
NEXT(LEXC,LEXA,LEXD) ; Next Allowable Character
 ;
 ; Input
 ; 
 ;   LEXC    Partial Proc Code    Required
 ;  .LEXA    Local Array (by Ref) Required
 ;   LEXD    Date (FM Format)     Optional (Default TODAY)
 ;  
 ; Output
 ; 
 ;   LEXA(<input>,0)= # of characters
 ;   LEXA(<input>,<character>)=""
 ; 
 N LEX1,LEX2,LEXCDT,LEXCHK,LEXCHR,LEXCT,LEXE,LEXLEN,LEXID,LEXNC,LEXNN
 N LEXNAM,LEXOR,LEXPRE,LEXS,LEXSO S LEXC=$$TM(LEXC) S (LEXID,LEXSO)=LEXC
 S LEXCDT=$G(LEXD) S:LEXCDT'?7N LEXCDT=$$DT^XLFDT S LEXLEN=$L(LEXC)
 I LEXLEN>6 D  Q X
 . S X="-1^Input is of Maximum length, no next character available"
 I LEXLEN>1 D
 . S LEXOR=$E(LEXSO,1,($L(LEXSO)-1))_$C($A($E(LEXSO,$L(LEXSO)))-1)_"~"
 S:LEXLEN=1 LEXOR=$C($A(LEXSO)-1)_"~" S:LEXLEN'>0 LEXOR="/~"
 S LEXCHK=0 S:LEXLEN'>0 LEXCHK=1 S:LEXLEN>0&(LEXLEN<7) LEXCHK=LEXLEN+1
 Q:+LEXCHK'>0 "-1^Character position not specified"
 S:LEXLEN=0 LEXID="<null>" S:'$L(LEXID) LEXID="<unknown>"
 S LEXNN="^LEX(757.02,""APR"","""_LEXOR_" "")"
 S LEXNC="^LEX(757.02,""APR"","""_LEXSO,LEXCT=0
 F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  D
 . N LEXC,LEXD,LEXE,LEXS,LEX1,LEX2
 . S LEXC=$P(LEXNN,",",3),LEXC=$TR(LEXC,"""",""),LEXC=$$TM(LEXC)
 . S LEXD=+($P(LEXNN,",",4)) Q:LEXD'?7N  Q:(LEXCDT+.001)'>LEXD
 . I $E(LEXC,1,$L(LEXSO))=LEXSO,$L(LEXC)'<LEXCHK D  Q
 . . N LEXCHR,LEXFUL S LEXCHR=$E(LEXC,LEXCHK) Q:'$L(LEXCHR)
 . . S LEXFUL=LEXID_LEXCHR Q:$$IS(LEXFUL)'>0
 . . I '$D(LEXA(LEXID,LEXCHR)) D
 . . . N LEXNAM S LEXNAM=$$NAM((LEXID_LEXCHR))
 . . . S LEXA(LEXID,LEXCHR)=LEXNAM,LEXCT=LEXCT+1
 . . S LEXOR=$E(LEXC,1,LEXCHK)_"~"
 . . S LEXNN="^LEX(757.02,""APR"","""_LEXOR_""")"
 S LEXNAM=$$NAM(LEXID) S:$L(LEXNAM) LEXA(LEXID)=LEXNAM
 I $L(LEXID)>1 D
 . F LEX1=($L(LEXID)-1):-1:1  D
 . . N LEXNN S LEXNN=$E(LEXID,1,LEX1),LEXNAM=$$NAM(LEXNN)
 . . S:$L(LEXNN)&($L(LEXNAM)) LEXA(LEXNN)=LEXNAM
 Q +($G(LEXCT))
NAM(X) ; Name
 N LEXC,LEXCIEN,LEXEFF,LEXNAM S LEXC=$G(X) Q:'$L(LEXC) ""
 S LEXEFF=$O(^LEX(757.033,"AFRAG",31,(LEXC_" "),(LEXCDT+.001)),-1)
 S LEXCIEN=$O(^LEX(757.033,"AFRAG",31,(LEXC_" "),LEXEFF," "),-1)
 S LEXNAM=$$SN(LEXCIEN) S X=LEXNAM
 Q X
SN(X,EFF) ; Short Name
 N IEN,CDT,IMP,EFF,HIS S IEN=+($G(X)),CDT=$G(LEXVDT) S:$G(EFF)?7N CDT=$G(EFF)
 S IMP=$$IMP^ICDEX(31) S:CDT'?7N CDT=$$DT^XLFDT S:CDT'>IMP&(IMP?7N) CDT=IMP
 S EFF=$O(^LEX(757.033,+IEN,2,"B",(CDT+.001)),-1)
 S HIS=$O(^LEX(757.033,+IEN,2,"B",+EFF," "),-1)
 S X=$G(^LEX(757.033,+IEN,2,+HIS,1))
 Q X
IS(X) ; Is a Root Code
 N LEXC,LEXL,LEXO,LEXN S LEXC=$G(X) Q:'$L(LEXC) 0  S LEXL=$L(LEXC)
 S:LEXL>1 LEXO=$E(LEXC,1,($L(LEXC)-1))_$C($A($E(LEXC,$L(LEXC)))-1)_"~"
 S:LEXL=1 LEXO=$C($A(LEXC)-1)_"~" S LEXN=$O(^LEX(757.02,"APR",(LEXOR_" ")))
 I $E(LEXN,1,LEXL)=LEXC Q 1
 Q 0
FIN(X,LEXVDT,ARY) ; Fragment Info
 ;
 ; Input
 ; 
 ;    X         IEN of Code Fragment
 ;    LEXVDT    Versioning date (busines rules apply)
 ;   .ARY       Local Array, passed by reference
 ;   
 ; Output
 ; 
 ;    $$FIN     1 on success
 ;             -1 ^ error message on error
 ;    
 ;    ARY(0)    5 piece "^" delimited strig
 ;                1  Unique Id
 ;                2  Code Fragment
 ;                3  Date Entered
 ;                4  Source
 ;                5  Details
 ;                
 ;    ARY(1)    4 piece "^" delimited string
 ;                1  Effective Date
 ;                2  Status
 ;                3  Effective Date External
 ;                4  Status External
 ;               
 ;    ARY(2)    Name/Title
 ;    ARY(3)    Description
 ;    ARY(4)    Explanation
 ;    ARY(5,0)  # of synonyms included
 ;    ARY(5,n)  included synonyms
 ;    
 N CDT,EFF,ENT,FRG,IEN,IMP,N0,NOD,NODC,NODI,REC,SAB,SRC K ARY
 S U="^",IEN=+($G(X)) Q:IEN'>0 "-1^Invalid IEN number"
 S N0=$G(^LEX(757.033,IEN,0)) Q:'$L(N0) "-1^IEN not found number"
 S SAB=$E(N0,1,3),FRG=$P(N0,U,2),ENT=$P(N0,U,3),SRC=$P(N0,U,4)
 S IMP=$$IMPDATE^LEXU(SRC) S CDT=$G(LEXVDT) S:'$L(CDT) CDT=$$DT^XLFDT
 S:CDT?7N&(IMP?7N)&(CDT<IMP) CDT=IMP
 S EFF=$O(^LEX(757.033,+IEN,1,"B",(CDT+.001)),-1)
 S REC=$O(^LEX(757.033,+IEN,1,"B",+EFF," "),-1)
 S NOD=$G(^LEX(757.033,IEN,1,+REC,0)) S ARY(0)=N0
 S ARY(0,"TXT")="Unique ID^Code Fragment^Date Entered^Source"
 S ARY(1)=NOD_"^"_$$FMTE^XLFDT($P(NOD,"^",1),"5Z")_"^"_$S($P(NOD,"^",2)="1":"Active",$P(NOD,"^",2)="0":"Inactive",1:"")
 S ARY(1,"TXT")="Effective Date^Status"
 S EFF=$O(^LEX(757.033,+IEN,2,"B",(CDT+.001)),-1)
 S REC=$O(^LEX(757.033,+IEN,2,"B",+EFF," "),-1)
 S NOD=$G(^LEX(757.033,IEN,2,+REC,1))
 S:$L(NOD) ARY(2)=NOD
 S:$L(NOD) ARY(2,"TXT")="Name/Title"
 S EFF=$O(^LEX(757.033,+IEN,3,"B",(CDT+.001)),-1)
 S REC=$O(^LEX(757.033,+IEN,3,"B",+EFF," "),-1)
 S NOD=$G(^LEX(757.033,IEN,3,+REC,1))
 S:$L(NOD) ARY(3)=NOD
 S:$L(NOD) ARY(3,"TXT")="Description"
 S EFF=$O(^LEX(757.033,+IEN,4,"B",(CDT+.001)),-1)
 S REC=$O(^LEX(757.033,+IEN,4,"B",+EFF," "),-1)
 S NOD=$G(^LEX(757.033,IEN,4,+REC,1))
 S:$L(NOD) ARY(4)=NOD
 S:$L(NOD) ARY(4,"TXT")="Explanation"
 S EFF=$O(^LEX(757.033,+IEN,5,"B",(CDT+.001)),-1)
 S REC=$O(^LEX(757.033,+IEN,5,"B",+EFF," "),-1)
 S (NODC,NODI)=0 F  S NODI=$O(^LEX(757.033,IEN,5,+REC,1,NODI)) Q:+NODI'>0  D
 . S NOD=$$TM($G(^LEX(757.033,IEN,5,REC,1,NODI,0))) Q:'$L(NOD)
 . S NODC=NODC+1 S ARY(5,0)=NODC,ARY(5,"TXT")="Include",ARY(5,NODC)=NOD
 Q 1
INF(X) ;
 N FRAG,CDT,IMP,C1,C2,ARY,IEN S C1=15,C2=26 K ARY
 S FRAG=$G(X) Q:'$L(FRAG)  S CDT=$G(LEXVDT) S:CDT'?7N CDT=$$DT^XLFDT S IMP=$$IMP^ICDEX(31)
 S IEN=$O(^LEX(757.033,"B",("10P"_FRAG),0))
 S:CDT?7N&(IMP?7N)&(CDT<IMP) CDT=IMP K ARY S X=$$FIN(IEN,CDT,.ARY)
 W:$L(FRAG) !," Fragment:",?C1,FRAG
 W:$L(FRAG) ?C2,"Character:  ",$E(FRAG,$L(FRAG))
 S TMP=$G(ARY(1)),EFF=$P(TMP,"^",3),STA=$P(TMP,"^",4)
 I $L(EFF),$L(STA) D
 . W !," Status:",?C1,STA,?C2,"Effective:  ",EFF
 S TMP=$G(ARY(2))
 I $L(TMP) D
 . N TXT,I S TXT(1)=TMP D PR(.TXT,(79-C1)) Q:'$L($G(TXT(1)))
 . W !!," Title:",?C1,$G(TXT(1))
 . S I=1 F  S I=$O(TXT(I)) Q:+I'>0  W !,?C1,$G(TXT(I))
 S TMP=$G(ARY(3))
 I $L(TMP) D
 . N TXT,I S TXT(1)=TMP D PR(.TXT,(79-C1)) Q:'$L($G(TXT(1)))
 . W !!," Definition:",?C1,$G(TXT(1))
 . S I=1 F  S I=$O(TXT(I)) Q:+I'>0  W !,?C1,$G(TXT(I))
 S TMP=$G(ARY(4))
 I $L(TMP) D
 . N TXT,I S TXT(1)=TMP D PR(.TXT,(79-C1)) Q:'$L($G(TXT(1)))
 . W !!," Explanation:",?C1,$G(TXT(1))
 . S I=1 F  S I=$O(TXT(I)) Q:+I'>0  W !,?C1,$G(TXT(I))
 N INI,INC S (INI,INC)=0  F  S INI=$O(ARY(5,INI)) Q:+INI'>0  D
 . N INT S INT(1)=$G(ARY(5,INI)) D PR(.INT,(79-C1))
 . S:$L($G(INT(1))) INC=INC+1
 . W:INC=1 !!," Include(s):" W:INC>1 ! W ?C1,$G(INT(1))
 . S I=1 F  S I=$O(INT(I)) Q:+I'>0  W !,?C1,$G(INT(I))
 Q
PR(LEX,X) ;   Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,Z,LEXC,LEXI,LEXL
 K ^UTILITY($J,"W") Q:'$D(LEX)  S LEXL=+($G(X)) S:+LEXL'>0 LEXL=79
 S LEXC=+($G(LEX)) S:+($G(LEXC))'>0 LEXC=$O(LEX(" "),-1) Q:+LEXC'>0
 S DIWL=1,DIWF="C"_+LEXL S LEXI=0
 F  S LEXI=$O(LEX(LEXI)) Q:+LEXI=0  S X=$G(LEX(LEXI)) D ^DIWP
 K LEX S (LEXC,LEXI)=0
 F  S LEXI=$O(^UTILITY($J,"W",1,LEXI)) Q:+LEXI=0  D
 . S LEX(LEXI)=$$TM($G(^UTILITY($J,"W",1,LEXI,0))," "),LEXC=LEXC+1
 S:$L(LEXC) LEX=LEXC K ^UTILITY($J,"W")
 Q
 ;
 ; Miscellaneous
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
