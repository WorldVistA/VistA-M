ONCOXA3 ; GENERATED FROM 'ONCOXA3' PRINT TEMPLATE (#829) ; 03/11/05 ; (FILE 165.5, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(829,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D N:$X>2 Q:'DN  W ?2 W "Diagnostic confirmation: "
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,6) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Tumor size: "
 S Y=$P(X,U,9) S Y(0)=Y D STOT^ONCOOT W $J(Y,7)
 D N:$X>2 Q:'DN  W ?2 W "Extension: "
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,10) S Y(0)=Y S ONCOX="E",ONCFLD=30 D OT^ONCODEL W $J(Y,2)
 D N:$X>2 Q:'DN  W ?2 W "Regional lymph nodes positive: "
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,12) S Y(0)=Y D RNP^ONCOOT W $J(Y,3)
 D N:$X>2 Q:'DN  W ?2 W "Regional lymph nodes examined: "
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,13) S Y(0)=Y D RNE^ONCOOT W $J(Y,3)
 D N:$X>2 Q:'DN  W ?2 W "Lymph nodes: "
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,11) S Y(0)=Y S ONCOX="L" D OT^ONCODEL W $J(Y,2)
 D N:$X>2 Q:'DN  W ?2 W "SEER Summary Stage 2000: "
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,17) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Sites of metastases: "
 D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,14) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D N:$X>43 Q:'DN  W ?43 S Y=$P(X,U,15) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D N:$X>63 Q:'DN  W ?63 S Y=$P(X,U,16) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Clinical TNM:     "
 D N:$X>20 Q:'DN  W ?20 S STGIND="C",X=$$TNMOUT^ONCOTNO(D0) W $E(X,1,12) K Y(165.5,37)
 D N:$X>39 Q:'DN  W ?39 W "Pathologic TNM:  "
 D N:$X>59 Q:'DN  W ?59 S STGIND="P",X=$$TNMOUT^ONCOTNO(D0) W $E(X,1,12) K Y(165.5,89.1)
 D N:$X>2 Q:'DN  W ?2 W "AJCC Stage (Clin):  "
 S X=$G(^ONCO(165.5,D0,2)) D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,20) S Y(0)=Y S X="" D OT^ONCOTNS W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 W "AJCC Stage (Path):  "
 S X=$G(^ONCO(165.5,D0,2.1)) D N:$X>59 Q:'DN  W ?59 S Y=$P(X,U,4) S Y(0)=Y S X="" D OT^ONCOTNS W $E(Y,1,30)
 D N:$X>29 Q:'DN  W ?29 W " " K DIP K:DN Y
 D N:$X>2 Q:'DN  W ?2 W "FIRST COURSE OF TREATMENT SUMMARY:"
 D N:$X>2 Q:'DN  W ?2 W "Dx/Staging/Palliative Proc: "
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,27) S Y(0)=Y D NCDSOT^ONCODSR W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Date First Surgical Procedure: "
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,38) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Surgery of primary site (F): "
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,29) S Y(0)=Y S FIELD=58.6 D SPSOT^ONCOSUR W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Surgical Margins: "
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,28) S Y(0)=Y S FILNUM=165.5,FLDNUM=59 D SOC^ONCOOT W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Reason for no surgery: "
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,26) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Radiation: "
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,6) W:Y]"" $S($D(DXS(7,Y)):DXS(7,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Radiation Sequence: "
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,7) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Reason for no radiation: "
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,35) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Chemotherapy: "
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,13) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Hormone Therapy: "
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,16) W:Y]"" $S($D(DXS(11,Y)):DXS(11,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Immunotherapy: "
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,19) W:Y]"" $S($D(DXS(12,Y)):DXS(12,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Other treatment: "
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,25) W:Y]"" $S($D(DXS(13,Y)):DXS(13,Y),1:Y)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
