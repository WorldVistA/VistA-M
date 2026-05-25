PSOERBT0 ;ALB/MFR - Dispense Drug Conversion Prompts  ;Jan 16, 2025@12:43:34
 ;;7.0;OUTPATIENT PHARMACY;**770**;DEC 16, 1997;Build 145
 ;
DRUGREP ; VistA Drug Replacement Entry Point
 N DIC,DWLW,DWPK,DIWESUB,DUOUT,DIR,CNT,RX,DIRUT,DIROUT,TIUTITLE,PSOTITL,PSODFN,PSOQUIT,STOP,PSOTIUDA,TIUX
 S VALMBCK="R" D FULL^VALM1
 I $$GET1^DIQ(59.7,1,102,"I")'="MBM" D  Q
 . S VALMSG="This action is available for Meds-by-Mail (MbM) site only"
 D ENTRYSEL^PSOERBT I '$O(^TMP("PSOERSEL",$J,0)) Q
 ;
 ; Progress Note for Drug Replacement
 W ! K ^TMP("PSOERPN",$J)
 S DIC="^TMP(""PSOERPN"""_",$J,"
 S DWLW=80,DWPK=1
 S DIWESUB="PATIENT PROGRESS NOTE" W !,DIWESUB,":"
 W ! D EN^DIWE I $G(DUOUT) Q
 ;
 S (RX,CNT)=0 F  S RX=$O(^TMP("PSOERSEL",$J,RX)) Q:'RX  S CNT=CNT+1
 W ! K DIR S DIR(0)="SA^Y:YES;N:NO",DIR("B")="NO"
 S DIR("A")="Are you sure you want to replace the VistA Drug for "
 S DIR("A")=DIR("A")_$S(CNT>1:"these "_$G(IOINHI)_CNT_$G(IOINORM)_" Rx's",1:"Rx #"_$$GET1^DIQ(52,+$O(^TMP("PSOERSEL",$J,RX)),.01))_"? "
 D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y="N") Q
 ;
 W ! S TIUTITLE="PHARMACY RX DRUG REPLACEMENT"
 S PSOTITL=$$FIND1^DIC(8925.1,"","X",TIUTITLE,"B")
 S (RXIEN,PSOQUIT)=0
 F  S RXIEN=$O(^TMP("PSOERSEL",$J,RXIEN)) Q:'RXIEN  D  I PSOQUIT Q
 . ;
 . S ENTRYNUM=+$G(^TMP("PSOERSEL",$J,RXIEN))
 . W !!,IOINHI_$J(ENTRYNUM,4)_". "_$$GET1^DIQ(52,RXIEN,.01)_" - "_$$GET1^DIQ(52,RXIEN,6)_IOINORM
 . W !,"      Replacing Dispense Drug with "_IOINHI_$$GET1^DIQ(50,NEWDRUG,.01)_IOINORM_"..."
 . ;
 . S SWAP=$$SWAPDRUG^PSODRGU0(RXIEN,NEWDRUG) W:SWAP IOINHI_"OK"_IOINORM
 . I 'SWAP D  Q
 . . W !,"ERROR: ",$P(SWAP,"^",2)
 . . W !! S STOP=$$ASKFLD^PSOSPMA3("E",,"Enter <RET> to continue or '^' to STOP") I STOP="^" S PSOQUIT=1
 . ;
 . W !,"      Creating a new Progress Note..."
 . K ^TMP("TIUP",$J) M ^TMP("TIUP",$J)=^TMP("PSOERPN",$J)
 . S PSODFN=$$GET1^DIQ(52,RXIEN,2,"I")
 . D NEW^TIUPNAPI(.PSOTIUDA,PSODFN,DUZ,$$NOW^XLFDT,PSOTITL)
 . I +$G(PSOTIUDA)<0 D  Q
 . . W !,$G(IOINHI),"A problem was encountered while creating the Progress Note.",$G(IOINORM),$C(7),!
 . . W !! S STOP=$$ASKFLD^PSOSPMA3("E",,"Enter <RET> to continue or '^' to STOP") I STOP="^" S PSOQUIT=1
 . S TIUX(.05)=$$FIND1^DIC(8925.6,"","X","COMPLETED","B")
 . S TIUX(1501)=$$NOW^XLFDT()
 . S TIUX(1502)=DUZ
 . S TIUX(1503)=$$GET1^DIQ(200,+DUZ,20.2)
 . S TIUX(1504)=$$GET1^DIQ(200,+DUZ,20.3)
 . S TIUX(1505)="E"
 . D UPDATE^TIUSRVP(.ERXRET,PSOTIUDA,.TIUX)
 . W IOINHI_"OK"_IOINORM
 ;
 I '$G(PSOQUIT) W !!,"Dispense Drug Replacement completed!",!
 ;
 K ^TMP("TIUP",$J),^TMP("PSOERPN",$J) D PAUSE^PSOERXUT
 D REF^PSOERBT
 ;
 Q
