EEOEOP2 ;HISC/JWR - EEO STATION PRINT ROUTINE ;11/11/92  15:03
 ;;2.0;EEO Complaint Tracking;;Apr 27, 1995
STN2 ;Entry point for report
 D ^EEOEOSE I FAIL Q
 W "      EEO Complaint Status Timeliness Report"
 S (DIC,DIE)="^EEO(785,"
 S L=0
 S FLDS=".01;S1;L17" ;complainant name
 S FLDS(1)="63;L7;T" ;status
 S FLDS(2)="1.1;L4;T" ;case no:
 S FLDS(3)="16;L14" ;date formal complaint filed
 S FLDS(4)="14.1;L4;T" ;counselor days
 S FLDS(5)="51;L4;T" ;couns report days
 S FLDS(6)="25;L4;T" ;total days acceptance
 S FLDS(7)="23;L4;T" ;days for OGC to acc/rej
 S FLDS(8)="42;L4;T" ;total days assign invest
 S FLDS(9)="33;L4;T" ;total investigation days
 S FLDS(10)="53;L4;T" ;days for advise/rights
 S FLDS(11)="54;L4;T" ;days to request hearing
 S FLDS(12)="46;L4;T" ;total days for hearing
 S FLDS(13)="55;L4;T" ;days to make election
 S FLDS(14)="56;L5;T" ;days for FAD
 S FLDS(15)="57;L5" ;180 days
 S FLDS(16)="50;L5;T" ;total processing days
 S EEOYTEMP=$P($P(^DIC(4,EEOYSPTR,0),U),",")
 S BY="63,.01"
 S FR="?"
 S TO="?"
 S DHD="EEO Complaint Status Timeliness Report for "_EEOSTNAM_" (132 column mode)"
 D DIP Q
KILL ;kills variables
 K EEOYTEMP,TO,FR,L,FLDS,BY,DHD,DIC("A") Q
STN3 ;Entry point for complaint status report (obsolete)
 D ^EEOEOSE I FAIL Q
 W "      EEO Complaint Status Report"
 S (DIC,DIE)="^EEO(785,"
 S L=0
 S FLDS=".01;S1;L17" ;complainant name
 S FLDS(1)="63;L8;T" ;status
 S FLDS(2)="1.1;L6;T" ;case no:
 S FLDS(6)="15.4;L4;T" ;lenght of extention
 S FLDS(7)="23;L4;T" ;days for OGC to acc/rej
 S FLDS(8)="42;L4;T" ;total days assign invest
 S FLDS(9)="33;L4;T" ;total investigation days
 S FLDS(15)="57;L4" ;180 days
 S FLDS(30)="64;L4;T" ;180 days deviations out of dir control
 S EEOYTEMP=$P($P(^DIC(4,EEOYSPTR,0),U),",")
 S BY="63,.01"
 S FR="?"
 S TO="?"
 S DHD="EEO Complaint Status Timeliness Report for "_EEOSTNAM_" (132 column mode)"
DIP ;Sets up print variables
 S DIS(0)="I $$SCREEN^EEOEOSE(D0) I $P($G(^EEO(785,D0,12)),U,2)'=""D"""
 D EN1^DIP K DIS(0) S DIC("S")=EEOYSCR
 D KILL
