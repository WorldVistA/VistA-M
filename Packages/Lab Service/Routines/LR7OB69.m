LR7OB69 ;slc/dcm/JAH - Get Lab order data from 69 - 68 - 63 ;8/10/04
 ;;5.2;LAB SERVICE;**121,187,224,291,373**;Sep 27, 1994;Build 1
 ;
69(ODT,SN) ;Get data from file 69
 ;ODT=Order Date subscript in file 69
 ;SN=Specimen number subscript in file 69
 ;Y1=Lab order number
 ;Y2=Start date
 ;Y3=Sample
 ;Y4=Collection type/Specimen Action code
 ;Y5=Order date
 ;Y6=Provider
 ;Y7=Routing Location
 ;Y8=Lab arrival time
 ;Y9=Date/Time Results Available
 ;Y10=Specimen
 ;Y11=OERR Order #
 ;Y12=Entering person
 ;^TMP("LRX",$J,69)=Y1^Y2^Y3^Y4^Y5^Y6^Y7^Y8^Y9^Y10^Y11^Y12
 ;^TMP("LRX",$J,69,i)=Test^Urgency^Accession Date^Accession area^Accession #^Combined on order^ORIFN^Panel exploded
 ;^TMP("LRX",$J,69,"N",i)=Specimen level comments (6 node)
 ;^TMP("LRX",$J,69,i,"N",ifn)=Comments by test
 ;^TMP("LRX",$J,69,i,"NC",ifn)=Free text cancel reason
 ;^TMP("LRX",$J,69,i,"DGX",ifn)=diagnosis^SC^CV^AO^IR^EC^HNC^MST
 ;^TMP("LRX",$J,69,i,63,ifn)=
 ;Test subscript^Result^Flag^Units^Ref Range^Result status^Observation Sub ID^Value type^Natl Procedure code^Natl Procedure Name^Natl Coding System^Verified by^^Theraputic flag (T or "")^Print name^Accession^Order #^Link to 63
 ;^TMP("LRX",$J,69,i,63,"N",ifn)=Result Comments
 ;^TMP("LRX",$J,69,i,68)=Lab Order #^LRDFN^Accession^Draw Time^Lab Arrival time^DT Results Available^Inverse Date
 ;^TMP("LRX",$J,69,i,68,ifn)=Test^Urgency^Technologist^Complete Date
 ;^TMP("LRX",$J,69,"N",i)= Ward comments on specimen
 N X,X0,XP1,X1,X4,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9,Y10,Y11,Y12,IFN,TSTY,NOTE,GOTCOM K ^TMP("LRX",$J,69)
 Q:'$D(^LRO(69,+ODT,1,+SN,0))  S X0=^(0),XP1=$G(^(.1)),X1=$G(^(1)),X3=$G(^(3)),X4=$O(^(4,0))
 Q:'$D(^LR(+X0,0))  ;No matching entry in ^LR
 S:'$D(DFN) DFN=$P(^LR(+X0,0),"^",3) S:'$D(LRDFN) LRDFN=+X0 S:'$D(LRDPF) LRDPF=$P(^LR(+X0,0),"^",2)_$G(^DIC(+$P(^LR(+X0,0),"^",2),0,"GL"))
 S Y1=+XP1,Y2=$S($P(X1,"^"):$P(X1,"^"),1:$P(X0,"^",8)),Y3=$P(X0,"^",3),Y4=$P(X0,"^",4),Y5=$P(X0,"^",5),Y6=$P(X0,"^",6),Y7=$P(X0,"^",9),Y8=$P(X3,"^"),Y9=$P(X3,"^",2),Y11=$P(X0,"^",11),Y12=$P(X0,"^",2)
 ;canceled entries are skipped, so calls to this routine from options
 ;that are removing tests need to make the call before setting the pieces
 ;that cancel the test: $P(^LRO(69,ODT,1,SN,2,IFN,0),"^",11)
 ;See DOUT^LRTSTJAN
 S IFN=0 F  S IFN=$O(^LRO(69,ODT,1,SN,2,IFN)) Q:IFN<1  S X=$G(^(IFN,0)) I X,'$P(X,"^",11) D
 . I $G(LRNIFN),$D(LRTMPO("LRIFN",LRNIFN)) Q:+X'=+LRTMPO("LRIFN",LRNIFN)
 . S ^TMP("LRX",$J,69,IFN)=X,I=0
 . D GDG1^LRBEBA2(ODT,SN,IFN)
 . F  S I=$O(^LRO(69,ODT,1,SN,2,IFN,1,I)) Q:I<1  S X=^(I,0) D
 .. S ^TMP("LRX",$J,69,IFN,"N",I)=X
 . S I=0 F  S I=$O(^LRO(69,ODT,1,SN,2,IFN,1.1,I)) Q:I<1  S X=^(I,0) D
 .. S ^TMP("LRX",$J,69,IFN,"NC",I)=X
 S IFN=0 F  S IFN=$O(^LRO(69,ODT,1,SN,6,IFN)) Q:IFN<1  S X=^(IFN,0) D
 . Q:X["removed ==>"  Q:X["deleted by"
 . S ^TMP("LRX",$J,69,"N",IFN)=X
 S Y10=$O(^LRO(69,ODT,1,SN,4,0)),Y10=$S(Y10:$P(^(Y10,0),"^"),1:"")
 S ^TMP("LRX",$J,69)=Y1_"^"_Y2_"^"_Y3_"^"_Y4_"^"_Y5_"^"_Y6_"^"_Y7_"^"_Y8_"^"_Y9_"^"_Y10_"^"_Y11_"^"_Y12
 S IFN=0 F  S IFN=$O(^TMP("LRX",$J,69,IFN)) Q:IFN<1  S X=^TMP("LRX",$J,69,IFN) S X1=$P(X,"^",3),X2=$P(X,"^",4),X3=$P(X,"^",5) K TSTY D EN^LR7OU1(+X,$P(^LAB(60,+X,0),"^",5)) D 68^LR7OB68(IFN,X1,X2,X3,+X)
 Q
