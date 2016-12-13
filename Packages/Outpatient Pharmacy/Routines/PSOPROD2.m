PSOPROD2 ;ALB/MRD - Pharmacy Productivity and Revenue Report ;9/8/15
 ;;7.0;OUTPATIENT PHARMACY;**448**;DEC 1997;Build 25
 ;Reference to $$BPSINSCO^BPSUTIL supported by IA 4410
 ;Reference to $$PAIDAMNT^BPSUTIL supported by IA 4146
 ;Reference to $$STATUS^BPSOSRX supported by IA 4412
 ;Reference to File 9002313.93 - BPS NCPDP REJECT CODES supported by IA 4720
 ;
 Q
 ;
EN ; Main entry point for compile and print.
 ;
 K ^TMP("PSOPRODA",$J),^TMP("PSOPRODB",$J)
 ;
 D COMPILE
 D PRINT
 ;
 K ^TMP("PSOPRODA",$J),^TMP("PSOPRODB",$J)
 ;
 I $D(ZTQUEUED) S ZTREQ="@"  ; If queued, purge the task after exiting.
 ;
 Q
 ;
COMPILE ; Compile data for report.
 ;
 ; Variables assumed to exist from EN^PSOPROD1:
 ;   PSODIV - Either equal to "ALL", or an array of each Division
 ;      selected by the user to be included.
 ;   PSODTBEGIN - Earliest Date Resolved to include.
 ;   PSODTEND - Latest Date Resolved to include.
 ;   PSOINCLUDE - Populated when user selects which to include.
 ;      The user can selected by PATIENT, DRUG, RX, INSURANCE
 ;      or REJECT CODE.  (For more info, see comments in ^PSOPROD1.)
 ;   PSOREPORT - "P" for Productivity report, "R" for Revenue report.
 ;   PSOSORT - D/R/B/N/C to indicate the primary sort (Division, date
 ;      Resolved, resolved By, drug Name, reject Code).
 ;   PSOSTATUS - "P" to include E Payable rejects, "R" to include E
 ;      Rejected rejects, "B" in include both.
 ;
 ; The data to be displayed on the report is compiled into the ^TMP
 ; array in the following format:
 ;   ^TMP("PSOPRODA",$J,SortValue,Rx,Fill,Reject) = Data
 ;      SortValue - Value of the field corresponding to the SortCode,
 ;         such as Division, Drug Name or Reject Code.
 ;      Rx - Prescription Number - file #52, IEN.
 ;      Fill - Refill Number - file #52.25, field #5.
 ;      Reject - Reject Number - file #52.25, IEN.
 ;   Data =
 ;      [1] Release Date - file #52, field #31, or sub-file #52.1, field #17.
 ;      [2] Date Rejected - sub-file #52.25, field #1.
 ;      [3] Date Resolved - sub-file #52.25, field #10.
 ;      [4] Resolved By - sub-file #52.25, field #11.
 ;      [5] Action Taken - file #52.25, field #12.
 ;      [6] Amount Paid - sub-file #9002313.0301, field #509.
 ;      [7] Insurance Name - file #9002313.59, field #902.33.
 ;      [8] Drug - file #52, field #6.
 ;      [9] Rejection - sub-file #52.25, field #.01.
 ;     [10] Division - file #52, field #20.
 ;     [11] Patient - file #52, field #2.
 ;     [12] E-Payable? - 1 if ECME Status is E PAYABLE.
 ;
 N PSOACTION,PSOCOB,PSODATA,PSODIVISION,PSODATE,PSODRUG
 N PSODTREJECTED,PSODTRESLVDA,PSODTRESLVDB,PSOECMESTATUS
 N PSOEPAYABLE,PSOFILL,PSOINSURANCE,PSOPAIDAMT,PSOPATIENT
 N PSOREJ,PSOREJCODEA,PSOREJCODEB,PSORESLVDBYA,PSORESLVDBYB
 N PSORX,PSOSORTB
 ;
 I IOST["C-",'PSOEXCEL W !,"Compiling..."
 ;
 ; All closed/resolved rejects will appear in the "CLSDAT" cross-
 ; reference:  ^PSRX("CLSDAT",Closed Date/Time,Rx,Reject).  Loop
 ; through them and include those that meet the filter criteria.
 ;
 S PSODATE=PSODTEND+.999999
 F  S PSODATE=$O(^PSRX("CLSDAT",PSODATE),-1) Q:PSODATE=""  Q:(PSODATE\1)<PSODTBEGIN  D
 . S PSORX=""
 . F  S PSORX=$O(^PSRX("CLSDAT",PSODATE,PSORX)) Q:PSORX=""  D
 . . ;
 . . ; Check to see if this Rx/Reject should be included.
 . . ;
 . . I PSOINCLUDE("RX")'="ALL",'$D(PSOINCLUDE("RX",PSORX)) Q
 . . ;
 . . ; Check to see if this Patient should be included.
 . . ;
 . . S PSOPATIENT=$$GET1^DIQ(52,PSORX,2,"I")
 . . I PSOINCLUDE("PATIENT")'="ALL",'$D(PSOINCLUDE("PATIENT",PSOPATIENT)) Q
 . . ;
 . . ; Check to see if this Drug should be included.
 . . ;
 . . S PSODRUG=$$GET1^DIQ(52,PSORX,6,"I")
 . . I PSOINCLUDE("DRUG")'="ALL",'$D(PSOINCLUDE("DRUG",PSODRUG)) Q
 . . S PSODRUG=$$GET1^DIQ(50,PSODRUG_",",.01)
 . . ;
 . . ; Check to see if this Division should be included.
 . . ;
 . . S PSODIVISION=$$GET1^DIQ(52,PSORX,20,"I")
 . . I PSODIV'="ALL",'$D(PSODIV(PSODIVISION)) Q
 . . ;
 . . S PSOREJ=""
 . . F  S PSOREJ=$O(^PSRX("CLSDAT",PSODATE,PSORX,PSOREJ)) Q:PSOREJ=""  D
 . . . ;
 . . . ; For the RRR Revenue report, skip if RRR flag is not set.
 . . . ;
 . . . I PSOREPORT="R",'$$GET1^DIQ(52.25,PSOREJ_","_PSORX,30,"I") Q
 . . . ;
 . . . ; Check to see if this Reject Code should be included.
 . . . ;
 . . . S PSOREJCODEA=$$GET1^DIQ(52.25,PSOREJ_","_PSORX_",",.01)
 . . . I PSOINCLUDE("REJECT CODE")'="ALL",'$D(PSOINCLUDE("REJECT CODE",PSOREJCODEA)) Q
 . . . S PSOREJCODEB=PSOREJCODEA
 . . . ;
 . . . ; Determine Fill# and COB.
 . . . ;
 . . . S PSOFILL=$$GET1^DIQ(52.25,PSOREJ_","_PSORX_",",5)
 . . . I PSOFILL="" S PSOFILL=0
 . . . S PSOCOB=$$GET1^DIQ(52.25,PSOREJ_","_PSORX_",",27,"I")
 . . . I PSOCOB="" S PSOCOB=1
 . . . ;
 . . . ; If any unresolved rejects, Quit.
 . . . ;
 . . . I $$FIND^PSOREJUT(PSORX,PSOFILL,,,1) Q
 . . . ;
 . . . ; Pull Date Rejected, Date Resolved, Resolved By, Action Taken
 . . . ; and Paid Amount.
 . . . ;
 . . . S PSODTREJECTED=$$GET1^DIQ(52.25,PSOREJ_","_PSORX_",",1,"I")\1  ; Date Rejected.
 . . . S PSODTRESLVDA=PSODATE\1  ; Date Resolved.
 . . . S PSORESLVDBYA=$$GET1^DIQ(52.25,PSOREJ_","_PSORX_",",11,"I")  ; Resolved By.
 . . . S PSOACTION=$$GET1^DIQ(52.25,PSOREJ_","_PSORX_",",12)  ; Action Taken.
 . . . S PSODTRESLVDB=PSODTRESLVDA,PSORESLVDBYB=PSORESLVDBYA
 . . . S PSOPAIDAMT=$P($$PAIDAMNT^BPSUTIL(PSORX,PSOFILL),U,2)  ; Amount Paid; IA 4146.
 . . . I PSOPAIDAMT'="" S PSOPAIDAMT=$J(PSOPAIDAMT,1,2)
 . . . ;
 . . . I $$ECMEINS(.PSOEPAYABLE) D ADDLINE
 . . . ;
 . . . ; If the report type is RRR Revenue report, then conditionally
 . . . ; display all subsequent refills on the Prescription.
 . . . ;
 . . . I PSOREPORT="R" D
 . . . . ;
 . . . . ; Clear out those data elements that are based on the Reject
 . . . . ; and not the Prescription.
 . . . . ;
 . . . . S PSODTREJECTED=""
 . . . . S PSODTRESLVDB=""
 . . . . S PSORESLVDBYB=""
 . . . . S PSOACTION=""
 . . . . S PSOREJCODEB=""
 . . . . ;
 . . . . F  S PSOFILL=$O(^PSRX(PSORX,1,PSOFILL)) Q:'PSOFILL  D
 . . . . . S PSOPAIDAMT=$P($$PAIDAMNT^BPSUTIL(PSORX,PSOFILL),U,2)  ; Amount Paid; IA 4146.
 . . . . . I PSOPAIDAMT'="" S PSOPAIDAMT=$J(PSOPAIDAMT,1,2)
 . . . . . I $$ECMEINS(.PSOEPAYABLE) D ADDLINE
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . Q
 ;
 Q
 ;
ECMEINS(PSOEPAYABLE) ; Check ECME Status and Insurance Company.
 ;
 ; Determine ECME Status and Insurance.  Check to see if this ECME
 ; Status and this Insurance should be included.  If not, Quit 0.
 ; If it passes the checks, Quit 1.  The variable EPAYABLE, passed
 ; by reference, gets set to 1 if the ECME status is E PAYABLE.
 ;
 S PSOEPAYABLE=0
 S PSOECMESTATUS=$P($$STATUS^BPSOSRX(PSORX,PSOFILL,,,PSOCOB),U,1)  ; IA 4412.
 I PSOECMESTATUS'="E PAYABLE",PSOECMESTATUS'="E REJECTED" Q 0
 I PSOECMESTATUS="E PAYABLE",PSOSTATUS="R" Q 0
 I PSOECMESTATUS="E REJECTED",PSOSTATUS="P" Q 0
 I PSOECMESTATUS="E PAYABLE" S PSOEPAYABLE=1
 ;
 S PSOINSURANCE=$$BPSINSCO^BPSUTIL(PSORX,PSOFILL)  ; IA 4410.
 I PSOINCLUDE("INSURANCE")'="ALL",'$D(PSOINCLUDE("INSURANCE",PSOINSURANCE)) Q 0
 ;
 Q 1
 ;
ADDLINE ; Add one Rx/Fill to the ^TMP global.
 ;
 I PSOFILL=0 S PSODATA=$$GET1^DIQ(52,PSORX_",",31,"I")\1  ; Release Date.
 I PSOFILL>0 S PSODATA=$$GET1^DIQ(52.1,PSOFILL_","_PSORX_",",17,"I")\1  ; Release Date.
 I +PSODATA=0 S PSODATA=""
 S PSODATA=PSODATA_"^"_PSODTREJECTED  ; Date Rejected.
 S PSODATA=PSODATA_"^"_PSODTRESLVDB  ; Date Resolved.
 S PSODATA=PSODATA_"^"_PSORESLVDBYB  ; Resolved By.
 S PSODATA=PSODATA_"^"_PSOACTION  ; Action Taken.
 S PSODATA=PSODATA_"^"_PSOPAIDAMT  ; Amount Paid
 S PSODATA=PSODATA_"^"_PSOINSURANCE  ; Insurance Name.
 S PSODATA=PSODATA_"^"_PSODRUG  ; Drug.
 S PSODATA=PSODATA_"^"_PSOREJCODEB  ; Rejection.
 S PSODATA=PSODATA_"^"_PSODIVISION  ; Division.
 S PSODATA=PSODATA_"^"_PSOPATIENT  ; Patient.
 S PSODATA=PSODATA_"^"_PSOEPAYABLE  ; E-Payable?
 ;
 ; Determine the first sort level, indicated by the user.  Possible
 ; sorts are Division, Date Resolved, User Resolved By, Drug Name
 ; and Reject Code.
 ;
 S PSOSORTB=$S(PSOSORT="D":PSODIVISION,PSOSORT="R":PSODTRESLVDA,PSOSORT="B":PSORESLVDBYA,PSOSORT="N":PSODRUG,PSOSORT="C":PSOREJCODEA,1:" ")
 ;
 ; If there is already a resolved reject for this Rx/Fill, then reset
 ; the Amount Paid field to "*****" for the current reject.  Since we
 ; are looping through the rejects in reverse chronological order, the
 ; result will be that only the most recently resolved reject will
 ; display the dollar amount instead of both of them.
 ;
 I $D(^TMP("PSOPRODB",$J,PSORX,PSOFILL)) S $P(PSODATA,U,6)="*****"
 S ^TMP("PSOPRODB",$J,PSORX,PSOFILL)=""
 ;
 ; Add to ^TMP global.
 ;
 S ^TMP("PSOPRODA",$J,PSOSORTB,PSORX,PSOFILL,PSOREJ)=PSODATA
 ;
 Q
 ;
PRINT ; Print report data.
 ;
 ; Variables assumed to exist from EN^PSOPROD1:
 ;   PSODIV - Either equal to "ALL", or an array of each Division
 ;      selected by the user to be included.
 ;   PSODTBEGIN - Earliest Date Resolved to include.
 ;   PSODTEND - Latest Date Resolved to include.
 ;   PSOEXCEL - 1 if user requested Excel format, otherwise 0.
 ;   PSOINCLUDE - Populated when user selects which to include.
 ;      The user can selected by PATIENT, DRUG, RX, INSURANCE
 ;      or REJECT CODE.  (For more info, see comments in ^PSOPROD1.)
 ;   PSOREPORT - "P" for Productivity report, "R" for Revenue report.
 ;   PSOSHOWPAT - 1 if user wants patient names displayed, else 0.
 ;   PSOSORT - D/R/B/N/C to indicate the primary sort (Division, date
 ;      Resolved, resolved By, drug Name, reject Code).
 ;   PSOSTATUS - "P" to include E Payable rejects, "R" to include E
 ;      Rejected rejects, "B" in include both.
 ;
 N DIR,PSOCRT,PSODASHES,PSODATA,PSOFILL,PSOPAGE,PSORX
 N PSOSORTB,PSOSTOP,PSOX,Y
 ;
 S PSOCRT=$S(IOST["C-":1,1:0)
 I PSOEXCEL S IOSL=999999  ; Ensure long screen length for Excel output.
 S PSOPAGE=0,PSOSTOP=0,$P(PSODASHES,"=",113)=""
 I PSOINCLUDE="PATIENT",'PSOEXCEL,'PSOSHOWPAT S PSOINCLUDE("PATIENT")=""
 ;
 D HDR
 I '$D(^TMP("PSOPRODA",$J)) W:'PSOEXCEL !!?5,"No data meets the criteria." G PX
 ;
 S PSOSORTB=""
 F  S PSOSORTB=$O(^TMP("PSOPRODA",$J,PSOSORTB)) Q:PSOSORTB=""!PSOSTOP  D
 . S PSORX=""
 . F  S PSORX=$O(^TMP("PSOPRODA",$J,PSOSORTB,PSORX)) Q:PSORX=""!PSOSTOP  D
 . . S PSOFILL=""
 . . F  S PSOFILL=$O(^TMP("PSOPRODA",$J,PSOSORTB,PSORX,PSOFILL)) Q:PSOFILL=""!PSOSTOP  D
 . . . S PSOREJ=""
 . . . F  S PSOREJ=$O(^TMP("PSOPRODA",$J,PSOSORTB,PSORX,PSOFILL,PSOREJ)) Q:PSOREJ=""!PSOSTOP  D
 . . . . S PSODATA=$G(^TMP("PSOPRODA",$J,PSOSORTB,PSORX,PSOFILL,PSOREJ))
 . . . . ;
 . . . . ; If Excel, write the formatted line then Quit.
 . . . . ;
 . . . . I PSOEXCEL D EXCELN Q
 . . . . ;
 . . . . I $Y+3>IOSL D HDR I PSOSTOP Q
 . . . . ;
 . . . . W !,$$GET1^DIQ(52,PSORX_",",.01),"/",PSOFILL
 . . . . W ?12,$$FMTE^XLFDT($P(PSODATA,U,1),"2Z")  ; Release Date.
 . . . . W ?22,$$FMTE^XLFDT($P(PSODATA,U,2),"2Z")  ; Date Rejected.
 . . . . W ?35,$$FMTE^XLFDT($P(PSODATA,U,3),"2Z")  ; Date Resolved.
 . . . . I $P(PSODATA,U,4)'="" W ?48,$E($$GET1^DIQ(200,$P(PSODATA,U,4)_",",.01),1,16)  ; Resolved By.
 . . . . E  I '$P(PSODATA,U,12) W ?48,"*Not ePayable*"  ; E-Payable?
 . . . . W ?65,$E($P(PSODATA,U,5),1,21)  ; Action Taken.
 . . . . W ?87,$J($P(PSODATA,U,6),10)  ; Amount Paid.
 . . . . W ?99,$E($$GET1^DIQ(36,$P(PSODATA,U,7)_",",.01),1,13)  ; Insurance Name.
 . . . . W !?4,$E($P(PSODATA,U,8),1,31)  ; Drug.
 . . . . I $P(PSODATA,U,9)'="" D  ; Rejection.
 . . . . . S PSOX=$O(^BPSF(9002313.93,"B",$P(PSODATA,U,9),""))  ; IA 4720.
 . . . . . S PSOX=$$GET1^DIQ(9002313.93,PSOX_",",.02)  ; IA 4720.
 . . . . . W ?36,$E($P(PSODATA,U,9)_" - "_PSOX,1,29)
 . . . . . Q
 . . . . W ?66,$E($$GET1^DIQ(59,$P(PSODATA,U,10)_",",.01),1,17)  ; Division.
 . . . . I PSOSHOWPAT W ?84,$E($$GET1^DIQ(2,$P(PSODATA,U,11)_",",.01),1,18)  ; Patient.
 . . . . ;
 . . . . Q
 . . . Q
 . . Q
 . Q
 ;
 I PSOSTOP G PRINTX
 I $Y+4>IOSL D HDR I PSOSTOP G PRINTX
 I 'PSOEXCEL W !!?5,"*** End of Report ***"
 ;
PX ;
 I PSOCRT S DIR(0)="E" W ! D ^DIR K DIR
PRINTX ;
 Q
 ;
EXCELN ; Write one line in Excel format.
 ;
 N PSOX
 ;
 W !,$$GET1^DIQ(52,PSORX_",",.01)_"/"_PSOFILL,"^"  ; Rx / Fill.
 W $$FMTE^XLFDT($P(PSODATA,U,1),"2Z"),"^"  ; Release Date.
 W $$FMTE^XLFDT($P(PSODATA,U,2),"2Z"),"^"  ; Date Rejected.
 W $$FMTE^XLFDT($P(PSODATA,U,3),"2Z"),"^"  ; Date Resolved.
 W $$GET1^DIQ(200,$P(PSODATA,U,4)_",",.01),"^"  ; Resolved By.
 W $P(PSODATA,U,5),"^"  ; Action Taken.
 W $P(PSODATA,U,6),"^"  ; Amount Paid.
 W $$GET1^DIQ(36,$P(PSODATA,U,7)_",",.01),"^"  ; Insurance Name.
 W $P(PSODATA,U,8),"^"  ; Drug
 S PSOX=""
 I $P(PSODATA,U,9)'="" D  ; Rejection.
 . S PSOX=$O(^BPSF(9002313.93,"B",$P(PSODATA,U,9),""))  ; IA 4720.
 . S PSOX=$P(PSODATA,U,9)_" - "_$$GET1^DIQ(9002313.93,PSOX_",",.02)  ; IA 4720.
 . Q
 W PSOX,"^"  ; Rejection.
 W $$GET1^DIQ(59,$P(PSODATA,U,10)_",",.01),"^"  ; Division.
 W $$GET1^DIQ(2,$P(PSODATA,U,11)_",",.01),"^"  ; Patient.
 W $S($P(PSODATA,U,12):"Y",1:"N")  ; E-Payable?
 ;
 Q
 ;
HDR ; Write the report header.
 ;
 ; If PAGE (i.e. not the first page) and device is the screen, do an
 ; end-of-page reader call.  If PAGE or screen output, do a form feed.
 ; If this is the first page ('PSOPAGE), and device is file or printer
 ; ('PSOCRT), reset the left margin ($C(13)).
 ;
 I PSOPAGE,PSOCRT S DIR(0)="E" D ^DIR K DIR I 'Y S PSOSTOP=1 G HDRX
 I PSOPAGE!PSOCRT W @IOF
 I 'PSOPAGE,'PSOCRT W $C(13)
 S PSOPAGE=PSOPAGE+1
 ;
 ; For Excel format, display only the column headers then exit.
 ; 
 I PSOEXCEL D EXCELHDR G HDRX
 ;
 ; Write the report header.
 ;
 I PSOREPORT="P" W "Pharmacy Productivity Report"
 E  W "RRR Revenue Report"
 W ?58,"Print Date: ",$$FMTE^XLFDT($$NOW^XLFDT,"1M")
 W ?97,"Page: ",PSOPAGE
 W !,"Selected Divisions: ",PSODIV
 W !,"Date Reject Resolved: ",$$FMTE^XLFDT(PSODTBEGIN,"2Z")," - ",$$FMTE^XLFDT(PSODTEND,"2Z")
 I PSOSTATUS(0)'="" W ?50,"Status: ",PSOSTATUS(0)
 I PSOINCLUDE(PSOINCLUDE)="" W !,"Select by ",PSOINCLUDE
 E  W !,$E("Select by "_PSOINCLUDE_": "_PSOINCLUDE(PSOINCLUDE),1,132)
 W !,"Sort by ",PSOSORT(0)
 ;
 ; Write the column headers.
 ;
 W !,PSODASHES
 W !,"RX#/FILL",?12,"REL DATE",?22,"DT REJECTED",?35,"DT RESOLVED"
 W ?48,"RESOLVED BY",?65,"ACTION TAKEN",?89,"AMT PAID",?98,"INSURANCE NAME"
 W !?4,"DRUG",?36,"REJECTION",?66,"DIVISION"
 I PSOSHOWPAT W ?84,"PATIENT NAME"
 W !,PSODASHES
 ;
HDRX ;
 Q
 ;
EXCELHDR ; Write the Excel header record.
 ;
 W "Rx#/FILL^REL DATE^DT REJECTED^DT RESOLVED^RESOLVED BY^"
 W "ACTION TAKEN^AMOUNT PAID^INSURANCE NAME^DRUG^REJECTON^"
 W "DIVISION^PATIENT NAME^E-PAYABLE?"
 Q
 ;
