PXCEPRV ;ISL/dee - Used to edit and display V PROVIDER ;5/10/05 6:23pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**7,27,124**;Aug 12, 1996
 ;
 Q
 ;
 ;Line with the line label "FORMAT"
 ;;Long name~File Number~Node Subscripts~Allow Duplicate entries (1=yes, 0=no)~File global name
 ;     1         2             3                   4                                   5
 ;
 ;Followning lines:
 ;;Node~Piece~,Field Number~Edit Label~Display Label~Display Routine~Edit Routine~Help Text for DIR("?")~Set of PXCEKEYS that can Edit~D if Detail Display Only~
 ;  1  ~  2  ~      3      ~     4    ~        5    ~        6      ~     7      ~       8              ~          9                  ~       10
 ;The Display & Edit routines are for special caces.
 ;  (The .01 field cannot have a special edit.)
 ;
FORMAT ;;Provider~9000010.06~0,12,811,812~0~^AUPNVPRV
 ;;0~1~.01~Provider:  ~Provider:  ~$$DISPLY01^PXCEPRV~EPROV^PXCEPRV~^D HELP^PXCEHELP~~B
 ;;0~4~.04~Is this Provider Primary:  ~Primary:  ~$$DISPPRIM^PXCEPRV~EPRIMSEC^PXCEPRV~~~N
 ;;0~5~.05~Is this Provider Attending:  ~Attending:  ~~EATTEND^PXCEPRV~~~N
 ;;
 ;
 ;The interface for AICS to get list on form for help.
INTRFACE ;;SD SELECT PROVIDER
 ;
 ;********************************
 ;Special cases for display.
 ;
DISPPRIM(PXCEPRIM) ;
 Q $S(PXCEPRIM="P":$$EXTERNAL^DILFD(9000010.06,".04","",PXCEPRIM,"PXCEDILF"),1:"")
 ;
 ;********************************
 ;Special cases for edit.
 ;
EPROV ;
 K DIRUT
 N DIC,DA,PXPRVDT
 S PXPRVDT=+^TMP("PXK",$J,"VST",1,0,"AFTER")
 I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))'="" D
 . N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 . S PXCEINT=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 . S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 . S DIC("B")=$S('$D(DIERR):PXCEEXT,1:PXCEINT)
 S DIC=200
 S DIC(0)="AEMQ"
 S DIC("A")=$P(PXCETEXT,"~",4)
 S DIC("S")="I $$ACTIVPRV^PXAPI(Y,PXPRVDT)"
 D ^DIC
 K DIR
 I $D(DUOUT)!$D(DTOUT)!(X="") S DIRUT=1 Q
 Q:$D(DIRUT)
 S:'($D(X)#2) X=+Y
 Q
 ;
EPRIMSEC ;For Primary/Secondary field only allows one primary.
 ;  Also used by V-POV
 K Y,DTOUT,DUOUT,PXCEPRIM
 ;See if there is already a primary provider in V Provider for this Visit
 S PXCEPRIM=$$PRIMSEC^PXUTL1(PXCEVIEN,PXCEAUPN,$P(PXCETEXT,"~",1),$P(PXCETEXT,"~",2))
 I 'PXCEPRIM S Y="PRIMARY"
 I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))'="" D
 . N DIERR,PXCEDILF,PXCEEXT,PXCEINT
 . S PXCEINT=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 . S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 . S Y=$S('$D(DIERR):PXCEEXT,1:PXCEINT)
 I $D(Y),'PXCEPRIM!($E(Y)="P") D
 . S DIR("B")=$S($E(Y)="P":"YES",1:"NO")
 . S DIR(0)="YAO"
 . S DIR("A")=$P(PXCETEXT,"~",4)
 . S:$P(PXCETEXT,"~",8)]"" DIR("?")=$P(PXCETEXT,"~",8)
 . D ^DIR
 . K DIR,DA
 . S Y=$S(Y:"P",1:"S")
 E  S Y="S"
 I $D(DTOUT)!$D(DUOUT) S (PXCEEND,PXCEQUIT)=1 Q  ;This field is required.
 S $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=$P(Y,"^")
 Q
 ;
EATTEND ;Attending/Operating field only ask for Attending
 S DIR("B")=$S($P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))="A":"YES",1:"NO")
 S DIR(0)="YAO"
 S DIR("A")=$P(PXCETEXT,"~",4)
 S:$P(PXCETEXT,"~",8)]"" DIR("?")=$P(PXCETEXT,"~",8)
 D ^DIR
 K DIR,DA
 I X="@" S Y="@"
 E  I $D(DTOUT)!$D(DUOUT) S PXCEEND=1 Q
 E  I +Y S Y="A"
 E  I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))="A" S Y="@"
 E  S Y=""
 S $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=$P(Y,"^")
 Q
 ;
EPROV12 ;
 K DIRUT
 N DIC,DA,PXPRVDT
 S PXPRVDT=+^TMP("PXK",$J,"VST",1,0,"AFTER")
 I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))'="" D
 . N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 . S PXCEINT=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 . S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 . S DIC("B")=$S('$D(DIERR):PXCEEXT,1:PXCEINT)
 S DIC=200
 S DIC(0)="AEMQ"
 S DIC("A")=$P(PXCETEXT,"~",4)
 S DIC("S")="I $$ACTIVPRV^PXAPI(Y,PXPRVDT)"
 D ^DIC
 K DIR
 I $D(DUOUT)!$D(DTOUT) S PXCEEND=1 Q
 Q:X=""
 S $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=$P(Y,"^")
 ;S:'($D(X)#2) X=+Y
 Q
 ;
 ;********************************
PERCLASS(PXCEPRV) ;Returns text for person class
 N PXCEPERC
 S PXCEPERC=$$OCCUP^PXBGPRV(PXCEPRV,+^AUPNVSIT(PXCEVIEN,0),"",2)
 G PRCL
DPERCLAS(PXCECLAS) ;Returns text for person class
 N PXCEPERC
 S PXCEPERC=$S(PXCECLAS>0:$$OCCUP^PXBGPRV("","","",2,PXCECLAS),1:"")
PRCL ;
 I PXCEPERC="" S PXCEPERC="## No Person Class ##"
 E  I PXCEPERC=-1 S PXCEPERC="!! No Person Class Defined !!"
 E  I PXCEPERC=-2 S PXCEPERC="** No Active Person Class **"
 E  I +PXCEPERC<0 S PXCEPERC=""
 Q PXCEPERC
 ;
 ;********************************
 ;Display text for the .01 field which is a pointer to ^ICPT.
 ;(Must have is called by ASK^PXCEVFI2 and DEL^PXCEVFI2.)
DISPLY01(PXCEPRV) ;
 N DIERR,PXCEDILF,PXCEEPRV,PXCEEPS,PXCEEAO,PXCEPERC,PXCERET
 S PXCEEPRV=$$EXTERNAL^DILFD(9000010.06,".01","",$P(PXCEPRV,"^",1),"PXCEDILF")
 S PXCEEPS=$$EXTERNAL^DILFD(9000010.06,".04","",$P(PXCEPRV,"^",4),"PXCEDILF")
 S PXCEEAO=$$EXTERNAL^DILFD(9000010.06,".05","",$P(PXCEPRV,"^",5),"PXCEDILF")
 S PXCEPERC=$$DPERCLAS($P(PXCEPRV,"^",6))
 S PXCERET=PXCEEPRV_"   "_$S($E(PXCEEPS)="P":PXCEEPS_"   ",1:"")_$S(PXCEEAO]"":PXCEEAO_"   ",1:"")
 S PXCERET=PXCERET_$E(PXCEPERC,1,(65-$L(PXCERET)))
 Q PXCERET
 ;
