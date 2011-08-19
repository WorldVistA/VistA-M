FBLTCAR ;WOIFO/SS-LTC AUTHORIZATIONS REPORTS ;11/20/02
 ;;3.5;FEE BASIS;**49**;JAN 30, 1995
 ;
 Q
 ;LTC Ending and Active Authorization Reports
 ;
 ;
EXPO ;entry point for LTC Outpatient Ending Authorization Report
 N FBLTCRT,FBLTCPR
 S FBLTCPR="OUTPATIENT"
 S FBLTCRT=1 ;Ending Expiration report
 D EN^FBLTCAR2
 Q
 ;
EXPC ;entry point for LTC CHN Ending Authorization Report
 N FBLTCRT,FBLTCPR
 S FBLTCPR="CONTRACT NURSING HOME"
 S FBLTCRT=1 ;Ending Expiration report
 D EN^FBLTCAR2
 Q
 ;
ACTO ;entry point for LTC Outpatient Active Authorization Report
 N FBLTCRT,FBLTCPR
 S FBLTCPR="OUTPATIENT"
 S FBLTCRT=2 ;Active authorizations report
 D EN^FBLTCAR2
 Q
ACTC ;entry point for LTC CHN Active Authorization Report
 N FBLTCRT,FBLTCPR
 S FBLTCPR="CONTRACT NURSING HOME"
 S FBLTCRT=2 ;Active authorizations report
 D EN^FBLTCAR2
 Q
 ;
 ;/*
 ;check if exclude/include the aithorization in report
 ;INPUT:
 ;FBAUTHFR - authorization date FROM
 ;FBAUTHTO - authorization date TO
 ;FBRPTFR  - report for date FROM
 ;FBRPTTO  - report for date TO
 ;FBRPTYPE - type of report: 
 ;  1-authorization Ending report
 ;  2-Active authorization report
 ;OUTPUT:
 ;1 - exclude
 ;0 - include
LTCRPT(FBAUTHFR,FBAUTHTO,FBRPTFR,FBRPTTO,FBRPTYPE) ;
 Q:FBRPTYPE=0 0
 ;authorization Ending report
 I FBRPTYPE=1 Q:((FBAUTHTO'<FBRPTFR)&(FBAUTHTO'>FBRPTTO)) 0  Q 1
 ;Active authorization report
 I FBRPTYPE=2 Q:((FBAUTHTO<FBRPTFR)!(FBAUTHFR>FBRPTTO)) 1  Q 0
 Q 0
 ;
 ;
 ;FBPTDFN - patient ien in file #2
 ;FB161P - pointer to multiple in file #161 under the DFN
 ;FBVEND - vendor
 ;FBDTB - begin date of the user specified date range
 ;FBDTE - end date of the user specified date range
 ;FBAUBEG - begin date of authorization
 ;FBAUEND - end date of authorization
 ;
 ;OUTPUT:
 ; string to print
 ;
PRNVIS(FBPTDFN,FB161P,FBVEND,FBDTB,FBDTE,FBAUBEG,FBAUEND) ;
 N FBRET1,FBRETAR,FBVNDR
 S FBRETAR=""
 S FBRET1=$$GETVIS(FBPTDFN,FB161P,FBDTB,$S(FBAUEND>FBDTE:FBDTE,1:FBAUEND),FBAUBEG,.FBRETAR)
 I FBVEND="not specified" D  ;if vendor was not specified in (#161)
 . ;loop thru vendors (#162) under this authorization
 . S FBVNDR="" F  S FBVNDR=$O(FBRETAR(FBVNDR)) Q:FBVNDR=""  D
 . . W !,?6,"Vendor: "_$S(FBVNDR>0:$P($G(^FBAAV(FBVNDR,0)),U),1:"not specified")
 . . W !,?6,"Visits: "_$G(FBRETAR(FBVNDR,1)),?19,"Paid Amt: $"_$G(FBRETAR(FBVNDR,2)),?39,"Cum Visits: "_$G(FBRETAR(FBVNDR,3)),?56,"Cum Paid Amt: $"_$G(FBRETAR(FBVNDR,4))
 . W !,?6,"---"
 W !,?6,"Visits: "_$P(FBRET1,U,1),?19,"Paid Amt: $"_$P(FBRET1,U,2),?39,"Cum Visits: "_$P(FBRET1,U,3),?56,"Cum Paid Amt: $"_$P(FBRET1,U,4)
 Q
 ;
 ;INPUT:
 ;FBPATDFN - patient ien in file #2
 ;FB161 - pointer to multiple in file #161 under the DFN
 ;FBBEG - begin date of the user specified date range
 ;FBEND - end date of the user specified date range 
 ;FBAUTB - begin date of authorization
 ;
 ;OUTPUT:
 ; returns number_of_visits^total amount^cumulative_number_of_visits^cumulative_total amount
 ; FBRET - array with results
GETVIS(FBPATDFN,FB161,FBBEG,FBEND,FBAUTB,FBRET) ;
 N FBVND,FBINDT,FBINITDT,FBCPT,FBAMT,FBCNT,FBCMAMT,FBCMCNT,FBDTCPT,FBBB,FBCPTN,FBAMT1
 ; auth,patient,vendor
 S (FBCNT,FBAMT,FBCMCNT,FBCMAMT)=0
 S FBVND=0 F  S FBVND=$O(^FBAAC("AF",FB161,FBPATDFN,FBVND)) Q:+FBVND=0  D
 . F FBBB=1:1:4 S FBRET(FBVND,FBBB)=0
 . ;auth,patient,vendor,date node
 . S FBINDT=0 F  S FBINDT=$O(^FBAAC("AF",FB161,FBPATDFN,FBVND,FBINDT)) Q:+FBINDT=0  D
 . . ;determine a date value
 . . S FBINITDT=+$G(^FBAAC(FBPATDFN,1,FBVND,1,FBINDT,0))
 . . Q:FBINITDT=0
 . . I FBINITDT>FBEND Q  ;out of date range
 . . ;patient,vendor,date,CPT code
 . . S FBCPT=0 F  S FBCPT=$O(^FBAAC(FBPATDFN,1,FBVND,1,FBINDT,1,FBCPT)) Q:+FBCPT=0  D
 . . . S FBCPTN=+$G(^FBAAC(FBPATDFN,1,FBVND,1,FBINDT,1,FBCPT,0))
 . . . S FBAMT1=+$P($G(^FBAAC(FBPATDFN,1,FBVND,1,FBINDT,1,FBCPT,0)),"^",3)
 . . . ; cumulative (from the begining of authorization till the end of user's date range)
 . . . I FBINITDT'<FBAUTB S FBCMAMT=FBCMAMT+FBAMT1,FBRET(FBVND,4)=FBRET(FBVND,4)+FBAMT1 S:'$D(FBDTCPT(FBINITDT,FBCPTN)) FBCMCNT=FBCMCNT+1,FBRET(FBVND,3)=FBRET(FBVND,3)+1
 . . . ; for user specified date range
 . . . I FBINITDT'<FBBEG S FBAMT=FBAMT+FBAMT1,FBRET(FBVND,2)=FBRET(FBVND,2)+FBAMT1 S:'$D(FBDTCPT(FBINITDT,FBCPTN)) FBCNT=FBCNT+1,FBRET(FBVND,1)=FBRET(FBVND,1)+1
 . . . S:'$D(FBDTCPT(FBINITDT,FBCPTN)) FBDTCPT(FBINITDT,FBCPTN)=""
 S FBRET=FBCNT_"^"_FBAMT_"^"_FBCMCNT_"^"_FBCMAMT
 Q FBRET
 ;
 ;
 ;FBLTCAR
