VIABMS3 ;SGU/GJW - VIA BMS RPCs ;04/15/2016
 ;;1.0;VISTA INTEGRATION ADAPTER;**8,11,13**;06-FEB-2014;Build 7
 ;
ORDACT ; Returns a list of order actions from the ORDER file #100.008
 ;Input - VIA("PATH")="LISTORDERACTIONS" [required]
 ; VIA("ORDIEN")=list of orderable IEN separated by a comma (",") [required],if VIA("VALUE")=1
 ; VIA("SDATE")=Start Date for search [optional]. Defaults to today's date, if no date is passed in
 ; VIA("EDATE")=End Date for search [optional]. Defaults to today's date, if no date is passed in
 ; VIA("IENS")=Order IEN [required]
 ; VIA("VALUE")=1 or 2 required]. 1 to filter by orderable item(s), 2 to filter by orderable action 
 ;Data returned
 ; .01 Date/Time Ordered,6 Date/Time Signed,16 Release Date/Time,5 Signed By,3 Provider,.1 Order Text
 N VIAFILE,VIAFIELDS,VIAFLAGS,OITM,I,TRESULT,I,X,N,IEN,VIATIEN,DATAFLG
 S VIAFILE=100.008,VIAFIELDS="@;.01;6;16;5;3",VIAFLAGS="IP"
 I 'VIAVAL S VIAER="Missing VALUE of 1 or 2" D ERR^VIABMS(VIAER) Q
 S:VIASDT="" VIASDT=DT S:VIAEDT="" VIAEDT=DT
 D DTCHK^VIABMS(.RESULT,.VIASDT,.VIAEDT) I $D(RESULT) Q
 I VIAIENS="" S VIAER="Missing Order number" D ERR^VIABMS(VIAER) Q
 I $G(VIAOIEN)'="" F I=1:1:$L(VIAOIEN,",") S OITM=$P(VIAOIEN,",",I) I OITM'="" S VIAOI(OITM)=""
 I VIAVAL=1,$O(VIAOI(""))="" S VIAER="Missing Orderable Items IEN" D ERR^VIABMS(VIAER) Q
 S VIAID="I $D(^OR(100,DA(1),8,Y,.1)) S I=0 F  S I=$O(^OR(100,DA(1),8,Y,.1,I)) Q:'I  S J=$P(^(I,0),U) D EN^DDIOL(J)"
 I VIAVAL=1 D
 . S VIASCRN="S VIAOK=0,VIADLA=$P($G(^OR(100,Y(1),3)),U) S VIAX=0 F  S VIAX=$O(^OR(100,Y(1),.1,VIAX)) Q:'VIAX  I VIAX>0 S VIAV=$P(^OR(100,Y(1),.1,VIAX,0),U,1) I $$BETWEEN^VIABMS(VIADLA,VIASDT,VIAEDT)&$D(VIAOI(VIAV)) S VIAOK=1 Q"
 I VIAVAL=2 D
 . S VIASCRN="S VIADLA=$P($G(^OR(100,Y(1),3)),U),VIAA=Y(1),(VIAB,VIAC,VIAD,VIAX,VIAE)=0,VIAE=$$BETWEEN^VIABMS(VIADLA,VIASDT,VIAEDT) F  S VIAX=$O(^OR(100,VIAA,8,Y,.1,VIAX)) Q:'VIAX  I VIAX>0 S VIAR=$$UP^XLFSTR(^OR(100,VIAA,8,Y,.1,VIAX,0)) "
 . S VIASCRN=VIASCRN_"S VIAB=VIAB!(VIAR[""ANTICIPATE""),VIAC=VIAC!(VIAR[""PLANNED""),VIAD=VIAD!(VIAR[""DISCHARGE"") I VIAE&(VIAB!VIAC&VIAD) Q"
 ; multiple IENs
 S VIATIEN=VIAIENS,N=0,DATAFLG=0
 F I=1:1:$L(VIATIEN,",") S IEN=$P(VIATIEN,",",I) I IEN'="" D
 . S VIAIENS=","_IEN_","
 . K RESULT
 . D LDIC^VIABMS
 . S X=0 F  S X=$O(RESULT(X)) Q:'X  D
 . . Q:(RESULT(X)["[Data]")&(DATAFLG)  I RESULT(X)["[Data]" S DATAFLG=1 ;list [Data] only once
 . . S:(RESULT(X)'["[")&($P(RESULT(X),"^")) $P(RESULT(X),"^")=IEN
 . . S N=N+1,TRESULT(N)=RESULT(X)
 . K RESULT
 I N=0 S TRESULT(1)="[Data]"
 M RESULT=TRESULT
 Q
 ;
LSTORD ; Returns a list of orders from the ORDER file #100;ICR-6475
 ;Input - VIA("PATH")="LISTORDERS" [required]
 ; VIA("ORDIEN")=list of orderable IEN separated by a comma (",") [required]. For example, VIA("ORDIEN")="73,75,76,360,740"
 ; VIA("SDATE")=Start Date for search [optional]. Defaults to today's date, if no date is passed in
 ; VIA("EDATE")=End Date for search [optional]. Defaults to today's date, if no date is passed in
 ; VIA("PATIEN")=Patient IEN; multiple IENS separated by a comma [optional]
 ; VIA("VALUE")=1 or 2 required]. 1 to filter by orderable item(s), 2 to filter by orderable action 
 ; VIA("FROM")=string/value to start list [optional]
 ; VIA("MAX")=n [optional]
 ;Data returned
 ; .01 Order #, 100.008,#.01 Date/Time Ordered, #31 Date of Last Activity, 5 Status, .02 Object of Order, 6 Patient Location
 I 'VIAVAL S VIAER="Missing VALUE of 1 or 2" D ERR^VIABMS(VIAER) Q
 I VIAVAL=1 G VALUE1
 I VIAVAL=2 G VALUE2
 ;
VALUE1 ; value=1, using ^PXRMINDX
 ;Data returned
 ; .01 Order #, 100.008,#.01 Date/Time Ordered, #31 Date of Last Activity, 5 Status, .02 Object of Order, 6 Patient Location
 N VIAOI,VIACNT,OITM,I,X,Y,Z,PT,STRT,STOP,DAS,CNT,FND,QFLG,MORE,TARRAY
 S:VIASDT="" VIASDT=DT S:VIAEDT="" VIAEDT=DT
 D DTCHK^VIABMS(.RESULT,.VIASDT,.VIAEDT) I $D(RESULT) Q
 I $G(VIAOIEN)'="" F I=1:1:$L(VIAOIEN,",") S OITM=$P(VIAOIEN,",",I) I OITM'="" S VIAOI(OITM)=""
 I $G(VIAPIEN)'="" F I=1:1:$L(VIAPIEN,",") S OITM=$P(VIAPIEN,",",I) I OITM'="" S VIAPIEN(OITM)=""
 I VIAVAL=1,$O(VIAOI(""))="" S VIAER="Missing Orderable Items IEN" D ERR^VIABMS(VIAER) Q
 S RESULT(1)="[Data]",VIACNT=1,FND=0,QFLG=0,MORE=""
 ;
 I $O(VIAOI("")) D
 . S OITM=$S($P(VIAFROM,"~")'="":$P(VIAFROM,"~")-1,1:0)
 . F  S OITM=$O(VIAOI(OITM)) Q:OITM'>0  D PT I VIACNT>VIAMAX Q
 ;E  D
 ;. S OITM=$S($P(VIAFROM,"~")'="":$P(VIAFROM,"~")-1,1:0)
 ;. F  S OITM=$O(^PXRMINDX(100,"IP",OITM)) Q:OITM'>0  D PT I VIACNT>VIAMAX Q
 I QFLG D  ; re-structure results array when 'more' defined
 . M TARRAY=RESULT
 . K RESULT
 . S CNT=3,I=0,RESULT(1)="[Misc]",RESULT(2)=MORE,RESULT(3)="[Data]"
 . F  S I=$O(TARRAY(I)) Q:'I  D
 . . I TARRAY(I)["Data" Q
 . . S CNT=CNT+1,RESULT(CNT)=TARRAY(I)
 Q
 ;
PT S PT=$S($P(VIAFROM,"~",2)'="":$P(VIAFROM,"~",2)-1,1:0)
 F  S PT=$O(^PXRMINDX(100,"IP",OITM,PT)) Q:PT'>0  D  I VIACNT>VIAMAX Q
 . S STRT=$S($P(VIAFROM,"~",3)'="":$P(VIAFROM,"~",3)-.0001,1:VIASDT)
 . F  S STRT=$O(^PXRMINDX(100,"IP",OITM,PT,STRT)) Q:(STRT'>0)!(STRT>VIAEDT)  D  I VIACNT>VIAMAX Q
 . . S STOP=$S($P(VIAFROM,"~",4)'="":$P(VIAFROM,"~",4),1:"") S VIAFROM=""
 . . F  S STOP=$O(^PXRMINDX(100,"IP",OITM,PT,STRT,STOP)) Q:STOP=""  D  I VIACNT>VIAMAX  S MORE="MORE"_U_OITM_"~"_PT_"~"_STRT_"~"_STOP,QFLG=1 Q
 . . . ;I +STOP>0,STOP'<VIAEDT Q
 . . . ; EDATE of 3180408.1249 equates to VIAEDT of 3180408.124901
 . . . ; EDATE=3180430,STOP=3180501  STOP entry would quit
 . . . S DAS=$O(^PXRMINDX(100,"IP",OITM,PT,STRT,STOP,"")) Q:DAS=""
 . . . S Y=+DAS
 . . . S Z=$$ORDACT1()
 Q
 ;
ORDACT1() ; value=1, filters by status, date and orderable items
 N VIA3,VIAV,VIAA,VIA8,VIA0,VIAPT,VIAX
 I '$D(^OR(100,Y,.1,0)) Q FND
 S VIA0=$G(^OR(100,Y,0)),VIA3=$G(^OR(100,Y,3)),VIAPT=$P(VIA0,U,2)
 I $P(VIA3,U,3)'=6 Q FND
 I VIAPIEN'="",(VIAPT'["DPT")!('$D(VIAPIEN(+VIAPT))) Q FND
 S VIAA=$P(VIA3,U,7),VIAV=$P(VIA3,U)
 I VIAA>0,VIAV>=VIASDT,VIAV<=VIAEDT S VIA8=$P(^OR(100,Y,8,VIAA,0),U),VIAX=0 D  Q FND
 . S FND=1,VIACNT=VIACNT+1
 . S RESULT(VIACNT)=Y_U_VIA8_U_$P(VIA3,U)_U_$P(VIA3,U,3)_U_$P(VIA0,U,2)_U_$P(VIA0,U,10)_U_OITM
 Q FND
 ;
VALUE2 ; value=2, using the 'AF' xref
 ;Data returned
 ; .01 Order #, 5 Status, .02 Object of Order, 6 Patient Location
 N VIAOI,VIACNT,OITM,I,X,Y,Z,CNT,QFLG,MORE,TARRAY
 S:VIASDT="" VIASDT=DT S:VIAEDT="" VIAEDT=DT
 D DTCHK^VIABMS(.RESULT,.VIASDT,.VIAEDT) I $D(RESULT) Q
 I $G(VIAOIEN)'="" F I=1:1:$L(VIAOIEN,",") S OITM=$P(VIAOIEN,",",I) I OITM'="" S VIAOI(OITM)=""
 I $G(VIAPIEN)'="" F I=1:1:$L(VIAPIEN,",") S OITM=$P(VIAPIEN,",",I) I OITM'="" S VIAPIEN(OITM)=""
 I VIAVAL=1,$O(VIAOI(""))="" S VIAER="Missing Orderable Items IEN" D ERR^VIABMS(VIAER) Q
 S RESULT(1)="[Data]",VIACNT=1,QFLG=0,MORE=""
 S X=$S($P(VIAFROM,",")'="":$P(VIAFROM,","),1:VIASDT)
 F  S X=$O(^OR(100,"AF",X)) Q:('X)!(X>VIAEDT)  I X>=VIASDT,X<VIAEDT D  I VIACNT>VIAMAX Q
 . S Y=0
 . F  S Y=$O(^OR(100,"AF",X,Y)) Q:'Y  D  I VIACNT>VIAMAX  S MORE="MORE"_U_X,QFLG=1 Q
 . . S Z=$$ORDACT2()
 I QFLG D  ; re-structure results array when 'more' defined
 . M TARRAY=RESULT
 . K RESULT
 . S CNT=3,I=0,RESULT(1)="[Misc]",RESULT(2)=MORE,RESULT(3)="[Data]"
 . F  S I=$O(TARRAY(I)) Q:'I  D
 . . I TARRAY(I)["Data" Q
 . . S CNT=CNT+1,RESULT(CNT)=TARRAY(I)
 Q
 ;
ORDACT2() ; value=2, filters by status, date and orderable actions
 N FND,VIA0,VIAA,VIAB,VIAC,VIAD,VIA3,VIAV,VIA8
 S FND=0 
 S VIA0=$G(^OR(100,Y,0))
 I $P($G(^OR(100,Y,3)),U,3)'=6 Q FND
 S (VIAA,VIAB,VIAC,VIAD)=0
 S VIA0=$G(^OR(100,Y,0)),VIA3=$G(^OR(100,Y,3))
 I $D(^OR(100,Y,8)) F  S VIAA=$O(^OR(100,Y,8,VIAA)) Q:'VIAA  S VIA8=$P(^OR(100,Y,8,VIAA,0),U,1) I VIA8>=VIASDT,VIA8<VIAEDT,$D(^OR(100,Y,8,VIAA,.1)) S VIAX=0 D  I FND Q
 . F  S VIAX=$O(^OR(100,Y,8,VIAA,.1,VIAX)) Q:'VIAX  S VIAR=$G(^OR(100,Y,8,VIAA,.1,VIAX,0)),VIAR=$$UP^XLFSTR(VIAR) S VIAB=VIAB!(VIAR["ANTICIPATE"),VIAC=VIAC!(VIAR["PLANNED"),VIAD=VIAD!(VIAR["DISCHARGE") I VIAB!VIAC&VIAD D  Q
 . . S FND=1,VIACNT=VIACNT+1
 . . S RESULT(VIACNT)=Y_U_VIA8_U_$P(VIA3,U)_U_$P(VIA3,U,3)_U_$P(VIA0,U,2)_U_$P(VIA0,U,10)_U
 Q FND
 ;
