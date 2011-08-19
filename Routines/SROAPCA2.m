SROAPCA2 ;BIR/MAM - PRINT OPERATIVE DATA ;06/28/06
 ;;3.0; Surgery ;**38,71,95,125,153,174**;24 Jun 93;Build 8
 S SRA(206)=$G(^SRF(SRTN,206)),SRA(207)=$G(^SRF(SRTN,207)),SRA(209)=$G(^SRF(SRTN,209)),SRA(207.1)=$G(^SRF(SRTN,207.1))
 S SRAO(1)=$P(SRA(207),"^")_"^365"
 S SRAO(2)=$P(SRA(207),"^",2)_"^366"
 S SRAO(3)=$P(SRA(207),"^",24)_"^464"
 S SRAO(4)=$P(SRA(207),"^",25)_"^465"
 S SRAO(5)=$P(SRA(207),"^",20)_"^416"
 S NYUK=$P(SRA(207),"^",3) D VL^SROACR1 S SRAO(6)=SHEMP_"^367"
 S NYUK=$P(SRA(207),"^",4) D VL^SROACR1 S SRAO(7)=SHEMP_"^368"
 S NYUK=$P(SRA(207),"^",5) D VL^SROACR1 S SRAO(8)=SHEMP_"^369"
 S NYUK=$P(SRA(207),"^",28) D VL^SROACR1 S SRAO(9)=SHEMP_"^493"
 S NYUK=$P(SRA(207),"^",7) D YN S SRAO(10)=SHEMP_"^371"
 S NYUK=$P(SRA(209),"^",9) D YN S SRAO(11)=SHEMP_"^481"
 S NYUK=$P(SRA(209),"^",11) D YN S SRAO(12)=SHEMP_"^483"
 S NYUK=$P(SRA(209),"^",14) S SHEMP=$S(NYUK="F":"FULL MAZE",NYUK="N":"NO MAZE PERFORMED",NYUK="M":"MINI MAZE",1:"") S SRAO(13)=SHEMP_"^512"
 S NYUK=$P(SRA(207),"^",12) D YN S SRAO(14)=SHEMP_"^376"
 S NYUK=$P(SRA(207),"^",13) D YN S SRAO(15)=SHEMP_"^380"
 S NYUK=$P(SRA(207),"^",16) D YN S SRAO(16)=SHEMP_"^378"
 S NYUK=$P(SRA(207),"^",14) D YN S SRAO(17)=SHEMP_"^377"
 S NYUK=$P(SRA(207),"^",18) D YN S SRAO(18)=SHEMP_"^379"
 S NYUK=$P(SRA(207),"^",9) D YN S SRAO(19)=SHEMP_"^373"
 S NYUK=$P($G(^SRF(SRTN,209.1)),"^") S SRAO(20)=$S(NYUK="NS":"NS",1:NYUK)_"^484"
 S NYUK=$P(SRA(207),"^",8) D YN S SRAO(21)=SHEMP_"^372"
 S NYUK=$P(SRA(207.1),"^",2) D YN S SRAO("21H")=SHEMP_"^505"
 S NYUK=$P(SRA(207),"^",15) D YN S SRAO(22)=SHEMP_"^381"
 S NYUK=$P(SRA(207),"^",17) D YN S SRAO(23)=SHEMP_"^382"
 S SRAO(24)=$P(SRA(206),"^",37)_"^451"
 S SRAO(25)=$P(SRA(206),"^",36)_"^450"
 S Y=$P(SRA(207),"^",26),C=$P(^DD(130,468,0),"^",2) D:Y'="" Y^DIQ S SRAO(26)=Y_"^468"
 S Y=$P(SRA(207),"^",27),C=$P(^DD(130,469,0),"^",2) D:Y'="" Y^DIQ S SRAO(27)=Y_"^469"
 S NYUK=$P(SRA(209),"^",13) D YN S SRAO(29)=SHEMP_"^502"
 W !!,"VI. OPERATIVE DATA"
 W !,"Cardiac surgical procedures with or without cardiopulmonary bypass",!,"CABG distal anastomoses:",?40,"Maze procedure:",?61,$J($P(SRAO(13),"^"),17)
 W !,?2,"Number with Vein:",?33,$P(SRAO(1),"^"),?40,"ASD repair:",?75,$P(SRAO(14),"^")
 W !,?2,"Number with IMA:",?33,$P(SRAO(2),"^"),?40,"VSD repair:",?75,$P(SRAO(15),"^")
 W !,?2,"Number with Radial Artery:",?33,$P(SRAO(3),"^"),?40,"Myectomy for IHSS:",?75,$P(SRAO(16),"^")
 W !,?2,"Number with Other Artery:",?33,$P(SRAO(4),"^"),?40,"Myxoma resection:",?75,$P(SRAO(17),"^")
 W !,?2,"Number with Other Conduit:",?33,$P(SRAO(5),"^"),?40,"Other tumor resection:",?75,$P(SRAO(18),"^")
 W !,"LV Aneurysmectomy:",?33,$P(SRAO(10),"^"),?40,"Cardiac transplant:",?75,$P(SRAO(19),"^")
 W !,"Bridge to transplant/Device:",?33,$P(SRAO(11),"^"),?40,"Great Vessel Repair:",?75,$P(SRAO(21),"^")
 W !,"TMR:",?33,$P(SRAO(12),"^"),?40,"Endovascular Repair:",?75,$P(SRAO("21H"),"^")
 W !,?40,"Other Cardiac procedure(s):",?75,$P(SRAO(29),"^")
 W !,"Aortic Valve Procedure:",?33,$P(SRAO(6),"^")
 W !,"Mitral Valve Procedure:",?33,$P(SRAO(7),"^")
 W !,"Tricuspid Valve Procedure:",?33,$P(SRAO(8),"^")
 W !,"Pulmonary Valve Procedure:",?33,$P(SRAO(9),"^")
 W !,"* Other Cardiac procedures (Specify): " I $P(SRAO(20),"^")'="" S SRQ=0 S X=$P(SRAO(20),"^") W:$L(X)<49 X,! I $L(X)>48 S Z=$L(X) D
 .I X'[" " W ?29,X Q
 .S I=0,LINE=1 F  S SRL=$S(LINE=1:48,1:80) D  Q:SRQ
 ..I $E(X,1,SRL)'[" " W X,! S SRQ=1 Q
 ..S J=SRL-I,Y=$E(X,J),I=I+1 I Y=" " W $E(X,1,J-1),! S X=$E(X,J+1,Z),Z=$L(X),I=0,LINE=LINE+1 I Z<SRL W X S SRQ=1 Q
 W !!,"Indicate other cardiac procedures only if done with cardiopulmonary bypass"
 W !,"Foreign body removal:",?33,$P(SRAO(22),"^")
 W !,"Pericardiectomy:",?33,$P(SRAO(23),"^")
 W !!,"Other Operative Data details"
 W !,"Total CPB Time: ",?20,$P(SRAO(24),"^")_" min",?42,"Total Ischemic Time: ",$P(SRAO(25),"^")_" min"
 W !,"Incision Type: ",?25,$P(SRAO(26),"^")
 W !,"Conversion Off Pump to CPB: ",$P(SRAO(27),"^")
 I $Y+6>IOSL D PAGE^SROAPCA I SRSOUT Q
 K SRA,SRAO D ^SROAPCA3
 Q
YN ; store answer
 S SHEMP=$S(NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
