ICDEXLK6 ;SLC/KER - ICD Extractor - Lookup, Miscellaneous ;12/19/2014
 ;;18.0;DRG Grouper;**57,67**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^DISV(              ICR    510
 ;    ^ICDS(              N/A
 ;    ^ICDS("F"           N/A
 ;    ^UTILITY($J         ICR  10011
 ;    ^XTMP(              SACC 2.3.2.5.2
 ;               
 ; External References
 ;    ^DIM                ICR  10016
 ;    $$GET1^DIQ          ICR   2056
 ;    ^DIR                ICR  10026
 ;    ^DIWP               ICR  10011
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed in ICDEXLK
 ;    ICDDIC0,ICDDIC00,ICDDICA,ICDDICB,ICDDICS,ICDDICW,ICDX
 ;     
DX9 ;   Fileman Lookup ICD-9 Diagnosis (interactive)
 ;
 ; This API forces the lookup in file 80 to use the ICD-9-CM
 ; coding system only by presetting the special variable ICDSYS
 ; to 1 (Coding System = ICD-9-CM)
 ; 
 N ICDSYS S ICDSYS=1 D DX
 Q
DX10 ;   Fileman Lookup ICD-10 Diagnosis (interactive)
 ;
 ; This API forces the lookup in file 80 to use the ICD-10-CM
 ; coding system only by presetting the special variable ICDSYS
 ; to 30 (Coding System = ICD-10-CM)
 ; 
 N ICDSYS S ICDSYS=30 D DX
 Q
DX ;   Fileman Lookup Diagnosis (interactive)
 ;
 ;   Variables that may be preset:
 ; 
 ;      ICDVDT     Versioning Date (Fileman format)
 ;      ICDSYS     Coding System 1 = ICD-9-CM, 30 = ICD-10-CM
 ;      ICDFMT     Display Format 1-4 (see above)
 ;      DIC("S")   Fileman Screen
 ;      DIC("W")   Executable write command
 ;      
 K X N SNAM,OVDT,OSYS,OFMT,SYSD S DIC="^ICD9(",DIC(0)="AQEM",(SYSD,SNAM)=""
 S OSYS=+($G(ICDSYS)) N ICDSYS S:$D(^ICDS("F",80,+($G(OSYS)))) ICDSYS=OSYS
 S OFMT=$G(ICDFMT) N ICDFMT S ICDFMT=OFMT S:+ICDFMT<1 ICDFMT=1 S:+ICDFMT>4 ICDFMT=1
 S OVDT=$G(ICDVDT) S:OVDT'?7N OVDT=$$DT^XLFDT N ICDVDT S ICDVDT=OVDT S:SYSD?7N&(SYSD>ICDVDT) ICDVDT=SYSD
 S:+($G(ICDSYS))>0 SNAM=$$SNAM^ICDEX(+($G(ICDSYS))),SYSD=$P($G(^ICDS(+$G(ICDSYS),0)),"^",4) S ICDSYS=+($G(ICDSYS))
 S SNAM=$P(SNAM," ",1),SNAM=$P(SNAM,"-",1,2)
 S DIC("A")="Select ICD Diagnosis:  " S:$L(SNAM) DIC("A")="Select "_SNAM_" Diagnosis:  "
 K:$$DIM($G(DIC("S")))'>0 DIC("S") K:$$DIM($G(DIC("W")))'>0 DIC("W")
 D LK^ICDEXLK K DIC
 Q
PR9 ;   Fileman Lookup ICD-9 Procedures (interactive)
 ;
 ; This API forces the lookup in file 80 to use the ICD-9 Proc
 ; coding system only by presetting the special variable ICDSYS
 ; to 2 (Coding System = ICD-9 Proc)
 ; 
 N ICDSYS S ICDSYS=2 D PR
 Q
PR10 ;   Fileman Lookup ICD-10 Procedures (interactive)
 ;
 ; This API forces the lookup in file 80 to use the ICD-10-PCS
 ; coding system only by presetting the special variable ICDSYS
 ; to 31 (Coding System = ICD-10-PCS)
 ; 
 N ICDSYS S ICDSYS=31 D PR
 Q
PR ;   Fileman Lookup Procedure (interactive)
 ;
 ;   Variables that may be preset:
 ; 
 ;      ICDVDT     Versioning Date (Fileman format)
 ;      ICDSYS     Coding System 2 = ICD-9 Proc, 31 = ICD-10-PCS
 ;      ICDFMT     Display Format 1-4 (see above)
 ;      DIC("S")   Fileman Screen
 ;      DIC("W")   Executable Write command
 ;      
 K X N SNAM,OVDT,OSYS,OFMT,SYSD S DIC="^ICD0(",DIC(0)="AQEM",(SYSD,SNAM)=""
 S OSYS=+($G(ICDSYS)) N ICDSYS S:$D(^ICDS("F",80.1,+($G(OSYS)))) ICDSYS=OSYS
 S OFMT=$G(ICDFMT) N ICDFMT S ICDFMT=OFMT S:+ICDFMT<1 ICDFMT=1 S:+ICDFMT>4 ICDFMT=1
 S OVDT=$G(ICDVDT) S:OVDT'?7N OVDT=$$DT^XLFDT N ICDVDT S ICDVDT=OVDT S:SYSD?7N&(SYSD>ICDVDT) ICDVDT=SYSD
 S:+($G(ICDSYS))>0 SNAM=$$SNAM^ICDEX(+($G(ICDSYS))),SYSD=$P($G(^ICDS(+$G(ICDSYS),0)),"^",4) S ICDSYS=+($G(ICDSYS))
 S SNAM=$P(SNAM," ",1),SNAM=$P(SNAM,"-",1,2)
 S DIC("A")="Select ICD Procedure:  " S:$L(SNAM) DIC("A")="Select "_SNAM_" Procedure:  "
 K:$$DIM($G(DIC("S")))'>0 DIC("S") K:$$DIM($G(DIC("W")))'>0 DIC("W")
 D LK^ICDEXLK K DIC
 Q
DIM(X) ;   Check MUMPS Code
 S X=$G(X) Q:'$L(X) 0  D ^DIM Q:'$D(X) 0
 Q 1
 ;
FILE(FILE,SYS) ; File
 N ROOT,TMP,Y S ROOT=$G(FILE),TMP=$$FILE^ICDEX(ROOT) Q:$D(^ICDS("F",+TMP)) TMP
 S SYS=$$SYS^ICDEX($G(SYS)),TMP=$$FILE^ICDEX(+SYS) Q:$D(^ICDS("F",+TMP)) TMP
 S TMP=$$FILN($G(FILE)) Q:$D(^ICDS("F",+TMP)) TMP
 N DIR,DTOUT,DUOUT,DIROUT,DIRUT S DIR(0)="SAO^DX:ICD DIAGNOSIS;PR:ICD OPERATION/PROCEDURE"
 S DIR("A")=" Select ICD File:  ",DIR("PRE")="S X=$$FILT^ICDEXLK6(X)" S (DIR("?"),DIR("??"))="^D FILH^ICDEXLK6"
 D ^DIR S Y=$S(Y="DX":80,Y="PR":80.1,1:-1)
 Q Y
FILT(X) ;   File Transform
 S X=$$UP^XLFSTR(X) S:X["ICD9" X="DX" S:X["ICD0" X="PR" Q:X["^^" "^^"  Q:X["^" "^"  S:X["?" X="??" Q:X["?" X
 S:X["DI"!(X["DX")!(X=80) X="DX" Q:X="DX" X  S:X["PR"!(X["OP")!(X=80.1) X="PR" Q:X="PR" X
 Q "??"
FILN(X) ;   File Number
 N NUM,TMP S NUM=0,TMP=$$UP^XLFSTR(X) S:TMP["DI"!(TMP["DX")!(TMP["ICD9")!(TMP=80) NUM=80
 S:TMP["PR"!(TMP["OP")!(TMP["ICD0")!(TMP=80.1) NUM=80.1 Q:$D(^ICDS("F",+NUM)) NUM
 Q X
FILH ;   File Help
 W:$O(^ICDS("F",0))>0 !,?4,"Select from:",!
 N FI S FI=0 F  S FI=$O(^ICDS("F",FI)) Q:+FI'>0  D
 . N CD,RT,NM S (CD,RT)="" S:FI=80 CD="DX",RT="^ICD9(" S:FI=80.1 CD="PR",RT="^ICD0("
 . S NM=$$GET1^DIQ(1,(+FI_","),.01) S:$E(NM,1,4)="ICD " NM=$P(NM,"ICD ",2)
 . W !,?10,FI,?16,CD,?20,NM,?41,RT
 Q
 ;
SYS(FILE,SYS) ; System
 N DIR,DTOUT,DUOUT,DIROUT,DIRUT,ROOT,TMP,Y S ROOT=$G(FILE),TMP=$$FILE^ICDEX(ROOT),SYS=$$SYS^ICDEX($G(SYS))
 S:'$D(^ICDS("F",+TMP)) TMP=$$FILE^ICDEX(+SYS) S:'$D(^ICDS("F",+TMP)) TMP=$$FILN($G(FILE))
 S FILE="" S:$D(^ICDS("F",+TMP)) FILE=TMP Q:$D(^ICDS("F",+($G(FILE)),+($G(SYS)))) +($G(SYS))
 S SYS=$$CS^ICDEX($G(FILE)) Q:$D(^ICDS(+SYS,0)) +SYS
 Q -1
 ;
CDT(CDT,SYS) ; Date
 N DIR,DTOUT,DUOUT,DIROUT,DIRUT,ROOT,LO,NX,HI,TD,TMP,Y
 S CDT=$G(CDT),SYS=$$SYS^ICDEX($G(SYS)),LO=$$IMP^ICDEX(1)
 S NX=$$IMP^ICDEX(+($G(SYS))) S:LO?7N&(NX?7N)&(NX>LO) LO=NX S HI=$$DT^XLFDT,HI=$$FMADD^XLFDT(HI,(365*3))
 I CDT?7N S:LO?7N&(CDT<LO) CDT=LO Q:CDT=LO CDT S:HI?7N&(CDT>HI) CDT=HI Q:CDT=HI CDT
 Q:CDT?7N&(CDT'<LO)&(CDT'>HI) CDT
 S TD=$$DT^XLFDT,TMP=$TR($$UP^XLFSTR($$FMTE^XLFDT(TD)),",","") S:TD>LO&(TD<HI) DIR("B")=TMP
 S DIR(0)="DAO^"_LO_":"_HI_":EX"
 S DIR("A")=" Enter a Versioning Date:  "
 S DIR("PRE")="S X=$$CDTT^ICDEXLK6(X)" S (DIR("?"),DIR("??"))="^D CDTH^ICDEXLK6"
 D ^DIR
 Q Y
CDTT(X) ;   Date Transform
 S X=$$UP^XLFSTR(X) S:X["?" X="??" Q:X["?" X
 Q X
CDTH ;   Date Help
 W !,?5,"Enter a date to be used to determine the appropriate codes"
 W !,?5,"and terms that were in use on the date specified. ",!
 I $G(LO)?7N,$G(HI)?7N D
 . N BEG,END,MO,DY,YR S BEG=$$UP^XLFSTR($$FMTE^XLFDT($G(LO))),END=$$UP^XLFSTR($$FMTE^XLFDT($G(HI)))
 . S MO=$P(BEG," ",1),DY=+($TR($P(BEG," ",2),",","")),YR=$P(BEG," ",3)
 . W !,?5,"Date must be from ",BEG," to ",END,!
 . W !,?5,"Examples of Valid Dates:",!
 . W !,?9,MO," ",DY," ",YR," or "
 . W DY," ",MO," ",$S($L(YR)=2:YR,$L(YR)=4:$E(YR,3,4),1:"")," or "
 . W +($E(LO,6,7)),"/",$E(LO,4,5),"/",$E((1700+$E(LO,1,3)),3,4)," or "
 . W $E(LO,4,5),$E(LO,6,7),$E((1700+$E(LO,1,3)),3,4)
 I $G(LO)'?7N!($G(HI)'?7N) D
 . W !,?5,"Examples of Valid Dates:",!
 . W !,?9,"JAN 20 1957 or 20 JAN 57 or 1/20/57 or 012057"
 W !,?9,"   T   (for TODAY),  T+1 (for TOMORROW),  T+2,  T+7, etc."
 W !,?9,"   T-1 (for YESTERDAY),  T-3W (for 3 WEEKS AGO), etc.",!
 W !,?5,"This date is sometimes called the 'versioning date' (VistA) or"
 W !,?5,"the 'date service was provided to the patient' (HIPAA)"
 Q
 ;
DIC0(X) ; Correct DIC(0) for a versioned file
 ;
 ; Not used  B - There are no pointer/variable pointers
 ;               in index fields
 ;           C - Cross-Reference suppression not allowed,
 ;               entries must be unique
 ;           I - If FileMan passes control to ICDEXLK, 
 ;               then "I"gnore no longer applies
 ;           K - There is no primary Key (may change in
 ;               the future)
 ;           L - "Learn-As-You-Go" not allowed LAYGO is killed
 ;           n - Only Codes, Text and IENs are allowed.  "n"
 ;               Returns too many values
 ;           U - Only Codes, Text and IENs are allowed.
 ;           V - Verify is always required when one entry is
 ;               found
 K LAYGO S X=$G(X)  K DINUM,DLAYGO N CHR,STR F CHR="C","B","K","L","n","U","T","V","I" D
 . F  Q:X'[CHR  S X=$P(X,CHR,1)_$P(X,CHR,2,299)
 S STR="" F CHR="A","E","Q","M","F","N","O","S","X","Z" S:X[CHR STR=STR_CHR
 ;
 ;           If non-numeric, and you are going to "A" ask 
 ;           then you are going to "E" echo
 S:STR["A"&(STR'["E")&(STR'["N") STR=STR_"E"
 ;
 ;           If you are going to "E" echo, and X does not 
 ;           exist, then you will "A" ask
 S:STR["E"&(STR'["A")&('$L($G(X))) STR=STR_"A"
 S:STR'["A"&(STR'["E")&(STR'["X") STR=STR_"X"
 S X=STR
 Q X
DICU ;   Undo DIC
 S:$L($G(ICDDICW)) DIC("W")=$G(ICDDICW)
 S:$L($G(ICDDICA)) DIC("A")=$G(ICDDICA)
 S:$L($G(ICDDICB)) DIC("B")=$G(ICDDICB)
 S:$L($G(ICDDICS)) DIC("S")=$G(ICDDICS)
 S:$L($G(ICDDIC0)) DIC(0)=$G(ICDDIC0)
 S:$L($G(ICDDIC00)) DIC(0)=$G(ICDDIC00)
 Q
DIE ;   Set for DIE call
 Q:'$L($G(DIE))  S:'$L($G(DIC("A")))&($L($G(DIP))) DIC("A")=$G(DIP)
 S:$L($G(DIC("A")))&($G(DIC("A"))'[": ") DIC("A")=$G(DIC("A"))_":  "
 N DIE,DIP,DZ,X1
 Q
DICS(ICDS) ;   Check DIC("S")
 N ICDT1,ICDT2,ICDTS S ICDT1=$D(X),ICDT2=$G(X) Q:'$L($G(ICDS)) ""
 S (ICDTS,X)=$G(ICDS) D ^DIM I '$D(X) S:ICDT1>0 X=$G(ICDT2) Q ""
 S ICDS=$G(ICDTS) S:ICDT1>0 X=$G(ICDT2) S:$L($G(ICDX)) X=$G(ICDX)
 Q ICDS
 ;
SAV(X,DIC) ;   Save Defaults
 N NUM,COM,VAL,ID,CUR,FUT,FILE,ROOT,SUB Q:+($G(DUZ))'>0  Q:'$L($G(DIC))  Q:+($G(Y))'>0
 S ROOT=$$ROOT^ICDEX(DIC) Q:'$L(ROOT)  S SUB=$TR(ROOT,"^(,","") Q:'$L(SUB)
 S FILE=$$FILE^ICDEX(ROOT) Q:+FILE'>0  Q:"^80^80.1^"'[("^"_FILE_"^")
 S NUM=+($G(DUZ)) Q:+NUM'>0  Q:'$L($$GET1^DIQ(200,(NUM_","),.01))  S VAL=$G(Y) Q:'$L(VAL)
 S COM=$S(FILE=80:"DX",FILE=80.1:"PR",1:""),ID=$$TM(("ICDEXLK "_NUM_" "_COM))
 S CUR=$$DT^XLFDT,FUT=$$FMADD^XLFDT(CUR,60)
 S ^XTMP(ID,0)=FUT_"^"_CUR_"^"_"ICD "_$S(COM="DX":"Diagnosis",COM="PR":"Procedures",1:"")
 S ^XTMP(ID,SUB)=VAL S:$D(@(ROOT_+($G(Y))_",0)")) ^DISV(DUZ,ROOT)=+($G(Y))
 Q
RET(DIC) ;   Retrieve Defaults
 N NUM,COM,ID,CUR,FUT,FILE,ROOT,SUB Q:+($G(DUZ))'>0 ""  Q:'$L($G(DIC)) ""
 S ROOT=$$ROOT^ICDEX($G(DIC)) Q:'$L(ROOT) ""  S SUB=$TR(ROOT,"^(,","") Q:'$L(SUB) ""
 S FILE=$$FILE^ICDEX(ROOT) Q:+FILE'>0 ""  Q:"^80^80.1^"'[("^"_FILE_"^") ""
 S NUM=+($G(DUZ)) Q:+NUM'>0 ""  Q:'$L($$GET1^DIQ(200,(NUM_","),.01)) ""
 S COM=$S(FILE=80:"DX",FILE=80.1:"PR",1:""),ID=$$TM(("ICDEXLK "_NUM_" "_COM))
 S X=$G(^XTMP(ID,SUB)) S:+X'>0&(+($G(^DISV(NUM,ROOT)))>0) X=+($G(^DISV(NUM,ROOT)))
 Q X
PA(ICD,X) ;   Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,ICDI,ICDLEN,ICDC K ^UTILITY($J,"W") Q:'$D(ICD)
 S ICDLEN=+($G(X)) S:+ICDLEN'>0 ICDLEN=79 S ICDC=+($G(ICD)) S:+($G(ICDC))'>0 ICDC=$O(ICD(" "),-1) Q:+ICDC'>0
 S DIWL=1,DIWF="C"_+ICDLEN S ICDI=0 F  S ICDI=$O(ICD(ICDI)) Q:+ICDI=0  S X=$G(ICD(ICDI)) D ^DIWP
 K ICD S (ICDC,ICDI)=0 F  S ICDI=$O(^UTILITY($J,"W",1,ICDI)) Q:+ICDI=0  D
 . S ICD(ICDI)=$$TM($G(^UTILITY($J,"W",1,ICDI,0))," "),ICDC=ICDC+1
 S:$L(ICDC) ICD=ICDC K ^UTILITY($J,"W")
 Q
OUT(X,Y,Z,ARY) ;   Output Array
 K ARY N FILE,TERM,ROOT,IEN,FMT S ROOT=$G(X),IEN=+($G(Y)) Q:'$L(ROOT)  S FMT=$G(Z)
 Q:"^ICD9(^ICD0(^"'[("^"_$E(ROOT,2,$L(ROOT))_"^")
 S FILE=$$FILE^ICDEX(ROOT) Q:"^80^80.1^"'[("^"_FILE_"^")
 S:FMT'>0 FMT=1 S:FMT>4 FMT=1 Q:'$D(@(ROOT_IEN_",0)"))
 I +($G(FMT))=1!(+($G(FMT))=3) S TERM=$$SD^ICDEX(FILE,IEN,CDT)
 I +($G(FMT))=2!(+($G(FMT))=4) S TERM=$$LD^ICDEX(FILE,IEN,CDT)
 Q:'$L(TERM)  Q:$P(TERM,"^",1)=-1  S ARY(1)=TERM Q:+($G(FMT))=1!(+($G(FMT))=3)
 D:+($G(FMT))=2 PAR^ICDEX(.ARY,60) D:+($G(FMT))=4 PAR^ICDEX(.ARY,70)
 Q
XT(X) ;   Input Transform for X
 S X=$TR($G(X),"""","") S:X="#" X="" S X=$$TM(X,"#")
 Q X
TM(X,Y) ;   Trim Y
 S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
