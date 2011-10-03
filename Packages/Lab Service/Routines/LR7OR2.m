LR7OR2 ;DALOI/dcm - Get Lab results (cont.) ;8/11/97
 ;;5.2;LAB SERVICE;**121,187,219,285,286,372**;Sep 27, 1994;Build 11
 ;
 ;
CH(SDATE,EDATE,TEST,COUNT,SPEC,UNVER) ;Get CH subscript data
 Q:'$D(SDATE)  Q:'$D(EDATE)  Q:'$D(COUNT)  Q:'$D(CT1)
 N GOTIT,IVDT,ITST,IST,TSTY,X,X0,ORD,Y6,Y12,Y16,Y19
 I $G(TEST) Q:'$D(^LAB(60,TEST,0))  S X=^(0) Q:$P(X,"^",4)'="CH"  D
 . I $L($P(X,"^",5)) S TSTY($P($P(X,"^",5),";",2))=TEST
 . I '$L($P(X,"^",5)) D EN^LR7OU1(TEST)
 S IVDT=SDATE
 F  S IVDT=$O(^LR(LRDFN,"CH",IVDT)) Q:IVDT<1!(IVDT>EDATE)!(CT1>COUNT)  D
 . S X0=^LR(LRDFN,"CH",IVDT,0),Y6=$S($P(X0,"^",3):"F",1:"P"),Y12=$P(X0,"^",4),Y19=$P(X0,"^",5),Y16=$P(X0,"^",6),ORD=$$ORD(LRDFN,IVDT)
 . S GOTIT=0
 . I '$G(UNVER),Y6="P" Q  ;Unverified data not requested
 . I $G(SPEC),Y19'=SPEC Q  ;Specimen specified
 . I '$D(TSTY) S ITST=1 F  S ITST=$O(^LR(LRDFN,"CH",IVDT,ITST)) Q:ITST<1  S X=^(ITST) D SETTST(ITST,X)
 . S IST=0 F  S IST=$O(TSTY(IST)) Q:IST<1  I $D(^LR(LRDFN,"CH",IVDT,IST)) S X=^(IST) D SETTST(IST,X)
 . I $O(^TMP("LRRR",$J,DFN,"CH",IVDT,0)) D NOTE(LRDFN,IVDT)
 . I GOTIT S CT1=CT1+1
 Q
 ;
 ;
SETTST(ISUB,ZERO) ;Set test data in ^TMP
 ;ISUB= test subscript
 ;ZERO= 0th node at ^LR(LRDFN,"CH",IVDT,TST)
 N LRX,X,Y,Y1,Y2,Y3,Y4,Y5,Y9,Y10,Y11,Y14
 S X=ZERO,Y1=ISUB,Y1=$O(^LAB(60,"C","CH;"_Y1_";1",0)),Y2=$P(X,"^"),Y3=$P(X,"^",2)
 Q:'Y1  Q:"IN"[$P(^LAB(60,Y1,0),"^",3)  S Y15=$P($G(^LAB(60,Y1,.1)),"^")
 S (Y9,Y10,Y11,Y14)=""
 I $P($G(^LAB(60,Y1,64)),"^") S Y9=$P(^(64),"^"),Y9=$P(^LAM(Y9,0),"^",2),Y10=$P(^(0),"^"),Y11="99NLT"
 ;D UNIT^LR7OB63(Y1,$P(X0,"^",5),SEX,DOB,AGE)
 S LRX=$$TSTRES^LRRPU(LRDFN,"CH",IVDT,ISUB,Y1)
 S Y2=$P(LRX,"^"),Y3=$P(LRX,"^",2),Y4=$P(LRX,"^",5),Y5=$$EN^LRLRRVF($P(LRX,"^",3),$P(LRX,"^",4))
 I $P(LRX,"^",7) S Y14="T"
 S Y2=$$TRIM^XLFSTR($$RESULT^LR7OB63(Y1,Y2),"RL"," ")
 S ^TMP("LRRR",$J,DFN,"CH",IVDT,ISUB)=Y1_"^"_Y2_"^"_Y3_"^"_Y4_"^"_Y5_"^"_Y6_"^^^"_Y9_"^"_Y10_"^"_Y11_"^"_Y12_"^^"_Y14_"^"_Y15_"^"_Y16_"^"_$G(ORD)_"^^"_Y19
 S GOTIT=1
 Q
 ;
 ;
NOTE(LRDFN,IVDT) ;Get comments
 N IFN
 S IFN=0 F  S IFN=$O(^LR(LRDFN,"CH",IVDT,1,IFN)) Q:IFN<1  S X=^(IFN,0),^TMP("LRRR",$J,DFN,"CH",IVDT,"N",IFN)=X
 Q
 ;
 ;
TEST(Y,DFN,ORD,SDATE,EDATE,SUB,TEST,FLAG,COUNT) ;Test network calls
 ;Called from TIU
 ;COUNT = count of results to send, results with the same date/time
 ;   count as 1
 N IVDT,SSUB,SEQ,CTR
 Q:'$G(DFN)
 D RR^LR7OR1(DFN,$G(ORD),$G(SDATE),$G(EDATE),$G(SUB),$G(TEST),$G(FLAG),$G(COUNT))
 I '$D(^TMP("LRRR",$J)) S Y(1)="No Lab Data" Q
 S CTR=0,SSUB="",COUNT=$S($G(COUNT):COUNT,1:9999999)
 F  S SSUB=$O(^TMP("LRRR",$J,DFN,SSUB)) Q:SSUB=""  S IVDT=0 F  S IVDT=$O(^TMP("LRRR",$J,DFN,SSUB,IVDT)) Q:IVDT<1  S SEQ=0 F  S SEQ=$O(^TMP("LRRR",$J,DFN,SSUB,IVDT,SEQ)) Q:SEQ<1  D
 . S CTR=CTR+1,^TMP("LRAPI",$J,CTR)=9999999-IVDT_"^"_SSUB_"^"_^TMP("LRRR",$J,DFN,SSUB,IVDT,SEQ)
 S Y=$NA(^TMP("LRAPI",$J))
 Q
 ;
 ;
T60(Y,IFN) ;Get tests from file 60
 ;If IFN is not passed then the whole file is sent.
 N CTR S CTR=0
 I $D(IFN) Q:'$D(^LAB(60,IFN,0))  S Y(1)=IFN_"^"_$P(^LAB(60,IFN,0),"^") Q
 S NAME="" F  S NAME=$O(^LAB(60,"B",NAME)) Q:NAME=""  S IFN=0 F  S IFN=$O(^LAB(60,"B",NAME,IFN)) Q:IFN<1  I $D(^LAB(60,IFN,0)) S CTR=CTR+1,Y(CTR)=IFN_"^"_NAME
 Q
 ;
 ;
T64(Y,IFN) ;Get tests from file 64
 ;If IFN is not passed then the whole file is sent, if entry has a link to file 60
 N CTR S CTR=0
 I $D(IFN) Q:'$D(^LAM(IFN,0))  Q:'$D(^LAB(60,"AC",IFN))  S Y(1)=IFN_"^"_$P(^LAM(IFN,0),"^") Q
 S NAME="" F  S NAME=$O(^LAM("B",NAME)) Q:NAME=""  S IFN=0 F  S IFN=$O(^LAM("B",NAME,IFN)) Q:IFN<1  I $D(^LAM(IFN,0)),$D(^LAB(60,"AC",IFN)) S CTR=CTR+1,Y(CTR)=IFN_"^"_NAME
 Q
 ;
 ;
ORD(LRDFN,IVDT) ;Get order # for entry in file 63
 ;LRDFN=Lab Patient #
 ;IVDT=Inverse Date/time in 63 (^LR(LRDFN,"CH",IVDT))
 Q:'$G(LRDFN)  Q:'$G(IVDT)
 N X0,X6,X,AC,ACD,ACN
 S X0=$G(^LR(LRDFN,"CH",IVDT,0)),X6=$P(X0,"^",6) I '$L(X6) Q ""
 S X=$P(X6," "),X=$O(^LRO(68,"B",X,0)) I 'X Q ""
 S AC=X,ACD=+$P(X0,"."),ACN=$P(X6," ",3) I '$D(^LRO(68,AC,1,ACD,1,ACN,0)) Q ""
 S X=$P($G(^LRO(68,AC,1,ACD,1,ACN,.1)),"^")
 Q X
