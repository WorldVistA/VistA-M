TIUPS174 ; SLC/AJB - Report for notes w/blank text ; 06/28/04
 ;;1.0;TEXT INTEGRATION UTILITIES;**174,177**;Jun 20, 1997
 ;
 Q
REPORT ; control segment
 N ANS
 W @IOF
 D ASKUSER(.ANS) Q:$G(ANS("EXIT"))="YES"
 D
 .N POP,TIUDESC,TIURTN,TIUSAVE
 .S TIUDESC="TIUPS174 Blank Note Report Routine",TIURTN="GATHER^TIUPS174",TIUSAVE("*")=""
 .W ! D EN^XUTMDEVQ(TIURTN,TIUDESC,.TIUSAVE)
EXIT Q
ASKUSER(ANS) ;
 N %DT,CNT,POP,X,Y
 S %DT="AE",%DT(0)=$$NOW^XLFDT*-1
 F CNT=1:1:2 D
 . S %DT("A")=$S(CNT=1:"START WITH REFERENCE DATE:  ",CNT=2:"     GO TO REFERENCE DATE:  ")
 . S %DT("B")=$S(CNT=1:"Jan 01, 2003",CNT=2:$P($$HTE^XLFDT($H),"@"))
 . D ^%DT
 . I Y=-1 S CNT=2,ANS("EXIT")="YES" Q
 . I CNT=1 S ANS("BEGDT")=$$DATE(Y,CNT),%DT(0)=ANS("BEGDT") Q
 . S ANS("ENDDT")=$$DATE(Y,CNT),X=$P($$NOW^XLFDT,".")_".24" I ANS("ENDDT")>X S CNT=1
 I $G(ANS("EXIT"))="YES" Q
 ;
 D  I $G(ANS("EXIT"))="YES" Q
 . N DIR,DIRUT,DUOUT,DTOUT,POP,X,Y
 . S DIR(0)="Y"
 . S DIR("A")="Would you like a delimited report"
 . S DIR("B")="NO"
 . S DIR("?")="Entering 'NO' will display/print the standard report."
 . S DIR("?",1)="Entering 'YES' will provide a delimited report for importing into another application."
 . W ! D ^DIR
 . I $D(DUOUT)!($D(DTOUT)) S ANS("EXIT")="YES" Q
 . S ANS("DELIM")=Y(0)
 ;
 Q
IFTEXT() ;
 N TIUCHK
 S TIUCHK=0 F  S TIUCHK=$O(^TIU(8925,DA,"TEXT",TIUCHK)) Q:TIUCHK=""!TIUCHK>0
 Q TIUCHK
DATE(TIUDT,TIUSEQ) ;
 I TIUDT["0000" S TIUDT=TIUDT/10000,TIUDT=TIUDT_$S(TIUSEQ=1:"0101",TIUSEQ=2:"1231")
 I TIUSEQ=2 S TIUDT=TIUDT_".24"
 Q TIUDT
GATHER ;
 N DA,I,J,LINE,N,TIME,TIUBOTH,TIUDT,TIUMTC,TIUTOG,TIUZNC
 K ^TMP("TIULIST",$J)
 I ANS("DELIM")="NO" W:'$D(ZTQUEUED) !,"Searching...",!
 S (I,J,TIUBOTH,TIUMTC,TIUZNC)=0,DA="",N=8925,TIUDT=ANS("BEGDT"),TIME("STRT")=$$NOW^XLFDT
 F  S TIUDT=$O(^TIU(N,"F",TIUDT)) Q:TIUDT=""!(TIUDT>ANS("ENDDT"))  F  S DA=$O(^TIU(N,"F",TIUDT,DA)) Q:DA=""  S I=I+1 I '$D(^TIU(8925,"DAD",DA)),'$D(^TIU(8925.91,"ADI",DA)),$P($G(^TIU(8925,DA,0)),U,5)>5,('$D(^TIU(N,DA,"TEXT",0))!'$$IFTEXT) D
 . I $P($G(^TIU(8925,DA,0)),U,5)=15 Q
 . S J=J+1,^TMP("TIULIST",$J,DA)=""
 . I '$D(^TIU(8925,DA,"TEXT",0)),$$IFTEXT() S ^TMP("TIULIST",$J,DA)="0 Node",TIUZNC=TIUZNC+1
 . I $D(^TIU(8925,DA,"TEXT",0)),'$$IFTEXT() S ^TMP("TIULIST",$J,DA)="Text",TIUMTC=TIUMTC+1
 . I '$D(^TIU(8925,DA,"TEXT",0)),'$$IFTEXT() S ^TMP("TIULIST",$J,DA)="0/Text",TIUBOTH=TIUBOTH+1
 . I $D(^TIU(8925,DA,"TEXT",300)) S ^TMP("TIULIST",$J,DA)=^TMP("TIULIST",$J,DA)_"*"
 S TIME("STOP")=$$NOW^XLFDT,TIME("ELAP")=$FN($$FMDIFF^XLFDT(TIME("STRT"),TIME("STOP"),2)/60,"-")
 ;
 N LCNT,LINE,LINETXT,XQA,XQAMSG
 S LCNT="",$P(LCNT,"-",$L(I))="-"
 I ANS("DELIM")="NO" F LINE=1:1 S LINETXT=$P($T(TEXT+LINE),";;",2) Q:LINETXT="EOM"  W @LINETXT,!
 I ANS("DELIM")="YES" D
 . W "Doc #^Missing^Status^Title^Author^Patient^Entry Date^Time" ; ^Reference Date^Time^Signature Date^Time",!
 S DA=""
 F  S DA=$O(^TMP("TIULIST",$J,DA)) Q:DA=""  D
 .N TMP
 .I ANS("DELIM")="YES" D  Q
 . . S TMP("AUTH")=$E($$GET1^DIQ(8925,DA_",",1202),1,34),TMP("RD")=$P($$FMTE^XLFDT($P($G(^TIU(8925,DA,13)),U)),"@")
 . . S TMP("TITLE")=$E($$GET1^DIQ(8925,DA_",",.01),1,34),TMP("RT")=$P($$FMTE^XLFDT($P($G(^TIU(8925,DA,13)),U)),"@",2)
 . . S TMP("PAT")=$E($$GET1^DIQ(8925,DA_",",.02),1,25)_"("_$$TIUSSN_")"
 . . S TMP("ET")=$P($$FMTE^XLFDT($P($G(^TIU(8925,DA,12)),U)),"@",2)
 . . S TMP("STAT")=$$GET1^DIQ(8925,DA,.05),TMP("ED")=$P($$FMTE^XLFDT($P($G(^TIU(8925,DA,12)),U)),"@")
 . . S TMP("MISS")=^TMP("TIULIST",$J,DA),TMP("SD")=$S($P($G(^TIU(8925,DA,15)),U)="":"N/A",1:$$FMTE^XLFDT($P($G(^TIU(8925,DA,15)),U)))
 . . I TMP("SD")'="N/A" S TMP("ST")=$P(TMP("SD"),"@",2),TMP("SD")=$P(TMP("SD"),"@")
 . . S TMP(DA)=DA_U_TMP("MISS")_U_TMP("STAT")_U_TMP("TITLE")_U_TMP("AUTH")_U_TMP("PAT")_U_TMP("ED")
 . . S TMP(DA)=TMP(DA)_U_TMP("ET") ; _U_TMP("RD")_U_TMP("RT")_U_TMP("SD")_U_$G(TMP("ST"))
 . . W TMP(DA),! Q
 .S TMP(DA)=$$SPACER(DA,12)_$$SPACER($$FMTE^XLFDT($P($G(^TIU(8925,DA,12)),U)),32)_$E($$GET1^DIQ(8925,DA_",",.01),1,34)
 .W TMP(DA),!
 .S TMP(DA)=$$SPACER(^TMP("TIULIST",$J,DA),12)_$$SPACER($$FMTE^XLFDT($P($G(^TIU(8925,DA,13)),U)),32)_$E($$GET1^DIQ(8925,DA_",",.02),1,25)_"("_$$TIUSSN_")"
 .W TMP(DA),!
 .S TMP(DA)=$$SPACER($$GET1^DIQ(8925,DA,.05),12)_$$SPACER($S($P($G(^TIU(8925,DA,15)),U)="":"N/A",1:$$FMTE^XLFDT($P($G(^TIU(8925,DA,15)),U))),32)_$E($$GET1^DIQ(8925,DA_",",1202),1,34)
 .W TMP(DA),!!
 K ^TMP("TIULIST",$J)
 S XQA(DUZ)="",XQAMSG="TIUPS174 has finished."
 D SETUP^XQALERT
 Q
TIUSSN() ;
 ; DBIA #10061
 N DFN,VA,VADM,VAERR
 S DFN=$P($G(^TIU(8925,DA,0)),U,2)
 D DEM^VADPT
 Q $P(VA("PID"),"-",3)
SPACER(TEXT,LENGTH,REV) ;
 N SPACER
 S SPACER=""
 S $P(SPACER," ",(LENGTH-$L(TEXT)))=" "
 S:'$D(REV) TEXT=TEXT_SPACER
 S:$D(REV) TEXT=SPACER_TEXT
 Q TEXT
TEXT ;
 ;;""
 ;;"Date range searched:  "_($$FMTE^XLFDT(ANS("BEGDT"),"D"))_" - "_($$FMTE^XLFDT(ANS("ENDDT"),"D"))
 ;;"       # of Records:"
 ;;"                            Searched   "_I
 ;;"                   Missing Text Only   "_$$SPACER(TIUMTC,$L(I),1)
 ;;"                 Missing 0 Node Only   "_$$SPACER(TIUZNC,$L(I),1)
 ;;"               Missing 0 node & Text   "_$$SPACER(TIUBOTH,$L(I),1)
 ;;"                                       "_LCNT
 ;;"                               Total   "_$$SPACER(J,$L(I),1)
 ;;""
 ;;"                Elapsed Time:  "_(TIME("ELAP")\1)_" minute(s) "_($FN((TIME("ELAP")#1)*60,"-",0))_" second(s)"
 ;;"                Current User:  "_($$GET1^DIQ(200,$G(DUZ),.01))
 ;;"                Current Date:  "_($$HTE^XLFDT($H))
 ;;""
 ;;"Doc #       Entry Date/Time                 Title"
 ;;"Missing     Reference Date/Time             Patient"             
 ;;"Status      Signature Date/Time             Author/Dictator"
 ;;"------      -------------------             ---------------"
 ;;EOM
 Q
