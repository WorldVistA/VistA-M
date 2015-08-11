DGPTIC10 ;ALB/AAS - PTF API TO ICD10 Remediation calls ;9/29/2011
 ;;5.3;Registration;**850,905**;Aug 13, 1993;Build 2
 ;
 ; CODEC^ICDEX     ICR 5747
 ; VLT^ICDEX       ICR 5747
 ;
GETCODSY(CSYS,IEN,DATE) ; -- RETURN IF THIS IS ICD9 OR ICD10
 ; returns 20th piece of call to ICDDATA^ICDxcode
 Q $P($$ICDDATA^ICDXCODE(CSYS,IEN,DATE),"^",20)
 ;
 ;; ICDINFO^DGAPI
 ;
IMPDATE(CODESYS) ; - calls IMPDATE^LEXU(CODESYS)
 ;  CODESYS: 10D = diagnosis, 10P = procedure
 ; -- For testing, enter a valid date in MAS Parameter file, 
 ;    fields 50001 a 50002.  The two dates resolve the issue of collecting ICD-10
 ;    code earlier than their implementation and for storing them in fields that check
 ;    to see if they are active.  (Codes become active on 10/1/2013 currently)
 ;   
 ; -- The ICD-10 Implementation date (50001) allows setting of a test implementation date.
 ; -- The ICD-10 Active Date will be used in calls to test if the code is active on this date.
 ;    
 N TEST,IMPDATE
 S TEST=$G(^DG(43,1,"ICD10"))
 I +TEST?7N Q TEST
 I $G(CODESYS)="" S CODESYS="10D"
 S IMPDATE=$$IMPDATE^LEXU($G(CODESYS))
 Q IMPDATE
 ;
 ;
EFFDATE(DGPTF,DGTYPE,DGMOVE,DGCSYS) ;-- build ICD-10 Implementation date / effective date
 N DGTEMP,X,Y,I,J,DGFEE
 S:$G(DGTYPE)="" DGTYPE=$P($G(X1),U,2)
 I $G(DGCSYS)="" S DGCSYS="10D"
 I $G(DGPTF)="" S (DGPTDAT,EFFDATE)=DT G EQ
 I $G(DGTYPE)="" S DGTYPE="701"
 I (DGTYPE'="501")&(DGTYPE'="601")&(DGTYPE'="701")&(DGTYPE'="801") S DGTYPE="701"
 I $G(DGMOVE)="" S DGMOVE=1
 ;Add 801 logic - uses CPT/Record date for EFFDATE
 S:DGTYPE'="801" (DGPTDAT,EFFDATE)=$$GET7DATE^DGPTIC10(DGPTF)
 S:DGTYPE="801" (DGPTDAT,DGCPTDT,EFFDATE)=$$GET8DATE($G(DGPTF))
EQ S DGTEMP=$$IMPDATE^DGPTIC10(DGCSYS)
 S IMPDATE=$P(DGTEMP,U,1)
 I DGPTDAT'<IMPDATE,+$P(DGTEMP,U,2)?7N S EFFDATE=+$P(DGTEMP,U,2)
 Q
 ;
EFFDAT1(DGPTDAT) ;-- build ICD-10 Implementation date / effective date
 N DGTEMP,DGFEE
 Q:$G(DGPTDAT)=""
 S DGTEMP=$$IMPDATE^DGPTIC10("10D")
 S EFFDATE=+$E(DGPTDAT,1,7)
 S IMPDATE=$P(DGTEMP,U,1)
 I DGPTDAT'<IMPDATE,+$P(DGTEMP,U,2)?7N S EFFDATE=+$P(DGTEMP,U,2)
 Q
 ;
CODESYS(PTFIEN) ; returns coding system for a PTF Based on Discharge Date
 ; -- called from DG701 template
 N DISDATE,X,Y,DGFEE
 I '$D(^DGPT($G(PTFIEN),0)) Q $$GETCODS("10D",DT)
 ;
 ; -- Census Date
 ; -- Currently a census record
 S PTR=$P($G(^DGPT(PTFIEN,0)),U,13) I PTR'="" S DISDATE=$P($G(^DG(45.86,PTR,0)),U,1) G:DISDATE'="" CSQ
 ; -- requires a census
 S PTF=PTFIEN D:'$D(DGPMCA) PM^DGPTUTL ; -- gets admission in DGPMCA and 0th node in DGPMAN
 ;905 D CEN^DGPTC1
 N DGSAVE S DGSAVE=$G(DGPTF0) D CEN^DGPTC1 S DGPTF0=DGSAVE
 ; -- DGCST=Census Status, dgcn=ien of census date file
 I $D(DGCST),DGCST=0,DGCN>0 S DISDATE=$P($G(^DG(45.86,DGCN,0)),U,1) G:DISDATE?7N CSQ
 ;
 S DISDATE=+$E($P($G(^DGPT($G(PTFIEN),70)),"^",1),1,7)
 I DISDATE<1 S DISDATE=DT
CSQ Q $$GETCODS("10D",DISDATE)
 ;
GETCODS(CODESYS,DATE) ; - Returns coding system for a date
 N IMPDATE,VERSION,DGFEE
 S IMPDATE=+$$IMPDATE(CODESYS)
 I +IMPDATE>0 D
 . I DATE<IMPDATE S VERSION="ICD9" Q
 . I DATE'<IMPDATE S VERSION="ICD10"
 I $G(VERSION)'="" Q VERSION
 Q "ICD9"
 ;
GET8DATE(PATNUM) ; GET CPT RECORD DATE FOR 801 SERVICE
 S EFFD=+$G(DGPRD)
 I EFFD="",$G(DGZP),$D(^DGPT(PATNUM,"C",DGZP,0))#10 S EFFD=+^DGPT(PATNUM,"C",DGZP,0)
 S:EFFD="" EFFD=DT
 Q $P(EFFD,U,1)
 ;
GET7DATE(PATNUM) ; FROM icdgtdrg
 ;Find the correct "EFFECTIVE DATE" for locating the icd codes for 701 fields
 ;
 ;  Input:    PATNUM - PTF Record Number
 ;  Output:   "effective date" to use
 ;
 N EFFD,PTR,IMPDATE,ADMDATE,PTF,X,Y,DGFEE
 S ADMDATE=$P($G(^DGPT(PATNUM,0)),U,2)
 ;
 ; -- Census Date
 ; -- Currently a census record
 S PTR=$P($G(^DGPT(PATNUM,0)),U,13) I PTR'="" S EFFD=$P($G(^DG(45.86,PTR,0)),U,1) G:EFFD'="" G7OUT
 ; -- requires a census
 S PTF=PATNUM D:'$D(DGPMCA) PM^DGPTUTL ; -- gets admission in DGPMCA and 0th node in DGPMAN
 ;905 D CEN^DGPTC1
 N DGSAVE S DGSAVE=$G(DGPTF0) D CEN^DGPTC1 S DGPTF0=DGSAVE
 ; -- DGCST=Census Status, dgcn=ien of census date file
 I $D(DGCST),DGCST=0,DGCN>0 S EFFD=$P($G(^DG(45.86,DGCN,0)),U,1) G:EFFD?7N G7OUT
 ;
 ;  Discharge Date
 S DISDATE=$E($P($G(^DGPT(PATNUM,70)),U,1),1,7)
 I DISDATE'="" S EFFD=$P(DISDATE,".") G G7OUT
 I DISDATE="" S EFFD=DT G G7OUT
 ;  Default TODAY
 I $G(EFFD)="" S EFFD=DT
G7OUT Q EFFD
 ;
GET5DATE(PATNUM,MOVE) ; FROM icdgtdrg
 ;Find the correct "EFFECTIVE DATE" for locating the icd codes for 501 fields
 ;
 ;  Input:    PATNUM - PTF Record Number
 ;            MOVE   - PTF Movement Number
 ;  Output:   "effective date" to use
 ;
 N EFFD,PTR,IMPDATE,MOVDATE,X,Y,DGFEE
 ;  Census Date
 S PTR=$P($G(^DGPT(PATNUM,0)),U,13) I PTR'="" S EFFD=$P($G(^DG(45.86,PTR,0)),U,1) G:EFFD'="" G5OUT
 ; -- requires a census
 S PTF=PATNUM D:'$D(DGPMCA) PM^DGPTUTL ; -- gets admission in DGPMCA and 0th node in DGPMAN
 ;905 D CEN^DGPTC1
 N DGSAVE S DGSAVE=$G(DGPTF0) D CEN^DGPTC1 S DGPTF0=DGSAVE
 ; -- DGCST=Census Status, dgcn=ien of census date file
 I $D(DGCST),DGCST=0,DGCN>0 S EFFD=$P($G(^DG(45.86,DGCN,0)),U,1) G:EFFD?7N G7OUT
 ;
 ;  Discharge Date
 S DISDATE=$E($P($G(^DGPT(PATNUM,70)),U,1),1,7)
 S MOVDATE=$P($G(^DGPT(PATNUM,"M",MOVE,0)),U,10)
 I DISDATE'="" S EFFD=$P(DISDATE,".") G G5OUT
 ;  Default TODAY
 S EFFD=DT
G5OUT ;
 Q EFFD
 ;
GET6DATE(PATNUM,PROC,DGI) ; FROM icdgtdrg
 ;Find the correct "EFFECTIVE DATE" for locating the icd codes for 601 fields
 ;
 ;  Input:    PATNUM - PTF Record Number
 ;            PROC   - Procedure or Surgery number
 ;            DGI    - 5- PROCEDURE NODE, 8 = SURGERY NODE
 ;  Output:   "effective date" to use
 ;
 N EFFD,PTR,IMPDATE,MOVDATE,X,Y,DGFEE
 I '$G(PATNUM) S PATNUM=$G(PROC)
 I '$G(PATNUM) S EFFD=DT G G6OUT
 ;  Census Date
 S PTR=$P($G(^DGPT(PATNUM,0)),U,13) I PTR'="" S EFFD=$P($G(^DG(45.86,PTR,0)),U,1) G:EFFD'="" G6OUT
 ; -- requires a census
 S PTF=PATNUM D:'$D(DGPMCA) PM^DGPTUTL ; -- gets admission in DGPMCA and 0th node in DGPMAN
 ;905 D CEN^DGPTC1
 N DGSAVE S DGSAVE=$G(DGPTF0) D CEN^DGPTC1 S DGPTF0=DGSAVE
 ; -- DGCST=Census Status, dgcn=ien of census date file
 I $D(DGCST),DGCST=0,DGCN>0 S EFFD=$P($G(^DG(45.86,DGCN,0)),U,1) G:EFFD?7N G7OUT ; DGCNO=0th node
 ;
 ;  Discharge Date
 S DISDATE=$E($P($G(^DGPT(PATNUM,70)),U,1),1,7)
 ;
 I $G(DGI)=1 S MOVDATE=$S(DISDATE'="":DISDATE,1:DT)
 I $G(DGI)=5 S MOVDATE=$P($G(^DGPT(PATNUM,"P",PROC,0)),U,1)
 I $G(DGI)=8 S MOVDATE=$P($G(^DGPT(PATNUM,"S",PROC,0)),U,1)
 I DISDATE'="" S EFFD=$P(DISDATE,".") G G6OUT
 S EFFD=DT
G6OUT ;
 Q EFFD
 ;
GETCDATE(PATNUM,CPT) ;
 ;Find the correct "EFFECTIVE DATE" for CPT Procedures
 ;
 ;  Input:    PATNUM - PTF Record Number
 ;            cpt    - CPT Entry Number
 ;  Output:   "effective date" to use
 ;
 N EFFD,PTR,IMPDATE,MOVDATE,X,Y,DGFEE
 ;  Census Date
 S PTR=$P($G(^DGPT(PATNUM,0)),U,13) I PTR'="" S EFFD=$P($G(^DG(45.86,PTR,0)),U,1) G:EFFD'="" GCOUT
 ; -- requires a census
 S PTF=PATNUM D:'$D(DGPMCA) PM^DGPTUTL ; -- gets admission in DGPMCA and 0th node in DGPMAN
 ;905 D CEN^DGPTC1
 N DGSAVE S DGSAVE=$G(DGPTF0) D CEN^DGPTC1 S DGPTF0=DGSAVE
 ; -- DGCST=Census Status, dgcn=ien of census date file
 I $D(DGCST),DGCST=0,DGCN>0 S EFFD=$P($G(^DG(45.86,DGCN,0)),U,1) G:EFFD?7N G7OUT
 ;
 ;  Discharge Date
 S DISDATE=$E($P($G(^DGPT(PATNUM,70)),U,1),1,7)
 I DISDATE'="" S EFFD=$P(DISDATE,".") G GCOUT
 ;  Default TODAY
 S EFFD=DT
GCOUT ;
 Q EFFD
 ;
GETLABEL(EVDATE,CODESYS) ; returns ICD label for printing
 ; CODESYS - D for diagnosis or P for  Procedures
 ; EVDATE - event date to use for determine label (discharge, movement date, etc.
 N ICDVER
 S ICDVER=""
 I CODESYS="D" S ICDVER=" (ICD-10-CM)"  I EVDATE<$P($$IMPDATE("10D"),U,1) S ICDVER=" (ICD-9-CM)"
 I CODESYS="P" S ICDVER=" (ICD-10-PCS)"  I EVDATE<$P($$IMPDATE("10P"),U,1) S ICDVER=" (ICD-9-CM)"
 Q ICDVER
 ;
DISPLY(FILE,IEN,DATE,FRMT) ; -- return the Code - Description for a code
 N CODE,DESC
 I $G(FILE)="DIAG"!($G(FILE)="ICD")!($G(FILE)="10D") S FILE=80
 I $G(FILE)="PROC"!($G(FILE)="ICP")!($G(FILE)="10P") S FILE=80.1
 I $G(FILE)'=80&($G(FILE)'=80.1) Q ""
 I $G(IEN)<1 Q ""
 I $G(FRMT)="" S FRMT=1
 I FRMT'=1&(FRMT'=2) S FRMT=1
 S CODE=$$CODEC^ICDEX(FILE,IEN)
 S DESC=$$VLT^ICDEX(FILE,IEN,$G(DATE))
 ;
 I $G(CODE)=""!($P($G(CODE),"^")=-1) S CODE="****"
 I $G(DESC)=""!($P($G(DESC),"^")=-1) S DESC="********************"
 I $G(FRMT)=1 Q $E(CODE_"      ",1,9)_DESC
 I $G(FRMT)=2 Q DESC_"("_CODE_")"
 Q "****   **********************"
 ;
WRITECOD(FILE,IEN,DATE,FRMT,RETURN,TAB) ;
 N I,X,X1,DGIOM,TAB1,TAB2,DGPARSE,DGPARSE2,DGSPACE,SIZE,DGSPACE2
 S TAB=+$G(TAB),RETURN=+$G(RETURN)
 S:TAB>20 TAB=20
 S SIZE=$S(TAB<1:4,1:TAB)
 S RETURN=$S(RETURN=0:"$C(0)",RETURN=1:"!",RETURN=2:"!!",RETURN=3:"!!!",1:"!")
 S DGIOM=+$G(IOM) I DGIOM<40 S DGIOM=80
 ;
 S X=$$DISPLY($G(FILE),$G(IEN),$G(DATE),$G(FRMT))
 I ($L(X)+SIZE)<DGIOM W @RETURN,?TAB,X Q
 ;
 S DGPARSE=DGIOM-TAB ; Find the place to start moving backwards looking for a space
 I TAB<1 S DGPARSE=DGPARSE-4
 ;
 F I=DGPARSE:-1:10 I $E(X,I)=" " Q
 S DGSPACE=I ; this is the space
 ;
 I FRMT=1 S TAB1=$F(X," ") D
 . S I=0 F  S I=$F(X," ",TAB1) Q:I'=(TAB1+1)  S TAB1=I
 . S TAB2=TAB1+1
 I FRMT'=1 S TAB2=TAB+3
 ;
 I ($L(X)+SIZE)>79 W @RETURN,?TAB,$E(X,1,DGSPACE) D
 . I (TAB2+$L($E(X,DGSPACE+1,$L(X))))<DGIOM D  Q
 .. W !,?TAB2,"  ",$E(X,DGSPACE+1,$L(X))
 . ;
 . S DGPARSE=DGIOM-TAB2-3
 . S X1=$E(X,DGSPACE+1,$L(X))
 . ;
 . F I=DGPARSE:-1:1 I $E(X1,I)=" " Q
 . S DGSPACE2=I
 . W !,?TAB2,"  ",$E(X1,1,DGSPACE2)
 . W !,?TAB2,"  ",$E(X1,DGSPACE2+1,$L(X1)) Q
 Q
 ;
PREV ;
 Q
 ;
ICDNAME() ; -- Called from PTF EXPANDED CODE file (45.89) field Name (#200)
 ; -- Determines ICD Code name using supported API's
 ;    Replaces direct global reads in computed Expression
 ;
 Q:'+$G(D0)&'+$G(DA)
 I '+$G(D0) S D0=DA
 N ENTRY,TYPE,X
 S X=""
 S ENTRY=$P($G(^DIC(45.89,D0,0)),U,2),VERSION=$P($G(^DIC(45.89,D0,0)),U,5)
 Q:'+$G(ENTRY) X
 S TYPE=$P(ENTRY,";",2),VERSION=$P(^DIC(45.89,D0,0),U,5)
 I TYPE="ICD9(" S X=$$VLT^ICDEX(80,+ENTRY)
 I TYPE="ICD0(" S X=$$VLT^ICDEX(80.1,+ENTRY)
 Q X
 ;
INPUT() ; - Input transform for 27.27;9  S X=$$INPUT^DGPTIC10() K:X<1 X
 N ICDVER,CAT
 S CAT=$P(^(0),U,2) S Y(0)=$S(CAT="D":80,CAT-"P":80.1,1:"")
 S ICDVER=$S(CAT="D":"10D",1:"10P")
 D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q X
DATERANG ; Get an ICD-10 compliant date range
 N IMPDATE,DGSDATE ;
 S IMPDATE=+$$IMPDATE^DGPTIC10("10D")
 W !!,"ICD-10 Implementation Date: ",$$FMTE^XLFDT(IMPDATE),!
 S DGSDATE=$$SDAT() G:DGSDATE<1 DRQ
 S DGEDATE=$$TDAT(DGSDATE)
 ;G:EDATE<1 DRQ
DRQ ;
 ;
SDAT() ; ask for start date
 N Y,DIR,DTOUT,DUOUT
 S DIR(0)="D^:"_DT_":EX",DIR("A")="Start Date"
 D ^DIR K DIR
 Q:$D(DTOUT)!($D(DUOUT)) -1
 Q Y
TDAT(DGSDAT) ; ask for end date
 N Y,DIR,DTOUT,DUOUT
 S DIR(0)="D^"_DGSDAT_":"_DT_":EX",DIR("A")="End Date"
 I '$D(IMPDATE) S IMPDATE=+$$IMPDATE^DGPTIC10("10D")
 I DGSDAT<IMPDATE,DT'<IMPDATE D
 . W !!,?10,"Start date is before ICD-10 implementation.",!,?10,"End date must be before ICD-10 implementation",!
 . S DIR(0)="D^"_DGSDAT_":"_$$FMADD^XLFDT(IMPDATE,-1)_":EX"
 D ^DIR K DIR
 Q:$D(DTOUT)!($D(DUOUT)) -1
 Q Y
 ;
CENSUS(DGPTF) ; display warning to user for ICD-10 transition census records
 ; -- do not remove this procedure from the routine
 ; -- called by input templates DG401, DG501, DG501F, DG601, and DG701
 ;
 ;
 Q
 N X,Y,CENDATE,EFFDATE,IMPDATE,DGPTDAT
 ;
 Q:'$D(PTF)  ; -- Called directly from fileman, no variable set up.
 ;
 ; -- Get census status (DGCST) and ien of census date (DGCN)
 ;905 D CEN^DGPTC1
 N DGSAVE S DGSAVE=$G(DGPTF0) D CEN^DGPTC1 S DGPTF0=DGSAVE
 ;
 I '$D(DGCST) G CENSUSQ
 I $G(DGCST)>0 G CENSUSQ ; status no longer open
 ;
 ; -- DGCST=Census Status, dgcn=ien of census date file
 I $D(DGCST),DGCST=0,DGCN>0 S CENDATE=$P($G(^DG(45.86,DGCN,0)),U,1)
 D EFFDATE(DGPTF)
 I CENDATE<IMPDATE,DT'<IMPDATE D
 . W !!,?5,"Note: This PTF record is OPEN for CENSUS."
 . W !,?7,"Census requires ICD-9 codes."
 . W !,?7,"PTF will require ICD-10 codes after the census is closed.",!
CENSUSQ ;
 Q
 ;
