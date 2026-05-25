DGRPU1 ;ALB/REW,JAM - CUSTOM LOAD/EDIT SCREEN UTILITIES ;19 Oct 2017  3:02 PM
 ;;5.3;Registration;**139,169,415,527,508,664,941,1143**;Aug 13, 1993;Build 36
 ;
 ; *941* - JAM; 1. Tag QNUM modified for new field reference numbers used in ^DGRPE due to redesign of Screen layouts for screen 1 and 1.1
 ;           Previous values:   ^104^105^109,105,112^109,105,111^111^
 ;           New values:        ^108^113^109,113,104^109,113,114^114^
 ;
 ; *1143* - JAM: Tag QNUM modified for new field reference numbers used in ^DGRPE due to change: Group 4 on screen 1 moved to Group 5 on screen 1.1
 ;           Previous values:   ^108^113^109,113,104^109,113,114^114^
 ;           New values:        ^108^113^109,113,115^109,113,114^114^
 ;
QUES(DFN,DGQCODE) ; EDIT SPECIFIC PORTIONS OF REGISTRATION DATA
 ;
 ;  INPUT:
 ;     DFN
 ;     DGQCODE = Code for question(s) to be asked
 ;  OUTPUT:
 ;     DGERR   = ERROR VARIABLE
 ;     DGCHANGE= 1 IF DATA MODIFIED 0 O/W
 ;  USED:
 ;     DGPTND  = Prior value(s) of Patient File node(s) [array]
 ;     DGQNODES= Node(s) used above
 ;     DGNODE  = Single node
 ;     DGDR    = edit=screen*10+item #
 ;     DGRPS   = Screen #
 ;     DGCODE  = CODE used by ^DGRPE
 ;     DGQ     = String of ^DGCODE^DGCODE etc.
 ;     DGPC    = Piece Number
 ;     DGX     = Line Tag offset
 ;
 N D,D0,DI,DIC,DGCODE,DGDR,DGNODE,DGQNODES,DGPC,DGPTND,DGRPS,DGQ,DGX
 N DQ,N,X,Y,%Y,DGPTNDM
 S (DGERR,DGRPS,DGCHANGE)=0
 I '($G(DFN)&$D(DGQCODE)) G QTE
 ; DG*5.3*1143 - Get flag for Real-time address updates and if active, initialize variables used for RTA update
 ; DGRTAHOLD set to 1 so that changes to the addresses are held in local memory and saved together by $$SAVEADDR below
 I +$G(DGRTAON)=0 N DGRTAON S DGRTAON=$$ISRTAUON^DGRTAUPD() I DGRTAON=1 N DGADDEDIT,DGADDGRP1,DGADDGRP2,DGADDGRP3,DGADDGRP4,DGADDGRP5,DGRETRY,DGRTAHOLD S DGRTAHOLD=1
RETRY ; DG*5.3*1143 - Add tag RETRY so on Real-time update failure, the user can retry the edits
 ; Clear the edit array (on Retry)
 I DGRTAON=1 K DGADDEDIT
 F DGX=1:1 S DGQ=$T(QDES+DGX) Q:DGQ[(U_DGQCODE_U)!(DGQ']"")
 F DGPC=2:1 S DGCODE=$P(DGQ,U,DGPC) Q:(DGCODE']"")!(DGCODE=DGQCODE)
 G:DGCODE']"" QTE
 S DGDR=$P($T(QNUM+DGX),U,DGPC)
 S DGRPS=DGDR\100
 S DGQNODES=$P($T(QNODE+DGX),U,DGPC)
 F N=1:1 S DGNODE=$P(DGQNODES,"~",N) Q:DGNODE']""  S DGPTND(DGNODE)=$G(^DPT(DFN,DGNODE))
 S DGQNODES=$P($T(MNODE+DGX),U,DGPC)
 F N=1:1 S DGNODE=$P(DGQNODES,"~",N) Q:DGNODE']""  M DGPTNDM(DGNODE)=^DPT(DFN,DGNODE) S DGPTNDM(DGNODE)=""
 D ^DGRPE
 I $G(DGTMOT)!($G(DGRPOUT)) Q
 ; DG*5.3*1143 - If RTA edit flag is set, save the data
 ;  - if the the update fails, the user can retry if DGRETRY flag is set or quit
 I $D(DGADDEDIT) S DGRETRY=0 I '$$SAVEADDR() G:DGRETRY=1 RETRY  Q
 ;
 F DGNODE=0:0 S DGNODE=$O(DGPTND(DGNODE)) Q:DGNODE']""  S:$G(^DPT(DFN,DGNODE))'=(DGPTND(DGNODE)) DGCHANGE=1
 S DGNODE="" F  S DGNODE=$O(DGPTNDM(DGNODE)) Q:DGNODE']""  D  Q:DGCHANGE
 .S X=0 F  S X=$O(DGPTNDM(DGNODE,X)) Q:'X  D  Q:DGCHANGE
 ..S Y="" F  S Y=$O(DGPTNDM(DGNODE,X,Y)) Q:Y']""  D  Q:DGCHANGE
 ...I $G(^DPT(DFN,DGNODE,X,Y))'=DGPTNDM(DGNODE,X,Y) S DGCHANGE=1
 .Q:DGCHANGE
 .S X=0 F  S X=$O(^DPT(DGNODE,X)) Q:'X  D  Q:DGCHANGE
 ..S Y="" F  S Y=$O(^DPT(DGNODE,X,Y)) Q:Y']""  D  Q:DGCHANGE
 ...I $G(^DPT(DFN,DGNODE,X,Y))'=DGPTNDM(DGNODE,X,Y) S DGCHANGE=1
QTE I 'DGRPS S DGERR=1
QTQ Q
 ;
SAVEADDR() ; DG*5.3*1143 - Save edits made with RTA updates enabled
 ; If successful, quit 1
 ; otherwise return 0 and set DGRETRY=1 if user elects to re-enter the data
 I $$RTASEND^DGRPCADD(DFN) Q 1
 ; Saving of data failed - determine if the user will retry edits
 ; If a timeout occurred
 I $D(DTOUT)!(+$G(DGTMOT)) Q 0
 ; If user entered "^"
 I $D(DUOUT) Q 0
 N X,Y,DIR
ASK ; Prompt user and allow them to correct the address or quit
 S DIR("A")="Enter 'E' to re-enter the data or '^' to quit"
 S DIR(0)="FO"
 S DIR("?")="Enter 'E' to re-edit the data, or '^' to exit and cancel the address entry/edit."
 D ^DIR K DIR
 ; If timeout, set timeout flag
 I $D(DTOUT) S DGTMOT=1 Q 0
 ; If user quit with ^
 I $D(DUOUT) Q 0
 ; User has opted to retry
 I X="E"!(X="e") S DGRETRY=1 Q 0
 G ASK  ; at this point, any other response is not accepted
 ;
QDES ;MNEMONIC - DGQCODE should match with one of these
 ;;^ADD1^ADD2^ADD^ADD3^ADD4^
QNUM ;REFERENCE NUMBERS USED TO SET DGDR FOR USE BY ^DGRPE - DG*5.3*1143 - add commas to end of edit string which DGRPE expects
 ;;^108,^113,^109,113,115,^109,113,114,^114,^
QNODE ;;NODES OF THE PATIENT FILE
 ;;^.11~.13^.121^.11~.121~.13^.11~.121~.13~.141^.141^
 ;;
MNODE ;;MULTIPLES OF THE PATIENT FILE
 ;;^^^.02~.06^.02~.06~.14^.14^
