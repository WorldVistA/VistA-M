XUEPCSRT ;FO-OAKAND/REM - EPCS Utilities and Reports; [5/7/02 5:53am] ;08/06/2012
 ;;8.0;KERNEL;**580**;Jul 10, 1995;Build 46
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;
 Q
 ;
PRESCBR(XUSD0) ;called from print option - XU EPCS PRIVS
 ;XUSD0 is D0
 ; screening for prescribers with DEA# or VA#
 N XUSPS
 S XUSPS=$G(^VA(200,XUSD0,"PS"))
 Q:($P(XUSPS,U,2)'="")!($P(XUSPS,U,3)'="") 1
 Q 0
 ;
PRIVS(XUSD0) ;called from print option - XU EPCS PRIVS 
 ;XUSD0 is D0
 ;user with controlled substance privileges? 
 ;based on 6 sub-schedules, PS3 node, pieces 1-6
 N XUSPS3
 S XUSPS3=$G(^VA(200,XUSD0,"PS3"))
 Q:($P(XUSPS3,U,1,6)[1) 1 ; yes, if at least one explicit Yes
 Q:($P(XUSPS3,U,1,6)[0) 0 ; no, if explicit No
 Q 1 ; default, when all NULL
 ;
XT30(XUSD0,ACT) ;called from print option - XU EPCS XDATE EXPIRES
 ;chk user ACTIVE,with DEA# and xdate expires in 30 days
 ;XUSD0=IEN, ACT=(1 or 0) active user of not
 N XDT,DT30,DEA,CNT
 S CNT=0
 S XDT=$P($G(^VA(200,XUSD0,"QAR")),U,9),DT30=$$FMADD^XLFDT(DT,30),DEA=$P($G(^VA(200,XUSD0,"PS")),U,2)
 I (DEA'=""),(XDT'>DT30),(XDT'<DT) S CNT=CNT+1
 I ACT D
 .I $$ACTIVE^XUSER(XUSD0) S CNT=CNT+1
 I 'ACT D
 .I '$$ACTIVE^XUSER(XUSD0) S CNT=CNT+1
 I CNT=2 Q 1
 Q 0
 ;
RPT1 ;ePCS report - setting or modifing to logical access controls.
 ;called from option - XU EPCS LOGICAL ACCESS
 ;Only runs if data has changed from previous day.
 ;FLG=records exist for previous day.
 N X,DEV,X1,X2,YT,%,FLG
 S (FLG,%)=0
 D NOW^%DTC S X1=X,X2="-1" D C^%DTC S YT=X ;Get the previous day date
 S %=0 F  S %=$O(^XTV(8991.6,"DT",%)) Q:%=""!(FLG=1)  D
 .S:YT=$P($G(%),".",1) FLG=1
 Q:FLG=0
 S DEV=$$GET^XPAR("SYS","XUEPCS REPORT DEVICE",1,"E")
 I DEV="" W !!,"DEVICE NOT DEFINED!  Set the parameter XUEPCS REPORT DEVICE." Q
 S IOP=DEV
 S DISUPNO=1
 K DIC
 S DIC="^XTV(8991.6,",FLDS="[XU EPCS LOGICAL ACCESS PRINT]",BY="@DATE/TIME EDITED",(FR,TO)=YT,L=0
 D EN1^DIP
 Q
 ;
RPT2 ;ePCS report - allocation history for PSDRPH key
 ;called from option - XU EPCS PSDRPH AUDIT
 ;Only runs if data has changed from previous day.
 ;FLG=records exist for previous day
 N X,DEV,X1,X2,YT,%,FLG
 S (FLG,%)=0
 D NOW^%DTC S X1=X,X2="-1" D C^%DTC S YT=X ;Get the previous day date
 S %=0 F  S %=$O(^XTV(8991.7,"DT",%)) Q:%=""!(FLG=1)  D
 .S:YT=$P($G(%),".",1) FLG=1
 Q:FLG=0
 S DEV=$$GET^XPAR("SYS","XUEPCS REPORT DEVICE",1,"E")
 I DEV="" W !!,"DEVICE NOT DEFINED!  Set the parameter XUEPCS REPORT DEVICE." Q
 S IOP=DEV
 S DISUPNO=1
 ;D NOW^%DTC S X1=X,X2="-1" D C^%DTC S YT=X ;Get the previous day date
 K DIC
 S DIC="^XTV(8991.7,",FLDS="[XU EPCS PSDRPH KEY PRINT]",BY="@DATE/TIME EDITED",(FR,TO)=YT,L=0
 D EN1^DIP
 Q
 ;
PSDKEY ;Allocated/de-allocate the PSDRPH key option
 ;called from option - XU EPCS PSDRPH KEY
 N XUBOSS,XUDA,XUKEY,XURET,XUNAME,ZZ,OK,NOW,IEN,MSG,INPUT,NOW
 S XUBOSS=0 S:(DUZ(0)["@"!($D(^XUSEC("XUMGR",DUZ)))) XUBOSS=1
 I 'XUBOSS W !,"You don't have privileges.  See your package coordinator or site manager." Q
 S XUKEY=$$LKUP^XPDKEY("PSDRPH") I XUKEY="" W !,"PSDRPH key does not exist" Q
 K DIC S DIC="^VA(200,",DIC(0)="AEMQZ",DIC("A")="Enter User Name: " D ^DIC Q:Y<0
 S XUDA=+Y,XUNAME=$P(Y,U,2)
 D OWNSKEY^XUSRB(.ZZ,"PSDRPH",XUDA) S XURET=ZZ(0) ;chk if user had key
 S OK=$$ASK(XURET,XUNAME) I 'OK W !,"Nothing done..." Q
 ;De-allocate key
 I XURET K DIK S DIK="^VA(200,XUDA,51,",DA(1)=XUDA,DA=XUKEY D ^DIK
 ;Allocate key
 I 'XURET S FDA(200.051,"+1,"_XUDA_",",.01)="PSDRPH" D UPDATE^DIE("E","FDA","IEN","MSG")
 ;Set and record audit data
 S NOW=$P($$HTE^XLFDT($H),":",1,2)
 S INPUT="`"_XUDA_"^"_"`"_$G(DUZ)_"^"_$S(XURET:0,1:1) D RECORD(INPUT,NOW)
 Q
 ;
ASK(TYPE,NAME) ;Ask user if Allocate/De-allocate - returns y/n
 ;TYPE - flag weather Allocate or De-allocate
 ;Name - user's name
 N FL,%
 S FL=0,%=0
 F  D  Q:FL=1
 .W !,$S(TYPE:"De-allocate",1:"Allocate")," PSDRPH for ",NAME,"?"
 .R " YES// ",X:DTIME S:'$T X=U S:X[U FL=1 Q:X[U  S:(X="") X="Y" I "YyNn"'[$E(X,1) W $C(7)," ??",!,"Please enter 'Y' or 'N'"
 .I $E(X,1)="N"!($E(X,1)="n") S %=0 S FL=1
 .I $E(X,1)="Y"!($E(X,1)="y") S %=1 S FL=1
 Q %
 ;
RECORD(LINE,NOW) ;Record the edited data into audit file #8991.7
 N FDA,VALUE,IEN,MSG,I
 F I=1:1:3 S VALUE=$P(LINE,U,I),FDA(8991.7,"+1,",(I/100))=VALUE
 S FDA(8991.7,"+1,",.04)=NOW
 D UPDATE^DIE("E","FDA","IEN","MSG")
 Q
 ;
VUSER1(XUSD0,ACT) ;called from option - XU EPCS DISUSER EXP DATE,XU EPCS EXP DATE
 ;chk user ACTIVE, with DEA# and null DEA Exp Date
 ;XUSD0=IEN, ACT=(1 or 0) active user or not
 N CNT
 S CNT=0
 I $P($G(^VA(200,XUSD0,"PS")),U,2)'="" S CNT=CNT+1
 I $P($G(^VA(200,XUSD0,"QAR")),U,9)="" S CNT=CNT+1
 I ACT D
 .I $$ACTIVE^XUSER(XUSD0) S CNT=CNT+1
 I 'ACT D
 .I '$$ACTIVE^XUSER(XUSD0) S CNT=CNT+1
 I CNT=3 Q 1
 Q 0
 ;
VUSER2(XUSD0,ACT) ;called from option - XU EPCS PRIVS,XU EPCS DISUSER PRIVS
 ;chk user ACTIVE, with DEA# or VA# with privilages - sch II-V
 ;XUSD0=IEN, ACT=(1 or 0) active user or not
 N CNT
 S CNT=0
 I $$PRESCBR^XUEPCSRT(XUSD0) S CNT=CNT+1
 I $$PRIVS^XUEPCSRT(XUSD0) S CNT=CNT+1
 I ACT D
 .I $$ACTIVE^XUSER(XUSD0) S CNT=CNT+1
 I 'ACT D
 .I '$$ACTIVE^XUSER(XUSD0) S CNT=CNT+1
 I CNT=3 Q CNT
 Q 0
