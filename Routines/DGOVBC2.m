DGOVBC2 ;ALB/MRL - VBC OUTPUT, CONTINUED ; 12 FEB 87
 ;;5.3;Registration;**279**;Aug 13, 1993
 N DGREL,DGINC,DGINR,DGDEP,DG421
 S DGD=$S($D(^DPT(DFN,.362)):^(.362),1:"")
 W ! D L D MB^VADPT W !,"8. Aid & Attendance:  ",$S(VAMB(1):"$"_+$P(VAMB(1),"^",2),1:"NONE"),?40,"Housebound         :  ",$S(VAMB(2):"$"_+$P(VAMB(2),"^",2),1:"NONE"),?90,"Social Security:  ",$S(VAMB(3):"$"_+$P(VAMB(3),"^",2),1:"NONE")
 W !?3,"VA Pension      :  ",$S(VAMB(4):"$"_+$P(VAMB(4),"^",2),1:"NONE"),?40,"Military Retirement:  ",$S(VAMB(5):"$"_+$P(VAMB(5),"^",2),1:"NONE"),?90,"GI Insurance   :  ",$S(VAMB(9):"$"_+$P(VAMB(9),"^",2),1:"NONE")
 W !?3,"Disability      :  ",$S(VAMB(7):"$"_+$P(VAMB(7),"^",2),1:"NONE"),?40,"SSI                :  ",$S(VAMB(6):"$"_+$P(VAMB(6),"^",2),1:"NONE"),?90
 ;MODIFIED BELOW TO RETURN 408.21 INFORMATION FOR OTHER INCOME
 D ALL^DGMTU21(DFN,"V",DT,"I")
 S DGOI421=$P($G(^DGMT(408.21,+$G(DGINC("V")),0)),U,17)
 W "Other Income   :  ",$S(DGOI421']"":"NONE",1:"$"_+DGOI421)
 W !?3,"Other Retirement:  ",$S(VAMB(8):"$"_+$P(VAMB(8),"^",2),1:"NONE"),! D L
 K VAMB S DGD=$S($D(^DPT(DFN,.361)):^(.361),1:"") W !,"9. ",$S($P(DGD,"^",1)'="V":"",1:"Verified "),"SC Disabilities:" S DGX=$X+2
 I 'DGSC W "  NOT A SERVICE-CONNECTED APPLICANT, NOT APPLICABLE!!" G 1
 S DGCT=0 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I  S I1=^(I,0),I2=$S($D(^DIC(31,+I1,0)):$P(^(0),"^",1)_" ("_+$P(I1,"^",2)_"%); ",1:""),DGCT=DGCT+1 I +$P(I1,"^",3) W:(130-$X)<$L(I2) ! W ?DGX,I2
 I 'DGCT W "  NONE ON FILE!!"
1 W ! D L W !,"10. Former POW:  ",$S(DGPOW:"YES",1:"NO"),?30,"| 11. Marital Status:  ",DGMS
 W ?80,"| 12. Means Test: ",$S(DGMT]"":DGMT,1:"NOT REQUIRED"),!,"______________________________|_________________________________________________|_________________________________________________"
 S X="|____________________|_________|_________________________________________________________________________________________________|" W !,DGLIN,!,DGLIN,!,"| DATE SEEN",?21,"| SEEN BY",?31,"| REMARKS",?129,"|"
 F I=$Y:1:$S($D(IOSL):(IOSL-8),1:58) W !,X
 W !,DGLIN,!,"Date/Time Printed:  " D H^DGUTL S Y=DGTIME X ^DD("DD") W Y,!
Q D KVAR^VADPT K %,DFN1,DGSCOND,DG1,DG36,DGA,DGA1,DGAD,DGADM,DGCT,DGD,DGD1,DGD2,DGDATE,DGL,DGMS,DGMT,DGP,DGPOW,DGPT,DGSC,DGSV1,DGT,DGTIME,I,I1,I2,J,X,X1,X2,VAUTN,Y,VAUTD Q
L F DGL=1:1:$S($D(IOM):(IOM-2),1:130) W "_"
 Q
