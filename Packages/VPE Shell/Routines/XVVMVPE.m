XVVMVPE ;DJB/VPE**Edit PERSON ;2017-08-16  11:00 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
EN ;
 NEW FLAGQ,XVVPERI,XVVPERN
TOP W @IOF
 W !,"*** ENTER/EDIT PERSON ***",!
 S FLAGQ=0
 D GETPER G:FLAGQ EX
 D EDIT
 G TOP
EX ;
 Q
 ;
GETPER ;Select a Person
 ;Return:
 ;   XVVPERI...Person IEN
 ;   XVVPERN...Person name
 ;   FLAGQ.....Quit variable
 ;
 NEW %,%Y,DDH,DIC,X,Y
 S DIC="^XVV(19200.111,"
 S DIC(0)="QEAML"
 S DIC("A")="Select PERSON: "
 D ^DIC I Y<0 S FLAGQ=1 Q
 S XVVPERI=+Y,XVVPERN=$P(Y,"^",2)
 Q
 ;
EDIT ;Edit Person
 NEW DA,DIERR,DIMSG,DINUM,DR,DTOUT,DUTOUT,I
 NEW DDSFILE,DDSPAGE,DDSPARM,DDSSAVE,DIERR
 ;
 S DDSFILE=19200.111
 S DA=XVVPERI
 S DR="[XVVM PER]"
 S DDSPARM="CE"
 D ^DDS
 I $G(DIERR) D DDSERR Q  ;... process error & quit
 Q
 ;
DDSERR ;Form couldn't load
 NEW I
 W @IOF,!!,"Screenman couldn't load this form."
 S I=0
 F  S I=$O(^TMP("DIERR",$J,1,"TEXT",I)) Q:I'>0  W !,^(I)
 D PAUSE^XVEMKU(2,"R")
 KILL ^TMP("DIERR",$J)
 Q
