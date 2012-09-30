DVBARSBD ;ALB/RPM - CAPRI 2507 REQUEST STATUS BY DT RANGE REPORT ; 01/24/12
 ;;2.7;AMIE;**179**;Apr 10, 1995;Build 15
 ;
 Q  ;NO DIRECT ENTRY
 ;
REQSTAT(DVBSDAT,DVBEDAT,DVBRSTAT,DVBDELIM,DVBNODT) ;entry for request status by dt range
 ;
 ;  Input:
 ;    DVBSDAT - start date (FM format)
 ;    DVBEDAT - end date (FM format)
 ;    DVBRSTAT - request status (internal format)
 ;    DVBDELIM - return delimited results (0=no;1=yes)
 ;    DVBNODT - ignore date range (0=no;1=yes)
 ;
 N EXSTAT  ;request status (external format)
 N EXSDAT  ;start date (external format: MM/DD/YYYY)
 N EXEDAT  ;end date (external format: MM/DD/YYYY)
 N DVBARS  ;request status conversion results
 N DVBERR  ;FM error msg
 N DVBCNT   ;returned record count
 ;
 K ^TMP("DVBREQ",$J)
 K ^TMP("DVBREQN",$J)
 S EXSDAT=$$FMTE^XLFDT(DVBSDAT,"5DZ")
 S EXEDAT=$$FMTE^XLFDT(DVBEDAT,"5DZ")
 I DVBRSTAT="A" S EXSTAT="ALL"
 E  D
 . D CHK^DIE(396.3,17,"E",DVBRSTAT,.DVBARS,"DVBERR")
 . S EXSTAT=$G(DVBARS(0))
 S DVBCNT=0
 ;
 ;collect records matching search criteria
 I DVBNODT D
 . S EXSDAT="NO START DATE"
 . S EXEDAT="NO END DATE"
 . D GETRECSN(DVBRSTAT,.DVBCNT)
 E  D
 . D GETRECS(DVBSDAT,DVBEDAT,DVBRSTAT,.DVBCNT)
 ;
 ;output results
 I 'DVBCNT D
 . W "NO DATA FOUND"
 E  D
 . I DVBDELIM D DELIMHDR(EXSDAT,EXEDAT,EXSTAT),DELIM  ;delimited format
 . I 'DVBDELIM D PLAINHDR(EXSDAT,EXEDAT,EXSTAT),PLAIN  ;plain text format
 K ^TMP("DVBREQ",$J)
 K ^TMP("DVBREQN",$J)
 Q
 ;
GETRECS(SDAT,EDAT,RSTAT,CNT) ;collect 2507 REQUEST record matches
 ;This procedure collects all 2507 REQUEST records that have a
 ;DATE STATUS LAST CHANGED within the start and end dates and have
 ;a REQUEST STATUS that matches the input request status parameter.
 ;
 ;  Input:
 ;    SDAT - start date (FM format)
 ;    EDAT - end date (FM format)
 ;    RSTAT - request status (internal format)
 ;    CNT - record count (passed by reference)
 ;
 N CHGDAT  ;change date
 N DVBIEN  ;2507 REQUEST IEN
 N DVBSTAT  ;2507 REQUEST STATUS
 N FLD  ;field array in external format
 ;
 S CHGDAT=SDAT-1
 F  S CHGDAT=$O(^DVB(396.3,"AH",CHGDAT)) Q:'CHGDAT!(CHGDAT>EDAT)  D
 . S DVBIEN=0
 . F  S DVBIEN=$O(^DVB(396.3,"AH",CHGDAT,DVBIEN)) Q:'DVBIEN  D
 . . S DVBSTAT=$$GET1^DIQ(396.3,DVBIEN_",",17,"I","","")
 . . I RSTAT="A"!(DVBSTAT=RSTAT) D
 . . . K FLD
 . . . I $$SETFLDS(DVBIEN,.FLD) D
 . . . . S CNT=CNT+1
 . . . . S ^TMP("DVBREQ",$J,CNT)=FLD("SS")_U_FLD("NM")_U_FLD("REQDT")_U_FLD("RELDT")_U_FLD("PRTDT")_U_FLD("RS")_U_FLD("CANDT")_U_FLD("RO")
 Q
 ;
SETFLDS(DVBIEN,DVBFLDS) ;build field array in external format
 ;This function formats the collected record data in external format
 ;and returns the results TRUE and an array on success.  Otherwise,
 ;the function returns FALSE.
 ;
 ;  Integration Reference #10061 - DEM^VADPT
 ;
 ;  Input:
 ;    DVBIEN - 2507 REQUEST IEN
 ;    DVBFLDS - field array passed by reference
 ;
 ;  Output:
 ;    DVBFLDS("NM") - patient name
 ;    DVBFLDS("SS") - social security number
 ;    DVBFLDS("RS") - request status
 ;    DVBFLDS("REQDT") - request date
 ;    DVBFLDS("RELDT") - release date
 ;    DVBFLDS("PRTDT") - print date
 ;    DVBFLDS("CANDT") - canceled date
 ;    DVBFLDS("RO") - regional office
 ;    DVBFLDS("IREQDT") - request date in internal FM format
 ;    Function Result - return 1 on success; otherwise returns 0
 ;
 N DFN  ;PATIENT file IEN used in VADPT call
 N DVBDAT  ;2507 REQUEST data field array
 N DVBIENS  ;FM IENS value
 N DVBRSLT  ;function result
 N VADM  ;VADPT return array
 ;
 S DVBRSLT=0
 S DVBIENS=+$G(DVBIEN)_","
 D GETS^DIQ(396.3,DVBIENS,".01;1;2;13;15;17;19","IE","DVBDAT","")
 S DFN=$G(DVBDAT(396.3,DVBIENS,.01,"I"))
 D DEM^VADPT
 I $G(VADM(1))'="" D  ;only return record when name is resolved
 . S DVBFLDS("NM")=$G(VADM(1))
 . S DVBFLDS("SS")=+$G(VADM(2))
 . S DVBFLDS("RS")=$G(DVBDAT(396.3,DVBIENS,17,"E"))
 . S DVBFLDS("REQDT")=$$FMTE^XLFDT($G(DVBDAT(396.3,DVBIENS,1,"I")),"5DZ")
 . S DVBFLDS("RELDT")=$$FMTE^XLFDT($G(DVBDAT(396.3,DVBIENS,13,"I")),"5DZ")
 . S DVBFLDS("PRTDT")=$$FMTE^XLFDT($G(DVBDAT(396.3,DVBIENS,15,"I")),"5DZ")
 . S DVBFLDS("CANDT")=$$FMTE^XLFDT($G(DVBDAT(396.3,DVBIENS,19,"I")),"5DZ")
 . S DVBFLDS("RO")=$G(DVBDAT(396.3,DVBIENS,2,"E"))
 . S DVBFLDS("IREQDT")=$G(DVBDAT(396.3,DVBIENS,1,"I"))
 . S DVBRSLT=1
 Q DVBRSLT
 ;
DELIMHDR(EXSDAT,EXEDAT,EXSTAT) ;output delimited format header
 ;
 ;  Input:
 ;    EXSDAT - start date (external format)
 ;    EXEDAT - end date (external format)
 ;    EXSTAT - request status (external format)
 ;
 W "Request Status by Date Range Report"
 W !,"Date Range: "_EXSDAT_" - "_EXEDAT
 W !,"Request Status: ",EXSTAT
 W !
 W !,"SSN^PatientName^RequestDT^DTReleased^DTPrinted^RequestStatus^DtCanceled^Station"
 Q
 ;
DELIM ;output delimited format
 ;
 N DVBI
 S DVBI=0
 F  S DVBI=$O(^TMP("DVBREQ",$J,DVBI)) Q:'DVBI  D
 . W !,^TMP("DVBREQ",$J,DVBI)
 Q
 ;
PLAINHDR(EXSDAT,EXEDAT,EXSTAT)  ;output plain text header
 ;Populate the header information.
 ;CAUTION:  The CAPRI GUI pulls this information to populate the header
 ;for each page when creating a printed report.  Do not modify the
 ;content or line count of the header information without validating
 ;against the CAPRI GUI interface.
 ;
 ;CAPRI GUI to populate 
 ;  Input:
 ;    EXSDAT - start date (external format)
 ;    EXEDAT - end date (external format)
 ;    EXSTAT - request status (external format)
 ;
 N DVBLINE  ;header separator
 ;
 S $P(DVBLINE,"-",131)=""
 W "Date Range: "_EXSDAT_" - "_EXEDAT
 W !,"Request Status: ",EXSTAT
 W !
 W !,"SSN",?11,"PATIENT NAME",?33,"REQUEST DT",?45,"DT RELEASED"
 W ?57,"DT PRINTED",?69,"STATUS",?98,"DT CANCELED",?110,"STATION"
 W !,DVBLINE
 Q
 ;
PLAIN ;output plain text format
 ;Output formatted text format.  The patient name and station name
 ;are truncated at 20 characters to maintain 132 character report.
 ;
 N DVBI     ;generic counter
 N DVBREQ   ;request record
 ;
 S DVBI=0
 F  S DVBI=$O(^TMP("DVBREQ",$J,DVBI)) Q:'DVBI  D
 . S DVBREQ=^TMP("DVBREQ",$J,DVBI)
 . W !,$P(DVBREQ,U,1),?11,$E($P(DVBREQ,U,2),1,20),?33,$P(DVBREQ,U,3)
 . W ?45,$P(DVBREQ,U,4),?57,$P(DVBREQ,U,5),?69,$P(DVBREQ,U,6)
 . W ?98,$P(DVBREQ,U,7),?110,$E($P(DVBREQ,U,8),1,20)
 Q
 ;
GETRECSN(RSTAT,CNT) ;collect 2507 REQUEST status matches and ignore date range
 ;This procedure collects all 2507 REQUEST records that have a REQUEST STATUS
 ;that matches the input request status parameter regardless of the LAST
 ;STATUS CHANGE DATE range.  The procedure uses the "AF" index which sorts
 ;by REQUEST STATUS and REGIONAL OFFICE.
 ;
 ;  Input:
 ;    RSTAT - request status (internal format)
 ;    CNT - record count (passed by reference)
 ;
 N CHGDAT  ;change date
 N SRTDAT  ;sort date
 N DVBIEN  ;2507 REQUEST IEN
 N FLD  ;field array in external format
 N DVBRO   ;regional office
 ;
 ;create list sorted by LAST STATUS CHANGE DATE
 S DVBRO=0
 F  S DVBRO=$O(^DVB(396.3,"AF",RSTAT,DVBRO)) Q:'DVBRO  D
 . S DVBIEN=0
 . F  S DVBIEN=$O(^DVB(396.3,"AF",RSTAT,DVBRO,DVBIEN)) Q:'DVBIEN  D
 . . K FLD
 . . I $$SETFLDS(DVBIEN,.FLD) D
 . . . ;use request date as sort for blank date
 . . . S SRTDAT=+$G(FLD("IREQDT"))
 . . . S ^TMP("DVBREQN",$J,SRTDAT,DVBIEN)=FLD("SS")_U_FLD("NM")_U_FLD("REQDT")_U_FLD("RELDT")_U_FLD("PRTDT")_U_FLD("RS")_U_FLD("CANDT")_U_FLD("RO")
 ;
 ;load output global with sorted list
 S CHGDAT=""  ;use "" because value could be zero ("0")
 F  S CHGDAT=$O(^TMP("DVBREQN",$J,CHGDAT)) Q:(CHGDAT="")  D
 . S DVBIEN=0
 . F  S DVBIEN=$O(^TMP("DVBREQN",$J,CHGDAT,DVBIEN)) Q:'DVBIEN  D
 . . S CNT=CNT+1
 . . S ^TMP("DVBREQ",$J,CNT)=^TMP("DVBREQN",$J,CHGDAT,DVBIEN)
 Q
