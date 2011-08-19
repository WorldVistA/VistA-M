SPNJRPSD ;BP/JAS - Returns SCI/SCI Discharges data ;JUN 12, 2009
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to ^DPT(D0,0 supported by IA# 998
 ; Reference to ^DPT(D0,57 supported by IA# 4938
 ; Reference to ^DPT(D0,"MPI" supported by IA# 4938
 ; Reference to ^DGPM("APRD" supported by IA# 4942
 ; References to file #4 supported by IA# 10090
 ; References to file #45/^DGPT supported by IA# 92 & 4945
 ; Reference to API ICDDX^ICDCODE supported by IA# 3990
 ; RETIRED AND REPLACED WITH IA# 3990 [Reference to file #80 supported by IA# 10082]
 ; Reference to file #4.3 supported by IA# 10091
 ; Reference to API DEM^VADPT supported by IA# 10061
 ; Reference to API IN5^VADPT supported by IA# 10061
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
 ; Parm values:
 ;     RETURN  is the sorted data from the earliest date of listing
 ;     ICNLST  is the list of patient ICNs to process
 ;     FDATE   is the delivery starting date
 ;     TDATE   is the delivery ending date
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,ICNLST,FDATE,TDATE) ;
 ;
 ;***************************
 S RETURN=$NA(^TMP($J)),RETCNT=1,DISCNT=0
 S X=FDATE S %DT="T" D ^%DT S SPNDATE=Y
 S X=TDATE S %DT="T" D ^%DT S SPNEDAT=Y_.2359
 ;***************************
 K ^TMP($J),^TMP("SPN",$J),SPNFAC
 F ICNNM=1:1:$L(ICNLST,"^") S ICN=$P(ICNLST,"^",ICNNM) D IN
 D OUT,HEAD2,CLNUP
 Q
IN Q:$G(ICN)=""
 S SPNDFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 N SPNX,SPNFAC
 S (SPNLPRT,SPNFAC)=0
 S SPNQDAT=SPNDATE-.000001
 S SDA=SPNDFN
 Q:'$D(^DGPM("APRD",SDA))
 F  S SPNQDAT=$O(^DGPM("APRD",SDA,SPNQDAT)) Q:(SPNQDAT<1)  Q:(SPNQDAT>SPNEDAT)  D
 . S SPNIEN=0 F  S SPNIEN=$O(^DGPM("APRD",SDA,SPNQDAT,SPNIEN)) Q:SPNIEN<1  D
 . . N DFN,SPNLINE,SPNLOS
 . . S DFN=SPNDFN,VAIP("E")=SPNIEN D IN5^VADPT
 . . Q:VAIP(2)'["DISCHARGE"
 . . S SPNLOS=$$FMDIFF^XLFDT(SPNQDAT,$P(VAIP(15,1),U)) ; LENGTH OF STAY
 . . ; SPNLINE=Movement date(E)^pointer to PTF(I)^Length of Stay
 . . ;         ^Ward location(E)^D/C date
 . . S SPNLINE=$P(VAIP(15,1),U)_U_VAIP(12)_U_SPNLOS_U_$P(VAIP(5),U,2)_U_SPNQDAT
 . . S ^TMP("SPN",$J,$$GET1^DIQ(2,SPNDFN,.01,"E"),SPNDFN,SPNIEN)=SPNLINE
 . . D KVAR^VADPT
 Q
OUT ;
 I $D(^TMP("SPN",$J)) D   ; Indicates the report had data
 . N SPNSTATE,SPNDFN,SPNNAME,SPNCOU
 . S SPNCOU=0,SPNFAC=0
 . S SPNNAME="" F  S SPNNAME=$O(^TMP("SPN",$J,SPNNAME)) Q:SPNNAME=""  D
 . . S SPNDFN=0 F  S SPNDFN=$O(^TMP("SPN",$J,SPNNAME,SPNDFN)) Q:SPNDFN<1  D NEWPAT(SPNDFN)  D
 . . . S SPNIEN=0 F  S SPNIEN=$O(^TMP("SPN",$J,SPNNAME,SPNDFN,SPNIEN)) Q:SPNIEN<1  D
 . . . . S SPNLINE=^TMP("SPN",$J,SPNNAME,SPNDFN,SPNIEN)
 . . . . D HEAD
 . . . . D PATIENT(SPNDFN,SPNLINE)
 Q
NEWPAT(SPNDFN) ; New patient to print
 N DFN
 S DFN=SPNDFN D DEM^VADPT
 S ICN=$P(^DPT(DFN,"MPI"),"^",1)
 S ^TMP($J,RETCNT)="HDR1999^Patient^SSN^SCI^EOL999"
 S RETCNT=RETCNT+1
 S ^TMP($J,RETCNT)="PAT999^"_VADM(1)_"^"_$P(VADM(2),"^",2)_"^"_$$GET1^DIQ(2,SPNDFN,57.4,"E")_"^"_ICN_"^EOL999"
 S RETCNT=RETCNT+1
 D KVAR^VADPT
 S SPNCOU=SPNCOU+1
 Q
PATIENT(SPNDFN,SPNLINE) ; Print Patient data
 ; SPNLINE=Movement date(I)^pointer to PTF(I)^Length of Stay
 ;         ^Ward location(E)^D/C Date
 ; SPNLINE=$P(VAIP(15,1),U,2)_U_VAIP(12)_U_SPNLOS_U_$P(VAIP(5),U,2)_U_SPNQDAT
 S ^TMP($J,RETCNT)="DTL999^"_$$FMTE^XLFDT($P(SPNLINE,U,5),"5DZ")_"^"_$P(SPNLINE,U,3)_"^"_$P(SPNLINE,U,4)_"^EOL999"
 S RETCNT=RETCNT+1,DISCNT=DISCNT+1
 Q:$P(SPNLINE,U,2)=""
 N SPNODE,SPNNODE
 S SPNNODE=$G(^DGPT($P(SPNLINE,U,2),70)) Q:SPNNODE=""
 I $P(SPNNODE,U,12)?1N.N S SPNFAC=SPNFAC+1,SPNFAC($P(SPNNODE,U,12))=$G(SPNFAC($P(SPNNODE,U,12)))+1 ; Collect Receiving Facility
 N SPNY
 S RETCNTB=RETCNT
 ;F SPNODE=10,16:1:24 D
 F SPNODE=79,79.16,79.17,79.18,79.19,79.201,79.21,79.22,79.23,79.24 D
 . ;S SPNY=$P(SPNNODE,U,SPNODE)
 . S SPNY=$$GET1^DIQ(45,$P(SPNLINE,U,2)_",",SPNODE,"I")
 . I SPNY'>0 Q
 . ;JAS 6/12/09 - DEFECT 1137 - Removed direct & FM reads of CPT/ICD files to API usage
 . ;I $G(^ICD9(SPNY,0))="" Q
 . S SPNYAPI=$$ICDDX^ICDCODE(SPNY,"","","")
 . Q:$P(SPNYAPI,"^")=-1
 . ;S ^TMP($J,RETCNT)="DIAG999^"_$$GET1^DIQ(80,SPNY,3,"E")_"^EOL999"
 . S ^TMP($J,RETCNT)="DIAG999^"_$P(SPNYAPI,"^",4)_"^EOL999"
 . S RETCNT=RETCNT+1
 K SPNYAPI
 I RETCNT=RETCNTB D
 . S ^TMP($J,RETCNT)="DIAG999^^EOL999"
 . S RETCNT=RETCNT+1
 D KVAR^VADPT
 Q
HEAD ; Header Print
 S ^TMP($J,RETCNT)="HDR2999^Date D/C^LOS^D/C Location^Diagnosis Codes^EOL999"
 S RETCNT=RETCNT+1
 Q
HEAD2 ; Header Print
 S ^TMP($J,RETCNT)="HDR3999^Facility^Station #^Total^EOL999"
 S RETCNT=RETCNT+1
 ;S DA=0  S DA=$O(^XMB(1,DA))
 ;S STDA=$P(^XMB(1,DA,"XUS"),"^",17)
 S STDA=$$GET1^DIQ(4.3,1,217,"I")
 ;S STAT=$P(^DIC(4,STDA,0),"^",1),DIVN=$P(^DIC(4,STDA,99),"^",1)
 S STAT=$$GET1^DIQ(4,STDA_",",.01)
 S DIVN=$$GET1^DIQ(4,STDA_",",99)
 S ^TMP($J,RETCNT)="TOT999^"_STAT_"^"_DIVN_"^"_DISCNT_"^EOL999"
 S RETCNT=RETCNT+1
 Q
CLNUP ;
 K %DT,DISCNT,DIVN,ICN,ICNNM,RETCNT,RETCNTB,SDA,SPNDATE
 K SPNEDAT,SPNIEN,SPNLPRT,SPNQDAT,STAT,STDA,VADM,VAIP,X,Y
 Q
