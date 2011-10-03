EDPBLK ;SLC/KCM - Handle locking for configuration
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
READL(AREA,PART,TOKEN) ; lock for reading
 N DAY,SEQ
 S DAY=$$INITLOCK
 L +^XTMP("EDP-LOCK-"_DAY,AREA,PART):10 E  Q ""
 S SEQ=+$G(^XTMP("EDP-LOCK-"_DAY,AREA,PART,"READ"))+1
 S ^XTMP("EDP-LOCK-"_DAY,AREA,PART,"READ")=SEQ
 S TOKEN=DAY_"-"_SEQ
 Q
READU(AREA,PART,TOKEN) ; unlock for reading
 Q:$G(TOKEN)=""
 L -^XTMP("EDP-LOCK-"_$P(TOKEN,"-"),AREA,PART)
 Q
INITLOCK() ; returns lock table id, initializing new table if necessary
 S DAY=+$H
 I '$D(^XTMP("EDP-LOCK-"_DAY,0)) D
 . S ^XTMP("EDP-LOCK-"_DAY,0)=$$FMADD^XLFDT(DT,2)_U_DT_U_"ED Locks"
 . N X S X=DAY-3  ; delete any older than 3 days
 . F  S X=$O(^XTMP("EDP-LOCK-"_X),-1) Q:$E(X,1,8)'="EDP-LOCK"  D
 . . S X=$P(X,"-",3)
 . . K ^XTMP("EDP-LOCK-"_X)
 Q DAY
 ;
SAVEL(AREA,PART,TOKEN,ERR) ; lock for saving configuration
 ; ERR is return, empty if successful, message if lock fails
 ; TOKEN is returned with save token, contains read token initially 
 S ERR=""
 I '$L(TOKEN) S ERR="Unable to update with empty token" Q
 ;
 ; extract from token the time of the GET
 N GDAY,GSEQ
 S GDAY=$P(TOKEN,"-"),GSEQ=$P(TOKEN,"-",2)
 ;
 ; lock out all reads during the update
 N DAY
 S DAY=$$INITLOCK
 L +^XTMP("EDP-LOCK-"_DAY,AREA,PART):10 E  S ERR="Unable to obtain lock" Q
 ;
 ; look backwards for interfering updates since GET
 N COLLIDE,SEQ,X,Y
 S COLLIDE="",X="EDP-LOCK-?"
 F  S X=$O(^XTMP(X),-1) Q:$E(X,1,8)'="EDP-LOCK"  Q:$P(X,"-",3)<GDAY  D
 . S Y=$O(^XTMP(X,AREA,PART,"SAVE"," "),-1) Q:'Y  ; no puts
 . I (GDAY=$P(X,"-",3)),(Y<GSEQ) Q                ; put earlier than get token
 . S COLLIDE=^XTMP(X,AREA,PART,"SAVE",Y)
 ;
 I COLLIDE D
 . L -^XTMP("EDP-LOCK-"_DAY,AREA,PART)
 . I COLLIDE=TOKEN S ERR="These changes have already been saved." Q
 . S ERR="Only one person should edit the configuration at a time.  "
 . S ERR=ERR_"The configuration has been modified since you began.  "
 . S ERR=ERR_"You will need to re-enter the changes you have made."
 E  D
 . S SEQ=+$G(^XTMP("EDP-LOCK-"_DAY,AREA,PART,"READ"))+1
 . S ^XTMP("EDP-LOCK-"_DAY,AREA,PART,"READ")=SEQ
 . S ^XTMP("EDP-LOCK-"_DAY,AREA,PART,"SAVE",SEQ)=TOKEN
 . S TOKEN=DAY_"-"_SEQ
 ;
 ; return & do the actual update now, unlocking afterwards
 Q
SAVEU(AREA,PART,TOKEN) ; Unlock for saving
 L -^XTMP("EDP-LOCK-"_$P(TOKEN,"-"),AREA,PART)
 Q
