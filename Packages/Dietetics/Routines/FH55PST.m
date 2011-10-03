FH55PST ;Hines OIFO/RTK RECURRING MEALS RELEASE POST-INIT  ;2/18/03  10:15
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
 I $P($G(^FH(119.9,1,"CV")),U,1)=1 Q  ;QUIT IF 5.5 PREVIOUSLY INSTALLED
ITEM1 ;Convert file .01 field of file #115. The .01 field was a pointer to
 ;the Patient (#2) file, it is being changed to a free text field which
 ;will look like P## or N##, for either a pointer to the Patient (#2)
 ;file or the New Person (#200) file. For example, P27 will be a pointer
 ;to entry #27 in file #2 and N1866 will be a pointer to entry #1866 in
 ;file #200. In addition there will be 2 new pointer fields in file #115
 ;which will be mutually exclusive pointer field to files #2 and #200:
 ; FIELD #14  - PATIENT will be a pointer to file #2.
 ; FIELD #15  - NEW PERSON will be a pointer to file #200.
 ;Each entry in file #115 will have a value in EITHER field #14 or #15.
 ;
 F FHPTIEN=0:0 S FHPTIEN=$O(^FHPT(FHPTIEN)) Q:FHPTIEN'>0  D
 .S FHPT1=$P($G(^FHPT(FHPTIEN,0)),U,1)
 .S FHPT26=$P($G(^FHPT(FHPTIEN,0)),U,2,6)
 .I FHPT1?1.25N,$D(^DPT(FHPT1)) D
 ..S FHNEW1="P"_FHPT1
 ..S FHZNODE=FHNEW1_"^"_FHPT26
 ..S ^FHPT(FHPTIEN,0)=FHZNODE
 ..I $D(^DPT(FHPTIEN,.1)) S DA=FHPTIEN,DR="13////^S X=""I""",DIE="^FHPT(" D ^DIE
 ..Q
 .Q
 ;
ITEM2 ;Populate/ensure integrity of fields #14 (PATIENT) and #15 (NEW PERSON)
 ;in file #115.  Each entry in #115 should have a pointer value in
 ;EITHER field #14 or #15.
 F FHPTIEN=0:0 S FHPTIEN=$O(^FHPT(FHPTIEN)) Q:FHPTIEN'>0  D
 .S FHPT1=$P($G(^FHPT(FHPTIEN,0)),U,1),FHPTTYP=$E(FHPT1,1)
 .I FHPTTYP'="P",FHPTTYP'="N" Q
 .S FHPTR=$E(FHPT1,2,99)
 .I FHPTTYP="P" D
 ..I '$D(^DPT(FHPTR)) Q
 ..K DIE S DA=FHPTIEN,DIE="^FHPT(",DR="14////^S X=FHPTR;15///@" D ^DIE
 .I FHPTTYP="N" D
 ..I '$D(^VA(200,FHPTR)) Q
 ..K DIE S DA=FHPTIEN,DIE="^FHPT(",DR="15////^S X=FHPTR;14///@" D ^DIE
 .Q
 ;
ITEM3 ;Re-index the "B" cross-reference on the #.01 field of file #115
 ;Re-index the "AW" cross-reference on the #13 sub-field of the #1 field
 S DIK="^FHPT(",DIK(1)=".01^B" D ENALL^DIK
 S IEN=0 F  S IEN=$O(^FHPT(IEN)) Q:IEN'>0  D
 .I '$D(^FHPT(IEN,"A")) Q
 .S DIK="^FHPT(IEN,""A"",",DIK(1)="13^AW",DA(1)=IEN D ENALL^DIK
 ;
ITEM4 ;Delete data hanging around in Site Parameters (#119.9) file.
 ;Allow post-init to be rerun without deleting values in the newly
 ;created fields
 K ^FH(119.9,1,1) K ^FH(119.9,1,2)
 I $P($G(^FH(119.9,1,"CV")),U,1)=1 Q
 S FHMULT=$P($G(^FH(119.9,1,0)),U,20)
 S ^FH(119.9,1,0)="1^^^^^^^^^^^^^^^^^^^"_FHMULT
 S DIE=119.9,DA=1,DR="101////^S X=1" D ^DIE
 Q
