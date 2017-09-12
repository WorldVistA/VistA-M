XU8P459 ;BP/BDT - Compile Print Template ;4/4/2007
 ;;8.0;KERNEL;**459**;Jul 10, 1995;Build 3
 Q
POST ;
 N X,Y,DMAX
 S X="XUCT01"
 S Y=$$FIND1^DIC(.4,"","MX","XUSERINQ","","","ERR")
 S DMAX=$$ROUSIZE^DILF
 I +Y>0 D EN^DIPZ
 Q
