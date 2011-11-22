DVBAVDPT ;ALB/JLU,557/THM-GET VARIABLES VIA ^VADPT ; 1/23/91  8:02 AM
 ;;2.7;AMIE;**57,108**;Apr 10, 1995
 W *7,!!,"NOT a stand-alone program !",!!,*7 Q
 ;
DCHGDT ;entry point for all reports that use discharge dates
 ;called by D DCHGDT^DVBAVDPT
 S DCHGDT=MA,VAINDT=$S(MA[".":MA-.000002,1:MA),VA200="" D INP^VADPT K VA200 S ADMDT=$P(VAIN(7),".") G EN
 ;
ADM ;entry point for all reports that use admission dates
 ;called by D ADM^DVBAVDPT only
 I $D(MA),MA]"" S (ADMDT,VAINDT)=MA S VA200="" D INP^VADPT K VA200 S ADMNUM=VAIN(1),DCHGDT="",DCHPTR=$S($D(^DGPM(+ADMNUM,0)):$P(^(0),U,17),1:"") G:DCHPTR="" EN I DCHPTR]"",$D(^DGPM(DCHPTR,0)) S DCHGDT=$P(^(0),U,1) G EN
 S VAINDT=$S($D(ADMDT):ADMDT,1:""),VA200="" D INP^VADPT K VA200 S ADMNUM=VAIN(1),DCHGDT="",DCHPTR=$S($D(^DGPM(+ADMNUM,0)):$P(^(0),U,17),1:"") I DCHPTR]"",$D(^DGPM(DCHPTR,0)) S DCHGDT=$P(^(0),U,1)
 Q:$D(DVBARADQ)
 ;
EN ;general entry point
 S (DVBAELIG,DVBAELST)="" I $D(^DPT(DFN,.36)),$P(^(.36),U)]"" S DVBAELIG=$S($D(^DIC(8,+^(.36),0)):$P(^(0),U,6),1:"")
 I DVBAELIG]"",$D(^DPT(DFN,.361)),^(.361)]"" S DVBAELST=$P(^(.361),U)
 S PNAM=$P(^DPT(DFN,0),U),SSN=$P(^(0),U,9),WARD=$P(VAIN(4),U),DIAG=VAIN(9),ADMNUM=VAIN(1)
 S WARD=$S($D(^DIC(42,+WARD,0)):^(0),1:""),BEDSEC=$S($P(WARD,U,2)]"":$P(WARD,U,2),1:"UNKNOWN"),WARD=$S($P(WARD,U)]"":$P(WARD,U),1:"UNKNOWN")
 K VAEL,VAERR,VADM,VAIN,VAINDT,DVBAPGM,VAMB,ADMNUM,DVBAX,DVBAY
RCV ;A&A and Pension
 ;
 ;* QUIT1 set by DVBAADRP, DVBACMRP, DVBADSNT, DVBADSRP, DVBADSRT,
 ;*  DVBARAD1, DVBASPD2
 Q:$D(QUIT1)  S RCVAA=$S($D(^DPT(DFN,.362)):^(.362),1:""),RCVPEN=$P(RCVAA,U,14),RCVAA=$P(RCVAA,U,12)
 S RCVAA=$S(RCVAA="Y":1,RCVAA="N":0,1:""),RCVPEN=$S(RCVPEN="Y":1,RCVPEN="N":0,1:"")
SC ;Service Connection
 S DVBASC=$S($D(^DPT(DFN,.3)):$P(^(.3),U),1:"")
CNUM ;Claim Number and Location
 S CNUM=$S($D(^DPT(DFN,.31)):^(.31),1:"")
 S CFLOC=+$P(CNUM,U,4)
 S CNUM=$P(CNUM,U,3)
 S:CNUM="" CNUM="UNKNOWN"
 S XCN=$E(CNUM,$L(CNUM)-1,$L(CNUM))
 ; DVBA*2.7*108 - Modified next line for null values
 ; S CFLOC=$S($D(^DIC(4,CFLOC,99)):$P(^(99),U,1),1:"UNKNOWN")
 S CFLOC=$P($G(^DIC(4,CFLOC,99)),"^") S:CFLOC="" CFLOC="UNKNOWN"
 Q
 ;
ELIG N ED S ELIG=DVBAELIG,INCMP="",ED="Eligibility data:"
 I ELIG]"" S ELIG=ELIG_" ("_$S(DVBAELST="P":"Pend Ver",DVBAELST="R":"Pend Re-verif",DVBAELST="V":"Verified",1:"Not Verified")_")"
 I $D(^DPT(DA,.29)) S INCMP=$S($P(^(.29),U,12)=1:"Incompetent",1:"")
 I INCMP]"",ELIG]"" S ELIG=ELIG_", "
 I '$D(DVBC)!'$$BROKER^XWBLIB W ?6,ED,?26,ELIG W:$X>60 !?26 W INCMP,! Q
 S DVBC=DVBC+1,ED="     "_ED_"    ",^TMP("DVBSPCRP",$J,DVBC)=ED_ELIG
 I $L(^(DVBC))<60 S ^(DVBC)=^(DVBC)_INCMP ;NakedRefs = ^TMP("DVBSPCRP",$J,DVBC)
 E  S DVBC=DVBC+1,$P(^(DVBC)," ",25)=" "_INCMP
 S DVBC=DVBC+1
 Q
 ;
NOTES ;Supported fields for this routine
 ;.362 Disability Ret from Military
 ;.291 Date ruled incomp (VA)
 ;.292 Date ruled incomp (civil)
 ;.293 Rated incomp?
 ;.313 Claim number
 ;.312 Claim folder loc (as free text)
 ;2.101 Log-in date/time
 ;File 44 field .02 Bedsection
 ;Elig file Print name
