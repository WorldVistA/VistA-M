DINZMGR ;SFISC/MKO-TO SET UP THE MGR ACCOUNT FOR THE SYSTEM ;3:04 PM  1 Oct 1998
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;This is a modification of Kernel's ZTMGRSET routine.
 I $D(^%ZTSK),$D(^%ZOSF("MGR"))#2 D  Q
 . W !,$C(7)_"  The VA Kernel appears to be installed on the system."
 . W !,"  ^DINZMGR should only be used during a stand-alone VA FileMan installation.",!
 ;
 S U="^"
 D INTRO^DINZMGR1
 ;
 K DIR
 S DIR("A",1)="Do you wish to proceed"
 S DIR("B")="YES"
 S DIR("?",1)="Enter 'Y' to continue.  Enter 'N' or '^' to quit."
 D DIR K DIR G:$D(DIQUIT)!'Y Q
 ;
 D ZS G:$D(DIQUIT)!'Y Q
 D OS^DINZMGR1 G:$D(DIQUIT) Q
 ;
 I $D(^%ZOSF("UCI")) X ^("UCI") I Y'["MG" D  G:$D(DIQUIT)!'Y Q
 . K DIR
 . S DIR("A",1)="THIS MAY NOT BE THE MANAGER UCI."
 . S DIR("A",2)="I think it is "_Y_".  Should I continue anyway"
 . S DIR("B")="NO"
 . S DIR("?",1)="This routine will attempt to file some % routines and set nodes"
 . S DIR("?",2)="in the %ZOSF global.  It should therefore be run in the manager"
 . S DIR("?",3)="account."
 . D DIR K DIR
 ;
 D DT G:$D(DIQUIT) Q
 D ZIS G:$D(DIQUIT) Q
 D ZISS G:$D(DIQUIT) Q
 D ZOSF G:$D(DIQUIT) Q
 W !!,"ALL DONE",!
 G Q
 ;
ZS K DIR
 S DIR("A",1)="Are the ZLOAD and ZSAVE commands implemented"
 S DIR("A",2)="on your MUMPS operating system (Y/N)"
 S DIR("?",1)="Since this utility will use ZLOAD and ZSAVE to file some routines"
 S DIR("?",2)="under different names, you can use this utility only if those"
 S DIR("?",3)="commands are available.  Otherwise, you'll have to perform the"
 S DIR("?",4)="operations manually."
 D DIR K DIR Q:$D(DIQUIT)
 Q
DT K DIR
 S DIR("A",1)="Do you want to save DIDT, DIDTC, and DIRCR"
 S DIR("A",2)="as %DT, %DTC, and %RCR"
 S DIR("B")="YES"
 S DIR("?",1)="Enter 'YES' to refile the routines.  This step must be performed",DIR("?",2)="in order for FileMan to work properly."
 D DIR K DIR Q:$D(DIQUIT)!'Y
 W ! S %S="DIDT^DIDTC^DIRCR",%D="%DT^%DTC^%RCR" D MOVE
 Q
ZIS K DIR
 S DIR("A",1)="Do you want to save DIIS as %ZIS (Y/N)"
 S DIR("?",1)="Enter 'YES' if you want to save the FileMan-supplied DIIS routine",DIR("?",2)="as %ZIS."
 D DIR K DIR Q:$D(DIQUIT)!'Y
 W ! S %S="DIIS",%D="%ZIS" D MOVE
 Q
ZISS K DIR
 S DIR("A",1)="Do you want to save DIISS as %ZISS (Y/N)"
 S DIR("?",1)="Enter 'YES' if you want to save the FileMan-supplied DIISS routine",DIR("?",2)="as %ZISS."
 D DIR K DIR Q:$D(DIQUIT)!'Y
 W ! S %S="DIISS",%D="%ZISS" D MOVE
 Q
ZOSF S DIR("A",1)="Do you want me to set nodes in the ^%ZOSF global and"
 S DIR("A",2)="to file the %ZOSV routine (and possibly the %ZOSV1 routine)"
 S DIR("A",3)="appropriate for the MUMPS operating system you are using (Y/N)"
 S DIR("?",1)="FileMan's screen-oriented utilities require certain %ZOSF nodes"
 S DIR("?",2)="to be present.  Some of these nodes call %ZOSV and %ZOSV1,"
 S DIR("?",3)="so those routines must also be present."
 D DIR K DIR S:'Y DIQUIT=1 Q:$D(DIQUIT)
 W ! S %D="%ZOSV" D @DIOS
 Q
1 ;M/11
 ;S %S="DINVM11" D MOVE
 ;D ^DINZM11
 Q
2 ;M/SQL-PDP
 ;S %S="DINVM11P" D MOVE
 ;D ^DINZM11P
 Q
3 ;CACHE/OpenM;was M/SQL;before that, was M/SQL-VAX
 ;W !?3,$C(7)_"M/SQL is not yet supported."
 ;S %S="DINVMVX" D MOVE
 ;D ^DINZMVX
 S %S="DINVONT" D MOVE
 D ^DINZONT
 Q
4 ;DSM-4
 ;S %S="DINVDSM" D MOVE
 ;D ^DINZDSM
 Q
5 ;DSM for OpenVMS;was VAX DSM(V6)
 S %S="DINVVXD" D MOVE
 S %S="DINV1VXD",%D="%ZOSV1" D MOVE
 D ^DINZVXD
 Q
6 ;MSM
 S %S="DINVMSM" D MOVE
 D ^DINZMSM
 Q
7 ;DTM-PC
 S %S="DINVDTM" D MOVE
 S %S="DINV1DTM",%D="%ZOSV1" D MOVE
 D ^DINZDTM
 Q
8 ;GT.M(VAX)
 ;W !?3,$C(7)_"GT.M(VAX) is not yet supported."
 ;S %S="DINVGTM" D MOVE
 ;S %S="DINV1GTM",%D="%ZOSV1" D MOVE
 ;D ^DINZGTM
 Q
 ;
MOVE F %=1:1:$L(%D,U) S X=$P(%S,U,%),Y=$P(%D,U,%) I X]"",Y]"" W !,"Loading ",X X "ZL @X ZS @Y" W ?20,"Saved as ",Y
 K %S,%D
 Q
Q K %,X,X1,Y,DIOS,DIQUIT,DISAVE
 Q
DIR K DIQUIT S Y=0 W ! F %=1:1 Q:'$D(DIR("A",%))  W !,DIR("A",%)
 W "? "_$S($D(DIR("B")):DIR("B")_"// ",1:"")
 R X:300 S:X="" X=$S($D(DIR("B")):DIR("B"),1:"NULL")
 I X[U!'$T S DIQUIT=1 Q
 I $P("NO",$TR(X,"no","NO"))="" S Y=0 Q
 I $P("YES",$TR(X,"yes","YES"))="" S Y=1 Q
 I X?1."?",$D(DIR("?")) D  G DIR
 . W ! F %=1:1 Q:'$D(DIR("?",%))  W !?5,DIR("?",%)
 W $C(7),!!?5,"Enter 'YES' or 'NO', or '^' to quit." G DIR
 Q
