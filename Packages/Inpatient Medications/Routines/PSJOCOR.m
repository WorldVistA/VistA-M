PSJOCOR ;BIR/MV - DISPLAY CPRS ORDER CHECKS ;6 Jun 07 / 3:37 PM
 ;;5.0;INPATIENT MEDICATIONS ;**181,252,281**;16 DEC 97;Build 113
 ;
 ; Reference to ^PSDRUG( is supported by DBIA# 2192.
 ; Reference to ^OROCAPI is supported by DBIA# 5367.
 ; Reference to ^ORX8 is supported by DBIA #5469.
 ;
CPRS(PSPDRG) ;Perform Aminoglycoside checks for IV drugs
 ;PSPDRG - Drug array in format of PDRG(n)=IEN (#50) ^ Drug name
 ;Only need to display Aminoglycoside once for an order.  If PSJQUIT is set that means it already displayed
 NEW PSJDD,PSJQUIT,PSJPAUSE,PSJCNT,VAIN
 S PSJPAUSE=0
 W !!
 F PSJCNT=0:0 S PSJCNT=$O(PSPDRG(PSJCNT)) Q:'PSJCNT  Q:$G(PSJQUIT)  S PSJDD=+PSPDRG(PSJCNT) D
 .  D DOC(DFN,$$OROI(+PSJDD))
 .  D GOC(DFN,($P(PSPDRG(PSJCNT),U,2)))
 .  D AOC(DFN,$$VAPROD(+PSJDD))
 I ($Y+4)>IOSL,PSJPAUSE W ! D PAUSE^PSJMISC() W @IOF
 Q
 ;
OROI(PSJDD) ;Get CPRS OI
 ;PSJDD - Drug IEN(#50)
 NEW PSJOI
 Q:'+$G(PSJDD) ""
 S PSJOI=+$P($G(^PSDRUG(+PSJDD,2)),U)
 Q:'PSJOI ""
 Q $$OITM^ORX8(PSJOI,"99PSP")
 ;
DOC(DFN,PSJOROI) ;DANGEREOUS MEDS FOR PAT > 64 ORDER CHECK
 ;DFN - Patient IEN
 ;PSJOROI - CPRS orderable item IEN
 NEW X
 Q:'+$G(DFN)
 Q:'+$G(PSJOROI)
 S X=$P($$DOC^OROCAPI(DFN,+PSJOROI),U,4)
 I X]"" S PSJPAUSE=1 W "***Dangerous Meds for Patient >64***",!! D WRITE^PSJMISC(X) W !
 Q
 ;
GOC(DFN,PSJDNM) ;GLUCOPHAGE LAB RESULTS ORDER CHECK
 ;PSJDNM - Drug name from file 50
 NEW X
 Q:'+$G(DFN)
 Q:$G(PSJDNM)=""
 S X=$P($$GOC^OROCAPI(DFN,PSJDNM),U,4)
 I X]"" S PSJPAUSE=1,PSJQUIT=1 W "***Metformin Lab Results***",!! D WRITE^PSJMISC(X) W !
 Q
 ;
AOC(DFN,PSJPROD) ;AMINOGLYCOSIDE ORDERED ORDER CHECK
 ;PSJPROD - VA Product File (#50.68) IEN.
 ;PSJQUIT is set so Aminoglycoside is only warn once per session.
 NEW X
 Q:'+$G(DFN)
 Q:'+$G(PSJPROD)
 S X=$P($$AOC^OROCAPI(DFN,+PSJPROD),U,4)
 I X]"" S PSJPAUSE=1,PSJQUIT=1 W "***Aminoglycoside Ordered****",!! D WRITE^PSJMISC(X) W !
 Q
 ;
VAPROD(PSJDD) ;Return VA PRODUCT IEN (50.68)
 ;PSJDD - Dispense drug IEN (50)
 Q $P($G(^PSDRUG(+PSJDD,"ND")),U,3)
 ; 
