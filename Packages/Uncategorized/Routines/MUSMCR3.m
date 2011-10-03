MUSMCR3 ;ROSE'S DRUG SEARCH
 Q
BEG ;
 S NAME=$P(^DPT(DFN,0),"^",1)
 S DPT01=$P(^DPT(DFN,0),U),DPT01=$P(DPT01,",",2)_" _$P(DPT01,",",1)
 S ADD=$S($D(^DPT(DFN,.11)):^(.11),1:"")
 S AD1=$P(ADD,U,1),AD2=$P(ADD,U,2),CTY=$P(ADD,U,4)
 S SN=$P(ADD,U,5),ZIP=$P(ADD,U,6)
 S ST=$S($D(^DIC(5,+SN,0)):$P(^(0), U,2),1:SN)
 W !?5,DPT01 
 W !?5,AD1
 I AD2]"" W !?5,AD2 W !?5,CTY,"  ",ST,"  ",ZIP
 I "Pp"[$E(LET,1) W !?5,^MUSMCRM(D)
 W @IOF Q
