ORCDLR1 ;SLC/MKB,JFR - Utility fcns for LR dialogs cont ;8/29/02  14:45
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**4,29,49,61,79,141,243,296**;Dec 17, 1997;Build 19
 ;
EN ; -- Entry Action for LR OTHER LAB TESTS order dialog
 D GETIMES S ORMAX=0
 S:$G(ORL) ORMAX=$$GET^XPAR("LOC.`"_+ORL,"LR MAX DAYS CONTINUOUS",1,"Q")
 Q
 ;
EX ; -- Exit Action for order dialog
 K ORTIME,ORCOLLCT,ORMAX,ORTEST,ORDIV,ORIMTIME,ORSMAX,ORSTMS,ORSCH,ORCAT
 I $G(ORXL) S ORL=ORXL K ORXL
 Q
 ;
GETIMES ; -- Set list of routine collections into ORTIME($H)=FMtime
 N I,X,CNT,ON K ORTIME
 I '$D(VALIDT) D
 . S I=$$PTR^ORCD("OR GTX START DATE/TIME"),X=$P(ORDIALOG(I,0),U,2)
 . S X="T::ETX",$P(ORDIALOG(I,0),U,2)=X ; reset lower bound
 S ORDIV=+$P($G(^SC(+$G(ORL),0)),U,4) S:'ORDIV ORDIV=+$G(DUZ(2))
 I $G(OREVENT) S ORDIV=+$$DIV^OREVNTX(OREVENT),ORXL=$G(ORL),ORL=$$LOC^OREVNTX(OREVENT)
 D GETLST^XPAR(.ORTIME,ORDIV_";DIC(4,","LR PHLEBOTOMY COLLECTION","N")
 S (I,CNT)=0 F  S I=$O(ORTIME(I)) Q:I'>0  S CNT=CNT+1,X=$P(ORTIME(I),U),ORTIME(I)=X,ORTIME("B",+("."_X))=I ; ORTIME($H time)=0000 FM time, ORTIME("B",.0000)=$H time of cut-off
 S ORTIME=CNT,I=$O(ORTIME(0)) S:I ORTIME("AM")=ORTIME(I) ; 1st collection
 S I=$O(ORTIME($P($H,",",2))) S:I ORTIME("NEXT")=ORTIME(I) ;NEXT coll
 S ON=$$ON^LR7OV4(ORDIV) D:ON SHOW^LR7OV4(ORDIV,.ORIMTIME)
 I 'ON,'$D(VALIDT) S I=$$PTR^ORCD("OR GTX COLLECTION TYPE"),X=$P(ORDIALOG(I,0),U,2),$P(ORDIALOG(I,0),U,2)=$P(X,";",1,3) ;Remove Immed if '$$ON
 Q
 ;
DEFTIME() ; -- Returns default collection time
 I $L($G(LRFDATE)) S EDITONLY=1 Q LRFDATE
 I '$D(ORCOLLCT) Q ""
 N Y S Y="" I $D(^TMP("ORECALL",$J,ORDIALOG,PROMPT)) D  Q:$L(Y) Y
 . S Y=$$RECALL^ORCD(PROMPT)
 . I '$S(ORCOLLCT="LC":$$LABCOLL(Y),ORCOLLCT="I":$$IMMCOLL(Y),1:$$CKDATE(Y)) S Y="" Q
 . S EDITONLY=1
 ;I $G(ORTYPE)="Q" Q $S(ORCOLLCT="LC":"AM",1:"")
 D LIST^ORCD:ORCOLLCT="LC"&$G(ORDIALOG(PROMPT,"LIST"))
 D IMMTIMES:ORCOLLCT="I"&$O(ORIMTIME(0))
 Q $S(ORCOLLCT="LC":"NEXT",ORCOLLCT="I":$$IMMDEF,ORCOLLCT="WC":"NOW",1:"TODAY")
 ;
IMMDEF() ; -- Returns immediate collect default
 N X,Y S X=$$DEFTIME^LR7OV4(ORDIV)
 S Y=$S($P(X,U,3):"NOW+"_$P(X,U,3)_"'",1:$P(X,U))
 Q Y
 ;
COLLTIME ; -- Get list of common collection times
 I ORCOLLCT="I" D:'$D(ORIMTIME) SHOW^LR7OV4(ORDIV,.ORIMTIME)
 I ORCOLLCT'="LC" K ORDIALOG(PROMPT,"LIST") Q
 Q:$G(ORDIALOG(PROMPT,"LIST"))  Q:'$O(ORTIME(0))
 N I,X,CNT,NEXT,DAY,NOW S NOW=$P($H,",",2)
 S NEXT=$O(ORTIME(NOW)),DAY=$$NEXTCOLL($S(NEXT:"T",1:"T+1")) Q:DAY=""
 S:'NEXT!(DAY["+") NEXT=$O(ORTIME(0))
 S CNT=1,ORDIALOG(PROMPT,"LIST",1)="NEXT^NEXT Lab collection ("_DAY_"@"_$$TIME(ORTIME(NEXT))_")",ORDIALOG(PROMPT,"LIST","B","NEXT LAB COLLECTION")="NEXT"
 S ORDIALOG(PROMPT,"LIST","B","AM LAB COLLECTION")="AM"
 G:ORTIME'>1 CTMQ ; only NEXT
 S I=NEXT F  S I=$O(ORTIME(I)) Q:I'>0  S X=DAY_"@"_$$TIME(ORTIME(I)),CNT=CNT+1,ORDIALOG(PROMPT,"LIST",CNT)=X_"^Routine Lab collection ("_X_")",ORDIALOG(PROMPT,"LIST","B","ROUTINE LAB COLLECTION")=X
 I NEXT>$O(ORTIME(0)) D  ;add morning times before NEXT to T+1
 . S DAY="T+"_(+$P(DAY,"+",2)+1),DAY=$$NEXTCOLL(DAY),I=$O(ORTIME(0))
 . S X=DAY_"@"_$$TIME(ORTIME("AM")),CNT=CNT+1,ORDIALOG(PROMPT,"LIST",CNT)="AM^AM Lab collection ("_X_")"
 . F  S I=$O(ORTIME(I)) Q:(I'>0)!(I'<NEXT)  S X=DAY_"@"_$$TIME(ORTIME(I)),CNT=CNT+1,ORDIALOG(PROMPT,"LIST",CNT)=X_"^Routine Lab collection ("_X_")",ORDIALOG(PROMPT,"LIST","B","ROUTINE LAB COLLECTION")=X
CTMQ S ORDIALOG(PROMPT,"LIST")=CNT
 Q
 ;
NEXTCOLL(START) ; -- Returns the next day that routine lab collects are done
 N X,Y,%DT,OFFSET,ORDAYS,PARAM I '$O(ORTIME(0)) Q "" ; no Lab collect
 S:'$D(START) START="T" S OFFSET=+$P(START,"+",2),START=$P(START,"+")
 F ORDAYS=1:1:7 D  Q:$D(X)  S OFFSET=OFFSET+1 ; ck up to a week
 . S %DT="X",X=START_$S(OFFSET:"+"_OFFSET,1:"")
 . D ^%DT I Y'>0 K X Q
 . I $G(ORL),$$GET^XPAR("ALL^LOC.`"_+ORL,"LR EXCEPTED LOCATIONS") Q
 . S PARAM="LR COLLECT "_$$UP^XLFSTR($$DOW^XLFDT(Y))
 . I '$$GET^XPAR("ALL",PARAM) K X Q
 . I '$$GET^XPAR("ALL","LR IGNORE HOLIDAYS"),$D(^HOLIDAY($P(Y,"."))) K X Q
 S Y=$S($D(X):X,1:"")
 Q Y
 ;
TIME(X) ; -- Returns 00:00AM from 0000 FileMan time
 N HOUR,MIN,XM,Y
 S HOUR=$E(X,1,2),MIN=$E(X,3,4),XM="AM"
 I HOUR'<12 S XM="PM" S:HOUR>12 HOUR=HOUR-12
 S:$E(HOUR)="0" HOUR=$E(HOUR,2) ; strip leading 0
 S Y=HOUR_":"_MIN_XM
 Q Y
 ;
LISTCOLL ; -- Lists the routine collection times for ??-help
 I '$O(ORTIME(0)) W !,"No routine lab collection times defined." Q
 N I,X S I=0,X=""
 F  S I=$O(ORTIME(I)) Q:I'>0  S X=X_$S($L(X):", ",1:"")_$$TIME(ORTIME(I))
 W !,"Routine collection times are "_X_"."
 W !,"You may also enter AM for the morning collection, or NEXT for the next",!,"routine collection time."
 Q
 ;
IMMTIMES ; -- Show the valid date/times for immediate collect
 N I S I=0
 F  S I=$O(ORIMTIME(I)) Q:I'>0  W !,ORIMTIME(I)
 Q
 ;
CKDATE(X) ; -- Valid coll time for SP or WC?
 S X=$$UP^XLFSTR(X) I ("NOW"[X)!("TODAY"[X) Q 1
 I X?1"T+"1.3N,+$P(X,"+",2)'>370 Q 1
 N Y,%DT,D
 I X'?7N.1".".6N S %DT="TX" D ^%DT S:Y>0 X=Y I Y'>0 Q "0^Invalid date/time"
 S D=$P(X,".") I D<DT Q "0^Cannot order for past days"
 I $P(X,".",2),X<$$NOW^XLFDT,'$G(OREVENT),$G(ORTYPE)'="Z" Q "0^The requested collection time has passed"
 I D>$$FMADD^XLFDT(DT,370) Q "0^Cannot order more than 370 days in advance"
 Q 1
 ;
IMMCOLL(X) ; -- Valid immediate collection date/time?
 I X?1"NOW+"1.N1"'" Q 1
 I X'?7N.1".".6N N Y,%DT S %DT="T" D ^%DT S:Y>0 X=Y I Y'>0 Q "0^Invalid date/time"
 Q $$VALID^LR7OV4(ORDIV,X)
 ;
LABCOLL(ORXTIM) ; -- Valid lab collection date/time?
 ;    Returns valid flag of 1 or 0^message
 N I,X,Y,%DT,ORD,ORT,PARAM,ORDY
 I '$O(ORTIME(0)) Q "0^There are no lab collection times defined!"
 I (ORXTIM="AM")!(ORXTIM="NEXT") Q 1
 I ORXTIM'?7N.1".".6N S %DT="T",X=ORXTIM D ^%DT S:Y>0 ORXTIM=Y I Y'>0 Q "0^Invalid date/time"
 ;I ORXTIM?1"V".E S T="."_$P(ORXTIM,"@",2) G D1 ; Visit - ignore day (D ^%DT ??)
 S ORD=$P(ORXTIM,"."),ORT="."_$P(ORXTIM,".",2)
 S:ORT="." ORT=+("."_$G(ORTIME("AM")))
 I '$D(ORTIME("B",ORT)) Q "0^Invalid lab collection time"
LC1 ; -- check date
 I ORD<DT Q "0^Can not order for past days."
 I ORXTIM<$$NOW^XLFDT,'$G(OREVENT) Q "0^Cannot order in the past"
 I $G(ORTYPE)'="Z",'$G(OREVENT),ORD=DT,$P($H,",",2)>ORTIME("B",ORT) Q "0^The cut-off time for this collection has passed"
 S ORDY=7 I $D(^XTV(8989.51,"B","LR LAB COLLECT FUTURE")),$G(ORL) S ORDY=+$$GET^XPAR("ALL^DIV.`"_ORDIV_"^LOC.`"_+ORL,"LR LAB COLLECT FUTURE",1,"I")
 I ORXTIM>$$FMADD^XLFDT($$NOW^XLFDT,ORDY) Q "0^Cannot order a lab collection more than "_ORDY_" days in advance"
 I $G(ORL),$$GET^XPAR("ALL^LOC.`"_+ORL,"LR EXCEPTED LOCATIONS") Q 1
 S PARAM="LR COLLECT "_$$UP^XLFSTR($$DOW^XLFDT(ORD))
 I $G(ORTYPE)'="Z",'$$GET^XPAR("ALL",PARAM) Q "0^There are no lab collections that day"
 I $G(ORTYPE)'="Z",'$$GET^XPAR("ALL","LR IGNORE HOLIDAYS"),$D(^HOLIDAY(ORD)) Q "0^There are no lab collections on holidays"
 Q 1
 ;
LABSAMP() ; -- Lab Collect sample?
 N X,Y S X=+$$VAL^ORCD("COLLECTION SAMPLE"),Y=$P($G(^LAB(62,X,0)),U,7)
 Q Y
 ;
COLLTYPE() ; -- Returns default collection type
 N Y I $G(ORTYPE)="Z" S Y="" G CTQ
 I $L($G(LRFZX)) S Y=LRFZX,EDITONLY=1 G CTQ
 I $D(^TMP("ORECALL",$J,+ORDIALOG,PROMPT)) D  G CTQ
 . S Y=$$RECALL^ORCD(PROMPT),EDITONLY=1
 S:$G(ORL) Y=$$GET^XPAR("ALL^"_ORL,"LR DEFAULT TYPE QUICK")
 I '$L($G(Y)) S Y=$S('$$INPT^ORCD:"SP",$G(ORTYPE)="Q":"LC",1:"WC")
CTQ I Y="I",'$O(ORIMTIME(0))!('$G(ORTEST("Lab CollSamp"))) S Y="WC"
 I Y="LC",'$O(ORTIME(0))!('$G(ORTEST("Lab CollSamp"))) S Y="WC"
 ;S:$G(ORTYPE)="Q" EDITONLY=1
 I '(FIRST&EDITONLY) D HELPTYPE
 Q Y
 ;
CKTYPE ; -- Valid type for time, sample?
 I Y="LC",'$O(ORTIME(0)) W $C(7),!,"There are no lab collection times defined!" K DONE Q
 I Y="I",'$O(ORIMTIME(0)) W $C(7),!,"There are no immediate collection times defined!" K DONE Q
 I (Y="LC"!(Y="I")),'$G(ORTEST("Lab CollSamp")) W $C(7),!,"There is no lab collection sample defined for this test!",! K DONE Q
 I $D(ORESET),ORESET'=Y,("ILC"[ORESET)!("ILC"[Y) D CHANGED^ORCDLR("TYPE") K ORDIALOG($$PTR^ORCD("OR GTX LAB URGENCY"),"LIST")
 Q
 ;
HELPTYPE ; -- Xecutable help for Coll Type
 W !!,"SEND TO LAB - Means the patient is ambulatory and will be sent to the",!,"Laboratory draw room to have blood drawn."
 W !,"WARD COLLECT - Means that either the physician or a nurse will be collecting",!,"the sample on the ward."
 W !,"LAB BLOOD TEAM - Means the phlebotomist from Lab will draw the blood on the",!,"ward.  This method is limited to laboratory defined collection times."
 W:$$ON^LR7OV4(ORDIV) !,"IMMEDIATE COLLECT BY BLOOD TEAM - Means the phlebotomist from Lab is on",!,"call to draw blood on the ward.  This method is available during times",!,"defined by Laboratory." W !
 N DOMAIN S DOMAIN=$P(ORDIALOG(PROMPT,0),U,2) D SETLST1^ORCD
 Q
VALID(ORDER) ;check collection time on release
 N VALIDT,OREVENT,COLLTYPE,COLLDT,OK,ORDIV,ORTXT,ORPTLK,ORTIME,ORIMTIME,ORACT
 S VALIDT="" D GETIMES
 S COLLDT=$$VALUE^ORCSAVE2(ORDER,"START")
 S COLLTYPE=$$VALUE^ORCSAVE2(ORDER,"COLLECT")
 I $L($P(^OR(100,+ORIFN,0),U,17)) S OREVENT=$P(^(0),U,17)
 I "NOWAMNEXT"[COLLDT D:'$G(OREVENT) MULT Q 1 ;OK
 S OK=$S(COLLTYPE="LC":$$LABCOLL(COLLDT),COLLTYPE="I":$$IMMCOLL(COLLDT),1:$$CKDATE(COLLDT))
 I OK D:'$G(OREVENT) MULT Q 1 ;COLLDT passed checks
 W !!,$C(7),$P(OK,U,2)
 D TEXT^ORQ12(.ORTXT,ORDER) W !,$G(ORTXT(1)) K ORTXT
 W !,"must be edited before signing/release." K VALIDT D
 . N ORDIV,ORIMTIME,ORTIME,ORNP
 . S ORNP=$P(^OR(100,ORDER,0),U,4)
 . S ORACT="XX" D XX^ORCACT4 ;edit order
 I $$VALUE^ORCSAVE2(ORDER,"START")'=COLLDT D:'$G(OREVENT) MULT Q 1 ;OK
 Q 0
 ;
MULT ; -- ck child orders
 N CHGD S CHGD=$$MULT^ORCDLR(ORDER,COLLTYPE,COLLDT) Q:'CHGD
 W !!,$P(CHGD,U,2) H 2
 Q
