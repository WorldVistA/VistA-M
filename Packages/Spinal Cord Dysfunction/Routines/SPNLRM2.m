SPNLRM2 ;ISC-SF/GB-SCD RADIOLOGY UTILIZATION REPORT (PRINT PART 2 OF 2) ;5 JUN 94 [ 08/15/94  8:38 AM ]
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ; PAGELEN   Number of lines per page
 ; TITLE     Array of header lines (titles)
P4(TITLE,PAGELEN,HIUSERS,ABORT) ;
 ; I         High user counter
 ; COST      Cost of the procedures
 ; NDPROCS   Number of different procedures
 ; NPROCS    Number of procedures
 ; PID       Patient ID (Coded SSN)
 ; PNAME     Patient Name
 ; PSSN      Patient SSN
 N NPROCS,NDPROCS,COST,PID,PNAME,PSSN,I
 S TITLE(4)=""
 S TITLE(5)=$$CENTER^SPNLRU("Highest Utilization Patients Based on Number of Procedures")
 ; TITLE(5)="         1         2         3         4         5         6         7         8"
 S TITLE(6)=""
 S TITLE(7)="                                                  Total     Different     Total"
 S TITLE(8)="Patient Name                        SSN           Procs       Procs       Value"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S NPROCS=""
 F I=1:1:HIUSERS S NPROCS=$O(^TMP("SPN",$J,"RA","HI","H1",NPROCS)) Q:NPROCS=""  D  Q:ABORT
 . S NDPROCS=""
 . F  S NDPROCS=$O(^TMP("SPN",$J,"RA","HI","H1",NPROCS,NDPROCS)) Q:NDPROCS=""  D  Q:ABORT
 . . S COST=""
 . . F  S COST=$O(^TMP("SPN",$J,"RA","HI","H1",NPROCS,NDPROCS,COST)) Q:COST=""  D  Q:ABORT
 . . . S PID=""
 . . . F  S PID=$O(^TMP("SPN",$J,"RA","HI","H1",NPROCS,NDPROCS,COST,PID)) Q:PID=""  D  Q:ABORT
 . . . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . . . D GETNAME^SPNLRU(PID,.PNAME,.PSSN)
 . . . . W !,PNAME,?32,PSSN,?44,$J($FN(-NPROCS,","),10),?55,$J($FN(-NDPROCS,","),8),?68,$J($FN(-COST,",",2),12)
 Q
P5(TITLE,PAGELEN,HIUSERS,ABORT) ;
 ; I         High user counter
 ; COST      Cost of the procedures
 ; NDPROCS   Number of different procedures
 ; NPROCS    Number of procedures
 ; PID       Patient ID (Coded SSN)
 ; PNAME     Patient Name
 ; PSSN      Patient SSN
 N NPROCS,NDPROCS,COST,PID,PNAME,PSSN,I
 S TITLE(5)=$$CENTER^SPNLRU("Highest Utilization Patients Based on Value")
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S COST=""
 F I=1:1:HIUSERS S COST=$O(^TMP("SPN",$J,"RA","HI","H2",COST)) Q:COST=""  D  Q:ABORT
 . S NPROCS=""
 . F  S NPROCS=$O(^TMP("SPN",$J,"RA","HI","H2",COST,NPROCS)) Q:NPROCS=""  D  Q:ABORT
 . . S NDPROCS=""
 . . F  S NDPROCS=$O(^TMP("SPN",$J,"RA","HI","H2",COST,NPROCS,NDPROCS)) Q:NDPROCS=""  D  Q:ABORT
 . . . S PID=""
 . . . F  S PID=$O(^TMP("SPN",$J,"RA","HI","H2",COST,NPROCS,NDPROCS,PID)) Q:PID=""  D  Q:ABORT
 . . . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . . . D GETNAME^SPNLRU(PID,.PNAME,.PSSN)
 . . . . W !,PNAME,?32,PSSN,?44,$J($FN(-NPROCS,","),10),?58,$J($FN(-NDPROCS,","),8),?68,$J($FN(-COST,",",2),12)
 K TITLE(4),TITLE(5),TITLE(6),TITLE(7),TITLE(8)
 Q
