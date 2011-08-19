FHADR1A ; HISC/NCA - Dietetic Facility Profile ;4/27/93  09:32
 ;;5.5;DIETETICS;;Jan 28, 2005
EN2 ; Print Facility Profile
 D HDR^FHADRPT,HDR
 K N F I=1:1:13 S N(I)=""
 S PRE=FHYR_"0000",(X0,X1)="" D LP
 Q
LP F L1=PRE:0 S L1=$O(^FH(117.3,L1)) Q:L1<1!($E(L1,1,3)'=$E(PRE,1,3))  I $G(^FH(117.3,L1,0))'="" S X0=^(0),X1=L1
 Q:X0=""
 S ST=$G(^DIC(4,FHX1,0)) Q:ST=""
 S X=$P(ST,"^",1,2)_"^"_$P($G(^DIC(4,FHX1,99)),"^",1)
 F I=1:1:3 S N(I)=$P(X,"^",I)
 S N(2)=$P($G(^DIC(5,N(2),0)),"^",1)
 S K=3 F I=3:1:12 S K=K+1,N(K)=$P(X0,"^",I)
 F I=5,8:1:13 S N(I)=$S(N(I)="Y":"YES",1:"NO")
 W ?13,"NAME: ",?39,N(1),?86,"STATION NUMBER: ",?104,N(3)
 W !?13,"LOCATION: ",?39,N(2),?86,"REGION:",?104,N(4)
 W !?13,"RPM CLASSIFICATION: ",?39,N(6),?86,"COMPLEXITY LEVEL: ",N(7)
 W !?13,"MULTI DIVISION FACILITY:",?39,N(5),!
L1 S (FLG,L1)=0 S FLG=1 F  S L1=$O(^FH(117.3,X1,"DELV",L1)) Q:L1<1  S X2=$G(^(L1,0)) D:$Y'<LIN HDR^FHADRPT,HDR D LP1
L2 W !!?13,"COOK CHILL FOODS: ",?66,$J($S($P(X0,"^",21)="Y":"YES",1:"NO"),3)
 I $P(X0,"^",21)="Y" S TIT=";"_$P(^DD(117.3,52,0),"^",3),L2=$F(TIT,";"_$P(X0,"^",22)_":") S:L2>0 L2=$P($E(TIT,L2,999),";",1) W:L2'="" !!?15,L2,!
L3 S (FLG,L3)=0 S FLG=1 F  S L3=$O(^FH(117.3,X1,"SPEC",L3)) Q:L3<1  S X2=$G(^(L3,0)) D:$Y'<LIN HDR^FHADRPT,HDR D LP1
 D:$Y'<(LIN-8) HDR^FHADRPT,HDR
 W !!?13,"DIETETIC INTERNSHIP/PROGRAMS:"
 W !!,?15,"VA SPONSORED DIETETIC INTERNSHIP",?66,$J(N(8),3)
 W !?15,"AFFILIATED AP4",?66,$J(N(9),3),!,?15,"AFFILIATED DIETETIC INTERNSHIP",?66,$J(N(10),3)
 W !,?15,"AFFILIATED CUP",?66,$J(N(11),3),!,?15,"VA SPONSORED AP4",?66,$J(N(12),3)
 W !,?15,"AFFILIATED DIETETIC TECHNICIAN",?66,$J(N(13),3) D:$Y'<(LIN-8) HDR^FHADRPT,HDR
 W !!?13,"FUNDED NUTRITION RESEARCH",?66,$J($S($P(X0,"^",23)="Y":"YES",1:"NO"),3),?95 I $P(X0,"^",23)="Y" W:$P(X0,"^",24)'="" $J($P(X0,"^",24),5,1)
 W !?13,"UNFUNDED NUTRITION RESEARCH",?66,$J($S($P(X0,"^",25)="Y":"YES",1:"NO"),3),?95 I $P(X0,"^",25)="Y" W:$P(X0,"^",26)'="" $J($P(X0,"^",26),5,1),!
 S L2=0 F  S L2=$O(^FH(117.3,X1,"AREA",L2)) Q:L2<1  S X2=$G(^(L2,0)) I X2'="" S TIT=";"_$P(^DD(117.356,.01,0),"^",3),ZZ=$F(TIT,";"_+X2_":") S:ZZ>0 ZZ=$P($E(TIT,ZZ,999),";",1) W:ZZ'="" !?15,ZZ
 K N Q
LP1 S Z=$P(X2,"^",1),LST=$G(^FH(117.4,Z,0)) Q:LST=""  S TYP=$P(LST,"^",2)
 I FLG W !?13,$S(TYP="S":"SPECIALIZED MEDICAL PROGRAMS:",TYP="D":"PRIMARY DELIVERY SYSTEM:",1:"NOT SPECIFIED") W ! S FLG=0 I TYP="S" W ?86,"ASSIGNED CLINICAL FTEE",!
 W !?15,$P(LST,"^",1) W:$P(X2,"^",2)'="" ?95,$J($P(X2,"^",2),5,1) Q
HDR ; Print Facility Profile Heading
 W !!!,?13,"S E C T I O N  I   F A C I L I T Y   P R O F I L E",!!!! Q
