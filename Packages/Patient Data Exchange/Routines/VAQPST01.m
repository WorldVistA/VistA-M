VAQPST01 ;ALB/JFP - PDX, POST INIT ROUTINE ;01JUN93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
EP ; -- Entry point
 N POP
 S POP=0
 W @IOF
 W !,"Begin of Post Init Process"
 S XQABT1=$H
 ; -- List Man install
 D PROT
 D LIST
 ; -- File initialization
 S XQABT2=$H
 D EXPORT^VAQPST30
 D PARM^VAQPST02 Q:POP
 D UPDATE^VAQPST40
 D AUTO^VAQPST02 Q:POP
 D ENCR^VAQPST03 Q:POP
 D REL^VAQPST03 Q:POP
 D OUT^VAQPST03 Q:POP
 D SEG^VAQPST03 Q:POP
 ; -- Mail groups
 S XQABT3=$H
 S X=$$MAIL^VAQPST10
 S CNT=0
 W !!
 W !,"Creating Mail Groups for PDX"
 I $E(X,1)=0 W !,"  'VAQ PDX ERRORS'           mail group created"
 I $E(X,2)=0 W !,"  'VAQ MANUAL PROCESSING'    mail group created"
 I $E(X,3)=0 W !,"  'VAQ UNSOLICITED RECEIVED' mail group created"
 ;
 I $E(X,1)=1 S CNT=CNT+1 W !," Error...Creating 'VAQ PDX ERRORS' mail group"
 I $E(X,2)=1 S CNT=CNT+1 W !," Error...Creating 'VAQ MANUAL PROCESSING mail group"
 I $E(X,3)=1 S CNT=CNT+1 W !," Error...Creating 'VAQ UNSOLICITED RECEIVED mail group"
 I CNT>0 W !!,"Problem with creating mail groups, post init halted" QUIT
 W !,"Mail Groups created"
T1 ;
 W !!
 S XQABT4=$H
 D TASK^VAQPST20
T2 W !!
 S X=$$REPEAT^VAQUTL1("*",79) W !,X
 W !,"* IMPORTANT * The following things need to be done: "
 W !,"*"
 W !,"*  - Members need to be added to the newly created mail groups."
 W !,"*    The option is XMEDITMG. "
 W !,"*"
 W !,"*  - The PDX Server (VAQ-PDX-SERVER) needs to be edited in order "
 W !,"*    to associate a mail group with the server.  The mail group "
 W !,"*    to add is 'VAQ PDX ERRORS'.  The installer will also have "
 W !,"*    to change the server action from 'QUEUE SERVER ROUTINE' to"
 W !,"*    'RUN IMMEDIATELY'"
 W !,X
 W !
 D TERMTYP^VAQPST05
 ; -- send mail message on install to G.PDX DEVELOPERS@ISC-ALBANY.VA.GOV
 S XQABT5=$H
 S X="VAQINITY" X ^%ZOSF("TEST") I $T D @("^"_X)
 W !!!,"Post init process completed"
 K X,Y,CNT,DR,ENTRY,FLE,FILENO,FILE,J
 QUIT
 ;
PROT ; -- Installs protocols used by list processor
 W !!,"Installing protocols for use by the list processor"
 D ^VAQONIT
 W !!,"Protocol install completed"
 QUIT
 ;
LIST ; -- Installs list templates
 W !!,"Installing list templates for use by list processor"
 D ^VAQPSL
 W !!," ** List Template install completed"
 QUIT
 ;
MISSING ; -- Builds DR string of fields with missing data
 N ND,PC,FLD,CNT
 S (ND,PC,FLD,DR)="",CNT=0
 F  S ND=$O(^DD(FILENO,"GL",ND))  Q:ND=""  D M1
 QUIT
M1 F  S PC=$O(^DD(FILENO,"GL",ND,PC))  Q:PC=""  D M2
 QUIT
M2 S FLE=$S(ND?1N.N:FILE_ENTRY_","_ND_")",1:FILE_ENTRY_","_$C(34)_ND_$C(34)_")")
 I $P($G(@FLE),U,PC)="" D M3
 QUIT
M3 S FLD="",FLD=$O(^DD(FILENO,"GL",ND,PC,FLD))
 S CNT=CNT+1
 I CNT=1 S DR=DR_FLD
 I CNT'=1 S DR=DR_";"_FLD
 QUIT
 ;
PROMPT ; -- Prompts for missing fields
 I DR="" W !!," ** File installed previously, all required fields present" QUIT
 W !,"Enter missing field(s)",!
 S DA=ENTRY,DIE=FILE
 D ^DIE K DIE,DR,DA
 W !!," ** Missing fields added, initialization complete",!
 QUIT
 ;
END ; -- End of code
 QUIT
