HMPEF1 ;SLC/MKB,ASMR/RRB,JD,SRG,CPC,CK - Serve VistA operational data as JSON via RPC;June 24, 2016 13:17:46
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;Sep 01, 2011;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; HMPEF (cont'd)
 ;
 ; JD - 4/20/16 - Fixed undefined for invalid genders (NP1 block). DE4411
 Q
 ;
LOC(HMPFINI,HMPFLDON,HMPMETA) ; Hospital Location (#44) and Ward Location (#42)  /DE2818
 N L42,L44
 ;BL;DE2188 This line tag has to make two complete passes through 
 ;the two FOR loops. In order to do this it is necessary to clearly 
 ;define the loop we are doing. The file 44 and 
 ;file 42 loops cannot be done at the same time
 ;
 ; Need variables to clearly define which pass we are on.
 ; 
 ; HMPFLDON indicates the loop
 ; HMPFLDON=0 means we are on L44
 ; HMPFLDON=1 means we are on L42
 ;
 S HMPCNT=$$TOTAL^HMPEF("^SC")+$$TOTAL^HMPEF("^DIC(42)") ; total file counts will be inaccurate for location domain
 ;
 ;BL/CPC - Handle single location or ward for restart
 I $G(HMPID) I $G(HMPID)'["w" D LOC44(HMPID) Q
 I $D(HMPID) I $G(HMPID)["w" D LOC42($TR(HMPID,"w","")) Q
 ;
 ;BL/CPC - determine if location or ward for restart
 I '$G(HMPFLDON) S L44=+$G(HMPLAST),L42=0  ; HMPFLDON=0 means we are on L44
 I $G(HMPFLDON) S L44=0,L42=+$G(HMPLAST)  ;  HMPFLDON=1 means we are on L42
 ; ^SC - IA 10040
 I '$G(HMPFLDON) F  S L44=$O(^SC(L44)) Q:L44<1  D LOC44(L44) I HMPMAX>0,HMPI'<HMPMAX Q  ;BL/cpc
 I HMPMAX>0,HMPI'<HMPMAX Q  ;BL/CPC prevents drop through
 I $G(HMPMETA)'=1 S HMPFLDON=1 ;BL/cpc mark locations complete ;US11019
 ; ^DIC(42) - IA 10039 DE2818
 F  S L42=$O(^DIC(42,L42)) Q:L42<1  D LOC42(L42) I HMPMAX>0,HMPI'<HMPMAX Q  ;BL/cpc
 I (L44<1)&(L42<1) S HMPFINI=1 ;BL/cpc - fix boolean error
 Q
 ;
LOC44(IEN) ; get one hospital location
 N $ES,$ET,ERRMSG
 S ERRMSG=$$ERRMSG^HMPEF("Location",IEN)
 S $ET="D ERRHDLR^HMPDERRH"
 N LOC,X0,X,Y
 ; if location is a WARD, ignore because file #42 will be used for wards
 S X0=$G(^SC(IEN,0)) I $P(X0,U,3)="W" Q  ; ^SC - IA 10040
 S LOC("name")=$P(X0,U)
 S LOC("localId")=IEN,LOC("uid")=$$SETUID^HMPUTILS("location",,IEN)
 S X=$P(X0,U,2) S:$L(X) LOC("shortName")=X S LOC("type")=$P(X0,U,3)
 S LOC("refId")=IEN,LOC("oos")=$S(+$G(^SC(IEN,"OOS")):"true",1:"false")
 S X=+$P(X0,U,4) I X D
 . S Y=$$NS^XUAF4(X),X=$P(Y,U,2)_U_$P(Y,U)
 . D FACILITY^HMPUTILS(X,"LOC")
 I '$$ACTLOC^HMPEF(IEN) S LOC("inactive")="true"
 D ADD^HMPEF("LOC") S HMPLAST=IEN
 Q
 ;
LOC42(IEN) ; get one ward location
 ; IEN - file 42 IEN
 ; references to ^DIC(42) via IA #10039
 ;
 N $ES,$ET,DIV,ERRMSG
 S ERRMSG=$$ERRMSG^HMPEF("Ward Location",IEN)
 S $ET="D ERRHDLR^HMPDERRH"
 N LOC,X,X0,Y
 S X0=$G(^DIC(42,IEN,0))
 S:$G(^DIC(42,IEN,0))'="" LOC("name")=$P(^DIC(42,IEN,0),U)  ;IA #10039
 S LOC("localId")=IEN,LOC("uid")=$$SETUID^HMPUTILS("location",,"w"_IEN)  ; wards have a "w"
 S LOC("type")="W"  ; always 'W' for ward
 S LOC("refId")=IEN
 S LOC("oos")="false" ; occasion of service is always false for ward locations
 S DIV=+$P(X0,U,11)
 S X=+$P($G(^DG(40.8,DIV,0)),U,7) I X D  ;ICR 417 DE2818 ASF 11/21/15
 . S Y=$$NS^XUAF4(X),X=$P(Y,U,2)_U_$P(Y,U)
 . D FACILITY^HMPUTILS(X,"LOC")
 ; out-of-service flag
 I '$$ACTWRD^HMPEF(IEN) S LOC("inactive")="true"  ; boolean field only exists if ward is inactive
 D ADD^HMPEF("LOC") S HMPLAST=IEN
 Q
 ;
NP ;New Persons
 ; Variables from HMPEF: HMPCNT,HMPID,HMPMAX,HMPI,HMPFINI
 N PRV
 S HMPCNT=$$TOTAL^HMPEF("^VA(200)")  ; IA 10035
 I $G(HMPID) D NP1(HMPID) Q
 S PRV=+$G(HMPLAST) ;$S(HMPLAST:HMPLAST,1:.9)
 I PRV=0 S PRV=.9
 F  S PRV=$O(^VA(200,PRV)) Q:'PRV  I PRV'<1 D NP1(PRV) I HMPMAX>0,HMPI'<HMPMAX Q  ;DE4778
 I 'PRV S HMPFINI=1 ;DE4778
 Q
 ;
NP1(IEN) ;one person
 N $ES,$ET,ERRMSG
 S ERRMSG=$$ERRMSG^HMPEF("person",IEN)
 S $ET="D ERRHDLR^HMPDERRH"
 N HMPV,FLDS,USER,X,Y
 I $$ISPROXY^HMPEF(IEN)=1 Q
 K HMPV S FLDS=".01;1;4:9.2;9.5*;19:53.8;654.3;.132:.138"  ;DE5361 6/20/2016 - incomplete Note Addendum Signature Block, send additional fields
 D GETS^DIQ(200,IEN_",",FLDS,"IEN","HMPV")
 S Y=$NA(HMPV(200,IEN_","))
 I '$L($G(@Y@(.01,"E"))) Q  ;DE4778 skip invalid entry
 S USER("name")=$G(@Y@(.01,"E"))
 S USER("localId")=IEN,USER("uid")=$$SETUID^HMPUTILS("user",,IEN)
 S X=$G(@Y@(1,"E")) S:$L(X) USER("initials")=X  ;DE5361
 ;Added $Gs to guard against undefined error. DE4411
 S:$L($G(@Y@(4,"I"))) USER("genderCode")="urn:va:gender:"_$G(@Y@(4,"I")),USER("genderName")=$G(@Y@(4,"E"))
 S X=+$P($G(@Y@(5,"I")),".") S:X USER("dateOfBirth")=$$JSONDT^HMPUTILS(X)
 S X=$G(@Y@(7,"I")) S:$L(X) USER("disuser")=$S(X:"true",1:"false")
 S X=$G(@Y@(8,"E")) S:$L(X) USER("title")=X
 S X=$G(@Y@(9,"E")) S:$L(X) USER("ssn")=X
 S X=$G(@Y@(9.2,"I")) S:$L(X) USER("terminated")=$$JSONDT^HMPUTILS(X)
 S X=+$G(@Y@(19,"I")) S:X USER("delegateCode")=$$SETUID^HMPUTILS("user",,X),USER("delegateName")=$G(@Y@(19,"E"))
 S X=$G(@Y@(20.2,"E")) S:$L(X) USER("signaturePrintedName")=X  ;DE5361
 S X=$G(@Y@(20.3,"E")) S:$L(X) USER("signatureTitle")=X  ;DE5361
 S X=$G(@Y@(29,"E")) S:$L(X) USER("service")=X
 S X=$G(@Y@(53.5,"E")) S:$L(X) USER("providerClass")=X
 S X=$G(@Y@(53.6,"E")) S:$L(X) USER("providerType")=X
 S X=+$G(@Y@(654.3,"I")) S:X USER("surrogateCode")=$$SETUID^HMPUTILS("user",,X),USER("surrogateName")=$G(@Y@(654.3,"E"))
 S X=$G(@Y@(.132,"E")) S:$L(X) USER("officePhone")=X
 S X=$G(@Y@(.133,"E")) S:$L(X) USER("phone3")=X
 S X=$G(@Y@(.134,"E")) S:$L(X) USER("phone4")=X
 S X=$G(@Y@(.135,"E")) S:$L(X) USER("commercialPhone")=X
 S X=$G(@Y@(.136,"E")) S:$L(X) USER("fax")=X
 S X=$G(@Y@(.137,"E")) S:$L(X) USER("voicePager")=X
 S X=$G(@Y@(.138,"E")) S:$L(X) USER("digitalPager")=X
 D KEYS^HMPEF(IEN)
 D ADD^HMPEF("USER") S HMPLAST=IEN
 Q
 ;
PROB(HMPFINI,LEX) ;get problem list OPD store
 N APP,ORAPP,ORDT,ORELEM,ORWLST,IEN,ELEMENT,PLIST,HMPCNT,HMPLAST,LST
 S (ORWLST,ORDT,ORELEM)=""
 S ORDT=DT
 S IEN=0,HMPCNT=0
 S LST=$NA(^TMP("ORLEX",$J))
 S APP="GMPX"
 D CONFIG^LEXSET(APP,"PLS",ORDT)
 S (HMPCNT,HMPLAST)=0
 ; ^LEX(757.01) - IA 1571 DE2818 ASF 11/21/15
 F  S IEN=$O(^LEX(757.01,IEN)) Q:IEN=""!(IEN'?1N.N)  D
 . S ORELEM=$G(^LEX(757.01,IEN,0))
 . Q:'$D(^LEX(757.01,IEN,1))
 . D LOOK^LEXA(ORELEM,,1,,ORDT)
 . S ELEMENT=$G(LEX("LIST",1))
 . Q:ELEMENT=""
 . S ELEMENT=$$LEXXFRM^ORQQPL4(ELEMENT,ORDT,"GMPX")
 . S PLIST("uid")=$$SETUID^HMPUTILS("problem-list","",IEN)
 . S PLIST("lexIen")=$P(ELEMENT,"^",1)
 . S PLIST("lexName")=$P(ELEMENT,"^",2)
 . S PLIST("icd")=$P(ELEMENT,"^",3)
 . S PLIST("icdIen")=$P(ELEMENT,"^",4)
 . S PLIST("codeSys")=$P(ELEMENT,"^",5)
 . S PLIST("cCode")=$P(ELEMENT,"^",6)
 . S PLIST("dCode")=$P(ELEMENT,"^",7)
 . S PLIST("impDt")=$P(ELEMENT,"^",8)
 . S HMPCNT=HMPCNT+1 D ADD^HMPEF("PLIST") S HMPLAST=HMPCNT
 . Q
 S HMPFINI=1
 Q
 ;
