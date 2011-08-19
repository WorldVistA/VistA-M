PSBOBZ ;BIRMINGHAM/TTH-BAR CODE LABELS (MAIN) ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**2**;Mar 2004;Build 22
 ;;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; ^%ZIS(2/3435
 ; File 50/221
 ;
EN ;
 N PSBI,PSBIENS,PSBQTY,PSBDOSE,PSBDRUG,PSBNAME,PSBNODE3,PSBWARD,PSBLOT,PSBBAR,PSBTLE,SL
 N PSBEXP,PSBFD,PSBMFG,PSBCB,PSBFB,PSBFCB,PSBCNT,PSBANS,PSBORD,PSBPRE,PSBX,PSBY,PSBSYM,TEXT
 ;
 N PSBXX,PSBYY,PSBCODE
 S PSBXX=0 F  S PSBXX=$O(^%ZIS(2,IOST(0),55,PSBXX)) Q:'PSBXX  S PSBYY=$G(^(PSBXX,0)) I PSBYY]"" S PSBX=$P(PSBYY,"^"),PSBY=^(1),PSBCODE(PSBX)=PSBY
 ;
 ;The PSBRPT variable and PSBRPT(.3) array are set in the PSBO routine.  It is the internal
 ;entry number from the BCMA REPORT REQUEST file (#53.69). This entry is created
 ;when the user submits the completed ScreenMan form from the Label Print option.
 ;
 ;
 S PSBIENS=PSBRPT_","
 S PSBBAR=$P($P($G(PSBRPT(.3)),U,1),"~",2)
 S PSBPRE=$$GET^XPAR("DIV","PSB DEFAULT BARCODE PREFIX")
 S:PSBPRE]"" PSBBAR=PSBPRE_$S(PSBPRE?1.N:"-",1:"")_PSBBAR
 S PSBDRUG=$P($P($G(PSBRPT(.3)),U,1),"~",1)
 S PSBQTY=+$P($G(PSBRPT(.3)),U,5)
 S:PSBQTY PSBDRUG=PSBDRUG_" (Qty: "_PSBQTY_")"
 I PSBQTY=0 S PSBDRUG=PSBDRUG_" (Qty:      )"
 S PSBDOSE=$P($G(PSBRPT(.3)),U,9)
 I PSBDOSE]"" S PSBDOSE="Dose:"_PSBDOSE
 I PSBDOSE="" S PSBDOSE="Dose:"
 S PSBNAME=$$GET1^DIQ(53.69,PSBIENS,.12)
 I PSBNAME]"" S PSBNAME=PSBNAME_" ("_$E($$GET1^DIQ(53.69,PSBIENS,.121),6,9)_")"
 I PSBNAME="" S PSBNAME="Patient:"
 S PSBWARD=$$GET1^DIQ(53.69,PSBIENS,.122)
 I PSBWARD]"" S PSBWARD="Ward: "_PSBWARD
 I PSBWARD="" S PSBWARD="Ward: "
 S PSBLOT=$P($G(PSBRPT(.3)),U,2)
 I PSBLOT]"" S PSBLOT="Lot: "_PSBLOT
 I PSBLOT="" S PSBLOT="Lot: "
 S PSBFD=$P($G(PSBRPT(.3)),U,3)
 S PSBEXP=$$FMTE^XLFDT(PSBFD,5)
 I PSBEXP]"" S PSBEXP="Exp: "_PSBEXP
 I PSBEXP="" S PSBEXP="Exp: "
 S PSBMFG=$P($G(PSBRPT(.3)),U,4)
 I PSBMFG]"" S PSBMFG="Mfg: "_PSBMFG
 I PSBMFG="" S PSBMFG="Mfg: "
 S PSBFB=$P($G(PSBRPT(.3)),U,6) I PSBFB="" S PSBFB="_____"
 S PSBCB=$P($G(PSBRPT(.3)),U,7) I PSBCB="" S PSBCB="_____"
 S PSBFCB=PSBFB_"/"_PSBCB
 F PSBCNT=1:1:+$P(PSBRPT(.3),U,8) D LABEL
 Q
 ;
LABEL ;Get Barcode Label Type
 ;Barcode Type
 S PSBSYM=$$GET^XPAR("DIV","PSB DEFAULT BARCODE FORMAT",,"E")
 ;
INIT ;Initialize barcode printer
 I $D(PSBCODE("FI")) X PSBCODE("FI")
 I $D(PSBCODE("FI1")) X PSBCODE("FI1")
 I $D(PSBCODE("FI2")) X PSBCODE("FI2")
 ;
 ;Additional format settings
 I PSBSYM]"",$D(PSBCODE("SBF")) X PSBCODE("SBF")
 I PSBSYM="",$D(PSBCODE("EBF")) X PSBCODE("EBF")
 ;
 D START ;execute control codes to start label
 D PRINT ;execute control codes to print label
 ;
 ;Print Barcode Strip
 ;If barcode type is defined.
 I PSBSYM]"",$D(PSBCODE("SB")) S TEXT=PSBBAR X PSBCODE("SB")
 ;If barcode type is not define.
 I PSBSYM="",$D(PSBCODE("SB")) S TEXT="*NO BARCODE TYPE*" X PSBCODE("SB")
 ;
END ; Close Label or End of Label
 I $G(PSBCODE("EL"))]"" X PSBCODE("EL")
 H 2
 Q
 ;
START ;Start Label Print Process
 I $G(PSBCODE("SL"))]"" X PSBCODE("SL")
 Q
 ;
PRINT ;Print barcode label
 ;
 I PSBDRUG]"" S PSBTLE="PSBDRUG",TEXT="Drug: "_PSBDRUG  D PROCESS
 I PSBDOSE]"" S PSBTLE="PSBDOSE",TEXT=PSBDOSE D PROCESS
 I PSBNAME]"" S PSBTLE="PSBNAME",TEXT=PSBNAME  D PROCESS
 I PSBWARD]"" S PSBTLE="PSBWARD",TEXT=PSBWARD  D PROCESS
 I PSBLOT]"" S PSBTLE="PSBLOT",TEXT=PSBLOT  D PROCESS
 I PSBEXP]"" S PSBTLE="PSBEXP",TEXT=PSBEXP  D PROCESS
 I PSBMFG]"" S PSBTLE="PSBMFG",TEXT=PSBMFG  D PROCESS
 I PSBFCB]"" S PSBTLE="PSBFCB",TEXT="Filled/Checked By: "_PSBFCB  D PROCESS
 Q
 ;
PROCESS ;Process control code and field data.
 I $D(PSBCODE("STF")) X PSBCODE("STF")
 I $D(PSBCODE("ST")) X PSBCODE("ST")
 Q
 ;
INPTR ;Input transform for DRUG field (#.31) in file 53.69.
 N PSBIAD,PSBDEA,D,Y
 K:$L(X)>40!($L(X)<1) X  I $D(X) D
 .S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 .N DIC S DIC="^PSDRUG(",DIC(0)="EQNM",D="B^C^VAPN^VAC^NDC^XATC"
 .S DIC("S")="I (($P($G(^PSDRUG(+Y,2)),U,3)[""I"")!($P($G(^(2)),U,3)[""U"")),(('$G(^PSDRUG(+Y,""I"")))!(DT'>$G(^(""I""))))"
 .D:+X'>0 MIX^DIC1
 .D:+X>0 ^DIC
 .S:+Y>0 X=$$GET1^DIQ(50,+Y_",",.01)_"~"_+Y K:+Y<1 X
 Q
