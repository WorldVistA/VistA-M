DVBARSBD ;ALB/RPM - CAPRI 2507 REQUEST STATUS BY DT RANGE REPORT ; 01/24/12
 ;;2.7;AMIE;**179,185,189,190**;Apr 10, 1995;Build 24
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
 K ^TMP("DVBREQ",$J),^TMP("DVBREQN",$J)
 S EXSDAT=$$FMTE^XLFDT(DVBSDAT,"5DZ")
 S EXEDAT=$$FMTE^XLFDT(DVBEDAT,"5DZ")
 I DVBRSTAT="A" S EXSTAT="ALL"
 E  D
 . D CHK^DIE(396.3,17,"E",DVBRSTAT,.DVBARS,"DVBERR")
 . S EXSTAT=$G(DVBARS(0))
 S DVBCNT=1
 S DVBAD=$S(DVBDELIM=1:",",1:0)
 ;
 ;collect records matching search criteria
 I DVBNODT D
 . S EXSDAT="NO START DATE"
 . S EXEDAT="NO END DATE"
 . I DVBDELIM D DELIMHDR(EXSDAT,EXEDAT,EXSTAT)
 . D GETRECSN(DVBRSTAT,.DVBCNT)
 E  D
 . I DVBDELIM D DELIMHDR(EXSDAT,EXEDAT,EXSTAT)
 . D GETRECS(DVBSDAT,DVBEDAT,DVBRSTAT,.DVBCNT)
 ;
 ;output results
 I 'DVBCNT D
 . W "NO DATA FOUND"
 E  D
 . I 'DVBDELIM D PLAINHDR(EXSDAT,EXEDAT,EXSTAT),PLAIN  ;plain text format
 . I DVBDELIM D DELIM  ;comma delimited format
 ;
END ;Clean up local variables
 K DIWF,DIWL,DIWR,DVBAD,DVBAX,DVBAY,DVBCNRS,DVBEXAM,DVBIEN4,DVBI2,DVBX,DVBXCNT,LINE,X
 K ^TMP("DVBREQ"),^TMP("DVBREQH")
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
 N DVBSTAT ;2507 REQUEST STATUS
 N FLD     ;field array in external format
 ;
 S CHGDAT=SDAT-1
 S DVBIEN=0,CNT=0 F  S CHGDAT=$O(^DVB(396.3,"AH",CHGDAT)) Q:'CHGDAT!(CHGDAT>EDAT)  D
 . F  S DVBIEN=$O(^DVB(396.3,"AH",CHGDAT,DVBIEN)) Q:'DVBIEN  D
 . . S DVBSTAT=$$GET1^DIQ(396.3,DVBIEN_",",17,"I","","")
 . . I RSTAT="A"!(DVBSTAT=RSTAT) D
 . . . K FLD
 . . . I $$SETFLDS(DVBIEN,.FLD) D
 . . . . S CNT=CNT+1,DVBXCNT=1
 . . . . I $G(DVBAD)'="," S ^TMP("DVBREQ",$J,CNT)=FLD("IEN")_U_FLD("SS")_U_FLD("NM")_U_FLD("REQDT")_U_FLD("RELDT")_U_FLD("PRTDT")_U_FLD("RS")_U_FLD("CANDT")_U_FLD("RO")_U_FLD("CANRS",DVBXCNT)_U_FLD("CANCOM",DVBXCNT)_U_FLD("EXAM",DVBXCNT) D
 . . . . . S DVBXCNT=DVBXCNT+1 Q
 . . . . I $G(DVBAD)="," D
 . . . . . S ^TMP("DVBREQ",$J,CNT)=FLD("SS")_DVBAD_""""_FLD("NM")_""""_DVBAD_FLD("REQDT")_DVBAD_FLD("RELDT")_DVBAD_FLD("PRTDT")_DVBAD
 . . . . . S ^TMP("DVBREQ",$J,CNT)=^TMP("DVBREQ",$J,CNT)_""""_FLD("RS")_""""_DVBAD_FLD("CANDT")_DVBAD_""""_FLD("RO")_""""_DVBAD
 . . . . . S DVBX=0 F  S DVBX=$O(FLD("IEN4",DVBX)) Q:'DVBX  D
 . . . . . . S ^TMP("DVBREQ",$J,CNT,DVBX)=^TMP("DVBREQ",$J,CNT)_$C(13)_FLD("SS")_DVBAD_DVBAD_DVBAD_DVBAD_DVBAD_DVBAD_DVBAD_DVBAD_""""_FLD("EXAM",DVBXCNT)_""""_DVBAD_""""_FLD("CANRS",DVBXCNT)_""""_DVBAD_""""_FLD("CANCOM",DVBXCNT)_""""_$C(13)
 . . . . . . S DVBXCNT=DVBXCNT+1
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
 ;    DVBFLDS("IEN") - 2507 REQUEST IEN
 ;    DVBFLDS("NM") - patient name
 ;    DVBFLDS("SS") - social security number
 ;    DVBFLDS("RS") - request status
 ;    DVBFLDS("REQDT") - request date
 ;    DVBFLDS("RELDT") - release date
 ;    DVBFLDS("PRTDT") - print date
 ;    DVBFLDS("CANDT") - canceled date
 ;    DVBFLDS("RO") - regional office
 ;    DVBFLDS("IREQDT") - request date in internal FM format
 ;    DVBFLDS("EXAM") - added with patch DVB*2.7*189; HOLDS THE 2507 EXAM name   
 ;    DVBFLDS("CANRS") - added with patch DVB*2.7*189; HOLDS THE 2507 EXAM CANCELLATION REASON name
 ;    DVBFLDS("CANCOM") - added with patch DVB*2.7*189; HOLDS THE 2507 EXAM CANCELLATION COMMENTS name
 ;    Function Result - return 1 on success; otherwise returns 0
 ;
 N DFN  ;PATIENT file IEN used in VADPT call
 N DVBDAT  ;2507 REQUEST data field array
 N DVBIENS  ;FM IENS value
 N DVBRSLT  ;function result
 N VADM  ;VADPT return array
 N DVBIEN4 ;the IEN FROM 2507 EXAM FILE 396.4
 N DVBALAST ;number of lines in the wp cancellation comments
 N DVBAI  ;for loop index
 N DVBAX ;
 ;
 S DVBRSLT=0
 S DVBIENS=+$G(DVBIEN)_","
 D GETS^DIQ(396.3,DVBIENS,".01;1;2;13;15;17;19","IE","DVBDAT","")
 S DFN=$G(DVBDAT(396.3,DVBIENS,.01,"I"))
 D DEM^VADPT
 I $G(VADM(1))'="" D  ;only return record when name is resolved
 . S DVBFLDS("IEN")=DVBIEN
 . S DVBFLDS("NM")=$G(VADM(1))
 . S DVBFLDS("SS")=$S(DVBDELIM:$P($G(VADM(2)),U,2),1:$P($G(VADM(2)),U,1))
 . S DVBFLDS("RS")=$G(DVBDAT(396.3,DVBIENS,17,"E"))
 . S DVBFLDS("REQDT")=$$FMTE^XLFDT($G(DVBDAT(396.3,DVBIENS,1,"I")),"5DZ")
 . S DVBFLDS("RELDT")=$$FMTE^XLFDT($G(DVBDAT(396.3,DVBIENS,13,"I")),"5DZ")
 . S DVBFLDS("PRTDT")=$$FMTE^XLFDT($G(DVBDAT(396.3,DVBIENS,15,"I")),"5DZ")
 . S DVBFLDS("CANDT")=$$FMTE^XLFDT($G(DVBDAT(396.3,DVBIENS,19,"I")),"5DZ")
 . S DVBFLDS("RO")=$G(DVBDAT(396.3,DVBIENS,2,"E"))
 . S DVBXCNT=1
 . S (DVBFLDS("EXAM",DVBXCNT),DVBFLDS("CANRS",DVBXCNT),DVBFLDS("CANCOM",DVBXCNT),DVBFLDS("IEN4"))=""
 . S DVBIEN4=0 F  S DVBIEN4=$O(^DVB(396.4,"C",DVBIEN,DVBIEN4)) Q:'DVBIEN4  D
 . . I $D(^DVB(396.4,DVBIEN4,"CAN")) D
 . . . S DVBAY=($P($P(^DVB(396.4,DVBIEN4,"CAN"),"^",1),".",1)) I DVBAY>(DVBSDAT-1)&DVBAY<(DVBEDAT+1) D
 . . . . S DVBFLDS("EXAM",DVBXCNT)=$$GET1^DIQ(396.4,DVBIEN4,.03),DVBFLDS("CANRS",DVBXCNT)=$$GET1^DIQ(396.4,DVBIEN4,52)
 . . . . I $D(^DVB(396.4,DVBIEN4,5)) D
 . . . . . S DVBFLDS("IEN4",DVBXCNT)=DVBIEN4
 . . . . . K WP S DVBAX=$$GET1^DIQ(396.4,DVBIEN4,53,"Z","WP") ; this puts the wordprocessing field into an array 'WP(#,0)=' next it gets put into one entry of the DVBFLDS ARRAY so we can handle any comma's that aren't delimiters
 . . . . . ;DVBALAST gets the number of WP lines to loop through in the for loop
 . . . . . S DVBALAST=$P(^DVB(396.4,DVBIEN4,5,0),U,3) S DVBAI="",DVBFLDS("CANCOM",DVBXCNT)=WP(1,0) F DVBAI=2:1:DVBALAST S DVBFLDS("CANCOM",DVBXCNT)=DVBFLDS("CANCOM",DVBXCNT)_WP(DVBAI,0)
 . . . . . S DVBXCNT=DVBXCNT+1
 . S DVBFLDS("IREQDT")=$G(DVBDAT(396.3,DVBIENS,1,"I"))
 . S DVBRSLT=1
 Q DVBRSLT
 ;
DELIMHDR(EXSDAT,EXEDAT,EXSTAT) ;output delimited format header
 ;  Input:
 ;    EXSDAT - start date (external format)
 ;    EXEDAT - end date (external format)
 ;    EXSTAT - request status (external format)
 S ^TMP("DVBREQH",$J,DVBCNT)="Request Status by Date Range Report",DVBCNT=DVBCNT+1
 S ^TMP("DVBREQH",$J,DVBCNT)="Date Range: "_EXSDAT_" - "_EXEDAT,DVBCNT=DVBCNT+1
 S ^TMP("DVBREQH",$J,DVBCNT)=""""_"Request Status: "_EXSTAT_""""_$C(13),DVBCNT=DVBCNT+1
 S ^TMP("DVBREQH",$J,DVBCNT)="SSN"_DVBAD_"PatientName"_DVBAD_"RequestDT"_DVBAD_"DTReleased"_DVBAD_"DTPrinted"_DVBAD_"RequestStatus"_DVBAD_"DtCanceled"_DVBAD_"Station"_DVBAD_"EXAM"_DVBAD_"CANCEL RSN"_DVBAD_"CANCEL CMNTS",DVBCNT=DVBCNT+1
 Q
 ;
DELIM ;output delimited format
 ;
 N DVBI     ;generic counter
 N DVBREQ   ;request record
 ;
 U IO
 S DVBI=0
 F  S DVBI=$O(^TMP("DVBREQH",$J,DVBI)) Q:'DVBI  D
 . S DVBREQ=^TMP("DVBREQH",$J,DVBI)
 . W !,DVBREQ
 S DVBI=0 F  S DVBI=$O(^TMP("DVBREQ",$J,DVBI)) Q:'DVBI  D
 . S DVBREQ=^TMP("DVBREQ",$J,DVBI)
 . W !,DVBREQ
 . S DVBI2=0 F  S DVBI2=$O(^TMP("DVBREQ",$J,DVBI,DVBI2)) Q:'DVBI2  D
 . .S DVBREQ=^TMP("DVBREQ",$J,DVBI,DVBI2)
 . .W !,DVBREQ
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
 U IO
 S $P(DVBLINE,"-",131)=""
 W "Date Range: "_EXSDAT_" - "_EXEDAT
 W !,"Request Status: ",EXSTAT
 W !
 W !,"SSN",?11,"PATIENT NAME",?33,"REQUEST DT",?45,"DT RELEASED"
 W ?57,"DT PRINTED",?69,"STATUS",?98,"DT CANCELED",?110,"STATION"
 W !,?2,"EXAM",?65,"CANCELLATION REASON"
 W !,?2,"CANCELLATION COMMENTS"
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
 U IO
 S DVBI=0
 F  S DVBI=$O(^TMP("DVBREQ",$J,DVBI)) Q:'DVBI  D
 . S DVBREQ=^TMP("DVBREQ",$J,DVBI)
 . W !,$P(DVBREQ,U,2),?11,$E($P(DVBREQ,U,3),1,20),?33,$P(DVBREQ,U,4)
 . W ?45,$P(DVBREQ,U,5),?57,$P(DVBREQ,U,6),?69,$P(DVBREQ,U,7)
 . W ?98,$P(DVBREQ,U,8),?110,$E($P(DVBREQ,U,9),1,20),!
 . S DVBIEN=$P(^TMP("DVBREQ",$J,DVBI),U,1)
 . S DVBIEN4=0 F  S DVBIEN4=$O(^DVB(396.4,"C",DVBIEN,DVBIEN4)) Q:'DVBIEN4  D
 . . I $D(^DVB(396.4,DVBIEN4,"CAN")) D
 . . . S DVBAY=($P($P(^DVB(396.4,DVBIEN4,"CAN"),"^",1),".",1)) I DVBAY>(DVBSDAT-1)&DVBAY<(DVBEDAT+1) D
 . . . . S DVBEXAM=$$GET1^DIQ(396.4,DVBIEN4,.03) S DVBCNRS=$$GET1^DIQ(396.4,DVBIEN4,52) D
 . . . . . W !,?2,"CANCELED EXAM: ",DVBEXAM,?65,"CANCELLATION REASON: ",DVBCNRS,!
 . . . . I $D(^DVB(396.4,DVBIEN4,5)) D
 . . . . . K ^UTILITY($J,"W")
 . . . . . W !,?2,"CANCELLATION COMMENTS:  " F LINE=0:0 S LINE=$O(^DVB(396.4,DVBIEN4,5,LINE)) Q:LINE=""  S X=^(LINE,0),DIWL=5,DIWR=75,DIWF="NW" D ^DIWP
 . . . . . W !
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
 N FLD     ;field array in external format
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
 . . . I $G(DVBAD)'="," S ^TMP("DVBREQN",$J,SRTDAT,DVBIEN)=FLD("SS")_U_FLD("NM")_U_FLD("REQDT")_U_FLD("RELDT")_U_FLD("PRTDT")_U_FLD("RS")_U_FLD("CANDT")_U_FLD("RO")_U_FLD("EXAM")_U_FLD("CANRS")_U_FLD("CANCOM")
 . . . I $G(DVBAD)="," D
 . . . . S ^TMP("DVBREQN",$J,SRTDAT,DVBIEN)=FLD("SS")_DVBAD_""""_FLD("NM")_""""_DVBAD_FLD("REQDT")_DVBAD_FLD("RELDT")_DVBAD_FLD("PRTDT")_DVBAD
 . . . . S ^TMP("DVBREQN",$J,SRTDAT,DVBIEN)=^TMP("DVBREQN",$J,SRTDAT,DVBIEN)_""""_FLD("RS")_""""_DVBAD_FLD("CANDT")_DVBAD_""""_FLD("RO")_""""_DVBAD_FLD("EXAM")_""""_DVBAD_FLD("CANRS")_""""_DVBAD_FLD("CANCOM")_""""
 ;
 ;load output global with sorted list
 S CHGDAT="",CNT=0  ;use "" because value could be zero ("0")
 F  S CHGDAT=$O(^TMP("DVBREQN",$J,CHGDAT)) Q:(CHGDAT="")  D
 . S DVBIEN=0
 . F  S DVBIEN=$O(^TMP("DVBREQN",$J,CHGDAT,DVBIEN)) Q:'DVBIEN  D
 . . S CNT=CNT+1
 . . S ^TMP("DVBREQ",$J,CNT)=^TMP("DVBREQN",$J,CHGDAT,DVBIEN)
 Q
