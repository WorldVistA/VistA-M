XQSMDFM ;ISC-SF(SEA)/JLI,MJM - PERMIT USER TO BUILD LIMITED FM OPTIONS ;01/25/2008
 ;;8.0;KERNEL;**510**;Jul 10, 1995;Build 6
 ; Per VHA Directive 2004-038, this routine should not be modified.
 ; Option: XQSMD LIMITED FM OPTIONS
RULES ;
 N XQNMSP,XQTYPE
 D NAMESP^XQSMD4(.XQNMSP) Q:'$D(XQNMSP)  ; User must have namespace to use.
 D ASKTYPE(.XQTYPE) Q:'$D(XQTYPE)
 D @XQTYPE
 Q
ASKTYPE(XQTYPE) ;
 W !,"The option types that may be built are P(rint), E(dit), and I(nquire),"
 W !,"and you must have template(s) ready to be included in the option."
 W !,"You may also enter D(elete) to delete an option."
 N DIR,X,Y,DIRUT
 S DIR("A")="Select Option Type"
 S DIR(0)="S^E:Edit"
 S DIR(0)=DIR(0)_";P:Print"
 S DIR(0)=DIR(0)_";I:Inquire"
 S DIR(0)=DIR(0)_";D:Delete"
 D ^DIR Q:$D(DIRUT)
 S XQTYPE=Y
 Q
D ; Delete
 N DIC,X,Y,XQOPT
 S DIC("A")="Select Option to Delete: "
 S DIC(0)="AEQMZ"
 S DIC="^VA(200,DUZ,19.5,"
 D ^DIC Q:Y<0
 S XQOPT("IEN")=+Y ; Option IEN
 S XQOPT("NAME")=Y(0,0) ; Option Name
 I $D(^VA(200,"AP",XQOPT("IEN"))) D NODEL^XQSMD4(.XQOPT) Q
 N DIR,X,Y,DIRUT
 S DIR("A")="Do you really want to delete "_XQOPT("NAME")
 S DIR("B")="No"
 S DIR(0)="Y"
 D ^DIR Q:'Y
 D DELETE^XQSMD4(.XQOPT)
 Q
E ; Edit
 N XQTMPLE,DIR,X,Y,DIRUT,DR
 D ASKTMPL("Edit","^DIE(",.XQTMPLE) Q:'$D(XQTMPLE)
 S DIR(0)="Y"
 S DIR("A")="Should the user be allowed to ADD a new "_XQTMPLE("FNAME")_" file entry"
 S DIR("B")="No"
 D ^DIR Q:$D(DIRUT)
 S XQTMPLE("ADD")=Y
 S DR="1;3.5;4///E;30///"_XQTMPLE("FGLOB")_";31///AEMQ"_$S(XQTMPLE("ADD"):"L",1:"")_";50///"_XQTMPLE("FGLOB")_";51///["_XQTMPLE("NAME")_"];"
 D CRE8OPT(DR)
 Q
I ; Inquire
 N XQTMPLP,DR
 D ASKTMPL("Print","^DIPT(",.XQTMPLP,1) Q:'$D(XQTMPLP)
 S DR="1;3.5;4///I;30///"_XQTMPLP("FGLOB")_";31///AEMQ;80///"_XQTMPLP("FGLOB")_";"
 I $D(XQTMPLP("NAME")) S DR=DR_"63///["_XQTMPLP("NAME")_"];"
 D CRE8OPT(DR)
 Q
P ; Print
 N XQTMPLP,XQTMPLS,DR
 D ASKTMPL("Sort","^DIBT(",.XQTMPLS) Q:'$D(XQTMPLS)
 S XQTMPLP("FNUM")=XQTMPLS("FNUM"),XQTMPLP("FNAME")=XQTMPLS("FNAME"),XQTMPLP("FGLOB")=XQTMPLS("FGLOB")
 D ASKTMPL("Print","^DIPT(",.XQTMPLP) Q:'$D(XQTMPLP)
 S DR="1;3.5;4///P;60///"_XQTMPLP("FGLOB")_";62///0;63///["_XQTMPLP("NAME")_"];64///["_XQTMPLS("NAME")_"];"
 D CRE8OPT(DR)
 Q
ASKTMPL(XQADJ,XQFILE,XQTMPL,XQOPTNL) ;
 N DIC,X,Y,DTOUT,DUOUT
 I '$D(XQTMPL("FNUM")) D ASKFILE(.XQTMPL) Q:'$D(XQTMPL("FNUM"))
 S DIC("A")="Select "_XQADJ_" Template"_$S($G(XQOPTNL):" (Optional)",1:"")_": "
 S DIC("S")="I $P(^(0),U,4)="_XQTMPL("FNUM")
 S DIC(0)="AEQMZ"
 S DIC=XQFILE
 D ^DIC I Y<0 D  Q
 . I '$G(XQOPTNL) K XQTMPL Q
 . I $D(DUOUT)!$D(DTOUT) K XQTMPL
 S XQTMPL("NAME")=Y(0,0) ; Template Name
 ;S XQTMPL("FNUM")=$P(Y(0),U,4) ; File Number
 ;S XQTMPL("FNAME")=$P(^DIC(XQTMPL("FNUM"),0),U) ; File Name
 Q
ASKFILE(XQTMPL) ;
 N DIC,X,Y
 S DIC=1
 S DIC(0)="AEQM"
 S DIC("S")="I $$ACCESS^XQSMDFM(+Y)"
 D ^DIC Q:Y<0
 S XQTMPL("FNUM")=+Y
 S XQTMPL("FNAME")=$P(Y,U,2)
 S XQTMPL("FGLOB")=$P(^DIC(XQTMPL("FNUM"),0,"GL"),U,2)
 Q
CRE8OPT(DR) ;
 N DIE,DA,XQOPT,DIC,DLAYGO,X
AGAIN ;
 D ASKOPT^XQSMD4(.XQOPT,XQTYPE) Q:'$D(XQOPT)
 I 'XQOPT("NEW") I '$$SURE K XQOPT G AGAIN
 S DIE=19,DA=XQOPT("IEN") D ^DIE
 S DIC="^VA(200,DUZ,19.5,",X=XQOPT("NAME"),DIC(0)="MLX",DA(1)=DUZ,DLAYGO=200 D ^DIC
 Q
SURE() ;
 N DIR,X,Y,XQT
 S XQT=$P(^DIC(19,XQOPT("IEN"),0),U,4)
 W !,"This is an existing "_$$TYPE^XQSMD4(XQT)_" option."
 I '$D(^VA(200,DUZ,19.5,XQOPT("IEN"),0)) W !,$C(7),"It is not included in your delegated options." Q 0
 I XQT'=XQTYPE W !,"It may not be changed to a different type of option." Q 0
 S DIR("A")="Are you sure you wish to change it?"
 S DIR("B")="No"
 D ^DIR
 Q Y
ACCESS(XQFNUM) ; See if user has file access
 N XQYZ,XQNODE,XQPIECE
 I XQTYPE="E" S XQNODE="WR",XQPIECE=6
 E  S XQNODE="RD",XQPIECE=5
 S XQYZ=$G(^DIC(XQFNUM,0,XQNODE)) Q:XQYZ="" 1
 I $D(^VA(200,"AFOF")) Q $P($G(^VA(200,DUZ,"FOF",XQFNUM,0)),U,XQPIECE)>0
 ;If Part 3 hasn't been run, check old style FM access codes
 N XQACC,XQFMA,I
 S XQACC=0
 S XQFMA=$P(^VA(200,DUZ,0),U,4) Q:XQFMA="" 0
 F I=1:1:$L(XQFMA) I XQYZ[$E(XQFMA,I) S XQACC=1 Q
 Q XQACC
