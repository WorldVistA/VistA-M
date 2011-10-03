EDPRPT ;SLC/MKB - Reports
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
EN(BEG,END,RPT,ID,CSV) ; Get RPT data for EDPSITE by date range
 N NOW S NOW=$$NOW
 I BEG,END D  ;check
 . N X I END<BEG S X=BEG,BEG=END,END=X ;switch
 . S:$L(END,".")<2 END=END_".2359"
 S RPT=$$UP^XLFSTR($G(RPT))
 ; switch on report type
 I RPT="EXPOSURE"   D EXP^EDPRPT7(ID)       G CONT
 I BEG<1            D ERR(2300012)          G CONT
 I RPT="SHIFT"      D SFT^EDPRPT5(BEG)      G CONT
 I END<1            D ERR(2300012)          G CONT
 I RPT="ACTIVITY"   D ACT^EDPRPT1(BEG,END)  G CONT
 I RPT["DELAY"      D DEL^EDPRPT2(BEG,END)  G CONT
 I RPT="SUMMARY"    D SUM^EDPRPT4(BEG,END)  G CONT
 I RPT="MISSEDOP"   D MO^EDPRPT3(BEG,END)   G CONT
 I RPT="PROVIDER"   D PRV^EDPRPT6(BEG,END)  G CONT
 I RPT="ACUITY"     D ACU^EDPRPT8(BEG,END)  G CONT
 I RPT="PATIENT"    D XRF^EDPRPT9(BEG,END)  G CONT
 I RPT="ADMISSIONS" D ADM^EDPRPT10(BEG,END) G CONT
 I RPT="INTAKE"     D CNT^EDPRPT11(BEG,END) G CONT
 I RPT="ORDERS"     D ORD^EDPRPT12(BEG,END) G CONT
 I RPT="BVAC"       D EN^EDPRPTBV(BEG,END)  G CONT
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
