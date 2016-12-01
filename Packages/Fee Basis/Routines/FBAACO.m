FBAACO ;AISC/GRR - ENTER MEDICAL PAYMENT ;9/25/2014
 ;;3.5;FEE BASIS;**4,61,79,116,122,133,108,135,123,154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
EN583 ;driver for opt payments (entry point for uc)
 K FBAAOUT,FBPOP
 D SITE G Q:$G(FBPOP) D BT G Q:$G(FBAAOUT)
1 K FBAAID,FBAAVID,FBAAOUT,FBDL,FBAAMM D SITE G Q:$G(FBPOP) S FBINTOT=0 W !!
 I '$D(FB583) K FBDL,FBAR D GETVET^FBAAUTL1 G EN583:'DFN K FBAAOUT,FBDMRA D GETAUTH^FBAAUTL1 G 1:FTP']""
 I '$$UOKPAY^FBUTL9(DFN,FTP) D  G 1
 . W !!,"You cannot process a payment associated with authorization ",DFN,"-",FTP
 . W !,"due to separation of duties."
 K FBAAOUT
 I $G(FBCHCO) S FB7078=$S($G(FB7078):FB7078_";FB7078(",$D(FB583):FB583_";FB583(",1:"")
 D:FBAAPTC="R" ^FBAACO0
 D PAT,GETVEN1^FBAACO1:$D(FB583),GETVEN^FBAACO1:'$D(FB583) I $G(FBAAOUT) G Q:$D(FB583),1
 W !! D FILEV^FBAACO5(DFN,FBV) I $G(FBAAOUT) G Q:$D(FB583),1
 ;check for payments against all linked vendors
 S DA=+Y D CHK^FBAACO4 K FBAACK1,FBAAOUT,DA,X,Y
 K FBAAID,FBAAVID D GETINV^FBAACO1 I $G(FBAAOUT) Q:$D(FBCHCO)  G Q:$D(FB583),1
 I '$D(FBAAID)!('$D(FBAAVID)) D GETINDT^FBAACO1 I $G(FBAAOUT) D OUT G Q:$D(FB583),1:'$D(FBCHCO) Q
 ;
 ; FB*3.5*123 - check for IPAC agreement for Federal vendor and capture DoD invoice number (both req'd if IPAC)
 S FBDODINV=""
 S FBIA=$$IPAC^FBAAMP(FBV) I FBIA=-1 S FBAAOUT=1 D OUT G Q:$D(FB583),1:'$D(FBCHCO) Q
 I FBIA,'$$IPACINV^FBAAMP(.FBDODINV) S FBAAOUT=1 D OUT G Q:$D(FB583),1:'$D(FBCHCO) Q
 ;
 ; ask patient account number
 S FBCSID=$$ASKPAN^FBUTL5() I FBCSID="^" K FBCSID S FBAAOUT=1 D OUT G Q:$D(FB583),1:'$D(FBCHCO) Q
 ; if U/C then get FPPS Claim ID else ask user
 I $D(FB583) S FBFPPSC=$P($G(^FB583(FB583,5)),U) W !,"FPPS CLAIM ID: ",$S(FBFPPSC="":"N/A",1:FBFPPSC)
 E  S FBFPPSC=$$FPPSC^FBUTL5() I FBFPPSC=-1 K FBFPPSC S FBAAOUT=1 D OUT G Q:$D(FB583),1:'$D(FBCHCO) Q
 ;
 S FBUCI135=$$ENTROUTP^FBUTL136(DFN,FBV,FBAAVID,FBFPPSC)                   ; Enter UCID FB3.5*135
 I FBUCI135<1 K FBFPPSC S FBAAOUT=1 D OUT G Q:$D(FB583),1:'$D(FBCHCO) Q    ; Enter UCID FB3.5*135
 ;
 G 1^FBAAMP:$G(FBMP) D MM G Q:$G(FBAAOUT)
SVDT K FBAAOUT,HOLDY W !! D GETSVDT^FBAACO5(DFN,FBV,FBASSOC,1) I $G(FBAAOUT) K FBAADT,FBX,FBAACP W:FBINTOT>0 !!,"Invoice: "_FBAAIN_" Totals $ "_$J(FBINTOT,1,2) G Q:$D(FB583)!($G(FBCHCO)),1
 D SETO^FBAACO3,DISPINV^FBAACO1
 W ! D ASKZIP^FBAAFS($G(FBV),$G(FBAADT))
 I $G(FBAAOUT)!(FBZIP']"") D DEL^FBAACO3 G SVDT
CPT K FBAAOUT W !
 D CPTM^FBAALU($G(FBAADT),$G(DFN)) I 'FBGOT D DEL^FBAACO3 G SVDT
 D CHK2^FBAACO4 I FBJ']"" G SVPR
CHKE ;determines what action to take on duplicate services entered
 K FBAAOUT W !!,*7,"Service selected for that date already in system."
 S DIR(0)="Y",DIR("A")="Do you want to add another service for the SAME DATE",DIR("B")="No" D ^DIR K DIR G Q:$D(DIRUT),SVPR:Y
 I FBJ]"",FBJ'=FBV W !!,*7,"You must use the 'EDIT PAYMENT' option to edit the service previously",!,"entered for that date." D DEL^FBAACO3 G SVDT
 S DIR(0)="Y",DIR("A")="Want to edit it",DIR("B")="No" D ^DIR K DIR G Q:$D(DIRUT) I Y D DOEDIT^FBAACO3 G SVDT:'$D(FBDL)!($G(FBAAOUT)),Q:$D(FB583),1
 D ^FBAACO2 G CPT:'$G(FBDEN)
SVPR K FBAAOUT
 I $$ANES^FBAAFS($$CPT^FBAAUTL4($G(FBAACP))) D ASKTIME^FBAAFS I $G(FBAAOUT)!'$G(FBTIME) G CPT
 D SVCPR^FBAACO1 G CPT:$G(FBAAOUT)
 S FBAMTPD=0 D FILE^FBAACO2 I $D(FBAAOUT) G Q:$D(FB583),1:$D(FBDL),Q ;FB*3.5*133 removed provider field save
 D OUT^FBAACO3 W:Z1>(FBAAMPI-20) !,*7,"Warning, you can only enter ",(FBAAMPI-Z1)," more line(s)!" G CPT:Z1'>(FBAAMPI-1) D WARN^FBAACO3 G EN583
 G 1
 ;
Q ;exit point for outpatient payment routines
 K FBAAPTC,DIC,Y,A,I,DFN,BO,DA,DI,DQ,DR,E,FBAABDT,FBAABE,FBFY,FBDL,FBAAID,FBAAIN,FBAAMPI,FBAAOPA,FBAAPN,FBCONT,FBDX,FBGOT,FBPOV,FBPT,DLAYGO,FBPSA,FBASSOC,FBZBN,FBZBS,FBDEN,FBV,FBSDI,FBAACPI,FBAACP,FBX,FBLOCK
 K FBSP,FBTPD,FBTT,FBTYPE,FTP,FBDEL,FY,FBINTOT,G,H,MAJN,NO,PI,Q,R,SUB,SUBN,TA,TP,UL,W,X1,Z,Z1,ZZ,FBAADT,K,L,J,FBTOV,FBPARCD,FBT,FEEO,Z2,FBSITE,FBAUT,T,FBLOC,FBSSN,FBVEN,FBD1,Z0,FB583
 K A1,A2,B1,B2,DAT,DIE,FBAACPT,FBAMTPD,FBAAEDT,FBAAOUT,FBAAPD,FBI,FBIN,FBPROG,FBRR,FBXX,PTYPE,S,VAL,X,V,ZS,FB7078,FBFDC,FBCOUNTY,FBMST,FBTTYPE,FBTV,HY,FBDMRA,DIRUT,FBPOP,FBJ,FBAACK1,FBAR,FBDA,FBST
 K FBMP,FBK,FBAAAS,%DT,FBDT,FBMAX,FBAMFS,FBAASC,FBHCFA,FBSI,FBCNP,FBAAAMT,FBAAVID,FBAAMM,FBAAMM1,VAPA,FBZX,FBTST,HOLDY,FBAOT
 K FBCSID,FBFPPSC,FBFPPSL,FBADJ,FBADJD,FBADJL,FBRRMK,FBRRMKD,FBRRMKL,FBUNITS,FBCNTRP,FBUCI135,FBIA,FBDODINV
AUTHQ K DIC,DFN,CNT,FB7078,FBAABDT,FBAAEDT,FBAAOUT,FBASSOC,FBAUT,FBPOV,FBPROG,FBPSA,FBPT,FBTT,FBTYPE,FBVEN,FBTP,PI,TA,FBMOD,FBMODA,FBZIP,FBTIME,FBFSAMT,FBFSUSD
 D GETAUTHK^FBAAUTL1
 Q
 ;
SITE ;set up site variables
 D:'$D(FBSITE(0)) SITEP^FBAAUTL Q:$G(FBPOP)  I '$G(FBPROG) D
 .I $G(FBCHCO) S FBPROG="I ($P(^(0),""^"",3)=6!($P(^(0),""^"",3)=7))&($P(^(0),U,9)'[""FB583"")" Q
 .S FBPROG=$S($P(FBSITE(1),"^",6)="":"I $P(^(0),""^"",9)'[""FB583""",1:"I $P(^(0),""^"",3)=2,($P(^(0),""^"",9)'[""FB583"")")
 S:'$D(FBAAPTC) FBAAPTC="V"
 S FBAAMPI=$P($G(^FBAA(161.4,1,"FBNUM")),"^",3),FBAAMPI=$S(FBAAMPI]"":FBAAMPI,1:100)
 Q
 ;
BT ;select batch
 S DIC="^FBAA(161.7,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,3)=""B3""&($G(^(""ST""))=""O"")&(($P(^(0),U,5)=DUZ)!($D(^XUSEC(""FBAA LEVEL 2"",DUZ))))",DIC("W")="W !,""  Obligation #: "",$P(^(0),U,2)" W !! D ^DIC K DIC I X["^"!(X="") S FBAAOUT=1 Q
 G BT:Y<0 S (DA,FBAABE)=+Y,Y(0)=^FBAA(161.7,DA,0)
 I $P(Y(0),"^",11)>(FBAAMPI-1) W !!,"This Batch already has the maximum number of Payments!" G BT
 S Z1=$P(Y(0),"^",11),FB7078="",BO=$P(^FBAA(161.7,DA,0),"^",2)
 Q
PAT ;set up patient in patient file
 ;required input variable DFN
 I '$D(^FBAAC(DFN,0)) K DD,DO S (X,DINUM)=DFN,DIC(0)="L",DLAYGO=162,DIC="^FBAAC(" D FILE^DICN K DLAYGO,DIC,DINUM,DD,DO,DA
 Q
MM ;check for money management of entire invoice
 ; fb*3.5*116
 D MMPPT
 Q
OUT K FBAADT,FBX,FBAACP W:FBINTOT>0 !!,"Invoice: "_FBAAIN_" Totals $ "_$J(FBINTOT,1,2) Q
 ;
MMPPT ;money management/prompt pay type for multiple payment entry
 ; input
 ;   FBAAPTC = payment type code, "R" when patient reimbursement
 ;   FBV     = vendor being paid (ien)
 ;   when called from FBAAMP additional variables will be available
 ;     FBCNTRA = contract ien from authorization
 ;     FBVEN   = vendor from authorization
 ;     FB583   = defined when unauthorized claim
 ; output
 ;   FBAAMM  = prompt payment, =1 to ask
 ;   FBAAMM1 = prompt payment type for line
 ;   FBAAOUT = (optional), = 1 to quit
 ;   FBCNTRP = contract for line item (ien)
 ;
 S (FBAAMM,FBAAMM1,FBCNTRP)=""
 I $G(FBAAPTC)'="R",'$D(FB583) D
 . ;
 . ; check if contract required by authorization
 . I '$D(FB583),$$UCFA^FBUTL7($G(FBV),$G(FBVEN),$G(FBCNTRA)) D  Q
 . . W !,"All lines items on this invoice will be considered as contracted services"
 . . W !,"under Contract ",$P($G(^FBAA(161.43,FBCNTRA,0)),U)," from the authorization."
 . . S (FBAAMM,FBAAMM1)=1
 . . S FBCNTRP=FBCNTRA
 . ;
 . ; when not forced by authorization ask if contracted service
 . W !,"The answer to the following will apply to all payments entered via this option."
 . S DIR(0)="Y"
 . S DIR("A")="Are payments for contracted services"
 . S DIR("B")="No"
 . S DIR("?",1)="Answering no indicates interest will not be paid for any line items."
 . S DIR("?",2)="Answering yes indicates interest will be paid."
 . S DIR("?",3)="A fee schedule is not used for contracted services."
 . S DIR("?")="Enter either 'Y' or 'N'."
 . D ^DIR K DIR I $D(DIRUT) S FBAAOUT=1 Q
 . S (FBAAMM,FBAAMM1)=$S(Y:1,1:"")
 . Q:FBAAMM1=""
 . ;
 . ; if contracted service, ask contract
 . S DIR(0)="PO^161.43:AQEM"
 . S DIR("A")="CONTRACT"
 . S DIR("?",1)="If the line item is under a contract then select it."
 . S DIR("?")="Contract must be active and applicable for the vendor."
 . S DIR("S")="I $P($G(^(0)),""^"",2)'=""I"",$$VCNTR^FBUTL7($G(FBV),+Y)"
 . D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S FBAAOUT=1 Q
 . S:Y>0 FBCNTRP=+Y
 Q
 ;
