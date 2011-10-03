XPDIN005 ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 Q:'DIFQ(9.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.64,222.2,21,3,0)
 ;;=only be installed if the file is new at the installing site.
 ;;^DD(9.64,222.2,21,4,0)
 ;;= 
 ;;^DD(9.64,222.2,21,5,0)
 ;;=NO means you do not want to include security codes.
 ;;^DD(9.64,222.2,"DT")
 ;;=2940211
 ;;^DD(9.64,222.3,0)
 ;;=SEND FULL OR PARTIAL DD^S^f:FULL;p:PARTIAL;^222;3^Q
 ;;^DD(9.64,222.3,1,0)
 ;;=^.1
 ;;^DD(9.64,222.3,1,1,0)
 ;;=^^TRIGGER^9.64^222.7
 ;;^DD(9.64,222.3,1,1,1)
 ;;=X ^DD(9.64,222.3,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^XPD(9.6,D0,4,D1,222)):^(222),1:"") S X=$P(Y(1),U,7),X=X S DIU=X K Y S X=DIV S X="n" X ^DD(9.64,222.3,1,1,1.4)
 ;;^DD(9.64,222.3,1,1,1.3)
 ;;=K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(0)=X S Y(1)=$C(59)_$S($D(^DD(9.64,222.3,0)):$P(^(0),U,3),1:"") S X=$P($P(Y(1),$C(59)_Y(0)_":",2),$C(59),1)="PARTIAL"
 ;;^DD(9.64,222.3,1,1,1.4)
 ;;=S DIH=$S($D(^XPD(9.6,DIV(0),4,DIV(1),222)):^(222),1:""),DIV=X S $P(^(222),U,7)=DIV,DIH=9.64,DIG=222.7 D ^DICR:$O(^DD(DIH,DIG,1,0))>0
 ;;^DD(9.64,222.3,1,1,2)
 ;;=Q
 ;;^DD(9.64,222.3,1,1,"%D",0)
 ;;=^^2^2^2941220^
 ;;^DD(9.64,222.3,1,1,"%D",1,0)
 ;;=This cross-reference sets the DATA COMES WITH FILE field to 'NO' if the
 ;;^DD(9.64,222.3,1,1,"%D",2,0)
 ;;=Data Dictionary is a PARTIAL.
 ;;^DD(9.64,222.3,1,1,"CREATE CONDITION")
 ;;=SEND FULL OR PARTIAL DD="PARTIAL"
 ;;^DD(9.64,222.3,1,1,"CREATE VALUE")
 ;;="n"
 ;;^DD(9.64,222.3,1,1,"DELETE VALUE")
 ;;=NO EFFECT
 ;;^DD(9.64,222.3,1,1,"DT")
 ;;=2941220
 ;;^DD(9.64,222.3,1,1,"FIELD")
 ;;=#222.7
 ;;^DD(9.64,222.3,1,2,0)
 ;;=9.64^AC^MUMPS
 ;;^DD(9.64,222.3,1,2,1)
 ;;=K:X="f" ^XPD(9.6,DA(1),4,DA,2),^XPD(9.6,DA(1),4,"APDD",DA)
 ;;^DD(9.64,222.3,1,2,2)
 ;;=Q
 ;;^DD(9.64,222.3,1,2,"%D",0)
 ;;=^^2^2^2941220^
 ;;^DD(9.64,222.3,1,2,"%D",1,0)
 ;;=This cross-reference is to clean up the partial DD information when
 ;;^DD(9.64,222.3,1,2,"%D",2,0)
 ;;=you send a Full DD.
 ;;^DD(9.64,222.3,1,2,"DT")
 ;;=2941220
 ;;^DD(9.64,222.3,5,1,0)
 ;;=9.64^222.7^1
 ;;^DD(9.64,222.3,"DT")
 ;;=2941220
 ;;^DD(9.64,222.5,0)
 ;;=RESOLVE POINTERS^S^y:YES;n:NO;^222;5^Q
 ;;^DD(9.64,222.5,21,0)
 ;;=^^4^4^2941108^
 ;;^DD(9.64,222.5,21,1,0)
 ;;=YES means you want to have all pointer type fields values resolved at the
 ;;^DD(9.64,222.5,21,2,0)
 ;;=installing site.
 ;;^DD(9.64,222.5,21,3,0)
 ;;= 
 ;;^DD(9.64,222.5,21,4,0)
 ;;=NO means you want any pointer type field values resolved.
 ;;^DD(9.64,222.5,"DT")
 ;;=2940601
 ;;^DD(9.64,222.6,0)
 ;;=DATA LIST^FX^^222;6^S X=$$SEL^DIFROMSS(D1,X) K:X="" X
 ;;^DD(9.64,222.6,3)
 ;;=Select Sort Template containing the list of records to transport, for this file.
 ;;^DD(9.64,222.6,4)
 ;;=D HELP^DIFROMSS(D1)
 ;;^DD(9.64,222.6,12)
 ;;=Must be a sort list
 ;;^DD(9.64,222.6,12.1)
 ;;=S DIC("S")="I $P(^(0),U,4)=D1,$D(^(1))>9"
 ;;^DD(9.64,222.6,21,0)
 ;;=^^2^2^2940720^^^^
 ;;^DD(9.64,222.6,21,1,0)
 ;;=This is the results of a search, which is stored in a Sort template.  This
 ;;^DD(9.64,222.6,21,2,0)
 ;;=Sort list will contain the records to be transported.
 ;;^DD(9.64,222.6,"DT")
 ;;=2940720
 ;;^DD(9.64,222.7,0)
 ;;=DATA COMES WITH FILE^S^y:YES;n:NO;^222;7^Q
 ;;^DD(9.64,222.7,1,0)
 ;;=^.1
 ;;^DD(9.64,222.7,1,1,0)
 ;;=^^TRIGGER^9.64^222.3
 ;;^DD(9.64,222.7,1,1,1)
 ;;=X ^DD(9.64,222.7,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^XPD(9.6,D0,4,D1,222)):^(222),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV S X="f" X ^DD(9.64,222.7,1,1,1.4)
 ;;^DD(9.64,222.7,1,1,1.3)
 ;;=K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(0)=X S Y(1)=$C(59)_$S($D(^DD(9.64,222.7,0)):$P(^(0),U,3),1:"") S X=$P($P(Y(1),$C(59)_Y(0)_":",2),$C(59),1)="YES"
 ;;^DD(9.64,222.7,1,1,1.4)
 ;;=S DIH=$S($D(^XPD(9.6,DIV(0),4,DIV(1),222)):^(222),1:""),DIV=X S $P(^(222),U,3)=DIV,DIH=9.64,DIG=222.3 D ^DICR:$O(^DD(DIH,DIG,1,0))>0
 ;;^DD(9.64,222.7,1,1,2)
 ;;=Q
 ;;^DD(9.64,222.7,1,1,"%D",0)
 ;;=^^2^2^2941220^
 ;;^DD(9.64,222.7,1,1,"%D",1,0)
 ;;=This cross-reference sets the SEND FULL OR PATIAL DD field to FULL
 ;;^DD(9.64,222.7,1,1,"%D",2,0)
 ;;=when sending data with a file.
 ;;^DD(9.64,222.7,1,1,"CREATE CONDITION")
 ;;=DATA COMES WITH FILE="YES"
 ;;^DD(9.64,222.7,1,1,"CREATE VALUE")
 ;;="f"
 ;;^DD(9.64,222.7,1,1,"DELETE VALUE")
 ;;=NO EFFECT
 ;;^DD(9.64,222.7,1,1,"DT")
 ;;=2941220
 ;;^DD(9.64,222.7,1,1,"FIELD")
 ;;=#222.3
 ;;^DD(9.64,222.7,5,1,0)
 ;;=9.64^222.3^1
 ;;^DD(9.64,222.7,21,0)
 ;;=^^4^4^2920513^^^^
 ;;^DD(9.64,222.7,21,1,0)
 ;;=YES means that the data should be included in the initialization
 ;;^DD(9.64,222.7,21,2,0)
 ;;=routines.
 ;;^DD(9.64,222.7,21,3,0)
 ;;= 
 ;;^DD(9.64,222.7,21,4,0)
 ;;=NO means that the data should be left out.
 ;;^DD(9.64,222.7,"DT")
 ;;=2941220
 ;;^DD(9.64,222.8,0)
 ;;=SITE'S DATA^S^a:ADD ONLY IF NEW FILE;m:MERGE;o:OVERWRITE;r:REPLACE;^222;8^Q
