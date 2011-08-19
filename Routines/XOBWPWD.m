XOBWPWD ;ALB/MJK - HWSC :: Private Password APIs ; 09/13/10 4:00pm
 ;;1.0;HwscWebServiceClient;;September 13, 2010;Build 31
 ;
 ; -- used XOBVJC1 as seed
 ; 
 QUIT
 ;
EDIT ; -- edit PASSWORD from DD
 NEW DIR,DIR0,XOBH,XOBMATCH
 SET XOBMATCH=0
 ;
 ; -- if not 'y'es
 IF "Nn"[$EXTRACT(X,1) SET X="" QUIT
 IF "Yy"'[$EXTRACT(X,1) KILL X QUIT
 ;
 ; -- get good hash or until abort by user 
 FOR  DO  QUIT:XOBMATCH!($DATA(DIRUT))
 . DO CLR
 . SET XOBH=$$ASK()
 . IF $DATA(DIRUT) QUIT
 . SET XOBMATCH=$$REASK(XOBH)
 ;
 ; -- if good hash set in file
 IF XOBMATCH DO
 . DO CLR
 . DO SET(XOBH,1)
 ;
 ; -- clean up
 KILL DUOUT
 IF $DATA(DIRUT) SET DUOUT=1
 XECUTE ^%ZOSF("EON") WRITE !
 KILL DIR,DIRUT SET X=""
 QUIT
 ;
CLR ; -- clear to continue
 IF '$DATA(DDS) WRITE ! QUIT
 NEW DX,DY
 DO CLRMSG^DDS SET DX=0,DY=DDSHBX+1 XECUTE IOXY
 QUIT
 ;
SET(XOBH,XOBTALK) ; -- set password in entry
 IF $LENGTH(XOBH),XOBTALK WRITE !,"Ok, password has been changed!"
 NEW FDA,XOBERR
 IF XOBH="" SET XOBH="@"
 ; -- password
 SET FDA(18.12,$$IENS^DILF(.DA),300)=XOBH
 DO FILE^DIE("","FDA","XOBERR")
 IF $DATA(XOBERR) DO ^%ZTER
 QUIT
 ;
DEL ; -- make sure delete is desired
 XECUTE ^%ZOSF("EON")
 WRITE "@",*7
 SET DIR(0)="Y",DIR("A")="Sure you want to delete"
 DO ^DIR
 IF Y'=1 WRITE:$X>55 !?9 WRITE *7,"  <Nothing Deleted>"
 QUIT
 ;
DIRUT ; -- set abort flag
 SET DIRUT=1
 QUIT
 ;
ASK() ; -- setup to ask user for password
 NEW X,XOBX,XOBH
 XECUTE ^%ZOSF("EOFF")
 DO CLR
 WRITE "Enter a new PASSWORD: "
 SET XOBX=$$GET()
 IF $DATA(DIRUT) QUIT ""
 IF XOBX="@" DO  QUIT ""
 . DO DEL
 . IF Y'=1 DO DIRUT
 ;
 DO CLR
 QUIT $$ENCRYP(XOBX)
 ;
REASK(XOBH) ; -- reask user for password
 NEW XOBX,XOBDONE,XOBMATCH,XOBI
 SET XOBDONE=0
 SET XOBMATCH=1
 ;
 ; -- if deleting then auto-match
 IF XOBH="" QUIT XOBMATCH
 ;
 SET XOBMATCH=0
 DO CLR
 XECUTE ^%ZOSF("EOFF")
 FOR XOBI=3:-1:1 DO  QUIT:XOBDONE
 . WRITE "Please re-type the new password to show that I have it right: "
 . SET XOBX=$$GET()
 . ; -- user is up-arrowing out
 . IF $DATA(DIRUT) SET XOBDONE=1 QUIT
 . ;
 . IF XOBX'=$$DECRYP(XOBH) DO  QUIT
 . . DO CLR
 . . WRITE "This doesn't match.  Try again!",!,*7
 . ; -- match entered
 . SET XOBDONE=1
 . SET XOBMATCH=1
 QUIT XOBMATCH
 ;
GET() ; -- get user input and process for '^' and ''
 SET X=$$ACCEPT(60)
 IF X="@" QUIT X
 IF (X["^")!('$LENGTH(X)) DO DIRUT
 QUIT X
 ;
ACCEPT(TO) ; -- read user input character a time; force exit on '^'; echo '*' back
 NEW C,A,E
 KILL DUOUT
 SET A="",TO=$GET(TO,60),E=0
 FOR  DO  QUIT:E
 . READ "",*C:TO SET:('$TEST) DUOUT=1 SET:('$TEST)!(C=94) A="^"
 . IF (A="^")!(C=13)!($LENGTH(A)>100) SET E=1 QUIT
 . IF C=127 QUIT:'$LENGTH(A)  SET A=$EXTRACT(A,1,$LENGTH(A)-1) WRITE $CHAR(8,32,8) QUIT
 . SET A=A_$CHAR(C) WRITE *42
 . QUIT
 QUIT A
 ;
ENCRYP(XOBX) ; -- Kernel encode
 QUIT $$ENCRYP^XUSRB1(XOBX)
 ;
DECRYP(XOBH) ; -- Kernel decode
 QUIT $$DECRYP^XUSRB1(XOBH)
 ;
