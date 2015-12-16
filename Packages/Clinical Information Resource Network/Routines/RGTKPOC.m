RGTKPOC ;BIRMIO/CML-Establish Visitor Record for TK POC ;25-NOV-14
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**62**;30 Apr 99;Build 3
 ;
 ;Reference to ^XWB2HL7 supported by IA #3144
 ;Reference to ^XWBDRPC supported by IA #3149
 ;Reference to GET^XUESSO1 supported by IA #4342
 ;
 ; This routine was created new for I13 (MVI_CR4999) DG*5.3*62 (cml and cmc).
 ; It is called by a new option "ToolKit POC User Setup" [RG TK POC USER SETUP]
 ; that calls a new RPC (MPI TK POC USER SETUP) that accesses the MPI to establish a Visitor Record in the New Person file (#200).
 ; Just calling the RPC will establish the Visitor record if one didn't exist.  It will then update the ToolKit user with the
 ; DUZ from the MPI, SSN and NT username.
 ;
 ; The RPC will identify any missing required fields in the New Person file and instruct the user to check their setup in the New Person
 ; file to be sure they have Name, SSN ,Network Username and phone contact number.
 ; - If a problem is detected they will need to use the Edit an Existing User option on the User Management menu or contact IRM if needed.
 ; - If they have all the required fields the user will get a message back that all is good  
 ;
 W @IOF
 W !!,"This option allows you to create a Visitor Record in the New Person file on"
 W !,"the MPI production account.  The purpose of this action is to accomplish the"
 W !,"first step toward establishing your ToolKit POC remote view access. Once this"
 W !,"action is completed successfully you will have the ability to use the new tools."
 W !!,"Note: It is important that prior to using this option you be set up correctly"
 W !,"as a user in your local New Person file (#200).  You should verify your user"
 W !,"record has the correct Name, SSN, Network Username and Phone Contact Number."
 ;
 W !!,"Attempting to establish Visitor Record on MPI..."
 N SITE,IEN,USER,NAME,NTNAME,PHONE,SSN,USR
 S SITE="200M"
 K RETURN
 S USR=$$GET^XUESSO1(DUZ) ;USER=ssn^name^station name^station number^DUZ^phone^vpid^NETWORK USERNAME
 I +USR=-1 W !!,"<Missing data> - ",$P(USR,"^",2),!,"Please populate this data via the User Management menu." G QUIT
 I $P(USR,"^",8)="" W !!,"<Missing Network Username> - please populate this field via the User Management",!,"menu as it is required for mapping your VistA account to your ToolKit account." G QUIT
 S NAME=$P(USR,"^",2),SSN=$P(USR,"^"),NTNAME=$P(USR,"^",8),PHONE=$P(USR,"^",6)
 D EN1^XWB2HL7(.RETURN,SITE,"MPI TK POC USER SETUP",1,NAME_"~"_SSN_"~"_NTNAME_"~"_PHONE)
 I RETURN(0)="" W !!,"Attempt was unsuccessful: "_$P(RETURN(1),"^",2) G QUIT
 ;Else RPC successful, RETURN(0) has IEN for other calls.
 S IEN=RETURN(0)
 ; Retrieve data
 N CNT
 F CNT=1:1:10 D RPCCHK^XWB2HL7(.RET,IEN) Q:+RET(0)=1  Q:+RET(0)=-1  H 2
 I +RET(0)=-1 W !!,"Attempt was unsuccessful: "_$S($P(RET(0),"^",2)["Handle":"Error in Process",1:$P(RET(0),"^",2)) G QUIT
 I +RET(0)'=1 W !!,"Attempt was unsuccessful, unable to get data after 10 attempts." G QUIT
 ;
 ; Get results
 K RET D RTNDATA^XWBDRPC(.RET,IEN)
 I +RET(0)=1 W !!,"Your Visitor Record was successfully established, ",!,"and your ToolKit user profile updated."
 I +RET(0)'=1 W !!,"There was an issue with your record ",RET(0),!,"Please report this to HC IdM for assistance."
 ;
QUIT ;
 W !! S DIR(0)="E" D ^DIR K DIR
 Q
