DGBTUTL ;ALB/SCK - BENEFICIARY/TRAVEL UTILITY ROUTINES; 1/6/93@1130 ;11/14/11  09:58
 ;;1.0;Beneficiary Travel;**20**;September 25, 2001;Build 185
START ;
 Q
MILES(DGBTRN,DGBTDX) ;
 ; DGBTRN holds the record no., and DGBTDX holds the division pointer passed in during the function call
 N DGBTML,XX,DGBTCHK
 S XX="",(DGBTML,DGBTDEF)=0
 F XX=0:0 S XX=$O(^DGBT(392.1,DGBTRN,1,XX)) Q:+XX'>0!(DGBTML>0)  D
 . S DGBTCHK=$P($G(^DGBT(392.1,DGBTRN,1,XX,0)),U,1) I DGBTDX=DGBTCHK S DGBTML=$P($G(^(0)),U,2)
 I DGBTML'>0 S DGBTML=$P($G(^DGBT(392.1,DGBTRN,0)),U,3),DGBTDEF=1
 K DGBTRN,DGBTDX
 Q DGBTML
DICLKUP(DGBTRN,DGBTDX,DGBTP) ;
 N RETURN,XX
 S DIC="^DGBT(392.1,DGBTRN,1,",DIC(0)="MZX",X=DGBTDX,RETURN=""
 D ^DIC
 I +Y>0 D
 . I DGBTP=4 S RETURN=$S(+$P($G(Y(0)),U,4)>0:$P($G(Y(0)),U,5),1:"")
 . I DGBTP=3 S RETURN=$S(+$P($G(Y(0)),U,3)>0:$P(^(0),U,3),1:0)
 Q RETURN
DEPCTY(ZIPCDE) ;
 N RETURN
 S DIC="^DGBT(392.1,",DIC(0)="MZ",X=$S($L(ZIPCDE)>5:$E(ZIPCDE,1,5),1:ZIPCDE) D ^DIC S RETURN=Y K DIC
 K ZIPCDE
 Q RETURN
 ;
DWAIVER(DFN,DGBTDCV,CLIEN) ;Get Deductible Waiver ***PAVEL
 ;DFN - Patient IEN
 ;DGBTDCV - Deductible amount
 ;CLIEN - Ien of current BT Claim
 N VAEL,DGBTMW,EXIT,DGBTRDV
 S EXIT=0
 ;added by bld to correct problem with manual waiver's
 I $D(DGBTRET(0)),$P(DGBTRET(0),"^",6)="MAN" Q "0^Manual Waiver"
 I $D(^DGBT(392.7,"C",DFN)) D  Q:EXIT "0^Manual Waiver"
 .S EXIT=0,DGBTMW=CLIEN+0.00001
 .F  S DGBTMW=$O(^DGBT(392.7,"C",DFN,DGBTMW),-1) Q:'DGBTMW!EXIT  D
 ..Q:$P(^DGBT(392.7,DGBTMW,0),"^",3)'=1      ;Waiver not Authorized
 ..Q:$D(^DGBT(392.7,DGBTMW,"DEL"))     ;Waiver deleted
 ..I $P(^DGBT(392.7,DGBTMW,0),"^",7)="PENSION" S EXIT=1 Q      ;Waiver never expire
 ..Q:$P(CLIEN,".",1)>$P(^DGBT(392.7,DGBTMW,0),"^",7)      ;Waiver expired
 ..S EXIT=1       ;Waiver found.
 .Q
 D ELIG^VADPT
 I $$WVELG^DGBT1 Q "0^VA Pension"
 I $P(DGBTINC,U,2)="H" Q "0^Alt Income Hardship"
 I $P(DGBTINC,U,2)="P" Q "0^Alt Income POW"
 I $G(DAYFLG)&('$G(DGBTREF))&(DGBTNSC)&($P($G(DGBTINC),"^",1)'="")&(+$TR($P(DGBTINC,U),"$,","")<DGBTRXTH) Q "0^NSC Low Income"
 I $G(DGBTREF)&(DGBTNSC) Q "0^Patient refuse to provide financial information"
 I '$G(DAYFLG) Q "0^Patient has expired Means Test or Co-Pay Test"
 ;Output:
 ;VAEL(4) If the VETERAN (Y/N)? field is YES, a "1" will be returned; otherwise, a "0" will be returned. (e.g., 1)
 I 'VAEL(4) Q "0^NO Veteran"
 N INCOME,X0,X1,X2,XX,MTEST
 N VAMB D MB^VADPT
 N LI
 ;Output:
 ;VAMB(1) A&A BENEFITS? field is YES, a "1" will be returned in the first piece; otherwise, a "0".
 ; If receiving A&A benefits, the TOTAL ANNUAL VA CHECK AMOUNT will be returned in the second piece. (e.g., 1^1000)
 ;VAMB(2) HOUSEBOUND BENEFITS? field is YES, a "1" will be returned in the first piece; otherwise, a "0".
 ; If receiving housebound benefits, the TOTAL ANNUAL VA CHECK AMOUNT will be returned in the second piece.
 ;(e.g., 1^0) ;VAMB(4) VA PENSION? field is YES, a "1" will be returned in the first piece; otherwise, a "0" .
 ; If receiving a VA pension, the TOTAL ANNUAL VA CHECK AMOUNT will be returned in the second piece. (e.g., 1^563.23)
 I VAMB(4),VAMB(1) Q "0^VA Pension and A&A"
 I VAMB(4),VAMB(2) Q "0^VA Pension and HB"
 I VAMB(4) Q "0^VA Pension"
 ;Is the mode of transportation :Common Carrier ?
 S LI=0
 I '$G(DGBTREF) S XX=$$LI(DFN,DGBTDTI,DGBTDEP,,DGBTINCA) ;Get Low Income + Hardship
 I $G(DGBTMLT)=0 S XX=0
 I '$G(XX),$G(DGBTCCMODE)'="",$G(DGBTCCREQ),$G(DGBTMLT) Q "0^Mode of transportation is Common Carrier/With Mileage"
 I '$G(XX),$G(DGBTCCMODE)'="",$G(DGBTCCREQ) Q "0^Mode of transportation is Common Carrier"
 Q $S(+$G(XX):"0^"_$P($G(XX),U,2),1:DGBTDCV)
 ;
GA(DFN,AA,DGBTDTI,AB) ;Get Alternate Income on file
 ;@AA= 0^    = no Valid Alternate Income
 ;@AA= 1^Alt Income^Date Alt. Income Entered^Reason: Hardship or POW^Expiration date
 ;@AB(I)=1^Alt Income^Date Alt. Income Entered^Reason: Hardship or POW^Expiration date   - Expire income
 ;Example:  @AA=1^7777.7^3120501.203728^H^3121231
 ;FDA(392.9,"7171872,",.01,"I")="7171872"
 ;FDA(392.91,"3120423.211054,7171872,",.01,"I")=3120423.211054
 ;FDA(392.91,"3120423.211054,7171872,",1,"I")=12345.67
 ;FDA(392.91,"3120423.211054,7171872,",2,"I")="H"
 ;FDA(392.91,"3120423.211054,7171872,",3,"I")=3121231
 N FDA,X0,X,Y,I,FDD,AC
 S @AA="0^" ;S XX(3)="0^"
 D GETS^DIQ(392.9,DFN_",","**","I","FDA","DGBTERR")
 S X0=$G(FDA(392.9,DFN_",",.01,"I"))
 Q:'$L(X0)!'$G(DGBTDTI)
 S X0="" F  S X0=$O(FDA(392.91,X0)) Q:'$L(X0)  S X=$P(X0,",",1) M FDD(392.91,X)=FDA(392.91,X0)
 S X0=DGBTDTI+0.000001
 F  S X0=$O(FDD(392.91,X0),-1) Q:'X0  D  Q:+@AA  ;Quit If Alternate income found
 .Q:DGBTDTI>$G(FDD(392.91,X0,3,"I"))  ;Alternate Income Expired continue search
 .S @AA="1^"_$G(FDD(392.91,X0,1,"I"))_U_X0_U_$G(FDD(392.91,X0,2,"I"))_U_$G(FDD(392.91,X0,3,"I"))
 .K FDD(392.91,X0)
 I $D(FDD),$L($G(AB)) D
 .S AB=$S($E(AB,$L(AB))=")":$E(AB,1,$L(AB)-1)_",",1:AB_"(")
 .S X0=0 F I=1:1 S X0=$O(FDD(392.91,X0)) Q:'X0  S AC=AB_I_")",@AC="1^"_$G(FDD(392.91,X0,1,"I"))_U_X0_U_$G(FDD(392.91,X0,2,"I"))_U_$G(FDD(392.91,X0,3,"I"))
 Q
LI(DFN,DGBTDTI,DGBTDEP,FLAG,DGBTINCA) ;Low Income
 ;DGBTDEP = # of Dependence
 ;FLAG = 1 Indication if printable Income value returned in DGBTINC and Income Type Type in DGBTIFL
 ;DGBTINCA = Possible Alternate income set for the VA Patient
 ;             1^alt income^date^alt. income reason POW or HARDSHIP^expiration date
 ;DGBTRET = RETURN VALUE:
 ;           0^
 ;           1^Low Income Copay
 ;           2^Low Income M Test
 ;           3^Alt. Income POW
 ;           4^Alt. Income Hardship
 N INCOME,X,X0,X2,X3,Y,MTEST,DGBTRET
 S DGBTRET="0^"
 I $G(DGBTREF) Q DGBTRET
 I '$G(DAYFLG) Q DGBTRET
 I '$G(FLAG) N DGBTINC,DGBTIFL
 S DGBTINCA=$G(DGBTINCA,"0^")
 S (Y,INCOME)=$$INCOME^VAFMON(DFN,DGBTDTI,1)
 I '$G(DGBTDYFL) S (Y,INCOME)="0^"
 S:DGBTINCA (Y,INCOME)=$P(DGBTINCA,U,2)_U_$E($P(DGBTINCA,U,4))
 S X=$P(Y,U),DGBTIFL=$P(Y,U,2) ; returns income & source.
 I DGBTIFL["I^V" S (DGBTINC,DGBTIFL,X,Y)="" Q DGBTRET ;Ignore if Income type is I or V
 I X?1N.E!(X<0) D
 .I X<0 S X=0
 .S X2="0$",X3=8 D COMMA^%DTC
 S DGBTINC=X_U_$G(DGBTIFL)
 I $G(DGBTINCA) Q $S($P(DGBTINCA,U,4)="P":"3^Alt. Income POW",1:"4^Alt. Income Hardship")
 I $P(INCOME,U,2)="C" D  Q:$G(DGBTRET) $G(DGBTRET)  ;Copay income
 .S INCOME=+$G(INCOME)
 .I $G(DGBTRXTH),'($G(INCOME)>$G(DGBTRXTH)) S DGBTRET="1^Low Income Copay"
 ;Get the patient Means Test for corresponding data and see if patient is M-test Low Income.
 S MTEST=+$$LST^DGMTU(DFN,DGBTDTI,1) Q:'MTEST DGBTRET ;Get last Means test
 I $G(DGBTRXTH),'($G(INCOME)>$G(DGBTRXTH)) Q "2^Low Income M Test"                                ;change by bld 10/9/2012@2346
 Q $G(DGBTRET)
 ;
EXIT ;
 Q
TEST ;
 W !,"DATE/TIME REQUIRED.."
 S X="OLD",DTOUT=1
 Q
 ;
ABP(DGBTU) ;Function returns date if patient has an active bus pass. Function added in patch 20
 N DATE,IEN,EXPDT
 S DATE=0,IEN=0,EXPDT=0
 F  S DATE=$O(^DGBT(392,"AI",DGBTU,DATE)) Q:'+DATE  S IEN=^DGBT(392,"AI",DGBTU,DATE) I $D(^DGBT(392,IEN,"B"))&($P($G(^DGBT(392,IEN,"B")),U,2)'<DT) S EXPDT=$P(^("B"),U,2) Q
 Q EXPDT
 ;
MHELP ;help text for Mileage/One Way field. Field 32 file 392.
 ;
 ;
 W !,?5,"If patient used a common carrier, then the mileage entered here would be"
 W !,?5,"only the mileage needed to get to the common carrier pick up point.",!
 Q
 ;
PAUSE(EXCEL) ;
 ;
 N DIR,PROMPT,PROMPT1,PROMPT2,PROMPT3
 K Y
 S EXCEL=$G(EXCEL)
 S PROMPT1="REPORT HAS FINISHED, "
 I IOST'["C-" S DGBTQ=1 W !!!,PROMPT1 Q ""                                ;quit if sent to a printer
 S PROMPT2="TURN OFF CAPTURE, THEN "
 S PROMPT3="PRESS RETURN TO CONTINUE OR '^' TO STOP...."
 I EXCEL S PROMPT=PROMPT1_PROMPT2_PROMPT3
 I 'EXCEL S PROMPT=PROMPT3
 W !
 S DIR("A")=PROMPT,DIR(0)="FAO" D ^DIR
 Q Y
 ;
YESNO(PROMPT) ;
 ;
 K DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="Y",DIR("B")="YES",DIR("?")="ENTER Y(ES) OR N(O)"
 I $G(PROMPT)'="" S DIR("A")=PROMPT
 D ^DIR K DIR I $D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) Q 0
 Q Y
 ;
DEVICE(RPTNAM,ROUTINE,DGBTEXCEL,COLWID) ;common device call for DGBT reports
 ;
 N %ZIS,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE,POP,ZTQUEUED
 ; RPTNAM = NAME OF DGBT REPORT BEING RUN
 ; ROUTINE = "TAG^ROUTINE"
 ;
 S DGBTQ1=0
 S %ZIS="PQM"
 D ^%ZIS
 I POP S DGBTQ=1 Q
 I IOST["C-" D  Q  ;
 .N X I IOM=255,$D(^%ZOSF("RM")) S (X,IOM)=512 X ^%ZOSF("RM")
 ;Check for exit
 I $G(IO("Q"))  D  S DGBTQ=1
  .S ZTRTN=ROUTINE
 .S ZTDESC="BT REPORT: "_RPTNAM
 .S ZTSAVE("*")=""
 .D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .D HOME^%ZIS K IO("Q")
 Q
 ;
SELEXCEL() ; - Returns whether to capture data for Excel report.
 ; Output: EXCEL = 1 - YES (capture data) / 0 - NO (DO NOT capture data)
 ;
 N EXCEL,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 ;
 S DIR(0)="Y",DIR("B")="NO",DIR("T")=DTIME W !
 S DIR("A")="Do you want to capture report data for an Excel document"
 S DIR("?")="^D HEXC^DGBTUTL"
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q "^"
 K DIROUT,DTOUT,DUOUT,DIRUT
 S EXCEL=0 I Y S EXCEL=1
 ;
 ;Display Excel display message
 I EXCEL=1 D EXMSG
 ;
 Q EXCEL
 ;
HEXC ; - 'Do you want to capture data...' prompt
 W !!,"      Enter:  'Y'    -  To capture detail report data to transfer"
 W !,"                        to an Excel document"
 W !,"              '<CR>' -  To skip this option"
 W !,"              '^'    -  To quit this option"
 Q
 ;
PRINTMSG ;common help message if user selects a printer
 ;
 W !!,"WARNING - THIS REPORT REQUIRES THAT A DEVICE WITH ",COLWID," COLUMN WIDTH BE USED."
 W !,"IT WILL NOT DISPLAY CORRECTLY USING 80 COLUMN WIDTH DEVICES",!
 Q
 ;
EXMSG ;common help message if user selects Excel option
 W !!?5,"Before continuing, please set up your terminal to capture the"
 W !?5,"detail report data. On some terminals, this can  be  done  by"
 W !?5,"clicking  on the 'Tools' menu above, then click  on  'Capture"
 W !?5,"Incoming  Data' to save to  Desktop. This  report  may take a"
 W !?5,"while to run."
 W !!?5,"Note: To avoid  undesired  wrapping of the data  saved to the"
 W !?5,"      file, please enter '0;512;999' at the 'DEVICE:' prompt.",!
 Q
 ;
RDV(DGBTRDV,DGBTDTI) ;this will process the remote sites for visits during current month.
 ;
 q
 N DGBTIEN,CURDATE,LASTVISIT
 S DGBTIEN=0
 S CLMMONTH=$E(DGBTDTI,1,5)
 F  S DGBTIEN=$O(DGBTRDV(DGBTIEN)) Q:DGBTIEN=""  D
 .S VISITDATA=DGBTRDV(DGBTIEN)
 .S LASTVISIT=$E($P(VISITDATA,"^",3),1,5)
 .Q:LASTVISIT'=CLMMONTH
 ;
 Q
NMRNG(PATNAME,SNAME,ENAME,RESULT) ;
 I (SNAME="AAA"),(ENAME="ZZZ") Q 1
 N DONE,I,LEN1,LEN2,PNAM
 S PNAM=$$UP^XLFSTR(PATNAME)
 I '$$SNAM(PNAM,$$UP^XLFSTR(SNAME)) Q 0
 Q $$ENAM(PNAM,$$UP^XLFSTR(ENAME))
SNAM(PNAM,SNAM) ;
 I SNAM="AAA" Q 1
 S LEN1=$L(PNAM),LEN2=$L(SNAM),DONE=0
 F I=1:1:$S(LEN1<LEN2:LEN1,1:LEN2) D  Q:DONE
 .I $E(PNAM,I)]$E(SNAM,I) S DONE=1 Q
 .I $E(PNAM,I)=$E(SNAM,I) Q
 .S RESULT=0,DONE=1
 Q RESULT
ENAM(PNAM,ENAM) ;
 I ENAM="ZZZ" Q 1
 S LEN1=$L(PNAM),LEN2=$L(ENAM),DONE=0
 F I=1:1:$S(LEN1<LEN2:LEN1,1:LEN2) D  Q:DONE
 .I $E(ENAM,I)]$E(PNAM,I) S DONE=1 Q
 .I $E(ENAM,I)=$E(PNAM,I) Q
 .S RESULT=0,DONE=1
 Q RESULT
 ;
DRDV(DFN,DGBTDCV,DGBTDTI,DLM) ;Used in remote data view to get local Deductible
 N I,DGBTDCM
 S DLM=$G(DLM,";") ;Output Delimiter
 S DGBTDCM=0 ;Cumulative of Deductible
 ;Get Ded. paid.
 S I=$E(DGBTDTI,1,5)_"00.2399"
 F  S I=$O(^DGBT(392,"C",DFN,I)) Q:'I!($E(I,1,5)>$E(DGBTDT,1,5))  S:$P($G(^DGBT(392,I,1)),U,2)'=15 DGBTDCM=DGBTDCM+($P(^DGBT(392,I,0),"^",9))
 S I=$$DWAIVER(DFN,DGBTDCV,DGBTDTI)
 ;Q Site;Ded paid;0 if ded reset to 0; Why deductible reset to 0 
 Q $G(DUZ(2))_DLM_DGBTDCM_DLM_$P(I,U,1)_DLM_$P(I,U,2)
 Q
 ;
NSC() ;
 I VAEL(1)["NSC" Q 1
 N HIT
 S (HIT,I)=""
 F  S I=$O(VAEL(1,I)) Q:I=""  D  Q:HIT
 .I VAEL(1,I)["NSC" S HIT=1
 Q HIT
 ;
DAYFLAG() ; See if we have a valid income test
 N MTIEN,STATUS
 S MTIEN=$O(^DGMT(408.31,"C",DFN,""),-1)
 I MTIEN="" Q 0
 S STATUS=$P($$MTS^DGMTU(DFN,$$GET1^DIQ(408.31,MTIEN,.03,"I")),U,2)
 I (STATUS?1A)&("LN"[STATUS) Q 0
 Q $$FMDIFF^XLFDT($P(DGBTDTI,"."),$$GET1^DIQ(408.31,MTIEN,.01,"I"))'>365
