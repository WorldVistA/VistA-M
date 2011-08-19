EASECPC1 ;ALB/LBD,CKN - LTC CoPayment Report continuation ; 6-FEB-2002
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**7,24,40**;Mar 15, 2001
 ;
 ; This routine is a continuation of EASECPC.
 ;
 ; Input:  DFN - Patient file IEN
 ;         DGMTI - LTC Copay Test IEN (file #408.31)
 ;         DGMTDT - LTC Copay Test Date
 ;         MAXRT - Maximum daily copay rates for LTC (OP^IP)
 ;         EASRPT - Report type:  1=Institutional (IP)
 ;                                2=Non-Institutional (OP)
 ;         EASRDT - Report start date
 ;         EASADM - LTC admission date (only if EASRPT=1)
 ;
START ; Generate Report
 N ARRY,IPRPT,DGSP,SRIC,LSEP,DECINF,AGRPAY,ERR
 I $G(ZTSK) S ZTREQ="@"
 D INIT(EASRDT,.ARRY)
 D BLDTBL(.ARRY) Q:$G(ERR)
 D PRINT
 Q
PRINT ; Print the Report
 N CRT,PAGE,RPTDT,LINE,HDR,CALC1,CALC2,SIDX,EIDX,MNTH,NAME,SSN,DOB,LOS
 D PRTVAR
 U IO
 D HEADER
 W !,$S(DGSP:"MARRIED",LSEP:"LEGALLY SEPARATED",1:"SINGLE")
 W:SRIC ?15,"SPOUSE RESIDING IN THE COMMUNITY"
 I DECINF,AGRPAY W !,"*** DECLINED TO PROVIDE INCOME INFORMATION -- AGREED TO PAY COPAYMENTS ***"
 I AGRPAY=0 W !,"*** VETERAN IS INELIGIBLE FOR LTC SERVICES -- REFUSED TO SIGN 10-10EC ***"
 W !,"LTC COPAY TEST DATE: ",$$FMTE^XLFDT(DGMTDT)
 W:$G(EASADM) ?47,"LTC ADMISSION DATE: ",$$FMTE^XLFDT(EASADM)
 W !!!,"LTC COPAYMENT CALCULATION"_$S(IPRPT:"S:",1:":")
 W ! W:IPRPT "FOR DAYS 1-180  " W CALC1
 I IPRPT W !,"FOR DAYS 181+   " W CALC2
 ;
 S SIDX=1,EIDX=6
 W !!,"              "
 F MNTH=1:1:6 W $J($P(ARRY(MNTH),"^"),11)
 I IPRPT D PRINTROW("TOT ASSETS    ",SIDX,EIDX,9)
 D PRINTROW("TOT INCOME    ",SIDX,EIDX,3)
 I 'IPRPT!($G(LOS)<181)!(DGSP&(SRIC)) D PRINTROW("TOT EXPENSES  ",SIDX,EIDX,4)
 D PRINTROW("TOT ALLOWANCE ",SIDX,EIDX,5)
 W ! D PRINTROW("CALC COPAY    ",SIDX,EIDX,6)
 D PRINTROW("MAX COPAY     ",SIDX,EIDX,7)
 W !,LINE
 D PRINTROW("VET COPAY     ",SIDX,EIDX,8)
 W !,LINE
 ;
 S SIDX=7,EIDX=12
 W !!,"              "
 F MNTH=7:1:12 W $J($P(ARRY(MNTH),"^"),11)
 I IPRPT D PRINTROW("TOT ASSETS    ",SIDX,EIDX,9)
 D PRINTROW("TOT INCOME    ",SIDX,EIDX,3)
 I 'IPRPT!(DGSP&(SRIC)) D PRINTROW("TOT EXPENSES  ",SIDX,EIDX,4)
 D PRINTROW("TOT ALLOWANCE ",SIDX,EIDX,5)
 W ! D PRINTROW("CALC COPAY    ",SIDX,EIDX,6)
 D PRINTROW("MAX COPAY     ",SIDX,EIDX,7)
 W !,LINE
 D PRINTROW("VET COPAY     ",SIDX,EIDX,8)
 W !,LINE
 ;
 I CRT Q:$$PAUSE(0)
 D:CRT HEADER
 D NOTETXT
 I CRT Q:$$PAUSE(0)
 I IPRPT D HEADER,SPNDDWN I CRT Q:$$PAUSE(0)
 Q
PRINTROW(TEXT,SIDX,EIDX,NODE) ; Print the Rows
 N MNTH
 W !,TEXT
 F MNTH=SIDX:1:EIDX W $J($S($P(ARRY(MNTH),"^",NODE)[".":$P($P(ARRY(MNTH),"^",NODE),"."),1:$P(ARRY(MNTH),"^",NODE)),11)
 Q
PRTVAR ; Set up variables needed to print report
 N PAT0
 S CRT=$S($E(IOST,1,2)="C-":1,1:0)
 S PAGE=0,RPTDT=$$FMTE^XLFDT(DT)
 S LINE="",$P(LINE,"-",81)=""
 S HDR=$$CJ^XLFSTR("LONG TERM CARE ESTIMATED COPAYMENTS FOR "_$S('IPRPT:"NON-",1:"")_"INSTITUTIONAL SERVICES",80)
 S PAT0=$G(^DPT(DFN,0)),NAME=$P(PAT0,"^"),DOB=$P(PAT0,"^",3)
 S SSN=$P(PAT0,"^",9),SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 S CALC1="TOTAL INCOME - TOTAL EXPENSES - TOTAL ALLOWANCE"
 I DGSP,SRIC S CALC2="(TOTAL ASSETS + TOTAL INCOME) - TOTAL EXPENSES - TOTAL ALLOWANCE"
 E  S CALC2="(TOTAL ASSETS + TOTAL INCOME) - TOTAL ALLOWANCE"
 S:$G(EASADM) LOS=$$FMDIFF^XLFDT(EASRDT,EASADM)
 Q
HEADER ; Print the header
 S PAGE=PAGE+1
 W @IOF
 W RPTDT,?71,"Page: ",$J(PAGE,3)
 W !!,HDR
 W !!,NAME,?35,SSN,?62,"DOB: ",$$FMTE^XLFDT(DOB)
 Q
PAUSE(RESP) ; Prompt user for next page or quit
 N DIR,DIRUT,DUOUT,DTOUT,U,X,Y
 S DIR(0)="E"
 D ^DIR
 I 'Y S RESP=1
 Q RESP
 ;
INIT(DATE,ARRY) ; Initialize the Month/Year Table
 N IDX,MNYR
 S MNYR=$E(DATE,1,5)_"00"
 F IDX=1:1:12 D
 .S ARRY(IDX)=$$UP^XLFSTR($$FMTE^XLFDT(MNYR))
 .S ARRY(IDX)=$P(ARRY(IDX)," ")_"'"_$E($P(ARRY(IDX)," ",2),3,4)
 .S $P(ARRY(IDX),"^",2)=MNYR
 .S MNYR=MNYR+100
 .S:$E(MNYR,4,5)=13 MNYR=$E(MNYR,1,3)+1_"0100"
 Q
BLDTBL(ARRY) ; Get the veteran's financial data, do the copay calculations,
 ; build the data table
 ;
 N DGDC,DGDEP,DGERR,DGFL,DGIN0,DGIN1,DGIN2,DGINI,DGIRI,DGDET,DGINT,DGNWT
 N DGPRI,DGNC,DGND,DGNWTF,DGVINI,DGVIR0,DGVIRI,DGVPRI,DGINTF,CPYFLG,IDX
 N OVR180,TAST,TINC,TEXP,ALLOW,CALCCPY,DAYS,MAXCPY,VETMAX,IPDR,OPDR,LOS
 ;
 S ERR=0
 S DGPRI=$O(^DGPR(408.12,"C",DFN_";DPT(",0)) I 'DGPRI S ERR=1 Q
 D GETIENS^EASECU2(DFN,DGPRI,DGMTDT) I '$G(DGIRI),'$G(DGINI) S ERR=1 Q
 S DGVIRI=DGIRI,DGVINI=DGINI
 D DEP^EASECSU3,INC^EASECSU3
 S IPRPT=$S(EASRPT=1:1,1:0)
 S CPYFLG=0
 S DECINF=$P($G(^DGMT(408.31,DGMTI,0)),"^",14)
 S AGRPAY=$P($G(^DGMT(408.31,DGMTI,0)),"^",11)
 I DECINF=1!(AGRPAY=0) S CPYFLG=1
 S SRIC=$P(DGVIR0,U,16),LSEP=$P(DGVIR0,U,17)
 S OPDR=$P(MAXRT,U),IPDR=$P(MAXRT,U,2)
 I IPRPT S LOS=$$FMDIFF^XLFDT(EASRDT,EASADM)+1
 ;
 S OVR180=$S($G(LOS)>180:1,1:0)
 S TINC=DGINT/12,TEXP=DGDET/12
 I OVR180,('DGSP!('SRIC)) S TEXP=0
 S TAST=DGNWT I OVR180 S TAST=$$ASSET
 ;
 ; Build data table
 F IDX=1:1:12 D
 .S DAYS=$$DOM($P(ARRY(IDX),"^",2))
 .D CALCALL
 .S $P(ARRY(IDX),"^",3)=TINC
 .S $P(ARRY(IDX),"^",4)=TEXP
 .S $P(ARRY(IDX),"^",5)=ALLOW
 .S $P(ARRY(IDX),"^",6)=CALCCPY
 .S $P(ARRY(IDX),"^",7)=MAXCPY
 .S $P(ARRY(IDX),"^",8)=VETMAX
 .S $P(ARRY(IDX),"^",9)=$S(OVR180:TAST,1:"-")
 .S:OVR180 TAST=$$ASTSPD
 .I $G(LOS) D
 ..S LOS=LOS+DAYS
 ..S:'OVR180 OVR180=$S(LOS>180:1,1:0)
 ..I OVR180,('DGSP!'(SRIC)) S:TEXP TEXP=0
 Q
 ;
CALCALL ; Calculate the allowance and all the copayment amounts
 S ALLOW=20*DAYS*(1+SRIC) S:CPYFLG ALLOW=0
 S CALCCPY=$$CALCCPY
 S MAXCPY=$$CALCMAX(DAYS)
 S VETMAX=$$VETMAX(CALCCPY,MAXCPY)
 Q
ASSET() ; Initialize asset amount by applying spend-down
 N NUM,MNYR,J,DONE,DAYS,ALLOW,CALCCPY,MAXCPY,VETMAX
 S DONE=0
 ; Calculate number of months to spend down the assets
 S NUM=(LOS-180)\30
 ; Get month to start spend down
 S MNYR=$$FMADD^XLFDT(EASADM,180)
 I NUM>0 F J=1:1:NUM D  Q:DONE
 .S DAYS=$$DOM(MNYR)
 .D CALCALL
 .S TAST=$$ASTSPD I TAST=0 S DONE=1 Q
 .S MNYR=MNYR+100 S:$E(MNYR,4,5)=13 MNYR=$E(MNYR,1,3)+1_"0100"
 Q TAST
ASTSPD() ;Asset Spend down for 180+ days
 Q:CPYFLG TAST
 I (TINC-TEXP-ALLOW)'>VETMAX D
 . I DGSP,SRIC S TAST=TAST-(VETMAX-(TINC-TEXP-ALLOW))
 . E  S TAST=TAST-(VETMAX-(TINC-ALLOW))
 . S:TAST<0 TAST=0
 Q TAST
 ;
CALCCPY() ; Calculate the Co-Pay Amount
 ;
 Q:CPYFLG 0
 Q:OVR180 TAST+TINC-ALLOW-TEXP
 Q TINC-ALLOW-TEXP
DOM(MNYR) ; Days in Month
 ; Returns: number of days in a month
 N DAYS,MN,YR
 S MN=+$E(MNYR,4,5)
 I "^4^6^9^11^"[("^"_MN_"^") S DAYS=30 Q DAYS
 I MN=2 D  Q DAYS
 .S DAYS=28
 .S YR=$E(MNYR,1,3)+1700
 .S:YR#4=0 DAYS=29
 S DAYS=31
 Q DAYS
CALCMAX(DAYS) ; Calculate the Maximum Co-Pay Amount
 ;
 Q $S(IPRPT:IPDR,1:OPDR)*DAYS
VETMAX(CALCCPY,MAXCPY) ; Calculate the Veteran Maximum Co-Pay Amount
 ;
 Q:CPYFLG MAXCPY
 Q:CALCCPY<0 0
 Q:CALCCPY<MAXCPY CALCCPY
 Q MAXCPY
 ;
NOTETXT ; Write the Note message
 W !!,"IMPORTANT NOTICE: The copayment amounts shown in this report are"
 W " estimates",!,"based on calculations of the copayment amount for "
 W "an entire month. The",!,"copayment amounts will be adjusted to "
 W "reflect the actual start date of LTC",!,"services and the "
 W "copayment exemption for the first 21 days of service. The VET",!
 W "COPAY amount is based on the assumption that the veteran "
 W "will be responsible",!,"to pay the lesser of EITHER the calculated"
 W " copayment (CALC COPAY) OR the",!,"maximum copayment (MAX COPAY).  "
 W "In the event that the calculated copayment",!,"(CALC COPAY) is a "
 W "negative figure, the veteran copayment (VET COPAY)",!
 W "will be adjusted to zero (0). If the veteran declined to provide"
 W " income",!,"information, the veteran will be obligated to pay the"
 W " maximum copayment."
 Q
 ;
SPNDDWN ; Text of message to explain the asset spend down
 W !!,"EXPLANATION OF ASSET SPEND DOWN CALCULATION:"
 W !,"============================================"
 W !,"The veteran's assets are included in the calculation of copayments"
 W !,"after 180 days of institutional LTC services.  The assets then may"
 W !,"be reduced each month according to the following formula:"
 W !
 W !,"Single Veteran:"
 W !
 W !,"  TOTAL ASSETS-(VET COPAY-(INCOME-ALLOWANCE))"
 W !
 W !,"Married Veteran (spouse residing in the community):"
 W !
 W !,"  TOTAL ASSETS-(VET COPAY-(INCOME-EXPENSES-ALLOWANCE))"
 W !
 W !,"In other words, the assets will be reduced by the amount of the"
 W !,"veteran's copayment that is not covered by the veteran's income "
 W !,"after all expenses and allowances are subtracted.  If the amount"
 W !,"of the veteran's income after all expenses and allowances are"
 W !,"subtracted is greater than the veteran's copayment then the assets"
 W !,"will not be reduced."
 W !
 Q
