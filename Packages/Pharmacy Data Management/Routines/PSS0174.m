PSS0174 ;BIR/JMC- PSS*1*174 POST INSTALL ;01/25/2013
 ;;1.0;PHARMACY DATA MANAGEMENT;**174**;9/30/97;Build 19
 ;
 ;Reference to ^DD(52.6 is supported by DBIA 5895.
 ;
 Q
EN  ;
 ; STRENGTH (#19) field in the IV ADDITIVES File (#52.6) needs to display on any lookup on the file.  This node has to be
 ; set directly.
 ; Also, per the User Group, the Quick Code Strength and the Administration Schedule will display next to any
 ; quick codes associated with the IV ADDITIVE.
 S ^DD(52.6,0,"ID","W19")="S PSSY15=$P(^(0),U,15) W ""   Additive Strength: "",$S($G(PSSY15)="""":""N/A"",$E($G(PSSY15),1)=""."":""0""_PSSY15,1:$G(PSSY15))_"" ""_$S($G(PSSY15)="""":"""",1:$$GET1^DIQ(52.6,+Y_"","",2))"
 S ^DD(52.6,0,"ID","WRITE")="W:$D(^PSDRUG(+$P(^PS(52.6,+Y,0),""^"",2),0)) !?15,$P(^(0),""^"",10) I $D(DD),DD F PSIV=0:0 S PSIV=$O(^PS(52.6,+Y,1,PSIV)) Q:'PSIV  W !?7,""- "",$P(^(PSIV,0),""^""),"" -        Quick Code Strength: """
 S ^DD(52.6,0,"ID","WRITE")=^DD(52.6,0,"ID","WRITE")_",$S($P($G(^PS(52.6,+Y,1,PSIV,0)),""^"",2)'="""":$P($G(^PS(52.6,+Y,1,PSIV,0)),""^"",2),1:""N/A"")"
 S ^DD(52.6,0,"ID","WRITE")=^DD(52.6,0,"ID","WRITE")_"_""     Schedule: "",$S($P($G(^PS(52.6,+Y,1,PSIV,0)),""^"",5)'="""":$P($G(^PS(52.6,+Y,1,PSIV,0)),""^"",5),1:""N/A"")"
 Q
