ENSA5 ;(WASH ISC)/DH-Post MedTester PMI ;4.27.99
 ;;7.0;ENGINEERING;**14,35,48,54**;Aug 17, 1993
POST1 ;  No existing PM work order - Post directly to equip hist
 I '$D(ENSHKEY) S DIC="^DIC(6922,",DIC(0)="X",X="BIOMEDICAL" D ^DIC Q:Y'>0  S ENSHKEY=+Y
FAIL I ENFAIL D  Q
 . N PROBLEM S PROBLEM=$S($L(ENWP)>13:ENWP,1:"Device failed MedTester Inspection")
 . S ENMSG="Equipment Entry # "_ENEQ_" FAILED INSPECTION.  Corrective action required.",ENMSG(0,1)="MedTester upload."
 . S ^TMP($J,"FAIL",ENEQ)=""
 . D NEWWO^ENSA9 ; XCPTN^ENSA2 called from ENSA9
PASS S ^TMP($J,"PASS",ENEQ)=""
 N ENW,ENCOST,PMTOT,ENPMDT S (ENW,ENCOST)=""
 I ENWP="" S ENWP="MedTester Electrical Safety Analysis "_ENTEST
 I ENTEC>0,ENTIME>0 D  D ^ENBCPM8
 . S PMTOT(ENSHKEY,ENTEC)=ENTIME,ENPMDT=$S($D(ENSTDT):$E(ENSTDT,2,5),1:$E(DT,2,5))
 . I $D(^ENG("EMP",ENTEC,0)) S ENW=$P(^(0),U,3)
 . I ENW="",$D(^DIC(6910,1,0)) S ENW=$P(^(0),U,4)
 . Q:ENW=""
 . S X=ENW*ENTIME,X(0)=2 D ROUND^ENLIB S ENCOST=+Y
 S:$L(ENWP)>140 ENWP=$E(ENWP,1,140) S ENDTCP=$S($G(ENSTDT):ENSTDT,1:DT),ENH=ENDTCP_"-E1"_U_ENPMWO_U_"P"_U_ENTIME_U_ENCOST_"^^^"_ENEMP_U_ENWP,ENINV=ENEQ
 I $D(^ENG(6914,ENEQ,6)) F J=0:0 S J=$O(^ENG(6914,ENEQ,6,J)) Q:J'>0  I $P(^(J,0),"-")=ENDTCP,$P(^(0),U,9)["MedTester" K ENINV S:$P(^(0),U,2)]"" ENPMWO(0)=$P(^(0),U,2) Q
 I '$D(ENINV) S ENMSG="MedTester Inspection already posted for Equip ID# "_ENEQ_".",ENMSG(0,1)="No action taken.",ENMSG(0,2)="MedTester REC # "_ENREC S:$D(ENPMWO(0)) ENMSG(0,2)=ENMSG(0,2)_"     Work Order Ref: "_ENPMWO(0) D XCPTN^ENSA2
 D:$D(ENINV) EXT^ENEQHS
 Q
 ;ENSA5
