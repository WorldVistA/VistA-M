ALPBOP ;OIFO-DALLAS/SED/KC/FOXK  BCMA-BCBU PURGE OLD ORDERS ;5/2/2002
 ;;3.0;BAR CODE MED ADMIN;**8**;Mar 2004
 ;
ST ;Start here. Purge Order information based of stop date first
 ;Get the parameter setting for number of days to hold patient 
 ;orders. Default is 7 days
 D NOW^%DTC
 S X1=X
 S X2="-"_$$DEFOR^ALPBUTL3()
 D C^%DTC S ALPPUR=X K X1,X2
 S ALPPUR=X
 D WAIT^DICD
 S ALPDFN=0
 F  S ALPDFN=$O(^ALPB(53.7,ALPDFN)) Q:+ALPDFN'>0  D
 . S ALPBIEN=0
 . F  S ALPBIEN=$O(^ALPB(53.7,ALPDFN,2,ALPBIEN)) Q:+ALPBIEN'>0  D
 . . ;First look for Stop Date
 . . S ALPBDATE=+$P($G(^ALPB(53.7,ALPDFN,2,ALPBIEN,1)),U,2)
 . . ;If stop date is not there then use last updated date
 . . S:+ALPBDATE'>0 ALPBDATE=+$P(^ALPB(53.7,ALPDFN,2,ALPBIEN,0),U,4)
 . . Q:ALPBDATE>ALPPUR
 . . K DIK,DA
 . . S DA(1)=ALPDFN,DA=ALPBIEN
 . . S DIK="^ALPB(53.7,"_DA(1)_",2," D ^DIK
 . ;Now check to see if I need to remove the patient record
 . D NOW^%DTC
 . S X1=X
 . ;Get the parameter setting for number of days to hold patient record
 . ;Default is 30 days with no order information
 . S X2="-"_$$DEFPR^ALPBUTL3()
 . D C^%DTC S ALPPUR=X K X1,X2
 . S ALPPUR=X
 . S ALPBDATE=+$P(^ALPB(53.7,ALPDFN,0),U,8)
 . ;Quit if record had been updated within time frame
 . Q:ALPBDATE>ALPPUR
 . I '$D(^ALPB(53.7,ALPDFN,2)) D RPAT Q
 . I +$O(^ALPB(53.7,ALPDFN,2,0))'>0 D RPAT
STOP K ALPBIEN,ALPDFN,DA,ALPBDATE,ALPPUR,DR,DIE,X,DIK,X1,X2
 Q
RPAT ;Remove patient
 K DIK
 S DA=ALPDFN
 S DIK="^ALPB(53.7," D ^DIK
 Q
