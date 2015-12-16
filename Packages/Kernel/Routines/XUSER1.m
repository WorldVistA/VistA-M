XUSER1 ;ISF/RWF - User file Utilities ;03/17/15  08:19
 ;;8.0;KERNEL;**169,210,222,514,655**;Jul 10, 1995;Build 16
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
PAGE() ;Do a page break; Return 0 if ok to continue, 1 if to abort
 ; ZEXCEPT: IOF,IOST
 N DIR
 S DIR(0)="E" D ^DIR:($E(IOST,1,2)["C-")
 Q:$D(DIRUT) 1 W @IOF S ($X,$Y)=0
 Q 0
 ;
GKEYS(IE,XUA) ;Get the keys held. IE=user
 N %,V,XUB
 S %=0 ;Sort list alphabetical
 F  S %=$O(^VA(200,IE,51,%)) Q:(%'>0)  S V=$P($G(^DIC(19.1,%,0)),U,1) I $L(V) S XUB(V)=""
 S V="" ;return to user
 F %=1:1 S V=$O(XUB(V)) Q:'$L(V)  S XUA(%)=V
 Q
 ;
SHLIST(ARRAY,LM,SP) ; Show a list, Array=list, LM=Left Margin, SP=spacing
 ;Set DN=0 to get FM22 to stop the print
 ; ZEXCEPT: DN,IOM,IOSL
 N %,Y2,Y4,Y5,Y6,DIR
 I $Y+4>IOSL,$$PAGE S DN=0 Q
 S Y4=-1,%=0,Y2=IOM-LM\SP,Y5=0
 F  S %=$O(ARRAY(%)),Y4=Y4+1 Q:(%'>0)!$D(DIRUT)  S Y6=$G(ARRAY(%)) D:$L(Y6)
 . S:Y4'<SP Y4=0 S Y5=(Y4*Y2+LM)
 . I $X>0,Y5+$L(Y6)'<IOM S Y4=0,Y5=(Y4*Y2+LM)
 . I 'Y4 W ! I $Y+3>IOSL S Y4=0,Y5=(Y4*Y2+LM) I $$PAGE S DN=0 Q
 . W ?Y5,Y6 S:(($X+1)>(Y5+Y2)) Y4=Y4+1
 . Q
 Q
 ;
SHPC(IE) ;Show the Person Class
 N %,Y S:'$D(DT) DT=$$DT^XLFDT
 S %=$X,Y=$$GET^XUA4A72(IE,DT)
 I $L(Y) W $P(Y,U,2) I $L($P(Y,U,3)) W !,?(%+2),$P(Y,U,3) I $L($P(Y,U,4)) W !,?(%+4),$P(Y,U,4)
 Q
GMG(IE,XUA) ;Get mail groups
 N %,Y,XUI,Y4,Y2,XUK
 S %=0
 F  S %=$O(^XMB(3.8,"AB",IE,%)) Q:%'>0  S XUA(%)=$P($G(^XMB(3.8,%,0)),U,1)
 Q
GPARAM(IE,PRAM,XUA) ;Get an entry from the Parameter tool
 ;IE is the user to get the list for. PARAM what parameter, XUA return array.
 ; ZEXCEPT: %
 N XUENT,XUX,XUERR,XU1
 S XUENT=IE_";VA(200,"_$S($G(^VA(200,IE,5)):"^SRV.`"_+$G(^(5)),1:""),XUA=""
 D GETLST^XPAR(.XUX,XUENT,PRAM,"E",.XUERR)
 Q:XUX'>0
 S XUA(.5)=PRAM_":"
 F %=1:1:XUX S XUA(%)=$P(XUX(%),U,2)
 Q
 ;
DIVCHG ;Allow user to change Division [DUZ(2)] value
 ;Called from option: XUSER DIV CHG
 N Y,X,DIC,I,CD
 I '$D(^VA(200,+$G(DUZ),0))#2 W !,"You are not a valid user.",!!,$C(7) Q
 I $G(DUZ(2))="" D  ;Should not happen
 . N XOPT D XOPT^XUS1A S DUZ(2)=$P(XOPT,U,17)
 S CD=$$NS^XUAF4(DUZ(2))
 W !,"Your current Division is ",$P(CD,U)_"  "_$P(CD,U,2)
 S X=+$O(^VA(200,DUZ,2,0)),Y=+$O(^(X))
 I 'Y W !,"You do not have any choices. ",!," Change is not possible.",!! Q
 K DIC S DIC="^VA(200,DUZ,2,",DIC(0)="AEMNQ"
 S DIC("S")="I $G(^DIC(4,+Y,99))"
 ;Check if user has a default
 S X=$O(^VA(200,DUZ,2,"AX1",1,0)) S:X>0 DIC("B")=$P($$NS^XUAF4(X),U)
 D ^DIC K DIC
 I Y'>0 D  Q
 .W !,$C(7),"Division Unchanged - Currently you are assigned to "
 .W $P(CD,U)_"  "_$P(CD,U,2),!
 S DUZ(2)=+Y,CD=$$NS^XUAF4(DUZ(2))
 W !?5,"Division is now set to [ ",$P(CD,U)_"  "_$P(CD,U,2)," ]",!
 Q
 ;
NETNM(NM,IEN) ;Check NetName, Called from input transform for field 501.1 NPF.
 ;Return 1 to abort, 0 to allow
 N NPF,OV
 I $L(NM)<9,DUZ(0)'["@",'$D(^XUSEC("XUMGR",DUZ)) Q 1 ;P655
 I $L(NM)<9 D EN^DDIOL("WARNING: The entered text is less than 9 characters.","") ;P655
 S NPF(0)=$P($G(^VA(200,IEN,0)),U,1),OV=0
 I $E(NM,1,3)'="VHA" D EN^DDIOL("WARNING: Prefix not VHA.","") S OV=1
 S NPF(1)=$E($P(NPF(0),","),1,5)_$E($P(NPF(0),",",2),1)
 I $E(NM,7,6+$L(NPF(1)))'=NPF(1) D EN^DDIOL("WARNING: Missing "_NPF(1)_" from username.","") S OV=1
 I OV S OV='((DUZ(0)["@")!$D(^XUSEC("XUMGR",DUZ)))
 Q OV
 ;
