PSOXWRH ; GENERATED FROM 'PSO DRUG WARNINGS HEADER' PRINT TEMPLATE (#1507) ; 07/16/10 ; (FILE 52, MARGIN=255)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 S I(0)="^PSRX(",J(0)=52
 W ?0 W "\\^PATIENT^SSN^ADDRESS 1^ADDRESS 2^ADDRESS 3^CITY^STATE^ZIP^PHONE (HOME)^PHONE (WORK)^PHONE (CELL)^DECEASED?^RX #^DRUG^FINISH D/T^QTY PER DAY^STATUS^REF REM^PROVIDER^LAST DISPENSED DATE^RETURNED TO STOCK?"
 K Y
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------",!!
