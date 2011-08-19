LR7OB68 ;slc/dcm - Get Lab data from 68 ;8/11/97
 ;;5.2;LAB SERVICE;**121**;Sep 27, 1994
 ;
68(CTR,ACCDT,ACC,ACCN,TEST) ;Get data from file 68
 ;CTR=Counter
 ;ACCDT=Accession Date subscript
 ;ACC=Accession area subscript
 ;ACCN=Accession # subscript
 ;TEST=test ptr
 ;See ^LR7OB69 for description of LRX array
 N X0,XP1,XP2,X3,IFN,Y1,Y2,Y3,Y4,Y5,Y6,Y7 K ^TMP("LRX",$J,68)
 Q:'$D(^LRO(68,+ACC,1,+ACCDT,1,+ACCN,0))  S X0=^(0),XP1=$G(^(.1)),XP2=$G(^(.2)),X3=$G(^(3))
 S Y1=+XP1,Y2=$P(X0,"^"),Y3=XP2,Y4=$P(X3,"^"),Y5=$P(X3,"^",3),Y6=$P(X3,"^",4),Y7=$P(X3,"^",5)
 S ^TMP("LRX",$J,69,CTR,68)=Y1_"^"_Y2_"^"_Y3_"^"_Y4_"^"_Y5_"^"_Y6_"^"_Y7
 I $D(^LRO(68,ACC,1,ACCDT,1,ACCN,4,TEST)) S X=^(TEST,0),^TMP("LRX",$J,69,CTR,68,TEST)=+X_"^"_$P(X,"^",2)_"^"_$P(X,"^",4)_"^"_$P(X,"^",5) D 63^LR7OB63(CTR,Y2,$P($G(^LRO(68,ACC,0)),"^",2),Y7,+$G(CORRECT))
 Q
A68(ACCDT,ACC,ACCN) ;Get data from file 68 when no 69 data exists
 ;Used for accessions that have no corresponding entries in file 69
 ;i.e. CY,EM,AU,SP (as of this version they all do)
 ;ACCDT=Accession Date subscript
 ;ACC=Accession area subscript
 ;ACCN=Accession # subscript
 N X0,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9,Y10,Y11,Y12,XP1,XP2,XAC,GOTCOM
 Q:'$D(^LRO(68,+ACC,1,+ACCDT,1,+ACCN,0))  S X0=^(0),XP1=$G(^(.1)),XP2=$G(^(.2)),X3=$G(^(3))
 Q:'$D(^LR(+X0,0))  ;No matching entry in ^LR
 S Y11=$S($P($G(^LRO(69,+$P(X0,"^",4),1,+$P(X0,"^",5),0)),"^",11):$P(^(0),"^",11),1:""),Y12=$P(X0,"^",10)
 S:'$D(DFN) DFN=$P(^LR(+X0,0),"^",3) S:'$D(LRDFN) LRDFN=+X0 S:'$D(LRDPF) LRDPF=$P(^LR(+X0,0),"^",2)_$G(^DIC(+$P(^LR(+X0,0),"^",2),0,"GL"))
 S Y1=+XP1,Y2=+X3,Y3="",Y4="",Y5=$P(X0,"^",4),Y6=$P(X0,"^",8),Y7=$P(X0,"^",7),Y8=$P(X3,"^",3),Y9=$P(X3,"^",4),Y10="",CTR=1
 S ^TMP("LRX",$J,69)=Y1_"^"_Y2_"^"_Y3_"^"_Y4_"^"_Y5_"^"_Y6_"^"_Y7_"^"_Y8_"^"_Y9_"^"_Y10_"^"_Y11_"^"_Y12
 S Y1=+XP1,Y2=$P(X0,"^"),Y3=XP2,Y4=$P(X3,"^"),Y5=$P(X3,"^",3),Y6=$P(X3,"^",4),Y7=$P(X3,"^",5)
 S XAC=$P($G(^LRO(68,ACC,0)),"^",2),X=$S(XAC="CY":$O(^LAB(60,"B","CYTOPATHOLOGY",0)),XAC="EM":$O(^LAB(60,"B","ELECTRON MICROSCOPY",0)),XAC="AU":$O(^LAB(60,"B","AUTOPSY",0)),XAC="SP":$O(^LAB(60,"B","SURGICAL PATHOLOGY",0)),1:"")
 I X="" S X=$S(XAC="CY":"CYTOPATHOLOGY",XAC="EM":"ELECTRON MICROSCOPY",XAC="AU":"AUTOPSY",XAC="SP":"SURGICAL PATHOLOGY",1:"")
 S ^TMP("LRX",$J,69,CTR)=X_"^^"_ACCDT_"^"_ACC_"^"_ACCN
 S ^TMP("LRX",$J,69,CTR,68)=Y1_"^"_Y2_"^"_Y3_"^"_Y4_"^"_Y5_"^"_Y6_"^"_Y7
 S TEST=0 F  S TEST=$O(^LRO(68,ACC,1,ACCDT,1,ACCN,4,TEST)) Q:TEST<1  S X=^(TEST,0),^TMP("LRX",$J,69,CTR,68,TEST)=+X_"^"_$P(X,"^",2)_"^"_$P(X,"^",4)_"^"_$P(X,"^",5) D 63^LR7OB63(CTR,Y2,XAC,Y7,+$G(CORRECT))
 Q
