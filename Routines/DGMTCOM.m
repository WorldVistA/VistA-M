DGMTCOM ;ALB/CAW - Copay Exemption Test Main Menu Driver ;7 JAN 1992 8:00 am
 ;;5.3;Registration;;Aug 13, 1993
 ;
EN ;Entry point to copay exemption test menu driver
 D HOME^%ZIS G:$D(^DOPT("DGMTCOP",6)) A
 S ^DOPT("DGMTCOP",0)="Copay Exemption Test Menu Options^1N^" F I=1:1 S X=$T(@(I)) Q:X=""  S ^DOPT("DGMTCOP",I,0)=$P(X,";;",2,99)
 S DIK="^DOPT(""DGMTCOP""," D IXALL^DIK K DIK
 ;
A W !! S DIC="^DOPT(""DGMTCOP"",",DIC(0)="AEMQ" D ^DIC K DIC Q:Y<0  D @+Y G A
 ;
1 ;;Add a New Copay Exemption Test
 S DGMTYPT=2 G EN^DGMTA
 ;
2 ;;Adjudicate a Copay Exemption Test
 S DGMTYPT=2 G ADJ^DGMTEO
 ;
3 ;;Edit an Existing Copay Exemption Test
 S DGMTYPT=2 G EN^DGMTE
 ;
4 ;;Delete a Copay Exemption Test
 S DGMTYPT=2 G EN^DGMTDEL
 ;
5 ;;List Incomplete Copay Tests
 S DGMTYPT=2 G EN^DGMTOREQ
 ;
6 ;;View Copay Exemption Test Editing Activity
 S DGMTYPT=2 G DIS^DGMTAUD
 ;
7 ;;View a Past Copay Test
 S DGMTYPT=2 G EN^DGMTV
 ;
8 ;;Copay Test Needing Updated At Next Appointment
 S DGMTYPT=2 G ^DGMTOFA
