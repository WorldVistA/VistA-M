EASECCAL ;ALB/LBD - Calculate LTC copayment ;27 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7,19,34,39,40**;Mar 15, 2001
 ;
 ; Input --   DFN    Patient IEN
 ;            MNTH   Last day of month for the LTC copay calculation
 ;                    in FM format (e.g. 3020131)
 ;            LOS    (Length of stay) The number of days in the patient's
 ;                    LTC episode
 ; Output --  COPAY  String containing copayment calculation
 ;                    = 0: no completed LTC copay test on file
 ;                    piece 1: LTC copay test status
 ;                               (1=Exempt; 2=Non-Exempt)
 ;                          2: If Exempt, Reason for Exemption
 ;                               (IEN to file #714.1)
 ;                          3: Calculated LTC copayment for IP 
 ;                               (1-180 days)
 ;                          4: Calculated LTC copayment for IP
 ;                               (181+ days)
 ;                          5: Calculated LTC copayment for OP
 ;
COPAY(DFN,MNTH,LOS) ;
 N COPAY,DAYS,MX,IPDR,OPDR,IPMAX,OPMAX,LST,DGMT,DGMTI,DGMTDT,DGSTA,DGEXR
 N ERR,X1,X2,INC,EXP,AST,ALLOW,DGSP,SRIC
 S COPAY=0
 I 'DFN!('MNTH) G Q
 S LOS=+$G(LOS),DAYS=$E(MNTH,6,7)
 ; Get maximum daily rate for LTC copayments
 ; DBIA #3717
 S MX=$$MAXRATE^IBAECU(MNTH),OPDR=$P(MX,U),IPDR=$P(MX,U,2) I 'OPDR!('IPDR) G Q
 ; Calculate maximum copayment for the month
 S OPMAX=DAYS*OPDR,IPMAX=DAYS*IPDR
 ; Get last completed LTC copay test
 S LST=$$LST^EASECU(DFN,MNTH,3) I +LST=0 G Q
 S DGMTI=$P(LST,U),DGMT(0)=$G(^DGMT(408.31,DGMTI,0)) I 'DGMT(0) G Q
 S DGMTDT=+DGMT(0),DGSTA=$P($G(^DG(408.32,+$P(DGMT(0),U,3),0)),U,1)
 S DGEXR=$P($G(^DGMT(408.31,DGMTI,2)),U,7)
 ; If LTC copay test status is neither NON-EXEMPT nor EXEMPT, quit
 I DGSTA'="NON-EXEMPT",DGSTA'="EXEMPT" G Q
 ; If LTC copay test is more than a year old and the veteran does
 ; not have an exemption for eligibility (Compensable SC) or LTC
 ; before 11/30/99, quit  (Added for LTC Phase III - EAS*1*34)
 ;S X1=MNTH,X2=DGMTDT D ^%DTC I X>365,"^1^4^"'[(U_DGEXR_U) G Q
 S COPAY=$S(DGSTA="EXEMPT":1,1:2)_U
 ; If test status = 'EXEMPT', get Reason for Exemption
 I DGSTA="EXEMPT" S COPAY=COPAY_DGEXR
 ; If veteran declined to give financial info, copay = max monthly copay
 I $P(DGMT(0),U,14) S COPAY=COPAY_U_IPMAX_U_IPMAX_U_OPMAX G Q
 ; Get total income, assets and expenses for veteran (and spouse)
 D FINTOT I $G(ERR) D  G Q
 .I +COPAY=1 Q
 .;no financial data but veteran agreed to pay copayments, copay = max
 .I $P(DGMT(0),U,11) S COPAY=COPAY_U_IPMAX_U_IPMAX_U_OPMAX Q
 .S COPAY=0
 ; Calculate copayments
 D CALC
Q ; Quit and return COPAY
 Q COPAY
 ;
FINTOT ; Get total income, assets and expenses for veteran (and spouse)
 N DGDC,DGDEP,DGDET,DGERR,DGIN0,DGIN1,DGIN2,DGINI,DGINT,DGINTF,DGIRI
 N DGNC,DGND,DGNWT,DGNWTF,DGPRI,DGVINI,DGVIR0,DGVIRI
 S ERR=0
 S DGPRI=$O(^DGPR(408.12,"C",DFN_";DPT(",0)) I 'DGPRI S ERR=1 Q
 D GETIENS^EASECU2(DFN,DGPRI,DGMTDT) I '$G(DGIRI),'$G(DGINI) S ERR=1 Q
 S DGVIRI=DGIRI,DGVINI=DGINI
 D DEP^EASECSU3
 D INC^EASECSU3
 I DGINT=0,DGDET=0,DGNWT=0 S ERR=1 Q
 ; Does spouse reside in community?
 S SRIC=$P(DGVIR0,U,16)
 ; Divide income and expense totals by 12 to get monthly amounts
 S INC=DGINT/12,EXP=DGDET/12,AST=DGNWT
 ; Calculate total monthly allowance:
 ; 20*number of days in month*(veteran+spouse(if married and spouse
 ;   resides in the community))
 S ALLOW=20*DAYS*(1+SRIC)
 Q
 ;
CALC ; Calculate copayments
 N CCPY,OPCPY,IPCPY1,IPCPY2,TINC,TEXP,TAST,OVR180,IPRPT,CPYFLG,EASADM
 ; Calculation for IP services up to 180 days and OP services:
 ;   Income-Allowance-Expenses
 S CCPY=INC-ALLOW-EXP
 S (OPCPY,IPCPY1)=$S(CCPY>0:(CCPY+.5)\1,1:0)
 ; Calculation for IP services 181+ days, add in assets
 S IPCPY2=0 I LOS>180 D
 . S TEXP=0 I DGSP,SRIC S TEXP=TEXP+EXP
 . S TINC=INC,TAST=AST,(OVR180,IPRPT)=1,CPYFLG=0
 . S EASADM=$$FMADD^XLFDT(MNTH,-LOS)
 . ; Get value of assets after spenddown is applied
 . S TAST=$$ASSET^EASECPC1
 . S CCPY=CCPY+TAST
 . ;If veteran is single or spouse does not reside in the community,
 . ;add expenses back in
 . I 'DGSP!('SRIC) S CCPY=CCPY+EXP
 . S IPCPY2=(CCPY+.5)\1 I IPCPY2<0 S IPCPY2=0
 S COPAY=COPAY_U_IPCPY1_U_IPCPY2_U_OPCPY
 Q
