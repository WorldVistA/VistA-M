SPNLRM1 ;ISC-SF/GB-SCD RADIOLOGY UTILIZATION REPORT (PRINT PART 1 OF 2) ;5 JUN 94 [ 08/23/94  10:04 AM ]
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
P1(TITLE,PAGELEN,ABORT) ;
 ; CPTCODE   Code of radiology procedure
 ; NPROCS    Number of procedures
 ; NDPROCS   Number of different procedures
 N NPROCS,NDPROCS,CPTCODE,OUT,LINE,STARTLIN,COL,NPATS
 S TITLE(4)=""
 S NPROCS=+$G(^TMP("SPN",$J,"RA","EXAMS"))
 S NPATS=+$G(^TMP("SPN",$J,"RA","PAT"))
 S TITLE(5)=$$CENTER^SPNLRU("Totals:  "_$FN(NPROCS,",")_" procedure"_$S(NPROCS=1:"",1:"s")_" reported for "_$FN(NPATS,",")_" patient"_$S(NPATS=1:"",1:"s"))
 S CPTCODE=""
 F NDPROCS=0:1 S CPTCODE=$O(^TMP("SPN",$J,"RA","PROC",CPTCODE)) Q:CPTCODE=""
 S:NDPROCS=1&(NPROCS>1) TITLE(6)=$$CENTER^SPNLRU("(This includes just one type of procedure)")
 S:NDPROCS>1 TITLE(6)=$$CENTER^SPNLRU("(These include "_$FN(NDPROCS,",")_" different procedures)")
 S NPROCS=+$O(^TMP("SPN",$J,"RA","EXAMS",""))
 F  D  Q:NPROCS=""!(ABORT)
 . D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . K OUT,TITLE(4),TITLE(5),TITLE(6)
 . S STARTLIN=$Y
 . S OUT(STARTLIN+1)=""
 . F COL=1:1:3 D  Q:NPROCS=""
 . . S OUT(STARTLIN)=$G(OUT(STARTLIN))_"   Patients  Procedures   "
 . . F LINE=STARTLIN+2:1:PAGELEN D  Q:NPROCS=""
 . . . S OUT(LINE)=$G(OUT(LINE))_$J($FN(+$G(^TMP("SPN",$J,"RA","EXAMS",NPROCS)),","),10)_$J($FN(-NPROCS,","),12)_"    "
 . . . S NPROCS=$O(^TMP("SPN",$J,"RA","EXAMS",NPROCS))
 . S LINE=""
 . F  S LINE=$O(OUT(LINE)) Q:LINE=""  D
 . . W !,OUT(LINE)
 Q
P2(TITLE,PAGELEN,QLIST,ABORT) ;
 N NPATS,NPROCS,CPTCODE,NAME,COST
 S TITLE(4)=""
 S TITLE(5)=$$CENTER^SPNLRU($FN(QLIST("MINNUM"),",")_" or More Procedures")
 S TITLE(6)=""
 S TITLE(7)="Radiology Procedure                  CPT Code    Procedures    Value    Patients"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S CPTCODE=""
 F  S CPTCODE=$O(^TMP("SPN",$J,"RA","PROC",CPTCODE)) Q:CPTCODE=""  D
 . S NPROCS=^TMP("SPN",$J,"RA","PROC",CPTCODE)
 . Q:NPROCS<QLIST("MINNUM")
 . S COST=^TMP("SPN",$J,"RA","PROC",CPTCODE,"VAL")
 . S NPATS=^TMP("SPN",$J,"RA","PROC",CPTCODE,"PAT")
 . S NAME=^TMP("SPN",$J,"RA","PROC",CPTCODE,"NAME")
 . S ^TMP("SPN",$J,"RA","OUT",-NPROCS,-COST,-NPATS,NAME)=CPTCODE
 S NPROCS=""
 F  S NPROCS=$O(^TMP("SPN",$J,"RA","OUT",NPROCS)) Q:NPROCS=""  D  Q:ABORT
 . S COST=""
 . F  S COST=$O(^TMP("SPN",$J,"RA","OUT",NPROCS,COST)) Q:COST=""  D  Q:ABORT
 . . S NPATS=""
 . . F  S NPATS=$O(^TMP("SPN",$J,"RA","OUT",NPROCS,COST,NPATS)) Q:NPATS=""  D  Q:ABORT
 . . . S NAME=""
 . . . F  S NAME=$O(^TMP("SPN",$J,"RA","OUT",NPROCS,COST,NPATS,NAME)) Q:NAME=""  D  Q:ABORT
 . . . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . . . S CPTCODE=^TMP("SPN",$J,"RA","OUT",NPROCS,COST,NPATS,NAME)
 . . . . W !,NAME,?39,$S(CPTCODE=0:"",1:$J(CPTCODE,5)),?47,$J($FN(-NPROCS,","),11),?58,$J($FN(-COST,",",2),10),?69,$J($FN(-NPATS,","),10)
 K ^TMP("SPN",$J,"RA","OUT")
 K TITLE(4),TITLE(5),TITLE(6),TITLE(7)
 Q
P3(TITLE,PAGELEN,QLIST,ABORT) ;
 N NPATS,NAME,NPROCS,LCOST,TCOST,COST,CPTCODE
 S TITLE(4)=""
 S TITLE(5)=$$CENTER^SPNLRU("Radiology procedures totaling $"_$FN(QLIST("MINCOST"),",",2)_" or more")
 ; TITLE(5)="         1         2         3         4         5         6         7         8"
 S TITLE(6)=""
 S TITLE(7)="Radiology Procedure                  CPT Code      Value   Procedures   Patients"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
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
 F  S COST=$O(^TMP("SPN",$J,"RA","OUT",COST)) Q:COST=""  D  Q:ABORT
 . S NPROCS=""
 . F  S NPROCS=$O(^TMP("SPN",$J,"RA","OUT",COST,NPROCS)) Q:NPROCS=""  D  Q:ABORT
 . . S NPATS=""
 . . F  S NPATS=$O(^TMP("SPN",$J,"RA","OUT",COST,NPROCS,NPATS)) Q:NPATS=""  D  Q:ABORT
 . . . S NAME=""
 . . . F  S NAME=$O(^TMP("SPN",$J,"RA","OUT",COST,NPROCS,NPATS,NAME)) Q:NAME=""  D  Q:ABORT
 . . . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . . . S CPTCODE=^TMP("SPN",$J,"RA","OUT",COST,NPROCS,NPATS,NAME)
 . . . . W !,NAME,?39,$S(CPTCODE=0:"",1:$J(CPTCODE,5)),?45,$J($FN(-COST,",",2),11),?57,$J($FN(-NPROCS,","),11),?68,$J($FN(-NPATS,","),11)
 K ^TMP("SPN",$J,"RA","OUT")
 I TCOST=LCOST D
 . I $Y+1>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . W !!,"TOTAL for all procedures",?45,$J($FN(TCOST,",",2),11)
 E  D
 . I $Y+2>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . W !!,"TOTAL for listed procedures",?45,$J($FN(LCOST,",",2),11)
 . W !,"TOTAL (including unlisted procedures)",?45,$J($FN(TCOST,",",2),11)
 K TITLE(4),TITLE(5),TITLE(6),TITLE(7)
 Q
