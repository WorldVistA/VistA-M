GMTS ; SLC/KER - Health Summary Main Routine ; 02/27/2002
 ;;2.7;Health Summary;**16,24,28,30,31,35,49**;Oct 20, 1995
 ;            
 ; External References
 ;   DBIA   510  ^DISV(
 ;   DBIA 10035  ^DPT(
 ;   DBIA 10076  ^XUSEC("GMTS VIEW ONLY"
 ;   DBIA  2160  ^XUTL("OR"
 ;   DBIA 10086  ^%ZIS
 ;   DBIA 10089  ^%ZISC
 ;   DBIA 10063  ^%ZTLOAD
 ;   DBIA   148  PATIENT^ORU1
 ;   DBIA 10141  $$VERSION^XPDUTL
 ;            
MAIN ; Controls branching
 ;            
 ;   GMTSPXGO & GMRANGE are set in 2 calling 
 ;   options, They aren't meant to be used together.
 ;            
 I +$G(GMTSPXGO)'>0,$L($T(PATIENT^ORU1)),($$VERSION^XPDUTL("OR")>2.19) D MAIN^GMTSDVR Q
 N DIROUT,DUOUT,ZTRTN,GMTSPX1,GMTSPX2,GMNAME,GMPSAP
 S GMTSTYP=0 K DIC,DIROUT,DUOUT
 S DIC("B")=$P($G(^GMT(142,+$G(^DISV(+$G(DUZ),"^GMT(142,")),0)),U)
 F  Q:$D(DIROUT)!$D(DUOUT)  D SELTYP Q:GMTSTYP'>0!$D(DIROUT)!$D(DUOUT)  D
 . N GMPAT,DFN,GMTSMULT
 . F  Q:$D(DIROUT)  D  Q:$D(DIROUT)!$D(DUOUT)!(+$D(GMPAT)'>0)!+$G(ORVP)
 . . K GMPAT,DFN
 . . I +$G(ORVP) D
 . . . S (DFN,GMPAT(1))=+ORVP,GMNAME=$P($G(^DPT(+DFN,0)),U) Q:GMNAME=""  S GMPATT(GMNAME,DFN)="",(GMTSPX1,GMTSPX2)=""
 . . . W !!,"For patient ",GMNAME," please answer the following."
 . . . I +$G(GMTSPXGO)>0 D MENU^GMTSPXU2(DFN,.GMTSPX2,.GMTSPX1)
 . . . I $G(GMTSPX1)']""!($G(GMTSPX2)']"") S DIROUT=1 K GMPAT,GMPATT Q
 . . . Q:$D(DIROUT)  S GMPAT(GMNAME_(9999999-GMTSPX1),+DFN)=+DFN_U_$G(GMTSPX1)_U_$G(GMTSPX2)
 . . I '(+($G(ORVP))) F  Q:$D(DIROUT)  K GMPATT D SELPT Q:$D(DIROUT)!('$D(GMPATT))  S GMNAME="" F  S GMNAME=$O(GMPATT(GMNAME)) Q:GMNAME=""!$D(DIROUT)  F DFN=0:0 S DFN=$O(GMPATT(GMNAME,DFN)) Q:DFN=""  D  Q:$D(DIROUT)
 . . . S (GMTSPX1,GMTSPX2)="" W !!,"For patient ",GMNAME," please answer the following."
 . . . I +$G(GMTSPXGO)>0 D MENU^GMTSPXU2(DFN,.GMTSPX2,.GMTSPX1) I $G(GMTSPX1)']""!($G(GMTSPX2)']"") Q
 . . . Q:$D(DIROUT)
 . . . S GMPAT(GMNAME_(9999999-GMTSPX1),+DFN)=+DFN_U_$G(GMTSPX1)_U_$G(GMTSPX2)
 . . Q:$D(DIROUT)!(+$D(GMPAT)'>0)
 . . I +$G(GMRANGE)>0 D GETRANGE^GMTSU(.GMTSPX1,.GMTSPX2) Q:$G(GMTSPX1)=""!($G(GMTSPX2)="")
 . . Q:$D(DIROUT)
 . . D RESUB^GMTSDVR(.GMPAT)
 . . S GMPSAP=$$RXAP^GMTSPD2 Q:$D(DIROUT)!$D(DTOUT)
 . . S ZTRTN="PQ^GMTS"
 . . D HSOUT^GMTSDVR,END W !
 K GMTSTYP,GMTSTITL,GMTSEG,GMTSEGI,GMTSEGC,GMX,DFN,X,Y,I,GMP,GMPATT
 Q
SELTYP ; Select a Health Summary Type for printing
 Q:GMTSTYP=-1  S DIC=142,DIC("A")="Select Health Summary Type: ",DIC(0)="AEQM",DIC("S")="I $P(^(0),U)'=""GMTS HS ADHOC OPTION"""
 S Y=$$TYPE^GMTSULT K DIC S GMTSTYP=+Y,GMTSTITL=$S($D(^GMT(142,+Y,"T")):^("T"),1:"") S:GMTSTITL="" GMTSTITL=$P(Y,"^",2)
 I GMTSTYP>0,$S($D(^GMT(142,GMTSTYP,1,0))=0:1,$O(^(0))'>0:1,1:0) W !,"This Summary Type includes no components...Please choose another." G SELTYP
SELTYP1 ; Get each component record
 K GMTSEG,GMTSEGI S (GMI,S1)=0 F  S S1=$O(^GMT(142,GMTSTYP,1,S1)) Q:'S1  S GMX=^(S1,0) D LOADSEG
 S GMTSEGC=GMI K S1,S2,GMI
 Q
LOADSEG ; Load enabled components into GMTSEG array
 S GMTS0=^GMT(142.1,$P(GMX,"^",2),0)
 S GMI=GMI+1,GMTSEG(GMI)=GMX,GMTSEGI($P(GMX,U,2))=GMI D SELFILE
 Q
SELPT ; Select a patient
 N DUOUT,GMTSPRO,GMTSVER K ^XUTL("OR",$J,"ORU"),^("ORV"),^("ORW"),^("ORLP"),GMP
 S GMTSVER=+($$VERSION^XPDUTL("OR")),GMTSPRO=+($$PROK^GMTSU("ORU1",11))
 D:+GMTSVER>2.9&(GMTSPRO) PATIENT^ORU1(.GMP,,"I  $P($G(^(""OOS"")),""^"")")
 D:+GMTSVER'>2.9!('GMTSPRO) PATIENT^ORU1(.GMP)
 D PATCOPY^GMTSDVR(.GMP,.GMPATT)
 Q
SELFILE ; Load Selection Items in GMTSEG( array
 N SF,SR,S2 S S2=0 F  S S2=$O(^GMT(142,GMTSTYP,1,S1,1,S2)) Q:'S2  D
 . S ENTRY=^(S2,0),SR=U_$P(ENTRY,";",2) Q:SR="^"
 . S SF=+$P(@(SR_"0)"),U,2) Q:+SF=0
 . S GMTSEG(GMI,SF,S2)=$P(ENTRY,";"),GMTSEG(GMI,SF,0)=SR
 Q
PQ ; Queued subroutine for HS by patient
 N DFN,GMTS,GMTS1,GMTS2,GMTSAGE,GMTSDOB,GMTSDTM,GMTSLO,GMTSLPG,GMTSPNM
 N GMTSRB,GMTSSN,GMTSTOF,GMTSWARD,GMTJ,I,IX0,J,M4,P17,SEX
 N TRFAC,VAERR,VAIN
 S GMTJ=0 F  S GMTJ=$O(GMPAT(GMTJ)) Q:GMTJ'>0!$D(DIROUT)  D
 . S DFN=+$G(GMPAT(GMTJ))
 . I +$G(GMTSPXGO)>0 S GMTSPX1=$P($G(GMPAT(GMTJ)),U,2) D
 . . S GMTSPX2=$P($G(GMPAT(GMTJ)),U,3)
 . . I +GMTSPX1'>0!+GMTSPX2'>0 K GMTSPX1,GMTSPX2
 . N GMDUOUT
 . D EN^GMTS1
 . Q:$D(DIROUT)!+$G(GMDUOUT)
 . D ACTPROF^GMTSDVR(DFN)
 Q
HSOUT ; Output Summary, with DEVICE handling
 K ZTSK
 I $D(^XUSEC("GMTS VIEW ONLY",DUZ)) D EN^GMTS1 Q
 K IOP S %ZIS="PQ" D ^%ZIS Q:POP
 G:$D(IO("Q")) QUE
NOQUE ; Print non-queued output to selected device
 D EN^GMTS1
 D ^%ZISC
 Q
QUE ; Call TaskMan to Queue output
 K IO("Q"),ZTSAVE F %="DFN","GMTS*","ENTRY" S ZTSAVE(%)=""
 S ZTRTN="EN^GMTS1",ZTDESC="HEALTH SUMMARY",ZTIO=ION
 D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Cancelled!")
 K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE D ^%ZISC
 S IOP="HOME" D ^%ZIS
 Q
END ; Clean up environmental variables and EXIT Health Summary
 K %T,DIC,GMTS,GMTSLO,GMTSPNM,GMTSRB,GMTSWARD,GMTSDOB,DIC,X,Y,VA,VAIN,VAINDT,VADM,VAEL,VAPA,VAERR,GMTSSN,GMTS0,GMTS1,GMTS2
 K GMTSAGE,GMTSTIM,GMTSEGN,GMTSEGH,GMTSEGL,GMTSHDR,GMTSNPG,GMTSPG,GMTSQIT,GMTSX,ENTRY,Z1,GMTSDTM,GMTSLOCK,GMTSLPG,SEX,POP,C,GMTSTOF
 Q
ENCWA ; Entry point printing components
 ;            
 ;   GMTSPRM can be set to any component abbreviations 
 ;   except ones that require selection items. Needs 
 ;   to be valid component abbreviation from the "C"
 ;   x-ref of File 142.1.
 ;            
 ;   Call with DFN, GMTSPRM="CD,CN,CW,ADR", GMTSTITL="TITLE"
 ;            
 ;     GMTSPX1=Optional FM date for ending date
 ;     GMTSPX2=Optional FM date for beginning date
 ;            
 ;   NOTE: Optional date range variables are both 
 ;         required if a date range is desired.
 ;            
 N GMI,GMJ,GMTSEG,GMTSEGI,GMTSEGC
 S GMTS1="9999999",GMTS2="6666666",GMI=0,GMTSPNF=1
 I '$D(GMTSPRM) W !,"The parameter GMTSPRM is undefined.",! Q
 I '$D(GMTSTITL) W !,"The parameter GMTSTITL is undefined.",! Q
 I '+$G(DFN) W !,"The parameter DFN is undefined.",! Q
 F GMJ=1:1:$L(GMTSPRM,",") S ABB=$P(GMTSPRM,",",GMJ) D LOAD Q:GMJ=-1
 S GMTSEGC=GMI K ABB,IFN
 D EN^GMTS1
 D END K GMTSEG,GMTSEGI,GMTSEGC,GMTSTITL,GMTSPRM,GMTSPNF
 Q
LOAD ; Load GMTSEG() using GMTSPRM abbreviations
 S IFN=$O(^GMT(142.1,"C",ABB,"")) Q:IFN=""
 S GMI=GMI+1,GMTSEG(GMI)=GMI_"^"_IFN,GMTSEGI(IFN)=GMI
 Q
