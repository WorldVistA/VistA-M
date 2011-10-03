IBDFU91 ;ALB/CJM - ENCOUNTER FORM - transforms needed to validate,display and pass data;AUG 18,1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
OUTPUT(PI,Y) ;xecutes the output transform of the package interface on Y
 ;Y should be passed by reference
 ;the underlying output transform should set Y="" if the transform can not be made
 ;in that case Y is set to "?"
 ;
 I $G(PI),$D(Y) X $G(^IBE(357.6,PI,14)) I Y="" S Y="?"
 Q
 ;
INPUT(PI,X) ;xecutes the input transform of the package interface on X
 ;X should be passed by reference
 ;the underlying input transform:
 ;       can be interactive if $G(IBDEVICE("LISTMAN"))
 ;       should set X to the form needed for passing to the database
 ;       X should be killed if it can not be put into the correct form
 ;       does not guarantee validity - for example, X could be an inactive code
 ;
 I $G(PI),$D(X) X $G(^IBE(357.6,PI,9))
 Q
 ;
CHOICE(PI,X) ;executes the selector of the package interface=PI, user input is X
 ; -- X should be passed by reference.
 ; -- sets IBLABEL,IBID,IBQUAL
 ;
 N DIC,DIE,%,%W,%Y,C,DIPGM,DISYS,I,Q,D,D0,DO,DI,DQ,D1,%X,%Y,Y,DIX,DICR
 ;execute the selector
 I $G(PI) X $G(^IBE(357.6,PI,17))
 Q
 ;
FDCHOICE(PI,X) ;executes the selector of the package interface=PI,X=the user input, then runs it through the input transform for a value that can be passed to the PCE GDI
 ; -- X should be passed by reference.
 ;
 N DIC,DIE,%,%W,%Y,C,DIPGM,DISYS,I,Q,D,D0,DO,DI,DQ,D1,%X,%Y,Y,DIX,DICR,IBLABEL,IBQUAL,IBID
 I $G(PI) D
 .;execute the selector
 .X $G(^IBE(357.6,PI,17))
 .;the selector actually returns the ID for the selection in the variabel IBID - X is the displayable value, which may be different
 .;I $G(IBID)="" K X Q
 .;pass the selection through the input transform
 .I $D(X),$G(IBID)'="" S X=IBID D INPUT(PI,.X)
 Q
 ;
HPTRNS(TYPEDATA,X,IBFORMID) ;used to transform a value read from a hand print field (X) into a value that can be passed to the database
 ;TYPEDATA = data type (file 359.1)
 ;IBFORMID = id in form tracking,should be passed by reference
 ;  available form form tracking:
 ;  IBFORMID("DFN")
 ;  IBFORMID("APPT")
 ;  IBFORMID("CLINIC")
 ;  IBFORMID("SOURCE")
 ;
 ;X = the value that needs to be transformed
 ;returns the transformed value
 ;returns "" if it can not be put inot the correct form
 ;
 ;the underlying input transform:
 ;       should not be interactive
 ;       can use the IBFORMID array
 ;       should set X to the form needed for passing to the database
 ;       X should be killed if it can not be put into the correct form
 ;       does not guarantee validity - for example, X could be an inactive code
 ;
 I '$G(TYPEDATA)!'$D(X) S X="" Q X
 I '$D(^IBE(359.1,TYPEDATA,0)) S X="" Q
 X $G(^IBE(359.1,TYPEDATA,1))
 S:'$D(X) X=""
 Q X
 ;
VALIDATE(PI,X) ;used to validate the value stored with a selection(file 357.3) 
 ;PI is assumed to be a selection type package interface
 ;kills X if not valid, but otherwise does not change it
 ;pass X by reference
 ;the underlying validation transform:
 ;    should not be interactive
 ;    should kill X if it is not valid
 ;
 I X="" K X Q
 I 'PI K X Q
 I '$D(^IBE(357.6,PI,0)) K X Q
 X $G(^IBE(357.6,PI,11))
 Q
 ;
HELP(PI) ;writes the help message for the package interface
 ;
 I PI W !,?6,$G(^IBE(357.6,PI,10)),!
 I PI D CHOICE(PI,"?")
 Q
