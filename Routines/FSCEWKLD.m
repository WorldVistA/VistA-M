FSCEWKLD ;SLC/STAFF-NOIS Edit Workload ;9/6/98  20:42
 ;;1.1;NOIS;;Sep 06, 1998
 ;
WKLD(CALL,CHECK) ; from FSCEL, FSCEN, FSCLMPE1, FSCLMPES
 I '$$ACCESS^FSCU(DUZ,"SPEC") Q  ;I '$D(^FSC("SPEC",DUZ,0)) Q
 Q:'$D(^FSCD("CALL",CALL,0))  Q:$P(^(0),U,2)=99
 I $G(CHECK),'$$WKLD^FSCEUD(DUZ) Q
 N DATE,HRS,OK,OLDHRS
 W !!,"Workload Time"
 D DATE(CALL,.DATE,.OK) I 'OK Q
 S (OLDHRS,HRS)=$$HCUD^FSCWKLD(CALL,DUZ,DATE)
 D HRS(CALL,DATE,.HRS,.OK) I 'OK Q
 I HRS D UPDATE(CALL,HRS,DATE,DUZ)
 Q
 ;
DATE(CALL,DATE,OK) ;
 N CDATE,DIR,RDATE,WEDATE,X,Y K DIR
 S OK=1
 S RDATE=$P($G(^FSCD("CALL",CALL,0)),U,3)
 I 'RDATE S OK=0 Q
 S CDATE=$P($G(^FSCD("CALL",CALL,0)),U,4)
 I 'CDATE S CDATE=DT
 S WEDATE=$$WEDATE^FSCUP
 I WEDATE,RDATE>WEDATE S RDATE=WEDATE
 I RDATE>CDATE W !,"Unable to edit workload for this call",$C(7) S OK=0 Q
 S DIR(0)="DA^"_RDATE_":"_CDATE_":EX",DIR("A")="Date of action: ",DIR("B")="TODAY"
 S DIR("?",1)="Enter the date for this particular action."
 S DIR("?",2)="Date must be from "_$$FMTE^XLFDT(RDATE)_" to "_$$FMTE^XLFDT(CDATE)_"."
 S DIR("?",3)="Date must be from when call was open to closed and cannot"
 S DIR("?",4)="be before T-"_+$P($G(^FSC("PARAM",1,0)),U,10)_"."
 S DIR("?")="^D HELP^%DTC,HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) S OK=0 Q
 S DATE=Y
 Q
 ;
HRS(CALL,DATE,HRS,OK) ;
 N DIR,HC,HUC,HUD,HIGHHRS,LOWHRS,X,Y K DIR
 S OK=1
 S HC=$$HC^FSCWKLD(CALL),HUC=$$HUC^FSCWKLD(DUZ,CALL),HUD=$$HUD^FSCWKLD(DUZ,DATE)
 I HUD W !,"Your hours on all calls for this date is ",HUD,"."
 I HC W !,"Total hours on this call is ",HC,"."
 I HUC W !,"Your hours on this call is ",HUC," (Total)" I $L(HRS) W ", ",HRS," (",$$FMTE^XLFDT(DATE),")."
 S HIGHHRS=24-HUD
 S LOWHRS=-HRS
 S DIR(0)="NAO^"_LOWHRS_":"_HIGHHRS_":2",DIR("A")="Enter any changes for this date:  "
 S DIR("?",1)="Enter changes to time on this call for this date."
 S DIR("?",2)="Enter a number ("_LOWHRS_" to "_HIGHHRS_") with no more than 2 decimal places."
 S DIR("?",3)="This time is added to hours spent on the call for "_$$FMTE^XLFDT(DATE)_"."
 S DIR("?",4)="Enter '^' to exit without making a note or '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT),Y'="" S OK=0 Q
 S HRS=Y
 Q
 ;
UPDATE(CALL,HRS,DATE,USER) ; from FSCRPCEB, FSCRPCEW
 Q:'$G(CALL)  Q:'$G(HRS)  Q:'$G(DATE)  Q:'$G(USER)
 N DA,DATA,DIK,INVALID,NUM,OK,WKLD
 S INVALID=$S($P(^FSCD("CALL",CALL,0),U,2)=11:1,1:"")
 S WKLD=$G(^FSCD("WKLD","AK",CALL,USER,DATE))
 I 'WKLD S OK=1 D  I 'OK Q
 .S DATA=CALL_U_USER_U_DATE_U_HRS_U_INVALID
 .S NUM=1+$P(^FSCD("WKLD",0),U,3)
 .L +^FSCD("WKLD",0):30 I '$T S OK=0 Q  ; needs ok
 .F  Q:'$D(^FSCD("WKLD",NUM,0))  S NUM=NUM+1
 .S ^FSCD("WKLD",NUM,0)=DATA
 .S $P(^FSCD("WKLD",0),U,3)=NUM,$P(^(0),U,4)=$P(^(0),U,4)+1
 .L -^FSCD("WKLD",0)
 .S DIK="^FSCD(""WKLD"",",DA=NUM D IX1^DIK
 I WKLD D
 .S $P(^(0),U,4)=$P(^FSCD("WKLD",WKLD,0),U,4)+HRS
 ;S $P(^FSCD("CALL",CALL,0),U,13)=$$HC^FSCWKLD(CALL)
 D TOTHRS(CALL,$$HC^FSCWKLD(CALL))
 Q
 ;
GOODWKLD(CALL) ; from FSCLMPES
 I '$D(^FSCD("CALL",CALL,0)) Q
 N TOTHRS,WKLD
 S (TOTHRS,WKLD)=0 F  S WKLD=$O(^FSCD("WKLD","B",CALL,WKLD)) Q:WKLD<1  D
 .I $D(^FSCD("WKLD",WKLD,0)) S $P(^(0),U,5)="",TOTHRS=TOTHRS+$P(^(0),U,4)
 ;S $P(^FSCD("CALL",CALL,0),U,13)=TOTHRS
 D TOTHRS(CALL,TOTHRS)
 Q
 ;
BADWKLD(CALL) ; from FSCLMPES
 I '$D(^FSCD("CALL",CALL,0)) Q
 N WKLD
 S WKLD=0 F  S WKLD=$O(^FSCD("WKLD","B",CALL,WKLD)) Q:WKLD<1  D
 .I $D(^FSCD("WKLD",WKLD,0)) S $P(^(0),U,5)=1
 ;S $P(^FSCD("CALL",CALL,0),U,13)=0
 D TOTHRS(CALL,0)
 Q
 ;
TOTHRS(DA,HRS) ;
 N DR,DIE,X,Y
 S DIE="^FSCD(""CALL"","
 S DR="20///"_HRS
 D ^DIE
 Q
