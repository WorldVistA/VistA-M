ONCOCOML ;Hines OIFO/GWB - Display abstract summary; 07/13/00
 ;;2.2;ONCOLOGY;**1,4**;Jul 31, 2013;Build 5
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
 ;
DIS2 ;
 N PID,NAM,ACS,TOP,DDX,DIV
 S PID=$$GET1^DIQ(165.5,ONCXD1,61)
 S NAM=$$GET1^DIQ(165.5,ONCXD1,.02)
 S ACS=$$GET1^DIQ(165.5,ONCXD1,.061)
 S TOP=$$GET1^DIQ(165.5,ONCXD1,20)
 S DDX=$$GET1^DIQ(165.5,ONCXD1,3)
 S DIV=$$GET1^DIQ(165.5,ONCXD1,2000,"I")
 S:DIV'="" DIV=$$GET1^DIQ(4,DIV,99)
 W !?1,PID,?8,$E(NAM,1,18),?27,ACS,?42,$E(TOP,1,21),?64,DDX,?76,DIV
 Q
 ;
HDR ;
 W !?1,"PID",?8,"Name",?27,"Acc/Sequence",?42,"Primary Site",?64,"Date Dx",?76,"Div"
 W !?1,"-----",?8,"-----------------",?27,"-------------",?42,"--------------------",?64,"----------",?76,"---"
 Q
