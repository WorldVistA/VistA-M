DINZMGR1 ;SFISC/MKO-TO SET UP THE MGR ACCOUNT FOR THE SYSTEM ;3:02 PM  1 Oct 1998
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
INTRO ;Print introductory text
 W !!!,"HELLO!"
 W !!,"I exist to assist you in correctly initializing the manager account",!,"or to update the current account."
 W !!,"I'm going to do the following:"
 W !!?3,"1.  File the routines DIDT, DIDTC, and DIRCR as %DT, %DTC, and",!?7,"%RCR, respectively."
 W !!?3,"2.  File the routines DIIS and DIISS as %ZIS and %ZISS, respectively."
 W !!?3,"3.  Set nodes in the %ZOSF global.  This global contains"
 W !?7,"MUMPS operating system-specific code required by FileMan's"
 W !?7,"screen-oriented utilities."
 W !!,?3,"4.  Save a %ZOSV routine (and possibly a %ZOSV1 routine) specific",!?7,"to your MUMPS operating system."
 W !!,"Note that on some MUMPS systems, executing some of the ^%ZOSF nodes"
 W !,"causes ^XUTL global nodes to be set in the production account."
 Q
 ;
OS ;Prompt for operating system
 N I,J
 S Y=0
 I $D(^%ZOSF("OS"))#2 D
 . S X1=$P(^%ZOSF("OS"),U),Y=$P(^("OS"),U,2)
 . ;S:Y=7 X1="M\SQL",Y=18
 . I X1=""!'Y S (X1,Y)="" Q
 . W !!,"I think you are using "_X1
 . S Y=$S(Y=1:1,Y=13:2,Y=18:3,Y=2:4,Y=16:5,Y=8:6,Y=9:7,Y=17:8,1:0)
 ;
OS1 W !!,"Which MUMPS system are you using?",!
 F I=1:1 S J=$P($T(@I),";;",2,999) Q:J=""  D
 . W !
 . W:$P(J,";",2)]"" ?3,$P(J,";",2)
 . W ?5,I_" = "_$P(J,";")
 W !!?9,"* No longer supported."
 W !!,"MUMPS System: " W:Y Y,"// " R X:300 S:X="" X=Y
 I X[U!'$T S DIQUIT=1 Q
 ;
 I X?1."?" D  G OS1
 . W !!?5,"If the MUMPS system you are using is not listed, you cannot use"
 . W !?5,"this utility.  You must manually file DIDT, DIDTC, and DIRCR as"
 . W !?5,"%DT, %DTC, and %RCR, respectively."
 . W !!?5,"In addition, if you wish to use FileMan's screen-oriented utilities,"
 . W !?5,"you must file %ZIS and %ZISS routines (you can use DIIS and DIISS"
 . W !?5,"as starting points), and you must set the %ZOSF nodes manually."
 . W !?5,"Please refer the VA FileMan Programmer Manual for more information."
 ;
 S J=$P($T(@X),";;",2,999)
 I $T(@X)="" D  G OS1
 . W !!?5,$C(7)_"Invalid response.  Enter a number between 1 and 9."
 I $P(J,";",2)="*" D  G OS1
 . W !!?5,$C(7)_$P(J,";")_" is no longer supported."
 ;
 S DIOS=+X
 Q
 ;
1 ;;M/11;*
2 ;;M/SQL-PDP;*
3 ;;CACHE/OpenM
4 ;;DSM-4;*
5 ;;DSM for OpenVMS
6 ;;MSM
7 ;;DTM-PC
8 ;;GT.M(VAX);*
