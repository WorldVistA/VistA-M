OCXOED06 ;SLC/RJS,CLA - Rule Editor (Rule Element Relation Options) ;11/20/01  13:39
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32,105**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
 ;
S ;
 ;
 Q
EN(OCXR0,OCXR1,OCXRD,OCXACT) ;
 ;
 ;
 ;
 N OCXTHLN,OCXTNLN,OCXTRLN,OCXTULN,OCXTNLN
 ;
 ;
 S OCXOPT=$$GETOPT^OCXOEDT(.OCXACT) Q:(OCXOPT=U) 1 X:$L(OCXOPT) OCXOPT
 ;
 Q:'$D(^OCXS(860.2,OCXR0,"R",OCXR1)) 1
 ;
 Q 0
 ;
 ;
EDREL(OCXR0,OCXR1) ;
 ;
 N OCXDA,X,OCXRD,OCXFLD,PAUSE
 S PAUSE=0,OCXDA(1)=OCXR0,OCXDA=OCXR1,X=$$DIE("^OCXS(860.2,"_OCXR0_",""R"",",.OCXDA,"1;2;3;4;5;6;7;8;9")
 Q:'$D(^OCXS(860.2,OCXR0,"R",OCXR1))
 ;
 ; Check for valid Datafield names
 ;
 K OCXRD S OCXRD="" D GETDATA^OCXOED05(OCXR0,OCXR1,.OCXRD)
 F OCXFLD=5,6,8,9 D
 .N NEWVAL,OLDVAL,FLDNAME
 .S FLDNAME=$S((OCXFLD=5):"Notification Message",(OCXFLD=6):"Order Check Message",1:"")
 .S OLDVAL=$G(OCXRD("REL",OCXR1,OCXFLD,"E")) Q:'$L(OLDVAL)
 .S NEWVAL=$$SCREEN^OCXOED12(OLDVAL,FLDNAME) Q:(NEWVAL=OLDVAL)
 .S OCXDA(1)=OCXR0,OCXDA=OCXR1,X=$$DIE("^OCXS(860.2,"_OCXR0_",""R"",",.OCXDA,OCXFLD_"///"_NEWVAL)
 ;
 ; Check for valid Mumps Code
 ;
 W !!," Mumps Code Check",!!
 K OCXRD S OCXRD="" D GETDATA^OCXOED05(OCXR0,OCXR1,.OCXRD)
 F OCXFLD=9 D
 .N NEWVAL,OLDVAL,FLDNAME,FCNT,X
 .S FLDNAME=$S((OCXFLD=9):"Execute Code",1:"")
 .S OLDVAL=$G(OCXRD("REL",OCXR1,OCXFLD,"E")) Q:'$L(OLDVAL)
 .S PAUSE=1
 .S NEWVAL=OLDVAL
 .F FCNT=1:1 Q:'(NEWVAL["|")  S NEWVAL=$P(NEWVAL,"|",1)_"X"_FCNT_$P(NEWVAL,"|",3,$L(NEWVAL,"|"))
 .W !,FLDNAME,": ",OLDVAL
 .S X=NEWVAL D ^DIM
 .I '$D(X) D  Q
 ..W !
 ..W !,"**WARNING** The mumps code: ",OLDVAL
 ..W !," Did not pass the mumps syntax check. Please verify that this is valid"
 ..W !,"mumps code before you run the compiler."
 .W !,?10," Code OK !!"
 ;
 S:PAUSE X=$$PAUSE
 ;
 Q
 ;
 ;
PAUSE() N X W !!,"  Press <enter> to continue... " R X:DTIME W ! Q ((X[U)*10)
 ;
 ;
 ;
READ(OCXZ0,OCXZA,OCXZB,OCXZL) ;
 N OCXLINE,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 Q:'$L($G(OCXZ0)) U
 S DIR(0)=OCXZ0
 S:$L($G(OCXZA)) DIR("A")=OCXZA
 S:$L($G(OCXZB)) DIR("B")=OCXZB
 F OCXLINE=1:1:($G(OCXZL)-1) W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) Q U
 Q Y
 ;
DIE(DIE,DA,DR) ;
 ;
 D RM(IOM) N DUOUT,DTOUT,DIC S DIC=DIE D ^DIE D RM(0) Q:$G(DTOUT) 0 Q:$G(DUOUT) 0 Q 1
 ;
RM(X) X ^%ZOSF("RM") Q
 ;
DIC(OCXDIC,OCXDIC0,OCXDICA,OCXX,OCXDICS,OCXDR,DA) ;
 ;
 N DIC,X,Y
 S DIC=$G(OCXDIC) Q:'$L(DIC) -1
 S DIC(0)=$G(OCXDIC0) S:$L($G(OCXX)) X=OCXX
 S:$L($G(OCXDICS)) DIC("S")=OCXDICS
 S:$L($G(OCXDICA)) DIC("A")=OCXDICA
 S:$L($G(OCXDR)) DIC("DR")=OCXDR
 D ^DIC Q:(Y<1) 0 Q Y
 ;
INVALID(X) ;
 ;
 N OCXFN
 ;
 F OCXFN=1:1 Q:'(X["|")  D  Q:'$L(X)
 .N OCXDF
 .S OCXDF=$P(X,"|",2)
 .I '$L(OCXDF) S X="" Q
 .I '$O(^OCXS(860.4,"B",OCXDF,0)),'$O(^OCXS(860.4,"C",OCXDF,0)) S X="" Q
 .S X=$P(X,"|",1)_"DFLD"_OCXFN_$P(X,"|",3,$L(X,"|"))
 ;
 Q:'$L(X) 1
 ;
 D ^DIM
 ;
 Q '$L($G(X))
 ;
ETEST ;
 ;
 N D0,D1,EXP
 ;
 S D0=0 F  S D0=$O(^OCXS(860.2,D0)) Q:'D0  D
 .W !,$P(^OCXS(860.2,D0,0),U,1)
 .S D1=0 F  S D1=$O(^OCXS(860.2,D0,"R",D1)) Q:'D1  D
 ..S EXP=$G(^OCXS(860.2,D0,"R",D1,"MCODE"))
 ..Q:'$L(EXP)
 ..W !,?10,D1,"  ",EXP
 ..I $$INVALID(EXP) W "   ** Invalid Code ** "
 Q
 ;
