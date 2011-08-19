RGSYSTAT ;BAY/ALS-MPI/PD STATUS DISPLAY ;01/05/01
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**16,19,23,25,20,43,45,52,57**;30 Apr 99;Build 2
 ;
 ;Reference to ^DGCN(391.98,"AST" supported by IA #3303
 ;Reference to ^DGCN(391.984 supported by IA #3304
 ;Reference to ^MPIF(984.9 supported by IA #3298
 ;Reference to OPTSTAT^XUTMOPT supported by IA #1472
 ;Reference to ^DPT("ACMORS", ^DPT("AICN", and ^DPT("AICNL" supported by IA #2070
 ;Reference to ^VAT(391.71 supported by IA #3422
EN ;
 ; Count exceptions on hand
EXC ;
 W @IOF,"Exception Handler Entries:",!,"--------------------------"
 S CNT=0,EXCTYP="",NTYP="",TOTL=0,PCNT=0
 N STAT,DFN,ICN
 S HOME=$$SITE^VASITE()
 F  S EXCTYP=$O(^RGHL7(991.1,"AC",EXCTYP)) Q:'EXCTYP  D
 . I EXCTYP=234 D  ;**45;**52 MPIC_772 remove 215, 216, 217 & 227;**57 MPIC_1893 remove 218
 .. I (EXCTYP'=NTYP)&(CNT>0) D
 ... S ETEXT=$P($G(^RGHL7(991.11,NTYP,10)),"^",1)
 ... W !,$E(ETEXT,1,47),?55,$J(CNT,6) S TOTL=TOTL+CNT,CNT=0
 .. S IEN=0,NTYP=EXCTYP
 .. F  S IEN=$O(^RGHL7(991.1,"AC",EXCTYP,IEN)) Q:'IEN  D
 ... S IEN2=0
 ... F  S IEN2=$O(^RGHL7(991.1,"AC",EXCTYP,IEN,IEN2)) Q:'IEN2  D
 .... S STAT=$P(^RGHL7(991.1,IEN,1,IEN2,0),"^",5) I STAT<1 D
 ..... S DFN=$P(^RGHL7(991.1,IEN,1,IEN2,0),"^",4) Q:'DFN
 ..... S ^XTMP("RGEXC",0)=$$FMADD^XLFDT(DT,2)_"^"_DT_"^"_"MPI/PD Status Display"
 ..... S ^XTMP("RGEXC",DFN)=DFN
 ..... S ICN=+$$GETICN^MPIF001(DFN)
 ..... I $E(ICN,1,3)=$E($P(HOME,"^",3),1,3)!(ICN<0)!(EXCTYP=234) D  ;**43;**45;**52 MPIC_772 remove 215, 216 & 217;**57 MPIC_1893 remove 218
 ...... S CNT=CNT+1
 I CNT>0 D
 .S ETEXT=$P($G(^RGHL7(991.11,NTYP,10)),"^",1)
 .W !,$E(ETEXT,1,47),?55,$J(CNT,6) S TOTL=TOTL+CNT
 I TOTL=0 W !,"There are no entries in the Exception Handler."
 I TOTL>0 D
 . W !!,"Total number of exceptions: ",?55,$J(TOTL,6)
 . S PDFN=""
 . F  S PDFN=$O(^XTMP("RGEXC",PDFN)) Q:'PDFN  D
 .. S PCNT=PCNT+1
 . W !,"Total unique patient exceptions: ",?55,$J(PCNT,6)
 S STDT=$P($G(^RGSITE(991.8,1,"EXCPRG")),"^",1)
 I $D(^RGSITE(991.8,1,"EXCPRG")) D
 . S STDT=$$FMTE^XLFDT(STDT,1)
 . W !!,"The MPI/PD Exception Purge process last ran "_STDT_"."
 K CNT,EXCTYP,NTYP,ETEXT,TOTL,IEN,IEN2,HOME,PCNT,^XTMP("RGEXC"),PDFN,STDT
 I $Y>21 D QUIT Q:X="^"
PDR ;Count entries in Patient Data Review ;**52 Obsolete data removed from report.
 ;W !!,"Patient Data Review Entries:",!,"----------------------------"
 ;S CNT=0,PDRTYP="",NTYP="",TOTL=0
 ;F  S PDRTYP=$O(^DGCN(391.98,"AST",PDRTYP)) Q:'PDRTYP  D
 ;. I (PDRTYP'=NTYP)&(CNT>0) D
 ;.. S DIC="^DGCN(391.984,",DR=".01",DA=NTYP,DIQ(0)="E",DIQ="RGPDR"
 ;.. D EN^DIQ1 K DIC,DA,DR,DIQ
 ;.. S PTEXT=$G(RGPDR(391.984,NTYP,.01,"E"))
 ;.. W !,$E(PTEXT,1,47),?55,$J(CNT,6) S TOTL=TOTL+CNT,CNT=0
 ;. I (PDRTYP=1)!(PDRTYP=2)!(PDRTYP=5) D
 ;.. S IEN=0,NTYP=PDRTYP
 ;.. F  S IEN=$O(^DGCN(391.98,"AST",PDRTYP,IEN)) Q:'IEN  D
 ;... S CNT=CNT+1
 ;I CNT>0 D
 ;. S DIC="^DGCN(391.984,",DR=".01",DA=NTYP,DIQ(0)="E",DIQ="RGPDR"
 ;. D EN^DIQ1 K DIC,DA,DR,DIQ
 ;. S PTEXT=$G(RGPDR(391.984,NTYP,.01,"E"))
 ;.W !,$E(PTEXT,1,47),?55,$J(CNT,6) S TOTL=TOTL+CNT
 ;I TOTL=0 W !,"There are no entries in Patient Data Review."
 ;K CNT,PDRTYP,NTYP,TOTL,IEN,PTEXT,RGPDR
 ;Q
 ;I $Y>20 D QUIT Q:X="^"
 ;
CMOR ;CMOR Requests Status ;**52 Obsolete data removed from report.
 ;W !!,"CMOR Requests Status:",!,"---------------------"
 ;S CNT=0,STAT="",NSTAT="",TOTL=0
 ;F  S STAT=$O(^MPIF(984.9,"AC",STAT)) Q:'STAT  D
 ;. I (STAT'=NSTAT)&(CNT>0) D
 ;.. S TEXT=$$EXTERNAL^DILFD(984.9,.06,,NSTAT)
 ;.. W !,$E(TEXT,1,47),?55,$J(CNT,6) S TOTL=TOTL+CNT,CNT=0
 ;. S IEN=0,NSTAT=STAT
 ;. F  S IEN=$O(^MPIF(984.9,"AC",STAT,IEN)) Q:'IEN  D
 ;.. S CNT=CNT+1 S TOTL=TOTL+CNT
 ;I CNT>0 S TEXT=$$EXTERNAL^DILFD(984.9,.06,,NSTAT) W !,$E(TEXT,1,47),?55,$J(CNT,6) S TOTL=TOTL+CNT,CNT=0
 ;I TOTL=0 W !,"There are no outstanding CMOR Requests."
 ;K CNT,STAT,NSTAT,TEXT,TOTL,IEN
 ;I $Y>20 D QUIT Q:X="^"
 ;
 S HOME=$P($$SITE^VASITE(),"^",3)
 S ICN=0,CNT=0
 F  S ICN=$O(^DPT("AICN",ICN)) Q:'ICN  D
 .Q:$E(ICN,1,3)=HOME
 .S CNT=CNT+1
 W !!,"Current total number of National ICNs = ",CNT
 S ICN=0,CNT=0
 F  S ICN=$O(^DPT("AICNL",1,ICN)) Q:'ICN  S CNT=CNT+1
 W !,"Current total number of Local ICNs = ",CNT
 K CNT,DFN,ICN
 Q
QUIT S DIR(0)="E" D  D ^DIR K DIR
 .S SS=21-$Y F JJ=1:1:SS W !
 S $Y=0
 K JJ,SS
 Q
