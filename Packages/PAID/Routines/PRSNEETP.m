PRSNEETP ;;WOIFO/JAH - Timekeeper for Nurse Activity for VANOD;7/24/2009
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
NURSEPOC(TLI,PPI,PRSIEN,PRSDT) ;
 ;
 ;  Determine if current user (timekeeper) has set toggle to enter POC
 ;  data as they post employee time
 ;
 Q:'$$EDTTOGLD()
 ;
 ; Determine if employee passed in PRSIEN is a nurse 
 ;
 Q:'$$ISNURSE^PRSNUT01(PRSIEN)
 ;
 ; Determine if user has access as a data entry personnel
 ;
 Q:'$D(^PRST(455.5,"AE",DUZ,TLI))
 ;
 ; Get Day number of PRSDT-
 ;
 N DAT,PRSD
 S DAT=$G(^PRST(458,"AD",PRSDT)),PRSD=$P(DAT,U,2)
 ;
 ;Call the POC data entry code
 D NURSE^PRSNEE(PPI,PRSIEN,PRSD,"")
 Q
EDTTOGLD() ; Check to see if edit POC from Timecard is toggled on.
 ; look up preference for TKPOCEDIT user preference
 ;
 N TOGGLE,PRSIEN,IENS,SWITCH
 S TOGGLE=0
 S PRSIEN=$G(^VA(200,DUZ,450))
 Q:PRSIEN'>0 TOGGLE
 S IENS=","_PRSIEN_","
 D FIND^DIC(450.01,IENS,"1",,"TKPOCEDIT",,,,,"SWITCH",)
 I $G(SWITCH("DILIST","ID",1,1))="TRUE" S TOGGLE=1
 Q TOGGLE
 ;
TOGGLE ; Turn On/Off POC Data Entry from Timecard Posting
 ; called from option PRSN TOGGLE TK POC POST
 ;
 ;
 N TOGON,PRSIEN,PREFIEN
 ;
 ; get current setting
 S TOGON=$$EDTTOGLD()
 W @IOF,!!!
 I TOGON D
 .  W !?5,"You ARE currently set up to edit"
 .  W !?5,"Nurse Point of Care records as"
 .  W !?5,"you post timecards.  Do you wish"
 .  W !?5,"to remove this setting?",!
 E  D
 .  W !?5,"You are NOT set up to edit POC"
 .  W !?5,"records as you post timecards."
 .  W !?5,"Do you wish to add this"
 .  W !?5,"capability?",!
 ;
 ; ask user if they want to change current preference
 N DIR,DIRUT,X,Y
 S DIR(0)="Y",DIR("B")="Y" D ^DIR
 Q:$D(DIRUT)!('$G(Y))
 S PRSIEN=$G(^VA(200,DUZ,450))
 S IENS=","_PRSIEN_","
 D FIND^DIC(450.01,IENS,"1",,"TKPOCEDIT",,,,,"SWITCH",)
 ; if there is an entry for TKPOCEDIT preference then update entry to 
 ;   new preference
 ; otherwise add and set user preference to multiple.
 ;
 I +$G(SWITCH("DILIST",0)) D
 . S PREFIEN=+$G(SWITCH("DILIST",2,1))
 . N FDA,IENS
 . S IENS=PREFIEN_","_PRSIEN_","
 . S FDA(450.01,IENS,1)=$S(TOGON:"FALSE",1:"TRUE")
 . D UPDATE^DIE("","FDA","IENS"),MSG^DIALOG()
 E  D
 . N FDA,IENS
 . S IENS="+1,"_PRSIEN_","
 . S FDA(450.01,IENS,.01)="TKPOCEDIT"
 . S FDA(450.01,IENS,1)=$S(TOGON:"FALSE",1:"TRUE")
 . D UPDATE^DIE("","FDA","IENS"),MSG^DIALOG()
 Q
ASSIGNKY(X) ;
 ; entry point called when user added as a POC Data Entry Personnel
 ; in the T&L unit file.  When added they get the PRSN DEP security key,
 ; if they don't already have it.
 ;
 S IEN200=$G(X)
 Q:IEN200'>0
 I '$D(^XUSEC("PRSN DEP",IEN200)) D
 . N KEYIEN
 . S KEYIEN=$$FIND1^DIC(19.1,,"X","PRSN DEP")
 . Q:'KEYIEN
 . S PRSFDA(200.051,"?+1,"_IEN200_",",.01)=KEYIEN
 . S PRSIENS(1)=KEYIEN
 . D UPDATE^DIE("","PRSFDA","PRSIENS"),MSG^DIALOG()
 Q
 ;
REMOVEKY(DA,X) ;entry point is called when a user is deleted as a POC Data 
 ; Entry Personnel in the T&L unit file.  When they are deleted from
 ; the multiple, the key is removed, unless they are also in another
 ; T&L as a POC Data Entry Personnel.
 ;
 ; Loop thru "AE" xref in case this data entry personnel is assigned
 ; to other T&Ls
 ;
 N IEN200 S IEN200=$G(X) Q:IEN200'>0
 ;
 N TLI,FOUND S (TLI,FOUND)=0
 F  S TLI=$O(^PRST(455.5,"AE",IEN200,TLI)) Q:TLI'>0!FOUND  D
 .  I TLI'=""&(TLI'=DA(1)) S FOUND=1
 ;
 I 'FOUND,$D(^XUSEC("PRSN DEP",IEN200)) D
 . N KEYIEN,PRSFDA,PRSIENS,DKIEN
 . S KEYIEN=$$FIND1^DIC(19.1,,"X","PRSN DEP")
 . Q:'KEYIEN
 . S DKIEN=$$FIND1^DIC(200.051,","_IEN200_",","QX",KEYIEN)
 . Q:'DKIEN
 . S PRSFDA(200.051,DKIEN_","_IEN200_",",.01)="@"
 . D FILE^DIE("E","PRSFDA"),MSG^DIALOG()
 Q
