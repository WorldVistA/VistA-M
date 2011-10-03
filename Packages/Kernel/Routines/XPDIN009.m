XPDIN009 ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 Q:'DIFQ(9.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.68,.01,1,2,"CREATE VALUE")
 ;;=$P(ENTRIES,"    FILE #",2)
 ;;^DD(9.68,.01,1,2,"DELETE VALUE")
 ;;=NO EFFECT
 ;;^DD(9.68,.01,1,2,"DT")
 ;;=2931020
 ;;^DD(9.68,.01,1,2,"FIELD")
 ;;=FILE
 ;;^DD(9.68,.01,3)
 ;;=Answer must be 3-45 characters in length.
 ;;^DD(9.68,.01,4)
 ;;=D HELP^XPDET
 ;;^DD(9.68,.01,7.5)
 ;;=D LOOKE^XPDET(.X)
 ;;^DD(9.68,.01,21,0)
 ;;=^^4^4^2950214^^^^
 ;;^DD(9.68,.01,21,1,0)
 ;;=The name of the component being sent.  The component must exist in
 ;;^DD(9.68,.01,21,2,0)
 ;;=the pointed-to file.  You can use '*' as a wild card character, 
 ;;^DD(9.68,.01,21,3,0)
 ;;=i.e.  XUS* means all components begining with XUS.
 ;;^DD(9.68,.01,21,4,0)
 ;;=You can also preceed the component with '-' to delete it from the list.
 ;;^DD(9.68,.01,"DT")
 ;;=2940517
 ;;^DD(9.68,.02,0)
 ;;=FILE^RP1'^DIC(^0;2^Q
 ;;^DD(9.68,.02,5,1,0)
 ;;=9.68^.01^2
 ;;^DD(9.68,.02,9)
 ;;=^
 ;;^DD(9.68,.02,21,0)
 ;;=^^1^1^2931020^
 ;;^DD(9.68,.02,21,1,0)
 ;;=The Fileman file for this Entry.
 ;;^DD(9.68,.02,"DT")
 ;;=2931020
 ;;^DD(9.68,.03,0)
 ;;=ACTION^R*S^0:SEND TO SITE;1:DELETE AT SITE;2:USE AS LINK FOR MENU ITEMS;3:MERGE MENU ITEMS;^0;3^Q
 ;;^DD(9.68,.03,12)
 ;;=Enter a number
 ;;^DD(9.68,.03,12.1)
 ;;=S DIC("S")="I $$SCRA^XPDET(Y)"
 ;;^DD(9.68,.03,21,0)
 ;;=^^2^2^2940503^^
 ;;^DD(9.68,.03,21,1,0)
 ;;=This is the action you want performed at the installing site on
 ;;^DD(9.68,.03,21,2,0)
 ;;=the entry of the component you are sending for this package.
 ;;^DD(9.68,.03,"DT")
 ;;=2940708
 ;;^DD(9.68,.04,0)
 ;;=CHECKSUM^F^^0;4^K:$L(X)>30!($L(X)<3) X
 ;;^DD(9.68,.04,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(9.68,.04,21,0)
 ;;=^^1^1^2950330^
 ;;^DD(9.68,.04,21,1,0)
 ;;=This field contains the checksum for this component.
 ;;^DD(9.68,.04,"DT")
 ;;=2950330
