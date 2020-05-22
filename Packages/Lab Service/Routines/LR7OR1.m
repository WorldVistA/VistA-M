LR7OR1 ;DALIO/JMC - Get Lab results ; 3/29/19 8:11am
 ;;5.2;LAB SERVICE;**121,187,219,230,256,310,340,348,350,427,459,519,534**;Sep 27, 1994;Build 1
 ;Reference to ^DPT supported by DBIA #10035
 ;Reference to $$FMADD^XLFDT supported by IA #10103
 ;
RR(DFN,ORD,SDATE,EDATE,SUB,TEST,FLAG,COUNT,SPEC,UNVER) ;Get LAB results for patient
 ;DFN = Patient DFN, ptr to file 2 (Required)
 ;ORD = Lab Link from OE/RR (ORPK node) (Optional)
 ;SDATE = start date to begin search in fileman format (Optional)
 ;EDATE = end date to end search in fileman format (Optional)
 ;SUB =set to CH,MI,AP or ALL to specify lab (Optional)
 ;    subsection. A null entry will imply ALL.
 ;TEST = Test to do lookup on (Optional). A null parameter will get all tests
 ;FLAG = L for local test ID, N for National test ID (Optional)
 ;    this is specified for both input and output
 ;COUNT =Count of results to return. Each Date/time counts as 1 (optional)
 ;SPEC =ptr file 61 to specify specimen (optional).
 ;      If specified, no AP results are returned.
 ;UNVER =1 to include unverified data
 ;Output is set in ^TMP("LRRR",$J,dfn,subscript,inverse d/t,seq)=
 ; testID^result^flag^units^refrange^resultstatus(F or P)^^^natlCode^natlName^system^Verifyby^^Theraputicflag(T or "")^PrintName^Accession^Order#^Specimen
 ;
 N LRDFN,LRDPF,SEX,AGE,DOB,ORDT,ORSN,II,III,DRAW,TSTY,SS,CT1
 N LRORID,LRORIDX,LRID,LRORIDF,LRD1,LRD2,LRAN,LRUID,LRI
 N LRDTST,LRORU,LRAA,LRSD,LRSA,LRSN,LRORNST
 ;
 Q:'$G(DFN)
 S LRDFN=$$LRDFN(DFN),LRDPF="2^DPT("
 Q:'LRDFN
 ;
 S SEX=$P($G(@("^"_$P(LRDPF,"^",2)_+DFN_",0)")),"^",2)
 S DOB=$P($G(@("^"_$P(LRDPF,"^",2)_+DFN_",0)")),"^",3),AGE=$S($D(DT)&(DOB?7N):DT-DOB\10000,1:"??")
 D DTRNG
 S SUB=$S($G(SUB)="ALL":"CHMIAP",$L($G(SUB)):SUB,1:"CHMIAP"),FLAG=$S('$L($G(FLAG)):"L",1:FLAG)
 ;
 I SUB["CH",$D(ORID) S LRORID=ORID,LRORIDX=0 D
 . I $G(LRORID)<1,$D(ID) S LRORID=+ID
 . I $D(LRORID) S LRORID=+LRORID
 . I $D(ID) S LRID=+ID
 ;
 I $G(TEST),FLAG="L",'$D(^LAB(60,TEST)) Q  ;No-Match on Local testID
 I $G(TEST),FLAG="N" S TEST=$O(^LAB(60,"AC",TEST,0)) Q:'TEST  ;No-Match on National testID
 I $G(TEST) S SUB=$P(^LAB(60,TEST,0),"^",4) Q:'$L(SUB)  ;Test with no subscript
 ;
 K ^TMP("LRRR",$J),^TMP("LRAPI",$J) F LRI="LRPLS","LRPLS-ADDR" K ^TMP(LRI,$J)
 ;
 S COUNT=$S($G(COUNT):COUNT,1:9999999),CT1=1
 ;
CV ;Check variables to see if called by OR; build array of tests (LR519)
 I SUB["CH",$D(LRORID) S LRORIDX=0 D
 . S LRD1=9999999-$$FMADD^XLFDT(9999999-SDATE,14),LRD2=9999999-$$FMADD^XLFDT(9999999-EDATE,-14)
 . F  S LRD1=$O(^LR(LRDFN,"CH",LRD1)) Q:LRD1<1!(LRD1>LRD2)  D
 . . S LRDTST=^LR(LRDFN,"CH",LRD1,0),LRORU=$G(^LR(LRDFN,"CH",LRD1,"ORU")) Q:LRORU=""
 . . S ^TMP("LRORID",$J,+LRDTST)=$P(LRDTST,U,6)_U_$P(LRDTST,U)_U_$P(LRORU,U)
 . S LRD1=0 F  S LRD1=$O(^TMP("LRORID",$J,LRD1)) Q:LRD1<1  S LRORIDF=0 D
 . . S LRAN=^TMP("LRORID",$J,LRD1),LRUID=$P(LRAN,U,3)
 . . S LRAA=$O(^LRO(68,"C",LRUID,0))
 . . I LRAA<1 K ^TMP("LRORID",$J,LRD1) Q
 . . S LRAD=$O(^LRO(68,"C",LRUID,LRAA,0))
 . . I LRAD<1 K ^TMP("LRORID",$J,LRD1) Q
 . . S LRSA=$O(^LRO(68,"C",LRUID,LRAA,LRAD,0))
 . . I LRSA<1 K ^TMP("LRORID",$J,LRD1) Q
 . . I $G(^LRO(68,LRAA,1,LRAD,1,LRSA,.2))=$P(LRAN,U) D
 . . . S LRSD=$P(^LRO(68,LRAA,1,LRAD,1,LRSA,0),U,4),LRSN=$P(^(0),U,5)
 . . . ;S LRON=^LRO(68,LRAA,1,LRAD,1,LRSA,.1)
 . . . S LRORNST=$P($G(^LRO(69,LRSD,1,LRSN,2,0)),U,3)  Q:LRORNST<1
 . . . F LRI=1:1:LRORNST I $P($G(^LRO(69,LRSD,1,LRSN,2,LRI,0)),U,7)=LRORID S LRORIDF=1 Q
 . . I 'LRORIDF K ^TMP("LRORID",$J,LRD1)
 . S LRD1=0 F  S LRD1=$O(^TMP("LRORID",$J,LRD1)) Q:LRD1<1  D
 . . S ^TMP("LRORID",$J,"O",9999999-LRD1)=^TMP("LRORID",$J,LRD1) K ^TMP("LRORID",$J,LRD1)
 . . S ^TMP("LRORID",$J)=$G(^TMP("LRORID",$J))+1
 I $G(ORD) S ORDT=0 D  Q
 . I $G(TEST) Q:'$D(^LAB(60,TEST,0))  S X=^(0) I $P(X,"^",4)="CH" D
 . . I $P(X,"^",5)'="" S TSTY($P($P(X,"^",5),";",2))=TEST
 . . I $P(X,"^",5)="" D EN^LR7OU1(TEST)
 . I ORD["^" S ORDT=$P(ORD,"^"),ORSN=$P(ORD,"^",2) I ORDT,ORSN D SN Q  ;OE/RR 2.5 unconverted orders
 . I ORD'[";" F  S ORDT=$O(^LRO(69,"C",ORD,ORDT)) Q:ORDT<1  S ORSN=0 F  S ORSN=$O(^LRO(69,"C",ORD,ORDT,ORSN)) Q:ORSN<1  D SN ;Early CPRS when only LR# stored
 . I ORD[";" S ORDT=$P(ORD,";",2),ORSN=$P(ORD,";",3) I ORDT,ORSN D SN
AGAIN ;First: get a CH entry; process; then check for another test (LR519)
 I SUB["CH",$D(LRORID) S LRORIDX=$O(^TMP("LRORID",$J,"O",0)) I LRORIDX>0 S (SDATE,EDATE)=LRORIDX K ^TMP("LRORID",$J,"O",LRORIDX)
 I SUB["CH" D CH^LR7OR2(SDATE,EDATE,$G(TEST),COUNT,$G(SPEC),$G(UNVER))
 I SUB["MI" D MI(SDATE,EDATE,COUNT,$G(SPEC))
 ;I SUB["BB" D BB(SDATE,EDATE,COUNT,$G(SPEC))
 I SUB["AP",'$G(SPEC) D AP(SDATE,EDATE,COUNT)
 I $D(^TMP("LRORID",$J)) G AGAIN:$O(^TMP("LRORID",$J,"O",0))>0 K ^TMP("LRORID",$J)
 I SUB["CH" K LRORID,LRORIDX,LRD1,LRD2,LRDTST,LRORIDF,LRAN,LRAA,LRSD,LRSA,LRAD,LRUID,LRI,LRORNST
 Q
 ;
 ;
MI(SDATE,EDATE,COUNT,SPEC) ;Get MI Subscript data
 Q:'$D(SDATE)  Q:'$D(EDATE)  Q:'$D(COUNT)  Q:'$D(CT1)
 K ^TMP("LRX",$J)
 S IVDT=SDATE F  S IVDT=$O(^LR(LRDFN,"MI",IVDT)) Q:IVDT<1!(IVDT>EDATE)!(CT1>COUNT)  K LRX S CTR=99,CT1=CT1+1 D MI^LR7OB63A(SPEC) M ^TMP("LRRR",$J,DFN,"MI",IVDT)=^TMP("LRX",$J,69,99,63)
 K ^TMP("LRX",$J)
 Q
 ;
 ;
BB(SDATE,EDATE,COUNT,SPEC) ;Get BB Subscript data
 Q
 Q:'$D(SDATE)  Q:'$D(EDATE)  Q:'$D(COUNT)  Q:'$D(CT1)
 K ^TMP("LRX",$J)
 S IVDT=SDATE F  S IVDT=$O(^LR(LRDFN,"BB",IVDT)) Q:IVDT<1!(IVDT>EDATE)!(CT1>COUNT)  K LRX S CTR=99,CT1=CT1+1 D BB1^LR7OB63(SPEC) M ^TMP("LRRR",$J,DFN,"BB",IVDT)=^TMP("LRX",$J,69,99,63)
 K ^TMP("LRX",$J)
 Q
 ;
 ;
AP(SDATE,EDATE,COUNT) ;Get AP Subscript data (EM,CY,AU,SP)
 N LRSS K ^TMP("LRX",$J)
 Q:'$D(SDATE)  Q:'$D(EDATE)  Q:'$D(COUNT)  Q:'$D(CT1)
 S CTR=99 D AU^LR7OB63D M ^TMP("LRRR",$J,DFN,"AU")=^TMP("LRX",$J,69,99,63)
 F LRSS="EM","CY","SP" S IVDT=SDATE F  S IVDT=$O(^LR(LRDFN,LRSS,IVDT)) Q:IVDT<1!(IVDT>EDATE)!(CT1>COUNT)  K LRX S CTR=99,CT1=CT1+1 D SS^LR7OB63C(LRSS) M ^TMP("LRRR",$J,DFN,LRSS,IVDT)=^TMP("LRX",$J,69,99,63)
 K ^TMP("LRX",$J)
 Q
 ;
 ;
TEST ;Test the RR entry point
 N X1,X2,X3,X4,X5,DIC,%DT,X,Y
 K ^TMP("LRRR",$J),^TMP("LRAPI",$J) S (X1,X2,X3,X4,X5)=""
 D ^LRDPA Q:'DFN
O1 W !,"Select Lab Order #: " R X:DTIME Q:'$T!(X["^")
 I $L(X),'$D(^LRO(69,"C",X)) W !!,X_" is not a valid order number." G O1
 I $L(X),$D(^LRO(69,"C",X)) S X5=X,DIC=60,DIC(0)="AEQM",DIC("A")="Select Test (optional): " D ^DIC S X3=$S(Y>0:+Y,1:"") Q:Y<0&(X["^")  G T2
 S %DT="AETS",%DT("A")="Select Start Date: " D ^%DT S X1=$S(Y>0:Y,1:"") I Y<0,X["^" Q
 S %DT="AETS",%DT("A")="Select End Date: " D ^%DT S X2=$S(Y>0:Y,1:"") I Y<0,X["^" Q
 S DIC=60,DIC(0)="AEQM",DIC("A")="Look for specific Test: " D ^DIC S X3=$S(Y>0:+Y,1:"") I Y<0,X["^" Q
 I 'X3 D
T1 . W !,"Enter a lab area to search on (ALL,CH,MI,AP): " R X:DTIME Q:'$T!(X["^")
 . IF "ALLCHMIAP"'[X W !!,"Bad input, enter ALL, CH, MI, or AP" G T1
 . S X4=$S("ALLCHMIAP"[X:X,1:"")
T2 D RR(DFN,X5,X1,X2,X4,X3)
 W !!,$S($D(^TMP("LRRR",$J)):"Data found!",1:"NO Data found!")
 Q
 ;
 ;
DTRNG ; Date range setup
 I $G(EDATE)<$G(SDATE) S X=EDATE,EDATE=SDATE,SDATE=X
 I $G(EDATE) S EDATE=$S($L(EDATE,".")=2:EDATE+.000001,1:EDATE+1)
 ;I $G(SDATE) S SDATE=$S($L(SDATE,".")=2:SDATE-.000001,1:SDATE)
 S SDATE=$S($G(SDATE):9999999-SDATE,1:9999999),EDATE=$S($G(EDATE):9999999-EDATE,1:1)
 S X=EDATE,EDATE=SDATE,SDATE=X
 Q
 ;
 ;
SN ; Get the subs
 ;
 N I,II,III,LRPLSAVE
 ;
 ; Set flag to not print performing lab in called routines, wait for control returns to this routine.
 S LRPLSAVE=1
 ;
 D 69^LR7OB69(ORDT,ORSN) Q:'$D(^TMP("LRX",$J,69))
 ;
 ; List performing laboratories
 I $G(LRPLSAVE(0)) D
 . N CTR,IVDT
 . S CTR=LRPLSAVE(0),IVDT=0
 . F  S IVDT=$O(LRPLSAVE("CH",IVDT)) Q:IVDT<1  D
 . . D PLS^LR7OB63
 ;
 S II=0
 F  S II=$O(^TMP("LRX",$J,69,II)) Q:II<1  D
 . S DRAW=$P($G(^TMP("LRX",$J,69,II,68)),"^",4),SS=$P($G(^LRO(68,+$P(^TMP("LRX",$J,69,II),"^",4),0)),"^",2)
 . S III=0
 . F  S III=$O(^TMP("LRX",$J,69,II,63,III)) Q:III<1  I $S($D(TSTY):$D(TSTY(III)),1:1) D
 . . I $P(^TMP("LRX",$J,69,II,63,III),U,6)="" Q
 . . S I=III
 . . I $D(^TMP("LRRR",$J,DFN,SS,9999999-DRAW,I)) F  S I=I+.00000001 I '$D(^TMP("LRRR",$J,DFN,SS,9999999-DRAW,I)) Q
 . . S ^TMP("LRRR",$J,DFN,SS,9999999-DRAW,I)=^TMP("LRX",$J,69,II,63,III)
 . I $D(^TMP("LRX",$J,69,II,63,"N")),$O(^TMP("LRRR",$J,DFN,SS,9999999-DRAW,0)) M ^TMP("LRRR",$J,DFN,SS,9999999-DRAW,"N")=^TMP("LRX",$J,69,II,63,"N")
 ;
 F I="LRPLS","LRPLS-ADDR" K ^TMP(I,$J)
 Q
 ;
LRDFN(IFN,FILEROOT)  ;Get LRDFN
 ; IFN=Internal file number
 ; FILEROOT=Root of file to get LRDFN (optional) "DPT(" is default
 Q:'$G(IFN) ""
 I '$L($G(FILEROOT)) S FILEROOT="DPT("
 S X=$S($D(@("^"_FILEROOT_+IFN_",""LR"")")):+^("LR"),1:"")
 I X,'$D(^LR(X,0)) S X=""
 Q X
