SPNLRL1 ;SD/WDE - SCD PHARMACY UTILIZATION REPORT (PRINT PART 1 OF 3) ;Nov 22, 2006
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ;
 ;
 ;
 ; PAGELEN   Number of lines per page
 ; TITLE     Array of header lines (titles)
P1(TITLE,PAGELEN,ABORT) ;
 ; NDDRUGS   Number of different types of drugs
 ; ZDRUGNR   Internal Entry Number of a drug in ^PSDRUG
 ; FILLS     Number of fills given
 S CNT=0  ;rpc
 N NDDRUGS,ZDRUGNR,FILLS,OUT,LINE,STARTLIN,COL,NPATS
 S TITLE(4)=""
 S FILLS=+$G(^TMP("SPN",$J,"RX","FILLS"))
 S NPATS=+$G(^TMP("SPN",$J,"RX","PAT"))
 S TITLE(5)=$$CENTER^SPNLRU("Totals:  "_$FN(FILLS,",")_" fill"_$S(FILLS=1:"",1:"s")_" reported for "_$FN(NPATS,",")_" patient"_$S(NPATS=1:"",1:"s"))
 S CNT=CNT+1  ;rpc
 S ^TMP($J,CNT)="BOS999"_"^EOL999"
 S CNT=CNT+1  ;rpc
 S ^TMP($J,CNT)="HDR999"_U_"Totals:  "_FILLS_" fill"_$S(FILLS=1:"",1:"s")_" reported for "_NPATS_" patient"_$S(NPATS=1:"",1:"s")_"^EOL999"  ;rpc
 S ZDRUGNR=""
 F NDDRUGS=0:1 S ZDRUGNR=$O(^TMP("SPN",$J,"RX","DRUG",ZDRUGNR)) Q:ZDRUGNR=""
 S:NDDRUGS=1&(FILLS>1) TITLE(6)=$$CENTER^SPNLRU("(This includes just one type of drug)")
 S:NDDRUGS>1 TITLE(6)=$$CENTER^SPNLRU("(These include "_$FN(NDDRUGS,",")_" different drugs)")
 S CNT=CNT+1
 S ^TMP($J,CNT)="HDR999"_U_"These include "_NDDRUGS_" different drugs"_"^EOL999"  ;rpc
 S FILLS=+$O(^TMP("SPN",$J,"RX","FILLS",""))
 F  D  Q:FILLS=""!(ABORT)
 . D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . K OUT,TITLE(4),TITLE(5),TITLE(6)
 . S STARTLIN=$Y
 . S OUT(STARTLIN+1)=""
 . F COL=1:1:3 D  Q:FILLS=""
 . . S OUT(STARTLIN)=$G(OUT(STARTLIN))_"   Patients      Fills    "
 . . F LINE=STARTLIN+2:1:PAGELEN D  Q:FILLS=""
 . . . S OUT(LINE)=$G(OUT(LINE))_$J($FN($G(^TMP("SPN",$J,"RX","FILLS",FILLS)),","),10)_$J($FN(-FILLS,","),11)_"     "
 . . . S:$G(CNT)="" CNT=0 S CNT=CNT+1 S ^TMP($J,CNT)=$G(^TMP("SPN",$J,"RX","FILLS",FILLS))_U_-FILLS_"^EOL999"  ;rpc
 . . . S FILLS=$O(^TMP("SPN",$J,"RX","FILLS",FILLS))
 . S LINE=""
 . F  S LINE=$O(OUT(LINE)) Q:LINE=""  D
 . . W !,OUT(LINE)
 Q
P2(TITLE,PAGELEN,QLIST,ABORT) ;
 N NPATS,ZDRUGNR,FILLS,MAXPATS,MAXFILLS,NAME
 S TITLE(4)=""
 S TITLE(5)=$$CENTER^SPNLRU("Drugs with "_$FN(QLIST("MINFILL"),",")_" or more fills")
 S CNT=CNT+1  ;rpc
 S ^TMP($J,CNT)="BOS999"_"^EOL999"  ;rpc
 S CNT=CNT+1
 S ^TMP($J,CNT)="HDR999"_U_"Drugs with "_$G(QLIST("MINFILL"))_" or more fills"_"^EOL999"  ;rpc
 S TITLE(6)=""
 S TITLE(7)="                                                                     Max # Fills"
 S TITLE(8)="Drug                                          Fills    Patients     (# patients)"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S ZDRUGNR=""
 F  S ZDRUGNR=$O(^TMP("SPN",$J,"RX","DRUG",ZDRUGNR)) Q:ZDRUGNR=""  D
 . S FILLS=^TMP("SPN",$J,"RX","DRUG",ZDRUGNR)
 . Q:FILLS<QLIST("MINFILL")
 . S NPATS=^TMP("SPN",$J,"RX","DRUG",ZDRUGNR,"PAT")
 . S NAME=^TMP("SPN",$J,"RX","DRUG",ZDRUGNR,"NAME")
 . S ^TMP("SPN",$J,"RX","OUT",-FILLS,-NPATS,NAME)=ZDRUGNR
 S FILLS=""
 F  S FILLS=$O(^TMP("SPN",$J,"RX","OUT",FILLS)) Q:FILLS=""  D  Q:ABORT
 . S NPATS=""
 . F  S NPATS=$O(^TMP("SPN",$J,"RX","OUT",FILLS,NPATS)) Q:NPATS=""  D  Q:ABORT
 . . S NAME=""
 . . F  S NAME=$O(^TMP("SPN",$J,"RX","OUT",FILLS,NPATS,NAME)) Q:NAME=""  D  Q:ABORT
 . . . S:$G(CNT)="" CNT=0  ;rpc
 . . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . . S ZDRUGNR=^TMP("SPN",$J,"RX","OUT",FILLS,NPATS,NAME)
 . . . S MAXFILLS=$O(^TMP("SPN",$J,"RX","DRUG",ZDRUGNR,"FILLS",""))
 . . . S MAXPATS=^TMP("SPN",$J,"RX","DRUG",ZDRUGNR,"FILLS",MAXFILLS)
 . . . W !,NAME,?40,$J($FN(-FILLS,","),10),?52,$J($FN(-NPATS,","),10)
 . . . S RPC1=NAME_U_-FILLS_U_-NPATS  ;rpc
 . . . I FILLS'=NPATS&(-FILLS>1)&(-NPATS>1) W ?65,$J($FN(-MAXFILLS,","),9)," (",MAXPATS,")"
 . . . I FILLS'=NPATS&(-FILLS>1)&(-NPATS>1) S RPC2=-MAXFILLS_"("_MAXPATS_")"  ;rpc
 . . . S CNT=CNT+1 S ^TMP($J,CNT)=$G(RPC1)_U_$G(RPC2)_"^EOL999" K RPC1,RPC2  ;rpc
 . . . ; See what IMRWRCP1 does here for national report.
 K ^TMP("SPN",$J,"RX","OUT")
 K TITLE(4),TITLE(5),TITLE(6),TITLE(7),TITLE(8)
 Q
KILL ;
 K CNT
