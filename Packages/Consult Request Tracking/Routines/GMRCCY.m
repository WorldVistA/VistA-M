GMRCCY ;SFVAMC/DAD - Consult Closure Tool: Date Range Selector ;01/20/17 15:19
 ;;3.0;CONSULT/REQUEST TRACKING;**89**;DEC 27, 1997;Build 62
 ;Consult Closure Tool
 ;
 ; IA#    Usage      Component
 ; ---------------------------
 ; 10003  Supported  ^%DT        
 ; 10103  Supported  $$FMTE^XLFDT
 ; 10103  Supported  $$SCH^XLFDT 
 ; 10104  Supported  $$UP^XLFSTR 
 ;
EN(GMTBEG,GMTEND,GMHEAD,GMRANG) ; *** Entry Point
 ; Input
 ;  GMTBEG = Begin date - Default (FM Int) [Req, Pass by ref]
 ;  GMTEND = End   date - Default (FM Int) [Req, Pass by ref]
 ;  GMHEAD = Header line [Opt, Pass by value]
 ;  GMRANG = Date range type [Opt, Pass by value]
 ;             M,M!,Q,Q!,S,S!,Y,Y!,F,F!,U,U!  ("!" forces selection)
 ; Output
 ;  $$EN()   = 1 - Okay   OR   0 - Exit
 ;  GMTBEG = Begin date [If $$EN()=1 FM Int Date, Else ""]
 ;  GMTEND = End   date [If $$EN()=1 FM Int Date, Else ""]
 ;
 ; Example
 ;  IF $$EN^GMDATE(.GMTBEG,.GMTEND,GMHEAD,GMRANG)'>0 QUIT
 ;
 N GM,GMDATA,GMDFLT,GMDONE,GMFRAM,GMQUIT,GMWHEN,X,Y
 S (GMFRAM,GMFRAM(0))=""
 F GM=1:1 S GMDATA=$P($T(FRAMDAT+GM),";;",2) Q:GMDATA=U  D
 . S GMFRAM=GMFRAM_U_$$UP^XLFSTR(GMDATA)
 . S GMFRAM(0)=GMFRAM(0)_GMDATA_$S(GM<6:",  ",1:"")
 . Q
 F  D  Q:GMQUIT!GMDONE
 . S (GMQUIT,GMDONE)=0
 . S GMTBEG=$S($G(GMTBEG)\1?7N:GMTBEG\1,1:"")
 . S GMTEND=$S($G(GMTEND)\1?7N:GMTEND\1,1:"")
 . S GMDFLT=$$UP^XLFSTR($G(GMRANG))_U_GMTBEG_U_GMTEND
 . I $G(GMHEAD)]"" W !,GMHEAD
 . W !,GMFRAM(0)
 . W !,"Select date range: "
 . W $S($TR($P(GMDFLT,U),"!")]"":$TR($P(GMDFLT,U),"!")_"// ",1:"")
 . S GMWHEN=""
 . I $P(GMDFLT,U)'["!" R GMWHEN:DTIME S:'$T GMWHEN=U
 . I GMWHEN="" S GMWHEN=$TR($P(GMDFLT,U),"!") W GMWHEN
 . I (GMWHEN="")!($E(GMWHEN)=U) S GMQUIT=1 Q
 . S GMWHEN=$$UP^XLFSTR(GMWHEN)
 . I $F(GMFRAM,U_GMWHEN)'>0 D  Q
 .. D BELL(GMWHEN)
 .. I $P(GMDFLT,U)["!" S GMQUIT=1 Q
 .. W !!?5,"Enter the first few letters of "
 .. W "one of the choices listed below.",!
 .. Q
 . W $P($P(GMFRAM,U_GMWHEN,2),U)
 . S GMWHEN=$E(GMWHEN)
 . S GMQUIT=$$ASKDATE(GMWHEN,GMDFLT,.GMTBEG,.GMTEND)
 . I GMQUIT D
 .. S GMQUIT=$S($P(GMDFLT,U)'["!":0,1:GMQUIT)
 .. I GMQUIT'>0 W !
 .. Q
 . E  D
 .. S GMDONE=1
 .. Q
 . Q
 S GMQUIT='$G(GMQUIT)
 I GMQUIT>0 D
 . W !!,"Range selected: "
 . W $$FMTE^XLFDT(GMTBEG,"5Z")," to ",$$FMTE^XLFDT(GMTEND,"5Z")
 . Q
 E  D
 . S (GMTBEG,GMTEND)=""
 . Q
 Q GMQUIT
 ;
FRAMDAT ;; TimeFrameName
 ;;Monthly
 ;;Quarterly
 ;;Semi-Annually
 ;;Yearly
 ;;Fiscal Yearly
 ;;User Selectable
 ;;^
 ;
ASKDATE(GMWHEN,GMDFLT,GMTBEG,GMTEND) ; *** Prompt for date range
 N GMQUIT
 S GMQUIT=1
 I GMWHEN="M" D
 . S GMQUIT=$$MONTH(GMWHEN,GMDFLT,.GMTBEG,.GMTEND)
 . Q
 I (GMWHEN="Q")!(GMWHEN="S") D
 . S GMQUIT=$$QUART(GMWHEN,GMDFLT,.GMTBEG,.GMTEND)
 . Q
 I (GMWHEN="F")!(GMWHEN="Y") D
 . S GMQUIT=$$YEAR(GMWHEN,GMDFLT,.GMTBEG,.GMTEND)
 . Q
 I GMWHEN="U" D
 . S GMQUIT=$$USERSEL(GMWHEN,GMDFLT,.GMTBEG,.GMTEND)
 . Q
 Q GMQUIT
 ;
MONTH(GMWHEN,GMDFLT,GMTBEG,GMTEND) ; *** Monthly
 N %DT,GM,GMDATA,GMDONE,GMEND,GMEOM,GMMNYR,GMMOE,GMQUIT,GMYEAR,X,Y
 F GM=1:1 S GMDATA=$P($T(MONTHDAT+GM),";;",2) Q:GMDATA=U  D
 . S GMEOM($P(GMDATA,U))=$P(GMDATA,U,2,3)
 . Q
 S (GMQUIT,GMDONE)=0
 F  D  Q:(GMQUIT>0)!(GMDONE>0)
 . K %DT
 . S %DT="AE"
 . S %DT("A")="Enter Month and Year: "
 . I $P(GMDFLT,U,2)]"" D
 .. S GMMNYR=$P(GMDFLT,U,2)
 .. S %DT("B")=$E(GMMNYR,4,5)_"/"_(1700+$E(GMMNYR,1,3))
 .. Q
 . W ! D ^%DT S GMEND=+$G(Y)
 . I GMEND'>0 S GMQUIT=1 Q
 . I ('+$E(GMEND,4,5))!(+$E(GMEND,6,7)) D  Q
 .. D BELL("")
 .. W !!,"Please enter a month and year"
 .. W $S(+$E(GMEND,6,7):" only",1:"")
 .. Q
 . S GMMOE=$E(GMEND,4,5)
 . S GMTEND=$E(GMEND,1,5)_$P(GMEOM(GMMOE),U)
 . I $E(GMTEND,4,5)="02" D
 .. S GMYEAR=1700+$E(GMTEND,1,3)
 .. S GMTEND=GMTEND+((GMYEAR#4=0)&((GMYEAR#100)!(GMYEAR#400=0)))
 .. Q
 . S GMTBEG=$E(GMTEND,1,5)_"01"
 . S GMDONE=1
 . Q
 Q GMQUIT
 ;
MONTHDAT ;; MonthNumber ^ DaysInMonth ^ MonthName
 ;;01^31^JANUARY
 ;;02^28^FEBRUARY
 ;;03^31^MARCH
 ;;04^30^APRIL
 ;;05^31^MAY
 ;;06^30^JUNE
 ;;07^31^JULY
 ;;08^31^AUGUST
 ;;09^30^SEPTEMBER
 ;;10^31^OCTOBER
 ;;11^30^NOVEMBER
 ;;12^31^DECEMBER
 ;;^
 ;
QUART(GMWHEN,GMDFLT,GMTBEG,GMTEND) ; *** Quarterly & Semi-Annually
 N %DT,GM,GMDATA,GMDONE,GMMNDY,GMQU,GMQUIT,GMQUYR,GMSBEG,GMSEMI,GMYR,GMQART
 N GMQBEG,GMQEND,GMQQUA,X,Y
 S GMSEMI=$S(GMWHEN="S":1,1:0)
 F GM=1:1 S GMDATA=$P($T(QUARTDAT+GM),";;",2) Q:GMDATA=U  D
 . S GMQQUA(GM)=$P(GMDATA,U)
 . S GMQBEG(GM)="000"_$P(GMDATA,U,2)
 . S GMSBEG(GM)="000"_$P(GMDATA,U,3)
 . S GMQEND(GM)="000"_$P(GMDATA,U,4)
 . Q
 S GMQUYR=""
 I $P(GMDFLT,U,2)]"" D
 . S GMMNDY=$E($P(GMDFLT,U,2),4,7)
 . I (GMMNDY'<GMQBEG(1))&(GMMNDY'>GMQEND(1)) S GMQU=1
 . I (GMMNDY'<GMQBEG(2))&(GMMNDY'>GMQEND(2)) S GMQU=2
 . I (GMMNDY'<GMQBEG(3))&(GMMNDY'>GMQEND(3)) S GMQU=3
 . I (GMMNDY'<GMQBEG(4))&(GMMNDY'>GMQEND(4)) S GMQU=4
 . S GMQUYR=$S(GMQU>0:GMQU_"/"_(1700+$E($P(GMDFLT,U,2),1,3)+(GMQU=1)),1:"")
 . Q
 S (GMQUIT,GMDONE)=0
 F  D  Q:(GMQUIT>0)!(GMDONE>0)
 . I GMSEMI>0 D
 .. W !!,"Enter Quarter Period and FY you "
 .. W "wish Semi-Annual range to end with"
 .. Q
 . W !
 . W !,"Enter Quarter and Year: ",$S(GMQUYR]"":GMQUYR_"// ",1:"")
 . R GMQART:DTIME S:'$T GMQART=U
 . I GMQART="" S GMQART=GMQUYR
 . I (GMQART=U)!(GMQART="") S GMQUIT=1 Q
 . I (GMQART'?1N1P2N)&(GMQART'?1N1P4N) D  Q
 .. D BELL(GMQART)
 .. W !!,"Enter Quarter Period in this format: "
 .. W "2nd quarter 1988 would be 2-88, 2/88, 2 88"
 .. Q
 . I ($E(GMQART)>4)!($E(GMQART)<1) D  Q
 .. D BELL("")
 .. W !!,"Enter Quarter 1 to 4 only"
 .. Q
 . S GMQU=$E(GMQART)
 . S GMYR=$E(GMQART,3,6)
 . K %DT S X=GMYR D ^%DT S GMYR=$E(Y,1,3)
 . F GM=1:1:4 D
 .. S GMQBEG(GM)=$S(GM=1:GMYR-1,1:GMYR)_$E(GMQBEG(GM),4,7)
 .. S GMSBEG(GM)=$S(GM'>2:GMYR-1,1:GMYR)_$E(GMSBEG(GM),4,7)
 .. S GMQEND(GM)=$S(GM=1:GMYR-1,1:GMYR)_$E(GMQEND(GM),4,7)
 .. Q
 . S GMTEND=GMQEND(GMQU)
 . S GMTBEG=$S(GMSEMI:GMSBEG(GMQU),1:GMQBEG(GMQU))
 . S GMDONE=1
 . Q
 Q GMQUIT
 ;
QUARTDAT ;;Name ^ QuarterStart ^ SemiStart ^ QuarterEnd
 ;;FIRST^1001^0701^1231
 ;;SECOND^0101^1001^0331
 ;;THIRD^0401^0101^0630
 ;;FOURTH^0701^0401^0930
 ;;^
 ;
YEAR(GMWHEN,GMDFLT,GMTBEG,GMTEND) ; *** Yearly & Fiscal Yearly
 N %DT,GMDONE,GMFY,GMQUIT,GMYEAR,GMYR,X,Y
 S GMFY=$S(GMWHEN="F":1,1:0)
 S (GMQUIT,GMDONE)=0
 F  D  Q:(GMQUIT>0)!(GMDONE>0)
 . W !!,"Enter ",$S(GMFY:"FISCAL ",1:""),"YEAR: "
 . S GMYEAR=$S($P(GMDFLT,U,2)]"":1700+$E($P(GMDFLT,U,2),1,3),1:"")
 . W $S(GMYEAR]"":GMYEAR_"// ",1:"")
 . R GMYR:DTIME S:'$T GMYR=U
 . I GMYR="" S GMYR=GMYEAR
 . I (GMYR=U)!(GMYR="") S GMQUIT=1 Q
 . I (GMYR'?2N)&(GMYR'?4N) D  Q
 .. D BELL(GMYR)
 .. W !!,"Enter a 2 or 4 digit ",$S(GMFY:"fiscal ",1:""),"year"
 .. Q
 . K %DT S X=GMYR D ^%DT S GMYR=$E(Y,1,3)
 . I GMFY D
 .. S GMTBEG=GMYR-1_"1001"
 .. S GMTEND=GMYR_"0930"
 .. Q
 . E  D
 .. S GMTBEG=GMYR_"0101"
 .. S GMTEND=GMYR_"1231"
 .. Q
 . S GMDONE=1
 . Q
 Q GMQUIT
 ;
USERSEL(GMWHEN,GMDFLT,GMTBEG,GMTEND) ; *** User Selectable
 N %DT,GMBEG,GMEND,GMQUIT,X,Y
 S GMQUIT=0
 W !!,"Enter beginning and ending dates for the desired time period:",!
 K %DT
 S %DT="AEX"
 S %DT("A")="Beginning Date: "
 I $P(GMDFLT,U,2)]"" S %DT("B")=$$FMTE^XLFDT($P(GMDFLT,U,2),"5Z")
 D ^%DT S GMBEG=+$G(Y)
 I GMBEG>0 D
 . K %DT
 . S %DT="AEX"
 . S %DT(0)=GMBEG
 . S %DT("A")="Ending Date:    "
 . I $P(GMDFLT,U,3)]"",$P(GMDFLT,U,3)'<GMBEG D
 .. S %DT("B")=$$FMTE^XLFDT($P(GMDFLT,U,3),"5Z")
 .. Q
 . E  D
 .. S %DT("B")=$$FMTE^XLFDT(GMBEG,"5Z")
 .. Q
 . D ^%DT S GMEND=+$G(Y)
 . I GMEND>0 D
 .. S GMTBEG=GMBEG
 .. S GMTEND=GMEND
 .. Q
 . E  D
 .. S GMQUIT=1
 .. Q
 . Q
 E  D
 . S GMQUIT=1
 . Q
 Q GMQUIT
 ;
BELL(X) ; *** Write ?? <Beep>
 I $E(X)'="?" W " ??",$C(7)
 Q
 ;
LASTMNTH(GMDATE,GMTBEG,GMTEND) ; *** Compute last month date range
 N GMMN,GMYR
 S GMYR=1700+$E(GMDATE,1,3)
 S GMMN=$E(GMDATE,4,5)
 I (GMMN'<1)&(GMMN'>12) D
 . S GMMN=GMMN-1
 . I GMMN=0 S GMMN=12,GMYR=GMYR-1
 . I $L(GMMN)=1 S GMMN="0"_GMMN
 . S GMTBEG=(GMYR-1700)_GMMN_"01"
 . S GMTEND=$$SCH^XLFDT("1M(1)",GMTBEG)\1
 . Q
 E  D
 . S (GMTBEG,GMTEND)=""
 . Q
 Q
