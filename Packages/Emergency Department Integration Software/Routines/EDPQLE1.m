EDPQLE1 ;SLC/KCM - Retrive Log Entry - Supporting Info ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;**6**;Feb 24, 2012;Build 200
 ;
CHOICES(AREA) ; Add choice lists for editing log entry to XML
 ; called from EDPQLE
 ;
 N ROLIEN,RNAME,RABBR,RXML,R0
 S ROLEIEN=0 F  S ROLEIEN=$O(^EDPB(232.5,ROLEIEN)) Q:'ROLEIEN  D
 .S R0=$G(^EDPB(232.5,ROLEIEN,0)),RNAME=$P(R0,U),RABBR=$P(R0,U,2),RXML=$P(R0,U,3)
 .D STAFF($S(RXML="@rn":"nurse",1:$P(RXML,"@",2)),ROLEIEN,RABBR)
 ;D STAFF("md","P")
 ;D STAFF("res","R")
 ;D STAFF("nurse","N")
 ;
 D CODES("arrival","arrival")
 D CODES("acuity","acuity")
 D CODES("status","status")
 D CODES("disposition","disposition")
 D CODES("delay","delay")
 Q
STAFF(LABEL,ROLEIEN,RABBR) ; add staff for this area to XML
 N IEN,X0,NM,PER,ALPHA,EDPNURS,ROW
 I RABBR="N" S EDPNURS=$$GET^XPAR("ALL","EDPF NURSE STAFF SCREEN")
 D XML^EDPX("<"_LABEL_"List>")
 D XML^EDPX($$XMLS^EDPX(LABEL,0,"None"))   ;non-selected (-1 will delete)
 S IEN=0 F  S IEN=$O(^EDPB(231.7,"AC",EDPSITE,AREA,ROLEIEN,IEN)) Q:'IEN  D
 . S X0=^EDPB(231.7,IEN,0),PER=$P(X0,U)
 . I '$$ALLOW^EDPFPER(PER,RABBR) Q
 . S ALPHA($P(^VA(200,PER,0),U),PER)=$P(^VA(200,PER,0),U,2)
 S NM="" F  S NM=$O(ALPHA(NM)) Q:NM=""  D
 . S PER=0 F  S PER=$O(ALPHA(NM,PER)) Q:'PER  D
 . . K ROW S ROW("data")=PER,ROW("label")=NM
 . . S ROW("initials")=ALPHA(NM,PER)
 . . D XML^EDPX($$XMLA^EDPX(LABEL,.ROW))
 . . ;D XML^EDPX($$XMLS^EDPX(LABEL,PER,NM))
 D XML^EDPX("</"_LABEL_"List>")
 Q
CODES(LABEL,SETNM) ; build nodes for set of codes
 D XML^EDPX("<"_LABEL_"List>")
 I "^arrival^acuity^status^disposition^delay^"[(U_LABEL_U) D
 . ;N NOVAL S NOVAL=+$O(^EDPB(233.1,"B","edp.reserved.novalue",0))
 . ;D XML^EDPX($$XMLS^EDPX(LABEL,NOVAL,"Not Set"))   ; non-selected value
 . D XML^EDPX($$XMLS^EDPX(LABEL,0,"Not Set"))   ; non-selected value ;
 I $D(^EDPB(233.2,"B",EDPSTA_"."_SETNM)) S SETNM=EDPSTA_"."_SETNM I 1
 E  S SETNM="edp."_SETNM
 ;
 N SET,SEQ,I,X0,IEN,SHOW
 S SET=$O(^EDPB(233.2,"B",SETNM,0))
 S SEQ=0 F  S SEQ=$O(^EDPB(233.2,SET,1,"B",SEQ)) Q:'SEQ  D
 . S I=0 F  S I=$O(^EDPB(233.2,SET,1,"B",SEQ,I)) Q:'I  D
 . . S X0=^EDPB(233.2,SET,1,I,0)
 . . Q:$P(X0,U,3)  ; inactive
 . . S IEN=$P(X0,U,2)
 . . S SHOW=$P(X0,U,4)
 . . I SHOW="" S SHOW=$P(^EDPB(233.1,IEN,0),U,2)
 . . D XML^EDPX($$XMLS^EDPX(LABEL,IEN,SHOW))
 ;
 D XML^EDPX("</"_LABEL_"List>")
 Q
CLINLST(USEALL) ; build nodes for selectable clinics
 N EDPLST,INSTANCE,IEN,NAME,LST,CURTM
 D GETLST^XPAR(.EDPLST,EDPSITE_";DIC(4,","EDPF LOCATION","N")
 S CURTM=$E($P($$NOW^XLFDT,".",2)_"0000",1,4)
 S INSTANCE="" F  S INSTANCE=$O(EDPLST(INSTANCE)) Q:INSTANCE=""  D
 . S IEN=+EDPLST(INSTANCE),NAME=$P(EDPLST(INSTANCE),U,2)
 . I 'USEALL,$$OUTSIDE(CURTM,INSTANCE) Q  ; outside time range, get next
 . S LST(NAME)=IEN
 ;
 D XML^EDPX("<clinicList>")
 D XML^EDPX($$XMLS^EDPX("clinic",0,"None"))   ;non-selected (-1 will delete)
 S NAME="" F  S NAME=$O(LST(NAME)) Q:NAME=""  D
 . D XML^EDPX($$XMLS^EDPX("clinic",LST(NAME),NAME))
 D XML^EDPX("</clinicList>")
 Q
OUTSIDE(TM,RNG) ; return true if the time is OUTSIDE of the range
 N BEG,END
 I RNG'["-" Q 0
 ;
 S BEG=+$P(RNG,"-"),END=+$P(RNG,"-",2)
 I (TM<BEG)!(TM>END) Q 1
 Q 0
