DI14POST ;OAK/RSD Post Install for patch 14
 ;;22.2;VA FileMan;**14**;Jan 05, 2016;Build 8
 ;resave DIDT to %DT ICR #6212
 N %D,%S,SCR,ZTOS
 S SCR="I 1",%S="DIDT",%D="%DT",ZTOS=$$OSNUM^ZTMGRSET()
 D MOVE^ZTMGRSET
 ;
 ;setup ^DD(.114 nodes, change 240 to 999
 S ^DD(.114,6,0)="MAXIMUM LENGTH^NJ3,0^^0;5^K:+X'=X!(X>999)!(X<1)!(X?.E1"".""1N.N) X"
 S ^DD(.114,6,3)="Answer must be between 1 and 999, with no decimal digits. Answer '??' for more help."
 Q
 ;
EN ;find all sub data dictionaries and check zero node name
 N DIR,I,J,K,X,Y
 W !!,"This will check your account for bad ^DD(file #,0) nodes.  It will look"
 W !,"for multiples that don't have the field name as the 1st piece of the node."
 W !,"It will display its results and ask you if you want to make the changes."
 W !,"This will take 5 to 10 minutes."
 I $G(^XTMP("DI14","C")) D
 . W !!,"You already have bad nodes identified in the ^XTMP(""DI14"") global."
 . W !,"If you proceed this data will be overwritten."
 W !!,"Do you want to run the check?"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR
 Q:'Y
 K ^XTMP("DI14")
 W !,".."
 ;reset expiration date to T+30 on transport global and "C"=count node
 S ^XTMP("DI14",0)=$$FMADD^XLFDT(DT,30)_U_DT,^XTMP("DI14","C")=0,I=1
 ;if zero node contains 'FIELD', check if a file
 F  S I=$O(^DD(I)) Q:'I  S J=$G(^DD(I,0)) I $P(J,U)="FIELD" D
 . I $G(^DIC(I,0))]"",$G(^DIC(I,0,"GL"))]"" Q  ;this is a file
 . S K=$O(^DD(I,0,"NM","")) Q:K=""  ;get subfield name
 . S $P(J,U)=K_$S($G(^DD(I,0,"UP")):" SUB-FIELD",1:"") D REC("S","^DD("_I_",0)",J) ;set subfield name back on the zero node
 . Q
 S J=$G(^XTMP("DI14","C")) W !
 I 'J W !,"No bad nodes",! Q
 F I=1:1 S X=$G(^XTMP("DI14",I)) W !,$P(X,U,2) Q:I=J 
 W !!,J," bad node(s) found.  Do you want to repair?"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR
 Q:'Y
 D EXEC W !!,"Done",!
 Q
 ;
 ;
REC(X,Y,Z) ;record action X, global ref. Y, new value for set Z
 ;^XTMP("DI14",n)=action^global ref^new value
 N C ;subscript counter
 S C=^XTMP("DI14","C")+1,^("C")=C
 I X="S" S ^XTMP("DI14",C)="S"_Y_"^"_$G(Z) Q
 Q
 ;
EXEC ;execute the changes found
 I '$G(^XTMP("DI14",0)) W !!,"Backup Global, ^XTMP(""DI14""), doesn't exists !!" Q
 N I,X,Y
 S I=0
 F  S I=$O(^XTMP("DI14",I)) Q:'I  D
 . S X=$G(^XTMP("DI14",I)),Y=$P(X,U,2)
 . I $E(X)="S" S @("^"_Y)=$P(X,U,3,6) Q
 . Q
 Q
 ;
RESTORE ;restore the old values in ^XTMP("DI14")
 I '$G(^XTMP("DI14",0)) W !!,"Backup Global, ^XTMP(""DI14""), doesn't exists !!" Q
 N I,X,Y
 S I=0
 F  S I=$O(^XTMP("DI14",I)) Q:'I  D
 . S X=$G(^XTMP("DI14",I)),Y=$P(X,U,2)
 . ;restore old set value, 1st piece is always "FIELD"
 . I $E(X)="S" S @("^"_Y)="FIELD^"_$P(X,U,4,6) Q
 . Q
 Q
