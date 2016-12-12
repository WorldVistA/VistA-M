ORDEBUG1 ;SLC/AJB - CPRS Debug Support Routine ;10/13/15  10:13
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**350**;Dec 17, 1997;Build 77
 ;
 Q
 ;
EN ;
 W @IOF
 N DESC,POP,RTN,SAVE
 S DESC="CPRS Debug Log Viewer",RTN="SHOWME^ORDEBUG1" ; ,SAVE("*")=""
 W ! D EN^XUTMDEVQ(RTN,DESC,.SAVE)
 Q
SHOWME ;
 ;
 N DATA,DLM S DATA=$NA(^XTMP("CPRS DEBUG LOG")),DLM=","
 N INFO S INFO="TEMP" ; $NA(^XTMP("DEBUG LOG VIEW",$J))
 K @INFO
 ;
 ; ^XTMP format
 ; P1="<usr IEN>^DD/MM/YYYY HH:MM:SS"
 ; P2=type of data [description, rpc, etc.]
 ; P3=counter for type
 ; P4=counter for # of lines in type
 ;
 W """USER"",""DATE"",""TIME"",""RPC #"",""DESCRIPTION/RPC"",""PARAMETERS"",""RESULTS"""
 ;
 ; get XTMP data and sort for various output
 N P1,P2,P3,P4
 S P1=0 F  S P1=$O(@DATA@(P1)) Q:'+P1  S P2=""  F  S P2=$O(@DATA@(P1,P2)) Q:P2=""  S P3="" F  S P3=$O(@DATA@(P1,P2,P3)) Q:P3=""  D
 . N DEV,DATE,TIME
 . S DEV=$$GET1^DIQ(200,$P(P1,U),.01)
 . S DATE=$P($P(P1,U,2)," ")
 . S TIME=$P($P(P1,U,2)," ",2)
 . I P2="DESCRIPTION" D
 . . S:P3=0 @INFO@(DEV,DATE,TIME,0,0,P2,0)=@DATA@(P1,P2,P3)
 . . S:P3'=0 @INFO@(DEV,DATE,TIME,0,0,P2,P3)=@DATA@(P1,P2,P3)
 . N RSLTS S RSLTS=0 S P4="" F  S P4=$O(@DATA@(P1,P2,P3,P4)) Q:P4=""  D
 . . ; I P3'=76 Q  ; ***** control number of results
 . . I P4=1!(P4=2) Q  ; skip first " " entry and "Parameters ---..." entry
 . . I P4=0 S @INFO@(DEV,DATE,TIME,P3,0,"RPC",P4)=@DATA@(P1,P2,P3,P4) Q  ; set 0 node=RPC name
 . . I P4=3,@DATA@(P1,P2,P3,P4)=" " S @INFO@(DEV,DATE,TIME,P3,1,"PARAM",P4)="",RSLTS=1 Q  ; no parameters for RPC
 . . I @DATA@(P1,P2,P3,P4)["Results -----" S RSLTS=1 Q
 . . I '+RSLTS,@DATA@(P1,P2,P3,P4)'=" " S @INFO@(DEV,DATE,TIME,P3,1,"PARAM",P4)=@DATA@(P1,P2,P3,P4)
 . . I +RSLTS,@DATA@(P1,P2,P3,P4)'=" " S @INFO@(DEV,DATE,TIME,P3,2,"RESULT",P4)=@DATA@(P1,P2,P3,P4)
 ;
 ; ^XTMP format [RPC,Parameters,Results]
 ; P1=user name
 ; P2=date of log
 ; P3=time of log
 ; P4=RPC number
 ; P5=type of data numeric [0=RPC name,1=Parameter,2=Result]
 ; P6=type of data
 ; P7=line number
 ;
 N P5,P6,P7
 S P1="" F  S P1=$O(@INFO@(P1)) Q:P1=""  S P2="" F  S P2=$O(@INFO@(P1,P2)) Q:P2=""  S P3="" F  S P3=$O(@INFO@(P1,P2,P3)) Q:P3=""  S P4="" F  S P4=$O(@INFO@(P1,P2,P3,P4)) Q:P4=""  D
 . W !,$C(34),P1,$C(34),DLM,$C(34),P2,$C(34),DLM,$C(34),P3,$C(34),DLM,$C(34),P4,$C(34),DLM
 . S P5="" F  S P5=$O(@INFO@(P1,P2,P3,P4,P5)) Q:P5=""  D
 . . S P6="" F  S P6=$O(@INFO@(P1,P2,P3,P4,P5,P6)) Q:P6=""  S P7="" F  S P7=$O(@INFO@(P1,P2,P3,P4,P5,P6,P7)) Q:P7=""  D
 . . . I $O(@INFO@(P1,P2,P3,P4,P5,P6,P7),-1)="" W $C(34)
 . . . W @INFO@(P1,P2,P3,P4,P5,P6,P7)
 . . . I $O(@INFO@(P1,P2,P3,P4,P5,P6,P7))'="" W !
 . . . I $O(@INFO@(P1,P2,P3,P4,P5,P6,P7))="" W $C(34) I P4'=0 I P5=0!(P5=1) W DLM
 ;
 ;
 Q
