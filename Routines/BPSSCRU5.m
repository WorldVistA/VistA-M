BPSSCRU5 ;BHAM ISC/SS - ECME SCREEN UTILITIES ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;USER SCREEN
 Q
 ;
DATETIME(Y) ;EP - convert fileman date.time to printable
 X ^DD("DD")
 Q Y
 ;
 ;create a history of claims and responses in #9002313.57 file 
 ;record for the specified transaction in #9002313.59 file
 ;input:
 ; BP59 - ptr to #9002313.59
 ; BPHIST - array to return results
 ;output:
 ; Array in BPHIST with the format:
 ;  BPHIST(type,timedate,PointerToResponseClaimFile)=PointerTo#9002313.57^request type
 ;  where:
 ;  request type - "C" - billing request, "R" - reversal request
 ;  type "C" - BPS CLAIM file, "R" - BPS RESPONSE file
 ;  PointerToResponseClaimFile - pointer to 9002313.03 or 9002313.02
MKHIST(BP59,BPHIST) ;
 N BP57,BPLSTCLM,BPLSTRSP,BPDAT57,BP1,BPSSTDT
 S BP57=0
 N BPSARR02
 N BPSARR03
 ; -- process BPS LOG OF TRANSACTIONS file
 F  S BP57=$O(^BPSTL("B",BP59,BP57)) Q:+BP57=0  D
 . ;claim transmissions
 . S BPDAT57(0)=$G(^BPSTL(BP57,0))
 . S BPSSTDT=+$P(BPDAT57(0),U,11) ;start time
 . S BPLSTCLM=+$P(BPDAT57(0),U,4) ;claim
 . I BPLSTCLM>0 D
 . . S BP1=+$P($G(^BPSC(BPLSTCLM,0)),U,5) ;transmitted on
 . . I BP1=0 S BP1=+$P($G(^BPSC(BPLSTCLM,0)),U,6) ;rec created on
 . . ;old BPS CLAIMS recs don't have dates, so use START TIME from .57 file but 
 . . ;only at the very first time (using $D for this)
 . . I BP1=0 I '$D(BPSARR02(BPLSTCLM)) S (BPSARR02(BPLSTCLM))=BPSSTDT,BP1=BPSSTDT
 . . I BP1 I '$D(BPHIST("C",BP1,BPLSTCLM)) S BPHIST("C",BP1,BPLSTCLM)=BP57_U_"C"
 . S BPLSTRSP=+$P(BPDAT57(0),U,5) ;response
 . I BPLSTRSP>0 D
 . . S BP1=+$P($G(^BPSR(BPLSTRSP,0)),U,2) ;received on
 . . I BP1=0 I '$D(BPSARR03(BPLSTRSP)) S (BPSARR02(BPLSTCLM))=BPSSTDT,BP1=BPSSTDT
 . . I BP1 I '$D(BPHIST("R",BP1,BPLSTRSP)) S BPHIST("R",BP1,BPLSTRSP)=BP57_U_"C"
 . ;reversal transmissions
 . S BPDAT57(4)=$G(^BPSTL(BP57,4))
 . S BPLSTCLM=+$P(BPDAT57(4),U,1) ;reversal
 . I BPLSTCLM>0 D
 . . S BP1=+$P($G(^BPSC(BPLSTCLM,0)),U,5) ;transmitted on
 . . I BP1=0 S BP1=+$P($G(^BPSC(BPLSTCLM,0)),U,6) ;rec created on
 . . I BP1=0 I '$D(BPSARR02(BPLSTCLM)) S (BPSARR02(BPLSTCLM))=BPSSTDT,BP1=BPSSTDT
 . . I BP1 I '$D(BPHIST("C",BP1,BPLSTCLM)) S BPHIST("C",BP1,BPLSTCLM)=BP57_U_"R"
 . S BPLSTRSP=+$P(BPDAT57(4),U,2) ;reversal response
 . I BPLSTRSP>0 D
 . . S BP1=+$P($G(^BPSR(BPLSTRSP,0)),U,2) ;received on
 . . I BP1=0 I '$D(BPSARR03(BPLSTRSP)) S (BPSARR02(BPLSTCLM))=BPSSTDT,BP1=BPSSTDT
 . . I BP1 I '$D(BPHIST("R",BP1,BPLSTRSP)) S BPHIST("R",BP1,BPLSTRSP)=BP57_U_"R"
 ;--------
 ;sorting: pairs (send/respond) in reversed chronological order
 N BPCLDT1,BPCLIEN,BPRSDT1,BPRSIEN,BPCLDT2
 S BPCLDT1=0
 F  S BPCLDT1=$O(BPHIST("C",BPCLDT1)) Q:BPCLDT1=""  D
 . S BPCLIEN=$O(BPHIST("C",BPCLDT1,0)) Q:BPCLIEN=""  D
 . . S BPCLDT2=+$O(BPHIST("C",BPCLDT1))
 . . I BPCLDT2=0 S BPCLDT2=9999999
 . . S BPRSDT1=BPCLDT1
 . . F  S BPRSDT1=$O(BPHIST("R",BPRSDT1)) Q:BPRSDT1=""!(BPRSDT1>BPCLDT2)  D
 . . . S BPRSIEN=$O(BPHIST("R",BPRSDT1,0)) Q:BPRSIEN=""  D
 . . . . S BPHIST("C",BPCLDT1,BPCLIEN,"R",BPRSIEN)=BPHIST("R",BPRSDT1,BPRSIEN)
 ;
 Q
 ;returns text for the transaction code in file #9002313.02 -- BPS CLAIMS FILE
TRTYPE(BPTRCD) ;
 I BPTRCD="E1" Q "Eligibility Verification"
 I BPTRCD="B1" Q "REQUEST"  ;"Billing"
 I BPTRCD="B2" Q "REVERSAL"  ; "Reversal"
 I BPTRCD="B3" Q "Rebill"
 I BPTRCD="P1" Q "P.A. Request & Billing"
 I BPTRCD="P2" Q "P.A. Reversal"
 I BPTRCD="P3" Q "P.A. Inquiry"
 I BPTRCD="P4" Q "P.A. Request Only"
 I BPTRCD="N1" Q "Information Reporting"
 I BPTRCD="N2" Q "Information Reporting Reversal"
 I BPTRCD="N3" Q "Information Reporting Rebill"
 I BPTRCD="C1" Q "Controlled Substance Reporting"
 I BPTRCD="C2" Q "Controlled Substance Reporting Reversal"
 I BPTRCD="C3" Q "Controlled Substance Reporting Rebill"
 Q ""
 ;
 ;get NDC for LOG
 ;BPIEN02 - IEN in #9002313.02 file
LNDC(BPIEN02) ;
 N BPDAT02,BPNDC
 S BPDAT02(400)=$G(^BPSC(BPIEN02,400,1,400))
 S BPNDC=$E($P(BPDAT02(400),U,7),3,99)
 S BPNDC=$E(BPNDC,1,5)_"-"_$E(BPNDC,6,9)_"-"_$E(BPNDC,10,11)
 Q BPNDC
 ;prepares array of reject codes
 ; BPIEN03 - IEN in #9002313.03 file
 ; BPRCODES - array to return results
REJCODES(BPIEN03,BPRCODES) ;
 N BPA,BPR
 S BPA=0
 F  S BPA=$O(^BPSR(BPIEN03,1000,1,511,BPA)) Q:'BPA  D
 . S BPR=$P(^BPSR(BPIEN03,1000,1,511,BPA,0),U)
 . I BPR'="" S BPRCODES(BPR)=""
 Q
 ;status of the response
RESPSTAT(BPIEN03) ;
 N BP1
 S BP1=$P($G(^BPSR(BPIEN03,1000,1,110)),U,2)
 Q:BP1="A" "Approved"
 Q:BP1="C" "Captured"
 Q:BP1="D" "Duplicate of Paid"
 Q:BP1="F" "PA Deferred"
 Q:BP1="P" "Paid"
 Q:BP1="Q" "Duplicate of Capture"
 Q:BP1="R" "Rejected"
 Q:BP1="S" "Duplicate of Approved"
 Q ""
 ;
 ;Electronic payer - ptr to #9002313.92 
 ;BPIEN02 - ptr in #9002313.02
PYRIEN(BPIEN02) ;
 Q $P($G(^BPSF(9002313.92,+$P($G(^BPSC(BPIEN02,0)),U,2),0)),U)
 ;
 ;BPIEN02 - ptr in #9002313.02
B2PYRIEN(BPIEN02,BP57) ;
 N BPX,BPX2
 S BPX=$G(^BPSF(9002313.92,+$$PYRIEN(BPIEN02),"REVERSAL"))
 I $L(BPX)=0 D
 . S BPX2=+$P($G(^BPSTL(BP57,10,+$G(^BPSTL(BP57,9)),0)),U,3)
 . S BPX=$P($G(^BPSF(9002313.92,BPX2,0)),U)
 Q BPX
 ;
 ;B3 payer sheet 
B3PYRIEN(BPIEN02,BP59,BP57) ;
 N BPX,BPX2
 S BPX2=+$P($G(^BPSTL(BP57,10,+$G(^BPSTL(BP57,9)),0)),U,4)
 S BPX=$P($G(^BPSF(9002313.92,BPX2,0)),U)
 Q BPX
 ;
 ;
 ;BPLN= line to use in SETLINE
 ;BPX - long string to display
 ;BPMLEN - max length
 ;BPPREFX - prefix string
 ;BPMARG - left margin
WRAPLN(BPLN,BPX,BPMLEN,BPPREFX,BPMARG) ;
 N BPQ,BPLEN,BPXX
 S BPQ=0
 S BPLEN=BPMLEN-$L(BPPREFX)
 S BPXX=$E(BPX,1,BPLEN)
 D SETLINE^BPSSCRLG(.BPLN,BPPREFX_BPXX)
 S BPX=$E(BPX,BPLEN+1,9999)
 I $L(BPX)<1 Q
 S BPLEN=BPMLEN-BPMARG
 F  D  Q:BPQ=1
 . S BPXX=$E(BPX,1,BPLEN)
 . D SETLINE^BPSSCRLG(.BPLN,$$SPACES(BPMARG)_BPXX)
 . S BPX=$E(BPX,BPLEN+1,9999)
 . I $L(BPX)<1 S BPQ=1
 Q
 ;
 ;to prepare spaces
SPACES(BPN) ;
 N BPX
 S $P(BPX," ",BPN+1)=""
 Q BPX
 ;
 ;BPN= line counter (index) 
 ;BPARR - array for lines
 ;BPX - long string to display
 ;BPMLEN - mas length
 ;BPPREFX - prefix string
 ;BPMARG - left margin
WRAPLN2(BPN,BPARR,BPX,BPMLEN,BPPREFX,BPMARG) ;
 N BPQ,BPLEN,BPXX
 S BPQ=0
 S BPLEN=BPMLEN-$L(BPPREFX)
 S BPXX=$E(BPX,1,BPLEN)
 D SETLN(.BPN,.BPARR,BPPREFX_BPXX)
 S BPX=$E(BPX,BPLEN+1,9999)
 I $L(BPX)<1 Q
 S BPLEN=BPMLEN-BPMARG
 F  D  Q:BPQ=1
 . S BPXX=$E(BPX,1,BPLEN)
 . D SETLN(.BPN,.BPARR,$$SPACES(BPMARG)_BPXX)
 . S BPX=$E(BPX,BPLEN+1,9999)
 . I $L(BPX)<1 S BPQ=1
 Q
 ;
 ;
SETLN(BPN,BPARR,BPTXT) ;
 S BPN=BPN+1,BPARR(BPN)=BPTXT
 Q
 ;---
 ;check 2nd insurance
 ;if there then ask user and print message
CH2NDINS(BP59,BPPATNAM,BPINSNAM,BPRXINFO) ;
 N BPRETV
 S BPRETV=$$NEXTINS^BPSSCRCL(BP59,BPINSNAM)
 Q:+BPRETV=0
 D PRN(BPPATNAM,BPRETV,.BPRXINFO,"S")
 W !!
 I $$YESNO^BPSSCRRS("Do you want to print the information (above) concerning additional insurance?   (Y/N)")'=1 Q
 D PRN(BPPATNAM,BPRETV,.BPRXINFO,"P")
 Q
 ;
 ;BPPRNFL
 ; S- print to screen
PRN(BPPATNAM,BPRETV,BPRXINFO,BPPRNFL) ;
 I BPPRNFL="S" W @IOF D MS2NDINS Q
 D PRINT("MS2NDINS^BPSSCRU5","BPS 2ND INSURANCE INFO","BP*")
 W !!
 Q
 ;
MS2NDINS ;
 N Y,Z
 W !,"This patient has ADDITIONAL insurance with Rx Coverage that may be"
 W !,"used to bill this claim.  The system will change the CT entry to a"
 W !,"NON-BILLABLE Episode. If appropriate, please go to the ECME Pharmacy"
 W !,"COB menu and use the PRO - Process Secondary/TRICARE Rx to ECME"
 W !,"option to create an ePharmacy secondary claim."
 W !!,"Patient: ",?18,BPPATNAM
 S Y=$P(BPRETV,U,4)\1 D DD^%DT
 W !,"Date of service: ",?18,Y
 W !,"Insurance: ",?18,$P(BPRETV,U,2)
 W !,"Group number: ",?18,$P(BPRETV,U,3)
 S Z=0 F  S Z=$O(BPRXINFO(Z)) Q:+Z=0  W !,BPRXINFO(Z)
 Q
 ;
 ;Prints report
 ;propmpts user to choose device (including queuing)
 ;TXTSRC - name of the report's entry point
 ;DESCR - description for the Task Manager
 ;SAVEVARS - mask for vars that need to be available in the report
 ;  (exmpl: "BP*")
PRINT(TXTSRC,DESCR,SAVEVARS) ;
 N Y,QUITVAR,SCRFLAG
 S (QUITVAR,SCRFLAG)=0
 D DEVICE Q:QUITVAR
 D @TXTSRC
 D ^%ZISC
 I QUITVAR W !,"Cancelled"
 Q
 ;
DEVICE ;
 N DIR,DIRUT,POP
 N ZTRTN,ZTIO,ZTSAVE,ZTDESC,%ZIS
 K IO("Q") S %ZIS="QM"
 W ! D ^%ZIS
 I POP S QUITVAR=1 Q
 S SCRFLAG=$S($E($G(IOST),1,2)="C-":1,1:0)
 I $D(IO("Q")) D  S QUITVAR=1
 . S ZTRTN=TXTSRC
 . S ZTIO=ION
 . S ZTSAVE(SAVEVARS)=""
 . S ZTDESC=DESCR
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
 Q
 ;
