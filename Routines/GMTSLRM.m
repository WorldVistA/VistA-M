GMTSLRM ; SLC/JER,KER - Microbiology Component Driver ; 09/21/2001
 ;;2.7;Health Summary;**28,47**;Oct 20, 1995
 ;
 ; External References
 ;    DBIA   525  ^LR( all fields
 ;    DBIA 10035  ^DPT( field 63 Read w/Fileman
 ;    DBIA  2056  $$GET1^DIQ (file 2)
 ;                         
MAIN ; Microbiology
 N IX0,IX,LRDFN,MAX,D1,D2,D3
 S LRDFN=+($$GET1^DIQ(2,(+($G(DFN))_","),63,"I")) Q:+LRDFN=0  Q:'$D(^LR(LRDFN))
 Q:+($S('$D(^LR(LRDFN,"MI",0)):1,'$O(^LR(LRDFN,"MI",GMTS1)):1,$O(^(GMTS1))>GMTS2:1,1:0))
 S MAX=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:999),IX=GMTS1
 F IX0=1:1:MAX S IX=$O(^LR(LRDFN,"MI",IX)) Q:+IX'>0!(IX>GMTS2)!$D(GMTSQIT)  D CKP^GMTSUP Q:$D(GMTSQIT)  D  Q:$D(GMTSQIT)
 . D ^GMTSLRME I $D(^TMP("LRM",$J)) D:IX0>1 CKP^GMTSUP Q:$D(GMTSQIT)  W:IX0>1 ! D INTRP
 . K ^TMP("LRM",$J)
 Q
INTRP ; Interprets ^TMP("LRM",$J
 N GMZ,GMK S (GMZ,GMK)=""
 F  S GMZ=$O(^TMP("LRM",$J,GMZ)) Q:GMZ=""  D RDNODE  Q:$D(GMTSQIT)
 Q
RDNODE ; Reads current node of ^TMP("LRM",$J
 N GMABX,COM S GMABX=0 I GMZ=0 D  Q
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?10,"Collected:",?21,$P(^TMP("LRM",$J,GMZ),U),?43,"Acc:",?48,$P(^TMP("LRM",$J,GMZ),U,2),!
 . I $P(^TMP("LRM",$J,GMZ),U,6)'=$P(^(GMZ),U,3) D
 . . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?2,"Collection Sample:",?21,$P(^TMP("LRM",$J,GMZ),U,6),!
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?6,"Site/Specimen:",?21,$TR($P(^TMP("LRM",$J,GMZ),U,3),"|"," "),!
 . S COM=$P(^TMP("LRM",$J,GMZ),U,7)
 . I COM]"" D
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W "Comment on Specimen:"
 . . I $L(COM)>58 S COM=$$WRAP^GMTSORC(COM,58)
 . . W ?21,$P(COM,"|"),!
 . . I $L($P(COM,"|",2)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?22,$P(COM,"|",2),!
 . D WRTTEST^GMTSLRM1
 S GMK="" F  S GMK=$O(^TMP("LRM",$J,GMZ,GMK)) Q:GMK=""  D WRTNODE Q:$D(GMTSQIT)
 Q
WRTNODE ; Writes current node of ^TMP("LRM",$J
 N GML,SMEAR,QTY,ORG,GMN,RSMEAR
 I GMZ="BSTER" D  Q
 . I GMK=0 D  Q
 . . Q:$P(^TMP("LRM",$J,"BSTER",GMK),U)']""
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . .  W ?2,"Sterility Control:",?21,$P(^TMP("LRM",$J,"BSTER",GMK),U),! Q
 . D CKP^GMTSUP I $D(GMTSQIT)
 . W ?13,"Number:",?21,GMK,?34,"Sterility Results: ",$P(^TMP("LRM",$J,GMZ,GMK),U),!
 I GMK=0 S GMN=$G(^TMP("LRM",$J,GMZ,GMK)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?4,$S(GMZ="BACT":"    Bact ",GMZ="TB":"Mycobact ",GMZ="MYCO":"Mycology ",GMZ="PARA":"Parasite ",GMZ="VIRO":"Virology ",1:"         ")_"Report:",?21,$P(GMN,U),! D  Q
 . I GMZ="BACT" D  Q:$D(GMTSQIT)
 . . I $P(GMN,U,3)]"" D CKP^GMTSUP Q:$D(GMTSQIT)  W ?7,"Urine Screen: ",$P(GMN,U,3),!
 . . I $P(GMN,U,2)]"" D CKP^GMTSUP Q:$D(GMTSQIT)  W ?6,"Sputum Screen: ",$P(GMN,U,2),!
 . I GMZ="TB" D  Q:$D(GMTSQIT)
 . . I $P(GMN,U,2)]"" D CKP^GMTSUP Q:$D(GMTSQIT)  W ?4,"Acid Fast Stain: ",$E($P(GMN,U,2),1,20) D
 . . . S QTY=$P(GMN,U,3)
 . . . I $L(QTY)>35 S QTY=$$WRAP^GMTSORC(QTY,35)
 . . . W ?44,$P(QTY,"|"),!
 . . . I $L($P(QTY,"|",2)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?44,$P(QTY,"|",2),!
 I GMZ="GRAM" D WRTGRM^GMTSLRM1 Q
 I GMK="SMEAR" D  Q
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W ?9,"Smear/Prep:"
 . S SMEAR=0
 . F  S SMEAR=$O(^TMP("LRM",$J,GMZ,GMK,SMEAR)) Q:SMEAR'>0  D  I +$O(^TMP("LRM",$J,GMK,SMEAR)) D CKP^GMTSUP Q:$D(GMTSQIT)
 . . S RSMEAR=^TMP("LRM",$J,GMZ,GMK,SMEAR)
 . . I $L(RSMEAR)>58 S RSMEAR=$$WRAP^GMTSORC(RSMEAR,58)
 . . W ?21,$P(RSMEAR,"|"),!
 . . I $L($P(RSMEAR,"|",2)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?22,$P(RSMEAR,"|",2),!
 I GMK="R" D REMARKS^GMTSLRM1 Q
 I GMZ'="CABXL" D  Q:$D(GMTSQIT)
 . S ORG=$P(^TMP("LRM",$J,GMZ,GMK),U),QTY=$P(^(GMK),U,2)
 . I $L(ORG)>58 S ORG=$$WRAP^GMTSORC(ORG,58)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W ?11,"Organism:"
 . W ?21,$P(ORG,"|",1),!
 . I $L($P(ORG,"|",2)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?23,$P(ORG,"|",2),!
 . I QTY]"" W ?11,"Quantity:" D
 . . I $L(QTY)>58 S QTY=$$WRAP^GMTSORC(QTY,58)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?21,$P(QTY,"|"),!
 . . I $L($P(QTY,"|",2)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?23,$P(QTY,"|",2),!
 . D COMMENT^GMTSLRM1 Q:$D(GMTSQIT)
 . I GMZ="TB" D TBSUSC^GMTSLRM1
 I GMZ="CABXL" D
 . I GMK=1!(GMABX=1) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?8,"Ser Abx Lev:"
 . W ?21,$E($P(^TMP("LRM",$J,GMZ,GMK),U),1,20),?45,$$DRAW($P(^TMP("LRM",$J,GMZ,GMK),U,2)),?55,$P(^TMP("LRM",$J,GMZ,GMK),U,3)," ug/ml",! D CKP^GMTSUP Q:$D(GMTSQIT)
 I GMZ="BACT",$D(^TMP("LRM",$J,GMZ,GMK,"SUSC")) D ANTIBX^GMTSLRM1 Q
 I GMZ="PARA",$D(^TMP("LRM",$J,GMZ,GMK))=11 D
 . S GML=0
 . F  S GML=$O(^TMP("LRM",$J,GMZ,GMK,GML)) Q:GML'>0  D  Q:$D(GMTSQIT)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W ?23,$P(^TMP("LRM",$J,GMZ,GMK,GML),U)
 . . S QTY=$P(^TMP("LRM",$J,GMZ,GMK,GML),U,2)
 . . I $L(QTY)>34 S QTY=$$WRAP^GMTSORC(QTY,34)
 . . W ?45,$P(QTY,"|"),!
 . . I $L($P(QTY,"|",2)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?45,$P(QTY,"|",2),!
 . . D PARACOMM^GMTSLRM1
 Q
DRAW(CODE) ; Peak/Trough/Random Abx level
 Q $S(CODE="P":"PEAK",CODE="T":"TROUGH",1:"RANDOM")
