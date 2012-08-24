PRSNCTL ;WOIFO/DWA - Edit T&L Unit POC Entry and Approval Personnel ;11/24/09
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
EDIT ; Enter/Edit POC Entry and Approval Personnel for a T&L Unit
 N TEMPLATE,STOP S STOP=0
 S TEMPLATE="[PRSN EDIT TL POC]"
 F  D  Q:STOP>0
 . D MAIN(.STOP,TEMPLATE)
 ;
 Q
 ;
DISP ; Display T&L Unit
 N TEMPLATE,STOP S STOP=0
 S TEMPLATE="[PRSA TL DISP]"
 F  D  Q:STOP>0
 . D MAIN(.STOP,TEMPLATE)
 ;
 Q
 ;
MAIN(STOP,T) ;
 N TLI,DA,DDSFILE,DR,DS
 S STOP=0
 S TLI=$$INIT()
 I TLI'>0 S STOP=1 Q
 S DA=+TLI,DDSFILE=455.5,DR=T
 D ^DDS K DS
 Q
 ;
INIT() ;
 D HDR
 N DIC,X,Y,DUOUT,DTOUT
 S DIC="^PRST(455.5,",DIC(0)="AEQLM",DIC("A")="Select T&L Unit: " D ^DIC K DIC
 I $D(DUOUT)!$D(DTOUT)!(Y'>0) Q 0
 Q Y
 ;
HDR ; Header
 W:$E(IOST,1,2)="C-" @IOF
 W !,?26,"VA TIME & ATTENDANCE SYSTEM",!
 W ?24,"EDIT POC ENTRY & APPROVAL PERSONNEL",!
 W ?36,"T&L UNIT",!!!
 ;
 Q
 ;
TL2PEV ;OVERWRITE T&L TIMEKEEPERS AND SUPERVISORS TO PEV DATA ENTRY AND
 ;APPROVERS
 ;
 ;Prompt for T&L unit
 ;
 N DIC,X,Y,DUOUT,DTOUT
 S DIC="^PRST(455.5,",DIC(0)="AEQM",DIC("A")="Select T&L Unit: "
 D ^DIC
 Q:$D(DUOUT)!$D(DTOUT)!Y'>0
 N TLIEN,ENIEN,SUIEN,APIEN,TKIEN,IENS,IEN,FDA,J,STOP,IEN450
 S TLIEN=+Y
 ;
 D HDR2
 S (ENIEN,SUIEN,APIEN,TKIEN,STOP)=0
 F  D  Q:STOP
 .S:TKIEN'="" TKIEN=$O(^PRST(455.5,TLIEN,"T","B",TKIEN))
 .S:ENIEN'="" ENIEN=$O(^PRST(455.5,TLIEN,2,"B",ENIEN))
 .I TKIEN="",ENIEN="" S STOP=1 Q
 .W !
 .I TKIEN'="" W $S($$SEP(TKIEN)="Y":"*",1:" "),$P($G(^VA(200,TKIEN,0)),U)
 .I ENIEN'="" W ?40,$S($$SEP(ENIEN)="Y":"*",1:" "),$P($G(^VA(200,ENIEN,0)),U)
 ;
 D HDR3
 S (ENIEN,SUIEN,APIEN,TKIEN,STOP)=0
 F  D  Q:STOP
 .S:SUIEN'="" SUIEN=$O(^PRST(455.5,TLIEN,"S","B",SUIEN))
 .S:APIEN'="" APIEN=$O(^PRST(455.5,TLIEN,3,"B",APIEN))
 .I SUIEN="",APIEN="" S STOP=1 Q
 .W !
 .I SUIEN'="" W $S($$SEP(SUIEN)="Y":"*",1:" "),$P($G(^VA(200,SUIEN,0)),U)
 .I APIEN'="" W ?40,$S($$SEP(APIEN)="Y":"*",1:" "),$P($G(^VA(200,APIEN,0)),U)
 ;
 W !
 ;
 N DIR,Y,DIRUT,CONT
 S DIR(0)="Y",DIR("B")="No",DIR("A")="Do you want to proceed"
 S DIR("A",1)="Continuing with this process will DELETE ALL existing"
 S DIR("A",2)="POC data entry and approval personnel. Then it will copy"
 S DIR("A",3)="ETA timekeepers to POC data entry and ETA supervisors to"
 S DIR("A",4)="POC approval personnel. Employees with an * in front of their"
 S DIR("A",5)="name are separated and will NOT be copied."
 D ^DIR
 S CONT=$S(Y=1:1,1:0)
 I 'CONT W !,"Aborted..." Q
 ;
 ;Kill off POC entry
 ;
 K FDA
 S IEN=0
 F  S IEN=$O(^PRST(455.5,TLIEN,2,IEN)) Q:IEN'>0  D
 . S FDA(455.52,IEN_","_TLIEN_",",.01)="@"
 I $D(FDA) D FILE^DIE("","FDA"),MSG^DIALOG()
 ;
 ;Kill off POC approvers
 ;
 K FDA
  S IEN=0
  F  S IEN=$O(^PRST(455.5,TLIEN,3,IEN)) Q:IEN'>0  D
 . S FDA(455.531,IEN_","_TLIEN_",",.01)="@"
 I $D(FDA) D FILE^DIE("","FDA"),MSG^DIALOG()
 ;
 ;Update POC Entry with timekeepers
 S (TKIEN,J)=0
 K FDA,IENS
 F  S TKIEN=$O(^PRST(455.5,TLIEN,"T","B",TKIEN)) Q:TKIEN'>0  D
 . ;check for separation
 . S SEPFLAG=$$SEP(TKIEN)
 . Q:SEPFLAG="Y"
 . S J=J+1
 . S IENS(J)=J
 . S FDA(455.52,"+"_J_","_TLIEN_",",.01)=TKIEN
 I $D(FDA) D UPDATE^DIE("","FDA","IENS"),MSG^DIALOG()
 ;
 ;Update POC Approvers with supervisors
 ;
 S (SUIEN,J)=0
 K FDA,IENS
 S SUIEN=0
 F  S SUIEN=$O(^PRST(455.5,TLIEN,"S","B",SUIEN)) Q:SUIEN'>0  D
 . ;check for separation
 . S SEPFLAG=$$SEP(SUIEN)
 . Q:SEPFLAG="Y"
 . S J=J+1
 . S IENS(J)=J
 . S FDA(455.531,"+"_J_","_TLIEN_",",.01)=SUIEN
 I $D(FDA) D UPDATE^DIE("","FDA","IENS"),MSG^DIALOG()
 W !,"Copied..."
 Q
 ;
SEP(IEN200) ;
 ; missing paid ien treated same as separated employee for this process
 N IEN450,SEPFLAG
 S SEPFLAG=""
 S IEN450=$G(^VA(200,IEN200,450))
 I 'IEN450 S SEPFLAG="Y" Q SEPFLAG
 S SEPFLAG=$P($G(^PRSPC(IEN450,1)),U,33)
 Q SEPFLAG
 ;
HDR2 ; Header
 W !,"ETA TIMEKEEPER",?40,"POC DATA ENTRY"
 W !,"--------------------------------------------------------------------------------"
 Q
 ;
HDR3 ;
 W !!,"ETA SUPERVISOR",?40,"POC APPROVAL"
 W !,"--------------------------------------------------------------------------------"
 Q
