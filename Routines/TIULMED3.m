TIULMED3 ; SLC/MAM - Cont. of Active/Recent Med Objects Routine ;1/30/07
 ;;1.0;TEXT INTEGRATION UTILITIES;**198,213**;Jun 20, 1997;Build 3
GETCLASS ; Get Drug Class, filter out supplies  BP/ELR
 I +DRUGIDX D
 .N TEMPNODE
 .S DRUGCLAS=$$DRGCLASS^TIULMED2(DRUGIDX)
 .S TEMPNODE=U_DRUGCLAS_U_$$DEA^TIULMED2(DRUGIDX)
 .I 'SUPPLIES,($E(DRUGCLAS,1,2)="XA") D
 ..S KEEPMED='($P(TEMPNODE,U,3)["S")
 Q
 ;
PATCHSOK() ; Function Checks for Pharmacy Package and required patches
 ;Returns 1 if ok, 0 if not
 N CHECKOK S CHECKOK=1
 I '$L($T(OCL^PSOORRL)) D  S CHECKOK=0 G CKX
 . D ADD^TIULMED1("Outpatient Pharmacy 7.0 Required for this Object.")
 . D ADD^TIULMED1(" ")
 I '$$PATCH^XPDUTL("PSO*7.0*20") D  S CHECKOK=0 G CKX
 . D ADD^TIULMED1("Outpatient Pharmacy Patch PSO*7.0*20 is required for this Object.")
 . D ADD^TIULMED1(" ")
 I '$$PATCH^XPDUTL("PSJ*5.0*22") D  S CHECKOK=0 G CKX
 . D ADD^TIULMED1("Inpatient Pharmacy Patch PSJ*5.0*22 is required for this Object.")
 . D ADD^TIULMED1(" ")
CKX Q CHECKOK
 ;
SORTSAVE ;Sort & save Meds Data in TARGET
 ; *** Check for empty condition ***
 ;
 I EMPTY D  G SORTX
 .D ADD^TIULMED1("No Medications Found")
 .D ADD^TIULMED1(" ")
 ;
 ; *** Sort Meds in "C" temp xref - sort by Med Type, Status
 ;     Med Name, and reverse issue date, followed by a counter 
 ;     to avoid erasing meds issued on the same day
 ;
 N MED,CNT,XSTR,TIUXSTAT
 N DATA,NODE
 S MED="",CNT=1000000
 F  S MED=$O(@TARGET@("B",MED)) Q:MED=""  D
 .S (XSTR,TIUXSTAT)=""
 .F  S XSTR=$O(@TARGET@("B",MED,XSTR)) Q:XSTR=""  D
 .. F  S TIUXSTAT=$O(@TARGET@("B",MED,XSTR,TIUXSTAT)) Q:TIUXSTAT=""  D
 ...S NODE=@TARGET@("B",MED,XSTR,TIUXSTAT)
 ...S DATA=$P(NODE,U,3)_U_$P(NODE,U,5)_U_MED,CNT=CNT+1
 ...S @TARGET@("C",DATA,(9999999-$P(NODE,U))_CNT)=$P(NODE,U,2)_U_$P(NODE,U,4)
 ;
 ; Read sorted data and save final version to TARGET
 ;
 N LASTCLAS,LASTMEDT,LASTSTS,COUNT,TOTAL
 N INDEX,MEDTYPE,STATIDX,DRUGCLAS,TYPE
 N NODE,LASTMEDT,LASTSTS,TEMP,OLDTAB,OLDHEADR
 S (DATA,LASTCLAS)="",(LASTMEDT,LASTSTS,COUNT,TOTAL)=0
 D WARNING^TIULMED1
 F  S DATA=$O(@TARGET@("C",DATA)) Q:DATA=""  D
 .S MEDTYPE=$E(DATA),STATIDX=$E(DATA,2)
 .S DRUGCLAS=$P(DATA,U,2),MED=$P(DATA,U,3),CNT=""
 .F  S CNT=$O(@TARGET@("C",DATA,CNT)) Q:CNT=""  D
 ..S INDEX=@TARGET@("C",DATA,CNT)
 ..S TYPE=$P(INDEX,U,2),INDEX=+INDEX
 ..S NODE=^TMP("PS",$J,INDEX,0)
 ..I $P($P(NODE,U),";")["N" S $P(NODE,U,2)="Non-VA "_$P(NODE,U,2)
 ..I (MEDTYPE'=LASTMEDT)!(STATIDX'=LASTSTS) D  ; Create Header
 ...I CLASSORT'=2,DRUGCLAS'=" " S LASTCLAS=DRUGCLAS
 ...I 'HEADER Q
 ...S LASTMEDT=MEDTYPE,LASTSTS=STATIDX,TAB=0
 ...I COUNT>0 D ADD^TIULMED1(" ")
 ...I CLASSORT D ADD^TIULMED1(" ")
 ...S COUNT=0
 ...I DETAILED D
 ....I MEDTYPE=OUTPTYPE D  I 1
 .....D ADD^TIULMED1(SPACE60_"Issue Date")
 .....D ADD^TIULMED1($E($E(SPACE60,1,47)_"Status"_SPACE60,1,60)_"Last Fill")
 ....E  D ADD^TIULMED1(SPACE60_"Start Date")
 ...I 'ONELIST D
 ....S TEMP=$S(STATIDX=1:"Active",STATIDX=2:"Pending",1:"Inactive")_" "
 ...E  S TEMP=""
 ...S TEMP=TEMP_$S(MEDTYPE=INPTYPE:"Inpatient",MEDTYPE=NVATYPE:"Non-VA",1:"Outpatient")
 ...S TEMP="     "_TEMP_" Medications"
 ...I CLASSORT D
 ....I DETAILED S TEMP=TEMP_" (By Class)"
 ....E  S TEMP=TEMP_" (By Drug Class)"
 ...I DETAILED D  I 1
 ....S TEMP=$E(TEMP_SPACE60,1,47)
 ....I MEDTYPE=INPTYPE S TEMP=TEMP_"Status"
 ....E  S TEMP=TEMP_"Refills"
 ....S TEMP=$E(TEMP_SPACE60,1,60)
 ....I MEDTYPE=INPTYPE S TEMP=TEMP_"Stop Date"
 ....E  S TEMP=TEMP_"Expiration"
 ...E  D
 ....S TEMP=$E(TEMP_SPACE60,1,60)_"Status"
 ...D ADD^TIULMED1(TEMP),ADD^TIULMED1(DASH73)
 ..I CLASSORT,DRUGCLAS'="",DRUGCLAS'=LASTCLAS D
 ...S LASTCLAS=DRUGCLAS,OLDTAB=TAB,OLDHEADR=HEADER
 ...S (TAB,HEADER)=0
 ...I COUNT>0 D ADD^TIULMED1(" ")
 ...I (CLASSORT=2)!(DRUGCLAS=" ") D  I 1
 ....I DRUGCLAS=" " S TEMP="   ====== Drug Class Unknown "
 ....E  S TEMP="   ====== Drug Class: "_DRUGCLAS_" "
 ...E  S TEMP="   "
 ...S TEMP=$E(TEMP_DASH73,1,LLEN-2)
 ...D ADD^TIULMED1(TEMP)
 ...S HEADER=OLDHEADR,TAB=OLDTAB
 ..S COUNT=COUNT+1,TOTAL=TOTAL+1
 ..D ADDMED^TIULMED1(0)
 I COUNT'=TOTAL D
 .S TAB=0
 .D ADD^TIULMED1(" ")
 .D ADD^TIULMED1(TOTAL_" Total Medications")
SORTX ;
 Q
 ;
