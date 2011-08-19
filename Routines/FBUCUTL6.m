FBUCUTL6 ;ALBISC/TET - UTILITY (continued) ;10/28/93  15:56
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
AUTH(FBUCP,FBUCA) ;determine if authorization file needs updating, based on
 ;change in disposition or other info impacting authorization
 ;INPUT:  FBUCP = zero node of 162.7 prior to enter/edit
 ;        FBUCA = zero node of 162.7 after enter/edit
 ;OUTPUT:  0 for deletion/1 for addition/2 for change/NULL for no action
 ;               (if function follows null update file)
 N FBAUTH I $P(FBUCA,U,11)=$P(FBUCP,U,11) D  G AUTHQ
 .;if disposition remained the same do further checking for app/app to stabilization claims
 .;if either auth from/to dates,program,vendor,patient type changed, update auth
 .;if dx change auth should also be updated (in 3.5 or 4)
 .I '($P(FBUCA,U,11)=1!($P(FBUCA,U,11)=4)) Q
 .S FBAUTH=$S($P(FBUCP,U,13,14)'=$P(FBUCA,U,13,14):2,$P(FBUCP,U,2,3)'=$P(FBUCA,U,2,3):2,$P(FBUCP,U,10)'=$P(FBUCA,U,10):2,1:"")
 .;include dx in future
 .Q
 N FBD1,FBD2
 S FBD1=$P(FBUCP,U,11),FBD2=$P(FBUCA,U,11)
 I FBD2=1!(FBD2=4) S FBAUTH=$S('FBD1:1,FBD1=1!(FBD1=4):2,1:1)
 I FBD2=2!(FBD2=3)!(FBD2=5)!('FBD2) S FBAUTH=$S(FBD1=1!(FBD1=4):0,1:"")
 ;S FBAUTH=$S(FBAUTH=2&($P(FBUCA,U,13,14)=$P(FBUCP,U,13,14)):"",FBAUTH']""&($P(FBUCA,U,13,14)'=$P(FBUCP,U,13,14)):2,1:FBAUTH)
 I FBAUTH']""!(FBAUTH=2),FBD2=1!(FBD2=4) S FBAUTH=$S($P(FBUCP,U,2,3)'=$P(FBUCA,U,2,3):2,$P(FBUCP,U,10)'=$P(FBUCA,U,10):2,$P(FBUCP,U,13,14)'=$P(FBUCA,U,13,14):2,1:FBAUTH)
AUTHQ K FBD1,FBD2 Q $G(FBAUTH)
CKAUTH(FBUCP,FBUCA,FBDA) ;check authorization dates if auth is approved or approved to stabilization
 ;called after the AFTER event
 ;check is necessary as these fields are required in order to set up authorization.
 ;if not there, disposition is reverted back to previous and message sent.
 ;INPUT:  FBUCP = prior node
 ;        FBUCA = after node
 ;        FBDA  = internal entry of u/c in 162.7
 ;OUPUT:  message to user if disposition has been reverted back
 ;VARIABLES: BACK = 1 if reverted to another dispo, otherwise '@'
 ;           FBAFR & FBATO = auth from/to dates
 ;           FBD1 & FBD2 = pre and post disposition
 ;           FBAMT = amount approved
 N BACK,DR,FBAMT,FBD,FBD1,FBD2,FBFR,FBTO
 I $S($G(FBUCP)']"":1,$G(FBUCA)']"":1,'+$G(FBDA):1,1:0) G CKAUTHQ
 S FBD1=$P(FBUCP,U,11),FBD2=$P(FBUCA,U,11)
 ;if disposition is not approved or approve to stab then quit,
 ; if disp is approv or approv to stab and auth fr/to dates incomplete then quit
 I $S('(FBD2=1!(FBD2=4)):1,+$P(FBUCA,U,13)&(+$P(FBUCA,U,14)):1,1:0) G CKAUTHQ
 S BACK=$S(FBD1:1,1:0),FBD=$S(BACK:+$P(FBUCP,U,11),1:"@"),(FBFR,FBTO,FBAMT)=0
 I BACK,FBD1=1!(FBD1=4) S FBFR=$P(FBUCP,U,13),FBTO=$P(FBUCP,U,14),FBAMT=$P(FBUCP,U,15)
 E  S:$P(FBUCA,U,13) FBFR="@" S:$P(FBUCA,U,14) FBTO="@" S:$P(FBUCA,U,15) FBAMT="@"
 ;reset fbuca
 I FBD'=0 S $P(FBUCA,U,11)=$S(FBD="@":"",1:FBD)
 I FBFR'=0 S $P(FBUCA,U,13)=$S(FBFR="@":"",1:FBFR)
 I FBTO'=0 S $P(FBUCA,U,14)=$S(FBTO="@":"",1:FBTO)
 I FBAMT'=0 S $P(FBUCA,U,15)=$S(FBAMT="@":"",1:FBAMT)
 ;set to call die & call
 S DR="S:FBD=""@"" Y=""@1"";10////^S X=FBD;S Y=""@2"";@1;10///@;@2;S:FBFR=0 Y=""@3"";S:FBFR=""@"" Y=""@30"";12///^S X=FBFR;S Y=""@3"";@30;12///@;@3;S:FBTO=0 Y=""@4"";S:FBTO=""@"" Y=""@40"";13///^S X=FBTO S Y=""@4"";@40;13///@;@4"
 S DR(162.7,1)="S:FBAMT=0 Y=""@99"";S:FBAMT=""@"" Y=""@50"";14///^S X=FBAMT;S Y=""@99"";@50;14///@;@99"
 D DIE^FBUCUTL2("^FB583(",FBDA,.DR)
 ;write message
 W !,*7,"Authorization From/To dates are missing.",!,"Disposition has not been updated.",!,"When entering in this disposition, please include these dates.",!
CKAUTHQ Q
