SPNJRPP2 ;BP/JAS - Returns Prosthetic Utilization Specific info ;May 15, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; References to ^RMPR(660 supported by IA# 4975
 ; Reference to file 4 supported by IA# 10090
 ; Reference to API DEM^VADPT supported by IA# 10061
 ; Reference to API PSASHCPC^RMPOPF supported by IA# 4975
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
 ; Parm values:
 ;     RETURN  is the sorted data from the earliest date of listing
 ;     ICNLST  is the list of patient ICNs to process
 ;     FDATE   is the delivery starting date
 ;     TDATE   is the delivery ending date
 ;     ITEMS   is the list of CPT codes to search for
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,ICNLST,FDATE,TDATE,ITEMS) ;
 ;
 ;***************************
 S RETURN=$NA(^TMP($J)),RETCNT=1
 S X=FDATE S %DT="T" D ^%DT S SPNSTRT=Y
 S X=TDATE S %DT="T" D ^%DT S SPNEND=Y_.2359
 ;***************************
 K ^TMP($J),^TMP("SPN",$J)
 K ITMLST,ICHK
 D ITMLST
 F ICNNM=1:1:$L(ICNLST,"^") S ICN=$P(ICNLST,"^",ICNNM) D IN
 D OUT,CLNUP
 Q
IN Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 Q:'$D(^RMPR(660,"C",DFN))
 ;JAS - 05/15/08 - DEFECT 1090
 ;S PDA=""
 S PDA=0
 F  S PDA=$O(^RMPR(660,"C",DFN,PDA)) Q:PDA=""  D
 . Q:'$D(^RMPR(660,PDA,0))
 . S DEDAT=$P($G(^RMPR(660,PDA,0)),"^",12)
 . Q:DEDAT=""
 . Q:DEDAT<SPNSTRT!(DEDAT>SPNEND)
 . S STAT=$P(^RMPR(660,PDA,0),"^",10)
 . S STAT=$$GET1^DIQ(4,STAT_",",.01)
 . S RMPRHCDT=$P(^RMPR(660,PDA,0),"^",1)
 . Q:'$D(^RMPR(660,PDA,1))
 . S RMPRHCPC=$P(^RMPR(660,PDA,1),"^",4)
 . Q:RMPRHCPC=""
 . D PSASHCPC^RMPOPF
 . Q:RMPREHC=""
 . S ITEM=RMPREHC
 . S IDESC=RMPRTHC
 . D DEM^VADPT
 . S IQTY=$P(^RMPR(660,PDA,0),"^",7)
 . S ITYP=$P(^RMPR(660,PDA,0),"^",4)
 . S ITYP=$S(ITYP="I":"INITIAL ISSUE",ITYP="X":"REPAIR",ITYP="S":"SPARE",ITYP="R":"REPLACE",ITYP=5:"RENTAL",1:"")
 . S ICOST=$P(^RMPR(660,PDA,0),"^",16)
 . S IHCP=IDESC
 . S DEDAT=$$FMTE^XLFDT(DEDAT,"5DZP")
 . Q:'$D(ITMLST(ITEM))
 . S ^TMP("SPN",$J,ITEM,IHCP,STAT,VADM(1),PDA)=VADM(1)_"^"_VA("PID")_"^"_ITEM_"^"_IDESC_"^"_IQTY_"^"_ICOST_"^"_ITYP_"^"_DEDAT
 . Q
 Q
OUT ;
 S ICHK="" F  S ICHK=$O(ITMLST(ICHK)) Q:ICHK=""  D
 . Q:ICHK=""!('$D(^ICPT("B",ICHK)))
 . Q:'$D(^TMP("SPN",$J,ICHK))
 . S ^TMP("SPN",$J,ICHK)=""
 . Q
 S ITEM=""
 F  S ITEM=$O(^TMP("SPN",$J,ITEM)) Q:ITEM=""  D
 . I $D(^TMP("SPN",$J,ITEM))=1 D  Q
 . . S ^TMP($J,RETCNT)="ITM999^"_ITEM_"^^EOL999"
 . . S RETCNT=RETCNT+1
 . . S ^TMP($J,RETCNT)="TOT999^0^0^EOL999"
 . . S RETCNT=RETCNT+1
 . S HCP=""
 . F  S HCP=$O(^TMP("SPN",$J,ITEM,HCP)) Q:HCP=""  D
 . . S ^TMP($J,RETCNT)="ITM999^"_ITEM_"^"_HCP_"^EOL999"
 . . S RETCNT=RETCNT+1
 . . S STAT="",PATCNT=0,TQTY=0,TCOST=0
 . . F  S STAT=$O(^TMP("SPN",$J,ITEM,HCP,STAT)) Q:STAT=""  D
 . . . S NAM=""
 . . . F  S NAM=$O(^TMP("SPN",$J,ITEM,HCP,STAT,NAM)) Q:NAM=""  D
 . . . . S PATCNT=PATCNT+1
 . . . . S PDA=""
 . . . . F  S PDA=$O(^TMP("SPN",$J,ITEM,HCP,STAT,NAM,PDA)) Q:PDA=""  D
 . . . . . S PREC=^TMP("SPN",$J,ITEM,HCP,STAT,NAM,PDA)
 . . . . . S SSN=$P(PREC,"^",2),IDESC=$P(PREC,"^",4),IQTY=$P(PREC,"^",5)
 . . . . . S ICOST=$P(PREC,"^",6),ITYP=$P(PREC,"^",7),DEDAT=$P(PREC,"^",8)
 . . . . . S TQTY=TQTY+IQTY,TCOST=TCOST+ICOST
 . . . . . S ^TMP($J,RETCNT)=STAT_"^"_NAM_"^"_SSN_"^"_IQTY_"^"_ICOST_"^"_ITYP_"^"_DEDAT_"^EOL999"
 . . . . . S RETCNT=RETCNT+1
 . . S ^TMP($J,RETCNT)="TOT999^"_PATCNT_"^"_TCOST_"^EOL999"
 . . S RETCNT=RETCNT+1
 K ^TMP("SPN",$J)
 Q
ITMLST ;
 S CNT="" F  S CNT=$O(ITEMS(CNT)) Q:CNT=""  D
 . S ICHK=$P(ITEMS(CNT),"^",1)
 . I $D(^ICPT("B",ICHK)) S ITMLST(ICHK)=""
 Q
CLNUP ;
 K FDATE,TDATE,ICNLST,ICN,ITEMS,SPNSTRT,SPEND,ICNNM,DFN,PDA,DEDAT,STAT,ITDA,IREC0,IREC2,IQTY,ITEM,ITMLST,ITEM
 K ITYP,ICOST,HCPREF,DEDAT,VADM,IHCP,STAT,IDESC,ICOST,ICHK,INUM,RETCNT,ITEM,HCP,STAT,NAM,PATCNT,TCOST
 K %DT,CNT,IREF,PREC,SPNEND,SSN,TQTY,VA,X,Y,RMPRHCDT,RMPRHCPC,RMPREHC,RMPRTHC
 Q
