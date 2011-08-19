SPNLRL3 ;SD/WDE - SCD PHARMACY UTILIZATION REPORT (PRINT PART 3 OF 3) ;Nov 22, 2006
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ;
 ;
 ;
 ; PAGELEN   Number of lines per page
 ; TITLE     Array of header lines (titles)
P5(TITLE,PAGELEN,QLIST,HIUSERS,ABORT) ;
 ; I         High user counter
 ; COST      Cost of the drugs
 ; NDDRUGS   Number of different drugs
 ; FILLS     Number of fills
 ; PID       Patient ID (Coded SSN)
 ; PNAME     Patient Name
 ; PSSN      Patient SSN
 N FILLS,NDDRUGS,COST,PID,PNAME,PSSN,I,HINODE,COSTITLE
 I QLIST("COST")="ACTUAL" D
 . S HINODE="H1"
 . S COSTITLE=" Cost"
 E  D
 . S HINODE="H3"
 . S COSTITLE="Value"
 S TITLE(4)=""
 S TITLE(5)=$$CENTER^SPNLRU("Highest Utilization Patients Based on Fills")
 S TITLE(6)=""
 S TITLE(7)="                                                  Total     Different     Total"
 S TITLE(8)="Patient Name                        SSN           Fills       Drugs       "_COSTITLE
 S CNT=CNT+1 S ^TMP($J,CNT)="BOS999"_"^EOL999"
 S CNT=CNT+1 S ^TMP($J,CNT)="HDR999"_U_"Highest Utilization Patients Based on Fills"_"^EOL999"  ;RPC
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S FILLS=""
 F I=1:1:HIUSERS S FILLS=$O(^TMP("SPN",$J,"RX","HI",HINODE,FILLS)) Q:FILLS=""  D  Q:ABORT
 . S NDDRUGS=""
 . F  S NDDRUGS=$O(^TMP("SPN",$J,"RX","HI",HINODE,FILLS,NDDRUGS)) Q:NDDRUGS=""  D  Q:ABORT
 . . S COST=""
 . . F  S COST=$O(^TMP("SPN",$J,"RX","HI",HINODE,FILLS,NDDRUGS,COST)) Q:COST=""  D  Q:ABORT
 . . . S PID=""
 . . . F  S PID=$O(^TMP("SPN",$J,"RX","HI",HINODE,FILLS,NDDRUGS,COST,PID)) Q:PID=""  D  Q:ABORT
 . . . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . . . D GETNAME^SPNLRU(PID,.PNAME,.PSSN)
 . . . . S CNT=CNT+1 S ^TMP($J,CNT)=PNAME_U_PSSN_U_-FILLS_U_-NDDRUGS_U_-COST_"^EOL999"  ;RPC
 . . . . W !,PNAME,?32,PSSN,?45,$J($FN(-FILLS,","),10),?58,$J(-NDDRUGS,8),?68,$J($FN(-COST,",",2),12)
 Q
P6(TITLE,PAGELEN,QLIST,HIUSERS,ABORT) ;
 ; I         High user counter
 ; COST      Cost of the drugs
 ; NDDRUGS   Number of different drugs
 ; FILLS     Number of fills
 ; PID       Patient ID (Coded SSN)
 ; PNAME     Patient Name
 ; PSSN      Patient SSN
 N FILLS,NDDRUGS,COST,PID,PNAME,PSSN,I,HINODE
 S CNT=CNT+1 S ^TMP($J,CNT)="BOS999"_"^EOL999"
 I QLIST("COST")="ACTUAL" D
 . S HINODE="H2"
 . S TITLE(5)=$$CENTER^SPNLRU("Highest Utilization Patients Based on Cost")
 . S CNT=CNT+1 S ^TMP($J,CNT)="HDR999"_U_"Highest Utilization Patients Based on Cost"_"^EOL999"  ;RPC
 E  D
 . S HINODE="H4"
 . S TITLE(5)=$$CENTER^SPNLRU("Highest Utilization Patients Based on Value")
 . S CNT=CNT+1 S ^TMP($J,CNT)="HDR999"_U_"Highest Utilization Patients Based on Value"_"^EOL999"  ;RPC
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S COST=""
 F I=1:1:HIUSERS S COST=$O(^TMP("SPN",$J,"RX","HI",HINODE,COST)) Q:COST=""  D  Q:ABORT
 . S FILLS=""
 . F  S FILLS=$O(^TMP("SPN",$J,"RX","HI",HINODE,COST,FILLS)) Q:FILLS=""  D  Q:ABORT
 . . S NDDRUGS=""
 . . F  S NDDRUGS=$O(^TMP("SPN",$J,"RX","HI",HINODE,COST,FILLS,NDDRUGS)) Q:NDDRUGS=""  D  Q:ABORT
 . . . S PID=""
 . . . F  S PID=$O(^TMP("SPN",$J,"RX","HI",HINODE,COST,FILLS,NDDRUGS,PID)) Q:PID=""  D  Q:ABORT
 . . . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . . . D GETNAME^SPNLRU(PID,.PNAME,.PSSN)
 . . . . W !,PNAME,?32,PSSN,?45,$J($FN(-FILLS,","),10),?58,$J(-NDDRUGS,8),?68,$J($FN(-COST,",",2),12)
 . . . . S CNT=CNT+1 S ^TMP($J,CNT)=PNAME_U_PSSN_U_-FILLS_U_-NDDRUGS_U_-COST_"^EOL999"  ;RPC
 K TITLE(4),TITLE(5),TITLE(6),TITLE(7),TITLE(8)
 Q
KILL ;
 K ABORT,CNT,COST,COSTITLE,FILLS,HINODE,HIUSERS,I,NDDRUGS,PAGELEN,PID,PNAME,PSSN,QLIST,TITLE
