FBPCR ;AISC/DMK,GRR,TET-POTENTIAL COST RECOVERY OUTPUT DRIVER ;5/23/2006
 ;;3.5;FEE BASIS;**12,48,76,98,103,135,163**;JAN 30, 1995;Build 21
 ;Per VA Directive 6402, this routine should not be modified.
 ; DBIA SUPPORTED REF $$NPI^XUSNPI = 4532
DOC ;Refer to fbdoc, tag fbpcr, for documentation of fbpcr* routines 
PSF ;select one/many/all primary service failities 
 K FBBILL,FBNPB,FBADJ,FBADJR,FBPVL133,FBINV,FBPVLIST,Y  ;FB*3.5*163
 S FBARRLTC=""
 W !! S DIC="^DIC(4,",VAUTSTR="Primary Service Facility",VAUTNI=2,VAUTVB="FBPSV" D FIRST^VAUTOMA K DIC I Y=-1 G EXIT
ARRAY ;set fee program array for all programs
 S FBPI=0 F  S FBPI=$O(^FBAA(161.8,FBPI)) Q:'FBPI  S FBPIN=$G(^(FBPI,0)) I $P(FBPIN,U,3) S FBPROG(FBPI)=$P(FBPIN,U)
 I '$D(FBPROG) G EXIT
 ;prepare array with LTC POV codes
 D MKARRLTC^FBPCR4
 ;what party to include
 K DIR
 S DIR(0)="SO^P:Patient;I:Insurance;B:Both",DIR("A")="Include (P)atient Co-pays / (I)nsurance / (B)oth",DIR("B")="Both"
 S DIR("?")=" Select type of recover to include",DIR("?",1)=" P - include only recover from patient copays",DIR("?",2)=" I - include only recover from insurance",DIR("?",3)=" B - include both",DIR("L")=""
 D ^DIR S FBPARTY=$S($G(Y(0))="Patient":1,$G(Y(0))="Insurance":2,$G(Y(0))="Both":3,X="Both":3,1:0)
 K DIR
 G:FBPARTY=0 EXIT
 ;what type of copay to include
 S FBCOPAY=3
 I FBPARTY'=2 D
 . S DIR(0)="SO^M:MeansTest;L:LTC;B:Both",DIR("A")="Include (M)eans Test Co-pays /(L)TC Co-pays /(B)oth",DIR("B")="Both"
 . S DIR("?")=" Select services to include",DIR("?",1)=" M - include only Means Test copays",DIR("?",2)=" L - include only LTC copays",DIR("?",3)=" B - include both",DIR("L")=""
 . D ^DIR S FBCOPAY=$S($G(Y(0))="LTC":1,$G(Y(0))="MeansTest":2,$G(Y(0))="Both":3,X="Both":3,1:0)
 . K DIR
 G:FBCOPAY=0 EXIT
 ;
 ;include patients if their insurance informations is unavailable?
 S FBINCUNK=0
 I FBPARTY=2!(FBPARTY=3) D
 . S FBINCUNK=1
 . N Y,X
 . W !!
 . S DIR("A")="Do you want to include patients whose insurance status is unavailable? "
 . S DIR("?")="Please answer Yes or No."
 . S DIR("B")="YES",DIR(0)="YA^^"
 . D ^DIR K DIR
 . I $G(DIRUT) S FBINCUNK=-1 Q
 . I $G(Y)=0 S FBINCUNK=0
 I FBINCUNK=-1 G EXIT ;uparrow - exit
 N FBINEXCL  ; FB*3.5*135
 D EXCLINS  ;select insurances to be excluded ; FB*3.5*135
 ;
PREBL ;Include Only Not Previously Billed NVC FB*3.5*163
 N Y,X
 W !
 S DIR("A")="Include only Non VA Care not previously billed to third party carrier: "
 S DIR("?")="Please answer Yes or No."
 S DIR("B")="YES",DIR(0)="YA^^"
 D ^DIR K DIR
 S FBNPB=Y
 ; 
DATE ;select date range
 D DATE^FBAAUTL I FBPOP G PSF
 S FBBDATE=BEGDATE,FBEDATE=ENDDATE
 S Z=9999999.9999,FBBEG=Z-FBEDATE,FBEND=Z-FBBDATE
Q K ^TMP($J,"FB"),^TMP($J,"FBINSIBAPI"),DIC
 ;
 S VAR="FBINCUNK^FBARRLTC^FBARRLTC(^FBPARTY^FBCOPAY^FBNAME^FBIEN^FBID^FBBEG^FBEND^FBBDATE^FBEDATE^FBPSV^FBPSV(^FBPROG(",VAL=VAR,PGM="DQ^FBPCR",IOP="Q" D ZIS^FBAAUTL G:FBPOP EXIT
DQ S $P(FBDASH,"=",80)="",$P(FBDASH1,"-",80)="",FBPG=0,FBCRT=$S($E(IOST,1,2)="C-":1,1:0),FBOUT=0,FBBEG=FBBEG-.9 U IO
SORT ;sort driver for payment output(s)
 S FBPI=0 F  S FBPI=$O(FBPROG(FBPI)) Q:'FBPI  S FBXPROG=FBPROG(FBPI) D
 .I FBPI=2 D EN^FBPCR2 ;outpatient payments
 .I FBPI=3 D EN^FBPCR3 ;pharmacy payments
 .I FBPI=6!(FBPI=7) S:FBPI=6&($D(FBPROG(7))) FBPI=67 D EN^FBPCR67 S:FBPI=67 FBPI=7 ;civil hospital/cnh payments
PRINT ;print driver for payment output(s)
 I $G(^TMP($J,"FBINSIBAPI"))>0 D HDRUNK
 S FBPI=$O(^TMP($J,"FB",0)) I FBPI']"" D WMSG G OUT
 S FBSTA=0
 S FBFIRST=0 ; FB*3.5*163
 S FBPSF=0 F  S FBPSF=$O(^TMP($J,"FB",FBPSF)) Q:'FBPSF!FBOUT  D STA S FBPT="" F  S FBPT=$O(^TMP($J,"FB",FBPSF,FBPT)) Q:FBPT']""!FBOUT  S DFN=$P(FBPT,";",2) D VET S FBPI=0 F  S FBPI=$O(FBPROG(FBPI)) Q:'FBPI  S FBXPROG=FBPROG(FBPI) D  Q:FBOUT
 .I FBPSF_FBPT'=FBSTA D HDR Q:FBOUT
 .I FBPI=2,$D(^TMP($J,"FB",FBPSF,FBPT,FBPI)) D PRINT^FBPCR2 Q
 .I FBPI=3 D:$D(^TMP($J,"FB",FBPSF,FBPT,FBPI)) PRINT^FBPCR3 Q
 .I FBPI=6!(FBPI=7) D:$D(^TMP($J,"FB",FBPSF,FBPT,FBPI)) PRINT^FBPCR671 Q
OUT I $G(^TMP($J,"FBINSIBAPI"))>0 D ERRHDL^FBPCR4
 I FBFIRST=0 D WMSG  ; FB*3.5*163
 I FBOUT!$D(ZTQUEUED) G EXIT
 D EXIT G PSF
 Q
 ;
EXCLINS ;create list of insurance type to be excluded ; FB*3.5*135
 N Y,X,DIC,DTOUT,DUOUT,DIR,DIRUT,DIROUT
 K FBINEXCL S FBINEXCL=0,X=1
 W !!!,"Select the TYPE of INSURANCE PLANS to be EXCLUDED from the PCR report:"
 F  Q:$G(X)=""  S DIC="^IBE(355.1,",DIC(0)="QEAFIBS",DIC("S")="I '$P($G(^(0)),U,4)" K X,Y D ^DIC I $G(Y)>0 S FBINEXCL(+Y)=$P(Y,U,2),FBINEXCL("INS",$P(Y,U,2))=+Y
 S FBINEXCL="A",X=0 F  S FBINEXCL=$O(FBINEXCL("INS",FBINEXCL)) Q:FBINEXCL=""  W:'X !!,"Type of Plan selected for EXCLUSION: " S X=1 W ?41,FBINEXCL,!
 I $O(FBINEXCL(0)) K X,Y S DIR(0)="Y",DIR("B")="NO",DIR("A")="Recreate Exclusion List" D ^DIR I Y D EXCLINS
 K FBINEXCL("INS")
 Q
 ;
EXIT ;kill and quit
KILL ;kill all variables set in the FBPCR* routines, other than fbx
 D CLOSE^FBAAUTL K ^TMP($J,"FB")
 K A1,A2,A3,BEGDATE,C,D,D2,DFN,DIC,DIR,DTOUT,DUOUT,ENDDATE,FBPDXC,FBPARTY,FBCOPAY,FBARRLTC,FBINCUNK,FBFIRST
 K FBAAA,FBAACPTC,FBAC,FBAP,FBBATCH,FBBDATE,FBBEG,FBBN,FBCATC,FBCNT,FBCP,FBCRT,FBDA1,FBDASH,FBDASH1,FBDATA,FBDOB,FBDRUG,FBDT,FBDT1,FBDOS,FBDX,FBDX1,FBEDATE,FBEND,FBERR,FBFD,FBFD1,FBHEAD
 K FBI,FBID,FBIEN,FBIN,FBINS,FBINVN,FBIX,FBJ,FBLOC,FBM,FBNAME,FBOB,FBOPI,FBOUT,FBOV,FBP,FBPAT,FBPD,FBPDX,FBPG,FBPI,FBPID,FBPIN,FBPNAME,FBPROC,FBPROC1,FBPROG,FBPSF,FBPSFNAM,FBPSFNUM,FBPSV,FBPT,FBPV,FBQTY,FBREIM,FBRX
 K FBSC,FBSL,FBSTA,FBSTR,FBSUSP,FBTA,FBTYPE,FBV,FBVCHAIN,FBVEN,FBVENID,FBVNAME,FBVI,FBVID,FBVP,FBXPROG,FBY,FBZ,I,IOP,J,K,L,M,N,PGM,T,V,VA,VAERR,VAL,VAR,VAUTNI,VAUTSTR,VAUTVB,X,Y,Z,FBSTANPI,FBXX
 Q
 ;
WMSG ;write message if no matches found
 D HDR W !!?3,"There are no potential cost recoveries on file"
 W !?5,"for specified date range:  ",$$DATX^FBAAUTL(FBBDATE)," through ",$$DATX^FBAAUTL(FBEDATE)
 I 'FBPSV D
 .W ",",!?5,"and selected Primary Service Area(s):"
 .S FBPSF=0 F  S FBPSF=$O(FBPSV(FBPSF)) Q:'FBPSF  W !?31,$G(FBPSV(FBPSF))
 E  W !?5,"and ALL Primary Service Areas "
 W ".",*7,!!
 Q
 ;
CATC(DFN,FBDT,FBPOV) ; 
 ;treats all copays as Means test for date < 3020705 (JULY 5,2002)
 ;check if patient is liable for copay
 ;INPUT:
 ; DFN = IEN of Patient file
 ; FBDT= Date
 ; FBPOV = POV code (for LTC determination)
 ;OUTPUT:
 ;0 - the patient is not liable for any co-pay;
 ;1 - if Means test catc or pending adjudication and agree to pay deduc
 ;2 - the patient is liable for LTC co-pay;
 ;3 - no 1010EC on file
 ;4 - more analysis is needed to determine the patient liability
 N FBLTC,FBISLTC
 S FBCATC=$$BIL^DGMTUB(DFN,FBDT)
 I '$D(FBPOV)!(FBDT<3020705) Q $S(FBCATC:1,1:0)
 S FBISLTC=$$ISLTC^FBPCR4(FBPOV)
 I FBISLTC=0 Q $S(FBCATC:1,1:0)  ;Means test
 I FBISLTC=2 Q 0  ;LTC-service, but LTC-copay is not applicable
 S FBLTC=$$LTCST^FBPCR4(DFN,FBDT)
 I FBLTC=2 Q 2  ;LTC copay
 I FBLTC=0 Q 3  ;no 1010EC on file
 I FBLTC=4 Q 4  ;more info needed
 Q 0  ;exemption from LTC -copay
 ;
VET ;set vet name/ssn/dob info
 ;INPUT:  DFN  = IEN of Patient file
 ;      FBPI = IEN of fee program (optional)
 ;OUTPUT:  FBPNAME = Patient's name
 ;      FBPID   = Patient's pid
 ;      FBDOB   = Patient's dob (if pharmacy fee program)
 N N
 S N=$G(^DPT(DFN,0)),FBPNAME=$P(N,U),FBPID=$$SSN^FBAAUTL(DFN),FBDOB=$$FMTE^XLFDT($P(N,U,3))
 Q
 ;
STA ;set station name & number
 ;INPUT = FBPSF - IEN to institution file
 ;OUTPUT = FBPSFNAM = station name
 ;      FBPSFNUM = station number
 S FBPSFNAM=$P($G(^DIC(4,FBPSF,0)),U),FBPSFNUM=$P($G(^DIC(4,FBPSF,99)),U)
 S:FBPSFNAM=+FBPSFNAM FBPSFNAM="UNKNOWN"
 S FBSTANPI=$S($G(FBPSFNAM)="":"",FBPSFNAM="UNKNOWN":"",1:$P($$NPI^XUSNPI("Organization_ID",FBPSF),U,1))
 Q
 ;
PAGE ;form feed when new station/patient
 S FBSTA=$G(FBPSF)_$G(FBPT)
 I FBCRT&(FBPG'=0) D CR Q:FBOUT
 I FBPG>0!FBCRT W @IOF
 S FBPG=FBPG+1
 Q
 ;
CR ;read for display
 S DIR(0)="E" W ! D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) FBOUT=1
 Q
 ;
HDR ;general header for potential recoveries
 D PAGE Q:FBOUT
 W !?(IOM-30/2),"POTENTIAL COST RECOVERY REPORT"
 W !?(IOM-(11+$L($G(FBPSFNAM))+$L($G(FBPSFNUM)))/2),"Division/Station: ",$G(FBPSFNUM)," ",$G(FBPSFNAM) ;FB*3.5*163
 W !?(IOM-14/2),"NPI: ",$S($G(FBSTANPI)="":"",$G(FBSTANPI)<1:"",1:$G(FBSTANPI))
 W !?(IOM-19/2),$$DATX^FBAAUTL(FBBDATE)," - ",$$DATX^FBAAUTL(FBEDATE)
 W !?71,"Page: ",FBPG
 W !,"Patient: ",$G(FBPNAME),?40,"Pat. ID: ",$G(FBPID),?62,"DOB: ",$G(FBDOB)
 W !
 S FBFIRST=1  ;FB*3.5*163
 I '$D(DFN) Q  ;FB*3.5*163
 D PATDEMO ;FB*3.5*163
 I FBINCUNK=1,$D(^TMP($J,"FBINSIBAPI",+$G(DFN))) W ">> Warning: accurate insurance information for the patient is unavailable"
 W !?3,"('*' Represents Reimbursement to Patient",?50,"'#' Represents Voided Payment)"
 W !,FBDASH
 ; W ! D:$D(DFN) INS^DGRPDB  ;FB*3.5*163
 W ! D:$D(DFN) INS  ;FB*3.5*163
 Q
 ;
HDRUNK ;Warning message if patient's insurance status is unknown
 D PAGE Q:FBOUT
 W !?(IOM-30/2),"POTENTIAL COST RECOVERY REPORT"
 ;W !?(IOM-(11+$L($G(FBPSFNAM))+$L($G(FBPSFNUM)))/2),"Division: ",$G(FBPSFNUM)," ",$G(FBPSFNAM) ;FB*3.5*163
 W !?(IOM-(19+$L($G(FBPSFNAM))+$L($G(FBPSFNUM)))/2),"Division/Station: ",$G(FBPSFNUM)," ",$G(FBPSFNAM) ;FB*3.5*163
 W !?(IOM-19/2),$$DATX^FBAAUTL(FBBDATE)," - ",$$DATX^FBAAUTL(FBEDATE)
 W !?71,"Page: ",FBPG
 W !,"------------------------------ !!! WARNING !!! --------------------------------"
 W !,"This report is incomplete due to problems with obtaining insurance information"
 W !,"for those patients listed in a separate section in the end of the report. You"
 W !,"may want to rerun the report again to get more accurate results."
 W !,FBDASH
 I FBINCUNK=1 D
 . W !,"Note: You have chosen to include patients with unknown insurance status in"
 . W !,"this report. Please be aware that these patients will be treated as if they"
 . W !,"have billable insurance and their treatment details will be marked accordingly."
 . W !,"The names of these patients will be accompanied with the following message"
 . W !,"to order to identify them:"
 . W !,">> Warning: accurate insurance information for the patient is unavailable"
 . W !,FBDASH
 Q
 ;
PATDEMO ; Patient Demographics FB*3.5*163
 N VAEL,FBCP,FBMT
 D ELIG^VADPT
 S FBMT=$P($G(VAEL(9)),U,2)
 W !,?10,"Outpatient Copayment Status: ",FBMT
 D DISP^IBARXEU(DFN,DT,1,"")
 D GETSC
 D GETSTA
 Q
 ;
GETSC    ; Get Service Connected FB*3.5*163
 N FBD,FBI,FBX,FBY,FBSC
 W !,?20,"Service Connected: "
 I VAEL(3)=0 W "NO" Q
 I $P(VAEL(3),U,2)="" W "NO" Q
 W $P(VAEL(3),U,2)_"%"
 I '$O(^DPT(DFN,.372,0)) Q
 S FBI=0 F  S FBI=$O(^DPT(DFN,.372,FBI)) Q:'FBI  D
 . S FBX=$G(^DPT(DFN,.372,FBI,0)),FBY=$G(^DIC(31,+FBX,0))
 . S FBD=$S($P(FBY,U,4)="":$P(FBY,U,1),1:$P(FBY,U,4))_" ("_$P(FBX,U,2)_"%-"_$S(+$P(FBX,U,3):"SC",1:"NSC")_")"
 . W !?39,FBD
 Q
 ;
GETSTA ; Get Special Authority Eligibility FB*3.5*163
 N FBY,FBADT,FBARR
 W !,?13,"Special Auth Eligibility: "
 S FBADT=DT
 D CL^SDCO21(DFN,FBADT,"",.FBARR)
 I $D(FBARR(3)) W "SC TREATMENT",!
 I $D(FBARR(7)),+$$CVEDT^DGCV(DFN,FBADT) W ?13,"COMBAT VETERAN",!
 I $D(FBARR(1)) W ?39,"AGENT ORANGE",!
 I $D(FBARR(2)) W ?39,"IONIZING RADIATION",!
 I $D(FBARR(4)) W ?39,"SOUTHWEST ASIA",!
 I $D(FBARR(8)) W ?39,"PROJECT 112/SHAD",!
 I $D(FBARR(5)) W ?39,"MILITARY SEXUAL TRAUMA",!
 I $D(FBARR(6)) W ?39,"HEAD/NECK CANCER",!
 I '$D(FBARR) W "NO",!
 Q
 ;
INS  ;Print Insurance Information FB*3.5*163
 N FBYN,FBINS,FBRTN,FBERR,FBX,FBSTAT,FBVAL
 W !,"    Health Insurance: "
 S FBSTAT="RB"
 S FBYN=$$INSUR^IBBAPI(DFN,"",FBSTAT,.FBRTN,"*")
 W $S(FBYN:"YES",1:"NO"),!
 S:FBYN<0 FBERR=$O(FBRTN("IBBAPI","INSUR","ERROR",0))
 D INSHDR
 I $G(FBERR) W !?6,FBRTN("IBBAPI","INSUR","ERROR",FBERR) D INSQ Q
 I 'FBYN W !!,"No Insurance Information" D INSQ Q
 M FBINS=FBRTN("IBBAPI","INSUR")
 S FBX=0
 F  S FBX=$O(FBINS(FBX)) Q:'FBX  D INSDSP(FBX)
 ;
INSQ  ;Check Insurance Buffer and verify no coverage then quit FB*3.5*163
 N FBNC
 W ! I $D(FBRTN("BUFFER")) D
 . I FBRTN("BUFFER")>0 W !?17,"*** Patient has Insurance Buffer entries ***"
 S FBNC=+$G(^IBA(354,DFN,60)) I +FBNC D
 . W !?17,"*** Verification of No Coverage "_$$FMTE^XLFDT(FBNC)_" ***"
 Q
 ;
INSHDR ;Print insurance header FB*3.5*163
 N FBEQL
 W !,"Insurance",?13,"COB",?17,"Subscriber ID",?35,"Group",?47,"Holder",?54,"Eff Dt",?63,"Exp Dt",?72,"Verified"
 S FBEQL="",$P(FBEQL,"=",80)="=" W !,FBEQL
 Q
 ;
INSDSP(FBVAL) ;Print insurance display line FB*3.5*163 
 N FBY,FBZ
 Q:'$D(FBINS)
 W !,$S($D(FBINS(FBVAL,1)):$E($P(FBINS(FBVAL,1),U,2),1,10),1:"UNKNOWN")  ;Insurance Company
 S FBY=+FBINS(FBVAL,7) I FBY'="" S FBY=$S(FBY=1:"p",FBY=2:"s",FBY=3:"t",1:"")
 W ?13,FBY  ;COB
 W ?17,$E(FBINS(FBVAL,14),1,16)  ;Subscriber ID
 W ?35,$E(FBINS(FBVAL,18),1,10)  ;Group
 S FBZ=$P(FBINS(FBVAL,12),U,1)
 W ?47,$S(FBZ="P":"SELF",FBZ="S":"SPOUSE",1:"OTHER")  ;Policy Holder
 W ?54,$TR($$FMTE^XLFDT(FBINS(FBVAL,10),"2DF")," ","0")  ;Effective Date
 W ?63,$TR($$FMTE^XLFDT(FBINS(FBVAL,11),"2DF")," ","0")  ;Expiration Date
 W ?72,$TR($$FMTE^XLFDT(FBINS(FBVAL,25),"2DF")," ","0")  ;Date Last Verified
 Q
