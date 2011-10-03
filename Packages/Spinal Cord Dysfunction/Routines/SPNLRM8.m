SPNLRM8 ;SD/WDE - SCD RADIOLOGY UTILIZATION REPORT (RPC PART 1 OF 2) ;Nov 24, 2006
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
P1 ;
 ; CPTCODE   Code of radiology procedure
 ; NPROCS    Number of procedures
 ; NDPROCS   Number of different procedures
 N NPROCS,NDPROCS,CPTCODE,OUT,LINE,STARTLIN,COL,NPATS
 S CNT=0
 S NPROCS=+$G(^TMP("SPN",$J,"RA","EXAMS"))
 S NPATS=+$G(^TMP("SPN",$J,"RA","PAT"))
 S CNT=CNT+1
 S ^TMP($J,CNT)="BOS999"_U_"Totals:  "_$FN(NPROCS,",")_" procedure"_$S(NPROCS=1:"",1:"s")_" reported for "_$FN(NPATS,",")_" patient"_$S(NPATS=1:"",1:"s")_"^EOL999"
 S CNT=CNT+1 S ^TMP($J,CNT)="HDR999"_U_"Patients"_U_"Procedures"_"^EOL999"
 S CPTCODE=""
 F NDPROCS=0:1 S CPTCODE=$O(^TMP("SPN",$J,"RA","PROC",CPTCODE)) Q:CPTCODE=""
 I NDPROCS=1&(NPROCS>1) S CNT=CNT+1 S ^TMP($J,CNT)="(This includes just one type of procedure)"_"^EOL999"
 I NDPROCS>1 S CNT=CNT+1 S ^TMP($J,CNT)="HDR999"_U_"(These include "_$FN(NDPROCS,",")_" different procedures)"_"^EOL999"
 S NPROCS=+$O(^TMP("SPN",$J,"RA","EXAMS",""))
 F  D  Q:NPROCS=""
 . S CNT=CNT+1
 . S ^TMP($J,CNT)=$G(^TMP("SPN",$J,"RA","EXAMS",NPROCS))_U_-NPROCS_"^EOL999"
 . S NPROCS=$O(^TMP("SPN",$J,"RA","EXAMS",NPROCS))
 . Q
 Q
P2 ;
 N NPATS,NPROCS,CPTCODE,NAME,COST
 ;S TITLE(5)=$$CENTER^SPNLRU($FN(QLIST("MINNUM"),",")_" or More Procedures")
 ;S TITLE(6)=""
 ;S TITLE(7)="Radiology Procedure                  CPT Code    Procedures    Value    Patients"
 S CPTCODE=""
 S CNT=CNT+1
 S ^TMP($J,CNT)="BOS999"_U_QLIST("MINNUM")_" or More Procedures"_"^EOL999"
 S CNT=CNT+1
 S ^TMP($J,CNT)="HDR999"_U_"Radiology Procedure"_U_"CPT Code"_U_"Procedures"_U_"Value"_U_"Patients"_"^EOL999"
 F  S CPTCODE=$O(^TMP("SPN",$J,"RA","PROC",CPTCODE)) Q:CPTCODE=""  D
 . S NPROCS=^TMP("SPN",$J,"RA","PROC",CPTCODE)
 . Q:NPROCS<QLIST("MINNUM")
 . S COST=^TMP("SPN",$J,"RA","PROC",CPTCODE,"VAL")
 . S NPATS=^TMP("SPN",$J,"RA","PROC",CPTCODE,"PAT")
 . S NAME=^TMP("SPN",$J,"RA","PROC",CPTCODE,"NAME")
 . S ^TMP("SPN",$J,"RA","OUT",-NPROCS,-COST,-NPATS,NAME)=CPTCODE
 S NPROCS=""
 F  S NPROCS=$O(^TMP("SPN",$J,"RA","OUT",NPROCS)) Q:NPROCS=""  D
 . S COST=""
 . F  S COST=$O(^TMP("SPN",$J,"RA","OUT",NPROCS,COST)) Q:COST=""  D
 . . S NPATS=""
 . . F  S NPATS=$O(^TMP("SPN",$J,"RA","OUT",NPROCS,COST,NPATS)) Q:NPATS=""  D
 . . . S NAME=""
 . . . F  S NAME=$O(^TMP("SPN",$J,"RA","OUT",NPROCS,COST,NPATS,NAME)) Q:NAME=""  D
 . . . . S CPTCODE=^TMP("SPN",$J,"RA","OUT",NPROCS,COST,NPATS,NAME)
 . . . . S CNT=CNT+1 S ^TMP($J,CNT)=NAME_U_$S(CPTCODE=0:"",1:$J(CPTCODE,5))_U_-NPROCS_U_-COST_U_-NPATS_"^EOL999"
 K ^TMP("SPN",$J,"RA","OUT")
 K TITLE(4),TITLE(5),TITLE(6),TITLE(7)
 Q
P3 ;
 N NPATS,NAME,NPROCS,LCOST,TCOST,COST,CPTCODE
 S CNT=CNT+1 S ^TMP($J,CNT)="BOS999"_U_"Radiology procedures totaling $"_QLIST("MINCOST")_" or more"_"^EOL999"
 S TITLE(6)=""
 S TITLE(7)="Radiology Procedure                  CPT Code      Value   Procedures   Patients"
 S CNT=CNT+1 S ^TMP($J,CNT)="HDR999"_U_"Radiology Procedure"_U_"CPT Code"_U_"Value"_U_"Procedures"_U_"Patients"_"^EOL999"
 S CPTCODE="",(LCOST,TCOST)=0
 F  S CPTCODE=$O(^TMP("SPN",$J,"RA","PROC",CPTCODE)) Q:CPTCODE=""  D
 . S COST=^TMP("SPN",$J,"RA","PROC",CPTCODE,"VAL")
 . S TCOST=TCOST+COST
 . Q:COST<QLIST("MINCOST")
 . S LCOST=LCOST+COST
 . S NPROCS=^TMP("SPN",$J,"RA","PROC",CPTCODE)
 . S NPATS=^TMP("SPN",$J,"RA","PROC",CPTCODE,"PAT")
 . S NAME=^TMP("SPN",$J,"RA","PROC",CPTCODE,"NAME")
 . S ^TMP("SPN",$J,"RA","OUT",-COST,-NPROCS,-NPATS,NAME)=CPTCODE
 S COST=""
 F  S COST=$O(^TMP("SPN",$J,"RA","OUT",COST)) Q:COST=""  D
 . S NPROCS=""
 . F  S NPROCS=$O(^TMP("SPN",$J,"RA","OUT",COST,NPROCS)) Q:NPROCS=""  D
 . . S NPATS=""
 . . F  S NPATS=$O(^TMP("SPN",$J,"RA","OUT",COST,NPROCS,NPATS)) Q:NPATS=""  D
 . . . S NAME=""
 . . . F  S NAME=$O(^TMP("SPN",$J,"RA","OUT",COST,NPROCS,NPATS,NAME)) Q:NAME=""  D
 . . . . S CPTCODE=^TMP("SPN",$J,"RA","OUT",COST,NPROCS,NPATS,NAME)
 . . . . S CNT=CNT+1 S ^TMP($J,CNT)=NAME_U_$S(CPTCODE=0:"",1:$J(CPTCODE,5))_U_-COST_U_-NPROCS_U_-NPATS_"^EOL999"
 K ^TMP("SPN",$J,"RA","OUT")
 I TCOST=LCOST D
 . S CNT=CNT+1 S ^TMP($J,CNT)="BHDR999"_U_"TOTAL for all procedures "_TCOST_"^EOL999"
 E  D
 . S CNT=CNT+1 S ^TMP($J,CNT)="BHDR999"_U_"TOTAL for all procedures "_LCOST_"^EOL999"
 . S CNT=CNT+1 S ^TMP($J,CNT)="BHDR999"_U_"TOTAL (including unlisted procedures) "_TCOST_"^EOL999"
 K TITLE(4),TITLE(5),TITLE(6),TITLE(7)
 Q
KILL ;
 K ABORT,CNT,COST,DFN,FACNAME,FDATE,HIUSERS,ICN,MINCOST,MINFILL,PTLIST,QLIST,SPNPAGE,STR,TDATE,X,XFDATE,XTDATE,Y,ZYZ
 K TITLE(4),TITLE
