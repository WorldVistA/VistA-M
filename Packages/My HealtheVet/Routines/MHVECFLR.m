MHVECFLR ;KUM - myHealtheVet File Workload ; 6/18/2013
 ;;1.0;My HealtheVet;**11**;June 18, 2013;Build 61
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 Q
 ;
 ;  Integration Agreements:
 ;
 ;                6012 : Event Capture API $$FILE^ECFLRPC
 ;                6013 : ^ECD(D0
 ;                1894 : PCE API $$GETENC^PXAPI
 ;               10004 : $$GET1^DIQ
 ;               10104 : $$REPLACE^XLFSTR
 ;                2701 : $$GETDFN^MPIF001
 ;
 ;
FILE(RESULT,ECSTRING) ;Start filing data into #721
 ;FILE^LOCATION^DSS UNIT^CATEGORY^PROCEDURE DATE TIME^PROCEDURE^PATIENT IEN^ORDERING SECTION^ENTER BY^PAT STATUS^PROVIDER^DX^
 ;ASSOC CLINIC^PATIENT STATUS AND CLASSIFICATION DATA^ELIGIBILITY IEN
 ;
 N MHVDXSTR,MHVCLSTR,DFN,ENCDT,HLOC,MHVVIEN,MHVWLI,ECUA,MHVERR,MHVECX,MHVQUIT,MHVSECS,MHVPDT,MHVVID,MHVSPEC
 ;
 S ECARY("ECFILE")=$P(ECSTRING,"^",1)
 S ECARY("ECL")=$P(ECSTRING,"^",2)     ; Location, Pointer to #4   
 S ECARY("ECD")=$P(ECSTRING,"^",3)     ; DSS Unit, Pointer to #724
 S ECARY("ECC")=$P(ECSTRING,"^",4)     ; Category, Pointer to #726
 ; 
 S MHVPDT=$P(ECSTRING,"^",5)
 S MHVPDT=$E(MHVPDT,1,4)_$E(MHVPDT,6,7)_$E(MHVPDT,9,10)_"@"_$E(MHVPDT,12,13)_$E(MHVPDT,15,16)
 S X=MHVPDT
 S %DT="TS"
 D ^%DT
 S MHVPDT=Y
 S ECARY("ECDT")=MHVPDT                ; Date and Time of Procedure 
 S ECARY("ECP")=$P(ECSTRING,"^",6)     ; Procedure
 ;
 ; Get Patient IEN from Patient ICN
 S MHVPICN=+$P(ECSTRING,"^",7)
 I $G(MHVPICN)'>0 S RESULT(1)="0^No Patient ICN" Q
 S MHVPIEN=$$GETDFN^MPIF001(MHVPICN)
 I $P(MHVPIEN,"^",1)=-1 S RESULT(1)="0^Patient ICN not in Database" Q
 S ECARY("ECDFN")=MHVPIEN              ; Patient IEN for file #2    
 ; 
 ; DO - Retrieve Ordering Section from DSS Unit
 ;
 S ECARY("ECMN")=$P(ECSTRING,"^",8)    ; Ordering Section, Pointer to #723
 S ECARY("ECMN")=$$GET1^DIQ(724,ECARY("ECD"),2,"I")
 S ECARY("ECDUZ")=$P(ECSTRING,"^",9)   ; Entered/Edited by, pointer to #200
 S ECARY("ECPTSTAT")=$P(ECSTRING,"^",10) ; Patient Status
 ;
 ; Loading List of Providers
 ;
 S ECUA=$P(ECSTRING,"^",11)            ; Primary and Secondary Providers
 S MHVERR=0
 F MHVECX=1:1 Q:MHVERR  D
 . I $P(ECUA,";",MHVECX)="" S MHVERR=1 Q
 . S ECARY("ECU"_MHVECX)=$P(ECUA,";",MHVECX)
 ;
 ; Loading List of Diagnosis Codes
 ;
 S ECARY("ECDX")=$S($F($P(ECSTRING,"^",12),";"):$P($P(ECSTRING,"^",12),";",1),1:$P(ECSTRING,"^",12))  ; Primary Diagnosis
 S MHVDXSTR=$P(ECSTRING,"^",12)
 I $F(MHVDXSTR,";")  D
 . S MHVDXSTR=$E(MHVDXSTR,$F(MHVDXSTR,";"),$L(MHVDXSTR))
 . S MHVSPEC(";")="^"
 . S ECARY("ECDXS")=$$REPLACE^XLFSTR(MHVDXSTR,.MHVSPEC)  ; Secondary Diagnosis codes
 ;
 ; Additional Fields 
 ;
 S ECARY("EC4")=$P(ECSTRING,"^",13)               ; Associated Clinic - Pointer to #44 
 ; 
 ; Load Patient Eligibility and Patient Classification data
 ;
 S MHVCLSTR=$P(ECSTRING,"^",14)
 S ECARY("ECELIG")=$S($F(MHVCLSTR,";"):$P(MHVCLSTR,";",1),1:MHVCLSTR)  ; Patient Eligibility
 I $F(MHVCLSTR,";")  D
 . S MHVCLSTR=$E(MHVCLSTR,$F(MHVCLSTR,";"),$L(MHVCLSTR))
 . S MHVSPEC(";")="^"
 . S ECARY("ECLASS")=$$REPLACE^XLFSTR(MHVCLSTR,.MHVSPEC)  ; Patient Classification data
 D FILE^ECFLRPC(.RESULT,.ECARY)
 ;
 ; Retrieve Visit IEN - 5 Seconds Loop till you get Visit IEN
 ;
 S MHVBTIM=$H
 S ENCDT=MHVPDT
 S HLOC=$P(ECSTRING,"^",13)
 S MHVVIEN=0
 S MHVSECS=0
 S MHVQUIT=0
 F MHVECX=1:1 Q:MHVQUIT  D
 . S MHVVIEN=$$GETENC^PXAPI(MHVPIEN,ENCDT,HLOC)
 . I MHVVIEN<=0  D
 . . S MHVETIM=$H
 . . S MHVBTIM(1)=$P(MHVBTIM,",",1),MHVBTIM(2)=$P(MHVBTIM,",",2),MHVETIM(1)=$P(MHVETIM,",",1),MHVETIM(2)=$P(MHVETIM,",",2)
 . . I MHVBTIM(1)=MHVETIM(1) S MHVSECS=MHVETIM(2)-MHVBTIM(2) Q
 . . S MHVSECS=86400*(MHVETIM(1)-MHVBTIM(1))+(MHVETIM(2)-MHVBTIM(2)) Q
 . I ((MHVVIEN>0)!(MHVSECS>=5)) S MHVQUIT=1
 ;
 ; Return IEN of workload
 ;
 S MHVWLI=0
 S MHVWLI=$O(^ECH("APAT",MHVPIEN,MHVPDT,MHVWLI))
 ;
 S RESULT1=""
 S SUB="" F  S SUB=$O(^TMP($J,"ECMSG",SUB)) Q:SUB=""  D
 . S RESULT1=RESULT1_" SUBSCRIPT "_$G(SUB)_":"_$G(^TMP($J,"ECMSG",SUB))
 S RESULT=$G(^TMP($J,"ECMSG",1))
 ;
 ; Populate Workload IEN and Visit IEN
 ;
 I $L(RESULT,"^")=2 S RESULT=RESULT_"^"
 I $G(MHVVIEN)<=0 S MHVVIEN=""
 ;I $G(MHVVIEN)>0 S MHVVID=$$GET1^DIQ(9000010,MHVVIEN,15001)
 S RESULT(1)=RESULT_"^"_$G(MHVWLI)_"^"_$G(MHVVIEN)
 Q
