ANRVJ1 ;HOIFO/CED - BR utility ;Jun 13,2006
 ;;5.0;BLIND REHABILITATION;**1**;Jun 02, 2006;Build 11
 ; This routine contains calls to VistA for 
 ; use until services are available.
 ; 
 ; Integration Agreements Utilized:
 ;       GETDFN^MPIF001  #2701
 ;
GETDFN ; [Procedure] Return the DFN given a ICN
 N DFN
 S DFN=VAL1
 S @RESULTS@(0)=$$GETDFN^MPIF001(DFN)
 Q
 ;
GETPAR ; [Procedure] Return external value for parameter
 N ENT,PAR,INST,VER
 S ENT="SYS"
 S PAR=VAL1
 S INST=DATA
 S VER=$$GET^XPAR(ENT,PAR,INST,"B")
 I VER="" S VER="0^NO"
 S @RESULTS@(0)=VER
 Q
 ;
RPC(RESULTS,OPTION,VAL1,DATA) ; [Procedure] Main RPC Entry
 S RESULTS=$NA(^TMP($J)) K @RESULTS
 D:$T(@OPTION)]"" @OPTION
 D:'$D(@RESULTS)
 .S @RESULTS@(0)="0^No results returned"
 D CLEAN^DILF
 Q
 ;
SELUSR ; [Procedure] Return a selected user
 ; This is being replaced by Kernel
 ; IEN is the selected users Internal Entry Number
 N IEN
 S IEN=VAL1
 S @RESULTS@(0)=IEN_U
 S @RESULTS@(1)=$$GET1^DIQ(200,IEN_",",.01)_U ; Name
 S @RESULTS@(2)=$$GET1^DIQ(200,IEN_",",8)_U ; Title
 Q
 ;
LISTUS ; [Procedure]Return a user list
 ; This is being replaced by Kernel
 N I,IEN,Y
 D FIND^DIC(200,"","","M",VAL1)
 S I=0,Y=""
 F  S I=$O(^TMP("DILIST",$J,1,I)) Q:'I  D
 . S IEN=^TMP("DILIST",$J,2,I)
 . S @RESULTS@(I)=^TMP("DILIST",$J,2,I)_U_^TMP("DILIST",$J,1,I)_"~"
 Q
 ;
