DINIT42 ;SFISC/XAK-INITIALIZE VA FILEMAN ;10MAR2008
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**76,999,1022,1031**
 ;
 I $G(^DD("FUNC",89,0))="DUPLICATED" S DA=89,DIK="^DD(""FUNC""," D ^DIK
 S %=47
DD F I=1:5 S X=$E($T(DD+I),4,999),%=%+1 G FUNC:X?.P S ^DD("FUNC",%,0)=$P(X,";"),Y=I F DU=1,2,3,9 S Y=Y+1,X=$E($T(DD+Y),4,999) I X]"" S ^(DU)=X
 ;;PARAM
 ;;S X=$S(X=""!(X'?.ANP):"",$D(DIPA($E(X,1,30))):DIPA($E(X,1,30)),1:"")
 ;;
 ;;
 ;;RETURNS VALUE OF PARAMETER NAMED BY ARGUMENT
 ;;IOM
 ;;S X=$G(IOM,80)
 ;;
 ;;0
 ;;RETURNS THE NUMBER OF COLUMN POSITIONS ON THE PAGE OR SCREEN (E.G., 80)
 ;;DUP
 ;;S %=X,X="" S:X1]"" $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%)
 ;;
 ;;2
 ;;DUPLICATES THE 1ST ARGUMENT INTO AN 'N'-BYTE STRING, WHERE 'N' IS 2ND ARGUMENT
 ;;STRIPBLANKS
 ;;X:X[" " "F %=0:0 Q:$A(X)-32  S X=$E(X,2,999)","F %=0:0 S %=$L(X) Q:$A(X,%)-32  S X=$E(X,1,%-1)"
 ;;
 ;;
 ;;DELETES LEADING AND TRAILING SPACES FROM THE ARGUMENT STRING
 ;;TRANSLATE
 ;;S X=$TR(X2,X1,X)
 ;;
 ;;3
 ;;REPLACES, IN ARG1, EACH OCCURRENCE OF EACH CHAR IN ARG2 WITH THE CORRESPONDING CHAR IN ARG3
 ;;PADRIGHT
 ;;S:$L(X1)<X X1=X1_$J("",X-$L(X1)) S X=X1
 ;;
 ;;2
 ;;RETURNS 'ARG1', WITH SPACES ADDED TO GENERATE A STRING 'ARG2' BYTES LONG
 ;;FILE
 ;;S X=$S('X:X,X'["(":X,'$D(@(U_$E($P(X,+X,2,99),2,99)_"0)")):X,1:$P(^(0),U))
 ;;
 ;;1
 ;;Names file for variable pointer type fields.
 ;;USER
 ;;S %=$S($D(^VA(200,+DUZ,0)):^(0),1:""),X=$S('DUZ:"??",X="#":DUZ,X="N":$P(%,U,1),X="I":$P(%,U,2),X="T":$S($D(^DIC(3.1,+$P(%,U,9),0)):$P(^(0),U,1),1:""),X="NN":$S($D(^VA(200,+DUZ,.1)):$P(^(.1),U,4),1:""),1:"??") K %
 ;;
 ;;1
 ;;RETURNS USER ATTRIBUTES: #=NUMBER,N=NAME,I=INITIAL,T=TITLE,NN=NICKNAME
 ;;VAR
 ;;Q:X  Q:$NA(@X)[U  S X=$G(@X)
 ;;
 ;;1
 ;;RETURNS VALUE OF A LOCAL VARIABLE IF IT'S THERE
 ;;DUPLICATED
 ;;S X=X
 ;;
 ;;1
 ;;Takes as argument the name of a CROSS-REFERENCED field.  Returns BOOLEAN value, 1=field value is duplicated in another entry, ""=field value is unique
 ;;NOON
 ;;N %DT,Y S %DT="XR",X="T@NOON" D ^%DT S X=+Y
 ;;D
 ;;0
 ;;RETURNS THE CURRENT DATE AND THE TIME VALUE OF 12:OO.
 ;;MID
 ;;N %DT,Y S %DT="XR",X="T@MID" D ^%DT S X=+Y
 ;;D
 ;;0
 ;;RETURNS THE CURRENT DATE AND THE TIME VALUE OF 24:00.
 ;;NUMDATE4
 ;;S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3))
 ;;X
 ;;
 ;;DATE IN 'MM/DD/YYYY' FORMAT
 ;;NUMYEAR4
 ;;S:X X=1700+$E(X,1,3)
 ;;X
 ;;
 ;;YEAR NUMBER (YYYY) FOR A DATE
 ;
FUNC F I=3:1:12 S X=$T(FUNC+I),^DD("FUNC",I+87,0)=$P(X,";",3),^(9)=$P(X,";",4)
 F I=91,92 S ^DD("FUNC",I,3)="VARIABLE"
 G ^DINIT5
 ;;PRIORVALUE;Takes name of an Audited Field.  Returns as a multiple all prior values of the field, most recent first.
 ;;PRIORDATE;When it has an argument (Fieldname), returns as a multiple all prior Date/Times of auditing, most recent first.  Without an argument, it is most recent audited Date/Time for the Entry
 ;;PRIORUSER;When it has an argument (Fieldname), returns as a multiple all prior audited Users, most recent first.  Without an argument, it is most recent audited User for the Entry
 ;;MAXIMUM;Takes multiple-valued field or expression as argument.  Returns the maximum value of all the multiples.
 ;;MINIMUM;Takes multiple-valued field or expression as argument.  Returns the minimum value of all the multiples.
 ;;NEXT;Takes name of a Field. Returns the value that that field has in the next entry or sub-entry.
 ;;PREVIOUS;Takes name of a Field. Returns the value that that field has in the previous entry or sub-entry.
 ;;TOTAL;Takes multiple-valued field or expression as argument.  Returns the total of all the multiple values.
 ;;COUNT;Takes multiple-valued field or expression as argument.  Returns the number of multiples currently existing.
 ;;LAST;Takes multiple-valued field or expression as argument.  Returns the value of the last multiple.
