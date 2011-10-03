LR7OB63A ;slc/dcm - Get Micro (Antibiotic level, Bact, Sterility) ;8/11/97
 ;;5.2;LAB SERVICE;**121,153,187**;Sep 27, 1994
 ;
MI(SPECMEN) ;Microbiology
 ;SPECMEN=ptr to 61, to specify specimen
 N X,Y1,Y2,Y3,Y4,Y5,Y6,Y18,Y19,CTR1,IF,IFN,IFN1,ORG,QU,SSD,SIC1,SBC1,TM1,SIC2,SBC2,TM2,X1,X2,X3
 Q:'$D(^LR(LRDFN,"MI",+$G(IVDT),0))  S X0=^(0),Y6=$S(+$G(CORRECT):"C",$P(X0,"^",3):"F",1:""),Y19=$P(X0,"^",5),CTR1=0
 I $G(SPECMEN),Y19'=SPECMEN Q
 S Y18=";MI;"_IVDT
 I $D(^LR(LRDFN,"MI",IVDT,14)) S IFN=0 D  ;Antibiotic level
 . F  S IFN=$O(^LR(LRDFN,"MI",IVDT,14,IFN)) Q:IFN<1  S X=^(IFN,0) D
 .. S Y1=$P(X,"^")_" ("_$S($P(X,"^",2)="P":"PEAK",$P(X,"^",2)="T":"TROUGH",1:"")_")",Y2=$P(X,"^",3),CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^"_"ug/ml"_"^^"_Y6_"^^^^^^^^^"_Y1_"^^^"_Y18_"^"_Y19
 ;
 I $D(^LR(LRDFN,"MI",IVDT,1))#2 S X=^(1) D  ;Bact
 . S Y6=$S(+$G(CORRECT):"C",1:$P(X,"^",2))
 . I $L($P(X,"^",5)) S Y1="SPUTUM SCREEN",Y2=$P(X,"^",5),CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_Y6_"^^^^^^^^^"_Y1_"^^^"_Y18_"^"_Y19
 . I $L($P(X,"^",6)) S Y1="URINE SCREEN",Y2=$S($P(X,"^",6)="N":"Negative",$P(X,"^",6)="P":"Positive",1:$P(X,"^",6)),CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_Y6_"^^^^^^^^^"_Y1_"^^^"_Y18_"^"_Y19
 . I $D(^LR(LRDFN,"MI",IVDT,2,0)) S Y1="GRAM STAIN",IFN=0 F  S IFN=$O(^LR(LRDFN,"MI",IVDT,2,IFN)) Q:IFN<1  S Y2=^(IFN,0),CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_Y6_"^^^^^^^^^"_Y1_"^^^"_Y18_"^"_Y19
 . I $D(^LR(LRDFN,"MI",IVDT,25,0)) S Y1="BACTERIOLOGY SMEAR/PREP",IFN=0 F  S IFN=$O(^LR(LRDFN,"MI",IVDT,25,IFN)) Q:IFN<1  S Y2=^(IFN,0),CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_Y6_"^^^^^^^^^"_Y1_"^^^"_Y18_"^"_Y19
 . I $D(^LR(LRDFN,"MI",IVDT,3,0)) S Y1="ORGANISM",IFN=0 D
 .. F  S IFN=$O(^LR(LRDFN,"MI",IVDT,3,IFN)) Q:IFN<1  S X=^(IFN,0),ORG=$P(X,"^"),ORG=$P($G(^LAB(61.2,+ORG,0)),"^"),QU=$P(X,"^",2),SSD=$P(X,"^",3,8) D
 ... I SSD'?."^" S SIC1=$P(SSD,"^"),SBC1=$P(SSD,"^",2),TM1=$P(SSD,"^",3),SIC2=$P(SSD,"^",4),SBC2=$P(SSD,"^",5),TM2=$P(SSD,"^",6),SSD=1
 ... I SSD S X1="" D  S Y1=Y1_" "_X1
 .... I $L(SIC1) S X1="SIT "_$S($L(TM1):"("_TM1_")",1:"")_": "_SIC1
 .... I $L(SBC1) S X1=$S($L(X1):", ",1:"")_"SBT "_$S($L(TM1):"("_TM1_")",1:"")_": "_SBC1
 .... I $L(SIC2) S X1=$S($L(X1):", ",1:"")_"SIT "_$S($L(TM2):"("_TM2_")",1:"")_": "_SIC2
 .... I $L(SBC2) S X1=$S($L(X1):", ",1:"")_"SBT "_$S($L(TM2):"("_TM2_")",1:"")_": "_SBC2
 ... S Y2=ORG_";"_QU,CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_Y6_"^^^^^^^^^"_Y1_"^^^"_Y18_"^"_Y19
 ... S IF=0 F  S IF=$O(^LR(LRDFN,"MI",IVDT,3,IFN,3,IF)) Q:IF<1  S X1=^(IF,0),Y1=$P(X1,"^"),Y2=$P(X1,"^",2)_";MIC^"_$P(X1,"^",3)_";MBC",CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^ug/ml^^"_Y6_"^^^^^^^^^"_Y1_"^^^"_Y18_"^"_Y19
 ... S IF=0 F  S IF=$O(^LR(LRDFN,"MI",IVDT,3,IFN,1,IF)) Q:IF<1  S X=^(IF,0),^TMP("LRX",$J,69,CTR,63,"N",IF)=X
 ... S IF=2 F  S IF=$O(^LR(LRDFN,"MI",IVDT,3,IFN,IF)) Q:IF<1!(IF'["2.")  S X=^(IF),Y1=$P(X,"^",1),Y2=$P(X,"^",2),CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_Y6_"^^^^^^^^^"_Y1_"^^^"_Y18_"^"_Y19
 . I $D(^LR(LRDFN,"MI",IVDT,4,0)) S Y1="Bacteriology Remark(s)",IFN=0 F  S IFN=$O(^LR(LRDFN,"MI",IVDT,4,IFN)) Q:IFN<1  S Y2=^(IFN,0),CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_Y6_"^^^^^^^^^"_Y1_"^^^"_Y18_"^"_Y19
 ;
 I $D(^LR(LRDFN,"MI",IVDT,31)) D  ;Sterility
 . S Y1="STERILITY CONTROL",Y2=$S($L($P(^LR(LRDFN,"MI",IVDT,1),"^",7)):$S($P(^(1),"^",7)="N":"Negative",1:"Positive"),1:""),CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_Y6_"^^^^^^^^^"_Y1_"^^^"_Y18_"^"_Y19
 . S IFN=0 F  S IFN=$O(^LR(LRDFN,"MI",IVDT,31,IFN)) Q:IFN<1  S X=^(IFN,0),Y2=X,CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,CTR1)=Y1_"^"_Y2_"^^^^"_Y6_"^^^^^^^^^"_Y1_"^^^"_Y18_"^"_Y19
 ;
 D MI^LR7OB63B
 I $D(^LR(LRDFN,"MI",IVDT,99)) S Y1="Comments on Specimen",Y2=^(99),CTR1=CTR1+1,^TMP("LRX",$J,69,CTR,63,"N",CTR1)=Y1_": "_Y2
 Q
