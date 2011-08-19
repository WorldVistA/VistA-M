XPDIN001 ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 Q:'DIFQ(9.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(9.6,0,"GL")
 ;;=^XPD(9.6,
 ;;^DIC("B","BUILD",9.6)
 ;;=
 ;;^DIC(9.6,"%D",0)
 ;;=^^4^4^2940705^^^^
 ;;^DIC(9.6,"%D",1,0)
 ;;=This file identifies the elements of a package that will be transported
 ;;^DIC(9.6,"%D",2,0)
 ;;=by the Kernel Installation & Distribution System.  All components of the
 ;;^DIC(9.6,"%D",3,0)
 ;;=package, i.e. templates, options, Security Keys, etc., must be listed in 
 ;;^DIC(9.6,"%D",4,0)
 ;;=in this file.
 ;;^DD(9.6,0)
 ;;=FIELD^NL^916^19
 ;;^DD(9.6,0,"DT")
 ;;=2950330
 ;;^DD(9.6,0,"ID",1)
 ;;=S %I=Y,Y=$S('$D(^(0)):"",$D(^DIC(9.4,+$P(^(0),U,2),0))#2:$P(^(0),U,1),1:""),C=$P(^DD(9.4,.01,0),U,2) D Y^DIQ:Y]"" W "   ",Y,@("$E("_DIC_"%I,0),0)") S Y=%I K %I
 ;;^DD(9.6,0,"IX","B",9.6,.01)
 ;;=
 ;;^DD(9.6,0,"IX","C",9.6,1)
 ;;=
 ;;^DD(9.6,0,"NM","BUILD")
 ;;=
 ;;^DD(9.6,0,"PT",9.63,.01)
 ;;=
 ;;^DD(9.6,0,"VRPK")
 ;;=KERNEL
 ;;^DD(9.6,.01,0)
 ;;=NAME^FX^^0;1^D INPUTB^XPDET(.X)
 ;;^DD(9.6,.01,1,0)
 ;;=^.1^^-1
 ;;^DD(9.6,.01,1,1,0)
 ;;=9.6^B
 ;;^DD(9.6,.01,1,1,1)
 ;;=S ^XPD(9.6,"B",X,DA)=""
 ;;^DD(9.6,.01,1,1,2)
 ;;=K ^XPD(9.6,"B",X,DA)
 ;;^DD(9.6,.01,3)
 ;;=Enter Package or Patch Name and version in the format 'PACKAGE nn.n[V|T]n' or 'PATCH*nn.n*nn'.
 ;;^DD(9.6,.01,21,0)
 ;;=^^2^2^2950105^^^^
 ;;^DD(9.6,.01,21,1,0)
 ;;=The name and version number of this Package or Patch.
 ;;^DD(9.6,.01,21,2,0)
 ;;= i.e. KERNEL 8.0T1  or XU*8.0*1
 ;;^DD(9.6,.01,"DT")
 ;;=2950105
 ;;^DD(9.6,.02,0)
 ;;=DATE DISTRIBUTED^D^^0;4^S %DT="EX" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.6,.02,21,0)
 ;;=^^1^1^2940608^
 ;;^DD(9.6,.02,21,1,0)
 ;;=The date this Build is distributed to the sites.
 ;;^DD(9.6,.02,"DT")
 ;;=2940608
 ;;^DD(9.6,1,0)
 ;;=PACKAGE FILE LINK^*P9.4'^DIC(9.4,^0;2^S DIC("S")="I $$PCK^XPDET(Y)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;^DD(9.6,1,1,0)
 ;;=^.1
 ;;^DD(9.6,1,1,1,0)
 ;;=9.6^C
 ;;^DD(9.6,1,1,1,1)
 ;;=S ^XPD(9.6,"C",$E(X,1,30),DA)=""
 ;;^DD(9.6,1,1,1,2)
 ;;=K ^XPD(9.6,"C",$E(X,1,30),DA)
 ;;^DD(9.6,1,1,1,"DT")
 ;;=2930820
 ;;^DD(9.6,1,3)
 ;;=
 ;;^DD(9.6,1,12)
 ;;=Must be the same Package Name or Namespace
 ;;^DD(9.6,1,12.1)
 ;;=S DIC("S")="I $$PCK^XPDET(Y)"
 ;;^DD(9.6,1,21,0)
 ;;=^^4^4^2950113^^^^
 ;;^DD(9.6,1,21,1,0)
 ;;=Enter this field only if you want to update the Package file when this
 ;;^DD(9.6,1,21,2,0)
 ;;=package is installed at the recipient's site.  You can only reference
 ;;^DD(9.6,1,21,3,0)
 ;;=a Package with the same Name as your Build. If this is a patch, you can
 ;;^DD(9.6,1,21,4,0)
 ;;=only reference a Package with the same Namespace as your Build.
 ;;^DD(9.6,1,"DT")
 ;;=2940425
 ;;^DD(9.6,2,0)
 ;;=TYPE^S^0:SINGLE PACKAGE;1:MULTI-PACKAGE;2:GLOBAL PACKAGE;^0;3^Q
 ;;^DD(9.6,2,3)
 ;;=
 ;;^DD(9.6,2,21,0)
 ;;=^^5^5^2950105^^
 ;;^DD(9.6,2,21,1,0)
 ;;=This field is used to determine information about a Build.
 ;;^DD(9.6,2,21,2,0)
 ;;=A package can be Single, Multi, or Global. A single package is
 ;;^DD(9.6,2,21,3,0)
 ;;=one package and multi package can contain more than one package.
 ;;^DD(9.6,2,21,4,0)
 ;;=A global package contains only globals to transport build, no
 ;;^DD(9.6,2,21,5,0)
 ;;=files or components can be included.
 ;;^DD(9.6,2,"DT")
 ;;=2950105
 ;;^DD(9.6,3,0)
 ;;=DESCRIPTION OF ENHANCEMENTS^9.61A^^1;0
 ;;^DD(9.6,3,21,0)
 ;;=^^2^2^2940607^^^^
 ;;^DD(9.6,3,21,1,0)
 ;;=A complete and detailed description of the Package's or Patch's
 ;;^DD(9.6,3,21,2,0)
 ;;=enhancements and capabilities.
 ;;^DD(9.6,3,"DT")
 ;;=2940607
 ;;^DD(9.6,4,0)
 ;;=VERSION^CJ8^^ ; ^S X=$$VER^XPDUTL($P($G(^XPD(9.6,D0,0)),U))
 ;;^DD(9.6,4,9)
 ;;=^
 ;;^DD(9.6,4,9.01)
 ;;=
 ;;^DD(9.6,4,9.1)
 ;;=S X=$$VER^XPDUTL($P($G(^XPD(9.6,D0,0)),U))
 ;;^DD(9.6,4,21,0)
 ;;=^^1^1^2940914^^
 ;;^DD(9.6,4,21,1,0)
 ;;=This field returns the version number for this package.
 ;;^DD(9.6,5,0)
 ;;=TRACK PACKAGE NATIONALLY^S^y:YES;n:NO;^0;5^Q
 ;;^DD(9.6,5,21,0)
 ;;=^^4^4^2941108^^^
 ;;^DD(9.6,5,21,1,0)
 ;;=YES means you want to send a message to the National Package File on
 ;;^DD(9.6,5,21,2,0)
 ;;=FORUM to track this package when it is installed at an installing site.
 ;;^DD(9.6,5,21,3,0)
 ;;= 
 ;;^DD(9.6,5,21,4,0)
 ;;=NO means you don't want to generate a message.
 ;;^DD(9.6,5,"DT")
 ;;=2940422
 ;;^DD(9.6,6,0)
 ;;=FILE^9.64PA^^4;0
 ;;^DD(9.6,6,21,0)
 ;;=^^3^3^2940502^^^^
 ;;^DD(9.6,6,21,1,0)
 ;;=Any FileMan files which are part of this Package are documented
 ;;^DD(9.6,6,21,2,0)
 ;;=here.  This multiple controls what files (Data Dictionaries and
 ;;^DD(9.6,6,21,3,0)
 ;;=Data) are distributed from this Package entry.
 ;;^DD(9.6,7,0)
 ;;=BUILD COMPONENTS^9.67PA^^KRN;0
 ;;^DD(9.6,7,21,0)
 ;;=^^1^1^2940503^^
 ;;^DD(9.6,7,21,1,0)
 ;;=The list of the components that make up a package.
