XPDIN006 ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 Q:'DIFQ(9.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.64,222.8,3)
 ;;=
 ;;^DD(9.64,222.8,21,0)
 ;;=7^^9^9^2941108^^^^
 ;;^DD(9.64,222.8,21,1,0)
 ;;=ADD ONLY IF NEW will install data at the installing site only if this
 ;;^DD(9.64,222.8,21,2,0)
 ;;=file is new to the site or there is no data in this file at the site.
 ;;^DD(9.64,222.8,21,3,0)
 ;;=MERGE data will only bring in data which is not already on file at
 ;;^DD(9.64,222.8,21,4,0)
 ;;=the installing site.
 ;;^DD(9.64,222.8,21,5,0)
 ;;=OVERWRITE data will be put in place regardless of what is on file
 ;;^DD(9.64,222.8,21,6,0)
 ;;=at the installing site.
 ;;^DD(9.64,222.8,21,7,0)
 ;;=REPLACE will delete the installing site's data before installing data for
 ;;^DD(9.64,222.8,21,8,0)
 ;;=this file. It will preserve locally developed fields, if they were created
 ;;^DD(9.64,222.8,21,9,0)
 ;;=within the VA Programming Standards and Conventions.
 ;;^DD(9.64,222.8,"DT")
 ;;=2940831
 ;;^DD(9.64,222.9,0)
 ;;=MAY USER OVERRIDE DATA UPDATE^S^y:YES;n:NO;^222;9^Q
 ;;^DD(9.64,222.9,3)
 ;;=
 ;;^DD(9.64,222.9,21,0)
 ;;=7^^7^7^2940414^^^
 ;;^DD(9.64,222.9,21,1,0)
 ;;=YES means that the user has the option to determine whether or not
 ;;^DD(9.64,222.9,21,2,0)
 ;;=to bring in the data that has been sent with this package.  However,
 ;;^DD(9.64,222.9,21,3,0)
 ;;=the user does not get the ability to change how to install the SITE'S DATA,
 ;;^DD(9.64,222.9,21,4,0)
 ;;=i.e. MERGE to REPLACE.
 ;;^DD(9.64,222.9,21,5,0)
 ;;= 
 ;;^DD(9.64,222.9,21,6,0)
 ;;=NO means that the developer of this package will control whether the data
 ;;^DD(9.64,222.9,21,7,0)
 ;;=will be installed at the target site.
 ;;^DD(9.64,222.9,"DT")
 ;;=2940502
 ;;^DD(9.64,223,0)
 ;;=SCREEN TO DETERMINE DD UPDATE^KX^^223;E1,245^K:$L(X)>240 X I $D(X) D ^DIM
 ;;^DD(9.64,223,3)
 ;;=This is Standard MUMPS code from 1 to 240 characters in length.
 ;;^DD(9.64,223,9)
 ;;=@
 ;;^DD(9.64,223,21,0)
 ;;=^^5^5^2940915^^^^
 ;;^DD(9.64,223,21,1,0)
 ;;=This field contains standard MUMPS code which is used to determine
 ;;^DD(9.64,223,21,2,0)
 ;;=whether or not a data dictionary should be updated.  This code must
 ;;^DD(9.64,223,21,3,0)
 ;;=set $T.  If $T=1, the DD will be updated.  If $T=0, it will not.
 ;;^DD(9.64,223,21,4,0)
 ;;= 
 ;;^DD(9.64,223,21,5,0)
 ;;=Namespace your variables.
 ;;^DD(9.64,223,"DT")
 ;;=2890927
 ;;^DD(9.64,224,0)
 ;;=SCREEN TO SELECT DATA^K^^224;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(9.64,224,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(9.64,224,9)
 ;;=@
 ;;^DD(9.64,224,21,0)
 ;;=^^5^5^2950512^^^^
 ;;^DD(9.64,224,21,1,0)
 ;;=This field contains standard M code which is used to determine
 ;;^DD(9.64,224,21,2,0)
 ;;=whether a record in a file should be exported in this package.
 ;;^DD(9.64,224,21,3,0)
 ;;=The variable Y will be equal to the internal entry number of the
 ;;^DD(9.64,224,21,4,0)
 ;;=current record.  This code must set $T, if $T=1 then the record will
 ;;^DD(9.64,224,21,5,0)
 ;;=be sent. If $T=0 it will not.
 ;;^DD(9.64,224,"DT")
 ;;=2940119
 ;;^DD(9.641,0)
 ;;=DD NUMBER SUB-FIELD^^1^3
 ;;^DD(9.641,0,"DT")
 ;;=2950330
 ;;^DD(9.641,0,"IX","APDD",9.641,.01)
 ;;=
 ;;^DD(9.641,0,"NM","DD NUMBER")
 ;;=
 ;;^DD(9.641,0,"UP")
 ;;=9.64
 ;;^DD(9.641,.01,0)
 ;;=DD NUMBER^MFX^^0;1^K:X[""""!($A(X)=45) X I $D(X) S X=$$CHKDD^DIFROMSD(D1,+$G(X),"N") K:X'>0 X S:$D(X) DINUM=+X,X=$P(X,"^",2)
 ;;^DD(9.641,.01,1,0)
 ;;=^.1
 ;;^DD(9.641,.01,1,1,0)
 ;;=9.641^APDD^MUMPS
 ;;^DD(9.641,.01,1,1,1)
 ;;=S ^XPD(9.6,DA(2),4,"APDD",DA(1),DA)=""
 ;;^DD(9.641,.01,1,1,2)
 ;;=K ^XPD(9.6,DA(2),4,"APDD",DA(1),DA)
 ;;^DD(9.641,.01,1,1,"%D",0)
 ;;=^^2^2^2950117^
 ;;^DD(9.641,.01,1,1,"%D",1,0)
 ;;=Used to create an array structure containing Partial DDs.  This array
 ;;^DD(9.641,.01,1,1,"%D",2,0)
 ;;=is passed to FIA^DIFROMSU as a list of DD numbers and fields to transport.
 ;;^DD(9.641,.01,1,1,"DT")
 ;;=2940829
 ;;^DD(9.641,.01,3)
 ;;=Enter a valid DD number for this file.
 ;;^DD(9.641,.01,4)
 ;;=D DDIOLDD^DIFROMSD(D1)
 ;;^DD(9.641,.01,21,0)
 ;;=^^17^17^2940903^
 ;;^DD(9.641,.01,21,1,0)
 ;;= 
 ;;^DD(9.641,.01,21,2,0)
 ;;=DD NUMBER pertains to the file's number or any multiple field contained
 ;;^DD(9.641,.01,21,3,0)
 ;;=within the file.
 ;;^DD(9.641,.01,21,4,0)
 ;;= 
 ;;^DD(9.641,.01,21,5,0)
 ;;=This list starts with the file's top level number followed by a list of
 ;;^DD(9.641,.01,21,6,0)
 ;;=multiple fields contained within the file, if any.  These DO NOT represent
 ;;^DD(9.641,.01,21,7,0)
 ;;=Field Number(s).
 ;;^DD(9.641,.01,21,8,0)
 ;;= 
 ;;^DD(9.641,.01,21,9,0)
 ;;=The nesting levels are not represented.  All the DD NUMBERs, file number
 ;;^DD(9.641,.01,21,10,0)
 ;;=and multiple fields, have been flatten to a single list.
