XQOO1 ;SEA/Luke - Out-of-order set calls ;01/28/97  15:00
 ;;8.0;KERNEL;**10,21,39,41,58**;Jul 10, 1995
 ;
OFF(XQSET) ;Mark options and protocols Out Of Order
 N %,DA,XQMESS,XQN,XQKD
 I '$D(^XTMP("XQOO",XQSET,0))#2 S XQSET="^" Q
 S XQMESS=$P(^XTMP("XQOO",XQSET,0),U),XQKD=" is being installed by KIDS"
 ;
 S XQN=0
 F  S XQN=$O(^XTMP("XQOO",XQSET,19,XQN)) Q:XQN=""  D
 .Q:'$D(^DIC(19,XQN,0))#2  S %=$P(^(0),U,3)
 .;quit if KIDS and option already out by nonKIDS user
 .Q:$D(XPDSET)&(%]"")&(%'[XQKD)  S %=$P(%,XQKD)
 .;if KIDS save off current OOO message
 .I $D(XPDSET),%]"",%'=XQSET,$D(^XTMP("XQOO",%)) S $P(^XTMP("XQOO",XQSET,19,XQN),U,3)=%_XQKD
 .S $P(^DIC(19,XQN,0),U,3)=XQMESS,DA=XQN D REDO^XQ7
 .Q
 ;
 S XQN=0
 F  S XQN=$O(^XTMP("XQOO",XQSET,101,XQN)) Q:XQN=""  D
 .Q:'$D(^ORD(101,XQN,0))#2  S %=$P(^(0),U,3)
 .Q:$D(XPDSET)&(%]"")&(%'[XQKD)  S %=$P(%,XQKD)
 .I $D(XPDSET),%]"",%'=XQSET,$D(^XTMP("XQOO",%)) S $P(^XTMP("XQOO",XQSET,101,XQN),U,3)=%
 .S $P(^ORD(101,XQN,0),U,3)=XQMESS
 .Q
 D OUT
 D KICK^XQ7
 Q
 ;
ON(XQSET) ;Remove Out Of Order messages from the set XQSET
 N %,%1,DA,XQN,XQKD
 I '$D(^XTMP("XQOO",XQSET,0))#2 S XQSET="^" Q
 ;
 S XQN=0,XQKD=" is being installed by KIDS"
 F  S XQN=$O(^XTMP("XQOO",XQSET,19,XQN)) Q:XQN=""  S XQMESS=$P(^(XQN),U,3) D
 .Q:'$D(^DIC(19,XQN,0))#2  S %=$P(^(0),U,3),%1=$S($D(XPDSET):$P(XQMESS,XQKD),1:"")
 .;quit if OOO message is set by nonKIDS
 .Q:$D(XPDSET)&(%'[XQKD)  S %=$P(%,XQKD)
 .I $D(XPDSET),%'=XQSET,%]"",$D(^XTMP("XQOO",%)) Q  ;another set has this option
 .;if we have another message to restore, check that set still exist
 .I XQMESS]"" S XQMESS=$S(%1="":"",'$D(^XTMP("XQOO",%1)):"",1:XQMESS)
 .S $P(^DIC(19,XQN,0),U,3)=XQMESS,DA=XQN D REDO^XQ7
 .Q
 ;
 S XQN=0
 F  S XQN=$O(^XTMP("XQOO",XQSET,101,XQN)) Q:XQN=""  S XQMESS=$P(^(XQN),U,3) D
 .Q:'$D(^ORD(101,XQN,0))#2  S %=$P(^(0),U,3),%1=$S($D(XPDSET):$P(XQMESS,XQKD),1:"")
 .Q:$D(XPDSET)&(%'[XQKD)  S %=$P(%,XQKD)
 .I $D(XPDSET),%'=XQSET,%]"",$D(^XTMP("XQOO",%)) Q
 .I XQMESS]"" S XQMESS=$S(%1="":"",'$D(^XTMP("XQOO",%1)):"",1:XQMESS)
 .S $P(^ORD(101,XQN,0),U,3)=XQMESS
 .Q
 ;
 I '$D(XPDSET) D
 .S DIR(0)="Y",DIR("B")="Y"
 .S DIR("A")="Should I remove the option set "_XQSET_" from ^XTMP?"
 .S DIR("?")=XQSET_" is the list of options and/or protocols you just turned on."
 .D ^DIR
 .I Y K ^XTMP("XQOO",XQSET)
 .K DIR,Y
 .Q
 D OUT
 D KICK^XQ7
 Q
 ;
ADD(XQSET,XQFIL,XQN) ;New option/protocol - add to set and mark it OOO
 ;Called by KIDS during a build
 I '$D(^XTMP("XQOO",XQSET,0)) S XQSET="^" D OUT Q
 S XQMESS=$P(^XTMP("XQOO",XQSET,0),U)
 S XQGL=$S(XQFIL=19:"^DIC(",1:"^ORD(")
 S %=@(XQGL_XQFIL_","_XQN_",0)"),^XTMP("XQOO",XQSET,XQFIL,XQN)=$P(%,U)_"^"_$P(%,U,2)
 S %=XQGL_XQFIL_","_XQN_",0)",$P(@%,U,3)=XQMESS
 D OUT
 Q
 ;
KIDS(XQSET,XQFIL,XQNAME,XQFLAG) ;Turn on/off an option or protocol
 ;Called only from KIDS during an install so OERR would work
 ;XQFLAG is set to 0 to put an option or protocol out of order,
 ;1 to turn it on, and I return it as -1 if the request 
 ;fails.
 ;
 N XQGL,XQMESS,XQMES2,XQN
 I '$D(^XTMP("XQOO",XQSET)) S XQFLAG=-1 Q
 S XQGL=$S(XQFIL=19:"^DIC(19)",XQFIL=101:"^ORD(101)",1:"")
 I XQGL="" S XQFLAG=-1 Q
 I XQNAME=+XQNAME S XQN=XQNAME
 E  D  I XQFLAG<0 Q
 .S XQN=$O(@XQGL@("B",XQNAME,0)) I XQN'>0 S XQFLAG=-1
 .Q
 S %=@XQGL@(XQN,0) S XQMES2=$P(%,U,3)
 S XQMESS=$P(^XTMP("XQOO",XQSET,0),U)
 I XQMESS=XQMES2 S XQMES2=""
 I '$D(^XTMP("XQOO",XQSET,XQFIL,XQN)) S ^XTMP("XQOO",XQSET,XQFIL,XQN)=$P(@XQGL@(XQN,0),U)_U_$P(^(0),U,2)
 ;
 I 'XQFLAG D
 .I XQMES2]"" S $P(^XTMP("XQOO",XQSET,XQFIL,XQN),U,3)=XQMES2
 .S $P(@XQGL@(XQN,0),U,3)=XQMESS
 .Q
 I XQFLAG D
 .S $P(@XQGL@(XQN,0),U,3)=""
 .Q
 ;
OUT ;Exit point
 K %,XQFIL,XQGL,XQMESS,XQN,XQS
 Q
 ;
OFFOP ;Option entry for turning off options
 W !
 S XQSET=""
 D GETSET(.XQSET)
 I XQSET]"" D
 .S DIR(0)="Y",DIR("B")="N"
 .S DIR("A")="Mark the options in "_XQSET_" Out-Of Order now"
 .S DIR("?")="If you answer ""Yes"" you will mark all the options in the set "_XQSET_" Out Of Order."
 .D ^DIR
 .I Y D OFF(XQSET)
 .K DIR,X,Y
 .Q
 Q
 ;
 ;
ONOP ;Option entry for turning on options
 S XQSET=""
 D GETSET(.XQSET)
 I XQSET]"" D
 .S DIR(0)="Y",DIR("B")="Y"
 .S DIR("A")="Return options in "_XQSET_" to general use"
 .S DIR("?")="If you answer ""Yes"" you will remove the Out-Of-Order message from the options in the set "_XQSET
 .D ^DIR
 .I Y D ON(XQSET)
 .K DIR,X,Y
 .Q
 D KICK^XQ7
 Q
 ;
GETSET(XQSET) ;Get the name of the option set in question
 I '$D(^XTMP("XQOO")) W !!,"There are currently no option sets definded in ^XTMP." Q
 S XQI=0
 D SETS^XQOO2(.XQI)
 I XQI=1 S XQSET=0,XQSET=$O(^XTMP("XQOO",XQSET)) Q
 I XQI>1 D
 .S DIR(0)="NO^1:"_XQI,DIR("B")=XQI
 .S DIR("A")=" Please enter the number of the option set you want"
 .S DIR("?")=" Which option set do you want to work with? 1, "_XQI_" etc."
 .W !
 .D ^DIR
 .S XQSET=0 F XQI=1:1:+Y S XQSET=$O(^XTMP("XQOO",XQSET))
 .Q
 K XQI
 Q
 ;
 ;
REBLD ;Rebuild a "lost" set of options and protocols
 N XQ,XQMESS,XQOP,XQPROT,XQSET
 S (XQOP,XQPROT)=0
 ;
 S DIR(0)="F^3:30"
 S DIR("A")=" Please enter the exact Out-Of-Order message"
 S DIR("?")=" All options/protocols with this message are reclaimed into a set in ^XTMP"
 D ^DIR G:$D(DIRUT) OUTRE
 S XQMESS=X K DIR
 ;
RE1 S DIR(0)="F^1:20"
 S DIR("A")=" What do you want to name the recovered set? "
 S DIR("?")=" Enter any name of up to 20 characters"
 D ^DIR G:$D(DIRUT) OUTRE
 S XQSET=X K DIR
 I $D(^XTMP("XQOO",XQSET,0)) D  G RE1
 .W !,"Sorry, that set already exists.  Use the Create/Modify option to"
 .W !?3,"modify it, or choose another name."
 .Q
 ;
REFIND ;Find options and protocols with the message XQMESS
 S XQ=0 F  S XQ=$O(^DIC(19,XQ)) Q:XQ'=+XQ!(XQ="")  D
 .Q:$P(^DIC(19,XQ,0),U,3)'=XQMESS
 .S ^XTMP("XQOO",XQSET,19,XQ)=$P(^DIC(19,XQ,0),U)_U_$P(^(0),U,2)
 .S XQOP=XQOP+1
 .Q
 ;
 S XQ=0 F  S XQ=$O(^ORD(101,XQ)) Q:XQ'=+XQ!(XQ="")  D
 .Q:$P(^ORD(101,XQ,0),U,3)'=XQMESS
 .S ^XTMP("XQOO",XQSET,101,XQ)=$P(^ORD(101,XQ,0),U)_U_$P(^(0),U,2)
 .S XQPROT=XQPROT+1
 .Q
 ;
 I XQOP>0!(XQPROT>0) D  G OUTRE
 .D ^XQDATE
 .S %=$P(^VA(200,DUZ,0),U),%=$P(%,",")
 .S ^XTMP("XQOO",XQSET,0)=XQMESS_U_%Y_U_%
 .S ^XTMP("XQOO",0)=DT+7
 .W !!,"Set named ",XQSET," recovered with ",XQOP," options and ",XQPROT," protocols."
 .Q
 E  W !!,"No options or protocols with the message ",XQMESS," were found." G OUTRE
 Q
 ;
OUTRE ;Exit point for REBLD
 K %,%Y,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,XQ,XQMESS,XQOP,XQPROT,XQSET,Y
 Q
 ;
TOG ;Toggle options and protocols on and off. (XQOOTOG option)
 N XQ
 D T1,OUTT,T2,KICK^XQ7
 ;
OUTT ;Exit for XQOOTOG
 K DIC,DTOUT,DUOUT,X,Y
 Q
 ;
T1 ;Toggle options
 S DIC=19,DIC(0)="AEMQZ",DIC("A")="Enter the name or menu text of an option: "
 F  W ! D ^DIC Q:$D(DTOUT)!$D(DUOUT)!(Y<0)  D
 .S XQ=+Y,XQ0=Y(0)
 .I $P(XQ0,U,3)]"" D
 ..S XQMESS=$P(XQ0,U,3)
 ..W !!,"Option ",$P(Y(0),U)," is out with the message '",XQMESS,"'",!
 ..S DIR(0)="Y",DIR("A")="Put it in service",DIR("B")="YES"
 ..S DIR("?")="If you answer 'YES' the out-of-order message will be killed, putting the option back in service."
 ..D ^DIR
 ..I Y S $P(^DIC(19,XQ,0),U,3)="",DA=XQ D REDO^XQ7
 ..K DIR,X,Y
 ..Q
 .E  W ! D
 ..S DIR(0)="FA^3:50",DIR("A")="Enter a message to put this option out of order: "
 ..S DIR("?")="This option is in service.  Enter a string to remove it from use."
 ..K DIRUT D ^DIR
 ..I '$D(DIRUT) S $P(^DIC(19,XQ,0),U,3)=Y,DA=XQ D REDO^XQ7
 ..K DIR,DIRUT,X,Y
 ..Q
 .Q
 Q
 ;
T2 ;Toggle protocols
 S DIC=101,DIC(0)="AEMQZ",DIC("A")="Enter the name or menu text of a protocol: "
 F  W ! D ^DIC Q:$D(DTOUT)!$D(DUOUT)!(Y<0)  D
 .S XQ=+Y,XQ0=Y(0)
 .I $P(XQ0,U,3)]"" D
 ..S XQMESS=$P(XQ0,U,3)
 ..W !!,"Protocol ",$P(Y(0),U)," is out with the message '",XQMESS,"'",!
 ..S DIR(0)="Y",DIR("A")="Put it in service",DIR("B")="YES"
 ..S DIR("?")="If you answer 'YES' the out-of-order message will be killed, putting the option back in service."
 ..D ^DIR
 ..I Y S $P(^ORD(101,XQ,0),U,3)=""
 ..K DA,DIR,X,Y
 ..Q
 .E  W ! D
 ..S DIR(0)="FA^3:50",DIR("A")="Enter a message to put this protocol out of order: "
 ..S DIR("?")="This protocol is in service.  Enter a string to remove it from use."
 ..K DIRUT D ^DIR
 ..I '$D(DIRUT) S $P(^ORD(101,XQ,0),U,3)=Y
 ..K DIR,DIRUT,X,Y
 ..Q
 .Q
 Q
