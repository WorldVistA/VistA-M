OCXOCMP ;SLC/RJS,CLA - ORDER CHECK CODE COMPILER (Main Entry point - All Rules) ;3/21/01  08:50
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32,105,243**;Dec 17,1997;Build 242
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
EN ;
 ;
 N OCXQ
 ;
 S OCXQ=$$READ("Y","Do you want to queue the compiler to run ","NO") Q:(OCXQ[U)  I OCXQ D  Q
 .D QUE^OCXOCMPV(10)
 .W !!,"Expert system compiler queued to run in 10 seconds."
 .W !,"You will be sent a Mailman bulletin when it has finished.",!!
 .H 2
 ;
MAN K ZTSK D MAN^OCXOCMPV Q  ;  Run the compiler (interactive/manual mode)
 ;                        ;  Ask for option settings.
 ;
AUTO D AUTO^OCXOCMPV Q  ; Run the compiler (Automatic mode)
 ;                  ; Program Execution Trace Mode OFF
 ;                  ; Elapsed time logging OFF
 ;                  ; Raw Data Logging OFF
 ;
QUE D QUE^OCXOCMPV(10) Q  ; Queue the compiler to run in the background
 ;                     ;  Uses option setting from last compile.
 ;                     ;   If no last compile then all options are
 ;                     ;    turned OFF as in Automatic mode.
RUN ;
 ;
 N OCX1,OCX2,OCX3,OCX4
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(1,20)
 ;
 D MESG("Build list of Active Rules, Elements and Datafields...")
 D SETFLAG^OCXOCMPV ; H 1
 I $$EN^OCXOCMP9 D ERMESG("Compiler Aborted while building list of Rules, Elements and Datafields...") Q
 Q:$G(OCXWARN)
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(2,20)
 ;
 S OCX1="" F  S OCX1=$O(^TMP("OCXCMP",$J,OCX1)) Q:'$L(OCX1)  D
 .S OCX2=0 F OCX3=0:1 S OCX2=$O(^TMP("OCXCMP",$J,OCX1,OCX2)) Q:'OCX2
 .D MESG("  "_$J(OCX3,5)_" "_OCX1_$S(OCX3=1:"",1:"S"))
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(3,20)
 ;
 D MESG("Compile DataField Navigation code...")
 D SETFLAG^OCXOCMPV ; H 1
 I $$EN^OCXOCMP1 D ERMESG("Compiler Aborted due to Datafield syntax errors...") Q
 Q:$G(OCXWARN)
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(4,20)
 ;
 S (OCX3,OCX1)=0 F  S OCX1=$O(^TMP("OCXCMP",$J,"DATA FIELD",OCX1)) Q:'OCX1  D
 .S OCX2=0 F  S OCX2=$O(^TMP("OCXCMP",$J,"DATA FIELD",OCX1,OCX2)) Q:'OCX2  S OCX3=OCX3+1
 D MESG("  "_$J(OCX3,5)_" DataField Navigation Code Array"_$S(OCX3=1:"",1:"s"))
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(5,20)
 ;
 D MESG("Compile Element Evaluation code...")
 D SETFLAG^OCXOCMPV ; H 1
 I $$EN^OCXOCMP2 D ERMESG("Compiler Aborted due to Rule Element syntax errors...") Q
 Q:$G(OCXWARN)
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(6,20)
 ;
 S (OCX1,OCX2)=0 F  S OCX1=$O(^TMP("OCXCMP",$J,"A CODE",OCX1)) Q:'OCX1  S OCX2=OCX2+1
 D MESG("  "_$J(OCX2,5)_" Event Evaluation Code Array"_$S(OCX2=1:"",1:"s"))
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(7,20)
 ;
 D MESG("Compile Element MetaCode...")
 D SETFLAG^OCXOCMPV ; H 1
 I $$EN^OCXOCMPM D ERMESG("Compiler Aborted due to Element metacode errors...") Q
 Q:$G(OCXWARN)
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(8,20)
 ;
 S OCX1="",OCX2=0 F  S OCX1=$O(^TMP("OCXCMP",$J,"INCLUDE",OCX1)) Q:'$L(OCX1)  S:($E(OCX1,1,3)="MCE") OCX2=OCX2+1
 D MESG("  "_$J(OCX2,5)_" Element Metacode Array"_$S(OCX2=1:"",1:"s"))
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(9,20)
 ;
 D MESG("Get Compiler Function Code...")
 D SETFLAG^OCXOCMPV ; H 1
 I $$EN^OCXOCMPO D ERMESG("Compiler Aborted due to Compiler Function code errors...") Q
 Q:$G(OCXWARN)
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(10,20)
 ;
 S OCX1="",OCX2=0 F  S OCX1=$O(^TMP("OCXCMP",$J,"INCLUDE",OCX1)) Q:'$L(OCX1)  S:'($E(OCX1,1,3)="MCE") OCX2=OCX2+1
 D MESG("  "_$J(OCX2,5)_" Compiler Include Function"_$S(OCX2=1:"",1:"s"))
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(12,20)
 ;
 D MESG("Compile Rule Element Relation code...")
 D SETFLAG^OCXOCMPV ; H 1
 I $$EN^OCXOCMP3 D ERMESG("Compiler Aborted due to Rule syntax errors...") Q
 Q:$G(OCXWARN)
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(13,20)
 ;
 S (OCX1,OCX2)=0 F  S OCX1=$O(^TMP("OCXCMP",$J,"RULE",OCX1)) Q:'OCX1  D
 .S OCX3=0 F  S OCX3=$O(^TMP("OCXCMP",$J,"RULE",OCX1,OCX3)) Q:'OCX3  S:$O(^(OCX3,"CODE",0)) OCX2=OCX2+1
 D MESG("  "_$J(OCX2,5)_" Rule Element Relation Code Array"_$S(OCX2=1:"",1:"s"))
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(14,20)
 ;
 D MESG("Construct Decision Tree...")
 D SETFLAG^OCXOCMPV ; H 1
 I $$EN^OCXOCMP4 D ERMESG("Compiler Aborted due to Compiler errors...") Q
 Q:$G(OCXWARN)
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(15,20)
 ;
 S OCX1=0 F OCX2=0:1 S OCX1=$O(^TMP("OCXCMP",$J,"C CODE",OCX1)) Q:'OCX1
 D MESG("  "_$J(OCX2,5)_" Sub-Routine"_$S(OCX2=1:"",1:"s"))
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(16,20)
 ;
 D MESG("Optimize Sub-Routines...")
 D SETFLAG^OCXOCMPV ; H 1
 I $$EN^OCXOCMP5 D ERMESG("Compiler Aborted due to Compiler errors...") Q
 Q:$G(OCXWARN)
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(17,20)
 ;
 S OCX1=0 F OCX3=0:1 S OCX1=$O(^TMP("OCXCMP",$J,"C CODE",OCX1)) Q:'OCX1
 D MESG("  "_$J(OCX3,5)_" Sub-Routine"_$S(OCX3=1:"",1:"s"))
 D MESG("  "_(100-(((OCX3/OCX2)*1000)\1/10))_"% Optimization")
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(18,20)
 ;
 D MESG("Assemble Routines...")
 D SETFLAG^OCXOCMPV ; H 1
 I $$EN^OCXOCMP6 D ERMESG("Compiler Aborted due to Compiler errors...") Q
 Q:$G(OCXWARN)
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(19,20)
 ;
 S OCX1=0 F OCX2=0:1 S OCX1=$O(^TMP("OCXCMP",$J,"D CODE",OCX1)) Q:'OCX1
 D MESG("  "_$J(OCX2,5)_" OCXOZ* Routine"_$S(OCX2=1:"",1:"s"))
 ;
 D:($G(OCXAUTO)<2) STATUS^OCXOPOST(20,20)
 ;
 L -^OCXD(861,1)
 ;
 Q
 ;
MESG(OCXX) ;
 I '$G(OCXAUTO) W !!,OCXX
 I ($G(OCXAUTO)=1) D BMES^XPDUTL(.OCXX)
 Q
 ;
ERMESG(OCXX) ;
 N OCXY S OCXY=OCXX
 I '$G(OCXAUTO) W !!,OCXX
 I ($G(OCXAUTO)=1) D BMES^XPDUTL(.OCXX)
 S OCXERRM=OCXY
 Q
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
 Q
 ;
DT(X,D) N Y,%DT S %DT=D D ^%DT Q Y
 Q
 ;
CNT(X) ;
 ;
 N CNT,D0
 S D0=0 F CNT=1:1 S D0=$O(@X@(D0)) Q:'D0
 W !!,?10,X,"  ",CNT
 Q CNT
 ;
DATE() N X,Y,%DT S X="N",%DT="T" D ^%DT X ^DD("DD") Q Y
 ;
CONV(Y) Q:'(Y["@") Y Q $P(Y,"@",1)_" at "_$P(Y,"@",2,99)
 ;
 ;
VERSION() Q $P($T(+3),";;",3)
 ;
