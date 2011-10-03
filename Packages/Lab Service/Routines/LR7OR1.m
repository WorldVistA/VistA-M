LR7OR1 ;slc/dcm - Get Lab results ;8/11/97
 ;;5.2;LAB SERVICE;**121,187,219,230,256,310,340,348**;Sep 27, 1994
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
 N LRDFN,LRDPF,SEX,AGE,DOB,ORDT,ORSN,II,III,DRAW,TSTY,SS,CT1
 Q:'$G(DFN)
 S LRDFN=$$LRDFN(DFN),LRDPF="2^DPT("
 Q:'LRDFN
 S SEX=$P($G(@("^"_$P(LRDPF,"^",2)_+DFN_",0)")),"^",2)
 S DOB=$P($G(@("^"_$P(LRDPF,"^",2)_+DFN_",0)")),"^",3),AGE=$S($D(DT)&(DOB?7N):DT-DOB\10000,1:"??")
 D DTRNG
 S SUB=$S($G(SUB)="ALL":"CHMIAP",$L($G(SUB)):SUB,1:"CHMIAP"),FLAG=$S('$L($G(FLAG)):"L",1:FLAG)
 I $G(TEST),FLAG="L",'$D(^LAB(60,TEST)) Q  ;No-Match on Local testID
 I $G(TEST),FLAG="N" S TEST=$O(^LAB(60,"AC",TEST,0)) Q:'TEST  ;No-Match on National testID
 I $G(TEST) S SUB=$P(^LAB(60,TEST,0),"^",4) Q:'$L(SUB)  ;Test with no subscript
 K ^TMP("LRRR",$J),^TMP("LRAPI",$J) S COUNT=$S($G(COUNT):COUNT,1:9999999),CT1=1
 I $G(ORD) S ORDT=0 D  Q
 . I $G(TEST) Q:'$D(^LAB(60,TEST,0))  S X=^(0) I $P(X,"^",4)="CH" D
 .. I $L($P(X,"^",5)) S TSTY($P($P(X,"^",5),";",2))=TEST
 .. I '$L($P(X,"^",5)) D EN^LR7OU1(TEST)
 . I ORD["^" S ORDT=$P(ORD,"^"),ORSN=$P(ORD,"^",2) I ORDT,ORSN D SN Q  ;OE/RR 2.5 unconverted orders
 . I ORD'[";" F  S ORDT=$O(^LRO(69,"C",ORD,ORDT)) Q:ORDT<1  S ORSN=0 F  S ORSN=$O(^LRO(69,"C",ORD,ORDT,ORSN)) Q:ORSN<1  D SN ;Early CPRS when only LR# stored
 . I ORD[";" S ORDT=$P(ORD,";",2),ORSN=$P(ORD,";",3) I ORDT,ORSN D SN
 I SUB["CH" D CH^LR7OR2(SDATE,EDATE,$G(TEST),COUNT,$G(SPEC),$G(UNVER))
 I SUB["MI" D MI(SDATE,EDATE,COUNT,$G(SPEC))
 ;I SUB["BB" D BB(SDATE,EDATE,COUNT,$G(SPEC))
 I SUB["AP",'$G(SPEC) D AP(SDATE,EDATE,COUNT)
 Q
MI(SDATE,EDATE,COUNT,SPEC) ;Get MI Subscript data
 Q:'$D(SDATE)  Q:'$D(EDATE)  Q:'$D(COUNT)  Q:'$D(CT1)
 K ^TMP("LRX",$J)
 S IVDT=SDATE F  S IVDT=$O(^LR(LRDFN,"MI",IVDT)) Q:IVDT<1!(IVDT>EDATE)!(CT1>COUNT)  K LRX S CTR=99,CT1=CT1+1 D MI^LR7OB63A(SPEC) M ^TMP("LRRR",$J,DFN,"MI",IVDT)=^TMP("LRX",$J,69,99,63)
 K ^TMP("LRX",$J) Q
BB(SDATE,EDATE,COUNT,SPEC) ;Get BB Subscript data
 Q
 Q:'$D(SDATE)  Q:'$D(EDATE)  Q:'$D(COUNT)  Q:'$D(CT1)
 K ^TMP("LRX",$J)
 S IVDT=SDATE F  S IVDT=$O(^LR(LRDFN,"BB",IVDT)) Q:IVDT<1!(IVDT>EDATE)!(CT1>COUNT)  K LRX S CTR=99,CT1=CT1+1 D BB1^LR7OB63(SPEC) M ^TMP("LRRR",$J,DFN,"BB",IVDT)=^TMP("LRX",$J,69,99,63)
 K ^TMP("LRX",$J) Q
AP(SDATE,EDATE,COUNT) ;Get AP Subscript data (EM,CY,AU,SP)
 N LRSS K ^TMP("LRX",$J)
 Q:'$D(SDATE)  Q:'$D(EDATE)  Q:'$D(COUNT)  Q:'$D(CT1)
 S CTR=99 D AU^LR7OB63D M ^TMP("LRRR",$J,DFN,"AU")=^TMP("LRX",$J,69,99,63)
 F LRSS="EM","CY","SP" S IVDT=SDATE F  S IVDT=$O(^LR(LRDFN,LRSS,IVDT)) Q:IVDT<1!(IVDT>EDATE)!(CT1>COUNT)  K LRX S CTR=99,CT1=CT1+1 D SS^LR7OB63C(LRSS) M ^TMP("LRRR",$J,DFN,LRSS,IVDT)=^TMP("LRX",$J,69,99,63)
 K ^TMP("LRX",$J) Q
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
DTRNG ;Date range setup
 I $G(EDATE)<$G(SDATE) S X=EDATE,EDATE=SDATE,SDATE=X
 I $G(EDATE) S EDATE=$S($L(EDATE,".")=2:EDATE+.000001,1:EDATE+1)
 I $G(SDATE) S SDATE=$S($L(SDATE,".")=2:SDATE-.000001,1:SDATE)
 S SDATE=$S($G(SDATE):9999999-SDATE,1:9999999),EDATE=$S($G(EDATE):9999999-EDATE,1:1)
 S X=EDATE,EDATE=SDATE,SDATE=X
 Q
SN ;Get the subs
 D 69^LR7OB69(ORDT,ORSN) Q:'$D(^TMP("LRX",$J,69))
 S II=0 F  S II=$O(^TMP("LRX",$J,69,II)) Q:II<1  S DRAW=$P($G(^TMP("LRX",$J,69,II,68)),"^",4),SS=$P($G(^LRO(68,+$P(^TMP("LRX",$J,69,II),"^",4),0)),"^",2) D
 . S III=0 F  S III=$O(^TMP("LRX",$J,69,II,63,III)) Q:III<1  I $S($D(TSTY):$D(TSTY(III)),1:1) D
 .. I $P(^TMP("LRX",$J,69,II,63,III),U,6)="" Q
 .. S ^TMP("LRRR",$J,DFN,SS,9999999-DRAW,III)=^TMP("LRX",$J,69,II,63,III)
 . I $D(^TMP("LRX",$J,69,II,63,"N")),$O(^TMP("LRRR",$J,DFN,SS,9999999-DRAW,0)) M ^TMP("LRRR",$J,DFN,SS,9999999-DRAW,"N")=^TMP("LRX",$J,69,II,63,"N")
 Q
LRDFN(IFN,FILEROOT)  ;Get LRDFN
 ;IFN=Internal file number
 ;FILEROOT=Root of file to get LRDFN (optional) "DPT(" is default
 Q:'$G(IFN) ""
 I '$L($G(FILEROOT)) S FILEROOT="DPT("
 S X=$S($D(@("^"_FILEROOT_+IFN_",""LR"")")):+^("LR"),1:"")
 I X,'$D(^LR(X,0)) S X=""
 Q X
