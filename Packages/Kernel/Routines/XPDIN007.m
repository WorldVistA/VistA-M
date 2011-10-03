XPDIN007 ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 Q:'DIFQ(9.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.641,.01,21,11,0)
 ;;= 
 ;;^DD(9.641,.01,21,12,0)
 ;;=After selecting a valid DD NUMBER you will then be prompted to select
 ;;^DD(9.641,.01,21,13,0)
 ;;=field number(s).
 ;;^DD(9.641,.01,21,14,0)
 ;;= 
 ;;^DD(9.641,.01,21,15,0)
 ;;=If a DD NUMBER is selected and no fields are selected, KIDS will send all
 ;;^DD(9.641,.01,21,16,0)
 ;;=the fields contained within, including multiple fields below the selected
 ;;^DD(9.641,.01,21,17,0)
 ;;=level.
 ;;^DD(9.641,.01,"DT")
 ;;=2940829
 ;;^DD(9.641,.02,0)
 ;;=CHECKSUM^F^^0;2^K:$L(X)>30!($L(X)<3) X
 ;;^DD(9.641,.02,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(9.641,.02,21,0)
 ;;=^^1^1^2950330^
 ;;^DD(9.641,.02,21,1,0)
 ;;=This field contains the checksum for this subDD
 ;;^DD(9.641,.02,"DT")
 ;;=2950330
 ;;^DD(9.641,1,0)
 ;;=FIELD NUMBER^9.6411^^1;0
 ;;^DD(9.641,1,"DT")
 ;;=2940525
 ;;^DD(9.6411,0)
 ;;=FIELD NUMBER SUB-FIELD^^.02^2
 ;;^DD(9.6411,0,"DT")
 ;;=2950330
 ;;^DD(9.6411,0,"NM","FIELD NUMBER")
 ;;=
 ;;^DD(9.6411,0,"UP")
 ;;=9.641
 ;;^DD(9.6411,.01,0)
 ;;=FIELD NUMBER^MFX^^0;1^K:X[""""!($A(X)=45) X I $D(X) S X=$$FLDCHK^DIFROMSD(D2,+$G(X),"MN") K:X'>0 X S:$D(X) DINUM=+X,X=$P(X,"^",2)
 ;;^DD(9.6411,.01,1,0)
 ;;=^.1
 ;;^DD(9.6411,.01,1,1,0)
 ;;=9.64^APDD^MUMPS
 ;;^DD(9.6411,.01,1,1,1)
 ;;=S ^XPD(9.6,DA(3),4,"APDD",DA(2),DA(1),DA)=""
 ;;^DD(9.6411,.01,1,1,2)
 ;;=K ^XPD(9.6,DA(3),4,"APDD",DA(2),DA(1),DA)
 ;;^DD(9.6411,.01,1,1,"%D",0)
 ;;=^^2^2^2950117^
 ;;^DD(9.6411,.01,1,1,"%D",1,0)
 ;;=Used to create an array structure containing Partial DDs.  This array
 ;;^DD(9.6411,.01,1,1,"%D",2,0)
 ;;=is passed to FIA^DIFROMSU as a list of DD numbers and fields to transport.
 ;;^DD(9.6411,.01,1,1,"DT")
 ;;=2940525
 ;;^DD(9.6411,.01,3)
 ;;=Enter a valid field NUMBER.
 ;;^DD(9.6411,.01,4)
 ;;=D DDIOLFLD^DIFROMSD(D2,"M")
 ;;^DD(9.6411,.01,21,0)
 ;;=^^13^13^2940903^
 ;;^DD(9.6411,.01,21,1,0)
 ;;= 
 ;;^DD(9.6411,.01,21,2,0)
 ;;=Select field(s) to be sent for this Partial Data Dictionary.
 ;;^DD(9.6411,.01,21,3,0)
 ;;= 
 ;;^DD(9.6411,.01,21,4,0)
 ;;=Only the attributes for the field(s) selected are sent.  Attributes such
 ;;^DD(9.6411,.01,21,5,0)
 ;;=as identifers, "ID" nodes for a field, are not sent when sending a
 ;;^DD(9.6411,.01,21,6,0)
 ;;=partial. Some attributes are considered file attributes, such as
 ;;^DD(9.6411,.01,21,7,0)
 ;;=identifiers, and are only sent with a Full Data Dictionary.
 ;;^DD(9.6411,.01,21,8,0)
 ;;= 
 ;;^DD(9.6411,.01,21,9,0)
 ;;=If the .01 field for a sub-file, multiple, is selected, the field at the
 ;;^DD(9.6411,.01,21,10,0)
 ;;=level above, which points to the multiple, is automatically sent.
 ;;^DD(9.6411,.01,21,11,0)
 ;;= 
 ;;^DD(9.6411,.01,21,12,0)
 ;;=If no field is selected, all fields will be sent, as well as the multiple
 ;;^DD(9.6411,.01,21,13,0)
 ;;=fields below this level.
 ;;^DD(9.6411,.01,"DT")
 ;;=2940906
 ;;^DD(9.6411,.02,0)
 ;;=CHECKSUM^F^^0;2^K:$L(X)>30!($L(X)<3) X
 ;;^DD(9.6411,.02,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(9.6411,.02,21,0)
 ;;=^^1^1^2950330^
 ;;^DD(9.6411,.02,21,1,0)
 ;;=This field contains the checksum for this field.
 ;;^DD(9.6411,.02,"DT")
 ;;=2950330
 ;;^DD(9.65,0)
 ;;=GLOBAL SUB-FIELD^^1^2
 ;;^DD(9.65,0,"DT")
 ;;=2950105
 ;;^DD(9.65,0,"IX","B",9.65,.01)
 ;;=
 ;;^DD(9.65,0,"NM","GLOBAL")
 ;;=
 ;;^DD(9.65,0,"UP")
 ;;=9.6
 ;;^DD(9.65,.01,0)
 ;;=GLOBAL^MFXO^^0;1^D GLOBALE^XPDET(.X)
 ;;^DD(9.65,.01,1,0)
 ;;=^.1
 ;;^DD(9.65,.01,1,1,0)
 ;;=9.65^B
 ;;^DD(9.65,.01,1,1,1)
 ;;=S ^XPD(9.6,DA(1),"GLO","B",$E(X,1,30),DA)=""
 ;;^DD(9.65,.01,1,1,2)
 ;;=K ^XPD(9.6,DA(1),"GLO","B",$E(X,1,30),DA)
 ;;^DD(9.65,.01,2)
 ;;=S Y(0)=Y S Y=$TR(Y,"'","""")
 ;;^DD(9.65,.01,2.1)
 ;;=S Y=$TR(Y,"'","""")
 ;;^DD(9.65,.01,3)
 ;;=Answer must be 2-30 characters in length and not begining with "^".
 ;;^DD(9.65,.01,7.5)
 ;;=S X=$TR(X,"""","'")
 ;;^DD(9.65,.01,21,0)
 ;;=^^2^2^2950105^^^
 ;;^DD(9.65,.01,21,1,0)
 ;;=Enter a global name or a closed global root you want to transport.
 ;;^DD(9.65,.01,21,2,0)
 ;;=The global should not begin with a "^". i.e.  %ZIS(2).
 ;;^DD(9.65,.01,"DT")
 ;;=2950106
 ;;^DD(9.65,1,0)
 ;;=KILL GLOBAL BEFORE INSTALL^S^y:YES;n:NO;^0;2^Q
 ;;^DD(9.65,1,21,0)
 ;;=^^5^5^2950105^
 ;;^DD(9.65,1,21,1,0)
 ;;=YES means that you want this global killed before it is installed
 ;;^DD(9.65,1,21,2,0)
 ;;=at the installing site.
 ;;^DD(9.65,1,21,3,0)
 ;;= 
 ;;^DD(9.65,1,21,4,0)
 ;;=NO means you want this global install on top of the existing global
 ;;^DD(9.65,1,21,5,0)
 ;;=at the installing site.
 ;;^DD(9.65,1,"DT")
 ;;=2950105
 ;;^DD(9.66,0)
 ;;=PACKAGE NAMESPACE OR PREFIX SUB-FIELD^^1^2
 ;;^DD(9.66,0,"DT")
 ;;=2940307
