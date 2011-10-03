GMTSDVR ; SLC/JER,KER - Health Summary Driver ; 04/30/2002
 ;;2.7;Health Summary;**6,16,27,28,30,31,35,49,55**;Oct 20, 1995
 ;                    
 ; External References
 ;   DBIA 10090  ^DIC(4
 ;   DBIA   510  ^DISV(
 ;   DBIA 10035  ^DPT(
 ;   DBIA 10091  ^XMB(1
 ;   DBIA 10076  ^XUSEC("GMTS VIEW ONLY"
 ;   DBIA  2160  ^XUTL("OR"
 ;   DBIA 10086  ^%ZIS
 ;   DBIA 10089  ^%ZISC
 ;   DBIA 10063  ^%ZTLOAD
 ;   DBIA   148  PATIENT^ORU1
 ;   DBIA   183  DFN^PSOSD1
 ;   DBIA 10141  $$VERSION^XPDUTL
 ;                    
MAIN ; Control branching
 N C,I,GMTYP,VADM,VAROOT,ZTRTN,GMPSAP
 K DIROUT,DUOUT
 F  D  Q:$D(DUOUT)!$D(DIROUT)!($D(GMTYP)'>9)
 . D SELTYP Q:$D(DUOUT)!$D(DIROUT)!($D(GMTYP)'>9)
 . N GMPAT,GMP
 . F  Q:$D(DIROUT)  D  Q:$D(DUOUT)!$D(DIROUT)!(+$D(GMPAT)'>0)!(+($G(ORVP))>0)
 . . K GMP,GMPAT
 . . I +($G(ORVP)) S GMPAT(1)=+($G(ORVP))
 . . E  F  Q:$D(DIROUT)  K ^XUTL("OR",$J,"ORU"),^("ORV"),^("ORW"),^("ORLP"),GMP D PTPC Q:$S($D(DUOUT):1,$D(DIROUT):1,'+$G(GMP):1,1:0)  D
 . . . W !!,"Another patient(s) can be selected."
 . . Q:$D(DUOUT)!$D(DIROUT)!(+$D(GMPAT)'>0)
 . . N GMTSPX1,GMTSPX2
 . . I +$G(GMRANGE)>0 D GETRANGE^GMTSU(.GMTSPX2,.GMTSPX1) Q:$G(GMTSPX1)=""!($G(GMTSPX2)="")
 . . Q:$D(DUOUT)!$D(DIROUT)
 . . D RESUB(.GMPAT)
 . . S GMPSAP=$$RXAP^GMTSPD2 Q:$D(DIROUT)!$D(DUOUT)!$D(DTOUT)
 . . S ZTRTN="PQ^GMTSDVR"
 . . D HSOUT
 K ^XUTL("OR",$J,"ORU"),^("ORV"),^("ORW"),^("ORLP")
 Q
PTPC ; Combined Patient/Patient Copy
 N GMTSPRO,GMTSVER S GMTSVER=+($$VERSION^XPDUTL("OR")),GMTSPRO=+($$PROK^GMTSU("ORU1",11))
 D:GMTSVER>2.9&(GMTSPRO) PATIENT^ORU1(.GMP,,"I  $P($G(^(""OOS"")),""^"")")
 D:GMTSVER'>2.9!('GMTSPRO) PATIENT^ORU1(.GMP) D PATCOPY^GMTSDVR(.GMP,.GMPAT)
 Q
PATCOPY(GMP,GMPAT) ; Copies patients from GMP to GMPAT array
 N IFN,GMDFN
 S IFN=0
 ;   GMPAT(NAME,GMDFN) - alphabetic order by patient
 F  S IFN=$O(GMP(IFN)) Q:IFN'>0  D
 . S GMDFN=+$G(GMP(IFN))
 . ;   Get name from ^DPT to prevent duplicates
 . S GMPAT($P($G(^DPT(GMDFN,0)),U),+GMDFN)=+GMDFN
 Q
RESUB(GMP) ; Resubscript GMP Array
 ;   Subscripts in GMP array are converted to numeric
 N NAME,GMDFN,CNT
 S CNT=0,NAME=""
 F  S NAME=$O(GMP(NAME)) Q:NAME']""  D
 . S GMDFN=0
 . F  S GMDFN=$O(GMP(NAME,GMDFN)) Q:GMDFN'>0  D
 . . S CNT=CNT+1
 . . S GMP(CNT)=GMP(NAME,GMDFN)
 . . K GMP(NAME,GMDFN)
 Q
 ;                   
ENXQ ; External call for tasked HS print
 ;                   
 ;   Input: GMTSTYP=Record # of HS type in file 142
 ;              DFN=Record # of patient in file 2
 ;          GMTSPX1=Optional internal FM ending date
 ;          GMTSPX2=Optional internal FM beginning date
 ;                   
 ;   NOTE:  Optional date range variables are both 
 ;          required if a date range is desired.
 ;                   
 ;   To call from TaskMan:
 ;          S ZTRTN="ENXQ^GMTSDVR"
 ;          S ZTSAVE("GMTSTYP")=""
 ;          S ZTSAVE("DFN")=""
 ;          D ^%ZTLOAD
 D ENX(DFN,GMTSTYP,$G(GMTSPX2),$G(GMTSPX1))
 Q
 ;                   
ENX(DFN,GMTSTYP,GMTSPX2,GMTSPX1) ; External call to print a Health Summary
 ;                   
 ;   Input: GMTSTYP=Record # of HS type in file 142
 ;              DFN=Record # of patient in file 2
 ;          GMTSPX1=Optional internal FM ending date
 ;          GMTSPX2=Optional internal FM beginning date
 ;                   
 ;   NOTE:  Optional date range variables are both 
 ;          required if a date range is desired.
 ;                   
 N DI,DX,DY,GMQUIT,GMTYP,GMPAT,VADM,VAIN,VAROOT
 F  Q:($D(^GMT(142,+GMTSTYP,1))>9)&$D(^DPT(DFN))!+$G(GMQUIT)  D
 . I $D(^GMT(142,+GMTSTYP,1))'>9 D
 . . I $D(ZTQUEUED) S GMQUIT=1 Q
 . . W !?3,"Invalid HEALTH SUMMARY TYPE." D SELTYP S GMTSTYP=+$G(GMTYP(1))
 . I '$D(^DPT(DFN)) D
 . . I $D(ZTQUEUED) S GMQUIT=1 Q
 . . W !?3,"Invalid PATIENT ID." D PATIENT^ORU1(.GMPAT) S DFN=+$G(GMPAT(1))
 Q:+$G(GMQUIT)
 S:$D(GMTYP)'>9 GMTYP(0)=1,GMTYP(1)=+$G(GMTSTYP)_U_$P($G(^GMT(142,+GMTSTYP,0)),U)
 S:$D(GMPAT)'>9 GMPAT=1,GMPAT(0)=1,GMPAT(1)=DFN_U_$P($G(^DPT(DFN,0)),U)
 D PQ
 Q
SELTYP ; Select Health Summary Type(s)
 N DIC,X,Y
 S DIC=142,DIC("A")="Select Health Summary Type: ",DIC(0)="AEMQZ"
 S DIC("S")="I $P(^(0),U)'=""GMTS HS ADHOC OPTION"""
 I $D(GMTYP)<10 S DIC("B")=$S($D(^DISV(DUZ,"^GMT(142,"))=10:$G(^DISV(DUZ,"^GMT(142,",$O(^("^GMT(142,",0)))),1:$P($G(^GMT(142,+$G(^DISV(DUZ,"^GMT(142,")),0)),U))
 K GMTYP S Y=$$TYPE^GMTSULT Q:+Y'>0
 I $S($D(^GMT(142,+Y,1,0))=0:1,$O(^(0))'>0:1,1:0) W !,"The Summary Type "_$P(Y,U,2)_" includes no components...Please choose another",! Q
 S GMTYP(0)=1,GMTYP(1)=Y_U_$P(Y,U,2)_U_$P(Y,U,2)_U_$P(Y,U,2)
 Q
PQ ; Queued subroutine for HS by patient
 N DFN,GMTI,GMTS,GMTS1,GMTS2,GMTSAGE,GMTSDOB,GMTSDTM,GMTSLO,GMTSLPG,GMTSPNM
 N GMTSRB,GMTSSN,GMTSTOF,GMTSTYP,GMTSTITL,GMTSWARD,GMTJ,I,IX0,J,M4,P17,SEX
 N GMTSPHDR,TRFAC,VAERR,VAIN
 S GMTI=0 F  S GMTI=$O(GMTYP(GMTI)) Q:GMTI'>0!$D(DIROUT)  D
 . N GMTSEG,GMTSEGC,GMTSEGI
 . S GMTSTYP=+$G(GMTYP(GMTI)),GMTSTITL=$G(^GMT(142,+GMTSTYP,"T"))
 . S:'$L(GMTSTITL) GMTSTITL=$P(GMTYP(GMTI),U,2)
 . D LOADSEG
 . S GMTJ=0 F  S GMTJ=$O(GMPAT(GMTJ)) Q:GMTJ'>0!$D(DIROUT)  D
 . . S DFN=+$G(GMPAT(GMTJ))
 . . N GMDUOUT
 . . D EN^GMTS1
 . . Q:$D(DIROUT)!+$G(GMDUOUT)
 . . D ACTPROF^GMTSDVR(DFN)
 Q
LOADSEG ; Load Enabled Components into GMTSEG Array
 N GMTI,GMTJ,GMX
 S (GMTI,GMTJ)=0 F  S GMTJ=$O(^GMT(142,GMTSTYP,1,GMTJ)) Q:GMTJ'>0  S GMX=^(GMTJ,0) D
 .S GMTI=GMTI+1,GMTSEG(GMTI)=GMX,GMTSEGI($P(GMX,U,2))=GMTI D SELFILE
 S GMTSEGC=GMTI
 Q
SELFILE ; Get Selection item information for GMTSEG(
 N GMTK S GMTK=0 F  S GMTK=$O(^GMT(142,GMTSTYP,1,GMTJ,1,GMTK)) Q:GMTK'>0  D
 . N GMTSE,GMTSR,GMTSF S GMTSE=^(GMTK,0),GMTSR=U_$P(GMTSE,";",2) Q:GMTSR="^"
 . S GMTSF=+$P(@(GMTSR_"0)"),U,2) Q:+GMTSF=0
 . S GMTSEG(GMTI,GMTSF,GMTK)=$P(GMTSE,";"),GMTSEG(GMTI,GMTSF,0)=GMTSR
 Q
HSOUT ; Output summary, with device control
 ; Call with: ZTRTN
 I $D(^XUSEC("GMTS VIEW ONLY",DUZ)) D @ZTRTN Q
 N %ZIS,IOP
 S %ZIS="PQ" D ^%ZIS Q:POP
 G:$D(IO("Q")) QUE
NOQUE ; Do Not Queue Output
 D @ZTRTN D ^%ZISC
 Q
QUE ; Queue output
 N %,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK
 Q:'$D(ZTRTN)  K IO("Q"),ZTSAVE F %="DFN","GM*","ENTRY","O*" S ZTSAVE(%)=""
 S ZTDESC="HEALTH SUMMARY",ZTIO=ION
 D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Cancelled!")
 K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE D ^%ZISC
 S IOP="HOME" D ^%ZIS
 Q
ACTPROF(GMDFN) ; Print Action Profile for Patient
 N DFN,PSTYPE,PSONOPG,PSOPAR,PSOINST
 I +$G(GMPSAP) D
 . S (PSTYPE,PSONOPG)=1,DFN=GMDFN
 . S $P(PSOPAR,U)=$S($P($G(^GMT(142.99,1,0)),U,5)="Y":1,1:0)
 . S PSOINST=$S(+$G(PSOINST):PSOINST,1:+$P($G(^DIC(4,+$P($G(^XMB(1,1,"XUS")),U,17),99)),U))
 . D DFN^PSOSD1
 . S DFN=GMDFN
 . ;   Reset DFN because ^PSOSD1 call kills it
 . D PAGE^GMTSPL
