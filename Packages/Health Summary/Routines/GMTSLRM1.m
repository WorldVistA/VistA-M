GMTSLRM1 ;SLC/SBW - Microbiology Component Continue ;2/13/98  14:15
 ;;2.7;Health Summary;**25**;Oct 20, 1995
REMARKS ; Write remarks
 N RPT,NUM,FIRST
 S NUM="",FIRST=1
 F  S NUM=$O(^TMP("LRM",$J,GMZ,GMK,NUM)) Q:+NUM'>0  D  Q:$D(GMTSQIT)
 . S RPT=^TMP("LRM",$J,GMZ,GMK,NUM)
 . I $L(RPT)>58 S RPT=$$WRAP^GMTSORC(RPT,58)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . I FIRST W ?12,"Remarks:" S FIRST=0
 . W ?21,$P(RPT,"|"),!
 . I $L($P(RPT,"|",2)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?23,$P(RPT,"|",2),!
 Q
COMMENT ; Write comment
 Q:+$D(^TMP("LRM",$J,GMZ,GMK,"COM"))'>0
 N REC,COM
 S REC=0
 F  S REC=$O(^TMP("LRM",$J,GMZ,GMK,"COM",REC)) Q:REC'>0  D
 . S COM=^TMP("LRM",$J,GMZ,GMK,"COM",REC)
 . I $L(COM)>55 S COM=$$WRAP^GMTSORC(COM,55)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W ?25,$P(COM,"|"),!
 . I $L($P(COM,"|",2)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?27,$P(COM,"|",2),!
 Q
PARACOMM ; Write comment for parasite
 Q:+$D(^TMP("LRM",$J,GMZ,GMK,GML,"COM"))'>0
 N REC,COM
 S REC=0
 F  S REC=$O(^TMP("LRM",$J,GMZ,GMK,GML,"COM",REC)) Q:REC'>0  D
 . S COM=^TMP("LRM",$J,GMZ,GMK,GML,"COM",REC)
 . I $L(COM)>53 S COM=$$WRAP^GMTSORC(COM,53)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W ?27,$P(COM,"|"),!
 . I $L($P(COM,"|",2)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?29,$P(COM,"|",2),!
 Q
WRTGRM ; Writes Gram Stain Results
 N GMGRAM
 S GMGRAM=^TMP("LRM",$J,GMZ,GMK)
 S:$L(GMGRAM)>58 GMGRAM=$$WRAP^GMTSORC(GMGRAM,58)
 D CKP^GMTSUP Q:$D(GMTSQIT)  W:GMK=1 ?15,"Gram:" W ?21,$P(GMGRAM,"|"),!
 I $L($P(GMGRAM,"|",2)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?23,$P(GMGRAM,"|",2),!
 Q
ANTIBX ; Writes Antibiotic susceptability data
 N GML,GMCNT,ANAM,ANLEN,ANEXT,GMSUB
 S GMABX=1
 F GMSUB="S","I","R","O" D  Q:$D(GMTSQIT)
 . Q:+$D(^TMP("LRM",$J,GMZ,GMK,"SUSC",GMSUB))'>0
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W:GMSUB="S" ?5,"Susceptible to: "
 . W:GMSUB="I" ?7,"Intermediate: "
 . W:GMSUB="R" ?7,"Resistant to: "
 . W:GMSUB="O" ?7,"       Other: "
 . S ANLEN=21,GML=""
 . F  S GML=$O(^TMP("LRM",$J,GMZ,GMK,"SUSC",GMSUB,GML)) Q:GML=""  S ANAM=$P($P(^(GML),U),";",2)_$S(GMSUB="O":"("_$P(^(GML),U,2)_"/"_$P(^(GML),U,3)_")",1:""),ANEXT=$O(^(GML)) D  Q:$D(GMTSQIT)
 . . I $L(ANAM)+ANLEN>79 D CKP^GMTSUP Q:$D(GMTSQIT)  W:'GMTSNPG ! W ?21 S ANLEN=21
 . . W ANAM,$S(ANEXT]"":", ",1:"") S ANLEN=ANLEN+$L(ANAM)+2
 . W !
 Q
WRTTEST ; Writes Lab Test for Accession
 N GML,GMCNT,TNAM,TLEN,TNEXT
 Q:'$D(^TMP("LRM",$J,GMZ,"TEST"))
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?4,"Test(s) ordered: "
 S TLEN=21,GML=""
 F  S GML=$O(^TMP("LRM",$J,GMZ,"TEST",GML)) Q:GML=""  S TNAM=$P($G(^(GML)),U),TNEXT=$O(^(GML)) D  Q:$D(GMTSQIT)
 . I $L(TNAM)+TLEN>79 D CKP^GMTSUP Q:$D(GMTSQIT)  W:'GMTSNPG ! W ?21 S TLEN=21
 . W TNAM,$S(TNEXT]"":", ",1:"") S TLEN=TLEN+$L(TNAM)+2
 W !
 Q
WRTSTER ; Writes sterility control data
 N STER,GML
 S STER=$G(^TMP("LRM",$J,"BSTER",0))
 Q:STER']""
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?2,"Sterility Control:",?21,STER,!
 S GML=0
 F  S GML=$O(^TMP("LRM",$J,GMZ,GML)) Q:GML'>0  D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP I $D(GMTSQIT)
 . W ?13,"Number:",?21,GML,?44,"Results: ",$P(^TMP("LRM",$J,GMZ,GML),U),!
 Q
TBSUSC ;Display TB Susceptiblities
 Q:+$D(^TMP("LRM",$J,GMZ,GMK,"SUSC"))'>0
 N GMTB,QTY
 S GMTB=0
 F  S GMTB=$O(^TMP("LRM",$J,GMZ,GMK,"SUSC",GMTB)) Q:GMTB'>0  D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W ?21,$P(^TMP("LRM",$J,GMZ,GMK,"SUSC",GMTB),U)
 . S QTY=$P(^TMP("LRM",$J,GMZ,GMK,"SUSC",GMTB),U,2)
 . I $L(QTY)>36 S QTY=$$WRAP^GMTSORC(QTY,36)
 . W ?44,$P(QTY,"|"),!
 . I $L($P(QTY,"|",2)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?44,$P(QTY,"|",2),!
 Q
