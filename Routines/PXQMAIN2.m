PXQMAIN2 ;ISL/JVS - MAIN MENU ROUTINE #3 ;8/29/96  10:33
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**4**;Aug 12, 1996
 ;
MENU ;--MENU FOR WHAT TO DISPLAY FOR VISIT
 ;--OPTION 9
 N LOC9,NAME,PAT9,POP,Y
 S DIR("A")="Select a Display"
 S DIR(0)="SOM^P:Patient files;L:Location files"
 D ^DIR I Y=""!(Y["^") G CLOSE
 I Y="P" D PAT G MENU
 I Y="L" D LOC G MENU
 K DIR("A"),DIR(0)
 G CLOSE
 ;
PAT ;--PATIENT FILES
 ;--GENERAL ERRORS IN THE DATA BASE
 ;--OPEN DEVICE
 S OPTION="9P"
 D ZIS^PXQZIS G:POP EXIT
 ;--RESET $X,$Y
 N DX,DY S (DX,DY)=0 X ^%ZOSF("XY")
PAT9P ;--BODY
 N PAT,I,PXQRECI,SSN,SSN1,FLAG1,FLAG2,FLAG3,PAT2,LOC
 N PAT2,LOC4,FLAG4,FLAG5
 S PXQRECI=0
 I '$D(^DD(2,.09,1,800)) W $$RE^PXQUTL("   ERROR    ")
 I '$D(^DD(2,.09,1,800)) W $$RE^PXQUTL("** NO CROSS-REFERENCE IN FILE#2 ON SSN FIELD FOR UPDATING FILE#9000001**")
 I '$D(^DD(2,.09,1,800)) W $$RE^PXQUTL("** CROSS-REFERENCE COMES WITH PATIENT/IHS SUBSET PACKAGE**"),$$RE^PXQUTL(" ")
 W $$RE^PXQUTL("Compare of #2 and # 9000001 Patient files"),$$RE^PXQUTL(" ")
 S PAT=$$PTFLE^PXQUTL
 S PAT2="^DPT(0) = "_$G(^DPT(0)),PAT9="^AUPNPAT(0) = "_$G(^AUPNPAT(0))
 W $$RE^PXQUTL("     "_PAT2),$$RE^PXQUTL("     "_PAT9)
 I $P(PAT,"^",1)=$P(PAT,"^",2) W $$RE^PXQUTL("      Zero Nodes MATCH")
 I $P(PAT,"^",1)'=$P(PAT,"^",2) W $$RE^PXQUTL("      Zero Nodes DO NOT Match")
 W $$RE^PXQUTL(" ")
 ;
 ;
 I IOST["C-" D WAIT^DICD
 N PXQCNT,PXQLIMIT
 S PXQCNT=0,PXQLIMIT=100
 S I=0 F  S I=$O(^DPT(I)) Q:I'>0  Q:PXQCNT>PXQLIMIT  I '$D(^AUPNPAT(I)) D
 .S PXQCNT=PXQCNT+1
 .I '$G(FLAG1) W $$RE^PXQUTL("Patients in file #2 but not in #9000001"),$$RE^PXQUTL(" DFN         NAME                  SSN") S FLAG1=1
 .S NAME=$P($G(^DPT(I,0)),"^",1),SSN=$P($G(^DPT(I,0)),"^",9)
 .W $$RE^PXQUTL(""""_I_""",?10,"""_$E(NAME,1,20)_""",?32,"""_SSN_"""")
 W $$RE^PXQUTL(" ")
 I PXQCNT>PXQLIMIT W $$RE^PXQUTL("**There are more that 100 of these so I'll quit with 100**")
 W $$RE^PXQUTL(" ")
 ;
 S I=0 F  S I=$O(^AUPNPAT(I)) Q:I'>0  I '$D(^DPT(I)) D
 .I '$G(FLAG2) W $$RE^PXQUTL("Patients in file #9000001 but not in #2"),$$RE^PXQUTL(" DFN         NAME                  SSN") S FLAG2=1
 .S NAME="**UNKNOWN**",SSN1=$P($G(^AUPNPAT(I,41,+$$SITE^VASITE,0)),"^",2)
 .W $$RE^PXQUTL(""""_I_""",?10,"""_NAME_""",?32,"""_SSN1_"""")
 W $$RE^PXQUTL(" ")
 ;
 S I=0 F  S I=$O(^DPT(I)) Q:I'>0  I $D(^AUPNPAT(I)) D
 .S NAME=$P($G(^DPT(I,0)),"^",1),SSN=$P($G(^DPT(I,0)),"^",9),SSN1=$P($G(^AUPNPAT(I,41,+$$SITE^VASITE,0)),"^",2)
 .I SSN'=SSN1 D
 ..I '$G(FLAG3) W $$RE^PXQUTL("SSN'S in #2 not equal to #9000001"),$$RE^PXQUTL(" DFN        NAME                   #2        #9000001") S FLAG3=1
 ..W $$RE^PXQUTL(""""_I_""",?10,"""_$E(NAME,1,20)_""",?32,"""_SSN_""",?45,"""_SSN1_"""")
 W $$RE^PXQUTL(" ")
 ;
 ;
 I $P(PAT,"^",1)=$P(PAT,"^",2) D
 .I '$G(FLAG1) W $$RE^PXQUTL("PATIENT file #2 and PATIENT/IHS file #9000001 are in sync.")
 D READ^PXQUTL
 ;--CLOSE DEVICE
 D ^%ZISC
 I $D(ZTSK) G CLOSE
 E  Q
 ;
LOC ;--LOCATION FILES
 ;--GENERAL ERRORS IN THE DATA BASE
 ;--OPEN DEVICE
 S OPTION="9L"
 D ZIS^PXQZIS G:POP EXIT
 ;--RESET $X,$Y
 N DX,DY S (DX,DY)=0 X ^%ZOSF("XY")
LOC9L ;--BODY
 N PAT,I,PXQRECI,SSN,SSN1,FLAG1,FLAG2,FLAG3,PAT2,LOC
 N PAT2,LOC4,FLAG4,FLAG5
 S PXQRECI=0
 ;--location files
 W $$RE^PXQUTL("Compare of #4 and # 9999999.06 location files"),$$RE^PXQUTL(" ")
 S LOC=$$LCFLE^PXQUTL
 S LOC4="^DIC(4,0) = "_$G(^DIC(4,0)),LOC9="^AUTTLOC(0) = "_$G(^AUTTLOC(0))
 W $$RE^PXQUTL("     "_LOC4),$$RE^PXQUTL("     "_LOC9)
 I $P(LOC,"^",1)=$P(LOC,"^",2) W $$RE^PXQUTL("      Zero Nodes MATCH")
 I $P(LOC,"^",1)'=$P(LOC,"^",2) W $$RE^PXQUTL("      Zero Nodes DO NOT Match")
 W $$RE^PXQUTL(" ")
 ;
 ;
 I IOST["C-" D WAIT^DICD
 ;
 S I=0 F  S I=$O(^DIC(4,I)) Q:I'>0  I '$D(^AUTTLOC(I)) D
 .I '$G(FLAG4) W $$RE^PXQUTL("Locations in file #4 but not in #9999999.06"),$$RE^PXQUTL(" IEN         NAME") S FLAG4=1
 .S NAME=$P($G(^DIC(4,I,0)),"^",1)
 .W $$RE^PXQUTL(""""_I_""",?10,"""_NAME_"""")
 W $$RE^PXQUTL(" ")
 ;
 S I=0 F  S I=$O(^AUTTLOC(I)) Q:I'>0  I '$D(^DIC(4,I)) D
 .I '$G(FLAG5) W $$RE^PXQUTL("Locations in file #9999999.06 but not in #4"),$$RE^PXQUTL(" IEN         NAME") S FLAG5=1
 .S NAME="**UNKNOWN**"
 .W $$RE^PXQUTL(""""_I_""",?10,"""_NAME_"""")
 W $$RE^PXQUTL(" ")
 ;
 I $P(LOC,"^",1)=$P(LOC,"^",2) D
 .I '$G(FLAG4) W $$RE^PXQUTL("INSTITUTION file #4 and LOCATION file #9999999.06 are in sync.")
 D READ^PXQUTL
 ;--CLOSE DEVICE
 D ^%ZISC
 I $D(ZTSK) G CLOSE
 E  Q
 ;
CLOSE ;--CLOSE DEVICE
 D ^%ZISC
 K OPTION
 ;--RETURN TO MENU
 ;R !,"Press any key to return to the menu",ANS:DTIME
 Q
 ;
EXIT ;--EXIT
 K OPTION
 Q
