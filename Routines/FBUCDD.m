FBUCDD ;ALBISC/TET - DD UTILITY ROUTINE ;5/27/93  19:28
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
INPUT(DA,X,Y,FBZZ) ;input transform of status field, file 162.7
 ;INPUT:  X and Y - FM variables
 ;        DA - internal entry number of 162.7, Unauthorized Claims
 ;        FBZZ - set in input transform, identifies the field in 162.7
 ;OUTPUT: 1 if x should be killed, otherwise 0.
 N FBZ S FBZ=$G(^FB583(DA,0))
23 ;If FBZZ=23 - CLAIM SUBMITTED BY
 ;ensure that if vendor or veteran entered, same as vendor or veteran field
 I FBZZ=23 Q $S(X["FBAAV"&(+X'=$P(FBZ,U,3)):1,X["DPT"&(+X'=$P(FBZ,U,4)):1,1:0)
24 ;IF FBZZ=24 - STATUS
 ;if y<0 k x
 ;if dispositioned, status can only be dispositioned (and converse).
 ;if not dispositioned, valid claim received, cannot select status
 ; which indicates incomplete claim (and converse).
 I FBZZ=24 N O S O=$$ORDER^FBUCUTL(X) Q $S(Y<0:1,"^40^70^90^"[O&('$P(FBZ,U,11)):1,"^40^70^90^"'[O&($P(FBZ,U,11)):1,$P(FBZ,U,8)&(O'>20):1,'$P(FBZ,U,8)&(O>20):1,1:0)
10 ;IF FBZZ=10 - DISPOSITION
 ;dispositon to cancelled/withdrawn or abandoned if date valid claim received is null,
 ; k x if disposition is other than approved(1) or approved to stabilization(4)
 ;  and not ok to updated (payments were made and user doesn't hold key)
 ;otherwise can select any disposition.
 I FBZZ=10 Q $S(Y<0:1,'(X=3!(X=5))&('$P(FBZ,U,8)):1,((X=2)!(X=3)!(X=5))&('$$UPOK^FBUCUTL(DA)):1,1:0)
7 ;IF FBZZ=7 - DATE VALID CLAIM RECEIVED
 ;claim is considered valid when all pending information is received.
 I FBZZ=7 Q $S(Y<1:1,$$PEND^FBUCUTL(DA):1,1:0)
4 ;IF FBZZ=4 - TREATMENT TO DATE
 ;if y<1 k x
 ;if treatment to date is before treatment from date, k x
 I FBZZ=4 Q $S(Y<1:1,$P(FBZ,U,5)>X:1,1:0)
12 ;IF FBZZ=12 - AUTHORIZED FROM DATE
 ;if y<1 k x
 ;if authorized from date is before treatment from date, k x
 ;if authorized from date is after treatment to date, k x
 I FBZZ=12 Q $S(Y<1:1,$P(FBZ,U,5)>X:1,X>$P(FBZ,U,6):1,1:0)
13 ;IF FBZZ=14 - AUTHORIZED TO DATE
 ;if y<1 k x
 ;if authorized to date is before authorized from date, k x
 ;if authorized to date is after treatment to date, k x
 I FBZZ=13 Q $S(Y<1:1,$P(FBZ,U,13)>X:1,X>$P(FBZ,U,6):1,1:0)
 Q
DISCHTYP(DA) ;discharge type - computed field expression from field 29 of 162.7
 ;INPUT:  DA = ien
 ;OUTPUT: long value of discharge type for file 161.01,.06
 N FBZ,FBIEN
 I '+$G(DA) Q ""
 S FBZ=$$FBZ^FBUCUTL(DA),FBIEN=+$O(^FBAAA("AG",DA_";FB583(",+$P(FBZ,U,4),0)) I 'FBIEN Q ""
 S FBZ=$$PTR^FBUCUTL("^FBAAA("_+$P(FBZ,U,4)_",1,",FBIEN),FBIEN=$P(FBZ,U,15)
 Q $S('FBIEN:"",FBIEN=4:"DISCHARGE",FBIEN=3:"DEATH WITHOUT AUTOPSY",FBIEN=2:"DEATH WITH AUTOPSY",1:"TRANSFER TO VA")
 ;
MSIX(X,DA,FLD,ACT,FBIX) ;cross-reference on either vendor/veteran/other,master claim,status order
 ;INPUT:  X = value edited
 ;        DA = internal entry number of record
 ;        FLD = field edited
 ;        ACT = action:  1 for set; 2 for kill
 ;        FBIX = cross-ref to be set, either APMS, AVMS or AOMS
 ;VAR:    FBZ = zero node and value of first subscript of cross-ref
 ;        FBZ(1) = master claim designation
 ;        FBZ(2) = status order
 ;OUTPUT:  set or kill cross-reference, depending upon the action
 I $S('+$G(X):1,'+$G(DA):1,'+$G(FLD):1,'+$G(ACT):1,$G(FBIX)']"":1,1:0) Q
 I $S(FBIX="APMS":0,FBIX="AVMS":0,FBIX="AOMS":0,1:1) Q
 N FBZ S FBZ=$$FBZ^FBUCUTL(DA) I FBIX="AOMS",$P(FBZ,U,23)'["VA(200" Q
 S FBZ(1)=$S(FLD=20:X,1:+$P(FBZ,U,20)) Q:'FBZ(1)  S FBZ(1)=FBZ(1)_$S(DA=FBZ(1):"P",1:"S")
 S FBZ(2)=$$ORDER^FBUCUTL($S(FLD=24:X,1:+$P(FBZ,U,24))) Q:'FBZ(2)
 S FBZ=$S(FLD'=20&(FLD'=24):+X,FBIX="APMS":+$P(FBZ,U,4),FBIX="AVMS":+$P(FBZ,U,3),1:+$P(FBZ,U,23)) Q:'FBZ
 I ACT=1 S ^FB583(FBIX,FBZ,FBZ(1),FBZ(2),DA)="" Q
 I ACT=2 K ^FB583(FBIX,FBZ,FBZ(1),FBZ(2),DA)
 Q
