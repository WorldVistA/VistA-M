SPNLRS7 ;SD/WDE - Pharmacy Utilization rpt specific RPC;JUL 01, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ;
 ;INTEGRATION REFERENCE #4533  ZERO^PSS50
 ;
 ;
RPC(ROOT,FDATE,TDATE,HIUSERS,VALUES,PTLIST)  ;
 ;
 K ^TMP("SPN",$J)
 K ^TMP($J)
 S ROOT=$NA(^TMP($J))
 K VAL,QTY,QLIST,PRICE,PATCNT,ICN,I,DRUGNAM,DRUGIEN,DFN,CVALUE,CQTY,CNT
 ;K SPNXXX  ;WDE
DATES ;----------------------------------------------------------------
 ;convert dates to fm style
 S X=FDATE D ^%DT S FDATE=Y  ;fdate
 S X=TDATE D ^%DT S TDATE=Y  ;tdate
 D BQLIST  ;unload the values in values
 ;-------------------------------------------------------------
 S CNT=0
 S ROOT=$NA(^TMP($J))
 S ICN=0 F ZYZ=1:1 S ICN=$G(PTLIST(ZYZ)) Q:ICN=""  D COL
 S ROOT=$NA(^TMP($J))
 D PRICEIT^SPNLGSRX ; get unit prices (cost) for the drugs
 D RESORT
 Q
COL ;
 ;***************************************
 Q:ICN=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************************
 D SELECT^SPNLGSRX(DFN,FDATE,TDATE,HIUSERS,.QLIST) ; gather pharmacy data
 ;Tag RPC is called by a Remote procedure
 ;   fdate = from date
 ;   tdate = to date
 ;   hiusers = report on hi users
 ;   qlist = array that has the drug names and numbers
 ;   ptlist = patient list array
 ;   abort = true or false abort yes no
 Q
 ;---------------------------------------------------------------
RESORT ;
 ;we need to rebuild the ^tmp("spn",$j into a format for JAVA
 ;
 D BQLIST2
 S DRUGIEN=0 F  S DRUGIEN=$O(^TMP("SPN",$J,"RX","DRUG",DRUGIEN)) Q:DRUGIEN=""  D
 .;S DRUGNAM=$P($G(^PSDRUG(DRUGIEN,0)),U,1) ;OLD BEFORE CALL TO API DATA^PSS50
 .D DATA^PSS50(DRUGIEN,,,,,"SPN")
 .S DRUGNAM=$G(^TMP($J,"SPN",DRUGIEN,.01))
 .K ^TMP($J,"SPN")
 .;======================================
 .;Get price node
 .S PRICE=$G(^TMP("SPN",$J,"RX","DRUG",DRUGIEN,"PRICE"))
 .;patient count for this drug
 .S PATCNT=$G(^TMP("SPN",$J,"RX","DRUG",DRUGIEN,"PAT"))
 .;Quantity
 .S QTY=$G(^TMP("SPN",$J,"RX","DRUG",DRUGIEN,"QTY"))
 .;TOTAL FILLS
 .S TOTFILLS=$G(^TMP("SPN",$J,"RX","DRUG",DRUGIEN))
 .S ATCOST=PRICE*QTY
 .;S CNT=CNT+1 S ^TMP($J,CNT)="BOR999"_U_DRUGNAM_U_PRICE_U_PATCNT_U_TOTFILLS_U_QTY_U_PRICE*QTY_"^EOL999"
 .S CNT=CNT+1 S ^TMP($J,CNT)="BOS999"_U_DRUGNAM_U_PRICE_U_PATCNT_U_TOTFILLS_U_QTY_U_ATCOST_"^EOL999"
 .;S CNT=CNT+1 S ^TMP($J,CNT)="BOS999"_U_DRUGNAM_U_PRICE_U_0_U_PATCNT_"^EOL999"
 .;======================================
 .;patient loop
 .S PATID="" F  S PATID=$O(^TMP("SPN",$J,"RX","DRUG",DRUGIEN,"PID",PATID)) Q:PATID=""  D
 ..S CQTY=$P(^TMP("SPN",$J,"RX","DRUG",DRUGIEN,"PID",PATID),"^",2),CVALUE=CQTY*PRICE
 ..S CNT=CNT+1 S ^TMP($J,CNT)=PATID_U_$G(^TMP("SPN",$J,"RX","DRUG",DRUGIEN,"PID",PATID))_"^"_$J(CVALUE,".",2)_"^EOL999"
 ..Q
 .Q
 Q
KILL ;
 ;
 K ^TMP("SPN",$J)
 K ABORT,CNT,COST,DFN,FACNAME,FDATE,HIUSERS,ICN,MINCOST,MINFILL,PTLIST,QLIST,SPNPAGE,STR,TDATE,X,XFDATE,XTDATE,Y,ZYZ
 K PID,DRGNAM,NPATS,TESTNR,TESTNAME,VALUE,AA,DRGNUM,LABTEST,PNAM,PSSN,TESTPTS,VAL,XYZZ,ZZ,ZZA,PNAME,RESULTS,PATCNT
 K PRICE,TOTFILLS,CQTY,ATCOST,TOTFILLS,DRUGIEN,PATID,RPTID ;,SPNXX
BQLIST ;276;ASPIRIN 300MG TAB^868;IBUPROFEN 600MG TAB
 ;       QLIST(IEN)=DRUG NAME
 ;       QLIST(276)=ASPIRIN 300MG TAB
 ;       QLIST(868)=IBUPROFEN 600MG TAB
 S ZZA=0
 F ZZA=1:1 S VAL=$G(VALUES(ZZA)) Q:VAL=""  D
 .S DRGNUM=$P(VAL,";",1)
 .S DRGNAM=$P(VAL,";",2)
 .S QLIST(DRGNUM)=DRGNAM
 .Q
 Q
BQLIST2 ;
 ;S SPXXX=0 
 S ZZA=0
 F ZZA=1:1 S DRGNUM=$G(VALUES(ZZA)) Q:DRGNUM=""  D
 .S DRGNUM=$P(DRGNUM,";",1)
 .I '$D(^TMP("SPN",$J,"RX","DRUG",DRGNUM)) D
 ..S ^TMP("SPN",$J,"RX","DRUG",DRGNUM)=0
 ..S ^TMP("SPN",$J,"RX","DRUG",DRGNUM,"PAT")=0
 ..S ^TMP("SPN",$J,"RX","DRUG",DRGNUM,"PRICE")=0
 ..S ^TMP("SPN",$J,"RX","DRUG",DRGNUM,"QTY")=0
 Q
NEWT ;NEW TEST DAYT42 1/5/2007 working
 K ^TMP($J) K ^TMP("SPN",$J) K VALUES,QLIST,PTLIST
 S VALUES(1)="342;ACETAMINOPHEN W/CODEINE 30 MG TAB (EA)"
 S VALUES(2)="1649;IBUPROFEN 600MG TAB"
 S VALUES(3)="5911;MORPHINE 100MG SR TAB"
 S PTLIST(1)=1002657188
 S PTLIST(2)=1002630943
 S PTLIST(3)=1002627882
 S PTLIST(4)=1011238640
 S PTLIST(5)=1010567933
 S PTLIST(6)=1002623842
 S PTLIST(7)=1005409510
 S PTLIST(8)=1002632242
 S PTLIST(9)=1002630369
 ;01/01/2005 to 07/31/2005
 D RPC(.ROOT,"01/01/2005","07/31/2005",1,.VALUES,.PTLIST)
