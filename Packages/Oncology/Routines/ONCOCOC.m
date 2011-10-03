ONCOCOC ;Hines OIFO/GWB - COMPUTED FIELDS FOR CASEFINDING REPORTS ;05/25/00
 ;;2.11;ONCOLOGY;**13,16,24,26,33,43,50**;Mar 07, 1995;Build 29
 ;
LAB ;LAB CASEFINDING REPORT (160,53)
 N X
 D GET G EX:O2=""
 S SR=$P(O2,U,3) G EX:$E(SR,1)'="L"
 S SR=$E(SR,2),LRSS=$S(SR="S":"SP",SR="C":"CY",SR="E":"EM",1:"AU")
 S XDT=$P(O2,U,1),MO=$P(O2,U,5),TO=$P(O2,U,6),DZ=$P(O2,U,14)
 S TO=$S(TO="":"None",1:"T-"_$P(^LAB(61,+TO,0),U,2)_"  "_$P(^LAB(61,+TO,0),U,1))
 S MODZ="None"
 I MO S MODZ=$G(^LAB(61.1,+MO,0)),MODZ=$E($P(MODZ,U,2),1,4)_"/"_$E($P(MODZ,U,2),5)_"  "_$P(MODZ,U,1)
 I DZ S MODZ=$G(^LAB(61.4,+DZ,0)),MODZ=$P(MODZ,U,2)_"  "_$P(MODZ,U,1)
 D DT
 W $E(XNM,1,20),?22,$E(XSN,1,6),?29,XDT,?44,LRSS
 I $D(^ONCO(165.5,"C",D0)) D DLC^ONCOCRF,DATEOT^ONCOES W ?54,X
 W !
 W "Topography:",?12,TO,!
 W:MO "Morphology:",?13,MODZ
 W:DZ "Disease:",?15,MODZ
 D SDD^ONCOCOM
 W !,"-------------------------------------------------------------------------------"
 W ! G EX
 ;
PTF ;PTF CASEFINDING REPORT (160,54)
 D GET G EX:O2=""
 S SR=$P(O2,U,3) G EX:$E(SR,1)'="P"
 S IC=$$ICDDX^ICDCODE(+$P(O2,U,9)) G EX:+IC=-1
 S XDT=+$P(O2,U,8)
 D DT
 S XDD=XDT,XDT=$P(O2,U,1)
 D DT
 W $E(XNM,1,20),?22,XSN,?29,XDT_" - "_XDD,!
 W "Diagnosis:",?11,$P(IC,U,2),?19,$P(IC,U,4),!!
 G LST
 ;
RAD ;RADIOLOGY CASEFINDING REPORT (160,58)
 D GET G EX:O2=""
 S SR=$P(O2,U,3) G EX:$E(SR,1)'="R"
 S XDT=$P(O2,U,1),RAD=$P($G(^RAMIS(71,+$P(O2,U,7),0)),U) G EX:RAD=""
 D DT
 ;B "L"
 W $E(XNM,1,29),?31,XSN,?38,XDT,?50,$E(RAD,1,30)
 G LST
 ;
GET ;Set variables
 S XD0=$G(^ONCO(160,D0,0)),GLO="" I XD0="" Q
 S LRDFN=$P(XD0,U,2)
 S VPR=$P(XD0,U)
 S GLO=U_$P(VPR,";",2)_$P(VPR,";"),GL0=GLO_",0)"
 S XPI=$G(@GL0),XNM=$P(XPI,U),SN=$P(XPI,U,9),XSN=$E(XNM,1)_$E(SN,6,9)
 S O2="" I $D(^ONCO(160,D0,"SUS","C",DUZ(2))) D  K SUSIEN
 .S SUSIEN=$O(^ONCO(160,D0,"SUS","C",DUZ(2),0))
 .S O2=^ONCO(160,D0,"SUS",SUSIEN,0)
 Q
 ;
DT ;Format date
 S XDT=$E(XDT,4,5)_"/"_$E(XDT,6,7)_"/"_($E(XDT,1,3)+1700)
 Q
 ;
LST ;Display DATE LAST CONTACT  (160,16) and primary list
 G EX:'$D(^ONCO(165.5,"C",D0))
 D DLC^ONCOCRF,DATEOT^ONCOES
 W !!?25,"Last Contact: ",X
 D SDD^ONCOCOM
 W ! G EX
 ;
EX ;Exit
 S X=""
 K DZ,GL0,GLO,IC,LRDFN,LRSS,MO,MODZ,O2,RAD,SN,SR,TO,VPR,XDT,XD0,XDD,XMO
 K XM1,XNM,XPI,XSN
 Q
