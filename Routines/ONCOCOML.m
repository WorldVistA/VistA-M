ONCOCOML ;Hines OIFO/GWB - Display abstract summary; 07/13/00
 ;;2.11;ONCOLOGY;**16,25,26,48**;Mar 07, 1995;Build 13
 ;
 N ACS,TOP,LTS,DDX,ABS,DIV
 S ACS=$$GET1^DIQ(165.5,XD1,.061)
 S TOP=$$GET1^DIQ(165.5,XD1,20)
 S LTS=$$GET1^DIQ(165.5,XD1,95,"I")
 S:LTS'="" LTS=$$GET1^DIQ(164.42,LTS,2)
 S DDX=$$GET1^DIQ(165.5,XD1,3)
 S ABS=$$GET1^DIQ(165.5,XD1,91)
 S DIV=$$GET1^DIQ(165.5,XD1,2000,"I")
 S:DIV'="" DIV=$$GET1^DIQ(4,DIV,99)
 S LIN=" -------------  --------------------  -----------------  ----------  ----  ----"
 I $G(J)=1 D
 .W !?1,"Acc/Sequence",?16,"Primary Site",?38,"Last Tumor Status",?57,"Date Dx",?69,"Stat",?75,"Div"
 .W !,LIN,!
 W ?1,ACS,?16,$E(TOP,1,20),?38,LTS,?57,DDX,?69,$E(ABS,1,3),?75,DIV,!
 Q
