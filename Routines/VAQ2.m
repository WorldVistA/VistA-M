VAQ2 ;ALB/CMM,JRP - PDX PATCH 15 DRIVER ;01-FEB-95
 ;;1.5;PATIENT DATA EXCHANGE;**15**;NOV 17, 1993
 ;
PATCH15 ;Entry point for patch 15 installation
 ;  Refer to VAQ*1.5*15 in National Patch Module for further details
 ;Declare/initialize variables
 N DASHES,TMP,MDY,TIME,DIR,DUOUT,DTOUT,DIRUT
 N ABORT,X,Y,UPDATE82,UPDATE83
 S (ABORT,UPDATE82,UPDATE83)=0
 S DASHES=$$REPEAT^VAQUTL1("-",79)
 ;Print Header
 S TMP=$$NOW^VAQUTL99()
 S MDY=$TR($P(TMP,"@",1),"-","/")
 S TIME=$P(TMP,"@",2)
 S TMP="  "_MDY_" @ "_TIME
 S TMP=$$INSERT^VAQUTL1(TMP,DASHES,(79-$L(TMP)+1))
 W !!,$$INSERT^VAQUTL1("VAQ*1.5*15  ",TMP,1)
 S TMP="Details of this installation may be obtained from the National Patch Module"
 W !!,$$INSERT^VAQUTL1(TMP,"",(40-($L(TMP)\2)))
 S TMP="under the entry VAQ*1.5*15 (patch #15 for version 1.5 of PDX)"
 W !,$$INSERT^VAQUTL1(TMP,"",(40-($L(TMP)\2)))
 W !!,DASHES,!!
 ;Allow user to skip running of inits
 S DIR(0)="YA"
 S DIR("A")="Do you want to run the inits included with this patch ? "
 S DIR("B")="YES"
 S DIR("?",1)="This patch is accompanied by a set of inits (VAQ2INIT).  Running the inits"
 S DIR("?",2)="will modify triggers on the Remote Facility field (#.01) of the VAQ - RELEASE"
 S DIR("?",3)="GROUP file (#394.82) and the Remote Facility field (#.01) of the Remote"
 S DIR("?",4)="Facility multiple (field #10) in the VAQ - OUTGOING GROUP file (#394.83)."
 S DIR("?",5)="These triggers did not correctly store the external value of a pointer in the"
 S DIR("?",6)="fields they update."
 S DIR("?",7)=" "
 S DIR("?",8)="You may skip the running of these inits if the inits included with patch"
 S DIR("?")="VAQ*1.5*12 (which was entered in error) were successfully run."
 D ^DIR K DIR
 I (($D(DTOUT))!($D(DUOUT))) S ABORT=1 G EXIT
 G:('Y) SKIP1
 W !!
 D ^VAQ2INIT
SKIP1 ;Allow user to skip updating of file 394.82
 S DIR(0)="YA"
 S DIR("A")="Do you want to update the VAQ - RELEASE GROUP file ? "
 S DIR("B")="YES"
 S DIR("?",1)="Enter 'YES' if you want the values stored in the Remote Domain field (#.02)"
 S DIR("?",2)="of the VAQ - RELEASE GROUP file (#394.82) automatically re-entered.  Doing"
 S DIR("?",3)="this will ensure that the pointer values contained in this field are stored"
 S DIR("?",4)="correctly."
 S DIR("?",5)=" "
 S DIR("?",6)="This step is not neccessary if the values were successfully re-entered"
 S DIR("?")="during the installation of patch VAQ*1.5*12 (which was entered in error)."
 W !!
 D ^DIR K DIR
 I (($D(DTOUT))!($D(DUOUT))) S ABORT=1 G EXIT
 G:('Y) SKIP2
 D FIX1^VAQ2A
 S UPDATE82=1
SKIP2 ;Allow user to skip updating of file 394.83
 S DIR(0)="YA"
 S DIR("A")="Do you want to update the VAQ - OUTGOING GROUP file ? "
 S DIR("B")="YES"
 S DIR("?",1)="Enter 'YES' if you want the values stored in the Remote Domain field (#.02)"
 S DIR("?",2)="of the Remote Facility multiple (field #10) in the VAQ - OUTGOING GROUP file"
 S DIR("?",3)="(#394.83) automatically re-entered.  Doing this will ensure that the pointer"
 S DIR("?",4)="values contained in this field are stored correctly."
 S DIR("?",5)=" "
 S DIR("?",6)="This step is not neccessary if the values were successfully re-entered"
 S DIR("?")="during the installation of patch VAQ*1.5*12 (which was entered in error)."
 W !!
 D ^DIR K DIR
 I (($D(DTOUT))!($D(DUOUT))) S ABORT=1 G EXIT
 G:('Y) EXIT
 D FIX2^VAQ2A
 S UPDATE83=1
EXIT ;Print footer and quit
 W !!,DASHES
 S TMP="Installation of patch number 15 "_$S(ABORT:"aborted",1:"completed")
 W !!,$$INSERT^VAQUTL1(TMP,"",(40-($L(TMP)\2)))
 I ('UPDATE82) D
 .S TMP="Updating of VAQ - RELEASE GROUP file (#394.82) was not performed"
 .W !,$$INSERT^VAQUTL1(TMP,"",(40-($L(TMP)\2)))
 I ('UPDATE83) D
 .S TMP="Updating of VAQ - OUTGOING GROUP file (#394.83) was not performed"
 .W !,$$INSERT^VAQUTL1(TMP,"",(40-($L(TMP)\2)))
 S TMP=$$NOW^VAQUTL99()
 S MDY=$TR($P(TMP,"@",1),"-","/")
 S TIME=$P(TMP,"@",2)
 S TMP="  "_MDY_" @ "_TIME
 S TMP=$$INSERT^VAQUTL1(TMP,DASHES,(79-$L(TMP)+1))
 W !!,$$INSERT^VAQUTL1("VAQ*1.5*15  ",TMP,1)
 Q
