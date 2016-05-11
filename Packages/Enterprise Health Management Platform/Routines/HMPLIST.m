HMPLIST ;HOIFO/DP,ASMR/RRB - List Manager;02 Nov 2012
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN(TARGET,NAME,FORMAT,PARAMS) ; OlD sKOoL entry point
 Kill @TARGET
 New HMPLIST,HMPROOT,HMPXECUTE
 If NAME="*" Do
 . Do ALL(TARGET)
 Else  Do
 . Set HMPLIST=$$LIST(NAME) If 'HMPLIST Set Y=$$ADD("-1^No Such List '"_NAME_"'") Quit
 . If $Piece(HMPLIST,U,3)=0 Do  ; Static list
 . . Set X=$$GET1^DIQ(800000.2,+HMPLIST_",",.9,"",TARGET)
 . Else  Set HMPXECUTE=$$GET1^DIQ(800000.2,HMPLIST_",",.11,"I") Xecute:HMPXECUTE]"" HMPXECUTE
 . Set @TARGET@(0)=NAME_U_$Order(@TARGET@(""),-1)_U_$$COLS(+HMPLIST)
 ; Process alternate format before leaving
 Set FORMAT=$Get(FORMAT,"DEFAULT")
 Do @$Select(FORMAT="XML":"XML",FORMAT="JSON":"JSON",FORMAT="DEFAULT":"DEFAULT",1:"UNKNOWN")
 Quit
 ;
RPC(RESULT,NAME,FORMAT,PARAMS) ; Accessed via HMP LIST Remote Procedure
 Set RESULT=$Name(^TMP($J)) Kill @RESULT
 If $Data(PARAMS) Do EN(RESULT,NAME,$Get(FORMAT,"DEFAULT"),.PARAMS)
 Else  Do EN(RESULT,NAME,$Get(FORMAT,"DEFAULT"))
 Quit
 ;
VALUE(NAME,ID) ; Return the item from a list by ID
 New HMPLIST
 Set HMPLIST=$$LIST(NAME) If 'HMPLIST Quit "^No Such List"
 For X=0:0 Set X=$Order(^HMPD(800000.2,+HMPLIST,9,X)) Quit:'X  Quit:$Piece(^(X,0),U)=ID
 Quit $Select(X:^HMPD(800000.2,+HMPLIST,9,X,0),1:"^No Such ID")
 ;
EDIT ; Edit a list definition
 New DDSFILE,DA,DR
 Do HOME^%ZIS Write @IOF
 Set DDSFILE=800000.2,DR="[HMP LIST]"
 Do ^DDS
 Quit
 ;
DISPLAY ; Display a list definition
 New DIC,HMP,BY,FR,TO,FLDS
 Set DIC=800000.2,DIC(0)="AEQM",DIC("A")="Select List Definition to Display: " Do ^DIC Quit:+Y<1
 Set BY="@NUMBER",FR=+Y,TO=+Y,FLDS="[HMP LIST DISPLAY]" Do EN1^DIP
 Quit
 ;
DEFAULT ; Just return as is, a simple array
 Quit
 ;
UNKNOWN ; You've got no idea, and neither do I
 Quit
 ;
JSON ; Convert @TARGET@(1..n) to JSON
 New HMPCOLS,HMPX,HMPY
 Set HMPCOLS=$Piece(@TARGET@(0),U,3),HMPX=@TARGET@(0)
 Set @TARGET@(0)="{ name : """_$Piece(HMPX,U,1)_""", count : """_$Piece(HMPX,U,2)_""""_$Select($Order(@TARGET@(0)):", [",1:"}")
 For X=0:0 Set X=$Order(@TARGET@(X)) Quit:'X  Do
 . Set HMPX=@TARGET@(X),HMPY="{ "
 . For Y=1:1:$Length(HMPCOLS,";") Set HMPY=HMPY_""""_$Piece(HMPCOLS,";",Y)_""":"""_$Piece(HMPX,U,Y)_""""_$Select(Y<$Length(HMPCOLS,";"):", ",1:" ")
 . Set HMPY=HMPY_"}"
 . If $Order(@TARGET@(X)) Set @TARGET@(X)=HMPY_"," Quit
 . Set @TARGET@(X)=HMPY
 Set @TARGET@($Order(@TARGET@(""),-1)+1)="]}"
 Quit
 ;
XML ; Convert @TARGET@(1..n) to XML
 New HMPCOLD,HMPX,HMPY
 Set HMPCOLS=$Piece(@TARGET@(0),U,3)
 For X=0:0 Set X=$Order(@TARGET@(X)) Quit:'X  Do
 . Set HMPX=@TARGET@(X),HMPY="<item "
 . For Y=1:1:$Length(HMPCOLS,";") Set HMPY=HMPY_$Piece(HMPCOLS,";",Y)_"="""_$Piece(HMPX,U,Y)_""" "
 . Set HMPY=HMPY_"/>"
 . Set @TARGET@(X)=HMPY
 Set HMPX=@TARGET@(0)
 Set @TARGET@(0)="<list name="""_$Piece(HMPX,U,1)_""" count="""_$Piece(HMPX,U,2)_""">"
 Set @TARGET@($Order(@TARGET@(""),-1)+1)="</list>"
 Quit
 ;
XMLSAFE(X) ; Transform X into XML safe data
 ; Strip off the spaces and make life easier
 For  Quit:$Extract(X)'=" "  Set X=$Extract(X,2,$Length(X))
 For  Quit:$Extract(X,$Length(X))'=" "  Set X=$Extract(X,1,$Length(X)-1)
 Set X=$$TRNSLT(X,"&","&amp;")
 Set X=$$TRNSLT(X,"<","&lt;")
 Set X=$$TRNSLT(X,">","&gt;")
 Set X=$$TRNSLT(X,"'","&apos;")
 Set X=$$TRNSLT(X,"""","&quot;")
 Set X=$$TRNSLT(X,":","&#58;")
 Quit X
 ;
JSONSAFE(X) ; Transform X into JSON safe data
 ; Strip the spaces
 For  Quit:$Extract(X)'=" "  Set X=$Extract(X,2,$Length(X))
 For  Quit:$Extract(X,$Length(X))'=" "  Set X=$Extract(X,1,$Length(X)-1)
 Set X=$$TRNSLT(X,"""","\""")
 Quit X
 ;
TRNSLT(X,X1,X2) ; Translate every Y to Z in X
 New Y
 Quit:X'[X1 X  ; Nothing to translate
 Set Y="" For  Quit:X=""  Do
 . If X[X1 Set Y=Y_$Piece(X,X1)_X2,X=$Piece(X,X1,2,250) Quit
 . Set Y=Y_X,X=""
 Quit Y
 ;
LIST(NAME) ; Return List by name
 Set X=$$FIND1^DIC(800000.2,,"KX",NAME) Quit:X<1 X
 Quit X_U_^HMPD(800000.2,X,0)
 ;
ALL(RETURN) ; Return All lists in RETURN()
 Kill @RETURN
 Do LIST^DIC(800000.2,,"@;.01;.02","P")
 For X=0:0 Set X=$Order(^TMP("DILIST",$J,X)) Quit:'X  Set @RETURN@(X)=^TMP("DILIST",$J,X,0)
 Set @RETURN@(0)="ALL LISTS^"_+$Order(@RETURN@(""),-1)_"^ID;name;type"
 Kill ^TMP("DILIST",$J)
 Quit
 ;
COLS(LIST) ; Return the col names (ID^Name) + any custom col specs
 New RESULT,X,Y
 Set RESULT="ID;name"
 For X=0:0 Set X=$Order(^HMPD(800000.2,+LIST,2,X)) Quit:'X  Set Y=^(X,0) Do
 . Set $Piece(RESULT,";",$Piece(Y,U,2))=$Piece(Y,U,1)
 Quit RESULT
 ;
CODE(LIST) ; Return Generation Code for a list
 Quit $Get(^HMPD(800000.2,+LIST,.11))
 ;
SET(DD,FLD) ; Build a list from a Set Of Codes DD and Field number combination
 Kill @TARGET
 Quit:$$GET1^DID(DD,FLD,,"TYPE")'="SET"
 Set X=$$GET1^DID(DD,FLD,,"POINTER")
 For Y=1:1:$Length(X,";")-1 Set @TARGET@(Y)=$Translate($Piece(X,";",Y),":","^")
 Quit
 ;
REBUILD(NAME) ;
 New LIST,ALL,CODE,FDA,HMPFDA,HMPX
 ;
 If NAME="?" Do  Quit
 . Set DIC=800000.2,DIC(0)="AEQMZ",DIC("A")="Rebuild List: ",DIC("S")="I '$P(^(0),U,2)"
 . Do ^DIC Do:+Y REBUILD(Y(0,0))
 ;
 If +NAME=NAME Do  Quit  ; Rebuild all for a DD number
 . For HMPX=0:0 Set HMPX=$Order(^HMPD(800000.2,"ADD",NAME,HMPX)) Quit:'HMPX  Do REBUILD($Piece(^HMPD(800000.2,HMPX,0),U))
 ;
 If NAME="*" Do  Quit  ; Rebuild all
 . For HMPX=0:0 Set HMPX=$Order(^HMPD(800000.2,HMPX)) Quit:'HMPX  Do REBUILD($Piece(^HMPD(800000.2,HMPX,0),U))
 ;
 Set LIST=$$LIST(NAME) Quit:+LIST<1  ; No Such List
 ;
 If $Piece(LIST,U,2) Quit  ; Dynamic list - fired every time
 Set CODE=$$CODE(LIST) Quit:CODE=""  ; No rebuild code, must be manual
 ;
 Set TARGET=$Name(^TMP($J))
 Set FDA=$Name(HMPFDA(800000.2,(+LIST)_","))
 Kill @TARGET
 Xecute CODE
 Set @FDA@(.09)="NOW"
 Set @FDA@(.9)=TARGET
 Do FILE^DIE("E","HMPFDA")
 Quit
 ;
DQ ; Called via Taskman to build any list that has expired
 New HMPNOW,HMPLIST,HMPMIN
 Kill HMPNEXT
 ; Nothing set to refresh automatically
 Quit:'$Order(^HMPD(800000.2,"AREFRESH",0))
 Do NOW^%DTC Set HMPNOW=%
 For HMPLIST=0:0 Set HMPLIST=$Order(^HMPD(800000.2,HMPLIST)) Quit:'HMPLIST  Do:'$Piece(^HMPD(800000.2,HMPLIST,0),U,2)  ; Not Dynamic
 . Quit:'$Piece(^HMPD(800000.2,HMPLIST,0),U,8)  ; Doesn't have a refresh limit
 . New $ESTACK,$ETRAP Set $ETRAP="D ERR^HMPLIST" ; Will prevent a list error from cratering the entire build
 . Set HMPMIN=$Piece(^HMPD(800000.2,HMPLIST,0),U,8)
 . Set HMPLAST=$$GET1^DIQ(800000.2,HMPLIST_",",.09,"I")
 . Set HMPNEXT=$$FMADD^XLFDT(HMPLAST,0,0,HMPMIN,0)
 . Quit:HMPNEXT>HMPNOW
 . Quit:($$FMADD^XLFDT(HMPNOW,0,0,HMPMIN*-1,0)<$Piece(^HMPD(800000.2,HMPLIST,0),U,9))  ; Not yet stale :)
 . Do REBUILD($Piece(^HMPD(800000.2,HMPLIST,0),U))
 ; Get the shortest refresh threshold and reschedule for that
 Set HMPNEXT=$$FMADD^XLFDT(+$Extract(HMPNOW,1,12),0,0,$Order(^HMPD(800000.2,"AREFRESH",0)),0)
 Kill ZTREQ
 Set ZTREQ=$$FMTH^XLFDT(HMPNEXT)
 Quit
 ;
ADD(X) ; Adds an item to the list automatically
 Set @TARGET@($Order(@TARGET@(""),-1)+1)=X
 Quit $Order(@TARGET@(""),-1)
 ;
WARDS ; Get list of wards, clinics and non-stops
 Do LOC("W")
 Quit
 ;
CLINICS ; Get Active Clinics
 Do LOC("NC")
 Quit
 ;
LOC(TYPES) ; Build list of locations by type
 New HMPDT,HMPNOW
 Do NOW^%DTC Set HMPNOW=%
 For X=0:0 Set X=$Order(^SC(X)) Quit:'X  Do:TYPES[$Piece(^(X,0),U,3)  ;DE2818 ICR 10040 ASF 11/16/15
 . Set HMPDT=$Get(^SC(X,"I"),U) ; Deactivation and Reactivation dates
 . If +HMPDT Quit:(+HMPDT<HMPNOW&('$Piece(HMPDT,U,2)))!(+HMPDT<HMPNOW&($Piece(HMPDT,U,2)>HMPNOW))
 . Set Y=$$ADD^HMPLIST(X_U_$Piece(^SC(X,0),U,1,3)) ; Full tag^rtn used for demonstration purposes
 Quit
 ;
INPT ; Rebuild the inpatient list
 Do LIST^DIC(2,,"@;.01;.02;.03;.09;.1;.101","P",,,,"CN")
 For X=0:0 Set X=$Order(^TMP("DILIST",$J,X)) Quit:'X  Set Y=$$ADD(^(X,0))
 Do CLEAN^DILF
 Quit
 ;
ERR ; This is the application specific error trap for the DQ loop
 Do ^%ZTER ; record the error
 Do UNWIND^%ZTER ; unwind the stack, return to caller.
 Quit
 ;
