PRCNRPT ;SSI/SEB,ALA-Reports ;[ 12/04/95  2:16 PM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
DET ;  Print detail report
 S FLDS="[PRCNDET]",L=0,DIC="^PRCN(413,",BY=.01,FR="",TO="",DHD="@"
 D EN1^DIP
 K FLDS,L,DIC,BY,FR,TO,DHD
 Q
CMR ;  Print turn-ins by CMR
 S FLDS="[PRCNTIST]",L=0,DIC="^PRCN(413.1,",BY=15,DHD="TURN IN REPORT BY CMR"
 D EN1^DIP
 K FLDS,L,DIC,BY,FR,TO,DHD
 Q
SER ;  Print turn-ins by Service
 S FLDS="[PRCNTIST]",L=0,DIC="^PRCN(413.1,",BY=2,DHD="TURN-IN REPORT BY SERVICE"
 D EN1^DIP
 Q
