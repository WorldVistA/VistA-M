GMRA5UTL ;HIRMFO/FT-Fix ART database due to GMRA*4*2 bug ;9/13/96  13:11
 ;;4.0;Adverse Reaction Tracking;**5**;Mar 29, 1996
 ;
 ; This routine is part of GMRA*4*5. GMRA*4*2 introduced a bug in
 ; the routine GMRAPEM0 which caused reactions that should have
 ; been autoverified from being marked as such.
 ;
EN1 ; This routine will:
 ; 1) Find & display reactions that have not been signed-off between
 ;    the installation of GMRA*4*2 and GMRA*4*5, and
 ; 2) Prompt the user to autoverify those reactions which will change
 ;    the ORIGINATOR SIGN OFF (#15), VERIFIED (#19) and VERIFICATION
 ;    DATE/TIME (#20) fields in File #120.8 to mimic autoverification.
 ;
 ; get patch #2 completion date/time(s)
 K ^TMP("DILIST",$J),GMRADT D CLEAN^DILF
 D LIST^DIC(9.7,"",17,"I","","","GMRA*4.0*2","","","","","")
 I '$D(^TMP("DILIST",$J,"ID")) W !,"GMRA*4.0*2 has not been installed on your system. Done." D KILL Q  ;quit if patch not found in Install file (#9.7)
 S GMRAIDT=0
 F  S GMRAIDT=$O(^TMP("DILIST",$J,"ID",GMRAIDT)) Q:GMRAIDT'>0  D
 .S GMRADT=+$G(^TMP("DILIST",$J,"ID",GMRAIDT,17))
 .I GMRADT>0 S GMRADT(GMRADT)="" ;array for #2 completion date/times
 .Q
 S GMRAIDT=$O(GMRADT("")) ;get earliest #2 completion date/time
 I GMRAIDT'>0 W !,"It does not appear that GMRA*4.0*2 was installed.",!,"Please contact your IRM Field Office Customer Support Representative." D KILL Q
 ; get GMRA*4*5 patch completion date/time(s)
 K ^TMP("DILIST",$J),GMRADT D CLEAN^DILF
 D LIST^DIC(9.7,"",17,"I","","","GMRA*4.0*5","","","","","")
 S GMRAENDT=0
 F  S GMRAENDT=$O(^TMP("DILIST",$J,"ID",GMRAENDT)) Q:GMRAENDT'>0  D
 .S GMRADT=+$G(^TMP("DILIST",$J,"ID",GMRAENDT,17))
 .I GMRADT>0 S GMRADT(GMRADT)="" ;array for #5 completion date/times
 .Q
 S GMRAENDT=$O(GMRADT("")) ;get earliest #5 completion date/time
 I GMRAENDT="" S GMRAENDT=$$NOW^XLFDT() ;use current date/time if #5 has no completion date/time ("bullet-proofing").
 ; display #2 completion date/time
 W !!,"GMRA*4.0*2 was installed on ",$$FMTE^XLFDT(GMRAIDT,1)
 ; get/display autoverify parameters
 W !!,"Your current AUTOVERIFY site parameters are:",!!
 S (GMRAUTO,GMRASITE)=0
 F  S GMRASITE=$O(^GMRD(120.84,GMRASITE)) Q:GMRASITE'>0  D
 .S GMRASITE(0)=$G(^GMRD(120.84,GMRASITE,0)) Q:GMRASITE(0)=""
 .W !,"           Site Parameter Name: ",$P(GMRASITE(0),U,1)
 .S X=$P(GMRASITE(0),U,2),GMRAUTO=GMRAUTO+X
 .W !,"    Autoverify Food/Drug/Other: "
 .W $S(X=0:"NO AUTOVERIFY",X=1:"AUTOVERIFY DRUG ONLY",X=2:"AUTOVERIFY FOOD ONLY",X=3:"AUTOVERIFY DRUG/FOOD",X=4:"AUTOVERIFY OTHER ONLY",X=5:"AUTOVERIFY DRUG/OTHER",X=6:"AUTOVERIFY FOOD/OTHER",X=7:"AUTOVERIFY ALL",1:"<none specified>")
 .S X=$P(GMRASITE(0),U,6)
 .W !,"   Autoverify Logical Operator: ",$S(X="!":"OR",X="&":"AND",1:"<none specified>")
 .S X=$P(GMRASITE(0),U,3),GMRAUTO=GMRAUTO+X
 .W !,"Autoverify Observed/Historical: ",$S(X=0:"NO AUTOVERIFY",X=1:"AUTOVERIFY HISTORICAL ONLY",X=2:"AUTOVERIFY OBSERVED ONLY",X=3:"AUTOVERIFY BOTH",1:"<none specified>"),!!
 K DIR,GMRASITE
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT) D KILL Q
 ; if autoverified is not used at all, ask user if he/she wants to
 ; continue since there shouldn't be any reactions to correct.
 I GMRAUTO=0 D  I $D(DIRUT)!(Y=1) D KILL Q
 .W !!
 .K DIR S DIR(0)="Y",DIR("A")="Want to stop (Y/N)",DIR("B")="YES"
 .S DIR("?")="Answer YES to continue or NO to halt."
 .S DIR("A",1)="Since your site does not autoverify any reactions you can halt now."
 .D ^DIR K DIR
 .Q
 W @IOF
 S GMRANOW=$$NOW^XLFDT(),(GMRACNT,GMRAIEN)=0 K GMRAOUT
 ; loop through unsigned reactions
 F  S GMRAIEN=$O(^GMR(120.8,"ASGN",GMRAIEN)) Q:GMRAIEN'>0  D  Q:$D(GMRAOUT)  ;quit if user up-arrows out
 .S GMRANODE=$G(^GMR(120.8,+GMRAIEN,0)) Q:GMRANODE=""
 .I $P(GMRANODE,U,4)]"" D
 ..S GMRAODT=$P(GMRANODE,U,4) ;origination date/time
 ..Q:GMRAODT'>GMRAIDT  ;quit if origination date/time before GMRA*4*2 installation
 ..Q:GMRAODT>GMRAENDT  ;quit if origination date/time after GMRA*4*5 installation
 ..S GMRACNT=GMRACNT+1
 ..S DIC="^GMR(120.8,",DA=GMRAIEN K DR D EN^DIQ ;display reaction data
 ..;prompt user to autoverify reaction
 ..W !! K DIR S DIR(0)="Y",DIR("A")="Autoverify this reaction (Y/N)"
 ..S DIR("?")="Answer YES to mark this reaction as autoverified or NO to leave it unchanged."
 ..S DIR("?",1)="Answering YES will change the ORIGINATOR SIGN OFF and VERIFIED fields to YES"
 ..S DIR("?",2)="and enter a date/time into the VERIFICATION DATE/TIME field (i.e., this will"
 ..S DIR("?",3)="mark the record as autoverified)."
 ..S DIR("?",4)=" "
 ..S DIR("?",5)="Answering NO will not change the record."
 ..S DIR("?",6)=" "
 ..D ^DIR K DIR I $D(DIRUT) S GMRAOUT=1 Q  ;quit if time-out/up-arrow
 ..;if yes change fields to mimic autoverified
 ..I Y=1 S DIE="^GMR(120.8,",DA=GMRAIEN,DR="15///1;19///1;20///"_GMRANOW D ^DIE
 ..Q
 .Q
 I GMRACNT=0 W !!,"No unsigned reactions were found for the time period between the",!,"installation of GMRA*4.0*2 and GMRA*4.0*5.",!!
KILL ; Kill variables
 K %,DA,DIC,DIE,DIR,DIROUT,DIRUT,DTOUT,DUOUT,DR,GMRACNT,GMRADT,GMRAENDT,GMRAIDT,GMRAIEN,GMRANODE,GMRANOW,GMRAODT,GMRAOUT,GMRAUTO
 K ^TMP("DILIST",$J) D CLEAN^DILF
 Q
