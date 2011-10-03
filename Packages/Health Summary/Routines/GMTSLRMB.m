GMTSLRMB ; SLC/JER,KER - Microbiology Component Dvr ; 09/21/2001
 ;;2.7;Health Summary;**25,28,47**;Oct 20, 1995
 ;
 ; External References
 ;    DBIA   525  ^LR( all fields
 ;    DBIA 10035  ^DPT( field 63 Read w/Fileman
 ;    DBIA  2056  $$GET1^DIQ (file 2)
 ;                       
MAIN ; Microbioloby Brief
 N IX0,IX,LRDFN,MAX,D1,D2,D3
 S LRDFN=+($$GET1^DIQ(2,(+($G(DFN))_","),63,"I")) Q:+LRDFN=0  Q:'$D(^LR(LRDFN))
 S MAX=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:999)
 S IX=GMTS1 F IX0=1:1:MAX S IX=$O(^LR(LRDFN,"MI",IX)) Q:+IX'>0!(IX>GMTS2)  D CKP^GMTSUP Q:$D(GMTSQIT)  D  Q:$D(GMTSQIT)
 . D ^GMTSLRME I $D(^TMP("LRM",$J)) D
 . . D:IX0>1 CKP^GMTSUP Q:$D(GMTSQIT)  W:IX0>1&'GMTSNPG ! D INTRP
 . K ^TMP("LRM",$J)
 Q
INTRP ; Interprets ^TMP("LRM",$J
 N GMTSJ,GMK,GMW,SMEAR,GMABX
 S (GMTSJ,GMK)=""
 F  S GMTSJ=$O(^TMP("LRM",$J,GMTSJ)) Q:GMTSJ=""!$D(GMTSQIT)  D RDNODE
 Q
RDNODE ; Reads current node of ^TMP("LRM",$J
 Q:GMTSJ="BSTER"
 I GMTSJ=0 D  Q
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W $P($P(^TMP("LRM",$J,GMTSJ),U)," "),?12,$P(^TMP("LRM",$J,GMTSJ),U,3),!
 . D WRTTEST
 S GMK=""
 F  S GMK=$O(^TMP("LRM",$J,GMTSJ,GMK)) Q:GMK=""!$D(GMTSQIT)  D WRTNODE
 I GMTSJ="TB" D  Q:$D(GMTSQIT)
 . I $P(^TMP("LRM",$J,GMTSJ,0),U,2)]"" D
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W "AFB Sme:",?12,$E($P(^TMP("LRM",$J,GMTSJ,0),U,2),1,20),!
 . . I $P(^TMP("LRM",$J,GMTSJ,0),U,3)]"" D
 . . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . . W ?12,$P(^TMP("LRM",$J,GMTSJ,0),U,3),!
 I $D(^TMP("LRM",$J,GMTSJ,"SMEAR")) D
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W ?2,"Smear:"
 . S SMEAR=0
 . F  S SMEAR=$O(^TMP("LRM",$J,GMTSJ,"SMEAR",SMEAR)) Q:SMEAR'>0  W ?12,^(SMEAR),! I +$O(^TMP("LRM",$J,"SMEAR",SMEAR)) D CKP^GMTSUP Q:$D(GMTSQIT)
 Q
WRTNODE ; Writes current node of ^TMP("LRM",$J
 N GML,QTY
 I GMK=0 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?1,"Report:",?12,$P(^TMP("LRM",$J,GMTSJ,GMK),U),! Q
 I GMTSJ="GRAM" D WRTGRM Q
 Q:GMK="SMEAR"
 I GMK="R" D REMARKS Q
 I GMTSJ'="CABXL" D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W "Organsm:",?12,$P(^TMP("LRM",$J,GMTSJ,GMK),U),!
 . I $P(^TMP("LRM",$J,GMTSJ,GMK),U,2)]"" D CKP^GMTSUP Q:$D(GMTSQIT)  W ?4,"QTY:",?12,$P(^TMP("LRM",$J,GMTSJ,GMK),U,2),!
 I GMTSJ="CABXL" D
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W:GMK=1 "Ser Abx:"
 . W ?12,$E($P(^TMP("LRM",$J,GMTSJ,GMK),U),1,18),?30,$$DRAW^GMTSLRM($P(^TMP("LRM",$J,GMTSJ,GMK),U,2)),?38,$P(^(GMK),U,3)," ug/ml",!
 I GMTSJ="BACT",$D(^TMP("LRM",$J,GMTSJ,GMK,"SUSC")) D ANTIBX Q
 I GMTSJ="PARA",$D(^TMP("LRM",$J,GMTSJ,GMK))=11 D
 . S GML=""
 . F  S GML=$O(^TMP("LRM",$J,GMTSJ,GMK,GML)) Q:GML'>0  D  Q:$D(GMTSQIT)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W ?12,$P(^TMP("LRM",$J,GMTSJ,GMK,GML),U)
 . . S QTY=$P(^TMP("LRM",$J,GMTSJ,GMK,GML),U,2)
 . . I $L(QTY)>46 S QTY=$$WRAP^GMTSORC(QTY,46)
 . . W ?35,$P(QTY,"|"),!
 . . I $L($P(QTY,"|",2)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?35,$P(QTY,"|",2),!
 Q
REMARKS ; Write remarks
 N NUM,FIRST
 S NUM="",FIRST=1
 F  S NUM=$O(^TMP("LRM",$J,GMTSJ,GMK,NUM)) Q:+NUM'>0  D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W:$X>0 !
 . I FIRST W "Remarks:" S FIRST=0
 . W ?12,^TMP("LRM",$J,GMTSJ,GMK,NUM),!
 Q
WRTGRM ; Writes Gram Stain Results
 D CKP^GMTSUP Q:$D(GMTSQIT)  W:$X>0 ! W:GMK=1 ?3,"Gram:" W ?12,$E(^TMP("LRM",$J,GMTSJ,GMK),1,69),!
 Q
ANTIBX ; Writes Antibiotic susceptability data
 N GML,GMCNT,ANAM,ANLEN,ANEXT,GMSUB
 S GMABX=1
 F GMSUB="S","I","R","O" D  Q:$D(GMTSQIT)
 . Q:+$D(^TMP("LRM",$J,GMTSJ,GMK,"SUSC",GMSUB))'>0
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W:GMSUB="S" "Susc to:    "
 . W:GMSUB="I" "Interme:    "
 . W:GMSUB="R" "Resista:    "
 . W:GMSUB="O" "  Other:    "
 . S ANLEN=10,GML=""
 . F  S GML=$O(^TMP("LRM",$J,GMTSJ,GMK,"SUSC",GMSUB,GML)) Q:GML=""  S ANAM=$P($P(^(GML),U),";",2)_$S(GMSUB="O":"("_$P(^(GML),U,2)_"/"_$P(^(GML),U,3)_")",1:""),ANEXT=$O(^(GML)) D  Q:$D(GMTSQIT)
 . . I $L(ANAM)+ANLEN>79 D CKP^GMTSUP Q:$D(GMTSQIT)  W:'GMTSNPG ! W ?12 S ANLEN=10
 . . W ANAM,$S(ANEXT]"":", ",1:"") S ANLEN=ANLEN+$L(ANAM)+2
 . W !
 Q
WRTTEST ; Writes Lab Test for Accession
 N GML,GMCNT,TNAM,TLEN,TNEXT
 Q:'$D(^TMP("LRM",$J,GMTSJ,"TEST"))
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "Test(s):    "
 S TLEN=10,GML=""
 F  S GML=$O(^TMP("LRM",$J,GMTSJ,"TEST",GML)) Q:GML=""  S TNAM=$P($G(^(GML)),U),TNEXT=$O(^(GML)) D  Q:$D(GMTSQIT)
 . I $L(TNAM)+TLEN>79 D CKP^GMTSUP Q:$D(GMTSQIT)  W:'GMTSNPG ! W ?12 S TLEN=10
 . W TNAM,$S(TNEXT]"":", ",1:"") S TLEN=TLEN+$L(TNAM)+2
 W !
 Q
