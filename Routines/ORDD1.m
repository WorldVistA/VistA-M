ORDD1 ; slc/dcm - Calls from OE/RR DD ;8/20/92  12:13 ;
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
K11 ;;Set logic from field 1 file 101
 S I=0,ORKX=X D UP F J=0:0 S I=$O(^ORD(101,DA,3,I)) Q:I<1  S ORKEY=$S($D(^DIC(19.1,+^(I,0),0)):$P(^(0),"^"),1:"") I $L(ORKEY),ORKEY="ORWARD" S ^ORD(101,"K."_ORKEY,X,DA)=""
 S X=ORKX K ORKEY,ORKX
 Q
K12 ;;Kill logic from field 1 file 101
 S I=0,ORKX=X D UP F J=0:0 S I=$O(^ORD(101,DA,3,I)) Q:I<1  S ORKEY=$S($D(^DIC(19.1,+^(I,0),0)):$P(^(0),"^"),1:"") I $L(ORKEY),ORKEY="ORWARD" K ^ORD(101,"K."_ORKEY,X,DA)
 S X=ORKX K ORKEY,ORKX
 Q
K21 ;;Set logic from field 2 file 101
 S I=0,ORKX=X D UP F J=0:0 S I=$O(^ORD(101,DA(1),3,I)) Q:I<1  S ORKEY=$S($D(^DIC(19.1,+^(I,0),0)):$P(^(0),"^"),1:"") I $L(ORKEY),ORKEY="ORWARD" S ^ORD(101,"K."_ORKEY,X,DA(1))=""
 S X=ORKX K ORKEY,ORITN
 Q
K22 ;;Kill logic from field 2 file 101
 S I=0,ORKX=X D UP F J=0:0 S I=$O(^ORD(101,DA(1),3,I)) Q:I<1  S ORKEY=$S($D(^DIC(19.1,+^(I,0),0)):$P(^(0),"^"),1:"") I $L(ORKEY),ORKEY="ORWARD" K ^ORD(101,"K."_ORKEY,X,DA(1))
 S X=ORKX K ORKEY,ORKX
 Q
K31 ;;Set logic from field 3 file 101
 S ORKEY=$S($D(^DIC(19.1,X,0)):^(0),1:"") I ORKEY="" K ORKEY Q
 I ORKEY'="ORWARD" K ORKEY Q
 S ORKX=X,X=$P(^ORD(101,DA(1),0),"^",2) I $L(X) D UP S ^ORD(101,"K."_ORKEY,X,DA(1))=""
 S I=0 F J=0:0 S I=$O(^ORD(101,DA(1),2,I)) Q:I<1  S X=$P(^(I,0),"^") I $L(X) D UP S ^ORD(101,"K."_ORKEY,X,DA(1))=""
 S X=ORKX K ORKEY,ORKX
 Q
K32 ;;Kill logic from field 3 file 101
 S ORKEY=$S($D(^DIC(19.1,X,0)):^(0),1:"") I ORKEY="" K ORKEY Q
 I ORKEY'="ORWARD" K ORKEY Q
 S ORKX=X,X=$P(^ORD(101,DA(1),0),"^",2) I $L(X) D UP K ^ORD(101,"K."_ORKEY,X,DA(1))
 S I=0 F J=0:0 S I=$O(^ORD(101,DA(1),2,I)) Q:I<1  S X=$P(^(I,0),"^") I $L(X) D UP K ^ORD(101,"K."_ORKEY,X,DA(1))
 S X=ORKX K ORKEY,ORKX
 Q
UP S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q
F1 ;Set logic (NOT CURRENTLY IN USE)
 I $D(@("^"_$P(X,";",2)_"0)")) S ORF="F."_+$P(^(0),"^",2),T=$P(^ORD(101,DA,0),"^",2) I $L(T) S ^ORD(101,ORF,T,DA)=""
 K T Q
F2 ;Kill logic
 I $D(@("^"_$P(X,";",2)_"0)")) S ORF="F."_+$P(^(0),"^",2),T=$P(^ORD(101,DA,0),"^",2) I $L(T) K ^ORD(101,ORF,T,DA)
 K T Q
