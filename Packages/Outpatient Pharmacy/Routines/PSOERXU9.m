PSOERXU9 ;ALB/ART - eRx Holding Queue Utilities ;02/02/2021
 ;;7.0;OUTPATIENT PHARMACY;**617**;DEC 1997;Build 110
 ;
 ;There are no APIs defined for the eRx Holding Queue (52.49) and associated files
 ; in the Pharmacy Reengineering (PRE) Application Program Interface (API) Manual
 Q
 ;
ERXIEN(RXIEN) ;Pass through to $$ERXIEN^PSOERXUT
 ; Input: (r) RXIEN - Pointer to either the PENDING ORDERS file (#52.41) (e.g., "139839P") or PRESCRIPTION file (#52) (e.g., 12930984)
 ;Returns:    Pointer to the ERX HOLDING QUEUE file (#52.49) or "" (Not an eRx prescription)
 ;
 I $G(RXIEN)="" Q:""
 Q $$ERXIEN^PSOERXUT(RXIEN)
 ;
CHKERX(ORDERIEN) ;Pass through to $$CHKERX^PSOERXU1
 ;  Input: (r) ORDERIEN - Order (100) file IEN
 ;Returns:     Pointer to the ERX HOLDING QUEUE file (#52.49) or 0 (Not an eRx prescription)
 ;
 I $G(ORDERIEN)="" Q:0
 Q $$CHKERX^PSOERXU1(ORDERIEN)
 ;
ERXPATDFN(ERXIEN) ;Get patient DFN from eRx Holding Queue (52.49)
 ;  Input: (r) ERXIEN - eRx Holding Queue IEN
 ;Returns:     patient DFN from eRx Holding Queue
 ;               or 0, if not found
 ;
 I $G(ERXIEN)="" Q:0
 Q +$$GET1^DIQ(52.49,ERXIEN,.04,"I")
 ;
ERXPATDOB(ERXDFN) ;Get patient DoB from ERX External Patient (52.46)
 ;  Input: (r) ERXDFN - patient DFN from eRx Holding Queue (52.49)
 ;Returns:     patient DoB from ERX External Patient (52.46)
 ;               or null
 ;
 I $G(ERXDFN)="" Q:""
 Q $$FMTE^XLFDT($$GET1^DIQ(52.46,ERXDFN,.08,"I"),"5DZ")
 ;
ERXHUBID(ERXIEN) ;Get ERX HUB ID (.01) from eRx Holding Queue (52.49)
 ;  Input: (r) ERXIEN - eRx Holding Queue IEN
 ;Returns:     ERX HUB ID
 ;               or null
 ;
 I $G(ERXIEN)="" Q:""
 Q $S(ERXIEN:$$GET1^DIQ(52.49,ERXIEN,.01),1:"")
 ;
ERXDATA(ERXDATA,ERXIEN) ;Get eRx Holding Queue Data
 ;Inputs: (r) ERXDATA - reference to return array
 ;        (r) ERXIEN  - Pointer to the ERX HOLDING QUEUE file (#52.49)
 ;Output: Populated ERXDATA array
 ;          ERXDATA(1)=null ^ eRxReceivedDate(FileMan) ^ eRxDrugName ^ VistaDrugIEN ^ CSdrugSchedule ^ eRxQuantity ^ eRxRefill ^ eRxHubID
 ;          ERXDATA(2)=providerDEA# ^ null ^ providerName ^ providerDUZ
 ;          ERXDATA(3)=null ^ provStreet1 ^ provCity ^ provState ^ provZip
 ;          ERXDATA(4)=patientName ^ patientDFN
 ;          ERXDATA(5)=patStreet1 ^ patStreet2 ^ null ^ patCity ^ patState ^ patZip ^ patDOB(MM/DD/YYYY)
 ;
 Q:'$G(ERXIEN)
 Q:'$D(^PS(52.49,ERXIEN,0))
 K ERXDATA
 ;get eRx Holding Queue fields
 N ERXHQ,ERR
 N ERXIENS S ERXIENS=ERXIEN_","
 D GETS^DIQ(52.49,ERXIENS,".01;.03;.04;.05;2.1;2.3;2.5;3.1;3.2;4.9;5.1;5.6","EI","ERXHQ","ERR")
 N HUBID S HUBID=$G(ERXHQ(52.49,ERXIENS,.01,"I")) ;eRx Hub ID
 N RCVDDATE S RCVDDATE=$G(ERXHQ(52.49,ERXIENS,.03,"I")) ;eRx Received Date
 N EXPATIEN S EXPATIEN=$G(ERXHQ(52.49,ERXIENS,.04,"I")) ;eRx External Patient ID
 N EXPATDFN S EXPATDFN=$G(ERXHQ(52.49,ERXIENS,.05,"I")) ;eRx External Patient VistA DFN
 N EXPRVIEN S EXPRVIEN=$G(ERXHQ(52.49,ERXIENS,2.1,"I")) ;eRx External Provider ID
 N EXPRVDUZ S EXPRVDUZ=$G(ERXHQ(52.49,ERXIENS,2.3,"I")) ;eRx External Provider VistA ID
 N EXPHID S EXPHID=$G(ERXHQ(52.49,ERXIENS,2.5,"I")) ;eRx External Pharmacy ID
 N DRUGNAME S DRUGNAME=$G(ERXHQ(52.49,ERXIENS,3.1,"I")) ;eRx Generic name
 N DRUGIEN S DRUGIEN=$G(ERXHQ(52.49,ERXIENS,3.2,"I")) ;eRx Drug IEN
 N EXDEA S EXDEA=$G(ERXHQ(52.49,ERXIENS,4.9,"E")) ;eRx DEA Schedule
 S EXDEA=$S(EXDEA="C48672":1,EXDEA="C48675":2,EXDEA="C48676":3,EXDEA="C48677":4,EXDEA="C48679":5,1:"")
 N ERXQUANT S ERXQUANT=$G(ERXHQ(52.49,ERXIENS,5.1,"E")) ;eRx Quantity
 N ERXREFIL S ERXREFIL=$G(ERXHQ(52.49,ERXIENS,5.6,"E")) ;eRx Refills
 ;get eRx External Pharmacy fields
 N ERXPHARM,ERR
 N EXPHIDS S EXPHIDS=EXPHID_","
 D GETS^DIQ(52.47,EXPHIDS,".01;.04;1.1;1.3;1.4;1.5","EI","ERXPHARM","ERR")
 N PHNAME S PHNAME=$G(ERXPHARM(52.47,EXPHIDS,.01,"E")) ;eRx pharmacy name
 N PHDEA S PHDEA=$G(ERXPHARM(52.47,EXPHIDS,.04,"E")) ;eRx pharmacy dea number
 N PHSTREET S PHSTREET=$G(ERXPHARM(52.47,EXPHIDS,1.1,"E")) ;eRx pharmacy address line 1
 N PHCITY S PHCITY=$G(ERXPHARM(52.47,EXPHIDS,1.3,"E")) ;eRx pharmacy city
 N PHSTATE S PHSTATE=$G(ERXPHARM(52.47,EXPHIDS,1.4,"E")) ;eRx pharmacy state
 N PHZIP S PHZIP=$G(ERXPHARM(52.47,EXPHIDS,1.5,"E")) ;eRx pharmacy zip
 ;get eRx External Provider fields
 N ERXPROV,ERR
 N EXPRVIENS S EXPRVIENS=EXPRVIEN_","
 D GETS^DIQ(52.48,EXPRVIENS,".01;1.6;4.1;4.2;4.3;4.4;4.5","EI","ERXPROV","ERR")
 N PROVNAME S PROVNAME=$G(ERXPROV(52.48,EXPRVIENS,.01,"E")) ;eRx provider name
 N PRVDEANBR S PRVDEANBR=$G(ERXPROV(52.48,EXPRVIENS,1.6,"E")) ;eRx provider dea#
 N PRVSTR1 S PRVSTR1=$G(ERXPROV(52.48,EXPRVIENS,4.1,"E")) ;eRx provider street 1
 N PRVSTR2 S PRVSTR2=$G(ERXPROV(52.48,EXPRVIENS,4.2,"E")) ;eRx provider street 2
 N PRVCITY S PRVCITY=$G(ERXPROV(52.48,EXPRVIENS,4.3,"E")) ;eRx provider city
 N PRVSTATE S PRVSTATE=$G(ERXPROV(52.48,EXPRVIENS,4.4,"E")) ;eRx provider state
 N PRVZIP S PRVZIP=$G(ERXPROV(52.48,EXPRVIENS,4.5,"E")) ;eRx provider zip
 ;get eRx External Patient fields
 N ERXPAT,ERR
 N EXPATIENS S EXPATIENS=EXPATIEN_","
 D GETS^DIQ(52.46,EXPATIENS,".01;.08;1.5;3.1;3.2;3.3;3.4;3.5","EI","ERXPAT","ERR")
 N PATNAME S PATNAME=$G(ERXPAT(52.46,EXPATIENS,.01,"E")) ;eRx patient name
 N PATDOB S PATDOB=$G(ERXPAT(52.46,EXPATIENS,.08,"I")) ;eRx patient DoB
 N PATDFN S PATDFN=$G(ERXPAT(52.46,EXPATIENS,1.5,"E")) ;eRx patient dfn
 N PATSTR1 S PATSTR1=$G(ERXPAT(52.46,EXPATIENS,3.1,"E")) ;eRx street 1
 N PATSTR2 S PATSTR2=$G(ERXPAT(52.46,EXPATIENS,3.2,"E")) ;eRx street 2
 N PATCITY S PATCITY=$G(ERXPAT(52.46,EXPATIENS,3.3,"E")) ;eRx city
 N PATSTATE S PATSTATE=$G(ERXPAT(52.46,EXPATIENS,3.4,"E")) ;eRx state
 N PATZIP S PATZIP=$G(ERXPAT(52.46,EXPATIENS,3.5,"E")) ;eRx zip
 ;
 S ERXDATA(1)=U_RCVDDATE_U_DRUGNAME_U_DRUGIEN_U_EXDEA_U_ERXQUANT_U_ERXREFIL_U_HUBID
 S ERXDATA(2)=PRVDEANBR_U_U_PROVNAME_U_EXPRVDUZ
 S ERXDATA(3)=U_PRVSTR1_U_PRVCITY_U_PRVSTATE_U_PRVZIP
 S ERXDATA(4)=PATNAME_U_EXPATDFN
 S ERXDATA(5)=PATSTR1_U_PATSTR2_U_""_U_PATCITY_U_PATSTATE_U_PATZIP_U_$$FMTE^XLFDT(PATDOB,"5DZ")
 ;
 Q
