IBJDF51 ;ALB/RB - CHAMPVA/TRICARE FOLLOW-UP REPORT (COMPILE);15-APR-00
 ;;2.0;INTEGRATED BILLING;**123,185,240,356**;21-MAR-94
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ST ; - Tasked entry point.
 K IB,^TMP("IBJDF5",$J) S IBQ=0
 ;
 ; - Set selected categories for report.
 I IBSEL[1 S IBCAT(31)=1
 I IBSEL[2 S IBCAT(19)=2
 I IBSEL[3 S IBCAT(30)=3
 I IBSEL[4 S IBCAT(32)=4
 I IBSEL[5 S IBCAT(29)=5
 I IBSEL[6 S IBCAT(28)=6
 ;
 ; Initialize the Summary Information
 S IBCAT="" F  S IBCAT=$O(IBCAT(IBCAT)) Q:IBCAT=""  D
 . S IBDIV=0
 . I IBSD,IBCAT'=31 D  Q
 . . F  S IBDIV=$O(VAUTD(IBDIV)) Q:IBDIV=""  D INIT^IBJDF53
 . D INIT^IBJDF53
 ;
 ; - Print the header line for the Excel spreadsheet
 I $G(IBEXCEL) D PHDL
 ;
 ; - Find data required for the report.
 S IBA=0 F  S IBA=$O(^PRCA(430,"AC",16,IBA)) Q:'IBA  D  Q:IBQ
 . I IBA#100=0 D  Q:IBQ
 . . S IBQ=$$STOP^IBOUTL("CHAMPVA/Tricare Follow-Up Report")
 . S IBAR=$G(^PRCA(430,IBA,0)) Q:'IBAR
 . I $P($G(^DGCR(399,IBA,0)),U,13)=7 Q  ;           Cancelled claim.
 . S IBCAT=+$P(IBAR,U,2) Q:'$D(IBCAT(IBCAT))  ;     Invalid AR category.
 . S IBCAT1=IBCAT(IBCAT)
 . ;
 . ; - Get division, if necessary.
 . I IBCAT1=1 S IBDIV=0                       ; CHAMPVA/Tricare Patient
 . ;
 . I IBCAT1'=1 D                              ; Others
 . . I 'IBSD S IBDIV=0 Q
 . . S IBDIV=$$DIV(IBA)
 . ;
 . I IBSD,IBDIV,'VAUTD Q:'$D(VAUTD(IBDIV))  ; Not a selected division.
 . ;
 . ; - Determine whether AR has corresponding IB action or claim and
 . ;   whether action/claim is inpatient, outpatient, or RX refill.
 . S IBAC=$$CLMACT^IBJD(IBA,IBCAT) Q:IBAC=""!(+IBAC=3)
 . I +IBAC=1 D
 . . S X=$P($G(^IB($P(IBAC,U,2),0)),U,3)
 . . S X=$P($G(^IBE(350.1,X,0)),U)
 . . S IBTYP=$S(X["RX":3,X["OPT":2,1:1)
 . I +IBAC'=1 D 
 . . S IBTYP=$S($P($G(^DGCR(399,IBA,0)),U,5)>2:2,1:1)
 . . I $D(^IBA(362.4,"C",IBA)) S IBTYP=3
 . ;
 . I IBSEL1'[IBTYP,IBSEL1'[4 Q
 . ;
 . I IBRPT="D" S IBPT=$$PAT(IBA) Q:IBPT=""  ; Get patient info.
 . ;
 . I '$G(IBEXCEL) D EN^IBJDF53 Q:IBRPT="S"  ; Get stats for summary.
 . ;
 . ; - Get insurance info.
 . S (IBI,IBIN)=0
 . I $G(^DGCR(399,IBA,"MP")) D  I 'IBI Q
 . . S IBI=+$G(^DGCR(399,IBA,"MP")) I 'IBI S IBIN="*** UNKNOWN ***" Q
 . . S IBIN=$P($G(^DIC(36,IBI,0)),U)_"@@"_IBI
 . ;
 . ; - Check the receivable age, if necessary.
 . I IBSMN D  Q:IBARD<IBSMN!(IBARD>IBSMX)
 . . S IBARD=+$$ACT^IBJDF2(IBA) S:IBARD IBARD=$$FMDIFF^XLFDT(DT,IBARD)
 . ;
 . ; - Check the minimum balance amount, if necessary.
 . S IBBA=0 F X=1:1:5 S IBBA=IBBA+$P($G(^PRCA(430,IBA,7)),U,X)
 . I IBSAM,IBBA<IBSAM Q
 . ;
 . ; - Get remaining AR/claim information.
 . S IBDP=$P(IBAR,U,10),X=$$CLMACT^IBJD(IBA,IBCAT) Q:X=""
 . S IBBU=$S(+IBAC=1:$G(^IB($P(IBAC,U,2),0)),1:$G(^DGCR(399,IBA,"U")))
 . S IBFR=$P(IBBU,U,$S(+IBAC=1:14,1:1))
 . S IBTO=$P(IBBU,U,$S(+IBAC=1:15,1:2))
 . S DFN=$P(IBPT,U,5),IBSID=$$SID(DFN,IBI)
 . S IBOI=$$OTH(DFN,IBI,IBFR),IBVA=$$VA^IBJD1(DFN)
 . S IBBN=$P(IBAR,U),IBOR=$P(IBAR,U,3)
 . ;
 . ; - Set up indexes for detail report.
 . I $G(IBEXCEL) D  Q
 . . S IBDIV=$P($G(^DG(40.8,$S('IBDIV:+$$PRIM^VASITE(),1:IBDIV),0)),U)
 . . ;
 . . S IBEXCEL1=$P(IBPT,U,2)_U_IBVA_U_$P(IBPT,U,3)_U_$TR($P(IBPT,U,4),"-")
 . . S IBEXCEL1=IBEXCEL1_U_$S(IBIN=0:"",1:$E($P(IBIN,"@@"),1,12))_U_$E(IBOI,1,12)
 . . S IBEXCEL1=IBEXCEL1_U_$$DT^IBJD(IBDP,1)_U_$$DT^IBJD(IBFR,1)
 . . S IBEXCEL1=IBEXCEL1_U_$$DT^IBJD(IBTO,1)_U_IBSID_U_IBBN_U_IBOR
 . . S IBEXCEL1=IBEXCEL1_U_IBBA_U_$P($G(^PRCA(430.2,IBCAT,0)),U,2)
 . . S IBEXCEL1=IBEXCEL1_U_$E("IOR",IBTYP)_U
 . . I IBSH D COM  ; This will capture the Last Comment Date
 . . S IBD=$$FMDIFF^XLFDT(DT,$S('$P(IBEXCEL1,U,16):IBDP,1:$G(DAT)))
 . . S IBEXCEL1=IBEXCEL1_U_IBD_U_$E(IBDIV,1,12) W !,IBEXCEL1 K IBD,IBEXCEL1
 . ;
 . S IBKEY=$P(IBPT,U)_"@@"_$S($G(IBPT):IBDP,1:IBFR_"/"_IBTO)
 . F X=IBTYP,4 I IBSEL1[X D
 . . I '($D(^TMP("IBJDF5",$J,IBDIV,IBCAT,X,IBIN,IBKEY))#10) D
 . . . S ^TMP("IBJDF5",$J,IBDIV,IBCAT,X,IBIN,IBKEY)=$P(IBPT,U,2)_" "_IBVA_U_$P(IBPT,U,3,4)_U_IBOI
 . . S ^TMP("IBJDF5",$J,IBDIV,IBCAT,X,IBIN,IBKEY,IBBN)=IBDP_U_IBFR_U_IBTO_U_IBOR_U_IBBA_U_IBSID
 . . I IBSH D COM
 ;
 I 'IBQ,'$G(IBEXCEL) D EN^IBJDF52 ; Print the report.
 ;
ENQ K ^TMP("IBJDF5",$J)
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IB,IBA,IBA1,IBAR,IBARD,IBBU,IBC,IBCAT,IBCAT1,IBDIV,IBD,IBI,IBQ,IBPT
 K IBDP,IBKEY,IBVA,IBAC,IBBA,IBBN,IBFR,IBIN,IBOI,IBOR,IBSID,IBTO,IBTYP
 K COM,COM1,DAT,DFN,J,X,X1,X2,Y,Z D KVA^VADPT
 Q
 ;
PAT(IBDA) ; - Find the claim patient and decide to include the claim.
 ;    Input: IBDA=Pointer to the claim/AR in file #399/#430 plus all
 ;             variable input in IBS*
 ;   Output: Y=Sort key (name or last 4)_@@_patient IEN to file #2 
 ;             ^ Patient name ^ Age ^ SSN ^ Patient IEN to file #2
 N AGE,ALL,ARZ,DA,DBTR,DFN,DIC,DIQ,DOB,DR,END,IBZ,INI,KEY,NAME,RCZ,SSN
 N VADM,Y,Z
 ;
 S Y="" G:'$G(IBDA) PATQ
 S DFN=0,(NAME,AGE,SSN)="",ARZ=$G(^PRCA(430,IBDA,0))
 ;
 ; - Look for Patient (Corresponding Claim in IB)
 I $D(^DGCR(399,IBDA,0)) D  I 'DFN S Y="" G PATQ
 . S IBZ=^DGCR(399,IBDA,0),DFN=+$P(IBZ,"^",2)
 . D DEM^VADPT S NAME=VADM(1),SSN=$P(VADM(2),"^",2),AGE=VADM(4)
 ;
 ; - Look for Debtor (No corresponding Claim in IB)
 I '$D(^DGCR(399,IBDA,0)) D  I 'DFN S Y="" G PATQ
 . S DBTR=+$P(ARZ,"^",9) I 'DBTR Q
 . S RCZ=$G(^RCD(340,DBTR,0)),DFN=+RCZ
 . I $P(RCZ,"^")["DPT" D
 . . D DEM^VADPT S NAME=VADM(1),SSN=$P(VADM(2),"^",2),AGE=VADM(4)
 . I $P(RCZ,"^")'["DPT" D
 . . S DIC="^PRCA(430,",DA=IBDA,DR=9,DIQ="DEB" D EN^DIQ1
 . . S NAME=$G(DEB(430,DA,9)),KEY=NAME
 . . S DIC="^RCD(340,",DA=DBTR,DR=110,DIQ="DEB" D EN^DIQ1
 . . S SSN=$G(DEB(340,DA,110))
 . . I SSN S SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 ;
 S KEY=$S(IBSN="N":NAME,1:+$P(SSN,"-",3))
 S INI=IBSNF,END=IBSNL,ALL=IBSNA
 I (INI'="@"&('DFN)) S Y="" G PATQ
 I ALL="ALL"&('DFN)!(ALL="NULL"&(DFN)) S Y="" G PATQ
 I INI="@",END="zzzzz" G PATC
 I INI]KEY!(KEY]END) S Y="" G PATQ
 ;
PATC ; - Find all patient data.
 S Y=KEY_"@@"_DFN_U_$E(NAME,1,25)_U_AGE_U_SSN_"^"_DFN
PATQ Q Y
 ;
DIV(CLM) ;Find the default division of the bill. 
 S DIV=$P($G(^DGCR(399,CLM,0)),"^",22)
QDIV S:'DIV DIV=$$PRIM^VASITE() S:DIV'>0 DIV=0
 Q DIV
SID(DFN,INS) ; - Find the subscriber ID for a bill (if any).
 ;   Input: DFN=Pointer to the patient in file #2
 ;          INS=Pointer to the patient's primary carrier in file #36
 ;  Output: Subscriber ID no. or null
 N X,Y,Z S Y="" G:'$G(DFN)!('$G(INS)) SIDQ
 S Z=0 F  S Z=$O(^DPT(DFN,.312,Z)) Q:'Z  S X=$G(^(Z,0)) D  Q:Y]""
 .I +X=INS S Y=$E($P(X,U,2),1,16)
 ;
SIDQ Q Y
 ;
PHDL ; - Print the header line for the Excel spreadsheet
 N X
 S X="Patient^VA Empl.?^Age^SSN^Prim.Ins.Carrier^Other Ins.Carrier^"
 S X=X_"Dt Bill prep.^Bill From Dt^Bill To Dt^Subsc.ID^Bill #^"
 S X=X_"Orig.Amt^Curr.Bal.^Cat.^Bill Type^Lst Comm.Dt^Days Lst Comm.^"
 S X=X_"Division"
 W !,X
 Q
 ;
OTH(DFN,INS,DS) ; - Find a patient's other valid insurance carrier (if any).
 ;   Input: DFN=Pointer to the patient in file #2
 ;          INS=Pointer to the patient's primary carrier in file #36
 ;           DS=Date of service for validity check
 ;  Output: Valid insurance carrier (first 15 chars.) or null
 N X,X1,Y,Z S Y="" G:'$G(DFN)!('$G(INS))!('$G(DS)) OTHQ
 S Z=0 F  S Z=$O(^DPT(DFN,.312,Z)) Q:'Z  S X=$G(^(Z,0)) D:X  Q:Y]""
 .I +X=INS Q
 .S X1=$G(^DIC(36,+X,0)) Q:X1=""
 .I $P(X1,U,2)'="N",$$CHK^IBCNS1(X,DS) S Y=$E($P(X1,U),1,15)
 ;
OTHQ Q Y
 ;
COM ; - Get bill comments.
 S DAT=0,IBA1=$S(IBSH1="M":999999999,1:0)
 F  S IBA1=$S(IBSH1="M":$O(^PRCA(433,"C",IBA,IBA1),-1),1:$O(^PRCA(433,"C",IBA,IBA1))) Q:'IBA1  D  I IBSH1="M",DAT Q
 .S IBC=$G(^PRCA(433,IBA1,1)) Q:'IBC
 .I $G(IBSH2),$$FMDIFF^XLFDT(DT,+IBC)<IBSH2 Q  ; Comment age not minimum.
 .I $P(IBC,U,2)'=35,$P(IBC,U,2)'=45 Q  ;   Not decrease/comment transact.
 .S DAT=$S(IBC:+IBC\1,1:+$P(IBC,U,9)\1)
 .I $G(IBEXCEL),IBSH1="M" S IBEXCEL1=IBEXCEL1_$$DT^IBJD(DAT,1) Q
 .;
 .; - Append brief and transaction comments.
 .K COM,COM1 S COM(0)=DAT,X1=0
 .S COM1(1)=$P($G(^PRCA(433,IBA1,5)),U,2)
 .S COM1(2)=$E($P($G(^PRCA(433,IBA1,8)),U,6),1,70)
 .S COM(1)=COM1(1)_$S(COM1(1)]""&(COM1(2)]""):"|",1:"")_COM1(2)
 .I COM(1)]"" S COM(1)="**"_COM(1)_"**",X1=1
 .;
 .; - Get main comments.
 .S X2=0 F  S X2=$O(^PRCA(433,IBA1,7,X2)) Q:'X2  S COM($S(X1:X2+1,1:X2))=^(X2,0)
 .;
 .S X1="" F  S X1=$O(COM(X1)) Q:X1=""  D
 ..S ^TMP("IBJDF5",$J,IBDIV,IBCAT,X,IBIN,IBKEY,IBBN,IBA1,X1)=COM(X1)
 ;
 Q
