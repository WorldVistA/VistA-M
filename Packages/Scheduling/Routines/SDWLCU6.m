SDWLCU6 ;IOFO BAY PINES/DMR - EWL FILE 409.3 CLEANUP - print ;2/15/05
 ;;5.3;scheduling;**427,491,539**;AUG 13 1993;Build 24
 N XFL,XFL1,XFLG,XDATA,END,SDWLAPTD,I,J,SDWLPD,SDWLPG,SDWLWD,SDWLTP,SDWLTP1,CC
 N IEN,PAT,SDWLDTP S (IEN,PAT)="",(CC,SDWLPG,SDWLTP)=0,U="^",END=""
 D NOW^%DTC S Y=% D DD^%DT S SDWLDTP=Y
 D HD
 F  S PAT=$O(^SDWL(409.3,"B",PAT)) Q:PAT=""  D
 .S IEN="" F  S IEN=$O(^SDWL(409.3,"B",PAT,IEN)) Q:IEN=""  D
 ..I '$D(^SDWL(409.3,IEN,0)) K ^SDWL(409.3,"B",PAT,IEN) L -^SDWL(409.3,IEN) Q  ;SD/539
 ..N SDWLX S SDWLX=$G(^SDWL(409.3,IEN,0)) N SDCS S SDCS=$P(SDWLX,U,17)
 ..I SDCS="C" Q  ; do not evaluate closed entries
 ..I DT'>$P(SDWLX,U,2),SDCS="" Q  ; do not evaluate partially entered on the run date
 ..;evaluate CURRENT STATUS and if NULL close it
 ..I DT>$P(SDWLX,U,2),SDCS="" D  Q  ; this entry will be closed; ignore it
 ...N SDWLDISP,DA,DIE,DR S SDWLDISP="ER" ; NOT TO BE OPENED 
 ...S DIE="^SDWL(409.3,",DA=IEN,DR="21////^S X=SDWLDISP" D ^DIE
 ...S DR="19////^S X=DT" D ^DIE
 ...S DR="20////^S X=.5" D ^DIE
 ...S DR="18////^S X=""Incomplete entry""" D ^DIE
 ...S DR="23////^S X=""C""" D ^DIE
 ..S XFLG="",XFL=1,SDWLWD="",SDWLTP1=""
 ..F I=3,5,XFL S XDATA=$P(SDWLX,U,I) S:I=5&XDATA XFL=XDATA+5 S:'XDATA XFLG=XFLG_I I I=5,XFL=1 D FIX
 ..I XFLG D
 ...N NN,NAME
 ...D HD:$Y+5>IOSL Q:END
 ...S NN="",NAME="" S NN=$P($G(^SDWL(409.3,IEN,0)),"^",1),NAME=$$GET1^DIQ(2,NN_",",.01,"E")
 ...S SDWLAPTD=$P(SDWLX,U,16) I SDWLAPTD'="" S Y=SDWLAPTD D DD^%DT S SDWLAPTD=Y
 ...W !!,IEN,?6,NAME,?40,SDWLAPTD,?54,$P(SDWLX,U,17),?58
 ...S XFL="" F I=1:1:3 Q:$E(XFLG,I)=""  S XFL=XFL_$S(XFL'="":",",1:"")_$P("::INST::Type:Team:Postn:Srv/Spec:Clinic",":",$E(XFLG,I))
 ...W XFL W:SDWLTP1'="" "/++"
 ...W:SDWLWD'="" !,?5,SDWLWD
 ...S CC=CC+1
 Q:END
 IF CC>.5 W !!,"TOTAL null field error EWL entries: "_CC
 I SDWLTP>.5 W !!,"++ Missing Wait List Type and corresponding field entry (TEAM,POSITION,",!,"     SERVICE/SPECIALTY,CLINIC). Correct corresponding field entries",!,"     and running report again will correct Wait List Type field"
 D CLINIC
 W !!,"** End of Report **"
 Q
CLINIC ;Display all clinics in file 409.32 that need to be cleaned up in file 44 in mail message
 N CLINIC,INST,CC S INST="",CLINIC=0,CC=0
 F  S CLINIC=$O(^SDWL(409.32,CLINIC)) Q:'CLINIC  D
 . N CL,INSTST S CL=+$G(^SDWL(409.32,CLINIC,0)) Q:CL'>0
 . S INSTST=$$CLIN^SDWLPE(CL)
 . I $P(INSTST,U,6)'="" W !,*7,$P(INSTST,U,6) D 
 .. S CC=CC+1
 .. I CC=1 W !!!,"The following clinics need to have the institution updated in file 44:",!!
 .. W !,?20,$$GET1^DIQ(44,+$G(^SDWL(409.32,CLINIC,0))_",",.01)
 Q
FIX ;fix corrupted Wait List Type piece 5
 S XFL1=0,SDWLTP1=""
 F J=6:1:9 S XDATA=$P(SDWLX,U,J) S:XDATA'="" XFL1=J
 I 'XFL1 S SDWLTP=SDWLTP+1,SDWLTP1="++" Q
 I XFL'=1,XFL=XFL1 Q
 S $P(SDWLX,U,5)=XFL1-5,XFL=XFL1,^SDWL(409.3,IEN,0)=SDWLX
 S SDWLWD="** WAIT LIST TYPE corrected to value: "_(XFL1-5)_" ("_$P("TEAM;POSITION;SERV/SPCLTY;CLINIC",";",XFL1-5)_")"
 Q
HD ;HDR
 I SDWLPG>0,$E(IOST,1,2)="C-" S END=$$EOP() Q:END
 S SDWLPG=SDWLPG+1 W:SDWLPG'=1 @IOF
 S Y=DT D DD^%DT S SDWLPD=Y W ?57,SDWLPD,?72,"Page: ",SDWLPG
 W !,?10,"Wait List Key Field 'NULL' Report for OPEN EWL entries."
 W !!,"STATION: "_+$$SITE^VASITE(,)
 W !!,"IEN   Patient Name",?42,"Wait Date",?53,"STS",?58,"Null Fields"
 Q
EOP() ;end of page check - return 1 to quit, 0 to continue
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 I $E(IOST,1,2)'="C-" Q 0  ; not to terminal
 F  Q:($Y>(IOSL-2))  W !
 S DIR(0)="E"
 D ^DIR
 Q 'Y
