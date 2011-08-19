RCXVPARM ;DAOU-AR Paramater File Editor;02-JUL-03
 ;;4.5;Accounts Receivable;**201**;Mar 20, 1995
 ;
 ;
 Q  ; Quit routine if not called at Entry Point EN
EN ; Entry Point
 NEW DIC,DIE,DR,DA,VDIR,VNAME,IEN,VUPDT,VDATA,SWITCH
 NEW RCXVFFD,RCXVFTD,RCXVVSD,RCXVMG,RCXVBMX,RCXVSYS,RCXVOFF
 NEW IN,D,DI,D0,DQ,UIN,X,Y,DIR,FILE,REC,DDH,RCXVUP,ERROR
 NEW DISYS,DZ,VBQ,KEEPLOG,RCXVBNM,RCXVLDM
 ;
 S RCXVUP(342,"1,",20.06)=$S($P($$PARAM^HLCS2(),U,3)="P":"PRODUCTION",1:"TEST")
 D FILE^DIE("E","RCXVUP","ERROR")
 ;
 S UIN=1
 W @IOF
 F  D  Q:'UIN                 ; Loop until user declines edit response
 . D DISP W !                 ; Display current parameter settings
 . S UIN=$$PROMPT()           ; Prompt for user edit response
 . I UIN W ! D SET W @IOF     ; If requested allow user to edit
 . Q
ENX ; EN exit point
 Q
 ;
 ;
DISP ; Display Current Settings
 W !!?2,"CURRENT CBO AR Data Extract Site Parameter Settings"
 ; Get all all CBO AR Parameter data
 S FILE=342,REC="1,"
 S RCXVVSD=$$GET1^DIQ(FILE,REC,20.01)      ; Vitria Stndrd Dir.
 S RCXVMG=$$GET1^DIQ(FILE,REC,20.02)       ; Mail Group
 S RCXVBNM=$$GET1^DIQ(FILE,REC,20.05)      ; Max. # of Rec.
 S RCXVSYS=$$GET1^DIQ(FILE,REC,20.06,"I")
 S RCXVOFF=$$GET1^DIQ(FILE,REC,20.04)
 S RCXVLEG=$$GET1^DIQ(FILE,REC,20.07,"E")
 S RCXVLDM=$$GET1^DIQ(FILE,REC,20.08,"E")
 ; Display AR Data Extract Parameter fields
 W !!?6,"FILE DIRECTORY              : ",RCXVVSD
 W !?6,"MAIL GROUP                  : ",RCXVMG
 W !?6,"MAXIMUM NUMBER RECORDS      : ",RCXVBNM
 W !,?6,"LEGACY SITE?                : ",RCXVLEG
 I RCXVLEG="YES" W !,?6,"PRIMARY DOMAIN NAME         : ",RCXVLDM
 I RCXVSYS="P" Q
 W !,?6,"TEST SYSTEM STATUS          : ",RCXVOFF
 Q
 ;
 ;
PROMPT() ; Prompt user to allow user to edit fields
 ; Return user input    0 : "NO" - Do not edit settings
 ;                      1 : "YES" - Edit settings
 S DIR(0)="Y",DIR("A")="  Do you wish to edit these settings"
 S DIR("B")="NO"
 D ^DIR
 Q Y
 ;
 ;
SET ; SET
 ; Set variables for ^DIE call
 S DIE="^RC(342,",DA=1
 S DR="20.01;20.02;20.05"
 I RCXVSYS'="P" S DR=DR_";20.04T~"
 ;
 S DR=DR_";20.07"
 ; Prompt user to enter/edit values in DR and file data
 D ^DIE
 S RCXVLEG=$$GET1^DIQ(FILE,REC,20.07,"E")
 I RCXVLEG="YES" S DR="20.08"
 E  Q
 D ^DIE
 Q
 ;
