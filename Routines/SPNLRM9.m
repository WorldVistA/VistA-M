SPNLRM9 ;SD/WDE - SCD RADIOLOGY UTILIZATION REPORT (RPC PART 2 OF 2) ;Nov 24, 2006
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ;
 ;
 ;
 ;
 ;
 ; PAGELEN   Number of lines per page
 ; TITLE     Array of header lines (titles)
P4 ;
 ; I         High user counter
 ; COST      Cost of the procedures
 ; NDPROCS   Number of different procedures
 ; NPROCS    Number of procedures
 ; PID       Patient ID (Coded SSN)
 ; PNAME     Patient Name
 ; PSSN      Patient SSN
 N NPROCS,NDPROCS,COST,PID,PNAME,PSSN,I
 S CNT=CNT+1 S ^TMP($J,CNT)="BOS999"_U_"Highest Utilization Patients Based on Number of Procedures"_"^EOL999"
 S CNT=CNT+1 S ^TMP($J,CNT)="HDR999"_U_"Patient Name"_U_"SSN"_U_"Total Procedures"_U_"Different Procedures"_U_"Total Value"_"^EOL999"
 S REPHDR=$G(^TMP($J,CNT))
 S NPROCS=""
 F I=1:1:HIUSERS S NPROCS=$O(^TMP("SPN",$J,"RA","HI","H1",NPROCS)) Q:NPROCS=""  D
 . S NDPROCS=""
 . F  S NDPROCS=$O(^TMP("SPN",$J,"RA","HI","H1",NPROCS,NDPROCS)) Q:NDPROCS=""  D
 . . S COST=""
 . . F  S COST=$O(^TMP("SPN",$J,"RA","HI","H1",NPROCS,NDPROCS,COST)) Q:COST=""  D
 . . . S PID=""
 . . . F  S PID=$O(^TMP("SPN",$J,"RA","HI","H1",NPROCS,NDPROCS,COST,PID)) Q:PID=""  D
 . . . . D GETNAME^SPNLRU(PID,.PNAME,.PSSN)
 . . . . S CNT=CNT+1 S ^TMP($J,CNT)=PNAME_U_PSSN_U_-NPROCS_U_-NDPROCS_U_-COST_"^EOL999"
 Q
P5 ;
 ; I         High user counter
 ; COST      Cost of the procedures
 ; NDPROCS   Number of different procedures
 ; NPROCS    Number of procedures
 ; PID       Patient ID (Coded SSN)
 ; PNAME     Patient Name
 ; PSSN      Patient SSN
 N NPROCS,NDPROCS,COST,PID,PNAME,PSSN,I
 S CNT=CNT+1 S ^TMP($J,CNT)="BOS999"_U_"Highest Utilization Patients Based on Value"_"^EOL999"
 S CNT=CNT+1 S ^TMP($J,CNT)=REPHDR  ;See above for header value
 S COST=""
 F I=1:1:HIUSERS S COST=$O(^TMP("SPN",$J,"RA","HI","H2",COST)) Q:COST=""  D
 . S NPROCS=""
 . F  S NPROCS=$O(^TMP("SPN",$J,"RA","HI","H2",COST,NPROCS)) Q:NPROCS=""  D
 . . S NDPROCS=""
 . . F  S NDPROCS=$O(^TMP("SPN",$J,"RA","HI","H2",COST,NPROCS,NDPROCS)) Q:NDPROCS=""  D
 . . . S PID=""
 . . . F  S PID=$O(^TMP("SPN",$J,"RA","HI","H2",COST,NPROCS,NDPROCS,PID)) Q:PID=""  D
 . . . . D GETNAME^SPNLRU(PID,.PNAME,.PSSN)
 . . . . S CNT=CNT+1 S ^TMP($J,CNT)=PNAME_U_PSSN_U_-NPROCS_U_-NDPROCS_U_-COST_"^EOL999"
 K TITLE(4),TITLE(5),TITLE(6),TITLE(7),TITLE(8)
 Q
KILL ;
 ;CALLED FROM SUB ROUTINE
 K ABORT,CNT,COST,DFN,FACNAME,FDATE,HIUSERS,ICN,MINCOST,MINFILL,PTLIST,QLIST,SPNPAGE,STR,TDATE,X,XFDATE,XTDATE,Y,ZYZ
 K REPHDR,TITLE
