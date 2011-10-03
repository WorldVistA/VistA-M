XUA4A72 ;SFISC/RWF - Person class API's ;08/05/2004  15:53
 ;;8.0;KERNEL;**27,49,74,132,222,300,327,357**;Jul 10, 1995;Build 2
 ; Entry Points (DBIA 1625)
 ; $$GET      - Returns active class, given duz and date.
 ; $$IEN2CODE - Returns VA CODE from PERSON CLASS file, given IEN.
 ; $$CODE2TXT - Returns HCFA text from PERSON CLASS file, given IEN
 ;              or VA CODE.
 Q  ;No access from top.
GET(IEN,DATE) ;sr. Get the active class on a date
 ;IEN of user.
 N X1,Y1,D
 S:$G(DATE)="" DATE=DT S D=DATE
 ;The return is file 200 ien_^_NODE
 S X1=$$GETUE(IEN,DATE) I X1'>0 Q X1
 S X1=$P(X1,"^",2,99) ;or X1=^VA(200,IEN,"USC1",+X1,0)
 S Y1=$G(^USC(8932.1,+X1,0))
 ;IEN^Occupation^specialty^sub-specialty^Effective date^expiration date^VA Code^specialty code
 Q +X1_U_$P(Y1,U,1,3)_U_$P(X1,U,2,3)_U_$P(Y1,U,6)_U_$P(Y1,U,9)
 ;
IEN2CODE(IEN) ;sr. Get the code for an IEN
 Q $P($G(^USC(8932.1,+$G(IEN),0)),U,6)
 ;
IEN2DATA(IEN) ;Get person class data for an IEN
 Q $G(^USC(8932.1,+$G(IEN),0))
 ;
CODE2TXT(CODE) ;sr. Convert IEN or V-code to text
 I CODE?1"V"1.N S CODE=$$VCLK(CODE)
 Q $P($G(^USC(8932.1,+CODE,0)),U,1,3)
 ;
VCLK(X) ;Lookup a V-code, Return IEN
 Q $O(^USC(8932.1,"F",X,0))
 ;
GETUE(IEN,DATE) ;private, Get the user entry
 N D,X,Y,XUOK
 Q:'$D(^VA(200,+$G(IEN),0)) -1
 Q:$O(^VA(200,IEN,"USC1",0))="" -1
 S XUOK=0
 S D=$O(^VA(200,IEN,"USC1","AD",DATE))
 F  S D=$O(^VA(200,IEN,"USC1","AD",D),-1) Q:D=""  D  Q:XUOK
 . S Y=""
 . F  S Y=$O(^VA(200,IEN,"USC1","AD",D,Y),-1) Q:'Y  D  Q:XUOK
 . . S X=$G(^VA(200,IEN,"USC1",Y,0))
 . . I $P(X,U,2),DATE'<$P(X,U,2),DATE'>$P(X,U,3)!($P(X,U,3)="") S XUOK=1
 Q $S(XUOK:Y_U_X_U_U,1:-2)
 ;
REMOVE ;Allow privileged user to remove a wrong entry in the users file.
 N XUDA,XUDA1,XUWT,%
 S XUDA1=+$$LOOKUP^XUSER Q:XUDA1'>0
 W !,"This user has the following Person Class enties:"
 S XUWT=^DD(8932.1,0,"ID","WRITE")
 F XUDA=0:0 S XUDA=$O(^VA(200,XUDA1,"USC1",XUDA)) Q:XUDA'>0  S %=+$G(^(XUDA,0)) I %>0 W !,$P(^USC(8932.1,%,0),U) X XUWT
 S DIR(0)="Y",DIR("A")="Are you sure you want to remove ALL these entries" D ^DIR Q:$D(DIRUT)!(Y'=1)
 F XUDA=0:0 S XUDA=$O(^VA(200,XUDA1,"USC1",XUDA)) Q:XUDA'>0  S DIK="^VA(200,DA(1),""USC1"",",DA=XUDA,DA(1)=XUDA1 D ^DIK
 Q
 ;
TERM(IEN,DATE) ;Called from XUSTERM, Set the expiration date for a user being terminated.
 N Y1
 Q:$G(DATE)'>0
 S Y1=$$GETUE(IEN,DATE)
 I Y1'>0!$L($P(Y1,"^",4)) Q
 D OLD(IEN,+Y1,DATE)
 Q
 ;
SET01 ;Called from the X-ref on the .01 field
 Q:$P(^VA(200,DA(1),"USC1",DA,0),U,2)>0
 S $P(^VA(200,DA(1),"USC1",DA,0),U,2)=DT ;Trigger date
 D UPDATE(200.05,2,DT)
 ;
SET2 ;Call from the X-ref on the Effective Date field
 N L,REC
 S L=$O(^VA(200,DA(1),"USC1",DA),-1) Q:L'>0
 S REC=^VA(200,DA(1),"USC1",L,0)
 I $P(REC,U,3)="" D OLD(DA(1),L,$$MAX^XLFMTH(X,$P(REC,U,2))) ;Inactivate the old one
 Q
KILL2 ;Call from the X-ref on the Effective Date field
 N L
 S L=$O(^VA(200,DA(1),"USC1",DA),-1) Q:L'>0
 I $P(^VA(200,DA(1),"USC1",L,0),U,3)=X D OLD(DA(1),L,"")
 Q
 ;
OLD(D0,D1,DATE) ;Inactivate the old one (Expiration Date)
 N DA,X
 S $P(^VA(200,D0,"USC1",D1,0),U,3)=DATE ;Inactivate the old one
 S DA(1)=D0,DA=D1 D UPDATE(200.05,3,DATE)
 Q
UPDATE(DIH,DIG,DIV,DIU) ;file,field,new value,old value
 S DIV=$G(DIV),DIU=$G(DIU),DIV(0)=DA(1),DIV(1)=DA
 D ^DICR:$O(^DD(DIH,DIG,1,0))>0
 Q
DDS1 ;Called from Pre-action person class field
 N %,XUDA,XU
 I X]"" S %=^USC(8932.1,X,0),XU(1)=$P(%,U,1),XU(2)="  "_$P(%,U,2),XU(3)="    "_$P(%,U,3) D HLP^DDSUTL(.XU)
 Q:DA'>0  M XUDA=DA N DA ;Hide DA
 S %=$$GET^DDSVAL(DIE,.XUDA,3,"","I"),%=$S(%>0:1,1:0)
 D UNED^DDSUTL(2,,,%),UNED^DDSUTL(3,,,%)
 Q
DDS2 ;Called from effective date on form
 N %,XUDA M XUDA=DA N DA ;Hide DA
 S XUDA=$O(^VA(200,XUDA(1),"USC1",XUDA),-1) Q:XUDA'>0
 S %=$$GET^DDSVAL(DIE,.XUDA,3,"","I") Q:%&(%<X)  ;Already has value
 D PUT^DDSVAL(DIE,.XUDA,3,X,"","I")
 Q
DDS3(%) ;Data validation
 I %=2,$$GET^DDSVAL(DIE,.DA,3,"","I")]"" D
 . S DDSERROR=1
 . D HLP^DDSUTL("This field is uneditable because Expired Date already has data")
 . Q
 I %=3,DDSOLD]"",X'=DDSOLD D
 . S DDSERROR=1
 . D HLP^DDSUTL("You cannot change the value of this field.")
 . Q
 Q
