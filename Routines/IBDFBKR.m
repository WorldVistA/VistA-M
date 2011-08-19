IBDFBKR ;ALB/AAS - EF utilite, receive and format data for PCE ; OCT 1,1994
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
PCE(IB,PXCA) ;
 ; -- Entry point from Broker receiver to parse data and
 ;    either send to PCE or store until all pages received
 ;
 N %,%H,%I,I,J,X,Y,IBDATA,BUBBLES,HANDPRNT,DYNAMIC,RESULT,NEEDMORE,IBDA
 S RESULT=1
 ;
 ; -- Move data from input format to data format
 S RESULT=$$BRKARY(.IB,.IBDATA)
 ;
 ; -- check for valid data
 S RESULT=$$VALIDD(.IBDATA) I RESULT>3 G PCEQ
 ;
 ; -- mark the page as having been received
 S IBDA=$O(^IBD(357.96,IBDATA("FORMID"),9,"B",+IBDATA("PAGE"),0))_","_IBDATA("FORMID")_","
 S FDA(357.969,IBDA,.02)=$$NOW^XLFDT
 ; -- marked stored image as received
 S X=$O(^IBD(357.96,"AD",IBDATA("PAGE"),IBDATA("FORMID"),0)) I X D
 .S FDA(357.963,X_","_IBDATA("FORMID")_",",.07)=1
 D FILE^DIE("","FDA","IBDERR")
 K DIC,DIE,DR,DA
 ;
 ; -- check if all pages have been rec'd (if not freeing ft entry)
 S NEEDMORE=$$NEEDMOR(.IBDATA)
 ;
 I NEEDMORE D
 .S RESULT=6
 .S I=0 F  S I=$O(IBDF(I)) Q:'I  D FILAD(IBDF(I)) Q:RESULT=11
 .N SUCCESS S SUCCESS=$$FSCND^IBDF18C(IBDATA("FORMID"),11)
 ;
 I 'NEEDMORE D
 .N SUCCESS S SUCCESS=$$FSCND^IBDF18C(IBDATA("FORMID"),2)
 .S RESULT=7
 .S I=0 F  S I=$O(IBDF(I)) Q:'I  D ARYAD(IBDF(I))
 .;
 .; -- add to the arrays data from other pages stored in form tracking
 .S I=0
 .F  S I=$O(^IBD(357.96,IBDATA("FORMID"),10,I)) Q:'I  D ARYAD($G(^IBD(357.96,IBDATA("FORMID"),10,I,0)))
 .;
 .; -- don't need the raw data kept in form tracking anymore
 .; -- maybe we do for formtracking???
 .;K ^IBD(357.96,IBDATA("FORMID"),10)
 .;
 .I $$SEND^IBDF18E(IBDATA("FORMID"),"","",.BUBBLES,.HANDPRNT,"",.PXCA,.DYNAMIC)
 .S RESULT=8
 .;S RESULT=$S($G(PXCASTAT)=1:8,$G(PXCASTAT)=0:9,1:10)
 .Q
 ;
PCEQ I +RESULT>10 D RECVERR^IBDFBK2(.IBDATA,+RESULT)
 Q +RESULT_"^"_$P($T(RESULT+RESULT),";;",2)
 ;
FILAD(REC) ;
 ; -- adds the data to the FORM TRACKING file
 ; -- awaiting all of the pages to be sent
 ;    REC is the line of raw data, as received
 ; -- may change to FM call???
 ;N CNT
 Q:REC=""
 ; -- remove hard sets and replace with FM call
 ;S CNT=+$P($G(^IBD(357.96,IBDATA("FORMID"),10,0)),"^",3)
 ;F  S CNT=CNT+1 Q:'$D(^IBD(357.96,IBDATA("FORMID"),10,CNT))
 ;S ^IBD(357.96,IBDATA("FORMID"),10,CNT,0)=REC
 ;S ^IBD(357.96,IBDATA("FORMID"),10,0)=$P($G(^IBD(357.96,IBDATA("FORMID"),10,0)),1,2)_"^"_CNT_"^"_CNT
 ;S ^IBD(357.96,IBDATA("FORMID"),10,"B",$E(REC,1,30),CNT)=""
 ;
 L +^IBD(357.96,IBDATA("FORMID")):3 I '$T S RESULT=11 Q
 S DIC="^IBD(357.96,"_IBDATA("FORMID")_",10,",DIC(0)="L",DIC("P")=$P(^DD(357.96,10,0),"^",2),DA(1)=IBDATA("FORMID"),X=REC,DLAYGO=357.96
 K DD,DO D FILE^DICN K DIC,DA,DLAYGO,DD,DO
 L -^IBD(357.96,IBDATA("FORMID"))
 Q
 ;
ARYAD(DATA) ;
 ; -- Input DATA
 ; -- DATA format B=bubble or
 ;                H=handprint>:<ien of form element in the form
 ;                  definition table>:<value entered
 ;                D=dynamic bubble>:<field identifier>:<number of choice>
 ; -- Output Bubbles,Dynamic, or Handprint Array.
 ;
 I $E(DATA,1)="""",$E(DATA,$L(DATA))="""" S DATA=$P(DATA,"""",2)
 I $P(DATA,":")="B" S BUBBLES($P(DATA,":",2))=$P(DATA,":",3)
 I $P(DATA,":")="D" S DYNAMIC($P(DATA,":",2),$P(DATA,":",3))=DATA
 I $P(DATA,":")="H" S HANDPRNT($P(DATA,":",2))=$P(DATA,":",3,10)
 Q
 ;
BRKARY(IB,IBDATA) ;
 ; -- break array of data into known parts
 ; -- Input  IB(array) contains raw data from receiver
 ;           IBDATA(array) called by reference
 ; -- Output IBDATA(array) of new formated data
 ;           result message indicator
 ;
 N I,X,CNT
 S (I,CNT)=0
 F  S I=$O(IBDF(I)) Q:'I!(CNT>3)  D
 .I $P(IB(I),"=")="FORMTYPE" S IBDATA("FORMTYPE")=+$P(IBDF(I),"=",2),CNT=CNT+1 K IBDF(I) Q
 .I $P(IB(I),"=")="FORMID" S IBDATA("FORMID")=+$P(IBDF(I),"=",2),CNT=CNT+1 K IBDF(I) Q
 .I $P(IB(I),"=")="PAGE" S IBDATA("PAGE")=+$P(IBDF(I),"=",2),CNT=CNT+1 K IBDF(I) Q
 .I $P(IB(I),"=")="DATA" S CNT=CNT+1 K IBDF(I) Q  ; shouldn't contain data
BRKQ Q 2
 ;
VALIDD(IBDATA) ;
 ; -- Determine if data contains Formtype, FormID, and Page
 ; -- Does form ID and form type match entry in Form Tracking
 ; -- is the form supposed to have this page?
 ; -- Input  IBDATA(array)
 ; -- Output result message indicator (3=valid, 4=invalid, 5=already recvd)
 ;
 N X S X=12 D
 .I '$G(IBDATA("FORMTYPE")) S X=13 Q
 .I '$G(IBDATA("FORMID")) S X=14 Q
 .I '$G(IBDATA("PAGE")) S X=15 Q
 .;
 .I $G(^IBD(357.96,+IBDATA("FORMID"),0))="" S X=16 Q
 .I $P($G(^IBD(357.96,+IBDATA("FORMID"),0)),"^",4)'=IBDATA("FORMTYPE") S X=17 Q
 .;
 .I '$O(^IBD(357.96,IBDATA("FORMID"),9,"B",IBDATA("PAGE"),0)) S X=18 Q
 .;
 .; -- if pce returned an error then all pages flagged as not received
 .I $P(^IBD(357.96,IBDATA("FORMID"),9,+$O(^IBD(357.96,IBDATA("FORMID"),9,"B",IBDATA("PAGE"),0)),0),"^",2) S X=5 Q
 .S X=3
VQ Q X
 ;
NEEDMOR(IBDATA) ;
 ; -- check to see if all the pages have been received
 N I,X
 S (I,X)=0
 F  S I=$O(^IBD(357.96,IBDATA("FORMID"),9,I)) Q:'I  D
 .I $G(^IBD(357.96,IBDATA("FORMID"),9,I,0)),'$P(^(0),"^",2) S X=1 Q
 .Q
NMQ Q X
 ;
RESULT ;;
 ;;Beginning to Format Data for PCE
 ;;Data Accepted, Beginning Validity Check
 ;;Valid Form Identity Received
 ;;Form ID Validity Rejected
 ;;Data from Page already Received
 ;;Waiting for more pages to be recognized
 ;;Formatting data for PCE
 ;;Data Sent to PCE
 ;;Data Rejected by PCE
 ;;Unknown result in sending data to PCE
 ;;Form Tracking Entry locked by another user, Editing not allowed
 ;;Form ID Validity Rejected
 ;;Form Definition of zero or null is invalid
 ;;Form ID of zero or null is invalid
 ;;Form Page number of zero or null is invalid
 ;;Form Tracking entry does not exist
 ;;Form Definition from scanning doesn't match data in Form Tracking
 ;;Data from non-scannable page was passed
 ;;Form Rejected, Patient not in clinic
