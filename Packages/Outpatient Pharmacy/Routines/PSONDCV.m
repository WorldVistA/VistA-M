PSONDCV ;BP/CMF - Pharmacy NDC Validation ;04/08/08
 ;;7.0;OUTPATIENT PHARMACY;**289**;DEC 1997;Build 107
 ;Reference to $$ECMEON^BPSUTIL supported by DBIA 4410
 ;Reference to $$STATUS^BPSOSRX suppored by DBIA 4300
 ;
 Q
 ;
EN ; entry point for [PSO NDC VALIDATION] option
 N FLAG,PSOINST
 S FLAG=0
 D BEGIN(.FLAG)
 D:FLAG PROMPTS
 D END
 Q
 ;;
BEGIN(RESULT) ;;
 I '$D(PSOSITE) D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"A Pharmacy Division Must Be Selected!",! G END
 S RESULT=$$ECMEON^BPSUTIL(PSOSITE)
 S PSOINST=$$GET1^DIQ(59,PSOSITE,".06")
 D:RESULT=0
 .W !!,"ePharmacy has not been activated for "_$$GET1^DIQ(59,PSOSITE,".01")_"("_PSOSITE_")."
 .W !,"NDC validation not allowed."
 Q
 ;;
END ;;
 ;;D KILL^XUSCLEAN
 Q
 ;;
PROMPTS ;;
 N X,Y,DIC,RXIEN,RX,PSORESP,QFLG,RXNUM,PSOMSG,PSONDCV,CMOP,PID
 S (PSONDCV("QFLG"),PSORESP)=0
 F  Q:PSORESP=-1!(PSONDCV("QFLG"))  D 
 .W !
 .K DIR,RX,RXIEN
 .S DIR(0)="FO^1:245^"
 .S DIR("A")="WAND BARCODE or enter Rx#"
 .S DIR("?",1)="Wand barcodes should be of the form NNN-NNNNNN"
 .S DIR("?",2)="where the number before the dash is your station number."
 .S DIR("?",3)="The fill number used for NDC Validation is defaulted to"
 .S DIR("?",4)="the last fill for the prescription number entered."
 .S DIR("?")="Enter ""^"", or a RETURN to quit."
 .D ^DIR Q:PSONDCV("QFLG")
 .I $D(DIRUT) S PSONDCV("QFLG")=1 K DIRUT,DUOUT,DTOUT,DIROUT Q
 .;
 . I X["-" S QFLG=0 D  Q:QFLG
 .. I $P(X,"-")'=PSOINST W !?7,$C(7),$C(7),$C(7),"Not From this Institution" S QFLG=1 Q
 .. S RXIEN=$P(X,"-",2)
 .. I $G(^PSRX(RXIEN,0))']"" W !,$C(7),"Rx data is not on file !",! S QFLG=1 Q
 .. S RX=$P(^PSRX(RXIEN,0),"^",1)
 . I X'["-" S RX=X K DIC S DIC=52,DIC(0)="BXQ",X=RX D ^DIC D  Q:Y=-1 
 .. I Y=-1 W !!,"Invalid prescription number.",! Q 
 .. S RXIEN=$P(Y,"^"),RX=$P(Y,"^",2)
 . D PSOL^PSSLOCK(RXIEN) I '$G(PSOMSG) D  K PSOMSG S QFLG=1 Q
 .. W $C(7),!!?5,"Another person is editing Rx "_$P($G(^PSRX(+$G(RXIEN),0)),"^"),!
 .;
 .D VALIDATE(RX,RXIEN)
 .D PSOUL^PSSLOCK(RXIEN)
 Q
 ;;
VALIDATE(RX,RXIEN) ;;
 N DIR,X,Y,ISVALID,FLAG,RFL,RXDIV,LBL,LPRT,ESTAT,LABELNDC,STOCKNDC,RXNDC,STOCK
 S FLAG=0,LPRT=0
 S RFL=$$LSTRFL^PSOBPSU1(RXIEN)
 ;
 S RXDIV=$$RXSITE^PSOBPSUT(RXIEN,RFL) I RXDIV'=PSOSITE D  Q
 . W !,"Prescription #"_RX_" is from a different division: "_$$GET1^DIQ(59,RXDIV,".01")_"."
 . W !,"Log into that division for NDC validation.",!!
 ;
 S ISVALID=$$ISVALID(RXIEN,RFL,0)
 I ISVALID D  Q:FLAG
 .W !!,"Prescription "_RX_" has already been validated."
 .S DIR("A")="Are you sure you want to revalidate"
 .S DIR(0)="Y"
 .S DIR("B")="YES"
 .D ^DIR
 .S:Y'=1 FLAG=1
 I $$ISOPAI(RX,RFL) D  Q  ;can't validate RXs sent to external interface
 .W !!,"Prescription "_RX_" has been sent to the external interface."
 .W !,"It cannot be validated at this time."
 I $$ISRELEAS(RXIEN,RFL) D  Q  ;can't validate released RXs
 .W !!,"Prescription "_RX_" has been released."
 .W !,"It cannot be validated at this time."
 I $$ISCMOP(RXIEN,RFL) D  Q  ;can't validate RXs sent to CMOP
 .W !!,"Prescription "_RX_" is a CMOP Rx."
 .W !,"CMOP RXs may not be validated."
 S FLAG=0 D TRICARE1(.FLAG,RXIEN,RFL)
 I FLAG=1 Q
  F LBL=0:0 S LBL=$O(^PSRX(RXIEN,"L",LBL)) Q:'LBL  I +$P(^PSRX(RXIEN,"L",LBL,0),"^",2)=RFL S LPRT=1
 I 'LPRT W !!,"The prescription label must be printed prior to the NDC being validated.",!!  Q
 D DISPLAY(RX,RXIEN,RFL,.RXNDC)
 S LABELNDC=RXNDC
 S STOCK=1
 S FLAG=$$CHGNDC^PSONDCUT(RXIEN,RFL,$G(PID),STOCK) I FLAG="^" S FLAG=1 W !!,"** Validation not completed.",!! Q
 S STOCKNDC=$P(FLAG,"^",2),FLAG=+FLAG
 I FLAG S LABELNDC=$$GETNDC^PSONDCUT(RXIEN,RFL) ;ndc changed
 S ESTAT=$$STATUS^BPSOSRX(RXIEN,RFL)
 I $P(ESTAT,"^")["PAYABLE",(LABELNDC=STOCKNDC!(STOCKNDC=""&('FLAG))) D  ;FLAG=0 NDC not changed; flag=1 ndc changed.
 .W !!,"NDC match confirmed.",!
 .S FLAG=1 D UPDATE(RXIEN,RFL)
 E  D
 . D DEL(RXIEN,RFL)
 . W !!,"NDC validation has not been completed.  " W:$P(ESTAT,"^")'="" "Rx claim was "_$P(ESTAT,"^"),! Q
 Q
 ;;
ISVALID(RXIEN,RFL,VERBOSE) ;;
 Q:RFL=0 $$ISRXVAL(RXIEN,VERBOSE)
 Q $$ISRFLVAL(RXIEN,RFL,VERBOSE)
 ;
ISRXVAL(RXIEN,VERBOSE) ;are NDCs already validated for Rx?
 N IENS,VALIDATE,VALIDUZ,RESULT
 S RESULT=0
 S IENS=RXIEN_","
 S VALIDATE=$$GET1^DIQ(52,IENS,83)
 S VALIDUZ=$$GET1^DIQ(52,IENS,84)
 I VALIDATE'="",VALIDUZ'="" S RESULT=1
 D DISPLAY1(VERBOSE,RESULT,VALIDATE,VALIDUZ)
 Q RESULT
 ;;
ISRFLVAL(RXIEN,RFL,VERBOSE) ;are NDCs already validated for refill?
 N IENS,VALIDATE,VALIDUZ,RESULT
 S RESULT=0
 S IENS=RFL_","_RXIEN_","
 S VALIDATE=$$GET1^DIQ(52.1,IENS,83)
 S VALIDUZ=$$GET1^DIQ(52.1,IENS,84)
 I VALIDATE'="",VALIDUZ'="" S RESULT=1
 D DISPLAY1(VERBOSE,RESULT,VALIDATE,VALIDUZ)
 Q RESULT
 ;;
ISOPAI(RX,RFL) ;;
 N RESULT,II,OPIAIEN,OPIAIEN,OPIARX
 D FIND^DIC(52.51,"",".01;9","",RX,"","","","","RESULT")
 S OPIARX=0
 I $D(RESULT("DILIST","ID")) S II=0 F  S II=$O(RESULT("DILIST","ID",II)) Q:II=""  D
 . I $D(RESULT("DILIST","ID",II,9)) S:RESULT("DILIST","ID",II,9)=RFL OPIARX=1
  Q OPIARX
 ;;
ISRELEAS(RXIEN,RFL) ;; has it been released?
 N RESULT
 S RESULT=0
 I $$RXRLDT^PSOBPSUT(RXIEN,RFL)'="" S RESULT=1
 Q RESULT
 ;;
ISCMOP(RXIEN,RFL) ;; has it been sent to CMOP?
 Q $$CMOP^PSOBPSUT(RXIEN,RFL)
 ;;
DISPLAY(RX,RXIEN,RFL,RXNDC) ;;
 N OUT
 W !
 S OUT=$$LJ^XLFSTR("Rx: "_RX,20)
 S OUT=OUT_$$LJ^XLFSTR("Fill: "_RFL,20)
 S OUT=OUT_$$LJ^XLFSTR("Patient: "_$$GET1^DIQ(52,RXIEN,2),38)
 W !,OUT
 S OUT=$$LJ^XLFSTR("Drug: "_$$GET1^DIQ(52,RXIEN,6),40)
 S RXNDC=$S(+RFL:$$GET1^DIQ(52.1,RFL_","_RXIEN,11),1:$$GET1^DIQ(52,RXIEN,27))
 S OUT=OUT_$$LJ^XLFSTR("NDC: "_RXNDC,38)
 W !,OUT,!
 Q
 ;;
DISPLAY1(VERBOSE,RESULT,VALIDATE,VALIDUZ) ;;
 Q:VERBOSE=0
 I RESULT=1 D  Q
 . W !,"** The following NDC was validated on "_VALIDATE_" by "_VALIDUZ_".",!
 W !,"** This NDC has not been validated.",!!
 Q
 ;;
UPDATE(RXIEN,RFL) ; update validation fields
 N IENS,FILE,FDA,ERROR
 I $G(RFL)>0 D
 .S IENS=RFL_","_RXIEN_","
 .S FILE=52.1
 E  D
 .S IENS=RXIEN_","
 .S FILE=52
 S FDA(FILE,IENS,83)=$$NOW^XLFDT()
 S FDA(FILE,IENS,84)=DUZ
 D FILE^DIE("","FDA","ERROR")
 Q
 ;;
DEL(RXIEN,RFL) ; update validation fields
 N IENS,FILE,FDA,ERROR
 I $G(RFL)>0 D
 .S IENS=RFL_","_RXIEN_","
 .S FILE=52.1
 E  D
 .S IENS=RXIEN_","
 .S FILE=52
 S FDA(FILE,IENS,83)="@"
 S FDA(FILE,IENS,84)="@"
 D FILE^DIE("","FDA","ERROR")
 Q
 ;;
TRICARE1(FLAG,RXIEN,RFL) ; tricare test #1
 N PSOTRIC
 D:$$TRIC^PSOREJP1(RXIEN,RFL,.PSOTRIC)
 .D:$$STATUS^PSOBPSUT(RXIEN,RFL)'="E PAYABLE"
 ..S FLAG=1
 ..W !,"This prescription fill has open Tricare third party insurance"
 ..W !,"rejections that must be resolved prior to completion of NDC validation."
 Q
 ;;
