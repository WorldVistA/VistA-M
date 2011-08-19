SCDXRT03 ;BP OIFO/KEITH - AMB CARE RETRANSMISSION BY SELECTED ERROR CODE ; 12/26/01 2:08pm
 ;;5.3;Scheduling;**215,247**;AUG 13, 1993
 ;
CODE ;Retransmit by selected error code
 ;
 N DIC,X,Y,SDERR,DIR,SDBEG,SDEND,SDCT,SDT,SDTOE,SDTOEE,SDTOEE0,SDTOT
 S DIC="^SD(409.76,",DIC(0)="AEMQ" W ! D ^DIC
 Q:$D(DTOUT)!$D(DUOUT)  Q:Y'>0  S SDERR=+Y
BEG S X=$$ECLMO() S:'X X=2991000 S X=X+1
 I '$O(^SD(409.75,"AEDT",X)) D  Q
 .W !!,"No errors on file since the most recent database closeout date."
 .Q
 S DIR(0)="D^"_X_":"_DT_":EXP"
 S DIR("A")="Start date"
 W ! D ^DIR Q:$D(DTOUT)!$D(DUOUT)  S SDBEG=Y
 I '$O(^SD(409.75,"AEDT",Y)) D  G BEG
 .W !!,"No errors on file later than the date specified."
 .Q
 S DIR(0)="D^"_Y_":"_DT_":EXP"
 S DIR("A")="  End date"
 W ! D ^DIR Q:$D(DTOUT)!$D(DUOUT)  S SDEND=Y_.999999
 I $O(^SD(409.75,"AEDT",SDBEG))>SDEND D  G BEG
 .W !!,"No errors on file within the date range specified."
 .Q
 W ! D WAIT^DICD  ;Pause
 ;Search for transmitted encounters with selected error by date range
 S (SDTOT,SDCT)=0,SDT=SDBEG
 F  S SDT=$O(^SD(409.75,"AEDT",SDT)) Q:'SDT!(SDT>SDEND)  D
 .S SDTOE=0 F  S SDTOE=$O(^SD(409.75,"AEDT",SDT,SDTOE)) Q:'SDTOE  D
 ..S SDTOEE=0
 ..F  S SDTOEE=$O(^SD(409.75,"AEDT",SDT,SDTOE,SDTOEE)) Q:'SDTOEE  D
 ...S SDTOEE0=$G(^SD(409.75,SDTOEE,0))
 ...S SDCT=SDCT+1 W:SDCT#100=0 "."  ;Dot out
 ...Q:$P(SDTOEE0,U,2)'=SDERR  ;Quit if not the selected error
 ...S SDTOT=SDTOT+1  ;Count records flagged
 ...D STREEVNT^SCDXFU01(SDTOE,0)  ;Record event
 ...D XMITFLAG^SCDXFU01(SDTOE,0)  ;Mark record for transmission
 ...Q
 ..Q
 .Q
 I 'SDTOT D  Q
 .W !!,"No encounters were found in this date range with the selected error code!"
 .Q
 W !!,SDTOT," encounter",$S(SDTOT=1:"",1:"s")," flagged for transmission."
 Q
 ;
ECLMO() ;Earliest month following the most recent database closeout
 N SDY,SDM,SDX
 S SDY=$E(DT,1,3)
 S SDM=$E(DT,4,5)
 S SDY=SDY-2 S:SDM<10 SDY=SDY-1
 S SDX=SDY_1000 ;Days greater than this one are acceptable
 Q SDX
