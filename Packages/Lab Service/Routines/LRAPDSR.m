LRAPDSR ;DALOI/WTY/KLL - AP SUPPLEMENTARY REPORT ENTRY;12/05/00
 ;;5.2;LAB SERVICE;**248,259,295,317**;Sep 27, 1994
 ;
 N LRYTMP,LRWPROOT,LRRLS,LRRLS1,LRRLS2,LRX,LRIENS,LRFILE1,LRFILE,LRA
 N LRIENS1,LRXTMP,LRFDA,LRNOW,LRIENS2,LRFIELD,LRORIEN,LRFLG,LRDA,LRQUIT
 ;
MAIN ;Main Subroutine
 D RELEAS1
 D GETRPT
 Q:LRQUIT
 D RELEAS2
 D:LRRLS COPY
 Q:LRQUIT
 D RPT
 ;Add supp report to the PRELIMINARY print queue
 D QUESP
 Q:LRQUIT
 D COMPARE
 Q:LRQUIT
 ;If supp report is already released (LRRLS1), unrelease it,
 ;   but only if the E-Sign Switch is ON (LRESSW)
 N LRESSW
 D GETDATA^LRAPESON(.LRESSW)
 I LRRLS1,LRESSW D UNRELEAS
 D UPDATE
 Q:LRQUIT
 D STORE
 Q
RELEAS1 ;Is the ENTIRE report already released?
 S (LRRLS,LRRLS1,LRQUIT)=0
 I LRSS="AU" D  Q
 .S LRX=$P($G(^LR(LRDFN,LRSS)),"^",15)
 .Q:'LRX         ;Report has not been released so no audit will occur.
 .W $C(7),!!,"This AUTOPSY has been released.  Supplementary report "
 .W "additions/modifications"
 .W !,"will create an audit trail.",!
 .S LRRLS=1    ;Report has been released so auditing will occur.
 S LRX=$P($G(^LR(LRDFN,LRSS,LRI,0)),"^",11)
 ;
 I LRX D
 .W $C(7),!!,"This "_$G(LRAA(1))_" report has been released."
 .W !,"Supplementary report additions/modifications will create"
 .W " an audit trail.",!
 .S LRRLS=1
 Q
GETRPT ;First, select the report 
 S DIC(0)="QAEZL",DLAYGO=63
 S DIC("A")="Select SUPPLEMENTARY REPORT DATE: "
 S DIC=$S(LRSS="AU":"^LR(LRDFN,84,",1:"^LR(LRDFN,LRSS,LRI,1.2,")
 S DIC("P")=$S(LRSS="AU":"63,32.4,0",1:"LRSF,1.2,0")
 S DIC("P")=$P(@("^DD("_DIC("P")_")"),"^",2)
 S DIC("B")="" S LRX=0 F  S LRX=$O(@(DIC_"LRX)")) Q:'LRX  D
 .S DIC("B")=+(@(DIC_"LRX,0)"))
 D ^DIC K DLAYGO
 S:Y=-1 LRQUIT=1
 Q
RELEAS2 ;Is the supplementary report already released?
 S LRRLS2=0
 S:LRSS'="AU" LRX=$G(^LR(LRDFN,LRSS,LRI,1.2,+Y,0))
 S:LRSS="AU" LRX=$G(^LR(LRDFN,84,+Y,0))
 S LRRLS2=+$P(LRX,"^",2)
 I LRRLS2 D
 .W $C(7),!!,"This supplementary report has been released.  Additions/"
 .W "modifications",!,"will create an audit trail.",!
 .S LRRLS1=1
 Q
COPY ;Make a copy of the current report.
 K ^TMP("DIQ1",$J)
 S LRIENS=+Y_","_$S(LRSS'="AU":LRI_",",1:"")_LRDFN_","
 S LRFILE1=$S(LRSS="SP":63.817,LRSS="CY":63.907,LRSS="EM":63.207,1:"")
 S:LRFILE1="" LRFILE1=$S(LRSS="AU":63.324,1:"")
 I LRFILE1="" S LRQUIT=1 Q
 D GETS^DIQ(LRFILE1,LRIENS,"**","Z","^TMP(""DIQ1"",$J)")
 Q
RPT ;
 N DIE,DA,DR
 S DIE=DIC K DIC
 S (LRDA,DA)=+Y
 S:LRSS="AU" DA(1)=LRDFN
 S:LRSS'="AU" DA(1)=LRI,DA(2)=LRDFN
 S DR=".01;1" D ^DIE
 I 'LRRLS S LRQUIT=1
 Q
QUESP ;Update the preliminary report print queue
 N LRIENS
 I '$D(^LRO(69.2,LRAA,1,LRAN,0)) D
 .K LRFDA
 .L +^LRO(69.2,LRAA,1):5 I '$T D  Q
 ..S MSG(1)="The preliminary reports queue is in use.  "
 ..S MSG(1,"F")="!!"
 ..S MSG(2)="You will need to add this accession to the queue later."
 ..D EN^DDIOL(.MSG) K MSG
 .S LRIENS="+1,"_LRAA_","
 .S LRFDA(69.21,LRIENS,.01)=LRDFN
 .S LRFDA(69.21,LRIENS,1)=LRI
 .S LRFDA(69.21,LRIENS,2)=LRH(0)
 .S LRORIEN(1)=LRAN
 .D UPDATE^DIE("","LRFDA","LRORIEN")
 .L -^LRO(69.2,LRAA,1)
 Q
COMPARE ;Compare reports
 I '$D(^TMP("DIQ1",$J)) S LRQUIT=1 Q
 S:LRSS'="AU" LRFILE="^LR(LRDFN,LRSS,LRI,1.2,LRDA,1,"
 S:LRSS="AU" LRFILE="^LR(LRDFN,84,LRDA,1,"
 I '$D(@(LRFILE_"0)")) D  Q
 .D:LRRLS1 UNRELEAS
 .S LRQUIT=1
 S LRA=0,LRFLG=1
 F  S LRA=$O(@(LRFILE_"LRA)")) Q:'LRA  D
 .S LRXTMP=@(LRFILE_"LRA,0)")
 .S:'$D(^TMP("DIQ1",$J,LRFILE1,LRIENS,1,LRA,0)) LRFLG=0
 .Q:'LRFLG
 .S LRYTMP=^TMP("DIQ1",$J,LRFILE1,LRIENS,1,LRA,0)
 .I LRXTMP'=LRYTMP S LRFLG=0
 I LRFLG D
 .S LRA=0 F  S LRA=$O(^TMP("DIQ1",$J,LRFILE1,LRIENS,1,LRA)) Q:'LRA  D
 ..I '$D(@(LRFILE_"LRA,0)")) S LRFLG=0
 I LRFLG D
 .W $C(7),!!,"No changes were made to the supplementary report."
 .K ^TMP("DIQ1",$J)
 .S LRQUIT=1
 Q
UNRELEAS ;Unrelease the supplementary report.
 K LRFDA
 S LRFDA(1,LRFILE1,LRIENS,.02)="@"
 D UPDATE^DIE("","LRFDA(1)")
 Q
UPDATE ;File changes
 ;First, store the date of the change and user ID
 D UPDATE^LRPXRM(LRDFN,LRSS,+$G(LRI))
 K LRFDA
 S X="NOW",%DT="T" D ^%DT S LRNOW=Y
 S LRIENS1="+1,"_LRIENS
 S LRFILE=$S(LRSS="SP":63.8172,LRSS="CY":63.9072,LRSS="EM":63.2072,1:"")
 S:LRFILE="" LRFILE=$S(LRSS="AU":63.3242,1:"")
 I LRFILE="" S LRQUIT=1 Q
 S LRFDA(1,LRFILE,LRIENS1,.01)=LRNOW
 S LRFDA(1,LRFILE,LRIENS1,.02)=DUZ,LRFIELD=1
 D UPDATE^DIE("","LRFDA(1)","LRORIEN")
 ;If E-Sign switch OFF,set 3rd piece .03 SUPP REPORT MODIFIED to 1
 ;  to flag the supp report so it can be released via RS
 I 'LRESSW D
 .S:LRSS'="AU" $P(^LR(LRDFN,LRSS,LRI,1.2,LRDA,0),"^",3)=1
 .S:LRSS="AU" $P(^LR(LRDFN,84,LRDA,0),"^",3)=1
 Q
STORE ;Second, store the original report
 S LRIENS2=LRORIEN(1)_","_LRIENS
 S LRWPROOT="^TMP(""DIQ1"",$J,LRFILE1,LRIENS,1)"
 D WP^DIE(LRFILE,LRIENS2,LRFIELD,"",LRWPROOT)
 K ^TMP("DIQ1",$J)
 Q
