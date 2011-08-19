IBDFRPC4 ;ALB/AAS - AICS Pass data to PCE, Broker Call ; 24-FEB-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**38,36,37**;APR 24, 1997
 ;
 ; -- used by AICS Data Entry System, routine IBDFDE1
 ;
SEND(RESULT,IBDF) ; -- procedure
 ; -- broker call to set data into pxca array and send to pce
 ;    rpc  := IBD RECEIVE DATA
 ;
 ; -- input:      Result := passed by reference, see output
 ;            ibdf(text) := contains data about visit, plus checkout defined as follows:
 ;          ibdf("appt") := appointment data/time
 ;        ibdf("clinic") := clinic, pointer to file 44
 ;           ibdf("dfn") := patient, pointer to file 2
 ;          ibdf("form") := encounter form ID, pointer to file 357.96
 ;        ibdf("frmdef") := form definition, pointer to 357.95
 ;       ibdf("foregnd") := pass data in foreground, show results
 ;       ibdf("backgnd") := pass data in background, don't show results
 ;
 ;            ibdf("co") := check out date/time
 ;            ibdf("sc") := is visit for service connected condition
 ;            ibdf("ao") := is visit related to Agent orange
 ;            ibdf("ir") := is visit related to ionizing radiation
 ;            ibdf("ec") := is visit related to environmental contam.
 ;            ibdf("mst"):= is visit related to Military Sexual Trauma
 ;
 ;               ibdf(n) := where n>0 are user selections as follows:
 ;                   $p1 := package interface, pointer to file 357.6
 ;                   $p2 := value to send
 ;                   $p3 := display text
 ;                   $p4 := header to send
 ;                   $p5 := clin lexicon pointer
 ;                   $p6 := qualifier
 ;                   $p7 := ien of inteface
 ;                   $p8 := vitals type (.01 field in 359.1)
 ;                   $p9 := quantity
 ;                      
 N I,J,X,Y,D,D0,D1,D2,DA,DIC,DIE,DR,TNODE,FID,FORMID,NODE,VALUE,PI,TEXT,SUBHDR,HEADER,TYPE,QLFR,ITEM,PROVIDER,PXKDONE,STATUS,VSIT,QUANTITY,SDFN
 S RESULT="-1^No data passed"
 ;
 K PXCA
 S (PXCA,PXCASTAT)=""
 ;
 ; -- check form,frmdef and appt/clinic.  Need one or the other
 S TNODE=$G(^IBD(357.96,+$G(IBDF("FORM")),0))
 S:'$G(IBDF("DFN")) IBDF("DFN")=$P(TNODE,"^",2)
 S:'$G(IBDF("APPT")) IBDF("APPT")=$P(TNODE,"^",3)
 S:'$G(IBDF("FRMDEF")) IBDF("FRMDEF")=$P(TNODE,"^",4)
 S:'$G(IBDF("CLINIC")) IBDF("CLINIC")=$P(TNODE,"^",10)
 ;
 I '$G(IBDF("DFN"))!('$G(IBDF("APPT")))!('$G(IBDF("CLINIC"))) D  G END
 . I $G(IBDF("FORM")) S STATUS=$$FSCND^IBDF18C(+IBDF("FORM"),12)
 . S RESULT="-1^Critical information for processing missing"
 ;
 ; -- log manual data entry attempt in form tracking
 S STATUS=$$FSCND^IBDF18C(IBDF("FORM"),5)
 ;
 ; -- build the encounter node and source node from form tracking
 S PXCA("ENCOUNTER")=$G(IBDF("APPT"))_"^"_$G(IBDF("DFN"))_"^"_$G(IBDF("CLINIC"))_"^^^"_$G(IBDF("SC"))_"^"_$G(IBDF("AO"))_"^"_$G(IBDF("IR"))_"^"_$G(IBDF("EC"))_"^"_$G(IBDF("MST"))_"^^^^"_$G(IBDF("CO"))
 S PXCA("SOURCE")="1^"_DUZ_"^"_$G(IBDF("FRMDEF"))_"^^"_$G(IBDF("FORM"))
 ;
 ; -- process data in ibdf(n) nodes
 S FORMID=IBDF("FORM")
 S FID=0 F  S FID=$O(IBDF(FID)) Q:'FID  S NODE=$G(IBDF(FID)) D
 .N VALUE,PI,TEXT,SUBHDR,HEADER,TYPE,QLFR,ITEM,DELEX,QUANTITY
 .I NODE="" D LOGERR^IBDF18E2(3570002,.FORMID,FID) Q
 .S PI=$P(NODE,"^")
 .S VALUE=$$INPUT(PI,$P(NODE,"^",2))
 .S TEXT=$P(NODE,"^",3)
 .S (SUBHDR,HEADER)=$E($P(NODE,"^",4),1,80)
 .I $L(SUBHDR),$L(SUBHDR)<2 S (SUBHDR,HEADER)=""
 .;I $L(SUBHDR),($L(SUBHDR)+$L(TEXT)<80) S TEXT=SUBHDR_" "_TEXT
 .S QLFR=$P(NODE,"^",6) S:QLFR'="" QLFR=$O(^IBD(357.98,"B",QLFR,0))
 .S TYPE=+$$TYPE($P(NODE,"^",8))
 .S ITEM=FID
 .S DELEX=$P(NODE,"^",5)
 .S QUANTITY=$P(NODE,"^",9)
 .S SLCTN=$P(NODE,"^",12)
 .D SETTEMP^IBDF18E1
 .Q
 ;
 ; --added to copy visit modifiers
 ;
 D:$D(TEMP("ENCOUNTER")) VSTPXCA^IBDF18E0
 ;
 D SETPXCA^IBDF18E0,PRO^IBDF18E0
 ;
 ;  send misc. data that does not go to PCE
 D ^IBDF18E4
 ;
 S IBDF("PASSFLAG")=+$P($G(^IBD(357.09,1,0)),"^",7)
 S IBD("AICS")=1 ;flag for IBDF PCE EVENT protocal
 ;
 ;I $G(IBDF("PASSFLAG"))<1 D BACKGND^PXCA(.PXCA,.PXCASTAT)
 ;I $G(IBDF("PASSFLAG"))=1 D VALIDATE^PXCA(.PXCA) I '$D(PXCA("ERROR")) D BACKGND^PXCA(.PXCA,.PXCASTAT)
 I $G(IBDF("PASSFLAG"))<2 D QUE^IBDF18E3
 I $G(IBDF("PASSFLAG"))>1 D FOREGND^PXCA(.PXCA,.PXCASTAT)
 K IBD("AICS")
 ;
 ; -- kill erroneous inpatient warnings
 I $D(PXCA("WARNING","ENCOUNTER"))>0 D INPT^IBDF18E0($G(IBDF("DFN")),$G(IBDF("APPT")))
 ;
 ; -- set form tracking processing status, if okay=6, if error=7
 I $G(IBDF("FORM")) S STATUS=$$FSCND^IBDF18C(IBDF("FORM"),$S(PXCASTAT=0:7,PXCASTAT=1:6,PXCASTAT=-1:7,PXCASTAT=-2:6,1:12),$S((PXCASTAT=0!(PXCASTAT=-1)):"PCE RETURNED AN ERROR",1:""))
 ;
 S RESULT(0)=PXCASTAT
 I (PXCASTAT=1!(PXCASTAT=-2)),IBDF("PASSFLAG")<3 K PXCA,PXCASTAT
END Q
 ;
INPUT(PI,X) ; -- convert external value to internal value
 I $G(PI)=""!($G(X)="")
 I $G(^IBE(357.6,+$G(PI),9))'="" X ^(9)
VALQ Q $G(X)
 ;
TYPE(X) ; -- Change external to internal for hand print fields
 N Y S Y=""
 I X'="" S Y=$O(^IBE(359.1,"B",X,0))
 Q Y
