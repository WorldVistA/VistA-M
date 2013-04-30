EDPRPT ;SLC/MKB - Reports ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
EN(BEG,END,RPT,ID,CSV,TASK) ; Get RPT data for EDPSITE by date range
 ;
 I $G(TASK) D  Q  ;return text from task
 . I '$D(^XTMP("EDIS-"_TASK)) D XML^EDPX("<task id='"_TASK_"' />") Q
 . M EDPXML=^XTMP("EDIS-"_TASK)
 . K EDPXML(0),^XTMP("EDIS-"_TASK)
 ;
 N NOW,ZTSAVE,ZTRTN,ZTDESC
 S NOW=$$NOW I BEG,END D  ;check
 . N X I END<BEG S X=BEG,BEG=END,END=X ;switch
 . S:$L(END,".")<2 END=END_".2359"
 S RPT=$$UP^XLFSTR($G(RPT))
 S CSV=$G(CSV,"")
 ; switch on report type
 I RPT="EXPOSURE"   D EXP^EDPRPT7(ID,CSV)   G CONT
 I BEG<1            D ERR(2300012)          G CONT
 I RPT="SHIFT"      D SFT^EDPRPT5(BEG,CSV)  G CONT
 I END<1            D ERR(2300012)          G CONT
 I RPT="ACTIVITY"   D ACT^EDPRPT1(BEG,END,CSV)  G CONT
 I RPT["DELAY"      D DEL^EDPRPT2(BEG,END,CSV)  G CONT
 I RPT="SUMMARY"    D SUM^EDPRPT4(BEG,END,CSV)  G CONT
 I RPT="MISSEDOP"   D MO^EDPRPT3(BEG,END,CSV)   G CONT
 I RPT="PROVIDER"   D PRV^EDPRPT6(BEG,END,CSV)  G CONT
 I RPT="ACUITY"     D ACU^EDPRPT8(BEG,END,CSV)  G CONT
 I RPT="PATIENT"    D XRF^EDPRPT9(BEG,END,CSV)  G CONT
 I RPT="ADMISSIONS" D ADM^EDPRPT10(BEG,END,CSV) G CONT
 I RPT="INTAKE"     D CNT^EDPRPT11(BEG,END,CSV) G CONT
 I RPT="ORDERS"     D ORD^EDPRPT12(BEG,END,CSV) G CONT
 I RPT="BVAC"       D EN^EDPRPTBV(BEG,END,CSV)  G CONT
 ; 10-18-2011 bwf: New report for patients removed in error
 I RPT="REMOVED"    D EN^EDPRPT13(BEG,END,CSV)   G CONT
 ; else
 D ERR(2300011)
CONT ; end switch
 Q
 ;
ERR(MSG) ; -- return error MSG
 N X S X=$$MSG^EDPX(MSG)
 I $G(CSV) D ADD^EDPCSV(X) Q
 D XML^EDPX("<error msg='"_X_"' />")
 Q
 ;
NOW() ; -- Return local value of NOW, based on EDPSITE
 Q $$NOW^XLFDT
 ;
TASK ; -- task report: expects ZTSAVE,ZTRTN,ZTDESC
 N ZTDTH,ZTIO,ZTSK,I
 S ZTDTH=$H,ZTIO=""
 F I="NOW","EDPSTA","EDPSITE","EDPXML","EDPXML(" S ZTSAVE(I)=""
 I $G(CSV) S ZTSAVE("CSV")="",ZTSAVE("EDPCSV(")=""
 D ^%ZTLOAD I '$G(ZTSK) D ERR(2300017) Q
 K EDPXML
 D XML^EDPX("<task id='"_ZTSK_"' />")
 Q
 ;
PROV(MD) ; add list of assigned providers to XML
 N I,X0,X
 D XML^EDPX("<providers>")
 S I=0 F  S I=$O(MD(I)) Q:I<1  D
 . S X0=$G(^VA(200,I,0)),X="<md id='"_I_"' name='"_$$ESC^EDPX($P(X0,U))_"' initials='"_$$ESC^EDPX($P(X0,U,2))_"'/>"
 . D XML^EDPX(X)
 D XML^EDPX("</providers>")
 Q
 ;
ECODE(IEN) ; Return external value for a Code
 ;Q:$G(IEN) $P($G(^EDPB(233.1,+IEN,0)),U,3) ;code
 N X0,LIST,DA,Y S IEN=+$G(IEN)
 S X0=$G(^EDPB(233.1,IEN,0)),LIST=EDPSTA_"."_$P($P(X0,U),".",2)
 S DA=+$O(^EDPB(233.2,"AS",LIST,IEN,0)),Y=""
 I DA S Y=$P($G(^EDPB(233.2,"AS",LIST,IEN,DA)),U)
 I Y="" S Y=$P(X0,U,3) ;use nat'l value if no local
 Q Y
 ;
ENAME(IEN) ; Return external value for a code Name
 N X0,LIST,DA,Y S IEN=+$G(IEN)
 S X0=$G(^EDPB(233.1,IEN,0)),LIST=EDPSTA_"."_$P($P(X0,U),".",2)
 S DA=$O(^EDPB(233.2,"AS",LIST,IEN,0)),Y=""
 I DA S Y=$P($G(^EDPB(233.2,"AS",LIST,IEN,DA)),U,2)
 I Y="" S Y=$P(X0,U,2) ;use nat'l value if no local
 Q Y
 ;
EPERS(IEN) ; Return external value for a Person (file 200)
 Q:$G(IEN) $P($G(^VA(200,+IEN,0)),U)
 Q ""
 ;
EDATE(FMDT) ; Return external value for a Date/Time
 Q:$G(FMDT) $TR($$FMTE^XLFDT(FMDT,"2M"),"@"," ") ;MM/DD/YY HH:MM
 Q ""
 ;
ETIME(MINS) ; Return #minutes as HH:MM
 N H,M,Y S MINS=+$G(MINS)
 S H=MINS\60,M=MINS#60
 S Y=H_":"_$S($L(M)=1:"0"_M,1:M)
 Q Y
 ;
MD(LOG) ; Return time physician was first assigned
 N IDX,ROOT,D,X,Y S Y="",LOG=+$G(LOG)
 S IDX=$NA(^EDP(230.1,"ADF",LOG)),ROOT=$TR(IDX,")")
 F  S IDX=$Q(@IDX) Q:$P(IDX,",",1,3)'=ROOT  D  Q:Y
 . S D=+$P(IDX,",",4),X=$P($G(^EDP(230.1,+$P(IDX,",",5),3)),U,5)
 . I X'="" S Y=D
 Q Y
 ;
ACUITY(LOG) ; Return time acuity was first assigned
 N IDX,ROOT,D,X,Y S Y="",LOG=+$G(LOG)
 S IDX=$NA(^EDP(230.1,"ADF",LOG)),ROOT=$TR(IDX,")")
 F  S IDX=$Q(@IDX) Q:$P(IDX,",",1,3)'=ROOT  D  Q:Y
 . S D=+$P(IDX,",",4),X=$P($G(^EDP(230.1,+$P(IDX,",",5),3)),U,3)
 . S:X Y=D
 Q Y
 ;
LVWAITRM(LOG) ; Return time patient left waiting room
 N IDX,ROOT,D,D1,X,ROOM S Y="",LOG=+$G(LOG)
 ; get list of room changes in ROOM(time)= 231.8 ien
 S IDX=$NA(^EDP(230.1,"ADF",LOG)),ROOT=$TR(IDX,")")
 F  S IDX=$Q(@IDX) Q:$P(IDX,",",1,3)'=ROOT  D
 . S D=+$P(IDX,",",4),X=+$P($G(^EDP(230.1,+$P(IDX,",",5),3)),U,4)
 . I X,D S ROOM(D)=X
 ; look for movement in and out of waiting room
 S D=0 F  S D=$O(ROOM(D)) Q:D<1  S D1=$O(ROOM(D)) D  Q:Y
 . N RM,NXT S RM=ROOM(D),NXT=$S(D1:ROOM(D1),1:0)
 . I NXT,NXT'=RM,$$WAIT(RM),'$$WAIT(NXT) S Y=D1 ;$S(D1:D1,1:OUT)
 Q Y
 ;
WAIT(X) ; Return 1 or 0, if X is a waiting room
 Q $P($G(^EDPB(231.8,+$G(X),0)),U,9)=2
 ;
ADMIT(LOG) ; Return 1st time admitting disposition was assigned
 N D,I,X0,X,Y,OUT S Y="",LOG=+$G(LOG)
 S D=0 F  S D=$O(^EDP(230.1,"ADF",LOG,D)) Q:D<1  S I=+$O(^(D,0)) D  Q:Y
 . S X0=$G(^EDP(230.1,I,0))
 . I $P(X0,U,11),$P($G(^EDPB(233.1,+$P(X0,U,11),0)),U,5)["A" S Y=D
 I Y="" D  ;ck old format
 . N X1 S X1=$G(^EDP(230,LOG,1))
 . I $P(X1,U,2),$P($G(^EDPB(233.1,+$P(X1,U,2),0)),U,5)["A" S Y=$P(X1,U,3)
 I Y S OUT=$P($G(^EDP(230,LOG,0)),U,9) S:OUT&(OUT<Y) Y=OUT ;use Time Out if earlier
 Q Y
DISP(X) ;Return disposition abbreviation or display name from file 233.2
 ;X = IEN of disposition entry in file 233.1
 I +X=0 Q ""
 N DA,DISP,Y
 S Y=EDPSTA_".disposition"
 S DA=0 F  S DA=$O(^EDPB(233.2,"AS",Y,+X,DA)) Q:DA=""  D
 . S DISP=$P($G(^EDPB(233.2,"AS",Y,+X,DA)),U)
 . I '$L(DISP) S DISP=$E($TR($P($G(^EDPB(233.2,"AS",Y,+X,DA)),U,2)," ","_"),1,30)
 Q DISP
