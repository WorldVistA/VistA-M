SPNJRPCD ;BP/JAS - Returns Discharge to Community info ;Dec 14, 2009
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; References to file 45 supported by IA# 92
 ; References to ^DGPT supported by IA# 4945
 ; Reference to ^DIC(4 supported by IA# 10090
 ; References to ^DIC(45.6 supported by IA# 4018
 ; References to ^DIC(45.1 supported by IA# 4944
 ; Reference to API $$IEN^XUAF4 is supported by IA# 2171
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
 S RETURN=$NA(^TMP($J)),RETCNT=1
 S X=FDATE S %DT="T" D ^%DT S SPNSTRT=Y
 S X=TDATE S %DT="T" D ^%DT S SPNEND=Y_.2359
 S SRCLIST="1A^1B^1C^1J^1K^1M^1P^1R^1S^1T^2A^2B^2C^3A^3B^3C^3D^3E^4A^4B^4M^4N^4P^4Q^4R^4S^4T^4U^4W^4Y^5A^5B^5G^6A^6D^7B"
 ;***************************
 K ^TMP($J),^TMP("SPN",$J),CARRY
 F ICNNM=1:1:$L(ICNLST,"^") S ICN=$P(ICNLST,"^",ICNNM) D IN
 D OUT,CLNUP
 Q
IN Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 Q:'$D(^DGPT("B",DFN))
 ;JAS - 05/15/08 - DEFECT 1090
 ;S PDA=""
 S PDA=0
 F  S PDA=$O(^DGPT("B",DFN,PDA)) Q:PDA=""  D
 . Q:'$D(^DGPT(PDA,0))
 . S PREC0=^DGPT(PDA,0)
 . S DIVN=$P(PREC0,"^",3)
 . Q:DIVN=""
 . ;JAS - DEFECT 1180 - Retrieve Station Name by Institution ien instead of Station Number
 . S DIEN=$$IEN^XUAF4(DIVN)
 . ;S STAT=$$GET1^DIQ(4,DIVN_",",.01)
 . S STAT=$$GET1^DIQ(4,DIEN_",",.01)
 . I $D(^TMP("SPN","AD",STAT)) S ^TMP("SPN","AD",STAT)=^TMP("SPN","AD",STAT)+1
 . E  S ^TMP("SPN","AD",STAT)=1
 . S DISDAT=$$GET1^DIQ(45,PDA_",",70,"I")\1
 . Q:DISDAT=""
 . Q:DISDAT<SPNSTRT!(DISDAT>SPNEND)
 . I $D(^TMP("SPN","DIS",STAT)) S ^TMP("SPN","DIS",STAT)=^TMP("SPN","DIS",STAT)+1
 . E  S ^TMP("SPN","DIS",STAT)=1
 . D DEM^VADPT
 . S ADDTM=$$GET1^DIQ(45,PDA_",",2,"I")\1
 . S ADDT=$$FMTE^XLFDT(ADDTM,"5DZP")
 . S DISDAT=$$FMTE^XLFDT(DISDAT,"5DZP")
 . S PREC70=^DGPT(PDA,70)
 . S SPEC=$$GET1^DIQ(45,PDA_",",71)
 . S DCCD=$$GET1^DIQ(45,PDA_",",72,"I")
 . S DCTYP=$$GET1^DIQ(45,PDA_",",72)
 . S DESP=$P(PREC70,"^",6) I DESP'="" D
 . . S DEST=$P($G(^DIC(45.6,DESP,0)),"^",1)
 . . S DESCD=$P($G(^DIC(45.6,DESP,0)),"^",2)
 . S SRCE=$P($G(^DGPT(PDA,101)),"^",1) I SRCE'="" D
 . . S ADCODE=$P($G(^DIC(45.1,SRCE,0)),"^",1)
 . . S ADSRCE=$P($G(^DIC(45.1,SRCE,0)),"^",2)
 . I $D(DCCD),$D(ADCODE),DCCD=1!(DCCD=2)!(DCCD=3)!(DCCD=5)&(SRCLIST[ADCODE) D
 . . I $D(^TMP("SPN",$J,"DENOM",STAT,DIVN)) S ^TMP("SPN",$J,"DENOM",STAT,DIVN)=^TMP("SPN",$J,"DENOM",STAT,DIVN)+1
 . . E  S ^TMP("SPN",$J,"DENOM",STAT,DIVN)=1
 . . I $D(DESCD),DESCD="X"!(DESCD="F")!(DESCD="G")!(DESCD="H")!(DESCD="K")!(DESCD="P")!(DESCD="U")!(DESCD="T")!(DESCD="M")!(DESCD="Y")!(DESCD="Z") D
 . . . I $D(^TMP("SPN",$J,"NUMER",STAT,DIVN)) S ^TMP("SPN",$J,"NUMER",STAT,DIVN)=^TMP("SPN",$J,"NUMER",STAT,DIVN)+1
 . . . E  S ^TMP("SPN",$J,"NUMER",STAT,DIVN)=1
 . Q:STAT=""!(DIVN="")!(VADM(1)="")!(VA("PID")="")!(ADDTM="")!(PDA="")
 . S ^TMP("SPN",$J,"DETAIL",STAT,DIVN,VADM(1),VA("PID"),ADDTM,PDA)=STAT_"^"_DIVN_"^"_VADM(1)_"^"_VA("PID")_"^"_$G(ADDT)_"^"_$G(DISDAT)_"^"_$G(SPEC)_"^"_$G(ADSRCE)_"^"_$G(ADCODE)_"^"_$G(DCTYP)_"^"_$G(DCCD)_"^"_$G(DEST)_"^"_$G(DESCD)
 . K ADDT,DISDAT,SPEC,ADSRCE,ADCODE,DCTYP,DCCD,DEST,DESCD
 Q
OUT ;
 S ^TMP($J,RETCNT)="HDR999^Facility Name^Division #^Veteran^SSN^Admission Date^Discharge Date^Treating Specialty^Admission Source^Admit Code^Discharge Type^DC Code^Destination^Destination Code^EOL999"
 S RETCNT=RETCNT+1
 S STAT=""
 F  S STAT=$O(^TMP("SPN",$J,"DETAIL",STAT)) Q:STAT=""  D
 . S DIVN=""
 . F  S DIVN=$O(^TMP("SPN",$J,"DETAIL",STAT,DIVN)) Q:DIVN=""  D
 . . S NAM=""
 . . F  S NAM=$O(^TMP("SPN",$J,"DETAIL",STAT,DIVN,NAM)) Q:NAM=""  D
 . . . S SSN=""
 . . . F  S SSN=$O(^TMP("SPN",$J,"DETAIL",STAT,DIVN,NAM,SSN)) Q:SSN=""  D
 . . . . S ADDTM=""
 . . . . F  S ADDTM=$O(^TMP("SPN",$J,"DETAIL",STAT,DIVN,NAM,SSN,ADDTM)) Q:ADDTM=""  D
 . . . . . S PDA=""
 . . . . . F  S PDA=$O(^TMP("SPN",$J,"DETAIL",STAT,DIVN,NAM,SSN,ADDTM,PDA)) Q:PDA=""  D
 . . . . . . S ^TMP($J,RETCNT)=^TMP("SPN",$J,"DETAIL",STAT,DIVN,NAM,SSN,ADDTM,PDA)_"^EOL999"
 . . . . . . S RETCNT=RETCNT+1
 . . S NUMER=$G(^TMP("SPN",$J,"NUMER",STAT,DIVN))
 . . S DENOM=$G(^TMP("SPN",$J,"DENOM",STAT,DIVN))
 . . I 'NUMER S CDRATE="0.00"
 . . E  S CDRATE=(NUMER/DENOM)*100
 . . S ^TMP($J,RETCNT)="TOT999^Community Discharge Rate^"_$J(CDRATE,".",2)_"^EOL999"
 . . S RETCNT=RETCNT+1
 Q
CLNUP ;
 K %DT,ADDTM,CDRATE,DENOM,DESP,DFN,DIVN,ICN,ICNNM,NAM,NUMER,PDA,PREC0
 K PREC70,RETCNT,SPNEND,SPNSTRT,SRCE,SRCLIST,SSN,STAT,VA,VADM,X,Y,DIEN
 Q
