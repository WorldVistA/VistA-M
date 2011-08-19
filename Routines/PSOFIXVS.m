PSOFIXVS ;BIR/HTW-Data Cleanup Utility; [ 09/08/95  12:38 PM ]
 ;;6.0;OUTPATIENT PHARMACY;**140,142**;APRIL 1993
VERIFY ;
 W !!,"Checking Rx Verify File"
 S CT=0
 S I="" F  S I=$O(^PS(52.4,"B",I)) Q:I=""  I '$D(^PSRX(I)) D
 .S DIK="^PS(52.4,",DA=I D ^DIK K DIK,DA
 .S CT=CT+1
 .I CT=1 W !!,"Entries deleted from Rx Verify File (52.4): "
 .W !,I
 W !!,$G(CT)," Entries deleted from Rx Verify File (52.4)."
SUSPENSE ;
 W !!,"Checking Rx Suspense File"
 S CT=0
 F I=0:0 S I=$O(^PS(52.5,"B",I)) Q:'I  I '$D(^PSRX(I)) D
 .S I525=$O(^PS(52.5,"B",I,"")) Q:'I525
 .I '$D(^PS(52.5,I525)) K ^PS(52.5,"B",I,I525) Q
 .S DIK="^PS(52.5,",DA=I525 D ^DIK K DIK,DA
 .S CT=CT+1
 .I CT=1 W !!,"Entries deleted from Rx Suspense File (52.5): "
 .W !,I525 K I525
 W !!,$G(CT)," Entries deleted from Rx Suspense File (52.5)."
 K CT,I
 Q
