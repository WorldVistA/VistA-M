LRAPKLG ;DSS/FHS - MOVE SP DATA FROM SURGICAL RECORD ;09/21/16  10:44
 ;;5.2;LAB SERVICE;**462**;Sep 27, 1994;Build 44
 ; Supported calls AI #, 5286,103,3615
EN ;
 ; Called from MOVE^LRAPKOE
 ; Call with
 ; LRDFN - LRSS - LRIDT - LRCDT
 Q:$P(^LR(LRDFN,0),U,2)'=2
 N A,ANS,CASE,CNT,CNTX,D0,DA,DIC,DIR,DIRUT,DR,DTOUT,DUOUT
 N ERR,FDA,FIL,FLD,IEN,LRABORT,LRCASE,LRDIAL,LRDOC,LREDT
 N LREND,LRFHDR,LRHDR,LRI,LRIEN,LRLONG,LROK,LROPER,LROPERS
 N LROPS,LRPAGE,LRPRAC,LROTHER,LRSCAN,LRRB,LRSCAN
 N LRSDATE,LRSDOC,LRSDT,LRSDX
 N LRSTAT,LRSTATUS,LRSURGDT,LRSURPHY,LRTN,LRTREA,LRV,LRVAL
 N LRWRD,LRX,LRYN,S,STR,VADM,VA,VAL,VAIN,X,Y
EN0 ;
 S LROK=0
 S:'$G(DFN) DFN=$P(^LR(LRDFN,0),U,3) D PT^LRX
 I '$O(^SRF("ADT",DFN,0)) W !,"No Surgery Case for "_PNM Q
 S LREDT=9999999.999999-$$FMADD^XLFDT(DT,-7) ; End Date
 S LRSDT=9999999.999999-$$NOW^XLFDT ;Start Date
 W @IOF,!!,"Checking surgical record for this patient...",!
 W PNM,"  ",$P(VADM(5),U,2)," DOB:",$$FMTE^XLFDT($P(VADM(3),U),5)," SSN:",$P(VADM(2),U,2),!
 S CNT=0 F  S LRSDT=$O(^SRF("ADT",DFN,LRSDT)) Q:'LRSDT!(LRSDT>LREDT)  S LRCASE=0 F  S LRCASE=$O(^SRF("ADT",DFN,LRSDT,LRCASE)) Q:'LRCASE  D LIST
EN1 ;
 ;
 I CNT=0 W !,"No operations on record in the past 7 days.",! Q
 I CNT=1 D  Q
 . W @IOF
 . W !,"Only one operation on record available",! H 3
 . S (LRTN,LRCASE)=+LRCASE(1) D DISPLAY(LRCASE)
 . I '$G(LROK) D END Q
 . I $G(LROK) D STORE^LRAPKLG1(LRDFN,LRSS,LRIDT,.LRHDR)
 ;
OPT K DIR S DIR("?",1)="Enter the number of the operation associated with the specimen(s)",DIR("?")="or press RETURN to bypass operation selection."
 W ! S DIR("A")="Select operation associated with the specimen(s)",DIR(0)="NO^1:"_CNT
 D ^DIR I $D(DTOUT)!$D(DUOUT) Q
 I +Y S LRTN=+LRCASE(+Y),CNT=+Y
NOOP I '$D(LRTN) W !!,"No operation selected.",! Q
 S LRCASE=LRTN
 W $$CJ^XLFSTR("Entry from Surgery Case #"_LRTN,IOM),!
DOC S LRDOC=$S($P($G(^SRF(LRTN,"NON")),U)="Y":$P(^("NON"),U,6),1:$P($G(^SRF(LRTN,.1)),U,4))
DISP I $D(LRTN) S LRCASE=LRTN,LRSDATE=$P(^SRF(LRTN,0),U,9) D DISPLAY(LRCASE)
 I $G(LROK) D STORE^LRAPKLG1(LRDFN,LRSS,LRIDT,.LRHDR)
 I '$G(LROK) D END
 Q
LIST ; list cases
 W !
 S LRSCAN=1 I $P($G(^SRF(LRCASE,.2)),U,10)!$P($G(^SRF(LRCASE,.2)),U,12)!($P($G(^SRF(LRCASE,"NON")),U)="Y") K LRSCAN
 I $D(LRSCAN),$D(^SRF(LRCASE,30)),$P(^(30),U) Q
 I $D(LRSCAN),$D(^SRF(LRCASE,31)),$P(^(31),U,8) Q
 I $D(^SRF(LRCASE,37)),$P(^(37),U) Q
 S CNT=+$G(CNT)+1,LRSDATE=$P(^SRF(LRCASE,0),U,9) W !,CNT_". "
 S LRSDX=$$FMTE^XLFDT(LRSDATE,"5P")
CASE W "D/T:"_LRSDX_"  "
 N LRI,LRVAL,LROPS
 S LROPER=$P(^SRF(LRCASE,"OP"),U)
 I $O(^SRF(LRCASE,13,0)) S LROTHER=0 D
 . F  S LROTHER=$O(^SRF(LRCASE,13,LROTHER)) Q:'LROTHER  D OTHER
 S LROPER="Case #"_LRCASE_" >> "_LROPER
 D STATUS^LRAPKLG1(LRCASE)
 S:$L(LROPER)<65 LROPS(1)=LROPER
 I $L(LROPER)>64 S LROPER=LROPER_"  " F LRI=1:1 D LOOK Q:LRVAL(1)=""
 W ?14,LROPS(1) I $D(LROPS(2)) W !,?14,LROPS(2) I $D(LROPS(3)) W !,?14,LROPS(3) W:$D(LROPS(4)) !,?14,LROPS(4)
 S LRCASE(CNT)=LRCASE_U_LRSDX_U_LRSURPHY
 Q
OTHER ; Check for other operations
 ;^DD(130,.42
 S LRLONG=1 I $L(LROPER)+$L($P(^SRF(LRCASE,13,LROTHER,0),U))>235 S LRLONG=0,LROTHER=999,LROPERS=" ..."
 I LRLONG S LROPERS=$P(^SRF(LRCASE,13,LROTHER,0),U)
 S LROPER=LROPER_$S(LROPERS=" ...":LROPERS,1:", "_LROPERS)
 Q
LOOK ; parse out procedures
 S LROPS(LRI)="" F  S LRVAL=$P(LROPER," "),LRVAL(1)=$P(LROPER," ",2,200) Q:LRVAL(1)=""  Q:$L(LROPS(LRI))+$L(LRVAL)'<65  S LROPS(LRI)=LROPS(LRI)_LRVAL_" ",LROPER=LRVAL(1)
 ;
 Q
 ;
DISPLAY(LRCASE) ;Display the Dialog for a Surgery case
 ;Call with Surgery Case #   ^SRF(LRCASE#)
 ;LRHDR array contains the Surgery Package dialog
 ;Where "X" = array subscript
 ;LRHDR(33,X)="Preoperative diagnosis"
 ;LRHDR(34,X)="Post Opertive Diag"
 ;LRHDR(38,X)="Operative Finding"
 ;LRHDR(39,X)="Brief Clinical History" DD(63.08,.013)
 N CNT,DIC,DA,DR,S,LRLN,LRPAGE,IEN,LREND,LRSDOC,VAL
 S $P(LRLN," ",IOM)=" "
 S LRSDOC=$S($P($G(^SRF(LRCASE,"NON")),U)="Y":$P(^("NON"),U,6),1:$P($G(^SRF(LRCASE,.1)),U,4))
 S LREND=0
 D HDR,PRTHDR
 ;
 S LRHDR(1)=$$FMT("      ===== Above From Surgery Case#: "_LRCASE_" =====",IOM)
 S LRHDR(2)=LRLN
 S CNT=0
 ;BRIEF CLINICAL HISTORY:
 I $O(^SRF(LRCASE,39,0)) D
 . S (CNT,CNTX,IEN)=0,LRHDR=$$FMT("     Brief Clinical History",IOM) D
 . . W !,LRHDR,"  ",!
 . . F  S IEN=$O(^SRF(LRCASE,39,IEN)) Q:IEN<1!($G(LREND))  S VAL=^(IEN,0) D
 . . . S VAL=$$FMT(VAL,IOM)
 . . . W VAL,! S (CNTX,CNT)=CNT+1,LRHDR(39,CNT)=VAL
 D PAGE
 Q:$G(LREND)
 I $G(CNTX) D FOOT(39,CNTX)
 ;
 ;Pre-Operative Diagnosis
 I $P($G(^SRF(LRCASE,33)),U)'="" K CNTX D
 . D PAGE Q:LREND
 . S LRHDR=$$FMT("     Pre-Operative Diagnosis:",IOM),CNTX=0
 . W !,LRHDR,!
 . S CNT=1,VAL=$$FMT($P(^SRF(LRCASE,33),U),IOM),LRHDR(33,CNT)=VAL W VAL,!
 . D PAGE Q:$G(LREND)  S CNTX=CNT
 . N IEN
 . Q:'$O(^SRF(LRCASE,14,0))  ;Get additional Preop diagnosis
 . S LRHDR=$$FMT("        Additional Pre-Operative Diagnosis",IOM) W !,LRHDR,!
 . S IEN=0 F  S IEN=$O(^SRF(LRCASE,14,IEN)) Q:IEN<1!($G(LREND))  D
 . . Q:$P($G(^SRF(LRCASE,14,IEN,0)),U)=""
 . . S VAL=$$FMT($P(^SRF(LRCASE,14,IEN,0),U),IOM)
 . . S (CNTX,CNT)=CNT+1,LRHDR(33,CNT)=VAL W VAL,!
 . . D PAGE
 Q:$G(LREND)
 I $G(CNTX) D FOOT(33,CNTX)
 ;Operative findings
 S (CNT,CNTX,IEN)=0,LRHDR=$$FMT("     Operative Finding",IOM) I $O(^SRF(LRCASE,38,0)) D
 . D PAGE Q:$G(LREND)
 . W !,LRHDR,"  ",!
 . D PAGE Q:$G(LREND)
 . F  S IEN=$O(^SRF(LRCASE,38,IEN)) Q:IEN<1!($G(LREND))  S VAL=^(IEN,0) D
 . . S VAL=$$FMT(VAL,IOM)
 . . W VAL,! S (CNTX,CNT)=CNT+1,LRHDR(38,CNT)=VAL D PAGE Q:$G(LREND)
 I $G(CNTX) D FOOT(38,CNTX)
 Q:$G(LREND)
 K CNT,CNTX,VAL
 ;Post Operative Diagnosis
 I $P($G(^SRF(LRCASE,34)),U)'="" S CNT=1 D
 . S VAL=$$FMT($P(^SRF(LRCASE,34),U),IOM)
 . S LRHDR(34,CNT)=VAL
 . S LRHDR=$$FMT("     Post Operative Diagnosis",IOM),CNTX=CNT
 . D PAGE Q:LREND
 . W !,LRHDR,!
 . W VAL,!
 . N IEN
 . S IEN=0 F  S IEN=$O(^SRF(LRCASE,15,IEN)) Q:IEN<1!$G(LREND)  D
 . . Q:$P($G(^SRF(LRCASE,15,IEN,0)),U)=""
 . . S VAL=$$FMT($P(^SRF(LRCASE,15,IEN,0),U),IOM)
 . . S (CNTX,CNT)=CNT+1,LRHDR(34,CNT)=VAL
 . . W VAL,! D PAGE
 Q:$G(LREND)
 I $G(CNTX) D FOOT(34,CNTX)
 D YN("Move this information into Laboratory Patient Record File")
 Q
PAGE ;End of page prompt
 Q:$Y<(IOSL-2)
 S LREND=0
 K DTOUT,DUOUT,DIRUT,Y,DIR
 S DIR(0)="E" D ^DIR
 I Y=0 S LREND=1 Q
 I Y=1 D PRTHDR
 Q
HDR ;Setup Header information
 S LRSURPHY="DR:"_$$GET1^DIQ(200,LRSDOC_",",.01,"ANS","ERR")
 S LRSURGDT=$$FMTE^XLFDT($P(^SRF(LRCASE,0),U,9),"1P")_"  DOB: "_$$FMTE^XLFDT(DOB,2)
 S LRHDR(0)=PNM_" SSN:"_SSN_" CASE# "_LRCASE
 S LRHDR(0,1)=" Surgery Date:"_LRSURGDT_" "_LRSURPHY
 Q
PRTHDR ; Print report header info
 S LRPAGE=$G(LRPAGE)+1
 W:'$G(LRFHDR) !!!
 W:$G(LRFHDR) @IOF
 S LRFHDR=1
 W $$CJ^XLFSTR("PG:"_LRPAGE_"  "_LRHDR(0),IOM)
 W !,$$CJ^XLFSTR(LRHDR(0,1),IOM),!
 Q
YN(STR) ;Yes No response
 N DTOUT,DUOUT,DIRUT,X,Y,DIR
 S LROK=0,LREND=1
 S DIR(0)="Y",DIR("A")=STR,DIR("B")="No"
 D ^DIR
 S:+$G(Y)=1 LROK=1,LREND=0
 Q
END ;User Termination Response
 W !,$$CJ^XLFSTR("No Surgery Data was transferred",IOM),!
 Q
FMT(VAL,IOM) ;Format line to IOM length
 Q VAL
 W "+" I $L(VAL)>71 Q VAL
 I VAL="" S VAL=" "
 S VAL=VAL_$E(LRLN,$L(VAL),71)
 Q VAL
FOOT(SEG,LRX) ;Add Surgery case # field separator
 S LRX=LRX+1,LRHDR(SEG,LRX)=LRHDR(1)
 S LRX=LRX+1,LRHDR(SEG,LRX)=LRHDR(2)
 Q
