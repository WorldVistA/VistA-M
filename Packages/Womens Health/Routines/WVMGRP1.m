WVMGRP1 ;ISP/RFR - MANAGER'S PATIENT EDITS;Nov 09, 2018@14:45
 ;;1.0;WOMEN'S HEALTH;**24**;Sep 30, 1998;Build 582
 Q
DOCACT ;PROCESS DOCUMENT ACTIONS
 ;CALLED FROM PLSDATA^WVMGRP AND NOT INTENDED TO BE CALLED BY ANYTHING ELSE
 N WVITEM,WVITEMS,WVDATA,WVERRORS,WVNODE,WVERROR,DIR,X,Y,DTOUT,DUOUT,DIROUT
 N DIRUT,WVKEY,WVPNUM,WVTYPE,WVSTATUS
 F  D  Q:$G(WVSTATUS)=0
 .S WVSTATUS=$$ITEMS(.WVITEMS,.WVKEY,.WVPAT) I $G(WVITEMS)<1 S WVSTATUS=0 Q
 .S WVTYPE=$P(WVSTATUS,U,2),$P(WVTYPE,U,2)=$S(WVTYPE="VISIT":"C",WVTYPE="DOCUMENT":"D",1:"")
 .F  D  Q:$G(Y)<1
 ..I $G(WVITEMS)>1 D  Q:+Y=-1
 ...W !,"   Applicable "_$$TITLE^XLFSTR($P(WVTYPE,U))_"s:",!
 ...F WVITEM=1:1:WVITEMS  W $$LJ^XLFSTR(WVITEM,2)_" " F WVPNUM=1:1:$L(WVITEMS(WVKEY(WVITEM)),U) W $S(WVPNUM>1:"   ",1:"")_$P(WVITEMS(WVKEY(WVITEM)),U,WVPNUM),!
 ...S DIR(0)="N"_U_"1:"_WVITEMS_":0"_U_"K:'$D(WVKEY(X)) X",DIR("A")="  Select "_$P(WVTYPE,U)
 ...S DIR("?")="Enter the number to the left of the "_$$LOW^XLFSTR($P(WVTYPE,U))_" you want to work with."
 ...D ^DIR
 ...I '$D(WVKEY(+Y)) S Y=-1 Q
 ...S WVITEM=WVKEY(+Y)
 ...W "  "_$$STRIP^XLFSTR(WVITEMS(WVITEM),U),!
 ..I $G(WVITEMS)=1 D
 ...S WVITEM=$O(WVITEMS(0))
 ...W !,"   "_$P(WVTYPE,U)_": "
 ...F WVPNUM=1:1:$L(WVITEMS(WVITEM),U) W $P(WVITEMS(WVITEM),U,WVPNUM),!
 ..I $G(WVITEMS)<1 S Y=-2 Q
 ..N WVFIRST,WVRESULT,WVACTION S WVFIRST=1
 ..S WVNODE=0 F  S WVNODE=$O(WVITEMS(WVITEM,WVNODE)) Q:'+WVNODE!($G(WVERROR))  D
 ...N WVCNT,WVRECID,WVRTACTS,WVFDA,WVCHAIN,WVCNUM,WVPSA,WVHELP,WVTXTA,WVTEXT
 ...I WVFIRST W !,"   L" S WVFIRST=0
 ...E  W @IOF,"   Now l"
 ...W "et's work with the "_$S(WVNODE=4:"pregnancy",1:"lactation")_" status.",!
 ...S WVRECID=$O(WVITEMS(WVITEM,WVNODE,0))
 ...I WVRECID<1 S WVERROR=$$ERROR^WVMGRP("determining the review record ID",,"There is a problem with the D cross-reference on the^WV DATA NEEDING REVIEW file.") Q
 ...I $G(WVACTION)'="" D  Q:$G(WVERROR)!($G(WVPSA))
 ....S WVTEXT="   You previously "_$S($P(WVACTION,U,2)=1:"moved",1:"marked as entered in error")
 ....S WVTEXT=WVTEXT_" the "_$S($P(WVACTION,U)=4:"pregnancy",1:"lactation")_" status data"
 ....I $P(WVACTION,U,2)=1 S WVTEXT=WVTEXT_" from "_WVPAT("NAME")_" to "_$P(WVACTION,U,3)
 ....S WVTEXT=WVTEXT_"."
 ....D WRAP^ORUTL(WVTEXT,"WVTXTA",,,3,.WVCNT)
 ....S WVCNT=0 F  S WVCNT=$O(WVTXTA(WVCNT)) Q:'+WVCNT  W !,WVTXTA(WVCNT)
 ....S WVERROR=$$SHODATA Q:WVERROR=-1
 ....I WVERROR=2 D  Q
 .....W !,"  There is no longer any "_$S(WVNODE=4:"pregnancy",1:"lactation")_" status data associated with this review"
 .....W !,"  record and therefore, it will be ignored." H 5
 .....S WVERROR=$$CROOTREC(WVRECID)
 ....K WVERROR
 ....S DIR(0)="Y"_U,DIR("A")="Do you want to perform the same action on the "_$S(WVNODE=4:"pregnancy",1:"lactation")_" status"
 ....S WVTEXT=$E(WVTEXT,4,$L(WVTEXT))_" Review "_WVPAT("NAME")_"'s chart using CPRS to determine if the "_$S(WVNODE=4:"pregnancy",1:"lactation")_" status displayed "
 ....S WVTEXT=WVTEXT_"above is still valid for "_WVPAT("NAME")_". If the status is still valid, enter "
 ....S WVTEXT=WVTEXT_"'N' for no (you do not want to mark the status as entered in error). If the "
 ....S WVTEXT=WVTEXT_"status is no longer valid, enter 'Y' for yes (you do want to mark the status "
 ....S WVTEXT=WVTEXT_"as entered in error)."
 ....D WRAP^ORUTL(WVTEXT,"WVHELP",0,,,.WVCNT)
 ....M DIR("?")=WVHELP S DIR("?")=DIR("?",WVCNT) K DIR("?",WVCNT)
 ....D ^DIR
 ....I $D(DIRUT)!($D(DIROUT)) S WVERROR=1 Q
 ....S WVPSA=+Y,WVRECID=+$O(^WV(790.8,WVRECID,1,0))_","_WVRECID_","
 ....S WVRESULT=$S(WVPSA:$$PACT^WVMGRP2(WVNODE,$P(WVACTION,U,2),WVRECID,$P(WVACTION,U,4),$P(WVACTION,U,5),$P(WVACTION,U,6),$P(WVACTION,U,7),$P(WVACTION,U,3)),1:$$CROOTREC($P(WVRECID,",",2)))
 ....I WVRESULT=-1 S WVERROR=-1 Q
 ...S WVRTACTS=0 F  S WVRTACTS=$O(^WV(790.8,WVRECID,1,"AC",1,WVRTACTS)) Q:'+WVRTACTS!($G(WVERROR))  D
 ....S WVCNT=1+$G(WVCNT),WVRTACTS("B",WVCNT)=WVRTACTS_","_WVRECID_",",WVRTACTS("B")=WVCNT
 ....D GETS^DIQ(790.801,WVRTACTS("B",WVCNT),".01;2",,"WVDATA","WVERRORS")
 ....I $D(WVERRORS) S WVERROR=$$ERROR^WVMGRP("retrieving root-level activities",.WVERRORS) Q
 ....S WVRTACTS(WVRTACTS_","_WVRECID_",")=WVDATA(790.801,WVRTACTS("B",WVCNT),2)_" on "_WVDATA(790.801,WVRTACTS("B",WVCNT),.01)
 ...I '$D(WVRTACTS) S WVERROR=$$ERROR^WVMGRP("retrieving root-level activities",,"No root-level activities were found.")  Q
 ...F  Q:'$D(WVRTACTS("B"))!($G(WVERROR))  D
 ....I WVRTACTS("B")>1 D  Q:$G(WVERROR)
 .....W !,"   The following relevant actions were taken:",!!
 .....S WVCNT=0 F  S WVCNT=$O(WVRTACTS("B",WVCNT)) Q:'+WVCNT  W ?5,$$RJ^XLFSTR(WVCNT," ",3),?11,WVRTACTS(WVRTACTS("B",WVCNT)),!
 .....S DIR(0)="N"_U_U_"K:'$D(WVRTACTS(""B"",X)) X",DIR("A")="Select an action to review"
 .....S DIR("?")="Enter the number to the left of the action you want to work with."
 .....D ^DIR
 .....I $D(DIRUT)!($D(DIROUT)) S WVERROR=1 Q
 .....K DIR
 .....S WVRTACTS=WVRTACTS("B",Y)_U_Y
 .....W ?40,WVRTACTS(WVRTACTS("B",Y))
 ....I WVRTACTS("B")<2 S Y=$O(WVRTACTS("B",0)),WVRTACTS=WVRTACTS("B",Y)_U_Y
 ....S WVRESULT=$$BRANCH($P(WVRTACTS,U),.WVACTION)
 ....I $G(WVACTION)'="" S WVACTION=WVNODE_U_WVACTION
 ....I WVRESULT=-1 S WVERROR=-1 Q
 ....I WVRESULT=0 D
 .....F WVCNUM=1:1:$L(WVCHAIN,U) S WVFDA(790.801,$P(WVCHAIN,U,WVCNUM),.01)="@"
 .....D FILE^DIE("","WVFDA","WVERRORS")
 .....I $D(WVERRORS) S WVERROR=$$ERROR^WVMGRP("deleting root activity chain",.WVERRORS) Q
 .....I $O(^WV(790.8,WVRECID,1,0))="" S WVRESULT=$$CROOTREC(WVRECID) S:WVRESULT<1 WVERROR=-1 Q:$G(WVERROR)=-1
 .....K WVRTACTS($P(WVRTACTS,U)),WVRTACTS("B",$P(WVRTACTS,U,2)),WVCHAIN
 .....I $O(WVRTACTS("B",""))="" K WVRTACTS("B")
 .....E  S WVRTACTS("B")=WVRTACTS("B")-1
 .....W !
 ..K WVITEMS(WVITEM),WVKEY
 ..S WVITEMS=WVITEMS-1
 ..I WVITEMS>0 S Y=1
 ..Q:WVITEMS<2
 ..S WVITEM=0 F  S WVITEM=$O(WVITEMS(WVITEM)) Q:WVITEM=""  S WVKEY=1+$G(WVKEY),WVKEY(WVKEY)=WVITEM
 Q
 ;
VISITS(WVVISITS,WVKEY,WVVISIT) ;RETRIEVE SPECIFIED VISIT
 N WVDATA,WVERRORS,WVRETURN
 S WVRETURN=1
 D GETS^DIQ(9000010,WVVISIT_",",".01;.22;15001","","WVDATA","WVERRORS")
 I $D(WVERRORS),'$D(WVERRORS("DIERR","E",601)) S WVRETURN=$$ERROR^WVMGRP("retrieving available visits",.WVERRORS) Q
 S WVVISITS=1+WVVISITS
 I $D(WVERRORS("DIERR","E",601)) D
 .S WVVISITS(WVVISIT)="#"_WVVISIT_" no longer exists."_U_U_U
 .K WVERRORS
 I $D(WVDATA) D
 .S WVVISITS(WVVISIT)=$$RJ^XLFSTR(WVDATA(9000010,WVVISIT_",",.01),23)
 .S WVVISITS(WVVISIT)=WVVISITS(WVVISIT)_U_$$RJ^XLFSTR($E(WVDATA(9000010,WVVISIT_",",.22),1,13),13)
 .S WVVISITS(WVVISIT)=WVVISITS(WVVISIT)_U_$$REPEAT^XLFSTR(" ",10)_$$RJ^XLFSTR($E(WVDATA(9000010,WVVISIT_",",15001),1,12),12)
 S WVKEY(WVVISITS)=WVVISIT
 Q WVRETURN
DOCS(WVDOCS,WVKEY,WVDOC) ;RETRIEVE SPECIFIED DOCUMENT
 N WVDATA,WVERRORS,WVRETURN
 S WVRETURN=1
 D GETS^DIQ(8925,WVDOC_",",".01;1201;1202","","WVDATA","WVERRORS")
 I $D(WVERRORS) S WVRETURN=$$ERROR^WVMGRP("retrieving available documents",.WVERRORS) Q
 S WVDOCS=1+WVDOCS
 S WVDOCS(WVDOC)=$$LJ^XLFSTR(WVDATA(8925,WVDOC_",",1201),23)_$E(WVDATA(8925,WVDOC_",",.01),1,60)
 S WVDOCS(WVDOC)=WVDOCS(WVDOC)_U_"  "_$E(WVDATA(8925,WVDOC_",",1202),1,78)
 S WVKEY(WVDOCS)=WVDOC
 Q WVRETURN
ITEMS(WVITEMS,WVKEY,WVPAT) ;RETRIEVE EITHER DOCUMENTS OR VISITS FOR A PATIENT
 N WVRETURN,WVITEM,WVINDEX
 S WVINDEX=$S($D(^WV(790.8,"E",WVPAT))>9:"E",1:"D"),WVRETURN=1_U,WVITEMS=0
 S WVITEM=0 F  S WVITEM=$O(^WV(790.8,WVINDEX,WVPAT,WVITEM)) Q:'+WVITEM!($G(WVRETURN)=-1)  D
 .I WVINDEX="D" S WVRETURN=$$VISITS(.WVITEMS,.WVKEY,WVITEM)
 .I WVINDEX="E" S WVRETURN=$$DOCS(.WVITEMS,.WVKEY,WVITEM)
 .M WVITEMS(WVITEM)=^WV(790.8,WVINDEX,WVPAT,WVITEM)
 I WVITEMS>0 S $P(WVRETURN,U,2)=$S(WVINDEX="E":"DOCUMENT",1:"VISIT")
 Q WVRETURN
BRANCH(WVIEN,WVACT) ;PROCESS A BRANCH OF ACTIVITIES (DO NOT USE OUTSIDE OF THIS ROUTINE)
 N WVRESULT,WVPIECE,WVAIEN
 S WVCHAIN=WVIEN_$S($G(WVCHAIN)'="":U_WVCHAIN,1:""),WVRESULT=$$ACTIVTY(WVIEN)
 I $P(WVRESULT,U)>0 D
 .;TAKE ACTION
 .S WVACT=WVRESULT,WVRESULT=$$PACT^WVMGRP2(WVNODE,$P(WVACT,U),WVIEN,$P(WVACT,U,3),$P(WVACT,U,4))
 I WVRESULT=0 D
 .;GO TO NEXT ACTIVITY IN CHAIN
 .F WVPIECE=1:1:($L(WVIEN,",")-1) S WVAIEN(WVPIECE)=$P(WVIEN,",",WVPIECE)
 .S WVAIEN=0 F  S WVAIEN=$O(^WV(790.8,WVAIEN(2),1,WVAIEN(1),2,WVAIEN)) Q:'+WVAIEN!($G(WVRESULT)>0)  D
 ..S WVRESULT=$$BRANCH($P($G(^WV(790.8,WVAIEN(2),1,WVAIEN(1),2,WVAIEN,0)),U)_","_WVAIEN(2)_",",.WVACT)
 Q WVRESULT
 ;
ACTIVTY(WVIEN) ;PROCESS AN ACTIVITY (DO NOT USE OUTSIDE OF THIS ROUTINE)
 ; INPUT: WVIEN: IEN OF THE CURRENT ACTIVITY [REQUIRED]
 ; OUTPUT: $$ACTIVTY: WHAT THE USER WANTS TO DO
 ;                    1 TO REASSIGN, 2 TO MARK ENTERED IN ERROR, 0 TO TAKE NO ACTION, -1 TO QUIT
 N WVDATA,WVMSG,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,WVPT,WVRET,WVHELP,WVCNT,WVTEXT,WVRESULT,WVFDA,WVERRORS
 D GETS^DIQ(790.801,WVIEN,"*","IE","WVDATA","WVMSG")
 I $D(WVMSG) Q $$ERROR^WVMGRP("retrieving activity #"_WVIEN,.WVMSG)
 S WVRESULT=$$SHODATA
 Q:WVRESULT=-1 -1
 W !,"   Activity Detail:",!,"ACTIVITY DATE/TIME: ",WVDATA(790.801,WVIEN,.01,"E"),!,?2,"ACTION: ",WVDATA(790.801,WVIEN,3,"E"),!
 W ?2,"DOCUMENT NAME (IEN): ",WVDATA(790.801,WVIEN,2,"E"),!
 I WVDATA(790.801,WVIEN,3,"E")="REASSIGN" S WVPT=WVDATA(790.801,WVIEN,11,"E") W ?2,"NEW PATIENT: ",WVPT,?40,"NEW VISIT: ",WVDATA(790.801,WVIEN,12,"E"),!
 E  S WVPT=WVPAT("NAME")
 I WVRESULT=2 D  Q 0
 .W !,"  There is no longer any status data associated with this review",!,"  record and therefore, it will be ignored." H 5
 W !,"   Please review the chart for "_WVPT_".",!,"Press ENTER to continue: "
 R X:DTIME W !
 I WVDATA(790.801,WVIEN,3,"E")="REASSIGN" D
 .S DIR("A",1)="Do you want to move the "_$S(WVNODE=4:"pregnancy",1:"lactation")_" status data",DIR("A")="from "_WVPAT("NAME")_" to "_WVDATA(790.801,WVIEN,11,"E")
 .S WVRET=1_U_WVDATA(790.801,WVIEN,11,"E")_U_WVDATA(790.801,WVIEN,11,"I")_U_WVDATA(790.801,WVIEN,12,"I")_U_WVDATA(790.801,WVIEN,3,"E")_U_WVDATA(790.801,WVIEN,2,"E")_U_WVDATA(790.801,WVIEN,12,"E")
 .S WVCNT=0
 .S WVTEXT="Review both patients' charts using CPRS to determine which patient "
 .S WVTEXT=WVTEXT_"("_WVPAT("NAME")_" or "_WVPT_") the status displayed above is valid for. "
 .S WVTEXT=WVTEXT_"If the status is still valid for "_WVPAT("NAME")_", enter 'N' for no (you do "
 .S WVTEXT=WVTEXT_"not want to move the status data to "_WVPT_"). If the status is valid for "
 .S WVTEXT=WVTEXT_WVPT_", enter 'Y' for yes (you do want to move the status data to "_WVPT_")."
 .D WRAP^ORUTL(WVTEXT,"WVHELP",0,,,.WVCNT)
 .M DIR("?")=WVHELP S DIR("?")=DIR("?",WVCNT) K DIR("?",WVCNT)
 I WVDATA(790.801,WVIEN,3,"E")'="REASSIGN" D
 .S DIR("A",1)="Do you want to mark the "_$S(WVNODE=4:"pregnancy",1:"lactation")_" status data",DIR("A")="for "_WVPAT("NAME")_" as entered in error"
 .S WVRET=2_U_U_U_U_WVDATA(790.801,WVIEN,3,"E")_U_WVDATA(790.801,WVIEN,2,"E")_U
 .S WVCNT=0
 .S WVTEXT="Review "_WVPT_"'s chart using CPRS to determine if the status displayed "
 .S WVTEXT=WVTEXT_"above is still valid for "_WVPT_". If the status is still valid, enter "
 .S WVTEXT=WVTEXT_"'N' for no (you do not want to mark the status as entered in error). If the "
 .S WVTEXT=WVTEXT_"status is no longer valid, enter 'Y' for yes (you do want to mark the status "
 .S WVTEXT=WVTEXT_"as entered in error)."
 .D WRAP^ORUTL(WVTEXT,"WVHELP",0,,,.WVCNT)
 .M DIR("?")=WVHELP S DIR("?")=DIR("?",WVCNT) K DIR("?",WVCNT)
 S DIR(0)="Y"_U
 D ^DIR
 I $D(DIRUT)!($D(DIROUT)) Q -1
 Q $S(+Y=1:WVRET,1:0)
 ;
SHODATA() ;DISPLAY STATUS DATA
 N DIC,DA,DR,DIQ,WVERROR,WVMSG,WVENTRIS
 I $G(WVTYPE)'="" D  Q:$D(WVENTRIS)<10 2
 .S DA=0 F  S DA=$O(^WV(790,WVPAT,WVNODE,$P(WVTYPE,U,2),WVITEM,DA)) Q:'+DA  S WVENTRIS(DA)=""
 I $G(WVTYPE)="",$P(WVENTS(WVNODE,WVENTS("Y")),U)'="" S WVENTRIS($P(WVENTS(WVNODE,WVENTS("Y")),U))=""
 I $D(WVENTRIS)<10 D  Q WVERROR
 .S WVMSG="There is an unknown problem with the selected status data."
 .S WVERROR=$$ERROR^WVMGRP("displaying status data",,WVMSG)
 S DIC="^WV(790,"_WVPAT_","_WVNODE_",",DA(1)=WVPAT
 W !!,"   Status Data ("_WVPAT("NAME")_"):"
 S DA=0 F  S DA=$O(WVENTRIS(DA)) Q:'+DA  D EN^DIQ
 Q 1
 ;
CROOTREC(WVIEN) ;DELETE FILE #790.8 ENTRY
 N WVFDA,WVERRORS,WVERROR
 S WVFDA(790.8,WVIEN_",",.01)="@",WVERROR=1
 D FILE^DIE("","WVFDA","WVERRORS")
 I $D(WVERRORS) S WVERROR=$$ERROR^WVMGRP("deleting patient's review record",.WVERRORS)
 Q WVERROR
 ;
