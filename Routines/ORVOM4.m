ORVOM4 ; slc/dcm - Creates rtn ending in 'ONIT3' ;9/16/91  15:51 ;
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 S DNAME=E_3,DL=0,(DH,Q)=" ;"
 K ^UTILITY($J) F DD=1:1 S X=$P($T(TXT+DD),";",3,999) Q:X=""  S ^UTILITY($J,DD,0)=X
 S ORVROM=2 D ZI^ORVOM3 G ^ORVOM5 ;cu
TXT ;
 ;; K ^UTILITY("ORVROM",$J) S DIC(0)="LX",ORNMCHK=1 I $D(^ORD(101,0))#2,^(0)?1"PROTOCOL".E S DIC="^ORD(101,",DLAYGO=101,N="PRO" D ADD,OP
 ;; K ^UTILITY(U,$J),DIC,DLAYGO
 ;; Q
 ;;DIEZ I ^DD("VERSION")>17.4,'$D(DISYS),$D(^%ZOSF("OS"))#2 S DISYS=+$P(^("OS"),"^",2)
 ;; E  S DISYS=^DD("OS")
 ;; Q:'$D(^DD("OS",DISYS,"ZS"))
 ;; S N=$O(^UTILITY("ORVROM",$J,DIR,0)) Q:N=""  S Y=+^(N) K ^(N)
 ;; I $D(@("^"_DIR_"(Y,""ROU"")")) K ^("ROU") I $D(^("ROUOLD")) S X=^("ROUOLD"),DMAX=^DD("ROU") D:X]"" @("EN^DI"_$E(DIR,3)_"Z")
 ;; G DIEZ
 ;; ;
 ;;OP S NM=$O(^UTILITY("ORVROM",$J,N,NM)) I NM="" K ^UTILITY("ORVROM",$J) G Q
 ;; S R=$O(^UTILITY("ORVROM",$J,N,NM,0)) G:R="" OP
 ;; W !,"'"_NM_"' Protocol Filed" S DA=+^UTILITY("ORVROM",$J,N,NM,R)
 ;; S %=$P(^ORD(101,DA,0),U,12) S:%]"" %=$O(^DIC(9.4,"B",%,0))
 ;; S $P(^ORD(101,DA,0),U,12)=%,(ORDZ,ORDIX)=0
 ;; S %=$S($D(^ORD(101,DA,5)):$P(^(5),"^"),1:"") I $L(%) S $P(^(5),"^")="",X=$P(%,";",2),%=$P(%,";") I $D(@("^"_X_"""B"","""_%_""")")) S %=$O(^(%,0)) S %=$S(%:%_";"_X,1:""),$P(^ORD(101,DA,5),"^")=%
 ;; I $D(^ORD(101,DA,3,0)) S I=0 F  S I=$O(^ORD(101,DA,3,I)) Q:I<1  S KEY=^(I,0) K ^(0) I $D(^DIC(19.1,"B",KEY)) S KEY=$O(^(KEY,0)) I KEY S ^ORD(101,DA,3,I,0)=KEY
 ;; I $D(^ORD(101,DA,3)) S I=0 F  S I=$O(^ORD(101,DA,3,I)) Q:I<1  S ORDZ=ORDZ+1,ORDIX=X
 ;; I  S $P(^ORD(101,DA,3,0),"^",3,4)=ORDIX_"^"_ORDZ
 ;; I $D(^UTILITY("ORVROM",$J,N,NM,R,10)) S X=0 F  S X=$O(^UTILITY("ORVROM",$J,N,NM,R,10,X)) Q:X<1  D A1
 ;; S (ORDZ,ORDIX)=0 S X=0 F  S X=$O(^ORD(101,DA,10,X)) Q:X<1  S ORDZ=ORDZ+1,ORDIX=X
 ;; S:$D(^ORD(101,DA,10,0)) ^(0)="^101.01PA^"_ORDIX_U_ORDZ D IX1^DIK
 ;; I $D(^UTILITY("ORVROM",$J,N,NM,R,"MEN")) S IMEN=0 F  S IMEN=$O(^UTILITY("ORVROM",$J,N,NM,R,"MEN",IMEN)) Q:IMEN=""  S OMEN=^(IMEN),MEN=IMEN D MEN
 ;; K MEN,IMEN,OMEN
 ;; G OP
 ;; ;
 ;;ADD S R=0 F  S R=$O(^UTILITY(U,$J,N,R)) Q:R=""  S X=$P(^(R,0),U),I=$P(^(0),U,4) D
 ;; . I $L($T(DOT^ORVOM)) D DOT^ORVOM
 ;; . I '$L($T(DOT^ORVOM)) W "."
 ;; . I $O(^ORD(101,"B",X,0)) S Y=$O(^(0)),ORA=Y,Y=Y_U D A Q
 ;; . D ^DIC I Y>0,'$D(DIFQ(N))!$P(Y,U,3) S ORA=Y,Y=Y_U D A
 ;;Q K ORA,MEN,OMEN,ORNMCHK,ORDZ,ORDIX S (NM,R)=0 Q
 ;;A S ^UTILITY("ORVROM",$J,N,X,R)=Y
 ;; I $O(^UTILITY(U,$J,N,R,1,0))>0 K ^ORD(101,+Y,1)
 ;; I $O(^UTILITY(U,$J,N,R,10,0))>0 S %X="^UTILITY(U,$J,N,R,10,",%Y="^UTILITY(""ORVROM"",$J,N,X,R,10," D %XY^%RCR K ^UTILITY(U,$J,N,R,10)
 ;; I $D(^UTILITY(U,$J,N,R,"MEN")) S %X="^UTILITY(U,$J,N,R,""MEN"",",%Y="^UTILITY(""ORVROM"",$J,N,X,R,""MEN""," D %XY^%RCR K ^UTILITY(U,$J,N,R,"MEN")
 ;; S %X="^UTILITY(U,$J,N,R,",%Y=DIC_"+ORA,",DA=+ORA,DIK=DIC D %XY^%RCR
 ;; Q
 ;;A1 S ORA=DA N DA,DIC,ORI S Y="",ORI=0,DIC="^ORD(101,"_+ORA_",10,",DIC(0)="L",DA(1)=+ORA S:'$D(^ORD(101,DA(1),10,0)) ^(0)="^101.01PA^^"
 ;; F  S ORI=$O(^UTILITY("ORVROM",$J,N,NM,R,10,ORI)) Q:ORI<1  S X0=^(ORI,0),X=$S($D(^(U)):^(U),1:"") I $L(X) D A2
 ;; K DA,^UTILITY("ORVROM",$J,N,NM,R,10)
 ;; Q
 ;;A2 N X1 S DLAYGO=101 D ^DIC Q:'Y
 ;; I $P(Y,"^",3) W !?2,X_" added as item to "_$P(^ORD(101,DA(1),0),"^")_"."
 ;; S X0=^UTILITY("ORVROM",$J,N,NM,R,10,ORI,0)
 ;; S %=$P(X0,"^",4) I $L(%) S %=$O(^ORD(101,"B",%,0)) S:% $P(X0,"^",4)=%
 ;; S $P(^ORD(101,DA(1),10,+Y,0),"^",2,99)=$P(X0,"^",2,99)
 ;; S X1=0 F  S X1=$O(^UTILITY("ORVROM",$J,N,NM,R,10,ORI,X1)) Q:X1=""  I X1'["^" S X0=^UTILITY("ORVROM",$J,N,NM,R,10,ORI,X1),^ORD(101,DA(1),10,+Y,X1)=X0
 ;; Q
 ;;MEN S MEN=$S($D(^ORD(101,"B",MEN)):$O(^(MEN,0)),1:"") I 'MEN K ^UTILITY("ORVROM",$J,N,NM,R,"MEN") Q
 ;; S X=NM,X0=OMEN,DIC="^ORD(101,"_MEN_",10,",DIC(0)="L",DA(1)=MEN S:'$D(^ORD(101,DA(1),10,0)) ^(0)="^101.01PA^^"
 ;; S DIC("DR")="2///"_$P(X0,"^",2)_";3///"_$P(X0,"^",3)_";4///"_$P(X0,"^",4)_";5///"_$P(X0,"^",5)_";6///"_$P(X0,"^",6),DLAYGO=101 D ^DIC
 ;; I $P(Y,"^",3) W !?2,X_" added as item to "_$P(^ORD(101,DA(1),0),"^")_"."
 ;; Q
