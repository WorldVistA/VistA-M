DINIT121 ;SFISC/MKO-SORT TEMPLATE FILE ;8AUG2014
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1008,1038,1050**
 ;
 ;.
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT122
Q Q
 ;;^DD(.401,1815,21,5,0)
 ;;=file to create the routine name.
 ;;^DD(.401,1815,21,6,0)
 ;;=  If this node is present, a new compiled sort routine will be created
 ;;^DD(.401,1815,21,7,0)
 ;;=during the FileMan sort/print.
 ;;^DD(.401,1815,23,0)
 ;;=^^3^3^2930331^^^
 ;;^DD(.401,1815,23,1,0)
 ;;=A routine beginning with these characters is created during the FileMan
 ;;^DD(.401,1815,23,2,0)
 ;;=sort/print.  The routine is then called from DIO2 to do the sort, rather
 ;;^DD(.401,1815,23,3,0)
 ;;=than executing code from the local DY, DZ and P arrays.
 ;;^DD(.401,1815,"DT")
 ;;=2930416
 ;;^DD(.401,1816,0)
 ;;=PREVIOUS ROUTINE INVOKED^F^^ROUOLD;E1,13^K:$L(X)>4!($L(X)<4)!'(X?1"DISZ") X
 ;;^DD(.401,1816,3)
 ;;=Entry must be 'DISZ'.
 ;;^DD(.401,1816,21,0)
 ;;=^^4^4^2930331^^
 ;;^DD(.401,1816,21,1,0)
 ;;=This node is present only to be consistant with other sort templates.
 ;;^DD(.401,1816,21,2,0)
 ;;=It's presence will indicate that at some time the SORT template was
 ;;^DD(.401,1816,21,3,0)
 ;;=compiled and will contain the beginning characters used to create the
 ;;^DD(.401,1816,21,4,0)
 ;;=name of the compiled routine.
 ;;^DD(.401,1816,"DT")
 ;;=2930416
 ;;^DD(.401,1819,0)
 ;;=COMPILED^CJ3^^ ; ^S X=$S($G(^DIBT(D0,"ROU"))]"":"YES",1:"NO")
 ;;^DD(.401,1819,9)
 ;;=^
 ;;^DD(.401,1819,9.01)
 ;;=
 ;;^DD(.401,1819,9.1)
 ;;=S X=$S($G(^DIBT(D0,"ROU"))]"":"YES",1:"NO")
 ;;^DD(.401,6666,0)
 ;;=ENTRIES^Cm^^ ; ^N FILE,DINAME,D S FILE=$P($G(^DIBT(D0,0)),U,4) I $D(^(1)) S DINAME=$G(^DIC(FILE,0,"GL"))_"D,0)" I DINAME[U F D=0:0 S D=$O(^DIBT(D0,1,D)) Q:'D  I $D(@DINAME) S X=$$GET1^DIQ(FILE,D,.01) X DICMX Q:'$D(D)
 ;;^DD(.401,21400,0)
 ;;=BUILD(S)^Cmp9.6^^ ; ^N DIBTNAME,D S DIBTNAME=$P($G(^DIBT(D0,0)),U)_"    FILE #"_$P($G(^(0)),U,4) F D=0:0 S D=$O(^XPD(9.6,D)) Q:'D  I $D(^(D,"KRN",.401,"NM","B",DIBTNAME)) N D0 S D0=D,X=$P(^XPD(9.6,D,0),U) X DICMX Q:'$D(D)
 ;;^DD(.401,21409,0)
 ;;=CANONIC FOR THIS FILE^S^1:YES^CANONIC;1
 ;;^DD(.401,21409,1,0)
 ;;=^.1^1^1
 ;;^DD(.401,21409,1,1,0)
 ;;=^^^MUMPS
 ;;^DD(.401,21409,1,1,1)
 ;;=N F S F=$P(^DIBT(DA,0),U,4) I F S ^DIBT("CANONIC",F,DA)=""
 ;;^DD(.401,21409,1,1,2)
 ;;=N F S F=$P(^DIBT(DA,0),U,4) I F K ^DIBT("CANONIC",F,DA)
 ;;^DD(.401,21409,4)
 ;;=D HELP^DIUCANON
 ;;^DD(.401,491620,0)
 ;;=PRINT TEMPLATE^F^^DIPT;1^K:'$D(^DIPT("B",X)) X
 ;;^DD(.401,491620,4)
 ;;=N D1 S D1(1)="If this Sort Template should always be used with a particular",D1(2)="Print Template, enter the name of that Print Template.",D1(3)="" D EN^DDIOL(.D1)
 ;;^DD(.4011,0)
 ;;=SEARCH SPECIFICATIONS SUB-FIELD^^.01^1
 ;;^DD(.4011,0,"NM","SEARCH SPECIFICATIONS SUB-FIELD")
 ;;=
 ;;^DD(.4011,0,"UP")
 ;;=.401
 ;;^DD(.4011,.01,0)
 ;;=SEARCH SPECIFICATIONS^WL^^0;1
 ;;^DD(.4011624,0)
 ;;=SORT RANGE DATA FOR BY(0) SUB-FIELD^^3.2^6
 ;;^DD(.4011624,0,"DT")
 ;;=2960910
 ;;^DD(.4011624,0,"IX","B",.4011624,.01)
 ;;=
 ;;^DD(.4011624,0,"NM","SORT RANGE DATA FOR BY(0)")
 ;;=
 ;;^DD(.4011624,0,"UP")
 ;;=.401
 ;;^DD(.4011624,.01,0)
 ;;=SUBSCRIPT LEVEL^MNJ1,0^^0;1^K:+X'=X!(X>7)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(.4011624,.01,1,0)
 ;;=^.1
 ;;^DD(.4011624,.01,1,1,0)
 ;;=.4011624^B
 ;;^DD(.4011624,.01,1,1,1)
 ;;=S ^DIBT(DA(1),"BY0D","B",$E(X,1,30),DA)=""
 ;;^DD(.4011624,.01,1,1,2)
 ;;=K ^DIBT(DA(1),"BY0D","B",$E(X,1,30),DA)
 ;;^DD(.4011624,.01,3)
 ;;=Enter a number, 1 or more.  L(0)-1 is the upper limit.
 ;;^DD(.4011624,.01,21,0)
 ;;=^^4^4^2960911^^^^
 ;;^DD(.4011624,.01,21,1,0)
 ;;=This field corresponds to a subscript in, and contains sort from/to ranges
 ;;^DD(.4011624,.01,21,2,0)
 ;;=and/or subheader information for, any of the variable subscripts in the
 ;;^DD(.4011624,.01,21,3,0)
 ;;=BY(0) global.  Any number here should never be greater than L(0)-1.  This
 ;;^DD(.4011624,.01,21,4,0)
 ;;=can represent a sparse array.
 ;;^DD(.4011624,.01,23,0)
 ;;=^^3^3^2960911^^^^
 ;;^DD(.4011624,.01,23,1,0)
 ;;=Corresponds to subscript levels in the BY(0) global, and will be used to
 ;;^DD(.4011624,.01,23,2,0)
 ;;=put sort from/to and subheader information into the DPP array when the
 ;;^DD(.4011624,.01,23,3,0)
 ;;=sort data is being built.
 ;;^DD(.4011624,.01,"DT")
 ;;=2960828
 ;;^DD(.4011624,1,0)
 ;;=FR(0,n)^F^^0;2^K:$L(X)>62!($L(X)<1) X
 ;;^DD(.4011624,1,3)
 ;;=Starting value for the sort on this subscript.  Answer must be 1-62 characters in length.
 ;;^DD(.4011624,1,21,0)
 ;;=^^16^16^2960911^^^^
 ;;^DD(.4011624,1,21,1,0)
 ;;=Use this field to define the FR(0,n) variable as you would in a
 ;;^DD(.4011624,1,21,2,0)
 ;;=call to EN1^DIP that included BY(0).  If defined, the value will be
 ;;^DD(.4011624,1,21,3,0)
 ;;=used as the starting point as FileMan sequences through the global
 ;;^DD(.4011624,1,21,4,0)
 ;;=array referenced by BY(0) at this subscript level (n).
 ;;^DD(.4011624,1,21,5,0)
 ;;= 
 ;;^DD(.4011624,1,21,6,0)
 ;;=Values are not transformed, so enter the internal form just as it
 ;;^DD(.4011624,1,21,7,0)
 ;;=is stored in the global array.  A date, for example, would be 2960829,
 ;;^DD(.4011624,1,21,8,0)
 ;;=not Aug 29, 1996.
 ;;^DD(.4011624,1,21,9,0)
 ;;= 
 ;;^DD(.4011624,1,21,10,0)
 ;;=Don't attempt to use the at-sign (@) to include records with null
 ;;^DD(.4011624,1,21,11,0)
 ;;=values (as can be done in ordinary sorts).  Only use values that can
 ;;^DD(.4011624,1,21,12,0)
 ;;=be compared with actual data in this subscript of the global array
 ;;^DD(.4011624,1,21,13,0)
 ;;=referenced by BY(0).  (The only records that can be selected are ones
 ;;^DD(.4011624,1,21,14,0)
 ;;=that exist in this global array.  A record with a null value for this
 ;;^DD(.4011624,1,21,15,0)
 ;;=subscript would exist in the data file but not in this array and thus
 ;;^DD(.4011624,1,21,16,0)
 ;;=can't be selected.)
 ;;^DD(.4011624,1,23,0)
 ;;=^^1^1^2960911^^^^
 ;;^DD(.4011624,1,23,1,0)
 ;;=Equivalent to the FR(0,n) input variable to the programmer call EN1^DIP.
 ;;^DD(.4011624,1,"DT")
 ;;=2960828
 ;;^DD(.4011624,2,0)
 ;;=TO(0,n)^F^^0;3^K:$L(X)>62!($L(X)<1) X
 ;;^DD(.4011624,2,3)
 ;;=Ending value for sort on this subscript.  Answer must be 1-62 characters in length.
 ;;^DD(.4011624,2,21,0)
 ;;=^^9^9^2960911^^^^
 ;;^DD(.4011624,2,21,1,0)
 ;;=Use this field to define the TO(0,n) variable as you would in a
 ;;^DD(.4011624,2,21,2,0)
 ;;=call to EN1^DIP that included BY(0).  If defined, the value will be
 ;;^DD(.4011624,2,21,3,0)
 ;;=used as the ending point as FileMan sequences through the global
 ;;^DD(.4011624,2,21,4,0)
 ;;=array referenced by BY(0) at this subscript level (n).
 ;;^DD(.4011624,2,21,5,0)
 ;;= 
 ;;^DD(.4011624,2,21,6,0)
 ;;=Values are not transformed, so enter the internal form just as it
 ;;^DD(.4011624,2,21,7,0)
 ;;=is stored in the global array.  An inverse date, for example,
 ;;^DD(.4011624,2,21,8,0)
 ;;=would be 7039268, not 7/31/96.  Do not attempt to use @ to select
 ;;^DD(.4011624,2,21,9,0)
 ;;=records with null values for this subscript.
 ;;^DD(.4011624,2,23,0)
 ;;=^^1^1^2960911^^^^
 ;;^DD(.4011624,2,23,1,0)
 ;;=Equivalent to the TO(0,n) input variable to the programmer call EN1^DIP.
 ;;^DD(.4011624,2,"DT")
 ;;=2960828
 ;;^DD(.4011624,3.1,0)
 ;;=DISPAR(0,n) PIECE ONE^FX^^1;1^K:$L(X)>10!($L(X)<1)!("#!#"'[X) X
 ;;^DD(.4011624,3.1,3)
 ;;=Answer with #, !, #!, or null.
 ;;^DD(.4011624,3.1,21,0)
 ;;=^^6^6^2960910^^
 ;;^DD(.4011624,3.1,21,1,0)
 ;;=Just as when setting the first piece of DISPAR(0,n) in a programmer
 ;;^DD(.4011624,3.1,21,2,0)
 ;;=call that includes BY(0) when calling EN1^DIP, this field can hold
