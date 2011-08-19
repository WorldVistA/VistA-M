MUSMCR2  ;MONITORING PROGRAM
 Q
BEG ;
 I '$D(LET) S LET=""
 S NODE=$G(^DPT(DFN,.21))
 I $P(NODE,"^",1)="" Q
 S NAME=$P(^DPT(DFN,0),"^",1)
 S DPT01=$P(NODE,U),DPT01=$P(DPT01,",",2)_" "_$P(DPT01,",",1)
 S ADD=$S($D(NODE):NODE,1:""),AD1=$P(ADD,U,3),AD2=$P(ADD,U,4),CTY=$P(ADD,U,6),SN=$P(ADD,U,7),ZIP=$P(ADD,U,8),ST=$S($D(^DIC(5,+SN,0)):$P(^(0),U,2),1:SN)
  W !?5,DPT01
 W !?5,"C/O: ",NAME
 W !?5,AD1
 I AD2]"" W !?5,AD2
 W !?5,CTY,"  ",ST,"  ",ZIP
 I "Pp"[$E(LET,1) W !?5,^MUSMCRM(D)
 W @IOF
 Q
