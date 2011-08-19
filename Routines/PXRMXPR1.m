PXRMXPR1 ; SLC/AGP - Print Reminder Due report carryover code. ;01/05/2006
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
 ;Patient list display
FOOTER(PLSTCRIT) ;
 N CNT,CNT1,COUNT,TEXT
 ;Count patients in list
 S COUNT=+$O(^PXRMXP(810.5,PXRMLIS1,30,"A"),-1)
 ;
 I COUNT=0 W !!!,"No patients due. Patient List not created" Q
 W !!!,"Patient List "_$P($G(^PXRMXP(810.5,PXRMLIS1,0)),U)_" created by "_$$GET1^DIQ(200,DUZ,.01)_" on "_$$FMTE^XLFDT($P($G(^PXRMXP(810.5,PXRMLIS1,0)),U,4),1)
 W !!,"List contains "_COUNT_" patients, report run on "_TTOTAL_" patients."
 ;
 ;Screen out formatting lines and second piece of criteria array
 S (CNT,CNT1)=0 F  S CNT=$O(PLSTCRIT(CNT)) Q:CNT'>0  D
 .I $P($G(PLSTCRIT(CNT)),U)="",$P($G(PLSTCRIT(CNT)),U,2)>0 Q
 .S CNT1=CNT1+1 S TEXT(CNT1)=$P($G(PLSTCRIT(CNT)),U)
 ;Store Report Criteria in the document multiple of the patient list
 F CNT1=1:1:CNT1 S ^PXRMXP(810.5,PXRMLIS1,200,CNT1,0)=TEXT(CNT1)
 S ^PXRMXP(810.5,PXRMLIS1,200,0)=U_"810.51"_U_CNT1_U_CNT1
 Q
 ;
 ;Set up literals for display
LITS ;
 I PXRMSEL="I" S PXRMFLD="Individual Patients"
 I PXRMSEL="R" S PXRMFLD="Patient List"
 I PXRMSEL="P" S PXRMFLD="PCMM Provider"
 I PXRMSEL="O" S PXRMFLD="OE/RR Team"
 I PXRMSEL="T" S PXRMFLD="PCMM Team"
 I PXRMSEL="L" D
 .S PXRMFLD="Location"
 .I $P(PXRMLCSC,U)="HS" S DES="Selected Hospital Locations"
 .I $P(PXRMLCSC,U)="HA" S DES="All Outpatient Locations"
 .I $P(PXRMLCSC,U)="HAI" S DES="All Inpatient Locations"
 .I $P(PXRMLCSC,U)="CS" S DES="Selected Clinic Stops"
 .I $P(PXRMLCSC,U)="CA" S DES="All Clinic Stops"
 .I $P(PXRMLCSC,U)="GS" S DES="Selected Clinic Groups"
 .I PXRMFD="P" S DES=DES_" (Prior Encounters)"
 .I PXRMFD="F" S DES=DES_" (Future Appoints.)"
 .I PXRMFD="A" S DES=DES_" (Admissions)"
 .I PXRMFD="C" S DES=DES_" (Current Inpatients)"
 I PXRMSEL="P" D
 .I PXRMPRIM="A" S CDES="All patients on list"
 .I PXRMPRIM="P" S CDES="Primary care assigned patients only"
 Q
 ;
 ;Report missed locations if report is partially successful
MISSED(PSTART,MISSED) ;
 ;Delimited report from template
 I PXRMTABS="Y",PXRMTMP'="" D  Q
 .W !!?PSTART,"The following had no patients selected",!
 .N SUB
 .S SUB=""
 .F  S SUB=$O(MISSED(SUB)) Q:SUB=""  D
 ..W !?PSTART+10,SUB
 ;Other reports
 N LIT,SUB
 D CHECK^PXRMXGPR(5) Q:DONE
 S LIT=PXRMFLD
 I PXRMSEL="L",$E(PXRMLCSC)="G" S LIT="Clinic Group"
 W !!?PSTART,"The following ",LIT,"(s) had no patients selected",!
 S SUB=""
 F  S SUB=$O(MISSED(SUB)) Q:SUB=""  D
 .D CHECK^PXRMXGPR(3) Q:DONE
 .W !?PSTART+10,SUB
 Q
 ;
 ;Build array of locations/providers/teams with no patients
NOPATS(MISSED) ;
 N DATA,IC,LTYPE,MARK
 S IC=""
 I PXRMSEL="P" D  Q
 . F  S IC=$O(PXRMPRV(IC)) Q:IC=""  D
 .. S DATA=PXRMPRV(IC)
 .. D TEST(DATA,$P(DATA,U,1),.MISSED)
 I PXRMSEL="T" D
 . F  S IC=$O(PXRMPCM(IC)) Q:IC=""  D
 .. S DATA=PXRMPCM(IC)
 .. D TEST(DATA,$P(DATA,U,1),.MISSED)
 I PXRMSEL="O" D
 . F  S IC=$O(PXRMOTM(IC)) Q:IC=""  D
 .. S DATA=PXRMOTM(IC)
 .. D TEST(DATA,$P(DATA,U,1),.MISSED)
 S LTYPE=$E($G(PXRMLCSC))
 I LTYPE="H" D
 . F  S IC=$O(^XTMP(PXRMXTMP,"HLOC",IC)) Q:IC=""  D
 .. S DATA=^XTMP(PXRMXTMP,"HLOC",IC)
 .. D TEST(DATA,IC,.MISSED)
 I LTYPE="C" D
 . F  S IC=$O(PXRMCS(IC)) Q:IC=""  D
 .. S DATA=PXRMCS(IC)
 .. D TEST(DATA,$P(DATA,U,3),.MISSED)
 I LTYPE="G" D
 . F  S IC=$O(PXRMCGRP(IC)) Q:IC=""  D
 .. S DATA=PXRMCGRP(IC)
 .. D TEST(DATA,$P(DATA,U,1),.MISSED)
 Q
 ;
 ;Check for match on location
TEST(DATA,IEN,MISSED) ;
 N SUB
 I $D(^XTMP(PXRMXTMP,"MARKED AS FOUND",IEN)) Q
 I PXRMSEL'="L" S MISSED($P(DATA,U,2))="" Q
 N LTYPE
 S LTYPE=$E(PXRMLCSC)
 I LTYPE="H" S SUB=IEN D
 . N FACNAM,FACNUM,HLOC
 . S HLOC=$P(DATA,U,2) Q:HLOC=""
 . S FACNUM=$$HFAC^PXRMXSL1(IEN)
 . S FACNAM=$S(FACNUM="":"?",1:$P($G(PXRMFACN(FACNUM)),U,1))
 . I FACNAM'="" S SUB=HLOC_" ("_FACNAM_")"
 I LTYPE="C" S SUB=$P(DATA,U,1)_" "_$P(DATA,U,3)
 I LTYPE="G" S SUB=$P(DATA,U,2)
 S MISSED(SUB)=""
 Q
 ;
