ORQ1 ;slc/dcm-Get orders for a patient. ; 08 May 2002  2:12 PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**27,72,78,141,190,215**;Dec 17, 1997
EN(PAT,GROUP,FLG,EXPAND,SDATE,EDATE,DETAIL,MULT,XREF,GETKID,EVENT) ;Get orders
 ; Returns orders in ^TMP("ORR",$J,ORLIST,i) for defined context:
 ;
 ; PAT  =patient variable ptr in format "DFN;DPT("
 ; GROUP=Display group
 ; FLG  =#:                Includes status:
 ; 1. All               => 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
 ; 2. Active/Current    =>     3,4,5,6,  8,9,   11,         15
 ;    Includes CONTEXT HRS 1,2,7,13 & Action Status=13
 ;                         Orders in ^OR(100,"AC",PAT,TM,IFN,ACTION)
 ; 3. Discontinued      => 1                       12,13
 ; 4. Completed/Expired =>   2,        7
 ; 5. Expiring          =>     3,4,5,6,  8,9
 ; 6. Recent Activity   => 1,2,3,4,5,6,7,8,9,      12,      15
 ;                         Orders in ^OR(100,"AR",PAT,TM,IFN,ACTION)
 ; 7. Pending           =>         5
 ; 8. Unverified        => 1,  3,4,5,6,  8,9,               15
 ; 9. Unverified/Nurse  => 1,  3,4,5,6,  8,9,               15
 ;10. Unverified/Clerk  => 1,  3,4,5,6,  8,9,               15
 ;11. Unsigned          => 1,2,3,4,5,6,7,8,9,10,11,   13,14,15
 ;                         Orders in ^OR(100,"AS",PAT,TM,IFN)
 ;12. Flagged           => 1,2,3,4,5,6,7,8,9,      12,13,14,15
 ;13. Verbal/Phoned     => 1,2,3,4,5,6,7,8,9,         13,14,15
 ;                         Nature of order of verbal or phoned
 ;14. Verb/Phn unsigned => 1,2,3,4,5,6,7,8,9,         13,14,15
 ;                         Nature of order V or P & unsigned
 ;15. Admission         =>           6,      10
 ;16. Discharge         =>           6,      10
 ;17. Transfer          =>           6,      10
 ;                         Orders in ^OR(100,"AEVNT",PAT,EVENT,IFN)
 ;18. On Hold           =>     3
 ;19. New Orders        =>                   10,11
 ;                         Orders in ^TMP("ORNEW",$J,ORIFN)
 ;20. Chart Review      => 1,  3,4,5,6,  8,9,               15
 ;21. Chart Copy Summary=> same as All w/screen on Nature of order
 ;22. Lapsed            =>                               14
 ;23. Active status     =>         5,6
 ;24. All Delayed       =>           6,      10
 ;25. Out of OR         =>           6,      10
 ;26. Manual Release    =>           6,      10
 ;27. Expired           =>             7
 ;28. Discontinued Entered in Error => code handles this in ORQ12
 ;                         Orders in ^OR(100,"AEVNT",PAT,EVENT,IFN)
EN0 ; where order status=#:
 ; 1 => Discontinued (dc) 6 => Active (a)           11 => Unreleased (u)
 ; 2 => Complete (c)      7 => Expired (e)          12 => DC/Edit (dce)
 ; 3 => Hold (h)          8 => Scheduled (s)        13 => Cancelled (x)
 ; 4 => Flagged (?)       9 => Partial Results (pr) 14 => Lapsed (l)
 ; 5 => Pending (p)      10 => Delayed (d)          15 => Renewed (rn)
 ;                                                  99 => No Status (')
 ; EXPAND=ifn of parent order, used to expand child orders
 ; SDATE =Start date
 ; EDATE =End date
 ; DETAIL=Data to be returned (optional, default=0):
 ;     0 => ^TMP("ORR",$J,ORLIST,i) = order #
 ;     1 => ^TMP("ORR",$J,ORLIST,i) = order #^display group^when entered^
 ;                                    start d/t^stop d/t^status^sts abbrv
 ;          ^TMP("ORR",$J,ORLIST,i,"TX",j) = order text
 ; MULT  =0:Don't allow multiple occurrances of order
 ;       =1:Allow multiple occurances
 ; XREF  =cross reference to use instead of ACT (AW for completed orders)
 ; GETKID=includes children of multiple orders
 ; EVENT =ptr to Patient Event file #100.2, for orders tied to an event
 ;
EN1 ; -- start here
 Q:'$G(PAT)  N X,ORLST,ORGRP,LAPSE
 S:'$G(GROUP) GROUP=$O(^ORD(100.98,"B","ALL SERVICES",0))
 S:'$G(FLG) FLG=2 S:'$G(DETAIL) DETAIL=0 S:'$G(MULT) MULT=0
 I $G(EDATE)<$G(SDATE) S X=EDATE,EDATE=SDATE,SDATE=X
 I $G(EDATE) S EDATE=$S($L(EDATE,".")=2:EDATE+.0001,1:EDATE+1)
 I $G(SDATE) S SDATE=$S($L(SDATE,".")=2:SDATE-.0001,1:SDATE)
 S SDATE=9999999-$S($G(SDATE):SDATE,FLG=6:DT-.7641,1:0),EDATE=9999999-$S($G(EDATE):EDATE,FLG=6:DT+.2359,1:9999998)
 S ORLST=0,X=EDATE,EDATE=SDATE,SDATE=X D GRP(GROUP),LIST
 S LAPSE=+$$GET^XPAR("ALL","OR DELAYED ORDERS LAPSE DAYS")
 S:LAPSE LAPSE=$$FMADD^XLFDT(DT,(0-LAPSE)) ;=0 or cutoff date
 I "^15^16^17^24^25^26^"[(U_FLG_U)!$G(EVENT) D EN^ORQ13 G ENQ
 D @($S(FLG=2:"CUR",FLG=5:"EXG","^6^8^9^10^20^"[(U_FLG_U):"ACT",FLG=11:"SIG",FLG=19:"NEW","^1^3^4^7^12^13^14^18^21^22^23^27^28^"[(U_FLG_U):"LOOP",1:"QUIT")_"^ORQ11")
ENQ K ^TMP("ORGOTIT",$J)
 Q
 ;
LIST ;Get entry in ^TMP("ORR",$J,ORLIST)
 S ORLIST=$H
 L +^TMP("ORR",$J,ORLIST)
 I $D(^TMP("ORR",$J,ORLIST)) L -^TMP("ORR",$J,ORLIST) H 1 G LIST
 S ^TMP("ORR",$J,ORLIST)=""
 L -^TMP("ORR",$J,ORLIST)
 Q
 ;
GRP(DG) ;Setup display groups
 ;DG=Display group to expand
 N STK,MEM
 S ORGRP(DG)="",STK=1,STK(STK)=DG_"^0",STK(0)=0,MEM=0
 F  S MEM=$O(^ORD(100.98,+STK(STK),1,MEM)) D @$S(+MEM'>0:"POP",1:"PROC") Q:STK<1
 Q
 ;
POP S STK=STK-1,MEM=$P(STK(STK),"^",2)
 Q
PROC S $P(STK(STK),"^",2)=MEM,DG=$P(^ORD(100.98,+STK(STK),1,MEM,0),"^",1)
 S ORGRP(DG)="",STK=STK+1,STK(STK)=DG_"^0",MEM=0
 Q
