RCDPETT ; ePayments/CNF, hrubovcak - epayments Testing Tool;Jul 10, 2014@17:25:29
 ;;4.5;Accounts Receivable;**298**; 20 Dec 2013;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; entered from the top
 D DT^DICRW,HOME^%ZIS  ; kernel variables
 ;
 ; delete any residual data
 K D0,DA,DIC,DIE,DIK,DIR,DR,X,Y,^TMP($J),^TMP("DIERR",$J),^TMP("XMERR",$J)
 N RCMNU,RCOPT  ; menu and option selection
 ;
 ; user's DUZ must be valid
 I '($G(DUZ)>0) W !,$C(7)_"DUZ not defined.",!,"Exiting.",! Q
 I '$L($P(^VA(200,DUZ,0),U,3)) W !,$C(7)_"No Access Code for this User.",!,"Exiting.",! Q
 I $$PROD^XUPROD D NTRY^RCDPETTU("Production Account") G H^XUS
 ;
 D DONOTUSE^RCDPETTU
 ;
 F  S RCMNU=U D  Q:'RCMNU  ; menu option in RCMNU
 .W !!,$J($$NOW^RCDPETTU,30),!   ; displayed every time menu painted
 .N DIR,X,Y S DIR(0)="SAO^1:RET;2:ERA;3:MRA;4:EFT;5:USR;6:FMS;7:REB;8:EXI"
 .S DIR("A")=" Select Option: "
 .S DIR("A",1)="    ePayments Testing Tool Options"
 .S DIR("A",2)=" "  ; blank format line
 .S DIR("A",3)="  1. RET - Retrieve Mail Message"
 .S DIR("A",4)="  2. ERA - EEOB/ERA Options"
 .S DIR("A",5)="  3. MRA - EEOB/MRA Options"
 .S DIR("A",6)="  4. EFT - EFT Options"
 .S DIR("A",8)="  5. USR - User Preferences"
 .S DIR("A",9)="  6. FMS - FMS Acceptance of EFTs"
 .S DIR("A",10)="  7. REB - Re-Establish Bill"
 .S DIR("A",11)="  8. EXI - Exit Menu"
 .S DIR("A",12)=" "  ; blank format line
 .D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 .Q:'$L(Y)  ; user pressed return, will exit
 .S RCMNU=Y
 .I RCMNU=1 D RTRVMSG Q
 .I RCMNU=2 F  S RCOPT=0 D ERAOPT Q:'RCOPT
 .I RCMNU=3 F  S RCOPT=0 D MRAOPT Q:'RCOPT
 .I RCMNU=4 F  S RCOPT=0 D EFTOPT Q:'RCOPT
 .I RCMNU=5 D USRPREF^RCDPETTP Q
 .I RCMNU=6 D ACPT^RCDPETTF Q
 .I RCMNU=7 N PRC D ^PRCAWREA K DTOUT Q
 .I RCMNU=8 W !!,"Exiting Testing Tool.",! S RCMNU=0 Q
 ;
 ; exit
 K ^TMP($J)
 Q
 ;
ERAOPT ; ERA Options
 ;
 D DONOTUSE^RCDPETTU
 D NTRY^RCDPETTU("ERA processing")
 ; RCOPT = desired option
 S RCOPT=U W !!
 ; DIR call - S:set of codes, A:prompt array supplied, O:optional response
 N DIR,X,Y S DIR(0)="SAO^1:D;2:E;3:V;4:C;5:S;6:Q;7:X"
 S DIR("A")=" Select ERA option: "
 S DIR("A",1)="    Electronic Remittance Advice (ERA) Options"
 S DIR("A",2)=" "  ; blank format line
 S DIR("A",3)="  1. D - Delete EEOB Object"
 S DIR("A",4)="  2. E - Edit EEOB Object"
 S DIR("A",5)="  3. V - View EEOB Object"
 S DIR("A",6)="  4. C - Copy EEOB Object"
 S DIR("A",7)="  5. S - Send ERA to VistA"
 S DIR("A",8)="  6. Q - Quick Copy/Edit/Send"
 S DIR("A",9)="  7. X - EXIT ERA Options"
 S DIR("A",10)=" "  ; blank format line
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 S RCOPT=Y ; might be null
 ; ERA action
 D:RCOPT
 .I RCOPT=1 D DEL^RCDPETTE Q
 .I RCOPT=2 D EDMSG^RCDPETTE Q
 .I RCOPT=3 D VWMSG^RCDPETTE Q
 .I RCOPT=4 D COPY^RCDPETTE Q
 .I RCOPT=5 D SNDERA^RCDPETTE Q
 .I RCOPT=6 D QUICK^RCDPETTQ Q
 .I RCOPT=7 S RCOPT="^EXIT" Q  ; evaluate as false
 ;
 Q
 ;
MRAOPT  ; MRA options
 ;
 D DONOTUSE^RCDPETTU
 D NTRY^RCDPETTU("MRA processing")
 ; RCOPT = desired option
 S RCOPT=U W !!
 ; DIR call - S:set of codes, A:prompt array supplied, O:optional response
 N DIR,X,Y S DIR(0)="SAO^1:D;2:E;3:V;4:C;5:S;6:X"
 S DIR("A")=" Select MRA option: "
 S DIR("A",1)="    Medicare Remittance Advice (MRA) Options"
 S DIR("A",2)=" "  ; blank format line
 S DIR("A",3)="  1. D - Delete EEOB Object"
 S DIR("A",4)="  2. E - Edit EEOB Object"
 S DIR("A",5)="  3. V - View EEOB Object"
 S DIR("A",6)="  4. C - Copy EEOB Object"
 S DIR("A",7)="  5. S - Send MRA to VistA"
 S DIR("A",8)="  6. X - EXIT MRA Options"
 S DIR("A",9)=" "  ; blank format line
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 S RCOPT=Y ; might be null
 ; MRA action
 D:RCOPT
 .I RCOPT=1 D DEL^RCDPETTM Q
 .I RCOPT=2 D EDMSG^RCDPETTM Q
 .I RCOPT=3 D VWMSG^RCDPETTM Q
 .I RCOPT=4 D COPY^RCDPETTM Q
 .I RCOPT=5 D SNDMRA^RCDPETTM Q
 .I RCOPT=6 S RCOPT="^EXIT" Q  ; evaluate as false
 ;
 Q
 ;
EFTOPT ; EFT options
 ;
 D DONOTUSE^RCDPETTU
 D NTRY^RCDPETTU("EFT processing")
 ; RCOPT = desired option
 S RCOPT=U W !!
 ; DIR call - S:set of codes, A:prompt array supplied, O:optional response
 N DIR,X,Y S DIR(0)="SAO^1:D;2:E;3:V;4:C;5:S;6:X"
 S DIR("A")=" Select EFT option: "
 S DIR("A",1)="    Electronic Fund Transfer (EFT) Options"
 S DIR("A",2)=" "  ; blank format line
 S DIR("A",3)="  1. D - Delete EFT Detail Line"
 S DIR("A",4)="  2. E - Edit EFT Detail Line"
 S DIR("A",5)="  3. V - View EFT Detail Line"
 S DIR("A",6)="  4. C - Copy EFT Detail Line"
 S DIR("A",7)="  5. S - Send EFT to VistA"
 S DIR("A",8)="  6. X - EXIT EFT Options"
 S DIR("A",9)=" "  ; blank format line
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 S RCOPT=Y ; might be null
 ; EFT action
 D:RCOPT
 .I RCOPT=1 D DEL^RCDPETTF Q
 .I RCOPT=2 D EDMSG^RCDPETTF Q
 .I RCOPT=3 D VWMSG^RCDPETTF Q
 .I RCOPT=4 D COPY^RCDPETTF Q
 .I RCOPT=5 D SNDEFT^RCDPETTF Q
 .I RCOPT=6 S RCOPT="^EXIT" Q  ; evaluate as false
 ;
 Q
 ;
RTRVMSG ; Retrieve MailMan message
 ; RCDA - array of new entry data
 ; RCERR - FileMan error text
 ; RCEOB - array of parsed EEOB messages
 ; RCEXIT - exit flag
 ; RCIMPORT - array for importation options
 ; RCXMZ - MailMan message #
 D DONOTUSE^RCDPETTU
 ;
 N DIR,RCDA,RCERR,RCEOB,RCEOBOPT,RCEXIT,RCXMZ,X,Y
 K ^TMP($J,"RCORIG")  ; clear any residue
 S X="Retrieve MailMan Message" W !!,X,!
 D NTRY^RCDPETTU(X)
 S DIC=3.9,DIC(0)="AEMQZ",DIC("A")="Select MailMan Message: "
 ; must be sent to specific Mail Group
 S DIC("S")="I +$O(^(6,""B"",""G.MCTMSGTEST"",0))"
 D ^DIC I '(Y>0) W !!,"No message selected. Exiting.",! Q
 S RCXMZ=+Y,RCXMZ(0)=Y(0),RCEXIT=0
 ; must have exclusive access
 L +^XMB(3.9,RCXMZ):DILOCKTM E  D
 .W !,"Unable to lock MailMan message #"_RCXMZ S RCEXIT=1
 ;
 Q:RCEXIT
 ; Z parameter: include W-P zero node
 S X=$$GET1^DIQ(3.9,RCXMZ_",",3,"Z",$NA(^TMP($J,"RCORIG")),"RCERR")
 I $D(RCERR) D  ; log error
 .L -^XMB(3.9,RCXMZ)  ; release LOCK, we're exiting
 .W !,"FileMan has returned an error message.",!
 .D LOGARY^RCDPETTU("RCERR") S RCEXIT=1
 ;
 Q:RCEXIT
 ;
 D  ; user questions and parsing
 .K DIR S DIR(0)="YA",DIR("A")="Automatically import? "
 .S DIR("?")="Indicate whether the EEOB text should be imported automatically."
 .; save result in RCDA for new object creation
 .D ^DIR S RCDA("AUTOIMP")=+Y,RCEXIT=$D(DTOUT)+$D(DUOUT)  ; handle timeout or '^'
 .Q:RCEXIT
 .;
 .K DIR S DIR(0)="YA",DIR("A")="Display EEOBs? "
 .S DIR("?")="Indicate whether an EEOB entry should be displayed as it is filed."
 .; use RCEOBOPT("DSPLY") on return
 .D ^DIR S RCEOBOPT("DSPLY")=+Y,RCEXIT=$D(DTOUT)+$D(DUOUT)  ; handle timeout or '^'
 .Q:RCEXIT
 .;
 .D PRSEOB^RCDPETTU(.RCEOB,$NA(^TMP($J,"RCORIG")))
 .S:RCEOB<0 RCEXIT=1  ; parsing error
 .Q:'RCEXIT  ; success
 .; display parsing error
 .W !,"Error processing message."
 .W:$D(RCEOB(-1)) !,"   "_$G(RCEOB(-1))  ; error text
 ;
 ; release exclusive access
 L -^XMB(3.9,RCXMZ)
 Q:RCEXIT  ; problems, exit
 ;
 W !," The MailMan message contained data for "_RCEOB_" bill"_$E("s",RCEOB'=1)_"."
 Q:'RCEOB
 ;
 ; verify we know this object's type, if not then exit
 I '("^ERA^EOB^EFT^"[(U_RCEOB("TYPE")_U)) W !," Message type unknown.  Nothing filed.",! Q
 I RCEOB("TYPE")="EOB" S RCEOB("TYPE")="MRA"   ;MRA header starts with "835EOB", change type to MRA
 ;
 S RCDA("AUTOTXT")=""  ; default text for auto-import
 D:RCDA("AUTOIMP")  ; get text from user
 .K DIR S DIR(0)="FA^3:20",DIR("A")="Enter default EEOB name: "
 .D ^DIR S RCEXIT=$D(DTOUT)+$D(DUOUT) Q:RCEXIT
 .S:Y]"" RCDA("AUTOTXT")=Y  ; response not required
 ;
 Q:RCEXIT  ; timed out or '^' entered
 ;
 ; save message data for new entry
 S RCDA("XMZ")=RCXMZ,RCDA("XMZ",0)=RCXMZ(0)
 D NWOBJ^RCDPETTU(.RCDA,.RCEOB)  ; create new entry or entries
 D:'RCDA("IEN")>0 
 .W !,"Unable to create new entry."  ; new entry IEN
 .N DIR S DIR(0)="EA",DIR("A")="Press Return: " D ^DIR
 ;
 D:RCDA("IEN")>0  ; if new entries created
 .N RCI  ; scratch namespaced variable
 .; display entries if indicated
 .I $G(RCEOBOPT("DSPLY")) S RCI=0 F  S RCI=$O(RCDA("IEN",RCI)) Q:'RCI  D
 ..W !!,"Created entry #"_RCI,!," Name: "_$$GET1^DIQ(344.81,RCI,.01)
 ..N J,DIR,RCWP S X=$$GET1^DIQ(344.81,RCI,2,"Z","RCWP")
 ..W !," Text:"
 ..S J=0 F  S J=$O(RCWP(J)) Q:'J  W !,RCWP(J,0)
 ..W ! S DIR(0)="E" D ^DIR
 .;
 .Q:$G(RCDA("AUTOIMP"))  ; user indicated to auto-import
 .W !!,"You can edit the new entries via FileMan."
 .S RCI=0 F  S RCI=$O(RCDA("IEN",RCI)) Q:'RCI  D   ; edit each entry
 ..W ! N D0,DA,DIC,DIE,DR,X,Y
 ..S DA=RCI,DIE=344.81,DR=".01;.05" D ^DIE
 ..I $D(Y) S RCI=U,RCEXIT=1 Q  ; user exited ^DIE with '^', exit loop
 ..; if user hasn't deleted the new entry set OBJECT STATUS to reviewed
 ..I $D(^RCY(344.81,RCI,0)) S $P(^(1),U,2)=2
 ;
 I 'RCEXIT D:RCDA("IEN")>0  ; delete G.MCTMSGTEST from recipients
 .N DA,DIK
 .; message IEN and RECIPIENT IEN
 .S DA(1)=RCXMZ,DA=+$O(^XMB(3.9,RCXMZ,6,"B","G.MCTMSGTEST",0))
 .Q:'DA  S DIK="^XMB(3.9,"_DA(1)_",6," D ^DIK
 ;
 Q
 ;
