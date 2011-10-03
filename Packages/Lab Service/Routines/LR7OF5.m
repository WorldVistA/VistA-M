LR7OF5 ;slc/dcm - Setup new order from OE/RR ;2/4/99  06:42
 ;;5.2;LAB SERVICE;**223,221,256**;Sep 27, 1994
 ;
 ;This routine invokes IA #2060, #2835, #2747
 ;
ORES(LRDFN,SDT,TYPE,SAMP,PROV,LOC,SPEC,ENTERBY)  ;Look for match on orders already processed for this session
 ;SDT=Requested Date time of collection
 ;TYPE=Collection type
 Q:'$D(TYPE) "" Q:'$G(SDT) ""
 N EX,REF,X,STRT,ORI,END
 S (X,REF)="",(END,STRT)=0
 F  S STRT=$O(^TMP("OR",$J,"LRES",LRDFN,STRT)) Q:'STRT  I $D(^(STRT,TYPE)) S ORI=0 D  Q:END
 . F  S ORI=$O(^TMP("OR",$J,"LRES",LRDFN,STRT,TYPE,ORI)) Q:'ORI  S REF=^(ORI) D  Q:END
 .. I $$ABS^XLFMTH($$FMDIFF^XLFDT(SDT,STRT,2))>600 S REF="" Q
 .. I REF D  Q
 ... I $$INDAIR(LRDFN,+REF) S REF="" Q
 ... S X=$$REF(LRDFN,$P(REF,"^",2),$P(REF,"^",3)),END=1
 I 'REF Q ""
 I '$L(X) S X="O."_+REF
 Q X
FIND(PAT,ODT,SDT,TYPE,SAMP,PROV,LOC,SPEC,ENTERBY) ;Look for match on patient, time, type, specimen, provider
 ;PAT=LRDFN
 ;ODT=LRODT
 ;TYPE=COLLECTION TYPE
 ;SDT=EST. DATE/TIME OF COLLECTION
 ;SAMP=COLLECTION SAMPLE
 ;PROV=PROVIDER
 ;LOC=LRLLOC (LOCATION)
 ;SPEC=SPECIMEN
 Q:'$D(^LRO(69,"D",PAT,ODT)) ""
 N EX,IFN,X,X0,X1,X4,Y,XORD
 S IFN=9999999999,X=""
 F  S IFN=$O(^LRO(69,"D",PAT,ODT,IFN),-1) Q:IFN<1  D  Q:$L(X)
 . Q:+$G(^LRO(69,ODT,1,IFN,0))'=PAT  ;double check for patient match
 . Q:$P($G(^LRO(69,ODT,1,IFN,3)),"^")  ;cannot add to 'collected' orders
 . Q:$$ORD(ODT,IFN)  ;cannot add if any part of order's collected
 . Q:$L($P($G(^LRO(69,ODT,1,IFN,1)),"^",7))  ;don't add to a combined order
 . Q:'$D(^LRO(69,ODT,1,IFN,0))  S X0=^(0),X1=$G(^(.1))
 . Q:$P(X0,"^",4)'=TYPE
 . ;'LC' collection types must have same collection times
 . I TYPE="LC",$P(X0,"^",8)'=SDT Q
 . I TYPE'="LC",$P(X0,"^",8),SDT,$$ABS^XLFMTH($$FMDIFF^XLFDT(SDT,$P(X0,"^",8),2))>600 Q  ;don't combine if time difference is >10 min
 . L +^LRO(69,"C",+X1):0
 . I '$T Q
 . L -^LRO(69,"C",+X1)
 . I '$$GOT^LROE(+X1,ODT) Q  ;Don't combine on canceled order
 . I $$INDAIR(PAT,+X1,1) S X=" " Q  ;Don't combine if duplicate test.
 . S X=$$REF(PAT,ODT,IFN)
 . S XORD=$S($L(X):"",1:+X1)
 S:$G(XORD) X="O."_XORD
 S:X=" " X=""
 Q X
REF(LRDFN,ODT,IFN)    ;Setup codes used for combining
 ;Returns "" if no match found or:
 ;   O.LRORD=Order # to combine with
 ;   S.LRSN.LRORD=Specimen number to combine with
 ;   C.LRSN.LRORD=Creates new LRSN under this order number so that unique data is retained (ENTERBY,PROVIDER,LOC,SPEC)
 N X0,X1,X4,LRORD,LRODT,LRSN,LRCODE,GOT
 Q:'$D(^LRO(69,+$G(ODT),1,+$G(IFN),.1)) 0 S LRORD=^(.1),(LRODT,GOT)=0,LRCODE=""
 F  S LRODT=$O(^LRO(69,"C",LRORD,LRODT)) Q:'LRODT!GOT  S LRSN=0 F  S LRSN=$O(^LRO(69,"C",LRORD,LRODT,LRSN)) Q:'LRSN!GOT  D
 . Q:'$D(^LRO(69,LRODT,1,LRSN,0))  S X0=^(0),X1=$G(^(.1))
 . Q:+X0'=LRDFN  ;Patient check
 . S X4=$G(^LRO(69,LRODT,1,LRSN,4,1,0))
 . I $P(X0,"^",2)=ENTERBY,$P(X0,"^",3)=SAMP,$P(X0,"^",6)=PROV,$P(X0,"^",9)=LOC,X4=SPEC S LRCODE="S."_LRSN_"."_+X1,GOT=1 Q
 . I $P(X0,"^",3)=SAMP,X4=SPEC S LRCODE="C."_LRSN_"."_+X1,GOT=1 Q
 Q LRCODE
ORD(ODT,SN) ;Check to see if any part of the order's been collected
 N LRORD
 Q:'$D(^LRO(69,+$G(ODT),1,+$G(SN),.1)) 0 S LRORD=^(.1)
 N LRODT,LRSN,GOT
 S LRODT=0
 F  S LRODT=$O(^LRO(69,"C",LRORD,LRODT)) Q:'LRODT  S LRSN=0 F  S LRSN=$O(^LRO(69,"C",LRORD,LRODT,LRSN)) Q:'LRSN  D
 . I $D(^LRO(69,LRODT,1,LRSN,3)) S GOT=1 Q
 Q +$G(GOT)
INDAIR(LRDFN,LRORD,CHK) ;Check for test duplication and tests that require their own order #
 ;Function returns 0 if test allowed, 1 if not
 ;CHK=1 if called from FIND, 0 if called from ORES (doesn't check ORES array)
 Q:'$G(LRORD) 1
 N UTS,X,X4,ODT,LRSN,TST,EX
 S ODT=0,EX=0
 F  S ODT=$O(^LRO(69,"C",LRORD,ODT)) Q:'ODT!(EX)  S LRSN=0 F  S LRSN=$O(^LRO(69,"C",LRORD,ODT,LRSN)) Q:'LRSN!(EX)  D
 . I +$G(^LRO(69,LRODT,1,LRSN,0))'=LRDFN Q  ;Check for same patient
 . S UTS=0 F  S UTS=$O(^TMP("OR",$J,"LROT",SDT,TYPE,SAMP,SPEC,UTS)) Q:'UTS  S X=^(UTS) D  Q:EX
 .. S X4=$G(^LRO(69,LRODT,1,LRSN,4,1,0))
 .. I X4=SPEC,$D(^LRO(69,ODT,1,LRSN,2,"B",+X)) S EX=1 Q  ;Duplicate test
 .. I $P($G(^LAB(60,+X,0)),"^",20) S EX=1 Q  ;Combining not allowed
 .. S TST=0 F  S TST=$O(^LRO(69,ODT,1,LRSN,2,"B",TST)) Q:'TST  D  Q:EX  ;Duplicate check for all tests
 ... I $P($G(^LAB(60,TST,0)),"^",20) S EX=1 Q
 ... N EXY
 ... D EXPAND^LR7OU1(TST,.EXY)
 ... S EXY=0 F  S EXY=$O(EX(EXY)) Q:'EXY  I $D(^LRO(69,ODT,1,LRSN,2,"B",EXY)) S EX=1 Q  ;Check panels for duplicate
 ... Q:EX
 ... I $G(CHK) S EX=$$ESTEST(TST,LRXZ,LRSDT)
 Q EX
ESTEST(TEST,TYPE,STARTDT)       ;Check ORES array for potential duplicates
 Q:'$G(TEST) 0 Q:'$D(TYPE) 0 Q:'$G(STARTDT) 0
 N IFN,ACT,LRI,ES,X
 S ES=0,LRI=""
 F  S LRI=$O(ORES(LRI)) Q:'LRI!(ES)  S IFN=+LRI,ACT=$P(LRI,";",2)  I $$VALUE^ORCSAVE2(IFN,"COLLECT")=TYPE D
 . I +$P($G(^ORD(101.43,+$$VALUE^ORCSAVE2(IFN,"ORDERABLE"),0)),"^",2)'=TEST S ES=0 Q
 . S X=$P($G(^OR(100,IFN,8,ACT,0)),"^")
 . I X,$$ABS^XLFMTH($$FMDIFF^XLFDT(X,STARTDT,2))<600 S ES=1 Q
 Q ES
