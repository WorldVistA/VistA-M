IBJDF61 ;ALB/RB - MISC. BILLS FOLLOW-UP REPORT (COMPILE) ;15-APR-00
 ;;2.0;INTEGRATED BILLING;**123,159,356**;21-MAR-94
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ST ; - Tasked entry point.
 K IB,IBCAT,^TMP("IBJDF6P",$J),^TMP("IBJDF6D",$J) S IBQ=0
 ;
 ; - Set selected categories for report.
 I IBSEL[",1," S IBCAT(21)=1        ; MEDICARE
 I IBSEL[2 S IBCAT(7)=2             ; NO-FAULT AUTO ACCIDENT
 I IBSEL[3 S IBCAT(10)=3            ; TORT FEASOR
 I IBSEL[4 S IBCAT(6)=4             ; WORKMEN'S COMP
 I IBSEL[5 S IBCAT(16)=5            ; CURRENT EMPLOYEE
 I IBSEL[6 S IBCAT(15)=6            ; EX-EMPLOYEE
 I IBSEL[7 S IBCAT(13)=7            ; FEDERAL AGENCIES-REFUND
 I IBSEL[8 S IBCAT(14)=8            ; FEDERAL AGENCIES-REIMBURSEMENT
 I IBSEL[9 S IBCAT(20)=9            ; MILITARY
 I IBSEL[10 S IBCAT(12)=10          ; INTERAGENCY
 I IBSEL[11 S IBCAT(17)=11          ; VENDOR
 ;
 ; Initialize the Summary Information
 S IBCAT="" F  S IBCAT=$O(IBCAT(IBCAT)) Q:IBCAT=""  D
 . S IBDIV=0
 . I IBSDV," 6 7 10 21 "[(" "_IBCAT_" ") D  Q
 . . F  S IBDIV=$O(VAUTD(IBDIV)) Q:IBDIV=""  D INIT^IBJDF63
 . D INIT^IBJDF63
 ;
 ; - Print the header line for the Excel spreadsheet
 I $G(IBEXCEL) D PHDL
 ;
 ; - Find data required for the report.
 S IBA=0 F  S IBA=$O(^PRCA(430,"AC",16,IBA)) Q:'IBA  D  Q:IBQ
 . I IBA#100=0 D  Q:IBQ
 . . S IBQ=$$STOP^IBOUTL("Miscellaneous Bills Follow-Up Report")
 . S IBAR=$G(^PRCA(430,IBA,0)) Q:'IBAR
 . S IBCAT=+$P(IBAR,U,2) Q:'$D(IBCAT(IBCAT))  ;     Invalid AR category.
 . S IBCAT1=IBCAT(IBCAT) I IBCAT1<5,'$D(^DGCR(399,IBA,0)) Q  ; No claim.
 . I IBCAT1<5,$P($G(^DGCR(399,IBA,0)),U,13)=7 Q  ;      Cancelled claim.
 . ;
 . ; - Get division, if necessary.
 . I IBCAT1>4 S IBDIV=0
 . E  D
 . . I 'IBSDV S IBDIV=0
 . . E  S IBDIV=$$DIV^IBJDF51(IBA)
 . ;
 . I IBSDV,IBDIV,'VAUTD Q:'$D(VAUTD(IBDIV))  ; Not a selected division.
 . ;
 . ; - Get patient or debtor for report.
 . I IBRPT="D" S IBPTDB=$$PTDB(IBA) Q:IBPTDB=""
 . ;
 . ; - Check the receivable age, if necessary.
 . I IBRPT="D",IBSMN D  I (IBARD)<IBSMN!(IBARD>IBSMX) Q
 . . S IBARD=+$$ACT^IBJDF2(IBA) S:IBARD IBARD=$$FMDIFF^XLFDT(DT,IBARD)
 . ;
 . ; - Check the minimum balance amount, if necessary.
 . S IBBA=0 F X=1:1:5 S IBBA=IBBA+$P($G(^PRCA(430,IBA,7)),U,X)
 . I IBRPT="D",IBSAM,IBBA<IBSAM Q
 . ;
 . ; - Get stats for summary
 . I '$G(IBEXCEL) D EN^IBJDF63 Q:IBRPT="S"
 . ;
 . ; - Get remaining AR/claim info and set indexes for detailed report.
 . S (IBFR,IBLP,IBOI,IBTO,IBCLM)="",IBIN=0
 . S IBBN=$P(IBAR,U),IBOR=$P(IBAR,U,3),IBDP=$P(IBAR,U,10)
 . I IBCAT1<5 D  Q:'IBI!('IBCLM)
 . . S IBI=+$G(^DGCR(399,IBA,"MP")) Q:'IBI  ; Get primary ins carrier.
 . . S IBIN=$P($G(^DIC(36,IBI,0)),U)_"@@"_IBI,DFN=$P($P(IBPTDB,U),"@@",2)
 . . S IBDP=$P(IBAR,U,10),IBCLM=$$CLMACT^IBJD(IBA,IBCAT) Q:IBCLM=""
 . . S IBR=$S(+IBCLM=1:$G(^IB($P(IBCLM,U,2),0)),+IBCLM=2:$G(^DGCR(399,IBA,"U")),1:IBDP)
 . . S IBFR=$P(IBR,U,$S(+IBCLM=1:14,1:1)),IBTO=$P(IBR,U,$S(+IBCLM=1:15,+IBCLM=2:2,1:1))
 . . S IBOI=$$OTH(DFN,$P(IBIN,"@@",2),IBFR) ; Get other insurance carrier.
 . . I $G(IBEXCEL) Q
 . . I '($D(^TMP("IBJDF6P",$J,IBDIV,IBCAT,IBIN,$P(IBPTDB,U)))#10) D
 . . . S ^TMP("IBJDF6P",$J,IBDIV,IBCAT,IBIN,$P(IBPTDB,U))=$P(IBPTDB,U,2)_" "_$P(IBPTDB,U,6)_U_$P(IBPTDB,U,3,4)_U_IBOI
 . . S ^TMP("IBJDF6P",$J,IBDIV,IBCAT,IBIN,$P(IBPTDB,U),IBBN)=IBDP_U_IBFR_U_IBTO_U_IBOR_U_IBBA
 . E  D
 . . S IBLP=+$P($$PYMT^IBJD1(IBA),U,2)
 . . I '($D(^TMP("IBJDF6D",$J,IBDIV,IBCAT,0,$P(IBPTDB,U)))#10) D
 . . . S ^TMP("IBJDF6D",$J,IBDIV,IBCAT,0,$P(IBPTDB,U))=$P(IBPTDB,U,2)_" "_$P(IBPTDB,U,6)
 . . S ^TMP("IBJDF6D",$J,IBDIV,IBCAT,0,$P(IBPTDB,U),IBBN)=IBDP_U_$P(IBPTDB,U,5)_U_IBOR_U_IBLP_U_IBBA
 . ;
 . I '$G(IBEXCEL) D:IBSH COM Q
 . ;
 . ; - Set up and write line for Excel document.
 . S IBDIV=$P($G(^DG(40.8,$S('IBDIV:+$$PRIM^VASITE(),1:IBDIV),0)),U)
 . S IBEXCEL1=IBDIV_U_$P($G(^PRCA(430.2,IBCAT,0)),U,2)_U_$S(IBIN=0:"",1:$P(IBIN,"@@"))
 . S IBEXCEL1=IBEXCEL1_U_$P(IBPTDB,U,2)_U_$S($P(IBPTDB,"^",6)="*":"E",1:"")_U_$TR($P(IBPTDB,U,4),"-")
 . S IBEXCEL1=IBEXCEL1_U_$P(IBPTDB,U,3)_U_IBOI_U_IBBN_U_$$DT^IBJD(IBDP,1)
 . S IBEXCEL1=IBEXCEL1_U_$$DT^IBJD(IBFR,1)_U_$$DT^IBJD(IBTO,1)_U_IBOR
 . S IBEXCEL1=IBEXCEL1_U_IBLP_U_IBBA_U
 . I IBSH D COM   ;  This will capture the Last Comment Date
 . S IBD=$$FMDIFF^XLFDT(DT,$S('$P(IBEXCEL1,U,17):IBDP,1:$G(DAT)))
 . S IBEXCEL1=IBEXCEL1_U_IBD W !,IBEXCEL1 K IBD,IBEXCEL1
 ;
 I 'IBQ,'$G(IBEXCEL) D EN^IBJDF62 ; Print the report.
 ;
ENQ K ^TMP("IBJDF6P",$J),^TMP("IBJDF6D",$J)
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IBA,IBA1,IBAR,IBARD,IBCAT,IBCAT1,IBDIV,IBD,IBI,IBIN,IBQ,IBR,IBOI,IBBA
 K IBBN,IBCLM,IBDP,IBEXCEL,IBFR,IBLP,IBOR,IBPTDB,IBTO,IBTYP,COM
 K COM1,DAT,DFN,J,X,X1,X2,Y,Z
 Q
 ;
PTDB(X) ; - Find Patient/Debtor and decide to include the AR.
 ;    Input: X=Pointer to the AR in file #430 plus all IBS* variables
 ;   Output: Y=Sort key (name or last 4) and Patient/Debtor IEN(file #2) 
 ;             ^ Patient/Debtor name (1st 25 chars) ^ Age ^ SSN
 ;             ^ Processed by (File #200) ^ Current VA Employee? (*=Yes)
 N AGE,ALL,ARZ,CAT,DEB,DA,DFN,DIC,DIQ,DR,END,IBZ,INI,KEY,NAME,PRC,SSN
 N VA,VADM,VAERR,Y
 ;
 S Y="" I '$G(X) G PDQ
 S DFN=0,ARZ=$G(^PRCA(430,X,0)),CAT=$P(ARZ,"^",2)
 S (NAME,AGE,SSN,PRC)=""
 ;
 ; - Look for Patient(Medicare,Tort Feasor,Work's Comp,No-Fault Auto Acc)
 I " 6 7 10 21 "[(" "_CAT_" ") D  I 'DFN S Y="" G PDQ
 . I '$D(^DGCR(399,X,0)) Q
 . S IBZ=^DGCR(399,X,0),DFN=+$P(IBZ,"^",2)
 . S INI=IBSNF,END=IBSNL,ALL=IBSNA
 . D DEM^VADPT S NAME=VADM(1),SSN=$P(VADM(2),"^",2),AGE=VADM(4)
 . S KEY=$S(IBSN="N":NAME,1:$P(SSN,"-",3))
 ;
 ; - Look for Debtor (All the other Categories)
 I " 6 7 10 21 "'[(" "_CAT_" ") D  I 'DFN S Y="" G PDQ
 . S DIC="^PRCA(430,",DA=X,DR="9;97",DIQ="DEB" D EN^DIQ1
 . S DFN=+$P(ARZ,"^",9) I 'DFN Q
 . S NAME=$G(DEB(430,DA,9)),PRC=$G(DEB(430,DA,97)),KEY=NAME
 . S DIC="^RCD(340,",DA=DFN,DR="110",DIQ="DEB" D EN^DIQ1
 . S SSN=$G(DEB(340,DA,110))  S:SSN=-1 SSN=""
 . S INI=IBSDF,END=IBSDL,ALL=IBSDA
 ;
 I (INI'="@"&('DFN)) S Y="" G PDQ
 I ALL="ALL"&('DFN)!(ALL="NULL"&(DFN)) S Y="" G PDQ
 I INI="@",END="zzzzz" G PDC
 I INI]KEY!(KEY]END) S Y="" G PDQ
 ;
 S KEY=KEY_"@@"_DFN
PDC S Y=KEY_U_$E(NAME,1,25)_U_AGE_U_SSN_U_PRC_U_$$VAEMP(+$TR(SSN,"-"))
PDQ Q Y
 ;
PHDL ; - Print the header line for the Excel spreadsheet
 N X
 S X="Division^Cat.^Prim.Ins.Carrier^Patient/Debtor^VA Empl.?^SSN^Age^"
 S X=X_"Other Ins.Carrier^Bill #^Dt Bill prep.^Bill From Dt^Bill To Dt^"
 S X=X_"Orig.Amt^Lst Pymt Amt^Curr.Bal.^Lst Comm.Dt^Days Lst Comm."
 W !,X
 Q
 ;
VAEMP(SSN) ; - Check if the Patient/Debtor is a current VA Employee
 ; Input:   SSN - Patient/Debtor Social Security Number
 ;Output: VAEMP - "*":Current VA Employee / "":Not a Current VA Employee
 ;
 N IEN I 'SSN Q ""
 S IEN=+$O(^PRSPC("SSN",SSN,0)) Q:'IEN ""
 I $P($G(^PRSPC(IEN,1)),U,33)'="Y" Q "*"
 Q ""
 ;
OTH(DFN,INS,DS) ; - Find a patient's other valid insurance carrier (if any).
 ;   Input: DFN=Pointer to the patient in file #2
 ;          INS=Pointer to the patient's primary carrier in file #36
 ;           DS=Date of service for validity check
 ;  Output: Valid insurance carrier (first 22 chars.) or null
 N Y S Y="" G:'$G(DFN)!('$G(DS)) OTHQ
 S Z=0 F  S Z=$O(^DPT(DFN,.312,Z)) Q:'Z  S X=$G(^(Z,0)) D:X  Q:Y]""
 .I $G(INS),+X=INS Q
 .S X1=$G(^DIC(36,+X,0)) Q:X1=""
 .I $P(X1,U,2)'="N",$$CHK^IBCNS1(X,DS) S Y=$E($P(X1,U),1,22)
 ;
OTHQ Q Y
 ;
COM ; - Get bill comments.
 N IBGLB,DAT,IBA1,IBC,COM,COM1,X1,X2
 ;
 S DAT=0,IBA1=$S(IBSH1="M":999999999,1:0)
 F  S IBA1=$S(IBSH1="M":$O(^PRCA(433,"C",IBA,IBA1),-1),1:$O(^PRCA(433,"C",IBA,IBA1))) Q:'IBA1  D  I IBSH1="M",DAT Q
 . S IBC=$G(^PRCA(433,IBA1,1)) Q:'IBC
 . I $G(IBSH2),$$FMDIFF^XLFDT(DT,+IBC)<IBSH2 Q  ; Comment age not minimum.
 . I $P(IBC,U,2)'=35,$P(IBC,U,2)'=45 Q  ;   Not decrease/comment transact.
 . S DAT=$S(IBC:+IBC\1,1:+$P(IBC,U,9)\1)
 . I $G(IBEXCEL),IBSH1="M" S IBEXCEL1=IBEXCEL1_$$DT^IBJD(DAT,1) Q
 . ;
 . ; - Append brief and transaction comments.
 . K COM,COM1 S COM(0)=DAT,X1=0
 . S COM1(1)=$P($G(^PRCA(433,IBA1,5)),U,2)
 . S COM1(2)=$E($P($G(^PRCA(433,IBA1,8)),U,6),1,70)
 . S COM(1)=COM1(1)_$S(COM1(1)]""&(COM1(2)]""):"|",1:"")_COM1(2)
 . I COM(1)]"" S COM(1)="**"_COM(1)_"**",X1=1
 . ;
 . ; - Get main comments.
 . S X2=0 F  S X2=$O(^PRCA(433,IBA1,7,X2)) Q:'X2  S COM($S(X1:X2+1,1:X2))=^(X2,0)
 . ;
 . S X1="" F  S X1=$O(COM(X1)) Q:X1=""  D
 . . S IBGLB=$S(IBCAT1<5:"IBJDF6P",1:"IBJDF6D")
 . . S ^TMP(IBGLB,$J,IBDIV,IBCAT,IBIN,$P(IBPTDB,U),IBBN,IBA1,X1)=COM(X1)
 ;
 Q
