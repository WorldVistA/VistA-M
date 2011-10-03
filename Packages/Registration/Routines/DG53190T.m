DG53190T ; ALB/SCK - UTILITY TO CREATE RAI/MDS SUBSCRIBER PROTOCOLS ; 10-14-99
 ;;5.3;Registration;**190,357,416**;Aug 13, 1993
 ;
EN ;
 N DGSTN,FDA,DIR,ERR,HLLP,DGDIV,DGSCN,DGTEST,DGX,DGABRT,HLAPP,HLLINK,DGABRT,I,X,Y,DGIP,DGPORT
 ;
 W @IOF
 F I=0:1 S DGX=$P($T(TEXT+I),";;",2) Q:DGX="$END"  W !,DGX
 S DIR(0)="YA",DIR("B")="NO",DIR("A")="Do you wish to continue? "
 S DIR("?")="Enter Yes to continue, or No to quit"
 D ^DIR K DIR
 Q:'Y!$D(DIRUT)
 ;
 F DGX="DIV","SETIP","870","771","408","101","DEM","MFU","FIN" D @DGX  Q:$G(DGABRT)
 Q
 ;
DIV ;
 W !
 N DIR,DIRUT
 S DIR(0)="PO^40.8:EMZ"
 S DIR("A",1)="Enter the Division you are setting up the"
 S DIR("A")="RAI/MDS HL7 messaging for"
 S DIR("?")="Select the appropriate division to set up the HL7 messaging parameters for."
 D ^DIR K DIR I $D(DIRUT)!(+Y'>0) S DGABRT=1 Q
 S DGDIV=Y
 S DGSTN=$$SITE^VASITE($$NOW^XLFDT,+DGDIV)
 ;
 W !!?4,"You have selected : ",$P(DGDIV,"^",2)
 W !?4,"Station Number    : ",$S(+DGSTN>0:$P(DGSTN,"^",3),1:"Undefined Station Number"),!
 ;
 I +DGSTN<0 D  G DIV
 . W !?4,"You cannot proceed with this division until the station number is"
 . W !?4,"corrected.  Check the STATION NUMBER TIME SENSITIVE"
 . W !?4,"file to be sure this division is active today."
 . W !?4,"You may select another division or quit.",!
 ;
 N DIR,DUOUT,DTOUT
 ;
 S DIR(0)="YAO",DIR("A")="Is this correct? ",DIR("B")="YES"
 S DIR("?")="Enter Yes or No, Yes will select, No will cancel."
 D ^DIR K DIR Q:$D(DUOUT)!($D(DTOUT))
 G:'Y DIV
 W !
 Q
 ;
SETIP ; Get IP address and port number
 N ERR,RSLT,FDA,DIR,DIRUT
 ;
IP S DIR(0)="FAO",DIR("A")="Enter IP address of target COTS receiver: "
 S DIR("?",1)="The IP address must be in the format 'nnn.nnn.nnn.nnn' where"
 S DIR("?",2)="nnn is a numeric, 1-3 numbers in length and should designate"
 S DIR("?")="the static IP address for the COTS database server."
 D ^DIR K DIR
 Q:$D(DIRUT)
 ;
 G:$P(Y,".",1)'?1.3N IP
 G:$P(Y,".",2)'?1.3N IP
 G:$P(Y,".",3)'?1.3N IP
 G:$P(Y,".",4)'?1.3N IP
 S DGIP=$G(Y)
PORT ;
 N DIR
 S DIR(0)="FAO",DIR("A")="Enter the port number of the target COTS receiver: "
 S DIR("?",1)="The port number must be a numeric value and should be"
 S DIR("?")="the TCP/IP port the target COTS receiver is listening on."
 D ^DIR K DIR
 Q:$D(DIRUT)
 ;
 G:Y'?1N.N PORT
 S DGPORT=$G(Y)
 Q
 ;
870 ; Create HL7 Logical Link
 N ERR,RSLT,FDA,DGLLP,DGLNK
 ;
 S DGLNK="DGRU"_$P(DGSTN,"^",3) ; Check for existing Logical Link
 I $$FIND1^DIC(870,"","MX",DGLNK)>0 D  Q
 . W !?4,"A Logical Link for ",DGLNK," already exists."
 ;
 ; Set up the logical link
 K FDA
 S FDA(1,870,"+1,",.01)=DGLNK
 S FDA(1,870,"+1,",4.5)=1
 S FDA(1,870,"+1,",2)="TCP"
 S FDA(1,870,"+1,",3)="NC" ;p-416
 S FDA(1,870,"+1,",200.021)="R" ;added p-416
 S FDA(1,870,"+1,",200.05)=20
 S FDA(1,870,"+1,",200.08)=2.3
 S FDA(1,870,"+1,",400.01)=DGIP
 S FDA(1,870,"+1,",400.02)=DGPORT
 S FDA(1,870,"+1,",400.03)="C"
 S FDA(1,870,"+1,",400.04)="N" ;p-416
 ;
 D UPDATE^DIE("E","FDA(1)","RSLT","ERR(1)")
 I $D(ERR) D  Q
 . W !,DGLNK,": " D MSG^DIALOG("WM","","",4,"ERR(1)")
 . S DGABRT=1
 S HLLINK=RSLT(1)
 Q
 ;
771 ; Create HL7 application
 N ERR,RSLT,FDA,DGNAME
 ;
 ; Retrieve ien of HL7 messaging mail group
 S DIC=3.8,DIC(0)="MZ",X="DGRU ADT/HL7"
 D ^DIC K DIC
 S DGMAIL=$G(Y(0,0))
 ;
 K FDA
 S DGNAME="DGRU-"_$P(DGSTN,"^",2)
 S:$L(DGNAME)>15 DGNAME=$E(DGNAME,1,15)
 ; Check for existing HL7 Application
 S HLAPP=$$FIND1^DIC(771,"","MX",DGNAME) I HLAPP>0 D  Q  ;p-416
 . W !?4,"A HL7 Application for ",DGNAME," already exists."
 ;
 S FDA(1,771,"+1,",.01)=DGNAME
 S FDA(1,771,"+1,",3)=$P(DGSTN,"^",3)
 S FDA(1,771,"+1,",4)=DGMAIL
 S FDA(1,771,"+1,",7)="USA"
 ;
 D UPDATE^DIE("E","FDA(1)","RSLT","ERR(1)")
 I $D(ERR) D  Q
 . W !,DGNAME,": " D MSG^DIALOG("WM","","",4,"ERR(1)")
 . S DGABRT=1
 S HLAPP=RSLT(1)
 Q
 ;
408 ; Create subscription registry entry
 N ERR,RSLT,FDA,DGSCN,DGLL,DGAP
 ;
 S DGSCN=$$ACT^HLSUB
 I '$D(HLAPP)!('$D(HLLINK)) D  Q
 . W !?4,"HL7 Application data not available"
 ;
 S DGLL=$$GET1^DIQ(870,HLLINK,.01)
 S DGAP=$$GET1^DIQ(771,HLAPP,.01)
 ;
 D UPD^HLSUB(DGSCN,DGLL,2,,,DGAP,.ERR)
 I $D(ERR) D  Q
 . W !,DGSCN,": " D MSG^DIALOG("WM","","",4,"ERR(1)")
 . S DGABRT=1
 ;
 S FDA(1,40.8,+DGDIV_",",900.01)=DGSCN
 ;
 K ERR D FILE^DIE("","FDA(1)","ERR")
 I $D(ERR) D
 . W ! D MSG^DIALOG("WM","","",4,"ERR(1)")
 . S DGABRT=1
 Q
 ;
101 ; Create subscriber protocols
 N EVNT,FDA,ERR,RSLT,DGNAME,IEN,DGCLIENT
 ;
 S IEN=0
 F EVNT="A01","A02","A03","A11","A12","A13","A21","A22","A08" D  Q:$G(DGABRT)
 . S IEN=IEN+1
 . S DGNAME="DGRU-RAI-"_EVNT_"-"_HLAPP ;changed p-357
 . ;Check for existing protocol
 . I $$FIND1^DIC(101,"","MX",DGNAME)>0 D  Q
 . . W !?4,"A protocol for ",DGNAME," already exists."
 . ;
 . S FDA(1,101,"+"_IEN_",",.01)=DGNAME
 . S FDA(1,101,"+"_IEN_",",1)=EVNT_" CLIENT PROTOCOL FOR "_$P(DGSTN,"^",2)
 . S FDA(1,101,"+"_IEN_",",4)="subscriber"
 . S FDA(1,101,"+"_IEN_",",12)="REGISTRATION"
 . S DGCLIENT="DGRU-"_$P(DGSTN,"^",2)
 . S:$L(DGCLIENT)>15 DGCLIENT=$E(DGCLIENT,1,15)
 . S FDA(1,101,"+"_IEN_",",770.2)=DGCLIENT
 . S FDA(1,101,"+"_IEN_",",770.3)="ADT"
 . S FDA(1,101,"+"_IEN_",",770.4)=EVNT
 . S FDA(1,101,"+"_IEN_",",770.7)="DGRU"_$P(DGSTN,"^",3)
 . S FDA(1,101,"+"_IEN_",",770.11)="ADT"
 . S FDA(1,101,"+"_IEN_",",771)="Q"
 . S FDA(1,101,"+"_IEN_",",773.1)="YES"
 . S FDA(1,101,"+"_IEN_",",773.2)="YES"
 . K ERR,RSLT
 . D UPDATE^DIE("E","FDA(1)","RSLT","ERR(1)")
 . I +$G(RSLT(IEN))>0 D
 . . S DIE=101,DR="770.95////2.3",DA=RSLT(IEN) D ^DIE K DIE
 . I $D(ERR) D
 .. W ! D MSG^DIALOG("WM","","",4,"ERR(1)")
 .. S DGABRT=1
 Q
 ;
DEM ;
 N FDA,RSLT,ERR,DGNAME,DGCLIENT,DGTXT
 ;
 S DGNAME="DGRU-PATIENT-A08-"_HLAPP ;changed p-357
 S FDA(1,101,"+1,",.01)=DGNAME
 ; Check for existing protocol
 I $$FIND1^DIC(101,"","MX",DGNAME)>0 D  Q
 . W !?4,"A protocol for ",DGNAME," already exists."
 ;
 S DGTXT="A08 DEMOGRAPHIC UPDATES CLIENT PROTOCOL FOR "_$P(DGSTN,"^",2)
 S:$L(DGTXT)>62 DGTXT=$E(DGTXT,1,62)
 S FDA(1,101,"+1,",1)=DGTXT
 S FDA(1,101,"+1,",4)="subscriber"
 S FDA(1,101,"+1,",12)="REGISTRATION"
 S DGCLIENT="DGRU-"_$P(DGSTN,"^",2)
 S:$L(DGCLIENT)>15 DGCLIENT=$E(DGCLIENT,1,15)
 S FDA(1,101,"+1,",770.2)=DGCLIENT
 S FDA(1,101,"+1,",770.3)="ADT"
 S FDA(1,101,"+1,",770.4)="A08"
 S FDA(1,101,"+1,",770.7)="DGRU"_$P(DGSTN,"^",3)
 S FDA(1,101,"+1,",770.11)="ADT"
 S FDA(1,101,"+1,",771)="Q"
 S FDA(1,101,"+1,",773.1)="YES"
 S FDA(1,101,"+1,",773.2)="YES"
 K ERR,RSLT
 D UPDATE^DIE("E","FDA(1)","RSLT","ERR(1)")
 I $D(ERR) D  Q
 . W ! D MSG^DIALOG("WM","","",4,"ERR(1)")
 . S DGABRT=1
 ;
 I +$G(RSLT(1))>0 D
 . S DIE=101,DR="770.95////2.3",DA=RSLT(1) D ^DIE K DIE
 Q
 ;
MFU ;
 N FDA,RSLT,ERR,DGNAME,DGCLIENT,DGTXT
 S DGNAME="DGRU-RAI-MFU-"_HLAPP
 ; Check for existing protocol
 I $$FIND1^DIC(101,"","MX",DGNAME)>0 D  Q
 . W !?4,"A protocol for ",DGNAME," already exists."
 ;
 S FDA(1,101,"+1,",.01)=DGNAME
 S DGTXT="MFU CLIENT PROTOCOL FOR "_$P(DGSTN,"^",2)
 S:$L(DGTXT)>62 DGTXT=$E(DGTXT,1,62)
 S FDA(1,101,"+1,",1)=DGTXT
 S FDA(1,101,"+1,",4)="subscriber"
 S FDA(1,101,"+1,",12)="REGISTRATION"
 S DGCLIENT="DGRU-"_$P(DGSTN,"^",2)
 S:$L(DGCLIENT)>15 DGCLIENT=$E(DGCLIENT,1,15)
 S FDA(1,101,"+1,",770.2)=DGCLIENT
 S FDA(1,101,"+1,",770.3)="MFN"
 S FDA(1,101,"+1,",770.4)="M01"
 S FDA(1,101,"+1,",770.7)="DGRU"_$P(DGSTN,"^",3)
 S FDA(1,101,"+1,",770.11)="MFN"
 S FDA(1,101,"+1,",771)="Q"
 S FDA(1,101,"+1,",773.1)="YES"
 S FDA(1,101,"+1,",773.2)="YES"
 K ERR,RSLT
 D UPDATE^DIE("E","FDA(1)","RSLT","ERR(1)")
 I $D(ERR) D  Q
 .W ! D MSG^DIALOG("WM","","",4,"ERR(1)")
 .S DGABRT=1
 I +$G(RSLT(1))>0 D
 .S DIE=101,DR="770.95////^S X=2.3",DA=RSLT(1) D ^DIE K DIE
 Q
 ;
FIN ;
 W !!?4,"Setup complete"
 Q
 ;
TEXT ;;This routine will setup the necessary HL7 messaging parameters and client 
 ;;protocols for the selected division for the RAI/MDS Commercial-Off-The-Shelf 
 ;;system.  This is required in order to correctly handle the dynamic addressing
 ;;used by VistA to process HL7 messages to the COTS system.
 ;;
 ;;THIS ROUTINE SHOULD ONLY BE EXECUTED WHEN NEW DIVISIONS USING RAI/MDS NEED TO BE INITIALIZED.
 ;;
 ;;$END
