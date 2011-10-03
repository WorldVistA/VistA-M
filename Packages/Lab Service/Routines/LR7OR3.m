LR7OR3 ;slc/dcm - Get Lab TEST parameters ;8/11/97
 ;;5.2;LAB SERVICE;**121,187,245,256**;Sep 27, 1994
 ;Entry points:  TEST - to get all TEST parameters
 ;               COLL - to get collection sample & specimen parameters
 ;               URG  - to get urgency parameters
GET(TEST) ;Get TEST ifn
 I '$D(TEST) Q ""
 I TEST'?1N.N S TEST=$O(^LAB(60,"B",TEST,0)) Q:'TEST ""
 I TEST?1N.N Q:'$D(^LAB(60,TEST)) ""
 Q TEST
TEST(TEST,Y) ;Gets Lab Test ordering parameters from file 60
 ;TEST=Lab TEST (can be either name or internal #)
 ;Y("Unique CollSamp")=n
 ;Y("Default CollSamp")=n
 ;Y("Lab CollSamp")=n (Lab Collection Sample)
 ;Y("Default Urgency")=ptr 62.05^Name
 ;Y("Urgencies",n)=ptr 62.05^Name
 ;Y("Specimens",n)=ptr 61^Name
 ;Y("CollSamp",n)=ptr 62^Name^DefSpecimen^TubeColor^MaxOrd^MaxDay^LabCollect^ReqComID
 ;Y("CollSamp",n,"WD",i,0)=Ward Remarks
 ;Y("GenWardInstructions",n)=General Ward Instructions
 ;Y("ReqCom")=Required Comment ID at Test level
 N X0
 Q:'$D(TEST)
 S TEST=$$GET(TEST) Q:'TEST
 S X0=^LAB(60,TEST,0)
 D GCOM(TEST,.Y)
 D COLL(TEST,.Y)
 D URG(TEST,.Y)
 Q
COLL(TEST,Y) ;Get Collection Sample-Specimen data
 N X0,I,J,X,SAMP,SPEC
 Q:'$D(TEST)
 S TEST=$$GET(TEST)
 Q:'TEST
 S X0=^LAB(60,TEST,0),I=0
 I $P(X0,"^",19) S Y("ReqCom")=$P($G(^LAB(62.07,+$P(X0,"^",19),0)),"^")
 F  S I=$O(^LAB(60,TEST,3,I)) Q:I<1  S X=^(I,0),Y("CollSamp",I)=$$SAMP(X),Y("CollSamp")=+$G(Y("CollSamp"))+1,J=0 D
 . F  S J=$O(^LAB(60,TEST,3,I,1,J)) Q:J<1  S Y("CollSamp",I,"WP",J,0)=^(J,0)
 I $O(^LAB(60,TEST,3,0)) S Y("Default CollSamp")=$O(^(0))
 S I=0 F  S I=$O(^LAB(60,TEST,1,I)) Q:I<1  S X=^(I,0),Y("Specimens",I)=+X_"^"_$P($G(^LAB(61,+X,0)),"^"),Y("Specimens")=+$G(Y("Specimens"))+1
 I $P(X0,"^",8),$O(^LAB(60,TEST,3,0)) S Y("Unique CollSamp")=+$O(^(0))
 I $P(X0,"^",9) S I=0 F  S I=$O(^LAB(60,TEST,3,I)) Q:I<1  S X=+^(I,0) I X=$P(X0,"^",9) S Y("Lab CollSamp")=I Q
 I $P(X0,"^",9),'$D(Y("Lab CollSamp")) S Y("Lab CollSamp")=999,Y("CollSamp",999)=$$SAMP($P(X0,"^",9)),Y("CollSamp")=+$G(Y("CollSamp"))+1
 Q
URG(TEST,Y) ;Get Urgency params for TEST
 N X0,I,X,URG
 Q:'$D(TEST)
 S TEST=$$GET(TEST)
 Q:'TEST
 S X0=^LAB(60,TEST,0)
 I $P(X0,"^",18) S Y("Default Urgency")=$P(X0,"^",18)_"^"_$P($G(^LAB(62.05,+$P(X0,"^",18),0)),"^",1,2) Q
 S I=0 F  S I=$O(^LAB(62.05,I)) Q:I<1!(I>49)  I $P(X0,"^",16)'>I S Y("Urgencies",I)=I_"^"_$P(^(I,0),"^",1,2),Y("Urgencies")=+$G(Y("Urgencies"))+1
 Q
SAMP(X) ;Build Collection Sample data
 ;SAMP(X,REQ) ;Build Collection Sample data
 ;X=zero node from ^LAB(60,TEST,3,ifn,0) or ptr to 62
 ;REQ=Required comment from $P(^LAB(60,TEST,0),"^",19)
 ;N X0,Y
 N X0,Y,REQ
 Q:'$D(^LAB(62,+X,0)) "" S X0=^(0)
 S REQ=+$P(X,"^",6),REQ=$S(REQ:$P($G(^LAB(62.07,REQ,0)),"^"),1:"")
 S Y=+X_"^"_$P(X0,"^")_"^"_$P(X0,"^",2)_"^"_$P(X0,"^",3)_"^"_$P(X,"^",5)_"^"_$P(X,"^",7)_"^"_$P(X0,"^",7)_"^"_REQ
 Q Y
DEFURG() ;Get default urgency for lab
 Q $P($G(^LAB(69.9,1,3)),U,2)
SCOM(TEST,SAMP,TEXT) ;Get Ward Remarks (specimen) & put in TEXT aray
 ;TEST=ptr to TEST in file 60
 ;SAMP=ptr to collection sample file 62
 N X
 S X=$O(^LAB(60,+$G(TEST),3,"B",+$G(SAMP),0))
 Q:'X
 M TEXT=^LAB(60,TEST,3,X,1)
 Q
GCOM(TEST,TEXT) ;Get General Ward Instructions
 ;TEST=ptr to TEST in file 60
 Q:'$O(^LAB(60,+$G(TEST),6,0))
 M TEXT("GenWardInstructions")=^LAB(60,TEST,6)
 Q
