PSBOBL ;BIRMINGHAM/EFC-BAR CODE LABELS (ZEBRA SPECIFIC) ;8/18/21  18:50
 ;;3.0;BAR CODE MED ADMIN;**70,81,106,131**;Mar 2004;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference/IA
 ; File 50/221
 ;
 ;*70 - 1459: Adding clinic to BL and BZ chui labels.
 ;*106- add Hazardous to Handle & Dispose alert text
 ;*131 - Restore y coordinate of first line of label to '25' so as to not be truncated
 ;
EN ;
 N PSBIENS,PSBBAR,PSBDRUG,PSBQTY,PSBDOSE,PSBNAME,PSBWARD,PSBLOT
 N PSBEXP,PSBMFG,PSBFCB,PSBSYM,PSBCNT,PSBANS,PSBORD,PSBCLIN   ;[*70-1459]
 N PSBDD,HAZ,PSBHAZ                                                                     ;*106
 S PSBIENS=PSBRPT_","
 S PSBBAR=$P($P($G(^PSB(53.69,PSBRPT,.3)),U,1),"~",2)
 ;
 S PSBPRE=$$GET^XPAR("DIV","PSB DEFAULT BARCODE PREFIX")
 S:PSBPRE]"" PSBBAR=PSBPRE_$S(PSBPRE?1.N:"-",1:"")_PSBBAR
 ;
 S PSBDRUG=$$GET1^DIQ(53.69,PSBIENS,.31)
 S PSBQTY=+$$GET1^DIQ(53.69,PSBIENS,.35)
 S:PSBQTY PSBDRUG=PSBDRUG_" (Qty: "_PSBQTY_")"
 S PSBDD=$$GET1^DIQ(53.69,PSBIENS,.31,"I"),HAZ=$$HAZ^PSSUTIL($P(PSBDD,"~",2))           ;*106
 S PSBDOSE=$$GET1^DIQ(53.69,PSBIENS,.39)
 S PSBNAME=$$GET1^DIQ(53.69,PSBIENS,.12)
 I PSBNAME]"" S PSBNAME=PSBNAME_" ("_$S(DUZ("AG")="I":$$HRN^AUPNPAT($P($G(^PSB(53.69,+PSBIENS,.1)),U,2),$P(^(0),U,4)),1:$E($$GET1^DIQ(53.69,PSBIENS,.121),6,9))_")" ;add code for IHS, PSB*3*81
 S PSBWARD=$$GET1^DIQ(53.69,PSBIENS,.122)
 S PSBCLIN=$$GET1^DIQ(53.69,PSBIENS,5)                        ;[*70-1459]
 S PSBLOT=$$GET1^DIQ(53.69,PSBIENS,.32)
 S PSBEXP=$$GET1^DIQ(53.69,PSBIENS,.33)
 S PSBMFG=$$GET1^DIQ(53.69,PSBIENS,.34)
 S PSBFCB=$$GET1^DIQ(53.69,PSBIENS,.36)_"/"_$$GET1^DIQ(53.69,PSBIENS,.37)
 S PSBSYM=$$GET^XPAR("DIV","PSB DEFAULT BARCODE FORMAT",,"E")
 F PSBCNT=1:1:+$P(PSBRPT(.3),U,8) D LABEL
 Q
 ;
LABEL ; Print the Label
 W "^XA"
 W !,"^LH0,0^FS"
 W $$DATA(20,25,"Drug:")
 W $$DATA(100,25,PSBDRUG)
 S PSBHAZ=$S($P(HAZ,U):"<<HAZ Handle>> ",1:"") S:$P(HAZ,U,2) PSBHAZ=PSBHAZ_"<<HAZ Dispose>>"   ;*106
 ; *131 - Tweaking the spacing of the dosage label and description to accommodate <HAZ> text
 ;W:$G(PSBHAZ)]"" $$DATA(20,35,PSBHAZ) ;*106
 ;I PSBDOSE]"" W $$DATA(20,60,"Dosage:") W $$DATA(100,60,PSBDOSE)
 S HASHAZ=$G(PSBHAZ)]""
 I HASHAZ D
 . W $$DATA(20,50,PSBHAZ)
 . I PSBDOSE]"" W $$DATA(20,75,"Dosage:") W $$DATA(100,75,PSBDOSE)
 ; If no HAZ text, keep the 'pre-106' x,y coordinates
 I 'HASHAZ D
 . I PSBDOSE]"" W $$DATA(20,60,"Dosage:") W $$DATA(100,60,PSBDOSE)
 I PSBNAME]"" W $$DATA(350,60,PSBNAME)
 I PSBCLIN]"" W $$DATA(350,90,"Clinic:") W $$DATA(400,90,PSBCLIN)            ;[*70-1459]
 I PSBCLIN="",PSBWARD]"" W $$DATA(350,90,"Ward:") W $$DATA(400,90,PSBWARD)   ;[*70-1459]
 I PSBLOT]"" W $$DATA(350,120,"Lot#:") W $$DATA(400,120,PSBLOT)
 I PSBEXP]"" W $$DATA(500,120,"Exp:") W $$DATA(550,120,PSBEXP)
 I PSBMFG]"" W $$DATA(350,150,"Mfg:") W $$DATA(400,150,PSBMFG)
 W $$DATA(350,180,"Filled/Checked By:") W $$DATA(520,180,PSBFCB)
 ;
 ; Code 39 - Adjust spacing to accommodate <HAZ> text if it exists
 I PSBSYM="C39" D
 . I HASHAZ W !,"^BY2,3.0^FO20,107^B3N,N,70,Y,N^FR^FD"_PSBBAR_"^FS"
 . I 'HASHAZ W !,"^BY2,3.0^FO20,100^B3N,N,80,Y,N^FR^FD"_PSBBAR_"^FS"
 ;
 ; Code 128  - Adjust spacing to accommodate <HAZ> text if it exists
 I PSBSYM="128" D
 . I HASHAZ W !,"^BY2,3.0^FO20,107^BCN,70,Y,N,N^FR^FD>:"_PSBBAR_"^FS"
 . I 'HASHAZ W !,"^BY2,3.0^FO20,100^BCN,80,Y,N,N^FR^FD>:"_PSBBAR_"^FS"
 ;
 ; Code I 2 of 5  - Adjust spacing to accommodate <HAZ> text if it exists
 I PSBSYM="I25" D
 . I HASHAZ W !,"^BY2,3.0^FO20,107^B2N,70,Y,N,N^FR^FD>:"_PSBBAR_"^FS"
 . I 'HASHAZ W !,"^BY2,3.0^FO20,100^B2N,80,Y,N,N^FR^FD>:"_PSBBAR_"^FS"
 ;
 I PSBSYM="" W $$DATA(20,100,"PSB DEFAULT BARCODE FORMAT Undefined.")
 ;
 ; Close Label
 W !,"^XZ",!
 H 2
 Q
 ;
DATA(X,Y,TEXT) ; Code to place the data on the label
 W !,"^FO"_X_","_Y_"^A0N,30,20^CI13^FR^FD"_TEXT_"^FS"
 Q ""
 ;
INPTR ;Input transform for DRUG field (#.31) in file 53.69.
 K:$L(X)>40!($L(X)<1) X I $D(X) D
 .S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 .N DIC S DIC="^PSDRUG(",DIC(0)="EQNM",D="B^C^VAPN^VAC^NDC^XATC"
 .S DIC("S")="I '$G(^PSDRUG(+Y,""I""))!($G(^(""I""))>DT),$P($G(^PSDRUG(+Y,2)),U,3)[""I""!($P($G(^PSDRUG(+Y,2)),U,3)[""U"")"
 .D:+X'>0 MIX^DIC1
 .D:+X>0 ^DIC
 .S:+Y>0 X=$$GET1^DIQ(50,+Y_",",.01)_"~"_+Y K:+Y<1 X
 Q
 ;
